Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE413264FB
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786217249; cv=none; b=e6r0rclyVmP9neVXAX72pqa+nI/WVV6MX6QeYBjBMAdvzuJJCDmUPeQNfp28lYdV2XkQiGJ3lLPWxycoSPLUoKc3UXdsC5yIjw9yLTfkwDPvBB6a+7kmPugNroGvkiM7Dlw/BXRrjJUvC3Qf10WP+72jtGd4ZS/FsJuEdXsyblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786217249; c=relaxed/simple;
	bh=XdaOwE3AlKXvEmlu3RCZ/Q9n8J/ph0S3x2OPcKa94Us=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cEkIoSGx46PPmbn+/qOgkRevbmni4CTKnxlKv62+HjCkqk/3/7Cj6+BuZfUa3zR6DEeL2wFk/ITDFwE4Icjbifl9gydt2N4R4mLMKaw8BKcxxQS9skEiCWYcBNNVZB5Mx92pWTGORbLuTnNOy6mEz8HgbHz1J2kLmc+wDmTYDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkbnfKxa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkbnfKxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB0E1F000E9;
	Sat,  8 Aug 2026 19:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786217247;
	bh=W+ocuT3PCQTSxyreHM4GX83Ib+V2ZP9MFiv82y0oOpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bkbnfKxar4LmizPJHNDaYIUTdyS07KyDtAkkkXNnCntSyeQ3RftAkiYQ+VnXUQiDY
	 7GoWpPNFSBJuK4wjChiYPf17sGWRJdkXj4UIbx4TNJuWU+svSxYsHq1OwqiXy0eFup
	 3RuQ5L4qmt/k+YtdAFQu4Kj9nsxnSmBpsFM7mlt/EH2x/xsyv0wcW36EvBRA196czK
	 MAXe8AgTEZpe2g2TxH2QxFZ2aj2kgU25+7+QAUtvUKIGMwiPlHoDXHRmbaYP9GOBkI
	 54KChE9Pesz/R4cQBduh4nxCPmHg9MxtfVA9j/jui87JT/1vEyq9Aqrn+4UH1urk95
	 KtJnbxnyvErEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 10/13] selftests/bpf: Add C tests for
 16-byte returns in R0:R2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260808190413.1902293-1-yonghong.song@linux.dev>
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
 <20260808190413.1902293-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 19:27:26 +0000
Message-Id: <20260808192726.EBB0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `aggregate_ret_kfunc_c` test will fail to load instead of gr=
acefully skipping on 32-bit kernels when compiled with LLVM >=3D 23, due to=
 a mismatch in `__SIZEOF_INT128__` definitions causing a ksym resolution fa=
ilure.
--

--- Patch [10]: [PATCH bpf-next v3 10/13] selftests/bpf: Add C tests for 16=
-byte returns in R0:R2 ---
commit 34be80f3aa8159c8e9fb57e485947ec4dc335cca
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add C tests for 16-byte returns in R0:R2

This commit adds selftests that exercise a 16-byte return value passed in t=
he
R0:R2 register pair. It covers __int128, 16-byte struct, and 16-byte union
returns. It also adds tests for __int128 and 16-byte struct returns from a
kfunc, with bpf_kfunc_call_test_i128() guarded by __SIZEOF_INT128__.

> diff --git a/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c b/too=
ls/testing/selftests/bpf/prog_tests/aggregate_ret.c
> new file mode 100644
> index 0000000000000..e4317399d711b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/aggregate_ret.c

[ ... ]

> +static void test_kfunc_c(void)
> +{
> +	struct aggregate_ret_kfunc_c *skel;
> +	bool supported;
> +	int err;
> +
> +	skel =3D aggregate_ret_kfunc_c__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_kfunc_c_open"))
> +		return;
> +
> +	supported =3D skel->rodata->has_reg_pair_ret;
> +
> +	/*
> +	 * Where the JIT cannot hand the second half of a >8-byte kfunc return
> +	 * back in R0:R2, bpf_add_kfunc_call() rejects the call with
> +	 * -EOPNOTSUPP. Asking the kernel keeps this test free of a list of the
> +	 * JITs that can, which would have to be updated as the rest of them
> +	 * learn.
> +	 */
> +	err =3D aggregate_ret_kfunc_c__load(skel);
> +	if (err =3D=3D -EOPNOTSUPP)
> +		supported =3D false;
> +	else if (!ASSERT_OK(err, "skel_kfunc_c_load"))
> +		goto out;

[Severity: Medium]
Will this load fail with an assertion error instead of gracefully skipping =
on
32-bit kernels when compiled with LLVM >=3D 23?

If the host kernel is 32-bit, bpf_testmod is built without __SIZEOF_INT128_=
_,
omitting bpf_kfunc_call_test_i128 from the module BTF.

However, because the BPF program aggregate_ret_kfunc_c.c is compiled for a
64-bit BPF target, __SIZEOF_INT128__ will be defined, and it will
unconditionally reference the bpf_kfunc_call_test_i128 kfunc via the
bpf_testmod_kfunc.h header.

During aggregate_ret_kfunc_c__load(), libbpf will attempt to resolve the
kfunc, but since it is missing from the 32-bit kernel's BTF, it will fail a=
nd
return a relocation error (such as -ENOENT) rather than -EOPNOTSUPP. This
would cause the ASSERT_OK(err) check to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808190322.1896=
580-1-yonghong.song@linux.dev?part=3D10
