export const CustomSelect = {
  mounted() {
    this.el.addEventListener("selected-change", event => {
      this.pushEventTo(event.detail.id, "update", event.detail)
    })

    this.handleEvent("close-selected", data => {
      const element = document.querySelector(data.id)

      if (!element) return
      if (data.id !== `#${this.el.id}`) return

      element.dispatchEvent(new CustomEvent("reset"))

      this.el.querySelector('input').value = data.value
      this.el.querySelector('input').dispatchEvent(new Event("input", {bubbles: true}))
    })
  }
}
