Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34363E49FF
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843323; cv=none; b=g6SNoS8Emt1tzyKKKeOU+MZFhLao7j+vsUh0nwYuzY7yypeTzxJk/a/vtzZbRjqTwXHxniO37UhpiwpaoHgxLO+t3HtIMHlY1ijqILa/OXtjwy54m7cfAp947ZbrEEqZBkjH5yqYCPsEzhvwtHnFhAVcBR1FdoKee3EPFaypfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843323; c=relaxed/simple;
	bh=KLLHBkwffB4FH6eWApevsbF2omxVdj0foutoIwY7pjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK9BsecMNNMLv589ki9sPZiBNDpyUgy1fwnIK4wtDF4yQ0ymdByViNgJf+Qcg9ipuQ4VLz4is37uctbnU/rbBUb/1w/YDjjiXKUl+YdKJlbkA9vw/DHjLnH/uudTzTsl02ysnU8vfFfx/5xrEndwKGwWxKc8KiKw413a41iU98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwcOyC4r; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwcOyC4r"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1433e7b057fso1632911c88.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791843321; x=1792448121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TtcIhJO+YxSdNgQJHhkhykF/808DucRHJuxBcDn/sJE=;
        b=FwcOyC4r2zM0nTFm3RZzLw6bN0drRBs5TEhVwL7KMI1JIgPctwRk6gVBsDtdy5ZsTb
         pzoNvRrgfZjDG0f7/yfN9C6WUIEix+adUvOdSndCWeF7iHlu/cuDUPhPLRbu+ITQlu5+
         O3jfDmg0wSWxH59br88U/3KBlOuDpVgEcZDxgsoHXVVRCRWuPXhACxnyE0OTiaiM1q+n
         4bF0QJ+mju3f+N5rCJHol9osnXa88FL5TOFiNebtRE3de3DHKnuq4cm/fwPn9+BwkpCe
         81FEanoKGfP5vMD9ua+fYJGzfojEeKtU5jDqeCN/uiYI7eFLXeTdv0Nz+G37bVHDwnbb
         pLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791843321; x=1792448121;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TtcIhJO+YxSdNgQJHhkhykF/808DucRHJuxBcDn/sJE=;
        b=XjLtFET1UC6F6UIpBLgZ0j8ULsIIc+/ZS57VN8tjBkPNVV3qZ8PB8Kot/Fx6s0nl7i
         tY/D+xopll1X47BX0mtkRVi5bJWMUIScEwlm7ftK01+OvLpthI5+uGpct4MPhcDNKkVb
         xtp2Nayx0cgtpp2ck4Gvz3sKVG/f/64bGn2299j2Hzi+sFzkWcxHplZbnG8WLzEzVJth
         gIMxAaQnV0ZFeSQ4LcJDlInzIYQ93H7zW+/TI4VDWmoDSWDNMfPfTH+Y4PIE/+lXVRZS
         BRNbmLjXW6o29qRfaCatpCvX1bXDU/UknFGlfTRDERPgSCHR/2hBQts4hC2s0Uw3SuZp
         GudA==
X-Forwarded-Encrypted: i=1; AKwUvBz44n3a4izSHmplEgz6OkZ4Y3H2FggfJ+0onkYFbk+gNRXgIcnmr96bRtSro1FTnC997+8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoWabEFmlXy6A46sMCVNqHXjPsSmWFjSchzS1dFfi41QJ+G+UG
	LPvvRbM68jdqiIr5LjSEnfG4zBP5zcvKMwDGabM4ovi7BOSYhy2eW0JX
X-Gm-Gg: AYBFou3QEn/MMiVft9dLEzD4WnxSvARuMW1ZfxuDCPsVnlQgxwUDXRIlsMtvsNJHPKW
	ijp8qA0qoiRS7zRZDBNFvC6NAM/8DyHmCec0IReRXXrQiTuzQJ18TTPLhLO35HA/Ira/+GEBneZ
	XDiPvpZmaMRsCqgIoW37B88WtD8gcdLxVFCtZFFON24m4b2XVgCwEC436V3qpgDjzzWy3Pv3Xu9
	QBN9WIF/zsZgUHhADGRuV8Xc/yj8Y0UGR88qDl3suCz7pO9pDiP/qFZAUKAB4FwWbHiY24z99Ag
	VxP8f9vry3mZHREmf+xxUVrszIhsf+CYmA3J6ZlqEuTsXJi29bCAOO+adX3HZU3irFC3N8vQQnR
	Krqpw9qmL3Y63tBl2fFPlMdafNbJcq9G/YgFa+QRK1XQFuIjgFszs0Lf10n7BDLtFDuLrunG0RG
	/VhmcHzh0YDcU+AKYDgFK7zuMQsqLmfubAdQXZ7F9BuJliZnwDei9vI1BwJe0aeRm3cZJelafHV
	TbDHJMzzPL52PpVLNk=
X-Received: by 2002:a05:701b:21db:b0:166:29a2:f83f with SMTP id a92af1059eb24-16a56ab04e9mr15192436c88.5.1791843320773;
        Mon, 12 Oct 2026 15:15:20 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a4429603sm31302727c88.17.2026.10.12.15.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:15:19 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:15:15 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/5] vsock/virtio: amortize RX socket locking
 for stream packets
Message-ID: <as1b8+vIy8K8J5cN@devvm29614.prn0.facebook.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010142247.99223-3-physicalmtea@gmail.com>

On Sat, Oct 10, 2026 at 10:22:44PM +0800, Jia Jia wrote:
> The virtio-vsock RX worker currently acquires and releases the socket lock
> for every received packet. Keep the lock held while processing a bounded
> run of packets that belongs to the same socket.
> 
> Only ordinary RW packets for an established STREAM socket whose transport
> and protocol remain unchanged are eligible. Control packets, SEQPACKET
> traffic, state or transport changes, malformed packets, and sockets whose
> protocol has been replaced end the active batch and retain their existing
> handling.
> 
> Serialize the initial eligibility check with sk_callback_lock because
> sockmap removal restores the protocol without taking the socket lock.
> 
> Limit each batch to 64 packets or 64KB of payload, bounding the work under
> one socket lock. Keep the lookup reference until the batch finishes.
> 
> Keep a batch only while another skb metadata charge fits in the receive
> buffer. Share this predicate with virtio_transport_inc_rx_pkt(). When an
> enqueued skb consumes the final metadata slot, finish the batch and release
> the socket lock before processing another packet, restoring the reader's
> scheduling opportunity from the per-packet path.
> 
> The virtqueue callback remains a queue_work() callback. Batching runs only
> in the process-context RX worker.
> 
> Introduce virtio_transport_rx_batch_finish() to tear down the batch and
> release the socket lock and lookup reference.
> 
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  include/linux/virtio_vsock.h            |  11 ++
>  net/vmw_vsock/virtio_transport.c        |  29 ++++-
>  net/vmw_vsock/virtio_transport_common.c | 147 +++++++++++++++++++++++-
>  3 files changed, 183 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index f91704731057..26dde6909c4e 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -282,6 +282,17 @@ void virtio_transport_destruct(struct vsock_sock *vsk);
>  
>  void virtio_transport_recv_pkt(struct virtio_transport *t,
>  			       struct sk_buff *skb, struct net *net);
> +
> +struct virtio_transport_rx_batch {
> +	struct sock *sk;
> +	unsigned int pkts;
> +	size_t bytes;
> +};
> +
> +void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> +				     struct sk_buff *skb, struct net *net,
> +				     struct virtio_transport_rx_batch *batch);
> +void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch);
>  void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
>  u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
>  void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 4f9aa9c4c3aa..ef076732158d 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -629,8 +629,16 @@ virtio_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
>  	return seqpacket_allow;
>  }
>  
> +/*
> + * Keep a bounded run of packets for one socket under a single socket lock.
> + * Limit packet count and payload size to bound the work done while locked.
> + */
> +#define VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS	64
> +#define VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES	(64 * 1024)

Why both? Seems like MAX_PKTS would sufficiently bound the lock hold
time.

> +
>  static void virtio_transport_rx_work(struct work_struct *work)
>  {
> +	struct virtio_transport_rx_batch batch = {};
>  	struct virtio_vsock *vsock =
>  		container_of(work, struct virtio_vsock, rx_work);
>  	struct virtqueue *vq;
> @@ -666,6 +674,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  			/* Drop short/long packets */
>  			if (unlikely(len < sizeof(*hdr) ||
>  				     len > virtio_vsock_skb_len(skb))) {
> +				virtio_transport_rx_batch_finish(&batch);
>  				kfree_skb(skb);
>  				continue;
>  			}
> @@ -673,6 +682,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  			hdr = virtio_vsock_hdr(skb);
>  			payload_len = le32_to_cpu(hdr->len);
>  			if (unlikely(payload_len > len - sizeof(*hdr))) {
> +				virtio_transport_rx_batch_finish(&batch);
>  				kfree_skb(skb);
>  				continue;
>  			}
> @@ -680,16 +690,33 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  			if (payload_len)
>  				virtio_vsock_skb_put(skb, payload_len);
>  
> +			if (batch.sk &&
> +			    payload_len > VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES -
> +					  batch.bytes) {
> +				virtio_transport_rx_batch_finish(&batch);
> +			}
> +
>  			virtio_transport_deliver_tap_pkt(skb);
>  
>  			/* Force virtio-transport into global mode since it
>  			 * does not yet support local-mode namespacing.
>  			 */
> -			virtio_transport_recv_pkt(&virtio_transport, skb, NULL);
> +			virtio_transport_recv_pkt_batch(&virtio_transport, skb, NULL,
> +							&batch);
> +
> +			if (batch.sk) {
> +				batch.pkts++;
> +				batch.bytes += payload_len;
> +				if (batch.pkts >= VIRTIO_TRANSPORT_RX_BATCH_MAX_PKTS ||
> +				    batch.bytes >= VIRTIO_TRANSPORT_RX_BATCH_MAX_BYTES) {
> +					virtio_transport_rx_batch_finish(&batch);

I'm not fundamentally opposed to the batch struct, but I wonder if its
needed? If we can get rid of BATCH_MAX_BYTES, then we only need to do
pkts++ in a local var, and can pass an &sk ptr-ptr to
virtio_transport_recv_pkt_batch()?

Best,
Bobby

> +				}
> +			}
>  		}
>  	} while (!virtqueue_enable_cb(vq));
>  
>  out:
> +	virtio_transport_rx_batch_finish(&batch);
>  	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>  		virtio_vsock_rx_fill(vsock);
>  out_nofill:
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index e3e75e59896f..a73e37b3fa62 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -576,10 +576,16 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
>  	skb_queue_splice(&new_queue, &vvs->rx_queue);
>  }
>  
> +static bool
> +virtio_transport_rx_skb_has_headroom(struct virtio_vsock_sock *vvs)
> +{
> +	return (u64)(skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0) <=
> +		vvs->buf_alloc;
> +}
> +
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>  
>  	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
>  	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> @@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  	 * queue growth.
>  	 */
>  	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
> -	    skb_overhead > vvs->buf_alloc)
> +	    !virtio_transport_rx_skb_has_headroom(vvs))
>  		return false;
>  
>  	vvs->rx_bytes += len;
> @@ -1834,10 +1840,28 @@ struct virtio_transport_rx_pkt_ctx {
>  	struct net *net;
>  	const struct sockaddr_vm *src;
>  	const struct sockaddr_vm *dst;
> +	bool *batchable;
>  };
>  
> +static bool
> +virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
> +				    struct sock *sk)
> +{
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +	struct virtio_vsock_sock *vvs = vsk->trans;
> +
> +	return sk->sk_state == TCP_ESTABLISHED &&
> +	       sk->sk_type == SOCK_STREAM &&
> +	       READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
> +	       !sock_flag(sk, SOCK_DONE) &&
> +	       vsk->transport == &t->transport &&
> +	       vvs && virtio_transport_rx_skb_has_headroom(vvs);
> +}
> +
>  /*
> - * The caller holds sk's socket lock and must free skb if this returns true.
> + * The caller holds sk's socket lock.  Set @batchable if the socket can remain
> + * locked for another ordinary STREAM/RW packet.  Return true if the caller
> + * must free @skb.
>   */
>  static bool
>  virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> @@ -1850,6 +1874,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>  	struct net *net = ctx->net;
>  	bool space_available;
>  
> +	if (ctx->batchable)
> +		*ctx->batchable = false;
> +
>  	/* Check after acquiring the socket lock. Listener sockets accept packets
>  	 * from any source and are not assigned to a transport.
>  	 */
> @@ -1891,6 +1918,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>  		break;
>  	}
>  
> +	if (ctx->batchable)
> +		*ctx->batchable = virtio_transport_recv_pkt_batchable(t, sk);
> +
>  	return false;
>  }
>  
> @@ -1941,6 +1971,117 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>  
> +/*
> + * Finish the RX batch.
> + * For a non-empty batch, the caller must hold the socket lock acquired with
> + * lock_sock(). This function releases the lock and the batch's lookup
> + * reference.
> + * An empty batch is a no-op.
> + */
> +void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> +{
> +	struct sock *sk = batch->sk;
> +
> +	batch->sk = NULL;
> +	batch->pkts = 0;
> +	batch->bytes = 0;
> +
> +	if (!sk)
> +		return;
> +
> +	release_sock(sk);
> +	sock_put(sk);
> +}
> +EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
> +
> +void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> +				     struct sk_buff *skb, struct net *net,
> +				     struct virtio_transport_rx_batch *batch)
> +{
> +	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> +	struct virtio_transport_rx_pkt_ctx ctx;
> +	struct sockaddr_vm src, dst;
> +	bool batchable, start_batch;
> +	struct sock *sk;
> +	bool free_pkt;
> +
> +	/* Only STREAM/RW packets can share a socket lock. */
> +	if (le16_to_cpu(hdr->type) != VIRTIO_VSOCK_TYPE_STREAM ||
> +	    le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_RW) {
> +		virtio_transport_rx_batch_finish(batch);
> +		virtio_transport_recv_pkt(t, skb, net);
> +		return;
> +	}
> +
> +	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> +	virtio_transport_trace_recv_pkt(skb, &src, &dst);
> +
> +	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> +	if (!sk) {
> +		virtio_transport_rx_batch_finish(batch);
> +		(void)virtio_transport_reset_no_sock(t, skb, net);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	if (!skb_set_owner_sk_safe(skb, sk)) {
> +		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> +		virtio_transport_rx_batch_finish(batch);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	if (batch->sk && batch->sk != sk) {
> +		/* Never acquire a second socket lock. */
> +		virtio_transport_rx_batch_finish(batch);
> +	}
> +
> +	if (batch->sk == sk) {
> +		/* Keep the batch reference; drop this packet's lookup reference. */
> +		sock_put(sk);
> +		ctx = (struct virtio_transport_rx_pkt_ctx) {
> +			.net = net,
> +			.src = &src,
> +			.dst = &dst,
> +			.batchable = &batchable,
> +		};
> +		free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> +		if (!batchable)
> +			virtio_transport_rx_batch_finish(batch);
> +		if (free_pkt)
> +			kfree_skb(skb);
> +		return;
> +	}
> +
> +	lock_sock(sk);
> +	/*
> +	 * Sockmap removal restores the native protocol under sk_callback_lock.
> +	 * Serialize this initial eligibility check with that update.
> +	 */
> +	read_lock_bh(&sk->sk_callback_lock);
> +	start_batch = virtio_transport_recv_pkt_batchable(t, sk);
> +	read_unlock_bh(&sk->sk_callback_lock);
> +
> +	ctx = (struct virtio_transport_rx_pkt_ctx) {
> +		.net = net,
> +		.src = &src,
> +		.dst = &dst,
> +		.batchable = start_batch ? &batchable : NULL,
> +	};
> +	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> +	if (start_batch && batchable) {
> +		/* Keep the lookup reference until the batch is released. */
> +		batch->sk = sk;
> +		return;
> +	}
> +
> +	release_sock(sk);
> +	sock_put(sk);
> +	if (free_pkt)
> +		kfree_skb(skb);
> +}
> +EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt_batch);
> +
>  /* Remove skbs found in a queue that have a vsk that matches.
>   *
>   * Each skb is freed.
> -- 
> 2.34.1
