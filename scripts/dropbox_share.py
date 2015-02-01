from getpass import getuser
from subprocess import Popen
from sys import argv, platform

from cronos import cronos
from dropbox import client

c = cronos.Cronos()

APP_KEY = c.get('APP_KEY')
APP_SECRET = c.get('APP_SECRET')
ACCESS_TOKEN = c.get('ACCESS_TOKEN')


class SharePublicUrl:

        def __init__(self, access_token):
            if self.get_osType() == 'osx':
                self.dropbox_path = '/Users/{0}/Dropbox'.format(getuser())
            else:
                self.dropbox_path = '/home/{0}/Dropbox'.format(getuser())
            self.public_path = '/Public/'
            self.dropbox_public_path = self.dropbox_path + self.public_path
            self.access_token = access_token
            try:
                self.client = client.DropboxClient(self.access_token)
            except:
                flow = client.DropboxOAuth2FlowNoRedirect(
                    APP_KEY, APP_SECRET)
                authorize_url = flow.start()
                authorize_url = flow.start()
                print '1. Go to: ' + authorize_url
                print '2. Click "Allow" (you might have to log in first)'
                print '3. Copy the authorization code.'
                code = raw_input("Enter the authorization code here: ").strip()
                new_access_token, user_id = flow.finish(code)
                print 'Save this token!'
                print 'Please remove db.cronos and rerun'

        def upload(self, full_path, name):
            f = open(full_path, 'rb')
            response = self.client.put_file(self.public_path + name , f)

        def copy(self, file_path):
            # Can be used later for directories
            try:
                cmd = 'cp -r {0} {1}'.format(file_path, self.dropbox_public_path)
                Popen(cmd.split())
            except:
                raise Exception('Error copying file to Dropbox Public path')

        def share(self, full_path, name):
            up_resp = self.upload(full_path, name)
            response = self.client.share(self.public_path + name)
            return response['url']

        def get_osType(self):
            if 'linux' in platform:
                return 'linux'
            elif 'darwin' in platform:
                return 'osx'


if __name__ == '__main__':
    usage = 'usage: puburl [file | directory]'
    if len(argv) != 2:
        print usage
    else:
        path = argv[1]
        name = path.split('/')[-1]
        s = SharePublicUrl(ACCESS_TOKEN)
        url = s.share(path, name)
        print url
