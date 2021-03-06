// Generated by CoffeeScript 1.4.0
(function() {
  var EventEmitter, T, TermUI, keypress, tty, util, _,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  keypress = require('keypress');

  util = require('util');

  tty = require('tty');

  EventEmitter = require('events').EventEmitter;

  _ = require('underscore');

  _.mixin(require('underscore.string'));

  module.exports = T = new (TermUI = (function(_super) {

    __extends(TermUI, _super);

    function TermUI() {
      this.handleData = __bind(this.handleData, this);

      this.handleKeypress = __bind(this.handleKeypress, this);

      this.handleSizeChange = __bind(this.handleSizeChange, this);
      if (tty.isatty(process.stdin)) {
        process.stdin.setRawMode(true);
        process.stdin.resume();
        keypress(process.stdin);
        process.stdin.on('keypress', this.handleKeypress);
        process.stdin.on('data', this.handleData);
        if (process.listeners('SIGWINCH').length === 0) {
          process.on('SIGWINCH', this.handleSizeChange);
        }
        this.handleSizeChange();
        this.enableMouse();
        this.isTerm = true;
      } else {
        this.isTerm = false;
      }
    }

    TermUI.prototype.C = {
      k: 0,
      r: 1,
      g: 2,
      y: 3,
      b: 4,
      m: 5,
      c: 6,
      w: 7,
      x: 9
    };

    TermUI.prototype.S = {
      normal: 0,
      bold: 1,
      underline: 4,
      blink: 5,
      inverse: 8
    };

    TermUI.prototype.SYM = {
      star: '\u2605',
      check: '\u2714',
      x: '\u2718',
      triUp: '\u25b2',
      triDown: '\u25bc',
      triLeft: '\u25c0',
      triRight: '\u25b6',
      fn: '\u0192',
      arrowUp: '\u2191',
      arrowDown: '\u2193',
      arrowLeft: '\u2190',
      arrowRight: '\u2192'
    };

    TermUI.prototype.handleSizeChange = function() {
      var winsize;
      winsize = process.stdout.getWindowSize();
      this.width = winsize[1];
      this.height = winsize[0];
      return this.emit('resize', {
        w: this.width,
        h: this.height
      });
    };

    TermUI.prototype.out = function(buf) {
      if (this.isTerm) {
        process.stdout.write(buf);
      }
      return this;
    };

    TermUI.prototype.hideCursor = function() {
      return this.out('\x1b[?25l');
    };

    TermUI.prototype.showCursor = function() {
      return this.out('\x1b[?25h');
    };

    TermUI.prototype.clear = function() {
      this.out('\x1b[2J');
      this.home;
      return this;
    };

    TermUI.prototype.pos = function(x, y) {
      x = x < 0 ? this.width - x : x;
      y = y < 0 ? this.height - y : y;
      x = Math.max(Math.min(x, this.width), 1);
      y = Math.max(Math.min(y, this.height), 1);
      this.out("\x1b[" + y + ";" + x + "H");
      return this;
    };

    TermUI.prototype.home = function() {
      this.pos(1, 1);
      return this;
    };

    TermUI.prototype.end = function() {
      this.pos(1, -1);
      return this;
    };

    TermUI.prototype.fg = function(c) {
      this.out("\x1b[3" + c + "m");
      return this;
    };

    TermUI.prototype.bg = function(c) {
      this.out("\x1b[4" + c + "m");
      return this;
    };

    TermUI.prototype.hifg = function(c) {
      this.out("\x1b[38;5;" + c + "m");
      return this;
    };

    TermUI.prototype.hibg = function(c) {
      this.out("\x1b[48;5;" + c + "m");
      return this;
    };

    TermUI.prototype.enableMouse = function() {
      this.out('\x1b[?1000h');
      this.out('\x1b[?1002h');
      return this;
    };

    TermUI.prototype.disableMouse = function() {
      this.out('\x1b[?1000l');
      this.out('\x1b[?1002l');
      return this;
    };

    TermUI.prototype.eraseLine = function() {
      this.out('\x1b[2K');
      return this;
    };

    TermUI.prototype.handleKeypress = function(c, key) {
      if (key && key.ctrl && key.name === 'c') {
        return this.quit();
      } else {
        return this.emit('keypress', c, key);
      }
    };

    TermUI.prototype.handleData = function(d) {
      var buttons, event, eventData;
      eventData = {};
      buttons = ['left', 'middle', 'right'];
      if (d[0] === 0x1b && d[1] === 0x5b && d[2] === 0x4d) {
        switch (d[3] & 0x60) {
          case 0x20:
            if ((d[3] & 0x3) < 0x3) {
              event = 'mousedown';
              eventData.button = buttons[d[3] & 0x3];
            } else {
              event = 'mouseup';
            }
            break;
          case 0x40:
            event = 'drag';
            if ((d[3] & 0x3) < 0x3) {
              eventData.button = buttons[d[3] & 0x3];
            }
            break;
          case 0x60:
            event = 'wheel';
            if (d[3] & 0x1) {
              eventData.direction = 'down';
            } else {
              eventData.direction = 'up';
            }
        }
        eventData.shift = (d[3] & 0x4) > 0;
        eventData.x = d[4] - 32;
        eventData.y = d[5] - 32;
        this.emit(event, eventData);
        return this.emit('any', event, eventData);
      }
    };

    TermUI.prototype.quit = function() {
      this.fg(this.C.x).bg(this.C.x);
      this.disableMouse();
      this.showCursor();
      process.stdin.setRawMode(false);
      return process.exit();
    };

    return TermUI;

  })(EventEmitter));

  T.Widget = (function(_super) {

    __extends(Widget, _super);

    function Widget(options) {
      var _ref, _ref1, _ref2, _ref3;
      this.options = options != null ? options : {};
      this.bounds = {
        x: ((_ref = this.options.bounds) != null ? _ref.x : void 0) || 0,
        y: ((_ref1 = this.options.bounds) != null ? _ref1.y : void 0) || 0,
        w: ((_ref2 = this.options.bounds) != null ? _ref2.w : void 0) || 0,
        h: ((_ref3 = this.options.bounds) != null ? _ref3.h : void 0) || 0
      };
      T.Widget.instances.unshift(this);
    }

    Widget.prototype.draw = function() {};

    Widget.prototype.hitTest = function(x, y) {
      return ((this.bounds.x <= x && x <= (this.bounds.x + this.bounds.w - 1))) && ((this.bounds.y <= y && y <= (this.bounds.y + this.bounds.h - 1)));
    };

    return Widget;

  })(EventEmitter);

  T.Widget.instances = [];

  T.on('any', function(event, eventData) {
    var widget, _i, _len, _ref, _results;
    _ref = T.Widget.instances;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      widget = _ref[_i];
      if (widget.hitTest(eventData.x, eventData.y)) {
        eventData.target = widget;
        _results.push(widget.emit(event, eventData));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  });

  T.Button = (function(_super) {

    __extends(Button, _super);

    function Button(opts) {
      var _ref, _ref1, _ref2, _ref3;
      Button.__super__.constructor.call(this, opts);
      this.fg = (_ref = this.options.fg) != null ? _ref : T.C.w;
      this.bg = (_ref1 = this.options.fg) != null ? _ref1 : T.C.b;
      this.label = (_ref2 = this.options.label) != null ? _ref2 : '';
      this.labelAnchor = (_ref3 = this.options.labelAnchor) != null ? _ref3 : 5;
    }

    Button.prototype.draw = function() {
      var align, emptyStr, labelRow, labelStr, y, _i, _ref, _ref1;
      T.fg(this.fg).bg(this.bg).pos(this.bounds.x, this.bounds.y);
      align = ['lpad', 'rpad', 'center'][this.labelAnchor % 3];
      labelStr = _[align](this.label, this.bounds.w, ' ');
      if (this.bounds.h > 1) {
        emptyStr = _.pad(' ', this.bounds.w, ' ');
      }
      switch (((this.labelAnchor - 1) / 3) | 0) {
        case 0:
          labelRow = this.bounds.y + this.bounds.h - 1;
          break;
        case 1:
          labelRow = this.bounds.y + (this.bounds.h / 2) | 0;
          break;
        case 2:
          labelRow = this.bounds.y;
      }
      for (y = _i = _ref = this.bounds.y, _ref1 = this.bounds.y + this.bounds.h - 1; _ref <= _ref1 ? _i <= _ref1 : _i >= _ref1; y = _ref <= _ref1 ? ++_i : --_i) {
        T.pos(this.bounds.x, y);
        if (y === labelRow) {
          T.out(labelStr);
        } else {
          T.out(emptyStr);
        }
      }
      return T.fg(T.C.x).bg(T.C.x).end();
    };

    return Button;

  })(T.Widget);

}).call(this);
