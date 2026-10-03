Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C513769F8;
	Sat,  3 Oct 2026 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057269; cv=none; b=pkkur3qIdX8XrY6ZcDDHEuls+dB8qz91T42mJw2WGJ9UQ189TNYXTE1jfLM/OYPyDnXZraEFwkIk6BIzlh8V8i5u6ymNQmJR71MpNGMbYhsEgTFe4VY/qqqQeQM8+5RlDNXV5f5KFvsAGifcqKq3i10qtkWt/ieXLVRQIB4VDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057269; c=relaxed/simple;
	bh=V4SwhJHXzfhfJvvSAd0Pl/jGIkyug/L/aevedDZDD7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nS7cyRxLgj5lb3hiwNWBmz8xS1CBdVH88B/OT2MdYTNG8SAbAyOOVMu1iYjCifVEkgj52bEeL/q7sJR5lBhOZJD6NRUlJz5uzEZkn8sqm5VoucU9di7cwiMTwV4HKx4DkyYGSXijsDJ5/gdgi75BHa3UDoiG/eshfd+c7Ouvurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OClql/Fj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OClql/Fj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25CA1F0089C;
	Sat,  3 Oct 2026 19:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791057268;
	bh=GcmQLXxD9vfx5jW+DIi0yKxI72Kjkr+6amm+3x2+Vj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OClql/Fj/5yna9wZTXyg9Qvm4Kmx01ZMLrqfKjakmv8R5b3QsNKhdyl2MLkr5/9Gv
	 EHvsLjpBtzhxZbGKD46J530GZukAkd+cEKpc8tyV3d+QARWc8vg/8kVRr4vb7ntg3t
	 J2Rec1Bxo+V/HGTYXxuQLZKsWEEibDlkfsR9CxJZq09bXA+/ZP0aPrK/6qY8IBJupY
	 ZsPwuvO/DLvWAq2dFD0rm5mEt6wkALBdg8kkYR3zWQuPWC2ch2++oZRmv/1P8ccBY3
	 J3sR46PwgsEnfLgLwhRKuL0WFRkh92meg1igew6OKgyIyTMjjTkJ4ZiScw1RJvgLgU
	 xLZczpsK+iT8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 7/7] selftests/bpf: Add a test verifying
 inline information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: linux-modules@vger.kernel.org, "Petr Pavlu" <petr.pavlu@suse.com>, bpf@vger.kernel.org
In-Reply-To: <20261003194323.817885-8-alan.maguire@oracle.com>
References: <20261003194323.817885-1-alan.maguire@oracle.com>
 <20261003194323.817885-8-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 19:54:27 +0000
Message-Id: <20261003195427.E25CA1F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] bpf: null pointer dereference in test_btf_inline() on error path
- [Medium] bpf: invalid pointer dereference in test_btf_inline() due to mis=
sing NULL check
- [Medium] bpf: uninitialized variable usage in module_get_base_addr()
- [Low] bpf: inverted assertion logic in test_btf_inline() breaks failure-a=
bort pattern
--

commit 0f45ec42b3956956fce6d91dc0397c28034b638d
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Add a test verifying inline information

This commit adds a selftest for bpf_testmod to verify that inline informati=
on
is correctly generated and matches expectations for an always-inline functi=
on.
It validates the LOCSEC descriptor offset and skips the test if pahole does
not encode inline information.

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_inline.c b/tools/=
testing/selftests/bpf/prog_tests/btf_inline.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_inline.c
[ ... ]
> +void test_btf_inline(void)
> +{
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
> +	locsec_id =3D btf__find_by_name_kind(inline_btf, "inline.text", BTF_KIN=
D_LOCSEC);

[Severity: Medium]
What happens if btf__parse_split() fails with an error other than -ENOENT,
such as -ENOMEM?

If inline_btf is an error pointer or NULL, the condition checking for -ENOE=
NT
evaluates to false, and the invalid inline_btf pointer is passed directly to
btf__find_by_name_kind().

Can this cause a null pointer dereference when libbpf attempts to access the
BTF struct?

[ ... ]
> +	t =3D btf__type_by_id(inline_btf, l->loc_proto);
> +	if (!ASSERT_OK_PTR(t, "loc_proto_ptr"))
> +		goto out;
> +	if (!ASSERT_EQ(btf_vlen(t), 1, "loc_proto_one_param"))
> +		goto out;
> +	p =3D btf_loc_proto_params(t);
> +	t =3D btf__type_by_id(inline_btf, *p);
> +	lp =3D btf_loc_param(t);
> +	if (!ASSERT_EQ(lp->flags, BTF_LOC_PARAM_REG, "param_is_reg"))

[Severity: Medium]
Does the second call to btf__type_by_id() require a check to ensure 't' is
not NULL before calculating the location param?

If *p is an invalid type ID, t would be NULL, and passing it to
btf_loc_param() calculates an offset from a NULL pointer. Could this cause a
segmentation fault when lp->flags is accessed?

> +		goto out;
> +	if (!ASSERT_GT(l->offset, caller_addr, "inline_gt_caller"))
> +		goto out;
> +	/* simple sanity test to roughly ensure inline site still in function */
> +	if (ASSERT_LT(l->offset, caller_addr + 256, "inline_in_caller"))
> +		goto out;

[Severity: Low]
Is the logic inverted on this ASSERT_LT() check?

The other assertions use the ! operator to jump to 'out' on failure. Because
ASSERT_LT() returns true when the check succeeds, it looks like this will j=
ump
to 'out' on success instead of on failure. While this might be benign right
now as the last statement, will it bypass any future checks appended here?


> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
[ ... ]
> +long module_get_base_addr(const char *module)
> +{
[ ... ]
> +	while (fscanf(f, "%s %*s %*s %*s %*s 0x%llx", name, &addr) > 0) {
> +		if (strcmp(module, name) =3D=3D 0) {
> +			base_addr =3D addr;
> +			break;
> +		}
> +	}

[Severity: Medium]
Can fscanf() return 1 if it successfully parses the module name but fails to
parse the address field?

If the line format in /proc/modules is unexpected or malformed, and fscanf()
returns 1, the check > 0 will pass, but the addr variable will remain
uninitialized. If the module name matches, could this return uninitialized
stack memory as the base address? Would it be safer to check that fscanf
returns exactly 2?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003194323.8178=
85-1-alan.maguire@oracle.com?part=3D7
