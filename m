Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F571156C6A
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618271; cv=none; b=uXFkDKkM4dO75pfBPxu9D7HPJqby5C7vrlnJcD208l7Zw5Rjl5EJjQ7Z1mPs4UOFKfG5sixokup0d0IzXMl4M3BUuVg1Yo8RrAJ54xuM7Cz2zIigyelSSnw0YUYuk5bEXf7pBWqcjnKCgn1w7msVVAgikhNRUAP4WJHXxFG8cJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618271; c=relaxed/simple;
	bh=59WPYPGZ9IJaHut0kcbxE/MMGXkCFSaJojC/tsLOv1I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bTKZsZ/xeV48ZNHm/Lgksq4sTYvUz2X6kayUrW8vNvGDEd0aOw/l8oTJK69tVTQkTZe8vAjz0B3SIZ3P8q5F35wvnFGQRVWa5zad3Hx4pm6rjblHpfli5hLzBkePnsaSlDMvHWFUBm1h+UEiQIqczxqs77G8fwmqwB+8gGF2dTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHjk4gWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHjk4gWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496401F000FF;
	Thu, 17 Sep 2026 04:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789618270;
	bh=gMdwNoX3inqczGglqVxZnaDK8y0PDHeKrPryqRVWtYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mHjk4gWeZO1jN0UfWNXol8vys8zX5Jm7FegnwRFKSW9wIoQoM2mlIZbKkjGad61A7
	 gR+3fMtuRHK6k4JnxzZs2LMIPYVvgJeBAYD5fiQwWCDCgKKY00tWwTD4WnW0VoM3GS
	 yYacRkrceMqvdp4liWNBQ6qE9LfjK3zQZ6AenC3kYHXfR0V7NErUTCa0KIbsBYGG7D
	 PQOBD8V49l/DLi5ISkHsIhJ43/3ZxhnHsWSFCdWNNU1oNYdCyQUCu7Dkvc0CEzigJ+
	 h9TnHvPse2XRnxoZP20dFAbP2zQ3g+bTGxdgekKbKzYBcIzGEdpL/OZ4lkQ6JGeueQ
	 bu+LBqlI6ASQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] bpf: lwt: clear stale IP control block after
 pushing an encap header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiang Mei" <xmei5@asu.edu>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260916041102.1914333-1-xmei5@asu.edu>
References: <20260916041102.1914333-1-xmei5@asu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 04:11:09 +0000
Message-Id: <20260917041110.496401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: type confusion in bpf_lwt_push_ip_encap drops VRF associati=
on
--

commit ca07a1fe3610a67c27699bc32edbe202fd703034
Author: Xiang Mei <xmei5@asu.edu>

bpf: lwt: clear stale IP control block after pushing an encap header

This patch clears the stale IP control block in bpf_lwt_push_ip_encap()
after pushing an encapsulation header. It zeroes the options for IPv4
and re-initializes the control block for IPv6 while preserving the iif
and l3slave flags to prevent out-of-bounds reads.

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index da49364ec63de..17be476b57172 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -649,6 +649,18 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>  	if (ingress)
>  		skb_postpush_rcsum(skb, iph, len);
>  	skb_reset_network_header(skb);
> +	if (ipv4) {
> +		memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));

[Severity: High]
This is a pre-existing issue, but does this leave the IPv4 control flags
uninitialized when encapsulating an inner IPv6 packet with an outer IPv4
header?

The memset clears the IP options (offsets 4-43 of skb->cb), but leaves
IPCB(skb)->flags (at offset 44) untouched. For inner IPv6 packets, the
control block was inet6_skb_parm (24 bytes), so offsets 24-47 were never
cleared during ip6_rcv_core() and might contain arbitrary garbage from
previous layers.

Could the outer IPv4 packet inherit this garbage in IPCB(skb)->flags,
potentially setting critical routing flags like IPSKB_FORWARDED,
IPSKB_XFRM_TRANSFORMED, or IPSKB_L3SLAVE randomly?

> +	} else {
> +		bool l3slave =3D ipv6_l3mdev_skb(IP6CB(skb)->flags);

[Severity: Medium]
When encapsulating an inner IPv4 packet with an outer IPv6 header, the code
evaluates ipv4 as false (since the outer header is IPv6) and reads
ipv6_l3mdev_skb(IP6CB(skb)->flags) to preserve the VRF association.

Because the inner packet was IPv4, does IP6CB (offset 16) alias with the
inner packet's IP options (IPCB(skb)->opt) rather than actual IPv6 flags?

This type confusion means the legitimate IPSKB_L3SLAVE flag of the inner
IPv4 packet (at offset 44) is completely ignored, and the l3slave variable
will always evaluate to false. Does this cause the packet to silently lose
its VRF association?

> +		int iif =3D IP6CB(skb)->iif;
> +
> +		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
> +		IP6CB(skb)->iif =3D iif;
> +		IP6CB(skb)->nhoff =3D offsetof(struct ipv6hdr, nexthdr);
> +		if (l3slave)
> +			IP6CB(skb)->flags |=3D IP6SKB_L3SLAVE;
> +	}
>  	if (is_udp_tunnel) {
>  		size_t iph_sz =3D ipv4 ? iph->ihl * 4 : sizeof(struct ipv6hdr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916041102.1914=
333-1-xmei5@asu.edu?part=3D1
