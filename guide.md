# Automation Demo

## Scenario

You have to take over a software project from a colleague.
You are aware, that it has not been well maintained in the past and is probably containing a lot of security problems.

Your task is to use the power of security automation to detect and remediate security issues in the application.

## Environment

All tasks have been developed and tested on a Linux system using Ubuntu 20.04.
While it is probably possible to solve all tasks on a different system, it is suggested to prepare a (virtual) machine using that OS.

## Tasks

There is a series of tasks, each is adding a new piece to your pipeline and is helping you fix a problem.

After each task, your CI pipeline should run successfully and display a green checkmark icon.

### Task 0: Setup

The application is developed using Java/OpenJDK 11 and Maven, and deployed as a Docker image.
In order to run it, you will have to install the following packages:

     sudo apt-get install maven docker.io openjdk-11-jdk-headless

You will also need an editor.
We suggest using *VS Code* for this, but any text editor will do.

Now the system should have everything it needs.
Unzip the source code and bootstrap a new git repository from it.
Follow the instructions in the README file to build and run the application.

We are using [GitHub Actions][1] as a CI system. So next you need to create a GitHub repository and push your local repo into it.

There is already a preliminary CI configuration in place. 
Navigate to the *Actions* tab in your GitHub repo and observe the software being built successfully after the push.

### Task 1: Testing

If you look at the documentation and the CI configuration, you will notice that unit tests have been disabled.
Your predecessor apparently did not spend enough time to fix them and thus started ignoring them.

1. Update the README and the CI configuration, so that all unit tests are run by the pipeline
2. Run the test in a separate *job* and set the dependencies between the jobs
3. Fix all broken unit tests

### Task 2: Linting

*Linting* is a form of static analysis that helps you ensure that your code follows best practices.
Adding it to your pipeline helps you prevent bugs and security issues.

1. Add a linter for your Java code to the CI pipeline. Use the [Maven Prettier Plugin][2] for that.
2. Add a [Hadolint][3] action to your pipeline, which looks for issues in your `Dockerfile`.
3. Set the dependencies in your pipeline: The application/the docker image must not be built, if the linter is finding a problem.
4. Fix all issues pointed out by the linter.

### Task 3: SAST

Linters are mostly looking for style issues, while a proper SAST tool will be able to find a lot more security issues in your code.
One SAST tool that is very usable in CI-systems due to its speed is [Semgrep][4].
Semgrep can be configured with different [rulesets][5] to look for different things.

1. Add a [Semgrep Action][5] to your code, which scans it for security issues
2. Configure a proper list of [rulesets][5] for your action that are appropriate for the software. This list should include at least `p/java p/secrets p/security-audit p/dockerfile p/ci`
3. Fix all issues identified by Semgrep.

### Task 4: Dependency Check

[Trivy][6] is a tool, which can check applications and Docker images for existing 3rd party components with known vulnerabilities.
Running it periodically helps you understand the attack surface of your application.

1. Add a [Trivy action][7] to your CI pipeline
2. Configure it, so that it only fails the build for *HIGH* and *CRITICAL* vulnerabilities.
3. Fix all issues in you Docker image. HINT: Observe the base image and the [way you build your image][8].
4. Update all dependencies in the Maven configuration.

[1]: https://github.com/features/actions
[2]: https://github.com/HubSpot/prettier-maven-plugin
[3]: https://github.com/marketplace/actions/hadolint-action
[4]: https://semgrep.dev
[5]: https://semgrep.dev/docs/semgrep-ci/overview/#github-actions
[6]: https://aquasecurity.github.io/trivy/latest
[7]: https://aquasecurity.github.io/trivy/latest/docs/integrations/github-actions/
[8]: https://docs.docker.com/develop/develop-images/multistage-build/
