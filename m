Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637602475D0
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784791638; cv=none; b=UMCa5w3AI5I9Ty2BFpCtdzRIonPR91nh8rRnr7EyCdYB1oaEy++fIX2SQTzQT0DYNsN7SmwBeeOBIdvMcbPzbx6MV0EqPShg5V0XziZDEgj/6kHjfUCA+bIX0KBEi2XQo7vb6NiPbBZB0coL2dmWJ5vcFpqZLTOFbziYD//VkYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784791638; c=relaxed/simple;
	bh=R5jekC4HAUm2HaVetQ1Lsy5Kko9VX23n2zmCqzifI9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kiGJR2GDMY42HnhIozGKxql86xFiZlCpd4bqkMMFKBYCauSsGFq1C3k3unIaD0rz5d3neytjkcpHzqknVeEn4QAmUuUzWTPxWak5YzRcd8FaSj7fqtNAK1+EauzSB57ix1fGW/nn8V+Tb+i1FN8iAHn6pb6hf9YEQk7vHALUW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVJm5TBj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVJm5TBj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D231F000E9;
	Thu, 23 Jul 2026 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784791636;
	bh=tHeTz3qudVhKkfTExBtEB59EASOtI/nUij4ZVH8fySY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVJm5TBjAyhrjDUbZ6eiHYDAraAG9+vLGbGa9or9B5aX7mzY6KyrDGhQ6IdQMBgYH
	 aAaXKM9N0zlprw8Dt2CpYO6FVWox6F5MKXTJsSJDKmW1Wql9vSCO/w6sGI2fCQsHep
	 6JkK0vwuINpYqykGw5LZTQgzMALSPlA8JmJZU/5UY2UFSHaGrywMW+qFbIeHn6oq00
	 JFsNh1KhAokq0dNkn+k0tkWD+pcjphi6A7iS2CEINn//0PRnrpNYXokSlvdsvctP6o
	 0m1Csf+ZCn05Y3Z5Ssxz3A2mfgIuOkbHlHhWOOUV0/N9LYJJl0Tiw/bj3EJSsoKpjt
	 4ChhFUHcb7zpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 15/18] bpf: Classify kfunc pointer arguments
 from BTF, resolve type against the register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723050806.1158442-16-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
 <20260723050806.1158442-16-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 07:27:16 +0000
Message-Id: <20260723072716.A1D231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The removal of the `bpf_type_has_unsafe_modifiers()` check all=
ows referenced pointers with unsafe modifiers (specifically `MEM_PERCPU`) t=
o be passed as normal pointers to regular kfuncs.
--

--- Patch [15]: [PATCH bpf-next v1 15/18] bpf: Classify kfunc pointer argum=
ents from BTF, resolve type against the register ---
commit 23915f0b14432c05d0cd9201ab12d531e9b8df8a
Author: Amery Hung <ameryhung@gmail.com>
Subject: bpf: Classify kfunc pointer arguments from BTF, resolve type again=
st the register

This commit refactors kfunc pointer argument classification to rely on BTF=
=20
rather than the caller's register state. It also moves the referenced-or-tr=
usted=20
checks for BTF ID arguments into the BTF ID resolution path.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12383,20 +12376,46 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_call_arg_me
>  			break;
>  		case KF_ARG_PTR_TO_BTF_ID:
>  			/* Only base_type is checked, further checks are done here */
> -			if ((base_type(reg->type) !=3D PTR_TO_BTF_ID ||
> -			     (bpf_type_has_unsafe_modifiers(reg->type) && !is_rcu_reg(reg))) =
&&
> -			    !reg2btf_ids[base_type(reg->type)]) {
> -				verbose(env, "%s is %s ", reg_arg_name(env, argno),
> -					reg_type_str(env, reg->type));
> -				verbose(env, "expected %s or socket\n",
> -					reg_type_str(env, base_type(reg->type) |
> -							  (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS)));
> +			if (base_type(reg->type) =3D=3D PTR_TO_BTF_ID ||
> +			    reg2btf_ids[base_type(reg->type)]) {
> +
> +				if (!is_trusted_reg(env, reg)) {
> +					if (!is_kfunc_rcu(meta)) {
> +						verbose(env, "%s must be referenced or trusted\n",
> +							reg_arg_name(env, argno));
> +						return -EINVAL;
> +					}
> +					if (!is_rcu_reg(reg)) {
> +						verbose(env, "%s must be a rcu pointer\n",
> +							reg_arg_name(env, argno));
> +						return -EINVAL;
> +					}
> +				}
> +
> +				ret =3D process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref=
_id, meta, i, argno);

[Severity: Critical]
Does this new structure allow referenced pointers with unsafe modifiers (li=
ke
MEM_PERCPU) to bypass validation and be passed to regular kfuncs?

The original code explicitly checked for unsafe modifiers:
bpf_type_has_unsafe_modifiers(reg->type) && !is_rcu_reg(reg)

However, is_trusted_reg() unconditionally returns true for all referenced
pointers. If a BPF program allocates a per-CPU object using
bpf_percpu_obj_new(), it receives a referenced pointer with the
PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU type.

Since is_trusted_reg() will trust this referenced pointer, the unsafe
modifier check appears to be bypassed. If this pointer is then passed to a
generic kfunc expecting a standard kernel pointer, could dereferencing the
raw per-CPU pointer (which acts as an offset rather than a virtual address)
trigger a page fault and crash the kernel?

> +				if (ret < 0)
> +					return ret;
> +				break;
> +			}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.1158=
442-1-ameryhung@gmail.com?part=3D15
