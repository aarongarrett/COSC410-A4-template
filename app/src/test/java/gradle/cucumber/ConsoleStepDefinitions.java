package gradle.cucumber;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.When;
import io.cucumber.java.en.Then;
import io.cucumber.java.Before;
import io.cucumber.java.After;

import static org.junit.jupiter.api.Assertions.*;
import static org.hamcrest.MatcherAssert.assertThat; 
import static org.hamcrest.Matchers.*;

import java.io.*;
import java.util.*;
import java.util.regex.*;
import edu.wofford.ConsoleMain;


public class ConsoleStepDefinitions {
    private String inputString;
    private String outputString;

    @Given("the game has started")
    public void the_game_has_started() {
        inputString = "";
        outputString = "";
    }

    @Given("the player marks  {int}  {int}")
    public void the_player_marks(Integer int1, Integer int2) {
        inputString += int1 + " " + int2 + "\n";
    }

    @When("the player views the board")
    public void the_player_views_the_board() {
        InputStream originalIn = System.in;
        PrintStream originalOut = System.out;
        try {
            System.setIn(new ByteArrayInputStream(inputString.getBytes()));
            ByteArrayOutputStream outContent = new ByteArrayOutputStream();
            System.setOut(new PrintStream(outContent));
            try {
                ConsoleMain.main(null);
            } catch (NoSuchElementException e) { }
            outputString = outContent.toString();
        } finally {
            System.setIn(originalIn);
            System.setOut(originalOut);
        }
    }

    private static String getLastGrid(String s) {
        String regex = "(?s).*[ XO]\\|[ XO]\\|[ XO]\\R-----\\R[ XO]\\|[ XO]\\|[ XO]\\R-----\\R[ XO]\\|[ XO]\\|[ XO]";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(s);
        String value = "";
        if (matcher.find()) {
            value = matcher.group().substring(matcher.end() - 29, matcher.end());
        }
        return value;
    }

    private static String getLocationAt(String s, int row, int col) {
        int charnum = row * 12 + col * 2;
        return s.substring(charnum, charnum + 1);
    }

    @Then("the location {int} {int} should be marked {string}")
    public void the_location_should_be_marked(Integer int1, Integer int2, String string) {
        String loc = getLocationAt(getLastGrid(outputString), int1, int2);
        assertThat(loc, is(string));
    }

    @Then("the game should end")
    public void the_game_should_end() { }

    @Then("the game result should be {string}")
    public void the_game_result_should_be(String string) {
        String s = outputString.trim();
        assertThat(s.substring(s.lastIndexOf("\n")), containsString(string));
    }

}