Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF731618C
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862290; cv=pass; b=P5wZL+OhIPuu8yzkMlegwM1APo8R+2G5EqI6++bmpein5g8/bKdT8r/fB3xwa04uenWRV3l97wDyqPjT5kV3KpG0EVHiG94AM2QGkQPA8+HMNjio2WeZovQHxVM4UDXXTT9WR5+CFco6HlZQvgOIjI1dBe3j8dOQfvJ+Xcgj2A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862290; c=relaxed/simple;
	bh=zCSEKIAPKVwVSGY4GyE3kxLa1knCjzTA3Y/jvMzWxiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pL/NjQ2lAdwAc1Be7CD0huL0SRpr/3AIHtIlyCvKPpQu6/HkudxWLc9W5UW2Sz1Ta10mtArbMzfexF1tBYe4krlQpetjM37NgqPtLLPpLT9lmw5r22GdtI03tlfKmckHN/zDZvjFg5kUe+SUa2lNXJIFUajlARyYyRzgaq67oQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNRyFkqW; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNRyFkqW"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91986c5cb75so33023446d6.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 20:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862288; cv=none;
        d=google.com; s=arc-20260327;
        b=IgkG636DyMvKIZzE/ZRlJctz8qsbU/ZkSipYYCHYVMOOJciEeIz4183lihm30I9S0S
         WFx+DNuVsLGSFQ3Jp28lbcHAhGQ34N+AO37jKop6mZ04vLykEycZclz9NBoMe8xISLAY
         hQpUO1XqzsrApp+sqwn8mnmC2qEpDOY1k60a0MStBeKpWINsL7wJ+zwHo3yDvo/e3JG/
         DGeBWKMTJY4xaa2Lnygj0c1lWk6xDX80pN0K5KsOfLDLOjOqRtmAcjXquHqpjEqzP569
         EerXcb8uKerO84Dt0Cxi8jH+JgnTiejRcBqbBNUXfr69VNuoKoezltbsvW9PJ9kijL9M
         8gJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oKth/1jAUk8y73FB5cD2ux1SjiU3FjqeBdt11b7UR8k=;
        fh=6x4D+Ddyc/BHI2NelUVL2umT/uDhyZabln1DRI2/ccU=;
        b=L4x5lYaoIas4kz0I49MSBUaDoR73V6rnhi92pTuwMf2a1/Z4/JAIw1lbgfXUv5/kYt
         /Naf+AR8jCqqHAp2cMMftLFE9NUQWzCC8mRyWQXfWIQlnRucsC7lo61tmWbZhT4lr/a7
         VQraKGZOES/tdMEJ7d3Z3xmWEnZItvueF9C/XveJR/jisy2Vli+wdcC0LXSoPe59GALX
         y2zUIXIxrtVQYNmAaJ54o71kcFpOw6aN5iepzysYJzU0VyNebPkJiOgc3oIaZ98zIuPK
         SrxAoF+LBgMaMXQ2g8NRPFz5N89LiFqW9TfWiaajTVhnURjB9Ahg7LT0EaZGjWLDKA15
         7BdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862288; x=1792467088; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKth/1jAUk8y73FB5cD2ux1SjiU3FjqeBdt11b7UR8k=;
        b=CNRyFkqWvkphXy4611cQxfWd3tluQ2Ap+aZpYQtlP56Wvf2uIOZtIBNT32f9l64lCL
         HdERnSWoEgkR/I2ykgmwW9MosDd36LVBYLu6FgpxJZ8CfziAMvs+159cn0FEnD3Wk8vs
         owf5QJpZW1rBUtUGwT8vcnB3pYZ53gcu4humkw3zPvllA3/lNcsYd9DuB+3stYgwMh0x
         WzsNiT7bE58HHyvxKNhB6gyxAw17LkLNfWXXnhSE0WUgxAQ5MbNsa9RRuytAk3T19QiY
         g6OGGZcFuYXaRsFoYjuxyt3UAtI2t/HA/7ciI0OrbqE1t8NO/gP65CGhRi7fSe90KWxZ
         f/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862288; x=1792467088;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oKth/1jAUk8y73FB5cD2ux1SjiU3FjqeBdt11b7UR8k=;
        b=yA7AhIz4JmdjHzpBzzWi8f7iW25VFjERpn7PQwlAWX4guW6U92zpyQncH7rC0xc11q
         L9alWihBA9l6R9iTSlWQlP6F1ar3mfWdhwgfQDbDBddqcA4VpkSq0wRD4bUWJDrxFCc9
         hoaOhWL7eYVXd1ythLhBIB21/iJ23jrkWO8ImN1dmcDh+uWCPD+wEzA6Zz9Q4EFIiWf1
         rAXvZOktGHvIDIKYERpTzsH3L60L33tcecbGrN2MehNAMJYf3wtyEj6CpLp44F0a0drK
         sRNERGguO6GFT8mfRVXIHiyrbcMzU7UVtOZeVjzIH8mKWa1HUd8R83Tf5hjHhJMNNokk
         H3pg==
X-Forwarded-Encrypted: i=1; AKwUvBzmMUHPQ59/hcU4RcAEFZ0Q6e7kdmJ6dFWzQpFNqYLGq9kJRCTqmUKVrY1G8W1wYpomjgo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIN1yxjIki/MdMqqNMoC73AkwPUqdT/SEDPpuEOJ10gGotHn0Ft
	3XDNXJTjWqYzeWNfCGgnOFQO6ODxhDv/hpOFSVPWpgtI8SiPJm9E+kXkp8Gnn4wjx+gIDn/l7ga
	d9p7U43f4rswDobifDNk8gTa+deMsidE=
X-Gm-Gg: AYBFou0hSnkXfYEv5JYIJuBxCXV9NntApmyjIx9k1b+oQnukD4ZBrVEmE9Otn0VEMk8
	npJo6xLAE6q3KSblPGGmCpIgDcBCmtI1x2kr5Ir1nPlabIo5V0jtoUNY6S9HqAiNFGnqlyeYsGr
	65JvR5MA7xq4kVJNmFWa4LN67qwYIrK9zBSitWXFojgXuiWViLg0Xh4Hy3E4pEpOU48r/LWN6tc
	eqHYh0yJdLYgkLk/arNrU3Nv6RbPVI/rCltwAzUebmENn+adK8qSOd+lqutWnqp7mHWc5y8Kmma
	2hR9VRuq2Ywf+8K/SSsZ3YOITZr9x0p5kgdj8Lwt7DFhOSsZpsUGR+k=
X-Received: by 2002:a05:620a:44c8:b0:939:1222:b9f1 with SMTP id
 af79cd13be357-93ebcd2b3d1mr1818738285a.0.1791862287366; Mon, 12 Oct 2026
 20:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-4-physicalmtea@gmail.com> <as1ciTHT2O40E/Uq@devvm29614.prn0.facebook.com>
In-Reply-To: <as1ciTHT2O40E/Uq@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 13 Oct 2026 11:30:51 +0800
X-Gm-Features: AclHuK82x5TMJTU3P4uV1cGGZ695rdTmYCG-meYcWlEm97kH4rrDUYXGHuCS2tM
Message-ID: <CAJwVaMJxgjbEXk8LW+wYbmfPYA2anNcRtitB=G1=kNv-WXm4TQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/5] vsock/virtio: reuse same-flow socket
 lookup in RX batches
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Oct 10, 2026 at 10:22:45PM +0800, Jia Jia wrote:
> > An RX lock batch still looks up the socket for every packet and takes a
> > temporary lookup reference, even though the batch already holds a reference
> > to the locked socket.
> >
> > Record the network namespace and packet address tuple when a batch starts.
> > Reuse the batch socket for later STREAM/RW packets with the same tuple, and
> > release the batch before looking up a different flow.
> >
> > The cached path still traces every packet, takes an skb owner reference,
> > validates socket state, source and transport, updates credit, and runs the
> > receive state machine. Only the socket table lookup and its temporary
> > reference are skipped.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  include/linux/virtio_vsock.h            |  3 ++
> >  net/vmw_vsock/virtio_transport_common.c | 58 +++++++++++++++----------
> >  2 files changed, 38 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index 26dde6909c4e..d6528681e052 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -287,6 +287,9 @@ struct virtio_transport_rx_batch {
> >       struct sock *sk;
> >       unsigned int pkts;
> >       size_t bytes;
> > +     struct net *net;
> > +     struct sockaddr_vm src;
> > +     struct sockaddr_vm dst;
> >  };
> >
> >  void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index e67dfcaa279c..73e5c7dfe8b4 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1977,6 +1977,7 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
> >       batch->sk = NULL;
> >       batch->pkts = 0;
> >       batch->bytes = 0;
> > +     batch->net = NULL;
> >
> >       if (!sk)
> >               return;
> > @@ -2008,6 +2009,37 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >       virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> >       virtio_transport_trace_recv_pkt(skb, &src, &dst);
> >
> > +     if (batch->sk) {
> > +             if (batch->net == net &&
> > +                 vsock_addr_equals_addr(&batch->src, &src) &&
> > +                 vsock_addr_equals_addr(&batch->dst, &dst) &&
> > +                 virtio_transport_recv_pkt_batchable(t, batch->sk)) {
> > +                     sk = batch->sk;
> > +                     if (!skb_set_owner_sk_safe(skb, sk)) {
> > +                             WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > +                             virtio_transport_rx_batch_finish(batch);
> > +                             kfree_skb(skb);
> > +                             return;
> > +                     }
> > +
> > +                     ctx = (struct virtio_transport_rx_pkt_ctx) {
> > +                             .net = net,
> > +                             .src = &src,
> > +                             .dst = &dst,
> > +                             .batchable = &batchable,
> > +                     };
> > +                     free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > +
> > +                     if (!batchable)
> > +                             virtio_transport_rx_batch_finish(batch);
> > +                     if (free_pkt)
> > +                             kfree_skb(skb);
> > +                     return;
> > +             }
> > +
> > +             virtio_transport_rx_batch_finish(batch);
> > +     }
> > +
> >       sk = virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net);
> >       if (!sk) {
> >               virtio_transport_rx_batch_finish(batch);
> > @@ -2018,33 +2050,10 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >
> >       if (!skb_set_owner_sk_safe(skb, sk)) {
> >               WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
> > -             virtio_transport_rx_batch_finish(batch);
> >               kfree_skb(skb);
> >               return;
> >       }
> >
> > -     if (batch->sk && batch->sk != sk) {
> > -             /* Never acquire a second socket lock. */
> > -             virtio_transport_rx_batch_finish(batch);
> > -     }
> > -
> > -     if (batch->sk == sk) {
> > -             /* Keep the batch reference; drop this packet's lookup reference. */
> > -             sock_put(sk);
> > -             ctx = (struct virtio_transport_rx_pkt_ctx) {
> > -                     .net = net,
> > -                     .src = &src,
> > -                     .dst = &dst,
> > -                     .batchable = &batchable,
> > -             };
> > -             free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> > -             if (!batchable)
> > -                     virtio_transport_rx_batch_finish(batch);
> > -             if (free_pkt)
> > -                     kfree_skb(skb);
> > -             return;
> > -     }
> > -
>
> Not sure I love adding code and then removing it in the same series.
> Seems like these are asking to be squashed?
>

I'll fold patch 3 into patch 2 so batching is introduced with
same-flow lookup reuse from the start.

> >       lock_sock(sk);
> >       /*
> >        * Sockmap removal restores the native protocol under sk_callback_lock.
> > @@ -2063,6 +2072,9 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
> >       free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
> >       if (start_batch && batchable) {
> >               /* Keep the lookup reference until the batch is released. */
> > +             batch->net = net;
> > +             batch->src = src;
> > +             batch->dst = dst;
>
> Similar to my comment in the other patch, seems these are all in sk
> already?
>

For the batch cache, yes. I'll use the locked socket state for the
same-flow check. The packet values still need to be passed to the
locked receive path for source validation and reset handling.

> Best,
> Bobby
