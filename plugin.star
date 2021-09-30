def main(ctx):
  pipelines = [
      {
      "kind": "pipeline",
      "name": "build",
      "steps": [
        {
          "name": "check PR title",
          "image": "alpine:latest",
          "commands": ["echo 'Checking PR title'"]
        },
        {
          "name": "check commit message",
          "image": "alpine:latest",
          "commands": ["echo 'Checking commit message: " + ctx.build.message + "'"]
        },
        {
          "name": ctx.input.stepName,
          "image": ctx.input.image,
          "commands": ctx.input.commands
        }
      ]
    },
    {
      "kind": "pipeline",
      "name": "some-parallel-pipeline",
      "steps": [
        {
          "name": "some-step",
          "image": "alpine:latest",
          "commands": ["echo 'Running step in parallel pipeline...'"]
        }
      ]
    }
  ]
  if ctx.input.lastStep == True:
    pipelines[0].get("steps").append({
      "name": "last-step",
      "image": "alpine:latest",
      "commands": ["echo 'Running last step ...'"]
    })
  return pipelines