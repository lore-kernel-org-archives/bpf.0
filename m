Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81143BFE40
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535923; cv=none; b=Zh6zgolQYKdKdFDqH5L8wo171PS5fUUrx2L0cfXLCPDvWfca9zw/u00PcXP1vvBZFrLjskzT/kLQxBEsEkvCHoDGy2dCwrZwtP2uk6/mo2DdW1yXg7Yd+qM1+TudyZfHfi7o+5OJpoMUi6QaLMs9W/sXkzbJhMlN9+9vtolJl1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535923; c=relaxed/simple;
	bh=DFJNnwY8486+t7IZxEbePVk14IQ52yje29IrdYl3Kc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N5KAA9XW4nzDpGBZSuXC265BZIyEHloza//cnA9hatmZOAOWZThMPFYZ7pGWYUKkngn/pdB99uEcoJUXFQ+Nuq9TLcZGMuXLGeSxqcWB20OPKlQG0FtuWzgheitQThEc9UcT1ysqhWRgpk5bRteahlOIYACrZOpAKDA4xbpSBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwJ5iBiz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwJ5iBiz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1F21F000FF;
	Wed, 16 Sep 2026 05:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789535917;
	bh=DpRUtdQi392il+LU3Is0WLqwH1opkbc/QonbAkvSYOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kwJ5iBizehvGujGGiaXZRxNEM/8/cS+rNF6q2L6QasMXzeavNSm+7SCrC1qfCUaYl
	 E5b5jJq54PLa2r8u+PL0+gcM0qeiqqeTupE/83rbvKN7DUIMZOvPujv4TJ7wiupByT
	 ed0PHDEpEf/9BrQt8fCb03dj6PYOdJ0XNKRtHMXcO0wHZf5P7LBkDUlTfTMlxpKC14
	 bhKKuI+l9QpCqxPnl8lBd2r1//sNkV6BmogR1xWd7O4DXN3OuovlNwELdZ+jPvkA7N
	 B3AOR9SBIgeQO1qb7uGZM5aERR55OzB5ZICKCdnuKS+AcXsJ++ujOlPx9VVSk7pXam
	 q6ev06EdCCYFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 02/11] selftests/bpf: Test dynptr slices past end of
 skb
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260916050830.8774-3-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
 <20260916050830.8774-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 05:18:37 +0000
Message-Id: <20260916051837.BC1F21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: test misses exact boundary condition for non-linear slices
--

commit 1de6d61a90f0dec0227f3a07a5bdda96d9ca4516
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Test dynptr slices past end of skb

This commit adds a BPF selftest to verify that dynptr slices cannot read
past the end of the linear area of an skb.

> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
> index e0745b6e467ea..b668ebd61fc79 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
[ ... ]
> @@ -211,6 +212,25 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
>  	return 1;
>  }
> =20
> +SEC("?tc")
> +int test_dynptr_skb_slice_non_linear(struct __sk_buff *skb)
> +{
> +	struct bpf_dynptr ptr;
> +	void *data;
> +
> +	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
> +		err =3D 1;
> +		return 1;
> +	}
> +
> +	/* Ensure we cannot read past the end of the buffer. */
> +	data =3D bpf_dynptr_slice(&ptr, TEST_SKB_LINEAR_SIZE + 1, NULL, 1);

[Severity: Medium]
Does this test miss the exact boundary condition?=20

TEST_SKB_LINEAR_SIZE defines the exact size of the linear portion of the=20
SKB. By requesting an offset of TEST_SKB_LINEAR_SIZE + 1, the test skips=20
the exact boundary offset and leaves a one-byte gap in test coverage.

An off-by-one error in the kernel's bpf_dynptr_slice boundary check might=20
not be caught by this test.

> +	if (data)
> +		err =3D 2;
> +
> +	return 1;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916050830.8774=
-1-emil@etsalapatis.com?part=3D2
