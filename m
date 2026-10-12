Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A081D457E5E
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843473; cv=none; b=Mn8BjxGZZ47buXuNYYVe1ezeNEuclQ1ZTxNfpHtKaPWPbbUSnfug7enYzC/dcaC0DDvyKVSvkm8JiuSwUryIYRIXfPFcgwdggqbSYlMmE1NHHmgHcfvCpgqXAGu2pE/8EBq9lPBc2E9iMFlcaJsp87nMVdA/f31YFF4ks483iMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843473; c=relaxed/simple;
	bh=gtoYvpUKjEumvZ9NZ4lgt37kt3RngiiSW4yRL0iX9gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSGlEMat2DMRUgxH8pqBLWNa19NVIeSWCIELI1afegyfkbgsDl8BEwTe1dz8EuhBzCYbUENf6i7To5EZMRvUi2GEbAjJK4BYNJDXmfoogVdOJChn1rgpyt6xWg49b7MsW1JQwpX4VfFtkTJOaRwA3KlIFLf0HYA6N8/R7RiuK3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWCc2IaL; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWCc2IaL"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-49e09a20082so1278032fac.2
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791843470; x=1792448270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F68EtWrkn2Wfb2ayNm/k6SKK8v3U+BQEExnVnz6byuA=;
        b=bWCc2IaLK/o6qI6vwYEcjeSWIN/rJxd/dA8grzptulSuyQkLJPWLsEq2PVfJXYkzff
         4/WXVFnxjeAqHjMhBdISQmi/XpbC7vOX4VzgH+4u9+YCYXwRc04/MLsi+gBYyp47zQ9p
         8aSOH85jehAI4xJ794cE+yZdI73PzLMg8WYugz1QRb3sXzSmQ7o/3GNJuqF8qWmxggSH
         oGzI6aAkXxYliEdgDY4Ad4DlmjD1M0ZNQLTc0ARnaxxdTAEREMo3m1e0jITD8ZIkXGnd
         KeOLu53fZKqNbmQ8eVfzhDfvgLkRlky//SB8K7aMsfjEfu3Sd054dIjM4sJZ3mZ1tQGo
         iEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791843470; x=1792448270;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F68EtWrkn2Wfb2ayNm/k6SKK8v3U+BQEExnVnz6byuA=;
        b=o6dql32qcpLlis2c2KJIewZ6TlEHzvc6dVQ1GiAAZsg1Pc/1fPhEXDTLZDaQAAyyfc
         E5e0Bc1t/gowXm3RUUN69rOTjjfAuKIvP6qmjLLWecmRMNAWT29UIsSeGzklna7XeysN
         cRCcikYWDNzU03jyX7D0Lcz6s7/PTOAlcap6YckwAOQonZEuM6s+NsJHnDOpP95NFi0v
         F+eRKwQsIkeHbZe+oHmJVah4kpIS4jRpCetrAJpRJ+NbMZomsuECFR9IhCKGrWFTgHvm
         Y/2kNTutiOnZP8IQ3ZM2TVuVQ7N87dlm+g8DsidUoKcIyBtKyzWEHiq5JXHFeKbwuJdq
         n/LQ==
X-Forwarded-Encrypted: i=1; AKwUvBxsc8/gp9axqo/52Qy2+pWXTn19/CN3BBJQdbQVK7wEKIl+DZ6/6b6Qf4iJnbEZ13VZPfA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3c7jIPz3RI1b2cmnGvv2VduNrqv9xi/3ZacBUkOZEKG18Mead
	YfFJlW5lXn6HZcwXd4hK+KlsH7orkU3V5D29TBD0XjvQ01H81FSnrpsh
X-Gm-Gg: AYBFou3m0GlPBXo5HnUW805Y9MACsBWOn04gOYaZDAcx1dK0/X4SOn9KdktmP7IseH+
	/1JJZnP88b/WaweqhDGyKp9JbMb7Q4UxxPDLxFhV1QZx5Js+1GJ0vupXWSwFafmb6Ve4N7+Zidj
	IxhKFKHjAWyVaAcLEOSEUrtEX4NEFLmd5gjeNxkxKzTvHPZPu6aRz96k3FDETHpbln46T/EsS8X
	J7OniOxq8c9ms+xYfq0A7n+r3r9SNcUZ8a8p/Ijgi6AsrGrtC11NniiSfwfiStVU1tGGslg8k/m
	oVMUI3jPq2Evkpn89eleSt2xvHkRxEuF9nSwnZkJZVfWmdXCWPbqCMH/i78zjB7NTIzG4PRIrfv
	rV3hu+1m4dslQJnRhzvNWJzROHm0dgAop2gxNQztdylbkL+o4kIiVjz5JMxemr7v2ALXB08doPd
	MUqSs56lAEEwi7cAVN5IhHU1RxvwkHDtrgfDe7OYwKH91pkP/Mhtpr+8jQaLrstGnEkttnuyYP6
	8SmI2AfOFbe40rOejLA
X-Received: by 2002:a05:6870:c213:b0:448:a3d6:c2d2 with SMTP id 586e51a60fabf-4a2a8955927mr10013926fac.10.1791843470199;
        Mon, 12 Oct 2026 15:17:50 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a85edf81sm10977018fac.15.2026.10.12.15.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:17:48 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:17:45 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/5] vsock/virtio: reuse same-flow socket
 lookup in RX batches
Message-ID: <as1ciTHT2O40E/Uq@devvm29614.prn0.facebook.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-4-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010142247.99223-4-physicalmtea@gmail.com>

On Sat, Oct 10, 2026 at 10:22:45PM +0800, Jia Jia wrote:
> An RX lock batch still looks up the socket for every packet and takes a
> temporary lookup reference, even though the batch already holds a reference
> to the locked socket.
> 
> Record the network namespace and packet address tuple when a batch starts.
> Reuse the batch socket for later STREAM/RW packets with the same tuple, and
> release the batch before looking up a different flow.
> 
> The cached path still traces every packet, takes an skb owner reference,
> validates socket state, source and transport, updates credit, and runs the
> receive state machine. Only the socket table lookup and its temporary
> reference are skipped.
> 
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  include/linux/virtio_vsock.h            |  3 ++
>  net/vmw_vsock/virtio_transport_common.c | 58 +++++++++++++++----------
>  2 files changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index 26dde6909c4e..d6528681e052 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -287,6 +287,9 @@ struct virtio_transport_rx_batch {
>  	struct sock *sk;
>  	unsigned int pkts;
>  	size_t bytes;
> +	struct net *net;
> +	struct sockaddr_vm src;
> +	struct sockaddr_vm dst;
>  };
>  
>  void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index e67dfcaa279c..73e5c7dfe8b4 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1977,6 +1977,7 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
>  	batch->sk = NULL;
>  	batch->pkts = 0;
>  	batch->bytes = 0;
> +	batch->net = NULL;
>  
>  	if (!sk)
>  		return;
> @@ -2008,6 +2009,37 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>  	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
>  	virtio_transport_trace_recv_pkt(skb, &src, &dst);
>  
> +	if (batch->sk) {
> +		if (batch->net == net &&
> +		    vsock_addr_equals_addr(&batch->src, &src) &&
> +		    vsock_addr_equals_addr(&batch->dst, &dst) &&
> +		    virtio_transport_recv_pkt_batchable(t, batch->sk)) {
> +			sk = batch->sk;
> +			if (!skb_set_owner_sk_safe(skb, sk)) {
> +				WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> +				virtio_transport_rx_batch_finish(batch);
> +				kfree_skb(skb);
> +				return;
> +			}
> +
> +			ctx = (struct virtio_transport_rx_pkt_ctx) {
> +				.net = net,
> +				.src = &src,
> +				.dst = &dst,
> +				.batchable = &batchable,
> +			};
> +			free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> +
> +			if (!batchable)
> +				virtio_transport_rx_batch_finish(batch);
> +			if (free_pkt)
> +				kfree_skb(skb);
> +			return;
> +		}
> +
> +		virtio_transport_rx_batch_finish(batch);
> +	}
> +
>  	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
>  	if (!sk) {
>  		virtio_transport_rx_batch_finish(batch);
> @@ -2018,33 +2050,10 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>  
>  	if (!skb_set_owner_sk_safe(skb, sk)) {
>  		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> -		virtio_transport_rx_batch_finish(batch);
>  		kfree_skb(skb);
>  		return;
>  	}
>  
> -	if (batch->sk && batch->sk != sk) {
> -		/* Never acquire a second socket lock. */
> -		virtio_transport_rx_batch_finish(batch);
> -	}
> -
> -	if (batch->sk == sk) {
> -		/* Keep the batch reference; drop this packet's lookup reference. */
> -		sock_put(sk);
> -		ctx = (struct virtio_transport_rx_pkt_ctx) {
> -			.net = net,
> -			.src = &src,
> -			.dst = &dst,
> -			.batchable = &batchable,
> -		};
> -		free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> -		if (!batchable)
> -			virtio_transport_rx_batch_finish(batch);
> -		if (free_pkt)
> -			kfree_skb(skb);
> -		return;
> -	}
> -

Not sure I love adding code and then removing it in the same series.
Seems like these are asking to be squashed?

>  	lock_sock(sk);
>  	/*
>  	 * Sockmap removal restores the native protocol under sk_callback_lock.
> @@ -2063,6 +2072,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>  	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
>  	if (start_batch && batchable) {
>  		/* Keep the lookup reference until the batch is released. */
> +		batch->net = net;
> +		batch->src = src;
> +		batch->dst = dst;

Similar to my comment in the other patch, seems these are all in sk
already?

Best,
Bobby
