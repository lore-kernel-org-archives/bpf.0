Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD5B3CF054
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778797432; cv=pass; b=DCROPX5d3Suw6sK1WQgi0rvofn2HrddnYqhwpegGQ0u8bEUqKmS+uulHS7vSfk4mUfvQwaGh2Uy2giMrIuwl+RrDHvycFyLW5nTXXGH+jtY09VpLOn1Auho8kLarAxltmhZDlYBf1iqE83vsLwpy80wKIpX3zHosYscrdjnXPAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778797432; c=relaxed/simple;
	bh=HaghXp6fCWiKw1AMHVGwhvZ0A4A687pES+ILCh8tQag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtZ6m/WIcZiz3wvAnyptXIoXtP2RhzjQFsTjOGzVmwso7DAbUOBPanyIwO66cVQ+dE3HiW67L5XiP92BDVc2/RV7dSvQiyOV4LAiisFBvD4qCmFP9Q0BYxqnuH3aQEzPwyh/PZiWUrsNG1MULWpjDmW2V1Hp/D0aJORp8+t2+0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KqNvzuVJ; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KqNvzuVJ"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-133362c30cfso93c88.0
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 15:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778797428; cv=none;
        d=google.com; s=arc-20240605;
        b=Rvm7VmJWaKIt9sy4Quagq9rJNzPfzE60fyzBrbuLLDOc0CSohM/w1i9+c2UGI2OnmM
         AnoJKoy4ACrNioVlNcb5wKaPvGnPlzE40H7SoCsRQb8IBOv1oRUyr/NTfzdIWRX3JGvw
         VbSp4IwxFdy2OrzwI5Sxchzi6ym5LR4p01mHgJYYCQ9iT3/vjtQU9byqaakkLvDSfRSP
         MHCq6qknKMqA/YqzBLNjskj776uGLLQfICS4PMUOoAQuq+6zQevr9HAIKry+cUYbmAXw
         oR4NDZnqQKwyQT9BotG8REcjZuWAahPLQdkeqZafOuhDyha9JvXYg1ICfN2IUFTQMJJf
         32Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F6ffD7YQhEKl+O0wF6OjcTYaRi7clYpavoXQ9MiYDCQ=;
        fh=g8rMr82vd1hv+zJLEaI8whZYcxV77gd1s8aKwbv5zVY=;
        b=SS4Q95yRVGCfjoGmxAr9yelqYrjcrHBeWv5I8IiFrx2Ra8yq8pNcscrzTob2wA3ocJ
         c7UPROC9pANaPEoIROah8QCW2HiBv+lIx1VXVMfDt/URLvrfsRlvnqVEKgS9W28MTlKT
         gaihqM98LX9354pozgMUq22TP4dSEwhBhpr3eRY3eHgW416Upvu+MtWh/A9lxw4tHzYy
         +gCbj2J7igbuIAUsBZofWYtdnKCtYZkqMCBvMOoB3TGh2kfbxkrxdcuxUWQPCwL48uJP
         O3HfzkBMTJO2Zn0KBS/gz4c5OaEVpFPC2gtRzLIAghH09z0fKdePtz7+WBpyJSTItfHF
         rLEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778797428; x=1779402228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6ffD7YQhEKl+O0wF6OjcTYaRi7clYpavoXQ9MiYDCQ=;
        b=KqNvzuVJpUpvwjRVwRM37W086HR8Svk47/E02/bVHGCophMrjRLVIRA7dogXFfl04T
         0yuQNuVw9IQRBjerMj39V9OqjLsWUhPxXEyS7ZZKzB+wc18VZlKTJmYNqK8qfEucCYE2
         nxLMRf+ejwWVJeR8ykc0KBqL61EMVQhF9HgKprDp04pLhKDMqBD0EuRmhCiFpjq3HzyX
         5Vzzwmc/IZ5bxwtOd+iJdwBplsFxwlLCyfjnMUXaRZe541IasM1v0rGnvONXnGq8upiU
         2mxSjRQ+okQhIbAKWbFD+DeAjRHlpD7ahcYvemlSewHoWuyx95CTwY3ueo9GyMV4b1wA
         5YGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778797428; x=1779402228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F6ffD7YQhEKl+O0wF6OjcTYaRi7clYpavoXQ9MiYDCQ=;
        b=E/bwpN39vKTd/9UHzh9qomd0ChlIstCRwu0YqbaA8V1Y90kDF9kalk9cMrE1rBe9ba
         2pA27f5PK0X7CEcCRpAjbtKMYiXebiM+gP1BY1APxQgWak6rQCh52HejktzE5tBxH6ee
         w2YAMk41WoZ1PZft6f/7Gy5T6VPxj81mfuRpPqU/GMtcP1yTYxp4WnWG6l027DgTJgcD
         7G6XDQVNWBcbyoqvAiJau4xpmSuo4iJvHun1oQc550b8CBUESH4jW1yG6zjEBCRHvjg+
         a0oiU/ntjELAV5aPHxMSWOoW+PRbkcMSFXu6I5yAWgr5ysDQlAMVU00O5aYHUBd8kjSp
         3FVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uHvF7W33n6FrqJw1YVBLhbANfwSJUQN1b7YrJ0SwbjeyadhLo39up/ycuiQJ6CtJ2ZM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYS+K8h9xxiJjnEgllsFbDo0UbZgZ5V/WSLh6WprFrMUkgBDk
	DOVfmjxnshM8Ri68VTUvpfbGDPwRbuBbFxpDQ4nsuNh56UgE+UNouvbTZx0ZE9P6eGsAmMJb7jt
	p9v84J28KDzql/uPOjjQKLQcvGNLbyuntUFi17wck
X-Gm-Gg: Acq92OGKq4Av/xOMw78T+IG3VVx4g3Bp/teaQ6m0eaf3F0Sy0E/nDUB6C4F9+rNI1EQ
	uvvnIvK3pGKa38tIR2mTTUcpHg+YwH1ctuDuXE7eIY2zsno2nIq5Q3daKIJq5wudo1lRwgBwXoh
	eiWyWwaadzRxIf1A9+6AZdhWPiQRljAA1BTBRaRleefh5YvtNM1ZsPQAeyaEOakrQKjc1QTtI5Q
	VEnvyiVyVwUZ4ZymdmGKUcAFWo3/tbJ4/ZAZxmhvXvayV0+V6WP54sJNlZSZXO27kU7mJ6jQwxk
	BYS440kL+s/bh89Nh20AFuRcEkJD3Xa5FoPekh7XBFz7WGo=
X-Received: by 2002:a05:7022:38d:b0:12d:ff22:d624 with SMTP id
 a92af1059eb24-13503ce1774mr61165c88.10.1778797426879; Thu, 14 May 2026
 15:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
 <agZHYSFneOSIo8d5@google.com>
In-Reply-To: <agZHYSFneOSIo8d5@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 May 2026 15:23:34 -0700
X-Gm-Features: AVHnY4I9yVA8NMnkhMge-wX9jZSiosHVBenBDf3PW_jN4xBJ6ScOba--ZTBdCK0
Message-ID: <CAP-5=fUJFRcXFdpSy_X23NSU7zMp9SVZEqX+cEBsKP9YARGRvA@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] perf build: Reduce build time by nearly half
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, james.clark@linaro.org, 9erthalion6@gmail.com, 
	adrian.hunter@intel.com, alex@ghiti.fr, alexandre.chartre@oracle.com, 
	andrii@kernel.org, ankur.a.arora@oracle.com, aou@eecs.berkeley.edu, 
	bpf@vger.kernel.org, collin.funk1@gmail.com, costa.shul@redhat.com, 
	daniel@iogearbox.net, dapeng1.mi@linux.intel.com, dsterba@suse.com, 
	eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 3:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, May 14, 2026 at 09:33:52AM -0700, Ian Rogers wrote:
> > This patch series refactors Kbuild internals, BPF skeleton generation,
> > Python AST pre-computation, and foundational tooling dependencies acros=
s
> > the perf tool build system. By eliminating umbrella target synchronizat=
ion
> > barriers, decoupling static library prerequisites, parallelizing single=
-core
> > script generators, and eradicating redundant feature checks, this serie=
s
> > unlocks absolute theoretical peak multi-core concurrency during Kbuild =
startup.
> >
> > On a 28-core build workstation (make -j28 all from scratch), clean buil=
d
> > latency improves by over 49%:
> >
> >   Before:
> >     real    0m29.006s
> >     user    2m46.019s
> >     sys     0m30.610s
> >
> >   After:
> >     real    0m14.782s
> >     user    2m39.527s
> >     sys     0m22.938s
> >
> > Saving 14.2 full seconds time per clean build. Furthermore, nothing to
> > build incremental builds are improved by nearly 7x:
> >
> >   Before:
> >     real    0m11.528s
> >     user    0m9.633s
> >     sys     0m6.965s
> >
> >   After:
> >     real    0m1.729s
> >     user    0m1.600s
> >     sys     0m0.884s
>
> I've quickly checked it with latency profiling like below:
>
>   $ perf record --latency -- make -C tools/perf
>
>   $ perf report --latency -s comm
>
> The result looks like this.
>
> Before:
>   #
>   # Samples: 715K of event 'cpu/cycles/Pu'
>   # Event count (approx.): 422452811481
>   #
>   #  Latency  Overhead  Command
>   # ........  ........  ...............
>   #
>       45.28%    71.33%  cc1
>       34.48%    16.92%  python3
>       11.15%     2.21%  ld
>        2.58%     1.51%  x86_64-linux-gn
>        2.22%     0.99%  cc1plus
>        0.71%     0.63%  sh
>        0.69%     0.14%  llvm-config
>        0.62%     0.56%  clang
>        0.57%     4.40%  shellcheck
>        0.44%     0.12%  perl
>
> After:
>   #
>   # Samples: 709K of event 'cpu/cycles/Pu'
>   # Event count (approx.): 416654798495
>   #
>   #  Latency  Overhead  Command
>   # ........  ........  ...............
>   #
>       64.99%    71.16%  cc1
>       15.07%     1.81%  ld
>        7.14%    17.59%  python3
>        3.66%     1.53%  x86_64-linux-gn
>        3.48%     0.75%  cc1plus
>        1.11%     4.43%  shellcheck
>        1.09%     0.74%  sh
>        0.86%     0.59%  clang
>        0.77%     0.12%  perl
>        0.45%     0.23%  make
>
> Now I see a big drop in the latency from python.  And the llvm-config
> doesn't show up in the top 10.

This looks good. What is "x86_64-linux-gn", and since we default off
LIBPERL, why does perl show up in the commands?

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Summary of Patches:
> >
> > 1-3: Foundational Tooling & Fast-Path Feature Detection
> >   - Exempts bpftool bootstrap from non-essential feature tests (LLVM, l=
ibbfd,
> >     libcap), saving 1.1s of sub-make fork overhead during Kbuild startu=
p.
> >   - Integrates libdebuginfod directly into test-all.c, allowing Make to=
 skip
> >     individual feature check sub-make forks during AST parsing on fully
> >     configured workstations. Escapes $(shell ...) macro expansion to pr=
event
> >     unconditional sub-make forks.
> >   - Fixes test-clang-bpf-co-re.bin feature check to correctly generate =
its
> >     target file on disk via atomic move (> $@.tmp && mv $@.tmp $@), all=
owing
> >     Kbuild to perfectly cache the detection result and avoid continuous=
 sub-make
> >     re-evaluations.
> >
> > 4-6: Flattening Umbrella Prepare Barriers
> >   - builtin-trace embedded inclusions and pmu-events generation are com=
pletely
> >     decoupled from the sequential "prepare" umbrella target, eliminatin=
g Make
> >     AST double-parsing overhead and unchoking parallel compilation barr=
iers.
> >
> > 7-10: Decoupling & Pre-generating BPF Skeletons
> >   - BPF skeleton rules are extracted out of Makefile.perf into bpf_skel=
.mak.
> >   - Decouples bpftool bootstrap from top-level static libbpf dependenci=
es,
> >     attaching bpf-skel-prepare directly to the umbrella prepare target.=
 This
> >     allows Make to pre-compile bpftool and dump vmlinux.h in the backgr=
ound at
> >     build startup, removing the 7-second serialization bottleneck befor=
e BPF
> >     object compilation.
> >   - Ensures benchmark skeleton intermediate .bpf.o files are cleanly re=
moved
> >     during make clean, and adds bpf-skel-prepare to .PHONY.
> >
> > 11-12: Foundational Linkage Optimization
> >   - Eliminates redundant libbpf sub-make feature checks during static b=
uilds.
> >   - Moves static libsymbol and libbpf library prerequisites out of the
> >     prepare step, ensuring libbpf headers are installed before
> >     compiling BPF-dependent tests.
> >
> > 13-14: jevents.py Concurrency & Deduplication
> >   - Splits the massive 2.8 MB big_c_string literal out of pmu-events.c
> >     into a dedicated pmu-events-string.c compilation unit. This slices
> >     C compilation latency in half by compiling string and struct
> >     tables simultaneously across separate CPU cores while preserving
> >     zero dynamic ELF relocations. Adds pmu-events-string.c to
> >     .gitignore and uses Make 4.0 compatible dependency chaining.
> >   - Pre-populates jevents.py JSON ASTs and metric formulas in parallel =
across
> >     all available CPU cores using ProcessPoolExecutor (accelerating Pyt=
hon
> >     execution by 11x, from 3.3s down to ~290ms). Moves _init_worker to =
top-level
> >     scope to ensure clean pickling under spawn multiprocessing start me=
thods.
> >
> > 15: Out-of-Tree Incremental Rebuild Fix
> >   - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to prev=
ent
> >     Make from continuously re-executing script installation rules on al=
ready
> >     built out-of-tree builds.
> >
> > 16-17: AST Parsing Optimization & Shell Fork Eradication
> >   - Converts ZENS, ARMS, and INTELS in pmu-events/Build from recursive
> >     assignment (=3D) to simply expanded assignment (:=3D) and replaces
> >     model_name/vendor_name with pure GNU Make string functions. This
> >     guarantees Make executes directory probing shell forks exactly
> >     once during AST parsing and evaluates path macros purely in
> >     memory, completely eradicating over 7,800 redundant sub-processes
> >     during out-of-tree build evaluation.
> >   - Converts llvm-config shell queries in Makefile.config from
> >     recursive assignment (=3D) to simply expanded assignment (:=3D). Th=
is
> >     eliminates ~185 redundant sub-processes that were previously
> >     executed across object compilation dependency checks.
> >
> > Changes since v2:
> >   - Dropped Patch 4 (tools scripts: Short-circuit CC_NO_CLANG compiler
> >     probe in Makefile.include) to prevent potential cross-compilation
> >     regressions when CC and HOSTCC use different compilers.
> >   - tools build (Patch 2): Escaped $(shell ...) macro expansion as
> >     $$(shell ...) inside define feature_check_code to safely defer
> >     sub-make execution until after eval parses the ifeq guard.
> >   - tools build (Patch 3): Refactored test-clang-bpf-co-re.bin feature
> >     check recipe to redirect grep output to a temporary file and
> >     atomically move it upon success (> $@.tmp && mv $@.tmp $@),
> >     preventing Kbuild from permanently caching failed detections due to
> >     0-byte files.
> >   - perf trace beauty (Patch 4): Updated commit description to accurate=
ly
> >     reflect the unconditional top-level recursive kbuild hook
> >     (perf-util-y +=3D trace/beauty/).
> >   - perf build (Patch 7): Added $(OUTPUT)bench/bpf_skel/.tmp to
> >     bpf-skel-clean in Makefile.perf to ensure intermediate benchmark
> >     skeleton .bpf.o artifacts are cleanly removed during make clean.
> >     Removed unused bpf_skel_deps variable from bpf_skel.mak.
> >   - perf build (Patch 9): Added $(LIBBPF) as an explicit prerequisite t=
o
> >     $(LIBPERF_TEST_IN) in Makefile.perf to guarantee libbpf headers are
> >     fully installed before compiling sigtrap.c or other BPF-dependent
> >     tests during parallel builds.
> >   - perf build (Patch 10): Added bpf-skel-prepare to the .PHONY target
> >     list in Makefile.perf to ensure Make never incorrectly skips the
> >     target if a file or directory named bpf-skel-prepare accidentally
> >     exists in the build tree.
> >   - perf pmu-events (Patch 13): Added pmu-events/pmu-events-string.c to
> >     tools/perf/.gitignore. Replaced grouped targets (&:) with Make 4.0
> >     compatible dependency chaining to guarantee backward compatibility
> >     with older Make versions (like 4.2.1) and prevent parallel builds
> >     from spawning multiple concurrent jevents.py processes.
> >   - perf pmu-events (Patch 14): Moved _init_worker from local main()
> >     scope to the top-level module scope in jevents.py to ensure it can =
be
> >     cleanly pickled when ProcessPoolExecutor uses the spawn
> >     multiprocessing start method (avoiding AttributeError crashes).
> >
> > Ian Rogers (17):
> >   bpftool build: Restrict feature tests during bootstrap compilation
> >   tools build: Integrate libdebuginfod into test-all fast path
> >   tools build: Fix test-clang-bpf-co-re.bin to generate target file
> >   perf trace beauty: Make beauty generated C code standalone .o files
> >   perf build: Decouple pmu-events from prepare umbrella target
> >   perf build: Remove empty archheaders target
> >   perf build: Move BPF skeleton generation out of Makefile.perf
> >   perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
> >   perf build: Move static libbpf dependency out of prepare step
> >   perf build: Pre-generate BPF skeleton tooling during umbrella prepare
> >     phase
> >   perf build: Move libsymbol dependency out of prepare step
> >   perf build: Remove redundant libbpf feature check for static builds
> >   perf pmu-events: Split big_c_string storage into standalone
> >     compilation unit
> >   perf pmu-events: Parallelize JSON and metric pre-computation in
> >     jevents.py
> >   perf build: Prefix SCRIPTS with output directory to fix continuous
> >     rebuilds
> >   perf pmu-events: Convert recursive shell assignments and macros to
> >     Make built-ins
> >   perf build: Convert llvm-config shell queries to simply expanded
> >     variables
> >
> >  tools/bpf/bpftool/Makefile                    |   5 +
> >  tools/build/Makefile.feature                  |   6 +-
> >  tools/build/feature/Makefile                  |   4 +-
> >  tools/build/feature/test-all.c                |   5 +
> >  tools/perf/.gitignore                         |   1 +
> >  tools/perf/Build                              |   2 +
> >  tools/perf/Makefile.config                    |  19 +-
> >  tools/perf/Makefile.perf                      | 431 ++----------------
> >  tools/perf/bench/Build                        |   6 +
> >  .../bpf_skel/bench_uprobe.bpf.c               |   0
> >  tools/perf/bench/uprobe.c                     |   2 +-
> >  tools/perf/bpf_skel.mak                       | 109 +++++
> >  tools/perf/builtin-trace.c                    |  30 +-
> >  tools/perf/pmu-events/Build                   |  26 +-
> >  tools/perf/pmu-events/jevents.py              |  56 ++-
> >  tools/perf/trace/beauty/Build                 | 280 ++++++++++++
> >  tools/perf/trace/beauty/arch_errno_names.c    |   2 +
> >  tools/perf/trace/beauty/arch_errno_names.sh   |   2 +-
> >  tools/perf/trace/beauty/beauty.h              |  60 +++
> >  tools/perf/trace/beauty/eventfd.c             |   6 +-
> >  tools/perf/trace/beauty/fsconfig.c            |   5 +
> >  tools/perf/trace/beauty/futex_op.c            |   6 +-
> >  tools/perf/trace/beauty/futex_val3.c          |   6 +-
> >  tools/perf/trace/beauty/mmap.c                |  24 +-
> >  tools/perf/trace/beauty/mode_t.c              |   6 +-
> >  tools/perf/trace/beauty/msg_flags.c           |   8 +-
> >  tools/perf/trace/beauty/open_flags.c          |   1 +
> >  tools/perf/trace/beauty/perf_event_open.c     |  22 +-
> >  tools/perf/trace/beauty/pid.c                 |   5 +-
> >  tools/perf/trace/beauty/sched_policy.c        |   8 +-
> >  tools/perf/trace/beauty/seccomp.c             |  12 +-
> >  tools/perf/trace/beauty/signum.c              |   6 +-
> >  tools/perf/trace/beauty/socket_type.c         |   6 +-
> >  .../perf/{util =3D> trace/beauty}/syscalltbl.c  |   0
> >  .../perf/{util =3D> trace/beauty}/syscalltbl.h  |   0
> >  tools/perf/trace/beauty/tracepoints/Build     |  22 +
> >  tools/perf/trace/beauty/waitid_options.c      |   8 +-
> >  tools/perf/util/Build                         |  17 +-
> >  tools/perf/util/bpf-trace-summary.c           |   2 +-
> >  tools/perf/util/env.c                         |   4 +-
> >  tools/perf/util/env.h                         |   1 +
> >  41 files changed, 717 insertions(+), 504 deletions(-)
> >  rename tools/perf/{util =3D> bench}/bpf_skel/bench_uprobe.bpf.c (100%)
> >  create mode 100644 tools/perf/bpf_skel.mak
> >  create mode 100644 tools/perf/trace/beauty/fsconfig.c
> >  rename tools/perf/{util =3D> trace/beauty}/syscalltbl.c (100%)
> >  rename tools/perf/{util =3D> trace/beauty}/syscalltbl.h (100%)
> >
> > --
> > 2.54.0.563.g4f69b47b94-goog
> >
