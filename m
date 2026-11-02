Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650336;
	b=2rf0Ws0jGdUqz2KTNj1XK+C4pH0XW1T3Mr7tqLYAtOd+VWere0ZR5l5yN5+y4FDVYfV3
	 LUdjrAXLMMp53lPFys6F74zsu8TJ5cClGOQMyQJvfeSs4kWzaphohtJOfq60sF6B1H1Xf
	 PF8HLF8sXox9lnxv2YPqFhWn1o1SrLvaLXTzzBf9fF9RaduMficgLKl528rvXT9fKMWn5
	 uVBEGi8zdjVxfGFcWRvCaE84w+b6ySzmAfrGXpr0Ok9B7cY5krsyPwLL8mwGX/WgLc6z9
	 InjZPznUMCla42uyCp3joUrqXsTHK9o4IIXHKlfVqJKQSdrYYB2upwMwO9khPGg0p7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650336;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=35huFANGVg4RT6AeDQ1nJ0dNPSmmlMv3374wgFMWx8c=;
	b=ET99jebaSlO066lphUJtuAP7jhOhGT/EEZlR9tGG8kjH5qDM9guAi73BkshJ/EipPRUs
	 kXSqsMFifAfu6fkyAzGQY05dMwtpIYuFW+VkAvk1hJ8M9UHvSPOSCQMoqldm8krJNlqzh
	 Wy6r/H9lLztq4IU2fhzbXGXfuXYtmqrIBnrvsuipY/PqqIzuL5MyFw/ja5F6U0/pTvIJB
	 7IQRbrBIadrWjWRLrJD9dz9pN9q62EDNMDCKzqgDu2ZJyNXvgGuD/RtodJBWceEe8gMVC
	 3jJxx79WZtNhrZAnRAtiNbEoki0K7txYh7MjZCnxf1LvrzwmW2Lk30+OxvxsZZov0BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kl9uytlD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8A606A329;
	Mon,  2 Nov 2026 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kl9uytlD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EBB1F00A16;
	Mon,  2 Nov 2026 20:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650336;
	bh=35huFANGVg4RT6AeDQ1nJ0dNPSmmlMv3374wgFMWx8c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Kl9uytlDZhW8RhoEg4o+yb1fuh9I16AOtEhcs5v+o3fRyWsFug/1MJAuB7eFLYSPu
	 xGQeX0f8yxkntDGREQf22bSfGNbUAG8kPJWikr7/Qxg214f5D+gcnpD5tBEQ2K1K6W
	 f9AnvygYFwfYc6Ot7SQ2CQPrvCFs5yaaYMEJmCJEk0hzEzuMbjvbMh6QHytDyn7G8L
	 mOmjnglfLCLEJHVbDm7EEHg+0zfsJr8ajNywum/+LM4fIMIqN9wkt/tuDk6oFDsxwG
	 eUL4XlwEYyRhiHYfRkl7JyDbDjehnrtiXwOE+FfRqQgWrFog3vdEB00mJwuPdx90kR
	 QmFhWtIek7hug==
Subject:
 Re: [PATCH net] octeontx2-pf: fix XDP frames freed as skbs on interface down
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, sumang@marvell.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Mon, 02 Nov 2026 20:12:14 +0000
Message-ID: <179365033465.3131.17188664588787330051@kernel.org>
In-Reply-To:
 <20261030-nb-otx2-xdp-cqe-cleanup-net-v1-1-710635c0f504@tipi-net.de>
References:
 <20261030-nb-otx2-xdp-cqe-cleanup-net-v1-1-710635c0f504@tipi-net.de>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (3) · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new CQ_XDP branch in otx2_cleanup_tx_cqes()
  (otx2_txrx.c:1352-1355) sends XDP CQEs to…
- [Medium] octeontx2-pf: missing xsk_tx_completed() call in
  otx2_cleanup_tx_cqes()

Pre-existing issues:
- [High] Nothing fences otx2_xdp_xmit() (ndo_xdp_xmit) off from XDP SQ
  teardown on the 'XDP program is replaced' path the commit message…
- [High] otx2_stop() calls only napi_synchronize() for each CINT
  (otx2_pf.c:2267) before otx2_free_hw_resources() (line 2277).
- [High] In AF_XDP zero-copy mode, otx2_xdp_rcv_pkt_handler()
  (otx2_txrx.c:1520-1527) runs the BPF program on xsk_buff and does…
- [Medium] otx2_free_pending_sqe() (otx2_txrx.c:1408) only walks `sq_idx
  < pfvf->hw.tx_queues`.

--

octeontx2-pf: fix XDP frames freed as skbs on interface down

With this patch, otx2_cleanup_tx_cqes() passes CQEs from XDP completion
queues to otx2_xdp_snd_pkt_handler() instead of treating sg->skb as an
sk_buff. Before this, pending xdp_frames on XDP queues were freed with
dev_kfree_skb_any() on ifdown or XDP program replacement, which corrupted
page pool memory.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 90af9b9044aa0..e3b07e5335fb8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -1332,6 +1332,7 @@ void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
>  	struct nix_cqe_tx_s *cqe;
>  	struct netdev_queue *txq;
>  	int processed_cqe = 0;
> +	int xsk_frames = 0;
>  	struct sg_list *sg;
>  	int qidx;
>  
> @@ -1348,6 +1349,10 @@ void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
>  
>  		if (!cqe)
>  			continue;
> +		if (cq->cq_type == CQ_XDP) {
> +			otx2_xdp_snd_pkt_handler(pfvf, sq, cqe, &xsk_frames);
> +			continue;
> +		}

[Severity: Medium]
The new CQ_XDP branch fills in xsk_frames, but is it ever used after
the loop?

For entries flagged OTX2_AF_XDP_FRAME, otx2_xdp_snd_pkt_handler() only
bumps the counter and returns. It leaves it to the caller to publish
the completions. On the NAPI path, otx2_tx_napi_handler() hands the
count to otx2_zc_submit_pkts(), which calls xsk_tx_completed().

otx2_cleanup_tx_cqes() never reads xsk_frames and never calls
xsk_tx_completed(). It still rings NIX_LF_CQ_OP_DOOR for those CQEs,
so the hardware considers them consumed.

When otx2_zc_napi_handler() queued these frames,
xsk_tx_peek_release_desc_batch() had already consumed the TX ring
descriptors and reserved completion ring entries for them. Consider
an AF_XDP zero-copy socket that is transmitting while the interface
goes down or the XDP program is replaced:

otx2_xdp_setup()->otx2_stop()->otx2_free_hw_resources()->
    otx2_cleanup_tx_cqes()

Do the completions reaped here then never reach the XSK completion
ring? If so, userspace would never get those UMEM frames back. The
reserved completion ring slots would also stay reserved across the
down/up cycle.

sq->xsk_pool is still attached at this point. It is only cleared in
otx2_xsk_pool_disable(). Would calling
xsk_tx_completed(sq->xsk_pool, xsk_frames) after the loop, when
sq->xsk_pool is set and xsk_frames is non-zero, be the right fix?
otx2_zc_submit_pkts() itself doesn't fit here, since it also submits
new TX descriptors.

[Severity: Medium]
Should xsk_frames be reported back to the XSK pool after this loop?

For AF_XDP zero-copy entries, otx2_xdp_snd_pkt_handler() only counts
them:

	if (sg->flags & OTX2_AF_XDP_FRAME) {
		(*xsk_frames)++;
		return;
	}

In the NAPI path, otx2_tx_napi_handler() passes the count to
otx2_zc_submit_pkts(), which does:

	if (*xsk_frames)
		xsk_tx_completed(xsk_pool, *xsk_frames);

otx2_cleanup_tx_cqes() fills xsk_frames but never reads it. It then rings
NIX_LF_CQ_OP_DOOR for those CQEs anyway.

Take an AF_XDP ZC socket that is transmitting while the interface goes
down or the XDP program is swapped:

otx2_xdp_setup()->otx2_stop()->otx2_free_hw_resources()->
    otx2_cleanup_tx_cqes()

Do the completed descriptors then never reach the xsk completion ring? If
so, userspace never gets those UMEM frames back. The completion ring slots
reserved by xsk_tx_peek_release_desc_batch() would also stay reserved
across down/up cycles.

sq->xsk_pool is still attached at this point. It is only cleared in
otx2_xsk_pool_disable(). Would adding something like this after the loop
work?

	if (sq->xsk_pool && xsk_frames)
		xsk_tx_completed(sq->xsk_pool, xsk_frames);

otx2_zc_submit_pkts() itself does not fit here, because it also submits
new TX packets.

[Severity: Medium]
This is a pre-existing issue, but it is on the same XDP teardown path.
otx2_free_pending_sqe() only walks the regular TX SQs:

	for (sq_idx = 0; sq_idx < pfvf->hw.tx_queues; sq_idx++) {

So nothing checks the XDP SQs for SQEs the NIC never completed.
otx2_sqb_flush() does not wait for the queue to drain. It sleeps once per
non-empty SQ:

	if (sqe_head != sqe_tail)
		usleep_range(50, 60);

XDP SQEs with no CQE can therefore still be there after
otx2_txschq_stop(), for example under PFC pause or link loss.

Is the xdp_frame in sg->skb ever returned for those entries? For
OTX2_XDP_REDIRECT entries, is the DMA_TO_DEVICE mapping created in
otx2_xdp_xmit_tx() ever unmapped before otx2_free_sq_res() frees sq->sg?

Widening the loop would not work as-is, because it uses
dev_kfree_skb_any(). The XDP SQs need an XDP-aware release.

[Severity: High]
This isn't a bug introduced by this patch. The commit message mentions
"when the XDP program is replaced". On that path, is ndo_xdp_xmit kept
away from the XDP SQ teardown?

otx2_xdp_setup() calls otx2_stop() directly and swaps the program only
afterwards:

	if (if_up)
		otx2_stop(pf->netdev);

	old_prog = xchg(&pf->xdp_prog, prog);

So during teardown netif_running() is still true and pf->xdp_prog is still
set. Those are the only two things otx2_xdp_xmit() checks:

	if (!netif_running(netdev))
		return -ENETDOWN;

	qidx += pf->hw.tx_queues;
	sq = pf->xdp_prog ? &pf->qset.sq[qidx] : NULL;

There is no OTX2_FLAG_INTF_DOWN check and no lock.
otx2_xdp_sq_append_pkt() also writes sq->sqe_base and sq->sg[] without
locking.

Suppose another device redirects into this one through a devmap
(xdp_do_flush()->bq_xmit_all()->ndo_xdp_xmit()) while otx2_stop() runs:

otx2_free_hw_resources()
    otx2_cleanup_tx_cqes()
    otx2_free_sq_res()      /* kfree(sq->sg), qmem_free(sq->sqe) */
otx2_free_queue_mem()       /* kfree(qset->sq); qset->sq = NULL */

Can the redirect path then write into freed sq->sg or SQE memory, or
dereference the NULL qset->sq?

otx2_stop() only synchronizes this device's IRQs and NAPIs, and there is
no synchronize_net(). Frames appended during teardown would also leak
their xdp_frame and DMA mapping.

[Severity: High]
This is a pre-existing issue, but can NAPI run at the same time as this
cleanup loop? otx2_stop() does:

	cq_poll = &qset->napi[qidx];
	napi_synchronize(&cq_poll->napi);
	...
	otx2_free_hw_resources(pf);
	otx2_free_cints(pf, pf->hw.cint_cnt);
	otx2_disable_napi(pf);

napi_synchronize() only waits for a poll that is already running. The
NAPI is still enabled, so socket or AF_XDP busy polling (napi_busy_loop())
can claim it again. It then processes the same XDP CQ:

otx2_napi_handler()
    otx2_tx_napi_handler()
        otx2_xdp_snd_pkt_handler()

This loop and the NAPI path both update cq->cq_head and cq->pend_cqe
without a lock. Could both pick up the same CQE and call
xdp_return_frame() twice on the same sg->skb? Or could one call
xdp_return_frame(NULL) after the other has cleared it?

There is a second window later in otx2_free_hw_resources():
otx2_free_cq_res() frees the CQE memory while busy poll can still run the
handler.

The same race existed before this patch for both the skb and XDP CQs.

[Severity: High]
This isn't a bug introduced by this patch. However, the new branch adds
another consumer of sg->skb values that may be bogus in AF_XDP zero-copy
mode.

In otx2_xdp_rcv_pkt_handler(), the ZC branch jumps past the
initialization of the local xdp_buff:

	if (pool->xsk_pool) {
		xsk_buff = pool->xdp[--cq->rbpool->xdp_top];
		...
		act = bpf_prog_run_xdp(prog, xsk_buff);
		goto handle_xdp_verdict;
	}

The XDP_TX case then uses &xdp rather than xsk_buff:

	case XDP_TX:
		...
		xdpf = xdp_convert_buff_to_frame(&xdp);
		return otx2_xdp_sq_append_pkt(pfvf, xdpf,

xdp_convert_buff_to_frame() reads xdp->rxq->mem.type and writes the frame
header at xdp->data_hard_start.

Doesn't this dereference uninitialized stack data on every XDP_TX verdict
in ZC mode?

The resulting pointer is stored in sq->sg[].skb with OTX2_XDP_TX. Both the
NAPI completion path and the new CQ_XDP branch later pass it to
xdp_return_frame().

The XDP_PASS case has a similar problem in ZC mode:

	case XDP_PASS:
		*metasize = xdp.data - xdp.data_meta;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030-nb-otx2-xdp-cqe-cleanup-net-v1-1-710635c0f504%40tipi-net.de
