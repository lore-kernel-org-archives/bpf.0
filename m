Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178453;
	b=LgAulybL7vMD/uKvummo8uW8NvcisD+LKbMahlSMCWCY+C6fNWVqBq3YYArLLQkFta+t
	 CzsrBlIN/VzDWiwFpPhdNOjGmtABnzwKdYtGGkukjnX5DRuBT7WRL5/8TtYB2ovKLn9vX
	 Zsfw1n5Q4CRlv6TSD++47Ahq664bjn/T1mIfJIJe8rg5WDjaEzhgzYXXbLSAQGaLl+q76
	 BX8SbYyijndzZdbDYlwaYkua8MYLUOJ4nnv1d6/O3XGNO/EAP5h5LhMAuux0QsTLS6ctE
	 qvnF4u5KFohtTHpdZUfj2tYOYETSDlIQHqVr7E6o2H6UUHngbV2x88A+irENnVaarGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178453;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6gILjvj5TkjSofGimhf9EcJDmErsL6keDY7+dgIgu40=;
	b=SkY4h7LzuNyOcaNkpn7bW2el9Ptu8FJC64TZdJoGr2DGUhK/OiM9n8/5JZeWr2bAag6+
	 krnrTASzlWehAaeQkeKycI4P/K+rv3qPONA4ZwYLtP8Rw8wi3tLaj34Wz0dVNrP+VVTnB
	 ATn618dkmYmQI8HHvTTgyt5Faqd4tmWfDzm4QAdS50ixzPpFRwXxYKLMEUmd2sWrOi5t5
	 D5T7QRFi+Z39N/v9M06n0JXkgmD98nd3RikiealRFdDa6tbrkMsMm2EwM4kLnjRYIAaam
	 N2+NS657F1OZmYCoAVSCGe4Z0Cupn/cotMKtLUrmHzDsdiTQh2zhJKjzT9ZNq4IStug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGg8Yywe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D9606A335
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGg8Yywe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329A41F000CF;
	Fri, 20 Nov 2026 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795178453;
	bh=6gILjvj5TkjSofGimhf9EcJDmErsL6keDY7+dgIgu40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gGg8Yywe0+3to0RhZhNRaSbNXJ7jLgATRGpKPZ+k3qnOoFmQKeLCL1a7/Hw4KZx/q
	 jbQxQXfS8asbJcF7vvIb0IRGWaxI1DP1m0XpRa9rgeqm0FzDK08rUwv49I0hPD3CnS
	 rWOhIVhYcx359WB2S7W9dLITLOZvJ1rvlR0R69GYJDYXd7RRFoa1h5LwYV7T3xKT1D
	 rC/3JeONcbmn2qxfBe9GnAhooKTQv7tBlek0yNGgz2Z5ugcPOtsi1wOnv0YRk6ThkS
	 NFA6qD4O4jVWrQeLZT1u3sauGgw+tPzJwAjkVo1izsV0hOMIAsmpWUUDhOfAzTZbC3
	 mzmlSsEIn1PVA==
Message-ID: <sashiko-outbox-225153@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 2/3] net: neighbour: reinject a parked skb
 through a headerless output device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <QDISC-6HS9.v6.r0.20261119070330-2@mojatatu.com>
References: <QDISC-6HS9.v6.r0.20261119070330@mojatatu.com>
 <QDISC-6HS9.v6.r0.20261119070330-2@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:40:52 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] net: neighbour: reinjecting skb onto n1->dev misroutes
  redirected packets
--

commit dce8515be5271f5a3b9c463a37e73a62aef0f6af
Author: Jamal Hadi Salim <jhs@mojatatu.com>

net: neighbour: reinject a parked skb through a headerless output device

This commit restores skb->dev to n1->dev in neigh_update_process_arp_queue()
when n1->dev has no header_ops before calling n1->output().

Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index ae2db3912454a..d36d86cfc441c 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1342,6 +1342,9 @@ static void neigh_update_process_arp_queue(struct n=
eighbour *neigh)
>  			if (n2)
>  				n1 =3D n2;
>  		}
> +		/* headerless output transmits on skb->dev, not n1->dev */
> +		if (!n1->dev->header_ops)
> +			skb->dev =3D n1->dev;
>  		READ_ONCE(n1->output)(n1, skb);

[Severity: Medium]
Can setting skb->dev =3D n1->dev misroute packets that were steered to anot=
her
device while retaining a dst pointing to a headerless device?

As the commit message notes, nft_fwd_neigh_eval() and
__bpf_redirect_neigh_v4() / __bpf_redirect_neigh_v6() (when nh is provided)
steer the packet to a target device and nexthop while leaving the original
skb_dst(skb) attached, and neither site drops that dst in this tree.  When a
packet originally routed to a headerless device is redirected to an
unresolved neighbour on another device, neigh_update_process_arp_queue()
re-looks up n1 from the retained dst, resets skb->dev to the original
headerless device, and transmits the packet there instead of on the target
device (or re-runs n1->dev's egress hook and decrements TTL a second time if
redirected from NF_NETDEV_EGRESS).

An egress redirect or mirror via tcf_mirred_to_dev() from a headerless
device to teql0 hits the same issue, and cannot drop skb_dst(skb) because
teql_resolve() requires the dst to resolve the slave neighbour.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/QDISC-6HS9.v6.r0.20=
261119070330@mojatatu.com?part=3D2
