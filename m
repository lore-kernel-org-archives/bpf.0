Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE0330C60D;
	Thu,  3 Sep 2026 23:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788478481; cv=none; b=EH5Jg2xKvJHTDwlX9s4YjsJt1TPTP5Cfy7A8yuketyPBuaM4HoRnx/i6Q/kTIvpWxr5W95rHuzjtnWsRaIVi3sy2imV/Ogx0QmWzsZou7LC9Q1poprqv9d2cGs4LTYDUuxTdoz4y/+3lQEPa/eB2XmC3Qszi21W7Yke53KwE+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788478481; c=relaxed/simple;
	bh=SMnsW9ylwnqAMzMYtzUgL1bfGkjXRrYvqC+PAnypDKI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQsYijitSbhEuq/fPf2rwgTN5/tjoyEQiUeq0a0d72kC3/mWEVZsYP4qzvIqw77U7M59dmaOhY7O2fw726dzZ+v8x4A8fHmxroPAnDnFxFbN0nTgr9TuNyc6MLZEYw4QRbCDZX3Q2+MEr0N2e5DTeqH9dOG/R29LPRSDyttgM58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eahy5PNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eahy5PNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB05B1F000E9;
	Thu,  3 Sep 2026 23:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788478479;
	bh=hPiSND+W4PGmdYrqL6Txc241RmbgrgfvHcMkz0qY7o0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eahy5PNJo/LTskZ+hhc05aNoxuIlJLx8U89yMCi18UewmN4T2epdt9iGOOqmhHgLo
	 44XI1HkAcBNai7k66ddWyV3czqTQdRS6uszqwOJDEVS0zZ9DX1RXp+X4lnoz6yoOrl
	 jkuh9vuxkmEbl+6QXV4SunEjbR80bmjFWpQQxAAJdohXe33Z4VLl0siYUNs/AbQNty
	 rPl2jyWAQLRQ40GIEomC7/BO7BKV79QqJ/wZQOiOgKpwPDkNq2ncfESDJ/ikqHcWC6
	 QGtlYNwP4shl2LVyxS6UG8XcLQn60LZK84m8VmkIJHwibaUeFaJWOfgmzVT7dtOw8u
	 qJRAq7Vss4sow==
Subject: Re: [PATCH net v2] xsk: set network header on skb at generic transmit
From: netdev-bot+sashiko@kernel.org
To: kerneljasonxing@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, aleksander.lobakin@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Date: Thu, 03 Sep 2026 23:34:38 +0000
Message-ID: <178847847848.4131868.16090144540850507396@kernel.org>
In-Reply-To: <20260901083325.3445-1-kerneljasonxing@gmail.com>
References: <20260901083325.3445-1-kerneljasonxing@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] net/xdp/xsk.c: the new skb_reset_network_header(skb) in
  xsk_skb_init_misc() (net/xdp/xsk.c:950) anchors the *network* header…

--

xsk: set network header on skb at generic transmit

The XSK generic transmit path never reset the network header, so after
skb_reserve(hr) the stored offset was left behind skb->data and
skb_network_offset() returned -hr, which tripped the
DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason() when the
skb reached a tunnel device. This adds skb_reset_network_header() in
xsk_skb_init_misc() so the offset is 0.

Closes: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
Link: https://lore.kernel.org/all/20260826012052.51028-1-kerneljasonxing@gmail.com/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6f..2077bb6299ca9 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -947,6 +947,8 @@ static int xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
>  {
>  	int err;
>  
> +	skb_reset_network_header(skb);
> +

[Severity: Medium]
The negative offset does look closed by this: xsk_skb_init_misc() runs
after skb_reserve(hr) in xsk_build_skb() and xsk_build_skb_zerocopy(), so
skb_network_offset() becomes 0. Two parts of the reasoning look off
though.

First, the commit message says:

  "Note this anchors it at the start of the frame (L2 for an ethernet
   device), which is the same convention AF_PACKET uses on TX."

Is that what AF_PACKET does? packet_parse_headers() anchors the MAC
header, not the network header:

net/packet/af_packet.c:packet_parse_headers() {
	/* On TX skb->data is the L2 header; anchor it for all socket types. */
	skb_reset_mac_header(skb);

	if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
	    sock->type == SOCK_RAW)
		skb->protocol = dev_parse_header_protocol(skb);
	...
}

and packet_snd() for SOCK_RAW resets network_header before moving
skb->data back over the hard header, so network_header stays at the L3
boundary:

	skb_reset_network_header(skb);
	...
	} else if (reserve) {
		skb_reserve(skb, -reserve);

So after this patch an AF_XDP skb differs from an AF_PACKET one by
hard_header_len in network_header, and mac_header is still at the unset
sentinel left by __finalize_skb_around(), i.e. skb_mac_header_was_set()
is false.

Second, the commit message says AF_PACKET "supports GSO/checksum
offload; none of that applies here". Does checksum offload really not
apply? xsk_skb_metadata() in the same file does:

net/xdp/xsk.c:xsk_skb_metadata() {
		skb->csum_start = hr + csum_start;
		skb->csum_offset = csum_offset;
		skb->ip_summed = CHECKSUM_PARTIAL;

		if (unlikely(pool->tx_sw_csum)) {
			...
			err = skb_checksum_help(skb);
	...
}

The software fallback only happens when the user opted in via
XDP_UMEM_TX_SW_CSUM, so a CHECKSUM_PARTIAL AF_XDP skb does reach the
driver through __dev_direct_xmit(), and drivers take the L2/L3 split
from network_header:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_tx_csum() {
	vlan_macip_lens = skb_checksum_start_offset(skb) -
			  skb_network_offset(skb);
no_csum:
	/* vlan_macip_lens: MACLEN, VLAN tag */
	vlan_macip_lens |= skb_network_offset(skb) << IXGBE_ADVTXD_MACLEN_SHIFT;
	...
}

With skb_network_offset() now 0 on an ethernet frame, does this program
MACLEN == 0 and an IPLEN that swallows the ethernet header, so the NIC
inserts a checksum derived from the wrong header layout?

Would it make sense to also call skb_reset_mac_header() and place
network_header at the real L3 boundary here? Alternatively, if the
minimal reset is the intent, could the commit message describe
network_header as a placeholder and drop the claims about the AF_PACKET
convention and the absence of checksum offload?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901083325.3445-1-kerneljasonxing%40gmail.com
