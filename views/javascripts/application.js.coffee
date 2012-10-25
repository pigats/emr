class Canvas
  constructor: ->
    @width = $(window).width()
    @height = $(window).height() 
    @size = 10

    @svg = d3.select('#days').append('svg')
      .attr('width', @width)
      .attr('height', => @size*30)


class HashtagsViz extends Canvas
  constructor: (hashtag_data) ->
    super()
    @hashtags = hashtag_data
    @normalize()
    
  normalize: ->
    #max = d3.max(@hashtags.map (h)-> h['count'])
    max = []
    (hashtag['hours_count'].forEach((h) -> max.push h['count'])) for hashtag in @hashtags
    max = d3.max(max)
    @opacity_ratio = d3.scale.linear()
      .domain([0,max/5])
      .range([0.05,1])
    console.log max

  draw: ->
    size = @size

    g = @svg.selectAll('.hour')
      .data(@hashtags)
      .enter().append('g')
      .attr('transform', (h, i) -> "translate(#{i*size}, 0)")
      .attr('title', (h) -> h['hashtag'])
      .attr('stroke', '#ccc')
      #.selectAll('text')
      #.enter().append('text')
      #.text( (hashtag) -> hashtag['hashtag'])
    g.selectAll('rect')
      .data( (hashtag) -> hashtag['hours_count'])
      .enter().append('rect')
      .attr('height', size)
      .attr('width', size)
      .attr('y', (hour, i) -> i*size)
      .style('opacity', (hour) => @opacity_ratio(hour['count']))
      .style('fill', 'f00')


class Day
  constructor: ->





$ ->
  $('g').tipsy({fade: true, gravity: 'sw', live: true })

  d3.json "/data/20110211.json", (hashtag_data) =>
    c = new HashtagsViz(hashtag_data)
    c.draw()
  #d3.json "/data/20110212.json", (hashtag_data) =>
  #  c = new HashtagsViz(hashtag_data)
  #  c.draw()
  #d3.json "/data/20110213.json", (hashtag_data) =>
  #  c = new HashtagsViz(hashtag_data)
  #  c.draw()
  #d3.json "/data/20110214.json", (hashtag_data) =>
  #  c = new HashtagsViz(hashtag_data)
  #  c.draw()
  #d3.json "/data/20110215.json", (hashtag_data) =>
  #  c = new HashtagsViz(hashtag_data)
  #  c.draw()
  #d3.json "/data/20110216.json", (hashtag_data) =>
  #  c = new HashtagsViz(hashtag_data)
  #  c.draw()
  #d3.json "/data/20110217.json", (hashtag_data) =>
  #  c = new HashtagsViz(hashtag_data)
  #  c.draw()