
import web, settings, z3, cgi

urls = (
    '^/$', 'index',
	'^/exclusive$', 'exclusive',
	'^/dashboard$', 'dashboard',
	'^/upload$', 'upload',
	'^/upload\.bin$', 'upload_bin',
	'^/demos$', 'demos',
	'^/docs$', 'docs',
	'^/live$', 'live',
	'^/about$', 'about'
)

app = web.application(urls, globals())
render = web.template.render(settings.TEMPLATE_FOLDER, base='base')

class index:
	def GET(self):
		return render.index(settings.SERIAL_PORTS)

class exclusive:
	def POST(self):
		raise web.seeother('/dashboard')

class dashboard:
	def GET(self):
		return render.dashboard()

class upload:
	def GET(self):
		return render.upload()
	def POST(self):
		raise web.seeother('/dashboard')

class upload_bin:
	def  GET(self):
		return render.upload()
	def POST(self):
		cgi.maxlen = settings.MAX_UP_FILE_SIZE

		input = web.input(file={})
		if input.file.file:
			web.debug('Writing uploaded data to the module')
			z3.write_serial(0, input.file.file.read())
			raise web.seeother('/dashboard')
		raise web.seeother('/dashboard')

class demos:
	def GET(self):
		import os
		files = os.listdir('static/samples')
		return render.demos(files)

class docs:
	def GET(self):
		return render.docs()

class live:
	def GET(self):
		return render.live()

class about:
	def GET(self):
		return render.about()

if __name__ == "__main__":
    app.run()

