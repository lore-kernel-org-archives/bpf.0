Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066141B373
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597980; cv=none; b=fxe2WrnJnZK/5nxxxM3vrk6QYSXPAdzORx/nEY7eJd80WJS3PlwEzJbDEUjNBAt5DFx7WclLYbELfRpN6wlXwN7esBx7JCQb4y61sVqoj7ayQKD+N+U8di7V6F1MhRf7oGHEQt54Ki80tHEcHfjI/nG8LLaKHJUoPJV1C/SMbQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597980; c=relaxed/simple;
	bh=Pn0btTyVukLJPY1HLKSkGLPCx855CzqBDB8la+Wtdyk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=afqlcLmM57wQ3MWJDUP9oCAQaQyoqf/x5HlB3sKIXdyvpuADSrkfPtO0CJIvi4/aT7cewJUKgejM1DpZrg4Uxbo9UELbcJxkXsVYXZ0q9Uu/p+qzgELnsE1o9SBjXMU3xjRctAZg9p/LevnmYCxbcfF4lkNWRaJzmZ8TbpjQHSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH7733MF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH7733MF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4A51F000E9;
	Thu,  9 Jul 2026 11:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783597977;
	bh=Tij7oURqpceKi87KGMOmn7OIlQkonBX4c1F4Mxern4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lH7733MFFOnz3yLVW2/OWphELl0V/4d00o8+WEk/CyRXNvOmiMkoPZFa/fZOOp+Ro
	 1zH9MdT4gH8dOpUzn5S86aH+LOeFVkhgyo+wGNrGVg3w2MtJidx73mDVEOAWyfgKaI
	 8yk87QBZH3ShH8PkVQG/hXfAwekFJs49UQOtgOLtEeBJAK9raWY7zfp5gfQ4+VwrcX
	 c7QF/GPxO+1SwGMudgsgNq1EzdffpN1CGZyx7XaSG7nlmPvHN1hn8MpCgFiy91HE1p
	 IO4yaN1vHQCCOz2X6Lnfrxjt9cQKSufAANsPrh1f2uIcBtQH+9iZ9cOmVapt9m8boA
	 pdfCWiPwGFtRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 10/10] selftests/bpf: add tests to validate
 KASAN on JIT programs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709-kasan-v5-10-1c64af8e4e1e@bootlin.com>
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-10-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:52:56 +0000
Message-Id: <20260709115256.EE4A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Infinite loop in `read_kernel_logs` if `read()` returns 0.
--

--- Patch [10]: [PATCH bpf-next v5 10/10] selftests/bpf: add tests to valid=
ate KASAN on JIT programs ---
commit f689181d893dcf7bbac97d28845dc342a1fe71e5
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

selftests/bpf: add tests to validate KASAN on JIT programs

This commit adds a basic KASAN test runner that loads and runs BPF programs
designed to trigger memory management bugs. The tests capture kernel logs to
verify that the expected KASAN splats are emitted, ensuring the JIT compiler
has correctly inserted KASAN instrumentation.

> diff --git a/tools/testing/selftests/bpf/prog_tests/kasan.c b/tools/testi=
ng/selftests/bpf/prog_tests/kasan.c
> new file mode 100644
> index 0000000000000..2bc545e962595
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kasan.c
> @@ -0,0 +1,430 @@
[ ... ]
> +static int read_kernel_logs(int fd, char *buf, size_t max_len)
> +{
> +	size_t total =3D 0;
> +	ssize_t n;
> +
> +	buf[0] =3D '\0';
> +	while (1) {
> +		char *msg, *eol;
> +		size_t len;
> +
> +		n =3D read(fd, record, sizeof(record) - 1);
> +		if (n < 0) {
> +			if (errno =3D=3D EAGAIN)
> +				break;
> +			return n;
> +		}
> +		record[n] =3D '\0';
> +
> +		/*
> +		 * Each kmsg record starts with some metadata, separated
> +		 * from the actual content by a semi-colon
> +		 */
> +		msg =3D strchr(record, ';');
> +		if (!msg)
> +			continue;

[Severity: Low]
Will this loop indefinitely if read() returns 0?=20

If n =3D=3D 0, record is null-terminated at index 0, making strchr() return=
 NULL.
The continue statement then restarts the loop, causing read() to be called
again. While /dev/kmsg typically returns -EAGAIN when no data is available,
should an unexpected 0 return from read() be explicitly handled to prevent a
potential infinite loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-kasan-v5-0=
-1c64af8e4e1e@bootlin.com?part=3D10
