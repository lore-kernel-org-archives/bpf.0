Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805C3DE45C
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785149220; cv=none; b=sEslGFVZHNyPV3dLARgri6DLRjggCRZjeeYA5zyUe7hjIX+JMe82zVSXgro8F7+Ksi3QNVzQG2momfYK4yiSp7PqTzxGzeKpNXotwM8BsK7Xpo22dpcb7R+Je13Iup7+O8aJ4ZVUhl/NdGUPWgz7rdfuNYiKthu9B2Ymi1D8NBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785149220; c=relaxed/simple;
	bh=hyTqthWL4QjdmdpenTufHqGb7yjnnt/OJf2XWrY17pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qZzjk6rKkWsL9iesaVuwFA5qfbBHVOJSzufMRn3ga90A6XDhbZqWyVz5Nl4CgHHw4SGzRySq4wYbO1Wq8E3UKuTCU1In7zbot3WUX8qJqMg5UP9NMv6IYfmmgMOF+C08qdU4ryorcyYcRaTtqVv+jrE682ZiUQZQQHHrTVfrVFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAeRaqTp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAeRaqTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F171F000E9;
	Mon, 27 Jul 2026 10:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785149219;
	bh=MVOTOgWcmHx9Dv5vymYbZ71L3/gPWYRXhM/ZiDiAwDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AAeRaqTpXUew2p6ixCC0HhWJ/U2G2xQo2NdIaTYDG0L4UAHf2k+cchjybTnAU3rtb
	 gSzeOTNYSAstxJw2erEmTTOM42hvp8ajx3DpnEL01uGWDAjxyGmW0+kkni4wZMvyag
	 79ZiVx1Y0yvlB1aUWSHfJzXlTp3dizqkIE2i7IdIctUBzmeyeaci3+uMQEIGh+UU40
	 uNzTvzAZ+ib8hHbheB3nS3+ukw6TKVX2yHwAOUgp5G3BkF7UAGpjbBQOfP3C4T99L7
	 tIK/r05ebQGnrbQ31yETNHHi/wRSXBU8kFAgLyoHkU3NP+vD0MYuV4vuLh/KiLWOYV
	 jKSvgQxRR4gdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] lwt_bpf: account for aligned neigh header length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junseo Lim" <zirajs7@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260727103005.897983-1-zirajs7@gmail.com>
References: <20260727103005.897983-1-zirajs7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:46:58 +0000
Message-Id: <20260727104658.D4F171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of sk_buff when pskb_expand_head() fails inside xmit_c=
heck_hhlen().
--

--- Patch [1]: [PATCH bpf] lwt_bpf: account for aligned neigh header length=
 ---
commit 5477d92d482dd8688e9965b977030b4ade25bd6d
Author: Junseo Lim <zirajs7@gmail.com>

lwt_bpf: account for aligned neigh header length
   =20
ip_finish_output2() expands an skb to LL_RESERVED_SPACE(dev) before LWT
xmit. An LWT_XMIT BPF program can then modify the skb head and still
return BPF_OK, so bpf_xmit() rechecks the remaining headroom before the
skb continues to neighbour output.

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index bf588f508b79e..2890aa59a3a00 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -169,8 +169,10 @@ static int bpf_output(struct net *net, struct sock *=
sk, struct sk_buff *skb)
> =20
>  static int xmit_check_hhlen(struct sk_buff *skb, int hh_len)
>  {
> -	if (skb_headroom(skb) < hh_len) {
> -		int nhead =3D HH_DATA_ALIGN(hh_len - skb_headroom(skb));
> +	int hh_alen =3D HH_DATA_ALIGN(hh_len);
> +
> +	if (skb_headroom(skb) < hh_alen) {
> +		int nhead =3D HH_DATA_ALIGN(hh_alen - skb_headroom(skb));
> =20
>  		if (pskb_expand_head(skb, nhead, 0, GFP_ATOMIC))
>  			return -ENOMEM;
                        ^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but if pskb_expand_head() fails here, does
this leak the skb?

Looking at bpf_xmit(), it takes ownership of the skb but doesn't free it
when xmit_check_hhlen() fails:

    ret =3D xmit_check_hhlen(skb, hh_len);
    if (unlikely(ret))
            return ret;

The -ENOMEM is returned directly up to lwtunnel_xmit() and then to
ip_finish_output2(), neither of which will free the skb in this error path.

Should xmit_check_hhlen() or bpf_xmit() call kfree_skb(skb) before
returning -ENOMEM?

>  	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727103005.8979=
83-1-zirajs7@gmail.com?part=3D1
