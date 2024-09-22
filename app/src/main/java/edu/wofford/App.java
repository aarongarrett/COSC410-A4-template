package edu.wofford;

public class App {
    public static void main(String[] args) {
	    if (args.length == 0) {
	        GuiMain.main(null);
	    } else {
	        ConsoleMain.main(null);
	    }
    }
}
