export function scrollTo(el, to, duration) {
  if (!window.requestAnimationFrame) {
    window.requestAnimationFrame = (
      function() {
        return (
          window.webkitRequestAnimationFrame ||
          window.mozRequestAnimationFrame ||
          window.oRequestAnimationFrame ||
          window.msRequestAnimationFrame ||
          function(callback, element) {
            window.setTimeout(callback, 1000 / 60)
          }
        )
      }
    )()
  }
  const count = duration / 16
  const position = el.scrollTop
  const difference = to - position
  const perTick = difference / count

  function tick() {
    el.scrollTop = el.scrollTop + perTick
    if (el.scrollTop === to || count <= 0) return
    window.requestAnimationFrame(tick)
  }

  tick()
}

export function scrollTop(el, from = 0, to, duration = 500) {
  if (!window.requestAnimationFrame) {
    window.requestAnimationFrame = (
      function() {
        return (
          window.webkitRequestAnimationFrame ||
          window.mozRequestAnimationFrame ||
          window.oRequestAnimationFrame ||
          window.msRequestAnimationFrame ||
          function(callback) {
            window.setTimeout(callback, 1000 / 60)
          }
        )
      }
    )()
  }
  const difference = Math.abs(from - to)
  const step = Math.ceil(difference / duration * 50)

  function scroll(start, end, step) {
    if (start === end) return

    let d = (start + step > end) ? end : start + step
    if (start > end) {
      d = (start - step < end) ? end : start - step
    }

    if (el === window) {
      window.scrollTo(d, d)
    } else {
      el.scrollTop = d
    }
    window.requestAnimationFrame(() => scroll(d, end, step))
  }
  scroll(from, to, step)
}
