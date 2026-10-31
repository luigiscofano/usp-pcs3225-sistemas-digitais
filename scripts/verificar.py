from pathlib import Path
import os, subprocess, shutil

root = Path(__file__).resolve().parents[1]
os.chdir(root)
Path("build").mkdir(exist_ok=True)
iverilog = os.environ.get("IVERILOG", "iverilog")
vvp = os.environ.get("VVP", "vvp")
extra = ["-B", os.environ["IVL_BASE"]] if os.environ.get("IVL_BASE") else []
rtl = sorted(str(p) for p in Path("rtl").rglob("*.sv"))
for top in ["digitais_tb", "riscv_tb"]:
    subprocess.run(
        [
            iverilog,
            *extra,
            "-g2012",
            "-Wall",
            "-s",
            top,
            "-o",
            f"build/{top}.vvp",
            *rtl,
            f"tests/{top}.sv",
        ],
        check=True,
    )
    subprocess.run([vvp, f"build/{top}.vvp"], check=True, timeout=90)
