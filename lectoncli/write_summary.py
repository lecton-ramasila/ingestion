import os
import click

def echo_summary(msg: str):
    """Print to console and write to GitHub Actions step summary if available."""
    summary_file = os.environ.get("GITHUB_STEP_SUMMARY")
    # Always print to console
    click.echo(msg)
    # Write to summary if running in GitHub Actions
    if summary_file:
        with open(summary_file, "a", encoding="utf-8") as f:
            f.write(msg + "\n")

@click.command()
@click.option('--chunks', default=10, help="Number of chunks")
def write_summary(chunks):
    """Write a markdown summary for GitHub Actions."""
    echo_summary(f"## Total Chunks: {chunks}\n")
    echo_summary("### Notes")
    echo_summary("- This is a markdown summary.")
    echo_summary("- Can include tables, headers, lists.")

if __name__ == "__main__":
    write_summary()
