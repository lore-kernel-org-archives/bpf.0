Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CCC2FB084
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201904; cv=none; b=cnzVSxFJ8CX347NIAeVZN2aIxONRDn9fPaS9Ttlqsrx+z1+Ohbb6i6Vbh7+mPId+iSzFEAz7rNlX3ZHVuP7/GtGMJrkXN0TkQpfw/qVc0KLKQsE52zUdGvxR+y0SEJV0jti/8LV4XK/V4cXLe567S4v81MNPF/buxxReO1pIwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201904; c=relaxed/simple;
	bh=rzKespywRnFTsvonOwJrWP8RWIZkSziWZVx2Cqkin4A=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=UtiV6QIv8lA/1Bf7qYi+iSYcpfA/Nu3II5OfinS0DO0cKAmL6tRHz/L6PVLhXlnZAp++KOh5/9GKyuW8UjMYv/bLyWZjVlnDL75bc2DRgXF/OI1O2jOXnXNN244/iK5JZYvVjE1aKP3N+WzyJna1pWQMu4ckDLIjMiJmIpuB15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1xBNS5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1xBNS5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF3A1F000C4;
	Sat, 17 Oct 2026 01:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201903;
	bh=MDf3o09XMAc1+lspRm0z2ROdI/P+AAX4QaLJskbbLJY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=G1xBNS5KBtV42lEWkilAN+LWictO++f3IdNphwuoQa7cb6rYdCTQ72i7cp4LnxK84
	 mddOMJvm3caBo/JxQLukWNjIabS/K4rf7TLTJkVGlICQSbGWMbuxALcI380hOjgMub
	 IFtaAXaYPlQzbdovEVt5XzQ6eXNbb5sIkZ0N0Vc1Kl0xD0aisTzi8cbUIpNreqVUkH
	 cmUBDJVJ79zEM6xsRWsyBZhR9h6ClmguHQN9Kwz0lFahl3+EAW5R/psI2u1ROdVNgy
	 bixcVeHlMPf62w6xlKvjW0s/djRi1Oe5kR/l0K/HtPvOGmcxjmSdZX+//8zKqzcZpe
	 6Ql2r5FAS6z+g==
Message-ID: <sashiko-outbox-175161@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 08/38] bpf: don't let bpf_skb_adjust_room() use
 up the MSS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261017012058.355787-9-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
 <20261017012058.355787-9-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 01:51:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: bpf_skb_net_grow() allows reducing TCP gso_size below TCP_MIN=
_GSO_SIZE
--

commit 0100f53f10670aa140c2329e248e324eafa85486
Author: Josef Bacik <josef@toxicpanda.com>

bpf: don't let bpf_skb_adjust_room() use up the MSS

This commit prevents bpf_skb_adjust_room() from growing a TCP GSO packet
when len_diff is greater than or equal to gso_size and
BPF_F_ADJ_ROOM_FIXED_GSO is not set. This avoids reducing gso_size to 0 or
wrapping the 16-bit value around (including to GSO_BY_FRAGS).

> diff --git a/net/core/filter.c b/net/core/filter.c
> index ba536be2915fb..a18702f89feb3 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3612,6 +3612,11 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u=
32 off, u32 len_diff,
>  			return -ENOTSUPP;
>  	}
> =20
> +	/* The MSS is lowered by len_diff: something has to be left of it. */
> +	if (skb_is_gso(skb) && !(flags & BPF_F_ADJ_ROOM_FIXED_GSO) &&
> +	    skb_shinfo(skb)->gso_size <=3D len_diff)
> +		return -ENOTSUPP;

[Severity: High]
Should this check ensure that the remaining gso_size is at least
TCP_MIN_GSO_SIZE rather than just greater than zero?

In bpf_skb_net_grow(), non-TCP GSO packets without BPF_F_ADJ_ROOM_FIXED_GSO
are already rejected just above, so any packet matching this condition is a
TCP GSO packet. The networking stack relies on TCP GSO packets having
gso_size >=3D TCP_MIN_GSO_SIZE (8) so that the segment count fits in the
16-bit gso_segs field:

include/linux/virtio_net.h:__virtio_net_hdr_to_skb() {
    ...
			BUILD_BUG_ON(TCP_MIN_GSO_SIZE * GSO_MAX_SEGS < GSO_MAX_SIZE);
			gso_size =3D max(gso_size, TCP_MIN_GSO_SIZE);
    ...
}

With skb_shinfo(skb)->gso_size <=3D len_diff, bpf_skb_net_grow() still allo=
ws
skb_decrease_gso_size() to reduce gso_size into the range 1..7 while setting
SKB_GSO_DODGY and resetting gso_segs to 0. If a large TCP GSO packet (where
skb->len exceeds 65535 * gso_size) is then transmitted, can this overflow t=
he
16-bit gso_segs field and corrupt qdisc_skb_cb(skb)->pkt_len in
qdisc_pkt_len_segs_init():

net/core/dev.c:qdisc_pkt_len_segs_init() {
    ...
		gso_segs =3D DIV_ROUND_UP(payload, shinfo->gso_size);
		shinfo->gso_segs =3D gso_segs;
		qdisc_skb_cb(skb)->pkt_segs =3D gso_segs;
	}
	qdisc_skb_cb(skb)->pkt_len +=3D (gso_segs - 1) * hdr_len;
}

as well as overflow skb_shinfo(skb)->gso_segs in tcp_gso_segment() or trigg=
er
DEBUG_NET_WARN_ON_ONCE(len / mss > GSO_MAX_SEGS) in skb_segment()?

> +
>  	ret =3D skb_cow_head(skb, meta_len + len_diff);
>  	if (unlikely(ret < 0))
>  		return ret;

endasi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017012058.3557=
87-1-alexei.starovoitov@gmail.com?part=3D8
