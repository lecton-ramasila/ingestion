import os
import click

@click.command()
@click.option('--chunks', default=10, help="Number of chunks")
def write_summary(chunks):
    """Write a markdown summary for GitHub Actions."""
    summary_file = os.environ.get("GITHUB_STEP_SUMMARY")

    markdown = f"""
## Total Chunks: {chunks}

### Notes
- This is a markdown summary.
- Can include tables, headers, lists.
"""

    # Always print to console for immediate visibility
    click.echo(markdown.strip())

    # Also write to GitHub Actions summary if env variable is set
    if summary_file:
        with open(summary_file, "a", encoding="utf-8") as f:
            f.write(markdown.strip() + "\n")

if __name__ == "__main__":
    write_summary()

