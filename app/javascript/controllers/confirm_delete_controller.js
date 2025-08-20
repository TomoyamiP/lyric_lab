import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="confirm-delete"
export default class extends Controller {
  static values = { url: String }

  delete(event) {
    event.preventDefault()

    Swal.fire({
      title: "Are you sure?",
      text: "This action cannot be undone!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#d33",
      cancelButtonColor: "#3085d6",
      confirmButtonText: "Yes, delete it!"
    }).then((result) => {
      if (result.isConfirmed) {
        fetch(this.urlValue, {
          method: "DELETE",
          headers: {
            "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
          }
        }).then(() => {
          Swal.fire("Deleted!", "Your song has been deleted.", "success")
            .then(() =>window.location.href = "/songs")
        })
      }
    })
  }
}
