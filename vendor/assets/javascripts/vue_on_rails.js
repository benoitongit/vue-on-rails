this.VueOnRails = (function() {
  var vueModels = [];
  var namespace = null;

  var mountComponents = function() {
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

  var mountComponent = function(component) {
    var name = component.getAttribute('data-vue-component');
    var props = JSON.parse(component.getAttribute('data-vue-props'));
    if ((namespace && typeof window[namespace][name] === 'object') || window[name] === 'object') {
      var vm = newVueInstance(name, props, component);
      return vueModels.push(vm);
    }
  };

  var newVueInstance = function(name, props, component) {
    var componentObj = {};
    var nameFormatted = camelCaseToHyphen(name);
    var element = document.createElement(nameFormatted);
    var componentName = namespace ? window[namespace][name] : window[name];
    setElementProps(element, props);
    component.innerHTML = '';
    component.appendChild(element);
    componentObj[nameFormatted] = componentName;
    return new Vue({
      el: component,
      components: componentObj
    });
  };

  var setElementProps = function(element, props) {
    var key, value;
    var results = [];
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

  var camelCaseToHyphen = function(string) {
    return string.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase();
  };

  var destroyComponents = function() {
    var i;
    for (i = 0; i < vueModels.length; i++) {
      vueModels[i].$destroy();
    }
    vueModels = [];
  };

  return {
    mountComponent: mountComponent,
    mountComponents: mountComponents,
    destroyComponents: destroyComponents
  };
})();