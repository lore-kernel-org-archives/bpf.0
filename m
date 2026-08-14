Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11773E00A5
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786707188; cv=none; b=uvhIHiyH1C94DgVndA60Eo93lE1XdKvZugIfcK95H1j7KRRP9UIEYK1mq8qw/i5vgn5+9T5q82BZ+6s+OHdlI8/5IPlbUHL/kU7DQkSsOkEPIc2PR25yrep3RsWQczTrWIi5NCCKmoKba1RBICfl0TMJm8sSxoTTXg7qBeDRm7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786707188; c=relaxed/simple;
	bh=E93JJVv0HIa7Ld/PHDmd+uYofOnyl8C/NjPhh00o5wY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sX4FHDYtRCwRzEboZ3ks/4IWrMNW023JZqGUCUr2fJ3Jsy66ZMFUzaJqJxB4HSTp0MMySgG2Iy+IcPLObLbd/pnefby3d/jXuN+yDzlKIdzDOyOAEjhsbO/09kT9l58K/NiaUMGX1i0SWqv1CXXQG7DAGsQcQnn/12NKnEw1HvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5uSDWW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5uSDWW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21941F000E9;
	Fri, 14 Aug 2026 11:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786707184;
	bh=X/zswRr4bMxTSL7uTgHRpHY+XJQvuxPSpcQCvwyU3Es=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5uSDWW/iJ+Pkqaq/zKn5JSHKGyKelNNymY3rYtq8wzsszkk8jcuql4ms9uz1FNtG
	 stpevfRK8ygDIbWHFepQh0Oh41cCDCA1ka3bLNPCiRIi+ZqfOsFGf9Jr8zVYqayY47
	 zQkmqSuy3fuZDs1ctOVGnccNY2Qx4FZSuWjVQ5H28MSpNwRZBLscoeTD/cwC8/Nnyv
	 sWtd5obYsNKviN+8uYfcIfFXT1TmbqsuMZWaADVCkIwHAtl9tLD1cyx4OAOLB0gXSW
	 vZsuX3feFrMXxIEoSH9DDG81081gjun3wGChkcP5UsLMhUNtXY8K7ibjHGWwfkupNu
	 zxl8fdUsRw0qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net: xdp: don't assume an Ethernet header in
 generic XDP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813113229.381136-1-jiayuan.chen@linux.dev>
References: <20260813113229.381136-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 11:33:04 +0000
Message-Id: <20260814113304.B21941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect SKB length and tail pointer calculation after generic XD=
P tail adjustment.
--

--- Patch [1]: [PATCH net-next] net: xdp: don't assume an Ethernet header i=
n generic XDP ---
commit 3332d9a3f6b94e19ff995230c0e36bef6be765df
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

net: xdp: don't assume an Ethernet header in generic XDP
   =20
This patch fixes generic XDP for L3 devices (like tun/tap or ARPHRD_NONE)
that do not have an Ethernet header. It skips Ethernet-specific checks and
header adjustments when the SKB does not carry an ETH_HLEN sized L2 header.

Link: https://lore.kernel.org/bpf/20260812043643.808295-1-kennethbwlee@snu.=
ac.kr/

> diff --git a/net/core/dev.c b/net/core/dev.c
> index fd0b445f5d38c..81de25a2b421d 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5519,10 +5520,21 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb,=
 struct xdp_buff *xdp,
> =20
>  	orig_data_end =3D xdp->data_end;
>  	orig_data =3D xdp->data;
> +
> +	/* xdp->data only points at an Ethernet header if this skb actually
> +	 * carries one.  Devices with a different link layer (mac_len =3D=3D 0
> +	 * for ARPHRD_NONE/TUNNEL/RAWIP/PPP/..., IPOIB_ENCAP_LEN for IPoIB)
> +	 * have nothing to inspect here, and must not have skb->mac_header
> +	 * relocated by the ETH_HLEN fixup below.
> +	 */
> +	has_eth =3D mac_len =3D=3D ETH_HLEN;
> +	if (has_eth) {
> +		eth =3D (struct ethhdr *)xdp->data;
> +		orig_host =3D ether_addr_equal_64bits(eth->h_dest,
> +						    skb->dev->dev_addr);
> +		orig_bcast =3D is_multicast_ether_addr_64bits(eth->h_dest);
> +		orig_eth_type =3D eth->h_proto;
> +	}
> =20
>  	act =3D bpf_prog_run_xdp(xdp_prog, xdp);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but looking at how xdp->data and
skb->data relate to the MAC header, could there be a tail pointer calculati=
on
issue when bpf_xdp_adjust_tail() is called?

Before bpf_prog_run_generic_xdp() executes, the MAC header is stripped via
__skb_pull(skb, mac_len), leaving skb->data pointing at the network layer.
However, xdp->data is initialized to point at the MAC header.

If the XDP program adjusts the tail, the new tail pointer is updated further
down in bpf_prog_run_generic_xdp():

	/* check if bpf_xdp_adjust_tail was used */
	off =3D xdp->data_end - orig_data_end;
	if (off !=3D 0) {
		skb_set_tail_pointer(skb, xdp->data_end - xdp->data);
		skb->len +=3D off;
	}

Because xdp->data_end - xdp->data includes the MAC header length, but
skb_set_tail_pointer() applies this offset relative to skb->data (which is
already at the network header), doesn't this push the tail pointer mac_len
bytes too far past the actual end of the packet?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813113229.3811=
36-1-jiayuan.chen@linux.dev?part=3D1
