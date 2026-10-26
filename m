Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986796;
	b=Axno0c1+EGMaOxwb/Jx7LhaNbQanjHojbkpkXzSdZl0QxNtFJwLlPGTSdC7xs1OvhOLy
	 8loVlCPGb2WGNswCdNASEmK5h9Kf//r1G7rnVwNVAEBPCUxUnCp9kWpw5laqSDFAQcOFx
	 OG+N8UFsnH3G7ygpFD8INwvxH87bame+O8jSGyRSsK6Zt7i8tNUCUcOd6V5HdmUPZn8KP
	 +2VcDPwOzD2aK+GDMvSeRrrZFk5W0TaWR3Cw54oboFG0klKZDbRWHlFGSCZ81gRMJ5PEa
	 hp67H67FONH3iXSmE6jIMlP+BtURXjI0Vy0C1Mlgl9lqsesr528lBThWs0FSO/ES+mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986796;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=hKH5b2hOEB/W6QoCEybvEAF1YfMruFZvYzwpt5a1UqA=;
	b=XcPcMHcQ1+fZ7RZO/L7Y8f7+RYnmu+m9fAKJIq7/Fa6mAN08YmNJuAWRfjiW0ZRlN7dH
	 rLziVzsJm4JujH7w/em3DX+NnEEPDo1ranCyyS7aKQUfkAKdzNOi3/pEE9FTzey15Dh10
	 BRx1cUvWSgOvWE1U+FercZQf3Pbor5JURkNI8Jzl6yCa5mWqmh8iTpNdJglHlyiaTr0wR
	 z8VUlO2luzD7hkoaT0aTzfn4dzUggKgXElINhHudtcmq7gCN6wtIRTmE236r4iAzBkCOz
	 6cOCUAfpdLMqhk01J0CpypZjCV0Y08htsOY1pEndC/u7V0mfcMPsuoDIhiB7YYTTPlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtu91btt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF68E606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtu91btt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4D41F01825;
	Mon, 26 Oct 2026 03:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986795;
	bh=hKH5b2hOEB/W6QoCEybvEAF1YfMruFZvYzwpt5a1UqA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dtu91bttN6ML2aAWq28I4/lioWm/oYmydwJ4BOMhXp9+kepvEkSfQ4zOpBCerr/oe
	 Pm1wYkXmzBpK6fUFbxHZXAOEmxiFOwOVCaPpyjsiJSSblFLnj3I/YumAwmXYne7Eq3
	 fHV7cks+iA01lKGZtmNU6dju73KhzJpJZ+iHutm0TXHPEq3I53IM9Q0gtwgkt6nEc2
	 f/Lj+2gj6OM669nRANeuerokB4ew8pxC7zPzrxqGgqk3edhCXAABdPzuKabigxA9Fd
	 ENQPEZ8qyoPkhBIkXBCN+EFVFf5f1DFbE55XxfRfF50aolO9SBu2kllHI/NgjjJH1y
	 Tcx5C1sTvICGw==
Content-Type: multipart/mixed; boundary="===============2918621841262129986=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <0321e2f903359c59c44f5cfe2ede2810dec59a76b7345364ec09b53eba862f66@mail.kernel.org>
In-Reply-To: <20261026025943.404450-33-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-33-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 32/81] bpf: Count stack arguments of a static subprog from its code
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:15 +0000 (UTC)

--===============2918621841262129986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Count stack arguments of a static subprog from its code

TL;DR: Counting stack args from r11 loads may let programs use them on JITs
lacking support (s390, powerpc, loongarch, mips), possibly emitting
absolute-address stores and loads; a bpf_jit_supports_stack_args() check seems
missing.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fb80bc4d2d01..0f2bae1c2305 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -15204,12 +15212,31 @@ static bool try_btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>  /* Prepare argument metadata for liveness; the main program is handled separately. */
>  static void prepare_subprog_args(struct bpf_verifier_env *env)
>  {
> -	int i;
> +	struct bpf_subprog_info *sub;
> +	struct bpf_insn *insn;
> +	int i, j, cnt;
>  
>  	for (i = 1; i < env->subprog_cnt; i++) {
> +		sub = &env->subprog_info[i];
>  		if (!try_btf_prepare_func_args(env, i) && bpf_subprog_is_global(env, i))
>  			/* Keep all argument registers live if the prototype is unavailable. */
> -			env->subprog_info[i].arg_slot_cnt = MAX_BPF_FUNC_REG_ARGS;
> +			sub->arg_slot_cnt = MAX_BPF_FUNC_REG_ARGS;
> +		if (bpf_subprog_is_global(env, i))
> +			continue;
> +		cnt = 0;
> +		for (j = sub->start; j < (sub + 1)->start; j++) {
> +			insn = &env->prog->insnsi[j];
> +			if (is_stack_arg_ldx(insn))
> +				cnt = max(cnt, insn->off / BPF_REG_SIZE);
> +			if (bpf_is_ldimm64(insn))
> +				j++;
> +		}
> +		sub->stack_args_from_code = true;
> +		sub->code_stack_args = min(cnt, MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS);

Can this let a program use r11 stack arguments on a JIT that does not
support them?

Before this patch, a static subprog got a non-zero incoming stack argument
count only through btf_prepare_func_args() -> btf_check_arg_slots(), and that
function rejects the case when the JIT lacks support:

kernel/bpf/btf.c:btf_check_arg_slots() {
    ...
	if (!bpf_jit_supports_stack_args()) {
		bpf_log(log, "JIT does not support function %s() with %d argument slots\n",
			tname, slot_cnt);
		return -EFAULT;
	}
    ...
}

Here code_stack_args comes from the r11 loads in the instructions, for every
non-global subprog.  That includes a subprog whose BTF has five or fewer
argument slots (the rustc case in the commit message), and a program with
no func_info at all, since bpf_subprog_is_global() needs func_info_aux.

Nothing on this path calls bpf_jit_supports_stack_args().  Besides
btf_check_arg_slots(), the only other caller is in the kfunc call path.
check_stack_arg_read(), check_stack_arg_write(), check_static_func_call()
and bpf_fixup_call_args() do not check it.

For example:

  main: *(u64 *)(r11 - 8) = r1; call f; exit
  f:    r0 = *(u64 *)(r11 + 8); exit

This looks like it now passes check_static_func_call() ->
check_outgoing_stack_args(), check_stack_arg_read() (incoming count is 1),
and the max_out_stack_arg_cnt check in bpf_fixup_call_args() (outgoing count
is 1).  It then reaches bpf_jit_subprogs() on architectures where
bpf_jit_supports_stack_args() is the __weak version that returns false.

Those JITs know nothing about BPF_REG_PARAMS (MAX_BPF_REG).  For example,
reg2hex[] in arch/s390/net/bpf_jit_comp.c has no [BPF_REG_PARAMS] entry, so
the r11 store and load are emitted using hardware register 0.  On s390,
powerpc, loongarch and mips a base register of 0 means an absolute address
equal to the displacement, so the JIT would emit a store to address -8 and a
load from address 8.

The "stack args are not supported in non-JITed programs" fallback in
bpf_fixup_call_args() only runs when the JIT fails to compile the program,
and these JITs would compile the r11 instructions without complaint.

Should prepare_subprog_args() (or check_stack_arg_read() and
check_stack_arg_write()) reject code_stack_args > 0 when
!bpf_jit_supports_stack_args()?  The later patches in this series don't
appear to add such a check.

> +		/* incoming + max outgoing. Calls add the latter. */
> +		sub->stack_arg_cnt = sub->code_stack_args;
> +		if (env->prog->aux->func_info_aux)
> +			env->prog->aux->func_info_aux[i].stack_args = sub->code_stack_args;
>  	}
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============2918621841262129986==--
