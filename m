Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0794F68B4
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025552; cv=none; b=rM7tm3U8kO2q83EROtb1whBVVmHAZlqw9H373Gsr45qc0+sCO1VZLQGANYA/0IkaAPjXQIzPpOE/lJSYBweWHsTjkiKDs78gAYt8K4rwpxXpzvzgytOuWZP8CiiikcwseKv5192UJZAnNY53ZUPZDyxdeJvz0me7Yttv6h7jvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025552; c=relaxed/simple;
	bh=at6OIysGD0/Qt3e1cVybOe54hJUqSMkO+W5LA0zSIQ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=okbnptBNwRjj05wl1HYWzvMR4Qa7y/wXLg942lFtmyXZGeLHB3/uRuvKcCQ31Gw0nex9zooB1yHbC5gfY9/Mt+o1jA+1Y0gK5dHCeHxztknMx/JA0Vi/lmBGvdL/jMoYAtxtMYlTox1G/fHE2/78EdRHV43IcZq3KOXT7bIqwX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8g5UJPA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8g5UJPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909871F000FF;
	Mon, 21 Sep 2026 21:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790025550;
	bh=EqC84pLw5xHmTmuiEdmDX4RiPDrbUvbZettaVsk8SYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i8g5UJPARNuoXzMFWuF/Pg15FEZLJQkNt1LBC5t/eamaaYSx6ByC/FTY9X78LN9g7
	 o0gmKwfTHN8zZykjQAeLaZmrxRGBM6d1jj1bDib5HQJ0G7sdh27vsrQ2fSVh+RHLtd
	 Siyx+9XiqmYh/9IIA2hLJJUbqXe1daBphEe/UQ1L1v3UI04PgiKnpjuSnDgi12c26l
	 03l8Fclq4JjrDT90nQ489hTuBmYLPKjMH0Bw1NDmMmlHuAY2TZSW/NyMN6nTLHTanN
	 otpFNzG+Kxszr7zgWLT48WcyyryQT5OzDJgP4WzSAn8WgVJ3lfApHraDh8XXYlmPid
	 gMt/JNEkCcjnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 19/20] selftests/bpf: Cover the exception
 cleanup shapes the chain does not reach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921210210.1725985-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210210.1725985-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 21:19:10 +0000
Message-Id: <20260921211910.909871F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comments do not follow mandatory style
--

commit 0b5284880fa55ebb7577505990c5eb80e76e625a
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Cover the exception cleanup shapes the chain does not reach

This commit adds end-to-end tests for exception cleanup shapes that the main
call chain does not reach. It introduces various edge cases in new BPF
programs and verifies their exception handling and cleanup behaviors.

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> index c932da7cbec16..2825dbb53b1c6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
[ ... ]
> @@ -36,6 +40,346 @@ static void run(struct exceptions_cleanup *skel, __u6=
4 input, __u32 retval,
[ ... ]
> +	/* The same call site either way: the subprogram's throw unwinds into
> +	 * this frame and runs its pad, an extension's stops at its own boundar=
y.
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the required styl=
e?
The BPF subsystem guidelines strictly require that multi-line comments must
have the opening /* on its own line, with the comment text starting on the
next line.

> +	if (test__start_subtest("freplace_subprog_throws"))
> +		run_shape(skel, skel->progs.entry_freplace, 7, THROW_COOKIE,
> +			  RAN_FREPLACE);
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.=
c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> new file mode 100644
> index 0000000000000..5e8ca799d9d2a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> @@ -0,0 +1,982 @@
[ ... ]
> +__u64 pads_ran =3D 0;
> +__u64 pad_runs =3D 0;
> +
> +/* 1. Everything a cleanup table leaves dead: a throw's continuation, th=
e tail
> + * after a resume with an ld_imm64 and a branch in it, and the block onl=
y that
> + * continuation reaches.
> + */

[Severity: Low]
This isn't a bug either, but here is another instance where the multi-line
comment rule is violated ahead of sweep_frame(). Could we update these to
have the opening /* on its own line?

> +static __used __naked __noinline __u64 sweep_frame(void)
> +{

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921210033.1715=
000-1-yonghong.song@linux.dev?part=3D19
