Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C715221C0
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911814; cv=none; b=WQKB0Z7tD/vmwUdQw90Fzkws5d5KF0JS5cq1PAelUxk4iusXk8b1O+Fyjq2dwYJFp9og41Imm2GxHjUA+DJ3HZ5Afi2AkMiNPLY5Jq+2xJmbKjSwwC6rdqxqhsxNq+mK4Fa+6nBMclE8h6a6K/MrNzHD8CWCSUCwO72QIQ83xzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911814; c=relaxed/simple;
	bh=E0y7u+KR3xF/a4fcPKHidebxgCLhqgP2K/Rv6TPbOiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjpIDPKLQ4mraGpV6aIftJhN9OAW50MJZ2zpUg5JXv8NlkfkvDFiVezqpE129fxRVAy8McmyH5NHBmbDZmY33wY+BEehgZCFCIqn80Z+V4zU9IgcQMGdfSTDWq60i8vet+T27cJ71Eo0lhoTjHDQn38TevBzVQlyOQFl1Jnip9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OngxHnvA; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OngxHnvA"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8249c775215so1796395a34.3
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791911808; x=1792516608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rh8zSXbKHc5uCKze2IT1wznFx+pVYTz0bfvRk4C07S4=;
        b=OngxHnvAA6saR3OBCtEOXWu6BOGRi+0KC/UsGTlv/UJBcnpyFztf00L4tqRe19juF4
         0NP69aClxJpJWCL6ILli8w+pOqUiUsmk6Q1tSLrbqqHwoxzxu+W9WLegjMmVhm08gXSp
         7L2iGOIG5qv7GQKjisQZ6xKVY5roN47WTEPrxIXGOf2uelKvAk6dTwEjYgU/prxMy5QQ
         mDLMTDyB8d1b5a/rDhd3zoWH73f5jtTvQq10X9TXE5zdy8ayYQMDxEB41YgyZlQkDzDu
         IhI2wBzMYATeYlmeviHi/U5CFKW85GFyhZp5HuLynuitHhWxhOogmdr2izp2Aae8SPT1
         VrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791911808; x=1792516608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rh8zSXbKHc5uCKze2IT1wznFx+pVYTz0bfvRk4C07S4=;
        b=JvVafI6CicYDDHKyJdz/90sX8XbxcYsmEIBx6MeHXzBTaSVifHNa/MPyXZglsIrdk9
         Rz4/A7PZxf0JhNCMk7IwgytJvnpS4mj8MWZejNF7u5u6JcGvFberSdCgy2MQBsdHI001
         AW+vC3IwBGGkspSUSpihidN6kX1mrPyUQ86v0UEDXODUVRVaPyJH0K0O/JWXdZKY4PQ0
         XDtet5iIy/3e4XC2Gn6zNOF8Ty8LF/xjWcTqDd8CJDZdUt9Ii6P6J8J9NHkrmHCh5AA2
         9g+DepRGzeW+LmZwLK7GnJaQ1k2PX2bhGYFFL1IFtFQHcLMHUlAMxC21M5GsnTqV4pQR
         w5LQ==
X-Forwarded-Encrypted: i=1; AKwUvByf1z6N3PExA5SKeFMROEMqpo0rPjWhyOue2iX9GNLuJdc6yR6WiFfQYlhkq4tmMJc0Qsc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcNztv0fv+6ZbqzL/Qp7wxOBkbQTapRQURNzRqzs4ZTLTmqIZS
	TCCSlTxr4OPAWnDP5dJr5SI3VJvEqR7zdTNKeYVC8IytBMeIh4H1HsLr
X-Gm-Gg: AYBFou2uj0ABZTnZBsSu3nX9AFgqFopVabxyspbq9xy7wD0/49e4OH7KaHloqPcR6ek
	RhhgArHQ15aCtgBu/eqY40j9wIdl9xwl6tYOLzTXuUjAserhD4esi2sLJgsJLO7hw17nO5tgJQ/
	I9jfdRwMqnK9cMFBZQohTzI0l5LHFn3qJhSv2Iaw3vQohSdGt1+9JJGm4XkUC8xlWbM4CeL5mb8
	USPl+Wmew/+VNRkA5lWofIs0LltjZi4Mp1ec9VGjnr7I+1dY/+VakddYiazrhOFRDM7TRqpu4/0
	R3fCC5qUdCpqiAu0mdp/4FumYodEBFIPUCS4RXc1eakEf4o7XJbhy0y+BtIwJ+ZRqrYFJCWU9Ft
	pFyq9qkWS8sZLjV+q2dZSGkPq1pUE0dILOKbRAey3uItXl+TiAUwEoxrA8Gwxsh9nR3qFDl7Ej8
	BT98zHCCiTuSlC99dRlJePgVv+l4SRja7+wI9FuRR/uqL8hcTindPRzC48lKXwshQ5emM=
X-Received: by 2002:a05:6808:13c3:b0:4d6:93e2:5bc4 with SMTP id 5614622812f47-50c59f38b43mr14625456b6e.64.1791911808288;
        Tue, 13 Oct 2026 10:16:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1c0248fbsm15142233b6e.15.2026.10.13.10.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:16:46 -0700 (PDT)
Date: Tue, 13 Oct 2026 10:16:44 -0700
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
Message-ID: <as5nfI0qfqD64dc1@devvm29614.prn0.facebook.com>
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com>
 <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
 <CAJwVaMJL4FFYLq523VY014oa4u7RWD0WUY0+seP1xh3GY5peiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJwVaMJL4FFYLq523VY014oa4u7RWD0WUY0+seP1xh3GY5peiQ@mail.gmail.com>

On Tue, Oct 13, 2026 at 11:26:38AM +0800, Jia Jia wrote:
> >
> > On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> > > Split virtio_transport_recv_pkt() so socket lookup is separate from the
> > > receive state machine that runs under the socket lock.
> > >
> > > Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> > > Pass the source and destination addresses used for lookup to the locked
> > > receive path so they are decoded only once.
> > >
> > > Pass the network namespace and decoded address tuple through a packet
> > > context to the locked receive path.
> > >
> > > Preserve source validation and failure handling. Keep the lookup reference
> > > separate from the skb owner reference so the locked receive path can manage
> > > the two lifetimes independently.
> > >
> > > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
> > >  1 file changed, 96 insertions(+), 43 deletions(-)
> > >
> >
> > [...]
> >
> > > +/*
> > > + * The caller holds sk's socket lock and must free skb if this returns true.
> > > + */
> > > +static bool
> > > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > > +                              struct sk_buff *skb, struct sock *sk,
> > > +                              const struct virtio_transport_rx_pkt_ctx *ctx)
> > > +{
> > > +     const struct sockaddr_vm *src = ctx->src;
> > > +     const struct sockaddr_vm *dst = ctx->dst;
> > > +     struct vsock_sock *vsk = vsock_sk(sk);
> > > +     struct net *net = ctx->net;
> > > +     bool space_available;
> > >
> > > -     /* Check if sk has been closed or assigned to another transport before
> > > -      * lock_sock (note: listener sockets are not assigned to any transport)
> > > +     /* Check after acquiring the socket lock. Listener sockets accept packets
> > > +      * from any source and are not assigned to a transport.
> > >        */
> > >       if (sock_flag(sk, SOCK_DONE) ||
> > >           (sk->sk_state != TCP_LISTEN &&
> > > -          !vsock_check_source(vsk, &t->transport, &src))) {
> > > +          !vsock_check_source(vsk, &t->transport, src))) {
> > >               (void)virtio_transport_reset_no_sock(t, skb, net);
> > > -             release_sock(sk);
> > > -             sock_put(sk);
> > > -             goto free_pkt;
> > > +             return true;
> > >       }
> > >
> > >       space_available = virtio_transport_space_update(sk, skb);
> > >
> > >       /* Update CID in case it has changed after a transport reset event */
> > >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
> > > -             vsk->local_addr.svm_cid = dst.svm_cid;
> > > +             vsk->local_addr.svm_cid = dst->svm_cid;
> > >
> > >       if (space_available)
> > >               sk->sk_write_space(sk);
> > > @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > >               break;
> > >       }
> > >
> > > +     return false;
> > > +}
> > > +
> > > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
> > > + * lock.
> > > + */
> > > +void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > +                            struct sk_buff *skb, struct net *net)
> > > +{
> > > +     struct virtio_transport_rx_pkt_ctx ctx;
> > > +     struct sockaddr_vm src, dst;
> > > +     struct sock *sk;
> > > +     bool free_pkt;
> > > +
> > > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > > +
> > > +     sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> > > +     if (!sk) {
> > > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > > +             goto free_pkt;
> > > +     }
> > > +
> > > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > > +             goto free_pkt;
> > > +     }
> > > +
> > > +     lock_sock(sk);
> > > +     ctx = (struct virtio_transport_rx_pkt_ctx) {
> > > +             .net = net,
> > > +             .src = &src,
> > > +             .dst = &dst,
> > > +     };
> > > +     free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> >
> > At this point the socket lookup succeeded with src/dst/net, why not just
> > pass sk which already has all of them?
> >
> 
> If I understand this correctly, a successful lookup is not enough to
> recover all of this from sk. The lookup may fall back from the
> connected table to the bound
> table, so the packet source must still be validated under the socket
> lock; otherwise that check would become ineffective. The packet
> destination is also needed after
> a transport reset, and the RX namespace used for a reset reply is not
> necessarily sock_net(sk) in global mode. I’ll remove the context
> struct and pass src, dst, and
> net directly.

True that the lookup may fallback to the bound table, but this begs the
question, why bother with the bound table here? If a socket hasn't
landed in the connected table yet, then OP_RW is -EINVAL and we respond
with RST anyway... so I'd guess we shouldn't even be trying to batch for
those sockets.

For connected sockets, the sk has the destination (vsk->remote_addr)
needed by the reset. And yes, sock_net(sk) does not necessarily equal
the net ptr used for a reset reply in global mode, but we don't really
expect that for global mode in vsock, we only expect that
vsock_net_check_mode() rules are followed. In this case where
!net_eq(n0, n1), the RST reply will be routed correctly across
namespaces following global mode rules.

I could certainly be missing something and happy to be pointed to an
instance of sk being insufficient here. In general, I think its nice to
avoid new data structures if possible.

Best,
Bobby
