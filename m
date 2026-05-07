Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C8343D8F
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192779; cv=none; b=IFda/6dw1+7OMKmUu4XNAfytn2dNRvczTRL/D6N2gLbwew+Lp2gPuPFh7rVdZpL0WrzmUNfVAJpCUwKIOu9oAM0k9Qzu5qpgw1LyUx1SXq2QfxD7yV7cI3RY0f7MtbTLIOzMdlFR0oXWUGeVLOK4VlbD03pdJCgWCOU4I4gbxY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192779; c=relaxed/simple;
	bh=g7005Q7mp67JxAe9pvym2urLJ5Q+6XprM4xi2DOzsFE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iMRy9KCoTef7+l2uIkuKIyxNHz/xbAThUV7cgaXLBEfbbH+uY0CoIsEhJCRPn0QfPvbQfNKv9Mkd6IodijEl41bi5JVth3fC3NLlMoDsKsqGzEfIX91hp6chA6KTVASb67utKKnyk5e/buGkyHKlrFwwnwZyrftKFaFFvK48BEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYuOS3Td; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYuOS3Td"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9276C2BCB2;
	Thu,  7 May 2026 22:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778192779;
	bh=g7005Q7mp67JxAe9pvym2urLJ5Q+6XprM4xi2DOzsFE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=OYuOS3TdRQNHu3QSpMM5Q98OX7oC67Jt5md2afYreBhEzquODcZeZoDhwfrZ+eptf
	 6W9j9fODwCGaTMXDytM6wAdjDmHDkZFwS/rdNUiUNIqZYn0cZpHwN5pVy6AF2a5iuS
	 L/8mu1TOk92D93e63fCZ4u/grU0ETv+0hGzTcqXMFSyAG+GjGkKGqJG594hFgqT03C
	 no4h97SZsiYDUP0p9UTmu8tcs4K0q24exfCWXGrK08uMavMpOmccbuuNZKDGOyRWWn
	 09EtXhBukQ68085OXlWM25crFM+1nNu11MI5ULO5s+N1XxjirWwcEewNb+JaMGmv11
	 Lm15Gs3OBz5oA==
Content-Type: multipart/mixed; boundary="===============7252206328885623299=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1d493872b8f17c88b57d437bdeb6b228085a672d70892a853eef970f265b464@mail.kernel.org>
In-Reply-To: <20260507213124.1132088-1-yonghong.song@linux.dev>
References: <20260507213124.1132088-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 15/23] bpf,x86: Implement JIT support for stack arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,puranjay@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  7 May 2026 22:26:18 +0000 (UTC)

--===============7252206328885623299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index ea9e707e8abf..67c2f4a3b9cc 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -1664,16 +1692,45 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  	int i, excnt = 0;
>  	int ilen, proglen = 0;
>  	u8 *ip, *prog = temp;
> +	u16 stack_arg_depth, incoming_stack_arg_depth, outgoing_stack_arg_depth; /* in bytes */
> +	u16 outgoing_rsp;
>  	u32 stack_depth;
> +	int callee_saved_size;
> +	s32 outgoing_arg_base;
>  	int err;
>
>  	stack_depth = bpf_prog->aux->stack_depth;
> +	stack_arg_depth = bpf_prog->aux->stack_arg_cnt * 8;
> +	incoming_stack_arg_depth = bpf_prog->aux->incoming_stack_arg_cnt * 8;
> +	outgoing_stack_arg_depth = stack_arg_depth - incoming_stack_arg_depth;

Can this u16 subtraction underflow for leaf subprograms? When a leaf
function receives stack arguments but makes no calls with stack arguments,
incoming_stack_arg_depth would be non-zero (e.g., 16 bytes for 2 args),
but stack_arg_depth would be zero since the verifier never updates it
for functions that don't make calls.

The subtraction would wrap around modulo 65536:
  outgoing_stack_arg_depth = 0 - 16 = 0xFFF0 (about 65520 bytes)

Later in do_jit():

> @@ -1700,6 +1757,42 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  		push_r12(&prog);
>  	push_callee_regs(&prog, callee_regs_used);
>  }
> +
> +	/* Compute callee-saved register area size. */

[ ... ]

> +	/*
> +	 * Allocate outgoing stack arg area for args 7+ only.
> +	 * Arg 6 goes into r9 register, not on stack.
> +	 */
> +	outgoing_rsp = outgoing_stack_arg_depth > 8 ? outgoing_stack_arg_depth - 8 : 0;
> +	emit_sub_rsp(&prog, outgoing_rsp);

This would compute outgoing_rsp = 0xFFF0 - 8 = 0xFFE8 (about 65512 bytes),
and emit_sub_rsp() would generate:
  sub rsp, 0xFFE8

allocating a 65 KB stack frame that overflows the kernel stack
(THREAD_SIZE is only 16 KB on x86_64).

This issue was identified by bot+bpf-ci@kernel.org in v1 (Fri, 24 Apr
2026 18:00:42 +0000) at
https://lore.kernel.org/bpf/e1b7281b2a52b18ae2a9f7d41091994eec0bba81e96e64adbe4c072d915acfc2@mail.kernel.org/

The author acknowledged this bug and promised to fix it with a selftest
in the next revision, but the current code still contains the vulnerable
subtraction without underflow protection.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25523765323
--===============7252206328885623299==--
