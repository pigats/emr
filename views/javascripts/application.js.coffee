$ ->
  d3.json '/data/20110211.json', (hashtags) ->
    # console.log(hashtags)
    # Width and height
    w = 600
    h = 700
    padding = 20
    
    # Create SVG element
    svg = d3.select("svg")
          .attr("width", w)
          .attr("height", h)

    svg.append('g')
      .attr('class', 'label')
      .attr('transform', 'translate(0,100)')
      .selectAll('text')
      .data(d3.range(24))
      .enter()
      .append('text')
      .text((d) -> return d)
      .attr('x', 20)
      .attr('y', (d) -> d*20+20)
      
    svg.append('g')
      .attr('class', 'label')
      .selectAll('text')
      .data(hashtags)
      .enter()
      .append('text')
      .text((d) -> return d['hashtag'])
      .attr('x', 100)
      .attr('y', (d, i) -> i*20+50)
      .attr('transform', "rotate(-90 100 100)")

