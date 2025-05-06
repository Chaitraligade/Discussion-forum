import consumer from "./consumer"

consumer.subscriptions.create("MessagesChannel", {
  connected() {
    console.log("Connected to MessagesChannel");
  },

  disconnected() {
    console.log("Disconnected from MessagesChannel");
  },

  received(data) {
    console.log("Received:", data);
  }
});
