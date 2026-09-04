Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A894156F0
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500219; cv=none; b=SR1V4nYNe87Sylr7pb6rJVrQcwDluG7TPbwQbZpltD62zPwPfwzyEkTT4xtnl60du5P78admlXgzCuBmV8ArPGRxEfnfb1l4V12HSQRpkqjRvKmOC9BsZd8VBmt1q9cm70HmhzyMMKFS3x5R2hiws7cRRBrP5yHLYOu4wCvjVkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500219; c=relaxed/simple;
	bh=vcwv+5ze0yF/r8ZUbx2ZQwNddkeM76lizyZ23pyYRtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=flBqDIlM/VuhYRTtk1uZ8NmDNju0z8PqJ0FSFrf6GEUI4b7gt0gh1JexGddqfX2KZ6TpjV3ZCm41n3085diwFt+YLIq1Kxs3X/QeUgD+zXzDilO4weeumikEmXzdI1ciBHFzyDrRReJnrja0a9fZkgqdw6q+F1GgQpRjPo5ar+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1Qsp/Ve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1Qsp/Ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335DE1F00A3F;
	Fri,  4 Sep 2026 05:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788500218;
	bh=WSd6TEnAZHDTx2HnWx6Nq0sfWCakM84f5O2xk8F9748=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E1Qsp/Ve5WJHg1pvoPDFMhytEH15EDaTCPuLP9hKKhM9uZrhgVaFLilaUmOwN1/6G
	 5rs7K6whAxNYQxRRYlIuzJHrOI9ojfXMMvuGap503+U5SUTU6q3oUwYlS/sfU8cbHo
	 F278Lq0kNOAA9hBHBYJtTgQYIC+ZIJnEaTZNWrO8Fl+B2EmkSBQwchjrfI0DxDxs4n
	 9+dehoGGD3PgIGGaYUMB+sJwSS55BDXMYkSoHGlg6LcVlFyodGVAPipmPx+elp8y8/
	 cZ9Di6A1Ajsrq0pf0iEDx4Lo8Lxfa/qahW5a4RkRGnaf7qjC1jzHvf7/m9ZGHU+CsX
	 gsQNnHBqgiMew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 07/12] bpf, x86: Place kfunc arguments per the
 SysV calling convention
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904051033.3979978-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051033.3979978-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 05:36:57 +0000
Message-Id: <20260904053658.335DE1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] emit_kfunc_args() and bpf_jit_kfunc_stack_slots() silently ignor=
e kfunc_arg_layout() errors for kfuncs requiring more than 12 argument eigh=
tbytes, leading to miscompiled BPF programs with incorrect argument placeme=
nts.
--

commit f5201014b232baff8f1ba36c0b74d2c3e1e5ccf9
Author: Yonghong Song <yonghong.song@linux.dev>

bpf, x86: Place kfunc arguments per the SysV calling convention

This commit updates the BPF JIT on x86 to conform to the SysV calling
convention when placing kfunc arguments. It adjusts argument placements
before a kfunc call to account for differing rules between BPF and SysV
regarding stack and register usage. The outgoing argument area is sized
to support both conventions.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> +static int emit_kfunc_args(const struct btf_func_model *fm, u8 **pprog,
> +			   s32 stack_base)
> +{
> +	u8 *prog =3D *pprog, *start =3D prog;
> +	bool done[MAX_BPF_FUNC_ARGS] =3D {};
> +	u8 pos[MAX_BPF_FUNC_ARGS];
> +	int i, j, n, todo =3D 0, parked =3D -1;
> +
> +	n =3D kfunc_arg_layout(fm, pos, ARRAY_SIZE(pos));
> +	if (n < 0)
> +		return 0;

[Severity: Medium]
Will this silently ignore errors if a kfunc requires more than 12 argument
eightbytes?

While the verifier limits the argument count to 12 (MAX_BPF_FUNC_ARGS),
arguments can take up to 2 slots, so the total slots could reach 24.
If a BPF program calls a registered kfunc that requires more than 12
eightbyte slots (such as 7 struct arguments of 16 bytes each),
kfunc_arg_layout() will return -EINVAL because max is hardcoded to 12 here.

Since emit_kfunc_args() returns 0 instead of propagating the error code,
could this cause the BPF program to compile successfully but execute with
missing argument shuffle instructions? It seems the kfunc might read garbage
from the 6th slot onwards, potentially causing panics or data corruption.

This same pattern of silently ignoring layout errors appears in
bpf_jit_kfunc_stack_slots():

kernel/bpf/core.c:bpf_jit_kfunc_stack_slots() {
	...
		n =3D layout(fm, pos, ARRAY_SIZE(pos));
		if (n < 0)
			continue;
	...
}

Does this also leave stack calculations undersized?

Though the stack corruption is mathematically averted because BPF's calling
convention stack requirements always equal or exceed SysV's (making
outgoing_rsp naturally sufficient), the silent argument corruption remains.
As there are currently no mainline kfuncs that take more than 12 slots,
this appears to be a latent regression.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904050957.3976=
119-1-yonghong.song@linux.dev?part=3D7
