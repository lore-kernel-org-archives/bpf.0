Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21244D697
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862038; cv=pass; b=TxMMNEUQtk/y35n4kgInZ2Xtz+1Qf3uQW7SRY16srtaMUY3H+FQyYnkyOZ5E9XBYJuGNOCtgyO0dfI5bxLXBOvCWvZW+fbR5HvElJqyjGbWLIhQMJ0Dukop1wpyjISCjXw2K1VQc30rx6TmCYdcf9mrMvL4lNObBvYFgK70RiRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862038; c=relaxed/simple;
	bh=skfSan0+1XZB1gCLut2T846bBKf4wrfvYxze6DiUgyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrvMz0aWKfjj/HGQBUWBte19p/0uI2tS+85WNAUuAVXcQjPmoglMKYawC/F25FltwFftGVUuQKlj+tUXHyPyC8hs2wbpr0wRGEoRIzxghPt8yKtlRmwRzmEGTWe3LvXrUKjqRKK1baLw4eCsOM9nBEnSDad9sq1RFGdcnp/+rQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwjYvO38; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwjYvO38"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e4c00d71aso191566885a.3
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 20:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862036; cv=none;
        d=google.com; s=arc-20260327;
        b=X4d74OGJPMjidSGzfWXLTbSZLxtmalsMstMyCLSD7GK2aEW7UbmtvDTWqvVMzdCvH1
         dQ8/Y++gJAdLcF7U/BB0xJ9t7KVE1Fi6z0Hv6tqDZagRD+y22+DWMANi1QJeGTJQDoeA
         UMLvQqDwK9Xfy3cW7cQ9ERDXX9vIEiVPGeOro4KrP9mUnsrTuoPQNaP6faDeIeHfKe3t
         2ma3r7cHj5HF1oYMMEViBmvUqRspIh/74i5iYGrvtVXgVcgOvb7nYxZSxLikJC3uzlNT
         gWGphly7nWH82UQ+OXMsJG50eSQQ0XXPR9RW/p/Jm3JtzXAQF8xIwVWUQ5hXFplhXI7a
         KizQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GnoX8iRBAWCVauZf/sBd0GnSZBf0BiraG31WKJrHpzA=;
        fh=JjDPqbtck3f8ZmKAenkQLBmtPEICvWE4UJdlOSiotCs=;
        b=XWwqmrX+ZwkVb8y8k1nLD7jzb5WTxX3oD1FbOHxUeZNg08br7gPQqNXXPWZ9ohu5/S
         r//rXHJc2af3AAM9PaWxaDZDJjKOakbZ4Bxx5qFJ7rxvq0E2MGuMyt3NdA5wiYINiJiD
         YSY9W7JNuvrRFbxjY6e1halJHUFETHcjNV8tmG/dC+FuKQs8t1s5YKrMTg/gmbCOmZ4h
         x2USLJEEWm+EUNNOCVwEk+mOnSu2LdM82zaEYJqI3Qeo5IWqt8w6slpPxNiPgFETWRd+
         5urYHbspIlFW4F2wnvnjSIYAxLs6n2XMoe1/NZVRSSysTJFXITg9jQlJvZPXsQtTIQVC
         swOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862036; x=1792466836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GnoX8iRBAWCVauZf/sBd0GnSZBf0BiraG31WKJrHpzA=;
        b=CwjYvO38fOqQHnicYM2mN6mt+w7UO33Rj+UogHeUu8SRJxqjI0DobRZjiKG9yIUhM1
         A2Gb3r1NimARynJC04G84Fses9uXheZD2h43631hjzfpd4Wti2Yrx6srFxOVK+U+B67z
         pJuUmTCFSFjsF/xk0Yhbdw4Ssfugk8Rbxb5GW7vcM7D40B0qVuqPgJd0WBz56I3GMyMl
         5/FhxdzlXZOBHxp6Qnk1kwSy/Efy/VJG4vqmQjXbiXFWNSdhWPdneZk/eF4oaQ71hfYb
         aKKMaJm35kSHWDwap4vhQzU5U61LPzJ3WI3urvY6Dc4Kx2rlS6FiMKu3h+KLHbd6M3IU
         GK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862036; x=1792466836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GnoX8iRBAWCVauZf/sBd0GnSZBf0BiraG31WKJrHpzA=;
        b=iOL41wH1pP/Xt+tFxYMJ+gAsW+B91EVQoK42xPBEZfcv1AGlp+Pd0pqg178HHxdhd8
         Bm0SFyyHratddx3bHMPl8J63VX7NWOBEhQ8xUveoZOMS0GAL8ujlSslhCQcgdTNLSXiP
         6IZkFI8aJpNDHurO8D+JW7b3blG2w3jEUVLagn4cxwT+Prj62MpIowa+MhEavwh4Immr
         jBmIhfeYnRDTgbYMprfdnbrOneJ0RxYR4ZOLZ2t08gjzcdCfwolWu8d04FGNnjobJD92
         fxLhj2CuPeNfQckzxE/KXZQmGvzUIPR2glL0L0RmOladnbuRccO9lwivccY5RamqOwcU
         En+w==
X-Forwarded-Encrypted: i=1; AKwUvBwuKeRoYH5NcNThewBx1Bsyf7rAlpm7dBJLYPJ1SATnXNvyyjHhb+ThF0WcYKImCdBt4oI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLX9O8DJYniPPkWK+DJ8rRRX4D7fe9v5DfgHZhMXmuzB5riXXRe
	h1HZmzEvfovE0omMpRMVE11Cp/22a2E7v5HQwMXzxxJZfSks+sjnjGNd5wz8isw1uUrQCN4Vgcc
	Sd90ZU/k1MwgFVF/v5Lg9ZWkO3I3ltbo=
X-Gm-Gg: AYBFou1bVglk0PS4oU03FJg8EarZJDe+FB6K9iRfv6JONyFq6NH+nOQB6e1BrfIsVt5
	k6tSeji2D3pDDg41SwUyDfpQb6PzBSnwe3kDDFWKld+5FYgp9Hf4XRYvKITvIoaQ4IPqNGCPoDe
	4Sth2klBwjC8oYtri4ijJuIwILYvShjiWLXw/dRPcxiWfXw+PvO/Nq+JzegOhFLB1Aw+9VquB30
	d9EAyaX2KR1QfnC3dlMN81U36zoH2bAVdiaUtqBzLA0izCYIZB9UdGohBKD5CO2ZdIe9TEaEPnR
	RDhqLR79/Axj9MhsQg0WWGi55AaSVah40e0HNLBxTeuNzGGviLXHNeQ=
X-Received: by 2002:a05:620a:19a2:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-93ebcc1186emr1807392585a.0.1791862035540; Mon, 12 Oct 2026
 20:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com> <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
In-Reply-To: <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Tue, 13 Oct 2026 11:26:38 +0800
X-Gm-Features: AclHuK-0Vr6L1DTitDJsFP7Cyfe2EIaVm5DyDLTJkZtt76nbyfmG1WpYEm38C3s
Message-ID: <CAJwVaMJL4FFYLq523VY014oa4u7RWD0WUY0+seP1xh3GY5peiQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/5] vsock/virtio: split socket lookup from
 locked RX processing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> > Split virtio_transport_recv_pkt() so socket lookup is separate from the
> > receive state machine that runs under the socket lock.
> >
> > Keep virtio_transport_recv_pkt() on its existing per-packet locking pat=
h.
> > Pass the source and destination addresses used for lookup to the locked
> > receive path so they are decoded only once.
> >
> > Pass the network namespace and decoded address tuple through a packet
> > context to the locked receive path.
> >
> > Preserve source validation and failure handling. Keep the lookup refere=
nce
> > separate from the skb owner reference so the locked receive path can ma=
nage
> > the two lifetimes independently.
> >
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++--------
> >  1 file changed, 96 insertions(+), 43 deletions(-)
> >
>
> [...]
>
> > +/*
> > + * The caller holds sk's socket lock and must free skb if this returns=
 true.
> > + */
> > +static bool
> > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > +                              struct sk_buff *skb, struct sock *sk,
> > +                              const struct virtio_transport_rx_pkt_ctx=
 *ctx)
> > +{
> > +     const struct sockaddr_vm *src =3D ctx->src;
> > +     const struct sockaddr_vm *dst =3D ctx->dst;
> > +     struct vsock_sock *vsk =3D vsock_sk(sk);
> > +     struct net *net =3D ctx->net;
> > +     bool space_available;
> >
> > -     /* Check if sk has been closed or assigned to another transport b=
efore
> > -      * lock_sock (note: listener sockets are not assigned to any tran=
sport)
> > +     /* Check after acquiring the socket lock. Listener sockets accept=
 packets
> > +      * from any source and are not assigned to a transport.
> >        */
> >       if (sock_flag(sk, SOCK_DONE) ||
> >           (sk->sk_state !=3D TCP_LISTEN &&
> > -          !vsock_check_source(vsk, &t->transport, &src))) {
> > +          !vsock_check_source(vsk, &t->transport, src))) {
> >               (void)virtio_transport_reset_no_sock(t, skb, net);
> > -             release_sock(sk);
> > -             sock_put(sk);
> > -             goto free_pkt;
> > +             return true;
> >       }
> >
> >       space_available =3D virtio_transport_space_update(sk, skb);
> >
> >       /* Update CID in case it has changed after a transport reset even=
t */
> >       if (vsk->local_addr.svm_cid !=3D VMADDR_CID_ANY)
> > -             vsk->local_addr.svm_cid =3D dst.svm_cid;
> > +             vsk->local_addr.svm_cid =3D dst->svm_cid;
> >
> >       if (space_available)
> >               sk->sk_write_space(sk);
> > @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virtio_tr=
ansport *t,
> >               break;
> >       }
> >
> > +     return false;
> > +}
> > +
> > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq-=
>mutex
> > + * lock.
> > + */
> > +void virtio_transport_recv_pkt(struct virtio_transport *t,
> > +                            struct sk_buff *skb, struct net *net)
> > +{
> > +     struct virtio_transport_rx_pkt_ctx ctx;
> > +     struct sockaddr_vm src, dst;
> > +     struct sock *sk;
> > +     bool free_pkt;
> > +
> > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > +
> > +     sk =3D virtio_transport_recv_pkt_find_socket(skb, &src, &dst, net=
);
> > +     if (!sk) {
> > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > +             goto free_pkt;
> > +     }
> > +
> > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt =3D=3D=
 0\n");
> > +             goto free_pkt;
> > +     }
> > +
> > +     lock_sock(sk);
> > +     ctx =3D (struct virtio_transport_rx_pkt_ctx) {
> > +             .net =3D net,
> > +             .src =3D &src,
> > +             .dst =3D &dst,
> > +     };
> > +     free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk, &ctx);
>
> At this point the socket lookup succeeded with src/dst/net, why not just
> pass sk which already has all of them?
>

If I understand this correctly, a successful lookup is not enough to
recover all of this from sk. The lookup may fall back from the
connected table to the bound
table, so the packet source must still be validated under the socket
lock; otherwise that check would become ineffective. The packet
destination is also needed after
a transport reset, and the RX namespace used for a reset reply is not
necessarily sock_net(sk) in global mode. I=E2=80=99ll remove the context
struct and pass src, dst, and
net directly.

> Best,
> Bobby
