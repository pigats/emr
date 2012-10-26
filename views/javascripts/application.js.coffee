class Canvas
  constructor: ->
    @width = $(window).width()
    @height = $(window).height() 
    @size = 20

    $('svg').empty()

    @svg = d3.select('svg')
      .attr('width', @width)
      .attr('height', => @size*24+250)


class HashtagsViz extends Canvas
  constructor: (date, hashtag_data) ->
    super()
    @date = date
    @hashtags = hashtag_data
    @normalize()


  normalize: ->
    max = []
    (hashtag['hours_count'].forEach((h) -> max.push h['count'])) for hashtag in @hashtags
    max = d3.max(max)
    @opacity_ratio = d3.scale.linear()
      .domain([0,max/5])
      .range([0.05,1])

  draw: ->
    size = @size
    days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']

    @svg.append('g')
      .attr('transform', 'translate(30 170) rotate(-90)')
      .append('text')
      .text( => 
        d = new Date(Date.UTC(parseInt(@date.substr(0,4)),parseInt(@date.substr(4,2)),parseInt(@date.substr(6,2))))
        days[d.getDay()] )
      .attr('class', 'title')
     

    @svg.append('g')
      .attr('transform', 'translate(30 190) rotate(-90)')
      .attr('class', 'label hashtag')
      .selectAll('text')
      .data(@hashtags)
      .enter()
        .append('text')
        .text((d) -> d['hashtag'] )
        .attr('x', 20)
        .attr('y', (d, i) -> (i+1)*size)
    
    @svg.append('g')
      .attr('transform', 'translate(20 510) rotate(-90)')
      .attr('class', 'label')
      .selectAll('text')
      .data(@hashtags)
      .enter()
        .append('text')
        .text((d) -> d['count'] )
        .attr('x', -160)
        .attr('y', (d, i) -> i*size+.8+30)

    @svg.append('g')
      .attr('class', 'label')
      .attr('transform', 'translate(0,140)')
      .selectAll('text')
      .data(d3.range(24))
      .enter()
        .append('text')
        .text((d) -> d)
        .attr('x', 20)
        .attr('y', (d) -> d*size+55)
 
    g = @svg.selectAll('.hour')
      .data(@hashtags)
      .enter().append('g')
        .attr('transform', (h, i) -> "translate(#{i*size+40}, 180)")
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
      hv = new HashtagsViz(@date, hashtag_data)
      hv.draw()


class PageController
  constructor: ->
    window.onhashchange = this.load
    this.load() if window.location.hash isnt ''

  load: ->
    hash = window.location.hash.substr(1)
    try
      new Day(hash).draw() 
      $(".days li").removeClass('active')
      $("##{hash}").addClass('active')

    catch e
      console.log e

       




$ ->
  new PageController()
  
