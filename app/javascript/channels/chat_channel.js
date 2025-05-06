import consumer from "./consumer"

consumer.subscriptions.create("ChatChannel", {
  connected() {
    console.log("Connected to ChatChannel");
  },

  disconnected() {
    console.log("Disconnected from ChatChannel");
  },

  received(data) {
    console.log("Received:", data);
  }
});
