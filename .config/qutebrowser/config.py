config.load_autoconfig(False)
c.auto_save.session = True
c.colors.tabs.bar.bg = '#303030'
c.colors.tabs.even.bg = '#2c2c2c'
c.colors.tabs.even.fg = '#f0f0f0'
c.colors.tabs.indicator.stop = '#303030'
c.colors.tabs.odd.bg = '#2c2c2c'
c.colors.tabs.odd.fg = '#f0f0f0'
c.colors.tabs.selected.even.bg = '#4c4c4c'
c.colors.tabs.selected.even.fg = '#f0f0f0'
c.colors.tabs.selected.odd.bg = '#4c4c4c'
c.colors.tabs.selected.odd.fg = '#f0f0f0'
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.contrast = 0.0
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.threshold.background = 205
c.colors.webpage.darkmode.threshold.text = 150
c.colors.webpage.preferred_color_scheme = 'dark'
c.confirm_quit = ['downloads']
c.content.blocking.enabled = True
c.content.blocking.hosts.block_subdomains = True
c.content.blocking.method = 'both'
c.fonts.default_family = ['Ubuntu Sans Bold']
c.fonts.default_size = '11pt'
c.fonts.statusbar = 'default_size default_family'
c.fonts.tabs.selected = 'default_size default_family'
c.fonts.tabs.unselected = 'default_size default_family'
c.scrolling.bar = 'overlay'
c.scrolling.smooth = True
c.tabs.favicons.scale = 1.0
c.tabs.favicons.show = 'always'
c.tabs.padding = {'top': 3, 'bottom': 3, 'left': 5, 'right': 5}
c.tabs.position = 'top'
c.tabs.select_on_remove = 'last-used'
c.tabs.show = 'always'
c.tabs.title.alignment = 'center'
c.tabs.title.format = '{audio} {current_title}'
c.url.default_page = 'https://search.brave.com/'
c.url.searchengines = {'DEFAULT': 'https://search.brave.com/search?q={}'}
c.url.start_pages = ['https://search.brave.com']
c.window.hide_decoration = True
c.zoom.default = '115%'
config.bind('j', 'scroll down')
config.bind('k', 'scroll up')
config.bind('t', 'set-cmd-text -s :open -t')
config.bind('x', 'tab-close')

