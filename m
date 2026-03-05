Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094229A1
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696906; cv=pass; b=RvOfN2DDUo622gzHDzTVHg8bJfsbw+JubI9UcjcOsHmwHsGf+3GtlZr1ILSiM0iyuoM2N2BMC/rjNjDOLQAMnQhfatnf/GRKFEwPNiqBr4oK6KLLkLG0SxOi/p6BMJSx8ybOdydlHCv/i+NrbUbuR7DVoOdDr+lljiYhlZH4cm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696906; c=relaxed/simple;
	bh=k9aARijhl+UpUNTAbtTN6GlGGncJpw4/8U+YwxU7GGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jzg1FKdkud1nHYkZsFEMZKMCouiY41vPRxfRsdsQOfK/lAJkd8dkIE+q+UhGZ1TqwK6yDY7SXtqQutQ7VuPBn1ryV0aevoeZGkVrasJegO92+FRBZ8tIEg5ttIuadO/+2kcERh1KV+KG8RiBqlPByNkben9TQNViw+L5x40lu4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGeIP84N; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGeIP84N"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1275750cf9cso6378642c88.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 23:48:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772696904; cv=none;
        d=google.com; s=arc-20240605;
        b=gmqdGOjBb8+XHmGoXfYhC6O3aPeKzevXIIqHKLN5KPCDJWCkgpismxPossw6wbIIYL
         cc0vlJhFRZZ3v6VoCE3Yole2sapJU4ABU2/LSTRoDllVCR2UC9IU2ypks6V4Us/90RiC
         2BLGfUD+CDTOiYesiSdBNzjbMRnUA2sxRlkyy9ROYGqSrXSNSGYW4jl5IejWpyhdhy5L
         QsH10QjJdugJyY0o83fzypfZ71gsOdQsoPoDfac066HIiI37201pSpoagqbqQ+FD+aPK
         uogo64Bx+g2tWsZ3t+SJSsp3fda4DlDleH8If0bxT89agT6vvehCor5vJkGwWhFcVcK+
         SBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9JJY1lPR4ZIJ0bJOtAMSPyTe1J2YXJb3Q8jfZODA7WM=;
        fh=oNo+1hifg6CX4IqOWWo6v8gaC12tZNl9IsQVelyVrHk=;
        b=WTIk3D/E5N1MwM8kYJZu2B6I8T0BKAsobAIssAaVoc8vdtyT85VjFkPtZdTCqnHpk5
         TNw2P0e+o6/Jh7JxiGeAN8+bJ2NxmBw5oQLL1q9+JrOy7OiTP1CAvlRCr/b1iAAHfFvT
         NZe0sgWRpEKJHYDJgIHUDnCdgSaoWmrvYn1xf2TqKcfdZC2c+sgtvrpomxJ0c48r8u0D
         cOAFqeeIo76DH/LJw7LcjIwG3feDPd7USl47kiZZToDL/Bq3ZOOIZfcd5ZxXvkEWrEGW
         zIhNFMzRT/crnfQdIxCy+kaT4rqfcROYk6G54Im2CSciX6EvXHvO09awSeHEQetk+HYJ
         m13g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772696904; x=1773301704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JJY1lPR4ZIJ0bJOtAMSPyTe1J2YXJb3Q8jfZODA7WM=;
        b=uGeIP84Ncjd5aF66u6nlTjNdRmqRJ2t+KKHR4dYJETc6C5AzitOoCuAx1wgVtgwPJU
         XxXJ7ePFD3eO2t7d1pazTLFNklyF1B+Y+aakuX9+1RIqiNVSs/wFjHefKxdh86aQQRaW
         Ggx8MuBEsBKrBerKwYlNzZ7IPxnBqfeWRpJLcF4PqDbp/FZ7VugWmAqDGf30IqtCYtKC
         St/aBImwFXZ/nAbBFEY6iNGCE0a3TAKSJ3d/1vR+jNZv8C4ISrUwij6vv479aOK0SIR1
         7QW/C0rgy3nUflbZFc2hpGkySvJLGIlaSKFjNAstqgck7+p26y0HPQpHP4yag79EKOI7
         HXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772696904; x=1773301704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9JJY1lPR4ZIJ0bJOtAMSPyTe1J2YXJb3Q8jfZODA7WM=;
        b=jvCGJL/fwBPPOcrdz1S16TeWdUWtjjvi9HtDjs0ldinPLvCIy+npQOvcGnRnkjEZGG
         /cTSmL5ANFD8OH7yPA37boEuGKvYBw7J3whxUWSUv9NlN9x5TAbY/d0BJ1UXGAWw0dKH
         5BUU3JLYXYfs+bO7bdrw8C6WtroqHqLm+mo8fFHuZzB4lCnMrCvPTwpNP8xMkoSNF+DW
         xulvmWUh9sJCRKoiJ8CHprglNmqRdyJBTLSUgCya9QD4iByXU386vjmDEZ/CuwmzyHyJ
         +IVGbCwKb0sthGEDI70CxydvRnZFlBz8FH+pIRZT/002xWe6haLtuvO2lTjj9QxRBPYZ
         qghA==
X-Forwarded-Encrypted: i=1; AJvYcCV+tdhV80YAVoFphn1CGrUlNBWCZk3xBeF9RpQfglvb49+oDyTE4vJgsHIU+llwyvXGEsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPALOocMgDupAZhWTewM3yTeTkjp2/536XW1Y6Hb3g+0CGTgyX
	ag5sQg04s+YC3eyvxcH0VIVEZf71TPF9a7vvq5nNFGu6bxXsKiziHnJSPZ9Ab0ycl23XV9Oj+ck
	Iv2iXVcG3q5O39ZuknpdaOkpILfBiDsbcbaCwEc0k
X-Gm-Gg: ATEYQzz7d0cbadQnF2SArrs/+M8PGyiHx/1ZC1+vmfKx+IGxFYUZf6uHLWdzsT+KlCq
	1YrA2wsrZdKAX+BqGBnfgojDaKTdPPS29XhUL1qwRp139kFDuskQ5zX9m75muYgMimoiZjYX/fA
	Jfj8pHcHsJAxsYMXrjXFUB75jKO3peB2RRi/xWqK1Br8oZ0SFEwtXhzkViaidrg/2a4Nwoj/EF2
	RKbJOXLE0YTRbTQ3sEnu1DEgJrNar1LubUdS52X32dJAVzvP2zYzHjEm0duCyLQyEqn6JuhQwwY
	2YVnW/+SumrMJkl6Z3M5NcRX/ojKzSFZxAKjBp+cRfX+TaLzTGvOjWdBF2pBi6KS0lmgUTEe
X-Received: by 2002:a05:7022:926:b0:122:2f4:b251 with SMTP id
 a92af1059eb24-128b70c82bemr2437835c88.21.1772696903061; Wed, 04 Mar 2026
 23:48:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-7-kuniyu@google.com>
 <r7csevb4yonphmfhfpkj7jpc4yvjkdwrp566zxhueaf6vgjfak@stnfyjkqid6o>
In-Reply-To: <r7csevb4yonphmfhfpkj7jpc4yvjkdwrp566zxhueaf6vgjfak@stnfyjkqid6o>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 23:48:12 -0800
X-Gm-Features: AaiRm51o2epiQ653A5R7b9_VBmqBq3bYa7mnj-Cue-rtJnp1UxPzumDbD-GWMNg
Message-ID: <CAAVpQUAGSzypVhT8V-qjhUfZeEQhXQtS1z+iQC7vrzZCHEr9=A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 10:37=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> On Sat, Feb 21, 2026 at 11:30:53PM +0800, Kuniyuki Iwashima wrote:
> [...]
> >  </TASK>
> >
> > Fixes: d7f571188ecf ("udp: Implement ->read_sock() for sockmap")
> > Reported-by: syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/698f84c6.a70a0220.2c38d7.00cb.GA=
E@google.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v4: Fix deadlock when requeued
> > v2: Fix build failure when CONFIG_INET=3Dn
> > ---
> >  include/net/udp.h |  9 +++++++++
> >  net/core/skmsg.c  | 29 +++++++++++++++++++++++++----
> >  net/ipv4/udp.c    |  9 +++++++++
> >  3 files changed, 43 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/udp.h b/include/net/udp.h
> > index 700dbedcb15f..ae38a4da9388 100644
> > --- a/include/net/udp.h
> > +++ b/include/net/udp.h
> > @@ -455,6 +455,15 @@ struct sock *__udp6_lib_lookup(const struct net *n=
et,
> >                              struct sk_buff *skb);
> >  struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
> >                                __be16 sport, __be16 dport);
> > +
> > +#ifdef CONFIG_INET
> > +void udp_sock_rfree(struct sk_buff *skb);
> > +#else
> > +static inline void udp_sock_rfree(struct sk_buff *skb)
> > +{
> > +}
> > +#endif
> > +
> >  int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
> >
> >  /* UDP uses skb->dev_scratch to cache as much information as possible =
and avoid
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index 96f43e0dbb17..dd9134a45663 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <net/sock.h>
> >  #include <net/tcp.h>
> > +#include <net/udp.h>
> >  #include <net/tls.h>
> >  #include <trace/events/sock.h>
> >
> > @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psock *ps=
ock, struct sk_buff *skb,
> >                               u32 off, u32 len, bool take_ref)
> >  {
> >       struct sock *sk =3D psock->sk;
> > +     bool is_udp =3D sk_is_udp(sk);
> >       struct sk_msg *msg;
> >       int err =3D -EAGAIN;
> >
> > @@ -583,13 +585,20 @@ static int sk_psock_skb_ingress(struct sk_psock *=
psock, struct sk_buff *skb,
> >       if (!msg)
> >               goto out;
> >
> > -     if (skb->sk !=3D sk && take_ref) {
> > +     if (is_udp) {
> > +             if (unlikely(skb->destructor =3D=3D udp_sock_rfree))
> > +                     goto enqueue;
> > +
> > +             spin_lock_bh(&sk->sk_receive_queue.lock);
> > +     }
> > +
> > +     if (is_udp || (skb->sk !=3D sk && take_ref)) {
> >               if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > -                     goto free;
> > +                     goto unlock;
> >
> >               if (!sk_rmem_schedule(sk, skb, skb->truesize))
> > -                     goto free;
> > -     } else {
> > +                     goto unlock;
> > +     } else if (skb->sk =3D=3D sk || !take_ref) {
> >               /* This is used in tcp_bpf_recvmsg_parser() to determine =
whether the
> >                * data originates from the socket's own protocol stack. =
No need to
> >                * refcount sk because msg's lifetime is bound to sk via =
the ingress_msg.
> > @@ -604,11 +613,23 @@ static int sk_psock_skb_ingress(struct sk_psock *=
psock, struct sk_buff *skb,
> >        * into user buffers.
> >        */
> >       skb_set_owner_r(skb, sk);
> > +
> > +     if (is_udp) {
> > +             spin_unlock_bh(&sk->sk_receive_queue.lock);
> > +
> > +             skb->destructor =3D udp_sock_rfree;
> > +     }
> > +
> > +enqueue:
> >       err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, ms=
g, take_ref);
> >       if (err < 0)
> >               goto free;
> >  out:
> >       return err;
> > +
> > +unlock:
> > +     if (is_udp)
> > +             spin_unlock_bh(&sk->sk_receive_queue.lock);
> >  free:
> >       kfree(msg);
> >       goto out;
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 422c96fea249..831d26748a90 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -2039,6 +2039,15 @@ struct sk_buff *__skb_recv_udp(struct sock *sk, =
unsigned int flags,
> >  }
> >  EXPORT_SYMBOL(__skb_recv_udp);
> >
> > +void udp_sock_rfree(struct sk_buff *skb)
> > +{
> > +     struct sock *sk =3D skb->sk;
> > +
> > +     spin_lock_bh(&sk->sk_receive_queue.lock);
> > +     sock_rfree(skb);
> > +     spin_unlock_bh(&sk->sk_receive_queue.lock);
> > +}
> > +
> >  int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
> >  {
> >       struct sk_buff *skb;
> > --
> > 2.53.0.371.g1d285c8824-goog
> >
>
> There are too many protocol-specific checks in the generic skmsg code
> here. This should be abstracted out.
>
> Also TCP also has a similar issue with sk_forward_alloc concurrency
> between the backlog charge and recvmsg uncharge paths so the abstraction
> is necessary.
>
> I've put together a simple diff based on your patch for reference.
> I haven't tested it thoroughly, but it at least handles TCP and UDP
> separately through a callback, keeping the generic code clean.

I can follow up on TCP, but TCP needs another fix, which
cannot be factored out.

Some wrong assumptions in your patch:

1) tcp_psock_ingress_charge() uses psock->ingress_lock,
    but it does not protect any tcp_sock fields, especially
    sk->sk_forwad_alloc.

2) TCP memory accounting happens under bh_lock_sock()
    _or_ lock_sock().  sendmsg()/recvmsg() works under
    lock_sock() and TCP fast path puts skb to backlog if
    lock_sock() is held by userspace.  This means even
    a simple bh_lock_sock() in tcp_psock_ingress_charge()
    race with memory accounting happening under lock_sock().

Since sk_psock_skb_ingress() is called from both GFP_KERNEL
and GFP_ATOMIC context, the simplest fix would be to put
lock_sock() in sk_psock_backlog() for TCP, which is ugly though.
