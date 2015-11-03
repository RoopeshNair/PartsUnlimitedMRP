import org.junit.After;
import org.junit.Before;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

import java.util.concurrent.TimeUnit;
import java.util.Date;
import java.io.File;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.*;
import static org.openqa.selenium.OutputType.*;

public class QuotesSeleniumTest {
    FirefoxDriver wd;
    
    @Before
    public void setUp() throws Exception {
        wd = new FirefoxDriver();
        wd.manage().timeouts().implicitlyWait(60, TimeUnit.SECONDS);
    }
    
    @Test
    public void QuotesSeleniumTest() {
        wd.get("http://pumrpvm1.cloudapp.net:9080/mrp/");
        wd.findElement(By.cssSelector("label")).click();
        if (!wd.findElement(By.id("nav-trigger")).isSelected()) {
            wd.findElement(By.id("nav-trigger")).click();
        }
        wd.findElement(By.cssSelector("#element__3 > div.win-navbarcommand-button-content > div.win-navbarcommand-label")).click();
        wd.findElement(By.id("comments")).click();
        wd.findElement(By.id("comments")).clear();
        wd.findElement(By.id("comments")).sendKeys("Quotes recieved");
    }
    
    @After
    public void tearDown() {
        wd.quit();
    }
    
    public static boolean isAlertPresent(FirefoxDriver wd) {
        try {
            wd.switchTo().alert();
            return true;
        } catch (NoAlertPresentException e) {
            return false;
        }
    }
}
