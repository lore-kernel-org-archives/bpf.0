Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DF31D39A
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789884080; cv=none; b=sBvRGISf5IyuihEDMf2deCVlKk6YN1sAU7W+wpRGCD544UHyOn+6zgRa768mSxbvBEO2NPqXCaae0VEpQrs1FIUyWDswXiOMOJ1rwaG1Ph3GpjtArchOytjOKOyaOE2SNcEWl/gbhV/Sp/kSpU1JowKUDvs2IPmaWASQ9ZMAmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789884080; c=relaxed/simple;
	bh=ck6+cYlqBrqZX35hK1WbN/O66WCpUC7hKaW2ozBx0Kc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ny0wzWVp5GZg8R5/On5bJz0Kx14IBjtnjCicN0XgLFCHDiMpAcz0jpwsvxhx3xc80pxHTLXlwdHmGBlLr0wdgJpy4VG7hXDjsRBFtBxf730j3aonnfOrXDbVEhAlKqfwzf6V8jM8f6hE7ueg6Cd5uU3sCR69vqdgVJ1IYJPSxxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmYevJGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmYevJGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F911F000FF;
	Sun, 20 Sep 2026 06:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789884077;
	bh=H4V8KRQ1kcrkevoy87UZWBqzYN7yUHGgB5TcvCmsleU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gmYevJGjiOBQzk8094IVrTq2NJwtlz0IH1J/ZH0lhtzWsh9hxM8l6hPziniNugzwx
	 BpZY9VKm8Ol6tkO6KvafHgVFMC2T7EQWEDlMNVILUMRzTncyj/0qjXME8pJeO7jvZW
	 5bHExZRZbQbLz+ktMdzFdRlmI7ocny9eA2cnAWqUUppFI6g+cghDS+wWi0a/bQnUbf
	 ausopiN4u0pM6H+PHMgqMrcX91HdhduX517xB2EprMnhIlA78cXPtRhyWxEUDrUV6I
	 VsDJMI2G6ja2b7+92EnYgMjJF9egkm+tamWZEJqXZPv8yrXuChQcV/GwWzfLGZpdeT
	 gzIXJfVjb4aAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 19/20] selftests/bpf: Cover the exception
 cleanup shapes the chain does not reach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260920054403.874319-1-yonghong.song@linux.dev>
References: <20260920054225.864535-1-yonghong.song@linux.dev>
 <20260920054403.874319-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:01:17 +0000
Message-Id: <20260920060117.B1F911F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comments violate the modern BPF subsystem style
--

commit 31d63d33bfdfb4e044e29aa2e2717a6f909808c9
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Cover the exception cleanup shapes the chain does not reach

This commit adds tests to cover exception cleanup scenarios that the call
chain doesn't reach. It introduces new shapes like dead continuations, shar=
ed
callees, and throwing subprograms in BPF selftests.

> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c =
b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> --- a/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions_cleanup.c
[ ... ]
> +	/* A pad in the main program's own frame, not in a subprogram. */
> +	if (test__start_subtest("main_program_pad"))
> +		run_shape(skel, skel->progs.entry_main_pad, 101, THROW_COOKIE,
> +			  RAN_MAIN_PAD);
> +
> +	/* The same call site either way: the subprogram's throw unwinds into
> +	 * this frame and runs its pad, an extension's stops at its own boundar=
y.
> +	 */

[Severity: Low]
This isn't a bug, but does this comment in test_shapes() violate the modern
BPF subsystem multi-line comment style? The opening /* is preferred to be
on its own line.

> +	if (test__start_subtest("freplace_subprog_throws"))
> +		run_shape(skel, skel->progs.entry_freplace, 7, THROW_COOKIE,
> +			  RAN_FREPLACE);
> +	if (test__start_subtest("freplace_extension_throws"))
> +		test_freplace(skel);
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.=
c b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/exceptions_cleanup_shapes.c
[ ... ]
> +__u64 magic =3D 0x5eed;
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
This isn't a bug, but does this multi-line comment above sweep_frame() foll=
ow
the preferred BPF subsystem format? The opening /* should typically reside
on its own line.

> +static __used __naked __noinline __u64 sweep_frame(void)
> +{
[ ... ]
> +SEC("syscall")
> +int entry_sweep(void *ctx)
> +{
> +	return sweep_frame();
> +}
> +
> +/* 2. A callee called from both a covered and an uncovered site: the pad
> + * belongs to the call site, not the callee. Either site can throw, and =
the RCU
> + * lock between them is what an unwind out of the uncovered one leaks.
> + */

[Severity: Low]
This isn't a bug, but similarly, does this comment above shared_callee() ne=
ed
the opening /* placed on its own line to match the modern BPF comment style?

> +static __used __noinline __u64 shared_callee(__u64 x)
> +{
> +	if (x > 100)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920054225.8645=
35-1-yonghong.song@linux.dev?part=3D19
