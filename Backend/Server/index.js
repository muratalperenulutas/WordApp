const express = require('express');
const http = require('http');
const WebSocket = require('ws');
const { commandMap} = require('./commands');

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ noServer: true });


wss.on('connection', (ws) => {
    console.log('WebSocket connection established ');
    //const data = readJsonFiles(path.join(__dirname, 'json_files'));

    //ws.send(JSON.stringify(data));

    ws.on('message', (message) => {
        //console.log('Received message:', message);
        try {
            const parsedMessage = JSON.parse(message);
            const command = parsedMessage.command;
            const params = parsedMessage.params || {};

            if (commandMap[command]) {
                commandMap[command](ws, params);
            } else {
                console.error(`Unknown command: ${command}`);
            }
        } catch (error) {
            console.error('Message processing error:', error);
        }
    });
});
server.on('upgrade', (request, socket, head) => {
    if (request.url === '/wss') {
        wss.handleUpgrade(request, socket, head, (ws) => {
            wss.emit('connection', ws, request);
        });
    }
    console.log('3 ');
});

app.get('/', (req, res) => {
    res.send('Hello from Express server!');
});
const HOST = '0.0.0.0';
const PORT = 5050;
server.listen(PORT,HOST, () => {
    console.log(`Server running on host:${HOST} and port:${PORT}`);
});



/*const express = require('express');
const http = require('http');
const WebSocket = require('ws');

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ noServer: true });

wss.on('connection', (ws) => {
    console.log('WebSocket connection established');
    ws.send('Hello from WebSocket server!');
});

server.on('upgrade', (request, socket, head) => {
    if (request.url === '/wss') {
        wss.handleUpgrade(request, socket, head, (ws) => {
            wss.emit('connection', ws, request);
        });
    }
});

app.get('/', (req, res) => {
    res.send('Hello from Express server!');
});

const PORT = 5050;
server.listen(PORT, () => {
    console.log(`Server running on port:${PORT}`);
});

function readJsonFiles(dirPath) {
    const files = fs.readdirSync(dirPath);
    const jsonFiles = files.filter(file => path.extname(file) === '.json');
    const data = [];

    jsonFiles.forEach(file => {
        const filePath = path.join(dirPath, file);
        const fileData = JSON.parse(fs.readFileSync(filePath, 'utf8'));
        data.push(...fileData);
    });

    return data;
}
*/