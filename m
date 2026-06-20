Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF82C3757
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975392; cv=none; b=qr5YF1Pst26n7ew8TEIoKqabKwe6EpuZZo3hnVmuxl27ad8qBp5VGD4JwyrUh4UlZ6bjn3tX6w1De2SmiQ5IMqPW0FuKos1hFTsF5WAdP2r3mLTnmwQlp1I8ZqSTWYVVRpUNfqdfLnm0EnwGZBhqT7XBMknTxB/2Wiq0CQlGfz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975392; c=relaxed/simple;
	bh=ig+uLwVQFsTEaVGnLr7KpDM8YZszbLVs2Wf2z86CL8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oiaIbCIWkTdv3swHpAVIV/u4UjpkIgRZ7wIr/BU/eSSOJtG+1v6W0gsaAO1W4bqzH6P+COlb6Xp1Tjbg698gAkPtUapg6olYoKePVytfbYqK4DHY9ANs5m2k41ZoBScRG49NZDBiLLKUbK+rUnBt5BsC/LFPx7TRzYTROXVJRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQiIm5pL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQiIm5pL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B273D1F000E9;
	Sat, 20 Jun 2026 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975390;
	bh=BIDGOpJ0HOIY8dOAV7R33hpJDGusEu+Wfdkj9cAv3Cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQiIm5pL5WO7i5f/x4N09Gai7saajJcZeaWs1s5dpXw6JjXKAGdNq80mFlVdHoGny
	 mp8BASQe55LnyTsVbhXJ8YeHlXeX+D5uKeLiUIjYkrTAUDV/0TrudSu0N8/4nNijk5
	 tv0CQnB9rrSZ3MdM6aRi12rJx0eCtRRqVT7PV/RgrgZr1469UkP29GQflMxPG5PDWU
	 qvIjuLaVmRRCISYmw8w++df1p/AbeOPrjZvpap7kui2SSc+8JNZWIw8uURZxnmH9OL
	 LCJIufZs00WHpBYS4CmEJ7gqu+pA+pZ0A3EonsBtG80w+nBF5rcLp3AOtgpHYhoRTe
	 8Z+qzDvKChplw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] selftests/bpf: Add LWT encap tests for skb
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260619-bpf-lwt-drop-skb-metadata-v3-2-71d6a33ab76b@cloudflare.com>
References: <20260619-bpf-lwt-drop-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com>
 <20260619-bpf-lwt-drop-skb-metadata-v3-2-71d6a33ab76b@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:09:50 +0000
Message-Id: <20260620170950.B273D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The assertion `ASSERT_GE(tap_ifindex, 0)` incorrectly accepts 0, wh=
ich is the error return value of `if_nametoindex()`, masking interface look=
up failures.
--

commit 78aa5c949a7515e0e86daf8bde1669b476228831
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Add LWT encap tests for skb metadata

This commit adds testing for LWT encapsulation and XDP metadata sitting in =
the
skb headroom. It exercises LWT dispatch paths including BPF, mpls, seg6, and
ioam6 to ensure outer headers do not silently corrupt metadata.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 26159e0499c76..448807676176c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
[ ... ]
> @@ -518,3 +559,137 @@ void test_xdp_context_tuntap(void)
[ ... ]
> +	SYS(close, "ip neigh add fd00::2 lladdr " TX_MAC " nud permanent dev " =
TAP_NAME);
> +	SYS(close, "ip -6 route add fd00:1::/64 %s dev %s", encap, TAP_NAME);
> +
> +	tap_ifindex =3D if_nametoindex(TAP_NAME);
> +	if (!ASSERT_GE(tap_ifindex, 0, "if_nametoindex"))
> +		goto close;

[Severity: Low]
Does this properly catch interface lookup failures?=20

Looking at if_nametoindex(), it returns 0 on error, so using ASSERT_GE
will evaluate to true when tap_ifindex is 0. This allows the test to mask
the lookup failure and inappropriately proceed with an invalid interface in=
dex
to bpf_xdp_attach().

Could this be ASSERT_GT(tap_ifindex, 0, ...) instead?

> +
> +	ret =3D bpf_xdp_attach(tap_ifindex, bpf_program__fd(skel->progs.ing_xdp=
),
> +			     0, NULL);
> +	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
> +		goto close;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-bpf-lwt-dr=
op-skb-metadata-v3-0-71d6a33ab76b@cloudflare.com?part=3D2
