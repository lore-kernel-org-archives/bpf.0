Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41295488755;
	Tue,  1 Sep 2026 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283693; cv=none; b=lr3pmc6BH4lf6gGV7/sDFM6TCiTlCffUtBAdUx+AIPBhnjXZLRiDl3pX7DOLFljAAa/BvpEc7UY+33ixS/YAqOTCN0VHhSxB6l6rI5Z8QxgfMQLuAvxdYnhxrVgc6MNwZ3zXgGj+9P8XaCF+9ldi7rDA4Euww79Fy1JW4IE78WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283693; c=relaxed/simple;
	bh=GMAaVd9EE5I3oSCG4zdW+kUa9NtXqaUYfKlEfBCzQMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fgqHNHV/p3/0lHDtzv2Fs7LsfTBjFsge56W5ZmdYTvbWlgZHVd+3N9YeEcqOMcl4PN2N7pCZyQkRc3dZJnrRXkKtMjs+XQCQULXRjJdWG+bgunJm88n4cEUzgJPgn0RcAcMSDGao4D+PHg9TrAnqSoVTHPHugkOGFV1wqqx9+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVgvkTQH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVgvkTQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7021F000E9;
	Tue,  1 Sep 2026 17:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283691;
	bh=znNTE4hej8Mjij8JsCEQmJw8vO+eIlDgEm+0/dv7+JQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mVgvkTQHBDKningC9gBpmmPeaMr4FqY1CJEen04+gKx5G9qpy6AQyTmGVZfTYcdUM
	 mznXSa/LpRDUEsklMPh3M3uF7GqEB3kbYygbw3kDd0T0Gg9S52wSXUxuaD/divs1Qw
	 UKiYT0klY6O+j9p0SoXsyDaNGT9Kc/tf3ly0lzZUCWn/MmzReEVunaT1mTTeGE2KZJ
	 YwvVE7nkhZrRstm3w87MXaXao9pvX2SyGgMNCDKgjgkYkE7RGZ1x1/2yuWILFaiSZc
	 Xk/j7s4VDdLWsmQEts8c9ObtPZgk3sin3kQetYw9eYm/6XdzrEFFHPCo1gUUBRqaMt
	 Sj3rlvfMCkfZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 18/18] selftests/bpf: Add a test verifying
 inline information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: linux-modules@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260901165757.801449-19-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-19-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:28:11 +0000
Message-Id: <20260901172811.AC7021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Parser desynchronization in module_get_base_addr() when reading =
trailing fields in /proc/modules.
- [Medium] Inverted logic in ASSERT_LT check causes early exit on test succ=
ess.
- [Medium] Unhandled error from btf__parse_split leads to invalid pointer d=
ereference.
- [Medium] Missing NULL pointer check after btf__type_by_id allows segmenta=
tion fault on malformed BTF.
--

commit 2cf9036457ef4f9129e585e625be7f2e1a33c7fa
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Add a test verifying inline information

This commit adds a selftest to verify inline information for an
__always_inline function in bpf_testmod. It checks that the LOCSEC
descriptor offset is within the expected bounds of the function.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_inline.c b/tools/=
testing/selftests/bpf/prog_tests/btf_inline.c
> index 0000000000000..8e0a85f6c6980
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_inline.c
[ ... ]
> +	inline_btf =3D btf__parse_split(BTF_SYSFS_DIR "/bpf_testmod" BTF_INLINE=
_SUFFIX,
> +				      btf);
> +	err =3D libbpf_get_error(inline_btf);
> +	/* pahole may not have inline BTF feature support. */
> +	if (err =3D=3D -ENOENT) {
> +		skip =3D true;
> +		goto out;
> +	}
> +	locsec_id =3D btf__find_by_name_kind(inline_btf, ".text", BTF_KIND_LOCS=
EC);

[Severity: Medium]
Does this code handle errors other than -ENOENT correctly?

If btf__parse_split() fails with an error like -ENOMEM, err will be extract=
ed,
but since it is not -ENOENT, execution continues and the unhandled ERR_PTR =
in
inline_btf is passed to btf__find_by_name_kind(), leading to a dereference =
of
an invalid pointer.

[ ... ]
> +	t =3D btf__type_by_id(inline_btf, l->loc_proto);
> +	if (!ASSERT_OK_PTR(t, "loc_proto_ptr"))
> +		goto out;
> +	if (!ASSERT_EQ(btf_vlen(t), 1, "loc_proto_one_param"))
> +		goto out;
> +	p =3D btf_loc_proto_params(t);
> +	t =3D btf__type_by_id(inline_btf, *p);
> +	lp =3D btf_loc_param(t);

[Severity: Medium]
Can this lead to a NULL pointer dereference on malformed BTF data?

Unlike the safe pattern used earlier with ASSERT_OK_PTR, the return value of
btf__type_by_id() is passed directly to btf_loc_param() and dereferenced via
lp->flags without a NULL check.

> +	if (!ASSERT_EQ(lp->flags, BTF_LOC_PARAM_REG, "param_is_reg"))
> +		goto out;
> +	if (!ASSERT_GT(l->offset, caller_addr, "inline_gt_caller"))
> +		goto out;
> +	/* simple sanity test to roughly ensure inline site still in function */
> +	if (ASSERT_LT(l->offset, caller_addr + 256, "inline_in_caller"))
> +		goto out;

[Severity: Medium]
Does this missing negation cause the test to exit early on success?

The ASSERT_LT macro evaluates to true when the check succeeds. Because the
condition lacks the negation ! used in all other assertions here, it will
execute the goto out branch when the sanity check passes.

> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
> index 679008b310d9a..bf4cb720e7b81 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
[ ... ]
> +long module_get_base_addr(const char *module)
> +{
> +	unsigned long long addr, base_addr =3D 0;
> +	char name[500];
> +	FILE *f;
> +
> +	f =3D fopen("/proc/modules", "r");
> +	if (!f)
> +		return 0;
> +
> +	while (fscanf(f, "%s %*s %*s %*s %*s 0x%llx", name, &addr) > 0) {

[Severity: Medium]
Can this parser become desynchronized if trailing fields are present in
/proc/modules?

The fscanf format string expects exactly 6 tokens and lacks a way to consume
the remainder of the line. Out-of-tree modules natively produce a 7th token
(such as the (O) taint flag).=20

When this happens, the trailing token is not consumed and the next loop
iteration will mistakenly read it as the name, breaking the parsing structu=
re
for all subsequent lines.

> +		if (strcmp(module, name) =3D=3D 0) {
> +			base_addr =3D addr;
> +			break;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165757.8014=
49-1-alan.maguire@oracle.com?part=3D18
