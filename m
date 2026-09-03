Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63932B119
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444670; cv=none; b=b7SWzBMg48ppwUF/boDI2PZnxR+YFa+arEHYOYFeGwdMXTb9IIQmsMSF+I50PCsOk+QDgFrbsCrKgUFhmgxdu9JbPQqVk5KiZxF5GGLLjYmgsnMWz+4/AcZpkIlFw4Cjnond92rXOOo9oVvArxnM8D9WnyKA/Kj1dn/3g5nU4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444670; c=relaxed/simple;
	bh=swkh/YTay7Nehw+nE1g31mcbFhdHnZgxsDHaapYTjOA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SzwoX83iLvzISg5DCkkDm7Pd9ura3sCGHImM0UnOqHJygvv4NkceFLcIGCIkC1D7yN3ky69MAIPdHAGMt76kVXTl+L+87cRrLN85HQzTboNbczFfkzLfOheCLxBd25JpzPy1Pd7k1AVXw4VHacGgtI4TA2JkaIQAbJgaLMm0Lqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX5SwBEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX5SwBEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722411F00A3E;
	Thu,  3 Sep 2026 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788444658;
	bh=vq8FOBZc6X+sTUYCPEgNCC8y1fyRaSsmHJa/mOS/5KE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oX5SwBEjaMq/leD7R21moactbioedH0Bd77Ux2/Toeme/bdWlvDR71Y9VixR8lfgl
	 c+4TCNPnVhsyLLEGyH9Rdd8lVkszeKDIJrJnN5e02Tq0liFwDaZl8SKlaiDMzeKKmH
	 ae9clEWvHwlg7ZORUQ4mUJjT40pfQ99lZeHfA/6DQGLBBd20LgImXotnH93LLvvgt+
	 64WIrRqwBwXx6K7p8HK8no17eK/Lt45byQ2J7PHZpAc8FyXYlARW2xIHIDliL2Q1J1
	 eU2hbGeSSLMnVSI98xrIS4w55yUSQ6GRsfBqX5oMxK1DVXKqYui05xbSG2s0c/kyCG
	 yXPw+FhoWwjcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 8/8] selftests/bpf: add tests to validate
 KASAN on JIT programs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903-kasan-v9-8-2407fe99255a@bootlin.com>
References: <20260903-kasan-v9-0-2407fe99255a@bootlin.com>
 <20260903-kasan-v9-8-2407fe99255a@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 14:10:57 +0000
Message-Id: <20260903141058.722411F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Uninitialized stack variables in BPF programs cause the BPF veri=
fier to reject the programs unless compiled with auto-initialization.
--

commit 90ac04f2b17e345bd3d2714823f9bf8e9abd88df
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

selftests/bpf: add tests to validate KASAN on JIT programs
   =20
Add a basic KASAN test runner that loads and test-run programs that can
trigger memory management bugs. The test captures kernel logs and ensure
that the expected KASAN splat is emitted by searching for the
corresponding first lines in the report.

> diff --git a/tools/testing/selftests/bpf/progs/kasan.c b/tools/testing/se=
lftests/bpf/progs/kasan.c
> new file mode 100644
> index 0000000000000..fe8e0dd228a09
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kasan.c
> @@ -0,0 +1,502 @@
[ ... ]
> +SEC("tcx/ingress")
> +int st_on_stack(struct __sk_buff *skb)
> +{
> +	struct kasan_test_val val;
> +
> +	bpf_kfunc_kasan_poison(&val, sizeof(struct kasan_test_val));

[Severity: Medium]
Does this code cause a BPF verifier rejection? The BPF verifier requires
stack memory to be initialized before it is read. By passing the pointer
to val to bpf_kfunc_kasan_poison() when val is uninitialized, the verifier
will reject the program unless the kfunc argument is annotated to allow
uninitialized memory (or the toolchain automatically initializes stack
variables).

This exact pattern appears in all the _on_stack tests in this file (such as
stx_on_stack, ldx_on_stack, simple_atomic_on_stack, etc.). Should val be
initialized (for example, struct kasan_test_val val =3D {};)?

[ ... ]
> +SEC("tcx/ingress")
> +int ldx_oob(struct __sk_buff *skb)
> +{
> +	struct bpf_testmod_oob *val;
> +	struct kasan_test_val volatile tmp;
> +
> +	val =3D bpf_testmod_oob_alloc();
> +	if (!val)
> +		return 0;
> +
> +	switch (access_size) {
> +	case 1:
> +		tmp.data_1 =3D (__u8)val->redzone_1;
> +		break;
> +	case 2:
> +		tmp.data_2 =3D (__u16)val->redzone_2;
> +		break;
> +	case 4:
> +		tmp.data_4 =3D (__u32)val->redzone_4;
> +		break;
> +	case 8:
> +		tmp.data_8 =3D (__u64)val->redzone_8;
> +		break;
> +	}
> +	bpf_testmod_oob_free(val);
> +	return tmp.data_1;
> +}

[Severity: Medium]
Can tmp.data_1 be returned uninitialized here? If access_size !=3D 1,
tmp.data_1 is never written to during the switch statement, but it is read
on the return path. This will cause the BPF verifier to reject the program =
for
an invalid read from uninitialized stack memory.

Should tmp be initialized when declared?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-kasan-v9-0=
-2407fe99255a@bootlin.com?part=3D8
