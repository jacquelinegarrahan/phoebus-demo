import argparse
import time
from pcaspy import Driver, SimpleServer, driver, cas
from pcaspy.tools import ServerThread

class myDriver(Driver):
    def  __init__(self):
        super(myDriver, self).__init__()

        # fix the invalid bug
        for pv in self.pvDB:
            self.setParam(pv, self.pvDB[pv].value)


if __name__ == "__main__":

    pvdb = {}

    for i in range(1, 8):
        print("Serving...")
        pvname=f"PV{i}"
        pvdb[pvname] = {
                        "type": "float",
                        "value": 0.0,
                        "hihi": 10.0,
                        "high":  5.0,
                        "low": -5.0,
                        "lolo": -10.0
                    }

    server = SimpleServer()
    server.createPV("DEMO" + ":", pvdb)
    driver = myDriver()

    try:
        while True:
            server.process(0.1)
    except KeyboardInterrupt:
        print("Shutting down server...")
