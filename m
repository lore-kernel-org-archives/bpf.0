Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8412FE074
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 04:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951482; cv=pass; b=j4oKrCaCaStie1/HJRbHPKsEl5LYlpHuWpbjE9TmkQIKkvbtSrLD7jaC0gY80VbzoW9jpjLjRLu0X9QmGj49lohBUNSxK7uAabqvGobqm6qArRUDwdgMZWksB41W77mK6TlCQOqCfLHBIn6/JuacayZY9BXZWjlV3J3hfLfcQMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951482; c=relaxed/simple;
	bh=FCFoyOy4qvXMnUzHelNH4AHBinUUgJXQyV47QXx+bBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sS2D3ai0YLiG4goMMHBqY0HKR7ehGNkqJACMmuWGkSo+g2B8ZTuodmpijj3jsdHbxNBUL642GJ3KJhZBfP1AmcQheBEDfDGFg8XfJ5n4olofO4OMQhSjOM4k1h9djkhp/OeBL7k6NdOeOzb8Q05fvuD/r9ysCRTKnOoZRlaromU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdI2p6LC; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdI2p6LC"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91791ec1b83so30908426d6.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 21:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791951479; cv=none;
        d=google.com; s=arc-20260327;
        b=h4cEn/82Hi8JZUGx+hq95j3dpqNAPpgrizp4/Bnnrz2eYMGGP0wmWjqvaJFIQ+XCdS
         lm93qFNCYhWrUGd2hxktzMaE0FyyN+FQmqWpktQfw7tUXB7v+wMpfEDuQcI+dEI4ZKGw
         x+UCooq825M2ru4EVk9egdywFuEGIaLPBQswhNQFBgS0MXV7tp0GCOAbhtOA6uW2B6Q2
         4j1NCriLRZUjUcrAbBSASGp28VGSfO8Y/vGG5zl9b1/PuD/jJHOTIbwf7FkQZNMrcJhf
         cHghndw78qKSK4H1AVHagb4/e9K8WuGnMo9f/u/6yuMt9gMET7RWwRxNAeXyR7ivjpZP
         ugDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ZCjIb9MTs997peH+Jf+AEs7X4vp3T30edvZQYk3nBA=;
        fh=bFYRQfMsi4n0nqQ7ahF1dGFa6A89a4z8PvhS4y8dZCc=;
        b=OKGNDnz5L4qY9W4vCChPgwC0gp6KDA8Fg4P34RMOJOlRjfU/u6LyvPo2zAwConB3rf
         CsAvmJ4/PKn6RJZyvlnluR2wEOrTF10axAln5GuZnc3HL68NDSfxjt9qj4i5yZ6cAAM8
         sbX3Lc7harRRRsfKdajO2XRBahAuswZznVPXm73kqWZVsnDbdP7CVtRUfK8qLfT9Nn4s
         2y59Kr7bKhWJQQgl8sdyDWxBnmOhXCHDLZZvvGWVQjdMK5oI7dXOU5jFZ6QkXLlv8Q48
         c0mLh+RioKtrkEyyfD9S1Y8eoO1CasatSfNK0YPOmzrYS7XtmSI/+wifZPOSprcMEyY0
         DwQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791951479; x=1792556279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ZCjIb9MTs997peH+Jf+AEs7X4vp3T30edvZQYk3nBA=;
        b=SdI2p6LCQ4aWaQPT6dillp92RI21bwsURrLkqh9CawHgTGt5ayFDz9YWLEYw+caXN6
         bTiaZhpDOG9II7LcivZaGyhxCF/Thd/6I9z7+R5vOPKcGAcXtZ0fPJLAslYG+p1tZXR7
         +NGiiP+A0bMWJtThoWCsVUpB5vveeEB9YM1RTB0tFMq8FNHvDwuZRywH8etLN1VzuD6a
         +AAaaORC27I23AXDgY9K+YNqlS4hRoUX7d90LU1GugjnmvZgbpjQzo0dCTDnxgPSQ9m9
         w9S3M9EAYyAkRCchj1URaqUEbYehTc7s/YnKtgT/DNv3RMfBcFcRTlu+9OQeV5DEAOnt
         UaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791951479; x=1792556279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZCjIb9MTs997peH+Jf+AEs7X4vp3T30edvZQYk3nBA=;
        b=AeAZh2o2WiOxY6sHIGSocQkrAa79Fo9RQJA4C5i6Gxdz8g8HrLBdMH4GTD6Bia3PrT
         m2jVvjdpApwOvKi3Vp1BhaCg9BedgKIFRNYvEQY6PsAB9k6zjmKcRXQWu8RYCwNzeJKq
         0R4u8XNR7v5GyvsePo+tBQf5YUk2yNykttngQLEflwZ0eb1JnfFl+av+qiRh5IcQLHGk
         IZgcb5aA5LNkf5VmQNYtB2zz83fvuhjO4G3GrcbeDlmPGWh/TsFvKcD/igvpoRX8srhb
         nvswz69fUuJ917R8xdZW2q/U6Fj4NlNub3UoD0B6FX68YHGopEp6CzEj7LZw2Qvz1G2s
         vaOg==
X-Forwarded-Encrypted: i=1; AKwUvBx4rr4sFaEb3UqiUvQDKq1JzH8UpZhMJRj+Np1t2cat1XWkDmq7n1LhtsMahpEP2QBZOWY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8rVXvIg5UCIlAlSBXVvAcMZzMY+n/Zl3LKkJ+FaBCxlLib7Ih
	PhZJt536e+E1YsVPhuhZFFgjZjtQbQLq+mYGdefx5zGBiUzO6GO+1ce02Os5qxOT52LFYYGP9U0
	k3/O8/YFV/DgmXigScBzAEYYBC/UQIjA=
X-Gm-Gg: AYBFou2RI8Y44IeT2QwUsHQI1A+hs7VoeHWiXZf2G+BrzDb2zMtl1bDIW7ohS7ii8zI
	VFR5h1LuVq630gNlt/ueD8w6fqPJ9tztxpQaANzkcjAQko8Y4u6p2CuT/DDQRzflZuLTZ2PsaPr
	OYYyebvXC4X/YaI2eKlBztHhbN64Y1J64zZb6TMjKDyRVOqCKVwdBT4P5CBX1LVorLTetgqhKmb
	jFVDU26pvdeFHLPLcQ9hByRep2B8EX/W+pfumdpQ9nPxanzjVPWiFeCFiKECNT+zs2ywUAMG1nO
	CrKhgsqRuzG2SWQTMqhYVkpF8CLD4/RRlj1ZhK8Pk4kZIfF79mG8vKo=
X-Received: by 2002:a05:620a:4449:b0:93b:e9db:1bab with SMTP id
 af79cd13be357-93ebd27cc75mr2258515585a.56.1791951478672; Tue, 13 Oct 2026
 21:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010142247.99223-1-physicalmtea@gmail.com>
 <20261010142247.99223-2-physicalmtea@gmail.com> <as1ZCkbya2jn72ip@devvm29614.prn0.facebook.com>
 <CAJwVaMJL4FFYLq523VY014oa4u7RWD0WUY0+seP1xh3GY5peiQ@mail.gmail.com> <as5nfI0qfqD64dc1@devvm29614.prn0.facebook.com>
In-Reply-To: <as5nfI0qfqD64dc1@devvm29614.prn0.facebook.com>
From: Jia Jia <physicalmtea@gmail.com>
Date: Wed, 14 Oct 2026 12:17:22 +0800
X-Gm-Features: AclHuK-Tjj0vL8jiV-17JnHCHultMYwdnuqEsTpaVilZ25EnMCMFZNG1gR08W4M
Message-ID: <CAJwVaM+SHuidjUeKD8-MX2ErbkaBUKE8cPYH2fzNJR+jH-oWZw@mail.gmail.com>
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
> On Tue, Oct 13, 2026 at 11:26:38AM +0800, Jia Jia wrote:
> > >
> > > On Sat, Oct 10, 2026 at 10:22:43PM +0800, Jia Jia wrote:
> > > > Split virtio_transport_recv_pkt() so socket lookup is separate from=
 the
> > > > receive state machine that runs under the socket lock.
> > > >
> > > > Keep virtio_transport_recv_pkt() on its existing per-packet locking=
 path.
> > > > Pass the source and destination addresses used for lookup to the lo=
cked
> > > > receive path so they are decoded only once.
> > > >
> > > > Pass the network namespace and decoded address tuple through a pack=
et
> > > > context to the locked receive path.
> > > >
> > > > Preserve source validation and failure handling. Keep the lookup re=
ference
> > > > separate from the skb owner reference so the locked receive path ca=
n manage
> > > > the two lifetimes independently.
> > > >
> > > > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > > > ---
> > > >  net/vmw_vsock/virtio_transport_common.c | 139 ++++++++++++++++----=
----
> > > >  1 file changed, 96 insertions(+), 43 deletions(-)
> > > >
> > >
> > > [...]
> > >
> > > > +/*
> > > > + * The caller holds sk's socket lock and must free skb if this ret=
urns true.
> > > > + */
> > > > +static bool
> > > > +virtio_transport_recv_pkt_locked(struct virtio_transport *t,
> > > > +                              struct sk_buff *skb, struct sock *sk=
,
> > > > +                              const struct virtio_transport_rx_pkt=
_ctx *ctx)
> > > > +{
> > > > +     const struct sockaddr_vm *src =3D ctx->src;
> > > > +     const struct sockaddr_vm *dst =3D ctx->dst;
> > > > +     struct vsock_sock *vsk =3D vsock_sk(sk);
> > > > +     struct net *net =3D ctx->net;
> > > > +     bool space_available;
> > > >
> > > > -     /* Check if sk has been closed or assigned to another transpo=
rt before
> > > > -      * lock_sock (note: listener sockets are not assigned to any =
transport)
> > > > +     /* Check after acquiring the socket lock. Listener sockets ac=
cept packets
> > > > +      * from any source and are not assigned to a transport.
> > > >        */
> > > >       if (sock_flag(sk, SOCK_DONE) ||
> > > >           (sk->sk_state !=3D TCP_LISTEN &&
> > > > -          !vsock_check_source(vsk, &t->transport, &src))) {
> > > > +          !vsock_check_source(vsk, &t->transport, src))) {
> > > >               (void)virtio_transport_reset_no_sock(t, skb, net);
> > > > -             release_sock(sk);
> > > > -             sock_put(sk);
> > > > -             goto free_pkt;
> > > > +             return true;
> > > >       }
> > > >
> > > >       space_available =3D virtio_transport_space_update(sk, skb);
> > > >
> > > >       /* Update CID in case it has changed after a transport reset =
event */
> > > >       if (vsk->local_addr.svm_cid !=3D VMADDR_CID_ANY)
> > > > -             vsk->local_addr.svm_cid =3D dst.svm_cid;
> > > > +             vsk->local_addr.svm_cid =3D dst->svm_cid;
> > > >
> > > >       if (space_available)
> > > >               sk->sk_write_space(sk);
> > > > @@ -1875,12 +1891,49 @@ void virtio_transport_recv_pkt(struct virti=
o_transport *t,
> > > >               break;
> > > >       }
> > > >
> > > > +     return false;
> > > > +}
> > > > +
> > > > +/* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's=
 vq->mutex
> > > > + * lock.
> > > > + */
> > > > +void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > > +                            struct sk_buff *skb, struct net *net)
> > > > +{
> > > > +     struct virtio_transport_rx_pkt_ctx ctx;
> > > > +     struct sockaddr_vm src, dst;
> > > > +     struct sock *sk;
> > > > +     bool free_pkt;
> > > > +
> > > > +     virtio_transport_recv_pkt_init_addrs(skb, &src, &dst);
> > > > +     virtio_transport_trace_recv_pkt(skb, &src, &dst);
> > > > +
> > > > +     sk =3D virtio_transport_recv_pkt_find_socket(skb, &src, &dst,=
 net);
> > > > +     if (!sk) {
> > > > +             (void)virtio_transport_reset_no_sock(t, skb, net);
> > > > +             goto free_pkt;
> > > > +     }
> > > > +
> > > > +     if (!skb_set_owner_sk_safe(skb, sk)) {
> > > > +             WARN_ONCE(1, "receiving vsock socket has sk_refcnt =
=3D=3D 0\n");
> > > > +             goto free_pkt;
> > > > +     }
> > > > +
> > > > +     lock_sock(sk);
> > > > +     ctx =3D (struct virtio_transport_rx_pkt_ctx) {
> > > > +             .net =3D net,
> > > > +             .src =3D &src,
> > > > +             .dst =3D &dst,
> > > > +     };
> > > > +     free_pkt =3D virtio_transport_recv_pkt_locked(t, skb, sk, &ct=
x);
> > >
> > > At this point the socket lookup succeeded with src/dst/net, why not j=
ust
> > > pass sk which already has all of them?
> > >
> >
> > If I understand this correctly, a successful lookup is not enough to
> > recover all of this from sk. The lookup may fall back from the
> > connected table to the bound
> > table, so the packet source must still be validated under the socket
> > lock; otherwise that check would become ineffective. The packet
> > destination is also needed after
> > a transport reset, and the RX namespace used for a reset reply is not
> > necessarily sock_net(sk) in global mode. I=E2=80=99ll remove the contex=
t
> > struct and pass src, dst, and
> > net directly.
>
> True that the lookup may fallback to the bound table, but this begs the
> question, why bother with the bound table here? If a socket hasn't
> landed in the connected table yet, then OP_RW is -EINVAL and we respond
> with RST anyway... so I'd guess we shouldn't even be trying to batch for
> those sockets.
>
> For connected sockets, the sk has the destination (vsk->remote_addr)
> needed by the reset. And yes, sock_net(sk) does not necessarily equal
> the net ptr used for a reset reply in global mode, but we don't really
> expect that for global mode in vsock, we only expect that
> vsock_net_check_mode() rules are followed. In this case where
> !net_eq(n0, n1), the RST reply will be routed correctly across
> namespaces following global mode rules.
>
> I could certainly be missing something and happy to be pointed to an
> instance of sk being insufficient here. In general, I think its nice to
> avoid new data structures if possible.
>

You're right. Although virtio_transport_recv_pkt_batchable() requires
TCP_ESTABLISHED and excludes other states from batching, the
bound-table fallback is
unnecessary there; batch admission can use only the connected lookup
and leave a miss to the normal path.

I also overlooked what the existing vsock_net_check_mode(sock_net(sk),
net) check guarantees. If the namespaces differ and the lookup
succeeds, both are
in global mode, so sock_net(sk) is sufficient for routing the RST. The
extra context is therefore unnecessary. Thanks for pointing this out.

I'll update this in the next version.

> Best,
> Bobby
