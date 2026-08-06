Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AC83806AF;
	Thu,  6 Aug 2026 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023911; cv=none; b=DrfFg4cpuiv7i2TxPq6+SUJ5DgW4L94IJUgNsa8UvZghEhnsZUE2YDqSdQsHG54b/Ywc3N1g2FUGGqo6sJK//g2X22F/eDtfjiDC5/+8kXBEPLfEpE/H7wMkBzJ/mE+g8MTff7P5RgvB9nmIBePTzYIlOZ+7lvks1TkAwwTfBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023911; c=relaxed/simple;
	bh=IALA1uDNbf5o/p/rf8md9qS+0knKGXzgdb9SABzpomg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lD9qdP3XEDnS2M2V7/nliMSodaASKBwdvxQzZ1ap93+RNx+YgGgaB8oe5OvZPEeYYDHhgXedD1nmTqNGCyNAJ/DaieEcdgi7lfC+8IzvzJzls08ft8P2l5OCXfiQRZIiQVfszWi8n234poIGKzktt4sOnXzzVQBnXjClLYsbNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhP7WZW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhP7WZW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91411F000E9;
	Thu,  6 Aug 2026 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023910;
	bh=6+yrdkh0LONfegXmNoa1TtrTQpU550Mmd4StmWllggA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jhP7WZW8tV/xyfh3ZIQJGLkciveI9miLHarkXfQi2p3REHg3umQXD46QHw2V1+319
	 yEtC0YdDyK/8mx/Ug4WeGvlMx1NllTEXh/sFj+rovSVO9qLIsNj4iUc0EVHzLlMYqh
	 dzz73b5CIGikrO1uOweLdFlGGFQMb/YX9hQK/w1k7XnnugbkzVWlh8ADbb0sfeAe4v
	 RN0Ad6EQBRpQAAIR1p9oWw3ziVNcmteaLpHXNi60UZ8uiXuSBB76KdlGJiOjlxZ59g
	 XVPSQoeK11eHlvVmol4Z5/2/DN59udivLLGn+RY2+y06Tb0Uk8rJrvQ2RRtnarX24n
	 +pPGGM994ebmA==
Message-ID: <17f81247-ebe2-42ce-ac34-02f4779ccaef@kernel.org>
Date: Thu, 6 Aug 2026 15:45:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] veth: fix queue index used to wake the peer txq in
 veth_poll
To: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Toshiaki Makita <toshiaki.makita1@gmail.com>,
 Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
References: <20260806-veth-fix-poll-queue-idx-v1-1-c5357fb7573d@tu-berlin.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260806-veth-fix-poll-queue-idx-v1-1-c5357fb7573d@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/08/2026 13.43, Jonas Köppeler wrote:
> veth_poll() derives the index of the peer TX queue to wake from
> rq->xdp_rxq.queue_index. That field is only initialized by
> xdp_rxq_info_reg() in veth_enable_xdp_range(), which runs only when an
> XDP program is attached. On the plain GRO/NAPI path
> (veth_napi_enable_range()) xdp_rxq_info_reg() is never called, so
> queue_index stays 0 for every queue, as priv->rq is zero-allocated. The
> same happens once an XDP program is detached while GRO stays enabled,
> since xdp_rxq_info_unreg() clears the struct again.
> 
> So in a multi-queue setup with GRO enabled and no XDP program attached,
> every NAPI instance looks at the peer's TX queue 0. If veth_xmit() stops
> peer TX queue 1 because the ptr_ring is full (NETDEV_TX_BUSY), nothing
> ever wakes it again: the poller draining queue 1 wakes queue 0 instead.
> veth implements no ndo_tx_timeout, so the netdev watchdog does not kick
> in either, and the queue stays stopped indefinitely.
> 
> Derive the index from the position of the rq within priv->rq instead,
> which is correct regardless of whether XDP was ever enabled.
> 
> Scripts to reproduce the stall are available at
> https://github.com/netoptimizer/veth-backpressure-performance-testing

I've modified both the reproducer[12] and selftests[13] to detect this.
Previously reproducer only had a 50% chance to catch this, and we didn't 
notice, code have been changed to catch this 100% of the time.  The 
selftests script never hit the bug as it always used one queue, this 
have been changed to always use two queues, but force/steer traffic to 
always hit queue index 1 via XPS config (as we want to see the queue 
build up and ptr_ring HoL queuing effects in the latency measurements).


- [12] 
https://github.com/netoptimizer/veth-backpressure-performance-testing/pull/12
- [13] 
https://github.com/netoptimizer/veth-backpressure-performance-testing/pull/13

> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")
> Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> ---
>   drivers/net/veth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 00e34afd858e..e927ef3f47b3 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -961,7 +961,7 @@ static int veth_poll(struct napi_struct *napi, int budget)
>   	struct veth_rq *rq =
>   		container_of(napi, struct veth_rq, xdp_napi);
>   	struct veth_priv *priv = netdev_priv(rq->dev);
> -	int queue_idx = rq->xdp_rxq.queue_index;
> +	int queue_idx = rq - priv->rq;

It took me a while to convince myself that this is correct via checking
the data-structures and how they get allocated.

This is a stable fix so it is good to keep this change as small as possible.

I do feel like we should add a queue_idx to struct veth_rq, and init
this in function veth_alloc_queues(). This could be a followup to net-
next IMHO.


>   	struct netdev_queue *peer_txq;
>   	struct veth_stats stats = {};
>   	struct net_device *peer_dev;

