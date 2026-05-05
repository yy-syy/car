import './waves.css'

export default {
  bind(el, binding) {
    el.addEventListener('click', e => {
      const customOpts = Object.assign({}, binding.value)
      const opts = Object.assign({
        ele: el,
        type: 'hit',
        color: 'rgba(0, 0, 0, 0.3)'
      }, customOpts)
      let target = null
      if (opts.type === 'hit') {
        target = document.createElement('div')
        const rect = el.getBoundingClientRect()
        target.className = 'waves-ripple'
        target.style.height = target.style.width = `${Math.max(rect.width, rect.height)}px`
        target.style.top = `${e.pageY - rect.top - parseInt(target.style.height) / 2}px`
        target.style.left = `${e.pageX - rect.left - parseInt(target.style.width) / 2}px`
        target.style.background = opts.color
        el.appendChild(target)
        el.classList.add('waves-animating')
        const computedStyle = window.getComputedStyle(target)
        computedStyle.animationDuration;
        target.classList.add('waves-ripple-animate')
        setTimeout(() => {
          target.classList.remove('waves-ripple-animate')
          el.classList.remove('waves-animating')
          if (target.parentNode) {
            target.parentNode.removeChild(target)
          }
        }, 650)
      }
    })
  }
}
