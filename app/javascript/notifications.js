document.addEventListener("click", function (e) {
    if (e.target.classList.contains("mark-as-read")) {
      const notificationId = e.target.dataset.id;
      fetch(`/notifications/${notificationId}/mark_as_read`, {
        method: "PATCH",
        headers: { "X-CSRF-Token": document.querySelector("[name='csrf-token']").content }
      }).then(() => e.target.parentElement.remove());
    }
  });
  