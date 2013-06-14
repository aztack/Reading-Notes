[W3C: Events](http://www.w3.org/TR/2000/REC-DOM-Level-2-Events-20001113/events.html)
[QuirkModes: Events Properties](http://www.quirksmode.org/js/events_properties.html)

[Cross-browser mouse positioning](http://www.jacklmoore.com/notes/mouse-position/)
=================================

*Mouse Event Properties*
------------------------
clientX, clientY
Standard: W3C Recommendation
Mouse position relative to the browser's visible viewport.

*screenX, screenY*
------------------------
Standard: W3C Recommendation
Mouse position relative to the user's physical screen.

*offsetX, offsetY*
------------------------
Standard: W3C Working Draft
Mouse position relative to the target element. This is implemented very inconsistently between browsers.

*pageX, pageY*
------------------------
Standard: W3C Working Draft
Mouse position relative to the html document (ie. [layout viewport](http://www.quirksmode.org/mobile/viewports2.html)).

*x, y*
------------------------
Standard: W3C Working Draft
Equivalent to clientX, clientY, but is unsupported by some browsers. Use clientX, clientY instead.

*layerX, layerY*
------------------------
No Standard
Mouse position relative to the closest positioned ancestor element. If none of the ancestor elements have positioning, the mouse position is relative to the document (like pageX, pageY). LayerX, layerY have an [uncertain future](https://bugs.webkit.org/show_bug.cgi?id=21868#c21).

QuirksMode has a great [compatibility table](http://www.quirksmode.org/dom/w3c_cssom.html#mousepos) that details inconsistencies in the non-standard properties. Know that only clientX, clientY, screenX, and screenY are part of the W3C Spec.

Normalization
=============


Calculating pageX, pageY
------------------------

The only major browser that does not support these properties is IE8. If you are doing event handling with jQuery, it will automatically normalize pageX and pageY for you. If you are not using jQuery's normalized events but still have access to the jQuery, you can use jQuery.event.fix to normalize the event object. Example:

```javascript
document.body.onclick = function(e) {
    e = e || window.event;
    e = jQuery.event.fix(e);
    console.log([e.pageX, e.pageY]);
};
```

Without jQuery, the clientX and clientY properties can be added to the viewports scrollLeft and scrollTop to calculate the pageX and pageY values. see also [QuirksMode: Event properties](http://www.quirksmode.org/js/events_properties.html)

```javascript
document.body.onclick = function(e) {
    e = e || window.event;

    var pageX = e.pageX;
    var pageY = e.pageY;
    if (pageX === undefined) {
        pageX = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
        pageY = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
    }

    console.log([pageX, pageY]);
};
```

Calculating offsetX, offsetY
----------------------------

According to the W3C Working Draft, offsetX and offsetY should be relative to the padding edge of the target element. The only browser using this convention is IE. Webkit uses the border edge, Opera uses the content edge, and FireFox does not support the properties.

Normalizing to the border edge is easiest to do, thanks to the nifty element.getBoundingClientRect:

```javascript
document.body.onclick = function(e) {
    e = e || window.event;

    var target = e.target || e.srcElement,
        rect = target.getBoundingClientRect(),
        offsetX = e.clientX - rect.left,
        offsetY = e.clientY - rect.top;

    console.log([offsetX, offsetY]);
};
```

If you wanted to normalize to the W3C draft spec, then the border width needs to be subtracted from the previously calculated offsetX and offsetY:

```javascript
document.body.onclick = function(e) {
    e = e || window.event;

    var target = e.target || e.srcElement,
        style = target.currentStyle || window.getComputedStyle(target, null),
        borderLeftWidth = parseInt(style['borderLeftWidth'], 10),
        borderTopWidth = parseInt(style['borderTopWidth'], 10),
        rect = target.getBoundingClientRect(),
        offsetX = e.clientX - borderLeftWidth - rect.left,
        offsetY = e.clientY - borderTopWidth - rect.top;

    console.log([offsetX, offsetY]);
};
```

[Calculate LayerX/Y](http://stackoverflow.com/questions/8389156/what-substitute-should-we-use-for-layerx-layery-since-they-are-deprecated-in-web)

> I renamed the function from `getOffset` to `getLayerXY`

```javascript
function getLayerXY(evt) {
  var el = evt.target,
      x = y = 0;

  while (el && !isNaN(el.offsetLeft) && !isNaN(el.offsetTop)) {
    x += el.offsetLeft - el.scrollLeft;
    y += el.offsetTop - el.scrollTop;
    el = el.offsetParent;
  }

  x = evt.clientX - x;
  y = evt.clientY - y;

  return { x: x, y: y };
}
```
