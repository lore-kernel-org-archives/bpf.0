Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911817;
	b=EKN970Yc1Z4v9yc5ryWXpIjHNlex9bEeUwUPBfE/cw67TIXNQVFjrQHFBWI1YDyH+dm4
	 9OhbFIioZaIZ84rH+5Bdm1GgdBCwHntbJCFTSFwXUVGfTc+HxU4ZsfRMwwkLkHYtfVQ8P
	 mJKOrvlwkd63zyoJrUg5c4K/QdwgSiqD1dz7I5RrPsmMuwwTO3iJ+yjX2kC9SE896b2+x
	 gVb14+i31IsH7D2RFZPKGwjOyKCpytKc4oFGJO+gxReT3999lBj2SJXjqMBNBYiA2sv0Q
	 kz65VCXjlqwxNFvlzSm9YBDUsZNEhosDKCu2ejmwxaXj7y9c4pjj+0U3zZbkhG6pEHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8/PQxmZ96RoltGpQhbN72csEFy8CDSMZBJAn0/ND6sk=;
	b=2mPuel/ZxtOO71GvlBmDCeC3FWMSYschLn0i0W+mfQkltgFdQwOyFVX3J691ezdTblVw
	 wv5Z9sxZV6blutKzRyKju+LpjrAaHYOLysZAVFyJ3jTE5+hZrCc7X56KPKEEfeInDbKSc
	 r2Nj9HKhNwpNykpsnD93dFy6ns7d5A+3/22/hNor20LQ+h1HfOlrzgmlrLzxOQ17YRb3J
	 ik0zd1N4LAE276e1Z8YKf1QAlAxyRFVcVVQax2QffyQ3BlODOnoMN2Kgzabg8TCs+qBJP
	 dnxpEl2iXsm1me11D39r5gpsamwc/DWK1DajwPyzpMv4jGboLelvr/RRW2dEcTajvDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCFtML3p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37E606A888
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCFtML3p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258371F000C4;
	Tue, 17 Nov 2026 10:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794911817;
	bh=8/PQxmZ96RoltGpQhbN72csEFy8CDSMZBJAn0/ND6sk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CCFtML3p3I72x55zN1GmQUVyXJCCgBcFel7TGHhfbPpk+EaU1pjtUJKP5TLM0XhJq
	 jCsoTt1o//Kp9IIwIXuTD1aTaVNMBUU9wXSHZ89oj9bxfpfkDx5kUHQtya9DCnL2IU
	 omtq9KB6Mj0xeZJX4/4EsT8b/I/I4b9uIHgK3OKbpf1DD6WAGyOxiOFfDgH090F99X
	 iZ8tbUdKc/hhm0NK1a4XTM6EzIN3tBotg5Q5uNrRNXMut3vwQiHpnSACQZzUn0iw6Q
	 gzWTfKFvE4g4PWrF7PXwt84UZXA6/uoP39UHNh7d4w0IlszhiEu9dkzTX/m6m7pHgw
	 2RX8BsxAEPzvw==
Message-ID: <sashiko-outbox-218641@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 2/3] net: neighbour: reinject a parked skb
 through a headerless output device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <QDISC-6HS9.v5.r0.20261116052927-2@mojatatu.com>
References: <QDISC-6HS9.v5.r0.20261116052927@mojatatu.com>
 <QDISC-6HS9.v5.r0.20261116052927-2@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:36:56 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] net: neighbour: reinjecting skb onto n1->dev misroutes
  redirected packets
- [Low] net: neighbour: unresolvable commit SHA 1da177e4c3f4 in Fixes
  trailer
--

commit c144e3e967eef24fc933621e8fea6beda200db16
Author: Jamal Hadi Salim <jhs@mojatatu.com>

> net: neighbour: reinject a parked skb through a headerless output device
>
> The issue:
> neigh_update_process_arp_queue() drains a neighbour's arp_queue and
> reinjects every skb through READ_ONCE(n1->output)(n1, skb), where n1 is
> the top-level neighbour re-looked-up from the skb's dst, not the neighbour
> the skb was queued on. skb->dev is whatever the producer left there.
> Note: skb->dev and n1->dev are not guaranteed to be equal.
>
> When n1->dev has no header_ops, arp_constructor() and ndisc_constructor()
> install neigh_direct_output(), a plain dev_queue_xmit() that transmits on
> skb->dev and builds no link header. Such an output sends the skb out
> whatever device skb->dev names, not out n1->dev, so a producer that
> parked the skb naming a lower device has it leave without the link header
> its own transmit path builds.
>
> sch_teql is the producer that hits this: it parks the skb on the slave's
> neighbour while the top-level neighbour is the master's, so skb->dev and
> n1->dev differ and the reinjection has to come back through the master to
> leave with a header. It names the slave on purpose, so that a parked skb
> does not outlive the master it came from.
>
> This half was split out of the sch_teql fix on review, so that the
> neighbour restore carries its own commit log and its own Cc set.
>
> The Fix:
> Put skb->dev back to n1->dev before the output call when that device
> builds no link header, so a headerless output transmits on the device the
> neighbour belongs to, whatever the producer left in skb->dev.
>
> A forward that steers the skb to another device, nft fwd ... neigh or
> bpf_redirect_neigh() with explicit nexthop parameters, parks it with the
> dst of the original route still attached. When the original route is
> itself a headerless device this gate matches there and the skb goes back
> out the original device, running its egress hook a second time. Those
> forwards supply their own device and nexthop and do not consult the
> retained dst, so dropping it at those two sites is where that is fixed;
> that is a separate change to the producers.
>
> Conditions to recreate the bug:
> CONFIG_NET_SCH_TEQL=3Dm and CONFIG_VETH=3Dy, run as root. This is the
> neighbour half of the sch_teql parked-skb fix, reached once sch_teql parks
> the skb naming the slave: create a veth pair, make one end a teql slave,
> give the master an address and a route, flush the slave's neighbour entry
> and send one packet:
>
>   ip link add v0 type veth peer name v0p
>   ip link set v0 up;  ip link set v0p up
>   tc qdisc add dev v0 root teql0
>   ip link set teql0 up
>   ip addr add 10.0.0.1/24 dev teql0
>   ip route add 10.0.0.99/32 dev teql0
>   ip neigh flush dev v0
>   ping -I teql0 -c 1 10.0.0.99
>
> The packet parks on v0's arp_queue. When the solicitation resolves,
> neigh_update_process_arp_queue() reinjects it; without this change it
> leaves v0 directly, with no link header, and never reaches the peer.
>
> The window that frees the master, and the unload recipe that shows it,
> are in the sch_teql patch.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
The commit sha 1da177e4c3f4 ("Linux-2.6.12-rc2") in the Fixes: trailer cann=
ot
be resolved in the repository.

> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index d6e9c7c59a892..1b556fa17c57c 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1339,6 +1339,9 @@ static void neigh_update_process_arp_queue(struct n=
eighbour *neigh)
>  			if (n2)
>  				n1 =3D n2;
>  		}
> +		/* headerless output transmits on skb->dev, not n1->dev */
> +		if (!n1->dev->header_ops)
> +			skb->dev =3D n1->dev;
>  		READ_ONCE(n1->output)(n1, skb);
>  		if (n2)
>  			neigh_release(n2);

[Severity: Medium]
Can setting skb->dev =3D n1->dev misroute packets redirected by
nft_fwd_neigh_eval() or __bpf_redirect_neigh_v4() / __bpf_redirect_neigh_v6=
()
when the original dst points to a headerless device?

As noted in the commit message, those paths leave the original skb_dst(skb)
attached when queuing on an unresolved target neighbour, and neither produc=
er
has been updated to drop the dst yet:

net/netfilter/nft_fwd_netdev.c:nft_fwd_neigh_eval() {
	...
	skb->dev =3D dev;
	skb_clear_tstamp(skb);

	nf_dev_xmit_recursion_inc();
	neigh_xmit(neigh_table, dev, addr, skb);
	...
}

When the target neighbour resolves, dst_neigh_lookup_skb(dst, skb) finds n2=
 on
the original headerless device, overwrites skb->dev with n1->dev, and
reinjects the packet through neigh_direct_output() -> dev_queue_xmit() onto
the original device instead of the redirected target.  If the redirect ran =
in
n1->dev's egress hook, nft_fwd_neigh_eval() runs a second time and decremen=
ts
iph->ttl or ip6h->hop_limit again; if the redirect happened outside n1->dev=
's
egress hook, the redirect is lost and the packet transmits out n1->dev.
Similarly, tcf_mirred_to_dev() retains skb_dst() on egress redirect or mirr=
or.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/QDISC-6HS9.v5.r0.20=
261116052927@mojatatu.com?part=3D2
