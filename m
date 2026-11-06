Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963488;
	b=ufqjYQsbyXNyhWMhekcfnMy9fAChSLML/daVvAEadCDZiVE+CIbPUTCrQjcWvbo8pB8s
	 t0xsbAaQWTPGIXiTvgSjZC47VPpllgHLcZ9meuZmwJfy7SC3Ox8pFebeowoHEgCUIb5ys
	 zZhv9xrwOd9xgefRLNk1xVJR5rlciWTZKwkHNcW/LJMMQtxNuVTTz5tYZOFoXZ/omDb0L
	 Y+Sf1p8Eq5N2k8yMGSXRiQNY1nMIx2TT3iNTftxwK0zxYcD75Wvi5bUVVJbAqaN/1HW1z
	 thjdL0mU0SpPWOe2PjoaeKTf+2etZfj7VutfMPqhHIl0J4AHsyuB4xjq1a+r0YvXMmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963488;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2TCSFRqB1VT/51qxAzdDDlKE5fIfeOnrCaZNdRqchMA=;
	b=WxIz/p63KyjD4mPmD39hpIPvmHB6ZQL2mxVJrVIsC5ICxNSJCMef4Sispj/VKOuQBf6u
	 n2YSV8xwAoMBCDXt636bVhkvCVk0C1ZxmvlxcN+mgQQnMwBvN26bBvOQ9hDg455UucfgF
	 SzhE8t91Botj+6a+bZ592I07TgAiVLVp/2Fk4Q/NKH1I8I8soUoVqTXpoBtyra4EkUPIC
	 QqcZl54Y6GHySeePbmmCNfFVgXkDHCNbqTZH0JazrdvfDspERnIOaRf1NULnJuZn0VGnG
	 kByrWGqu4rh90Ys3tHb4MsFonsb/n9tBFaVJGEx5nA0ktG8MrBBVG5YRdioK7jNqh6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4oAZvCq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF487606A335;
	Fri,  6 Nov 2026 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4oAZvCq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D281F0089F;
	Fri,  6 Nov 2026 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793963487;
	bh=2TCSFRqB1VT/51qxAzdDDlKE5fIfeOnrCaZNdRqchMA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n4oAZvCq2992sUstzwpmoVVBPrV4cYtzfOyX/xKu5+VfHf51y+tGNNBfOdLfQZJJe
	 WEaklyz8/R3DScWiyEHAAyezFfRsv6Z3IJbo0XyS3Ilo/xiheT7euupzYXTJ26kNnu
	 ipAj6s3l8cAGNQ6XmE/jAQRBcGaaxP4wPFjpZo5ng/ELq3U/+xnowT5cqMe7ujrQHq
	 yXeQOYpbMjrGh54lKPOQRkhisE4oV8jFB+uLld7y9y1OBG3YjVaYhRXuJPWtLp58/s
	 SFxsSm6n7gEryS9MZUp7+ZB3w1RQTcGOIkHe8nrTQsoDigtMOQ3uWbsPpf4oFRtAtr
	 lSF+NAfsGAhAw==
Subject:
 Re: [PATCH net v3] xsk: Do not free ZC Rx buffer when the Rx ring is full
From: netdev-bot+sashiko@kernel.org
To: marcin.knap@vecima.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jtollet@cisco.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 bjorn@kernel.org, kerneljasonxing@gmail.com, nshettyj@marvell.com,
 joshwash@google.com, hramamurthy@google.com, sgoutham@marvell.com,
 gakula@marvell.com, rkannoth@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com
Date: Fri, 06 Nov 2026 11:11:25 +0000
Message-ID: <179396348511.994134.3480253108877320302@kernel.org>
In-Reply-To: <20261104-xsk-zc-rx-double-free-v3-1-11a0c7ef1973@vecima.com>
References: <20261104-xsk-zc-rx-double-free-v3-1-11a0c7ef1973@vecima.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (3) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch, ixgbe's need_wakeup -ENOBUFS path keeps a
  live buffer and runs XDP on it again, but with stale data pointers.

Pre-existing issues:
- [High] The rule that the caller owns the buffer when redirect fails
  still breaks when a zero-copy buffer is redirected to anything other…
- [High] In otx2_xdp_rcv_pkt_handler()
  (drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c), the two…
- [High] In otx2_xdp_rcv_pkt_handler()
  (drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c), the AF_XDP…

--

xsk: Do not free ZC Rx buffer when the Rx ring is full

This commit stops xsk_rcv_zc() from freeing the zero-copy buffer when the
XSK Rx ring is full. A failed xdp_do_redirect() now leaves the buffer with
the caller. The drivers that relied on the core freeing it (i40e, ice, gve
DQO, octeontx2) now call xsk_buff_free() themselves on that path.

> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> index 82ed5e48b00ab..cc544420df112 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -686,8 +686,10 @@ static void gve_xsk_done_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
>  			goto err;
>  		break;
>  	case XDP_REDIRECT:
> -		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog)))
> +		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog))) {
> +			xsk_buff_free(xdp);
>  			goto err;
> +		}
>  		break;
>  	}
>  

[Severity: High]
This is a pre-existing issue, but does the rule in the commit message, "A
failed xdp_do_redirect() leaves the buffer owned by the caller", hold
when a zero-copy buffer is redirected to something other than an XSKMAP?

For non-XSKMAP targets, xdp_do_redirect() calls
xdp_convert_buff_to_frame(). For MEM_TYPE_XSK_BUFF_POOL that ends up in
xdp_convert_zc_to_xdp_frame(), which copies the packet into a new page
and always frees the ZC buffer:

net/core/xdp.c:xdp_convert_zc_to_xdp_frame() {
    ...
	page = dev_alloc_page();
    ...
	memcpy(addr, data_to_copy, totsize);
    ...
	xsk_buff_free(xdp);
	return xdpf;
}

__xdp_do_redirect_frame() can still fail after that. Examples:

  -EBADRQC for a bare XDP_REDIRECT
  -EINVAL for a missing ifindex
  -ENOENT during broadcast map teardown
  -EOPNOTSUPP, -ENETDOWN or -EMSGSIZE from __xdp_enqueue()

The err: label only traces and returns:

err:
	_trace_xdp_redirect_map_err(dev, xdp_prog, fwd, map_type, map_id, ri->tgt_index, err);
	return err;

On this error, mlx5e_xdp_handle() counts a drop and does not set
MLX5E_RQ_FLAG_XDP_XMIT. The XSK Rx paths in mlx5e then skip setting
MLX5E_WQE_FRAG_SKIP_RELEASE, so the buffer is released again at WQE
refill.

Wouldn't that produce the same duplicate UMEM frame, and the same
possible NULL dereference in mlx5e_post_rx_wqes(), that the commit message
describes?

dpaa2_xsk_run_xdp() has the same problem: on a redirect error it calls
dpaa2_eth_recycle_buf() on a buffer that is already on the xsk free list.

The copied xdp_frame page also seems to leak on every such failure.
Neither __xdp_do_redirect_frame() nor __xdp_enqueue() frees xdpf on error.

For gve DQO and octeontx2, the new xsk_buff_free() is a second free on
this path. It is harmless because xp_free() returns early for a buffer
already on the free list, but the page leak remains.

Neither the commit message nor the changelog mentions this path. Could
they say that the mlx5e duplicate frame problem is only fixed for XSKMAP
redirects?

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 90af9b9044aa0..6d10c132f61cb 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -1555,7 +1555,8 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  				*need_xdp_flush = true;
>  				return true;
>  			}
> -			return false;
> +			xsk_buff_free(xsk_buff);
> +			return true;
>  		}
>  
>  		err = xdp_do_redirect(pfvf->netdev, &xdp, prog);

[Severity: High]
This isn't a bug introduced by this patch, but the non-ZC branch just
below has the same problem the commit message describes for the ZC
branch. On redirect failure it does:

		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
				    DMA_FROM_DEVICE);
		xdpf = xdp_convert_buff_to_frame(&xdp);
		xdp_return_frame(xdpf);
		break;

It then falls out of the switch to return false.

otx2_rcv_pkt_handler() treats false as "not consumed" and continues with:

  napi_get_frags()
  otx2_skb_add_frag() for each cqe->sg segment, with a second
    cq->pool_ptrs++
  skb_mark_for_recycle()
  napi_gro_frags()

xdp_return_frame() has already given the page back to the page pool. Is
the skb then built on a page the pool can refill to hardware? And is that
page returned to the pool a second time when the skb is freed?

Should this branch also return true after freeing, as the XDP_DROP case
does?

[Severity: High]
This is a pre-existing issue, but on the zero-copy path the on-stack
xdp_buff in otx2_xdp_rcv_pkt_handler() is never initialized:

	struct xdp_buff xdp, *xsk_buff = NULL;
	...
	if (pool->xsk_pool) {
		xsk_buff = pool->xdp[--cq->rbpool->xdp_top];
		...
		act = bpf_prog_run_xdp(prog, xsk_buff);
		goto handle_xdp_verdict;
	}

This jumps past xdp_init_buff() and xdp_prepare_buff(). Only the
XDP_REDIRECT and drop cases check xsk_buff, so in ZC mode these cases run
on the uninitialized struct:

	case XDP_PASS:
		*metasize = xdp.data - xdp.data_meta;
		break;
	case XDP_TX:
		...
		xdpf = xdp_convert_buff_to_frame(&xdp);

Does XDP_TX here dereference an uninitialized xdp.rxq inside
xdp_convert_buff_to_frame()? With CONFIG_INIT_STACK_ALL_ZERO that is a
NULL dereference in NAPI context; without it, it is a wild pointer.

XDP_PASS also seems to compute metasize from uninitialized fields, and the
caller then passes that value to skb_metadata_set().

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 781ba46eb1525..89bac2feeff26 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -224,21 +224,15 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	struct list_head *xskb_list;
>  	u32 contd = 0;
>  	u32 num_desc;
> -	int err;
>  
> -	if (likely(!frags)) {
> -		err = __xsk_rcv_zc(xs, xskb, len, contd);
> -		if (err)
> -			goto err;
> -		return 0;
> -	}
> +	if (likely(!frags))
> +		return __xsk_rcv_zc(xs, xskb, len, contd);

[Severity: Medium]
Now that the buffer is no longer freed on -ENOBUFS, ixgbe's need_wakeup
retry runs XDP again on a live buffer. Is the buffer state still correct
for that rerun?

When need_wakeup is enabled, ixgbe_run_xdp_zc() returns IXGBE_XDP_EXIT on
-ENOBUFS. ixgbe_clean_rx_irq_zc() then breaks out without clearing
bi->xdp or advancing next_to_clean:

		} else if (xdp_res == IXGBE_XDP_EXIT) {
			failure = true;
			break;

On the next poll the same buffer is processed again with:

		bi->xdp->data_end = bi->xdp->data + size;
		xsk_buff_dma_sync_for_cpu(bi->xdp);
		xdp_res = ixgbe_run_xdp_zc(adapter, rx_ring, bi->xdp);

xdp->data and xdp->data_meta are not reset first; igb uses
xsk_buff_set_size() for this. Any bpf_xdp_adjust_head(),
bpf_xdp_adjust_meta() or header rewrite from the first run therefore
carries over.

After adjust_head(+N), wouldn't the rerun window extend N bytes past the
received frame, possibly past the end of the UMEM chunk? If the second
redirect succeeds, user space could get a shifted, truncated or over-long
descriptor.

In this patch, i40e and ice free and consume the descriptor on EXIT
instead. The v2 notes leave that change for ixgbe and igb to a follow-up.
Should ixgbe drop and consume the descriptor here as well, or reset the
buffer before the rerun?

On igb, the commit message says:

  - ixgbe and igb keep the buffer in the ring on their need_wakeup
    -ENOBUFS (XDP_EXIT) path and run XDP on it again on the next poll.

In igb_run_xdp_zc(), out_failure falls through to XDP_DROP, which
overwrites IGB_XDP_EXIT with IGB_XDP_CONSUMED. Does igb actually ever take
an EXIT path? If not, the igb part of this description looks inaccurate.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-xsk-zc-rx-double-free-v3-1-11a0c7ef1973%40vecima.com
