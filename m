Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8932BE7B6
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057385; cv=none; b=hoXYPv2XyVgN3iQT18pgvXBd3ZSANUHlRJDXzvLu90rspSh0tDb3ExuJIRXUsqIlztXFsMoQYSHZyMrjj9N/x2RWAh52pjDKDfxgFB/6BgqCwX5KZJTaakTxrysW4Gi/MYOGpgWilzMdoF+tS9BWbJaRh5npVnhWSG6FoMQaEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057385; c=relaxed/simple;
	bh=vXNUPAlGnwHXPtNStIAWvSTrVNz63weAWdOLsr43vOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SwlUXZHgXQ8TL7/s73IEprNgR5U8yEK61+0eGaBg8EufXm92/BLs/y3yqHNQvfZ+D/A84KWblmeXflDhF1pM0ukEFaumr28J6mpTl315lTUhSEJl76oeySbHTU/6g0Hy7Tw80MtmgyTYIgO73bjTQxqBIZd1oo0k6X4gW2eN35k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STQO7PcW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STQO7PcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EB81F000E9;
	Sun, 21 Jun 2026 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057381;
	bh=NqEEUrf6kx2diLq9JRxjYHA5etm3cKwglN+pCgStRjk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=STQO7PcWHlagCKoVDvKtTI8NapuWySjPuboeSRLFkqfwMwzxdkrFvCCT0tZSbWvxa
	 WOFU23h3/8BZvhKG6oYcMQ27J7eJ94WPMmfdd+eqHAglFYcTPfAABxl8R0QxFfm4LA
	 j+3nyolLXY2QInT9nwdtnqk1U2dQrcVecbUSrZ2EJ+vcSNaq4lXh/jtw3OIF4QJDCu
	 WoBqXwHjX4CQguwUBDA7OVRpnzc1b6DqENO1E1MRM9bDx+r94WeerHOr4N/S9LVpKw
	 ge1dRTsE19G+kd5EbGtBhIIcTqpRZffjjm6lxNIVyLy9ZlAplhVTwgRT+AfGgYdl3n
	 hFQZQHp1A/4Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] seg6: validate SRH length before reading fixed
 fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260620-f01-17-seg6-srh-len-v1-1-36cbb29c12f1@mails.tsinghua.edu.cn>
References: <20260620-f01-17-seg6-srh-len-v1-1-36cbb29c12f1@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 15:56:20 +0000
Message-Id: <20260621155621.18EB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Blind skb_pull() in __seg6_do_srh_inline() causes kernel panic on =
malformed or BPF-truncated packets.
--

commit a29767c35f1c85244acfe27c6f46d515a8b796c9
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

seg6: validate SRH length before reading fixed fields

This commit adds a minimum length check to seg6_validate_srh() before readi=
ng
fixed fields like srh->type. This prevents an out-of-bounds read when a BPF
program passes a truncated SEG6 encapsulation header.

> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index 1c3ad25700c4c..d2cb32a1058af 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -29,6 +29,9 @@ bool seg6_validate_srh(struct ipv6_sr_hdr *srh, int len=
, bool reduced)
>  	int max_last_entry;
>  	int trailing;
> =20
> +	if (len < (int)sizeof(*srh))
> +		return false;
> +
>  	if (srh->type !=3D IPV6_SRCRT_TYPE_4)
>  		return false;
> =20

[Severity: High]
This is a pre-existing issue, but while looking at the BPF encap path
mentioned in the commit message, I noticed a potential panic in a related
function, __seg6_do_srh_inline(), when handling truncated packets.

If a BPF program at LWT_XMIT uses bpf_skb_change_tail() to truncate the pac=
ket
length to less than 40 bytes before calling bpf_lwt_push_encap() with
BPF_LWT_ENCAP_SEG6_INLINE, it seems we can hit a panic here:

net/ipv6/seg6_iptunnel.c:__seg6_do_srh_inline() {
	err =3D skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
	if (unlikely(err))
		return err;

	oldhdr =3D ipv6_hdr(skb);

	skb_pull(skb, sizeof(struct ipv6hdr));
	skb_postpull_rcsum(skb, skb_network_header(skb),
			   sizeof(struct ipv6hdr));

	skb_push(skb, sizeof(struct ipv6hdr) + hdrlen);
	...
}

skb_pull() will fail silently and return NULL without updating skb->data if
skb->len is less than sizeof(struct ipv6hdr).

Because skb_cow_head() only ensured hdrlen bytes of headroom, the subsequent
skb_push() for sizeof(struct ipv6hdr) + hdrlen will consume more headroom t=
han
was allocated. Can this underflow the headroom and trigger skb_under_panic(=
)?

Additionally, if the linear data length is less than 40 bytes but the total
length is greater, it looks like the internal __skb_pull() will cause skb->=
len
to fall below skb->data_len, which triggers a BUG() in net/core/skbuff.c.

Should there be a check to ensure skb->len is at least sizeof(struct ipv6hd=
r)
before calling skb_pull(), or does pskb_may_pull() need to be called earlier
in this path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620-f01-17-seg=
6-srh-len-v1-1-36cbb29c12f1@mails.tsinghua.edu.cn?part=3D1
