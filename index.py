
import web, settings

urls = (
    '^/$', 'index',
	'^/exclusive$', 'exclusive',
	'^/dashboard$', 'dashboard',
	'^/upload$', 'upload',
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
	def  GET(self):
		return render.upload()
	def POST(self):
		raise web.seeother('/dashboard')

class about:
	def GET(self):
		return render.about()

if __name__ == "__main__":
    app.run()

