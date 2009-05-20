
import web, settings, z3, cgi

urls = (
    '^/$', 'index',
	'^/exclusive$', 'exclusive',
	'^/dashboard$', 'dashboard',
	'^/edit(.*)$', 'edit',
	'^/compile$', 'compile',
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
		raise web.seeother('/dashboard')

class exclusive:
	def POST(self):
		raise web.seeother('/dashboard')

class dashboard:
	def GET(self):
		return render.dashboard()

class edit:
	def GET(self, file):
		if file != None or file != '':
			try:
				content = open("static/samples%s" % file).read()
			except:
				content = ''
		else:
			content = ''
		return render.edit(content)

	def POST(self, str):
		cgi.maxlen = settings.MAX_UP_FILE_SIZE
		input = web.input(file={})
		if input.file.file:
			content = input.file.file.read()
		else:
			content = ''
		return render.edit(content)

class compile:
	def GET(self):
		input = web.input(source='')
		return render.compile(input.source)

class upload:
	def GET(self):
		return render.upload()
	def POST(self):
		raise web.seeother('/dashboard')

class upload_bin:
	def  GET(self):
		return render.uploadbin()
	def POST(self):
		cgi.maxlen = settings.MAX_UP_FILE_SIZE

		input = web.input(file={})
		if input.file.file:
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

