// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function notifyBugUpdated() {
    $('notice').innerHTML = 'Bug was successfully updated.';
    new Effect.Appear('notice');
    new Effect.Fade('notice', {queue: 'end'});        
}

function updateBug(bugId) {
    dojo.xhrGet({
        url: "/bugs/" + bugId,
        load: function(response) {
            var divWrapper = document.createElement("div");
            divWrapper.innerHTML = "<table>" + response + "</table>";
            var id = "bug_" + bugId;
            $(id).parentNode.replaceChild(
                divWrapper.getElementsByTagName("tr")[0], $(id));
            new Effect.Highlight(id, {duration: 10});
            return response;
        }
    });
}

function BayeuxBugTopicManager() {
    dojo.require("dojox.cometd");

    var topic = "/BugTopic/1";

    return {
        publish: function(bugId) {
            notifyBugUpdated();
            dojox.cometd.publish(topic, bugId);
        },

        init: function(subscribeTopic) {
            dojox.cometd.init("/cometd");
            if (subscribeTopic == true) {
                dojox.cometd.subscribe(topic, function(message) {
                    console.log("message", message.data);
                    updateBug(message.data);
                });                
            }
        }
    };
}

function StompBugTopicManager() {
    var topic = "/BugTopic";

    var stomp = new STOMPClient();
    return {
        publish: function(bugId) {
            notifyBugUpdated();
            stomp.send(bugId, topic);
        },

        init: function(subscribeTopic) {
            TCPSocket = Orbited.TCPSocket;
            if (subscribeTopic == true) {
                stomp.onconnectedframe = function() {
                    stomp.subscribe(topic);
                };
                stomp.onmessageframe = function(frame) {
                    console.log("message", frame.body);
                    updateBug(frame.body);
                };
            }
            stomp.connect('localhost', 61613);
        }
    };
}

BugTopicManager = StompBugTopicManager();