const fs = require("fs");
const path = require("path");

const commandMap = {
  GET_WORD_LISTS_INFOS: handleGetWordListsInfos,
  GET_WORDS_FROM_LIST: handleGetWordsFromList,
};

function getWordsFromList(listName) {
  console.log("1");
  const filePath = path.join(__dirname, "json_files", `${listName}.json`);

  if (fs.existsSync(filePath)) {
    const fileData = JSON.parse(fs.readFileSync(filePath, "utf8"));
    const wordCount = fileData.length;

    return {
      listName: listName,
      wordCount: wordCount,
      words: fileData,
    };
  } else {
    return null;
  }
}

function handleGetWordListsInfos(ws) {
  const filePath = path.join(__dirname, "json_files", "wordListInfo.json");
  if (fs.existsSync(filePath)) {
    const listInfo = JSON.parse(fs.readFileSync(filePath, "utf8"));

    ws.send(JSON.stringify({ command: "WORD_LISTS", data: listInfo }));
  } else {
    ws.send(JSON.stringify({ command: "ERROR", message: "File not found" }));
  }
}

function handleGetWordsFromList(ws, params) {
  const listName = params.listName;
  const listInfo = getWordsFromList(listName);

  if (listInfo) {
    ws.send(JSON.stringify({ command: "WORDS_FROM_LIST", data: listInfo }));
  } else {
    ws.send(
      JSON.stringify({
        command: "ERROR",
        message: `List not found: ${listName}`,
      })
    );
  }
}

module.exports = {
  commandMap,
};
