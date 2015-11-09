import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;

import battleship.BattleBoardPanel;
import battleship.BattleshipDialog;
import battleship.Constants;
import battleship.model.BattleBoard;
import battleship.model.Place;

//From Battleshipdialog
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

privileged aspect InterfaceExtension{
	
	JPanel content;
	BattleBoard battleBoard;
	boolean press = false;
	Graphics g;
	boolean x = false;
	JLabel msgBar;
			//= new JLabel("Shots: 0");
	int i = 0;

	pointcut revealedShip():
		execution (JPanel battleship.BattleshipDialog.makeControlPane());
	
	JPanel around(): revealedShip(){
		JPanel content = proceed();
		//Original
		JPanel button = (JPanel)content.getComponent(0);
		JButton originalPlay = (JButton)button.getComponent(0);
		JButton newPlay = new JButton("Play");
//		newPlay.addActionListener(new ActionListener(){
//			public void actionPerformed(ActionEvent e){
//				System.out.println("hello");
//
//			}
//		});
		newPlay.addActionListener(originalPlay.getActionListeners()[0]);
		button.add(newPlay);
		
		originalPlay.setLabel("Practice");
		
		button.addKeyListener(new KeyListener(){
			public void keyReleased(KeyEvent e) {
				//116 = F5

				if(e.getKeyCode()==116){
					if(!press){
						System.out.println("True");
						press=true;
					}
					else{
						System.out.println("False");
						press=false;
						}
					}
			}
			public void keyPressed(KeyEvent e) {
				System.out.println("Inside Key Press");
			}
			public void keyTyped(KeyEvent e) {}
		});
		button.setFocusable(true);
		button.requestFocus();
		this.content = content;
		return content;
	}
/*
 * This is method would help to get the latest BattleBoard,
 * any time the BattleBoard class it would save the latest BattleBoard.
 */

	after(BattleBoard board): this(board) && (call(*.BattleBoard*.new(..))||
	preinitialization(*BattleBoard*.new(..)) ||
	initialization(*BattleBoard*.new(..)) ||
	execution(*BattleBoard*.new(..))){
		this.battleBoard = board;
	}
	/*
	 *This method is the one that shows where the ships are in the board
	 *Would be perform if the F5 key is press. It is done by a boolean statement. 
	 */
	after(Graphics g):args(g)&& execution(void battleship.BattleBoardPanel.drawPlaces(..)){
		if(press){
			int leftMargin = Constants.DEFAULT_LEFT_MARGIN;
			int topMargin = Constants.DEFAULT_TOP_MARGIN;
			int placeSize = Constants.DEFAULT_PLACE_SIZE;
				for (Place p: battleBoard.places()) {
		        	int x = leftMargin + (p.getX() - 1) * placeSize;
	    		    int y = topMargin + (p.getY() - 1) * placeSize;
	    		    if(!(p.isEmpty())){
	    		    	g.setColor(new Color(255,255,0));
		        		g.drawRect(x, y, placeSize, placeSize);
		        	}
		    	}

			}
		this.g=g;
	}
//	pointcut playButton():
//			execution (void battleship.BattleshipDialog.startNewGame());
//	before(JLabel msgBar,BattleBoard board ):args(msgBar, board) && playButton(){
//		this.msgBar.setText("Shots: 15");
//	}
//	before(BattleBoard board): this(board) && (call(*.BattleBoard*.new(..))||
//			preinitialization(*BattleBoard*.new(..)) ||
//			initialization(*BattleBoard*.new(..)) ||
//			execution(*BattleBoard*.new(..))){
//			this.battleBoard = new BattleBoard(10);
//	}
	private void playButtonClicked() {
		System.out.println("puto");
	}
}