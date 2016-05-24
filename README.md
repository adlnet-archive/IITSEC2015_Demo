# IITSEC2015_Demo
A repo to host the assets and code for the IITSEC 2015 Naval demo

### How to use this repo

We're version controlling the entire data directory for a Sandbox server. This will allow us to keep assets, worlds, metadata and libraries controlled without impacting your regular development. We'll also be able to run the simulation with different branches of the engine.

To run the server with this data directory

1. Check out repo
2. Set the assetDataDir path in your Sandbox config.json to "IITSEC2015_Demo/assets"
3. Start the server with the -d flag
4. use the path to the /data/ directory under this repo

```
c:\development\Sandbox\node app.js -d "c:\development\iitsecDemo_2015\data"
```

**Please be very careful with `git add .`. Only check in changes you intended to make!**

## License
   Copyright &copy;2016 Advanced Distributed Learning

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
