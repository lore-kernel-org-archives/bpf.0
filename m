Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795489420;
	b=shmJf1o/0wgJC/JdIcOn7Ng/2eYw/acyR+sJcGGv3/Z4J1+jCDozzhj0wVlFw3NFoltS
	 EFVj1/TKWbBepRczyPDCCDYwB+l47KF6yE7Umxg/dUM7KKgKuPoxWv08kpvXfn0cGikeN
	 6473G9oxacRoNyC+ynzQHuOvhvJvWdTTi/jeSoC6fO4NVf3FzZb4HxiWfU4Tz4On3Z7RU
	 0S6su2Q5fdbsnWNv6o9/j9RH9aQcXZ9hY269xZvqq3Eb6JeKxTWoQPSk3rQ8V2QpZyqnl
	 Qw+ubjPRVP1rMmOfo3dAZhlB8GQprLkQcpGu33Qx+pyo0Sb7/wdJZYo75LqFzhZUBxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795489420;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QtOO178Xl6HCtpiOteX/ptXW459o9pIRF2Md167GErQ=;
	b=i5q19CYV8geCvli8ssHFnibO86sOMArlbH+JBFR/EzCl1kuqF8+g3+jRq3WpRrsf15iy
	 FbShdTvcEkBlZTYM2BsVyyspvaWVU+XfawSUEbAQxwApF2creKuH/54V/N00B6VorKk+m
	 /nYqj169jdrWZ/h14+hiQc7+OYiWbny+bw0r0vt7eMiK1tGlPvS6tZjV6pJtMrseQ1tEz
	 /Jv0iw0uosnvumhwowCOvr+pTuJsIHNTwSks82UhgODSqjvJ/6Cg78X6orDuHRCMew09V
	 bnG9iLgkYx9IjcgQ1G199fJddGXjCEIyA9b4rJRCRDX+9l0oaCccVTgHCdEbaRcuUhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8Hgok7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B910D606A31E;
	Tue, 24 Nov 2026 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8Hgok7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02331F000C4;
	Tue, 24 Nov 2026 03:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795489420;
	bh=QtOO178Xl6HCtpiOteX/ptXW459o9pIRF2Md167GErQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c8Hgok7HkJgGYEstz6ua34gOCO2URWkpB6P9ViYTpCgnFOxb5m7Sx2F/am7iCwWA2
	 pX9aX7R8jNMh6EZp94jDqfj1w+UuBn/BtvdBsM/cqosa019/6bcctUcQBXAo/Y5Aju
	 5e6TubAQCdTLwwdRIFZMUf3Drs8s2YrlE+AVf4PGQfBvHapDaLvBF9T3cCBMOLOV8d
	 lTsHvsnFAEwQhR1uLQNcKZ4pJkriA5pKVDGGTWT3xRKEvJkbZ+Zie09RCKVSTsG8gX
	 GkqNbCHbk+xmffxOtfCw/5b9Cgx/8WGkAg8RTF40gG9bcFsOU9MODgtPI1pvOM2XrE
	 GN2370hlM1R7Q==
Subject:
 Re: [PATCH net] net: keep skbs with a prefetched socket out of gro_cells gro
From: netdev-bot+sashiko@kernel.org
To: razor@blackwall.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 kafai@fb.com, joe@wand.net.nz, daniel@iogearbox.net, bpf@vger.kernel.org
Date: Tue, 24 Nov 2026 03:03:39 +0000
Message-ID: <179548941922.3135.9577858774980848901@kernel.org>
In-Reply-To: <20261121160204.4024204-1-razor@blackwall.org>
References: <20261121160204.4024204-1-razor@blackwall.org>
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

- [High] The fix is incomplete.

--

net: keep skbs with a prefetched socket out of gro_cells gro

This patch makes gro_cells_receive() send skbs that carry a prefetched
socket from bpf_sk_assign() to netif_rx() instead of the GRO cell. The
goal is to stop GRO from clearing skb->sk and skb->destructor on merged
skbs, which leaks one socket reference per merged skb.

> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> index 31352cac355ce..4e8b9c3cd7da0 100644
> --- a/net/core/gro_cells.c
> +++ b/net/core/gro_cells.c

[ ... ]

> @@ -26,7 +27,8 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
>  
>  	skb_unset_transport_header(skb);
>  
> -	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
> +	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev) ||
> +	    unlikely(skb_sk_is_prefetched(skb))) {

[Severity: High]
Is matching only skb->destructor == sock_pfree enough here? An skb that
got its socket from bpf_sk_assign() can still reach gro_cells_receive()
with a different destructor that owns one sk_refcnt reference per skb.

One path: bpf_sk_assign() at tc ingress attaches a non-refcounted socket,
such as a TCP listener or a UDP socket. It sets sock_pfree and takes no
reference. ip_rcv_core() keeps it. Then an NFQUEUE rule matches the outer
ipip/gre/esp packet, and __nf_queue() converts it:

net/netfilter/nf_queue.c:__nf_queue() {
    ...
	if (skb_sk_is_prefetched(skb)) {
		struct sock *sk = skb->sk;

		if (!sk_is_refcounted(sk)) {
			if (!refcount_inc_not_zero(&sk->sk_refcnt))
				return -ENOTCONN;

			/* drop refcount on skb_orphan */
			skb->destructor = sock_edemux;
		}
	}
    ...
}

After an NF_ACCEPT reinject, the packet is decapsulated. With !xnet,
skb_scrub_packet() does not orphan it, so the skb arrives here with
skb->sk set and destructor == sock_edemux. skb_sk_is_prefetched() now
returns false, and the skb is queued for GRO.

skb_gro_receive() then clears both fields on each merged skb without
calling sock_edemux():

net/core/gro.c:skb_gro_receive() {
    ...
	/* sk ownership - if any - completely transferred to the aggregated packet */
	skb->destructor = NULL;
	skb->sk = NULL;
    ...
}

The frag_list merge path in the same function does the same thing.
gro_list_prepare() still allows the merge because p->sk == skb->sk.

Wouldn't each merged skb then leak the reference that __nf_queue() took?
That is the same socket and netns teardown leak described in the commit
message.

The tree already has a general rule for this in skb_prepare_for_gro():

include/net/sock.h:skb_prepare_for_gro() {
	if (skb->destructor != sock_wfree) {
		skb_orphan(skb);
		return;
	}
	skb->slow_gro = 1;
}

veth_xdp_rcv_skb() calls it before napi_gro_receive(). Could
gro_cells_receive() divert or orphan any skb that still has skb->sk set
with a destructor other than sock_wfree, rather than checking for
sock_pfree only? Checking skb->sk directly would be one way to do it.

Separately, the "sk ownership - if any - completely transferred to the
aggregated packet" comments in skb_gro_receive() look wrong for
destructors that hold one reference per skb (sock_pfree on refcounted
sockets, sock_edemux, sock_efree).

>  		res = netif_rx(skb);
>  		goto unlock;
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261121160204.4024204-1-razor%40blackwall.org
