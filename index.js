const playwright = require('playwright-aws-lambda');

exports.handler = async (event, context) => {
  let browser = null;

  try {
    browser = await playwright.launchChromium();
    const context = await browser.newContext();
    const page = await context.newPage();

    await page.goto(event.url);
    await page.waitForTimeout(5000);
    await page.locator('label[for="1.0"]').click();
    await page.locator('button[type="submit"]').click();
    await page.waitForURL('**/confirmation');

  } catch (error) {
    throw error;
  } finally {
    if (browser) {
      await browser.close();
    }
  }

  return {
    statusCode: 200
  };
};
