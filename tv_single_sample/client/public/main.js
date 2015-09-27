function getDocument(url) {
    var templateXHR = new XMLHttpRequest();
    templateXHR.responseType = "document";
    templateXHR.addEventListener("load", function() {pushDoc(templateXHR.responseXML);}, false);
    templateXHR.open("GET", url, true);
    templateXHR.send();
    return templateXHR;
}

function getJson(url, callback) {
    var templateXHR = new XMLHttpRequest();
    templateXHR.responseType = "json";
    templateXHR.addEventListener("load", function() {callback(templateXHR.responseXML);}, false);
    templateXHR.open("GET", url, true);
    templateXHR.send();
    return templateXHR;
}

function pushDoc(document) {
    navigationDocument.pushDocument(document);
}

// 起動時に呼ばれる
App.onLaunch = function(options) {
    alert();
}

App.onExit = function() {
    console.log('App finished');
}

// XMLを生成してモーダル表示
function alert() {
  getJson("http://api.dribbble.com/shots/popular", function(res) {
    console.log(res);
    var alertXMLString =
    `<?xml version="1.0" encoding="UTF-8" ?>
    <document>
        <alertTemplate>
            // 表示する文言
            <title>`+res+`</title>
        </alertTemplate>
    </document>`
    var parser = new DOMParser();
    var alertDOMElement = parser.parseFromString(alertXMLString, "application/xml");
    navigationDocument.presentModal(alertDOMElement);
  });
}
