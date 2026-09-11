Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D287322C6D
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137993; cv=none; b=QN+ubGPw+fEXDmcsQ/ijW1uml4v+xqfS/xDvquznuDGDU/DKWC8A6dtdL/20ZEmI7O6shwFONz5DRVMaxOAA7bRB+hn2WJtq3AW7LsWmGajNZNO5qZyY8aVV4ptTryXScWa9dCm5IuqfVufYyYbgO5XvhvNF3FXFEZaM4HqqSa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137993; c=relaxed/simple;
	bh=zrZRTxHOroSHc1SU3ZpcTIzYrEsz6Gb5VrIikhdbwPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IRBWDKdoOsgqA2jAWpL+xK4KA5OPFASqTuyXaccerNJ1aBG8l3wIqe/0zfJ5CJ2XpAnS3sdTwDKOgUjYE8W4Gdg+SOw7hOZgCyOTo1j/K2QhSMmwDM4Zwyobf8gualni2ea9l1mexzo6e9dYc4MnnpKl75EzXYKUIVJ5dStCDuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEY3pGSk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEY3pGSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A4C1F000FF;
	Fri, 11 Sep 2026 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789137991;
	bh=QK7G9V/U1JCzQI9vr2Ftm51VPVwWhNcp1VHJA1ZxcSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MEY3pGSk2qQkU2J8wXrZrUc0+QswujZu8M2LBE1DJDHTdadTDVC1NBgadrBhiXs0B
	 B4ox0Ag8zoTQjLzrfC5jJ9pRX4UmWsQW0mp+hgCNAPwA/1eQx0pZXJ+M6ovGgrxwcm
	 s2QuzZ6j+Yp28nbcv8k7h+mVsnHohjMFMhpiLa1WyuWE6/8uPAYaWMF5xAQ9ic20ec
	 ATmwTmNLi/wb1HyCojwxtYqerGGnB0k7OtMZ8A2Ti2ArBuDWPCS3h0x9UgBTpG3RGe
	 23sl+ro7o+CU9DHz7MZl6ULulPdABmsPgnlhN8pEzErqtHugSnd8qXpJCa/vNcNzIf
	 cLRXchtdp96OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: add xdp_shrink_frags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911135711.109338-3-jiayuan.chen@linux.dev>
References: <20260911135711.109338-1-jiayuan.chen@linux.dev>
 <20260911135711.109338-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:46:31 +0000
Message-Id: <20260911144631.A7A4C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Type punning a byte array into a struct pointer violates strict =
aliasing rules.
--

commit 7d6829eaaf619b188a1baf1e3f7bf91fc5a0a765
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

selftests/bpf: add xdp_shrink_frags

This commit adds a BPF selftest for XDP that shrinks fragments and
triggers a page_pool leak on a generic XDP path. The test exercises
test_tun, test_veth, and test_veth_tx to cover different data path
behaviors on 4K pages.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c b/=
tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
> new file mode 100644
> index 0000000000000..ee8f9034a2684
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_shrink_frags.c
[ ... ]
> +static void test_tun(struct xdp_shrink_frags *skel)
> +{
> +	__u8 head[74], frag1[2048], frag2[2048];
> +	struct ethhdr *eth =3D (void *)head;
> +	int tap_fd =3D -1, ifindex, err;
> +	struct netns_obj *ns =3D NULL;
> +	struct iovec iov[3];
> +	ssize_t n;
[ ... ]
> +	memset(head, 0, sizeof(head));
> +	memset(frag1, 0x41, sizeof(frag1));
> +	memset(frag2, 0x42, sizeof(frag2));
> +	eth->h_proto =3D htons(ETH_P_IP);

[Severity: Medium]
Does this code violate strict aliasing rules by type-punning a byte array
into a struct pointer?

When test_tun() executes, it accesses an object declared as an array of
characters (__u8) through an unrelated larger struct pointer (struct ethhdr=
 *).
Since this code is located in a test program running in user space (under
tools/), standard -fstrict-aliasing rules apply.

Could the compiler assume that eth does not alias head, leading it to reord=
er
or drop the write to eth->h_proto entirely during optimization?

> +
> +	iov[0].iov_base =3D head;  iov[0].iov_len =3D sizeof(head);
> +	iov[1].iov_base =3D frag1; iov[1].iov_len =3D sizeof(frag1);
> +	iov[2].iov_base =3D frag2; iov[2].iov_len =3D sizeof(frag2);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911135711.1093=
38-1-jiayuan.chen@linux.dev?part=3D2
