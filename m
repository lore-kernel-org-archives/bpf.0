Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753A33B6DA
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067622; cv=none; b=B959mcTb0jXuSFIZPvOazMbdkXglYJV20Dz7eQDwykn1tAEmb1Y8lcq0TvYLk2DZ+kOVGj4P4hL0MiijtHlSIMg1BZtxVdEuwvQyeZ7KVcEe9xHNYv8++KYYLZtxsKq1maJLgSpPcMZR4aPvP+jvIrkYrXLcJ8+HpOsXd6H01Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067622; c=relaxed/simple;
	bh=s0LirhyID40okBoex45trSkQrlNtfD7qZqmO76aKLuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oH/Ly5cUApgzu1Alo/Be7V0tUQ6QMBlzHVW7lrl/aetMAPrCjlSVs2zRwsELMV9mUw1JTyEVOKlqJtBEr8mKXJZyJs2SqsH4BUUXQJBegFSJ+AysTPI6WMaNlk/65aQHodilglLCL49Hri7kK+lm+jfXvEjHtjOgdrn6jHXO2KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3gOhs0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3gOhs0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749521F000E9;
	Tue, 18 Aug 2026 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787067620;
	bh=7JGvx3ZZYmBKKDQZVuHfBuWZpM7glZTmAP68NdyFB/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c3gOhs0tQFQ4qqEXC3s6TyTgLUnjYwL2Zvh1utvf8nid0m53qS7mnmDDK7B4z13bg
	 Q7c3SdqihsIrje9Mprx0Ug8DcOXMleGFLJQQxYUN9vaw0CBogGXALb7dwS1fMaSMlr
	 H+7pw3rMDFjhYjyE3hBrEJWJAX3VvpXq2vBBMuuwHATl5Mn8kawc0j0BlK5sPyqX+n
	 TOqN18KHqs21no18qmz3eXzM+Lgj9hiPKFvKx/Wtshjv5RPeKRynImY2JGfx6fVGud
	 hSDXiOsBiOJVRk//dKeIzXfogdDOF9eqSkrR/BDDuTJijPujfxj8QA8lSMV6oE/Tjn
	 mfp1TW1sUx7xQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] xsk: reset the mac header in the generic Tx path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Petr Oros" <poros@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817153957.3177627-1-poros@redhat.com>
References: <20260817153957.3177627-1-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:40:20 +0000
Message-Id: <20260818154020.749521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix leaves skb->network_header and skb->transport_heade=
r uninitialized in generic XDP TX, causing out-of-bounds reads during check=
sum offload.
--

--- Patch [1]: [PATCH net] xsk: reset the mac header in the generic Tx path=
 ---
commit 28a4ae00fcc18f8550bef3cea318942f60fe0720
Author: Petr Oros <poros@redhat.com>

xsk: reset the mac header in the generic Tx path

This commit fixes a bug where AF_XDP generic Tx leaves the MAC header
uninitialized, leading to out-of-bounds reads in drivers. It sets the
MAC header in xsk_skb_init_misc() to ensure the pointer stays in bounds.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7855ee09c4b64..885427392cb6b 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -931,6 +931,7 @@ static int xsk_skb_init_misc(struct sk_buff *skb, str=
uct xdp_sock *xs,
>  	skb->priority =3D READ_ONCE(xs->sk.sk_priority);
>  	skb->mark =3D READ_ONCE(xs->sk.sk_mark);
>  	skb->destructor =3D xsk_destruct_skb;
> +	skb_reset_mac_header(skb);

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but does this incomplete fix leave skb->network_header and
skb->transport_header uninitialized?

If a userspace application uses an AF_XDP socket in generic TX mode with
the XDP_TXMD_FLAGS_CHECKSUM metadata flag set, xsk_skb_metadata() will set
skb->ip_summed =3D CHECKSUM_PARTIAL without initializing the network or
transport headers.

When the packet is passed to a NIC driver (like ice) that processes
CHECKSUM_PARTIAL, it reads skb_network_header() and skb_transport_header():

drivers/net/ethernet/intel/ice/ice_txrx.c:ice_tx_csum() {
    ...
		ip.hdr =3D skb_network_header(skb);
		l4.hdr =3D skb_transport_header(skb);
    ...
}

Because these headers are never initialized, network_header remains 0
(pointing to uninitialized SKB headroom) and transport_header remains ~0U
(65535 bytes past skb->head).

Could this lead to out-of-bounds reads when drivers dereference these
pointers, requiring us to safely anchor or parse the headers here as well
(for example, via skb_probe_transport_header() as was previously done for
AF_PACKET)?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817153957.3177=
627-1-poros@redhat.com?part=3D1
