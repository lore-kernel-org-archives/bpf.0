Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793673480;
	b=LrKMtzbxFpMrEc7v580Rsv3zFGlv4zRx94J85vSfz0Oq3xjsJqX+logXt3h7i/QzTS4/
	 +3NfeD4VquOk0ukTjvpekKznEiknFhCZ/lRrgExkm070N1BB284W8/LctC4qnoZ66bJMX
	 CTjXv6bUF5kxJi5WYisfsEswJ8qQZ66H7ztI3C9+KCZk3YtbO3y5X3d4Q4Firz6CXl5r3
	 tzKblmSNVpkt1BugZOn4jDjkGWgNYcDKr74gC/1SByih2dqvug7P3LErfhGdgKlvsoW9J
	 yUaB31cYu5j0Fh4CBlIXV+NxL6IZZXwKuK4CQAiemuMIX3bpaNC9PJ9REuPaB/WczpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673480;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0sRD0l57hfFVgwi/g0tAS1yR0jpVl0PruXeq1WJE2ek=;
	b=oLmEyilf7cwwAbfK1VOMRghJAomf7K3cVjahmCDaz05XtzAZF7il1GxHKf7NeSlnV5G/
	 wq/UCgVfYL9phhjGGb+6rJg+PT+3+TikduKVzfgFnPFx/rIzJjCN5zM+exlRyM5ToD4K+
	 zE5J3Y2bcbunywbNv0cahoDr97jqkhNCOeZ+xCk1UwNO2ErBPiYf/QS/l4ljbqgQWn+2/
	 mtcCTCYymVwD5mK/wid8atDVu4r1rjeyCCyJC+d4V4LcUwEP7wyJjMcx9UirwuKquAqBK
	 2bmd1UJ/azUi604CpX3OZdOft4GUmcukBpSqoKp+ojabnv7NyaIWPC7cBT/AcsNTqpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BPouTgqF;
	arc=none smtp.remote-ip=91.218.175.26
Received: from mta0.migadu.com (out-26.mta0.migadu.com [91.218.175.26])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DC606A33B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 02:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B30DC606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BPouTgqF
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YB1TgEsc5rIC0KVTq3a2dIhsapr6DQo3zVEdWup7xnE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793673476; v=1; x=1794278276;
 b=BPouTgqFgshjAvhj6sxurvqh1w/QHAmPKM+joIfs4B3j7ii59pHmukgTYDqDVQ/2GHfqzxAO
 qS3cX3U0tkj3jplgCBeU42e+Z7ekg+mAPd2hm8c/SKoaC3ikbaNc5mbpeRJDhq3XFJCyWkYrtZa
 +UnphlWtrr6ojt2ZNHRm6w+4=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 35c4c235a93bf988;
	Tue, 03 Nov 2026 02:37:56 +0000
X-Mizu-Trace-ID: 35c4c235a93bf988
X-Migadu-Flow: FLOW_OUT
Date: Tue, 3 Nov 2026 10:37:34 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	David Lebrun <david.lebrun@uclouvain.be>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Mathieu Xhonneux <m.xhonneux@gmail.com>,
	David Lebrun <dlebrun@google.com>,
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Andrea Mayer <andrea@common-net.org>
Subject: Re: [PATCH net 5/6] seg6: account for the MAC header in skb checksum
 on L2 encapsulation
Message-ID: <aulI7pl1oWRKzXgt@fedora>
References: <20261031225033.64-1-andrea.mayer@uniroma2.it>
 <20261031225033.64-6-andrea.mayer@uniroma2.it>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031225033.64-6-andrea.mayer@uniroma2.it>

Hi Andrea,
On Sat, Oct 31, 2026 at 11:50:32PM +0100, Andrea Mayer wrote:
> In L2ENCAP and L2ENCAP_RED mode, seg6_do_srh() puts the MAC header back
> in front of the frame with skb_push(), without adding it to skb->csum.
> The encapsulation then calls skb_postpush_rcsum() only for the outer
> headers. With CHECKSUM_COMPLETE the MAC header is missing from
> skb->csum, which no longer covers the whole packet as required.
> 
> For a forwarded packet, ip6_forward() sets ip_summed to CHECKSUM_NONE with
> skb_forward_csum(), and End.DX2 does the same before sending the frame.
> When the packet is delivered on the same node, a raw socket with
> IPV6_CHECKSUM still reads skb->csum. With skb->csum computed by the device,
> the kernel can then log a "hw csum failure", as if the device had computed
> a wrong skb->csum.
> 
> Use skb_push_rcsum(), which also calls skb_postpush_rcsum() for the MAC
> header.
> 
> Found by manual code inspection of the skb->csum updates in the SRv6 code,
> and observed in a VM without kernel changes or error injection: with
> skb->csum computed by a tc ct action, a BPF tracing program on
> ip6_forward() shows skb->csum missing the MAC header. With this patch,
> skb->csum covers it. Also tested against the srv6 selftests, and with a
> ConnectX-6 Lx NIC (mlx5) that provides CHECKSUM_COMPLETE.
> 
> Fixes: 38ee7f2d4756 ("ipv6: sr: add support for encapsulation of L2 frames")
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/seg6_iptunnel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 0d39a38a5dd2..3821d8e1409e 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -456,7 +456,7 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
>  			return err;
>  
>  		skb_mac_header_rebuild(skb);
> -		skb_push(skb, skb->mac_len);
> +		skb_push_rcsum(skb, skb->mac_len);
>  
>  		if (tinfo->mode == SEG6_IPTUN_MODE_L2ENCAP)
>  			err = __seg6_do_srh_encap(skb, tinfo->srh,
> -- 
> 2.43.0
> 

Should we put the skb_push_rcsum() inside of __seg6_do_srh_encap() and
seg6_do_srh_encap_red()? They all do skb_mac_header_rebuild() again.

Thanks
Hangbin
