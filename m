Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641762E0925
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778540311; cv=pass; b=YKmEcpyTaE/o2S0OeoC1Aiy1v0PBaESxNi9chBoT4aKAd0U+k6jEwH+FNZZ/NnXV6qA8MPF2U42K9Fu1efxdAjXZEoijYjbET3cChB9NsJcnSErfQlw9U1vT+8+qyDCCnYCHYb+XG+vg86gh725RENO9lXheIaPu//pd7xnU+JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778540311; c=relaxed/simple;
	bh=/Xw7IwVkEqtXthC9Nf1pqFsLFJ1P97LjFqH9jeVZ13Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfL9M9UydJBKna/KoBDBqgH9Tjd1nXJNouh7riVMFeAOrZmEDJHs9/8nEvFs9hRNNtYM0FjxRbb5FbuaVXkIRmJZgoVyVyC4Or5yJyDnXwiiAl4Nm8sbkdvGWxhBGMN/NYH993rvHkcUN0pm6jR9qeAKyqZCRRZUcYdK/kxa32k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qaFc4zs1; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaFc4zs1"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d73422431so3756392f8f.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 15:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778540308; cv=none;
        d=google.com; s=arc-20240605;
        b=SUyGw8mTZXf2ORS/GMj0W5txLragtqreTpv7znyOREw05fgpFsYHtG8Ykfb5CRERWI
         MDc0FveOueJZH5+a1A1jAgvmHjTs9cMPbXaqYxSul5jDWMS64HKOFWDs6ovDAsPdW14d
         cIjTuZOK4IB7Eh+3dAI/TF5JklPTq8dn1hG+GboSTSTHaiira5SexDazYJqnGo4Z57cM
         iudmxO9Io61DOtrxJBnrjsinmrS6Q7k7v+7zz6hbII6uXEw+6gVv1ekLftVwXdfyA8se
         DxD6c+B31X/gmo0ByM3lYGG19RIXMDYlWETRZO1uaF2gCaaaVBEfYGPuYEFJTtiO2r93
         TIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ULxQjRtw2mVRm+P5lRYIKNh5DbGbU0zMeN9kkE3aGeM=;
        fh=tBXT2UM00D6/7rD5OtPbkvDzXEnh3L5E5h+5Ht9DBZo=;
        b=UvSSQ12ytlqo9yMWIva46SiwDvLHdeMnOqr/XdZE+0GHU6hqJCJwgkwSoucwXZ6/2B
         qPxVSBTijY/EegUBblWJAdRhWXpvVtP1dPVJJb1l5ltelWijC6WKNT906ocAx8b0ask4
         tQYs6+k5wIiOg7saalW0aFxk3bVpNYB7ePwKJFchIQdF60EWdvsvzxnsw+vhAtELgal7
         NPHt3el5FKvg/N/I/eJeG7eoT/jsR7m463rcs+2hGwWmSPOdYOq3I9RtTH3QEiM9ICce
         UlsazpkrBEYr+qw8m9OAnSEgaqCRmsfuwnkcdJXYMhN+tszvkVd+jBT3ReT4JSAhqJKB
         EnPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778540308; x=1779145108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULxQjRtw2mVRm+P5lRYIKNh5DbGbU0zMeN9kkE3aGeM=;
        b=qaFc4zs10I7oXPy8nXoN/nABrC2JgPKsxEz1Z2A/qTdY665mHE4ByKY+QwUiT1eJtL
         omap1h544p7oz+tmOb3W1aAT/WAKxLQ8H2XAbJTK6fVOZS++gkwPXL8wgY/qul4f3w6s
         Gn5mNCAS1NbmZOQ3yYIXImDFcNxl+zTTJy/as1TE+soz0kDMSTutwwSB2ckTQ8UT89Fs
         ijCx+SgSY/PteXq6ecbvQdBMsrxv348eYdGS5SykK9G7K66zksXBtKZgDa1MJQx89xjb
         8ZoKMYtvFGa4gW2ixss29UtrYuDb5BnVOkVmHDloKCyfvjOkX20Nr15lzL35TMp9AsPP
         e0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778540308; x=1779145108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ULxQjRtw2mVRm+P5lRYIKNh5DbGbU0zMeN9kkE3aGeM=;
        b=UYcNvem6do8XbM8mEHY4Zp1U4U0R3ORtALfIwq78263wQFpGG/88J2OqyTKSDmzxPp
         qtEdQpJoQvpngv48BL/n0s7R2E1iJqjB0BBT9A+dkh8Pj+yYBTmUNSWwlRLh4ITWI/rp
         hxDZonzciy4mZRoqvDHTR6xzqbiTMLOPNRXtK4HaVUEN+AOaVqCoMndppKoUjQHiK8O9
         woaSK7RrLEQ2jvy3Zj1HmxEljtUHeAnauFBT2fqtEMvV6s3UBGBP6c3RC3FAAzTDAkfL
         m+Il4nntMjgBf+SS9eoLnsKLvwunUu8j0OCxkRDKixg/DSD5/BbrJ2eJPQ2vFI9OgJKI
         WL4A==
X-Gm-Message-State: AOJu0YzF+xKXfJV/Zb8e7aS5KXSTd6I8T/ANuC1djeJBmjFiYF1a/Act
	fSwq1loiY5Kw799YwfNDSqqKn2LD47yK371IyHQ8x/WqmIFgDWgM4KjPTUeGCN/pv0Geo0zoWHY
	O2C4XypbZ8Q9AZksS901lG8ZmB3EdSes=
X-Gm-Gg: Acq92OH0iPxqcNhw6WEsD3T1CMaGuX6UJhHxx5o0mT7LYOsedCvLB8OLfdcGweFbH1d
	h4ZlzrLN+If88HwS6+jH4gofoji8HOIqJ9T8eLsirqzIf4CJNJ0UGMMC/CMopaUGwbTxAimLrw6
	g62x+/y1cfI7A0MYCZHXPs9B0HNV6CXRKet8dYjo96YuEwmaaAjHzhFEZNulav4vwZuuj3HOjm5
	Q3MhNzsy7ZuXy49s5WiU9uV96Eg/d3Ktl2hUwa6mBrkCOixD0HOmsTsbNcyFi6+7jcCpvxLIbWI
	UqDuq6INmrk0fh9ML88FjsyBGw1ra0WEFFEJwfAwAGYw6/5aKvqYnL1IM+cn/cYzfE39BC81VUT
	tLkJuFyxAR3Oma1WmkfnZWczErQ==
X-Received: by 2002:a05:6000:2f87:b0:43f:e721:76b8 with SMTP id
 ffacd0b85a97d-4515d99f482mr39905435f8f.37.1778540307433; Mon, 11 May 2026
 15:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427232313.1582588-1-puranjay@kernel.org>
In-Reply-To: <20260427232313.1582588-1-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 May 2026 15:58:16 -0700
X-Gm-Features: AVHnY4ITogejax_IcgaXDiT9gbhc1ehq56i_ChyenMl8xMroPdo0qtGrxwCVK-I
Message-ID: <CAADnVQLNYDaJcCPiwzE_Gdy8XEjXFNkQsMgomOuCZBnYM5ZTsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] selftests/bpf: Add XDP load-balancer benchmark
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Fei Chen <feichen@meta.com>, 
	Taruna Agrawal <taragrawal@meta.com>, Nikhil Dixit Limaye <ndixit@meta.com>, 
	"Nikita V. Shirokov" <tehnerd@tehnerd.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 4:23=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Changelog:
> RFC: https://lore.kernel.org/all/20260420111726.2118636-1-puranjay@kernel=
.org/
> Changes in v1:
> - Replace bpf_get_cpu_time_counter() with bpf_ktime_get_ns()
> - Replace bpf_repeat() with plain for loop and may_goto
> - Refactor collect_measurements() to reuse bench_force_done()
> - Remove histogram, verbose calibration output, and per-scenario status p=
rints
> - Trim run script table to p50/stddev/p99
> - Set env.quiet when --machine-readable is passed
> - Add || true to run script benchmark invocation for set -e safety
> - Add bpf-nop benchmark as timing overhead baseline (patch 3)
> - Use named struct for LRU inner map to fix build on older toolchains
>
> This series adds an XDP load-balancer benchmark (based on Katran) to the =
BPF
> selftest bench framework.
>
> Motivation
> ----------
>
> Existing BPF bench tests measure individual operations (map lookups,
> kprobes, ring buffers) in isolation.  Production BPF programs combine
> parsing, map lookups, branching, and packet rewriting in a single call
> chain.  The performance characteristics of such programs depend on the
> interaction of these operations -- register pressure, spills, inlining
> decisions, branch layout -- which isolated micro-benchmarks do not
> capture.
>
> This benchmark implements a simplified L4 load-balancer modeled after
> katran [1].  The BPF program reproduces katran's core datapath:
>
>   L3/L4 parsing -> VIP hash lookup -> per-CPU LRU connection table
>   with consistent-hash fallback -> real server selection -> per-VIP
>   and per-real stats -> IPIP/IP6IP6 encapsulation
>
> The BPF code exercises hash maps, array-of-maps (per-CPU LRU),
> percpu arrays, jhash, bpf_xdp_adjust_head(), bpf_ktime_get_ns(),
> and bpf_get_smp_processor_id() in a single pipeline.
>
> This is intended as the first in a series of BPF workload benchmarks
> covering other use cases (sched_ext, etc.).
>
> Design
> ------
>
> A userspace loop calling bpf_prog_test_run_opts(repeat=3D1) would
> measure syscall overhead, not BPF program cost -- the ~4 ns early-exit
> paths would be buried under kernel entry/exit.  Using repeat=3DN is
> also unsuitable: the kernel re-runs the same packet without resetting
> state between iterations, so the second iteration of an encap scenario
> would process an already-encapsulated packet.
>
> Instead, timing is measured inside the BPF program using
> bpf_ktime_get_ns().  BENCH_BPF_LOOP() brackets N iterations with
> timestamp reads using a plain for loop with may_goto, runs a
> caller-supplied reset block between iterations to undo side effects
> (e.g. strip encapsulation), and records the elapsed time per batch.
> One extra untimed iteration runs afterward for output validation.
>
> Auto-calibration picks a batch size targeting ~10 ms per invocation.
> A proportionality sanity check verifies that 2N iterations take ~2x
> as long as N.
>
> 24 scenarios cover the code-path matrix:
>
>   - Protocol: TCP, UDP
>   - Address family: IPv4, IPv6, cross-AF (IPv4-in-IPv6)
>   - LRU state: hit, miss (16M flow space), diverse (4K flows), cold
>   - Consistent-hash: direct (LRU bypass)
>   - TCP flags: SYN (skip LRU, force CH), RST (skip LRU insert)
>   - Early exits: unknown VIP, non-IP, ICMP, fragments, IP options
>
> Each scenario validates correctness before benchmarking by comparing
> the output packet byte-for-byte against a pre-built expected packet
> and checking BPF map counters.
>
> Sample single-scenario output:
>
>   $ sudo ./bench xdp-lb --scenario tcp-v4-lru-hit
>   Setting up benchmark 'xdp-lb'...
>   Benchmark 'xdp-lb' started.
>   tcp-v4-lru-hit: median 74.51 ns/op, stddev 0.11, p99 74.81 (202 samples=
)
>
> Sample run script output:
>
>   $ ./benchs/run_bench_xdp_lb.sh
>
>   XDP load-balancer benchmark
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>   +----------------------------------+----------+---------+----------+
>   | Single-flow baseline             |      p50 |  stddev |      p99 |
>   +----------------------------------+----------+---------+----------+
>   | tcp-v4-lru-hit                   |    74.30 |    0.08 |    74.48 |
>   | tcp-v4-ch                        |   101.73 |    0.11 |   102.01 |
>   | tcp-v6-lru-hit                   |    76.77 |    0.14 |    77.04 |
>   | tcp-v6-ch                        |   121.40 |    0.10 |   121.65 |
>   | udp-v4-lru-hit                   |   107.42 |    0.22 |   107.90 |
>   | udp-v6-lru-hit                   |   110.21 |    0.12 |   110.45 |
>   | tcp-v4v6-lru-hit                 |    74.82 |    0.35 |    75.43 |
>   +----------------------------------+----------+---------+----------+
>   | Diverse flows (4K src addrs)     |      p50 |  stddev |      p99 |
>   +----------------------------------+----------+---------+----------+
>   | tcp-v4-lru-diverse               |    86.63 |    0.37 |    89.04 |
>   | tcp-v4-ch-diverse                |   104.09 |    0.19 |   105.67 |
>   | tcp-v6-lru-diverse               |    89.34 |    0.42 |    90.70 |
>   | tcp-v6-ch-diverse                |   122.20 |    0.21 |   123.78 |
>   | udp-v4-lru-diverse               |   119.37 |    0.58 |   123.10 |
>   +----------------------------------+----------+---------+----------+
>   | TCP flags                        |      p50 |  stddev |      p99 |
>   +----------------------------------+----------+---------+----------+
>   | tcp-v4-syn                       |   165.52 |   15.68 |   198.34 |
>   | tcp-v4-rst-miss                  |   161.34 |    2.69 |   172.64 |
>   +----------------------------------+----------+---------+----------+
>   | LRU stress                       |      p50 |  stddev |      p99 |
>   +----------------------------------+----------+---------+----------+
>   | tcp-v4-lru-miss                  |   440.39 |   35.75 |   550.62 |
>   | udp-v4-lru-miss                  |   571.88 |   57.38 |   680.61 |
>   | tcp-v4-lru-warmup                |   317.75 |    9.55 |   356.20 |

Applied, but these huge stddev numbers are concerning.
Since the results are all over the place, how can we trust them?

Also please follow with a fix for:

./bench xdp-lb --scenario udp-v4-lru-miss
Setting up benchmark 'xdp-lb'...
  [udp-v4-lru-miss] COUNTER FAIL: LRU misses=3D0, expected 1
Validation FAILED - aborting benchmark

./bench xdp-lb --scenario udp-v4-lru-miss
Setting up benchmark 'xdp-lb'...
Benchmark 'xdp-lb' started.
udp-v4-lru-miss: median 282.49 ns/op, stddev 21.12, p99 340.05 (223 samples=
)

./bench xdp-lb --scenario udp-v4-lru-miss
Setting up benchmark 'xdp-lb'...
  [udp-v4-lru-miss] COUNTER FAIL: LRU misses=3D0, expected 1
Validation FAILED - aborting benchmark

./bench xdp-lb --scenario udp-v4-lru-miss
Setting up benchmark 'xdp-lb'...
Benchmark 'xdp-lb' started.
udp-v4-lru-miss: median 289.42 ns/op, stddev 13.07, p99 355.29 (223 samples=
)

It fails way too often.
