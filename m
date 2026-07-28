Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F373BFAEB
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253596; cv=none; b=gTu1gSHDPrOoszkx2NNc4CH4WBAUAg/CQvlALW+1VM5GcPn5nXcXM/FJpnUealU1kXX3N/eyoOqPBfbMqEJgkxR0pcLAY1w7g0xp3GVU1i49XxDanNqXaZT5alRfqcCR72lFPaieAYS614X71b4XeAKpNMph2nogNI96z054wTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253596; c=relaxed/simple;
	bh=qHtqOyQwTicXlBiXjsa40FOOFzsk4ubgxG9F8iTStrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gkk8xqOt0TZ0aScQeKAcUvpXHeRBdjyy2ClSnpDbi7O6bD4PnwoxaswAt/iZ6912KBnKFY9WN4bHZI79eN/cZhY3KCTh6BX3rXqN2xS+f1jkGwCyYGELxMjc9s2Kkp5SuNj3aGwzE7myoNEIpLD8mKIXzaLKCvFt/TWC+J97Rt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz37XGyl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz37XGyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627E01F000E9;
	Tue, 28 Jul 2026 15:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785253594;
	bh=43tddkdiy5OxQc/HCEvD/OzRFwnHRyfJbAOTZJJv444=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zz37XGylFGrLDruoJhuuHJMl9dsRQlPb217NogH10Cp3eWY22tBZ34lqls8k/Ij9y
	 +TXDdCqdPaK1qYR6upNNapjeG7LK7yoYdMBkofb0/SdEVHneR550vD4Vhcp6SxFUFG
	 CkU2XpW4NJ2FmPaw4Aq9A0PmWSXIlHd3Wd+XeW15ifIhGQOrVvZ1RqMODu0KH/wFob
	 pfzEeFNbA+jEK37HtMbTL6KX2WNlv/3Mv0sVHWGs10RnQTgP4+rnRf5orSPcnc4OPm
	 ETnjUChk5p3bcd87t8j0aFJHXn8/TNCudLpbrATz4eum03Dvh2k2f0Pd3TKRbV3jfZ
	 eUn4tI6mW3oWg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 5/6] selftests/bpf: Exercise word-at-a-time
 string kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260728145727.45153-6-leon.hwang@linux.dev>
References: <20260728145727.45153-1-leon.hwang@linux.dev>
 <20260728145727.45153-6-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:46:34 +0000
Message-Id: <20260728154634.627E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Tests intended to exercise word-load page faults fail to reach t=
he word-at-a-time code paths due to unaligned arguments or byte-load implem=
entations.
--

--- Patch [5]: [RFC PATCH bpf-next 5/6] selftests/bpf: Exercise word-at-a-t=
ime string kfuncs ---
commit dc0a0a05e577e233a4ad33ac1ebb0ed2f4f840c1
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Exercise word-at-a-time string kfuncs
   =20
This commit adds functional coverage for aligned and unaligned strings
across the scan, comparison, span, and substring families. It also adds tes=
ts
using aligned invalid kernel addresses to exercise failed word-sized nofault
loads and their byte-sized retries.

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b=
/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> index bddc4e8579d24..05f93c7cd07cd 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c

[ ... ]

> @@ -108,4 +109,61 @@ SEC("syscall") __retval(-EFAULT) int test_strnstr_pa=
gefault2(void *ctx) { return
>  SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault1(void *c=
tx) { return bpf_strncasestr(invalid_kern_ptr, "hello", 1); }
>  SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault2(void *c=
tx) { return bpf_strncasestr("hello", invalid_kern_ptr, 1); }
> =20
> +/* Exercise word-load faults and the byte retry at the same address. */
> +SEC("syscall")
> +__retval(-EFAULT)
> +int test_strncasecmp_word_pagefault(void *ctx)
> +{
> +	return bpf_strncasecmp(invalid_aligned_kern_ptr, "12345678", 8);

[Severity: Medium]
Will this actually exercise the word-load fault logic?

Since "12345678" is a string literal, it may not be aligned. If it is
relatively misaligned, __bpf_strncasecmp falls back to a byte-by-byte loop,
which would mean this test misses the intended word-load fault test entirely
and only tests the byte-load path.

> +}

[ ... ]

> +SEC("syscall")
> +__retval(-EFAULT)
> +int test_strspn_set_word_pagefault(void *ctx)
> +{
> +	return bpf_strspn("a", invalid_aligned_kern_ptr);

[Severity: Medium]
Does this test reach the word-at-a-time code path?

It looks like bpf_strspn processes the 'accept' set using strictly 1-byte
loads. By passing the invalid pointer as the set, the test will fault on
a byte-load, bypassing the word-load logic it is intended to test.

> +}

[ ... ]

> +SEC("syscall")
> +__retval(-EFAULT)
> +int test_strnstr_word_pagefault2(void *ctx)
> +{
> +	return bpf_strnstr("12345678", invalid_aligned_kern_ptr, 8);

[Severity: Medium]
Will this fault on a word-load?

Looking at bpf_strnstr(), it unconditionally reads the first character of t=
he
second argument using a 1-byte load. If invalid_aligned_kern_ptr is passed
here, it will fault on the initial byte-load before any word-load occurs.

> +}
> +
>  char _license[] SEC("license") =3D "GPL";

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728145727.4515=
3-1-leon.hwang@linux.dev?part=3D5
