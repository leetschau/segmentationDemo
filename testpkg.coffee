SegDict = new Mongo.Collection('segdict').findOne()
if Meteor.isClient
  Template.hello.helpers
    parseStr: () ->
      Session.get "parseRes"

  Template.hello.events
    'click button': (e, t) ->
      Meteor.call 'parseChn',
        $("#search-box").val(),
        (err, result) ->
          if err
            console.log err
          else
            Session.set "parseRes", result

if Meteor.isServer
  # dict = {}
  # Meteor.startup ->
  #  dict = SegDict
    
  Meteor.methods
    parseChn: (inp) ->
      return Seg.parse inp, SegDict
