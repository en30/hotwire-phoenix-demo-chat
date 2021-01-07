import { connectStreamSource, disconnectStreamSource } from "@hotwired/turbo";
import { Socket } from "phoenix";

class TurboStreamSourceElement extends HTMLElement {
  async connectedCallback() {
    connectStreamSource(this);
    this.socket = new Socket("/socket");
    this.socket.connect();
    this.channel = this.socket.channel(this.getAttribute("channel"), {
      signed_channel_name: this.getAttribute("signed-channel-name"),
    });

    this.channel.on("new_message", this.dispatchMessageEvent.bind(this));
    this.channel.join();
  }

  disconnectedCallback() {
    disconnectStreamSource(this);
    if (this.channel) this.channel.leave();
    if (this.socket) this.socket.disconnect();
  }

  dispatchMessageEvent({ stream }) {
    const event = new MessageEvent("message", { data: stream });
    return this.dispatchEvent(event);
  }
}

customElements.define("turbo-stream-source", TurboStreamSourceElement);
