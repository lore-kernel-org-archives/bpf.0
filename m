Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523065;
	b=sicOgQOcX9MjAu6GKiTwWyfz6JNg8eeWAqKaC2IX3eAohroFSS5uOgYwXpw78AZ7gu4n
	 w5zGWmeL67i5roBey87bnuvwaLGUnu/2XoZg3CXikTLxYZHAMZFx9EJS8WQzgBrDSAxJg
	 ITRgjVlGWi08jKJmdX85OupxVHXpZMT1G4UW01bKR92kq/k298eDIOk21uQhTOIJblhCm
	 e7ExT2xUvEQe+FNi82pVvkjDkWcIw1ZSgameOK5l5C0efQxqOGbQsmFXj954+mbau6rUv
	 sgpc1dJIxOsg3aFlg4OmwOIWQQwtzQy1UtpD0u+6FbRLgufal5ilajJK34MmuVKYmVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523065;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3RgPDHRoRZYFO88F/iEnQNqSWM4u5BLq3aNl2+2XP7E=;
	b=hCoWXF7a0KN0cbOLlIHxbg4fdTbu8tRoYcZAaaqV5GuqtN2PH2j4P6iuuOUJEcftUgYn
	 4HpwTC79qNPhoRgqPAoWHuqhnI5BKEbxLFeRiidVdjZ417m4TDi4ltl7qP5J5O76vfHon
	 nxHjhy1sfUMX9SGZJjKW53/ydjK7BuJe4+4bSFh8BUPIm6ssBZVhcFxuBud93Igh9SoSA
	 KVLLkM8GDre1Mi7mJTs55/FmwXYgH3pq4xaK4RhuvX+65Lk4NgoShooHUWpbGc+XKxd2q
	 MWD6imVj9m0QC8EsKBHMpS5ou7Ckl89sz5wHdpVpXFayr+Lf+dWulq9+07e+F73CpWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnNdBStn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E98606A31E;
	Tue, 24 Nov 2026 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnNdBStn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B211F000D0;
	Tue, 24 Nov 2026 12:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795523064;
	bh=3RgPDHRoRZYFO88F/iEnQNqSWM4u5BLq3aNl2+2XP7E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bnNdBStn1H4rajUmtV4VBas0NXF6RM6XPIkCoMrQlzyVihPKH1jFJT0WmcY8Qc1P+
	 InVi9xco5vwjuNN+1QYb0pX05n+ty4GN3dur/UqJy7TmDr8OIQ89XoSx/eOFAKXNjg
	 q9F8eYkRN74LDy3T5TSsdIXjFKIXXJYQOU8ZONxvV/pkc+sCQYUeYrCOy5RJpvQdYX
	 GI4S/bQ5NMkuKaf8K8eTDUDiQhS0QdKnXZ47iburtU4CabNouI3/0Mtgxkpr0E99kN
	 GDelaOyYRzHLc8mVzDCrD91LSdIUv/Z3eQhVNOb0dsT096jmJZicRHiKqDrw6KXEvO
	 zx3EduhK7vNcw==
Subject: Re: [PATCH net v2] net: xdp: fix generic XDP on skbs without an
 Ethernet header
From: netdev-bot+sashiko@kernel.org
To: jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org, kennethbwlee@snu.ac.kr, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, kuniyu@google.com,
 wang.zhan@smartx.com, mkarsten@uwaterloo.ca, bpf@vger.kernel.org
Date: Tue, 24 Nov 2026 12:24:23 +0000
Message-ID: <179552306350.3135.16282643834784138893@kernel.org>
In-Reply-To: <20261123121540.275576-1-jiayuan.chen@linux.dev>
References: <20261123121540.275576-1-jiayuan.chen@linux.dev>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new runtime guard in netif_receive_generic_xdp()
  (net/core/dev.c:5827, `if (skb->data - skb_mac_header(skb) < ETH_HLEN)…

--

net: xdp: fix generic XDP on skbs without an Ethernet header

This patch stops generic XDP programs from being attached to devices that
are not ARPHRD_ETHER or ARPHRD_LOOPBACK. dev->type can change after attach,
so it also skips generic XDP for skbs whose mac header is shorter than
ETH_HLEN.

Closes: https://lore.kernel.org/bpf/20260812043643.808295-1-kennethbwlee@snu.ac.kr/

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6140fd9d11cd0..df335f361706d 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5823,6 +5823,10 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
>  	if (skb_is_redirected(skb))
>  		return XDP_PASS;
>  
> +	/* XDP is Ethernet only, skip skbs without an Ethernet header. */
> +	if (skb->data - skb_mac_header(skb) < ETH_HLEN)
> +		return XDP_PASS;

[Severity: High]

According to the commit message, this check covers the case where dev->type
changes after attach:

  "An empty bond or team takes the type of its first port ... So also
  skip the program for skbs whose mac header is shorter than ETH_HLEN."

What happens with non-Ethernet ports whose L2 or pseudo header is ETH_HLEN
bytes or longer? In these two cases data - mac_header is at least 24.

IPoIB, in skb_add_pseudo_hdr():

	skb_reset_mac_header(skb);
	skb_pull(skb, IPOIB_HARD_LEN);

ipgre with ipgre_header_ops, in __ipgre_rcv():

	if (tunnel->dev->header_ops == &ipgre_header_ops)
		skb_pop_mac_header(skb);

That second case leaves mac_header on the outer IP header, so mac_len is
the outer IP header plus the GRE header.

The sequence looks like this:

1. Attach an XDP_FLAGS_SKB_MODE program to an empty bond or team while it
   is still ARPHRD_ETHER. This passes the new dev_xdp_attach() check.

2. Enslave an IPoIB device to the bond
   (bond_enslave()->bond_setup_by_slave()), or add an ipgre device to the
   team (team_dev_type_check_change()->team_setup_by_port()). Nothing
   vetoes NETDEV_PRE_TYPE_CHANGE because of a generic XDP program.
   bond_enslave() only checks the native-mode bond->xdp_prog.

3. On RX, __netif_receive_skb_core() calls skb_reset_mac_len() on the
   lower device's skb. The rx_handler returns RX_HANDLER_ANOTHER, and at
   another_round do_xdp_generic() runs the upper device's generic program.

4. The new check is false, so the program treats the IPoIB pseudo header,
   or the outer IP/GRE bytes, as an Ethernet header.

If the program then changes bytes 0-5 or 12-13, bpf_prog_run_generic_xdp()
does:

	__skb_push(skb, ETH_HLEN);
	skb->pkt_type = PACKET_HOST;
	skb->protocol = eth_type_trans(skb, skb->dev);

This leaves mac_header at data - 14 while skb->mac_len stays at 24 or
more. skb->protocol is also taken from non-Ethernet bytes.

Would tc ingress then hit the same "skb_vlan_push got skb with skb->data
not at mac header" warning in skb_vlan_push() that this patch is meant to
fix?

There is also a second gap. bpf_xdp_link_update() calls dev_xdp_install()
directly and does not go through dev_xdp_attach(). After a type change like
the one above, could a new generic program be swapped in through an
existing link without hitting the new ARPHRD check?

Would any of these close the remaining cases?

- require mac_len == ETH_HLEN at run time
- check skb->dev->type for ARPHRD_ETHER or ARPHRD_LOOPBACK at run time
- veto NETDEV_PRE_TYPE_CHANGE while a generic XDP program is attached

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123121540.275576-1-jiayuan.chen%40linux.dev
