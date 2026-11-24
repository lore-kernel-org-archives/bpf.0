Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522563;
	b=hMsuunzTUeiXopfKHAMCDmIbhFDgCqr0TiavsD90EGxfIfScI+gUZT1aPn21wZTEwlBi
	 pndLH0MrcR4MHZjYIIjtWJYDD9NOJIhBEOTAlEE3k27h67MZEKAXgCRHoyY+7XNXKRNgJ
	 7FljzvoygHok9yWmAP0oNZ3OR+q9b/MlyTsoe1Aoa+VXVuEw09eZdf9poV2/9RbrZ5wXd
	 uGrqaZzZJuFMoYFrsHHN7Z5mzN7OnS7zACFNPzKJStc9CNt0MH4Nn0oH3wwdD8+LC7GdY
	 UFK5DJxUA+F12/bUKIGSxUmcA+WjSSR75P+EBeahe94z6/mLD8s9sc5F1y5c3eTOHmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4Zf3E6ptCFPJlfFiUbgEzpFlCvSDIr8Lq1oRc/Eu9AI=;
	b=MEzgMUkYTpzWeyGDZcMmBxdUu72V+8iYjB+Sr/FzbMAxTyft9X8350Ah4BV8CK0ybkx+
	 H3XXT/A2JGFrq7ZPM/prFGHuFmj0g9Ygh+v2lc4wT9JwHoNcnHGoGtXcEZVt+E0F+lYZk
	 uezgbVldFi9kehf/i9cUFdDW1kYX/f6gBHT4NrSKVoJW+fv9YJ2VBCgWxX31B4OJ1r18r
	 66aOPKC6/JOyZkX/SFMs1cWDKmzV6z0p5l09wib6wbdTsEXeRw+Y2WpvIe2ETkrQtmBgV
	 8efpuIxuQoLNXGd7sEnHBUaNj7JinnyP33fMTyKdp9bkwauFHrX1K3YJ9AD3IayeaEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFyJIRX0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDBD606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFyJIRX0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BA41F000D0;
	Tue, 24 Nov 2026 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795522563;
	bh=4Zf3E6ptCFPJlfFiUbgEzpFlCvSDIr8Lq1oRc/Eu9AI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lFyJIRX0XXYDLWwRxd6RWmlRdpNbJGTQvchUrYvc39xx9lOlep2j8pfLQbLOhg5iw
	 LdvNLuBv9cEeuH7SMkOGlpWTihZxmNcU8aTGvtqjNQSBYbKI7ilWLqrs/dJhFHuXO/
	 kTR6UeddljyR8fXyVh8ELQj2y49nNZSbIy+KFru73gNmdAHGxTJx+7SY8DKsyCFHxv
	 egRNMZisE747sZkLdsyl+vjg0McXAqbXfZ4EG7E56z+wMkq7D2KOf9wMgBhP1379q6
	 KbbbEhmuW+3EMV0Mfe8DO8uiRKrWgXpy9M21IWDieWq/E+5EC66wYBLVVH+ZWmfKp1
	 WetGDgNcYuQPw==
Message-ID: <sashiko-outbox-231117@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net: xdp: fix generic XDP on skbs without an
 Ethernet header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261123121540.275576-1-jiayuan.chen@linux.dev>
References: <20261123121540.275576-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:16:02 +0000
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
- [Medium] net: xdp: incomplete Ethernet check in
  netif_receive_generic_xdp()
--

commit 2ed38b0924ab170f5d151d7bc82023a0581fce18
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

net: xdp: fix generic XDP on skbs without an Ethernet header

This commit rejects generic XDP attachment on devices whose type is not
ARPHRD_ETHER or ARPHRD_LOOPBACK, and skips generic XDP processing in
netif_receive_generic_xdp() when skb->data - skb_mac_header(skb) < ETH_HLEN.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6140fd9d11cd0..df335f361706d 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5823,6 +5823,10 @@ static u32 netif_receive_generic_xdp(struct sk_buf=
f **pskb,
>  	if (skb_is_redirected(skb))
>  		return XDP_PASS;
> =20
> +	/* XDP is Ethernet only, skip skbs without an Ethernet header. */
> +	if (skb->data - skb_mac_header(skb) < ETH_HLEN)
> +		return XDP_PASS;
> +
>  	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
>  	 * bytes. This is the guarantee that also native XDP provides,
>  	 * thus we need to do it here as well.

[Severity: Medium]
Does checking for < ETH_HLEN still let skbs with mac_len > ETH_HLEN or a
non-Ethernet skb->dev->type reach bpf_prog_run_generic_xdp()?

On a VLAN device with VLAN_FLAG_REORDER_HDR cleared, vlan_do_receive()
pulls ETH_HLEN + VLAN_HLEN (18 bytes) and resets skb->mac_len to 18.
Similarly, if an empty bond or team device has generic XDP attached and
then enslaves an ARPHRD_INFINIBAND or ARPHRD_IPGRE port, skb->dev->type
changes and received skbs arrive with skb->data - skb_mac_header(skb) >=3D
24.

When mac_len > ETH_HLEN, the header-mangle fixup in
bpf_prog_run_generic_xdp() pushes ETH_HLEN (14) and calls
eth_type_trans(), leaving skb->mac_header at skb->data - ETH_HLEN while
skb->mac_len is still 18 or 24, which triggers the same skb_vlan_push()
warning on TC ingress.  In addition, xdp_prepare_buff() includes mac_len
bytes ahead of skb->data while bpf_xdp_adjust_head() only enforces a
minimum frame size of ETH_HLEN, allowing off > skb_headlen(skb) in
__skb_pull(skb, off) to underflow skb->len or hit BUG() when
skb->data_len > 0.

Should netif_receive_generic_xdp() check skb->data - skb_mac_header(skb)
!=3D ETH_HLEN as well as skb->dev->type !=3D ARPHRD_ETHER && skb->dev->type=
 !=3D
ARPHRD_LOOPBACK?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123121540.2755=
76-1-jiayuan.chen@linux.dev?part=3D1
