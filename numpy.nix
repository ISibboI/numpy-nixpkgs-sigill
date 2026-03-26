final: prev: {
  python3 = prev.python3.override {
    packageOverrides = pyFinal: pyPrev: {
      numpy = pyPrev.numpy.overrideAttrs (old: {
        # Optional: NumPy's Meson options (example)
        mesonFlags = (old.mesonFlags or []) ++ [
          "-Dcpu-baseline=native"
          "-Dcpu-dispatch=none"
        ];
      });
    };
  };
}
