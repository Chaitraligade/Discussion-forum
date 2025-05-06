import consumer from "./consumer"

consumer.subscriptions.create("ThreadChatChannel", {
  connected() {
    console.log("Connected to ThreadChatChannel");
  },

  disconnected() {
    console.log("Disconnected from ThreadChatChannel");
  },

  received(data) {
    console.log("Received:", data);
  }
});
