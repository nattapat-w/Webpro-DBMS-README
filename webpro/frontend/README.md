## Steps to install Vue CLI
1. Install vue cli
```
npm install -g @vue/cli
```
2. Create project
```
vue create frontend

Vue CLI v4.5.12
? Please pick a preset: Manually select features
? Check the features needed for your project: Choose Vue version, Babel, Router, Linter
? Choose a version of Vue.js that you want to start the project with 2.x
? Use history mode for router? (Requires proper server setup for index fallback in production) No
? Pick a linter / formatter config: Standard
? Pick additional lint features: Lint on save
? Where do you prefer placing config for Babel, ESLint, etc.? In dedicated config files
? Save this as a preset for future projects? No
? Pick the package manager to use when installing dependencies: NPM
```
3. Go to project folder
```
cd frontend
```
4. Install Bulma
```
npm install bulma
```
5. Import Bulma -> go to main.js
```
import 'bulma/css/bulma.css'
```
6. Install axios
```
npm install axios
```
7. Disable ESLint -> go to .eslintrc.js and comment this line
```javascript
// '@vue/standard'
```


## Fix CORS problems
1. Go to folder backend and install cors
```
npm install cors
```
2. Go to index.js and add these lines
```javascript
var cors = require('cors')

...

app.use(cors())
```

**How to use Font Awesome in Vue JS Project**
* https://medium.com/front-end-weekly/how-to-use-fon-awesome-5-on-vuejs-project-ff0f28310821

