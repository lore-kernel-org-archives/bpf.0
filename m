Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77463379C52
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578600; cv=none; b=YyB7rHf1PrvXEzCW1BZMIcgwWCy+gIeFhf8pjtAFOQZ2Y4v6MlAkcwoG/pqh1S6l1Cn3g16cZ2yL1L0kqSckazhf90PaTw1tR8xsJX6bfLBiLj3oRJ03n3N83GLatYTyT0yHfcdfKu1rlmc0yOKguf/Dwyq9VMEeNtoDX5lyCAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578600; c=relaxed/simple;
	bh=tm0NVwwbouUOW/ov7c8L4ich1p+zJor/SPJKdx8NRLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=FSCApOkGn+omQWcZlKYXbUgWwBotVY8f60iPG7ojNTgdFy5nz/H1YWDXsA6NHPlCJqB0cEM76lT1tPbDOEMOOUW/iqnGw2cXbed0u6rPEQaC0tnCg9GIEbxeTcRIj0I3jK/UH+OY7vga4x3xUdXdAFyMpgWEnU2SdaPj/O+q0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gT3Ayfnt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gT3Ayfnt"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso48660255e9.3
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778578597; x=1779183397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4TuJODOI+QkiUVtzRDrKwuK4f3bx4sDE+Z5ULvd9uEM=;
        b=gT3Ayfnt9c90ULVLYRvtPOvQl6BYM64/KPpNKLrkx/nTVsWttxhNwi/ryJbcEONbTs
         i79d6J8EMnICeYSK1FrQNpK3dBTDj1k5s/aIRuSiKZp6QTEQr9TAUHv4pxDuaLG+oDpt
         bBXshMDBNllkdU4wTf+5RFECGMk5lbFJT5P2ZP6EKWLZiCZ48hhJoBF/+oWsilZPhD+X
         IzX9sBwIG/gfitV6iMZwcaiZIIZEP2BfNsRkVO0BPfVmNhokXc+mKYXO03Mptg1r/f6R
         B9FEoQ4MdbqvgKEaw7hgKaT79SGrVZoco33ONgmwKPGN+sCIe8dQcK9uTutfvVr7PJge
         GesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578597; x=1779183397;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TuJODOI+QkiUVtzRDrKwuK4f3bx4sDE+Z5ULvd9uEM=;
        b=kl1smrM9EZ//TIpOfJU//q0HFJz2tWKrEjgbuJwKK7eyL09EgVBnZE9KHIWGbEqzM9
         Fq4XRh5NoDwA2H7CRraHC1A4AKwOUUTdnFCy14ZGUOsw++7iYcsq5efihLaf++GDCukG
         pL6R3r50jtjzwRKH7qKzrguZGEyE+C9ewByot+cn9CpqQgYIKUePWe/HdyXEyti/wMXg
         tsAQIgA6EFBR0jJ+BwntMURf/Ef6VTTCw6zgj/blmOpuQdzc3zBYgRDX/ypxjBqxcxTj
         vad7103eMAhh1LPmZxwcwl/XxLc/UpBa+cZpo8zw2dwQ79g7UawQYtlKy7A4NC3yPYrO
         K44g==
X-Forwarded-Encrypted: i=1; AFNElJ+UTZq0Y/LFv0ODLKcTRx7S7yLQTWKULd1bUMsB7AsAbaDpfTXDb7A60m1dM5Ahy/Hb678=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+4JqyhTkgw20/u6dWDEyKeRtkkqKzgnvQ/FZ/LBi4B4tyUW4G
	9wkpM5H9xQf03ZvF/5rFEyxHfeZkSsGrbuIlDSaMj3ZEUX9OULB0i1pTZhvTglw62Nc=
X-Gm-Gg: Acq92OFa4Oh0kzYUXq78+DEoRhKqHlx3IXG+8+FE2HYLxjQeHQFGWFjG4WxcQzzd9bD
	w+NfUih0HNV6AC6tlkA6QS2V14wTkKkNAFIj63QaACbj9Prx0j1VscKaBIauIyPOzkoTSEiAsuj
	tRjUiREDixfGOfStddnaAfCKZwuwjvpNUuWewODj/TwZvoVB5OPp83gClN9/2M8XP7PlAa4rVr7
	AReFBc5NuviGp6EGvdmCuN1pm4/2w9gQWg/qh9Ck8GipM3j/KvBhfemNpKXGgY9MhVi+rtbYD5x
	EJASW+u/v6/cfRcZAGTQ+NFy3xfmB/r2twy8PUjXnrax9+B0c8aLSv8Qs44Z/QF0tfCwxh8fO1M
	qlrPCMMTxiDLgAaKYiu7OMJ7xC9kGje25APW3GykFnYnARyTKDMJiOo/BpSNkED55xW32rrKIim
	MYnzdlZUFDh6BKteGuBryJqSQLw7HCkQv5pfeEosg=
X-Received: by 2002:a05:600c:c494:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-48e51f32c35mr435745135e9.13.1778578596689;
        Tue, 12 May 2026 02:36:36 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e9052c9fesm68487945e9.1.2026.05.12.02.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:36:36 -0700 (PDT)
Message-ID: <3c42ab2a-7698-4459-b1e1-9441a0bf4d9b@linaro.org>
Date: Tue, 12 May 2026 10:36:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/14] perf build: Reduce build time by one third
To: Ian Rogers <irogers@google.com>
References: <20260512053539.3410189-1-irogers@google.com>
Content-Language: en-US
Cc: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
 Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>,
 Dmitrii Dolgov <9erthalion6@gmail.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Yuzhuo Jing <yuzhuo@google.com>, Leo Yan <leo.yan@arm.com>,
 Ankur Arora <ankur.a.arora@oracle.com>, Markus Mayer <mmayer@broadcom.com>,
 Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Thomas Falcon <thomas.falcon@intel.com>,
 Ricky Ringler <ricky.ringler@proton.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/05/2026 6:35 am, Ian Rogers wrote:
> This patch series refactors many aspects of the perf build aiming to
> better encapsulate BPF code generation, remove serial build code and
> gain build parallelism. The prepare step that blocks the parallel
> build is reduced to a core 6 smaller dependencies. BPF skeletons are
> made regular dependencies on the targets that use them. Feature tests
> and dependencies are reorgnized. The jevents.py script processes json
> files in parallel and allows the big_c_string to be compiled
> separately.
> 
> On a 28-core build workstation (make -j28 all from scratch), clean build
> latency improves by over 36%:
> 
>    Before:
>      real    0m29.006s
>      user    2m46.019s
>      sys     0m30.610s
> 
>    After:
>      real    0m18.498s
>      user    2m32.922s
>      sys     0m27.623s
> 

I also get similar numbers, even when using ccache:

Before:

   real    0m29.584s
   user    0m48.993s
   sys     0m20.466s

After:

   real    0m18.322s
   user    0m49.995s
   sys     0m17.077s

Tested-by: James Clark <james.clark@linaro.org>

> Summary of Patches:
> 
> 1: bpftool Bootstrap Optimization
>    - Exempts bpftool bootstrap from non-essential feature tests (LLVM, libbfd,
>      libcap), saving 1.1s of sub-make fork overhead during Kbuild startup.
> 
> 2-4: Flattening Umbrella Prepare Barriers
>    - builtin-trace embedded inclusions and pmu-events generation are completely
>      decoupled from the sequential "prepare" umbrella target, eliminating Make
>      AST double-parsing overhead and unchoking parallel compilation barriers.
> 
> 5-8: Decoupling & Pre-generating BPF Skeletons
>    - BPF skeleton rules are extracted out of Makefile.perf into bpf_skel.mak.
>    - Decouples bpftool bootstrap from top-level static libbpf dependencies,
>      attaching bpf-skel-prepare directly to the umbrella prepare target. This
>      allows Make to pre-compile bpftool and dump vmlinux.h in the background at
>      build startup, removing the 7-second serialization bottleneck before BPF
>      object compilation.
> 
> 9-11: Foundational Linkage & Fast-Path Feature Detection
>    - Eliminates redundant libbpf sub-make feature checks during static builds.
>    - Integrates libdebuginfod directly into test-all.c, allowing Make to skip
>      individual feature check sub-make forks during AST parsing on fully
>      configured workstations.
> 
> 12-13: jevents.py Concurrency & Deduplication
>    - Splits the massive 2.8 MB big_c_string literal out of pmu-events.c into a
>      dedicated pmu-events-string.c compilation unit. This slices C compilation
>      latency in half by compiling string and struct tables simultaneously across
>      separate CPU cores while preserving zero dynamic ELF relocations.
>    - Pre-populates jevents.py JSON ASTs and metric formulas in parallel across
>      all available CPU cores using ProcessPoolExecutor (accelerating Python
>      execution by 11x, from 3.3s down to ~290ms).
> 
> 14: Out-of-Tree Incremental Rebuild Fix
>    - Prefixes SCRIPTS (perf-archive, perf-iostat) with $(OUTPUT) to prevent
>      Make from continuously re-executing script installation rules on already
>      built out-of-tree builds.
> 
> Ian Rogers (14):
>    bpftool build: Restrict feature tests during bootstrap compilation
>    perf trace beauty: Make beauty generated C code standalone .o files
>    perf build: Decouple pmu-events from prepare umbrella target
>    perf build: Remove empty archheaders target
>    perf build: Move BPF skeleton generation out of Makefile.perf
>    perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
>    perf build: Move static libbpf dependency out of prepare step
>    perf build: Pre-generate BPF skeletons during umbrella prepare phase
>    perf build: Move libsymbol dependency out of prepare step
>    perf build: Remove redundant libbpf feature check for static builds
>    tools build: Integrate libdebuginfod into test-all fast path
>    perf pmu-events: Split big_c_string storage into standalone
>      compilation unit
>    perf pmu-events: Parallelize JSON and metric pre-computation in
>      jevents.py
>    perf build: Prefix SCRIPTS with output directory to fix continuous
>      rebuilds
> 
>   tools/bpf/bpftool/Makefile                    |   5 +
>   tools/build/Makefile.feature                  |   6 +-
>   tools/build/feature/Makefile                  |   2 +-
>   tools/build/feature/test-all.c                |   5 +
>   tools/perf/Build                              |   2 +
>   tools/perf/Makefile.config                    |   6 +-
>   tools/perf/Makefile.perf                      | 427 +-----------------
>   tools/perf/bench/Build                        |   6 +
>   .../bpf_skel/bench_uprobe.bpf.c               |   0
>   tools/perf/bench/uprobe.c                     |   2 +-
>   tools/perf/bpf_skel.mak                       | 110 +++++
>   tools/perf/builtin-trace.c                    |  30 +-
>   tools/perf/pmu-events/Build                   |  15 +-
>   tools/perf/pmu-events/jevents.py              |  56 ++-
>   tools/perf/trace/beauty/Build                 | 280 ++++++++++++
>   tools/perf/trace/beauty/arch_errno_names.c    |   2 +
>   tools/perf/trace/beauty/arch_errno_names.sh   |   2 +-
>   tools/perf/trace/beauty/beauty.h              |  60 +++
>   tools/perf/trace/beauty/eventfd.c             |   6 +-
>   tools/perf/trace/beauty/fsconfig.c            |   5 +
>   tools/perf/trace/beauty/futex_op.c            |   6 +-
>   tools/perf/trace/beauty/futex_val3.c          |   6 +-
>   tools/perf/trace/beauty/mmap.c                |  24 +-
>   tools/perf/trace/beauty/mode_t.c              |   6 +-
>   tools/perf/trace/beauty/msg_flags.c           |   8 +-
>   tools/perf/trace/beauty/open_flags.c          |   1 +
>   tools/perf/trace/beauty/perf_event_open.c     |  22 +-
>   tools/perf/trace/beauty/pid.c                 |   5 +-
>   tools/perf/trace/beauty/sched_policy.c        |   8 +-
>   tools/perf/trace/beauty/seccomp.c             |  12 +-
>   tools/perf/trace/beauty/signum.c              |   6 +-
>   tools/perf/trace/beauty/socket_type.c         |   6 +-
>   .../perf/{util => trace/beauty}/syscalltbl.c  |   0
>   .../perf/{util => trace/beauty}/syscalltbl.h  |   0
>   tools/perf/trace/beauty/tracepoints/Build     |  22 +
>   tools/perf/trace/beauty/waitid_options.c      |   8 +-
>   tools/perf/util/Build                         |  17 +-
>   tools/perf/util/bpf-trace-summary.c           |   2 +-
>   tools/perf/util/env.c                         |   4 +-
>   tools/perf/util/env.h                         |   1 +
>   40 files changed, 700 insertions(+), 491 deletions(-)
>   rename tools/perf/{util => bench}/bpf_skel/bench_uprobe.bpf.c (100%)
>   create mode 100644 tools/perf/bpf_skel.mak
>   create mode 100644 tools/perf/trace/beauty/fsconfig.c
>   rename tools/perf/{util => trace/beauty}/syscalltbl.c (100%)
>   rename tools/perf/{util => trace/beauty}/syscalltbl.h (100%)
> 

