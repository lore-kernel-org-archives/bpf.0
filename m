Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1363C2782
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831490; cv=pass; b=qX3MuzsD1/Y91523WZUocxW/2/VC1EMbasd3bV+yvU858SEnuqr6iGFAtNSW8FhvEmFXITU0evYap9jCL4nYT5hNQXSYvthR65dJhUVhxyHfRjxvwblw/u7JE4EwR+JUORGI15pIIq1DblTKmLIdz/hVWpqCYSgPt9QRHbPIe2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831490; c=relaxed/simple;
	bh=gQmyYwdEAcIENiu0zTOso9kcSPefm5PuS5PM74wbhT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cqz2tyFO5PipF3vU/52ZtB6DUx95YsFoRjc/DLxkSdH0OdA2mZGjF2djy4Hki899gU9q4TTDTnkHOeTmGVZe6bj4APHebtQzBd1pwuk7V05nPysWr4EzU6veV7GoBvMKuHTyKdi/+/kJ4fLV+xGuzzHWOX8t9H2SwiLeXcviwk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoS3fOcT; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoS3fOcT"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bf1eaba464so103095387b3.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779831488; cv=none;
        d=google.com; s=arc-20240605;
        b=duPGb9p+a1ruBiQ9UoNQ3CU8k90ksHNNfbKmiYHP1i8DsEed6S1XEqRvGZ6npQk5V4
         kJu+N32Js145qQI0OxamXUAy7zB05kwCufo2AoexJyqeLwZsHClCL30phiLG7ddv54wz
         Y5FrU3yLLqyEPsBGLi6MOIcEA7P+yGZ3cgaJ+vvgbCkn9PtUDx0NkB7InPURmBqtO9+q
         x3YYKwaw/yDZKueobXOA16bJ1iYvJr9CG/PHG3s6MlsC4dKxh/XB0UCRWHDN+xtmsGPX
         RuSgNH5C0KCIAH5ujrE1zl7Ehvpy2v/E/JaO6HUiCvAub/L5sU0VEcz3gjtb7l2wSko+
         KuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=plsnEEQSbhGV7QIIM3FErJsIPshK6pJB+M+smdqUF88=;
        fh=sw9AHaaNn9JxtEE5v6foVhYeLsStPxNaSSnbthRY8Vo=;
        b=ISJCpMwNi6meGYCZLt+/2KWbk8kEqgBwBOXl0abncaiI9jHGjJtu0owqv4W//Hrpw/
         QCuDksF0heAdS+wDxWIXXe5+kvX+sopTj5CmYWY9Vk/FLrsntnyKoaz4dc/2jKhelJJ3
         pY3lA+cFFlhz7Eypxk4pCRHnOBb62IENeWnJoXT/l7x9OsFmbzdekRKq34aPy1cf4hYP
         6hL6xqZm4hSLqw2NJR3QpMUL6QSnteyPhUoAOpJkgXzWSrOuRqfkbCjj5eda7r7WICMu
         HQnrsUshu3M7wINkp38zu4qobxqWcKA/QSWf+iCXD4CX2Bfz7PVQ93bFGhXcC3nlyA1I
         /eXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779831488; x=1780436288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plsnEEQSbhGV7QIIM3FErJsIPshK6pJB+M+smdqUF88=;
        b=qoS3fOcT+Kilj6RF0WwWg/mV2zmYIvMUS75gdxNAgwP9jMbsInIdpZpRpxxH2t74G+
         n6dRZUAmNvMVZn2lz2E4y8OUeoqqWzGsc6ZRraUm/vbM1NbHG/kIVpCTEi4L1nkFFFW4
         /3pqQr839b86BPuES79FSlwAo45/wAErvqEN3YRXzxpT/viJ+0Rglrkyb3eiZV0XRFqT
         I3y4yB10ePbyM2xRIjeUbqKwv1x3gRvBoknLraUE8Ff3CPpSqdt/1sbIeUh8lv6DABhJ
         bfRvAswBeJ9JZEwYKWtt6W4whxJJ7qxfkvVFymgY96AijisrO9iItcRGZBvXsfdkNi8G
         L+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779831488; x=1780436288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=plsnEEQSbhGV7QIIM3FErJsIPshK6pJB+M+smdqUF88=;
        b=pffcEHZewBBllxY6pofewxU6Wu2OBtinNGIRDWQrIySswyoLB4gASFSe616GsJKo1v
         66FjoUCC6z6rBE/9zICKV1AR5690HhmS6OzTtMpmbI8uoj9VfeqccLx9DOLEJeWhZkEQ
         st6ik6qQN5T3lNOTW0vvdNId/tbwtW/8enDS8KkTWXu1UPXZVdahNCidk0fA7kjsGctC
         amb1kwhhmXtISLkZB1rI8y+HbhUxv5gNaDgEXvbR4szF5dtVj2IdMhaKQbetJU435dib
         jcTLKqCHO+DLIBWVyTXBIJFTK3acVGR3dOKjoAeSNA1WD7/xv9NRUuJAMM2adDmHgfhw
         KT+Q==
X-Forwarded-Encrypted: i=1; AFNElJ93+IuvAMBxCh/VWE8DTakWKeRWLCYUdJ4GpHtdAU1grU/dqeN7jouUYeBOwysSQe+v5BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBs4ZtbwGiiML1b+h/M4+IUgwfOPuNd+Gfr8thtQu+SlToRohZ
	XoyBcBMi9/BVEMOXD/I534JeiAecfz08gx7rImLtWzPK2ad6qV3mA2wywgS02+jQD8Svucrmnza
	Bn21WlSCR9JHNFcKIcLT5dmS7vcrONgk=
X-Gm-Gg: Acq92OEj1D2GWlrLj+3wJqEfNSxwIEkvH+1VAVzUvyPqfTumUtCuepT6bLPITfXiEht
	sqbHbrMSLi986ZlNi/x0aLuzJNtG+q7bLKalZR6AJ8rPLJET/pI6e1W443X0UTnLUx+8lneFHm5
	IYpSt4/4RI7mmbWOKp0zHSkBuhLu5LuD6KZsdK2cHUoO8Z1sz9T/QHPRs61AxzKachrKd87rDDv
	+bHdMEe6WXnD4RNm/3qn+4gOaBpTBByjL4z6cJwJOsp+m5R2HvCBAp61XrDJNMplmDNYZNp8Z/A
	z6ADTheDyAtJpfKCxSLneOQ/qqnBUu80Jg==
X-Received: by 2002:a05:690c:c9b:b0:7bd:7e01:8d53 with SMTP id
 00721157ae682-7d3346d3757mr218203377b3.19.1779831487577; Tue, 26 May 2026
 14:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com> <20260523083001.2911931-11-kuniyu@google.com>
 <202652620435.m7WK.martin.lau@linux.dev> <CAAVpQUCd_eDq2nVz=um3T3iR5x7dSX1Rpi1YVTF0T5j16ok95g@mail.gmail.com>
In-Reply-To: <CAAVpQUCd_eDq2nVz=um3T3iR5x7dSX1Rpi1YVTF0T5j16ok95g@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 26 May 2026 14:37:54 -0700
X-Gm-Features: AVHnY4Ipdo3k_ItI27qeKZBIuTXC9Hu2bKBcmkqQ2o_TZi6eAv02HLrwRwcDsw8
Message-ID: <CAMB2axO6PeJOLWCfyGp2pq+2t8D8evEb07HgEyyw8qHG5TFGxA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/11] bpf: tcp: Add SOCK_OPS rcvlowat hook.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 a

On Tue, May 26, 2026 at 2:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, May 26, 2026 at 1:47=E2=80=AFPM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On Sat, May 23, 2026 at 08:29:39AM +0000, Kuniyuki Iwashima wrote:
> > > Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVQ_CB.
> > >
> > > Let's invoke the BPF SOCK_OPS prog when
> > >
> > >   1. TCP stack enqueues skb to sk->sk_receive_queue
> > >      -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()
> > >
> > >   2. TCP recvmsg() completes
> > >      -> __tcp_cleanup_rbuf()

Not sure if this is just me, but having to differentiating call sites
by checking if skb =3D=3D NULL seems a bit less ideal (feels a bit
arbitrary and may be restrictive to extend in the future)

If new sockops is going to be built on top of bpf_tcp_ops, it would be
more obvious as different call sites will be different struct_ops op.
Although arguably tcp_queue_rcv(), tcp_ofo_queue(), and
tcp_fastopen_add_skb() may share the same struct_ops op.

> > >
> > > This will allow the BPF prog to parse each skb and dynamically
> > > adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
> > > until sufficient data (e.g., a full RPC frame) is available
> > > in the receive queue.
> > >
> > > Note that the direct access to bpf_sock_ops.data is intentionally
> > > disabled by passing 0 as end_offset.
> > >
> > > Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
> > > with bpf_sock_ops because payload is not in the linear area
> > > with TCP header/data split on and skb may contain a RPC
> > > descriptor in skb frag.  This also simplifies the BPF prog.
> > >
> > > The placement of tcp_bpf_rcvlowat() in tcp_ofo_queue() and
> > > tcp_fastopen_add_skb() is chosen to provide the same snapshot
> > > with tcp_queue_rcv().
> > >
> > > For example, if tcp_bpf_rcvlowat() were called before updating
> > > TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF prog would
> > > need to implement an unlikely if branch to strip SYN.
> > >
> > > In addition, TCP stack can queue overlapping skb into recvq.
> > > Once rcv_nxt is updated with a new skb, BPF prog cannot infer
> > > the previous one from skb->len.
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > ---
> > > v2: Add explanation of tcp_bpf_rcvlowat() placement.
> > > ---
> > >  include/net/tcp.h       | 12 ++++++++++++
> > >  net/ipv4/tcp.c          |  2 ++
> > >  net/ipv4/tcp_fastopen.c |  2 ++
> > >  net/ipv4/tcp_input.c    | 10 ++++++++++
> > >  4 files changed, 26 insertions(+)
> > >
> > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > index bc95d8e7b62e..a409f2ea710f 100644
> > > --- a/include/net/tcp.h
> > > +++ b/include/net/tcp.h
> > > @@ -2889,12 +2889,24 @@ static inline void bpf_skops_init_skb(struct =
bpf_sock_ops_kern *skops,
> > >       skops->skb =3D skb;
> > >       skops->skb_data_end =3D skb->data + end_offset;
> > >  }
> > > +
> > > +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> > > +
> > > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff =
*skb)
> > > +{
> > > +     if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLA=
G))
> > > +             bpf_skops_rcvlowat(sk, skb);
> > > +}
> > >  #else
> > >  static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skop=
s,
> > >                                     struct sk_buff *skb,
> > >                                     unsigned int end_offset)
> > >  {
> > >  }
> > > +
> > > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff =
*skb)
> > > +{
> > > +}
> > >  #endif
> > >
> > >  /* Call BPF_SOCK_OPS program that returns an int. If the return valu=
e
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 3afeb69a547a..f7e32891bb4e 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int co=
pied)
> > >               tcp_mstamp_refresh(tp);
> > >               tcp_send_ack(sk);
> > >       }
> > > +
> > > +     tcp_bpf_rcvlowat(sk, NULL);
> >
> > hmm... so NULL is a way for the bpf prog to tell where it is called?
>
> Yes.  The selftest fetches bpf_cast_to_kern_ctx(ops)->skb first to
> check it since we need to access skb->cb anyway to read
> TCP_SKB_CB()->{seq,end_seq} for non-NULL case.
>
>
> >
> > With skb NULL, what does the bpf prog usually do?
>
> In that case, the prog reads tp->copied_seq and some sequence
> numbers from sk local storage and calls kfunc to adjust sk->sk_rcvlowat.
>
