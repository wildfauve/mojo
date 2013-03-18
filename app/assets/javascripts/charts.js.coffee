$ ->
	years_chart = {
		chart: {
			renderTo: '',
			type: 'bar'
     	},
		title: {
			text: ''
		},
		subtitle: {
			text: 'Source: www.moj.govt.nz'
			},
		xAxis: {
			categories: ['Male', 'Female'],
			title: {
				text: null
			}
		},
		yAxis: {
			min: 0,
			title: {
				text: 'Crime (numbers)',
				align: 'high'
			},
			labels: {
				overflow: 'justify'
			}
		},
		tooltip: {
			formatter: ->
				'' + @series.name +': '+ @y
		},
		plotOptions: {
			bar: {
				dataLabels: {
					enabled: true
				}
			}
		},
		legend: {
			layout: 'vertical',
			align: 'right',
			verticalAlign: 'top',
			x: -100,
			y: 100,
			floating: true,
			borderWidth: 1,
			backgroundColor: '#FFFFFF',
			shadow: true
		},
		credits: {
			enabled: false
		},
		series: [{
			name: 'Year 2005',
			data: [1, 1]
		}]
	}
	# chart = new Highcharts.Chart(years_chart)
	year_req = $.ajax({url: '/api/crimeaggregations/by_year.json'})
	year_req.done (data) ->
		series_gender = []
		series_offence = []
		# This is not really right as the categories are assumed to be in order
		$.each(data.years, (i, year) -> 
			gen_data = []
			off_data = []
			$.each(year.genders, (i2, gender) -> 
				gen_data.push(gender.count))
			series_gender.push({name: year.title, data: gen_data})
			$.each(year.offences, (i2, offence) -> 
				off_data.push(offence.count))
			series_offence.push({name: year.title, data: off_data}))
		years_chart.series = series_gender
		years_chart.xAxis.categories = data.gender_cats
		years_chart.chart.renderTo = 'year_gender'
		years_chart.title.text = 'Crime by Genders per year'
		chart = new Highcharts.Chart(years_chart)
		
		years_chart.xAxis.categories = data.offence_cats
		years_chart.chart.renderTo = "year_offence"
		years_chart.series = series_offence
		years_chart.title.text = 'Crime by Offences per year'		
		chart = new Highcharts.Chart(years_chart)