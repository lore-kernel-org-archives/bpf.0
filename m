Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B73345750
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851176; cv=none; b=qXapymyy7VcCE6ugurww3SUWTmD/+WIQPB+5bLGGdjJ6G/0Mc3x9lcYxLWQXc3oG44sZ7TeNLEQWoqsx73ryGdmt+GxmOfKsCCfsqTq5MCsCAr73fOHlDPX1yiSNlaHIA5+avD1+8DILlfv+vEt0xzfY68Iyr7jeOD2wvMQyXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851176; c=relaxed/simple;
	bh=/NXNLLJne1m1beyTs11+lFJn5WgxT0mW5oi0GTq0wX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5nMuoj8BVmJjxlfHqSYyPItbD4M8V1thNvdv21fCx+YvNkSAkhCIMB6Z/bvAYZVlJMnBasn4E4uPfl/SK+q0GOdAlKze1wTEJ3dQiI/Kx8lPzlAecogzjH4PqTbLTGrP6TjI5cRsbuWiMXRNc4MlqAll7tzJv/xbXLHi2SaUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmVGaFuP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmVGaFuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5170F1F000E9;
	Tue,  4 Aug 2026 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785851174;
	bh=ju3lN6zAZf8qHo333U3ybYwIFg5ObQBZnrImutoeozU=;
	h=From:To:Cc:Subject:Date;
	b=BmVGaFuPBoLVNtdBGr+DIS/qgdQbfxkWUaPah93NUA+stMwCXD8CSGZA3PpArMOUV
	 SlqH7H4r8vJSRcASnePOJPQfl8UUDYPYMtl31S+EJ5gGDssS+d92Ev2P5SX2gdKjDc
	 WSo/jzubCgMffxSBil0t9Fk+WtdK7iZn9PSRYFbTkCbDqatTouvVyripXtmHuOL+ow
	 pgYNR5PNjfmAeCVrCojHubv8e0gSSn7hRy2/TQyzEhzHzYWr+yCIXcEgVEfALmmbXZ
	 Eoz+xXI8omXk46bmIkmZkd/uX0Hwbiu1CG9WJgWKoFPOfqQkMaFb9n/vnwSm6sMTTT
	 89DRvd5p5Mnyw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v5 0/6] bpf: Inline the numeric open-coded iterator kfuncs
Date: Tue,  4 Aug 2026 06:45:52 -0700
Message-ID: <20260804134601.2305303-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_for(i, start, end) macro is BPF's open-coded numeric iterator. It
expands into calls to three kfuncs: bpf_iter_num_new() to set the iterator
up, bpf_iter_num_next() once per iteration, and bpf_iter_num_destroy() to
tear it down. The verifier emits these as ordinary kfunc calls, so a
bpf_for() loop pays function-call overhead on setup, teardown, and -- most
importantly -- on every single iteration via bpf_iter_num_next().

All three kfuncs are tiny and only touch the 8-byte on-stack iterator state
(struct bpf_iter_num_kern { int cur; int end; }). That makes them good
candidates for inlining, the same way several other special kfuncs are
already open-coded in bpf_fixup_kfunc_call(). This series replaces each of
the three calls with an equivalent inline BPF instruction sequence:

  - bpf_iter_num_new(): the end - start range check is done with 32-bit
    arithmetic (start <= end is checked first, so the distance fits in a
    u32) and range-checked against BPF_MAX_LOOPS as unsigned. This avoids
    the cpuv4 sign-extension insns that some JITs do not implement. Returns
    the same -EINVAL / -E2BIG / 0 as the kfunc.

  - bpf_iter_num_next(): the hot path. cur and end are int, so the kfunc's
    s->cur + 1 >= s->end test is an ordinary signed 32-bit compare and the
    inlined code needs no sign extension.

  - bpf_iter_num_destroy(): the stack slot is no longer tracked as iterator
    state once destroy() returns, so nothing needs to be written to it.
    Both the kfunc and the inlined form become a no-op, which just drops the
    call.

The emitted instructions are plain BPF and remain valid for the
interpreter, so interpreter fallback stays correct and no jit_required
marking is needed.

Benchmark (./bench -p 1 --nr_loops 1000000 {bpf-loop,bpf-for}):

    +--------+---------------------+---------------------+---------------------+
    |  arch  |       bpf_loop      | bpf_for non-inlined |   bpf_for inlined   |
    +--------+---------------------+---------------------+---------------------+
    | x86-64 |  4252 M/s (0.24 ns) |  3608 M/s (0.28 ns) |  7417 M/s (0.13 ns) |
    +--------+---------------------+---------------------+---------------------+
    | arm64  |  649 M/s (1.54 ns)  |  548 M/s (1.82 ns)  |  546 M/s (1.83 ns)  |
    +--------+---------------------+---------------------+---------------------+

On x86-64 removing the per-iteration call roughly doubles bpf_for()
throughput. On arm64 it is neutral, and rather than guess why this was
checked with perf: inlining removes ~28% of the executed instructions (the
call) but leaves the cycle count unchanged -- IPC drops from ~4.2 to ~3.0
and backend stalls rise from ~50% to ~66%. The loop is bound by the latency
of the iterator's on-stack counter, not by call overhead:
bpf_iter_num_next() loads s->cur from the stack, increments it and stores it
back each iteration, and the next iteration's load depends on that store.
The removed call instructions were executing in the shadow of that
store->load stall and were never on the critical path.

A small userspace microbenchmark isolates the effect: a same-address
store->load->add round-trip (the shape of the on-stack counter) costs
~6 cycles/iteration on the tested arm64 core but ~1 cycle on x86-64, where
the core collapses the same-address round-trip into a register move (memory
renaming / store-to-load-forwarding elimination). So on x86-64 the loop is
not latency-bound and the per-iteration call dominates -- removing it is the
~2x win -- whereas on arm64 the call fits entirely inside the store->load
stall the loop already has, so adding or removing it changes nothing.

bpf_loop() is shown for reference only; it is a different construct (a
callback invoked per iteration) and this series does not change it. Its
counter lives in a register rather than on the stack, so on arm64 it avoids
the store->load latency above and is faster than bpf_for() there.

Changelog:
v4: https://lore.kernel.org/all/20260729203633.213973-1-puranjay@kernel.org/
Changes in v5:
- Inline the new()/next()/destroy() sequences directly in
  bpf_fixup_kfunc_call() instead of via helper functions (Andrii Nakryiko)
- Trim the code comments; keep the explanation in the bpf_iter.c kfuncs and
  leave only brief comments at the inline sites, and shorten the
  bpf_iter_num_destroy() kfunc to /* no-op */ (Andrii Nakryiko)
- Reword the patch 1 comment so it no longer forward-references the inlined
  bpf_iter_num_next(), which is only added later in the series (bpf-ci)
- Switch the bpf_iter_num_next() comment to the networking multi-line style

v3: https://lore.kernel.org/all/20260722132424.450230-1-puranjay@kernel.org/
Changes in v4:
- Drop the "elide range checks for constant bounds" patch (Andrii Nakryiko)
- bpf_iter_num_new(): range-check the distance against BPF_MAX_LOOPS with an
  unsigned compare (Andrii Nakryiko)
- bpf_iter_num_destroy(): make it a no-op in both the kfunc and the inlined
  form instead of zeroing the iterator state (Andrii Nakryiko)
- New patch: fix the misleading overflow comment in bpf_iter_num_next() and
  drop the redundant (s64) cast; the int wraparound is intentional and
  load-bearing (Andrii Nakryiko)
- bpf_for benchmark: nr_loops is int, matching what bpf_for() expects
  (Andrii Nakryiko)
- Corroborate the arm64/x86 benchmark difference with perf counters and a
  store-to-load-forwarding microbenchmark (Kumar Kartikeya Dwivedi,
  Andrii Nakryiko)

v2: https://lore.kernel.org/bpf/20260717120215.2171057-1-puranjay@kernel.org/
Changes in v3:
- Elide the range checks in bpf_iter_num_new() when start and end are
  constant, marking the registers precise so paths reaching the call with
  different constants are not pruned (Eduard Zingerman)
- Add __xlated selftests pinning the inlined new()/next()/destroy() shapes
  (Eduard Zingerman)
- Use the insn_buf[i++] idiom in the inline helpers (Eduard Zingerman)
- Pick up Acked-by on patch 3

v1: https://lore.kernel.org/all/20260715130430.318421-1-puranjay@kernel.org/
Changes in v2:
- Don't emit sign-extending (movsx) moves; some JITs (e.g. x86-32, mips32,
  sparc64) decode them as a plain move and would miscompile the range check

Puranjay Mohan (6):
  bpf: Correct the overflow check comment in bpf_iter_num_next()
  bpf: Inline bpf_iter_num_new() kfunc
  bpf: Inline bpf_iter_num_next() kfunc
  bpf: Inline bpf_iter_num_destroy() as a no-op
  selftests/bpf: Verify inlined numeric iterator shape with __xlated
  selftests/bpf: Add bpf_for() benchmark

 kernel/bpf/bpf_iter.c                         |  17 ++-
 kernel/bpf/verifier.c                         |  45 ++++++++
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_bpf_for.c      | 104 ++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_bpf_for.sh |  15 +++
 .../selftests/bpf/progs/bpf_for_bench.c       |  32 ++++++
 tools/testing/selftests/bpf/progs/iters.c     |  83 ++++++++++++++
 8 files changed, 292 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_for.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_for.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_for_bench.c


base-commit: 7f333f85f83da9a20a60a1d8bf518c4ae0818e5a
-- 
2.53.0-Meta

