Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C264A3F21
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145252; cv=none; b=Zu6J5TzzkYUEe9Bxy808dKwAv1EyDtGib3HAb/lo9mRsbJhdcPtJ3dZionO/3qhYwqYdo/x89w60d3cVLmzjW2h31LmluMKatS+lQRQXPll3yZ7xxq2A/NMpzUfy3I4ipoh+uerdez2c/KuGV0rmkzYAxO7wPeg8QqYGu4hAmLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145252; c=relaxed/simple;
	bh=Ozsl7YU4SLnU1h6+EQ9D/fiNATcQul72fN0x1LeMR4Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NPu0UyDBfKzZ39YCQpzcxfwqOZGyx0ka1Vt0vPD7iP/X97dPTbq5eLpQpSknQwXZJn/mNVIac9b66PjhX86VynW1BNPXDHvNRbR+YL22nE2KkYcOMpREXRh9DgpRUoQRMky3wt7KnJy/WJsh+wEWYNnHGvMgHyjtN+pLHRUi9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvTdip2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvTdip2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4901F0089C;
	Fri, 11 Sep 2026 16:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789145250;
	bh=ZxRn3V0qQ25OFmKTTwyPhhQ06vy0/XqYj+nntgore5g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jvTdip2RHEzaL1lWIvKAlD8gMVMYmN04+qcjyHVBJrT/6vP6uN9MEzcS0lSyY/bhE
	 XnynA84w3+WFnXWSgHYJDNjTc//2NX04V4NmFlkPYNGAVUyMKGX6W5bjERpMbVuNvu
	 6WWjZwMrSru1A8I2rpWokdgBGZ9l+w51za0Mxpra0Oh5a63tY6Ftm6k/W03v3tEGyh
	 nLRRy2tq7mB8CxT85IRlJtOfh4l7qoxS/AgqFslpC3sp3YK0SdT53x5tex87M/CPO2
	 x4+6LApEuCAhajusjK5C6bcJ66BoZNDvSXaIFlfuDKn6weva1pZf7sCo60jb+39lfO
	 T9XSfoU8trGKA==
Content-Type: multipart/mixed; boundary="===============8479279336311216203=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <255ff7973d5971f95d7a43241872424eac7694cf5c8fd3d2c86030e04ba63fcb@mail.kernel.org>
In-Reply-To: <20260911154954.2008505-1-yonghong.song@linux.dev>
References: <20260911154954.2008505-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 08/15] bpf: Recognize by-value struct and __int128 kfunc arguments
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 16:47:29 +0000 (UTC)

--===============8479279336311216203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Recognize by-value struct and __int128 kfunc arguments
>
> A kfunc taking a struct or union by value is rejected today, and one
> taking an __int128 is accepted but mis-counted:
>
>   Unrecognized R2 type STRUCT
>
> The kfunc arguments walk the same slot as a BPF-to-BPF call:
> one argument register per eightbyte, and a 16-byte value takes two.
> The outgoing stack argument count at the call site follows the slots for
> the same reason. Similar to BPF-to-BPF aggregate handling, a kfunc
> aggregate argument is only supported when it is composed of scalars.
> Everything that maps a kfunc argument to a register has to follow the
> slots too.
>
> An argument of a single eightbyte lands in the same place under every
> calling convention, so those are taken. The conventions the JIT has to
> reconcile do not agree on where a larger one goes, so refuse it for now
> with
>
>   Function f arg#1 type INT cannot be passed at argument slot 1 on this
>   architecture
>
> which the next patch turns into an answer from the JIT. The paths that
> handle a two-slot argument are therefore unreachable until then.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for kfunc struct argument support. Should this
include:

  Fixes: 0ab8eb34abe4 ("bpf: Support by-value struct arguments up to 16 bytes")

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c520c37bb3c9..9e70995c763f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12892,29 +12978,35 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>  	const struct btf *btf = meta->btf;
>  	const struct btf_param *args;
>  	struct btf_record *rec;
> -	u32 i, nargs;
> +	u32 i, k, nargs, proto_slots, slots_used, prev_slot = 0, nslots = 0;
>  	int ret;
>
>  	args = (const struct btf_param *)(meta->func_proto + 1);
>  	nargs = btf_type_vlen(meta->func_proto);
> +	proto_slots = kfunc_proto_slots(btf, meta->func_proto);
>
> -	ret = check_outgoing_stack_args(env, caller, nargs, func_name, btf, args);
> +	ret = check_outgoing_stack_args(env, caller, proto_slots, func_name, btf,
> +					proto_slots == nargs ? args : NULL);
>  	if (ret)
>  		return ret;
>
>  	/* Check that BTF function arguments match actual types that the
>  	 * verifier sees.
>  	 */
> -	for (i = 0; i < nargs; i++) {
> -		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, i);
> +	for (i = 0, slots_used = 0; i < nargs;
> +	     i++, prev_slot = slots_used, slots_used += nslots) {
> +		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, slots_used);
>  		const struct btf_type *t, *ref_t, *resolve_ret;
>  		enum bpf_arg_type arg_type = ARG_DONTCARE;
> -		argno_t argno = argno_from_arg(i + 1);
> +		argno_t argno = argno_from_arg(slots_used + 1);
>  		int regno = reg_from_argno(argno);
>  		bool btf_id_fixed_off_ok = true;
>  		u32 ref_id = args[i].type, type_size;
>  		int kf_arg_type = meta->fn->arg_type[i];
>
> +		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
> +		nslots = kfunc_arg_slots(t);
> +
>  		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
>  			/* Reject repeated use bpf_prog_aux */
>  			if (meta->arg_prog) {

[ ... ]

> @@ -12986,6 +13076,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
>  			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
>  		}
>
> +		/*
> +		 * The first slot is checked in below KF_ARG_ANYTHING.
> +		 * The rest of it has to be a scalar.
> +		 */
> +		for (k = 1; k < nslots; k++) {
> +			ret = check_kfunc_scalar_arg(env, caller, regs, slots_used + k,
> +						     insn_idx, func_name);
> +			if (ret)
> +				return ret;
> +		}
> +

This isn't a bug, but would it be worth rewording this comment to name
the KF_ARG_ANYTHING case explicitly and speak of the remaining slots in
the plural? The phrase "checked in below KF_ARG_ANYTHING" is a bit hard
to parse, and "the rest of it" refers to slots while the sentence subject
is singular.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34620351527
--===============8479279336311216203==--
