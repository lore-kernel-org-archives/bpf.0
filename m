Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3EB4F85B6
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840867; cv=none; b=a7pgXVx42tNV2Be16Ig5jJh/Mkq2GzeDiNST7Q5beM0ppEcy20QeLdAYPGKo3s1PsPkqs+8RlqV3mf3hK5FsWiELPlES6nt7iWlf+Zsb8nlE6zbKgmBmSwRXfM2nN6DrHCG50i9ZycBAvtr5xhPBZMXDUoqRKLyiZzpzjqaHgJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840867; c=relaxed/simple;
	bh=Hc1ijqb78M+KCiboOG1eU95mN0RQFKIJR2c7e4qGr2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL1Yea9iO9lIQG6jgQuLqQvATUzKxkVAtmhGVlmMeLk3j0N3SUKVa8/XzqLnCxPDr33hf/wsFjziNdbKk5RGrkVg2dy9xCXzt7aR38Xe/BfqGubu44euyx5HG05PpH8CGpRtgZvnAg747kp3J9OYeT+ZFb/pqWRjia3fd+/+PTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSlGCtoJ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSlGCtoJ"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8249ca723bcso1345579a34.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791840863; x=1792445663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wtcrbd6Cgz3Ugy3PXt8EJcehRCAPru4qEFOiOsw7Yk8=;
        b=CSlGCtoJY274zs2yLfnnW/EvvrLSzrH1eHdv3PUmD1wSlMEDqWXKa43fEGcacZnapO
         CTCfBp0oAKfuuA73J86lYpgpMARKxT60b2SOobhTHUaPrQyGOw5bW8J3sPfLrX7T3enk
         2LTcrpUNAjk+Oh/kpw0LUqe/FfTNbBZGperGCp1kod30d9E+y9lX4ZSFa8TRpHMBCdaU
         i+SlborerQNhyVrpx4/lUjtKwDYNyoDAUU6WJY4wZPTdE0BOhp7MlvQ5OKCYdVGG+nlE
         cKzMpXw1JMcgMN8zRtSLWQHglgUj4PuBbhdd/a5MKRaBLPE7iUZHY7oDpunzoFew+YoO
         8lYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791840863; x=1792445663;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wtcrbd6Cgz3Ugy3PXt8EJcehRCAPru4qEFOiOsw7Yk8=;
        b=1hCRYrentcLmU/1F1CoL7l5kic1UuS8gds+9Jka0QfuPUho6+BVpO/O1bVScI+8LGv
         aSdrweebC4dZ4vElhrTlW/30lLxWQKUot4ugbFVJ4jBaRYkSb0r+WHqNT8GtHd5hkLTB
         6m9XpDx/dSsRwKErRIKIAJvSkCLzpwnDecburQbeICOScktDtBCKJAPChsyiCe1gZGqZ
         x1bOlbXRPnM6SHnUOk6+bJtJ1IgFM2TqgkFB6YgYltAquMCKUvq7FarpbTlckt+Oh5Ui
         Ac1HVlSmxAvTL8Pm9nzJ37b73Ag4jv6t2FulWJ1xC4sLtKCqTJ0vHS33TLTy3EUYT/er
         bISA==
X-Forwarded-Encrypted: i=1; AKwUvBwU/C4SBX0vUk+5IjDUjaXZ9zEVHPGNH3hfo9WiHTZ9iXLO8csYD/N2SaybSrw/WuaDz/A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnXB5mH+JegniqSceVnPgIA82n9lbMFZh8+IUP2XL5Jm21RNPk
	pj3YDZZgoA6I18XiwqSYjhq+Q/PtlhO/U+DpKqxqJ819EBdUuvDK63Rw
X-Gm-Gg: AYBFou3aW0We7p3/C28x7bbQ9dqjXIf18eQ+oTiqP5d449CVIB5sRaGwepMBsXSQqHo
	903pG034oRbXzJz8FlEHRkxPxQRF1wZ+y82RtC7EqP7jdshzPYeu2WKalSCWaJCi7QjgGsN+UKL
	yW0OzaWeX2GoOvl5OTAOO3OtchyAenOMg0UIQQo+fhysNEpwWELSnYj8mxMBkWtdJ+PwXaGwzBG
	cWtbtIAftTpeuVIRb89pyGXabE9VuaFBeO7RiFLgEZneT2WAS8UWze7fMWgtKWy+fpPrmSMRTPi
	YS2RFW/gUZr2UAEZcjbujBZUwrclpDjc2bowgyW1KXg9h9PO27eO0yEAGnEIaV0dUWwQnPj2R/7
	FHrw3i0O3yQWIpf01rVlPnv+fJ7gHg++LvZGZ/gdnIY+dYzS0kmtjdbsfOkojQn76GsJYZpwfZh
	k9F1qE17yN6+9Xb+yfnEiACQCx8Tqngt7MrtTs/ZXArOFd+B1O/Qgtr/cnieUXLp0JbwhKGkVSl
	XaJJW1ZNzHN6YJAg/og
X-Received: by 2002:a05:6830:4c0a:b0:80a:b8da:2792 with SMTP id 46e09a7af769-83094e783camr11556972a34.6.1791840863000;
        Mon, 12 Oct 2026 14:34:23 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm11078644a34.25.2026.10.12.14.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 14:34:21 -0700 (PDT)
Date: Mon, 12 Oct 2026 14:34:18 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com,
	jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
Message-ID: <as1SWsJw2dSrPYcL@devvm29614.prn0.facebook.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010142247.99223-2-physicalmtea@gmail.com>

On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> Split virtio_transport_recv_pkt() so socket lookup is separate from the
> receive state machine that runs under the socket lock.
> 
> Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> Pass the source and destination addresses used for lookup to the locked
> receive path so they are decoded only once.
> 
> Pass the network namespace and decoded address tuple through a packet
> context to the locked receive path.
> 
> Preserve source validation and failure handling. Keep the lookup reference
> separate from the skb owner reference so the locked receive path can manage
> the two lifetimes independently.
> 
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
>  1 file changed, 96 insertions(+), 43 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index f225f53..e3e75e5 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1774,81 +1774,97 @@ static bool virtio_transport_valid_type(u16 type)
>  	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
>  }
>  
> -/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> - * lock.
> - */
> -void virtio_transport_recv_pkt(struct virtio_transport *t,
> -			       struct sk_buff *skb, struct net *net)
> +static void
> +virtio_transport_recv_pkt_init_addrs(struct sk_buff *skb,
> +				     struct sockaddr_vm *src,
> +				     struct sockaddr_vm *dst)

I'd prefer these calls stay inline, there is nothing complex enough here
to justify abstracting IMHO.

Could we move things around so that we don't have the arbitrary move of
virtio_transport_recv_pkt()? It tends to create noise and makes it
harder to focus on the more important parts of the patch.

>  {
>  	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> -	struct sockaddr_vm src, dst;
> -	struct vsock_sock *vsk;
> -	struct sock *sk;
> -	bool space_available;
>  
> -	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> +	vsock_addr_init(src, le64_to_cpu(hdr->src_cid),
>  			le32_to_cpu(hdr->src_port));
> -	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> +	vsock_addr_init(dst, le64_to_cpu(hdr->dst_cid),
>  			le32_to_cpu(hdr->dst_port));
> +}
> +
> +static void
> +virtio_transport_trace_recv_pkt(struct sk_buff *skb,
> +				const struct sockaddr_vm *src,
> +				const struct sockaddr_vm *dst)
> +{
> +	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>  
> -	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> -					dst.svm_cid, dst.svm_port,
> +	trace_virtio_transport_recv_pkt(src->svm_cid, src->svm_port,
> +					dst->svm_cid, dst->svm_port,
>  					le32_to_cpu(hdr->len),
>  					le16_to_cpu(hdr->type),
>  					le16_to_cpu(hdr->op),
>  					le32_to_cpu(hdr->flags),
>  					le32_to_cpu(hdr->buf_alloc),
>  					le32_to_cpu(hdr->fwd_cnt));
> +}

Any chance we can get rid of this wrapper and just call
trace_virtio_transport_recv_pkt() directly? Even from multiple call
sites I don't think this is a big simplification win.

>  
> -	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
> -		(void)virtio_transport_reset_no_sock(t, skb, net);
> -		goto free_pkt;
> -	}
> +static struct sock *
> +virtio_transport_recv_pkt_find_socket(struct sk_buff *skb,
> +				      struct sockaddr_vm *src,
> +				      struct sockaddr_vm *dst,
> +				      struct net *net)
> +{
> +	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> +	struct sock *sk;
>  
> -	/* The socket must be in connected or bound table
> -	 * otherwise send reset back
> -	 */
> -	sk = vsock_find_connected_socket_net(&src, &dst, net);
> -	if (!sk) {
> -		sk = vsock_find_bound_socket_net(&dst, net);
> -		if (!sk) {
> -			(void)virtio_transport_reset_no_sock(t, skb, net);
> -			goto free_pkt;
> -		}
> -	}
> +	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type)))
> +		return NULL;
> +
> +	sk = vsock_find_connected_socket_net(src, dst, net);
> +	if (!sk)
> +		sk = vsock_find_bound_socket_net(dst, net);
> +	if (!sk)
> +		return NULL;
>  
>  	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
> -		(void)virtio_transport_reset_no_sock(t, skb, net);
>  		sock_put(sk);
> -		goto free_pkt;
> +		return NULL;
>  	}
>  
> -	if (!skb_set_owner_sk_safe(skb, sk)) {
> -		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> -		goto free_pkt;
> -	}
> +	return sk;
> +}

Similarly here, the unrelated functions blending makes for a harder
read. Maybe worth moving things around or trying a different diff
algorithm?

nit: maybe we could just call this virtio_transport_find_socket()? AFAIK
the tx side doesn't need a socket lookup since we already have the
socket there, so we can omit the disambiguation if it lends a nicer
name.

>  
> -	vsk = vsock_sk(sk);
> +struct virtio_transport_rx_pkt_ctx {
> +	struct net *net;
> +	const struct sockaddr_vm *src;
> +	const struct sockaddr_vm *dst;
> +};

Let's just pass these directly too...

>  
> -	lock_sock(sk);
> +/*
> + * The caller holds sk's socket lock and must free skb if this returns true.
> + */
> +static bool
> +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> +				 struct sk_buff *skb, struct sock *sk,
> +				 const struct virtio_transport_rx_pkt_ctx *ctx)
> +{
> +	const struct sockaddr_vm *src = ctx->src;
> +	const struct sockaddr_vm *dst = ctx->dst;
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +	struct net *net = ctx->net;
> +	bool space_available;
>  
> -	/* Check if sk has been closed or assigned to another transport before
> -	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	/* Check after acquiring the socket lock. Listener sockets accept packets
> +	 * from any source and are not assigned to a transport.

We can probably remove the first sentence since the function-level
comment already declares we are holding the socket lock.

Best,
Bobby

>  	 */
>  	if (sock_flag(sk, SOCK_DONE) ||
>  	    (sk->sk_state != TCP_LISTEN &&
> -	     !vsock_check_source(vsk, &t->transport, &src))) {
> +	     !vsock_check_source(vsk, &t->transport, src))) {
>  		(void)virtio_transport_reset_no_sock(t, skb, net);
> -		release_sock(sk);
> -		sock_put(sk);
> -		goto free_pkt;
> +		return true;
>  	}
>  
>  	space_available = virtio_transport_space_update(sk, skb);
>  
>  	/* Update CID in case it has changed after a transport reset event */
>  	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> -		vsk->local_addr.svm_cid = dst.svm_cid;
> +		vsk->local_addr.svm_cid = dst->svm_cid;
>  
>  	if (space_available)
>  		sk->sk_write_space(sk);
> @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  		break;
>  	}
>  
> +	return false;
> +}
> +
> +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> + * lock.
> + */
> +void virtio_transport_recv_pkt(struct virtio_transport *t,
> +			       struct sk_buff *skb, struct net *net)
> +{
> +	struct virtio_transport_rx_pkt_ctx ctx;
> +	struct sockaddr_vm src, dst;
> +	struct sock *sk;
> +	bool free_pkt;
> +
> +	virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> +	virtio_transport_trace_recv_pkt(skb, &src, &dst);
> +
> +	sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> +	if (!sk) {
> +		(void)virtio_transport_reset_no_sock(t, skb, net);
> +		goto free_pkt;
> +	}
> +
> +	if (!skb_set_owner_sk_safe(skb, sk)) {
> +		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> +		goto free_pkt;
> +	}
> +
> +	lock_sock(sk);
> +	ctx = (struct virtio_transport_rx_pkt_ctx) {
> +		.net = net,
> +		.src = &src,
> +		.dst = &dst,
> +	}
> +	free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
>  	release_sock(sk);
>  
>  	/* Release refcnt obtained when we fetched this socket out of the
>  	 * bound or connected list.
>  	 */
>  	sock_put(sk);
> +	if (free_pkt)
> +		kfree_skb(skb);
>  	return;
>  
>  free_pkt:
> -- 
> 2.34.1
> 
