/* ========================================================================
 * Ratchet: sliders.js v2.0.2
 * http://goratchet.com/components#sliders
 * ========================================================================
   Adapted from Brad Birdsall's swipe
 * Copyright 2014 Connor Sears
 * Licensed under MIT (https://github.com/twbs/ratchet/blob/master/LICENSE)
 * ======================================================================== */

!(function () {
  'use strict';

  var pageX;
  var pageY;
  var slider;
  var deltaX;
  var deltaY;
  var offsetX;
  var lastSlide;
  var startTime;
  var resistance;
  var sliderWidth;
  var slideNumber;
  var isScrolling;
  var scrollableArea;

  var getSlider = function (target) {
    var i;
    var sliders = document.querySelectorAll('.slider > .slide-group');

    for (; target && target !== document; target = target.parentNode) {
      for (i = sliders.length; i--;) {
        if (sliders[i] === target) {
          return target;
        }
      }
    }
  };

  var getScroll = function () {
    if ('webkitTransform' in slider.style) {
      var translate3d = slider.style.webkitTransform.match(/translate3d\(([^,]*)/);
      var ret = translate3d ? translate3d[1] : 0;
      return parseInt(ret, 10);
    }
  };

  var setSlideNumber = function (offset) {
    var round = offset ? (deltaX < 0 ? 'ceil' : 'floor') : 'round';
    slideNumber = Math[round](getScroll() / (scrollableArea / slider.children.length));
    slideNumber += offset;
    slideNumber = Math.min(slideNumber, 0);
    slideNumber = Math.max(-(slider.children.length - 1), slideNumber);
  };

  var onTouchStart = function (e) {
    slider = getSlider(e.target);

    if (!slider) {
      return;
    }

    var firstItem  = slider.querySelector('.slide');

    scrollableArea = firstItem.offsetWidth * slider.children.length;
    isScrolling    = undefined;
    sliderWidth    = slider.offsetWidth;
    resistance     = 1;
    lastSlide      = -(slider.children.length - 1);
    startTime      = +new Date();
    pageX          = e.touches[0].pageX;
    pageY          = e.touches[0].pageY;
    deltaX         = 0;
    deltaY         = 0;

    setSlideNumber(0);

    slider.style['-webkit-transition-duration'] = 0;
  };

  var onTouchMove = function (e) {
    if (e.touches.length > 1 || !slider) {
      return; // Exit if a pinch || no slider
    }

    deltaX = e.touches[0].pageX - pageX;
    deltaY = e.touches[0].pageY - pageY;
    pageX  = e.touches[0].pageX;
    pageY  = e.touches[0].pageY;

    if (typeof isScrolling === 'undefined') {
      isScrolling = Math.abs(deltaY) > Math.abs(deltaX);
    }

    if (isScrolling) {
      return;
    }

    offsetX = (deltaX / resistance) + getScroll();

    e.preventDefault();

    resistance = slideNumber === 0         && deltaX > 0 ? (pageX / sliderWidth) + 1.25 :
                 slideNumber === lastSlide && deltaX < 0 ? (Math.abs(pageX) / sliderWidth) + 1.25 : 1;

    slider.style.webkitTransform = 'translate3d(' + offsetX + 'px,0,0)';
  };

  var onTouchEnd = function (e) {
    if (!slider || isScrolling) {
      return;
    }

    setSlideNumber(
      (+new Date()) - startTime < 1000 && Math.abs(deltaX) > 15 ? (deltaX < 0 ? -1 : 1) : 0
    );

    offsetX = slideNumber * sliderWidth;

    slider.style['-webkit-transition-duration'] = '.2s';
    slider.style.webkitTransform = 'translate3d(' + offsetX + 'px,0,0)';

    e = new CustomEvent('slide', {
      detail: { slideNumber: Math.abs(slideNumber) },
      bubbles: true,
      cancelable: true
    });

    slider.parentNode.dispatchEvent(e);
  };

  window.addEventListener('touchstart', onTouchStart);
  window.addEventListener('touchmove', onTouchMove);
  window.addEventListener('touchend', onTouchEnd);

}());
