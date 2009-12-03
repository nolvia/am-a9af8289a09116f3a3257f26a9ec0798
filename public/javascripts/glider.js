/**
 * @author Bruno Bornsztein <bruno@missingmethod.com>
 * @copyright 2007 Curbly LLC
 * @package Glider
 * @license MIT
 * @url http://www.missingmethod.com/projects/glider/
 * @version 0.0.3
 * @dependencies prototype.js 1.5.1+, effects.js
 */

/*  Thanks to Andrew Dupont for refactoring help and code cleanup - http://andrewdupont.net/  */

Glider = Class.create();
Object.extend(Object.extend(Glider.prototype, Abstract.prototype), {
  initialize: function(options){
    this.options    = Object.extend({ duration: 1.0, frequency: 3 }, options || {});
    
    this.scrolling  = false;
    this.scroller   = this.options.scroller || $$('.scroller').first();
    this.sections   = this.options.sections || $$('.section');
    this.controls   = this.options.controls || $$('div.controls a');
    this.initial    = this.options.initial  || null;
    this.sections.each( function(section, index) {
      section._index = index;
    });
    
    this.events = {
      click: this.click.bind(this)
    };

    this.addObservers();
    // initialSection should be the id of the section you want to show up on load
    if(this.options.initial) this.moveTo(this.options.initial);
    if(this.options.auto)    this.start();
  },

  addObservers: function() {
    this.controls.invoke('observe', 'click', this.events.click);
  },

  click: function(event) {
    this.stop();
    var element = event.findElement('a');
    this.controls.each(function(link){ link.removeClassName('active'); });
    element.addClassName('active');
    this.moveTo( $(element.href.split("#").last()) );
    event.stop();
  },

  moveTo: function(element){
    this.current = $(element);
    if (this.scrolling) this.scrolling.cancel();
    
    Position.prepare();
    var containerOffset = Position.cumulativeOffset(this.scroller);
    var elementOffset   = Position.cumulativeOffset(this.current);

    this.scrolling = new Effect.SmoothScroll(this.scroller, {
      duration: this.options.duration, 
      x: (elementOffset[0]-containerOffset[0]), 
      y: (elementOffset[1]-containerOffset[1])
    });
    return false;
  },
    
  next: function(){
    this.stop();
    
    if (this.current) {
      var currentIndex = this.current._index;
      var nextIndex = (currentIndex + 1) % (this.sections.length - 1);
    } else var nextIndex = 1;

    this.moveTo(this.sections[nextIndex]);
  },
  
  toggle: function(){
    this.scrolling ? this.stop() : this.start();
  },
  
  previous: function(){
    this.stop();
    
    if (this.current) {
      var currentIndex = this.current._index;
      console.log(this.sections);
      console.log(this.sections.length);
      console.log(currentIndex);
      var prevIndex = (currentIndex + this.sections.length - 2) % (this.sections.length - 1);
    } else {
      var prevIndex = this.sections.length - 1;
    }
    
    this.moveTo(this.sections[prevIndex]);
  },

  stop: function() {
    clearTimeout(this.timer);
  },
  
  start: function() {
    this.periodicallyUpdate();
  },
    
  periodicallyUpdate: function() {
    if (this.timer != null) {
      clearTimeout(this.timer);
      this.next();
    }
    this.timer = setTimeout(this.periodicallyUpdate.bind(this), this.options.frequency*1000);
  }
});

Effect.SmoothScroll = Class.create();
Object.extend(Object.extend(Effect.SmoothScroll.prototype, Effect.Base.prototype), {
  initialize: function(element) {
    this.element = $(element);
    var options = Object.extend({
      x:    0,
      y:    0,
      mode: 'absolute'
    } , arguments[1] || {}  );
    this.start(options);
  },
  setup: function() {
    if (this.options.continuous && !this.element._ext ) {
      this.element.cleanWhitespace();
      this.element._ext=true;
      this.element.appendChild(this.element.firstChild);
    }
   
    this.originalLeft=this.element.scrollLeft;
    this.originalTop=this.element.scrollTop;
   
    if(this.options.mode == 'absolute') {
      this.options.x -= this.originalLeft;
      this.options.y -= this.originalTop;
    } 
  },
  update: function(position) {   
    this.element.scrollLeft = this.options.x * position + this.originalLeft;
    this.element.scrollTop  = this.options.y * position + this.originalTop;
  }
});