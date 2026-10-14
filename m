Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A879502795
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984192; cv=none; b=jCXryXH0l4cTSTcNMwEMT0/ZaDl44jdiGV8bdOBJ6YAos9A+QAt7QO5WFZ3Dauo0o2bLQjRv19G+hIjkoIqx+/xe2BnC3z0QYTjP+obkaeB4Dz3+4crNdSTiUWN1UL2iqNB18DsbfeW3rkiUQyHT/UYOj5yXVaLMNJAgUlxXHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984192; c=relaxed/simple;
	bh=+jYV/F/7k9Rbt8gtneZcL+MW6DO9f9SRJlbn+JGwMMg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jx4nK+TS3PdHQjQuCVTA3U36ucKd+uEMQoDoDpxcEWCP2Ad6jDLyQJQbFeqgBK9OPdmRoTrHLHIw8/In2cYq6PHdC0kuy8SIKoh7pvD64zsdAYu3EgZlAdkB8VOBBQaEtyP6bxqhROrDWgPX4kvwIaMhvZ6a0RtRgk/v/HZ2Kns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPChpP8p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPChpP8p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03F81F000FF;
	Wed, 14 Oct 2026 13:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984189;
	bh=p9MgGpJgVno8P781i2bxUY2cOhWiWOlywpir4KRWi8Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BPChpP8p/V7umgOLv7WudluwmQa0l2CthBogKyF8UcLDyMMOcqBNgqSzI3451D7WQ
	 R6JTPJzAuc6xXm+PMuF5Csj2SikA67a4V/AIPX6dKLB3ysQMIbLvVkg2NpR3FuoSx0
	 d0+FjBp7fVpPQnP8kM9q/oKiEgSAqB93zs1lwYOixK30YQMZ2dRWfA+3ziDQDqxlZW
	 +gKjQlbrdBkJBGu/DnaAN+G2rWbgZ8ovdk9cgrr8+jMqSJbpnuVYv6k+nsN1cv6rYz
	 2sbQLiqU2/N3a1PX1XfY+i+WnMZLRMZbp/UMSzISUPnGrXeJ7xECBs54x6NJxwm7el
	 D6XdQeWOGaeMg==
Content-Type: multipart/mixed; boundary="===============2179720693399677536=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <355b273a4b679e2549bdb7356695d9f31ced9419697a7b94ae472b49a453e1f3@mail.kernel.org>
In-Reply-To: <20261014125017.1426212-4-puranjay@kernel.org>
References: <20261014125017.1426212-4-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v4 3/3] sched_ext: Use fetching atomics for cmask instead of a cmpxchg loop
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,tj@kernel.org,void@manifault.com,arighi@nvidia.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 14 Oct 2026 13:23:07 +0000 (UTC)

--===============2179720693399677536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> sched_ext: Use fetching atomics for cmask instead of a cmpxchg loop

TL;DR: Commit message only: the riscv-without-Zacas claim looks impossible
since arena needs Zacas, and "all four helpers" needing new JIT support holds
only for LLVM >= 20.

> sched_ext: Use fetching atomics for cmask instead of a cmpxchg loop
>
> cid.bpf.h implements cmask_set(), cmask_clear() and the test_and_
> variants with a bounded cmpxchg loop, because the x86 BPF JIT used to
> reject BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on arena pointers.
>
> The x86 JIT accepts them now, and the loop was only ever an x86
> workaround, not a fallback for the JITs that still reject these. arm64
> without LSE rejects every arena read-modify-write, CMPXCHG included, and
> riscv without Zacas rejects only CMPXCHG, where a fetching OR or AND is
> accepted and the loop is not.
>
> Use the fetching atomics directly, and drop CMASK_CAS_TRIES along with
> the error paths that could only be reached from the loop.
>
> Clang emits the fetching form even when the result is unused, so all four
> helpers now need an x86-64 kernel whose JIT accepts fetching AND/OR/XOR in
> an arena; schedulers built from this header no longer load on older
> x86-64 kernels. When the bit is already as wanted, the helpers now also
> do a locked write of the unchanged value where the loop returned after a
> plain load.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

The changelog says "riscv without Zacas rejects only CMPXCHG, where a
fetching OR or AND is accepted and the loop is not."  Can that configuration
exist?

On riscv, bpf_jit_supports_arena() returns system_has_cmpxchg128(), which is
only defined with CONFIG_RISCV_ISA_ZACAS && CONFIG_TOOLCHAIN_HAS_ZACAS and
expands to riscv_has_extension_unlikely(RISCV_ISA_EXT_ZACAS).  Since commit
536b523b4073 ("bpf, riscv: Make arena support depend on ZACAS"), without
Zacas arena_map_alloc() returns -EOPNOTSUPP and the verifier rejects the
program with "JIT doesn't support arena".

Before that commit, arena creation on non-Zacas riscv already failed with
-ENOMEM because of f8c67d8550ee ("bpf: Use kmalloc_nolock() in range tree").
That predates the cmask helpers (a58e6b79b432), so no arena program loads on
riscv without Zacas, and a fetching OR or AND is not accepted there either.

The "if (insn->imm == BPF_CMPXCHG) return rv_ext_enabled(ZACAS);" check in
riscv's bpf_jit_supports_insn() tests the same extension, so it cannot reject
an arena CMPXCHG once arena is available.

The main point, that the loop was never a fallback for other JITs, still
looks right.  Should the riscv sentence be dropped, or reworded to say that
riscv needs Zacas for arena at all?

The changelog also says "Clang emits the fetching form even when the result
is unused, so all four helpers now need an x86-64 kernel whose JIT accepts
fetching AND/OR/XOR in an arena."  Is that true for every supported clang?

Commit 2897b1e2a2f4 ("selftests/bpf: Fix arena_atomics failure due to llvm
change") records that only LLVM PR 106494 (LLVM 20) made
__sync_fetch_and_{and,or,xor}() emit atomic_fetch_*() when the return value
is unused.  Older LLVM, including LLVM 19 which already has the
addr_space_cast support that __arena needs, rewrites unused-result fetches
into the non-fetching BPF_AND/BPF_OR atomics, and tools/sched_ext/README.md
still lists clang >= 16.0.0.

With such a clang, cmask_set() and cmask_clear() would compile to the
non-fetching form:

    __sync_fetch_and_or(__cmask_word(cid, m), BIT_U64(cid & 63));

which the x86 JIT already accepted in an arena before this series.  Only
the test_and_set and test_and_clear helpers would strictly need the new
JIT support on those toolchains.

The "schedulers no longer load on older x86-64 kernels" conclusion still
holds for scx_qmap, which uses cmask_test_and_clear() in
pick_direct_dispatch_cid().  Would it be more accurate to say "with
LLVM >= 20" before "all four helpers"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38567454417
--===============2179720693399677536==--
