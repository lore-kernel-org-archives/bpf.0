Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751271;
	b=jBAkqiPePpTi7W6hVhULMt/wHHp/88Ra/YDWml5Kd+9N3YoDzUf+JUyGfY7ZFp/mRNPT
	 rqIMbL1dYzCcSY9MDpzguqBy3sJdoT/Hl4Kzru9qbPXqVzOYao7pO4eu0PaAoCU5vb5qY
	 SFHPEh5ocVAQNhauV2w6swOE3deitjmjdqTwW0kPtV4BnwidAG8hdresGybm0K/rMV6zf
	 4XEh7NpGdlYcczyXJX387ELpOw/YqFRNC6aKZephHG8UXxG7bvTb9KA3fahEY7FZnLE2o
	 Z6h8bO+IuCoJFL9Ri59KbiQJkVZaLm36msqLASwb9LTvIOIuiECSQ6SG6d0dk2gCvzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751271;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yKUh2CyaHi9OXDWRoDC5XIPXmch4YlH2pxwBy4Vbw8M=;
	b=nsukGJPaS97LFGme7UnzBCjstuK3UCXaCwllptfiygtCIgLc6nurGXJ2xtU04M6WvNlF
	 bDKzzluBv5EXoVdIe/+4xa9ZKaa2T+7qKiH7nJhbVp3z85A4MNsXSFoGqPZm7i401AXmJ
	 pW+14KedIrUVAHKRQfsKutpTzQIIFQwlgJIsCJkipmDvgAZiLZ27eLDsDKowfSULQ73Na
	 CbmgquCrnnsJIFQtKJ0qoaeEHB5wDV4KddWklpyF/QAVtse+Amps9rWwGm5uYzwTjackH
	 WlapsgvDwez0M0vvXfA3XMspKxmT9Rficqh2nH4LAL0f9z1yXSsAvDqDhj5DbXM9NFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgQJWgyB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076F606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bgQJWgyB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4851F00919;
	Wed,  4 Nov 2026 00:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793751270;
	bh=yKUh2CyaHi9OXDWRoDC5XIPXmch4YlH2pxwBy4Vbw8M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bgQJWgyBKbtL3n7xKuSysRIbDhdt+dPYbs1kPJomB//1H+8gUrQml6a1n3jG0m5ei
	 Hdwp6dY9lfI8amTmvMEplUQr4bxnULkj7GHT2VVTu1ng84jfZjIXKxtdwvmJOKNqGT
	 77iyT0k8+GCdIxqBgasov/hCOWbrtu3eMxHRPGQOC2ybiM3Dd/Fn4BDk6ol14M4dw7
	 UTPGbIph8QX15TPVxf6h28U8SAAQ52D2BqQiakn6RFRxnPDjH9DzDWmVCB1IDBogTX
	 6o4wDr+NsCzarvNJpMoJ0ECkU2/UsuXtZ64+EKtIccWHwejOBFCzAifoDbWaHOFr1R
	 US0EzALjPd1Xw==
Message-ID: <sashiko-outbox-196294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 06/37] bpf: Count stack arguments of a static
 subprog from its code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261103234104.208239-7-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
 <20261103234104.208239-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:14:29 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: undercounted arg_slot_cnt on early return in btf_prepare_fu=
nc_args()
--

commit 7a7c085f34a6a2a56b7b82b03b95e750d7742fd9
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Count stack arguments of a static subprog from its code

This commit changes the verifier to determine the number of stack arguments
of a static subprogram from the highest stack argument slot loaded through
r11 in its instructions rather than solely from its BTF prototype. It also
updates caller stack argument accounting and trampoline attachment checks
accordingly.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8bf39098ba97a..228b93d4f8c94 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -8827,13 +8821,15 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
>  	}
>  	args =3D (const struct btf_param *)(t + 1);
>  	nargs =3D btf_type_vlen(t);
> -	sub->arg_slot_cnt =3D nargs;
> +	sub->arg_slot_cnt =3D min_t(u32, nargs, MAX_BPF_FUNC_ARGS);
>  	if (nargs > MAX_BPF_FUNC_ARGS) {
> +		if (!is_global) /* not fatal for static funcs */
> +			return -EINVAL;
>  		bpf_log(log, "kernel supports at most %d parameters, function %s has %=
d\n",
>  			MAX_BPF_FUNC_ARGS, tname, nargs);
>  		return -EFAULT;
>  	}
> -	err =3D btf_check_arg_slots(log, tname, is_global, nargs, sub);
> +	err =3D btf_check_arg_slots(log, tname, is_global, nargs);
>  	if (err)
>  		return err;
> =20
> @@ -9022,7 +9018,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
>  		return -EINVAL;
>  	}
> =20
> -	err =3D btf_check_arg_slots(log, tname, is_global, slots_used, sub);
> +	err =3D btf_check_arg_slots(log, tname, is_global, slots_used);
>  	if (err)
>  		return err;
>  	sub->arg_slot_cnt =3D slots_used;

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d95f86b62e99f..b480c5c242af8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11537,13 +11541,24 @@ static int check_static_func_call(struct bpf_ve=
rifier_env *env, int subprog,
>  	/*
>  	 * Track caller's total stack arg count (incoming + max outgoing).
>  	 * This is needed so the JIT knows how much stack arg space to allocate.
> +	 * The callee can load less than its prototype has, and the caller can =
still store
> +	 * all of it. Count the slots of the prototype only as far as the calle=
r has stored
> +	 * them: compilers store in front of the call. bpf_fixup_call_args() re=
jects the rest.
>  	 */
>  	caller_info =3D &env->subprog_info[caller->subprogno];
> -	callee_incoming =3D bpf_in_stack_arg_cnt(&env->subprog_info[subprog]);
> -	stack_arg_cnt =3D bpf_in_stack_arg_cnt(caller_info) + callee_incoming;
> +	callee_incoming =3D bpf_in_stack_arg_cnt(callee_info);
> +	stack_arg_cnt =3D bpf_in_stack_arg_cnt(caller_info) +
> +			max_t(int, callee_incoming,
> +			      min_t(int, caller_info->max_out_stack_arg_cnt,
> +				    callee_info->arg_slot_cnt - MAX_BPF_FUNC_REG_ARGS));
>  	if (stack_arg_cnt > caller_info->stack_arg_cnt)
>  		caller_info->stack_arg_cnt =3D stack_arg_cnt;

[Severity: Medium]
Can btf_prepare_func_args() leave sub->arg_slot_cnt undercounted when it
returns early on a static subprogram with multi-slot parameters?

In kernel/bpf/btf.c, btf_prepare_func_args() initially sets:

	nargs =3D btf_type_vlen(t);
	sub->arg_slot_cnt =3D min_t(u32, nargs, MAX_BPF_FUNC_ARGS);

which is the BTF parameter count rather than the 8-byte slot count. It only
updates sub->arg_slot_cnt to slots_used at the end of the function if the
return type and all parameters are accepted:

	err =3D btf_check_arg_slots(log, tname, is_global, slots_used);
	if (err)
		return err;
	sub->arg_slot_cnt =3D slots_used;

If btf_prepare_func_args() returns an error early for a static subprogram
(for example, when btf_validate_return_type() rejects a pointer return type,
when the parameter loop encounters an untagged pointer parameter, or when
slots_used exceeds MAX_BPF_FUNC_ARGS at too_many_slots while nargs is at
most MAX_BPF_FUNC_ARGS), sub->arg_slot_cnt remains set to nargs instead of
the prototype's 8-byte slot count.

When that static subprogram also has multi-slot parameters (such as 9-to-16
byte structs passed by value or 128-bit integers) and ignores a trailing
stack argument slot, check_static_func_call() in kernel/bpf/verifier.c
computes:

	callee_info->arg_slot_cnt - MAX_BPF_FUNC_REG_ARGS

using the parameter count rather than the slot count. Because this
undercounts the prototype's stack argument slots, wouldn't
bpf_fixup_call_args() reject valid caller stores to those trailing stack
argument slots?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103234104.2082=
39-1-alexei.starovoitov@gmail.com?part=3D6
