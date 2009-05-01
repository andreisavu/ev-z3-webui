
import web, settings

urls = (
    '^/$', 'index'
)

app = web.application(urls, globals())
render = web.template.render(settings.TEMPLATE_FOLDER, base='base')

class index:
	def GET(self):
		return render.index()

if __name__ == "__main__":
    app.run()

