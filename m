Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA843A8735
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786750040; cv=none; b=B2izgHeiwyApXg1lRx5HOReIuy3bSlRsKGHpjB/6n0lCJe0Fm1CKqrq1qGv3eMNPFapHOX/TiHD5kDLi3aDY8aJVu5OaEqCU72zs0VP3JGriaZedbtnQ2ndHrDxKuXKMcYWTMMlX/LuzSyuM3QoKv7lYYFqgzD9S8cLh4aWUmqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786750040; c=relaxed/simple;
	bh=QNA26Kn6uoCaz0u6AZZHSiwVuhbZV7OMK2Qo2mDlgOs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gDEDnQPBoLwJbbkWhzVMH/qvpQqZAQlNiHV9VBiUe3GduKUIPTlzj4eqRd1DSqGn+Nz8chAFmxPIA4U46VHkvlO3FlXAbkf/MMqlOZB6M761KFvQjyQ0smKY9jtNbj1oRSndme1IeRrgSOjnevtwa9sxRoSdGqw4OLUsJclh6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuEzCANX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuEzCANX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064EC1F000E9;
	Fri, 14 Aug 2026 23:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786750039;
	bh=luipzvt+l5FypzpQvZs7UxWQ3hRYQhv7tuAaq7TmEkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BuEzCANXvEAG5ZEWk2N5D/BkXJj6F/nbchNJguBGNgteh6HAdpA0UDog+NTDBhH+y
	 YILvKvr4kWOSTlKPoabFlSHeIc/6WPLBOBsVEpEr6QQaWEIbbC80by5FlWHEflgDvY
	 368GNRw0OpM9zNnTNlK/VV7nLpWoaoeADo58+L98JmN8+zrJtEfvu6QPbYrrOahnf6
	 WY5Lkcxm2H50uOFDb2WAz3ytxOx9SUoEZDBxVmfD5WJN+BQw+XwMXEu/Ayzwu4EGbU
	 fUv4AyzQnikolq4G21yrtLe113UBtSpt1NHuPNSNuzlec1HZrQf2yl4I6y+J4fTyxw
	 tUtKPL2iVXxZw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next 6/6] selftests/bpf: cover 32-bit sign-extension
 low-32 links
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814231945.3884596-7-vineet.gupta@linux.dev>
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
 <20260814231945.3884596-7-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:27:18 +0000
Message-Id: <20260814232719.064EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The failure tests `sext_dest_driven_does_not_narrow_base` and `z=
ext_dest_driven_does_not_narrow_base` contain backwards branch conditions, =
making them unconditionally pass regardless of whether the verifier bug is =
present.
--

--- Patch [6]: [RFC bpf-next 6/6] selftests/bpf: cover 32-bit sign-extensio=
n low-32 links ---
commit f8b3195655d59866de20fa031cd9d9e1bbfbde94
Author: Vineet Gupta <vineet.gupta@linux.dev>
Subject: selftests/bpf: cover 32-bit sign-extension low-32 links

This commit adds selftests for the BPF_FLAG_SUBREG_SEXT link in the BPF
verifier. The tests verify various sign-extension behaviors, including
deduction through links, zero-extension interaction, and in-loop behavior.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c =
b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> index 2cc6f9e45aff3..ff71e168d4cc4 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c

[ ... ]

> @@ -826,4 +826,416 @@ l_out_%=3D:							\
>  	: __clobber_all);
>  }
> =20

[ ... ]

> +SEC("socket")
> +__failure __msg("div by zero")
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__naked void sext_dest_driven_does_not_narrow_base(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 =3D r0;		/* r6 low =3D unknown u32 */	\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<=3D 32;						\
> +	r6 |=3D r0;		/* r6 =3D full 64-bit unknown (base) */ \
> +	r7 =3D (s32)r6;		/* low-32 SEXT link */		\
> +	if r7 !=3D 0 goto l_out_%=3D;/* r7 =3D=3D 0: low 32 bits are 0 */ \
> +	if r6 !=3D 0 goto l_out_%=3D;/* r6 may still have high bits set */ \
> +	r0 /=3D 0;		/* must stay reachable */	\
> +l_out_%=3D:							\
> +	r0 =3D 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

[Severity: Medium]
Are these branch conditions backward for a __failure test that expects a
"div by zero" rejection?

Since the test expects the division to be reachable for rejection, if the
buggy verifier deduces r6 =3D=3D 0, "if r6 !=3D 0 goto l_out_%=3D" will eva=
luate as
false and fall through to the division by zero, causing a rejection and
making the test pass.

If the verifier is correct, the fall-through is also reachable, causing a
rejection and passing the test.

Does this mean the test passes unconditionally regardless of whether the
verifier bug is present, causing a regression in test coverage?

Should this check instead be "if r6 =3D=3D 0 goto l_out_%=3D"? This way, if=
 the
verifier makes the buggy deduction that r6 =3D=3D 0, it takes the branch and
the div becomes unreachable, allowing the verifier to accept the program and
fail the test as intended.

It looks like the identical condition also exists in the pre-existing
zext_dest_driven_does_not_narrow_base() test just above this:

	w7 =3D w6;		/* low-32 ZEXT link */		\
	if r7 !=3D 0 goto l_out_%=3D;/* r7 =3D=3D 0: low 32 bits are 0 */ \
	if r6 !=3D 0 goto l_out_%=3D;/* r6 may still have high bits set */ \
	r0 /=3D 0;		/* must stay reachable */	\

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814231945.3884=
596-1-vineet.gupta@linux.dev?part=3D6
