#!/usr/bin/python
# -*- coding: utf-8 -*-

from BaseHTTPServer import *
from urlparse import urlparse

class KRKHttpRequestHandler(BaseHTTPRequestHandler):
    
    #def __init__(self, arg):
    #    super(KRKHttpRequestHandler, self).__init__()
    #    self.arg = arg

    def do_GET(self):
        self.write_log_message()
        params = self.create_params(self.path)
        status = 200
        if 'status' in params:
            status = int(params['status'])
        type = 'text/plain'
        if 'type' in params:
            type = '/'.join(params['type'].split('-')) 
        self.do_GET_Response(type, status)
        

    def do_POST(self):
        self.write_log_message()
        self.do_POST_Response('text/plain', '<?xml version="1.0" encoding="UTF-8"?>')

    
    def create_params(self, path):
        self.log_message('param : path = %s' %(path))
        params = {} 
        try:
            param_pairs = self.url_parse()
            self.log_message("param_pair : %s" %(param_pairs))
            param_array = []
            for param_pair in param_pairs:
                param_array.append(param_pair.split('='))
            self.log_message("param_array : %s" %(param_array))
            params = dict(param_array)
        except Exception, e:
            self.log_message("raise error : %s" %(e))
            raise e
        finally:
            self.log_message('create_params : return = %s' %(params))
            return params
    

    def url_parse(self):
        parsedURL = urlparse(self.path)
        param_pairs = parsedURL.query.split('&')
        return param_pairs


    def do_GET_Response(self, type, status = 200):
        self.log_message('type = %s, status = %d' %(type, status))
        if status >= 400:
            self.send_error(status)
        else:
            self.send_response(status)
            self.send_header('Content-Type', type)
            body = 'hello world !!'
            if type.find('image') != -1:
                body = (open('./Icon.png', 'rb').read())
            elif type.find('html') != -1:
                body = '<html><head><title>test</title></head><body>hello world!!</body></html>'
            else:
                body = '<?xml version="1.0" encoding="UTF-8"?>'
            self.send_header('Content-Length', str(len(body)))
            self.end_headers()
            self.wfile.write(body) 


    def do_POST_Response(self, type, body):
        self.send_response(200)
        self.send_header('Content-Type', type)
        length = int(self.headers['Content-Length'])
        self.send_header('Content-Length', str(length))
        self.log_message('read : %s' %(str(self.rfile.read(length))))
        self.end_headers()
        #self.wfile.write("%s \n %s" %(body, str(self.rfile.read(length)))) 


    def write_log_message(self):
        #self.do_GET_Response('text/plain', '<?xml version="1.0" encoding="UTF-8"?>', int(self.path.strip('/')))
        self.log_message("command : %s" %(self.command))
        self.log_message("client_address : %s" %(str(self.client_address)))
        self.log_message("path : %s" %(self.path))
        self.log_message("request_version : %s" %(self.request_version))
        self.log_message("server_version : %s" %(self.server_version))
        self.log_message("sys_version : %s" %(self.sys_version))
        self.log_message("protocol_version : %s" %(self.protocol_version))
        self.log_message("version_string() : %s" %(self.version_string()))
        self.log_message("log_date_time_string() : %s" %(self.log_date_time_string()))
        self.log_message("address_string() : %s" %(self.address_string()))
        self.log_message("headers : %s" %(str(self.headers)))



if __name__ == '__main__':
    address = ('', 8080)
    httpd = HTTPServer(address, KRKHttpRequestHandler)
    httpd.serve_forever()
    print('Press to Ctrl + C Key.')

