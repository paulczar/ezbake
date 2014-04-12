EZ-Bake
=====

`EZ Bake` came from an idea I had while watching the [HangOps](https://twitter.com/hangops) [episode 2014-04-11](https://www.youtube.com/watch?v=clLFKIeSADo&feature=youtu.be).  

EZ bake takes chef solo recipes designed for chef-solo in a tarball via `stdin` and converges a docker node using that recipe.

In order to recognize and run your cookbook ( or repo ) it needs to contain the following files: `Berksfile`, `solo.json`, 'solo.rb' in the root of your cookbook.   There is some provision for providing different locations for these via environment variables.  See `./ezbake` if you wish to do this.

Once the container is converged you can save it off to an image by running `docker commit`

This could easily be built into a CI pipeline.   a git webhook can call jenkins which would clone the repo and then use a command like  `git archive master | docker run -i -a stdin paulczar/ezbake` to converge a container from it.  

Building
=====
```
$ git clone paulczar/ezbake
$ cd ezbake
$ sudo docker build -t ezbake .
```

Running
=====

Example 1
----------------

I have provided an example in the ezbake repo that will install Java7 in the container.  

This example shows:

*  Converging a container using a local chef recipe
*  Committing the container to an image on completion
*  Removing the build container
*  Running the new image

```
$ git clone paulczar/ezbake
$ cd ezbake/examples
$ ID=$(tar cf - . | sudo docker run -i -a stdin paulczar/ezbake) \
  && sudo docker attach $ID \
  && sudo docker commit $ID java7 
  && sudo docker rm $ID
$ sudo docker run -t java7 java -version
```

License
=====

Copyright 2014 [Paul Czarkowski](https://twitter.com/pczarkowski)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.