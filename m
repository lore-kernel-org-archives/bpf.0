Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EEF3A2E02
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590120; cv=pass; b=OxWf185dBNsE+cf9tDGUCfxOpXY2ebPgHF5Xyag7sYcU757li7+zsb2/YQ/9fr8fDRuymFyujGdpetgk3DTOym74Uu7OA5KpcM09ICs5WBBaYtSvLh+Q1Zz6rNsZsKCUtUsMJzqT/y463RRNa0abk6qmfUHviHmBvZNbxHNnc2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590120; c=relaxed/simple;
	bh=HvpKffvI0prsQ2jm132GLkq8ioTtgE6c9HguvJfa5yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcweQ6jpbuM4VOoRO6wa7O6mW/UDtM+zp39MvC5t3ZRfCKNzcQpKOYD/PSRstlEA6b9TVLhuzqAIgg/LLM4jhlWQj3ptIhA1StLTWw9AGwNQgrU8z+stAGIjEmz0T+Woo7PChgh41tUgtnfchH09lmFCEEV/YXJUEit0fw61EcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjL7ISdr; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjL7ISdr"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so8841476a12.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 05:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778590115; cv=none;
        d=google.com; s=arc-20240605;
        b=kPU05q2oMOhnNJThMBvyZUsbwNZsPzrxMxTkk8s9BFy2QjXyVFHrWTPu17+1TutUja
         4bqUktauGe+/r/eLDo5mxocBNqLliTZcRI6od7FRySK4JCXTr1PqCTp0NYf3iU8i+t6Q
         rZ4SLFjttmcHuYj+cIhLSrADBzlkSDjl/I6wYW8CySvv9/B8IooibQLgz/Tjf6lU0Zy+
         KUYTH0ZM+AnddYa9rWkf08Ib8Qs+MabmEuop4m0JzKYgMbcu4ZN1AB9ewH4unu2zI7mW
         Q5+f2N9/NrEQwLbuUB2d7eSImOR1KMtEoNMR5sWQZZ5A8RcYUkqLL5FlpT8cH/GWOVws
         20rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hR6jqqTd2eUlioIEZ2E8fiCLh+G3VGgHiC1GCAiCYR4=;
        fh=6hiPdiTe4zHoVSFcX6DceRO15RsbA1SKMTu9jUn9QM4=;
        b=JghMTieHfNCvU2kwkqzESKi93NCbmZkAg9pzK4b2H29rIuKrTc5tKxzLyZtuDr8N3p
         AXHHu8wygT2xGP+Hpn4U5nlB8cXEMIzOK3rT+IqkLUBZPHjhprIpKzsI1uoiR6JEh4Gb
         4Qvl5Dmwe/S7pnUrHCpGOweqS252zwmpllU1pEubnSyWutFx6OqKmB0dyt/sTZPwovVq
         OIakUXH+CzY9lELicmAd3np9/juQBM64cSamvP+qu5LOFFV6UkwY9lleaNMJ8Kv0o052
         HlIn11lncwiSeWjgoh+09DD8TRiKloXr6xVHDVN9qtY0ouRaV2NhiZ3KetlXQxgMyvdn
         kY7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778590115; x=1779194915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hR6jqqTd2eUlioIEZ2E8fiCLh+G3VGgHiC1GCAiCYR4=;
        b=ZjL7ISdrGpbtxVjYjbgytELRgfHYirne6AQa2u89ibcjyQIJnUU0URpgkgG8YquTrY
         7CU+YizOFm02p2lpD+raXJfwxrKdMa7MOYzyvnzUdSp9JTU+gHblFRUE5OoV5ZJvqP01
         srUWlX976JzF2WqKcUekMEq6QWlhUenenZJnaSZKx3GCo9NT3ObYtM8+7fc8pqWY25TJ
         jlZW/fYe9gTtxyHUj/Np9zhjp828XYMQjwoWTfyFNagX4riZ6KiN35QFEl3uQRZ2sEui
         Q4JmGd6yt5vsqLznw2cTPPMqHR3WyaqxuCZkMvXS9BRwsswj75bcMSS70U7LPjYbvKvC
         se4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778590115; x=1779194915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hR6jqqTd2eUlioIEZ2E8fiCLh+G3VGgHiC1GCAiCYR4=;
        b=swR4qD9PwKq67Ne6pBnL8T6kjW6hS29qQgPdNTxxJi1cv0XmMDTCMrf1PwptCA15F7
         hYiMNVhorEOqT0RC4jThGhqx5E4wc77g2T3KCP1Oy8JZCD72f4e346iDfWtXbh8h4flx
         Q2udPo6fZP7wpsxaKK2iDVphxei1i62tXCsZOutg2D459O9aQdJnVklq/Cq29+a32oxS
         9hh7W21lIPA5LHAdKk+ViBT2IUf9PsXzU/o538l6wVlD80wnbv+RL+rXiCBQRgU5MLA+
         mqk5BsQs5rS04E/LlDqGNVI63Uc88AfTJ/xcdsXaO+KjoTE20vhEhaBiFuTFTGIlXqqM
         xd5w==
X-Gm-Message-State: AOJu0YzGaYcm3Q1Blu5lCr1KIMEd85+FAxsy3rmTi9v82RydExAwnj2y
	qTDYJjnTGY8b7o/ZlJI+gkKK9LY6YlwFe50TmPfbKwTFXHKkGWyp2geh2/6+GiX2Rc5DQMx/+kv
	vwmz2TzE99WqJVI796zfB9y7ZrYKUR8o=
X-Gm-Gg: Acq92OHZh+sR1pKC1sx34zK1iTyOKz2muEEWCXx3nigPfX93ZbU86vcPvBT8M5mWsdB
	vGBtXHqi92qS1RrpVZvqbVoQZIo5R5M8Ma9RTfp7ufQim2EMpg54LXp91Vk59M5yvrRWj5D4RNC
	wS4QtB/s0keLB+0GWXEzwaVQSczTcF3n8uGilHbqnGuk/ZC77andpD++pjxUiT6y6CDr+YA4Lj/
	EdG67xrh8XTVTmBN8b3CnFYYt0eEblfkIogk+jFJskJMiBgZ4P325Vaeu/Zs0cwWBslU1V+swAw
	hceQGTyMag72gFv18LwxI0s0EjHZ
X-Received: by 2002:a05:6402:913:b0:676:e2c2:9034 with SMTP id
 4fb4d7f45d1cf-67d642b99d9mr14571938a12.13.1778590114784; Tue, 12 May 2026
 05:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427232313.1582588-1-puranjay@kernel.org> <CAADnVQLNYDaJcCPiwzE_Gdy8XEjXFNkQsMgomOuCZBnYM5ZTsw@mail.gmail.com>
In-Reply-To: <CAADnVQLNYDaJcCPiwzE_Gdy8XEjXFNkQsMgomOuCZBnYM5ZTsw@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 12 May 2026 14:48:23 +0200
X-Gm-Features: AVHnY4Kp0AZfiBLYxk6UoXFmtVIeujeTcy659Va9wRzYMYbPnDWODGuukI5J1zY
Message-ID: <CANk7y0iBMdON-Vx_jaoiCKeVf2-qi1kNnqAhfuKvWhfz8dyxUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/7] selftests/bpf: Add XDP load-balancer benchmark
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Fei Chen <feichen@meta.com>, Taruna Agrawal <taragrawal@meta.com>, 
	Nikhil Dixit Limaye <ndixit@meta.com>, "Nikita V. Shirokov" <tehnerd@tehnerd.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 12:58=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 27, 2026 at 4:23=E2=80=AFPM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > Changelog:
> > RFC: https://lore.kernel.org/all/20260420111726.2118636-1-puranjay@kern=
el.org/
> > Changes in v1:
> > - Replace bpf_get_cpu_time_counter() with bpf_ktime_get_ns()
> > - Replace bpf_repeat() with plain for loop and may_goto
> > - Refactor collect_measurements() to reuse bench_force_done()
> > - Remove histogram, verbose calibration output, and per-scenario status=
 prints
> > - Trim run script table to p50/stddev/p99
> > - Set env.quiet when --machine-readable is passed
> > - Add || true to run script benchmark invocation for set -e safety
> > - Add bpf-nop benchmark as timing overhead baseline (patch 3)
> > - Use named struct for LRU inner map to fix build on older toolchains
> >
> > This series adds an XDP load-balancer benchmark (based on Katran) to th=
e BPF
> > selftest bench framework.
> >
> > Motivation
> > ----------
> >
> > Existing BPF bench tests measure individual operations (map lookups,
> > kprobes, ring buffers) in isolation.  Production BPF programs combine
> > parsing, map lookups, branching, and packet rewriting in a single call
> > chain.  The performance characteristics of such programs depend on the
> > interaction of these operations -- register pressure, spills, inlining
> > decisions, branch layout -- which isolated micro-benchmarks do not
> > capture.
> >
> > This benchmark implements a simplified L4 load-balancer modeled after
> > katran [1].  The BPF program reproduces katran's core datapath:
> >
> >   L3/L4 parsing -> VIP hash lookup -> per-CPU LRU connection table
> >   with consistent-hash fallback -> real server selection -> per-VIP
> >   and per-real stats -> IPIP/IP6IP6 encapsulation
> >
> > The BPF code exercises hash maps, array-of-maps (per-CPU LRU),
> > percpu arrays, jhash, bpf_xdp_adjust_head(), bpf_ktime_get_ns(),
> > and bpf_get_smp_processor_id() in a single pipeline.
> >
> > This is intended as the first in a series of BPF workload benchmarks
> > covering other use cases (sched_ext, etc.).
> >
> > Design
> > ------
> >
> > A userspace loop calling bpf_prog_test_run_opts(repeat=3D1) would
> > measure syscall overhead, not BPF program cost -- the ~4 ns early-exit
> > paths would be buried under kernel entry/exit.  Using repeat=3DN is
> > also unsuitable: the kernel re-runs the same packet without resetting
> > state between iterations, so the second iteration of an encap scenario
> > would process an already-encapsulated packet.
> >
> > Instead, timing is measured inside the BPF program using
> > bpf_ktime_get_ns().  BENCH_BPF_LOOP() brackets N iterations with
> > timestamp reads using a plain for loop with may_goto, runs a
> > caller-supplied reset block between iterations to undo side effects
> > (e.g. strip encapsulation), and records the elapsed time per batch.
> > One extra untimed iteration runs afterward for output validation.
> >
> > Auto-calibration picks a batch size targeting ~10 ms per invocation.
> > A proportionality sanity check verifies that 2N iterations take ~2x
> > as long as N.
> >
> > 24 scenarios cover the code-path matrix:
> >
> >   - Protocol: TCP, UDP
> >   - Address family: IPv4, IPv6, cross-AF (IPv4-in-IPv6)
> >   - LRU state: hit, miss (16M flow space), diverse (4K flows), cold
> >   - Consistent-hash: direct (LRU bypass)
> >   - TCP flags: SYN (skip LRU, force CH), RST (skip LRU insert)
> >   - Early exits: unknown VIP, non-IP, ICMP, fragments, IP options
> >
> > Each scenario validates correctness before benchmarking by comparing
> > the output packet byte-for-byte against a pre-built expected packet
> > and checking BPF map counters.
> >
> > Sample single-scenario output:
> >
> >   $ sudo ./bench xdp-lb --scenario tcp-v4-lru-hit
> >   Setting up benchmark 'xdp-lb'...
> >   Benchmark 'xdp-lb' started.
> >   tcp-v4-lru-hit: median 74.51 ns/op, stddev 0.11, p99 74.81 (202 sampl=
es)
> >
> > Sample run script output:
> >
> >   $ ./benchs/run_bench_xdp_lb.sh
> >
> >   XDP load-balancer benchmark
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >   +----------------------------------+----------+---------+----------+
> >   | Single-flow baseline             |      p50 |  stddev |      p99 |
> >   +----------------------------------+----------+---------+----------+
> >   | tcp-v4-lru-hit                   |    74.30 |    0.08 |    74.48 |
> >   | tcp-v4-ch                        |   101.73 |    0.11 |   102.01 |
> >   | tcp-v6-lru-hit                   |    76.77 |    0.14 |    77.04 |
> >   | tcp-v6-ch                        |   121.40 |    0.10 |   121.65 |
> >   | udp-v4-lru-hit                   |   107.42 |    0.22 |   107.90 |
> >   | udp-v6-lru-hit                   |   110.21 |    0.12 |   110.45 |
> >   | tcp-v4v6-lru-hit                 |    74.82 |    0.35 |    75.43 |
> >   +----------------------------------+----------+---------+----------+
> >   | Diverse flows (4K src addrs)     |      p50 |  stddev |      p99 |
> >   +----------------------------------+----------+---------+----------+
> >   | tcp-v4-lru-diverse               |    86.63 |    0.37 |    89.04 |
> >   | tcp-v4-ch-diverse                |   104.09 |    0.19 |   105.67 |
> >   | tcp-v6-lru-diverse               |    89.34 |    0.42 |    90.70 |
> >   | tcp-v6-ch-diverse                |   122.20 |    0.21 |   123.78 |
> >   | udp-v4-lru-diverse               |   119.37 |    0.58 |   123.10 |
> >   +----------------------------------+----------+---------+----------+
> >   | TCP flags                        |      p50 |  stddev |      p99 |
> >   +----------------------------------+----------+---------+----------+
> >   | tcp-v4-syn                       |   165.52 |   15.68 |   198.34 |
> >   | tcp-v4-rst-miss                  |   161.34 |    2.69 |   172.64 |
> >   +----------------------------------+----------+---------+----------+
> >   | LRU stress                       |      p50 |  stddev |      p99 |
> >   +----------------------------------+----------+---------+----------+
> >   | tcp-v4-lru-miss                  |   440.39 |   35.75 |   550.62 |
> >   | udp-v4-lru-miss                  |   571.88 |   57.38 |   680.61 |
> >   | tcp-v4-lru-warmup                |   317.75 |    9.55 |   356.20 |
>
> Applied, but these huge stddev numbers are concerning.
> Since the results are all over the place, how can we trust them?

These scenarios have a lot of moving parts and therefore the stddev is
high, I will see if I can improve these by running for longer or
improve the scenarios itself. The only way to trust these in the
current state would be to only take trust improvements in these
benchmarks when it is much bigger than stddev.

> Also please follow with a fix for:
>
> ./bench xdp-lb --scenario udp-v4-lru-miss
> Setting up benchmark 'xdp-lb'...
>   [udp-v4-lru-miss] COUNTER FAIL: LRU misses=3D0, expected 1
> Validation FAILED - aborting benchmark
>
> ./bench xdp-lb --scenario udp-v4-lru-miss
> Setting up benchmark 'xdp-lb'...
> Benchmark 'xdp-lb' started.
> udp-v4-lru-miss: median 282.49 ns/op, stddev 21.12, p99 340.05 (223 sampl=
es)
>
> ./bench xdp-lb --scenario udp-v4-lru-miss
> Setting up benchmark 'xdp-lb'...
>   [udp-v4-lru-miss] COUNTER FAIL: LRU misses=3D0, expected 1
> Validation FAILED - aborting benchmark
>
> ./bench xdp-lb --scenario udp-v4-lru-miss
> Setting up benchmark 'xdp-lb'...
> Benchmark 'xdp-lb' started.
> udp-v4-lru-miss: median 289.42 ns/op, stddev 13.07, p99 355.29 (223 sampl=
es)
>
> It fails way too often.

I will send follow up patches to fix this and the stddev issue.

Thanks
