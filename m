Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436904;
	b=VgdmUocqzdGXsjTEIQNd/9525IpOXZ/JpDkDCKj9SGQ8RsYfeDZtfYPPWm3xi/Y78rHq
	 preXEYiHA1EiDa0TDijvWDdY9zlyaiXGaOOHqfEiAHqhAWBJhMszNGCChQ3PWaaX7xVSL
	 CF/w+HlyOJB6TyG07b/2I56WWWwOF/E9crskxZcwmJUMPXIUqcL+DtNmtmb3u5kLjYHPV
	 G7puwwqJNzFwLXKObx3/4G7MJvQcFBqr4RIOkSi6LEB6QP+rtvNT5b5RROsOheceXqLVu
	 xAQVj6xpEHJioWYDqfjGAaLGfthqFdlWNuOT4hnXn+0UB0w2t67d6EkTN0FLQaTSccw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436904;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1VxYrnk3EGdLlXmWiNcVYysu+JK3YRtT9g9emVyC1Wg=;
	b=tQnlUgd5Ra3352COzXaEkcehg1RNXQVitGBoKKxDexB80Uexs0KcFMI1aNVt4sxXAiM4
	 DgvqVH0w7Ee2Amt3sIt8ClAk7gQod+N99aJoFmZH5k1qLxVGPsjddWY1eoUyCy/CidRFB
	 OwngNq+Gf6cqHlt1ZyjHB7m7IsX0q+9hQpPZwQSxrvYtLvu8D/LBTHRamtJtsP9n9Mp+G
	 FpcwyrjrE45jKuxNaf3+UgUP/HQ8AsMi5lCDyPQV/r+LEEQNa8VwN5kdFocMyOxyuwoGF
	 i7+3eHxJ3Sqr9TToSxPfcZHNIoYi+yE+Wc1WOF1VKosEvRkxprQKJdMsESFZsSmqKpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nccq3Pbr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727B60A6F55;
	Wed, 11 Nov 2026 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nccq3Pbr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CB31F00A07;
	Wed, 11 Nov 2026 22:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436904;
	bh=1VxYrnk3EGdLlXmWiNcVYysu+JK3YRtT9g9emVyC1Wg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Nccq3PbrXWNWsFEWSLzMIsLjSSYh7CxcgVNAGHTp+2y++opajMDXxcl4EWuswD3JI
	 z4dFF1B/KyhSO2Ll0mpYTEECFEkX9twB0vMo2pXWqwmr8SnpsqIrSUZCfNckBYJP8s
	 GU4qTta3D5wx99z1ioCB62kCwd526KtlcENyU3KWxpXTisBtnI3fWNqn/GNbBovOct
	 l/vwfvlZunQawTvATN1kdfdK81ZeojHlom/dLB9MMUiH48Y8+jQJTaY15u5cE5/V6e
	 61ZaLLaPkxe+9J9DbcE1BKQPTkRYMtvlsPcVfY+XyqqWO1Dozvb1PFbNUzFqGTrbAQ
	 ZLQavktXhQ5WA==
Subject:
 Re: [PATCH net-next v1 11/11] eth: fbnic: Support AF_XDP page pool zero copy
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
Date: Wed, 11 Nov 2026 22:41:41 +0000
Message-ID: <179443690174.2199510.10806656670743256191@kernel.org>
In-Reply-To: <20261110102039.1002605-12-bjorn@kernel.org>
References: <20261110102039.1002605-12-bjorn@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Stale, unreferenced xsk_buff_pool pointer is used after a failed
  queue restart during AF_XDP unbind.
- [Medium] On an AF_XDP provider queue, an empty FILL ring is normal flow
  control, but fbnic counts it as a buffer allocation failure.
- [Low] The commit message presents the balanced header/payload refill as
  something for the shared provider page pool ("Header and payload rings…
- [Low] The new "Zero-copy through page pool" section of
  Documentation/networking/af_xdp.rst says "MTU and XDP program changes…
- [Low] The new af_xdp.rst text says: "If the device cannot do zero-copy
  for the socket, a bind with XDP_ZEROCOPY fails with EOPNOTSUPP, while…

--

eth: fbnic: Support AF_XDP page pool zero copy

This adds AF_XDP zero-copy support to fbnic through a page pool memory
provider. The header and payload BDQs share one provider page pool and
use a new balanced refill policy, and socket TX descriptors go out on
the XDP TX ring from the RX NAPI after RX processing. It also adds
per-queue rx_headroom support and documents the page pool zero-copy mode
in af_xdp.rst.

> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> index e73a0005e169c..f152ae8812d17 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -346,6 +346,64 @@ Note that a UMEM can be shared between sockets on the same queue id

[ ... ]

> +If the device cannot do zero-copy for the socket, a bind with
> +XDP_ZEROCOPY fails with EOPNOTSUPP, while a bind without it falls back
> +to copy mode. MTU and XDP program changes that a bound socket cannot
> +handle are refused.

[Severity: Low]
Does the page pool bind path always behave this way?

xsk_pp_bind() in net/xdp/xsk_pp.c returns -EBUSY when another queue has
an unreadable memory provider:

    if (!netif_all_mps_have_cap(dev, MP_CAP_READABLE))
        return -EBUSY;

It also passes on errors from the driver's XDP_VALIDATE_XSK_POOL check,
xp_dma_map(), xsk_pp_create() (-ENOMEM, -ERANGE) and netif_mp_open_rxq()
(for example -EEXIST, -EINVAL, -ENOMEM).

The copy-mode fallback is also conditional. In xp_assign_dev():

    if (!force_zc && !pool->pp)
        err = xp_alloc_heads(pool); /* fallback to copy mode */

Suppose netif_mp_open_rxq() fails, and then either xp_alloc_heads()
fails or xsk_pp_abandon() finds an old page pool still holding chunks.
In that case xsk_pp_bind() leaves pool->pp set, and a bind without
XDP_ZEROCOPY fails instead of falling back to copy mode.

Could the text mention the other errnos, and the case where copy mode is
not available?

[ ... ]

> +* advertises NETDEV_XDP_ACT_XSK_ZEROCOPY and xdp_zc_max_segs,
> +* checks the setup in XDP_VALIDATE_XSK_POOL, and sets xsk_page_pool
> +  in its netdev_queue_mgmt_ops.

[Severity: Low]
Should this list also say that the driver must call xsk_validate_dev()
from its own ndo_change_mtu?

In net/core/dev.c, the only callers of xsk_validate_dev() are the XDP
program install paths. No core MTU path calls it. fbnic refuses such MTU
changes only because this patch adds this to fbnic_change_mtu():

    err = xsk_validate_dev(dev, new_mtu, NULL, XDP_MODE_DRV, NULL);

A driver that follows only this list would accept MTU changes that a
bound socket cannot handle. One example is raising the MTU above the
header buffer size for a non-SG socket. The statement above that such
MTU changes are refused would then not hold.

[ ... ]

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> index d96c957d6fbad..c358003f053b6 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c

[ ... ]

> @@ -938,66 +969,146 @@ static void fbnic_bd_prep(struct fbnic_ring *bdq, u16 id, netmem_ref netmem)
>  	} while (--i);
>  }
>  
> +static bool fbnic_fill_bdq_one(struct fbnic_ring *bdq, unsigned int *tail)
> +{
> +	netmem_ref netmem;
> +
> +	netmem = page_pool_dev_alloc_netmems(bdq->page_pool);
> +	if (!netmem) {
> +		u64_stats_update_begin(&bdq->stats.syncp);
> +		bdq->stats.bdq.alloc_failed++;
> +		u64_stats_update_end(&bdq->stats.syncp);
> +
> +		return false;
> +	}

[Severity: Medium]
On an AF_XDP provider queue, xsk_pp_alloc_netmems() returns 0 whenever
the reuse stack and the FILL ring are empty. That is normal flow control
for the socket. Is it intended to count it as alloc_failed?

Without XDP_USE_NEED_WAKEUP, xsk_pp_refill_done() returns false in this
case:

    more = pp->reuse_cnt || xskq_cons_nb_entries(pp->fq, 1);
    WRITE_ONCE(pp->starved, !more);
    spin_unlock_bh(&pp->lock);

    return !more && wait;

fbnic_fill_bdqs() then returns false, fbnic_clean_rcq() returns budget,
and NAPI polls again at once. Each poll fails the allocation again and
increments the counter again.

This counter reaches userspace through the standard queue stats in
fbnic_netdev.c:

    rx->alloc_fail = fbn->rx_stats.rx.alloc_failed +
        fbn->bdq_stats.bdq.alloc_failed;

Won't an idle xsk queue then report a fast-growing alloc_fail count that
has nothing to do with memory pressure? With need_wakeup, each wakeup
that finds the FILL ring empty would also be counted.

[ ... ]

> +static bool fbnic_fill_bdqs(struct fbnic_q_triad *qt)
> +{
> +	struct fbnic_ring *hpq = &qt->sub0, *ppq = &qt->sub1;
> +	enum pp_refill state;
> +	bool done;
>  
> -		writel(i * fbnic_bd_page_count(bdq), bdq->doorbell);
> +	if (hpq->page_pool == ppq->page_pool) {
> +		fbnic_fill_shared_bdqs(hpq, ppq);

[Severity: Low]
The commit message says:

    Header and payload rings share one provider page pool, so refills even
    them out, and a short pool does not starve one of them.

In the default configuration, without AF_XDP, fbnic_alloc_qt_page_pools()
already shares one regular page pool between sub0 and sub1, through this
unchanged branch:

    } else {
        page_pool_get(pp);
    }
    qt->sub1.page_pool = pp;

So this test is true for every normal RX queue as well.
fbnic_fill_shared_bdqs() replaces the old policy, which filled the HPQ
fully and then filled the PPQ, on the default datapath. The new policy
interleaves per buffer through fbnic_hpq_takes_next(), which does u64
multiplications for each buffer. Filling of both rings also stops at the
first allocation failure.

Should the commit message mention this change to the existing datapath?
It also does not mention two other changes: QCFG_RX_HEADROOM is now
accepted, and RDE_CTL0 MIN_HROOM is programmed per queue.

> +		state = fbnic_bdq_state(hpq);
> +		if (state == PP_REFILL_FULL)
> +			state = fbnic_bdq_state(ppq);
> +		return page_pool_refill_done(hpq->page_pool, state);
>  	}

[ ... ]

> @@ -1674,8 +1901,29 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_q_triad *qt,
>  		.netdev	= fbn->netdev,
>  		.queue_idx = rxq_idx,
>  	};
> +	struct xsk_buff_pool *xsk;
>  	struct page_pool *pp;
>  

[ ... ]

> +	/* Payload buffers come from UMEM only for multi-buffer sockets */
> +	xsk = xsk_rxq_pool(fbn->netdev, rxq_idx);
> +	qt->xsk_pool = xsk;

[Severity: High]
This stores the xsk_buff_pool pointer without taking a reference, and
fbnic_queue_start() copies it into the live triad. What happens to this
pointer if the queue restart during unbind fails?

On socket close, this chain can fail:

__xp_clear_dev()
  xsk_pp_unbind()
    netif_mp_close_rxq()
      __netif_mp_close_rxq()
        netdev_rx_queue_reconfig()

Some ways it can fail:

- fbnic_queue_mem_alloc() returns -ENOMEM from page_pool_create(),
  kvzalloc() or the descriptor ring allocation.
- fbnic_queue_stop() fails through fbnic_wait_queue_idle().
- ndo_queue_start() fails and the old queue is restarted.

__netif_mp_close_rxq() only warns:

    err = netdev_rx_queue_reconfig(dev, rxq_idx, &qcfg[0], &qcfg[1]);
    if (err == -ENETDOWN)
        return 0;
    WARN_ON(err);
    return err;

xsk_pp_unbind() then ignores the result:

    netif_mp_close_rxq(pool->netdev, pool->queue_id, &mp);
    xsk_pp_detach(pp);

xsk_pp_detach() unmaps the DMA through xp_dma_unmap(), and xp_destroy()
later frees the pool. Meanwhile the old fbnic triad keeps running with
qt->xsk_pool still set.

On every poll, fbnic_poll()->fbnic_xsk_tx()->fbnic_xsk_tx_pool() calls
xsk_set_tx_need_wakeup(), xsk_tx_peek_release_desc_batch() and
xsk_buff_raw_get_dma() on that pool. Wouldn't these then read and write
freed memory? In-flight entries in ring->xdp_buf[].xsk would also be
passed to xsk_tx_completed() from fbnic_clean_twq1().

The xsk_rxq_pool() comment says "The pool stays valid while the queue
that the caller allocates runs", but that does not seem to hold on this
failure path. Part of the cause is the core error handling. Still, the
fbnic TX code added here is what keeps using the raw pointer.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110102039.1002605-1-bjorn%40kernel.org
