Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266BD3DDAFD;
	Mon, 10 Aug 2026 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368328; cv=none; b=fOof0EQZM4hnpJ8/IT7ZV8UljjZUtnWozKQf9gpxf2J58Fs/t1X15Th36DphvDhirlUs+Ll6ACAQgxxpudt2Xs3TgvCcYeR9GyjRS+TJQ83jMEWwDCtIQ2N1Tk+j+TsRmTfwGt05Nqe/k8JGs5LOUJO74ZxK78fOMInCREhTlq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368328; c=relaxed/simple;
	bh=wskSE1VD0EzHHGBmXGF4Fgxf1VLFRB6pyxJzKHE26os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qss+JSnNuRIdhGg4Bb8XIwW/J+0ASiDr08bRp9kglk0km4+yYX35usNLOdTg7tggQPqj12H8n/C0h9yi/qe3slCWLj7csJIQUKa7FjVNBt2nwchjPmQbsMaKeY+zrNIffh/Gfcn/YiptbV8C9DKIoXmJL0Nq3HWGoLX3Rf9QU6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtSw3bxf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtSw3bxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1371F000E9;
	Mon, 10 Aug 2026 13:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786368326;
	bh=dEtejrEdXgs99OR34sC90fBYAjTOj/HKk0gWcb2jKIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CtSw3bxf5BrqkkcvJV4BOxlbvnOBWOO+DEfYDEjbEMn7Am9v9vgaL70vxOENc6HJQ
	 vrDjkBYyZhF507msvYQEHO3hhQm4wFw+tZZf+h/tcs/jYGPr+HcLZV6vnv56yVjhVQ
	 0WBiuvCb4sME7dIjevupsKv8lgPhm4/X9F+JAj3X7jf5d2RXBVk8vnmxsTLkOWHxLd
	 ip7tiET7rhv1mRRbqVE0DSi1hqxmLnWfk6Jg8QxET1cbomEc3mmtSha0c7fQeuTW8d
	 2HK+EZ3E2btLOt4F6xQuvxqCTIbhTPFIcrWTHFSUC4RzLAmiJ6VG6aQPCwE82DL/77
	 RqTADGasbJkOw==
From: Simon Horman <horms@kernel.org>
To: blbllhy@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	magnus.karlsson@intel.com,
	kerneljasonxing@gmail.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH net v3] xsk: fix NULL pointer dereference in __xsk_rcv()
Date: Mon, 10 Aug 2026 14:25:05 +0100
Message-ID: <20260810132505.769431-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806204757.47817-1-blbllhy@gmail.com>
References: <20260806204757.47817-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260806204757.47817-1-blbllhy@gmail.com?part=1
---
--- Patch [1]: [PATCH net v3] xsk: fix NULL pointer dereference in __xsk_rcv() ---
commit ee824acf57213f0a5f7afb287ff22c8b8eefdc3c
Author: Cen Zhang (Microsoft) <blbllhy@gmail.com>

xsk: fix NULL pointer dereference in __xsk_rcv()

The patch converts the multi-buffer copy path in __xsk_rcv() into a
two-stage transaction: all buffers for a packet are allocated and staged
on the pool's xskb_list first, and only once that succeeds are the data
copied and the RX descriptors reserved. On an allocation failure the
staged buffers are recycled with xsk_buff_free().

Link: https://lore.kernel.org/netdev/20260724164719.99563-1-blbllhy@gmail.com

A couple of questions below, starting with the changelog.

The commit message ends at:

  "Only after the allocation stage succeeds, copy the data, reserve the
   RX descriptors, and release the buffers in an error-free loop using
   xsk_buff_get_frag()."

[Severity: Low]
[Finding: main-1-0]
[Sources: opus-5]
Should the message also describe the two new drop conditions the patch
adds?

The first is the new WARN_ON_ONCE(!list_empty(&xs->pool->xskb_list)),
which drops the packet and bumps rx_dropped based on pool-wide state that
is also written by xsk_buff_add_frag() and drained by xsk_rcv_zc().

The second is the new handling of a Fill Ring that hands out the same
chunk twice ("xsk_xdp == first || !list_empty(&xskb->list_node)"), which
is entirely under userspace control. Before this patch, an aligned-mode
Fill Ring containing a duplicate address made __xp_alloc() return
&pool->heads[xp_aligned_extract_idx(addr)] twice and the old loop emitted
two RX descriptors both pointing at that chunk; now the packet is dropped
and the Fill Ring entries are consumed with no descriptor produced.

Both are explained in the v3 changelog below the "---" separator, which is
dropped when the patch is applied, so neither git history nor a stable
backporter (the patch carries a Fixes: tag) sees them.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7855ee09c4b64..02ff3ad97410f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -343,11 +344,34 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  		frag =  &sinfo->frags[0];
>  	}
>  
> +	if (WARN_ON_ONCE(!list_empty(&xs->pool->xskb_list)))
> +		goto err_alloc;

[Severity: Medium]
[Finding: main-1-1]
[Sources: opus-5]
Can this condition ever clear itself once it fires? The err_alloc label
only does:

	err_alloc:
		xs->rx_dropped++;
		return -ENOMEM;

so pool->xskb_list is neither drained nor repaired. pool->xskb_list is a
field of the long-lived struct xsk_buff_pool, initialized once by
INIT_LIST_HEAD(&pool->xskb_list) in xp_create_and_assign_umem(), and it is
never reset per packet.

If a stale entry is ever left on that list, doesn't every subsequent
multi-buffer copy-mode packet for every socket sharing the pool take this
branch and get dropped, with the stranded buffers never returned to
pool->free_list? Since WARN_ON_ONCE only prints once, the drops after that
are silent.

Would draining the list here, or keeping the staging list call-local, be
preferable to a bailout for a condition that persists?

> +
> +	first = xsk_buff_alloc(xs->pool);
> +	if (!first)
> +		goto err_alloc;
> +
> +	xdp_buff_set_frags_flag(first);
> +	for (i = 1; i < num_desc; i++) {
> +		xsk_xdp = xsk_buff_alloc(xs->pool);
> +		if (!xsk_xdp)
> +			goto err_free;
> +
> +		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> +		if (unlikely(xsk_xdp == first ||
> +			     !list_empty(&xskb->list_node)))
> +			goto err_free;
> +
> +		list_add_tail(&xskb->list_node, &xs->pool->xskb_list);
> +	}

[Severity: High]
[Finding: main-5-7]
[Sources: opus-5]
What serializes access to xs->pool->xskb_list here? The two callers of
__xsk_rcv() do not share a lock:

net/xdp/xsk.c:xsk_generic_rcv() {
	err = xsk_rcv_check(xs, xdp, len);
	if (!err) {
		spin_lock_bh(&xs->pool->rx_lock);
		err = __xsk_rcv(xs, xdp, len);
		...
}

net/xdp/xsk.c:xsk_rcv() {
	...
	err = __xsk_rcv(xs, xdp, len);
	if (!err)
		xdp_return_buff(xdp);
	...
}

xsk_rcv() (reached from __xsk_map_redirect()) holds no pool lock, so the
per-packet staging state now lives in pool-global list state with an empty
lockset. Previously each buffer was a local variable in this function.

A concrete unlocked, non-NAPI caller is cpumap:

kernel/bpf/cpumap.c:cpu_map_bpf_prog_run_xdp() {
	struct xdp_rxq_info rxq = {};
	...
		rxq.dev = xdpf->dev_rx;
		rxq.mem.type = xdpf->mem_type;
		/* TODO: report queue_index to xdp_rxq_info */
	...
			err = xdp_do_redirect(xdpf->dev_rx, &xdp, rcpu->prog);
}

queue_index defaults to 0 and mem.type is page-based, so an XDP_REDIRECT
into an xskmap from that program passes xsk_dev_queue_valid(), takes the
copy path, and runs from a cpumap kthread that can execute concurrently
with the NIC NAPI, another cpumap kthread, or a generic-XDP
xsk_generic_rcv() on another CPU that only holds rx_lock.

Can that lead to concurrent list_add_tail() on the same list_head, i.e.
list corruption? And can xsk_buff_get_frag() in the copy loop pop a buffer
staged by the other context, so the same umem chunk ends up published in
two different RX descriptors?

Note also that the helpers touching this list in
include/net/xdp_sock_drv.h have no internal locking:

include/net/xdp_sock_drv.h:xsk_buff_get_frag() {
	frag = list_first_entry_or_null(&xskb->pool->xskb_list,
					struct xdp_buff_xsk, list_node);
	if (frag) {
		list_del_init(&frag->list_node);
		ret = &frag->xdp;
	}
}

They were previously reached only from the NAPI/zero-copy driver context.

> +
> +	xdp_buff_clear_frags_flag(first);
> +	xsk_xdp = first;
>  	do {
>  		u32 to_len = frame_size + meta_len;
>  		u32 copied;
>  
> -		xsk_xdp = xsk_buff_alloc(xs->pool);
> +		next = xsk_buff_get_frag(xsk_xdp);

[Severity: Low]
[Finding: main-2-3]
[Sources: opus-5]
This isn't a bug today, but the producer/consumer protocol for
pool->xskb_list is now implemented two different ways in-tree.

The canonical producer is:

include/net/xdp_sock_drv.h:xsk_buff_add_frag() {
	if (!__xdp_buff_add_frag(head, virt_to_netmem(data),
				 offset_in_page(data), xdp->data_end - data,
				 xdp->frame_sz, false))
		return false;

	frag = container_of(xdp, struct xdp_buff_xsk, xdp);
	list_add_tail(&frag->list_node, &frag->pool->xskb_list);
}

__xdp_buff_add_frag() sets the head's XDP_FLAGS_HAS_FRAGS and updates the
head's skb_shared_info nr_frags/len. The new code open-codes the producer
side with a bare list_add_tail() plus xdp_buff_set_frags_flag(first) and no
skb_shared_info initialization, while using the official consumer
xsk_buff_get_frag(). That yields a frags-flagged xdp_buff whose shared info
at xdp_data_hard_end() is uninitialized. Today nothing reads it
(xsk_buff_free() only writes nr_frags = 0), but would it be safer to reuse
xsk_buff_add_frag() here?

Related: xsk_buff_get_frag() is declared as

	static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)

and every other caller passes the head buffer, whereas this loop passes the
fragment returned by the previous iteration. That only works because the
body uses the argument solely to reach xskb->pool.

>  		copy_to = xsk_xdp->data - meta_len;
>  
>  		copied = xsk_copy_xdp(copy_to, &copy_from, to_len, &from_len, &frag, rem);
> @@ -356,10 +380,21 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
>  		__xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
>  				  rem ? XDP_PKT_CONTD : 0);
> +		xsk_xdp = next;
>  		meta_len = 0;
>  	} while (rem);
>  
>  	return 0;
> +
> +err_free:
> +	/* Re-set frags flag; xsk_buff_alloc() may have cleared first->flags
> +	 * if the same Fill Ring address aliased back to first.
> +	 */
> +	xdp_buff_set_frags_flag(first);
> +	xsk_buff_free(first);
> +err_alloc:
> +	xs->rx_dropped++;
> +	return -ENOMEM;
>  }

Following on from the locking question above: with the frags flag set,
xsk_buff_free() walks the whole pool list:

include/net/xdp_sock_drv.h:xsk_buff_free() {
	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
		list_del_init(&pos->list_node);
		xp_free(pos);
	}
	...
}

so if another context has entries staged on pool->xskb_list at that moment,
does this error path xp_free() buffers that are still in flight there,
skewing pool->free_list/free_heads accounting?
