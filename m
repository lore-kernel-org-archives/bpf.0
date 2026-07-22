Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9D3112AB
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726670; cv=none; b=pRRNmQTSWdqsu/sKGHvWtiE160RBLWGuOa8EDaYRhLpx131IeIb3hwK0rETluoVmC5M/G9YMRTwhcAZ8tIGQYLOeL4MRLoNfamKP0RJnv1uUt1fBQmyFOrFQ3aggH3zg/j2hjjVHj/8CtSuRmUh+w+g3C4eTywkCF34pauHv2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726670; c=relaxed/simple;
	bh=3JotuB+r1ptsQ8NM02IpAbed374hvYI1xzDE1vlDIoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U4Kvv8DObxDtpllKDvA9ooEMfP5ekH3v+F853FQrZxsUXf17RYlEu4Sc5jKKVzEKMhI+41XCNDwC6HOO4UvkuZvO80e/NDsqoeHsG5Pzlqw65yBJnXVAjfPgBrvHwbUxTuW9L0rIyVflC3abhP7pi1uusKoJoy7Qau3kRxk2AY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP7btV6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP7btV6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A3A1F000E9;
	Wed, 22 Jul 2026 13:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726669;
	bh=DnOQCgjvN+Udl1ciju8kou251jqw9Y77OC5Eb83jRG0=;
	h=From:To:Cc:Subject:Date;
	b=GP7btV6C+8W7qVIa0Js3XJocjeknBpxZW5xQzME17HeRoBXFISaU7ODCBB4OcAz4p
	 W+xF2vYW3udy6/q7MixdKDfdkAvPPeQiuSWXm17a5ymJ65Ge31br0/b1jWsO8LPiAI
	 Gz8dCeizDHLjeXKtEdk7q7Hk6K1li3g1w2WmJFM/rrW7yTIC+EEjYh2e+B62x3qcay
	 HIXVe93FmWnUhfT0KK7OPAlNPbRGSpHl/9rxpvo/chUA7fQn+WR24yWclyh9YiT4ak
	 hMItQ9TuJGTSdmm+pspaYNsMxKdWHYs3O8Rrpnj7l4DX17QU2ytyQ5yNCqd3ayzEGE
	 HcI08ICwt2wpw==
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
Subject: [PATCH bpf-next v3 0/6] bpf: Inline the numeric open-coded iterator kfuncs
Date: Wed, 22 Jul 2026 06:24:15 -0700
Message-ID: <20260722132424.450230-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The bpf_for(i, start, end) macro is BPF's open-coded numeric iterator. It
expands into calls to three kfuncs: bpf_iter_num_new() to set the iterator
up, bpf_iter_num_next() once per iteration, and bpf_iter_num_destroy() to
tear it down. The verifier emits these as ordinary kfunc calls, so a
bpf_for() loop pays function-call overhead on setup, teardown, and — most
importantly — on every single iteration via bpf_iter_num_next().

All three kfuncs are tiny and only touch the 8-byte on-stack iterator state
(struct bpf_iter_num_kern { int cur; int end; }). That makes them good
candidates for inlining, the same way several other special kfuncs are
already open-coded in bpf_fixup_kfunc_call(). This series replaces each of
the three calls with an equivalent inline BPF instruction sequence:

  - bpf_iter_num_new(): the (s64)end - (s64)start overflow check is done
    with 32-bit arithmetic (start <= end is checked first, so the range
    fits in a u32), avoiding cpuv4 sign-extension insns that some JITs do
    not implement. Returns the same -EINVAL / -E2BIG / 0 as the kfunc.

  - bpf_iter_num_next(): the hot path. Since cur and end are int, the
    kfunc's (s64)(s->cur + 1) >= s->end test reduces to a signed 32-bit
    comparison of (s->cur + 1) against s->end, so the inlined code uses a
    32-bit compare with no sign extension.

  - bpf_iter_num_destroy(): a single 8-byte store zeroing the state.

bpf_for() is frequently used with constant bounds; in that case the range
checks in bpf_iter_num_new() are decidable at verification time, so a
follow-up patch elides them and emits only the iterator init (or the error
result). The inlined shapes are pinned by new __xlated selftests, and a
bench_bpf_for benchmark (modeled on the existing bpf_loop benchmark) runs a
bpf_for() loop with an empty body to measure the per-iteration cost.

The emitted instructions are plain BPF and remain valid for the
interpreter, so interpreter fallback stays correct and no jit_required
marking is needed.

Benchmark (./bench -p 1 --nr_loops 1000000 {bpf-loop,bpf-for}):

    +--------+---------------------+---------------------+---------------------+
    |  arch  |       bpf_loop      | bpf_for non-inlined |   bpf_for inlined   |
    +--------+---------------------+---------------------+---------------------+
    | x86-64 | 2946 M/s (0.339 ns) | 4281 M/s (0.234 ns) | 8981 M/s (0.111 ns) |
    +--------+---------------------+---------------------+---------------------+
    | arm64  |  618 M/s (1.619 ns) |  543 M/s (1.843 ns) |  538 M/s (1.858 ns) |
    +--------+---------------------+---------------------+---------------------+

On x86-64, removing the per-iteration call to bpf_iter_num_next() roughly
doubles bpf_for() throughput. On arm64 it is neutral: the loop is bound by
the load/store dependency chain on the on-stack iterator state rather than
by call overhead, so inlining neither helps nor hurts there. It still
removes the calls.

bpf_loop() is shown for reference only; it is a different construct (a
callback invoked per iteration), so the comparison is structural rather
than a measure of the inlining: on x86-64 bpf_for() is faster than
bpf_loop() even before inlining, while on arm64 bpf_loop() is faster
because bpf_for()'s per-iteration cost is dominated by the stack round-trip
through the iterator state.

Changelog:
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
  bpf: Inline bpf_iter_num_new() kfunc
  bpf: Inline bpf_iter_num_next() kfunc
  bpf: Inline bpf_iter_num_destroy() kfunc
  bpf: Elide range checks when inlining bpf_iter_num_new() for constant
    bounds
  selftests/bpf: Verify inlined numeric iterator shape with __xlated
  selftests/bpf: Add bpf_for() benchmark

 include/linux/bpf_verifier.h                  |  13 ++
 kernel/bpf/verifier.c                         | 157 ++++++++++++++++++
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_bpf_for.c      | 104 ++++++++++++
 .../selftests/bpf/benchs/run_bench_bpf_for.sh |  15 ++
 .../selftests/bpf/progs/bpf_for_bench.c       |  32 ++++
 tools/testing/selftests/bpf/progs/iters.c     | 145 ++++++++++++++++
 8 files changed, 472 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_for.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_for.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_for_bench.c


base-commit: a23a71823352e2d792dcaae25f1ebb744acbfc0b
-- 
2.53.0-Meta

