<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	
	import="java.util.*" 
	import="java.sql.*"
	import="java.util.Date"
	import="java.text.DateFormat"
	import="java.text.SimpleDateFormat"
	import="java.time.LocalTime"
%>
	
<%

	String SendMessage = "";
	int recvNum = 0;
	try {
		recvNum = Integer.parseInt(request.getParameter("num"));
	
		//DB 연결//
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = null;
	
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			conn = DriverManager.getConnection("jdbc:sqlserver://airble.database.windows.net:1433;DatabaseName=DBID", ID, PW);
			try {
				stmt = conn.createStatement();
	
				try {
					
					switch (recvNum) {
					
					/** 
					*	case 9 계열 : Airble Device <-> Database <-> APP 테스트용 
					*/
					case 90 : // 기기 <-> 서버 연결 테스트
					{
						out.print("[][S90]");	// 통신 성공 - Success 90 
					}
					break;
					
					case 9 : // 기기 -> 데이터베이스 등록
					{
						//System.out.println("9 통신");
						try{
							String device = request.getParameter("device");
							String mac = request.getParameter("mac");
							String ssid = request.getParameter("ssid");
							//System.out.println("device = " + device);
							//System.out.println("mac = " + mac);
							//System.out.println("ssid = " + ssid);
							
							try{
								sql = "select * from [dbo].[Airble_Device_TB] where Airble_Device_PK = '" + mac + "'";
								//System.out.println(sql);
								
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									sql = "update [dbo].[Airble_Device_TB] set Airble_Shared_Key = '0000000000', Airble_SSID = '" + ssid + "', Airble_NickName = '" + ssid + "', Update_DT = dateadd(HOUR, 9, getdate()) where Airble_Device_PK = '" + mac + "'";
									//System.out.println(sql);
									stmt.executeUpdate(sql);
									out.print("[][S9]");	//  성공 - Success 9
								}else{
									sql = "insert into [dbo].[Airble_Device_TB] values ('" + mac + "', '" + device + "', '0000000000', '" + ssid + "', '" + ssid + "', dateadd(HOUR, 9, getdate()))";
									//System.out.println(sql);

									stmt.executeUpdate(sql);
									out.print("[][S9]");	//  성공 - Success 9
								}
							}catch(Exception e){
								out.print("[][E9]");	// 실패 - Error 9 ( 데이터베이스 문제 )
								//System.out.println("에러 1");
								//System.out.println("ss");
							}
						}catch(Exception e){
							//System.out.println("에러 2");
							out.print("[][E9]");	// 실패 - Error 9 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 91 : // 데이터베이스 -> APP 등록 확인
					{
						try{
							String mac = request.getParameter("mac");
							try{
								sql = "select * from [dbo].[Airble_Device_TB] where Airble_Device_PK = '" + mac + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									out.print("[][S91]");	//  성공 - Success 91 ( 존재함 )
								}else{
									out.print("[][F91]");	//  성공 - Fail 91 ( 존재하지 않음 )
								}
							}catch(Exception e){
								out.print("[][E91]");	// 실패 - Error 9 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E91]");	// 실패 - Error 9 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 92 : // 기기 등록 완료 후 기기 정보 초기화
					{
						try{
							String mac = request.getParameter("mac");
							try{
								sql = "select * from [dbo].[Airble_Device_TB] where mac = '" + mac + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									sql = "update [dbo].[Airble_Device_TB] set Airble_User_FK = 'System', Update_DT = dateadd(HOUR, 9, getdate()) where Airble_Device_PK = '" + mac + "'";
									stmt.executeUpdate(sql);
									sql = "delete [dbo].[Airble_Real_Time_TB] where Airble_Device_FK = '" + mac + "'";
									stmt.executeUpdate(sql);
									sql = "delete [dbo].[Airble_M_Time_TB] where Airble_Device_FK = '" + mac + "'";
									stmt.executeUpdate(sql);
									sql = "delete [dbo].[Airble_H_Time_TB] where Airble_Device_FK = '" + mac + "'";
									stmt.executeUpdate(sql);
									sql = "delete [dbo].[Airble_Real_Time_TB] where Airble_Device_FK = '" + mac + "'";
									stmt.executeUpdate(sql);
									
									out.print("[][S92]");	//  성공 - Success 92
								}else{
									out.print("[][F92]");	// 실패 - Fail 92 ( 테스트를 한번도 진행하지않아 등록된 기기가 없음)
								}
							}catch(Exception e){
								out.print("[][E92]");	// 실패 - Error 92 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E92]");	// 실패 - Error 92 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					/** 
					*	case 1 계열 : Airble Device <-> Database
					*/
					
					case 1: // Airble Device 등록
					{
						try{
							String mac = request.getParameter("mac");
							String email = request.getParameter("email");
							// String nickname = request.getParameter("nickname");
							try{
								sql = "select * from [dbo].[Airble_User_Device_TB] where Airble_Device_FK = '" + mac + "' and Airble_Owner = 1";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									out.print("[][FF1]"); //  실패 - Fail 1 ( 이미 다른 유저가 등록해 사용중 ) ( 등록되지 않은 기기 + 테스트완료가 안됨 )
									if(rs.getString("Airble_User_FK").trim().equals("System")){
										
									}else{
										
									}
								}else{
									String nickname = "airble_" + mac.substring(0,2) + mac.substring(3,5) + mac.substring(6,8) + mac.substring(9,11) + mac.substring(12,14) + mac.substring(15,17);
									
									sql = "insert into [dbo].[Airble_User_Device_TB] values ((select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email ='" + email + "'), '" + mac + "', 1, (select count(*) + 1 from [dbo].[Airble_User_Device_TB] where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "')), dateadd(HOUR, 9, getdate()))";
									stmt.executeUpdate(sql);
									sql = "update [dbo].[Airble_Device_TB] set Airble_NickName = '" + nickname + "', Update_DT = dateadd(HOUR, 9, getdate()) where Airble_Device_PK = '" + mac + "'";
									stmt.executeUpdate(sql);
									try{
										sql = "update [dbo].[Airble_State_TB] set Airble_WIFI_Reset = 0 where Airble_Device_FK = '" + mac + "'";
										stmt.executeUpdate(sql);
									}catch(Exception e){
										sql = "insert into [dbo].[Airble_State_TB] values ('" + mac + "', 100, 255, 'Test', 0, 0, '1100000000')";
										stmt.executeUpdate(sql);
									}
									out.print("[][S1]");	//  성공 - Success 1
								}
							}catch(Exception e){
								out.print("[][E1]");	// 실패 - Error 1 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E1]");	// 실패 - Error 1 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 10: // Airble Device 등록
					{
						try{
							String mac = request.getParameter("mac");
							String email = request.getParameter("email");
							String nickname = request.getParameter("nickname");
							try{
								sql = "select * from [dbo].[Airble_User_Device_TB] where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email ='" + email + "') and Airble_Device_FK = '" + mac + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									sql = "update [dbo].[Airble_Device_TB] set Airble_NickName = '" + nickname + "', Update_DT = dateadd(HOUR, 9, getdate()) where Airble_Device_PK = '" + mac + "'";
									stmt.executeUpdate(sql);
									out.print("[][S10]");	//  성공 - Success 10
								}else{
									out.print("[][F10]");	//  실패 - Fail 10 ( 등록되지 않은 기기 + 테스트완료가 안됨 )
								}
							}catch(Exception e){
								out.print("[][E10]");	// 실패 - Error 10 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E10]");	// 실패 - Error 10 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 11: // Airble Device 기기 정보 불러오기
					{
						try{
							String mac = request.getParameter("mac");
							String router = request.getParameter("router");
							try{
								sql = "select * from [dbo].[Airble_Device_TB] where Airble_Device_PK = '" + mac + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									sql = "select * from [dbo].[Airble_State_TB] where Airble_Device_FK = '" + mac + "'";
									rs = stmt.executeQuery(sql);
									if(rs.next()){
										int brightness = rs.getInt("Airble_Brightness");
										int volume = rs.getInt("Airble_Volume");
										int wifi_reset = rs.getInt("Airble_WIFI_Reset");
										int join_interval = 0;
										
										sql = "select iif(datediff(mi, User_Join_DT, dateadd(HOUR, 9, getdate())) < 2, '1', '0') as join_interval from [dbo].[Airble_User_TB] where Airble_User_PK = (select Airble_User_FK from [dbo].[Airble_User_Device_TB] where Airble_Device_FK = '" + mac + "' and Airble_Owner = 1)";
										
										rs = stmt.executeQuery(sql);
										rs.next();
										
										join_interval = rs.getInt("join_interval");
										
										out.print("[][S11][" + brightness + "][" + volume + "][" + wifi_reset + "][" + join_interval + "]" );	//  성공 - Success 11
									}else{
										sql = "insert into [dbo].[Airble_State_TB] values ('" + mac + "', 100, 255, '" + router + "', 0, 0, '1100000000')";
										stmt.executeUpdate(sql);
										out.print("[][S11][100][255][0]");	//  성공 - Success 11 ( 초기화 개념.. )
									}
								}else{
									out.print("[][F11]");	//  실패 - Fail 11 ( 등록되지 않은 기기 + 테스트완료가 안됨 )
								}
							}catch(Exception e){
								out.print("[][E11]");	// 실패 - Error 11 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E11]");	// 실패 - Error 11 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 12: // Airble Device 기기 센서 값 뿌리기
					{
						try{
							String mac = request.getParameter("mac");
							String pm = request.getParameter("pm");
							String co = request.getParameter("co");
							String co2 = request.getParameter("co2");
							String voc = request.getParameter("voc");
							String temp = request.getParameter("temp");
							String humi = request.getParameter("humi");
							
							try{
								
								sql = "select * from [dbo].[Airble_Real_Time_TB] where Airble_Device_FK = '" + mac + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									if(temp.trim().equals("0")&&humi.trim().equals("0")){
										sql ="update [dbo].[Airble_Real_Time_TB] set Airble_Data_DT = dateadd(HOUR, 9, getdate()) where Airble_Device_FK = '" + mac + "'";
									}else{
										sql = "update [dbo].[Airble_Real_Time_TB] set " + 
												"Airble_CO = " + co + 
												", Airble_CO2 = " + co2 + 
												", Airble_VOC = " + voc + 
												", Airble_Dust = " + pm + 
												", Airble_Temp = " + temp + 
												", Airble_Humi = " + humi + 
												", Airble_Data_DT = dateadd(HOUR, 9, getdate()) where Airble_Device_FK = '" + mac + "'";
									}
									//System.out.print(LocalTime.now() + " - ");
									//System.out.println(sql);
									stmt.executeUpdate(sql);
									out.print("[][S12]");	//  성공 - Success 12 ( 데이터 업데이트 )
								}else{
									if(!(temp.trim().equals("0")&&humi.trim().equals("0"))){
										sql = "insert into [dbo].[Airble_Real_Time_TB] values( '" + mac + "'," + co + ", " + co2 + ", " + voc + ", " + pm + ", " + temp + ", " + humi + ", dateadd(HOUR, 9, getdate()))";
										//System.out.println(sql);
										stmt.executeUpdate(sql);
									}
									
									out.print("[][S12]");	//  성공 - Success 12 ( 데이터 첫 등록 )
								}
							}catch(Exception e){
								out.print("[][E12]");	// 실패 - Error 12 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E12]");	// 실패 - Error 12 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 13: // Airble Device의 지역 미세먼지, 온습도 불러오기
					{
						try{
							String mac = request.getParameter("mac");
							try{
								sql = "Select  PM , Temp, Humi from [dbo].[Air_Data_TB] where Air_Data_PK = (select Airble_Place_Code from [dbo].[Airble_State_TB] where Airble_Device_FK = '" + mac + "')";
								rs = stmt.executeQuery(sql);
								
								if(rs.next()){

									int PM = rs.getInt("PM");
									int Temp = rs.getInt("Temp");
									int Humi = rs.getInt("Humi");
									
									out.print("[][S13][" + PM + "][" + Temp + "][" + Humi + "]" );	//  성공 - Success 13
									
								}else{
									out.print("[][F13]");	//  실패 - Fail 13 ( 등록되지 않은 기기 + 테스트완료가 안됨 )
								}
							}catch(Exception e){
								out.print("[][E13]");	// 실패 - Error 13 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E13]");	// 실패 - Error 13 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 14: // Airble Device 기기 상태 정보 불러오기
					{
						try{
							String mac = request.getParameter("mac");
							String router = request.getParameter("router");
							try{
								sql = "select * from [dbo].[Airble_State_TB] where Airble_Device_FK ='" + mac + "'";
								rs = stmt.executeQuery(sql);
								
								if(rs.next()){
									sql = "update [dbo].[Airble_State_TB] set WIFI_SSID = '" + router + "' where Airble_Device_FK = '" + mac + "'";
									stmt.executeUpdate(sql);
								}else{
									sql = "insert into [dbo].[Airble_State_TB] values ('" + mac + "', 100, 255, '" + router + "', 0, '1100000000')";
									stmt.executeUpdate(sql);
								}
								rs.close();

								sql = "select a.Airble_Device_FK, a.Airble_Brightness, a.Airble_Volume, a.Airble_WIFI_Reset, a.Airble_Page, a.Airble_Place_Code, "
										+ "iif(datediff(SECOND, c.User_Access_DT, dateadd(HOUR, 9, getdate())) < 10, 1, 0) as Access_app, "
										+ "iif(datediff(SECOND, b.Update_DT, dateadd(HOUR, 9, getdate())) < 10, 1, 0) as Access_option, "
										+ "CAST(d.Temp * 10 as INT) as Temp, CAST(d.Humi * 10 as INT) as Humi, d.PM "
										+ "from [dbo].[Airble_State_TB] as a "
										+ "join [dbo].[Airble_User_Device_TB] as b on a.Airble_Device_FK = b.Airble_Device_FK "
										+ "join [dbo].[Airble_User_TB] as c on b.Airble_User_FK = c.Airble_User_PK "
										+ "join [dbo].[Air_Data_TB] as d on a.Airble_Place_Code = d.Air_Data_PK "
										+ "where b.Airble_Device_FK = '" + mac + "' and b.Airble_Owner = 1";
								rs = stmt.executeQuery(sql);
								
								if(rs.next()){
									int brightness = rs.getInt("Airble_Brightness");
									int volume = rs.getInt("Airble_Volume");
									int wifi_reset = rs.getInt("Airble_WIFI_Reset");
									int airble_page = rs.getInt("Airble_Page");
									String place_code = rs.getString("Airble_Place_Code");
									int access_app = rs.getInt("Access_app");
									int access_option = rs.getInt("Access_option");
									int pm = rs.getInt("PM");
									int temp = rs.getInt("Temp");
									int humi = rs.getInt("Humi");
									
									out.print("[][S14]," + brightness + "," + volume + "," + wifi_reset + "," + airble_page + "," + place_code + "," + access_app + "," + access_option  + "," + pm  + "," + temp  + "," + humi);	//  성공 - Success 14
									//System.out.print(LocalTime.now() + " - ");
									//System.out.println("[][S14]," + brightness + "," + volume + "," + wifi_reset + "," + airble_page + "," + place_code + "," + access_app + "," + access_option  + "," + pm  + "," + temp  + "," + humi);
									
									if(access_app == 0){
										sql = "update [dbo].[Airble_State_TB] set Airble_Page = 0 where Airble_Device_FK = '" + mac + "'";
										stmt.executeUpdate(sql);
									}
								}else{
									out.print("[][S14],100,255,1,0,1100000000,0,0,0,0,0");	//  실패 - Fail 14 ( 주인이 없는 기기 , 잘못된 경로 )
								}
							}catch(Exception e){
								out.print("[][E14]");	// 실패 - Error 14 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E14]");	// 실패 - Error 14 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					/**
					*	case 2 계열 : APP <-> Database
					*/
					
					case 2: // 유저 회원가입 -> 유저 등록
					{
						try{
							String email = request.getParameter("email");
							try{
								sql = "select * from [dbo].[Airble_User_TB] where User_Email = '" + email + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									out.print("[][F2]");	// 실패 - Fail 2 ( 이미 존재하는 이메일 )
								}else{
									sql = "insert into [dbo].[Airble_User_TB] values " + 
										"(concat('IoTU', year(dateadd(HOUR, 9, getdate())) , format(next value for [dbo].[Airble_User_SEQ], '000000')), '" + email + "', dateadd(HOUR, 9, getdate()), dateadd(HOUR, 9, getdate()))";
									stmt.executeUpdate(sql);
									out.print("[][S2]");	//  성공 - Success 2
								}
							}catch(Exception e){
								out.print("[][E2]");	// 실패 - Error 2 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E2]");	// 실패 - Error 2 ( email 받아오기 실패 )
						}
					}
					break;
					
					case 20: // 유저 로그인 시간 갱신 -> 유저 최신 로그인 시간 갱신
					{
						try{
							String email = request.getParameter("email");
							try{
								sql = "update [dbo].[Airble_User_TB] set User_Join_DT = dateadd(HOUR, 9, getdate()) where User_Email = '" +  email + "'";
								stmt.executeUpdate(sql);
								out.print("[][S20]");	//  성공 - Success 20
							}catch(Exception e){
								out.print("[][E20]");	// 실패 - Error 20 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E20]");	// 실패 - Error 20 ( email 받아오기 실패 )
						}
					}
					break;
					
					case 21: // 유저 기기 등록 -> 기기 등록
					{
						try{
							String email = request.getParameter("email");
							String ssid = request.getParameter("ssid");
							try{
								sql = "select * from [dbo].[Airble_User_TB] where User_Email = '" + email + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									out.print("[][F21]");	// 실패 - Fail 21 ( 이미 존재하는 이메일 )
								}else{
									sql = "insert into [dbo].[Airble_User_TB] values " + 
										"(concat('IoTU', year(dateadd(HOUR, 9, getdate())) , format(next value for [dbo].[Airble_User_SEQ], '000000')), '" + email + "', dateadd(HOUR, 9, getdate()), dateadd(HOUR, 9, getdate()))";
									stmt.executeUpdate(sql);
									out.print("[][S21]");	//  성공 - Success 21
								}
							}catch(Exception e){
								out.print("[][E21]");	// 실패 - Error 21 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E21]");	// 실패 - Error 21 ( email 받아오기 실패 )
						}
					}
					break;
					
					case 22: // 유저의 등록된 기기 불러오기 -> 기기 불러오기
					{
						try{
							String email = request.getParameter("email");
							try{
								sql = "select * from [dbo].[Airble_Real_Time_TB] where Airble_Device_FK in (select Airble_Device_PK from [dbo].[Airble_Device_TB] where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "'))";
								rs = stmt.executeQuery(sql);
								
								if(rs.next()){

									SendMessage += "[[0314590405]]";
									SendMessage += rs.getString(1) + "[]";
									SendMessage += rs.getInt(2) + "[]";
									SendMessage += rs.getInt(3) + "[]";
									SendMessage += rs.getInt(4) + "[]";
									SendMessage += rs.getInt(5) + "[]";
									SendMessage += rs.getInt(6) + "[]";
									SendMessage += rs.getInt(7) + "[]";
									SendMessage += rs.getString(8);
									
									while(rs.next()){
										SendMessage += "[[0314590405]]";
										SendMessage += rs.getString(1) + "[]";
										SendMessage += rs.getInt(2) + "[]";
										SendMessage += rs.getInt(3) + "[]";
										SendMessage += rs.getInt(4) + "[]";
										SendMessage += rs.getInt(5) + "[]";
										SendMessage += rs.getInt(6) + "[]";
										SendMessage += rs.getInt(7) + "[]";
										SendMessage += rs.getString(8);
									}
									
									SendMessage = "[][S22]" + SendMessage; //  성공 - Success 22
								}else{
									SendMessage = "[][F22]"; // 실패 - Fail 22 ( 등록된 기기가 없음 )
								}
								
								out.print(SendMessage);
						
							}catch(Exception e){
								out.print("[][E22]");	// 실패 - Error 22 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E22]");	// 실패 - Error 22 ( email 받아오기 실패 )
						}
					}
					break;
					
					case 23: // 유저 기기 정보 가져오기 -> 기기 정보 가져오기
					{
						try{
							String mac = request.getParameter("mac");
							try{
								sql = "select * from [dbo].[Airble_Device_TB] where Airble_Device_PK = '" + mac + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									sql = "select * from [dbo].[Airble_State_TB] where Airble_Device_FK = '" + mac + "'";
									rs = stmt.executeQuery(sql);
									if(rs.next()){
										int brightness = rs.getInt("Airble_Brightness");
										int volume = rs.getInt("Airble_Volume");
										String router = rs.getString("WIFI_SSID");
										out.print("[][S23][" + brightness + "][" + volume + "][" + router + "]");	//  성공 - Success 23
									}else{
										out.print("[][FF23]");	//  실패 - Fail ( 라우터에 재대로 연결이 된 적이 없음 )
									}
								}else{
									out.print("[][F23]");	//  실패 - Fail 23 ( 등록되지 않은 기기 + 테스트완료가 안됨 )
								}
							}catch(Exception e){
								out.print("[][E23]");	// 실패 - Error 23 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E23]");	// 실패 - Error 23 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 24: // 유저 기기 정보 수정하기 -> 기기 정보 수정하기
					{
						try{
							String mac = request.getParameter("mac");
							String volume = request.getParameter("volume");
							String brightness = request.getParameter("brightness");
							
							try{
								sql = "select * from [dbo].[Airble_State_TB] where Airble_Device_FK = '" + mac + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									sql = "update [dbo].[Airble_State_TB] set Airble_Brightness = '" + brightness + "', Airble_Volume = '" + volume + "' where Airble_Device_FK = '" + mac + "'";
									stmt.executeUpdate(sql);
									out.print("[][S24]");	//  성공 - Success 24
									
								}else{
									out.print("[][F24]");	//  실패 - Fail 24
								}
							}catch(Exception e){
								out.print("[][E24]");	// 실패 - Error 24 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E24]");	// 실패 - Error 24 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 25: // 유저가 APP에서 기기 삭제하기 -> 기기 사용자 System으로 변경하기
					{
						try{
							String mac = request.getParameter("mac");
							String email = request.getParameter("email");
							try{
								sql = "select * from [dbo].[Airble_Device_TB] where Airble_Device_PK = '" + mac + "' and Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "')";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									sql = "update [dbo].[Airble_Device_TB] set Airble_User_FK = 'System' where Airble_Device_PK = '" + mac + "'";
									stmt.executeUpdate(sql);
									sql = "update [dbo].[Airble_State_TB] set Airble_WIFI_Reset = 1 where Airble_Device_FK = '" + mac + "'";
									stmt.executeUpdate(sql);
									out.print("[][S25]");	//  성공 - Success 25
									
								}else{
									out.print("[][F25]");	//  실패 - Fail 25
								}
							}catch(Exception e){
								out.print("[][E25]");	// 실패 - Error 25 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E25]");	// 실패 - Error 25 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 26: // 유저가 로그인 시 기존 기기 있는지 확인하기 -> 기기 리스트 불러오기
					{
						try{
							String email = request.getParameter("email");
							try{
								sql = "select * from [dbo].[Airble_Device_TB] where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "')";
								rs = stmt.executeQuery(sql);
								while(rs.next()){
									// [[0314590405]]mac주소[0314590405]ssid[0314590405]nickname
									SendMessage += "[[0314590405]]" + rs.getString("Airble_Device_PK");
									SendMessage += "[0314590405]" + rs.getString("Airble_SSID");
									SendMessage += "[0314590405]" + rs.getString("Airble_NickName");
								}
								
								if(!SendMessage.trim().equals("")){
									out.print("[][S26]" + SendMessage);	//  성공 - Success 26
									
								}else{
									out.print("[][F26]");	//  실패 - Fail 26
								}
							}catch(Exception e){
								out.print("[][E26]");	// 실패 - Error 26 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E26]");	// 실패 - Error 26 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 27: // 유저가 기기 별명 바꾸기 -> 기기 NickName 변경
					{
						try{
							String mac = request.getParameter("mac");
							String nickname = request.getParameter("nickname");
							
							try{
								sql = "update [dbo].[Airble_Device_TB] set Airble_NickName = '" + nickname + "' where Airble_Device_PK = '" + mac + "'";
								stmt.executeUpdate(sql);
								out.print("[][S27]");	//  성공 - Success 27
								
							}catch(Exception e){
								out.print("[][E27]");	// 실패 - Error 27 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E27]");	// 실패 - Error 27 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 28: // 유저가 기기 WIFI 리셋 -> 기기 WIFI 리셋
					{
						try{
							String mac = request.getParameter("mac");
							try{
								sql = "update [dbo].[Airble_State_TB] set Airble_WIFI_Reset = 1 where Airble_Device_FK = '" + mac + "'";
								stmt.executeUpdate(sql);
								out.print("[][S28]");	//  성공 - Success 28
								
							}catch(Exception e){
								out.print("[][E28]");	// 실패 - Error 28 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E28]");	// 실패 - Error 28 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 29: // 기기의 일일 데이터 불러오기
					{
						try{
							String mac = request.getParameter("mac");
							String date = request.getParameter("date");
							
							String year = date.substring(0, 4);
							String month = date.substring(4, 6);
							String day = date.substring(6, 8);
							
							try{
								sql = "select * from [dbo].[Airble_H_Time_TB] where Airble_Device_FK = '" + mac + "' and year(Airble_Data_DT) = " + year + " and month(Airble_Data_DT) = " + month + " and day(Airble_Data_DT) = " + day + " order by Airble_Data_DT";
								//System.out.println(sql);
								rs = stmt.executeQuery(sql);
								SendMessage = "[][S29]";
								
								while(rs.next()){
									SendMessage += ",,";
									SendMessage += rs.getInt("Airble_CO") + ",";
									SendMessage += rs.getInt("Airble_CO2") + ",";
									SendMessage += rs.getInt("Airble_VOC") + ",";
									SendMessage += rs.getInt("Airble_Dust") + ",";
									SendMessage += rs.getInt("Airble_Temp") + ",";
									SendMessage += rs.getInt("Airble_Humi") + ",";
									SendMessage += rs.getString("Airble_Data_DT");
								}
								out.print(SendMessage);
							}catch(Exception e){
								out.print("[][E29]");	// 실패 - Error 29 ( 데이터베이스 문제 )
							}
							
						}catch(Exception e){
							out.print("[][E29]");	// 실패 - Error 29 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 30: // 기기의 월별 데이터 불러오기
					{
						try{
							String mac = request.getParameter("mac");
							String date = request.getParameter("date");
							
							String year = date.substring(0, 4);
							String month = date.substring(4, 6);
							
							try{
								sql = "select AVG(Airble_CO) as Airble_CO, AVG(Airble_CO2) as Airble_CO2, AVG(Airble_VOC) as Airble_VOC, AVG(Airble_Dust) as Airble_Dust, AVG(Airble_Temp) as Airble_Temp, AVG(Airble_Humi) as Airble_Humi, day(Airble_Data_DT) as Airble_Data_Day " +
										"from [dbo].[Airble_H_Time_TB] where Airble_Device_FK = '" + mac + "' and year(Airble_Data_DT) = " + year + " and month(Airble_Data_DT) = " + month + " group by day(Airble_Data_DT) order by Airble_Data_Day";
								//System.out.println(sql);
								rs = stmt.executeQuery(sql);
								SendMessage = "[][S30]";
								
								while(rs.next()){
									SendMessage += ",,";
									SendMessage += rs.getInt("Airble_CO") + ",";
									SendMessage += rs.getInt("Airble_CO2") + ",";
									SendMessage += rs.getInt("Airble_VOC") + ",";
									SendMessage += rs.getInt("Airble_Dust") + ",";
									SendMessage += rs.getInt("Airble_Temp") + ",";
									SendMessage += rs.getInt("Airble_Humi") + ",";
									SendMessage += rs.getString("Airble_Data_Day");
								}
								out.print(SendMessage);
							}catch(Exception e){
								out.print("[][E30]");	// 실패 - Error 30 ( 데이터베이스 문제 )
							}
							
						}catch(Exception e){
							out.print("[][E30]");	// 실패 - Error 30 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 31: // Airble Device의 지역 설정해주기
					{
						try{
							String mac = request.getParameter("mac");
							String code = request.getParameter("code");
							try{
								sql = "update [dbo].[Airble_State_TB] set Airble_Place_Code = '" + code + "' where Airble_Device_FK = '" + mac + "'";
								stmt.executeUpdate(sql);
								out.print("[][S31]");	//  성공 - Success 31
								
							}catch(Exception e){
								out.print("[][E31]");	// 실패 - Error 31 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E31]");	// 실패 - Error 31 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 4: // 유저 로그인 시간 갱신 -> 유저 최신 로그인 시간 갱신
					{
						try{
							String email = request.getParameter("email");
							try{
								sql = "update [dbo].[Airble_User_TB] set User_Join_DT = dateadd(HOUR, 9, getdate()) where User_Email = '" +  email + "'";
								stmt.executeUpdate(sql);
								out.print("[][S4]");	//  성공 - Success 4
							}catch(Exception e){
								out.print("[][E4]");	// 실패 - Error 4 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E4]");	// 실패 - Error 4 ( email 받아오기 실패 )
						}
					}
					break;
				
					// 유저 로그인
					case 40:
					{
						try{
							String email = request.getParameter("email");
							try{
								sql = "select * from [dbo].[Airble_User_TB] where User_Email = '" + email + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									out.print("[][S40]");	// 성공 - Success ( 이미 회원인 상태 로그인 시작 )
								}else{
									out.print("[][F40]");	//  실패 - Fail 40 ( 회원가입 진행 )
								}
							}catch(Exception e){
								out.print("[][E40]");	// 실패 - Error 40 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E40]");	// 실패 - Error 40 ( email 받아오기 실패 )
						}
					}
					break;
					
					// 유저 회원가입
					case 41:
					{
						try{
							String email = request.getParameter("email");
							try{
								sql = "select * from [dbo].[Airble_User_TB] where User_Email = '" + email + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									out.print("[][F41]");	// 실패 - Fail 41 ( 이미 회원인 상태 )
								}else{
									sql = "insert into [dbo].[Airble_User_TB] values " + 
										"(concat('IoTU', year(dateadd(HOUR, 9, getdate())) , format(next value for [dbo].[Airble_User_SEQ], '000000')), '" + email + "', dateadd(HOUR, 9, getdate()), dateadd(HOUR, 9, getdate()))";
									stmt.executeUpdate(sql);
									out.print("[][S41]");	//  성공 - Success 41
								}
							}catch(Exception e){
								out.print("[][E41]");	// 실패 - Error 41 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E41]");	// 실패 - Error 41 ( email 받아오기 실패 )
						}
					}
					break;
					
					// 유저 기기 불러오기
					case 42:
					{
						try{
							String email = request.getParameter("email");
							try{
								sql = "update [dbo].[Airble_User_TB] set User_Access_DT = dateadd(HOUR, 9, getdate()) where User_Email = '" + email + "'";
								stmt.executeUpdate(sql);
								sql = "select a.Airble_Device_FK, a.Airble_Owner, b.Airble_Devices_FK, b.Airble_SSID, Airble_NickName, a.Update_DT "
										+ "from [dbo].[Airble_User_Device_TB] as a join [dbo].[Airble_Device_TB] as b on a.Airble_Device_FK = b.Airble_Device_PK where a.Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB]" 
										+ "where User_Email = '" + email + "') order by a.Airble_Order";
								rs = stmt.executeQuery(sql);
								while(rs.next()){
									SendMessage += ",,";
									SendMessage += rs.getString(1) + ",";
									SendMessage += rs.getInt(2) + ",";
									SendMessage += rs.getString(3) + ",";
									SendMessage += rs.getString(4) + ",";
									SendMessage += rs.getString(5) + ",";
									SendMessage += rs.getString(6);
								}
								
								if(SendMessage.trim().equals("")){
									SendMessage = "[][F42]"; // 실패 - Fail 42 ( 등록된 기기가 없음 )
								}else{
									SendMessage = "[][S42]" + SendMessage; //  성공 - Success 42
								}
								
								out.print(SendMessage);
						
							}catch(Exception e){
								out.print("[][E42]");	// 실패 - Error 22 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E42]");	// 실패 - Error 22 ( email 받아오기 실패 )
						}
					}
					break;
					
					// 유저 기기 삭제하기
					case 421:
					{
						try{
							String mac = request.getParameter("mac");
							String email = request.getParameter("email");
							try{
								sql = "select * from [dbo].[Airble_User_Device_TB] where "
										+ "Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "') "
										+ "and Airble_Device_FK = '" + mac + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									ResultSet rs2 = null;
									Statement stmt2 = null;
									stmt2 = conn.createStatement();
									
									if(rs.getInt("Airble_Owner") == 1){
										sql = "update [dbo].[Airble_State_TB] set Airble_WIFI_Reset = 1 where Airble_Device_FK = '" + mac + "'";
										stmt.executeUpdate(sql);
										
										String user ="";
										sql = "select Airble_User_FK from [dbo].[Airble_User_Device_TB] where Airble_Device_FK = '" + mac + "'";
										rs2 = stmt.executeQuery(sql);
										
										
										
										while(rs2.next()){
											user = rs2.getString("Airble_User_FK");
											sql = "update [dbo].[Airble_User_Device_TB] set Airble_Order = Airble_Order - 1 where Airble_Order > (select Airble_Order from [dbo].[Airble_User_Device_TB] where Airble_Device_FK = '" + mac + "' and Airble_User_FK = '" + user + "') and Airble_User_FK = '" + user + "'";
											stmt2.executeUpdate(sql);
											sql = "delete [dbo].[Airble_User_Device_TB] where Airble_Device_FK = '" + mac + "' and Airble_User_FK = '" + user + "'";
											stmt2.executeUpdate(sql);
										}
										rs2.close();
										stmt2.close();
									}else{
										sql = "update [dbo].[Airble_User_Device_TB] set Airble_Order = Airble_Order - 1 where Airble_Order > (select Airble_Order from [dbo].[Airble_User_Device_TB] where Airble_Device_FK = '" + mac + "' and Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "')) and Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "')";
										stmt.executeUpdate(sql);
										sql = "delete [dbo].[Airble_User_Device_TB] where Airble_Device_FK = '" + mac + "' and Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "')";
										stmt.executeUpdate(sql);
									}
									
									out.print("[][S421]"); //  성공 - Success 421
								}else{
									out.print("[][F421]"); // 실패 - Fail 421 ( 본인이 주인이 아님, 기기를 등록하지 않음, 잘못된 삭제 경로.. )
								}
								
							}catch(Exception e){
								out.print("[][E421]");	// 실패 - Error 421 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E421]");	// 실패 - Error 421 ( 받아오기 실패 )
						}
					}
					break;
					
					// 유저 기기 대여해주기 위한 코드 생성
					case 422:
					{
						try{
							String mac = request.getParameter("mac");
							String email = request.getParameter("email");
							
							try{
								sql = "select * from [dbo].[Airble_User_Device_TB] where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "') and Airble_Device_FK = '" + mac + "' and Airble_Owner = 1";
								rs = stmt.executeQuery(sql);
								char[] codes = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P'
										, 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
								String code = "";
								Random random = new Random();
								if(rs.next()){
									do{
										code = "";
										for(int i = 0; i < 10; i++){
											code += codes[random.nextInt(codes.length)];
										}
										rs.close();
										sql = "select * from [dbo].[Airble_Device_TB] where Airble_Shared_Key = '" + code + "'";
										rs = stmt.executeQuery(sql);
									}while(rs.next());
									
									sql = "update [dbo].[Airble_Device_TB] set Airble_Shared_Key = '" + code + "' where Airble_Device_PK = '" + mac + "'";
									stmt.executeUpdate(sql);
									
									out.print("[][S422]," + code );	//  성공 - Success 422
									
								}else{
									out.print("[][F422]");	// 실패 - Fail 422 ( 등록된 기기가 없거나 주인이 아님, 잘못된 경로 )
								}
						
							}catch(Exception e){
								out.print("[][E422]");	// 실패 - Error 422 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E422]");	// 실패 - Error 422 ( email 받아오기 실패 )
						}
					}
					break;
					
					// 유저 기기 공유받기
					case 423:
					{
						try{
							String code = request.getParameter("code");
							String email = request.getParameter("email");
							
							try{
								if(code.trim().equals("0000000000")){
									out.print("[][F423_1]");	// 실패 - Fail 423_1 ( 잘못된 코드, 잘못된 경로 )
								}else{
									sql = "select * from [dbo].[Airble_Device_TB] where Airble_Shared_Key = '" + code + "'";
									rs = stmt.executeQuery(sql);
									if(rs.next()){
										rs.close();
										sql = "select * from [dbo].[Airble_User_Device_TB] " 
												+ "where Airble_Device_FK = (select Airble_Device_PK from [dbo].[Airble_Device_TB] where Airble_Shared_Key = '" + code + "') "
												+ "and Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "')";
										rs = stmt.executeQuery(sql);
										if(rs.next()){
											out.print("[][F423_2]");	// 실패 - Fail 423_2 ( 이미 추가된 보유하고 있는 기기 )
										}else{
											sql = "insert into [dbo].[Airble_User_Device_TB] values ("
													+ "(select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email ='" + email + "'), "
													+ "(select Airble_Device_PK from [dbo].[Airble_Device_TB] where Airble_Shared_Key = '" + code + "'), "
													+ "0, "
													+ "(select count(*) + 1 from [dbo].[Airble_User_Device_TB] where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "')), "
													+ "dateadd(HOUR, 9, getdate()))";
											stmt.executeUpdate(sql);
											sql = "update [dbo].[Airble_Device_TB] set Airble_Shared_Key = '0000000000' where Airble_Shared_Key = '" + code + "'";
											stmt.executeUpdate(sql);
											
											out.print("[][S423]");	//  성공 - Success 423
										}
										
									}else{
										out.print("[][F423_3]");	// 실패 - Fail 423_3 ( 잘못된 코드 번호 )
									}
								}
						
							}catch(Exception e){
								out.print("[][E423]");	// 실패 - Error 423 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E423]");	// 실패 - Error 423 
						}
					}
					break;
					
					// 유저 기기 공유 취소하기
					case 424:
					{
						try{
							String mac = request.getParameter("mac");
							String email = request.getParameter("email");
							
							try{
								sql = "select * from [dbo].[Airble_User_Device_TB] where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "') and Airble_Device_FK = '" + mac + "' and Airble_Owner = 1";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									sql = "update [dbo].[Airble_Device_TB] set Airble_Shared_Key = '0000000000' where Airble_Device_PK = '" + mac + "'";
									stmt.executeUpdate(sql);
									out.print("[][S424]");	//  성공 - Success 424
									
								}else{
									out.print("[][F424]");	// 실패 - Fail 424 ( 기기 주인이 아님, 잘못된접근경로 )
								}
						
							}catch(Exception e){
								out.print("[][E424]");	// 실패 - Error 424 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E424]");	// 실패 - Error 424 
						}
					}
					break;
					
					// 공유된 기기를 가진 유저 불러오기
					case 425:
					{
						try{
							String mac = request.getParameter("mac");
							String email = request.getParameter("email");
							
							try{
								sql = "select * from [dbo].[Airble_User_Device_TB] where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "') and Airble_Device_FK = '" + mac + "' and Airble_Owner = 1";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									rs.close();
									sql = "select User_Email from [dbo].[Airble_User_TB] where Airble_User_PK in (select Airble_User_FK from [dbo].[Airble_User_Device_TB] where Airble_Device_FK = '" + mac + "' and Airble_Owner <> 1)";
									rs = stmt.executeQuery(sql);
									while(rs.next()){
										SendMessage += "," + rs.getString("User_Email");
									}
									
									out.print("[][S425]" + SendMessage);	//  성공 - Success 425
								}else{
									out.print("[][F425]");	// 실패 - Fail 425 ( 기기 주인이 아님, 잘못된접근경로 )
								}
				
						
							}catch(Exception e){
								out.print("[][E425]");	// 실패 - Error 425 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E425]");	// 실패 - Error 425 
						}
					}
					break;
					
					// 공유된 기기를 가진 유저 권한 없애기
					case 426:
					{
						try{
							String mac = request.getParameter("mac");
							String email = request.getParameter("email");
							String shared_email = request.getParameter("shared_email");
							
							try{
								sql = "select * from [dbo].[Airble_User_Device_TB] where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "') and Airble_Device_FK = '" + mac + "' and Airble_Owner = 1";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									sql = "update [dbo].[Airble_User_Device_TB] set "
											+ "Airble_Order = Airble_Order - 1 "
											+ "where Airble_Order > (select Airble_Order from [dbo].[Airble_User_Device_TB] where Airble_Device_FK = '" + shared_email + "' "
											+ "and Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + shared_email + "')) "
											+ "and Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + shared_email + "')";
									stmt.executeUpdate(sql);
									sql = "delete [dbo].[Airble_User_Device_TB] where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + shared_email + "') and Airble_Device_FK = '" + mac + "'";
									stmt.executeUpdate(sql);
									out.print("[][S426]");	//  성공 - Success 426
								}else{
									out.print("[][F426]");	// 실패 - Fail 426 ( 기기 주인이 아님, 잘못된접근경로 )
								}
				
						
							}catch(Exception e){
								out.print("[][E426]");	// 실패 - Error 426 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E426]");	// 실패 - Error 426 
						}
					}
					break;
					
					case 43: // 유저의 등록된 기기 데이터 불러오기 -> 기기 데이터 불러오기
					{
						try{
							String email = request.getParameter("email");
							try{
								sql = "update [dbo].[Airble_User_TB] set User_Access_DT = dateadd(HOUR, 9, getdate()) where User_Email = '" + email + "'";
								stmt.executeUpdate(sql);
								
								ResultSet rs2 = null;
								Statement stmt2 = conn.createStatement();
								sql = "select Airble_Device_FK from [dbo].[Airble_User_Device_TB] where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "')";
								rs = stmt.executeQuery(sql);
								
								while(rs.next()){
									String device = rs.getString("Airble_Device_FK");
									sql = "select * from [dbo].[Airble_State_TB] where Airble_Device_FK = '" + device + "'";
									rs2 = stmt2.executeQuery(sql);
									if(!rs2.next()){
										sql = "insert into [dbo].[Airble_State_TB] values ('" + device + "', 100, 255, 'Sample', 0, 0, '1100000000')";
										stmt2.executeUpdate(sql);
									}
									
								}
								
								try{
									stmt2.close();
									rs2.close();
								}catch(Exception e){
									
								}
								
								sql = "select a.Airble_Device_FK, "
										+ "iif(a.Airble_Device_FK = b.Airble_Device_FK, Airble_CO, 0) as Airble_CO, "
										+ "iif(a.Airble_Device_FK = b.Airble_Device_FK, Airble_CO2, 0) as Airble_CO2, "
										+ "iif(a.Airble_Device_FK = b.Airble_Device_FK, Airble_VOC, 0) as Airble_VOC, "
										+ "iif(a.Airble_Device_FK = b.Airble_Device_FK, Airble_Dust, 0) as Airble_Dust, "
										+ "iif(a.Airble_Device_FK = b.Airble_Device_FK, Airble_Temp, 0) as Airble_Temp, "
										+ "iif(a.Airble_Device_FK = b.Airble_Device_FK, Airble_Humi, 0) as Airble_Humi, "
										+ "c.Airble_Place_Code, c.Division_1 + ' ' + c.Division_2 + ' ' + c.Division_3 as Division, c.Temp, c.Humi, c.PM, "
										+ "iif(a.Airble_Device_FK = b.Airble_Device_FK, Airble_Data_DT, dateadd(YEAR, -1, getdate())) as Airble_Data_DT "
										+ "from [dbo].[Airble_User_Device_TB] as a left join [dbo].[Airble_Real_Time_TB] as b on a.Airble_Device_FK = b.Airble_Device_FK "
											+ "join (select a.Airble_Device_FK, a.Airble_Place_Code, b.Division_1, b.Division_2, b.Division_3, b.Temp, b.Humi, b.PM from [dbo].[Airble_State_TB] as a "
												+ "join [dbo].[Air_Data_TB] as b on a.Airble_Place_Code = b.Air_Data_PK) as c on a.Airble_Device_FK = c.Airble_Device_FK "
										+ "where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "')"
										+ "order by Airble_Order";
								//System.out.println(sql);
								
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									SendMessage += ",,";
									SendMessage += rs.getString("Airble_Device_FK") + ",";
									SendMessage += rs.getInt("Airble_CO") + ",";
									SendMessage += rs.getInt("Airble_CO2") + ",";
									SendMessage += rs.getInt("Airble_VOC") + ",";
									SendMessage += rs.getInt("Airble_Dust") + ",";
									SendMessage += rs.getInt("Airble_Temp") + ",";
									SendMessage += rs.getInt("Airble_Humi") + ",";
									
									SendMessage += rs.getString("Airble_Place_Code") + ",";
									SendMessage += rs.getString("Division") + ",";
									SendMessage += rs.getFloat("Temp") + ",";
									SendMessage += rs.getFloat("Humi") + ",";
									SendMessage += rs.getInt("PM") + ",";
									
									SendMessage += rs.getString("Airble_Data_DT");
									
									while(rs.next()){
										SendMessage += ",,";
										SendMessage += rs.getString("Airble_Device_FK") + ",";
										SendMessage += rs.getInt("Airble_CO") + ",";
										SendMessage += rs.getInt("Airble_CO2") + ",";
										SendMessage += rs.getInt("Airble_VOC") + ",";
										SendMessage += rs.getInt("Airble_Dust") + ",";
										SendMessage += rs.getInt("Airble_Temp") + ",";
										SendMessage += rs.getInt("Airble_Humi") + ",";
										
										SendMessage += rs.getString("Airble_Place_Code") + ",";
										SendMessage += rs.getString("Division") + ",";
										SendMessage += rs.getFloat("Temp") + ",";
										SendMessage += rs.getFloat("Humi") + ",";
										SendMessage += rs.getInt("PM") + ",";
										
										SendMessage += rs.getString("Airble_Data_DT");
									}
									
									SendMessage = "[][S43]" + SendMessage; //  성공 - Success 43
								}else{
									SendMessage = "[][F43]"; // 실패 - Fail 43 ( 등록된 기기가 없음 )
								}
								
								out.print(SendMessage);
						
							}catch(Exception e){
								out.print("[][E43]");	// 실패 - Error 43 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E43]");	// 실패 - Error 43 ( email 받아오기 실패 )
						}
					}
					break;
					
					case 44: // 유저 기기 정보 가져오기 -> 기기 정보 가져오기
					{
						try{
							String mac = request.getParameter("mac");
							String email = request.getParameter("email");
							
							try{
								sql = "select * from [dbo].[Airble_User_Device_TB] where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "') and Airble_Device_FK = '" + mac + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									rs.close();
									sql = "select * from [dbo].[Airble_User_Device_TB] as a join [dbo].[Airble_State_TB] as b on a.Airble_Device_FK = b.Airble_Device_FK where a.Airble_Device_FK = '" + mac + "'";
									rs = stmt.executeQuery(sql);
									if(!rs.next()){
										sql = "insert into [dbo].[Airble_State_TB] values ('" + mac + "', 100, 255, null, 0, '1100000000')";
										stmt.executeUpdate(sql);
									}
									rs.close();
									sql = "select b.*, a.Airble_Shared_Key, (select a.User_Email from [dbo].[Airble_User_TB] as a join [dbo].[Airble_User_Device_TB] as b on a.Airble_User_PK = b.Airble_User_FK where b.Airble_Owner = 1 and b.Airble_Device_FK = '" + mac + "') as Master_Email from [dbo].[Airble_Device_TB] as a join "
											+ "(select a.Airble_Device_FK, a.Airble_Owner, b.Airble_Brightness, b.Airble_Volume, b.Airble_Place_Code from [dbo].[Airble_User_Device_TB] as a join [dbo].[Airble_State_TB] as b on a.Airble_Device_FK = b.Airble_Device_FK) "
											+ "as b on a.Airble_Device_PK = b.Airble_Device_FK where Airble_Device_FK = '" + mac + "' and Airble_Owner = 1";
									rs = stmt.executeQuery(sql);
									if(rs.next()){
										int brightness = rs.getInt("Airble_Brightness");
										int volume = rs.getInt("Airble_Volume");
										String place_code = rs.getString("Airble_Place_Code");
										String shared_key = rs.getString("Airble_Shared_Key");
										String master_email = rs.getString("Master_Email");
										
										out.print("[][S44]," + brightness + "," + volume + "," + place_code + "," + shared_key + "," + master_email);	//  성공 - Success 44
									}else{
										out.print("[][F44]");	//  실패 - Fail ( 데이터 출력오류 )
									}
								}else{
									out.print("[][FF44]");	//  실패 - FFail 44 ( 보유 기기가 아님 )
								}
							}catch(Exception e){
								out.print("[][E44]");	// 실패 - Error 44 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E44]");	// 실패 - Error 44 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 45: // 유저 옵션 접속 상태 갱신하기
					{
						try{
							String mac = request.getParameter("mac");
							
							try{
								sql = "update [dbo].[Airble_User_TB] set User_Access_DT = dateadd(HOUR, 9, getdate()) where Airble_User_PK = (select Airble_User_FK from [dbo].[Airble_User_Device_TB] where Airble_Owner = 1 and Airble_Device_FK = '" + mac + "')";
								stmt.executeUpdate(sql);
								sql = "update [dbo].[Airble_User_Device_TB] set Update_DT = dateadd(HOUR, 9, getdate()) where Airble_Owner = 1 and Airble_Device_FK = '" + mac + "'";
								stmt.executeUpdate(sql);
								
								out.print("[][S45]");	//  성공 - Success 45
								
							}catch(Exception e){
								out.print("[][E45]");	// 실패 - Error 45 ( 데이터베이스 문제 )
							}
							
						}catch(Exception e){
							out.print("[][E45]");	// 실패 - Error 45 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 46: // 유저가 보는 화면으로 리모콘 갱신
					{
						try{
							String mac = request.getParameter("mac");
							String airble_page = request.getParameter("page");
							
							try{
								sql = "update [dbo].[Airble_State_TB] set Airble_Page = " + airble_page + " where Airble_Device_FK = '" + mac + "'";
								stmt.executeUpdate(sql);
								
								out.print("[][S46]");	//  성공 - Success 45
								
							}catch(Exception e){
								out.print("[][E46]");	// 실패 - Error 45 ( 데이터베이스 문제 )
							}
							
						}catch(Exception e){
							out.print("[][E46]");	// 실패 - Error 45 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 470: // 유저가 기기 별명 바꾸기 -> 기기 NickName 변경
					{
						try{
							String mac = request.getParameter("mac");
							String nickname = request.getParameter("nickname");
							
							try{
								sql = "update [dbo].[Airble_Device_TB] set Airble_NickName = '" + nickname + "' where Airble_Device_PK = '" + mac + "'";
								stmt.executeUpdate(sql);
								out.print("[][S470]");	//  성공 - Success 470
								
							}catch(Exception e){
								out.print("[][E470]");	// 실패 - Error 470 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E470]");	// 실패 - Error 470 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 471: // 기기의 볼륨 변경
					{
						try{
							String mac = request.getParameter("mac");
							String volume = request.getParameter("volume");
							
							try{
								sql = "select * from [dbo].[Airble_State_TB] where Airble_Device_FK = '" + mac + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									sql = "update [dbo].[Airble_State_TB] set Airble_Volume = '" + volume + "' where Airble_Device_FK = '" + mac + "'";
									stmt.executeUpdate(sql);
									out.print("[][S471]");	//  성공 - Success 471
									
								}else{
									out.print("[][F471]");	//  실패 - Fail 471
								}
							}catch(Exception e){
								out.print("[][E471]");	// 실패 - Error 471 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E471]");	// 실패 - Error 471 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 472: // 기기의 밝기 변경
					{
						try{
							String mac = request.getParameter("mac");
							String brightness = request.getParameter("brightness");
							
							try{
								sql = "select * from [dbo].[Airble_State_TB] where Airble_Device_FK = '" + mac + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									sql = "update [dbo].[Airble_State_TB] set Airble_Brightness = '" + brightness + "' where Airble_Device_FK = '" + mac + "'";
									stmt.executeUpdate(sql);
									out.print("[][S472]");	//  성공 - Success 472
									
								}else{
									out.print("[][F472]");	//  실패 - Fail 472
								}
							}catch(Exception e){
								out.print("[][E472]");	// 실패 - Error 472 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E472]");	// 실패 - Error 472 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 473: // 기기의 현제위치 변경
					{
						try{
							String mac = request.getParameter("mac");
							String division_1 = request.getParameter("division_1");
							String division_2 = request.getParameter("division_2");
							String division_3 = request.getParameter("division_3");
							
							try{
								sql = "select * from [dbo].[Airble_State_TB] where Airble_Device_FK = '" + mac + "'";
								rs = stmt.executeQuery(sql);
								if(rs.next()){
									
									sql = "update [dbo].[Airble_State_TB] set "
										+ "Airble_Place_Code = (select Air_Data_PK from [dbo].[Air_Data_TB] where Division_1 = '" + division_1 + "' and Division_2 = '" + division_2 + "' and Division_3 = '" + division_3 + "') "
										+ "where Airble_Device_FK = '" + mac + "'";
									System.out.println(sql);	// 실패 - Error 473 ( 데이터베이스 문제 )
									
									stmt.executeUpdate(sql);
									out.print("[][S473]");	//  성공 - Success 473
									
								}else{
									out.print("[][F473]");	//  실패 - Fail 473
								}
							}catch(Exception e){
								out.print("[][E473]");	// 실패 - Error 473 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E473]");	// 실패 - Error 473 ( 데이터 받아오기 실패 )
						}
					}
					break;
					
					case 48: // 상시 백그라운드에서 데이터 받기
					{
						try{
							String email = request.getParameter("email");
							
							try{

								sql = "select c.Airble_NickName, iif(a.Airble_Device_FK = b.Airble_Device_FK, Airble_CO, 0 ) as Airble_CO, "
										+ "iif(a.Airble_Device_FK = b.Airble_Device_FK, Airble_CO2, 0 ) as Airble_CO2, "
										+ "iif(a.Airble_Device_FK = b.Airble_Device_FK, Airble_VOC, 0 ) as Airble_VOC, "
										+ "iif(a.Airble_Device_FK = b.Airble_Device_FK, Airble_Dust, 0 ) as Airble_Dust "
										+ "from [dbo].[Airble_Real_Time_TB] as a right join [dbo].[Airble_User_Device_TB] as b on a.Airble_Device_FK = b.Airble_Device_FK "
										+ "join [dbo].[Airble_Device_TB] as c on b.Airble_Device_FK = c.Airble_Device_PK "
										+ "where Airble_User_FK = (select Airble_User_PK from [dbo].[Airble_User_TB] where User_Email = '" + email + "')";

								System.out.println(sql);	
								rs = stmt.executeQuery(sql);
							
								while(rs.next()){
									String nickname = rs.getString("Airble_NickName");
									int co = rs.getInt("Airble_CO");
									int co2 = rs.getInt("Airble_CO2");
									int voc = rs.getInt("Airble_VOC");
									int pm = rs.getInt("Airble_Dust");
									SendMessage += ",," + nickname + "," + voc + "," + co2 + "," + co + "," + pm;
								}
								
								if(SendMessage.trim().equals("")){
									out.print("[][F48]");	//  실패 - Fail 473
								}else{
									out.print("[][S48]" + SendMessage);	//  성공 - Success 473
								}
								
							}catch(Exception e){
								out.print("[][E48]");	// 실패 - Error 473 ( 데이터베이스 문제 )
							}
						}catch(Exception e){
							out.print("[][E48]");	// 실패 - Error 473 ( 데이터 받아오기 실패 )
						}
					}
					break;
					

					
					/*
					case 2:
					{
						try{
							String mac = request.getParameter("mac");
							String ssid = request.getParameter("ssid");
							String fine_dust = request.getParameter("fine_dust");
							String co = request.getParameter("co");
							String co2 = request.getParameter("co2");
							String vocs = request.getParameter("vocs");
							String temp = request.getParameter("temp");
							String humi = request.getParameter("humi");
							String wifi_ssid = request.getParameter("wifi_ssid");
							
							sql = "select * from airble_test_db where mac = '" + mac + "'";
							rs = stmt.executeQuery(sql);
							if(rs.next()){
								sql = "update airble_test_db set "
										+ "ssid = '" + ssid + "', "
										+ "fine_dust = " + fine_dust + ", "
										+ "co = " + co + ", "
										+ "co2 = " + co2 + ", "
										+ "vocs = " + vocs + ", "
										+ "temp = " + temp + ", "
										+ "humi = " + humi + ", "
										+ "wifi_ssid = '" + wifi_ssid + "' "
										+ "where mac = '" + mac + "'";
								stmt.executeUpdate(sql);		
										
							}else{
								sql = "insert into airble_test_db values('"
										+ mac + "','"
										+ ssid + "',"
										+ fine_dust + ","
										+ co + ","
										+ co2 + ","
										+ vocs + ","
										+ temp + ","
										+ humi + ",'"
										+ wifi_ssid + "')";
								stmt.executeUpdate(sql);
								
							}
							System.out.println(sql);
						}catch(Exception e){
							//out.print("1234");
							System.out.println(sql);
						}
					}
					break;
	
					
					case 11: // 매장 등록
					{
						try {
							String spot_passwd = request.getParameter("spot_passwd");
							String spot_name = request.getParameter("spot_name");
							String spot_classify = request.getParameter("spot_classify");
							String spot_zipcode = request.getParameter("spot_zipcode");
							String spot_address1 = request.getParameter("spot_address1");
							String spot_address2 = request.getParameter("spot_address2");
							double spot_lati = Double.parseDouble(
									String.format("%.7f", Double.parseDouble(request.getParameter("spot_lati"))));
							double spot_long = Double.parseDouble(
									String.format("%.7f", Double.parseDouble(request.getParameter("spot_long"))));
	
							sql = "insert into spot values('S'||to_char(sysdate,'yyyy')||lpad(spot_seq.nextval,4,'0'),'"
									+ spot_passwd + "','" + spot_name + "'," + spot_classify + "," + spot_zipcode + ",'"
									+ spot_address1 + "','" + spot_address2 + "', " + spot_lati + ", " + spot_long + ")";
			
							System.out.println(sql);
							stmt.executeUpdate(sql);
	
							sql = "select * from spot where spot_passwd = '" + spot_passwd + "' and spot_name = '"
									+ spot_name + "' and spot_lati = " + spot_lati + " and spot_long = " + spot_long
									+ " order by spot_code desc";
	
							rs = stmt.executeQuery(sql);
							rs.next();
							System.out.println(sql);
	
							out.print("111/" + rs.getString("spot_code"));
							rs.close();
	
						} catch (Exception e) {
							out.print("112");
						}
					}
					break;
	
					case 12: // 매장정보 불러오기
					{
	
						String spot_code = request.getParameter("spot_code");
						String spot_passwd = request.getParameter("spot_passwd");
						sql = "select * from spot where spot_code = '" + spot_code + "'";
						rs = stmt.executeQuery(sql);
						if (rs.next()) {
	
							if (spot_passwd.equals(rs.getString("spot_passwd"))) {
	
								String spot_name = rs.getString("spot_name");
								int spot_classify = rs.getInt("spot_classify");
								int spot_zipcode = rs.getInt("spot_zipcode");
								String spot_address1 = rs.getString("spot_address1");
								String spot_address2 = rs.getString("spot_address2");
								double spot_lati = rs.getDouble("spot_lati");
								double spot_long = rs.getDouble("spot_long");
			
								//			0	매장명		/		1  분류			/		2 우편번호		/		3 기본주소		/ 		4 상세주소 		/		5 lati		/	6 long	
								SendMessage = "121//" + spot_name + "/" + spot_classify + "/" + spot_zipcode + "/" + spot_address1
										+ "/" + spot_address2 + "/" + spot_lati + "/" + spot_long; // 각 변수들은 '/' 로 구분
								out.print(SendMessage);
	
							} else {
								out.print("122");
							}
						} else {
							out.print("122");
						}
						rs.close();
		
					}
					break;
	
					case 13: // 매장  수정
					{
						try {
							String spot_code = request.getParameter("spot_code");
							String spot_name = request.getParameter("spot_name");
							String spot_classify = request.getParameter("spot_classify");
							String spot_zipcode = request.getParameter("spot_zipcode");
							String spot_address1 = request.getParameter("spot_address1");
							String spot_address2 = request.getParameter("spot_address2");
							double spot_lati = Double.parseDouble(
									String.format("%.7f", Double.parseDouble(request.getParameter("spot_lati"))));
							double spot_long = Double.parseDouble(
									String.format("%.7f", Double.parseDouble(request.getParameter("spot_long"))));
		
							String new_passwd = request.getParameter("new_passwd");
		
							if (new_passwd.length() == 0) {
								sql = "update spot set spot_name = '" + spot_name + "', spot_classify = " + spot_classify
										+ ", spot_zipcode = " + spot_zipcode + ", spot_address1 = '" + spot_address1
										+ "' , spot_address2 = '" + spot_address2 + "', spot_lati = '" + spot_lati
										+ "', spot_long = '" + spot_long + "' where spot_code = '" + spot_code + "'";
	
							} else {
								sql = "update spot set spot_passwd = '" + new_passwd + "', spot_name = '" + spot_name
										+ "', spot_classify = " + spot_classify + ", spot_zipcode = " + spot_zipcode
										+ ", spot_address1 = '" + spot_address1 + "' , spot_address2 = '" + spot_address2
										+ "', spot_lati = '" + spot_lati + "', spot_long = '" + spot_long
										+ "' where spot_code = '" + spot_code + "'";
	
							}
	
							stmt.executeUpdate(sql);
							out.print("131");
						} catch (Exception e) {
							out.print("132");
						}
					}
					break;
					
					*/
	
			// 삭제는 보류
			/*
			case 14 :		//매장 정보 삭제
			{
				String member_id = request.getParameter("member_id");
				String member_pwd  = request.getParameter("member_pwd");
				sql = "select * from androidpj_member where member_id = '" + member_id + "'";
				rs = stmt.executeQuery(sql);
				rs.next();
				if(member_pwd.equals(rs.getString("member_pwd"))){
					sql = "delete androidpj_member where member_id = '" + member_id + "'";
					stmt.executeUpdate(sql);
					out.print("회원탈퇴가 완료 되었습니다.");
				}else{
					out.print("비밀번호가 틀렸습니다.");
				}
				rs.close();
			}
			break;
			*/
			
	
					default:
						out.print("등록된 코드가 없는대요? : 받은 코드값  = " + recvNum);
						break;
					}
					try{
						rs.close();
					}catch(Exception e){
						
					}
					stmt.close();
					conn.close();
				} catch (Exception e) {
					out.print("에러코드 : " + recvNum);
				}
			} catch (Exception e) {
		System.out.print("오라클  Select 오류!");
			}
		} catch (Exception e) {
			System.out.print("오라클 연동 실패!");
		}
	} catch (Exception e) {
		System.out.print("서버 및 오라클 오류!");
	} finally {
	
	}
%>
