Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150736;
	b=C42RfcLr3lvXocr/Rv1g2xyPwSh4j33+u7LTEza6PdmF1YdKrEtqqHIZFMXkPx0JPX5R
	 zNLHFQkjqOBR49y+RrAbgMsIcnd651px6hPik2zW5UqzOOyTA8g2vnZXNNX7QoDqJU+iL
	 ymJqICsw4civcnVBdhlePYcFduT0i+aSPfyEZQ6sLO5ajoqoQ3mgQ9Z0WtdmVA6NPPVrR
	 e9kqM5DOGN8TJuO2ZfpGw/kRCs8bWGppj8UIyRRiXM1UL1ucBBhIqPJapKeftivAtcsmv
	 Xp9qfYzhukYRr2Vw8Z5GD2gMbvYq8JS7PKYlwcoG7KbCDBVOA9wE/gUD1lJ+JF6TWvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150736;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=uwTFqG+Y3Drm9tBRTvZoHX5U5RK5FD2GNGkB/YHfKwE=;
	b=WF6nsHv3GQ+Xjfe4pj1gYlMLoTIOHVdYgk3P7GnuvxCre5tekv57Qz6zcsJyddcbz8k5
	 I9W5J3gTf1SQmxX4/kuogas6zyW8Vn0t/cbHLnTxec2nUzNP6lWrdBQjOeYADCbi+wEUF
	 1gSnqaRSw+e32UGNvH7k5Su4EJTl05wriCxuSRcPinD9OvrNFsqvSWuWOBC9xNPUBudsA
	 S7oxNFikcXmDVgBvqsW513wxGCM6/iOWAoplyy7JSrRQrRFytdyRUkmRJqSUXaZFVj3hA
	 r0pAF17GFtMeZ2inw8o3fLqvyGWYop6pFrHzBp8sZk8YcQV5ElkAOPkORYRkYIfk62A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JF4okSYa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4ED606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JF4okSYa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED991F01825;
	Wed, 28 Oct 2026 01:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793150735;
	bh=uwTFqG+Y3Drm9tBRTvZoHX5U5RK5FD2GNGkB/YHfKwE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JF4okSYabP7qtOwwR/K+gYk8lt2OwToVO33cXayfWaUS4UkwicxSd/m7IwXp6Icwy
	 WSQCsoaJjeVPblW4Mjm8UMOYnKMV3I7Y5Ab/bt0qcd7mM33qRHD7UUEyhUmqOxUSvv
	 1DDPtIaYd8ulhaVZIFlFvtBlxayQbh5OsjHERdjivVQYfKLlrDmT8NwlV4wVb6f/Sh
	 ZSHzRCv/bJd7rEbfaemExPDYOgsf05QqGhwXprBBAVwlRttKtLp5TONyoB62f9oBz4
	 +ZSb5byGewOeJBFolSVf5i6hT7BVR5f3o9kKELi/0GDJmwovwEpG8VhcTvWolKLlSO
	 CmNbB70hOtcng==
Content-Type: multipart/mixed; boundary="===============8096680168149290584=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d7e7a55c00b4ea31b7ff71b901c5e2054ce3f0a67d5c39d9820b29ec215c2208@mail.kernel.org>
In-Reply-To: <25728094090d9bf3e4cd88feecec336f0493a5a9.1793147364.git.memxor@gmail.com>
References: <25728094090d9bf3e4cd88feecec336f0493a5a9.1793147364.git.memxor@gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 05/11] bpf: Let the callback of bpf_loop unwind
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 28 Oct 2026 01:25:34 +0000 (UTC)

--===============8096680168149290584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Let the callback of bpf_loop unwind

TL;DR: If bpf_loop() is traced (fexit, kretprobe, function_graph),
bpf_unwind_leave() may not find the BPF return address, so it may WARN and
resume the program in a state the verifier never checked, possibly leaking
pointers or references.

> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c

[ ... ]

> @@ -749,7 +750,7 @@ const struct bpf_func_proto bpf_for_each_map_elem_proto = {
>  	.arg4_type	= ARG_ANYTHING,
>  };
>
> -BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
> +BPF_CALL_x(4, noinline, bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
>  	   u64, flags)
>  {
>  	bpf_callback_t callback = (bpf_callback_t)callback_fn;

[ ... ]

> @@ -766,13 +767,18 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
>  		return -E2BIG;
>
>  	for (i = 0; i < nr_loops; i++) {
> -		ret = callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
> +		bpf_call_cb(callback, i, callback_ctx, 0, 0, 0, ret, unwound);
>  		/* return value: 0 - continue, 1 - stop and return */
>  		if (ret)
>  			return i + 1;
>  	}
>
>  	return i;
> +
> +unwound:
> +	/* The callback left with unwind_exit: the loop is over, and so is the helper */
> +	bpf_unwind_leave();
> +	return ret;
>  }
>
>  const struct bpf_func_proto bpf_loop_proto = {

Can bpf_unwind_leave() find the BPF caller's return address here when
bpf_loop() is being traced?

bpf_unwind_leave() looks for the return address of the BPF caller in
bpf_loop()'s own return-address slot (__builtin_dwarf_cfa() - 1 on x86,
the frame record LR on arm64).  But bpf_loop() is a regular traceable
kernel function.  bpf_iter.o is built with the ftrace flags (kernel/bpf/
Makefile only strips them for percpu_freelist, bpf_lru_list,
queue_stack_maps, lpm_trie, ringbuf and rqspinlock), bpf_loop() has no
NOKPROBE_SYMBOL, and it is not in btf_id_deny.  Several tracers change
that slot or add a frame:

- An fexit/fsession BPF trampoline calls the original function with
  emit_rsb_call(&prog, orig_call, ...) in arch/x86/net/bpf_jit_comp.c, so
  the return address of bpf_loop() points into the trampoline image.

- kretprobe/rethook: arch_rethook_prepare() does
  stack[0] = arch_rethook_trampoline.

- The function_graph tracer and fprobe exit handlers replace the slot with
  return_to_handler.

In each case bpf_unwind_target(*slot) does not find a BPF address.
search_bpf_extables() goes through bpf_prog_ksym_find(), which returns NULL
for a trampoline ksym (ksym->prog is false), and the kernel and module
tables have no EX_TYPE_BPF entry there, so the address comes back
unchanged.  Then WARN_ON_ONCE(to == *slot) fires, which panics with
panic_on_warn, and bpf_loop() returns ret through the tracer to the
instruction after "call bpf_loop".  On x86 and arm64 the JIT emits no code
for unwind_goto, so the program continues along the normal path.

The verifier checked that path only against callback states that returned
normally, where r0 is RET_INTEGER and the stack and references are as left
by a normal return.  It checked the unwind_exit state only against the
pad.  So the BPF program can run in a state the verifier never checked.
For example:

- r0 can be the pointer or reference the callback unwound with
  (b2f03cf6322f lets a pointer and its reference reach the pad), now seen
  as a scalar.  The pointer leaks and the reference is never released.

- Callback writes through callback_ctx on the unwind path only (for
  example a scalar over a spilled pointer) are seen by code that assumes
  the old slot type.

The trigger is a bpf_loop() call that the verifier does not inline (flags
not provably 0, or two callbacks at one call site) whose callback has
unwind_exit, while kretprobe:bpf_loop, an fexit program on bpf_loop(), or
the function_graph tracer is active.

bpf_check_attach_target() already treats this hazard as real for BPF
targets:

    /* unwind_exit would return to the trampoline that called the target */
    ...
    "Only fentry can attach to %s, which can unwind"

Nothing equivalent covers bpf_loop(), which this patch turns into a frame
that unwinds.  No later patch in the series addresses this (no notrace,
NOKPROBE_SYMBOL or btf_id_deny change, and no ftrace_graph_ret_addr() or
rethook lookup in bpf_unwind_leave()).  The helpers that get pads later in
the series (bpf_for_each_map_elem and its ops, bpf_find_vma,
bpf_user_ringbuf_drain, bpf_rbtree_add) look to have the same problem.

Could bpf_loop() and the other helpers with pads be made untraceable
(notrace plus NOKPROBE_SYMBOL, and a btf_id_deny entry for fexit/fmod_ret),
or could bpf_unwind_leave() resolve a hijacked return address?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40612543702
--===============8096680168149290584==--
