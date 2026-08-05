Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3647D36493C
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943947; cv=none; b=PnY7qFG4hKjtmGsxoSNAeu5s1rqsBKsq/ZG+WsBux8ZeOUfT+Wy16pDuBVZIyUWWOiI1d8/vNrPWNgXiauzlA+yuFRt7bxsNNfLhzWE2dY95ge3Gi3ymQ6TnipBA/cN8GNuwlfoL4PkA6tpiXEQGQ1SrhQGymY4E7B0r0/IGOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943947; c=relaxed/simple;
	bh=FBZeaODhBTdbo0XAEgn/DBvWhxaF2n9O21ns9ZmQnrc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sMkC9m8DXjq3WHsP5jkK4H9FVQ9g5XELyO64RPJLWVqmPKJKX67xhH/BhADtbYwwcf+j64NXzERdm60yKHmlnAFHfL5+q+1iH2ujoi39/B46k8rzNF/B/Wsb23gHkE8+aeEb9PdqeK81gedmzlgZX+znPltoHPQxtK/GkynsLpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVzfJvlW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVzfJvlW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645AE1F000E9;
	Wed,  5 Aug 2026 15:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785943944;
	bh=U6SVdZQlK7QoivTVNSlbYoHBrXVQwRhFWb0C2F+xaCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVzfJvlWAW64AlvRsP/3yy88CPwdI4d0gpWe0/uYLUrolxjYjhAV4krgG5vwc5NC2
	 ZS0W9BFMuyVQhD30hS2diO7M0Ahu2RRxd1uvPxVyO095seudVP0MrSCQwkFdA8iX0j
	 pU/64toVL2K1tpvyzP17Bt1dNrUpt/1CU7PBuUFp9WIp1wiWOa2tQ9CPAgfRbcGmEk
	 R9PYTsQh2W/a/9SoT3h2z9EGMfBeWcAa1GMlf+sh1ct/nQwN4g7fipulAC3iasZeG4
	 5nDVtO9qGTHaAPe5ez8h+YV3sbl0Vuolncvmp/bc7VxHOOogAMYWiXGsKlvYt0IZ/I
	 X7QNhz6kGpgjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Verify rejection of
 sleepable tracing prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805150810.34907-3-leon.hwang@linux.dev>
References: <20260805150810.34907-1-leon.hwang@linux.dev>
 <20260805150810.34907-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:32:23 +0000
Message-Id: <20260805153224.645AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test deliberately triggers a kernel BUG on a failing run by =
executing an active kernel-crashing payload when the tested bug is present,=
 disrupting automated CI environments.
--

--- Patch [2]: [PATCH bpf-next v4 2/2] selftests/bpf: Verify rejection of s=
leepable tracing prog ---
commit b744623263d5a19a3bd8be3aa0ccd3a94a64c24e
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Verify rejection of sleepable tracing prog

This commit adds a selftest to verify that a sleepable tracing program cann=
ot
attach to a '__x64_sys' prefix prog target. It ensures the kernel properly
rejects this to avoid sleeping function bugs in invalid contexts.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> index 4a87d7163c8c7..2523c07a16c65 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
[ ... ]
> @@ -576,6 +577,60 @@ static void test_func_replace_progmap(void)
>  	freplace_progmap__destroy(skel);
>  }
> =20
> +static void test_sleepable_fentry_to_xdp(void)
> +{
[ ... ]
> +	err =3D bpf_program__set_attach_target(skel->progs.fentry_xdp, prog_fd,=
 "__x64_sys_nop");
> +	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
> +		goto out;
> +
> +	err =3D fentry_sleepable__load(skel);
> +	ASSERT_ERR(err, "fentry_sleepable__load");
> +	if (err)
> +		goto out;
> +
> +	skel->links.fentry_xdp =3D bpf_program__attach_trace(skel->progs.fentry=
_xdp);

[Severity: Medium]
Will this execution path crash automated CI environments when running on a
kernel without the fix?

If fentry_sleepable__load() unexpectedly succeeds and returns 0, ASSERT_ERR=
()
will log the test failure, but the subsequent 'if (err)' check evaluates to
false. This causes the test to fall through to the attach and ping payload
rather than jumping to 'out'.

Since executing this payload triggers a kernel panic when the bug is presen=
t,
should this error check jump to 'out' when err =3D=3D 0 to fail gracefully?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805150810.3490=
7-1-leon.hwang@linux.dev?part=3D2
