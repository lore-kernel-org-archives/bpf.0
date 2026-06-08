Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C93CB8F4
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930421; cv=none; b=AmEC6QW/Q+PimEIUccXSmSyB5epfGzpnuJGDjzxmYnDlaM9dSHzFxGKTs61eXjo1reZr1SoNkTynRzwoHEn5pUipEa3CGBAeRLIbBr/Vgg0Qu9JUYz+YovlgqVZLuIETBtEONj3ex7Mwr68aXAHCjXOojB8A5Xwg85BUC2echK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930421; c=relaxed/simple;
	bh=KiqF8/MAkDcFtk9sqhNSCq2gu3JKJehODIn0a4JltT0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mYrDeOEw9QHsz4NWN2tFtjjpc6hdEpvPuBoEPZEVoaFFXVYRO1tfMX/0H3OgxOEJJAI2e0xwLIsK+zU9vn/7zjAQaZrv9l5afgZiOVn5ASE5oN8+ObNABsBePBnraHq5h7q/iBkooqpzsl4NSoyV34FNeZlQZF5zT3sXufc2BIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY2KEk0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY2KEk0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BFD1F00893;
	Mon,  8 Jun 2026 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780930419;
	bh=Hs7MLgPitmIVyTcMReuVekArW/KJua4lDQKGvGkwbOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kY2KEk0paqc1Gt2Vq6G+LTvJi/PtWI6+uwWD0JESyn9Q3WsfC+S3J8nbtjcz1y7G/
	 xm0pVjLdVc5HGrJmarrdsgDQnaQjBrrutZFECbiSPy1VdRkb/2eWGXDxt7Jy/tT6T0
	 0yYge5zTCj7HOBP69ZQMwsYnwr2hNT6RQc5snCTGt0542dLDIqstiAblZMtFoKk3GO
	 Is/Zb0be62ktxOk01qVz6iP/a/mOB60OkgwhywUxj6AHfrW+GqxdxpfzU9VLSyrA5V
	 +vBw5XfHix1S5n4gef9nqk5dIOKuwh5dPBoV/w7bgLevaqtaW/Cq1cVR/g89X75DUy
	 zqtRj7awmyQkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: strengthen
 bpf_kfunc_implicit_arg to verify aux injection
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608142618.3064380-3-chenyuan_fl@163.com>
References: <20260608142618.3064380-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 14:53:39 +0000
Message-Id: <20260608145339.81BFD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unsafe memory access in `bpf_kfunc_implicit_arg` leading to kern=
el panic on verifier injection failure
- [Low] BPF subsystem multi-line comment style violation
--

commit 7fe0e7a112c19898e04e79eb1d5d25a017d9fcd2
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: strengthen bpf_kfunc_implicit_arg to verify aux injection

This commit updates bpf_kfunc_implicit_arg to verify that the kernel correc=
tly
injected the bpf_prog_aux pointer. It checks the name field of the aux poin=
ter
to ensure it matches the expected prefix, attempting to catch cases where t=
he
verifier leaves a stale register value.

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c

[ ... ]

> @@ -1827,7 +1827,11 @@ int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_=
ops_args *args, struct bpf_pro
> =20
>  int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux)
>  {
> -	if (aux && a > 0)
> +	/* Verify the kernel injected the correct bpf_prog_aux pointer
> +	 * rather than leaving a stale register value. */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem comment style?

The BPF subsystem guidelines require multi-line comments to have the
opening /* on its own line:

/*
 * Verify the kernel injected the correct bpf_prog_aux pointer
 * rather than leaving a stale register value.
 */

> +	if (!aux || strncmp(aux->name, "test_kfunc", sizeof("test_kfunc") - 1))

[Severity: Medium]
If the verifier skips injection and leaves a stale, non-NULL register
value in the aux variable, won't dereferencing aux->name cause a kernel
panic?

The commit message mentions that in cases like a BTF mismatch, the stale
register would not contain a valid aux pointer. If aux is a garbage pointer
rather than NULL, the !aux check will evaluate to false, and the strncmp
call will attempt to read from unmapped or invalid memory.

Could this use something like copy_from_kernel_nofault() or similar safe
memory access to gracefully fail the test instead of crashing the host kern=
el?

> +		return -EINVAL;
> +	if (a > 0)
>  		return a;
>  	return -EINVAL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608142618.3064=
380-1-chenyuan_fl@163.com?part=3D2
