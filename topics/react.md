# React # 

## disable browser automatically opening on `npm start` # 
in file `example-react-app/node_modules/react-scripts/scripts/start.js`:
```bash
./react-app
|   +-- ...
|   +-- public/
|   +-- src/
|   +-- package.json
|   +-- node_modules/
|   |    +-- ...
|   |    +-- react-scripts/
|   |    |    +-- ...        
|   |    |    +-- scripts/
|   |    |    |    +-- test.js
|   |    |    |    +-- init.js
|   |    |    |    +-- start.js  <----- Edit this file 
|   |    |    |    +-- ...
```
comment this line:
```javascript
...
      console.log(chalk.cyan('Starting the development server...\n'));
    //   openBrowser(urls.localUrlForBrowser); <-- commment this line 
    });
...
```

or run this sed command in root folder of project:
```bash
# find the line which opens the browser and inline comment it with "//" 
# -i -> edit the file in place
sed -i 's/     openBrowser/\/\/   openBrowser/g' node_modules/react-scripts/scripts/start.js
```

or add `.env.local` file in root directory and add this line:
```bash
BROWSER=none
```
