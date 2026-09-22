Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B5437475B
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098120; cv=none; b=u7Gi5jC8VV29vM6VSh3qkOxrSbM9rAhi0JyI2UnUDwXY9E1mdYZmLBhY4QiUFOsOdq+XCnq14oxVJP594GsY5JQdwy6XAxF0iCHBzHgXUMsEIpciBrUEYYfQPtJZrdPo7kqzT9lG6WnF1LnG0Ffnk1ybVTGwwfA5cgMW5huYYGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098120; c=relaxed/simple;
	bh=mI0R6q9BWuKUL0BDYNU21xpAC+mRLZxtYIpbXRWt4Yc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ePyW5fyuheFHBF8KD7BQ9EaS2RjNMyIvpyHywFh9bVzHGL8v3M09hcV+R7MJ4ueCTBHV9ftZp/XgzI9Wwi1+rCR4aUSZfDKsYaenes1DGK1LIL83ipt+LQD4Dr4K1sCtF7B8Cs8eJXiOckWVZeU34SICk581XOpvMw85iGgsiYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3PrEk1h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3PrEk1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71BA1F00893;
	Tue, 22 Sep 2026 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790098118;
	bh=IPrYUm9TPFq9MUQvPIU8aniddotn1f8jzphCR+Ispws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y3PrEk1hmguMkN6S0a01NuZ4rYuwD7vaA6Zjy1x8ujqSIAvm03a65+x/1dvL7VzbP
	 m2lQTZtlFwQxgdCjhCbs+bbs5iPJug5Tw6dxkOgUqmftDtYaI7SQcDEZrYb1heiUAP
	 qpTW34Du1+9WPbyd4I48y0Y03LbKrR5zXrYIbK8th2QsbkyScK+5Qvz2ed/2saAG80
	 X4Om7F/T8+CHJDKMZdFwokzmA1Vyd58eOSeVKFBd2nEYu04lNQ+6sSXZ6qc/CJtFie
	 1yYEnh/3yLYw7tdMkXEAe/xnS+e+J5QB56yya+X/FdItlol7L2PMr3dTa0xFpb4D2Y
	 B1gWiST+oyz3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 02/11] selftests/bpf: Test dynptr slices past end
 of skb
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922172028.6269-3-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
 <20260922172028.6269-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:28:38 +0000
Message-Id: <20260922172838.A71BA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] test: off-by-one boundary skip in bpf_dynptr_slice test
--

commit b231913ac8efedbed65769b0e27691d0098590c1
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: Test dynptr slices past end of skb
   =20
Add a selftest to ensure dynptr slices cannot include
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

[Severity: Low]
Does this skip the exact linear/non-linear boundary byte by adding 1 here?

Since the linear portion's size is exactly TEST_SKB_LINEAR_SIZE (34 bytes),=
 the
first byte of the non-linear area is at index 34. By using
TEST_SKB_LINEAR_SIZE + 1 (index 35), this avoids testing the boundary direc=
tly.

If an off-by-one error existed where index 34 was incorrectly treated as li=
near,
this test might fail to catch it.

> +	if (data)
> +		err =3D 2;
> +
> +	return 1;
> +}
> +
>  SEC("?tc")
>  int test_dynptr_skb_meta_data(struct __sk_buff *skb)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922172028.6269=
-1-emil@etsalapatis.com?part=3D2
