#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

function grabBuildNameFromConfig(config) {
    let bareBoard;
    try {
        let firstLineItems = config.split("\n")[0].split(' ');
        if (!(firstLineItems[0] == '#' && firstLineItems[1] == 'Betaflight' && firstLineItems[2] == '/')) {
            throw new Error('Could not find header');
            return undefined;
        }
        bareBoard = firstLineItems[3];
    } catch (e) {
        bareBoard = undefined;
        console.log('grabBuildNameFromConfig failed: ', e.message);
    }
    return bareBoard;
}

function cleanUnifiedConfigFile(input) {
    let output = [];
    let inComment = false;
    for (let i=0; i < input.length; i++) {
        if (input.charAt(i) == "\n" || input.charAt(i) == "\r") {
            inComment = false;
        }
        if (input.charAt(i) == "#") {
            inComment = true;
        }
        if (!inComment && input.charCodeAt(i) > 255) {
            // Note: we're not showing this error in betaflight-configurator
            throw new Error('commands are limited to characters 0-255, comments have no limitation');
        }
        if (input.charCodeAt(i) > 255) {
            output.push('_');
        } else {
            output.push(input.charAt(i));
        }
    }
    return output.join('');
}

function testUnifiedConfigFile(filePath) {
    let config;
    let configCleaned;
    config = fs.readFileSync(filePath, 'UTF-8');
    configCleaned = cleanUnifiedConfigFile(config);
    return grabBuildNameFromConfig(config);
}

function walkSync(currentDirPath, callback) {
    fs.readdirSync(currentDirPath).forEach(function (name) {
        var filePath = path.join(currentDirPath, name);
        var stat = fs.statSync(filePath);
        if (stat.isFile()) {
            callback(filePath, stat);
        } else if (stat.isDirectory()) {
            walkSync(filePath, callback);
        }
    });
}

let configs = {};
let problems = false; // Start with no problems

walkSync('configs', function (filePath, stat) {
    let bareBoard;
    try {
        bareBoard = testUnifiedConfigFile(filePath);
        if (bareBoard === undefined) {
            throw new Error ('Unspecified firmware')
        }
    } catch (err) {
        //console.error(err);
        console.log(filePath, err.toString());
        problems = true;
    }
    var pathParts = filePath.split('/');
    if (configs[pathParts[1]] === undefined) {
        configs[pathParts[1]] = [];
    }
    //configs[pathParts[1]].push(pathParts[2]);
    configs[pathParts[1]].push({ filename: pathParts[2], bareboard: bareBoard});
    //console.log(filePath, pathParts[2], bareBoard);
});
if (!problems) {
    fs.writeFileSync('target-configs.json', JSON.stringify(configs, null, 2).concat("\n"));
} else {
    console.log('One or more problems occured, see above');
    process.exitCode = 1;
}
