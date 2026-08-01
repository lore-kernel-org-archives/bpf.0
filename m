Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2BC2BEFEF
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785571782; cv=none; b=lpkncuZn5QgAIJoQyPu5qd2rhq2gaeJ+gSD8NyReJnRRD+1xE4XeRTqNi5jLCelFsX9mF7No3lvgHmRh074+KF+KVb3+vjOKDfSyxHfOVbGtCaPumy87bPjU6DWWkWHeD+fPpmMneezf67sZ37vDOTNEjiF7tAVSzGY5vUHUI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785571782; c=relaxed/simple;
	bh=KSLqN2rkKUrZmbR7HVsd6M/RuqxRjtQAXBj4LAw3rfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hijoeOdz/eb+Rz8FEh61ZLx4VDJXjq7XvzXHk5u8BSCBBGEFJ2kz16seTLLZKs7Zq9k0Xu8l2ebFdw25hkpP5ocZlON4PkK3ziWkpbQf7YpPcy3tj9ZLOj0bFaJXvoobWNmXDfbPouOiycsQbWPiyC5DBeBLICPsNjW6s13cLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnJN8yrX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnJN8yrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E721F00AC4;
	Sat,  1 Aug 2026 08:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785571780;
	bh=aaoCS8qdDELW3s+38nd2EV02rDRTiwTaprfLldXTTGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LnJN8yrXE2oSvA8422NxzFLaUCIOUBHJl9hJXMHcADaztewLN9yuXumw4PocynLCu
	 cKx3DBqSBO0MRrHS/DyEAei46opd/I8S039utfRLUbwNamWMs6+YhKfS6H5XyWRVBa
	 DYC1hsX/vB6iVGvAF78KuOrOCg949RVgdcq4ZFj8jMUE0t8ml+BqtYSQaIr4FxvBnK
	 eV9KUKcy8ONaf1QvEJszNFt40WPRoZsnVdHcKPdA1irU6Rtl/0bB+Q8uZR9u/6UVv6
	 ep9ZJsf/+/QZVz0uoGtYOE0LFM1fOfhtcs/JCyXwKyMZOvx/zmz18mEJ1SMTecW+HF
	 stZ/o8xdRtPAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 12/18] bpf: Classify kfunc mem_size args
 from BTF without register state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260801074633.1595644-13-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
 <20260801074633.1595644-13-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 08:09:39 +0000
Message-Id: <20260801080940.55E721F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the register type check from `is_kfunc_arg_mem_size()` al=
lows a BPF program to pass a pointer register as a memory size parameter (`=
__sz`), which triggers a `verifier_bug` and a kernel warning.
--

--- Patch [12]: [PATCH bpf-next v3 12/18] bpf: Classify kfunc mem_size args=
 from BTF without register state ---
commit e7666ea9e561228e1708d772f8e42d33c514cde8
Author: Amery Hung <ameryhung@gmail.com>

bpf: Classify kfunc mem_size args from BTF without register state

This commit removes register state checks from is_kfunc_arg_mem_size() and
is_kfunc_arg_const_mem_size(). It relies solely on BTF to classify kfunc
memory size arguments to further decouple argument type classification from
register state.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6fc22a4e38b26..d65da54f9c0f8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10785,26 +10785,24 @@ static bool is_kfunc_rcu_protected(struct bpf_c=
all_arg_meta *meta)
>  }
> =20
>  static bool is_kfunc_arg_mem_size(const struct btf *btf,
> -				  const struct btf_param *arg,
> -				  const struct bpf_reg_state *reg)
> +				  const struct btf_param *arg)
>  {
>  	const struct btf_type *t;
> =20
>  	t =3D btf_type_skip_modifiers(btf, arg->type, NULL);
> -	if (!btf_type_is_scalar(t) || reg->type !=3D SCALAR_VALUE)
> +	if (!btf_type_is_scalar(t))

[Severity: High]
Does removing this SCALAR_VALUE check allow a BPF program to pass a pointer
register instead of a scalar to a kfunc's size argument, potentially
triggering a verifier_bug()?

If get_kfunc_ptr_arg_type() sets arg_mem_size purely based on BTF,
check_kfunc_args() will process the memory pointer argument, peek ahead at
the size argument, and call check_mem_size_reg():

kernel/bpf/verifier.c:check_kfunc_args() {
    ...
    ret =3D check_mem_size_reg(env, buff_reg, size_reg, argno, next_argno,
                             BPF_READ | BPF_WRITE, true, meta);
    ...
}

This happens before the main loop reaches the size argument and ensures it =
is
a SCALAR_VALUE.

If a pointer register with a fixed zero offset is passed,
check_mem_size_reg() might assume it is a valid scalar value of 0, pass the
boundary checks, and call mark_chain_precision(). This explicitly triggers
verifier_bug(env, "backtracking misuse") if the register is not a
SCALAR_VALUE.

Could this lead to a kernel panic on systems with panic_on_warn=3D1?

>  		return false;
> =20
>  	return btf_param_match_suffix(btf, arg, "__sz");
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801074633.1595=
644-1-ameryhung@gmail.com?part=3D12
