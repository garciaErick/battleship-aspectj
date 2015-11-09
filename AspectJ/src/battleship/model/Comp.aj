//package battleship.model;
//
//import java.awt.Color;
//import java.awt.event.KeyEvent;
//import java.awt.event.KeyListener;
//import javax.swing.JPanel;
//
//import battleship.BattleBoardPanel;
//import battleship.BattleshipDialog;
//import java.awt.event.MouseEvent;
//import java.lang.reflect.Field;
//import java.lang.reflect.Method;
//import java.util.List;
//import java.util.Random;
//
//import javax.swing.JButton;
//
//
//
//privileged aspect Comp {
//
//		
//	//DILOG WINDOWS FOR THE LAYER AND THE CCOMPUTER PLAYER
//	BattleshipDialog player,comp;
//	
//	//CHECK THE "STATES" OF THE GAME. IS ONE IF YOU YOU CLICK THE PLAYER BOTON IS 0 IF YOU CHOSE PRACTICE
//	int window = 0;
//	
//	//KEEP TRACK THE F15 KEY OF THE BOARD IF IS 1 IS GOING TO REVEAL THE SHIPS IF IS 0 IS GOING TO HIDE THEM
//	//(IS MESING THE HIDSHIPS FINCTOIN)
//	int toggle = 0;
//	
//	//THE PANEL OF THE PLAYER WINDOW TO CAN CALL THE REPAIN() METHOD AND UPDATE THE GRAPHICS
//	JPanel panel1=null;
//	//THE PANEL OF THE PLAYER WINDOW TO CAN CALL THE REPAIN() METHOS AND UPDATE THE GRAPHICS
//	JPanel panel3=null;
//	//KEEP TRACK THE TURN OF THE PLAYERS
//	public int turn = 0;
//	
//	
//	//F15 LISTENER
//	KeyListener listener = new KeyListener(){
//	
//		@Override
//		public void keyPressed(KeyEvent arg0) {
//			
//			
//		}
//
//		@Override
//		public void keyReleased(KeyEvent e) {
//			// TODO Auto-generated method stub
//			
//		}
//
//		@Override
//		public void keyTyped(KeyEvent e) {
//			// TODO Auto-generated method stub
//		}
//		
//		
//	};
//	
//	//THI POINT WILL BE WAITING FOR THE IF THE PLAY BUTTON IS CLICKED
//	pointcut display():
//		execution(void battleship.BattleshipDialog.playButtonClicked(..));
//	
//	//THIS POINT WILL BE WAITING FOR THE METHOD THAT CREATES THE BUTTONS
//	//IN THE DIALOG WINDOW
//	pointcut addButton():
//		execution(JPanel battleship.BattleshipDialog.makeControlPane());
//
//	//IS GOING TO WAIT FOR THE MAIN METHOD AND IS GOING TO CREATE THE PLAYER DIALOOG
//		void around():execution(void battleship.BattleshipDialog.main(..)){
//			player = new BattleshipDialog();
//	        player.setVisible(true);
//	        player.addKeyListener(listener);
//	        //STATE IS 1
//			window = 1;
//			
//		}
//	
//
//	//WAITING FOR THE MWETHOD THAT WILL CREATE THE BOARD IN THE DIALOG WINDOW
//	JPanel around():execution(JPanel makeBoardPane(..)){
//		BattleshipDialog dialog = (BattleshipDialog)thisJoinPoint.getThis();//GET THE NAMES OF THE INSTANCIATES OF
//																			//THE BattleshipDialog OBJECT THAT HAVE
//																			//BEEN INSTANTIATED
//		
//		JPanel panel = proceed();//GET THE BOARD PANEL THAT THIS POINTCUT RETURNS
//		
//		//IF THE NAME OF THE BattleshipDialog INSTANCE IS dialog1 IST MEANS THAT IS THE
//		//INSTANCE OF THE PLAYER DIALOG WINDOW IF IS dialog2 IS MEANS IS THE COMPUTER DIALOG WINDOW
//		if(dialog.getName().equals("dialog1")){
//			panel1 = panel;//GET THE PANEL OF THE PLAYER WINDOW
//		
//			
//			//panel3 = panel;
//		}else if(dialog.getName().equals("dialog2")){
//			panel3 = panel;//GET THE PANEL OF THE COMPUTER WINDOW
//			
//		}
//
//		return panel;
//	}
//	
//	//ADD THE BUTTONS TO THE CORRESPONDING WINDOWS 
//	JPanel around():addButton(){
//		BattleshipDialog dialog = (BattleshipDialog)thisJoinPoint.getThis();//GET THE NAMES OF THE INSTANCIATES OF
//																			//THE BattleshipDialog OBJECT THAT HAVE
//																			//BEEN INSTANTIATED
//		
//		JPanel content = proceed();
//		//IS THE STATE IS 0 WE ARE GOOING TO ADD THE PLAY BUTTON TO THE DIALOG WINDOW
//		if(window == 0){
//			
//		JPanel button = (JPanel)content.getComponent(0);//GET THE PANEL AT THE POSITION 0 OF THE DIALOG WINDOW
//		JButton buton = (JButton)button.getComponent(0);//GET THE BUTON AT THE POSITINO 0 OF THE PANEL AT
//														//POSITION 0
//		JButton buton2 = new JButton("Play");//CREATE NEW BUTTON
//		buton2.addActionListener(buton.getActionListeners()[0]);//ADD LISTENER TO THE NEW BUTTON
//		buton.addKeyListener(listener);//ADD KEY LISTENER TO THE PRACTICE BUTTON
//		button.add(buton2);//ADD NEW BUTTON TO THE DIALOG WINDOW
//		
//		buton.setLabel("Practice");//RENAME THE BUTTON TO PRACTICE
//
//		//IF THE STATE IS 1
//		}else{
//			
//			
//			JPanel button = (JPanel)content.getComponent(0);//GET THE PANEL AT THE POSITION 0 OF THE DIALOG WINDOW
//			JButton buton = (JButton)button.getComponent(0);//GET THE BUTON AT THE POSITINO 0 OF THE PANEL AT
//															//POSITION 0
//			JButton buton2 = new JButton("Play");//ADD PLAY BUTON
//			buton2.addActionListener(buton.getActionListeners()[0]);//ADD LISTENER
//			buton2.addKeyListener(listener);//ADD KEY LISTENER
//			button.add(buton2);//ADD THE BUTTON TO THE DIALOG WINDOW
//			button.remove(0);//REMOVE THE PRACTICE BUTTON
//			
//			//IS THE DIALOG WINDOW IS FOR THE CIOMPUTER
//			if(dialog.getName().equals("dialog2")){
//				button.remove(0);//REMOVE PLAY BUTTON
//				
//			}
//	
//		}
//		
//		return content;
//	}
//	
//	//CHECKS WICH PLACE WAS CLICKED AND LOOK FOR IT THE OPONENT WINDOW TO DISPLAY THE HIT THE OTHER WINDOW
//	//NOTE: IT HAS AN ERROR THAT I AM TRYING TO FIX XD, AND IT USES REFLECTION TO GET THE PRIVATE FIELDS AND
//	//METHODS OF THE PLAYER AND COMPUTER INSTANCES
//	void sendHid(Place place,BattleshipDialog dialog){
//		try{
//			
//			//GET THE BOARD OF THE DIALOG WINDOW
//			Field b = dialog.getClass().getDeclaredField("board");
//			b.setAccessible(true);//GET ACCESS
//			BattleBoard board = (BattleBoard) b.get(comp);
//			
//			//GET THE LIST OF PLACES
//			Field p =  board.getClass().getDeclaredField("places");
//			p.setAccessible(true);//GET ACCESS
//			 List<Place> places = (List<Place>)p.get(board);
//			 
//			 //ITERATE OVER THE PACES AND CHECK WHICH PLACE WAS HIT
//			 for(int i=0;i<places.size();i++){
//				 Place placehit =places.get(i);
//				 //IF THE PLACE EQUALS THE POSITION CLICKED
//				 if(placehit.getX() == place.getX() && placehit.getY() == place.getY()){
//					 placehit.hit();//SET TO HIT
//					 place.hit();
//				    	panel1.repaint();//CALL REPAINT METHODS TO UPDATE THE GRAPHICS
//				    	panel3.repaint();
//				    	
//				    	//THIS PAST IS NOT COMPLETE AND HAS ERRORS
//				    	//IS FOR CHECK IF THE PLACES CLICKED HAD A SHIP AND SET WHO IS THE NEXT PLAYER
//				    	if(turn == 0){
//				    		if(placehit.hasShip() == false){
//				    			turn = 1;
//				    		}
//				    	}else{
//				    		if(placehit.hasShip() == false){
//				    			turn = 0;
//				    		}else{
//				    			
//				    				
//				    		}
//				    		
//				    	}
//				    	
//				 }}
//
//			 
//			
//			
//			
//			 
//			 
//		}
//		catch(NoSuchFieldException e){}
//		catch(SecurityException e){}
//		catch(IllegalArgumentException e){}
//		catch(IllegalAccessException e){}
//    	
//		
//	}
//	
//	//WAITS IF A PLACES WAS CLICKED AND CALLS THE SENHIT() AND STRATEGY() METHODS
//	 void around(Place place):args(place) && execution(void placeClicked(..)){
//		 sendHid(place,comp);
//		 strategy();
//	    	
//	    }
//	 //WAITS FOR THE FUNCTION THAT CREATES THE BOARD
//	JPanel around():execution(JPanel battleship.BattleshipDialog.makeBoardPane()){
//		BattleshipDialog dialog = (BattleshipDialog)thisJoinPoint.getThis();//GET THE NAMES OF THE INSTANCIATES OF
//																			//THE BattleshipDialog OBJECT THAT HAVE
//																			//BEEN INSTANTIATED
//		
//		//CRATE NEW BOARD WITH DIFFERENT BLUE COLOR JUST TO DIFFERENCIATE WICH IS THE PLAYER AND THE COMPUTER
//		JPanel compBoard = new BattleBoardPanel(new BattleBoard(10),10,10,30 ,new Color(102, 255, 255), Color.RED,Color.GRAY);
//		
//		//IS THE DIALOG IS THE COMPUTER THEN SET THE NEW BOARD WITH A DIFFERENT BLUE COLOR
//		if(dialog.getName().equals("dialog2")){
//		return compBoard;	
//		}
//		
//		return proceed();
//		
//	}
//	
//	//WAITS FOR THE BUTTON PLAY IS CLICKED AND CREAYES THE PLAYER AND COMPUTER 
//	after():display(){
//		window = 1;
//		//CLOSE DEFAULT WINDOW
//		player.dispose();
//		//CREATES PLAYER WINDOW
//		player = new BattleshipDialog();
//		player.addKeyListener(listener);
//		player.setVisible(true);
//		player.setLocation(200, 150);
//		
//		//CREATES COMPUTER WINDOW
//		comp = new BattleshipDialog();
//		comp.setVisible(true);
//		comp.setLocation(600, 150);
//		
//		//THIS IS NOT COMPLETE
//		try{
//			Field b = comp.getClass().getDeclaredField("board");
//			b.setAccessible(true);
//			BattleBoard board = (BattleBoard) b.get(comp);
//			//board.removeBoardChangeListener(listener);
//			
//			 
//			 
//		}
//		catch(NoSuchFieldException e){}
//		catch(SecurityException e){}
//		catch(IllegalArgumentException e){}
//		catch(IllegalAccessException e){}
//		
//		
//		
//	}
//	
//	//WAITS FOR THE F15 KEY TO BE PRESSED
//	after():execution(void keyReleased(..)){
//		if(toggle == 0){
//			toggle=1;
//		}else{
//			toggle=0;
//		}
//		
//		//CALLS THE SHOWSHIIPS METHOD
//		showShips(player);
//		
//	}
//	
//	//STRATEGY IS JUST RANDOM LOL XD
//	public void strategy(){
//		Random rand = new Random();
//		int x = rand.nextInt(10) + 1;
//		int y =	rand.nextInt(10) + 1;
//		
//		
//		try{
//		
//			Field b = comp.getClass().getDeclaredField("board");//GET PRIVATE BOARD OF THE COMPUTER
//			b.setAccessible(true);//GET ACCESS
//			BattleBoard board = (BattleBoard) b.get(comp);
//			
//			Field p =  board.getClass().getDeclaredField("places");//GET PRIVATE PLACES OF THE COMPUTER
//			p.setAccessible(true);//GET ACCESS
//			 List<Place> places = (List<Place>)p.get(board);
//			
//			
//			//LOOKS WICH PLACE IS AT THE RANDO POSITION GENERATED
//			for(int i =0;i<places.size();i++){
//				Place tmp = places.get(i);
//				if(tmp.getX() == x && tmp.getY() == y){
//					//CALLS SENDHIt method
//				}
//					 sendHid(tmp,player);
//				}
//			
//			 
//		}
//		catch(NoSuchFieldException e){}
//		catch(SecurityException e){}
//		catch(IllegalArgumentException e){}
//		catch(IllegalAccessException e){}
//		
//		
//	
//		
//		
//	}
//	
//	//SHOW THE SHIPS IT HAS AN ERROR XD THAT NEEDS TO BE FIXED :X
//	public List<Place> showShips(BattleshipDialog dialog){
//		
//		
//		try{
//			Field b = dialog.getClass().getDeclaredField("board");//GET PRIVATE BOARD
//			b.setAccessible(true);//GET ACCESS
//			BattleBoard board = (BattleBoard) b.get(dialog);
//			
//			Field p =  board.getClass().getDeclaredField("places");//GET PRIVATE PLACES
//			p.setAccessible(true);//GET ACCESS
//			 List<Place> places = (List<Place>)p.get(board);
//			 
//			 //ITERATE OVER ALL THE PLACES AND IF HAS A SHIP SETHIT
//			 for(int i=0;i<places.size();i++){
//				 Place place =places.get(i);
//				 if(place.hasShip() == true){//IF THE PLACE HAS A SHIP
//					 	place.hit();//SETHIT
//				    	panel1.repaint(); //UPDATE GRAPHICS      
//					 
//				 }
//			 }
//			 
//			 
//		}
//		catch(NoSuchFieldException e){}
//		catch(SecurityException e){}
//		catch(IllegalArgumentException e){}
//		catch(IllegalAccessException e){}
//		return null;
//	}
//	
//	
//
//
//}
//
