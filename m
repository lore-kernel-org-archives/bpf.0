Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487163E0C4C
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072290; cv=none; b=pPqJrA1aJIrRkdfrDp/1SsmGSDQfr8XAWH1GbS2x+LdC4omPf6dLeB7HKfofjj1OOBS/GQAXQdn4u389zUqsMb6Kw5SlIwhWLJuvCDki+8VkVMVTSA+skAdWWJydSXMBYFfb4ZlgpMapC0YKG/GJp5he2Uj9tol5A9nLgBw4Ewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072290; c=relaxed/simple;
	bh=W2KkZCdI6WcMGeLpxLSrWFa+EpYCHT5dTxj1AouCKFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e7+14KvBsKQpUUABZcGgWMUCudR/WeZH6ER0ckZ3ks0e0AoN9ImaAMqniNwm2v3X+YfG3XLulpwJJPE9aqcF1Gdtg3Zq+kuIi+1WaXbqhjB4r1mWc2o6yz57wU9XkXuM62lPFVHJ681XLug4fDM4IIDxJR1FRwzSc4DrE6WLHq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk/8DMpi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk/8DMpi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260961F00893;
	Fri, 29 May 2026 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780072287;
	bh=qABiexOGqrDgDerIicoQP3YAgOwpXJtY8jQVkBZjams=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hk/8DMpi/p37M03jZ3sSPbAIu9HPNTZ7T+pTygVkO6WdDSFJmDwYzadh7w42gc+cl
	 JMsdEr4a45qdH8yLWebg+BVfizqqGNXzkL4/M/tWa9zxj8en5QgeK5mE4dbIz1/IT+
	 NgM+HsMOdlWeih7opnSYUSc5CW4huWWDfBaWCGy2usUxoVOEgG0IJO/a130l6MF8pE
	 DmIala5KfpL8UjPa5Ua3BhUD6QchqH9qL84W/LzvnRe0LlbTZ7wVF1/zt7vNoC7x/R
	 6ufKri2kuTNrBummS1IZf3jeHdFZ9G5vOAyqOS3Ms7jVHUX3J/JRU+t9nhtahLO1UI
	 6ysBMwr5UJCdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 3/4] bpf: Update transport_header when
 encapsulating UDP tunnel in lwt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529151351.69911-4-leon.hwang@linux.dev>
References: <20260529151351.69911-4-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 16:31:26 +0000
Message-Id: <20260529163127.260961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch only updates `skb->transport_header` for UDP tunnels, le=
aving it stale for GRE encapsulation, which breaks hardware offloads (e.g.,=
 TSO/checksums) on modern NICs like `ice`.
- [High] `handle_gso_encap()` hardcodes the IPv4 header length to 20 bytes,=
 failing to account for IP options, which causes out-of-bounds reads when p=
arsing the encapsulated L4 header.
--

commit 069ecde1299856dcf6cef2dee89cb71a921e3024
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Update transport_header when encapsulating UDP tunnel in lwt

This commit fixes checksum offloading for encapsulated UDP tunnels in the
bpf_lwt_push_ip_encap() helper by updating the stale skb->transport_header.
Without this, hardware NICs like ice may compute incorrect checksums and
drop packets.

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index c306120e11d29..1d556dec94b4f 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
[ ... ]
> @@ -615,10 +616,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void=
 *hdr, u32 len, bool ingress)
>  		ipv4 =3D true;
>  		if (unlikely(iph->ihl < 5 || len < iph->ihl * 4))
>  			return -EINVAL;
> +		is_udp_tunnel =3D iph->protocol =3D=3D IPPROTO_UDP;
> +		if (unlikely(is_udp_tunnel && len < iph->ihl * 4 + sizeof(struct udphd=
r)))
> +			return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does handle_gso_encap() handle IPv4
options correctly when parsing the encapsulated L4 header?

bpf_lwt_push_ip_encap() explicitly allows IPv4 headers with options by
checking iph->ihl < 5. When a GSO packet is encapsulated,
handle_gso_encap() is called.

In handle_gso_encap(), the offset to the outer L4 header is hardcoded to 20
bytes (sizeof(struct iphdr)), ignoring the actual iph->ihl.

If a BPF program pushes an encapsulation header with IPv4 options, wouldn't
the next_hdr pointer incorrectly point to the IP options payload instead of
the GRE or UDP header?

This could lead to out-of-bounds reads or misparsing the L4 fields,
potentially misclassifying the GSO type (e.g., wrongly setting
SKB_GSO_UDP_TUNNEL_CSUM) which leads to incorrect offload processing or
dropped packets.

[ ... ]
> @@ -641,6 +648,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>  		skb_postpush_rcsum(skb, iph, len);
>  	skb_reset_network_header(skb);
>  	memcpy(skb_network_header(skb), buff, len);
> +	if (ipv4 && is_udp_tunnel)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + iph->ihl * 4);
> +	else if (!ipv4 && is_udp_tunnel)
> +		skb_set_transport_header(skb, skb_network_offset(skb) + sizeof(struct =
ipv6hdr));

[Severity: High]
This isn't a bug introduced by this patch, but does this leave the
transport_header stale for GRE encapsulation?

bpf_lwt_push_ip_encap() permits pushing IP encapsulation headers with
IPPROTO_GRE, but this only updates skb->transport_header when is_udp_tunnel
is true.

For GRE packets, the transport_header remains stale and points to the inner
packet's transport header. The ice driver (and others) handles GRE and UDP
tunnel GSO offloads by calculating the outer L4 header length as:

skb_inner_network_header(skb) - skb_transport_header(skb)

With a stale transport_header, this driver length calculation evaluates to
(inner_network_offset) - (inner_transport_offset), yielding a negative
value. This large unsigned length exceeds ICE_TXD_L4LEN_MAX, causing
hardware offloads to fail and the packet to be dropped.

>  	bpf_compute_data_pointers(skb);
>  	skb_clear_hash(skb);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529151351.6991=
1-1-leon.hwang@linux.dev?part=3D3
