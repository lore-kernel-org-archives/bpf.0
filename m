Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E634753F
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297688; cv=none; b=U5DMfVcA3nYJM2fyYBgclzhH3T4/CRCWUyJV2MSo2er5pdxiT0oAebclVhgTvTjfOxKR8daVkV5Eqpu3HdbwcmI2kI1SiYnd7WVL3rEayNWppJgRQMjWscu6mtT6yaxURkhkg6pSnfGhtJ6k3T8y9e9VYPLr+jVf8x36UdwkzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297688; c=relaxed/simple;
	bh=28WlBr73GRSuhvfIaXBlq/gytQfOpEjXmGv75NSVEQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R2yDSgVyEz+C71bWNkUylzucGhA+1bpHYcAnV5vw4TsKBWfsfJTzwbp/cR1RVAMuAOvdoWm+5lTFMfUhlWYuvmy9Y/syquPA9PsqA6/Mvi8MMGsQ6NN1OWzxDZG60j3h5+S9lgmrvz2iCxcDuEQ8qauPH8Ex+6Z7Mv1wR3fh21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3khH0rT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3khH0rT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB321F00893;
	Mon,  1 Jun 2026 07:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780297687;
	bh=wlehJoFM0jT999X3DRQNvBr+8Rzn7Ow3rtveiO6Hxw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3khH0rT3hWsk/i55FdyxxOXKUl8fkBGBArIpZ0V5eqOcu7arh0R06ksktKjxsA8s
	 LNaOTWQbkQ1yJZnemR7HAHUKIJNlYA1jRhLBJs0P78kZM0t1csXJFPVyl7c7Lukfps
	 qmDD1xMBmVtwf5gHq81f4y10rS4B8fFd5cqAn2v06x1nsKV6s/lIbrlBIczZUilnKK
	 DnzgxhspKmnSE0soIXAM375WA4wtek3AG3EJwwOTpPPnFe0iKhqdmpmU7q7r3vM8Mg
	 XlCpta/OJ8RdaVF75D9gF9qW4HIyRWFrtyXNzVUpwIJVlUzdmUFoO7b8YEEJOYf29k
	 XS5ZZemHwjfWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add regression test for kfunc
 implicit arg injection with stale register
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260601064611.807637-3-chenyuan_fl@163.com>
References: <20260601064611.807637-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 07:08:06 +0000
Message-Id: <20260601070807.0FB321F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added multi-line comment documenting the aux injection te=
st violates the BPF subsystem comment style guidelines by placing text on t=
he same line as the opening `/*`.
--

commit 1ef24f7e0744d3c963c7f542a86739e51e7b0b41
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: Add regression test for kfunc implicit arg injection with st=
ale register

This commit adds a selftest to verify that the BPF verifier correctly injec=
ts
the implicit bpf_prog_aux pointer for KF_IMPLICIT_ARGS kfuncs. It explicitly
contaminates the register mapping to the second argument with a magic value
to ensure the kernel overwrites it with the real pointer.

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c b/tools=
/testing/selftests/bpf/progs/struct_ops_assoc.c
> index 68842e3f936b9..dd322d43ff5e4 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> @@ -103,3 +103,43 @@ SEC(".struct_ops.link")
>  struct bpf_testmod_multi_st_ops st_ops_map_b =3D {
>  	.test_1 =3D (void *)test_1_b,
>  };
> +
> +/* Test for aux injection with stale register contamination.
> + *
> + * This test reproduces the scenario where the BPF verifier fails to

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem comment style? The guidelines require multi-line comments to have
the opening /* on its own line, rather than having text on the same line as
the opening marker.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601064611.8076=
37-1-chenyuan_fl@163.com?part=3D2
