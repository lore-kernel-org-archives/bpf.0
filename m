Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930913ACA5F
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239845; cv=pass; b=X3bJMV+vOwHxzXwZr0mKsl7pjJxRl43HwmYX0a9JMfnj61HHk/tm6F8h8RK9Hqnh/M9o6oghW4PN3uApGpSesO/zgWB2TZMSGdyD54IpRHWVGcmG6ona/Y9V1/yo/7QEVPrJ5ZS61P/B4bn8yWMaq/8X4ysYckWslbCpoBaCElQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239845; c=relaxed/simple;
	bh=CBfD4iRTH3E14SN4QEqZr0RaBqNvQko8KctGms5BCcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rF+rIW0GBgB0S2oGuhttHxp18YevTNgdwLcfRTgsB4yUHeULVWXFOyDwWOEg5TG0rRxPeK3//YTF4NP0cMPgaDI69MVq8prn3bS+vwZ35rtu9SaU7qIvZRv3X/6F1JsncVSELOx/uJ+ZDJmkL5fnDlKECBBiaKO1Dm0hmkGNIy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EfxAoXh7; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfxAoXh7"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-130b2295ed0so5574453c88.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 04:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778239843; cv=none;
        d=google.com; s=arc-20240605;
        b=jS+n1AUrq3szSm9Ko3IMv0GnA6sIZ/MeMWfgkJhtjnfIpvZOIcqgy4/VVvdux5jw3a
         u/fcP6Z+rrNsLuJNaPCQRM2yM4+nQga5zFbN9nn7PG3KakabjS080tQogvdk6TXuxdUs
         Pwp6BoTc8DVUTEUDvn+NPESZgyfISfMJoUiyysVm9bkSHB4TBN9acaHHkReTPS39+C07
         hW1AQ+vP70jESRaqQ3FPx+v9FLVtTjwSsbrCSiCyRdF4XW3drhHcGm8xlmTK/ejZ9Gb8
         jI6xPLH+pP/AfhX8mkipZsUOMZ8O/SpHFn2XXE1JkJAJaAJnXu9S2RRkxqn1nqVv/0fr
         Uq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kv/cN9JZtLINOz191VE4jyOuiPMT2DphC53i8RZ2MOk=;
        fh=rjdmRj+rDKzF/fCGUcuJ4P9hiwXZwpk8lCQJxTTyhfI=;
        b=PJdo8OToqvjbLSxbhNreHYOh5B+iMaBNLgHyeZiHw1PsRlu4EpJkc5PVLSOg6ZIiWA
         0KrWC5+jrdGFkvI/FB66M6xQ2o/6RtJ+wo+7Inl+z7TLB/fmuNL/IdOdg9InFQTMg90P
         r34LzG7l2RI3h0xXJ+873qXZeIpJlyShsOfR4celHXoQiiiZD08SahH+Uai1qCPkXfze
         qtue3NaOMk8AaCdmojE2LpBJqHFoGaOKNpf7anwkXdi1rStP6TBemqJ8f2jO68oEyCob
         WJb/z1yTdodkRXZlcV8W/bF8axQ0BzfQFYEPfm+50QIYhokw6yLdO32QXHDmVS/sXnmY
         rHtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778239843; x=1778844643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kv/cN9JZtLINOz191VE4jyOuiPMT2DphC53i8RZ2MOk=;
        b=EfxAoXh7ZNOtZ6fsyUbKJw/95kCMKcIxREmjyJPpXIiq+mlMYp2pxPmOR6ZCo1HPRj
         mLsQWvTT0Gzw5M1SkoogzpkXAWuzy8suTdtJ6aCaJEhj7xQvtzuRImY88cpioQ78Rr4T
         Pfc2T3cBxktmn483+6lI+1mw895pJVD8ZCbF9KPCoQgr9EYPxNmpb+hRcZnnvz645EfF
         ROYyMDKOuouoTr7ULEjsx9MC7A9ZGtaIRiAu01eW7VVx1ut2F+dMSxJOielhAVNotbvg
         YfXOm40wyd4eX5SbBMjcpU3OV4m1kwp506glgSgxMmPTyUVW4golxWdHy16cvPt0/kAP
         4o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778239843; x=1778844643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kv/cN9JZtLINOz191VE4jyOuiPMT2DphC53i8RZ2MOk=;
        b=NTMsgPrdmXqKMOJVqlldTHUSgMoLP91hYAnLteKkpr4Wg20a+gBjTj5+zURBHNsZCL
         YoY3lnT660YUxaH/Ih7ibxXFfwub4wgzPhmM9z27qpPs42WXWzuEJ7m+axPMAj548Z+x
         xxsFOIAOyi3MYt+/3FsyZhxLGY1Ust3sLonRigGgsatbjwMPwumuujATr4pskZx4LMFb
         Mt3PZXA02+TA1Z38qxkX5yCzgSAKvSbX5Xm7OHI/8iLN+4s+qrsePcGLFkbryEkQd6gg
         nhfRyb4bNc0Jule1jZ2S0rshjWRr9iOhJXX+6aM0Vm+VPms5JdtQhmAZtZLHdTwpveyY
         MYkA==
X-Forwarded-Encrypted: i=1; AFNElJ9IUkSjfoGN66aUCgcQHdMPUOwbxyPEKDPHvFK5MWC/iqMSsPIyowh9x2ilQtSfmqcnwEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz85uRbx1v/ySUgk1XDloQjclrlqAm62ZgUN5H8FYJowpcXy3jZ
	Sg5uc8jp/t9vwFUasdsz9BVsUK14HDXQAR5hX8a+TbJpZEDor71bNq6XygViveNBX6YUH6MQgk0
	xOmHwQ+2Qlq/m16BkH84fhp17eXCgNic8umA9hjjQ
X-Gm-Gg: AeBDiesZM5AxTiUwRSYG1lzOL9P0De/o3yiw4m0Xo00S+w42vA5c3HvRY3/If4Z1QRz
	6vQPlRd2m2UilwdgigmaLq3MUnW1L+kGN9U9D3zWsG+GoAk89RePa4WU3hBUZCty8ru8PZgZTlD
	XHsEh2tE+iG+xs+cvlQMu1/PniGNRj7EHLJMdzKGAT5iBb40pRlkaEKU7r29+N7+9Ioe8sqr5r0
	p7CKILUteMoZcNopiYRKelo2L9HJqjUWowafkIQnLVQ/RlTWbGJcQjW3H8VUx2C/ZNnOFNSeIsg
	NnaHYzKasM+8KygVmOT9sj0VIAN78ELvVb3KUtdIyhK1doGn7BRZv+rW1AkktMyt/LziFEdKKgm
	NNlLFjGDPm9wQZISEqVEtq84RsI0fg2Q=
X-Received: by 2002:a05:7022:ea24:b0:12c:87f1:f41a with SMTP id
 a92af1059eb24-1318e91771bmr6366203c88.21.1778239842029; Fri, 08 May 2026
 04:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com> <20260508073355.3916746-8-kuniyu@google.com>
 <21ee2d5d-fc8c-497e-aa98-e5e4e3fbecf8@linux.dev>
In-Reply-To: <21ee2d5d-fc8c-497e-aa98-e5e4e3fbecf8@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 8 May 2026 04:30:30 -0700
X-Gm-Features: AVHnY4KkzSQ5bG2E11JHf5_h3yq1P29unHw-1nEvdIdkT055s-AbAypVF74WclI
Message-ID: <CAAVpQUBv0Uc4Xi-4wK2S63FqtXHHkLqJTotOxxDyhqFknoZG_Q@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 7/8] bpf: tcp: Add SOCK_OPS rcvlowat hook.
To: Jiayuan Chen <jiayuan.chen@linux.dev>
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

On Fri, May 8, 2026 at 3:37=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
>
> On 5/8/26 3:33 PM, Kuniyuki Iwashima wrote:
> > Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVLOWAT_CB.
> >
> > Let's invoke the BPF SOCK_OPS prog when
> >
> >    1. TCP stack enqueues skb to sk->sk_receive_queue
> >       -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()
> >
> >    2. TCP recvmsg() completes
> >       -> __tcp_cleanup_rbuf()
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
> > ---
> >   include/net/tcp.h       | 14 ++++++++++++++
> >   net/ipv4/tcp.c          |  2 ++
> >   net/ipv4/tcp_fastopen.c |  2 ++
> >   net/ipv4/tcp_input.c    | 10 ++++++++++
> >   4 files changed, 28 insertions(+)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 4e9e634e276b..003e46c9b500 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -737,6 +737,20 @@ static inline struct request_sock *cookie_bpf_chec=
k(struct net *net, struct sock
> >   }
> >   #endif
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
> >   /* From net/ipv6/syncookies.c */
> >   int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr =
*th);
> >   struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
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
> >   }
> >
>
> tcp_read_skb (process frame 1 and __skb_unlink)
> =E2=94=94=E2=94=80 sk_psock_verdict_recv
>      =E2=94=94=E2=94=80 sk_psock_verdict_apply
>          =E2=94=94=E2=94=80 tcp_eat_skb
>              =E2=94=94=E2=94=80 tcp_cleanup_rbuf
>                  =E2=94=94=E2=94=80 __tcp_cleanup_rbuf
>                      =E2=94=94=E2=94=80 BPF RCVLOWAT_CB
>                          =E2=94=94=E2=94=80 bpf_sock_ops_tcp_set_rcvlowat=
 (wakeup=3Dtrue)
>                              =E2=94=94=E2=94=80 tcp_data_ready
>                                  =E2=94=94=E2=94=80 sk_psock_verdict_data=
_ready
>                                      =E2=94=94=E2=94=80 tcp_read_skb (fra=
me 2)
>                                          =E2=94=94=E2=94=80 ... =E2=86=92=
 tcp_read_skb (frame 3) ...
>
> For strparser it use read_sock instead of read_skb and it will become
> more complicated...

To be clear, this feature is NOT to use strparser/sockmap.

>
> I think this will cause stack overflow with amounts of skbs in receive
> queue or infinite call(not tested) for sockmap/kTLS/strparser.
>

BPF user is responsible for not doing silly things.

tcp_bpf_strp_read_sock() can have loop detection logic,
but it's only if really needed.
