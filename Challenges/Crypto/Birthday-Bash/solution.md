# Hint 1 on Site: 
Based.

# Hint 2 on Site: 
Think about 100 and 22 together.

# Solution
The key to this challenge is realizing Base122 is a thing. See : https://github.com/kevinAlbs/Base122

Once this realization is made, make a JS or C program that can then decrypt the file, and that includes the flag.

e.g.: 

```javascript
let fileData = fs.readFileSync('mybirthday.txt', {encoding: 'utf-8'});
console.log(String.fromCharCode.apply(null, decode(fileData)));
```

In testing, the leap was made to Base122 pretty quickly. In practice, this challenge turned out to be a lot more difficult than intended. (Especially with people finding a python implementation that did not work with files, which was specified in that repository but missed by multiple teams)