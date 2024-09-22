package edu.wofford;

import javax.swing.*;

public class GuiMain extends JFrame {
	// This class should BE the window.
  // There's no reason to modify the main() method here,
  // because it isn't used by the acceptance tests.
  // Do NOT set the default close operation. That is already
  // being handled by the main() method, and doing it anywhere
  // else will break the acceptance tests.


  public static void main(String[] args) {
	  GuiMain window = new GuiMain();
    window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    window.setVisible(true);
  }

}