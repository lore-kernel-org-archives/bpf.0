Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A70181724
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338025; cv=none; b=kP7f4TSR+L6iTPkCT6Ty15fWYaLA/pc13D/IheVHiDCopJZR+Y4SXugBQufQlF5klud67MgtsuT/TBm84TdL15000Y8vJt266U7DzrcKjlB4QsNvqOypagoRyt7FlbIkirHSVEjqUPzBGQPGbzMhJmomWgFFCJ1FCCw+sbFxtk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338025; c=relaxed/simple;
	bh=bB6mMMV+fde/icLlzHg3QH0YPWT5Cv/rs0fObuVPuwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ai/Rhh9iWofY6uN/ngztro8vRiNJlWn6/0rr0tQ6YY6L5bZoj3eljnjFpPSsXUbar7oX8JaWROyGa/kcQu4dzKT4+wk3FnCKyqs/TnePQe/JYrT7JtCcr/oOaJcMaYVWQhczwxKpShva4snnD/P+8uTkO49+FOJpc09rhfjsWks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjvMVotC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjvMVotC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9311F00A3A;
	Wed,  2 Sep 2026 08:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788338024;
	bh=ONY17FOgirTWV3fBr0Jn/neeh6ouGuMPU9DI9PFumuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JjvMVotCm1e1OWKoFjO+Uwx7YQN0JU5ydpESU+HPxpbjAA88BzWyYK4wDePgvzPoA
	 UNtaxGXioONr4zkK7qxtZvWHdczeNzIMdx9/OfxFCbv4Watmveb5/IEofaBp0Ck+iG
	 xMseU7YDe4D+RV+Zo3JHrPOw9j8I4xj++8H/3j7F1KvvsKbYYe1If0lEAlSmjcYf29
	 IP/CYiTQWDJ/39BL9seKUMvcnh7hMWMEauYLMVe2rNx6Mr1tnJa4NrZPlzuFCAfGkM
	 KUHT5Pb533bhqKwaS3RKbDO4BWoaTwSEtEdoAGGoZheOBJ6Ef3bG7nZfs6qBK1Z/Be
	 GdeWcGSD5eh3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] xsk: set network header on skb at generic
 transmit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260901083325.3445-1-kerneljasonxing@gmail.com>
References: <20260901083325.3445-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 08:33:43 +0000
Message-Id: <20260902083344.1D9311F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The patch incorrectly anchors the network header at the L2 bound=
ary (MAC header), which violates standard SKB semantics and contradicts the=
 AF_PACKET convention it claims to follow.

Pre-existing issues:
- [High] Missing initialization of `skb->mac_header` in the AF_XDP generic =
transmit path leaves it at `~0U` (0xFFFF), causing out-of-bounds memory acc=
esses in network drivers that unconditionally read the MAC header.
--

commit 8222314e7d9b572394dd3fc2b9acb0b3706abd3e
Author: Jason Xing <kerneljasonxing@gmail.com>

xsk: set network header on skb at generic transmit

This commit fixes an issue in the XSK generic transmit path where the netwo=
rk
header was left uninitialized. It adds a call to skb_reset_network_header(s=
kb)
in xsk_skb_init_misc() to ensure the network header is correctly anchored to
the start of the frame. This prevents a crash when the skb is handled by
tunnel drivers.

Closes: https://syzkaller.appspot.com/bug?extid=3Df16c1b285c9f63994eec
Link: https://lore.kernel.org/all/20260826012052.51028-1-kerneljasonxing@gm=
ail.com/

>     Reset the network header so skb_network_offset() is valid (0). Note t=
his
>     anchors it at the start of the frame (L2 for an ethernet device), whi=
ch
>     is the same convention AF_PACKET uses on TX.

[Severity: Medium]
Does anchoring the network header at the L2 boundary (MAC header) here
violate SKB semantics and contradict the AF_PACKET convention?

In AF_PACKET's packet_snd(), skb_reset_network_header(skb) is explicitly
called before skb_reserve(skb, -reserve) prepends the L2 header, correctly
anchoring the network header at the L3 boundary (after hard_header_len byte=
s).

By anchoring the network header directly at skb->data (the L2 header) in
xsk_skb_init_misc(), won't any subsystem, offload logic, or tunneling driver
that relies on skb_network_header(skb) erroneously parse the Ethernet header
as an IP header?

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6f..2077bb6299ca9 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -947,6 +947,8 @@ static int xsk_skb_init_misc(struct sk_buff *skb, str=
uct xdp_sock *xs,
>  {
>  	int err;
> =20
> +	skb_reset_network_header(skb);
> +

[Severity: High]
This isn't a bug introduced by this patch, but is it also necessary to call
skb_reset_mac_header(skb) here?

The AF_XDP generic TX path allocates packets via __alloc_skb(), which leaves
mac_header uninitialized at ~0U (0xFFFF). Because AF_XDP generic TX bypasses
standard egress paths (like __dev_queue_xmit()) that would normally set the
MAC header, the SKB is handed to __dev_direct_xmit() with an invalid
mac_header.

When physical NIC drivers unconditionally read eth->h_proto via
skb_mac_header(skb) during transmit, this evaluates to skb->head + 0xFFFF.

For example, in drivers/net/ethernet/intel/ice/ice_txrx.c:ice_xmit_frame_ri=
ng():

	eth =3D (struct ethhdr *)skb_mac_header(skb);

	if ((ice_is_switchdev_running(vsi->back) ||
	     ice_lag_is_switchdev_running(vsi->back)) &&
	    vsi->type !=3D ICE_VSI_SF)
		ice_eswitch_set_target_vsi(skb, &offload);
	else if (unlikely((skb->priority =3D=3D TC_PRIO_CONTROL ||
			   eth->h_proto =3D=3D htons(ETH_P_LLDP)) &&
			   vsi->type =3D=3D ICE_VSI_PF &&
			   vsi->port_info->qos_cfg.is_sw_lldp))

Dereferencing this out-of-bounds pointer crosses page boundaries and causes
a paging violation (kernel panic). Should skb_reset_mac_header(skb) be added
alongside the network header reset to prevent this out-of-bounds read?

>  	err =3D xsk_skb_destructor_set_addr(skb, addr);
>  	if (unlikely(err))
>  		return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901083325.3445=
-1-kerneljasonxing@gmail.com?part=3D1
