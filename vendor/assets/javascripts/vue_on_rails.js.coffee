@VueOnRails = do ->
  vueModels = []
  namespace = null

  init = ->
    vueModels = []
    namespace = VueOnRails.namespace
    vueComponents = document.querySelectorAll('[data-vue-component]')
    return if vueComponents.length <= 0
    for i in [0...vueComponents.length]
      mountComponent(vueComponents[i])

  mountComponent = (component) ->
    name = component.getAttribute('data-vue-component')
    props = JSON.parse(component.getAttribute('data-vue-props'))
    if (namespace && typeof window[namespace][name] == 'object') || window[name] == 'object'
      el = document.createElement('element-to-be-mounted')
      component.innerHTML = ''
      component.appendChild(el)
      vm = newVueInstance(name, props, el)
      vueModels.push(vm)

  newVueInstance = (name, props, el) ->
    nameFormatted = camelCaseToHyphen(name)
    element = document.createElement(nameFormatted)
    setElementProps(element, props)
    component = if namespace then window[namespace][name] else window[name]
    new Vue({
      el: el
      template: element.outerHTML
      components: { "#{nameFormatted}": component }
    })

  setElementProps = (element, props) ->
    for key, value of props
      if typeof value == 'object'
        element.setAttribute(key, JSON.stringify(value))
      else
        element.setAttribute(key, value)

  camelCaseToHyphen = (string) ->
    string.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase()

  destroy = ->
    for vm in vueModels
      vm.$destroy()
    vueModels = []

  { init, destroy }
