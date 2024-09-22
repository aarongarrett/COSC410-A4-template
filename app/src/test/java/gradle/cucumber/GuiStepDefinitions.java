package gradle.cucumber;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import io.cucumber.java.en.Then;
import io.cucumber.java.Before;
import io.cucumber.java.After;

import static org.junit.jupiter.api.Assertions.*;
import static org.hamcrest.MatcherAssert.assertThat; 
import static org.hamcrest.Matchers.*;

import org.assertj.swing.edt.GuiActionRunner;
import org.assertj.swing.edt.GuiQuery;
import org.assertj.swing.fixture.*;
import org.assertj.swing.image.ScreenshotTaker;

import java.io.*;
import java.util.*;
import javax.swing.JButton;
import edu.wofford.GuiMain;


public class GuiStepDefinitions {
    private List<String> actual;
    private List<String> expected;
    private FrameFixture window;
    private static int testNumber = 0;
    private static boolean dunit = false;
    private static File SCREENSHOT_DIRECTORY = new File(
        "build" + File.separator + 
        "reports" + File.separator + 
        "cucumber" + File.separator + 
        "screenshots"
    );


    private FrameFixture getFrameFixture() {
        GuiMain frame = GuiActionRunner.execute(new GuiQuery<GuiMain>() {
            protected GuiMain executeInEDT() {
                GuiMain gm = new GuiMain();
                gm.setVisible(true);
                return gm;
            }
        });
        return new FrameFixture(frame);
    }

    private static void rmdir(File file) {
        File[] list = file.listFiles();
        if (list != null) {
            for (File temp : list) {
                rmdir(temp);
            }
        }
        file.delete();
    }

    @Before
    public void beforeAll() {
        if(!dunit) {
            Runtime.getRuntime().addShutdownHook(new Thread() {
                public void run() { }
            });
            
            if (SCREENSHOT_DIRECTORY.exists()){
                rmdir(SCREENSHOT_DIRECTORY);
            }
            SCREENSHOT_DIRECTORY.mkdirs();
            //window = getFrameFixture();
            //window.close();
            //window.cleanUp();
            dunit = true;
        }
    }


    @Given("the window is open")
    public void the_window_is_open() {
        testNumber++;
        window = getFrameFixture();
        window.robot().settings().delayBetweenEvents(10);
        window.robot().settings().eventPostingDelay(20);
        window.robot().waitForIdle();

        actual = new ArrayList<>();
        expected = new ArrayList<>();
    }

    @Given("the player clicks  {int}  {int}")
    public void the_player_clicks(Integer int1, Integer int2) {
        window.button("location" + int1 + "" + int2).click();
    }

    @When("the player views the window")
    public void the_player_views_the_window() { }

    @Then("the button {int} {int} should be marked {string}")
    public void the_button_should_be_marked(Integer int1, Integer int2, String string) {
        expected.add(string);
        actual.add(window.button("location" + int1 + "" + int2).text());
    }

    @Then("the result label should say {string}")
    public void the_result_label_should_say(String string) {
        expected.add(string);
        actual.add(window.label("result").text());
    }

    @Then("the window should close")
    public void the_window_should_close() {
        ScreenshotTaker screenshotTaker = new ScreenshotTaker();
        java.awt.image.BufferedImage screenshot = screenshotTaker.takeScreenshotOf(window.target());
        window.close();
        window.cleanUp();

        try {
            for (int i = 0; i < expected.size(); i++) {
                assertThat(actual.get(i), is(expected.get(i)));
            }
        } catch (AssertionError e) {
            if (!SCREENSHOT_DIRECTORY.exists()){
                SCREENSHOT_DIRECTORY.mkdirs();
            }
            String imgPath = SCREENSHOT_DIRECTORY.getPath() + File.separator + String.format("%03d", testNumber) + ".png";
            System.out.println("A screenshot of the error has been saved at " + imgPath);
            screenshotTaker.saveImage(screenshot, imgPath);
            throw e;
        }
    }

}