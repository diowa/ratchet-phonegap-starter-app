describe 'app', ->
  describe 'initialize', ->
    it 'should bind deviceready', ->
      runs ->
        spyOn app, 'onDeviceReady'
        app.initialize()
        helper.trigger window.document, 'deviceready'
        return

      waitsFor (->
        app.onDeviceReady.calls.length > 0
      ), 'onDeviceReady should be called once', 500
      runs ->
        expect(app.onDeviceReady).toHaveBeenCalled()

  describe 'onDeviceReady', ->
    it 'should report that it fired', ->
      spyOn app, 'receivedEvent'
      app.onDeviceReady()
      expect(app.receivedEvent).toHaveBeenCalledWith 'deviceready'

  describe 'receivedEvent', ->
    beforeEach ->
      el = document.getElementById('stage')
      el.innerHTML = """
        <div id="deviceready" class="event-listener">'
          <button class="btn btn-block listening">Connecting to Device</button>'
          <button class="btn btn-block received">Device is Ready</button>'
        '</div>'
      """

    it 'should hide the listening element', ->
      app.receivedEvent 'deviceready'
      displayStyle = helper.getComputedStyle('#deviceready .listening', 'display')
      expect(displayStyle).toEqual 'none'

    it 'should show the received element', ->
      app.receivedEvent 'deviceready'
      displayStyle = helper.getComputedStyle('#deviceready .received', 'display')
      expect(displayStyle).toEqual 'block'
