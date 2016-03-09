import time, os
import socket, ssl
import datetime
import BaseHTTPServer

VERSION_DEPLOYMENT_ID = os.environ.get('VERSION_DEPLOYMENT_ID', "unknown")
VERSION_DEPLOYMENT_ID = VERSION_DEPLOYMENT_ID.split('/')[-1]
USE_SSL = True if os.getenv('USE_SSL', "0") == "1" else False

class MyHandler(BaseHTTPServer.BaseHTTPRequestHandler):
    def do_HEAD(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        path = self.path.strip('/')
        segments = path.split('/')
        if len(segments) == 2 and segments[0] == "env_var":
            key = segments[1].upper()
            value = os.environ.get(key, "")
            self.wfile.write(value)
            return
        #self.wfile.write("<html><head><title>Hello World From ICE Group1!</title></head>")
        #self.wfile.write("<body>")
        #self.wfile.write("<h2>Hostname: " + socket.gethostname() + "</h2>")
        #self.wfile.write("<h2>Deployment ID: " + VERSION_DEPLOYMENT_ID + "</h2>")
        self.wfile.write("Hello World from ICE Group 1 @ {host}!\n".format(host=socket.gethostname()))
	#self.wfile.write("</body></html>")

if __name__ == "__main__":
    while True:
        try:
            print "Pause for network to initialize at", datetime.datetime.now().isoformat()
            time.sleep(5)
            server_class = BaseHTTPServer.HTTPServer
            port = 443 if USE_SSL else 80
            httpd = server_class(("0.0.0.0", port), MyHandler)
            if USE_SSL:
                httpd.socket = ssl.wrap_socket(httpd.socket, keyfile='/tmp/homestead.key', certfile='/tmp/homestead.crt', server_side=True)
            print time.asctime(), "Server started - %s:%s" % (socket.gethostname(), port)
            try:
                httpd.serve_forever()
            except KeyboardInterrupt:
                pass
            httpd.server_close()
            break
        except Exception, e:
            print "Server failed", e

    print time.asctime(), "Server stopped"
