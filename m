Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2C4CEE70
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789590458; cv=none; b=gD0GiBUVjI/y/mug+32zJMnec9aD+MQLliog81W2XPXIpHnbuhTpY7uZFFPcXago845+QNSi6qktDy4vwBnNDg8LjG+f1FRYKFT+cG+Qzq1yTGLYu20x/U0UvqfXTcMpA9SGnxGZVc6w16PQDjjku9WBtMc/tAEwc6LCD7XB8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789590458; c=relaxed/simple;
	bh=7NwFRiXaUVGZROG5FqMLJXsijXsrjm/mnU4CYo2T+1M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=I/kd6agvv3D6NR6PbLp4SVUBdavqlcBaCrfuxMr4if7ngz4emXw4qyil1yyybm4nvtw4CAOx5Vuj89WlEZraejYf87oB5e72rHnd4GD/6FiMf0NUr1+4QOOjeDgbJXzjrPXeJ8+jxkzhKye5Q0w+begzpHM6pKKd2Oa3GrRwsng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3lzE167; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3lzE167"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091BD1F00893;
	Wed, 16 Sep 2026 20:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789590450;
	bh=U7VCHgK9J0EDuI4epwMH+1UBlZAyEgsRMUYQIniYlzY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=k3lzE167+d2fChCQnbd/LUbT9SvTRk2ycfeCGiBCADPJ0MRlvzmNN4qEuLRj58/6i
	 Vwc/BFGn/84ycC/VYV6jbl4f3UgOA4qTHu43IXOh5vSMjKcS4xGc3tuvw9ZHtywEFw
	 wBRzyFKm2gfbiAgJqpJEv2RvPemr1VtvStxPBsoxlNmCqgaDi0S6Ca4JV1HbrWVmkl
	 SLqGERP10rfU6qkNcVAv+PyRkcgFy6m89C/nlFzSfyxYCTYVCznk6oY2uwPP8Om8fI
	 8Vzs0XKD6S1/v1pS9+jN4vGzQ+x1E9W90MSgS9lFXtOz4dmDiwMVn0TgRXJ80rHIF4
	 sVDwVBcACjEQQ==
Content-Type: multipart/mixed; boundary="===============9050654853037073688=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6415706d0795ebb714a0d93a65e9a2053fe992b829f6e34703e1a2a49ba81f15@mail.kernel.org>
In-Reply-To: <20260916192805.3991983-3-memxor@gmail.com>
References: <20260916192805.3991983-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Fix generic __uninit kfunc output buffers
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: tj@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ameryhung@gmail.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 16 Sep 2026 20:27:29 +0000 (UTC)

--===============9050654853037073688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index 6c2c048dccef6..71fb0ca72d698 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -164,19 +164,32 @@ suffix should be used.
>  2.3.3 __uninit Annotation
>  -------------------------
>
> -This annotation is used to indicate that the argument will be treated as
> -uninitialized.
> +Use ``__uninit`` on a pointer parameter for an output that the kfunc
> +initializes without reading its incoming contents.
> +
> +For generic memory buffers, the kfunc must initialize every byte in the
> +declared range on every return path, including error returns and struct
> +padding. The range is determined by the pointed-to type or the associated
> +``__sz`` or ``__szk`` size argument.
> +
> +The annotation does not change the accepted pointer types. A stack-backed
> +struct passed as a generic memory buffer must still be scalar-only.
> +
> +A stack buffer with a verifier-known constant offset and size may be
> +uninitialized before the call and is considered initialized afterwards.
> +For variable offsets or sizes, callers with neither ``CAP_PERFMON`` nor
> +``CAP_SYS_ADMIN`` must initialize the potentially accessed stack range before
> +the call.
> +
> +For dynptr parameters, ``__uninit`` indicates that the kfunc constructs a
> +dynptr in the supplied storage. For example::
>
> -An example is given below::
> +        __bpf_kfunc int bpf_dynptr_from_skb(..., struct bpf_dynptr *ptr__uninit)
>          {
>          ...
>          }
>
> -Here, the dynptr will be treated as an uninitialized dynptr. Without this
> -annotation, the verifier will reject the program if the dynptr passed in is
> -not initialized.
> +Without this annotation, a dynptr argument must already be initialized.

[ ... ]

This isn't a bug, but could the middle paragraphs be trimmed to the
decisions that are not obvious from the diff (for example why raw mode
must only be dropped for the tracked output), rather than listing each
hunk?

The first two paragraphs state the problem and the fix rationale well.
The middle paragraphs then walk the diff hunk by hunk, with several
sentences that restate a single line of code rather than explain a
decision: 'Use a common access-mode helper for fixed-size and sized
arguments' (the new func_arg_access_type()), 'Look up the output
register state only when there are recorded bytes to initialize' (the
'if (!meta->arg_raw_mem.size) return 0;' early exit), and 'Include
struct pointers that are resolved to generic memory later' (the
ARG_PTR_TO_BTF_ID term added to arg_type_is_raw_mem()).

A reader who has the diff learns little from those lines.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index cf85141ea1674..3c1b06a3daf30 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1548,10 +1548,11 @@ struct ref_obj_desc {
>
>  /*
>   * A memory argument a call fills in. The verifier allows the stack to be uninitialized if
> - * the range is a known constant. Stack slots are marked as STACK_MISC by check_mem_access().
> + * the range is a known constant. Stack slots are marked as STACK_MISC by check_mem_access()
> + * after all arguments have been checked.
>   */
>  struct arg_raw_mem_desc {
> -	u8 regno;
> +	u8 regno; /* Register number, or one-based kfunc argument slot. */
>  	int size;
>  };

This isn't a bug, but now that this holds a one-based argument slot for
kfuncs, would naming it after the slot (e.g. arg_slot) read better next
to argno_from_arg()/release_regno, so the comment does not have to
carry two meanings?

The field keeps the name regno but, for kfuncs, now holds a one-based
argument slot rather than a register number, and the comment is what
carries that dual meaning. Every consumer converts it back:
mark_raw_stack() does 'u32 slot = meta->arg_raw_mem.regno - 1;' before
get_func_arg_reg(), and check_stack_range_initialized()/
check_mem_size_reg() compare it against abs(argno.argno) rather than
against a register number. The same file/function already uses distinct
slot terminology (argno_t, argno_from_arg(), argno_from_reg(),
reg_from_argno(), check_func_arg(env, arg, slot, prev_slot, ...)), and
release_regno next to it really is a register number, so a field named
regno holding a slot reads against the surrounding convention.

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6c6b8d8520cdf..d7a40dc159aea 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6981,7 +6981,7 @@ static int check_stack_range_initialized(
>  	 */
>  	bool allow_poison = access_size < 0 || clobber;
>  	/* The call will initialize the memory; uninitialized stack allowed */
> -	bool raw_mode = meta && meta->arg_raw_mem.regno == reg_from_argno(argno);
> +	bool raw_mode = meta && meta->arg_raw_mem.regno == abs(argno.argno);

[ ... ]

> @@ -7215,7 +7215,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
>  	 * raw mode so that the program is required to initialize all
>  	 * the memory that the helper could just partially fill up.
>  	 */
> -	if (!tnum_is_const(size_reg->var_off))
> +	if (!tnum_is_const(size_reg->var_off) &&
> +	    meta->arg_raw_mem.regno == abs(mem_argno.argno))
>  		meta->arg_raw_mem.regno = 0;

This isn't a bug, but would a small arg_slot_from_argno() helper next
to the other argno_t accessors read better than open-coding
abs(argno.argno) in both check_stack_range_initialized() and
check_mem_size_reg()?

The same expression abs(<argno>.argno) is open-coded in two places
(check_stack_range_initialized() at line 6984 and check_mem_size_reg()
at line 7219). argno_t is a wrapper struct (typedef at verifier.c:270-
272) with three dedicated accessors right next to it - reg_from_argno()
(line 284), arg_from_argno() (line 293) and arg_idx_from_argno() (line
300). Grepping the file shows these two new lines are the only reads of
the raw .argno member anywhere in verifier.c outside those four
accessor functions; every other site goes through an accessor. Neither
existing accessor has the needed semantics (reg_from_argno() returns -1
for argument slots beyond MAX_BPF_FUNC_REG_ARGS, arg_from_argno()
returns -1 for register-encoded values), which is exactly why the raw
member is being read here.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35141528669
--===============9050654853037073688==--
