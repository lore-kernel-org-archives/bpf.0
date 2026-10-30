Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793392049;
	b=0RUr7+VdZjlCKx/l3gQDnuOFbupjwlVsoCDLCNc0aX4wQmxZExY46Em/o9Of+2cwWkas
	 mh9kT9eLzU3B0IYfjgohc0EiAUo1mH7/+LCRfPkTOw5plxxXwiF/jELPBSRuhIfg0L5/3
	 Lt3M/2bPeGH5kISz23Ss92rtbt1lu8wgxh18roM6MO2WoKn8UWk3GrI0ZBaoNwiM5ixsi
	 gZFdy+iw7AZ0M0Z2Gc6RDhttn/3UkwP0qb2xA8FVq4uYDAcg35pbp+iFbDgokY1ukkkaD
	 sS6xOMmjVnym8sIaye3VCOr3pwN1C6aQ7Vfi1FWjcElRsJ9LOfB2TQbL5kaATPNWyJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=5lyHfD9gDVe46qmCqsjdgsoBvqJkPXERQXV0cBBlSa4=;
	b=J2zeGo46cZo3/vqTWEVlEXcVou1E5E1ydy68ZNNZzdeFxAMNbyFAKfzhSy4vAY/X+N1U
	 hlBHSOc6PKb6tNpKiCZz7dcRGh73LAKldyMZn+QTVSQYiHNrA/Ip/QjddtLXGTbtRjgYW
	 Q9OCtlrL/dsr89Sl42k8Uu7igylMjeErYHD1I705jjAAtzimETe703BJ7dKIOuxx0XGbJ
	 5ZLOikVT/nwOeE+sIKR9qxud7S3QLDpUwUDqTpEg3yaWDzvi7cdVJ1/DPRyJeCwmoFWpJ
	 cKtm9B7Rk8y3vbYs85eCK0ITOnI6Y0wdt0x9aAjIYja/cbdb79RtCRSODO8VzHWzBHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="F5F/X96P";
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B68606A31E
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 20:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33B68606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=F5F/X96P
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1663fb7e005so1375058c88.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 13:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793392047; x=1793996847; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5lyHfD9gDVe46qmCqsjdgsoBvqJkPXERQXV0cBBlSa4=;
        b=F5F/X96P1iqUjyleF+j+g+WMxCXe8TUdoAZ9XNl+xhg6eBka4wv1Je+Fp8Acg1oyi0
         pcRS08rsh5H8DOB4G0zbvClmRh6T3oKDS5qXv1tMV6k1Nwf9AdWosKfnO4cq9esqjjp/
         iroU6gt2PY/vbz4JDwzwzQwy7ZdLQVw+IYMILW+FWPvHx1wd8yFWV7rCERIPgfexW7dF
         gzxLi7Dz7rAJwAkUvRQNLbUP9LPN4mdgOMJxJSDpj/bQEMaDxf/U/pNy5eOyJ2XBYkXi
         ICBIwL9mst9ncb13ysGM6hO1jj2up3SkvMxRqkYBqhQYxF5ysalWZ6MHNZDB+eBgoi05
         FvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793392047; x=1793996847;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5lyHfD9gDVe46qmCqsjdgsoBvqJkPXERQXV0cBBlSa4=;
        b=l/sxSVlhXw7wA0cYMSGSWOxnPPmCcQ1XWAg9VYEVGKRT1ZSBlWNP3YkkiUH8AO+bc5
         JGmKZvAmleN+IqiHHBrVFX+SFPC7b8uPNJhtty/y/ZoZC0elJulM+++qAGrOA669gory
         AI+49DAHoa96r6UVfBO7SGrC+YXhTVx5N6zuJSY1V6/o4hKT2+Awng+Qmvv70ZXBurth
         aMMb0FgM69Im8X1RZuKJRZRkRsMJs+tstvZ+yuRWXRoEVT4f3qzylg+d0qUv1BsvEirV
         9UVwnvQwp8UoHs+90ac7QOIfv/g9aWeUbvP/3sVXlOxrF6qmbdFZD2PX3V8QqR94PkKf
         ocUA==
X-Forwarded-Encrypted: i=1; AKwUvByZ9c2naGCQ0vESd4KTJf0t9GvgGHRTxLNeP2LdWyEuZyi3z6Zmw3CkG3KtqR4cbmgqouw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJg+Kn4HdNvoGqay9VZ6++eYXrjYGkep92mqvsIR1dtiVafyuRB
	g7JJITXByZnjGAeJjAI1zhyOeIAD7iYCJpQWP9d+GfEJJzws8KjJGR3fTZDLiqauKJs4ZOCAEzD
	wwMz0a53BhQ==
X-Received: from dlbtp7.prod.google.com ([2002:a05:7022:3b87:b0:15f:5ef4:b896])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1602:b0:1a8:4997:65f6
 with SMTP id a92af1059eb24-1ac5d88c579mr6176377c88.20.1793392046539; Fri, 30
 Oct 2026 13:27:26 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:27:07 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261030202710.3863806-1-irogers@google.com>
Subject: [RFC PATCH v2 0/3] tools: Add Rust library build infrastructure and
 prefer zlib-rs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Quentin Monnet <qmo@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The zlib-rs project (https://github.com/trifectatechfoundation/zlib-rs)
provides a memory-safe, high-performance Rust implementation of the zlib
compression specification along with a C ABI layer (libz-rs-sys) that is a
drop-in replacement for the standard C zlib library. Transitioning
decompression of kernel configuration files (/proc/config.gz), compressed
ELF/BTF sections, and perf data from C zlib to zlib-rs improves both memory
safety and decompression performance.

On many Linux distributions (such as Debian, Ubuntu, and Fedora), Rust
crates like zlib-rs and libz-rs-sys are packaged as Cargo registry sources
under /usr/share/cargo/registry/ (e.g. librust-libz-rs-sys-dev or
rust-libz-rs-sys-devel) rather than as prebuilt C shared libraries, while
other environments may install prebuilt libz_rs libraries via pkg-config or
a custom prefix (LIBZ_RS_DIR).

This RFC series lays the groundwork for building and linking Rust crate
libraries in tools/ offline from the system Cargo registry and integrates
zlib-rs support into perf and bpftool, preferring zlib-rs over C zlib when
available:

1. **tools build: Add Rust library build infrastructure and zlib-rs feature test**:
   - Adds `tools/build/Makefile.rust` with helpers to resolve C compiler and
     linker flags for Rust libraries via `%-cflags` and `%-libs` targets.
   - Resolves `zlib-rs` compiler and linker flags via `LIBZ_RS_DIR`,
     `pkg-config` (`libz-rs-sys-cdylib`, `zlib-rs`, `z_rs`), or building
     `libz_rs.a` (with the `export-symbols`, `c-allocator`, `std`, and `gz`
     features) into `$(OUTPUT)libz_rs/` from `/usr/share/cargo/registry`
     using offline Cargo (`cargo metadata --offline` and
     `cargo build --offline`).
   - Adds `tools/build/feature/test-zlib-rs.c` checking
     `ZLIB_VER_SUBREVISION == 15` (`0xf`, which distinguishes
     `libz-rs-sys`'s `zlib.h` from standard C `zlib.h`) and linking against
     `inflateInit()`.
   - Extends `tools/scripts/Makefile.include` with cross-compilation target
     triples (`RUST_TARGET_FLAGS_<arch>`) and the `feature_rust_lib` macro.

2. **perf build: Prefer zlib-rs over zlib when available**:
   - Moves Rust detection ahead of zlib detection in
     `tools/perf/Makefile.config` and prefers `zlib-rs` over C `zlib` unless
     `NO_ZLIB_RS=1` (or `NO_ZLIB=1` / `NO_RUST=1`) is set.
   - Defines both `HAVE_ZLIB_SUPPORT` and `HAVE_ZLIB_RS_SUPPORT` when
     `zlib-rs` is used so existing zlib call sites in `perf` work unchanged
     while `perf version --build-options` and `perf check feature zlib-rs`
     report whether `zlib-rs` is active.
   - Shares `$(OUTPUT)libz_rs/` with the host bootstrap `bpftool` build in
     `tools/perf/bpf_skel.mak` and adds `NO_ZLIB` / `NO_ZLIB_RS` tests to
     `tools/perf/tests/make`.

3. **bpftool: Prefer zlib-rs over zlib when available**:
   - Adds `zlib-rs` and `zlib` to `FEATURE_TESTS` and `FEATURE_DISPLAY` in
     `tools/bpf/bpftool/Makefile` and configures `ZLIB_CFLAGS` and
     `ZLIB_LIBS` via `feature_rust_lib` when `zlib-rs` is detected.

Changes in v2:
- Use offline Cargo (`cargo metadata --offline` and `cargo build --offline`
  configured against `CARGO_REGISTRY_DIR` = `/usr/share/cargo/registry` and
  isolated from `~/.cargo`) to resolve crate versions, dependency graphs,
  features, and build scripts instead of manually globbing crate directory
  names and invoking `rustc` on hardcoded `.rlib` edges (Miguel Ojeda).
- Avoid including `../../scripts/Makefile.arch` in `tools/bpf/bpftool/Makefile`
  (to keep the standalone bpftool mirror self-contained) by placing
  `RUST_TARGET_FLAGS_<arch>` in `tools/scripts/Makefile.include`, and expand
  the bpftool commit message on the security and performance motivation for
  preferring `zlib-rs` (Quentin Monnet).
- Drop unused `.rlib` pattern rules and helpers from `tools/build/Build.include`
  and `tools/build/Makefile.build` (Sashiko).
- Address Sashiko review feedback on `PKG_CONFIG` handling when unset or with
  `-static`, `test-all.bin` re-checking `zlib-rs` and `rust`, preserving
  `EXTRA_CFLAGS` optimization defaults when building `libbpf.a`, and
  honoring `NO_ZLIB_RS=1` in `bpftool` when `FEATURES_DUMP` is used.

AI Assistance Disclosure (per Documentation/process/coding-assistants.rst
and Documentation/process/generated-content.rst):
- Tools used: Antigravity coding assistant and Sashiko automated patch
  review using Gemini 4 LLMs.
- Summary of prompts and assistance: Interactive pair-programming session to
  identify distro packaging for zlib-rs/libz-rs-sys, implement the zlib-rs
  feature test and offline Cargo build rules in Makefile.rust, integrate
  zlib-rs detection into perf and bpftool, separate Rust library outputs
  into $(OUTPUT)libz_rs/, and address reviewer and automated Sashiko
  feedback.
- Testing performed: Built and tested perf and bpftool with zlib-rs
  (default), NO_ZLIB_RS=1 (fallback to C zlib), NO_ZLIB=1, and MINIMAL=1;
  verified `perf version --build-options`, `perf check feature`, and the
  `make_no_zlib` / `make_no_zlib_rs` tests in `tools/perf/tests/make`; and
  checked all commits with `scripts/checkpatch.pl`.

Ian Rogers (3):
  tools build: Add Rust library build infrastructure and zlib-rs feature
    test
  perf build: Prefer zlib-rs over zlib when available
  bpftool: Prefer zlib-rs over zlib when available

 tools/bpf/bpftool/.gitignore             |   1 +
 tools/bpf/bpftool/Makefile               |  57 +++++++++-
 tools/build/Makefile.feature             |  12 +-
 tools/build/Makefile.rust                | 160 +++++++++++++++++++++++
 tools/build/feature/.gitignore           |   1 +
 tools/build/feature/Makefile             |  11 +-
 tools/build/feature/test-zlib-rs.c       |  19 +++
 tools/perf/.gitignore                    |   1 +
 tools/perf/Documentation/perf-check.txt  |   1 +
 tools/perf/Makefile.config               |  88 +++++++------
 tools/perf/Makefile.perf                 |  32 ++++-
 tools/perf/bpf_skel.mak                  |   8 +-
 tools/perf/builtin-check.c               |   1 +
 tools/perf/scripts/install-build-deps.sh |   6 +
 tools/perf/tests/make                    |   9 ++
 tools/scripts/Makefile.include           |  25 ++++
 16 files changed, 382 insertions(+), 50 deletions(-)
 create mode 100644 tools/build/Makefile.rust
 create mode 100644 tools/build/feature/test-zlib-rs.c

-- 
2.56.0.317.g454f8302e1-goog

