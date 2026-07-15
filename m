Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF3420472
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120704; cv=none; b=X07Z0WPGi+Ekos/ZY6mw9qMwzhV7Rjm/j1STwSJcwBJcI2X5Y9/qIWiu3ORqYc7z8oKuFAwsDKxFzau0tXj2btMVPbLC6yESDt9QAAHU2fo7tOBEcGA4N+jyUDDOMIYT4MN/mVsTtuu2GpbBmZIYwgwCYl6fRhOAsPGlYacwLKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120704; c=relaxed/simple;
	bh=/qq79xw3HehXq0hb96BL08JCt+kNbk4pqUnctQqXGpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E0A3I0tiUiOqR8sCoDemxhlNNKpivg8gzEcrBYFkHNG1TyJWC4qVeohyrfVLH+FGu0VbiyP5UbYEFtuUNtDu5gOdvdlwh7rp9nqY7ebBSTpfyNsKQbQEH1E+Q/F9/vTQ6yMP3mXVc4JZsTOSeGKvlE3dKQdAhlwubJiDll2yszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEDjcZNS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEDjcZNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5522D1F000E9;
	Wed, 15 Jul 2026 13:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784120702;
	bh=uNqur404Sr3kBDD3Pss7/XVa7lpynuyMtGIhqlan+W0=;
	h=From:To:Cc:Subject:Date;
	b=FEDjcZNS95O8sjoF0oUPAPzgcOX/NvHGClG10d6tWd5GjRuv/T9px8zyR+kgpO2ns
	 Gp3PZ6KNQW6W1qBrUfgRpkPOrqoIzx3vXrF+a1UGeUxdPU111aMuGJ8tArXXzve8Cy
	 K7njI2A7Srs4sLp0HoNwG6w4XlzeifcYrTpiwtatxonqNcMjs8UeDeoZ0A9yusftd9
	 +IjPvpox+OlOthcnrfUN9j1BUgRqB5QZUTNlKrv2o788mhzxvL83oZTyDw/6uq594O
	 F8Y++H00SIHRlafZb/T9qqbF/fMLFAXOD4p19UwtTn8R5Hp6k/lfwc00vR1qckypDs
	 nUxPABujm+01g==
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
Subject: [PATCH bpf-next 0/4] bpf: Inline the numeric open-coded iterator kfuncs
Date: Wed, 15 Jul 2026 06:04:22 -0700
Message-ID: <20260715130430.318421-1-puranjay@kernel.org>
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

Puranjay Mohan (4):
  bpf: Inline bpf_iter_num_new() kfunc
  bpf: Inline bpf_iter_num_next() kfunc
  bpf: Inline bpf_iter_num_destroy() kfunc
  selftests/bpf: Add bpf_for() benchmark

 kernel/bpf/verifier.c                         |  79 +++++++++++++
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_bpf_for.c      | 105 ++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_bpf_for.sh |  15 +++
 .../selftests/bpf/progs/bpf_for_bench.c       |  32 ++++++
 6 files changed, 237 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_for.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_for.sh
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_for_bench.c


base-commit: d1f4b56417a3dc1a0600f960b14f46bd25eda89d
-- 
2.53.0-Meta

