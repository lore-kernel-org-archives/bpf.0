Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887774;
	b=nwGq9aTDyGvmteg2L7TVdPYQLXfE9YFNepSjs4ZzADpirAEeqUBR8eQle7k884H2Nuk4
	 Od++CTwaW48XnFSJlp+gNe3VbFRmLSaCx3GbJq9q9XW29UNsJe1MXJh5VEAF+6l/PtrMC
	 Vw/vzfUYuUtTsBf+PqU+glB6TJmX0b0pZoOpJnpRiHEo28w/TD/RqkXzo3ET5Kh/UK8QA
	 JegXNhxuPjR5cJmcyXXxRRTTzFf2LYVj4GFHOVDs5vj7W/7TJI0EJZWoLDkR0oL79JWDV
	 JpiZ1A1nVFvFw6XpSP5sbXytlxD6EXOdK/9dhGNbFQV7/e7siCo+xQfWAi2CAn41SAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=jzTzN1xi3wWq3rkQo05baaXe4YaAa7XUzbwyEbAc0TE=;
	b=uxUmwi70sQwZrS1x9FV4zTXyZk11Qsgy+E2rvM28H2bmLJKhzZX8MrCs1gIDwntoMNFj
	 QbwuOseC7PGAZuwMu4v/mvQwLJvLVD6AgLe6uyrvhNfSM4IWvSEOZ98ZWftG3auezHc9a
	 q8olL0gsehlDvRno+PsaW1njrZWbG4YNBfoZqc2gx0RGAYoSeGViMkpeHyw8tCN5HM+Vd
	 30QRRRcfXY6dF+gDTr/xuFbLQEuFupman80/5p8pLhtOPFSSlLngNkqFUP8xTdux3sIm5
	 8hyhARlnHxWUEfQtM9xkNKU97GpZ39tZixwNC6yRU3HZAFJ4h/wuuZC4yKg6UB3IhgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cDOXOJ7;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C7606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 14:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B7C7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0cDOXOJ7
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67c00f291e1so984175d50.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 06:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793887773; x=1794492573; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jzTzN1xi3wWq3rkQo05baaXe4YaAa7XUzbwyEbAc0TE=;
        b=0cDOXOJ7kU44pN3CSsJC7LBttdhxXbKwXqvZzda7pHXStgvvBzFoKR4rfQ6uRpzano
         LqGpNPg3W+CWu4WnyQkkbdSjRVXu+jvbvdx7LlzpaLxR3UBCncfBpxp7F1bVC1zR+7KP
         tOpqvK21hn3041JvnCXOIHZ1DQ5S6efh+xzD106W6QtWm527wUoE+KbI3Pdx4pboCUeH
         J7c0+EJi+hdBXYKg14ZCJ4Ab8oTgUC5Gw4DUJ4Tani6wz1FCcrxCBb2CybU5Tt8NB3w9
         r7i4x3Fi0TP87AzY+Xgmvr0Itmnv4T5QoEgJdD1/ShixhE8u4yftXQKAkHFGDsmbERx0
         3s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887773; x=1794492573;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jzTzN1xi3wWq3rkQo05baaXe4YaAa7XUzbwyEbAc0TE=;
        b=0fbf7mVidjfGVV2PdP2nq/0J8lGlEwyCoirrMw2hL93Yd9Y8vSQ2mnVzxy8OvBMSLa
         sGX1+p/IJ4MU0b8DJwlReJfSwoGs77/rBAvMucOV3fO3NW9MiIJMCvP4i9cZPYnx9oh1
         XDGlVQa5g8Cd+apsOvdQpDyXspXlH3C2sFzs47q6hCIWu79EQdCrA0NhIpYmgjl0FC/a
         w3A61xtdoNyL4mmEARZa77vDPf4ldDTS/YiR3L5AC8ajD7p9WZCuQqNTi1SgLJ7bHhAW
         kVhofPOybkMdecPt+PESGvriQi3+kqWeZmEBzIeEpOEgCsQgv7qT9cS/1luSVNlz0x5b
         5/HQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcOdauMjVpol3os38zt9ZDmZZf7MPC/S2Ue3qR+yYyzmti+pmjJkGrzzF0Tnmz1fekV78=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LV1ifoBGKHaONsD2bfoWoFdgR59xjfE4BaUM+qkDP5j1oMRRl
	2364ZVhBPAx3ImTMetGAfqYIRzBy1ONTC2R71ZbMIeDL7obv6hc8qUHo
X-Gm-Gg: AYBFou28R8BkM+8vZ4GgUq4V9lU3fEV/jZMABv6dSlQW56Z8DWLx76EYHpfIPgy7IqB
	apMf1UpgJ0gh0rwd81vXK5JaJ9KiqZFv6EYygwOVVkAC1eN6Se/ikPVRfYR2wAEI7P5GL3WcjlY
	tMwqtsh4QMIhfCRnCCZe1VTsOu5GGUyWV6oTgXFQV9VB0SsTwwMxQ3SDQzy61lTcDWsh5ruQwW1
	gG6HONwxYZSvIFBDequPSCXHI3oGMux15YBQNFDv+wMxMAnAUdWLZbMHF6ntFmrOw/ptJpuBu4V
	FxH+o+ncsNM1uVKG0yeW16wCztfWdAR/sHjZWIzsvSl+6+DV2J8MvfTBTEjaUMKDoml5EI0zeXw
	VUmqbEKuuR/gMxDYNJUvWXk1hFdHbfp4AmQMTeJ3rjX4GN8GC+SPxA0l/E4BEgSa1I3KxBW03o8
	a1teU42a1fHIcGx2+EZazJYdnUtE33U+2cWz6dC5KVOPjtiGrc7ojrqbdD193VPSgll1FaBaQjL
	NVGum4+CBaX1/R68liC4xWASNEE25ntXl//l9qITtF9jDPFkXE3UWHh+5+fSJzAqnEm/ukXIQ0v
	LcvJROfDH5xRBMCJrcXc3cTvo922n90IjQ==
X-Received: by 2002:a05:690e:1444:b0:679:b98d:9b7f with SMTP id 956f58d0204a3-67ba4c82e34mr11758102d50.11.1793887773314;
        Thu, 05 Nov 2026 06:09:33 -0800 (PST)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309712e33sm40372397b3.4.2026.11.05.06.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 06:09:32 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 09:09:26 -0500
Message-Id: <DMNC538FF7AS.2JZQJXNEZG6P6@gmail.com>
Cc: "Simon Horman" <horms@kernel.org>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Daniel Zahka" <daniel.zahka@gmail.com>, "Willem de
 Bruijn" <willemb@google.com>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net v2 1/2] net: Make PSP skb extension survive packet
 scrubbing
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Wei Wang" <weiwan@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.21.0-threadmapfix
References: <20261030043145.2185700-1-weiwan@google.com>
 <20261030043145.2185700-2-weiwan@google.com>
In-Reply-To: <20261030043145.2185700-2-weiwan@google.com>

On Fri Oct 30, 2026 at 12:31 AM EDT, Wei Wang wrote:
> skb_scrub_packet() drops all skb extensions unconditionally via
> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_rcv,
> etc.) and virtual device forwarding/redirection (dev_forward_skb,
> netkit_xmit, skb_do_redirect).
>
> When a virtual device such as netkit is associated with a PSP device in
> another network namespace via PSP_CMD_DEV_ASSOC, incoming PSP packets
> decapsulated by psp_dev_rcv() lose their SKB_EXT_PSP extension when
> scrubbed during redirection into the peer netns. Without SKB_EXT_PSP,
> __psp_sk_rx_policy_check() rejects incoming TCP data segments at the
> socket layer with SKB_DROP_REASON_PSP_INPUT.
>
> Introduce a static skb_ext_scrub() helper in net/core/skbuff.c to
> preserve SKB_EXT_PSP across skb_scrub_packet() while dropping all other
> extensions. If SKB_EXT_PSP is not active, skb_ext_scrub() simply calls
> skb_ext_reset(). If SKB_EXT_PSP is the only extension in the skb_ext
> buffer, nothing needs to be scrubbed. Otherwise, save the PSP metadata,
> reset the extension block, and re-add a fresh SKB_EXT_PSP extension (or
> clear skb->decrypted if the allocation fails).
>
> Fixes: 06c2dce2d0f6 ("psp: add new netlink cmd for dev-assoc and dev-disa=
ssoc")
> Link: https://lore.kernel.org/r/20260910-bpf-meta-inside-skb-ext-v2-3-0b2=
1e42180b0@cloudflare.com
> Reported-by: Daniel Zahka <daniel.zahka@gmail.com>
> Closes: https://lore.kernel.org/netdev/DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail.c=
om/
> Co-developed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Wei Wang <weiwan@google.com>
> ---
>  net/core/skbuff.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 93c2f440b9ec..5c4a2e982ebc 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6369,6 +6369,32 @@ bool skb_try_coalesce(struct sk_buff *to, struct s=
k_buff *from,
>  }
>  EXPORT_SYMBOL(skb_try_coalesce);
> =20
> +static void skb_ext_scrub(struct sk_buff *skb)
> +{
> +#if IS_ENABLED(CONFIG_INET_PSP)
> +	struct psp_skb_ext *pse =3D skb_ext_find(skb, SKB_EXT_PSP);
> +
> +	if (pse) {
> +		struct skb_ext *ext =3D skb->extensions;
> +		struct psp_skb_ext tmp =3D *pse;

I would move the copy just before skb_ext_reset(skb), but it probably
won't make a difference in the generated code.

> +
> +		/* Nothing else to scrub if PSP is the only extension in ext. */
> +		if (ext->chunks =3D=3D SKB_EXT_CHUNKSIZEOF(*ext) +
> +				   skb_ext_type_len[SKB_EXT_PSP])
> +			return;
> +
> +		skb_ext_reset(skb);
> +		pse =3D skb_ext_add(skb, SKB_EXT_PSP);
> +		if (pse)
> +			memcpy(pse, &tmp, sizeof(*pse));
> +		else
> +			skb->decrypted =3D 0;

Agree with sashiko not to clear decrypted. It would at least prevent the
skb from being forwarded cleartext back onto the network.

> +		return;
> +	}
> +#endif
> +	skb_ext_reset(skb);
> +}
> +
>  /**
>   * skb_scrub_packet - scrub an skb
>   *
> @@ -6380,7 +6406,8 @@ EXPORT_SYMBOL(skb_try_coalesce);
>   * operations.
>   * skb_scrub_packet can also be used to clean a skb before injecting it =
in
>   * another namespace (@xnet =3D=3D true). We have to clear all informati=
on in the
> - * skb that could impact namespace isolation.
> + * skb that could impact namespace isolation. Note that PSP skb extensio=
n is
> + * preserved across packet scrubbing by design.
>   */
>  void skb_scrub_packet(struct sk_buff *skb, bool xnet)
>  {
> @@ -6388,7 +6415,7 @@ void skb_scrub_packet(struct sk_buff *skb, bool xne=
t)
>  	skb->skb_iif =3D 0;
>  	skb->ignore_df =3D 0;
>  	skb_dst_drop(skb);
> -	skb_ext_reset(skb);
> +	skb_ext_scrub(skb);
>  	nf_reset_ct(skb);
>  	nf_reset_trace(skb);
> =20

The only thing I would say is that skb_ext_scrub() won't scale if a
second extension comes along and wants the same treatment as PSP. In
that case, either we could make a bitmap of "no scrub" extensions and
then use the same approach of allocating a new ext block and copying
them over, or the original approach of skb_ext_del() could be used after
changing the reference counting scheme for the special extensions in the
release path of __skb_ext_put(), but that is a more intrusive change.

I'm ok with the approach from a PSP perspective:

Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
