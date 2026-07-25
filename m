Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DD32472A2
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784986391; cv=none; b=Kx4WqpVtILfXhUBrwgpbuP9lOtSAAblqGOmNtnZN7qMoI+TV0CcITfgISZ+Vgaz/7B3GrbbBawT5DeVLbrLD2kxIvdsTcqRxVzVY0MBz0//KSx2OIkWdUZjdXnSjHvSmsB6qmbYP5+wcTe4V4DjwTEtt/F8da3As5O+9+1P2kHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784986391; c=relaxed/simple;
	bh=Bc3cTnxaGLzeKs/A72dFXkvvTh8KhqS5P5MFpU2Lp1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cAjtify9SUkqs5VNerG8nKEzEyIXOf0EbeZkTTafOS/hAFeetW3GTbk583RXVlvBCNkKkjzlz5jf7u3EUhJRQnylJMYTvIMi+Ca5XR81hf1rT+HTTv9HPZIBa6R56b2bfRMEE/QP8aHzLKncWoiJ9CIw7VnLH1TxPY4C9VKazDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aub3ZTp8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aub3ZTp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66B31F00A3A;
	Sat, 25 Jul 2026 13:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784986389;
	bh=NS/79ZLEVqJz6M237iPrd8X0EANF2TL8jF++lWT06eA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aub3ZTp8ptdqKHrcXaZTXf9eS3wucnMNtiUvk1h0aeo4xa7iLLes82+KmBCqdqbQl
	 JA/+z1zfZA2rsPk67uf6Hu1GPg6MuuqBozmjg4nu44GpmajXsjsGszPDizI1vT0uZ/
	 aspq+DMyCmfwgtlEeAhehaYlrmykpju97epL4cy+zwYw0ZvyE4q1N3/kn/U+DrF/ry
	 p1b9lSwJR+EDIHbFlBAFjE7ofQluCNetztS6w8ZnarmyUgNPkOZ0pP4PracNZVxq4L
	 z+464nify33qcsR8z3w60DILtGPVce1MBTW2KcZFskKEZY9GupIpHnyIQKz+8N+ML9
	 4M3kTAtMP32oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Verify rejection of
 sleepable tracing prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260725132624.78373-3-leon.hwang@linux.dev>
References: <20260725132624.78373-1-leon.hwang@linux.dev>
 <20260725132624.78373-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 13:33:09 +0000
Message-Id: <20260725133309.B66B31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test contains dead code after the expected failure of `fentr=
y_sleepable__load()`. If this code executes on an unfixed kernel, it intent=
ionally triggers a kernel BUG and crashes the test environment.
--

--- Patch [2]: [PATCH bpf-next v2 2/2] selftests/bpf: Verify rejection of s=
leepable tracing prog ---
commit 44292a230f0467503b72b0ecb8c6c25244de310b
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Verify rejection of sleepable tracing prog

This commit adds a selftest to verify that a sleepable tracing program
cannot attach to a '__x64_sys' prefix program target. The test attempts
to load the program and expects the load to fail, avoiding a kernel BUG
on unpatched kernels.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
[ ... ]
> @@ -576,6 +577,60 @@ static void test_func_replace_progmap(void)
[ ... ]
> +static void test_sleepable_fentry_to_xdp(void)
> +{
[ ... ]
> +	err =3D fentry_sleepable__load(skel);
> +	ASSERT_ERR(err, "fentry_sleepable__load");
> +	if (err)
> +		goto out;
> +
> +	skel->links.fentry_xdp =3D bpf_program__attach_trace(skel->progs.fentry=
_xdp);
> +	if (!ASSERT_OK_PTR(skel->links.fentry_xdp, "bpf_program__attach_trace"))
> +		goto out;
> +
> +	skel_xdp->links.__x64_sys_nop =3D bpf_program__attach_xdp(skel_xdp->pro=
gs.__x64_sys_nop,
> +								ifindex);
> +	if (!ASSERT_OK_PTR(skel_xdp->links.__x64_sys_nop, "bpf_program__attach_=
xdp"))
> +		goto out;
> +
> +	err =3D system("ping -q -c 1 -W 1 127.0.0.1 > /dev/null");
> +	ASSERT_OK(err, "ping");
> +	ASSERT_ERR(skel->bss->retval, "retval");
> +
> +out:
> +	fentry_sleepable__destroy(skel);
> +	xdp_dummy__destroy(skel_xdp);
> +}

[Severity: Medium]
Since the test expects fentry_sleepable__load() to fail (meaning err < 0),
won't the "if (err) goto out;" statement cause the test to immediately bran=
ch
to out?

If this code behaves as expected, it appears all the subsequent logic for
bpf_program__attach_trace(), bpf_program__attach_xdp(), and the ping command
becomes unreachable dead code.

Conversely, if the test runs on an unpatched kernel where the load
unexpectedly succeeds (err =3D=3D 0), the test would fall through to the at=
tach
and ping logic. Could executing this sequence on an unpatched kernel trigger
the exact kernel BUG mentioned in the commit message, potentially crashing
the test environment instead of gracefully failing the test?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725132624.7837=
3-1-leon.hwang@linux.dev?part=3D2
