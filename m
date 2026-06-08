Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4496D282F3C;
	Mon,  8 Jun 2026 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928545; cv=none; b=d+R7rno5seON2shEmg+9topE5cZtcRI07MCcsNLZQMg9tovbwlbRZwy8PhnMF+dICgODalCctOec8BJtFpUcrHTpBvx9I84kjPahPLhIeKNjRreqYaFZoyeYkHuDprRLPZSBt+D51SBWhASY/3MmuoLD7MzWRF61Zy+85I8UBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928545; c=relaxed/simple;
	bh=y4vALbuvRk0/F18Sg9jO/10j3xq8jP0c35s6LPh8uZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmG4m/fk1CSMQReM8F+rRaxjv80FAJ09QYVSoBp6T/EGxK1Zeu+FkTT9fWuQUputXuDiuJj52pGfhcBrL13j9WKP2VJoEDZ++UsUnIvtyrMTv09x2edBXZLHz5L1iz2c/u6PGKbWjjn9k/bzpMQu7ywfEXVRzbzoGdOA0E9GkwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=NcUFYYyJ; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="NcUFYYyJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1780928521;
	bh=y4vALbuvRk0/F18Sg9jO/10j3xq8jP0c35s6LPh8uZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NcUFYYyJ77bXGKCBH6PsriVK8mgilPyVb+qd+BHeFdV4AynxDLwwgPXxnt2KLsfZq
	 MAoYY1cf7KU/1wb8YEbOeal7UiaUURt2Cqeyn6GHT3aJde8g+rMP658+pwEt7QwmFD
	 o1qS0n+iEWMf7D6Oxkpm+VCW8p8kOdOBd9rawyTk=
Received: from [129.217.186.245] ([129.217.186.245])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 658ELxgl020041
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 8 Jun 2026 16:21:59 +0200 (CEST)
Message-ID: <b8569d0f-7a99-4488-a1bb-63d813231b7d@tu-dortmund.de>
Date: Mon, 8 Jun 2026 16:21:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
 <db2aa3b9-09d4-46d8-aafc-0a859ee8b635@tu-dortmund.de>
 <7fcb9f02-db61-416c-a6f5-b737d74110ec@kernel.org>
 <e8478d82-5af6-44f7-a481-584c09ae8337@tu-berlin.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <e8478d82-5af6-44f7-a481-584c09ae8337@tu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/8/26 15:13, Jonas Köppeler wrote:
> 
> On 6/8/26 3:04 PM, Jesper Dangaard Brouer wrote:
>>
>>
>> On 08/06/2026 12.38, Simon Schippers wrote:
>>> On 5/27/26 15:54, hawk@kernel.org wrote:
>>>> From: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>>
>>>> Per-packet BQL completion forces DQL to converge on limit=2, causing
>>>> excessive NAPI scheduling overhead and qdisc requeues.
>>>>
>>>> Accumulate BQL completions and flush them when a configurable time
>>>> threshold is exceeded, letting DQL discover a limit that bounds actual
>>>> queuing delay to the configured interval. Coalescing state persists
>>>> across NAPI polls in struct veth_rq so completions can accumulate
>>>> beyond a single budget=64 cycle.
>>>>
>>>> Add ethtool tx-usecs support for runtime tuning. Default is 100 us;
>>>> setting tx-usecs to 0 disables coalescing and falls back to per-packet
>>>> completion.
>>>>
>>>>    ethtool -C <veth-dev> tx-usecs 500  # 500us coalescing
>>>>    ethtool -C <veth-dev> tx-usecs 0    # per-packet (no coalescing)
>>>>
>>>> Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>> ---
>>>
>>> I found the issue that n_bql may become infinitly large if producer
>>> and consumer have the same speed (and tx_usecs is large). It could
>>> cause a potential BUG_ON if n_bql grows beyond INT_MAX...
>>> Also I figured that no hardware BQL driver ever completes more than
>>> BQL limit many elements.
>>>
>>> Therefore, I propose a simpler logic (see attachment) that completes
>>> either on the usual bql_flush_ns or if n_bql > dql.limit.
>>> If n_bql > dql.limit then we either have the case above that the
>>> producer is as fast as the consumer or we have BQL starvation.
>>>
>>> if (state->time + bql_flush_ns <= current_time ||
>>>     state->n_bql > peer_txq->dql.limit) {
>>>
>>> It must be n_bql *bigger than* dql.limit because the producer will
>>> always exceed the limit before it stops, see netdev_tx_sent_queue().
>>> It is fast because peer_txq->dql.limit is in the cacheline of the
>>> completion path, see dynamic_queue_limits.h.
>>>
>>> Another advantage is that we avoid the snippet checking for empty
>>> and BQL stopped which requires an smp_rmb() and an test_bit().
>>>
>>> Apart from that I:
>>> - Always call veth_bql_maybe_complete() in the for loop to have
>>>    more accurate completion intervals when having mixed XDP and
>>>    non-XDP packets.
>>> - Made it so tx_usecs = 0 is now also a normal case.
>>> - Change the type of n_bql to uint instead of int.
>>> - Added _ONCE() for tx_coalesce_usecs as suggested by Paolo.
>>> - Moved the bql_state init in __veth_napi_enable_range() in front
>>>    of napi_enable() to avoid a race (Sashiko).
>>> - Moved the bql_state reset in veth_napi_del_range() after the
>>>    ptr_ring_cleanup() (probably does not matter but makes sense to me)
>>>
>>> Benchmarks look just fine, see commit message.
>>>
>>> WDYT?
> 
>>
>> Looks good to me, I will use this in my V7 patchset.
>>
>> A bike-shedding issue: We change the coalescing parameters for the veth
>> net_device, but should this be a TX or RX parameter?
>>
> 
> Hi,
> 
> The results look a little bit suspicious, that in some cases the p99 is smaller than the average, which can happen if you have really large max values. It feels something is off with the methodology. I think we should drop the avg, and include the max value. This would give a better picture.

Luckily I saved the raw test result from /tmp (the raw ping output
is included).

extract_ping_p99() seems to be broken. It has issues ordering the
numbers. So if there are 2 or 3 numbers after the point I think.
avg ping is fine.

Claude Sonnet wrote a script for me to recalculate the p99 pings
from the raw ping output).
Below is the new result. Not 100% sure but this seems right now.
Most pings are the same.

Ping RTT ms (p99)
===========================================================================
nrules |   0us |  50us | 100us | 500us | 1000us | 5000us | 10000us || stock
-------+-------+-------+-------+-------+--------+--------+---------++------
     0 | 0.028 | 0.115 | 0.159 | 0.161 |  0.163 |  0.161 |   0.163 || 0.154
     1 | 0.027 | 0.123 | 0.169 | 0.172 |  0.169 |  0.173 |   0.172 || 0.169
    10 | 0.030 | 0.117 | 0.189 | 0.193 |  0.195 |  0.192 |   0.196 || 0.186
   100 | 0.045 | 0.134 | 0.233 | 0.368 |  0.365 |  0.369 |   0.361 || 0.358
  1000 | 0.230 | 0.300 | 0.412 |  1.26 |   2.11 |   2.12 |    2.13 ||  2.07
 10000 |  2.04 |  2.55 |  2.54 |  2.72 |   3.77 |   12.1 |    20.1 ||  20.3

> 
> Is state->n_bql += veth_ptr_is_bql(ptr) something that is commonly done in the kernel? It relies on bool normalization which feels a bit implicit to me.

Ok, we could swap for something like 

if (veth_ptr_is_bql(ptr))
	state->n_bql+;

> 
>> For physical NICs adjusting TX coalescing will affect the BQL as this
>> affect the TX completion of the transmitted packets. For veth, it is the
>> veth-peer's RX NAPI that is "completing" or emptying the ptr_ring, which
>> is where this patch adds netdev_tx_completed_queue calls for BQL.
>> Any opinions on the "TX" or "RX" color?

Personally I would also say TX.

> I think I would prefer to configure it on the tx dev, and the recv side gets the value from the peer. Maybe something like this.
> 
> @@ -997,11 +998,12 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>         struct veth_bql_state *state = &rq->bql_state;
>         int i, done = 0, n_xdpf = 0;
>         void *xdpf[VETH_XDP_BATCH];

Why this deletion?

> -       struct veth_priv *priv;
> -       u64 bql_flush_ns;
> +       u64 bql_flush_ns = 0;
> 
> -       priv = netdev_priv(rq->dev);
> -       bql_flush_ns = (u64)priv->tx_coal_usecs * 1000;

I see we should check if peer_txq exists.

> +       if (peer_txq) {
> +           struct veth_priv *peer_priv = netdev_priv(peer_txq->dev);
> +           bql_flush_ns = (u64)READ_ONCE(peer_priv->tx_coal_usecs) * 1000;
> +       }
> 
>         /* Clamp stored timestamp in case we migrated to a CPU with a behind
>          * sched_clock(); prevents the deadline from never firing.
> 
> - Jonas
