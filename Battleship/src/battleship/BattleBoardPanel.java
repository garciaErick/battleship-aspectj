// $Id: PuzzlePanel.java,v 1.1 2014/12/01 00:33:19 cheon Exp $

package battleship;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JPanel;

import battleship.model.BattleBoard;
import battleship.model.Place;
import static battleship.Constants.*;

/**
 * A special panel to display a battle board modeled by the
 * {@link BattleBoard} class. A battle board is displayed as a 2D grid of 
 * square cells. 
 * 
 * <pre>
 *  +--------------
 *  |    TM         
 *  |   +---+---+-- 
 *  |LM |PS |   |   ...
 *  |   +---+---+--
 *  |       ...
 * </pre>
 *
 * @see BattleBoard
 * @author Yoonsik Cheon
 * @version $Revision: 1.1 $
 */
@SuppressWarnings("serial")
public class BattleBoardPanel extends JPanel {

    /**
     * Height of the blank space above the board panel in pixel. It is 10 by
     * default.
     */
    protected final int topMargin;

    /**
     * Width of the blank space left of the board panel in pixel. It is 10 by
     * default.
     */
    protected final int leftMargin;

    /**
     * Number of pixels between horizontal/vertical lines of the board panel to
     * present places. By default, it is 30.
     */
    protected int placeSize;

    /**
     * Number of rows/columns of the battleship board. The board will have
     * <code>boardSize x boardSize</code> places.
     */
    protected int boardSize;

    /** Background color of the board. It's blue by default. */
    protected Color boardColor;

    /** Color for drawing places that are hit and have a ship. */
    protected final Color hitColor;

    /** Color for drawing places that are hit but have no ship. */
    protected final Color missColor;

    /** Foreground color for drawing 2-d grid lines for board and places. */
    protected final Color lineColor = DEFAULT_LINE_COLOR;

    /** Puzzle board to be displayed by this panel. */
    protected final BattleBoard battleBoard;

    /** Create a new panel to display the given battle board. */ 
    public BattleBoardPanel(BattleBoard battleBoard) {
    	this(battleBoard, 
    	    DEFAULT_TOP_MARGIN, DEFAULT_LEFT_MARGIN, DEFAULT_PLACE_SIZE,
    	    DEFAULT_BOARD_COLOR, DEFAULT_HIT_COLOR, DEFAULT_MISS_COLOR);
    }
    
    /** Create a new panel to display the given battle board
     * with the provided visual specification. */ 
    public BattleBoardPanel(BattleBoard battleBoard,
            int topMargin, int leftMargin, int placeSize,
            Color boardColor, Color hitColor, Color missColor) {
    	this.battleBoard = battleBoard;
    	this.boardSize = battleBoard.size();
    	this.topMargin = topMargin;
    	this.leftMargin = leftMargin;
    	this.placeSize = placeSize;
    	this.boardColor = boardColor;
    	this.hitColor = hitColor;
    	this.missColor = missColor;
        addMouseListener(new MouseAdapter() {
            public void mouseClicked(MouseEvent e) {
                Place p = locatePlace(e.getX(), e.getY());
                if (p != null) {
                    placeClicked(p);
                }
            }
        });
    }
    
    /** To be called when a place is clicked. If not all ships are sunk,
     * and the place is not already hit, hit the place. 
     * 
     * @param place Place that was clicked. Note the game may be over
     *  or the place may already been hit.
     */
    private void placeClicked(Place place) {
        if (!battleBoard.isGameOver() && !place.isHit()) {
            place.hit();
            repaint();                	
        }
    }
    
    /** Given a position on the screen, locate the corresponding place
     * of the battle board; if it doesn't correspond to any place of the
     * board, return null. 
     * 
     * @param x X-coordinate of the screen
     * @param y Y-coordinate of the screen
     * @return Place corresponding to the given screen position; null
     *  if the screen position doesn't correspond to any place in a battle
     *  board.
     */
    private Place locatePlace(int x, int y) {
        //
        // +--------------
        // |    TM
        // |   +---+---+-- 
        // |LM |TS |   |   
        // |   +---+---+--
        //
        int ix = (x - leftMargin) / placeSize;
        int iy = (y - topMargin)  / placeSize;
        if (x > leftMargin && y > topMargin
            && ix < boardSize && iy < boardSize) {
            return battleBoard.at(ix + 1, iy + 1);
        }
        return null;
    }
    
    /** Overridden here to draw the current state of the battle board. 
     * This method will draw a 2-d grid representation of the board. */
    @Override
    public void paint(Graphics g) {
        super.paint(g); // clear the background
        drawGrid(g);
        drawPlaces(g);
    }

    /** Draw a 2D grid representing a battle board of 
     * <code>boardSize x boardSize</code> places. Both horizontal and
     * vertical lines are spaced <code>placeSize</code> pixels. */
    private void drawGrid(Graphics g) {
        Color oldColor = g.getColor(); 

        // fill the background of the frame.
		final int frameSize = boardSize * placeSize;
        g.setColor(boardColor);
        g.fillRect(leftMargin, topMargin, frameSize, frameSize);
        
        // draw vertical and horizontal lines
        g.setColor(lineColor);
        int x = leftMargin;
        int y = topMargin;
        for (int i = 0; i <= boardSize; i++) {
            g.drawLine(x, topMargin, x, topMargin + frameSize);
            g.drawLine(leftMargin, y, leftMargin + frameSize, y);
            x += placeSize;
            y += placeSize;
        }

        g.setColor(oldColor);
    }

    /** Draw the places that are hit. */
    private void drawPlaces(Graphics g) {
        final Color oldColor = g.getColor();
        for (Place p: battleBoard.places()) {
    		if (p.isHit()) {
    		    int x = leftMargin + (p.getX() - 1) * placeSize;
    		    int y = topMargin + (p.getY() - 1) * placeSize;
    		    g.setColor(p.isEmpty() ? missColor : hitColor);
    		    g.fillRect(x + 1, y + 1, placeSize - 1, placeSize - 1);
    		}
        }
        g.setColor(oldColor);
    }

}
