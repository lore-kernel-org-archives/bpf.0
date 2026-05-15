Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257393FF1C7
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859467; cv=none; b=WvMeR2EZ1p9reMQVlM/wq6MLeeraGrIe/akUAZWBzbEHia5Ye9rZi98kikL9qRct+hYz/nL9LSySVFBKPlT0EbLJy88Dj3WcqcqZsJ2y1BL4YZqiUtg4XuK+2Wh2iD2g/0MbNjlQIMga/WdT5Xc7tHqQvSkRj4kwW/ttkONivmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859467; c=relaxed/simple;
	bh=HqrEwFz+F7gpbG94BoPl3Vh1bgEzyB4F8K3wrJfuRj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zz9rdaDj8600jlwECeY0ZAwuiCHWpPtW6GMTkSEZpRLyj+PcPgrcEtNbtuGFj/V534qp1BlJwNfwvCkJAfgLGvc/qEdRoQLD/i609Fd7iEwf4DrV5WC7uIHnq3e8UXQKFQjAw0OVDe5FvGkGBet9lAU9i13xLMGuJ+UYjWZaRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiScDIhw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiScDIhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0D9C2BCB0;
	Fri, 15 May 2026 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859467;
	bh=HqrEwFz+F7gpbG94BoPl3Vh1bgEzyB4F8K3wrJfuRj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DiScDIhwbxhPWydshiZgTfQdEPezQELlzBNmTJU9AWfyiLK/AKXbC15Osp7Jtf/GW
	 JoEqmBw40G+gKH/5FKLNd8NdTJ2kFb7CHcYMNnKscEXA5ScCpm7K0fmdAuEfQvz4Xk
	 sphiLPOevj1pTKDH0QGfYzmv0aTfvQT3gLHy+gFIyn6Q+rQtxbxm0LB02FTV5ZrRV/
	 q/H2UY6d46L/hNrZXdv5g1iqydXWYsy6jQdN3Jci1sp+q3vm9XBAEJ/N6ZfhPRqnHI
	 2kjO5sKmU+c2X9ZcSN6gOi9BuK8DV2xetjNXk/1yDau2ostgG6ZVAnDghmZEXYM0fH
	 dvrJtv7mSiJWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/bpf: fix tunnel option size in
 ip6geneve_set_tunnel()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Faisal Bukhari" <faisalbukhari523@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515151830.711129-1-faisalbukhari523@gmail.com>
References: <20260515151830.711129-1-faisalbukhari523@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 15:37:46 +0000
Message-Id: <20260515153746.DF0D9C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The test constructs a malformed Geneve packet where the option siz=
e field exceeds the total options length.
- [High] The receiver test silently fails to read the Geneve options, meani=
ng the BPF tunnel option feature remains unverified.
- [Medium] The commit message incorrectly claims to fix an incorrect option=
 length, but causes no functional change.
--

commit 41bdc36eb9d63a2614970dded5866e42f459a85a
Author: Faisal Bukhari <faisalbukhari523@gmail.com>

selftests/bpf: fix tunnel option size in ip6geneve_set_tunnel()

Pass the correct size to bpf_skb_set_tunnel_opt() in
ip6geneve_set_tunnel().

> sizeof(gopt) returns the size of the pointer instead of the
> actual Geneve option structure, resulting in an incorrect
> option length being passed to the helper. Use
> sizeof(local_gopt) to provide the proper structure size.

This isn't a bug, but does this actually change the size passed to the help=
er?

On the 64-bit eBPF architecture, pointers are exactly 8 bytes.
struct local_geneve_opt consists of a 4-byte struct geneve_opt and a 4-byte
int, totaling exactly 8 bytes. Thus, the exact same length (8) is passed to
the helper before and after the patch. The patch improves semantics but does
not appear to fix an incorrect length.

> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools=
/testing/selftests/bpf/progs/test_tunnel_kern.c
> index 32127f1cd6872..b53d367451b2c 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -675,7 +675,7 @@ int ip6geneve_set_tunnel(struct __sk_buff *skb)
>  	gopt->length =3D 2; /* 4-byte multiple */
>  	*(int *) &gopt->opt_data =3D bpf_htonl(0xfeedbeef);

Is it possible this creates a malformed Geneve packet?

According to the Geneve protocol (RFC 8926), the length field defines the
option data length in 4-byte multiples, excluding the 4-byte header.
Thus, length =3D 2 indicates 8 bytes of data (12 bytes total option length).

However, only 8 bytes total are passed to bpf_skb_set_tunnel_opt() via
sizeof(local_gopt). This results in an option that claims a length exceeding
the available option space.

Should the length field be set to 1 instead?

> -	ret =3D bpf_skb_set_tunnel_opt(skb, gopt, sizeof(gopt));
> +	ret =3D bpf_skb_set_tunnel_opt(skb, gopt, sizeof(local_gopt));

While looking at this, I noticed an issue in the receiver function
ip6geneve_get_tunnel() which calls bpf_skb_get_tunnel_opt() with a 4-byte
local struct geneve_opt:

tools/testing/selftests/bpf/progs/test_tunnel_kern.c:ip6geneve_get_tunnel()=
 {
	struct geneve_opt gopt;
...
	ret =3D bpf_skb_get_tunnel_opt(skb, &gopt, sizeof(gopt));
	if (ret < 0)
		gopt.opt_class =3D 0;
...
}

Does this silently fail to read the Geneve options?

The kernel helper enforces that the buffer size must be at least the size of
the options present on the packet. Since the sender set 8 bytes of options,
bpf_skb_get_tunnel_opt() with a 4-byte buffer will fail with -ENOMEM.

It seems the test might be ignoring this error and bypassing the verificati=
on
of the Geneve options entirely.

>  	if (ret < 0) {
>  		log_err(ret);
>  		return TC_ACT_SHOT;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515151830.7111=
29-1-faisalbukhari523@gmail.com?part=3D1
