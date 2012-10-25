class Canvas
  constructor: ->
    @width = $(window).width()
    @height = $(window).height() 
    @size = 10

    @svg = d3.select('#days').append('svg')
      .attr('width', @width)
      .attr('height', => @size*24+110)


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

  draw: ->
    size = @size

    @svg.append('g')
      .attr('class', 'label')
      .attr('transform', 'translate(0,100)')
      .selectAll('text')
      .data(d3.range(24))
      .enter()
      .append('text')
      .text((d) -> return d)
      .attr('x', size)
      .attr('y', (d) -> (d+2)*size)
      
    @svg.append('g')
      .attr('class', 'label')
      .selectAll('text')
      .data(@hashtags)
      .enter()
      .append('text')
      .text((d) -> return d['hashtag'])
      .attr('x', 100)
      .attr('y', (d, i) -> i*size+50)
      .attr('transform', "rotate(-90 100 100)")

    g = @svg.selectAll('.hour')
      .data(@hashtags)
      .enter().append('g')
      .attr('transform', (h, i) -> "translate(#{(i*size)+40}, 110)")
      .attr('title', (h) -> h['hashtag'])
      .attr('stroke', '#ccc')

    g.selectAll('rect')
      .data( (hashtag) -> hashtag['hours_count'])
      .enter().append('rect')
      .attr('height', size)
      .attr('width', size)
      .attr('y', (hour, i) -> i*size)
      .style('opacity', (hour) => @opacity_ratio(hour['count']))
      .style('fill', 'f00')



class Day
  constructor: (date)->
    @date = date
    return this

  draw: ->
    d3.json "/data/#{@date}.json", (hashtag_data) =>
      hv = new HashtagsViz(hashtag_data)
      hv.draw()




$ ->
  new Day('20110211').draw()
