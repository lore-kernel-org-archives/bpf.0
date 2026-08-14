Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DBA2C15A9
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670442; cv=none; b=uX/60D1YoORB+gSH/uc3RRMDlpgYdN9xG2PfUPBtk0ITOXVpCRd5mvqiDlGNxxQ+G+d4KGPdBUY+prZggnE0ZUHNX+OX8fVoFggS98lnZK1cZlnTPRkvJsgAWcOEroF6Qgu/zazejsex7AJmGhYi+3tOqoe1QqdYxkCjoRR1evc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670442; c=relaxed/simple;
	bh=7mi+u0jmxL+FYUKHEpiId8J3n0D4znAEf8yCAikiu60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AEJU7USGFgFOfnRzHeSAXT1QPpQhqTNvm6AcKgZ8BOyIkbOcOxr9xwHVq7jFy6VGnrtyYjifA7PlgDVa3a+dkIEc5LuG+sT3C3zzeCUmEOsYcRPI3JJyeO0EKkGFqirFt9JuaNbMEssK47r8gx3pA7vqbCzhGFpq2+jmbT4B7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy4/py3t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy4/py3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4921F000E9;
	Fri, 14 Aug 2026 01:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786670440;
	bh=boRvZBLVANEJapmZsIesN3UL0L8wg6OQKjVIAcdidXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hy4/py3tzmiOQwuWZTOPkhfUH/l5xh392NaLotMBNJFhVyXraIqiV8y7JX0I7bM6h
	 h6tLLPpYolHWKUWxGx/t86qw502s94tXiFSayiIckb7dpO359NWlabLLWa3CaxqIIm
	 1M8LcbnbpWx4O2foEgsGcSwZ7qPD8+8t5gKIl+RN9OcOTamifmpe1Ph3BP7fd7Y3PU
	 z67HtvO2m4wnVU4eBu1Wsij/XpfZuHvW8Px9tpjfkOZzpgD89/FMCO1YwF9jdSV8s5
	 TbD4Gyjk5JKGoDAEwGgyz+NVgGu2aT7mk1tyn5JiYU3aRjSreW8Z62g9Jp1vKuNNnZ
	 guzSE07Bzd6+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 03/11] bpf: Wire up JIT support for 16-byte
 kfunc returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813200225.1994805-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
 <20260813200225.1994805-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:20:39 +0000
Message-Id: <20260814012040.1F4921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The verifier fails to initialize BPF_REG_2 for 16-byte kfunc retur=
ns, and completely fails to initialize both BPF_REG_0 and BPF_REG_2 if the =
kfunc returns a 16-byte struct.
--

--- Patch [3]: [PATCH bpf-next v5 03/11] bpf: Wire up JIT support for 16-by=
te kfunc returns ---
commit fc27c41d2405fa63fb5ef7aa5e34586ccf98e0bd
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Wire up JIT support for 16-byte kfunc returns

This commit adds JIT support for 16-byte kfunc returns by placing the
second half of the return value in the BPF R2 register. It introduces
architecture-specific capabilities and enables support for x86-64, arm64,
and riscv64. The verifier is also updated to reject unsupported 16-byte
returns.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 57d14480ded29..161d77791bc62 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2854,6 +2854,18 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *en=
v, u32 func_id, u16 offset)
>  	err =3D btf_distill_func_proto(&env->log, kfunc.btf, kfunc.proto, kfunc=
.name, &func_model);
>  	if (err)
>  		return err;
> +	if (func_model.ret_size > 8) {
> +		if (kfunc.flags && (*kfunc.flags & KF_FASTCALL)) {
> +			verbose(env, "kfunc %s with >8-byte return is not supported with KF_F=
ASTCALL\n",
> +				kfunc.name);
> +			return -EOPNOTSUPP;
> +		}
> +		if (!bpf_jit_supports_kfunc_ret_reg_pair()) {
> +			verbose(env, "kfunc %s with >8-byte return is not supported by JIT\n",
> +				kfunc.name);
> +			return -EOPNOTSUPP;
> +		}
> +	}

[Severity: High]
Does the verifier need updates in check_kfunc_call() to track the initializ=
ation
of BPF_REG_2 for these larger returns?

When evaluating the kfunc return type in check_kfunc_call(), the verifier
currently appears to miss marking BPF_REG_2 as initialized for 16-byte scal=
ar
returns:

kernel/bpf/verifier.c:check_kfunc_call() {
    if (btf_type_is_scalar(t)) {
        mark_reg_unknown(env, regs, BPF_REG_0);
        ...
    } else if (btf_type_is_ptr(t)) {
        ...
    } else if (btf_type_is_void(t)) {
        ...
    }
}

Furthermore, if the kfunc returns a 16-byte struct, the code falls through
completely without initializing either BPF_REG_0 or BPF_REG_2.

Since all CALLER_SAVED_REGS are cleared to NOT_INIT earlier during the call,
won't this cause the verifier to incorrectly reject valid BPF programs that
attempt to read these return values?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813200210.1991=
507-1-yonghong.song@linux.dev?part=3D3
