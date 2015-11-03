package smpl.ordering;

import org.junit.After;
import org.junit.Before;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

import java.util.concurrent.TimeUnit;
import java.util.Date;
import java.io.File;
//import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.*;
import static org.openqa.selenium.OutputType.*;

public class dealersSeleniumTest {
    FirefoxDriver wd;
    
    @Before
    public void setUp() throws Exception {
        wd = new FirefoxDriver();
        wd.manage().timeouts().implicitlyWait(60, TimeUnit.SECONDS);
    }
    
    @Test
    public void dealersSeleniumTest() {
        wd.get("http://pumrpvm1.cloudapp.net:9080/mrp/");
        wd.findElement(By.cssSelector("button.launchtile")).click();
        wd.findElement(By.id("contact")).click();
        wd.findElement(By.id("contact")).clear();
        wd.findElement(By.id("contact")).sendKeys("123 Microsoft");
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
