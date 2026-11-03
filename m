Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793669241;
	b=kChY+5rOkwfFmvjwUA5EDcsWqOic/WgRYqa1c1hU/gPNhso4AbFQZiuSaSP8lRqEbc0i
	 KnZFTswHJ6DE5va6vPadHr5dwXYxtPHWyLPcMDQbcxcYdSiSyKRk4q+tJX0BBOoIg5ady
	 nDqLV8PtTa/HEOSR4h7j6c8S0sT4UqA7SCFHHv7S6wjhFfE0/y4EL0gtYbsNnLRptKl1F
	 m2agK63SExvGYC092h5lKvjrS9VGjA4q8bOFybgX7NgtJaKmoC0QjALEgkHwVJSqVTjn0
	 RbEuXY7cSjfX0bRSRYPlvwcXNMCRlDTX2wrNUDK1ECn8tQjxM0vBbBPLWIYJ+3ds4xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793669241;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xwrigN4hHrfQ0pdJAvaDQuroSa/OQ6XUSfC/4kh1PgE=;
	b=TVGhuArOpz4hTyqWGfO5ZAk9417UL1mf7zFzuDFhvU93ODGMmVwkB6WZDp8NyK8g6rAb
	 rY9lhVogXtPl0pxcPz7jfpizw3c66CJHp1+ANL07pvqpG1yfZm9/lLp+nsBNPzUZa2brr
	 2eJcBicjPQiL2mE1jAbkzmJzvpVbP5hrIvm+WY6rtQ6jaG27ieylHPwnEFzIkEJozOOJr
	 JgFyEK78VxKOCTrSDpgNVolnkxWsSNsfejs3EXbutVSVUw86eOIsprb0lwPe5EyvUexhM
	 vXXKXkyCpsL8hmnjwGLJ9lJMIr5G7LmxXKAbHsYvx/8PVKC4w4EaS1Ly9ZEMAJf+i3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PB7soUHQ;
	arc=none smtp.remote-ip=95.215.58.61
Received: from mta1.migadu.com (out-61.mta1.migadu.com [95.215.58.61])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D9606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 01:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 808D9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PB7soUHQ
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=D+/gw0Ztw4cZkf3WTT5E7vaQ4EK3jAqSPRQxFCWd8ok=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793669238; v=1; x=1794274038;
 b=PB7soUHQZzgbmZjXh/fH9csK3Ied1/V+gZxo/SFEdSc1Zj3L2pmU2rSYLsgY2FEKuXAAHXcD
 ZM+yjE7osqIRQ6zEkD9hs1ySTqGPIroojC92NhjBfhUne0f36ayjAAXujQ0g87JjcHBf9wZK5Gl
 Mb8KKgNNX9fRjWUiCl/eteBI=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 53184aca2c7ad085;
	Tue, 03 Nov 2026 01:27:18 +0000
X-Mizu-Trace-ID: 53184aca2c7ad085
X-Migadu-Flow: FLOW_OUT
Date: Tue, 3 Nov 2026 09:27:03 +0800
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
Subject: Re: [PATCH net 2/6] seg6: update skb checksum when ipv6_srh_rcv()
 decrements the Hop Limit
Message-ID: <auk4Z3DM4up7qVqu@fedora>
References: <20261031225033.64-1-andrea.mayer@uniroma2.it>
 <20261031225033.64-3-andrea.mayer@uniroma2.it>
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
In-Reply-To: <20261031225033.64-3-andrea.mayer@uniroma2.it>

On Sat, Oct 31, 2026 at 11:50:29PM +0100, Andrea Mayer wrote:
> When the next segment is a local address, ipv6_srh_rcv() processes it
> directly and also decrements the Hop Limit. With CHECKSUM_COMPLETE,
> skb->csum is not updated for this change. If the packet is then delivered
> on the same node and skb->csum was computed in software, for instance by
> conntrack, UDP can drop the packet as a checksum error. With skb->csum
> computed by the device, TCP can instead log a "hw csum failure", as if the
> device had computed a wrong skb->csum.
> 
> Update skb->csum for the Hop Limit decrement with update_csum_diff4().
> 
> Depends on patch "seg6: fix skb checksum update helpers".
> 
> Found by manual code inspection, and reproduced in a VM without kernel
> changes or error injection. A following commit adds a selftest that
> reproduces the problem with a tc ct action. With this patch, the selftest
> passes for the path with local SRH segments. Also tested against the srv6
> selftests, and with a ConnectX-6 Lx NIC (mlx5) that provides
> CHECKSUM_COMPLETE.
> 
> Fixes: 1ababeba4a21 ("ipv6: implement dataplane support for rthdr type 4 (Segment Routing Header)")
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---
>  net/ipv6/exthdrs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 96c8402a27a5..9d3ba310065a 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -460,6 +460,10 @@ static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  	}
>  
>  	if (skb_dst_dev(skb)->flags & IFF_LOOPBACK) {
> +		/* payload_len, nexthdr and hop_limit */
> +		__be32 *hlim_word = (__be32 *)ipv6_hdr(skb) + 1;
> +		__be32 old;
> +
>  		if (ipv6_hdr(skb)->hop_limit <= 1) {
>  			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
>  			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
> @@ -467,8 +471,12 @@ static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
>  			kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
>  			return -1;
>  		}
> +		old = *hlim_word;
>  		ipv6_hdr(skb)->hop_limit--;
>  
> +		if (skb->ip_summed == CHECKSUM_COMPLETE)
> +			update_csum_diff4(skb, old, *hlim_word);
> +
>  		skb_pull(skb, skb_transport_offset(skb));
>  		goto looped_back;
>  	}
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
