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
        wd.findElement(By.xpath("//div[@id='launchtiles']/button[2]")).click();
        wd.findElement(By.id("comments")).click();
        wd.findElement(By.id("comments")).clear();
        wd.findElement(By.id("comments")).sendKeys("Quotes recieved");
        wd.findElement(By.id("edit-tools-save")).click();
        wd.findElement(By.xpath("//section[@class='page-section']/div[2]")).click();
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
