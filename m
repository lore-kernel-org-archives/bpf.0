Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD13358CA
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053642; cv=none; b=ooaK/2dYamlnRil0KScsZMFou1+NFtnxEAUCbNYRsb1xoLFqfhYp+H2HTV+fxtcZ6AGNSr9QWbg9ze/Mr9iPMc1xCqERx+TNpC7+IlAZGD2R09QvIjy9ARVvx/aQ1HubDqdjZJfhj/IQxX6CS0kXxisHvvpQYtfLr0OoWpkEbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053642; c=relaxed/simple;
	bh=N5CdDVfuM45HjSLsE+Ombu6odieAez0sxQynWJNbaKY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dKb5Rez2D1qqbFJRBkmXLQ5ZuDEVnOCzq+AyMTVi4/oceaVKZJMgVcS63vVdLcp7WnbBfhnfIcOee7MHEIHiNjVr/INlmzk6mU8SjcelQVV1fK7AOnhgmNlLh2o8vAsQy/OdrfHzEQ/Kn/Bfd8jrL/FNYh5nZV7p824/oISYXvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgtot0Cf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgtot0Cf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3167DC19425;
	Fri, 24 Apr 2026 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777053642;
	bh=N5CdDVfuM45HjSLsE+Ombu6odieAez0sxQynWJNbaKY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pgtot0CfQhpoNCOHCzcBf9XaRbY5CxLHdicCfDXeogvgZipAa5UYPQmL6Ntu0OfiG
	 Y8h6Kd3UVUHh626JYjbhk0st16B01YizsBi6CyVJNWBiYIAlrSfhXQWxSW6UFGbJEU
	 +fCIFZADPmpL4t9puof21aQHjq3d70cM6V2/ZY0PrQ2kzQ5pDNNAwfPz5chH40weTy
	 yHkILwEle+cViJ900ODDhEhvB+pTDoxTNcF91/dUjcBO7lPW+yjstT/wOavuGe8Ui6
	 l8FRhNKkikcFc5uJsjNojy741xPM+cazozP+qkoNV0NveKEAZNVyVVM1dQB3lJQOdb
	 yVxmQN0OzwjeA==
Content-Type: multipart/mixed; boundary="===============1558836097723664395=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e1b7281b2a52b18ae2a9f7d41091994eec0bba81e96e64adbe4c072d915acfc2@mail.kernel.org>
In-Reply-To: <20260424171648.2043493-1-yonghong.song@linux.dev>
References: <20260424171648.2043493-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 10/18] bpf,x86: Implement JIT support for stack arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,puranjay@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 24 Apr 2026 18:00:42 +0000 (UTC)

--===============1558836097723664395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index ea9e707e8abf..06f33fef1e8e 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -1664,16 +1692,45 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>  	int i, excnt = 0;
>  	int ilen, proglen = 0;
>  	u8 *ip, *prog = temp;
> +	u16 stack_arg_depth, incoming_stack_arg_depth, outgoing_stack_arg_depth;
> +	u16 outgoing_rsp;
>  	u32 stack_depth;
> +	int callee_saved_size;
> +	s32 outgoing_arg_base;
>  	int err;
>
>  	stack_depth = bpf_prog->aux->stack_depth;
> +	stack_arg_depth = bpf_prog->aux->stack_arg_depth;
> +	incoming_stack_arg_depth = bpf_prog->aux->incoming_stack_arg_depth;
> +	outgoing_stack_arg_depth = stack_arg_depth - incoming_stack_arg_depth;
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Can this underflow? All three variables are u16, so the subtraction
wraps around modulo 65536.

Looking at btf_prepare_func_args() in kernel/bpf/btf.c, it sets
'sub->incoming_stack_arg_depth = (nargs - MAX_BPF_FUNC_REG_ARGS) *
BPF_REG_SIZE' for any static subprog with more than 5 arguments. It does
not initialize sub->stack_arg_depth.

The 'stack_arg_depth' field is only written by check_func_call() in
kernel/bpf/verifier.c and check_kfunc_call(), which update the *caller's*
subprog entry when the caller makes a call with more than 5 arguments.

Since env->subprog_info[] is zero-initialized (kvcalloc), leaf subprograms
that receive stack arguments but never call other functions with stack
arguments will have:
  incoming_stack_arg_depth = (nargs - 5) * 8
  stack_arg_depth = 0

For example:
  static int leaf(int a1, int a2, int a3, int a4, int a5, int a6, int a7)
  {
      return a1 + a7;  /* r11+16 load, then BPF_EXIT - no calls */
  }

  /* some other subprog does: ret = leaf(1,2,3,4,5,6,7); */

For 'leaf', the verifier sets:
  incoming_stack_arg_depth = (7 - 5) * 8 = 16
  stack_arg_depth = 0    (never updated, no calls made)

When do_jit() computes:
  outgoing_stack_arg_depth = 0 - 16 = 0xFFF0 (u16 underflow)

Then at the new code below:

> +	/*
> +	 * Allocate outgoing stack arg area for args 7+ only.
> +	 * Arg 6 goes into r9 register, not on stack.
> +	 */
> +	outgoing_rsp = outgoing_stack_arg_depth > 8 ?  outgoing_stack_arg_depth - 8 : 0;
                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +	emit_sub_rsp(&prog, outgoing_rsp);

This emits 'sub rsp, 0xFFE8' (about 65 KB), which overflows the kernel
stack (THREAD_SIZE is only 16 KB on x86_64). The epilogue then emits a
matching 'add rsp, 0xFFE8', but the damage is already done at function
entry.

The commit message states "The verifier guarantees that neither
tail_call_reachable nor priv_stack is set when stack args exist, so R9 is
always available." It does not claim the verifier maintains
'stack_arg_depth >= incoming_stack_arg_depth', and that invariant is not
maintained for leaf subprograms.

The sanity check in bpf_fixup_call_args() at kernel/bpf/fixups.c does not
catch this because the same underflow happens there:
  u16 outgoing = subprog->stack_arg_depth - subprog->incoming_stack_arg_depth;
but since leaf subprograms have max_out_stack_arg_depth == 0, the
comparison 'outgoing > max_out_stack_arg_depth' is false (0xFFF0 wraps
around in the comparison).

Should the JIT compute outgoing_stack_arg_depth safely to prevent the
underflow? For example:
  outgoing_stack_arg_depth = stack_arg_depth > incoming_stack_arg_depth ?
                             stack_arg_depth - incoming_stack_arg_depth : 0;

Or should the verifier ensure the invariant 'stack_arg_depth >=
incoming_stack_arg_depth' after verification completes?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240
--===============1558836097723664395==--
