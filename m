Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8C221FBB
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332212; cv=none; b=UuUUdzCeXz5hXvFjzpNm3GK7s4q3OpXHnSBsR+S4WlEE5BTR8bnIShVH6zB/vcnX/R5y8kxQPSI18XuW74HyjEKC1FjKaPj/IC9hy+51Uka5Nj9rqoGmhP4Sw+0eISUMdEqm/qb036UUMSt912QqAJJP3x4seMAM6E7rTAYlJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332212; c=relaxed/simple;
	bh=nIayJSgTV1YhNzK/LLuHf3pRm7aSQTngAAJstWkGM5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5VXjt0+Kusrw8SFBc//kZvt0ChfUa6M2vJuo5CPcC7t0Xbwuuordd+jg1W34Pzb9bq1djuYQdMs/Cf+FIi7CenNzIIoitcbJ3pnxwUepdL48cuUMoLOeUE0F1j3DoF8xF3bLDVVKEZ1eMxSNu4w/cV6mJOOrWt39EY7Jz2Pqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrdOqQIH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrdOqQIH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A3FC19425;
	Mon, 27 Apr 2026 23:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332212;
	bh=nIayJSgTV1YhNzK/LLuHf3pRm7aSQTngAAJstWkGM5M=;
	h=From:To:Cc:Subject:Date:From;
	b=VrdOqQIH2mjlXH6axscTAcQ1gJi33v26BKdhmILigio9OCAanHV+QBxH38L3qji9T
	 GWp8WIuW/JumYnsHrmSqUm4rCJKxudC06sc9cr7oVTTTyRj8LV2JlX1Gv7iZ28MHRD
	 ttgslvqSzCaiEwla+FmoX8F1s/tT/dwPTnTNyEK0ykSi+LJJjcoTV98P6ry5Q1jj5h
	 cBF9uWuq5obvane38MlRwfuf71OVFay0qGakH1eJZkahI760NdI8acyedFm2L1EQ4F
	 5/pxyJVzVu1yXLy7CaXN92cg7IDqhh6lWubV03vtR3W2XDRqmS7PMdttOvj5gHM4Wq
	 8Nzrk9MlBVDKQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Fei Chen <feichen@meta.com>,
	Taruna Agrawal <taragrawal@meta.com>,
	Nikhil Dixit Limaye <ndixit@meta.com>,
	"Nikita V. Shirokov" <tehnerd@tehnerd.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/7] selftests/bpf: Add XDP load-balancer benchmark
Date: Mon, 27 Apr 2026 16:22:57 -0700
Message-ID: <20260427232313.1582588-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
RFC: https://lore.kernel.org/all/20260420111726.2118636-1-puranjay@kernel.org/
Changes in v1:
- Replace bpf_get_cpu_time_counter() with bpf_ktime_get_ns()
- Replace bpf_repeat() with plain for loop and may_goto
- Refactor collect_measurements() to reuse bench_force_done()
- Remove histogram, verbose calibration output, and per-scenario status prints
- Trim run script table to p50/stddev/p99
- Set env.quiet when --machine-readable is passed
- Add || true to run script benchmark invocation for set -e safety
- Add bpf-nop benchmark as timing overhead baseline (patch 3)
- Use named struct for LRU inner map to fix build on older toolchains

This series adds an XDP load-balancer benchmark (based on Katran) to the BPF
selftest bench framework.

Motivation
----------

Existing BPF bench tests measure individual operations (map lookups,
kprobes, ring buffers) in isolation.  Production BPF programs combine
parsing, map lookups, branching, and packet rewriting in a single call
chain.  The performance characteristics of such programs depend on the
interaction of these operations -- register pressure, spills, inlining
decisions, branch layout -- which isolated micro-benchmarks do not
capture.

This benchmark implements a simplified L4 load-balancer modeled after
katran [1].  The BPF program reproduces katran's core datapath:

  L3/L4 parsing -> VIP hash lookup -> per-CPU LRU connection table
  with consistent-hash fallback -> real server selection -> per-VIP
  and per-real stats -> IPIP/IP6IP6 encapsulation

The BPF code exercises hash maps, array-of-maps (per-CPU LRU),
percpu arrays, jhash, bpf_xdp_adjust_head(), bpf_ktime_get_ns(),
and bpf_get_smp_processor_id() in a single pipeline.

This is intended as the first in a series of BPF workload benchmarks
covering other use cases (sched_ext, etc.).

Design
------

A userspace loop calling bpf_prog_test_run_opts(repeat=1) would
measure syscall overhead, not BPF program cost -- the ~4 ns early-exit
paths would be buried under kernel entry/exit.  Using repeat=N is
also unsuitable: the kernel re-runs the same packet without resetting
state between iterations, so the second iteration of an encap scenario
would process an already-encapsulated packet.

Instead, timing is measured inside the BPF program using
bpf_ktime_get_ns().  BENCH_BPF_LOOP() brackets N iterations with
timestamp reads using a plain for loop with may_goto, runs a
caller-supplied reset block between iterations to undo side effects
(e.g. strip encapsulation), and records the elapsed time per batch.
One extra untimed iteration runs afterward for output validation.

Auto-calibration picks a batch size targeting ~10 ms per invocation.
A proportionality sanity check verifies that 2N iterations take ~2x
as long as N.

24 scenarios cover the code-path matrix:

  - Protocol: TCP, UDP
  - Address family: IPv4, IPv6, cross-AF (IPv4-in-IPv6)
  - LRU state: hit, miss (16M flow space), diverse (4K flows), cold
  - Consistent-hash: direct (LRU bypass)
  - TCP flags: SYN (skip LRU, force CH), RST (skip LRU insert)
  - Early exits: unknown VIP, non-IP, ICMP, fragments, IP options

Each scenario validates correctness before benchmarking by comparing
the output packet byte-for-byte against a pre-built expected packet
and checking BPF map counters.

Sample single-scenario output:

  $ sudo ./bench xdp-lb --scenario tcp-v4-lru-hit
  Setting up benchmark 'xdp-lb'...
  Benchmark 'xdp-lb' started.
  tcp-v4-lru-hit: median 74.51 ns/op, stddev 0.11, p99 74.81 (202 samples)

Sample run script output:

  $ ./benchs/run_bench_xdp_lb.sh

  XDP load-balancer benchmark
  ===========================
  +----------------------------------+----------+---------+----------+
  | Single-flow baseline             |      p50 |  stddev |      p99 |
  +----------------------------------+----------+---------+----------+
  | tcp-v4-lru-hit                   |    74.30 |    0.08 |    74.48 |
  | tcp-v4-ch                        |   101.73 |    0.11 |   102.01 |
  | tcp-v6-lru-hit                   |    76.77 |    0.14 |    77.04 |
  | tcp-v6-ch                        |   121.40 |    0.10 |   121.65 |
  | udp-v4-lru-hit                   |   107.42 |    0.22 |   107.90 |
  | udp-v6-lru-hit                   |   110.21 |    0.12 |   110.45 |
  | tcp-v4v6-lru-hit                 |    74.82 |    0.35 |    75.43 |
  +----------------------------------+----------+---------+----------+
  | Diverse flows (4K src addrs)     |      p50 |  stddev |      p99 |
  +----------------------------------+----------+---------+----------+
  | tcp-v4-lru-diverse               |    86.63 |    0.37 |    89.04 |
  | tcp-v4-ch-diverse                |   104.09 |    0.19 |   105.67 |
  | tcp-v6-lru-diverse               |    89.34 |    0.42 |    90.70 |
  | tcp-v6-ch-diverse                |   122.20 |    0.21 |   123.78 |
  | udp-v4-lru-diverse               |   119.37 |    0.58 |   123.10 |
  +----------------------------------+----------+---------+----------+
  | TCP flags                        |      p50 |  stddev |      p99 |
  +----------------------------------+----------+---------+----------+
  | tcp-v4-syn                       |   165.52 |   15.68 |   198.34 |
  | tcp-v4-rst-miss                  |   161.34 |    2.69 |   172.64 |
  +----------------------------------+----------+---------+----------+
  | LRU stress                       |      p50 |  stddev |      p99 |
  +----------------------------------+----------+---------+----------+
  | tcp-v4-lru-miss                  |   440.39 |   35.75 |   550.62 |
  | udp-v4-lru-miss                  |   571.88 |   57.38 |   680.61 |
  | tcp-v4-lru-warmup                |   317.75 |    9.55 |   356.20 |
  +----------------------------------+----------+---------+----------+
  | Early exits                      |      p50 |  stddev |      p99 |
  +----------------------------------+----------+---------+----------+
  | pass-v4-no-vip                   |    18.26 |    0.13 |    18.66 |
  | pass-v6-no-vip                   |    19.08 |    0.01 |    19.10 |
  | pass-v4-icmp                     |     6.81 |    0.02 |     6.86 |
  | pass-non-ip                      |     5.71 |    0.03 |     5.76 |
  | drop-v4-frag                     |     6.09 |    0.01 |     6.10 |
  | drop-v4-options                  |     5.88 |    0.00 |     5.89 |
  | drop-v6-frag                     |     6.00 |    0.03 |     6.04 |
  +----------------------------------+----------+---------+----------+

Patches
-------

Patch 1 adds bench_force_done() to the bench framework so benchmarks
can signal early completion when enough samples have been collected.

Patch 2 adds the shared BPF batch-timing library (BPF-side timing
arrays, BENCH_BPF_LOOP macro, userspace statistics and calibration).

Patch 3 adds a bpf-nop benchmark as a timing overhead baseline and
usage example for the timing library.

Patch 4 adds the common header shared between the BPF program and
userspace (flow_key, vip_definition, real_definition, encap helpers).

Patch 5 adds the XDP load-balancer BPF program.

Patch 6 adds the userspace benchmark driver with 24 scenarios,
packet construction, validation, and bench framework integration.

Patch 7 adds the run script for running all scenarios.

[1] https://github.com/facebookincubator/katran

Puranjay Mohan (7):
  selftests/bpf: Add bench_force_done() for early benchmark completion
  selftests/bpf: Add BPF batch-timing library
  selftests/bpf: Add bpf-nop benchmark for timing overhead baseline
  selftests/bpf: Add XDP load-balancer common definitions
  selftests/bpf: Add XDP load-balancer BPF program
  selftests/bpf: Add XDP load-balancer benchmark driver
  selftests/bpf: Add XDP load-balancer benchmark run script

 tools/testing/selftests/bpf/Makefile          |    6 +
 tools/testing/selftests/bpf/bench.c           |   20 +-
 tools/testing/selftests/bpf/bench.h           |    1 +
 .../testing/selftests/bpf/bench_bpf_timing.h  |   50 +
 .../selftests/bpf/benchs/bench_bpf_nop.c      |   84 ++
 .../selftests/bpf/benchs/bench_bpf_timing.c   |  272 ++++
 .../selftests/bpf/benchs/bench_xdp_lb.c       | 1113 +++++++++++++++++
 .../selftests/bpf/benchs/run_bench_xdp_lb.sh  |   79 ++
 .../bpf/progs/bench_bpf_timing.bpf.h          |   69 +
 .../selftests/bpf/progs/bpf_nop_bench.c       |   14 +
 .../selftests/bpf/progs/xdp_lb_bench.c        |  647 ++++++++++
 .../selftests/bpf/xdp_lb_bench_common.h       |  112 ++
 12 files changed, 2462 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bench_bpf_timing.h
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_nop.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_xdp_lb.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_nop_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_lb_bench.c
 create mode 100644 tools/testing/selftests/bpf/xdp_lb_bench_common.h

-- 
2.52.0

