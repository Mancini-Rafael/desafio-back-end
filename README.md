## Rails CNAB Test

- **Ruby:** 2.4

Other packages versions can be found at the [```Gemfile```](Gemfile)

### PROJECT DESCRIPTION
- This project implements a simple crud application (with github oauth authentication) that allows users to upload CNAB files
and view the exported information on their profiles.

### Installing
- The project uses docker and docker-compose to unify all dependencies. To set up, run:
``` bash
  bin/docker_setup.sh
  docker-compose up
```

### Using
- To run the project you can use either
``` bash
  docker-compose up
```
or if you want to enable STD_IN (for debugger for example)
``` bash
  docker-compose run --service-ports --rm app
```
- Commands in general can be run with ```docker-compose run --rm app COMMAND```
- Look at the [```bin/docker_entrypoint.sh```](bin/docker_entrypoint.sh) for examples of commands.


### Testing
- The test suite uses RSPEC for functionality testing and Rubocop for lint quality:
  - Lint (code quality/syntax errors)
  - Tests (models/controllers/callbacks)
- Using docker-compose:
  - docker-compose run app lint
  - docker-compose run app test