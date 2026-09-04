Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B257D37DAD0
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499962; cv=none; b=r/cGPh2Z3xZvIwlXrWopCSyNm7uavcmwHsxZgjcyxSutM9rFsuxPwMMa+BGKjEJTX4GDYI3S1iFuIwzHtJrAekQbVrCMkTrKm9sku2Ofad69YPHPo7ix9K0BA9tZFR2m4MS/u4be4DeCLgRvBSCzgWjCsqCNpb0tiwOvEVaKau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499962; c=relaxed/simple;
	bh=RdLeN1NwDpUjS1qyM3SS66TkTKx7+Fq3axz++cJKbvY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k7SN1w+XWEFak33e55XaZA0QxG2cO+673ixeeCEsHVkky/J2lOCXQrKpNcwI22Wg4NEwphHh7tkNjHzhTkcWC/K8QleXQQjaLichbdlbDvnCT7WPkko4cWJMkctA8hk7cRhDUgOXpsph8BbI8lPCakmLzngslXIsqoBlfCapMvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9zhuu2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9zhuu2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532E61F00A3D;
	Fri,  4 Sep 2026 05:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788499961;
	bh=1/8sOfO/G83HQGDABZck76XQ58xZ17msdETf1x5tq4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a9zhuu2m8frskDbIvQ5UdvLdd6vBvtq8HkU2JirNYxuvgRLKhE3Uen+dCK0uL4FWa
	 erSlYtyKUKS92aXBfDR5mXv7mxxilaEAs/5jueBzVlCqnqQVGMBOshm9IfzZdMc6vV
	 Z1i1ps/eXNMce5yycvys20iCCXJqoKvaMSTmmJFYTWgZXepGJV4FKrSK7MQhINDOLf
	 LNccLgFUvZOK6qHH6IYkmvlp8MjwtZvtajGQoHufw8aj7JLfGDJRRegqC/bB49I6TV
	 a5Q6B8bjFEz9YdLUBDD8gDeyVwq+cN51crQRT8T27IxDtJuceRW7b1soa1p6cStcVc
	 RKgKSHuZQrM2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 04/12] bpf: Support __int128 as a by-value
 function argument
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904051018.3978585-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051018.3978585-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 05:32:40 +0000
Message-Id: <20260904053241.532E61F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds array write in `btf_prepare_func_args()` when an arg=
ument takes multiple register slots (like a 16-byte struct or `__int128`) a=
nd pushes `slots_used` past `MAX_BPF_FUNC_ARGS`.
--

commit 6ab0b55d70f74022fd34563ec7b71f1a649ea690
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Support __int128 as a by-value function argument

This commit adds support for 128-bit integers as by-value function arguments
in BPF. It handles __int128 similarly to a 16-byte struct, consuming two
consecutive argument registers.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8251,7 +8247,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
>  					i, btf_type_str(t), tname, t->size, 2 * BPF_REG_SIZE);
>  				return -EINVAL;
>  			}
> -			if (!btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR)) {
> +			if (btf_type_is_struct(t) &&
> +			    !btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR)) {
>  				if (!is_global)
>  					return -EINVAL;
>  				bpf_log(log, "Arg#%d type %s in %s() is not composed of scalars\n",

[Severity: High]
This is a pre-existing issue, but this patch enables __int128 arguments whi=
ch
trigger the same vulnerable path as 16-byte structs.

Can this loop overflow the sub->args array when an argument takes multiple
slots?

Looking at btf_prepare_func_args() just below this hunk:

			nslots =3D (t->size + BPF_REG_SIZE - 1) / BPF_REG_SIZE;
			while (nslots--)
				sub->args[slots_used++].arg_type =3D ARG_ANYTHING;

If a BPF program defines a subprogram with exactly 12 arguments, where the
last argument is a 16-byte struct or __int128, slots_used would be 11 when
processing the final argument.

The 16-byte argument yields nslots =3D 2. The loop then increments slots_us=
ed
twice without checking bounds mid-loop. Because sub->args is sized
MAX_BPF_FUNC_ARGS (12), this writes to sub->args[11] and then out of bounds
to sub->args[12].

Since sub->args sits at the end of struct bpf_subprog_info, immediately
followed by stack_arg_cnt, this out-of-bounds write corrupts stack_arg_cnt.

Later, sub->stack_arg_cnt is set to slots_used - MAX_BPF_FUNC_REG_ARGS,
which rewrites the corrupted enum value. Depending on endianness, this can
result in an invalid enum value triggering a verifier_bug(), or an incorrect
type expectation (like ARG_PTR_TO_CTX instead of a scalar).

Could we add a bounds check inside or before the nslots loop to prevent
slots_used from exceeding MAX_BPF_FUNC_ARGS?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904050957.3976=
119-1-yonghong.song@linux.dev?part=3D4
