this.VueOnRails = (function() {
  var camelCaseToHyphen, destroyComponents, mountComponent, mountComponents, newVueInstance, setElementProps;
  var vueModels = [];
  var namespace = null;

  mountComponents = function() {
    vueModels = [];
    namespace = VueOnRails.namespace;
    var vueComponents = document.querySelectorAll('[data-vue-component]');
    if (vueComponents.length <= 0) {
      return;
    }
    var results = [];
    for (var i = 0; i < vueComponents.length; i++) {
      results.push(mountComponent(vueComponents[i]));
    }
    return results;
  };

  mountComponent = function(component) {
    var el, name, props, vm;
    name = component.getAttribute('data-vue-component');
    props = JSON.parse(component.getAttribute('data-vue-props'));
    if ((namespace && typeof window[namespace][name] === 'object') || window[name] === 'object') {
      el = document.createElement('element-to-be-mounted');
      component.innerHTML = '';
      component.appendChild(el);
      vm = newVueInstance(name, props, el);
      return vueModels.push(vm);
    }
  };

  newVueInstance = function(name, props, el) {
    var component, element, nameFormatted, obj;
    nameFormatted = camelCaseToHyphen(name);
    element = document.createElement(nameFormatted);
    setElementProps(element, props);
    component = namespace ? window[namespace][name] : window[name];
    return new Vue({
      el: el,
      template: element.outerHTML,
      components: (
        obj = {},
          obj["" + nameFormatted] = component,
          obj
      )
    });
  };

  setElementProps = function(element, props) {
    var key, results, value;
    results = [];
    for (key in props) {
      value = props[key];
      if (typeof value === 'object') {
        results.push(element.setAttribute(key, JSON.stringify(value)));
      } else {
        results.push(element.setAttribute(key, value));
      }
    }
    return results;
  };

  camelCaseToHyphen = function(string) {
    return string.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase();
  };

  destroyComponents = function() {
    var j, len, vm;
    for (j = 0, len = vueModels.length; j < len; j++) {
      vm = vueModels[j];
      vm.$destroy();
    }
    return vueModels = [];
  };

  return {
    mountComponents: mountComponents,
    destroyComponents: destroyComponents
  };
})();