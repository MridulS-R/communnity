(function() {
  function animatePipeline(container) {
    if (container.dataset.animated) return;
    container.dataset.animated = 'true';
    var steps = container.querySelectorAll('.pipeline-step');
    var connectors = container.querySelectorAll('.pipeline-connector');
    steps.forEach(function(step, i){
      setTimeout(function(){
        step.classList.add('active');
        if (connectors[i]) connectors[i].classList.add('active');
      }, 500 * i);
    });
  }

  function onIntersect(entries, observer) {
    entries.forEach(function(entry){
      if (entry.isIntersecting) {
        animatePipeline(entry.target);
        observer.unobserve(entry.target);
      }
    });
  }

  document.addEventListener('DOMContentLoaded', function(){
    var els = document.querySelectorAll('[data-pipeline]');
    if (!('IntersectionObserver' in window)) {
      els.forEach(animatePipeline);
      return;
    }
    var io = new IntersectionObserver(onIntersect, { rootMargin: '0px', threshold: 0.3 });
    els.forEach(function(el){ io.observe(el); });
  });
})();

