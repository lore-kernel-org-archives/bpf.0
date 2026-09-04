Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30E41DEF7
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499386; cv=none; b=XrKlEgr4q7VwQqnGb2jDWxXdQpbVk/acy80rowE0rH0MxjfCG+qZ4W5edTn/jTw4VWhvMHI7RqkuZS5wEVf8FYexffy1Zzpu9x1ph8Og/lPQpcORl4E8JLlNiyLa8A/C7WCdPEN4fQhyVAEJykI/EJc8uJiVvvRtHgTTsZ4D5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499386; c=relaxed/simple;
	bh=fPUh86oDyt5IUoO2yr7kl9+xlqyNBkTr5991YNwG9cg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZCdECvuQbUqF/QmjKI0wBkAEK7u1qktDURWsvT0htNTmj84Y/Spkw3GXvOi2D/z4paZ7mPuM4Hf7QUkxY9R114jQElzgttOBJIKtF8FqA49BGwBK91Grx+WoWSpc4ip77bN7xbiK6aF0+p8H0V4KhDRRoYIyz+rrqsFnE/IJGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuGzuimp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuGzuimp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB2C1F00A3E;
	Fri,  4 Sep 2026 05:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788499384;
	bh=OkLz2wWHouwmH7Xh+OFyG1MRdlynSVwRjTjuoykbKT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SuGzuimpeaFDd6MIDFI0qugItil2tv1QMLs8DBhDXzs6mR4WIGY9srSYVX60AQIXK
	 wrtD5zB8VkGOe56led3oSGP/uMALlyRBb/AOjJUKyBp/fusIEcz5ttA+DDOan7DlK2
	 8UckgyHJHr48PimdsknR4qDDDL4wIDthARTvUsLDHSpoP4+MTp4AsOR/kufXgZOwCq
	 fBzXJQPDCayyzlQ3O2WF29eFY1GSiiBLLcdjTc27BkbT4ob7LvP5WSxBqye24Qc97F
	 BxMMyHQOlnBPU15BjarTAJ6Nj3aIauqSXZ/ZM3r/54ldWTZerbp9GkHeO4WWX9c01U
	 JQlZF1JMeZ3Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 03/12] bpf: Support by-value struct arguments
 up to 16 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904051013.3978240-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051013.3978240-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 05:23:04 +0000
Message-Id: <20260904052304.9AB2C1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Out-of-bounds array write in `btf_prepare_func_args` when an argum=
ent passed by value requires multiple slots, overflowing the `sub->args` ar=
ray.
--

commit d1c6556d5925344f81e73a6b534000285b7cee65
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Support by-value struct arguments up to 16 bytes

This commit adds support for passing struct arguments up to 16 bytes by val=
ue
to global BPF functions. The arguments are split into multiple register slo=
ts
based on their size.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 22828b489b778..dbd64cee1b27a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8103,6 +8103,14 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
>  	for (i =3D 0, slots_used =3D 0; i < nargs; i++) {
>  		u32 tags =3D 0;
> =20
> +		if (slots_used >=3D MAX_BPF_FUNC_ARGS) {
> +			if (!is_global)
> +				return -EINVAL;
> +			bpf_log(log, "Arguments of %s() need more than %d argument slots\n",
> +				tname, MAX_BPF_FUNC_ARGS);
> +			return -EINVAL;
> +		}
> +

[ ... ]

> @@ -8231,6 +8239,31 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
>  			sub->args[slots_used++].arg_type =3D ARG_ANYTHING;
>  			continue;
>  		}
> +		if (btf_type_is_struct(t)) {
> +			u32 nslots;
> +
> +			if (!t->size || t->size > 2 * BPF_REG_SIZE) {
> +				if (!is_global)
> +					return -EINVAL;
> +				bpf_log(log,
> +					"Arg#%d type %s in %s() has size %u, only 1 to %d bytes "
> +					"can be passed by value\n",
> +					i, btf_type_str(t), tname, t->size, 2 * BPF_REG_SIZE);
> +				return -EINVAL;
> +			}
> +			if (!btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR)) {
> +				if (!is_global)
> +					return -EINVAL;
> +				bpf_log(log, "Arg#%d type %s in %s() is not composed of scalars\n",
> +					i, btf_type_str(t), tname);
> +				return -EINVAL;
> +			}
> +
> +			nslots =3D (t->size + BPF_REG_SIZE - 1) / BPF_REG_SIZE;
> +			while (nslots--)
> +				sub->args[slots_used++].arg_type =3D ARG_ANYTHING;

[Severity: High]
Can this loop write out-of-bounds of the sub->args[] array?

The bounds check for slots_used is only performed at the beginning of the
outer for-loop in btf_prepare_func_args(). If a function argument is evalua=
ted
when slots_used is exactly MAX_BPF_FUNC_ARGS - 1, and this argument is a
16-byte struct requiring 2 slots (nslots =3D 2), the inner while loop will
increment slots_used twice.

This will cause an out-of-bounds write when setting arg_type for the second
slot.

Since struct bpf_subprog_info defines args as having exactly
MAX_BPF_FUNC_ARGS elements, writing past the end will corrupt adjacent
memory fields like stack_arg_cnt.

Should the code verify if slots_used + nslots > MAX_BPF_FUNC_ARGS before
entering this loop?

> +			continue;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904050957.3976=
119-1-yonghong.song@linux.dev?part=3D3
