Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795878891;
	b=RcC/ZLDfTM72bNaDkj4CJKeTyr0wcMes1f4a7vlAl8OMRHrLtSYXOBUnmqpNqNgFlzgE
	 ICyBE00IZEen9R9dAUMgTsemO2IG01ONDLI8lLkQt5ZdiEezKe0Nv7Ob4AqyWK8w94TY1
	 MccEyWsvetdRNJz69+xDS2s1q40k+PD9gs4kpK88dDvDSJbn/0PGxFP3YeBDD93bUkqYp
	 MT2vls0eTOEJ5a4+oJdOpmT3uXBn4clFu/mSqsEjGVR1bUjeCrRuz1ORX4T5wDUEo10hl
	 E6QjOUuUogBfECMfhlEWPUpAbDeKd+1CSxuifgeOOSsjMsUK2OkN1oF07AxNKVT/a5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795878891;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=u/C8RYi6+798S4kpGGanhV2w42xyOLOAvKc1eEMfPfo=;
	b=Z8M9/Pl5+4VbBqzn0p6L/qqno++TLnH7B5GQUcJ4piEOPXu7M0/rlqH09VmMcLfp6Iog
	 nXSmVIrEVbR3FUpM7yXCuFEHDBAsN186lYYg84evl4daEBcttPZZL9fMSoJpcyoo+kWqY
	 wK+wul8058VNJTyPBXj+j6LVWtUF/gN/B/G8+ERy1MTLVwnE0/gyhqdIsBPT68PiVd8sJ
	 9SCnhit6/NkTmUQazU+UGkGQhsQHKm/Wr1Opek70qxcLUmnO6vbbiAgzRREhQXXYRaYlL
	 SwhBgthPk7VIsjlCenn0hvVqMsF5hqeW1cVyx7hUiXZRun1PBziMgM0dhzNS+Vmjrgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PoXhA8ak;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79710606A31C;
	Sat, 28 Nov 2026 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PoXhA8ak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3923D1F000C1;
	Sat, 28 Nov 2026 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795878891;
	bh=u/C8RYi6+798S4kpGGanhV2w42xyOLOAvKc1eEMfPfo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PoXhA8akbo0rxfgCNkBeJVK7LP/8uFhk2ZHEaF6Aalnt1BA2ApE9YCtudUqVY7TZE
	 D8Aboeh4vTcBpBvkzpDR+qJdx+Uj1juqJkKJ/HpyOSr3eOoW0TUwBgIqKlwuOHH7uF
	 7DJZ4wKJkiVo9ZGn9Ks1oohVy2aQi3Ulhfk6BlkUiVcnyfGJbEo+wRttoghKsrrZLL
	 bLZkVsYvdrZLHAjnLttRm9BGBRImsxmWZxdKIBnsD37+lG5tjzKrSagO5jQqAvR75Z
	 dctjZKqWsipby5GqiHsnzXXasf8FpVA36nUue3zAGRnflFfSAZL1bk43LGJ2NXy+8e
	 FBYzw0juLP03w==
Subject: Re: [PATCH net 1/3] libeth: xsk: Count each XDP_TX buffer on its own
From: netdev-bot+sashiko@kernel.org
To: bjorn@kernel.org
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 aleksander.lobakin@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, shuah@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, horms@kernel.org,
 sdf@fomichev.me, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, larysa.zaremba@intel.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com,
 bastien.curutchet@bootlin.com, colin.i.king@gmail.com,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Date: Sat, 28 Nov 2026 15:14:48 +0000
Message-ID: <179587888871.3135.18266598324203799547@kernel.org>
In-Reply-To: <20261127142131.3527737-2-bjorn@kernel.org>
References: <20261127142131.3527737-2-bjorn@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The in-flight count still goes the wrong way.
- [Low] The kernel-doc for struct libeth_sqe in include/net/libeth/tx.h
  no longer matches LIBETH_SQE_XSK_TX / LIBETH_SQE_XSK_TX_FRAG SQEs.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  libeth_xsk_tx_queue_bulk() (include/net/libeth/xsk.h) mishandles a…
- [Low] Dismissed (baseline false).

--

libeth: xsk: Count each XDP_TX buffer on its own

At bulk flush time, libeth no longer reads the shared info of an XSk
XDP_TX frame to get the fragment count and byte totals. Each SQE now
records the length of its own buffer. On completion, every head or
fragment SQE takes one off the in-flight count, and the head also
counts the packet.

> diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
> index c3db5c6f16410..25cad55664363 100644
> --- a/include/net/libeth/tx.h
> +++ b/include/net/libeth/tx.h
> @@ -22,7 +22,8 @@
>   * @LIBETH_SQE_XDP_XMIT: &xdp_frame, unmap and xdp_return_frame_bulk(), stats
>   * @LIBETH_SQE_XDP_XMIT_FRAG: &xdp_frame frag, only unmap DMA
>   * @LIBETH_SQE_XSK_TX: &libeth_xdp_buff on XSk queue, xsk_buff_free(), stats
> - * @LIBETH_SQE_XSK_TX_FRAG: &libeth_xdp_buff frag on XSk queue, xsk_buff_free()
> + * @LIBETH_SQE_XSK_TX_FRAG: &libeth_xdp_buff frag on XSk queue, xsk_buff_free(),
> + *			    stats
>   */
>  enum libeth_sqe_type {
>  	LIBETH_SQE_EMPTY		= 0U,

[Severity: Low]
The enum doc is updated here. Should the struct libeth_sqe kernel-doc in
the same file be updated as well? It still describes per-frame values:

 * @nr_frags: number of frags in the frame this buffer belongs to
 * @packets: number of physical packets sent for this frame
 * @bytes: number of physical bytes sent for this frame

After this patch, libeth_xsk_tx_fill_buf() stores only the length of
its own buffer in sqe->bytes. It also no longer calls
libeth_xdp_tx_fill_stats(), so nothing writes sqe->nr_frags for XSk
XDP_TX SQEs. The field keeps whatever an earlier user of that ring slot
left there.

Nothing reads these fields as frame totals today, so this only affects
the documentation.

> diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
> index 898723ab62e81..66a3c4ec9967e 100644
> --- a/include/net/libeth/xdp.h
> +++ b/include/net/libeth/xdp.h
> @@ -1794,12 +1794,19 @@ __libeth_xdp_complete_tx(struct libeth_sqe *sqe, struct libeth_cq_pp *cp,
>  	switch (type) {
>  	case LIBETH_SQE_XDP_TX:
>  	case LIBETH_SQE_XDP_XMIT:
> -	case LIBETH_SQE_XSK_TX:
>  		cp->xdp_tx -= sqe->nr_frags;
>  
>  		cp->xss->packets++;
>  		cp->xss->bytes += sqe->bytes;
>  		break;
> +	case LIBETH_SQE_XSK_TX:
> +		cp->xss->packets++;
> +		fallthrough;
> +	case LIBETH_SQE_XSK_TX_FRAG:
> +		/* One buffer per SQE, see libeth_xsk_tx_fill_buf() */
> +		cp->xdp_tx--;

[Severity: High]
Does this decrement move the in-flight count the right way once idpf
applies it?

idpf_xsksq_complete_slow() builds cp without an initializer for xdp_tx,
so the field starts at 0. The result is then subtracted from the queue
counter:

drivers/net/ethernet/intel/idpf/xsk.c:idpf_xsksq_complete_slow() {
	struct libeth_cq_pp cp = {
		.dev	= xdpsq->pool->dev,
		.bq	= &bq,
		.xss	= &ss,
		.napi	= true,
	};
    ...
	xdpsq->xdp_tx -= cp.xdp_tx;
    ...
}

After T buffers complete, cp.xdp_tx is (u32)-T, so the final
subtraction gives xdpsq->xdp_tx + T. The send side adds to the same
counter:

include/net/libeth/xdp.h:libeth_xdp_tx_xmit_bulk() {
    ...
	if (sq.xdp_tx)
		*sq.xdp_tx += n;
    ...
}

So xdpsq->xdp_tx seems to grow on both send and completion, and only
gets back to 0 when the u32 wraps. idpf_xdpsq_complete() in idpf/xdp.c
applies the delta the same way. The existing cp->xdp_tx -=
sqe->nr_frags for XDP_TX/XDP_XMIT follows the same convention.

The only reader is the fast path in idpf_xsksq_complete():

	if (likely(!xdpsq->xdp_tx)) {
		...
		xsk_frames = done_frames;

		goto finalize;
	}

If the counter never returns to 0, this fast path stays off after the
first XSk XDP_TX buffer is sent on the queue.

What happens if the counter wraps to exactly 0 while XSK_TX or
XSK_TX_FRAG SQEs are still outstanding? Every finished descriptor would
then go to xsk_tx_completed() as an xmit completion.
libeth_xdp_complete_tx() would be skipped, so those XDP_TX buffers would
never go back to the pool.

That looks like the same "wrong number of completions" result the
commit message says it fixes. The commit message also says:

  Head and fragments each take one off the in-flight count

Given how idpf applies the delta, each completed SQE appears to add one
instead. Later patches in the series don't seem to touch this either.

Should libeth accumulate a positive count here (cp->xdp_tx++, and
cp->xdp_tx += sqe->nr_frags above)? Or should idpf add cp.xdp_tx
instead of subtracting it?

[Severity: Low]
This isn't a bug introduced by this patch, but the kernel-doc for
struct libeth_cq_pp in include/net/libeth/tx.h says:

 * @xdp_tx: number of XDP-not-XSk frames processed

__libeth_xdp_complete_tx() actually counts buffers, and that includes
XSk XDP_TX buffers. The old code already counted LIBETH_SQE_XSK_TX
here. Could the wording be fixed while this code is being changed?

> +		cp->xss->bytes += sqe->bytes;
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
> index 249b1c7407881..2cd4252a3445f 100644
> --- a/include/net/libeth/xsk.h
> +++ b/include/net/libeth/xsk.h
> @@ -129,6 +129,10 @@ libeth_xsk_tx_fill_buf(struct libeth_xdp_tx_frame frm, u32 i,
>  
>  	sqe = &sq->sqes[i];
>  	sqe->xsk = xdp;
> +	/* Count each buffer on its own SQE. The shared info of the frame
> +	 * may change before the bulk is flushed.
> +	 */
> +	sqe->bytes = desc.len;
>  
>  	if (!(desc.flags & LIBETH_XDP_TX_FIRST)) {
>  		sqe->type = LIBETH_SQE_XSK_TX_FRAG;

[ ... ]

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. It
is in the same XSk XDP_TX path: does libeth_xsk_tx_queue_bulk() in this
file handle a flush failure in the middle of a frame correctly?

	for (struct libeth_xdp_buff *head = xdp; ; ) {
		xdp = container_of(xsk_buff_get_frag(&head->base),
				   typeof(*xdp), base);
		if (!xdp) {
			...
			xdp_buff_clear_frags_flag(&head->base);
			break;
		}

		if (unlikely(bq->count == LIBETH_XDP_TX_BULK) &&
		    unlikely(!flush_bulk(bq, LIBETH_XDP_TX_XSK))) {
			ret = false;
			break;
		}

		libeth_xsk_tx_queue_frag(bq, xdp);
	}

By this point, xsk_buff_get_frag() has already removed the frag from
pool->xskb_list with list_del_init(). If the bulk is full and
flush_bulk() fails because the XDPSQ has no free descriptors, the loop
breaks and that frag is neither queued nor freed. Does this leak one
UMEM buffer from the pool on every such failure?

The head is also left in a bad state. xdp_buff_clear_frags_flag(),
added by commit 90e5d84086d9 ("libeth: xsk: do not free in-flight frags
on XDP_TX completion"), only runs on the !xdp exit. So the head keeps
XDP_FLAGS_HAS_FRAGS.

At that point the head is either already in the HW ring from an earlier
mid-frame flush, or still in the bulk. Without LIBETH_XDP_TX_DROP,
libeth_xdp_tx_exception() only memmove()s it.

When the head is later completed or dropped, libeth_xsk_buff_free_slow()
calls xsk_buff_free(). Because the frags flag is still set, that frees
everything on the pool-wide list:

include/net/xdp_sock_drv.h:xsk_buff_free() {
    ...
	if (likely(!xdp_buff_has_frags(xdp)))
		goto out;

	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
		list_del_init(&pos->list_node);
		xp_free(pos);
	}
    ...
}

The list can then hold frags of another frame being queued, or of a
partial Rx frame stashed across NAPI polls. Could those buffers go back
to the pool while still in use, and later be freed a second time through
their own SQEs?

The remaining frags of the failed frame also stay on xskb_list. They
would then be picked up as frags of the next multi-buffer frame.

This goes back to b3ad8450b4dc, and 90e5d84086d9 only covered the
success exit. Would it help to free the popped frag (or put it back) on
this error path, and handle the head's frags flag consistently?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127142131.3527737-1-bjorn%40kernel.org
