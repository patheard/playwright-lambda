const playwright = require('playwright-aws-lambda');
const { expect } = require('@playwright/test');

exports.handler = async (event, context) => {
  let browser = null;

  try {
    browser = await playwright.launchChromium();
    const context = await browser.newContext();
    const page = await context.newPage();

    await page.goto(event.url);

    // Confirm expected form and submit
    await expect(page.locator('h1')).toHaveText('Healthcheck (email)');
    await page.waitForTimeout(1000);
    await page.locator('form#form label[for="1.0"]').click();
    await page.locator('form#form button[type="button"]').click();
    await page.waitForTimeout(5000);
    await page.locator('form#form button[type="submit"]').click();
  
    // Check form has been submitted
    await page.waitForURL('**/confirmation');
    await expect(page.locator('h1')).toHaveText('Your form has been submitted');

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
