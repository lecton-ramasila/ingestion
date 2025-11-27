import os
import click

@click.command()
@click.option("--chunks", default=10)
def write_summary(chunks):
    markdown = f"""
## Total Chunks: {chunks}

### Notes
- This is a markdown summary.
- Can include tables, headers, lists.
"""
    click.echo(markdown.strip())
    summary_file = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary_file:
        with open(summary_file, "a", encoding="utf-8") as f:
            f.write(markdown.strip() + "\n")

if __name__ == "__main__":
    write_summary()
