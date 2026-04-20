Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AF62E0B5C
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683876; cv=none; b=NRNMc/NXeVjZkpwuY+wAS8Ex4Vkht1as9XMFk1m00l0AEvwznn0aLRmYeIP0w8md6OADSHoqcEQ1Xvo0VmVN1iP7oVofwojPZGmMlTZtudCalk8N37aN1m+Z/kxr36oW4Yc1RbOejk05hk6hWPVQl/ngOZ5KLvbeo26rBeG/bZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683876; c=relaxed/simple;
	bh=G3o5u0wnT7xv6eUvmheNnb6g0YJzH/nV1nfzQ/qiEGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IeS2Vg4LMGqwqEFZnqMvEkUwIAFIxUZ+IFd8vXnMk+6A4hTvS62o0YwFC/53VCiZT2mipLYBwAb8oy0WbYE5MoWkRf0CUUn5uRKGaFa+76QRLwUbXgCgy8xm13z/MX2NeGnTaePwBsEUypZ2siA3JsxCEu5bg09T8Ai06b50zS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRuYDgd2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRuYDgd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F74C19425;
	Mon, 20 Apr 2026 11:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776683875;
	bh=G3o5u0wnT7xv6eUvmheNnb6g0YJzH/nV1nfzQ/qiEGA=;
	h=From:To:Cc:Subject:Date:From;
	b=iRuYDgd2SAF/D3Zc0d0W6s0GQM9FkRjSmAfXlVj8xo2Q248qDRVzSnTYqJKmJjrAu
	 45BEuSL+RNjgcb/6AzqrMtSK8vWTJei61f172Sm+PMbvbBn58Ald586QnN0n5SXhnG
	 ZYDO+uXj//cBHgivDh+T+R6paBK8h23a4gRbe5CG0rmY1OJEZ328Nm29slh6yszh3F
	 tN9uaKAQTuRcsKgKGB/FS/kCOkpPML0KQOLsxvumd699Me4gh37pTvuBXYRbkpiqvO
	 IYllUH+CRnu92g1LcjtQIeTzSXXu8JPxW8PiTxqjWIbTIUtKu0p2U+LmgbaLWc8yNc
	 kLHakIUca2+sA==
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
Subject: [RFC PATCH bpf-next 0/6] selftests/bpf: Add XDP load-balancer benchmark
Date: Mon, 20 Apr 2026 04:17:00 -0700
Message-ID: <20260420111726.2118636-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds an XDP load-balancer benchmark (based on Katran) to the BPF
selftest bench framework.

This series depends on the bpf_get_cpu_time_counter() kfunc series:
https://lore.kernel.org/all/20260418131614.1501848-1-puranjay@kernel.org/
But if that doesn't land in time, we can replace
bpf_get_cpu_time_counter() with bpf_ktime_get_ns() which means more
benchmarking overhead but it should still work.

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
bpf_get_cpu_time_counter().  BENCH_BPF_LOOP() brackets N iterations
with counter reads, runs a caller-supplied reset block between
iterations to undo side effects (e.g. strip encapsulation), and
records the elapsed time per batch.  One extra untimed iteration
runs afterward for output validation.

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

  $ sudo ./bench -a -w3 -p1 xdp-lb --scenario tcp-v4-lru-miss
  Calibration: 84 ns/op, batch_iters=119047 (~9ms/batch)
  Proportionality check: 2N/N ratio=1.9996 (ok)
  Validating scenario 'tcp-v4-lru-miss' (batch_iters=119047):
    [tcp-v4-lru-miss] PASS  (XDP_TX) IPv4 TCP, LRU miss (16M flow space), CH lookup
    Flow diversity: 16777216 unique src addrs (mask 0xffffff)
    Cold LRU: enabled (per-batch generation)

  Scenario: tcp-v4-lru-miss - IPv4 TCP, LRU miss (16M flow space), CH lookup
  Batch size: 119047 iterations/invocation (+1 for validation)

  In-BPF timing: 203 samples, 119047 ops/batch
    median 856.8 ns/op, stddev 39.4, CV 4.54% [min 817.4, max 1173.6]
    p50 856.8, p75 881.4, p90 918.3, p95 943.3, p99 976.3
    NOTE: right-skewed distribution (tail 3.6x the body)

    Distribution (ns/op):
         <p1 : 1         (below range)
         820 : 4         |***                                     |
         830 : 31        |*****************************           |
         840 : 42        |****************************************|
         850 : 33        |*******************************         |
         860 : 25        |***********************                 |
         870 : 15        |**************                          |
         880 : 8         |*******                                 |
         890 : 14        |*************                           |
         900 : 6         |*****                                   |
         910 : 6         |*****                                   |
         920 : 2         |*                                       |
         930 : 5         |****                                    |
         940 : 2         |*                                       |
         950 : 3         |**                                      |
         960 : 2         |*                                       |
         970 : 2         |*                                       |
        >p99 : 2         (above range)

Sample run script output:

  $ ./benchs/run_bench_xdp_lb.sh

  +----------------------------------+------+----------+---------+--------+----------+----------+----------+----------+
  | Single-flow baseline             |    n |      p50 |  stddev |     CV |      min |      p90 |      p99 |      max |
  +----------------------------------+------+----------+---------+--------+----------+----------+----------+----------+
  | tcp-v4-lru-hit                   |  202 |    83.14 |    0.16 |  0.19% |    82.79 |    83.31 |    83.51 |    83.60 |
  | tcp-v4-ch                        |  201 |    92.26 |    0.12 |  0.13% |    92.05 |    92.41 |    92.57 |    92.68 |
  | tcp-v6-lru-hit                   |  202 |    81.00 |    0.12 |  0.14% |    80.80 |    81.15 |    81.45 |    81.56 |
  | tcp-v6-ch                        |  201 |   106.36 |    0.14 |  0.13% |   106.07 |   106.55 |   106.73 |   107.03 |
  | udp-v4-lru-hit                   |  202 |   114.65 |    0.17 |  0.15% |   114.22 |   114.85 |   115.02 |   115.06 |
  | udp-v6-lru-hit                   |  297 |   112.91 |    0.17 |  0.15% |   112.56 |   113.13 |   113.45 |   113.50 |
  | tcp-v4v6-lru-hit                 |  298 |    81.28 |    1.11 |  1.37% |    80.09 |    82.04 |    86.32 |    86.71 |
  +----------------------------------+------+----------+---------+--------+----------+----------+----------+----------+
  | Diverse flows (4K src addrs)     |    n |      p50 |  stddev |     CV |      min |      p90 |      p99 |      max |
  +----------------------------------+------+----------+---------+--------+----------+----------+----------+----------+
  | tcp-v4-lru-diverse               |  272 |    93.43 |    0.38 |  0.40% |    92.76 |    93.92 |    94.97 |    95.30 |
  | tcp-v4-ch-diverse                |  291 |    94.92 |    1.88 |  1.97% |    94.08 |    97.70 |   102.66 |   102.86 |
  | tcp-v6-lru-diverse               |  270 |    89.43 |    1.85 |  2.06% |    88.42 |    91.34 |    99.04 |   100.00 |
  | tcp-v6-ch-diverse                |  291 |   108.85 |    0.23 |  0.21% |   108.58 |   109.04 |   110.26 |   110.73 |
  | udp-v4-lru-diverse               |  268 |   126.66 |    2.04 |  1.60% |   124.95 |   129.11 |   137.47 |   138.29 |
  +----------------------------------+------+----------+---------+--------+----------+----------+----------+----------+
  | TCP flags                        |    n |      p50 |  stddev |     CV |      min |      p90 |      p99 |      max |
  +----------------------------------+------+----------+---------+--------+----------+----------+----------+----------+
  | tcp-v4-syn                       |  204 |   787.60 |    0.92 |  0.12% |   785.53 |   788.68 |   790.23 |   791.21 |
  | tcp-v4-rst-miss                  |  226 |   160.33 |    1.12 |  0.70% |   158.67 |   161.71 |   164.23 |   164.92 |
  +----------------------------------+------+----------+---------+--------+----------+----------+----------+----------+
  | LRU stress                       |    n |      p50 |  stddev |     CV |      min |      p90 |      p99 |      max |
  +----------------------------------+------+----------+---------+--------+----------+----------+----------+----------+
  | tcp-v4-lru-miss                  |  203 |   855.68 |   31.97 |  3.71% |   813.63 |   908.00 |   952.04 |   979.49 |
  | udp-v4-lru-miss                  |  211 |   854.79 |   48.24 |  5.55% |   819.49 |   928.10 |  1061.91 |  1129.39 |
  | tcp-v4-lru-warmup                |  286 |   534.18 |   16.62 |  3.09% |   510.34 |   559.55 |   592.37 |   594.51 |
  +----------------------------------+------+----------+---------+--------+----------+----------+----------+----------+
  | Early exits                      |    n |      p50 |  stddev |     CV |      min |      p90 |      p99 |      max |
  +----------------------------------+------+----------+---------+--------+----------+----------+----------+----------+
  | pass-v4-no-vip                   |  210 |    25.80 |    0.04 |  0.15% |    25.72 |    25.85 |    25.88 |    26.04 |
  | pass-v6-no-vip                   |  282 |    27.67 |    0.06 |  0.20% |    27.60 |    27.73 |    27.96 |    28.00 |
  | pass-v4-icmp                     |  215 |     5.57 |    0.06 |  1.12% |     5.47 |     5.67 |     5.76 |     5.77 |
  | pass-non-ip                      |  207 |     4.80 |    0.10 |  2.14% |     4.67 |     4.94 |     5.18 |     5.23 |
  | drop-v4-frag                     |  207 |     4.81 |    0.02 |  0.48% |     4.79 |     4.85 |     4.88 |     4.89 |
  | drop-v4-options                  |  206 |     4.82 |    0.09 |  1.95% |     4.74 |     5.00 |     5.17 |     5.24 |
  | drop-v6-frag                     |  201 |     4.93 |    0.09 |  1.89% |     4.86 |     5.11 |     5.21 |     5.36 |
  +----------------------------------+------+----------+---------+--------+----------+----------+----------+----------+

Patches
-------

Patch 1 adds bench_force_done() to the bench framework so benchmarks
can signal early completion when enough samples have been collected.

Patch 2 adds the shared BPF batch-timing library (BPF-side timing
arrays, BENCH_BPF_LOOP macro, userspace statistics and calibration).

Patch 3 adds the common header shared between the BPF program and
userspace (flow_key, vip_definition, real_definition, encap helpers).

Patch 4 adds the XDP load-balancer BPF program.

Patch 5 adds the userspace benchmark driver with 24 scenarios,
packet construction, validation, and bench framework integration.

Patch 6 adds the run script for running all scenarios.

[1] https://github.com/facebookincubator/katran

Puranjay Mohan (6):
  selftests/bpf: Add bench_force_done() for early benchmark completion
  selftests/bpf: Add BPF batch-timing library
  selftests/bpf: Add XDP load-balancer common definitions
  selftests/bpf: Add XDP load-balancer BPF program
  selftests/bpf: Add XDP load-balancer benchmark driver
  selftests/bpf: Add XDP load-balancer benchmark run script

 tools/testing/selftests/bpf/Makefile          |    4 +
 tools/testing/selftests/bpf/bench.c           |   11 +
 tools/testing/selftests/bpf/bench.h           |    1 +
 .../testing/selftests/bpf/bench_bpf_timing.h  |   49 +
 .../selftests/bpf/benchs/bench_bpf_timing.c   |  415 ++++++
 .../selftests/bpf/benchs/bench_xdp_lb.c       | 1160 +++++++++++++++++
 .../selftests/bpf/benchs/run_bench_xdp_lb.sh  |   84 ++
 .../bpf/progs/bench_bpf_timing.bpf.h          |   68 +
 .../selftests/bpf/progs/xdp_lb_bench.c        |  653 ++++++++++
 .../selftests/bpf/xdp_lb_bench_common.h       |  112 ++
 10 files changed, 2557 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bench_bpf_timing.h
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_timing.c
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_xdp_lb.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_xdp_lb.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bench_bpf_timing.bpf.h
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_lb_bench.c
 create mode 100644 tools/testing/selftests/bpf/xdp_lb_bench_common.h


base-commit: 31f61ac33032ee87ea404d6d996ba2c386502a36
-- 
2.52.0

