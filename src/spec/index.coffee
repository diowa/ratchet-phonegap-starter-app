describe 'app', ->
  describe 'initialize', ->
    it 'binds deviceready', ->
      runs ->
        spyOn app, 'onDeviceReady'
        app.initialize()
        helper.trigger window.document, 'deviceready'
      waitsFor ->
        app.onDeviceReady.calls.length > 0
      , 'onDeviceReady should be called once', 500
      runs ->
        expect(app.onDeviceReady).toHaveBeenCalled()

  describe 'onDeviceReady', ->
    it 'reports that it fired', ->
      spyOn app, 'receivedEvent'
      app.onDeviceReady()
      expect(app.receivedEvent).toHaveBeenCalledWith 'deviceready'

  describe 'receivedEvent', ->
    beforeEach ->
      el = document.getElementById('stage')
      el.innerHTML = """
        <div id="deviceready" class="event-listener">
          <button class="btn btn-block listening">Connecting to Device</button>
          <button class="btn btn-block received">Device is Ready</button>
        </div>
      """

    it 'hides the listening element', ->
      app.receivedEvent 'deviceready'
      displayStyle = helper.getComputedStyle('#deviceready .listening', 'display')
      expect(displayStyle).toEqual 'none'

    it 'shows the received element', ->
      app.receivedEvent 'deviceready'
      displayStyle = helper.getComputedStyle('#deviceready .received', 'display')
      expect(displayStyle).toEqual 'block'
