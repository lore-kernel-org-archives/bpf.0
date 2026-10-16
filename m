Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB03659FD
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172601; cv=none; b=DQ50eCVxmZCNS87GWPJseAybN/NQycTzAXgyKCOj7aM2F/fWPS+Sjfi4MB/C//P1SGZAXGrgR7Mc+N+k/Qp2WCsAZ/MZm4687j3io6xwhw2eayUGVTt9KL07YLOuw6OXvHRzcKkhTrM4kb5fPQmbl3kgnz0W0ZinBBOdoX20pz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172601; c=relaxed/simple;
	bh=X71StBbKKzBj6FPlGnJArBkjaZJZeMRr55Z523wvISU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hxLC3iS2/ofImUPSqn8lHUktL34o9BUOJYVLVB/jSbxg6UiRfb0cYi9bRA+uHsn+G0lR2ejqT5A4fkoIEpVvg6uNLuiYPl1ybPuINoqy5iVPKKMDGB7bPPDQnLqDfrY0voeUqXHX+zZWiKBbACvp5Td6tjrW6Fgl9pDeAgE0y8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohpIS9IP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohpIS9IP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37D51F000C4;
	Fri, 16 Oct 2026 17:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172597;
	bh=AplNqmIP1b8p4H6OJk3oxcJAlLfNN/s0QGC7lTXfWgc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ohpIS9IP1ieScP95jz9ysrVE+frV70Mvr4JpsgrQABfVcscoFvOLRFfqHiQpnD8f+
	 L6POxVwAKYP6IvGyUXoXUUO4Sm0nUBkZEzOazLEuLd8vZTwYB7QoRl29nHfAVU8y5y
	 HjhBTZOYrZi9XKmUEFeW2HtH60Gv33vHeZUk1KjNZLlyQjfZb7ALyqVhuE+OXEkGzH
	 RXem0oNlVXtD01yXBTl4UYj1t5fhwvK6KcP2amikgsrKOH4yhdXFOpsWXr/6h5h1hy
	 3s6mWVw1YtpOPGK/eH8tadJQAQ/WwnBxuhjqDzZFflGFSq/hKuZa7YvE43Qgz1+gf9
	 HYWasV/LFDzHg==
Content-Type: multipart/mixed; boundary="===============3779327967830707358=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <529f0cb23adebe2fbff89be7e072463f4cb7ba6205dcc15f1534f4c869025dde@mail.kernel.org>
In-Reply-To: <20261016171319.1623447-4-puranjay@kernel.org>
References: <20261016171319.1623447-4-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v5 3/3] sched_ext: Use fetching atomics for cmask instead of a cmpxchg loop
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,tj@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 17:43:15 +0000 (UTC)

--===============3779327967830707358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> sched_ext: Use fetching atomics for cmask instead of a cmpxchg loop

TL;DR: Replacing the cmpxchg loops in cid.bpf.h with fetching atomics may make
schedulers (e.g. scx_qmap) fail verification on x86-64 v7.2/v7.3 kernels that
already ship cmask; should it be version-gated with a fallback?

> diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
> index 69fb4e97bc77..d0d4cea19e29 100644
> --- a/tools/sched_ext/include/scx/cid.bpf.h
> +++ b/tools/sched_ext/include/scx/cid.bpf.h

[ ... ]

> @@ -129,101 +129,38 @@ static __always_inline bool cmask_test(u32 cid, const struct scx_cmask __arena *
>  	return *__cmask_word(cid, m) & BIT_U64(cid & 63);
>  }
>
> -/*
> - * x86 BPF JIT rejects BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on arena
> - * pointers (see bpf_jit_supports_insn() in arch/x86/net/bpf_jit_comp.c). Only
> - * BPF_CMPXCHG / BPF_XCHG / BPF_ADD with FETCH are allowed. Implement
> - * test_and_{set,clear} and the atomic set/clear via a cmpxchg loop.
> - *
> - * CMASK_CAS_TRIES is sized so exhausting it means seconds of real spinning
> - * on one word - past any plausible contention. Abort hard.
> - */
> -#define CMASK_CAS_TRIES		(1U << 23)
> -
>  static __always_inline void cmask_set(u32 cid, struct scx_cmask __arena *m)
>  {
> -	u64 __arena *w;
> -	u64 bit, old, new;
> -	u32 i;
> -
>  	if (!__cmask_contains(cid, m))
>  		return;
> -	w = __cmask_word(cid, m);
> -	bit = BIT_U64(cid & 63);
> -	bpf_for(i, 0, CMASK_CAS_TRIES) {
> -		old = *w;
> -		if (old & bit)
> -			return;
> -		new = old | bit;
> -		if (__sync_val_compare_and_swap(w, old, new) == old)
> -			return;
> -	}
> -	scx_bpf_error("cmask_set CAS exhausted at cid %u", cid);
> +	__sync_fetch_and_or(__cmask_word(cid, m), BIT_U64(cid & 63));
>  }

[ ... ]

>  static __always_inline bool cmask_test_and_clear(u32 cid, struct scx_cmask __arena *m)
>  {
> -	u64 __arena *w;
> -	u64 bit, old, new;
> -	u32 i;
> +	u64 bit;
>
>  	if (!__cmask_contains(cid, m))
>  		return false;
> -	w = __cmask_word(cid, m);
>  	bit = BIT_U64(cid & 63);
> -	bpf_for(i, 0, CMASK_CAS_TRIES) {
> -		old = *w;
> -		if (!(old & bit))
> -			return false;
> -		new = old & ~bit;
> -		if (__sync_val_compare_and_swap(w, old, new) == old)
> -			return true;
> -	}
> -	scx_bpf_error("cmask_test_and_clear CAS exhausted at cid %u", cid);
> -	return false;
> +	return __sync_fetch_and_and(__cmask_word(cid, m), ~bit) & bit;
>  }

[ ... ]

Will schedulers built from this header still load on the x86-64 kernels
that already ship cmask?

cmask and cid.bpf.h were added in a58e6b79b432 ("sched_ext: Add cmask, a
base-windowed bitmap over cid space"), which is in v7.2 and in v7.3-rc.
In both of those trees, x86 bpf_jit_supports_insn() still rejects the
fetching forms in an arena:

    case BPF_STX | BPF_ATOMIC | BPF_DW:
        if (insn->imm == (BPF_AND | BPF_FETCH) ||
            insn->imm == (BPF_OR | BPF_FETCH) ||
            insn->imm == (BPF_XOR | BPF_FETCH))
            return false;

Only 4432f58d8449 earlier in this series lifts that restriction.

As an in-tree example, scx_qmap's pick_direct_dispatch_cid() calls
cmask_test_and_clear(prev_cid, &qa.idle_cids.mask).  Built at this commit,
it would fail verification on x86-64 v7.2/v7.3 with "BPF_ATOMIC stores
into R1 arena is not allowed".  Before this change it loaded there,
because the cmpxchg loop existed for exactly that reason.  With LLVM >= 20,
cmask_set() and cmask_clear() hit the same problem.

The commit message does say that "schedulers built from this header no
longer load on older x86-64 kernels".  However, tools/sched_ext/include/
scx/compat.h says the compat mechanisms "keep BPF schedulers built against
newer headers running on older kernels", and compat.bpf.h already gates on
kernel version, for example:

    if (bpf_ksym_exists(scx_bpf_dsq_peek) &&
        LINUX_KERNEL_VERSION >= KERNEL_VERSION(7, 1, 0))

The verifier prunes the branch that is not taken, so the same pattern
could keep the cmpxchg loop as a fallback on kernels whose x86 JIT lacks
the new support.  This change instead makes x86-64 v7.2 and v7.3, the
platform where these helpers used to work, unable to load any scheduler
that uses them.

Should the fetching atomics be gated, for example on LINUX_KERNEL_VERSION
or on a CO-RE check, with the old loop kept as the fallback, rather than
dropping support for every released kernel that has cmask?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38939225700
--===============3779327967830707358==--
