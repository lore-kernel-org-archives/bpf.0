Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F25027979A
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270763; cv=pass; b=MCOysLu6hau2GHM+xov/QHR2QpGGgLJVoBJUGabjfILqK0AEXNnh+AHCXtB7jTAmCdFvtt6XU8uVrljtuIxRlA2H27gYWoM3grQeRRh3dgSwyCkQ04gVAWIpXatkOS0RIyVwgcsAJPBvHJWJDdLYkVb6pcCt2UH18n9Xf8b1lBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270763; c=relaxed/simple;
	bh=ljYsOJ7jqnNRKK8F1FTelk1JVXCB4hRGIxbFCH/hs4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaEVA8ie2pS4AZFvIPu4PYrIbNUdCmUfXdYrDslljMIjlccB7BzsOjuekgfXzYF0i46GdyoXCmPEYOrMyM5kGJNyhl6zhxBlJPq3mdUhlZdtegvWZ4mt8LShEbYwfH+T8DC0oJfSZlmWeeMZY/ZOT0WVfF3pegi7rjY73BArC08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=srwmsTnK; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srwmsTnK"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-130c9dcbd25so2944448c88.1
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 13:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778270762; cv=none;
        d=google.com; s=arc-20240605;
        b=G7aSYUivBdSFdBVi2383ySk2OdYHjlicw6CKP2/tbS0+q2rD6e9WYcaGnp6mP4SZny
         k9bYSD9QxKMj27wK1OFW9EvZme6DIzkSl01ttTdHWNGI2Dcb/Fmvn9+k5D6Ozzc2GVsC
         h9zWkkIKkXP3IQERvZUYxys27kG8DAkjpxiZAYhIlMUCb8TIcV1aqRoiH1x71G/psrIs
         gh5WrckqrjdRhFwaEK15KZvzcrd3I9TU5ZdRlVTwhvupc6nKMlOv4u+Euze8fd2U4YLE
         7pQRK2qIx2BFvw6pIlPZfw0CKm00jcl0JiXqxuVmra+TIXVXeFly4AeqPV4/vVCJfwBz
         0ssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I0JZM/GQp10NFG/z1zCxRMzw+i+x1LWJdYqOb718wvE=;
        fh=5rvhGiiujt9AMZDCTwSpYKyt0wVISXpokdftnDXTWo8=;
        b=lOeBscd+0OiQcl0SgkRLabt+pyyfBscWoPvdLVKrR/YZQ2D0STLhgbXedbL7nwypI1
         4vBGsvWHxHye0STHAI9PGQjjqO0xITpixcgfWeJtCfauefdgH5OEmMLAbIJIxRUtdRpb
         opw+EXwIh3Sf9qMXfCIEMuwcjXl9P0EGMnzo4Dgz7Yq0T7VsQ1iQ6VkZnYs545xvV/Wy
         6Ag0yxsZgPzPH5q+JRxN2l5cfRsRi1EPCua0T/1hNdBEu0LB2s8S7MMiBjIWfZar0TWv
         j07rgEyn/LCw47hRBOTjjZfSzKGSp41CmSdS3g4UKTXcH+4vcs4YnkGzfYBRv3EdNZ6U
         rtpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778270762; x=1778875562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0JZM/GQp10NFG/z1zCxRMzw+i+x1LWJdYqOb718wvE=;
        b=srwmsTnKdZrlgUYBV3gw2qeyCBFYZA323zVBIHNAoUmECgynXUr5r4IJ0zlLkMaSHo
         y22XHknJAwdUVlcF3rc02ntPd+4TjS1+KWbSURVKxw6i/idiE/LmQsR3hfz9KAXzHHfx
         pmDf3FtgUgJ9bZCXEMTOI5mZM+qy3Weu5hZQ5MoQuKW3fTI3m/QES1QQEaHzg9eoawy8
         BSKYZdKKMKWuDDAIULmm09tJDwooWRFjfAN8oR8HRoAymv6s6QDp57a9U3HGUCmatQ2q
         L5QS6HbKMwqqdv8Zdp/EaXKAj/0hF/4EPd7eR27erktefKOu2kblED+NsUV68xtGHZER
         LGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778270762; x=1778875562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I0JZM/GQp10NFG/z1zCxRMzw+i+x1LWJdYqOb718wvE=;
        b=YwO1zaSND3VGaOPBAkjubO7AzCyL/ptpBamk0JQkNucXhj8N5L0sJKTayhI9tAQ+NJ
         1Wiv4fRH8A9Sl9BCLmHernk37jnuIZL8meeJt7rqP7ugjss88j76tP9Yckf43KdX+Uqm
         bLFK1mYQzlV2/KXoKGpjbEEc9XDeOONoYtzH/JcmoeXGwkixMs/yVXBlWeYMpFuEGqeB
         Fy2in0CdEF2dBXXHz5G2Zi8KoYyqyskmnJkAO+5Jh8ZjbdPwdk7gQD4hJJCEK4hspsPE
         Di5Nwj20Cv4L+PJObkjDOwXEvwYcFVxDsvqLgVKbKVgpHs//yyXROfEFbN/emgg7MRwx
         I5BA==
X-Forwarded-Encrypted: i=1; AFNElJ80aHmupz5c4B9BoeJMSFh8uu7tZjDjjkV2jK2YpXlZ3b4SURG4rYyT803JxAJwiUDtf3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH67nCAC2gxE4YPZ49JbIs1HtfK7bofUZZT6xO6PwLdfz3Ix0h
	vCNRN6wdc7PdZWXxT4rheQoT56Z+//b/HDXzAYG4gEHvL48Fp36vdY3HFL5j+/DIzuAHw/4/vDa
	fdjVNQb4PV/E/4Sxz0djaDNUmPohvznMk/WD72IF8
X-Gm-Gg: AeBDies2msSBvMMXkU/zCbVHOXVLGzm001EzDzAt2cjjsyISRMCDE7xE0fiq+XxyXA+
	D1MY/sAU/6NMNIGx2QGH4bbX1eArSeNrUBCE7HTCVVSMarsyOLJgLeT+sLvHNlCQ0/W6UxQFwuK
	oj5SQuqewBuCqBmw5sSuhyftOGE8j5cC5mVGFVsnUrUSmgyq4RjpdXuKH4MClpfhfk9rMKxXbPN
	pP3piK988TDV5Rz/6Olbc9iT6kMaZXaZTcbypLZqJ5kkZAxpqanXAo6L6gDAd1hIIdv67Oe++DZ
	dhM9VK9sSsLWXXs2QUTPajluu2ZVhyKMuKuRgjrZqOh6YSwS9FcjrnsymYpgPeKqvOsjcrk+7oa
	bqhbyMEzqeBdTCyHug/sQOu1haFtOY8I=
X-Received: by 2002:a05:7022:6628:b0:12c:91ef:6e63 with SMTP id
 a92af1059eb24-1323ab647a9mr3606912c88.7.1778270761051; Fri, 08 May 2026
 13:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com> <20260508073355.3916746-8-kuniyu@google.com>
 <af4AO2-9jwluWuik@devvm7509.cco0.facebook.com>
In-Reply-To: <af4AO2-9jwluWuik@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 13:05:49 -0700
X-Gm-Features: AVHnY4KxyF7PmxKzfFRoR9wPAhtUQEb5E2m1xogbHPUGkBr3Dc2h_5gVeNU3EmI
Message-ID: <CAAVpQUBTbcpf+kNOqXj-2=Qjx86TeZ-sHVGKT-Vwj=GVXz4hEA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 7/8] bpf: tcp: Add SOCK_OPS rcvlowat hook.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 8:28=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> On 05/08, Kuniyuki Iwashima wrote:
> > Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVLOWAT_CB.
> >
> > Let's invoke the BPF SOCK_OPS prog when
> >
> >   1. TCP stack enqueues skb to sk->sk_receive_queue
> >      -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()
> >
> >   2. TCP recvmsg() completes
> >      -> __tcp_cleanup_rbuf()
> >
> > This will allow the BPF prog to parse each skb and dynamically
> > adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
> > until sufficient data (e.g., a full RPC frame) is available
> > in the receive queue.
> >
> > Note that the direct access to bpf_sock_ops.data is intentionally
> > disabled by passing 0 as end_offset.
> >
> > Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
> > with bpf_sock_ops because payload is not in the linear area
> > with TCP header/data split on and skb may contain a RPC
> > descriptor in skb frag.  This also simplifies the BPF prog.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> I was reading the series expecting to find some skb_queue_walk-like
> implementation, but since it's a cgroup hook we obviously don't
> need to do that.. So at this point BPF_SOCK_OPS_RCVLOWAT_CB_FLAG
> is basically a "rx queue skb" hook, right?

If recvmsg() hook w/o skb is not confusing, yes.

> So should we make
> the name more generic? There is really nothing lowat-specific
> here besides your new kfunc to read the payload?

Do you have any suggestions?  BPF_SOCK_OPS_RCVQ ?


>
> > ---
> >  include/net/tcp.h       | 14 ++++++++++++++
> >  net/ipv4/tcp.c          |  2 ++
> >  net/ipv4/tcp_fastopen.c |  2 ++
> >  net/ipv4/tcp_input.c    | 10 ++++++++++
> >  4 files changed, 28 insertions(+)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 4e9e634e276b..003e46c9b500 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -737,6 +737,20 @@ static inline struct request_sock *cookie_bpf_chec=
k(struct net *net, struct sock
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_CGROUP_BPF
> > +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> > +
> > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *s=
kb)
> > +{
> > +     if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVLOWAT_CB_F=
LAG))
> > +             bpf_skops_rcvlowat(sk, skb);
> > +}
> > +#else
> > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *s=
kb)
> > +{
> > +}
> > +#endif
> > +
> >  /* From net/ipv6/syncookies.c */
> >  int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *=
th);
> >  struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 1d9e52fc454f..80144b97a87a 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copi=
ed)
> >               tcp_mstamp_refresh(tp);
> >               tcp_send_ack(sk);
> >       }
> > +
> > +     tcp_bpf_rcvlowat(sk, NULL);
> >  }
> >
> >  void tcp_cleanup_rbuf(struct sock *sk, int copied)
> > diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> > index 471c78be5513..91bf421fc5b6 100644
> > --- a/net/ipv4/tcp_fastopen.c
> > +++ b/net/ipv4/tcp_fastopen.c
> > @@ -281,6 +281,8 @@ void tcp_fastopen_add_skb(struct sock *sk, struct s=
k_buff *skb)
> >       TCP_SKB_CB(skb)->seq++;
> >       TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_SYN;
> >
> > +     tcp_bpf_rcvlowat(sk, skb);
> > +
>
> I'm also not sure about the particular placement of some of these..
> For example here, why do it before updating tp? Why not after?
>
> (and same for tcp_ofo_queue)

Basically, it's to give the same snapshot with tcp_queue_rcv().

For example, if you call tcp_bpf_rcvlowat() before updating
TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF
prog will need to implement an unlikely if branch to strip SYN.

Also, TCP stack can queue overlapping skb into recvq.
Once you update rcv_nxt with a new skb, you cannot infer
the previous one from skb->len.
