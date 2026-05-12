Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1E33E172F
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608013; cv=none; b=KKwqaNdqquS9OvCdkGkljTBZlCNuwkevnD4/xhbEhMnyQ9594gUVwj00+QICO0Ak+Cqx9G34TzLkmHapFwAczGyz96OkKnnpV+JpCT1xBvNMdgNSyfTMudQ3vb5aG3COsmbl2P8bFOT+/zWYH6rhaQRDMyGTX7NdJAeinVAc3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608013; c=relaxed/simple;
	bh=6+phfWjzcZiyxfX2+ElE3wO14gQTwke+ldl1zkP7yQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GUhqbT21CLPbC23YyT1m0DEGmAUROofRZ/vlFzQfjAp65L/V/2UaUusUrq8We0jxkxfic4tmfwdalUuqOQDj6QvVdwnXqo2LGE7tvVSrYTENoMqOsxh+vWnRL2YTcSlIFTdZvlvR8LeieqtTmPjmf3TCIzElhKSQJ8CjxShN5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tNTYZl6o; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tNTYZl6o"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13312be8a31so9328578c88.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608011; x=1779212811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCuYHFd13VKIKsq33MQZhh+6mX5Eg/Ufkhv3eevqjRA=;
        b=tNTYZl6oD/th9KPH9/8oDIo53sOZ0IJtgbl+P5xkv7R0cNFMFKm+FmQ6ZQvtIhm97A
         ysV3xgoWO2IltPY8cYEn+FDgchKuqAOL86ZLMiBMrstJkHg87kMyk7fMSuGsDoB/uzGm
         9s19WfYQKIXrZc+1NYHANFXNYJYKesJWWMdgJ9he7EBUAY+ZS4rht6HWtaBMV8IA++px
         OedautzCHkJTSgQ8z9bztJVPA+oLUiS8RuxMxaBIuDLHlnaJv0zba5qYSBGVV4KFD0s/
         DgVamc5qDNM1yTboXj5/AWdpkmcY0rdtkGg9xtlkddTvmayDKj0uOUexat9HLGvKRgHM
         4X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608011; x=1779212811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCuYHFd13VKIKsq33MQZhh+6mX5Eg/Ufkhv3eevqjRA=;
        b=RAJtjs3+dj6DBv/RBbCvLt7FJ6w19gNR9IvdnKFtreMHf7MotHsW7YoFbbys+ANPB6
         s0dh8uE3xmRm7800HNcypOu3Zl+h67SrDvclcAMA3BjIFoottGyH5gbFa3tsElZi8MbE
         lpv6LKMd8eyyv6hhTbyNUXy18W+fB9pbw6SoIXmd0Sog2xXKO84dRjVmRl4Ypw+kbi+F
         mK7UzkxQTOC/zMnm9Od2+WfeHpGRlpPWCzGBUq0yqrRris6FB0HACqdyDVbVdM3TS3yt
         4ckrxGnn4qkMcFGezkfVSWycI8Yif5A0KjHXqMtug/7PQiNi2Xqik/SVR3o7iRhdZ8fL
         L4Kg==
X-Forwarded-Encrypted: i=1; AFNElJ9/Dl8Xs0T3Uu7Y4FVdGUrmaCKpP3Fnzqrc6hbxjzVUp2RujS38gD82cNCHD1gctpdIfmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXmKpC/fsBgVb9Q/Z2EwP7/wEX9oCgTN7Eambjpjs898al/P5x
	kUhdRz/xhQzJQKW3sAOe75MjEpeOTMjtCnofrz/fFwdfUCVqpiB1UBGLJgJcm9xkVZdmg8I3qbd
	DQIwUirpMOw==
X-Received: from dlb13.prod.google.com ([2002:a05:7022:60d:b0:132:8d92:4d7a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2509:b0:130:9bce:c60f
 with SMTP id a92af1059eb24-13271377e33mr11545718c88.14.1778608010940; Tue, 12
 May 2026 10:46:50 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:20 -0700
In-Reply-To: <20260512053539.3410189-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-1-irogers@google.com>
Subject: [PATCH v2 00/18] perf build: Reduce build time by nearly half
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

This patch series refactors Kbuild internals, BPF skeleton generation,
Python AST pre-computation, and foundational tooling dependencies across
the perf tool build system. By eliminating umbrella target synchronization
barriers, decoupling static library prerequisites, parallelizing single-core
script generators, and eradicating redundant feature checks, this series
unlocks absolute theoretical peak multi-core concurrency during Kbuild startup.

On a 28-core build workstation (make -j28 all from scratch), clean build
latency improves by over 46%:

  Before:
    real    0m29.006s
    user    2m46.019s
    sys     0m30.610s

  After:
    real    0m15.655s
    user    2m43.051s
    sys     0m26.437s

Saving 13.3 full seconds time per clean build. Furthermore, nothing to
build incremental builds are improved by nearly 7x:

  Before:
    real    0m11.528s
    user    0m9.633s
    sys     0m6.965s

  After:
    real    0m1.665s
    user    0m1.501s
    sys     0m0.841s

Summary of Patches:

1-4: Foundational Tooling & Fast-Path Feature Detection
  - Exempts bpftool bootstrap from non-essential feature tests (LLVM, libbfd,
    libcap), saving 1.1s of sub-make fork overhead during Kbuild startup.
  - Integrates libdebuginfod directly into test-all.c, allowing Make to skip
    individual feature check sub-make forks during AST parsing on fully
    configured workstations.
  - Fixes test-clang-bpf-co-re.bin feature check to correctly generate its
    target file on disk, allowing Kbuild to perfectly cache the detection result
    and avoid continuous sub-make re-evaluations.
  - Short-circuits CC_NO_CLANG compiler inspection probe in Makefile.include by
    exporting the cached result, eliminating 40+ redundant compiler forks across
    the sub-make hierarchy.

5-7: Flattening Umbrella Prepare Barriers
  - builtin-trace embedded inclusions and pmu-events generation are completely
    decoupled from the sequential "prepare" umbrella target, eliminating Make
    AST double-parsing overhead and unchoking parallel compilation barriers.

8-11: Decoupling & Pre-generating BPF Skeletons
  - BPF skeleton rules are extracted out of Makefile.perf into bpf_skel.mak.
  - Decouples bpftool bootstrap from top-level static libbpf dependencies,
    attaching bpf-skel-prepare directly to the umbrella prepare target. This
    allows Make to pre-compile bpftool and dump vmlinux.h in the background at
    build startup, removing the 7-second serialization bottleneck before BPF
    object compilation.

12-13: Foundational Linkage Optimization
  - Eliminates redundant libbpf sub-make feature checks during static builds.
  - Moves static libsymbol and libbpf library prerequisites out of the prepare step.

14-15: jevents.py Concurrency & Deduplication
  - Splits the massive 2.8 MB big_c_string literal out of pmu-events.c into a
    dedicated pmu-events-string.c compilation unit. This slices C compilation
    latency in half by compiling string and struct tables simultaneously across
    separate CPU cores while preserving zero dynamic ELF relocations.
  - Pre-populates jevents.py JSON ASTs and metric formulas in parallel across
    all available CPU cores using ProcessPoolExecutor (accelerating Python
    execution by 11x, from 3.3s down to ~290ms).

16: Out-of-Tree Incremental Rebuild Fix
  - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to prevent
    Make from continuously re-executing script installation rules on already
    built out-of-tree builds.

17-18: AST Parsing Optimization & Shell Fork Eradication
  - Converts ZENS, ARMS, and INTELS in pmu-events/Build from recursive assignment
    (=) to simply expanded assignment (:=) and replaces model_name/vendor_name
    with pure GNU Make string functions. This guarantees Make executes directory
    probing shell forks exactly once during AST parsing and evaluates path macros
    purely in memory, completely eradicating over 7,800 redundant sub-processes
    during out-of-tree build evaluation.
  - Converts llvm-config shell queries in Makefile.config from recursive assignment
    (=) to simply expanded assignment (:=). This eliminates ~185 redundant sub-processes
    that were previously executed across object compilation dependency checks.

Changes since v1:
  - Reorganized commit order so foundational build system and script infrastructure
    patches precede perf tool refactoring.
  - Added Tested-by tag from James Clark on v1 patches.
  - Eliminated redundant llvm-config shell forks and simply expanded PMU directory
    probing variables, wiping out over 7,800 redundant sub-processes during AST parsing.
  - Fixed test-clang-bpf-co-re.bin feature check caching and short-circuited CC_NO_CLANG
    compiler probes across sub-makes.

Ian Rogers (18):
  bpftool build: Restrict feature tests during bootstrap compilation
  tools build: Integrate libdebuginfod into test-all fast path
  tools build: Fix test-clang-bpf-co-re.bin to generate target file
  tools scripts: Short-circuit CC_NO_CLANG compiler probe in
    Makefile.include
  perf trace beauty: Make beauty generated C code standalone .o files
  perf build: Decouple pmu-events from prepare umbrella target
  perf build: Remove empty archheaders target
  perf build: Move BPF skeleton generation out of Makefile.perf
  perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
  perf build: Move static libbpf dependency out of prepare step
  perf build: Pre-generate BPF skeleton tooling during umbrella prepare
    phase
  perf build: Move libsymbol dependency out of prepare step
  perf build: Remove redundant libbpf feature check for static builds
  perf pmu-events: Split big_c_string storage into standalone
    compilation unit
  perf pmu-events: Parallelize JSON and metric pre-computation in
    jevents.py
  perf build: Prefix SCRIPTS with output directory to fix continuous
    rebuilds
  perf pmu-events: Convert recursive shell assignments and macros to
    Make built-ins
  perf build: Convert llvm-config shell queries to simply expanded
    variables

 tools/bpf/bpftool/Makefile                    |   5 +
 tools/build/Makefile.feature                  |   6 +-
 tools/build/feature/Makefile                  |   4 +-
 tools/build/feature/test-all.c                |   5 +
 tools/perf/Build                              |   2 +
 tools/perf/Makefile.config                    |  19 +-
 tools/perf/Makefile.perf                      | 427 +-----------------
 tools/perf/bench/Build                        |   6 +
 .../bpf_skel/bench_uprobe.bpf.c               |   0
 tools/perf/bench/uprobe.c                     |   2 +-
 tools/perf/bpf_skel.mak                       | 110 +++++
 tools/perf/builtin-trace.c                    |  30 +-
 tools/perf/pmu-events/Build                   |  25 +-
 tools/perf/pmu-events/jevents.py              |  56 ++-
 tools/perf/trace/beauty/Build                 | 280 ++++++++++++
 tools/perf/trace/beauty/arch_errno_names.c    |   2 +
 tools/perf/trace/beauty/arch_errno_names.sh   |   2 +-
 tools/perf/trace/beauty/beauty.h              |  60 +++
 tools/perf/trace/beauty/eventfd.c             |   6 +-
 tools/perf/trace/beauty/fsconfig.c            |   5 +
 tools/perf/trace/beauty/futex_op.c            |   6 +-
 tools/perf/trace/beauty/futex_val3.c          |   6 +-
 tools/perf/trace/beauty/mmap.c                |  24 +-
 tools/perf/trace/beauty/mode_t.c              |   6 +-
 tools/perf/trace/beauty/msg_flags.c           |   8 +-
 tools/perf/trace/beauty/open_flags.c          |   1 +
 tools/perf/trace/beauty/perf_event_open.c     |  22 +-
 tools/perf/trace/beauty/pid.c                 |   5 +-
 tools/perf/trace/beauty/sched_policy.c        |   8 +-
 tools/perf/trace/beauty/seccomp.c             |  12 +-
 tools/perf/trace/beauty/signum.c              |   6 +-
 tools/perf/trace/beauty/socket_type.c         |   6 +-
 .../perf/{util => trace/beauty}/syscalltbl.c  |   0
 .../perf/{util => trace/beauty}/syscalltbl.h  |   0
 tools/perf/trace/beauty/tracepoints/Build     |  22 +
 tools/perf/trace/beauty/waitid_options.c      |   8 +-
 tools/perf/util/Build                         |  17 +-
 tools/perf/util/bpf-trace-summary.c           |   2 +-
 tools/perf/util/env.c                         |   4 +-
 tools/perf/util/env.h                         |   1 +
 tools/scripts/Makefile.include                |   3 +
 41 files changed, 716 insertions(+), 503 deletions(-)
 rename tools/perf/{util => bench}/bpf_skel/bench_uprobe.bpf.c (100%)
 create mode 100644 tools/perf/bpf_skel.mak
 create mode 100644 tools/perf/trace/beauty/fsconfig.c
 rename tools/perf/{util => trace/beauty}/syscalltbl.c (100%)
 rename tools/perf/{util => trace/beauty}/syscalltbl.h (100%)

-- 
2.54.0.563.g4f69b47b94-goog

