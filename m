Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718A3CB56A
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289750; cv=none; b=lbpgzWMyS7Pu9sCo6W/VograiDsT16vOaBqlcKvHE6QCS6wKzHXlOut0SL6npbinrd74SOba/1V4M5m/x7UuFVRPsK2J8PPPS+xdplcUbTnB4k6wCWI1AnasuK8PJpAUMytvwh9kgA1zqzdYhYmU4YpD793f0W0Pax9X42m3fNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289750; c=relaxed/simple;
	bh=ePQIorKlCKR2lEtnJ1TWZLUUVqIsXrtU6rxUgRE9PdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IMi5haVSxtq2FmsUzmYvV83LN1fSvW66bBbHUoUKSShnI2k6WUt+ygNE6QgBF/GVrTVvW/N0VIggnDO2cpgAwcs3jsHtVjJPiybWHNc5O2l5cYO4OtGaXkOdEIeQ8OrTMt6M5wCttGkFyyiOk+ZOqynLHbUF6/guEX8bMBxtdgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJQxAh+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJQxAh+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6B41F000E9;
	Fri, 17 Jul 2026 12:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784289748;
	bh=gnq3g882HK65JyI1okzHM5wZCSmRNCR9zm5wYHc7t0E=;
	h=From:To:Cc:Subject:Date;
	b=iJQxAh+71br1SMArtiSyJSzrhYXP5Lq61WKlw4H/FCtSOBpJzFyEGpXT3uDrf6Tj3
	 tnSfyRsCDcAK/L14NsuHuYfKqjjg6fsMw6QfJxun5JsRjNH8X5rZfafpla6ma/l+NT
	 ZrIL/imzKr3KlUysDat0s4LMGhhA4y/lRhH+rlrISo6WCxiRGdnKBdLMOscI85ojD8
	 4Xb9VLarK5xycu/smByCBelXMSJV3HgvvZlew4nCJZtyvb/BM5Bbawc0thrF869UUq
	 o2bKCEeI1ouMgVWjAJAw+O+uWe3IyovNe1/SOXJngQl+6X2EZtSBsSS3nU4ABXa3cA
	 SPcQGhyobffxQ==
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
Subject: [PATCH bpf-next v2 0/4] bpf: Inline the numeric open-coded iterator kfuncs
Date: Fri, 17 Jul 2026 05:02:08 -0700
Message-ID: <20260717120215.2171057-1-puranjay@kernel.org>
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

  - bpf_iter_num_new(): keeps the (s64)end - (s64)start overflow check
    (emitted with sign-extending moves) and returns the same
    -EINVAL / -E2BIG / 0 results as the kfunc.

  - bpf_iter_num_next(): the hot path. Since cur and end are int, the
    kfunc's (s64)(s->cur + 1) >= s->end test reduces to a signed 32-bit
    comparison of (s->cur + 1) against s->end, so the inlined code uses a
    32-bit compare with no sign extension.

  - bpf_iter_num_destroy(): a single 8-byte store zeroing the state.

The emitted instructions are plain BPF and remain valid for the
interpreter, so interpreter fallback stays correct and no jit_required
marking is needed.

Patch 4 adds a bench_bpf_for benchmark, modeled on the existing bpf_loop
benchmark, that runs a bpf_for() loop with an empty body so the
per-iteration iterator cost can be measured directly.

Results (./bench -p 1 --nr_loops 1000 bpf-for):

  +--------+----------------------+----------------------+--------------+
  |  arch  |       inlined        |     kfunc calls      |   result     |
  +--------+----------------------+----------------------+--------------+
  | x86-64 | 12884 M/s (0.078 ns) | 5812 M/s (0.172 ns)  | ~2.2x faster |
  +--------+----------------------+----------------------+--------------+
  | arm64  | 546.1 M/s (1.831 ns) | 545.8 M/s (1.832 ns) | neutral      |
  +--------+----------------------+----------------------+--------------+

On x86-64, removing the per-iteration call to bpf_iter_num_next() roughly
doubles throughput. On arm64 the numbers are unchanged: the loop is bound
by the load/store dependency chain on the on-stack iterator state rather
than by call overhead, so inlining neither helps nor hurts there. It still
removes the calls.

Changelog:
v1: https://lore.kernel.org/all/20260715130430.318421-1-puranjay@kernel.org/
Changes in v2:
- Don't use sign-extending moves as some JITs don't support them (AI)

Puranjay Mohan (4):
  bpf: Inline bpf_iter_num_new() kfunc
  bpf: Inline bpf_iter_num_next() kfunc
  bpf: Inline bpf_iter_num_destroy() kfunc
  selftests/bpf: Add bpf_for() benchmark

 kernel/bpf/verifier.c                         |  81 ++++++++++++++
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_bpf_for.c      | 105 ++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_bpf_for.sh |  15 +++
 .../selftests/bpf/progs/bpf_for_bench.c       |  32 ++++++
 6 files changed, 239 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_for.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_for.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_for_bench.c


base-commit: 1d91ea01185656ac3ee63c5f9f6f8bde3c746b3d
-- 
2.53.0-Meta

