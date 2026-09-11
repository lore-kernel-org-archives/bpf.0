Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149832F60B2
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139345; cv=none; b=S+KgjobrXSoAtXdqLtbdA9pDj2qMxf/xWeTOZyCn07k1m/nI3Pl6cL3GSSazlO9KoQFofJgsTdUl4a9vW2+qbvwbqtJYa/z3OVA4Yz9CVV03uUSoOdZqCbBY1hBMX8tMcoQx+dd3tIt4GEBZjRL6raSDS7tgY0P0jUU7+Xy37u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139345; c=relaxed/simple;
	bh=WTUGu3L2LCGIv2K4u7YlL7UIntgtFL2OjRrrvHrvc6g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kcOvnuU/x3B3Sef9fQL4+xViVnkxWC9wVtyaRxDEg4p31unrmdNmoqsjpXX6lUvfdoltclMNX9MSVkFO/4IxcicTIjzDc4FgO7aHAZNo27E+UuLUCTFfzoG7L0MQf02+2MR2OQR5djF6RZy5iI7ZcsiNZjdFdeHkp5UutSXznIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnmN5Nn3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnmN5Nn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEA71F00893;
	Fri, 11 Sep 2026 15:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139343;
	bh=ywufb7TtTpghFpyooAT1bokej8RITjTZ3F18zSF7h9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AnmN5Nn3NP4J+PHGVtGpR/aEqjtL6ALm5upFZ6+sW+UxkUd2am8pYHjVNrBBtaaO8
	 DWs/h0pG3fvfOtsmK7KCosipyMo4PZiC2zpRDNGpMjmqRZX0ONhn9BIzKfvg0VD+Q9
	 hK7dpT27kbuDgcjy44Cv0cO4wA9x1/xGMxX62WAMBpVUoTd8ksVKgE3VB2NvDoogkw
	 /RgWHOahKB72oPkGK4L7YRyA7DRiqwacRU6kkNUNrFSVVZ4lm7OtW7lYXGqDZdXd7g
	 IF2wISSFw07PchAv8+JZ0uktu2KQyW4VEuK1YTgNkSwp6XSg8ttOxgIvNBq4nVmNeL
	 OJyt2I9S35Kyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 04/14] selftests/bpf: Add tests for
 bpf_dynptr_from_skb_ext
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-4-0b21e42180b0@cloudflare.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
 <20260910-bpf-meta-inside-skb-ext-v2-4-0b21e42180b0@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 15:09:03 +0000
Message-Id: <20260911150903.7BEA71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing NULL check for `xdp_prog` in `__test_tuntap()` leads to unc=
onditionally calling `bpf_xdp_attach()` with an invalid file descriptor (-E=
INVAL).
--

commit a1930ddb8537b804128c0b7705ce4372074cd5b6
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Add tests for bpf_dynptr_from_skb_ext
   =20
Cover the bpf_dynptr_from_skb_ext() kfunc and the dynptr interface
to skb_ext with TC-to-TC tests on a tuntap device. This also exercises=20
the verifier check for tracing and LSM programs that rejects=20
bpf_dynptr_from_skb_ext(BPF_SKB_EXT_F_CREATE) in these contexts.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index 448807676176c..252ac02de81b1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
[ ... ]
> @@ -693,3 +704,55 @@ void test_xdp_context_lwt_encap(void)
> =20
>  	test_xdp_meta__destroy(skel);
>  }
> +
> +static void test_skb_ext_tuntap(struct bpf_program *tc_prio_1_prog,
> +				struct bpf_program *tc_prio_2_prog,
> +				bool *test_pass)
> +{
> +	__test_tuntap(SKB_EXT_NETNS, NULL /* xdp */, tc_prio_1_prog,
> +		      tc_prio_2_prog, test_pass);
> +}

[Severity: Low]
When test_skb_ext_tuntap() calls __test_tuntap() with NULL for xdp_prog,=20
does this cause an issue with the unconditional call to bpf_xdp_attach()?

Looking at __test_tuntap():

	ret =3D bpf_xdp_attach(tap_ifindex, bpf_program__fd(xdp_prog),
			     0, NULL);

Since xdp_prog is NULL, bpf_program__fd(NULL) will return -EINVAL.=20
This negative file descriptor is then passed directly to bpf_xdp_attach(),=
=20
which violates the API contract.

Would it be better to add a NULL check for xdp_prog before attempting to=20
attach it, similar to the existing check for tc_prio_2_prog in __test_tunta=
p()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-bpf-meta-i=
nside-skb-ext-v2-0-0b21e42180b0@cloudflare.com?part=3D4
