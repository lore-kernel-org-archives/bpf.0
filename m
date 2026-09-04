Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B953F4DD0
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 03:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788494082; cv=pass; b=qEf9x9riUj824uMlJwwxeFo0l+y68nDtQPof28uAzvfxOWDmcUEyxOyJNhGxv01LgEdfepDCuZ0xz+r3QTMUDkUm2c8G0HldnbAGOzrG00RrVhpL67s0EUHNiUUC8/5LPf3Jk4j0vWo2x3R9fzHB9taGfe+LTI6KC10dIhGTn9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788494082; c=relaxed/simple;
	bh=4ivltMd+WNh9xrx0FALebal4xO9kvXF/tQHkhvKpwao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMVT1IJYMgSMTO/lWmvV7+CGKzjGs7ewXwfzvy9Xl7gaNBsXgFZbQFWsixt+dVfsHQeqi+VRZODQwyIVrGY0j36a0HVA+wPfMHjqMDNiOaishf7Sy8sXMAKtn5Gg964Ndp9+3ywxeUCyQPTalhuB2d5VAK4m6bnD9xtwqealRfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP+aYer1; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP+aYer1"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b4ab0e4da6so494737e87.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 20:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788494079; cv=none;
        d=google.com; s=arc-20260327;
        b=PKgRKtVQVz36H4w0m8HTHX7GbKhu1KZc7GJVld0BNpz7oNsZFT3DZAIUys+XcjLf9Z
         S60wliCikMiYje2pTCIs8C7AjHs7n/14zlqEt7hSBankfSxQtyPckk9R/zAPpEN6UlYw
         oiHTcwttcuxlVeVWJ84ToE7Egk4vUSvuPvndt8NtKK/seLdno8mKvmOjLKJ3Hib7iUUx
         yxIwOUiTh8ENFevXfvykY8GqbAPtLxD0lDZT1pzRuLS7qgD2SXoWyTOSrNlQ+szK/U5f
         UF9mg4fwjSfw6Fa+X8BPjBEV5AsV60oSs3GxANXxTDESWZ2U6fRtlQseXYUA2ro3yRYS
         VWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Mz/3viwjB0MJGXdWkfWYvgUftKCdoN6ikbVn8DsC4Y=;
        fh=Gbja4XEFK4QbI4A3h17b5m/0ArTMx1Arrzzerel3iFc=;
        b=iYFt7r8yAABmS0JeIJNwHiQuhr/g4A0ypV4c1kaugOKGlyGG+WRcRP4tRx6lA1KlGi
         jQwfSb+a4t+9hZ8w4vlbe2pzNcNYWKpzPl+4rIg+q/DJJT7gCfeL51nj6OS6Wt707QVq
         1pTHv7xoqk+sVN/t64IlAKIdXgr4c1lDcMw5evbcAbqyBAr0Dv8oOTJ5wVCTKr8EN2O4
         IYDiuEpNzDRpTe6ZEeQVcH7eUDywtEmdCMeaKM6yBol9k+FOV9E3ZXLfRcpldXVFv+UT
         AioWHOM7CLGdbgR24w+H/v7hprg+csY2osqHSkdsADkjPLjOXED4dGfJKH4Q3FGjgZUZ
         Ta3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788494079; x=1789098879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Mz/3viwjB0MJGXdWkfWYvgUftKCdoN6ikbVn8DsC4Y=;
        b=CP+aYer1aH99Y6HzrH7WlOlSZHOzSup0QePPkOEVciz4yLuKDHW0OCAqA8soDdI15l
         6uL1rmJPKjk8lZSVdu1NpKh7SYo6svBkXn+nR043brlVTDJ7iqfe+lySRszmJFeo7lSL
         OYTrnCr8x904ySh/2+2zFx7fjljx+yDaVVbrfBuuSMgk+u5Rac5Xq9auGo7bJLY4aZ3z
         ebBZL0/jXnywdUzGC7aHO7uq8oSNlDetnfXZ+/8AJxXV0EpEZUf1VKnHrCuA7yD8dUjB
         0+LiCEZgmY2oZIg/YN3VBkUCxHr6gjo9V5YVWfQ3oh9EbUZ4ECM/ndjXkR1vRC099fjj
         e1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788494079; x=1789098879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Mz/3viwjB0MJGXdWkfWYvgUftKCdoN6ikbVn8DsC4Y=;
        b=PDIieKxun6Xrft/mB3mmhz/32k+mfnO7rGAch+gpK3KGC68RK407DzYz0CEXJ53Djm
         Vtt3tPNdSXox0GgkDIQg14+sRcNaNjSlbQ0bPYR/7YnpI/aF1lrqFgh+FJ+uBaPFLN/i
         54qGtn5FnhwKgXSKjboIQ5WETggp/DGp0vkS8EoGTEzkZOoq8re//txkeHpKslQCnFyG
         8XQAQrWqYdKiG3QFUE5UnFhc+YWQQNp0CFF+4PZj2M0ltEWdN25cN2Fevo6poraKSBor
         FnS/PeDVQobwCxFO3zzoUStXQupLA4HYMuLhvlVW+rakp6ejVYgUOkeit0iFDhwm8fJ2
         Oi2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxDbtPZg++AakR23TX+GKK+AeCachjP4QY0kWQDaRDNjs8MiIkAWUmtbVj5bB4g2RU2LbM=@vger.kernel.org
X-Gm-Message-State: AFuF++kivSbkgldmiZjMzUfKKtOPHewlncupUtxoHoNGXczMBma+A6mT
	R3gDAALnyg3CwNTR6rPAOgyNi0FkreW4C5x01zGMny5rkX+SrUmP4FkE8CR3t9YPQgUcaxdpIjv
	fjNC3sexZRnciRnZhQnWo6OPQjTs/Klw=
X-Gm-Gg: AYBFou3CJzLd8/7Umit0eMZ17baULmTnx9eUm96DZilnxosIsrLcm73Q2jHgcwIpueT
	6O47unV0XReM7ghZOOZRt4wSLKERX/xwCqYj2GkZo1jHjJt9qCz/OLv7k4i7ZdcdfGsK5AhlFcF
	GbEgqc0aIJ5k+tD7SC0KUQfh5hIOXZcdOY8QmRRFBfvbIomi3rvUcXLuh2qVUlfjQm8rm9TXZl6
	GnaK3ntsmBl8NQjK2KOJylVCX+t0rZTs7BlOtGjd3nj5S7DFqqrdmkC5Wm61zSbFxLclFkubhZu
	O+Bl0wWGRF8ScD9H0DfgV8kmqjAQr/AJRAAio0DivqZSmAm4w2uMvtmgQ7V5eXV3fgNJc1n8Oh8
	sPOQqBHL9YaqYxVI1RQN9K1ivhw8B2cLAgfm53ELKasHovDe+WU0znbP5Sxk=
X-Received: by 2002:a05:6512:3995:b0:5b1:5a31:85fa with SMTP id
 2adb3069b0e04-5b616f422c1mr485731e87.16.1788494078454; Thu, 03 Sep 2026
 20:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901083325.3445-1-kerneljasonxing@gmail.com> <178847847848.4131868.16090144540850507396@kernel.org>
In-Reply-To: <178847847848.4131868.16090144540850507396@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 4 Sep 2026 11:53:59 +0800
X-Gm-Features: AcwNN1UGiVZEE19vtDL4L_1YR6gWA-zv8jPPrCDXRY0juq9kvuh0kdlBj6DycAI
Message-ID: <CAL+tcoDpyG-Hy9mtDnLSGu0nvU_VDqTjs-k51r2+OPwVyHtABA@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: set network header on skb at generic transmit
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, aleksander.lobakin@intel.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 7:34=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] net/xdp/xsk.c: the new skb_reset_network_header(skb) in
>   xsk_skb_init_misc() (net/xdp/xsk.c:950) anchors the *network* header=E2=
=80=A6
>
> --
>
> xsk: set network header on skb at generic transmit
>
> The XSK generic transmit path never reset the network header, so after
> skb_reserve(hr) the stored offset was left behind skb->data and
> skb_network_offset() returned -hr, which tripped the
> DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason() when the
> skb reached a tunnel device. This adds skb_reset_network_header() in
> xsk_skb_init_misc() so the offset is 0.
>
> Closes: https://syzkaller.appspot.com/bug?extid=3Df16c1b285c9f63994eec
> Link: https://lore.kernel.org/all/20260826012052.51028-1-kerneljasonxing@=
gmail.com/
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 33475b180ea6f..2077bb6299ca9 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -947,6 +947,8 @@ static int xsk_skb_init_misc(struct sk_buff *skb, s=
truct xdp_sock *xs,
> >  {
> >       int err;
> >
> > +     skb_reset_network_header(skb);
> > +
>
> [Severity: Medium]
> The negative offset does look closed by this: xsk_skb_init_misc() runs
> after skb_reserve(hr) in xsk_build_skb() and xsk_build_skb_zerocopy(), so
> skb_network_offset() becomes 0. Two parts of the reasoning look off
> though.
>
> First, the commit message says:
>
>   "Note this anchors it at the start of the frame (L2 for an ethernet
>    device), which is the same convention AF_PACKET uses on TX."
>
> Is that what AF_PACKET does? packet_parse_headers() anchors the MAC
> header, not the network header:
>
> net/packet/af_packet.c:packet_parse_headers() {
>         /* On TX skb->data is the L2 header; anchor it for all socket typ=
es. */
>         skb_reset_mac_header(skb);
>
>         if ((!skb->protocol || skb->protocol =3D=3D htons(ETH_P_ALL)) &&
>             sock->type =3D=3D SOCK_RAW)
>                 skb->protocol =3D dev_parse_header_protocol(skb);
>         ...
> }

I'm going to remove this part.

>
> and packet_snd() for SOCK_RAW resets network_header before moving
> skb->data back over the hard header, so network_header stays at the L3
> boundary:
>
>         skb_reset_network_header(skb);
>         ...
>         } else if (reserve) {
>                 skb_reserve(skb, -reserve);
>
> So after this patch an AF_XDP skb differs from an AF_PACKET one by
> hard_header_len in network_header, and mac_header is still at the unset
> sentinel left by __finalize_skb_around(), i.e. skb_mac_header_was_set()
> is false.
>
> Second, the commit message says AF_PACKET "supports GSO/checksum
> offload; none of that applies here". Does checksum offload really not
> apply? xsk_skb_metadata() in the same file does:
>
> net/xdp/xsk.c:xsk_skb_metadata() {
>                 skb->csum_start =3D hr + csum_start;
>                 skb->csum_offset =3D csum_offset;
>                 skb->ip_summed =3D CHECKSUM_PARTIAL;
>
>                 if (unlikely(pool->tx_sw_csum)) {
>                         ...
>                         err =3D skb_checksum_help(skb);
>         ...
> }
>
> The software fallback only happens when the user opted in via
> XDP_UMEM_TX_SW_CSUM, so a CHECKSUM_PARTIAL AF_XDP skb does reach the
> driver through __dev_direct_xmit(), and drivers take the L2/L3 split
> from network_header:
>
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_tx_csum() {
>         vlan_macip_lens =3D skb_checksum_start_offset(skb) -
>                           skb_network_offset(skb);
> no_csum:
>         /* vlan_macip_lens: MACLEN, VLAN tag */
>         vlan_macip_lens |=3D skb_network_offset(skb) << IXGBE_ADVTXD_MACL=
EN_SHIFT;
>         ...
> }

After digging into the probing logic, I strongly feel that Jakub is
right to consider whether to add the probing logic.

>
> With skb_network_offset() now 0 on an ethernet frame, does this program
> MACLEN =3D=3D 0 and an IPLEN that swallows the ethernet header, so the NI=
C
> inserts a checksum derived from the wrong header layout?
>
> Would it make sense to also call skb_reset_mac_header() and place
> network_header at the real L3 boundary here? Alternatively, if the
> minimal reset is the intent, could the commit message describe

The minimal reset doesn't help with the checksum problem mentioned above.

Adding simple logic like resetting l2/l3 headers doesn't guarantee
that csum problem won't be triggered. Adding complete probing hurts
perfomance for sure.

Maybe we can cook two patches:
1. Fix the current bug syzbot reported as is.
2. Fix offload logic by adding complete probing

@Jakub, Maciej, Stan
Do we need a complex logic like af_packet to handle this?

Thanks,
Jason

> network_header as a placeholder and drop the claims about the AF_PACKET
> convention and the absence of checksum offload?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260901083325.3445-1-kerneljasonxing%40gmail.com
