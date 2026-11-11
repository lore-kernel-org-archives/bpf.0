Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436899;
	b=VRLbN+YSBbEx4ndh2wK+KU4G86B9wX08fGG9JAc21sMSU/847aWsNL06aoA9CZkAw7GK
	 cSGAAhgP3tgCWkyh2VNlfx26xsE2pHRnqh7d6YyVUX8c64187BcyRk0Zld2E09hJw63A2
	 clFRwo49J53EoTSpo48C55bqedeQtKVzosnanILhTo+y2NexI9j1Wy/OzslvYySyzkC9M
	 h4zrPBikH9KHk0oiIhHPTQ5wwYLtd2reV2F+M1i905jDd31+Q1Mi1yH4h4R/epc3k6fCx
	 hs31p9ZgoCVDWoMCj6tRRsFmEx4n1xCm56TscHHazScHCDH6tLB7IKO7CAGkfdZg/XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436899;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/AWuy26j6xO/+PuOcFejOEnfNmeGq9vPqTM+p90YjAc=;
	b=j4IggsyZZgiFdEOfWgWEXOHl5gmyb4qz/WfHLROPXlh6T2PXrt8+BgH60L1QIMJcQ0PS
	 PRgoick2pCV3y//UeOcGYLl9g58YKigm8k7XFhs0vnRTQCmEhsTXFNdG4n3Ixz9yOhdhx
	 p1yhfvz7rvCO0JLZfH0s2Sjj0zcIeiYIk9pBYFq41USRBLAOzUbo2xga7susLL83fKNlO
	 I4KIaw4IUe1oPNT2lDO2K9nkVdK0JvzewbgBWEvk80rBFsgYWDbNRTC1cSSslUxdEbNxn
	 n4Vx7TYRVk8+kBeIT43phPgdg6KKaLE2hsTww0Mj8K+VkBtspRi5M7kQyQn5at6sVzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMvPc8rq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD4760A3820;
	Wed, 11 Nov 2026 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMvPc8rq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EAB1F00A09;
	Wed, 11 Nov 2026 22:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436898;
	bh=/AWuy26j6xO/+PuOcFejOEnfNmeGq9vPqTM+p90YjAc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YMvPc8rqcRjg2+UCtIXYxVtWdwSW1aaeylbH62iXeKnQeRlW+PxRhxHVNrgbDgDQE
	 6MvnZ2SY6R5G+uU5ZgnzJDSdJHlYyqD7KHAWIOVpGHn+WhGXWm2oEJ/6FMnTe5meYi
	 iT6OsnvqtRuXD4EQ8gshuiui8OJWvxN8Spl/1HaeruKKVdsczo1ULEwpopI5tm0RnL
	 ovWS9OvMfEn+qpkfqCSaRlt6cH3LWAQtwLEGkp6Bk0IDhfroVEgXEHCAubAU/Gl6XO
	 b2fy5QOJJHA899IYxLcmHjCQlm27++rxFd7wFuxT1e7VB1bt8bUQ679Z8khejKLmdf
	 eyAYdcbd8J4gw==
Subject:
 Re: [PATCH net-next v1 07/11] xsk: Deliver provider chunks without copying
From: netdev-bot+sashiko@kernel.org
To: bjorn@kernel.org
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, alexanderduyck@fb.com, kernel-team@meta.com,
 andrew+netdev@lunn.ch, hawk@kernel.org, ilias.apalodimas@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 asml.silence@gmail.com, axboe@kernel.dk, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org,
 io-uring@vger.kernel.org, almasrymina@google.com, mike.marciniszyn@gmail.com,
 bestswngs@gmail.com, razor@blackwall.org, dw@davidwei.uk,
 aleksander.lobakin@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stuclar@meta.com
Date: Wed, 11 Nov 2026 22:41:35 +0000
Message-ID: <179443689590.2199510.9741809616593174859@kernel.org>
In-Reply-To: <20261110102039.1002605-8-bjorn@kernel.org>
References: <20261110102039.1002605-8-bjorn@kernel.org>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch weakens a documented AF_XDP UAPI guarantee, and
  userspace cannot opt in or detect it.
- [Low] The commit message gets wrong what the old copy path did.
- [Low] The patch adds a new core page_pool memory-provider API,
  net_mp_release_page_pool_bulk(), in net/core/page_pool.c and…
- [Low] The new drop paths for provider sockets in xsk_rcv() do a plain
  non-atomic `xs->rx_dropped++` on a u64 from contexts outside the queue…

--

xsk: Deliver provider chunks without copying

This commit puts packets whose buffers all belong to the socket's memory
provider directly on the AF_XDP RX ring, and copies other packets into
chunks claimed from the provider. Generic XDP and CPUMAP redirects to
provider sockets are dropped. TX descriptor validation now reserves
tx_metadata_len only for descriptors with XDP_TX_METADATA.

> A provider socket still receives through the copy path, which takes
> FILL entries without the provider's ownership checks: a chunk that a
> page pool holds could be handed out twice. No driver opts in yet.

[Severity: Low]
Does this describe what the old copy path actually does for a provider
socket?

Before this patch, xsk_rcv() calls __xsk_rcv() for provider sockets,
because their mem.type is MEM_TYPE_PAGE_POOL. That leads to:

xsk_rcv()->__xsk_rcv()->xsk_buff_alloc()->xp_alloc()->__xp_alloc()
    ->xp_get_xskb()

For a provider bind, pool->free_heads_cnt is umem->chunks and pool->fq is
still set. So __xp_alloc() peeks a FILL entry, and in aligned mode (the
only mode xsk_pp_bind() accepts) xp_get_xskb() returns &pool->heads[idx].

pool->heads is never allocated here. xp_assign_dev() returns right after
a successful xsk_pp_bind() and never calls xp_alloc_heads():

net/xdp/xsk_buff_pool.c:xp_assign_dev() {
    ...
	if (xsk_pp_supported(netdev)) {
		err = xsk_pp_bind(pool, netdev, queue_id);
		if (err)
			goto err_unreg_pool;

		pool->umem->zc = true;
		return 0;
	}
    ...
}

xp_alloc() then writes xskb->xdp.data through a NULL-based pointer.

So the failure would be a NULL or wild pointer dereference in NAPI, not a
chunk handed out twice. No driver opts in yet, so there is no runtime
impact. Could the commit message describe the actual failure mode?

> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index e897e79d31f19..56c299f2280d7 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c

[ ... ]

> @@ -1422,3 +1422,35 @@ void net_mp_niov_clear_page_pool(struct net_iov *niov)
>  
>  	page_pool_clear_pp_info(netmem);
>  }
> +
> +/**
> + * net_mp_release_page_pool_bulk() - take net_iovs back from a page pool
> + * @pool: page pool that holds one reference to each net_iov
> + * @netmems: net_iovs of the memory provider of @pool
> + * @count: number of entries in @netmems
> + *
> + * A memory provider takes net_iovs out of a page pool without
> + * ->release_netmem(), for example to give them to userspace. @pool may be
> + * freed on return.
> + */
> +void net_mp_release_page_pool_bulk(struct page_pool *pool,
> +				   netmem_ref *netmems, u32 count)
> +{

[Severity: Low]
This isn't a bug, but this adds a new core page_pool memory provider API,
declared in include/net/page_pool/memory_provider.h. The xsk commit
message doesn't mention it.

The helper clears pp_info and advances pool->pages_state_release_cnt.
That counter feeds the inflight accounting that decides when a destroyed
pool is freed. The helper also documents that @pool may be freed on
return.

Other core changes in this series, such as "page_pool: Coordinate refill
with memory providers", got their own patches. Could this go in a
separate page_pool patch, so the page_pool maintainers can review the
new contract?

[ ... ]

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 113b0b08356d5..b419c673e3f14 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -488,7 +547,26 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
>  		return xsk_rcv_zc(xs, xdp, len);
>  	}
>  
> -	err = __xsk_rcv(xs, xdp, len);
> +	if (!xs->pool->pp) {
> +		err = __xsk_rcv(xs, xdp, len);
> +	} else {
> +		/* A CPUMAP program runs XDP on another CPU, not in NAPI. */
> +		if (unlikely(!xdp_rxq_info_is_reg(xdp->rxq))) {
> +			xs->rx_dropped++;
> +			return -EINVAL;
> +		}
> +
> +		err = xsk_pp_rcv_zc(xs->pool->pp, xs, xdp);
> +		if (err != -EXDEV)
> +			return err;
> +
> +		/* Copy only packets of the queue, from its NAPI */
> +		if (unlikely(!xsk_pp_queue_buf(xs->pool->pp, xdp))) {
> +			xs->rx_dropped++;
> +			return -EINVAL;
> +		}

[Severity: Low]
Can these xs->rx_dropped++ updates race with the queue NAPI?

The CPUMAP kthread reaches the unregistered rxq branch.
cpu_map_bpf_prog_run_xdp() uses an on-stack rxq:

kernel/bpf/cpumap.c:cpu_map_bpf_prog_run_xdp() {
    ...
	struct xdp_rxq_info rxq = {};
    ...
}

It sets rxq.dev = xdpf->dev_rx and leaves queue_index at 0, so
xsk_rcv_check() passes for a socket bound to queue 0.

A BPF_F_TEST_XDP_LIVE_FRAMES test run reaches the xsk_pp_queue_buf()
branch. xdp_test_run_setup() registers a fake rxq on the real device with
queue_index 0 and page-backed MEM_TYPE_PAGE_POOL buffers. xsk_pp_rcv_zc()
returns -EXDEV, then xsk_pp_queue_buf() returns false, all in process
context.

At the same time, the queue NAPI on another CPU can increment
xs->rx_dropped and xs->rx_queue_full in xsk_pp_rcv_copy(),
xsk_pp_rcv_zc() and xsk_rcv_check(). No lock is shared between these
contexts.

Would concurrent increments get lost, and could the u64 counter tear on
32-bit, so that XDP_STATISTICS reports wrong drop counts? xsk_rcv_check()
already has the same unsynchronized pattern, and the effect is limited to
these counters.

> +		err = xsk_pp_rcv_copy(xs, xdp, len);
> +	}
>  	if (!err)
>  		xdp_return_buff(xdp);
>  	return err;

[ ... ]

> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
> index a77213f7fef6b..a1c2ca00f0169 100644
> --- a/net/xdp/xsk_pp.c
> +++ b/net/xdp/xsk_pp.c

[ ... ]

> @@ -294,6 +299,166 @@ static bool xsk_pp_refill_done(struct page_pool *pool, enum pp_refill state)

[ ... ]

> +/* Returns -EXDEV for a packet that must be copied. Called from the NAPI. */
> +int xsk_pp_rcv_zc(struct xsk_pp *pp, struct xdp_sock *xs,
> +		  struct xdp_buff *xdp)
> +{

[ ... ]

> +	__xskq_prod_reserve_desc(xs->rx, xdp->data - umem,
> +				 xdp->data_end - xdp->data,
> +				 nr_frags ? XDP_PKT_CONTD : 0);
> +	pp->pending[pp->pending_cnt++] = head;
> +
> +	for (i = 0; i < nr_frags; i++) {
> +		frag = &sinfo->frags[i];
> +		__xskq_prod_reserve_desc(xs->rx, skb_frag_address(frag) - umem,
> +					 skb_frag_size(frag),
> +					 i + 1 < nr_frags ? XDP_PKT_CONTD : 0);

[Severity: Medium]
Does this weaken the documented AF_XDP headroom guarantee for XDP_USE_SG
applications, with no way to opt in or detect it?

af_xdp.rst says a UMEM headroom of N means the packet "will start N bytes
into the buffer leaving the first N bytes for the application to use".
Before this patch, every RX buffer kept this headroom:

- copy mode, in __xsk_rcv()
- driver zero copy, in xp_alloc()
- the new xsk_pp_rcv_copy() path, which uses addrs[i] + headroom

Here the frag descriptors are published at skb_frag_address(frag) - umem,
wherever the device placed the payload. On fbnic that can be chunk
offset 0. The device has then DMA-written into the first N bytes of
those chunks. Any per-chunk application data kept in the headroom is
overwritten.

xp_assign_dev() picks xsk_pp_bind() automatically whenever
xsk_pp_supported(netdev) is true. That covers both XDP_ZEROCOPY and a
bind without flags. No bind or UMEM flag lets an application accept or
refuse the weaker rule. The af_xdp.rst hunk changes the documented rule
for all drivers:

  In a multi-buffer packet, only the first buffer is guaranteed this
  headroom; the others may start at offset 0 of their chunk.

At the end of the series only fbnic opts in, and fbnic had no AF_XDP RX
before, so no existing deployment changes today. An application that
relies on per-buffer headroom could still lose it, with no change on its
side, if another driver later moves to xsk_page_pool.

Should this be gated by a flag? Or should the commit message describe it
as a UAPI change rather than as a device property?

> +		pp->pending[pp->pending_cnt++] = skb_frag_netmem(frag);
> +	}
> +
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110102039.1002605-1-bjorn%40kernel.org
