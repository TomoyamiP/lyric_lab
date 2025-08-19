import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share"
export default class extends Controller {
  connect() {
    console.log("share controller connected")
  }

  async share(event) {
    const baseUrl = location.origin
    const songId = event.currentTarget.dataset.songId
    const songTitle = event.currentTarget.dataset.title
    console.log("shared")
    const shareData = {
      title: songTitle,
      text: "Check out this song my AI just composed!",
      url: `${baseUrl}/songs/${songId}`,
    };
    try {
    await navigator.share(shareData);
  } catch (err) {
    console.log(`Error: ${err}`);
  }
  }
}
