Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8B730C149
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887940; cv=pass; b=OXCCICwf3li+pii20bRjTZdk8vbPAFm8hWo4OAfvrZEl4PLtpkfsIts50d9Hm8qkEFghRY9IV03REW8u5o3fA7rDLOnAj+J6qzOFM5POSTsSB0X8ZsCDje1LbHlsim9vDEoiIn75VZIyydbMjyufI5srIb9uz+9803/e9FuAf8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887940; c=relaxed/simple;
	bh=rlnibuafkxBJQpUaWKsPbz0JEUKLXyVNRXQdiOu0Byg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUNhcztS3VwZL/tDZRT9eF8KXwcT2VvmYL3ewLqD4Gtcf+P5ZeUl9ivE4+9I9PwpqIH2aT5hp0YzQvE25cj7dIX3QE0PiSKPp3zq0Uv+vbECxCXq4tbFJExsFWA/p2j4pRTJruaXV+JHuH+poSb3Ct5fMdNIVxmttl+cSC/l+Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9pbPRme; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9pbPRme"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b46da8c48eso1045ad.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 16:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778887938; cv=none;
        d=google.com; s=arc-20240605;
        b=Gh7H79wI2HMRSTO9jaNdrVUrK/j2TmBDJiKzo1XzIYJsXnLApAjGt7yGKLcd/o5i1d
         mIlHmwJ3g8110wSAn/BxB1riaNeAoGdqW2brw49uHRpMK1Oz45mT6mG51uxg5ZcsLL8q
         uwxntQUIkLoPQZQU5KFjpHghgRNnTKR0Dbfa3LXGQCFCdwt8tx3XD4qJSkjbwEUUEk8T
         ZnyYVNtpz7lFIWeedbktgArAk1xhb+70lAJTRucfL7PqUDrlXfLYRBBEFsJwUQ6gix1Q
         AMmBpSGE2dVB8dRs96kXCV91/wjOppBpIzdIJVxuznZWxr1GZJ6wDI/3Jn+9QAmoeU+u
         wk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=taVpDGO8357JvuXO5HGCBQyhKg1VCpTmNQkkufou/MU=;
        fh=Hmuah8+RE7lbeGjpx0J3/oojWfdegt6G1hAbBYQmHqU=;
        b=G0aDYmY7sio4tRknAYKndGibgCJivWPkC6mtCrDRN22d7vjagG7QtjzZwyPGLtfOQM
         H2AhV0M1Iq0cn7qpPBj2b68DSsOHgrhUK+UklhA3xfpt1vIQJQw2FnZcMVR1r3vUqalc
         DSXbG4BXw3vAuv4MWmgBMnwDWTcbOVscGz8mYhw2pi3ukFHAMXS6kjbsppMlu0UUqVcJ
         dSQFQPpfdmPCYVXbiMm271KSqVlenDLw9At8YroGRCU7Va3PwUypmWvamZBy8jFEgjEg
         f7cls/4eukrYcuF2e5PG1yAJuDoaDfLQOCRtiGnS0O4rPT87N2uhAfEcgUrvNVo68xKN
         IJgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778887938; x=1779492738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taVpDGO8357JvuXO5HGCBQyhKg1VCpTmNQkkufou/MU=;
        b=v9pbPRmeQcrqTOtK7jx5UJMYjyq9DhuR4fFBAt+XGC3LHdtQt/RhhW+bomJzXCy/4D
         GQFTu9OrF8aw8mPC1q3apHd/B3IRs0Y1Za60y+U3S4sO4DfGhg+Gpmuy6xqykkmb+o50
         OHFQkPdozWiRqLlZE4FfQwdJxp4jxAAhW09dKsSYr874NvSwqUVC8Y8K9xbMMzlYMCFv
         VHQqIClm495vNNoxf4ZGGmTXUxgr/R7hcr1nGICqmwmVHRe7hsrHZW1KlyAx+nG0fS7n
         NR7wyd3vo5BYv2bvwb2pml3RM6SkcKjQOrvMXAolay/Njs/YZbbNMblIgQR8+YXGGSzy
         IIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778887938; x=1779492738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=taVpDGO8357JvuXO5HGCBQyhKg1VCpTmNQkkufou/MU=;
        b=kVhSeAn9YaTWEOTMka3L4DaYUuYBCzeTfGgI7L4L2Lw2pV4e63vuOF0+KMDFdUT8Ye
         X7RMAbDT7BSZ0pGQRjQ0Kl7n9ERFiEkuJ/RHZMVSz+8WkHL5/3w0EnCcHd4abhHhpGeb
         /+UDzCYRbDLwKJcu2M835hjrJCFiDBPW0lmbr9+R/Ttf0oX/+dJmzIeSI8IjYNfD6LR1
         GpmOfk0h3Q8b2VoZckSql2vYavsFjy3Alzkj3za3vLiFqlK26DzrElu4TRX0JfmWKgan
         Dg8hzlV5cYcXItYY9rkKXG4SsHe+CVqDCGgSesdK19dDTj4GGc9WShJ5LjyBOyGktTF5
         yuYg==
X-Forwarded-Encrypted: i=1; AFNElJ//6F5xYHPk4oEqCrIQ6QMhpNQgFgTB8e3LkytRz9mdjtcmZoQEJ5ZyQOJLZu89iDZNszs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybaiIuUqpnm7Sm3O6dYL69/4+ouCuyqoFXBPFbu+dbDXlrXI3u
	Rj80j3QL+6QkWO+arlHXq0FIOrQQz9H0hceCXutyfhdN1pdieWp+PWVKski1QKB2OtkTgU3ls7M
	YaekrqYlNsjBrBHuSvTTCrjlx6M3kTTexpYyRvbKd
X-Gm-Gg: Acq92OGH++7ioLZ1TvQVYEuMSFu0RdKt1xYVKqPWjKnQuDrtGkeI1AlfHVDVO96f6R8
	bQz65sjSqUM7oPdEdikSgnDLI9gru0+9sTojCn3IrR/WSVCdqhMQqvQ3okWhwqd0aqWBzh5vPIh
	tx2y9HL830pcG4mjRO3ZV0WWvyizJzuwLxDxbbMZqtwrL0YB6S5H4Tuo2uLCZkAESnYtXnc7Rgo
	4NgckVyjkH/X8qOh0NFTfq1IBoIlAwIypOZLSDVnHLqMzZBrTki7XkFP8ZGExV5Yb/4ia9zU27p
	gue/W7srfT310kpCtPg=
X-Received: by 2002:a17:902:d508:b0:2bd:6dad:3dfd with SMTP id
 d9443c01a7336-2bda5303d91mr550265ad.27.1778887937703; Fri, 15 May 2026
 16:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com> <20260515193314.1593560-1-irogers@google.com>
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 May 2026 16:32:06 -0700
X-Gm-Features: AVHnY4KE3oqNgl6jQ5JuPZyyBywUGPxeDuZ_S4oiCXwVhXAzwZDmbaYrTj6BSag
Message-ID: <CAP-5=fWJ-AQ+dPfocop_0ok23g3p4m2q87kfF4pvLOu9dBjNAg@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] perf build: Reduce build time by nearly half
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
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:33=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> This patch series refactors Kbuild internals, BPF skeleton generation,
> Python AST pre-computation, and foundational tooling dependencies across
> the perf tool build system. By eliminating umbrella target synchronizatio=
n
> barriers, decoupling static library prerequisites, parallelizing single-c=
ore
> script generators, and eradicating redundant feature checks, this series
> unlocks greater concurrency during Kbuild startup.
>
> On a 28-core build workstation (make -j28 all from scratch), clean build
> latency improves by over 44%:
>
>   Before:
>     real    0m29.006s
>     user    2m46.019s
>     sys     0m30.610s
>
>   After:
>     real    0m16.091s
>     user    2m40.135s
>     sys     0m25.740s
>
> Saving 12.9 full seconds time per clean build. Furthermore, nothing to
> build incremental builds are improved by nearly 7x:
>
>   Before:
>     real    0m11.528s
>     user    0m9.633s
>     sys     0m6.965s
>
>   After:
>     real    0m1.717s
>     user    0m1.682s
>     sys     0m0.960s
>
> Summary of Patches:
>
> 1: Fast-Path Feature Detection
>   - Refactors test-clang-bpf-co-re.bin and test-bpftool-skeletons.bin fea=
ture
>     checks to group shell pipelines within curly braces and redirect both=
 stdout
>     and stderr to .make.output before touching $@ purely upon success
>     (> $(@:.bin=3D.make.output) 2>&1 && touch $@). Grouping the pipeline =
({ cmd1 | cmd2; })
>     ensures that compiler stderr is successfully captured in .make.output=
 rather
>     than escaping to the parent shell. This perfectly matches standard Kb=
uild
>     feature check conventions and ensures the target files are touched on=
 disk
>     purely upon success, allowing Kbuild to cache positive detections and=
 avoid
>     continuous sub-make re-evaluations during incremental builds. Adds
>     test-bpftool-skeletons.bin to the clean FILES list and explicit sourc=
e
>     prerequisite test-clang-bpf-co-re.c.
>
> 2-4: Flattening Umbrella Prepare Barriers
>   - builtin-trace embedded inclusions and pmu-events generation are compl=
etely
>     decoupled from the sequential "prepare" umbrella target, eliminating =
Make
>     AST double-parsing overhead and unchoking parallel compilation barrie=
rs.
>
> 5-7: Decoupling & Pre-generating BPF Skeletons
>   - BPF skeleton rules are extracted out of Makefile.perf into bpf_skel.m=
ak.
>   - Decouples bpftool bootstrap from top-level static libbpf dependencies=
,
>     attaching bpf-skel-prepare directly to the umbrella prepare target. T=
his
>     allows Make to pre-compile bpftool and dump vmlinux.h in the backgrou=
nd at
>     build startup, removing the 7-second serialization bottleneck before =
BPF
>     object compilation.
>   - Ensures benchmark skeleton intermediate .bpf.o files are cleanly remo=
ved
>     during make clean, and adds bpf-skel-prepare to .PHONY.
>
> 8-9: Foundational Linkage Optimization
>   - Moves static libsymbol library prerequisites out of the prepare step.
>   - Eliminates redundant libbpf sub-make feature checks during static bui=
lds.
>
> 10-11: jevents.py Concurrency & Deduplication
>   - Splits the massive 2.8 MB big_c_string literal out of pmu-events.c in=
to a
>     dedicated pmu-events-string.c compilation unit. This slices C compila=
tion
>     latency in half by compiling string and struct tables simultaneously =
across
>     separate CPU cores while preserving zero dynamic ELF relocations. Add=
s
>     pmu-events-string.c to .gitignore, declares extern const char big_c_s=
tring[];
>     locally inside output_string_file and output_file when split to preve=
nt linkage
>     conflicts with empty-pmu-events.c, defers file closures to ensure ide=
ntical
>     timestamps, and uses canonical Make 4.0 @: dependency chaining.
>   - Pre-populates jevents.py JSON ASTs and metric formulas in parallel ac=
ross
>     all available CPU cores using ProcessPoolExecutor (accelerating Pytho=
n
>     execution by 11x, from 3.3s down to ~290ms). Moves _init_worker to to=
p-level
>     scope to ensure clean pickling under spawn multiprocessing start meth=
ods.
>
> 12: Out-of-Tree Incremental Rebuild Fix
>   - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to preven=
t
>     Make from continuously re-executing script installation rules on alre=
ady
>     built out-of-tree builds.
>
> 13-14: AST Parsing Optimization & Shell Fork Eradication
>   - Converts ZENS, ARMS, and INTELS in pmu-events/Build from recursive as=
signment
>     (=3D) to simply expanded assignment (:=3D) and replaces model_name/ve=
ndor_name
>     with pure GNU Make string functions. This guarantees Make executes di=
rectory
>     probing shell forks exactly once during AST parsing and evaluates pat=
h macros
>     purely in memory, completely eradicating over 7,800 redundant sub-pro=
cesses
>     during out-of-tree build evaluation.
>   - Converts llvm-config shell queries in Makefile.config from recursive =
assignment
>     (=3D) to simply expanded assignment (:=3D). This eliminates ~185 redu=
ndant sub-processes
>     that were previously executed across object compilation dependency ch=
ecks.
>
> Changes since v4:
>   - tools build (Patch 1): Refactored test-bpftool-skeletons.bin and
>     test-clang-bpf-co-re.bin feature check recipes to group the shell pip=
eline
>     within curly braces ({ cmd1 | cmd2; }) so that compiler stderr is suc=
cessfully
>     captured in .make.output rather than escaping to the parent shell. Ad=
ded
>     test-bpftool-skeletons.bin to the clean FILES list in feature/Makefil=
e so
>     that make clean correctly purges the generated binary and prevents pe=
rmanent
>     feature cache poisoning.
>   - perf pmu-events (Patch 10): Reverted secondary target rule in pmu-eve=
nts/Build
>     back to the canonical Make 4.0 @: dependency chaining pattern to prev=
ent
>     concurrency race conditions during parallel compilation. Removed glob=
al
>     extern const char big_c_string[]; declaration from pmu-events.h and i=
nstead
>     emitted the extern declaration locally inside output_string_file and
>     output_file when split, preventing type and linkage conflicts with
>     empty-pmu-events.c when building with NO_JEVENTS=3D1.

Just to add that Sashiko on v5 has 2 medium and 1 low priority warning
across the 14 patches:
https://sashiko.dev/#/patchset/20260515193314.1593560-1-irogers%40google.co=
m
We could get it to 0 by removing the 3 patches it is warning about,
dropping the jevents.py changes would impact build time the most. I'd
prefer to land this series as it is.

Thanks,
Ian

> Ian Rogers (14):
>   tools build: Fix feature checks to touch target files on success
>   perf trace beauty: Make beauty generated C code standalone .o files
>   perf build: Decouple pmu-events from prepare umbrella target
>   perf build: Remove empty archheaders target
>   perf build: Move BPF skeleton generation out of Makefile.perf
>   perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
>   perf build: Pre-generate BPF skeleton tooling during umbrella prepare
>     phase
>   perf build: Move libsymbol dependency out of prepare step
>   perf build: Remove redundant libbpf feature check for static builds
>   perf pmu-events: Split big_c_string storage into standalone
>     compilation unit
>   perf pmu-events: Parallelize JSON and metric pre-computation in
>     jevents.py
>   perf build: Prefix SCRIPTS with output directory to fix continuous
>     rebuilds
>   perf pmu-events: Convert recursive shell assignments and macros to
>     Make built-ins
>   perf build: Convert llvm-config shell queries to simply expanded
>     variables
>
>  tools/build/feature/Makefile                  |  13 +-
>  tools/perf/.gitignore                         |   1 +
>  tools/perf/Build                              |   2 +
>  tools/perf/Makefile.config                    |  19 +-
>  tools/perf/Makefile.perf                      | 423 ++----------------
>  tools/perf/bench/Build                        |   6 +
>  .../bpf_skel/bench_uprobe.bpf.c               |   0
>  tools/perf/bench/uprobe.c                     |   2 +-
>  tools/perf/bpf_skel.mak                       | 109 +++++
>  tools/perf/builtin-trace.c                    |  32 +-
>  tools/perf/pmu-events/Build                   |  26 +-
>  tools/perf/pmu-events/jevents.py              |  58 ++-
>  tools/perf/trace/beauty/Build                 | 276 ++++++++++++
>  tools/perf/trace/beauty/arch_errno_names.c    |   2 +
>  tools/perf/trace/beauty/arch_errno_names.sh   |   2 +-
>  tools/perf/trace/beauty/beauty.h              |  60 +++
>  tools/perf/trace/beauty/eventfd.c             |   6 +-
>  tools/perf/trace/beauty/fsconfig.c            |   5 +
>  tools/perf/trace/beauty/futex_op.c            |   5 +-
>  tools/perf/trace/beauty/futex_val3.c          |   5 +-
>  tools/perf/trace/beauty/mmap.c                |  24 +-
>  tools/perf/trace/beauty/mode_t.c              |   6 +-
>  tools/perf/trace/beauty/msg_flags.c           |   8 +-
>  tools/perf/trace/beauty/open_flags.c          |   2 +
>  tools/perf/trace/beauty/perf_event_open.c     |  21 +-
>  tools/perf/trace/beauty/pid.c                 |   5 +-
>  tools/perf/trace/beauty/sched_policy.c        |   8 +-
>  tools/perf/trace/beauty/seccomp.c             |  12 +-
>  tools/perf/trace/beauty/signum.c              |   6 +-
>  tools/perf/trace/beauty/socket_type.c         |   6 +-
>  .../perf/{util =3D> trace/beauty}/syscalltbl.c  |   0
>  .../perf/{util =3D> trace/beauty}/syscalltbl.h  |   0
>  tools/perf/trace/beauty/tracepoints/Build     |  21 +
>  tools/perf/trace/beauty/waitid_options.c      |   8 +-
>  tools/perf/util/Build                         |  17 +-
>  tools/perf/util/bpf-trace-summary.c           |   2 +-
>  tools/perf/util/env.c                         |   4 -
>  tools/perf/util/env.h                         |   1 +
>  38 files changed, 687 insertions(+), 516 deletions(-)
>  rename tools/perf/{util =3D> bench}/bpf_skel/bench_uprobe.bpf.c (100%)
>  create mode 100644 tools/perf/bpf_skel.mak
>  create mode 100644 tools/perf/trace/beauty/fsconfig.c
>  rename tools/perf/{util =3D> trace/beauty}/syscalltbl.c (100%)
>  rename tools/perf/{util =3D> trace/beauty}/syscalltbl.h (100%)
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
