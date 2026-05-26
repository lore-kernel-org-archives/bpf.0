Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6DC3B4E9D
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832285; cv=pass; b=pFyaUoeO3+5qIJQVRrUt7LbpJdhma766QWLpBAWrbSHPb2FP3W4KOue4csiBvxnNjSFeCcsehNJuscPFhSKLsS/xSmN1bg/o8BWDAxKPvdwLJYHbfCe6zmNGOCAq2Wa5+K63BTNMu450EP1uvinaY5aNrRzaQ0MnWjwrb1CN8qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832285; c=relaxed/simple;
	bh=AoeM8g6x9IYVveJxQcTNP3LqVXcO3jwkZgfHAxvHIsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQADrcznQtnubK4+qlOcktMe8JTzmvtP/cw9Bf6GZaYRwOR3BV0t14zMEHPiS0WksILBDaP7PIfwLcV//Sc7ObeM2jsvzt0zxcp7hwP0amN5S+kAozot1HdJ9ifG/K4HDJn7108wVi3k1qrUurOGQ18MsYU7wVF/zUIdH8gw0jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMslIW7Z; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMslIW7Z"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-136b46c3540so3422264c88.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779832283; cv=none;
        d=google.com; s=arc-20240605;
        b=Kw7dcgZHFyApMTw11QzLAcPbLhZoaepLL5B+dPxkdu5N5zVex30khO2TJVAwbcaFPz
         LfZFqOpy57SQ8C3EJpWyaGzaAR15d/4h1x7hyKcj5nym3SizOqk/W+7Rg41klPfD6WIh
         85QCg4sQtFT0MXl0oayINMtvRppgdJW3TisornN0OrfgLxV9AQSBdGef6PgaiP61+s7v
         QousOrMLlvTAom1B8emoRn6nZF4ZIeyArljw3dAYd8fYvuEL8I5oApYYZL+8bVl5m6O2
         W4wIJQvixlkq2ZWnH35ed7hQWIiMt06JcEjoYWJELX1KWMtXVA8Qa3wSdb5nLff8m7DS
         qYFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lQqGVBd+cocCt/UgJ7d/2rWN5gR8Q6QOgQJb5mSWO2g=;
        fh=Oz48oXM6l/VMqe6EbDFnSWfJEERTAqj5arzIMtcmr3Y=;
        b=ZiK8y+39dVQKqmpBB2eW3q1zJxIgJrvXhNVS8VADjsIXgxsuh4vDhrJMDOhGJDZkE1
         HnsrzDJuXTMC5Otf2rS/XRUxv6mkByci2MnAj5DYtNGgy65HCtWE+uhx/oojQQ9EIjQ4
         /R6kY1NX4CLRWCf4z58UG1vpp7+oUmyeVGiUD/5gaK9RHVWYFYg1eo+yCJ4pbLLGQscc
         Df++7bOaofZC164j2iDUN9Mas3DQJGdlSYQTllRIGNmK0MdE7FH1bnYxnm6M6kDuGE/C
         iubqgZBszJPFY13M3cxOLcFe0UO/OCuVHm2Qbq90Ksa24daSrkCTrloW7uaPJqCql9WT
         v4vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779832283; x=1780437083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQqGVBd+cocCt/UgJ7d/2rWN5gR8Q6QOgQJb5mSWO2g=;
        b=bMslIW7ZZJj2nSeKaadqXJ21FpiidiBHbzcB4uN/zIutrYKYJfyasqi1VO0MuF50hA
         zg2BvIVI6dnym0WixNMalMBHgiQmvBjaOdgsDehv8z/aBbNBne8nV48DsN0fdSs3gXJu
         lx7vCtgOEA/hdFKf5TDWg8A73aff3GDTZKZohhanRmVr2l+uUQbw9oTqiwXJf3dilTlH
         VGPEvp+ecavySCh8c0VDkhdJ1DO/G2F0rlFGwMYZIWxGOWXM76NwBFLHLobkx1JYpTKv
         vsVmJTKoq7gTNbBIwWfkb3peDRfZCiKmmL1yzjUkpDDO6kfa7tD2+cigI0QEds8jW0Zp
         Khjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779832283; x=1780437083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQqGVBd+cocCt/UgJ7d/2rWN5gR8Q6QOgQJb5mSWO2g=;
        b=CGXttpG4ZXVn9aOKmV/ubSLgxhByFyTGorFsfmQNu6cu/+MEhgPgfKZ2HWcs8xFHgO
         pqt3CHwRhSplSZmZ1ITSTerGnZY5a3vm5PulKMvcSApSgUFLpt5PFVyOoiXzxEBDhRDG
         cXsMju+bnbnQ4qVyWmNCsUZMmxbnLn9FCutKZpvCzJ+jAu61ICfkpfiUbsDED70ELHMJ
         iqlOI88N/IenBRd6qPkNRNWPlB2jgMPsS4nUxG4HvzU9Yr9CvltfBUfc4d+HgL0X0PXx
         THf4KA17dj1beCgdALkhbv24kWsVdB6uKhNfT5+gt00YG899icojoO8deRjfT6Uxtdt0
         jIqA==
X-Forwarded-Encrypted: i=1; AFNElJ8i33GhEEjIQLEt5q9FJDN+HOU8n/auR/kG5ai3HaoRQCinUUNujqQrO7alIyk2Y+wzOyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpNq6XroFn/YZ+HM/wbpcGOH1rrEaMaKmOk7bsv1AZjH4pU45S
	chlMdp3rdbWMA9S9FlYUlG63R2pfng0MQZ8wXjPa16+yGyxlFGusKC8qWP0yc81upcJ+6yaaIHj
	cp2c2CIWZJL4fvduA1X7jrj5aqr8SGHYcD65rVhKh
X-Gm-Gg: Acq92OEdEv7bcz/Oc+XQlAoQIbAdQSHfNnhEKcjcaHfg/WhIQ9h03rqnA2H5h41CT4t
	iz7ZW51FnhxDkU4JApZRROYhOFXWaGEUL6AwPeK9uhjFbGyflobSZ8jxXAvThUz6W9q/hkKHl6b
	Mxq94uvYVWoI+JHGEXqfSO+CQ3DTjgPfQDtSA2yLNgryoFw2nSNOcFDL5Dfxued9zhd0gBVFa1p
	f40L1yL/PaXn7gJx4uIh6DhuiI7QvPiNtkIrwyulinG5mcCDvAO2UdhFmWgIBlBX7R9jD1KpJud
	MbiGWsu6/mfnQ0wsACn4Ff1nV26SC4odB2PMxYOeIy8re46XHuJ14HJMVMKA2eFlxm+JJs2N0xW
	kNkYsWlsjGiJ9D+LKnkhhxCG4NoFIpCTOneX0N4VUzbofobW+A4KWN8kcymgGTeK+8SVYgm4=
X-Received: by 2002:a05:7022:1a81:b0:132:6877:eea with SMTP id
 a92af1059eb24-1365f819092mr7112298c88.12.1779832282746; Tue, 26 May 2026
 14:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com> <20260523083001.2911931-11-kuniyu@google.com>
 <202652620435.m7WK.martin.lau@linux.dev> <CAAVpQUCd_eDq2nVz=um3T3iR5x7dSX1Rpi1YVTF0T5j16ok95g@mail.gmail.com>
 <CAMB2axO6PeJOLWCfyGp2pq+2t8D8evEb07HgEyyw8qHG5TFGxA@mail.gmail.com>
In-Reply-To: <CAMB2axO6PeJOLWCfyGp2pq+2t8D8evEb07HgEyyw8qHG5TFGxA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 May 2026 14:51:11 -0700
X-Gm-Features: AVHnY4J3Rs6sv4H8De29931zUN6J9wyMHkX5s4zEmvSh1A9Ll-gZnC3sgGqG_jM
Message-ID: <CAAVpQUCSWkMd-_FBqHe6sO1gEmuyS3twv65Rb45wc6-4PsYUEg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/11] bpf: tcp: Add SOCK_OPS rcvlowat hook.
To: Amery Hung <ameryhung@gmail.com>
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

On Tue, May 26, 2026 at 2:38=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
>  a
>
> On Tue, May 26, 2026 at 2:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > On Tue, May 26, 2026 at 1:47=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On Sat, May 23, 2026 at 08:29:39AM +0000, Kuniyuki Iwashima wrote:
> > > > Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVQ_CB.
> > > >
> > > > Let's invoke the BPF SOCK_OPS prog when
> > > >
> > > >   1. TCP stack enqueues skb to sk->sk_receive_queue
> > > >      -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb(=
)
> > > >
> > > >   2. TCP recvmsg() completes
> > > >      -> __tcp_cleanup_rbuf()
>
> Not sure if this is just me, but having to differentiating call sites
> by checking if skb =3D=3D NULL seems a bit less ideal (feels a bit
> arbitrary and may be restrictive to extend in the future)

I think Martin shares the feeling :)

I chose the way for two reasons: 1) bpf_skops_established()
already accepts null skb (for unlikely TCP_REPAIR_ON), and
2) adding another op just for the case seems redundant (it adds
more conditionals in the fast path, kfunc) while bpf prog is capable
of distinguishing a null skb.


>
> If new sockops is going to be built on top of bpf_tcp_ops, it would be
> more obvious as different call sites will be different struct_ops op.
> Although arguably tcp_queue_rcv(), tcp_ofo_queue(), and
> tcp_fastopen_add_skb() may share the same struct_ops op.

Yes, this sounds fascinating.

>
> > > >
> > > > This will allow the BPF prog to parse each skb and dynamically
> > > > adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
> > > > until sufficient data (e.g., a full RPC frame) is available
> > > > in the receive queue.
> > > >
> > > > Note that the direct access to bpf_sock_ops.data is intentionally
> > > > disabled by passing 0 as end_offset.
> > > >
> > > > Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
> > > > with bpf_sock_ops because payload is not in the linear area
> > > > with TCP header/data split on and skb may contain a RPC
> > > > descriptor in skb frag.  This also simplifies the BPF prog.
> > > >
> > > > The placement of tcp_bpf_rcvlowat() in tcp_ofo_queue() and
> > > > tcp_fastopen_add_skb() is chosen to provide the same snapshot
> > > > with tcp_queue_rcv().
> > > >
> > > > For example, if tcp_bpf_rcvlowat() were called before updating
> > > > TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF prog would
> > > > need to implement an unlikely if branch to strip SYN.
> > > >
> > > > In addition, TCP stack can queue overlapping skb into recvq.
> > > > Once rcv_nxt is updated with a new skb, BPF prog cannot infer
> > > > the previous one from skb->len.
> > > >
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > ---
> > > > v2: Add explanation of tcp_bpf_rcvlowat() placement.
> > > > ---
> > > >  include/net/tcp.h       | 12 ++++++++++++
> > > >  net/ipv4/tcp.c          |  2 ++
> > > >  net/ipv4/tcp_fastopen.c |  2 ++
> > > >  net/ipv4/tcp_input.c    | 10 ++++++++++
> > > >  4 files changed, 26 insertions(+)
> > > >
> > > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > > index bc95d8e7b62e..a409f2ea710f 100644
> > > > --- a/include/net/tcp.h
> > > > +++ b/include/net/tcp.h
> > > > @@ -2889,12 +2889,24 @@ static inline void bpf_skops_init_skb(struc=
t bpf_sock_ops_kern *skops,
> > > >       skops->skb =3D skb;
> > > >       skops->skb_data_end =3D skb->data + end_offset;
> > > >  }
> > > > +
> > > > +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> > > > +
> > > > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buf=
f *skb)
> > > > +{
> > > > +     if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_F=
LAG))
> > > > +             bpf_skops_rcvlowat(sk, skb);
> > > > +}
> > > >  #else
> > > >  static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *sk=
ops,
> > > >                                     struct sk_buff *skb,
> > > >                                     unsigned int end_offset)
> > > >  {
> > > >  }
> > > > +
> > > > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buf=
f *skb)
> > > > +{
> > > > +}
> > > >  #endif
> > > >
> > > >  /* Call BPF_SOCK_OPS program that returns an int. If the return va=
lue
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index 3afeb69a547a..f7e32891bb4e 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int =
copied)
> > > >               tcp_mstamp_refresh(tp);
> > > >               tcp_send_ack(sk);
> > > >       }
> > > > +
> > > > +     tcp_bpf_rcvlowat(sk, NULL);
> > >
> > > hmm... so NULL is a way for the bpf prog to tell where it is called?
> >
> > Yes.  The selftest fetches bpf_cast_to_kern_ctx(ops)->skb first to
> > check it since we need to access skb->cb anyway to read
> > TCP_SKB_CB()->{seq,end_seq} for non-NULL case.
> >
> >
> > >
> > > With skb NULL, what does the bpf prog usually do?
> >
> > In that case, the prog reads tp->copied_seq and some sequence
> > numbers from sk local storage and calls kfunc to adjust sk->sk_rcvlowat=
.
> >
