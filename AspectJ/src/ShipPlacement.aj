import java.io.File;

import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.DataLine;

import battleship.model.Place;

public aspect ShipPlacement {
//	int i =0;
//	pointcut isHit():
//		execution (void battleship.BattleshipDialog.placeShips(..));
//	after(): isHit(){
//		System.out.println(i);
//		System.out.println("in ship placement.");
//		i++;
//	}
//	
//	public void playSound(File sound){
//		try{		
//			AudioInputStream audio = AudioSystem.getAudioInputStream(sound);
//			Clip clip = (Clip)AudioSystem.getLine(new DataLine.Info(Clip.class, audio.getFormat()));
//			clip.open(audio);
//			clip.start();
//			}
//			catch(Exception e){
//				System.out.println("File not found fam");
//			}
//	}


}