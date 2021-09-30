def main(ctx):
  pipelines = [
      {
      "kind": "pipeline",
      "name": "build",
      "steps": [
        {
          "name": "check-PR",
          "image": "alpine:latest",
          "commands": ["date", "echo 'Checking PR title'"]
        },
        {
          "name": "check-commit",
          "image": "alpine:latest",
          "commands": ["date", "echo 'Checking commit message: " + ctx.build.message + "'"]
        },
        {
          "name": ctx.input.stepName,
          "image": ctx.input.image,
          "commands": ctx.input.commands,
          "depends_on": ["check-PR", "check-commit"]
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
          "commands": ["date", "echo 'Running step in parallel pipeline...'"]
        }
      ]
    }
  ]
  if ctx.input.lastStep == True:
    pipelines[0].get("steps").append({
      "name": "last-step",
      "image": "alpine:latest",
      "commands": ["date", "echo 'Running last step ...'"]
    })
  return pipelines