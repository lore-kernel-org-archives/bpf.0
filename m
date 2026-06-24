Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758C84039
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782263092; cv=none; b=XvCPY7UXgk68zmtPVdh8mjfE6dEi4X/Bhb8BohY3ngA5myCLBKFz//dzX5w2QN2oTqFfMPNklFmILo3fcmPXin+uj/mWprGEqyF005k1csLq1pHx9eQhLMpDAGQNLsE6RmSuJo+GWon80K01mdV0wdWMmbT7G0Lm2vgzI72/i+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782263092; c=relaxed/simple;
	bh=084OPcogX4s7XF5EctdpNmnoVHnFycbaYjrHa3aldvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ew7spKvI4vhrHgV7BZllrGacTc4hcF+n73UrcJSaucfEw662S+uJ4qj8hiGBmm8dHfrtikyH0g521rB7qdC7Qg4JOFVpIgGe8rUxOyxIwGtB3GyXZEu3Qa7WJfN6hLVOce80opd2r/hb/l/Idui5F/OYTcWWgzqYAFqi40sIXcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZntuRsNF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZntuRsNF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2031E1F000E9;
	Wed, 24 Jun 2026 01:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782263091;
	bh=5pHmy4EkLkY6VrvAVXs4kRdrFrlYkpBO8jCGCVZrmPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZntuRsNF5FNNfA1UjxtoA6e4FLuL4RZichLg6ua46nNroVQVLEG7Pyxl9SxEaa9FM
	 ja7hfmw62mGj7P6mcArD39dfCuPg/wrQgf77AVNLRv+Iuv9AAOogQlSFVJJvA5ahgh
	 kTVvEWYn7dyLg7uo93kq3wIuR99NmG9tH+fwCXvsJfx41Qu7oKgS2fVaPhmvv1wwbF
	 dgRPJ2juHETUv/8oQG18LNyh4TZas2COWl8Ksv2U6b+7esZIrT4AHbRMUEZWXNd6Bc
	 aDbOIeEVEOPRz2ap33Pt7E7K6m/jrkJs/hVqlrogij03jVGWZPsUKZTNIAsRkZHHaN
	 C4sHVvD6s5N4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add kfunc set test to
 resolve_btfids
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260624005546.1818483-5-ihor.solodrai@linux.dev>
References: <20260624005546.1818483-1-ihor.solodrai@linux.dev>
 <20260624005546.1818483-5-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 01:04:50 +0000
Message-Id: <20260624010451.2031E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Failure of the `ASSERT_EQ` check on `set->cnt` does not halt exe=
cution, leading to an out-of-bounds array read in the subsequent loop in `c=
heck_kfunc_set()`.
--

commit 9cd3f00b88448034723a89667e181cfaf756806b
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

selftests/bpf: Add kfunc set test to resolve_btfids

This commit extends the resolve_btfids selftest to cover kfunc sets defined
with BTF_KFUNCS_START and BTF_KFUNCS_END. It verifies that resolve_btfids
correctly processes BTF_ID_FLAGS, resolves function IDs, and ensures the
kfunc set is sorted.

> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/to=
ols/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index 98ce8fca2007e..ac51fd4548214 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
[ ... ]
> @@ -122,6 +159,31 @@ static int resolve_symbols(struct btf *btf)
>  	return 0;
>  }
> =20
> +static void check_kfunc_set(struct btf_id_set8 *set)
> +{
> +	unsigned int i, j;
> +
> +	ASSERT_EQ(set->flags, BTF_SET8_KFUNCS, "kfunc_set_flags");
> +	ASSERT_EQ(set->cnt, ARRAY_SIZE(kfunc_symbols), "kfunc_set_cnt");
> +

[Severity: Medium]
In the modern BPF selftests framework, ASSERT_EQ() evaluates to a boolean
and logs a failure but does not automatically return from the function.

If the resolve_btfids tool has a bug and sets an unexpectedly large value
for set->cnt, the assertion will fail, but execution unconditionally procee=
ds
to the loop.

Could this cause the test to iterate past the actual bounds of the array,
reading out of bounds from set->pairs[i] and crashing with a segmentation
fault? Would it be safer to wrap this check in an early return, such as
if (!ASSERT_EQ(...)) return; ?

> +	for (i =3D 0; i < set->cnt; i++) {
> +		for (j =3D 0; j < ARRAY_SIZE(kfunc_symbols); j++) {
> +			if (kfunc_symbols[j].id =3D=3D (s32)set->pairs[i].id) {
> +				ASSERT_EQ(set->pairs[i].flags,
> +					  kfunc_symbols[j].flags, "kfunc_flags_check");
> +				break;
> +			}
> +		}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624005546.1818=
483-1-ihor.solodrai@linux.dev?part=3D4
