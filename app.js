const express = require('express'); // Adding Express
    const app = express(); // Initializing Express
    const puppeteer = require('puppeteer'); // Adding Puppeteer

    // Wrapping the Puppeteer browser logic in a GET request
    app.get('/', function(req, res) {

        // Launching the Puppeteer controlled headless browser and navigate to the Digimon website
        puppeteer.launch({ args: ['--no-sandbox'] }).then(async function(browser) {
            const page = await browser.newPage();
              console.log('Teste 12');

            await page.goto('https://expressjs.com/en/starter/installing.html');

            // Targeting the DOM Nodes that contain the Digimon names
            const digimonNames = await page.$$eval('#', function(digimons) {
            // Mapping each Digimon name to an array
                return digimons.map(function(digimon) {
              return digimon.innerText;
            });
          });

            // Closing the Puppeteer controlled headless browser
            await browser.close();

            // Sending the Digimon names to Postman
            res.send(digimonNames);
        });
    });

    // Making Express listen on port 7000a
    app.listen(3000, function() {
      console.log('Running on port 7000.');
    });