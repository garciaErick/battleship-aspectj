import java.io.File;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.DataLine;

public aspect Sound {
	//Declaration of Global variables that will be used in all the code 
	boolean hasStarted = false;
	File hitSound = new File("Sounds/exclamation1.wav");
	File bgm = new File("Sounds/Rush.wav");
	File sunkenSound = new File("Sounds/You're Pretty Good.wav");
	File gameOverSound = new File("Sounds/You're Pretty Good Ocelot.wav");
	File fanfare = new File("Sounds/Fanfare.wav");
	Clip bgmClip;
	int shipSunk = 0;

	
	pointcut isHit():
		execution (void battleship.model.BattleBoard.notifyHit(..));
	after(): isHit(){
		if(hasStarted){
		playSound(hitSound, true);
		}
		else{
			//Play background music, boolean false so the clip wont stop
			bgm(bgmClip, false);
			//Play sound while closing the click to save resources
			playSound(hitSound, true);
		}
		hasStarted = true;
	
	}
	
	pointcut isSunken():
		execution (void battleship.model.BattleBoard.notifyShipSunk(..));
	after(): isSunken(){
		if(shipSunk != 4)
			playSound(sunkenSound, true);
		shipSunk++;
	}
	
	pointcut gameOver():
		execution (void battleship.model.BattleBoard.notifyGameOver(..));
	after(): gameOver(){
		playSound(gameOverSound, true);
		bgm(bgmClip, true);
	}
	
	public void playSound(File sound, boolean stop){
			try{
				AudioInputStream audio = AudioSystem.getAudioInputStream(sound);
				Clip clip = (Clip)AudioSystem.getLine(new DataLine.Info(Clip.class, audio.getFormat()));
				clip.open(audio);
				clip.start();
				//If we want the soundfile to stop after a certain time
				if(stop){
					new java.util.Timer().schedule( 
					        new java.util.TimerTask() {
					            @Override
					            //What will run after a certain time
					            public void run() {
					    		    clip.close();
					            }
					        }, 
					        5000 
					);
				}
			}
			catch(Exception e){
				System.out.println(e);
			}
		}
	
	public void bgm(Clip clip, boolean stop){
		try{
			if(!stop){
				AudioInputStream audio = AudioSystem.getAudioInputStream(bgm);
				bgmClip = (Clip)AudioSystem.getLine(new DataLine.Info(Clip.class, audio.getFormat()));
				bgmClip.open(audio);
				bgmClip.start();
			}
			else{
				System.out.println("You have won, You're pretty good ;)");
				//Stopping bgm
				bgmClip.stop();
				new java.util.Timer().schedule( 
				        new java.util.TimerTask() {
				            @Override
				            public void run() {
				            	playSound(fanfare, false);
				            }
				        }, 
				        3000 
				);
				
			}
			
		}
		catch(Exception e){
			System.out.println(e);
		}
	}
}
