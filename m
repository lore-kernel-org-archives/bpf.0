Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98935346A19
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635716; cv=none; b=YN6BxrebjER6j61IX/aYN9HxWJFDFDBQppl6pDKjmS9WTFm9NCr0fU/Ostj4sUk9rBQYl+iMbL6vYa7VHMg1Tl+bgeb4GRwlLybM03lKyX8HKO5GhFuwHCYKCNOPuK2W9mXzRFukISlh+LURVdA63PkDdE3g+yjopOC2ZoV7mxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635716; c=relaxed/simple;
	bh=UI7pALpdge8y7c923vWDbvUyrAKJ5/EHrig3hBHVIJk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FjFxQj78inNGpj4SITL7O9KwcC/rOOZM7NrWqmX8GV5uV58XvuIpEFwZ8WFN5Rf3ENCDoqsGOwhXwzpTj8NeEAX/BE9nV2x6HZz9FnXBWWAOt+Mp+u+HmCy8j4P3hPFyMIkIDPN4walVgDjuAx2ordystEM8kjGx97zvyG2hXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQpdwGS5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQpdwGS5"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-848761b5897so19514b3a.3
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783635714; x=1784240514; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=COtf+UqtS7pMI/U4G/J5AH2MxiHcvZElqgmhEVHroEg=;
        b=cQpdwGS5rNn9sVyImDPwAXPlW7gBM5bFdOABP1rBWqBMWrJv+VXtNrf65sFzbw0VA8
         8ApvM1dSMvMQML+b6vDIwHt8BFPAO5oW1MUXOdMIjWnbwrNjEmx/cowthTHKrcVylnsS
         mTdOdMz/BX9EsM0Bb6O7zxD0d75UVeNBA5iAK8vgdTd2Fg06JpNAE34z45GGsOAYlxWO
         WiyF6X67hIdyhJGjmu0sV0dma+qOH8YxBcfZSA2O0GqFPXOwqhTggb2+BMjZLbHmQIoA
         Rig9wGmJrH7P6E68IBw2T3R0RuT5qLqqTclvi0GKW0fOXel+//v+CQSZ9ivKS5zHiCzP
         GjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783635714; x=1784240514;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COtf+UqtS7pMI/U4G/J5AH2MxiHcvZElqgmhEVHroEg=;
        b=ZC5xm14SrfHgBC9cvr5fqtcgbj1dQWxCwqCX/YsMSYJvqttsx9UaMZN1hPK1ONcrFP
         LxjMJkhh9tJTTyneLjp8YZnzCZLpaJRYnMcAQ7ShcjUh+r6FqBG3jUc7B6bDJK/oacFE
         6u8Qc2jVaY9wyZWNvJahDDX6aS3LVRAa5uHt0PbjpHj4enyTjDzpXPWnT9SVz1FeNqUH
         OFwbUhuUMtMAU9tUA31m4z60VexWlSN928RpCQcPoTSfJ7MRuwfXlp1948/qaQhAs+Yz
         JWErubr/LhBT/M3/Y4JjUilwjSlfB5In1ZRwKofkhMjNPxj5aHutBcVk3pU+Gi4ph9qD
         GQ/w==
X-Forwarded-Encrypted: i=1; AHgh+Rqo53awabte60otOO6GWfIyjJf/zZYf/6DZXO8+VGH6lrtT3QbvgKfsq2u1ILxaXrcHreg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIVL3ftE2Hh0OsBRyj68YqlHqev02G0wConFkEvsClCVpwVi0t
	J5+IL+ELTozjtqGtV2+u2m2rd+OWAVspTf43fECBgz31giGohPbByq64
X-Gm-Gg: AfdE7cmhqZJLdC/N4NboWO+3U5Yz+dDFSkGxUBxoZRI7EOf38Xq+Q+ty+bMgn52lMNj
	VY2SN3gDvTgZ6BkrxtqKyE1WqgOqkr+l5iWH4KBfGuMWRx7FulNr8VHqvaJSVcybW5TWnxB4Mp7
	anslfvIwp32lBU0XJuZx2lWNRm8iVZ4JOV2Dk6yNzWCzDXr1v4oq5aKlZFXNrYpP/c3LXqRRLF5
	YsZrKN+YhAtQLEALbpn4mjCnCkkKwGlU1lf97U+hqJOGw8Zh+5QY32ni66oJ6Xx7LWSez3Km+ao
	RSEkZx4NCVGsJ6HNa+lkZTR7OtTHpn8Tdh3vXmJxVrdOriae2DucLs7mBuSX+tDGuWmqcOPTaDW
	/3HaztWboxtk5Yi+IX5k6KAqSgqVMBvJs67LM3YW7S8apT0fZDr639256smubnYwCpF/7X9JLz1
	hze0j8iVpQ3PNFQrfmf+igO7wOas7r3Mg77tUKJd9bzCR0Qf1YSqU=
X-Received: by 2002:a05:6a00:448b:b0:848:2f6e:e52b with SMTP id d2e1a72fcca58-84842ffe2bbmr8858922b3a.63.1783635713906;
        Thu, 09 Jul 2026 15:21:53 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84870d76ce7sm279390b3a.55.2026.07.09.15.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 15:21:53 -0700 (PDT)
Message-ID: <ea6bd9922125d2e3967dae33a686cd7e42830b73.camel@gmail.com>
Subject: Re: [PATCH bpf-next 02/12] bpf: Add verifier support for 16-byte
 returns in R0:R2
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Thu, 09 Jul 2026 15:21:50 -0700
In-Reply-To: <20260708200949.2156169-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
	 <20260708200949.2156169-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 13:09 -0700, Yonghong Song wrote:
> LLVM 23 added support for returning a value in two registers for an
> __int128, or a struct/union whose size is greater than 8 but not more
> than 16 bytes. See LLVM patches [1] and [2].
>=20
> Before LLVM 23 the BPF backend could not return these values at all. A
> by-value struct or union return (of any size) was rejected at compile
> time with:
>=20
> =C2=A0 error: aggregate returns are not supported
>=20
> and an __int128 return failed later in the backend with:
>=20
> =C2=A0 fatal error: error in backend: unable to allocate function return =
#1
>=20
> Both are resolved in LLVM 23, which lowers such returns into the R0:R2
> register pair.
>=20
> This patch is one of several preparation patches that build up
> <=3D16 byte return support incrementally:
> =C2=A0 - the verifier R0:R2 modelling in this patch,
> =C2=A0 - the x86 JIT move and JIT-capability gate,
> =C2=A0 - precision-backtracking and live-register tracking of R2,
> =C2=A0 - forcing the JIT for such programs, and
> =C2=A0 - guarding the trampoline paths.
> Finally, the patch "bpf: Enable 16-byte aggregate return types" enables
> support for 16-byte returns.

Nit: I think the above paragraphs belong to a cover letter.

> This patch adds handling for '>8' byte returns in several places: BPF
> subprogram returns (the main program, and both global and static
> subprograms) and kfunc returns.
>=20
> =C2=A0 [1] https://github.com/llvm/llvm-project/pull/190894
> =C2=A0 [2] https://github.com/llvm/llvm-project/pull/206876
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
> =C2=A0kernel/bpf/verifier.c | 93 ++++++++++++++++++++++++++++++++++++++++=
---
> =C2=A01 file changed, 88 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3f34ce1a3107..03ffb5f839fa 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -424,6 +424,35 @@ static bool subprog_returns_void(struct bpf_verifier=
_env *env, int subprog)
> =C2=A0	return btf_type_is_void(type);
> =C2=A0}
> =C2=A0
> +static bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
> +{
> +	const struct btf_type *type, *func, *func_proto;
> +	const struct btf *btf =3D env->prog->aux->btf;
> +	u32 btf_id;
> +
> +	if (!btf || !env->prog->aux->func_info)
> +		return false;
> +
> +	btf_id =3D env->prog->aux->func_info[subprog].type_id;
> +
> +	func =3D btf_type_by_id(btf, btf_id);
> +	if (!func)
> +		return false;

`if (!func) return false` checks here and below are not necessary
after BTF validation.

> +
> +	func_proto =3D btf_type_by_id(btf, func->type);
> +	if (!func_proto)
> +		return false;
> +
> +	type =3D btf_type_skip_modifiers(btf, func_proto->type, NULL);
> +	if (!type)
> +		return false;
> +
> +	if (btf_type_is_struct(type) || btf_type_is_scalar(type))
> +		return type->size > 8 && type->size <=3D 16;
> +
> +	return false;
> +}
> +
> =C2=A0static const char *subprog_name(const struct bpf_verifier_env *env,=
 int subprog)
> =C2=A0{
> =C2=A0	struct bpf_func_info *info;
> @@ -9459,10 +9488,17 @@ static int check_func_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
> =C2=A0		clear_caller_saved_regs(env, caller->regs);
> =C2=A0		invalidate_outgoing_stack_args(env, cur_func(env));
> =C2=A0
> -		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
> +		/*
> +		 * A non-void global function returns a 64-bit SCALAR_VALUE in
> +		 * R0, or a >8 byte SCALAR_VALUE in the R0:R2 register pair.
> +		 */
> =C2=A0		if (!subprog_returns_void(env, subprog)) {
> =C2=A0			mark_reg_unknown(env, caller->regs, BPF_REG_0);
> =C2=A0			caller->regs[BPF_REG_0].subreg_def =3D DEF_NOT_SUBREG;
> +			if (bpf_ret_reg_pair(env, subprog)) {
> +				mark_reg_unknown(env, caller->regs, BPF_REG_2);
> +				caller->regs[BPF_REG_2].subreg_def =3D DEF_NOT_SUBREG;
> +			}
> =C2=A0		}
> =C2=A0
> =C2=A0		if (env->subprog_info[subprog].might_throw) {
> @@ -9825,6 +9861,13 @@ static int prepare_func_exit(struct bpf_verifier_e=
nv *env, int *insn_idx)
> =C2=A0	} else {
> =C2=A0		/* return to the caller whatever r0 had in the callee */
> =C2=A0		caller->regs[BPF_REG_0] =3D *r0;
> +		if (bpf_ret_reg_pair(env, callee->subprogno)) {
> +			if (callee->regs[BPF_REG_2].type =3D=3D PTR_TO_STACK) {

Let's consolidate all such checks in one place and not copy-paste them.

> +				verbose(env, "cannot return stack pointer to the caller\n");
> +				return -EINVAL;
> +			}
> +			caller->regs[BPF_REG_2] =3D callee->regs[BPF_REG_2];
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to=
 callsite,
> @@ -10745,6 +10788,18 @@ static void mark_btf_func_reg_size(struct bpf_ve=
rifier_env *env, u32 regno,
> =C2=A0	return __mark_btf_func_reg_size(env, cur_regs(env), regno, reg_siz=
e);
> =C2=A0}
> =C2=A0
> +static void mark_kfunc_ret_reg_size(struct bpf_verifier_env *env,
> +				=C2=A0=C2=A0=C2=A0 struct bpf_reg_state *regs, u32 size)
> +{
> +	if (size > 8) {
> +		mark_btf_func_reg_size(env, BPF_REG_0, 8);
> +		mark_reg_unknown(env, regs, BPF_REG_2);
> +		regs[BPF_REG_2].subreg_def =3D DEF_NOT_SUBREG;
> +	} else {
> +		mark_btf_func_reg_size(env, BPF_REG_0, size);
> +	}
> +}

This function makes R2 handling very asymmetric compared to R0:
- mark_reg_unknown() for r0 is done in check_kfunc_call()
- DEF_NOT_SUBREG for r0 is done in mark_btf_func_reg_size()

I think the code should be structured to keep R0 and R2 processing
uniform.

> +
> =C2=A0static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
> =C2=A0{
> =C2=A0	return meta->kfunc_flags & KF_ACQUIRE;
> @@ -13208,7 +13263,22 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
> =C2=A0		if (meta.btf =3D=3D btf_vmlinux && (meta.func_id =3D=3D special_k=
func_list[KF_bpf_res_spin_lock] ||
> =C2=A0		=C2=A0=C2=A0=C2=A0 meta.func_id =3D=3D special_kfunc_list[KF_bpf_=
res_spin_lock_irqsave]))
> =C2=A0			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
> -		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
> +		mark_kfunc_ret_reg_size(env, regs, t->size);
> +	} else if (btf_type_is_struct(t)) {
> +		/*
> +		 * The returned struct comes back as raw register bits modeled
> +		 * as an unknown scalar, so it must contain only scalars:
> +		 * otherwise a pointer field would be laundered into a scalar
> +		 * and escape provenance and reference tracking.
> +		 */
> +		if (!__btf_type_is_scalar_struct(env, desc_btf, t, 0)) {
> +			verbose(env, "kernel function %s returns %s %s that is not composed o=
f scalars\n",
> +				func_name, btf_type_str(t),
> +				btf_name_by_offset(desc_btf, t->name_off));

Should this also check the size of the struct?

> +			return -EINVAL;
> +		}
> +		mark_reg_unknown(env, regs, BPF_REG_0);
> +		mark_kfunc_ret_reg_size(env, regs, t->size);
> =C2=A0	} else if (btf_type_is_ptr(t)) {
> =C2=A0		ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type, &ptr_type=
_id);
> =C2=A0		err =3D check_special_kfunc(env, &meta, regs, insn_aux, ptr_type,=
 desc_btf);

[...]
