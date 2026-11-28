Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795878894;
	b=Jdzhzx6Avm4Vz3IQ0xf/MlX9x6YwOsU8f1bHkDKG6IM67i5R/QgwR1LX5Iaw6F/UooQv
	 oYuff7ITqqrARGkWiJUYaVIve8uL1hE4RaTvifJz2ZPY3J6BZPnTfxTMPZSf1FPaxRMOj
	 0wIvEmMk0DszReRRC7kwz+WRo3csXVfWXVQFeFx37XFgF9FplPDeSGtSt+6Bgg+pYGZUk
	 5TLEN8EHzIIuIs9EEjczDKwhbigvCi6aXNpF0l/eLGqAnkRj7sdHFGDiUeZm65KubGO/S
	 HqQkg0RJ9u8GmAKq+KKxWy9dygYmyZlHER/hS2iCYV/p0c4SAaXZImQbOOlZLH2l9EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795878894;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FpsoEXqSK3IMNo6ryPhFPnR25QbgpB2sugtr6bbIz/0=;
	b=1a1zvPjvzw9/JePuHFC88A29+iZ/sUWjoWAOZt2mcGkFZ4MdbOISYB6xbQADKMpPrpfC
	 Vky2+/CwNGk2Y4gDLsHndej7/cSa8y68hSFwMqCXUHRnDizFZ5UoRIV5V08dKPh+GKmwm
	 WG2qA7pTkE0CpXWmhQs6uH1kOcXOJMFAMIcK1tYayU5HehDMdeT1zydeCYuR8u/Yyl4rb
	 iOYzBrJkvHQVw7Dq5Cy2Kzaoi57t8XmWgEUElYsHSJxM0MZmLxhyW3xitVah28vLghaLL
	 8D0OjOiQ8LochUxTnG37gCm02g/yaGi8b6MBedq1uSAFDicuZlsogpHpMN5J5WEGXwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IIcX1b2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ECA606A323;
	Sat, 28 Nov 2026 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIcX1b2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF55A1F00898;
	Sat, 28 Nov 2026 15:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795878893;
	bh=FpsoEXqSK3IMNo6ryPhFPnR25QbgpB2sugtr6bbIz/0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IIcX1b2/Zz4sRVWHfznny0jQA/4pQvNrD/Nuwh3E/lTHG8z0WcsSa+i5FojC7A43Y
	 pcL3w1A6W43/wihknGzixuQ6y2Rkmmtyuk+Pf/1k5aGwy8ZkLJgSin9fTx2pRi4Hd/
	 7Pu9PAo+t7f9j1YaAPEGaHZqKvB3FMnu9iLxPrtMI7e2irK8QtZvcBpu+aD5cgIj6e
	 oDyu/6UMk81pnCEfA1CZNZBvSzwBoQsn9XxhAzKkTryII4l8tbF7T1K6da1SzzxHJl
	 YdezirG07jlTnntLDceATp3eTYqhyQqcn+zmzaY3fD9A7FbW/4uJs5oLkORzENBWz4
	 7AVo0zD6+Upeg==
Subject: Re: [PATCH net 2/3] xsk: Keep the shared info of zero-copy buffers in
 kernel memory
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
Date: Sat, 28 Nov 2026 15:14:51 +0000
Message-ID: <179587889144.3135.7516970201926139253@kernel.org>
In-Reply-To: <20261127142131.3527737-3-bjorn@kernel.org>
References: <20261127142131.3527737-3-bjorn@kernel.org>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Heap overflow in xdp_build_skb_from_zc() (net/core/xdp.c).
- [High] xdp_build_skb_from_zc() (net/core/xdp.c) copies with
  memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len)), which…
- [Medium] xp_set_rxq_info() (net/xdp/xsk_buff_pool.c) has a publication-
  order race with a live datapath.
- [Medium] xsk: lost XDP_FLAGS_SINFO_EXT flag on buffer reuse in
  buf_to_xdp()
- [Low] The comment in bpf_xdp_adjust_tail() (net/core/filter.c:4513)
  still says "Notice that xdp_data_hard_end have reserved some tailroom".
- [Low] The new 'struct skb_shared_info sinfo' member of struct
  xsk_buff_pool (include/net/xsk_buff_pool.h) is placed in the section…

--

xsk: Keep the shared info of zero-copy buffers in kernel memory

This patch moves the skb_shared_info of zero-copy XSk multi-buffer packets
out of the UMEM chunk tailroom and into the buffer pool. The pool copy is
reached through a new xdp_rxq_info.ext_sinfo pointer and a new
XDP_FLAGS_SINFO_EXT buffer flag. Zero-copy buffers no longer reserve
tailroom, so the device can fill the whole chunk and bpf_xdp_adjust_tail()
can grow a packet up to the chunk end.

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 07231adfb5f82..68dc9caacfa93 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h

[ ... ]

> @@ -178,17 +189,26 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
>
>  /* Reserve memory area at end-of data area.
>   *
> - * This macro reserves tailroom in the XDP buffer by limiting the
> - * XDP/BPF data access to data_hard_end.  Notice same area (and size)
> - * is used for XDP_PASS, when constructing the SKB via build_skb().
> + * This reserves tailroom in the XDP buffer by limiting the XDP/BPF data
> + * access to data_hard_end.  Notice same area (and size) is used for
> + * XDP_PASS, when constructing the SKB via build_skb(). Buffers with
> + * %XDP_FLAGS_SINFO_EXT keep the shared info elsewhere and reserve none.
>   */
> -#define xdp_data_hard_end(xdp)				\
> -	((xdp)->data_hard_start + (xdp)->frame_sz -	\
> -	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
> +static __always_inline void *xdp_data_hard_end(const struct xdp_buff *xdp)
> +{
> +	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +
> +	if (xdp->flags & XDP_FLAGS_SINFO_EXT)
> +		tailroom = 0;
> +	return xdp->data_hard_start + xdp->frame_sz - tailroom;
> +}

[Severity: Low]
This isn't a bug, but bpf_xdp_adjust_tail() in net/core/filter.c still has
this comment above its linear grow check:

	/* Notice that xdp_data_hard_end have reserved some tailroom */
	if (unlikely(data_end > data_hard_end))
		return -EINVAL;

xp_set_rxq_info() now sets XDP_FLAGS_SINFO_EXT on every zero-copy XSk
buffer. For those buffers xdp_data_hard_end() reserves no tailroom, so
data_end can reach the end of the UMEM chunk.

Should that comment be updated as well?

[ ... ]

> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index a40ad3f90f13c..fc22314e72c4e 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h

[ ... ]

> @@ -56,20 +51,13 @@ static inline u32 __xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
>  	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
>  }
>
> +/* Device RX buffers typically come in 128-byte units. The shared info
> + * of zero-copy buffers lives in the pool, see xp_set_rxq_info(), so the
> + * device may write up to the end of the chunk.
> + */
>  static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
>  {
> -	u32 frame_size =  __xsk_pool_get_rx_frame_size(pool);
> -	struct xdp_umem *umem = pool->umem;
> -	bool mbuf;
> -
> -	/* Reserve tailroom only for zero-copy pools that opted into
> -	 * multi-buffer. The reserved area is used for skb_shared_info,
> -	 * matching the XDP core's xdp_data_hard_end() layout.
> -	 */
> -	mbuf = pool->dev && (umem->flags & XDP_UMEM_SG_FLAG);
> -	frame_size -= xsk_pool_get_tailroom(mbuf);
> -
> -	return ALIGN_DOWN(frame_size, 128);
> +	return ALIGN_DOWN(__xsk_pool_get_rx_frame_size(pool), 128);
>  }

[Severity: Critical]
Can this overflow the skb_shared_info of the skb built by
xdp_build_skb_from_zc() in net/core/xdp.c?

Multi-buffer pools no longer have the tailroom subtracted, so the device
fills the head buffer up to data_hard_start + frame_sz, which is the end
of the chunk. xdp_build_skb_from_zc() still sizes the new skb head from
frame_sz:

net/core/xdp.c:xdp_build_skb_from_zc() {
	u32 len = xdp->data_end - xdp->data_meta;
	u32 truesize = xdp->frame_sz;
	...
	data = page_pool_dev_alloc_va(pp, &truesize);
	...
	skb = napi_build_skb(data, truesize);
	...
	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);

	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
	...
}

napi_build_skb() puts skb_shared_info at data + truesize -
SKB_DATA_ALIGN(sizeof(struct skb_shared_info)). __skb_put() does not check
tail against end.

Take a 4K chunk with headroom 0, XDP_USE_SG and a jumbo frame.
rx_frame_size is now ALIGN_DOWN(4096 - 256, 128) = 3840, so the head
buffer holds 3840 bytes and data_end - data_hard_start is 4096.
napi_build_skb(data, 4096) leaves 3776 usable bytes.

The copy then writes packet bytes from the wire over all 320 bytes of the
skb_shared_info that was just initialized. That includes flags,
frag_list, dataref and destructor_arg. With 2K chunks the copy reaches
2048 bytes into a 1728 byte area.

Before this patch an SG pool got rx_frame_size = 3456, so
data_end - data_hard_start was at most 3712, which fit below 3776.

Single-buffer pools hit the same overflow when an XDP program grows the
tail to the chunk end with bpf_xdp_adjust_tail(). xdp_data_hard_end() now
returns the chunk end for these buffers.

This looks reachable from the XDP_PASS paths in ice_clean_rx_irq_zc(),
__libeth_xsk_run_pass() (idpf) and gve DQO. The commit message says the
device may now write the whole chunk, but this consumer is left
unchanged.

Should truesize be sized from (data_end - data_hard_start) +
SKB_DATA_ALIGN(sizeof(struct skb_shared_info)), or should the copy be
bounded some other way?

[Severity: High]
A related question: can the LARGEST_ALIGN(len) copy in
xdp_build_skb_from_zc() now read past the end of the UMEM chunk?

	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));

LARGEST_ALIGN() rounds len up to __LARGEST_ALIGN, which is 16 on x86_64
and arm64. Before this patch every zero-copy frame kept at least
SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) bytes of chunk after
data_end, so the rounded read stayed inside the chunk.

data_end can now equal the chunk end in two ways:

- a full SG head buffer, when the headroom is a multiple of 128
- bpf_xdp_adjust_tail() growing the packet to xdp_data_hard_end()

If len is not a multiple of 16, the copy reads up to 15 bytes past the
chunk. That happens with 4 or 8 bytes of metadata from
bpf_xdp_adjust_meta(), or with a UMEM headroom such as 4, which
xdp_umem_reg() accepts.

For the last chunk of an aligned UMEM whose size is a multiple of
PAGE_SIZE, the chunk end is the end of the vmap() area created by
xdp_umem_addr_map(). Could this read fault on the guard page in NAPI
context?

The rounded write also runs the same number of bytes past the new skb's
tail, and past truesize. This adds to the skb_shared_info overwrite
described above.

[ ... ]

> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index 02e89350faf9a..f43e618ae707c 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -59,6 +59,8 @@ struct xsk_buff_pool {
>  	spinlock_t rx_lock;
>  	struct list_head free_list;
>  	struct list_head xskb_list;
> +	/* Fragment list of the packet being built, out of userspace reach */
> +	struct skb_shared_info sinfo;
>  	u32 heads_cnt;
>  	u16 queue_id;
>

[Severity: Low]
This isn't a bug, but struct xsk_buff_pool documents this section as
"Members only used in the control path first.". The data path members
start at the cacheline aligned fq.

sinfo is about 320 bytes. It is read and written for every multi-buffer
zero-copy packet through rxq->ext_sinfo: in xsk_buff_add_frag(), the
bpf_xdp_* helpers, xsk_rcv_zc() and the driver XDP_TX paths.

Would it fit better with the data path members?

[ ... ]

> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 5ec092f7cb6f7..5536301702297 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -125,8 +125,14 @@ void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq)
>  {
>  	u32 i;
>
> -	for (i = 0; i < pool->heads_cnt; i++)
> +	/* Userspace may write the UMEM. Keep the shared info in the pool,
> +	 * and let the device write up to the end of each chunk.
> +	 */
> +	for (i = 0; i < pool->heads_cnt; i++) {
>  		pool->heads[i].xdp.rxq = rxq;
> +		pool->heads[i].xdp.flags |= XDP_FLAGS_SINFO_EXT;
> +	}
> +	rxq->ext_sinfo = &pool->sinfo;

[Severity: Medium]
Does the shared info flag really stay for virtio_net in zero-copy
mode?

xp_set_rxq_info() sets XDP_FLAGS_SINFO_EXT on the heads only once,
when the pool is bound to the rxq. After that, xp_alloc() and
xsk_buff_set_size() only mask xdp->flags, and xp_alloc_batch() does
not touch them. Once the flag is cleared on a head, nothing sets it
again.

buf_to_xdp() in drivers/net/virtio_net.c clears it for every buffer
after the first one of a mergeable packet:

	} else {
		xdp_prepare_buff(xdp, xdp->data_hard_start,
				 XDP_PACKET_HEADROOM - vi->hdr_len, len, 1);
		xdp->flags = 0;
	}

xsk_append_merge_buffer() then returns that buffer to the pool with
xsk_buff_free(). The same xdp_buff_xsk can later come back through
xsk_buff_alloc_batch() as the first buffer of a packet. Then
xsk_buff_set_size() keeps the cleared flag, and the buffer stays
without XDP_FLAGS_SINFO_EXT for the rest of the pool's lifetime.

For such a head, xdp_data_hard_end() subtracts
SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) again. The length check
in buf_to_xdp() still accepts frames up to
xsk_pool_get_rx_frame_size(), which no longer leaves that tailroom.

A full frame then ends past data_hard_end, and bpf_xdp_adjust_tail()
returns -EINVAL for any offset that leaves data_end there. With the
larger headroom that xdp_umem_reg() now accepts, data_hard_end can
even fall below xdp->data.

xdp_get_shared_info_from_buff() also points back into the
userspace-writable chunk tailroom. That area now holds packet data.
This is the situation the patch is meant to remove.

Any other zero-copy driver that assigns xdp->flags on a pool buffer
would hit the same problem.

Should xp_alloc() and xsk_buff_set_size() set XDP_FLAGS_SINFO_EXT
instead of only keeping it? xp_alloc_batch() would need the same
treatment, since virtio_net allocates through it. Alternatively,
should buf_to_xdp() clear only XDP_FLAGS_HAS_FRAGS?

[Severity: Medium]
Is there a window here where a head already has XDP_FLAGS_SINFO_EXT and
the new rxq, but rxq->ext_sinfo is still NULL?

xdp_rxq_info_init() in __xdp_rxq_info_reg() zeroed the new rxq.
ext_sinfo is stored only after the loop, with no barrier, and
xdp_get_shared_info_from_buff() returns it without a NULL check:

	if (xdp->flags & XDP_FLAGS_SINFO_EXT)
		return xdp->rxq->ext_sinfo;

mlx5e_safe_switch_params() opens the new channels while the old ones are
still active:

mlx5e_safe_switch_params()
  mlx5e_open_channels(priv, new_chs)
    ...
      mlx5e_alloc_rq()
        xsk_pool_set_rxq_info(rq->xsk_pool, &rq->xdp_rxq)

The loop covers one head per UMEM chunk, and the old NAPI keeps serving
the same pool while it runs. The old NAPI can then process a head whose
rxq already points at the new rxq.

An XDP program that reaches the shared info would then dereference NULL.
One example is bpf_xdp_pointer(), which reads sinfo->nr_frags when called
from bpf_dynptr_slice() with offset equal to the linear size and len 0.
I could not fully confirm that the verifier accepts a zero-size slice
there.

The plain read-modify-write of heads[i].xdp.flags can also race with the
datapath's own flag updates in xp_alloc() and xsk_buff_set_size(), and
with the setting and clearing of XDP_FLAGS_HAS_FRAGS. That could lose
XDP_FLAGS_HAS_FRAGS or bring it back.

The rxq pointer swap under a live datapath already existed. The NULL
ext_sinfo window is new with this patch.

Would storing rxq->ext_sinfo before publishing rxq on the heads, with
release/acquire or WRITE_ONCE() ordering, close this window? Requiring a
quiesced datapath here would also work.

>  }
>  EXPORT_SYMBOL(xp_set_rxq_info);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127142131.3527737-1-bjorn%40kernel.org
