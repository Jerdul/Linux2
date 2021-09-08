from scr.app import app

Host='localhost'
Port=4000
Debug=True

if(__name__ == '__main__'):
    app.run(Host, Port, Debug)