Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942B4078C0
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499173; cv=none; b=nZlOnhCFvTWF5AM3wFgJVe68Rq0HYV3Bd8R+LSFo96sQ4TPQnPJwnE6XwTwc130R8jYCNsRkmkMWf5gQHcv+NcRb2yBQR4iYOdLNLeSRuvuHGsROB/3e++z6O5mWnSOWJxZzRv6UKqNWthWuOdMfy65yexjw2/zlWXMdzjhn6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499173; c=relaxed/simple;
	bh=PZFLZtwrHJo4xozaZv0HEF6E7El7wtBaEYaYwL96vaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iNeLtJ4NdVWGMr4moTMWpHaYS728n+RwVcQyh2BKpUgxP6nEOoqG14D3azKm4AkurMYUIvyoklPxNAj7qsH2b+sjV6VamqxHyU7Gk8EWn9QMQhzqNcS+cbWXwesv1nZMUNIzf3Z6VtBR+Dksq3w7YyaxW70MIZcPGcjgjlsOKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXTjVysc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXTjVysc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD761F00A3E;
	Fri,  4 Sep 2026 05:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788499172;
	bh=BbdnR8Bkzr2++32P9jcn4T5oKT/SABUB1r06+hRYLgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TXTjVyscj1tLk77z79zLyeGHZHTHbNzYnpbpNoEuGx3RS5bbm9SOo8BFuqUYq1QMO
	 0OzDtXiScEwZDNGK7AJuB+3boKggLEm6IRNCeStteqOjIy+pGBOFRoa0MKzW96qLaI
	 p8b0EbSvXjBBDhl74/UzTsf6q0vNAq2ZZP+3TDkVk3hyCZEa+o8EyPnoxxAA9k3Txz
	 0KoQdNQ9+WulbJ9N1D5Xx0q+74WUSF4To6uNsa0Dl6FRDlVVn1wrdQ/YlOch4Tc7iJ
	 qpuCBWFWxDrs2tOCAr7y7Bn+h80KY9Fc9A6ymPSRGJcWPteYIGzaDG4lE3CuB2qya2
	 WeBUwLa+JwUhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 10/12] selftests/bpf: Add C tests for by-value
 arguments up to 16 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904051049.3982644-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
 <20260904051049.3982644-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 05:19:31 +0000
Message-Id: <20260904051931.EDD761F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] `take_with_ptr_global` and its test are missing the `#if defined=
(__clang__)` guard used for other global functions taking structs by value,=
 which will cause the test to fail when built with GCC.
- [Medium] `take_two_pairs_global` lacks the surrounding `int` arguments ex=
plicitly promised in the commit message to catch slot counting bugs.
--

commit a3823ad45ae612d86e218eeec89944cc894c7843
Author: Yonghong Song <yonghong.song@linux.dev>

selftests/bpf: Add C tests for by-value arguments up to 16 bytes

This commit extends the by-value argument tests with aggregate cases written
in C. It relies on the compiler to lower arguments into register pairs inst=
ead
of using hand-written register layouts.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_int128_arg.c b/to=
ols/testing/selftests/bpf/progs/verifier_int128_arg.c
> index 044fc4a800554..b10fb4aeb4056 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
[ ... ]
> +__noinline __u64 take_two_pairs_global(struct pair p, struct pair q)
> +{
> +	return p.lo + p.hi + q.lo + q.hi;
> +}
> +
> +SEC("tc")
> +__success __retval(0)
> +int aggregate_arg_two_structs_c_test(struct __sk_buff *skb)
> +{
> +	__u64 a =3D skb->len ^ MIX_A;
> +	__u64 b =3D skb->len ^ MIX_B;
> +	struct pair p =3D { .lo =3D a, .hi =3D b };
> +	struct pair q =3D { .lo =3D b, .hi =3D a };
> +
> +	if (take_two_pairs_global(p, q) !=3D 2 * (a + b))
> +		return 1;
> +
> +	return 0;
> +}

[Severity: Medium]
Does this function signature and test implementation match the strategy
described in the commit message?

The commit message explicitly states a defensive testing strategy of having
"two struct arguments in a row, each with an int argument on either side so
that a wrong slot count shows up as a wrong value in the parameters around
it".

However, take_two_pairs_global completely omits these surrounding int
arguments. Can these be added to properly validate register slot counting?

[ ... ]
> +__noinline __u64 take_with_ptr_global(struct with_ptr s)
> +{
> +	return s.x;
> +}
> +
> +SEC("tc")
> +__failure __msg("type STRUCT in take_with_ptr_global() is not composed o=
f scalars")
> +int aggregate_arg_ptr_member_fail(struct __sk_buff *skb)
> +{
> +	struct with_ptr s =3D { .p =3D skb, .x =3D skb->len };
> +
> +	return take_with_ptr_global(s);
> +}

[Severity: Medium]
Should take_with_ptr_global and its test aggregate_arg_ptr_member_fail
be enclosed within the #if defined(__clang__) guard?

Other global functions taking structs by value in this file are guarded.
Since GCC passes aggregates by invisible reference, it will produce a
different BTF signature (a pointer instead of a struct).

Will this cause the test to fail when compiled with GCC, as the verifier
might not emit the specific "type STRUCT ... is not composed of scalars"
failure message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904050957.3976=
119-1-yonghong.song@linux.dev?part=3D10
