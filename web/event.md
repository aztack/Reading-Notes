[W3C: Events](http://www.w3.org/TR/2000/REC-DOM-Level-2-Events-20001113/events.html)
[QuirkModes: Events Properties](http://www.quirksmode.org/js/events_properties.html)

(Cross-browser mouse positioning)[http://www.jacklmoore.com/notes/mouse-position/]

*Mouse Event Properties*
clientX, clientY
Standard: W3C Recommendation
Mouse position relative to the browser's visible viewport.

*screenX, screenY*
Standard: W3C Recommendation
Mouse position relative to the user's physical screen.

*ffsetX, offsetY*
Standard: W3C Working Draft
Mouse position relative to the target element. This is implemented very inconsistently between browsers.

*pageX, pageY*
Standard: W3C Working Draft
Mouse position relative to the html document (ie. layout viewport).

*x, y*
Standard: W3C Working Draft
Equivalent to clientX, clientY, but is unsupported by some browsers. Use clientX, clientY instead.

*layerX, layerY*
No Standard
Mouse position relative to the closest positioned ancestor element. If none of the ancestor elements have positioning, the mouse position is relative to the document (like pageX, pageY). LayerX, layerY have an uncertain future.

QuirksMode has a great compatibility table that details inconsistencies in the non-standard properties. Know that only clientX, clientY, screenX, and screenY are part of the W3C Spec.
