Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E23353EE0
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829653; cv=pass; b=M91/2+r2V39kcLWAJDYFQenbTYdL4EHeFzOHG//ui65ZB669Urn5IU35BcNFdzJbHA+RshcjvWvpLUZ6METEcxmMULj+81RipkVKEWgRcHlrz/UaSKTVxHKUZMQZnH5OHMI4Qpc76QwfU/DXs6NKaEqp1iOcpu0sYNUW/kAq+Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829653; c=relaxed/simple;
	bh=XqF3j13cxi/d9CWy5HLYmYXPbEh0BqsKm5gpvCmGXeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Psc3YWrSKOGiSITml1nBYNkRhnepqy5xWINrYLsF5lAZbHjSu0CiB9iZdaEBfNhiUrCg2yxn9YmpZt8CL2i6J1/pCSJmsE4IinHuekygoe0zKEteMi1i4IkaZ3jRdEP9h+LGNa/HKG6Xvp7/P5t7bmNoOAy7OPP7UcvTYCXsGbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W6ZIWRmM; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6ZIWRmM"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1363fe80fe8so5470720c88.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779829651; cv=none;
        d=google.com; s=arc-20240605;
        b=fCaaUh13yV8oMZ+wXWVIX174J/vfx4MsSTRZIUr/ShGGQwrckfqXy14NhBhKffnynP
         BIXhLKXjrRnhNceJEIJFvITDepMscvGEgdV7hHEId82odfKGgWm1mL+LWc5fDdGuHpYw
         h4kl136vf6M3JLZvFEZdLAiRiVXXIvhL/hAj2WcqzXL1ZVyEp2hOwbtz4VG6HUfoDpsH
         /qjsG+335xP7ZxmOwvqXi2F7jv/9NsKz0Y8xJTGmCbeh4rR6WEag8XZnY8Si0glmB9mN
         mB+N0Rmslw1F1sWPNU1AlAaJ9MXs2ju0JQdHjK4fjW/iNfcjjLUAZcwc1uVH64baGlPK
         yPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FuG/OCefuxvzv1MSr9xGrIiR1NYDCf8b3OUyrtpmtVc=;
        fh=4CoPT1z+TIVkb2AHXitxvxvKJwvf4ErpAc7DsAZXfIg=;
        b=bwdtT5MB9KPmyOHSCQ91NfgVDWN44yO38T4XhrFe8QWEEp39f56/ed6Vvkfskcp3JB
         /zf4RfGJXznGG2YQ1vNBOkTMzsW0zL/VQGYnNwEbMwzszhs8Nem3iSdFJ6vNpoU9ZpgX
         xZd42LBgiwCaXYtvYccj3YVfw2UkNbvlsxbIK8H/anJvhPpgV7H84Yl1SUysj0X2/pVl
         kfQf2eZiib/jmz2/YEk1qH65ux7556mu7MKWASrtnjgGD50pSveZKObxcdmQa9eQS4W3
         FK6dIcvEDmOzHe8SLHCqRLR8Pca5df1TZa2RTnGnG9dfMiezTUI9NYT4/diVrQLpN6Yc
         dIpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779829651; x=1780434451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuG/OCefuxvzv1MSr9xGrIiR1NYDCf8b3OUyrtpmtVc=;
        b=W6ZIWRmMhs7Q0zcLhSKbx0SViCSZEe2H4fp42duJaVm0T4KcRdbgWipLCvJex4CpFv
         G6T7uJAp5GiukeZC2E/b4Eaayc6r/+dO2UoArnO6eDLPWizDTy/IvD+LTY7AjDiC9yOQ
         qoVogXuBnNW+mRuzSHDbjAP+Dmw+K/M3E3twPfrRj/WHGioBC28aIYIxwUKkkeQbK3PM
         w4EdarYOpSM/UmiXEiaTNRIY1dX91kXZQh+VialBBhMXBmWAJ0N9ByjlCqhH3p2UEB5k
         RLEmDiPaR2pJfHdgwZPffld6W6mjYa1e4VaQP8Dqc71gc75cZEgp85gfIOtXr6wuSk/s
         Nh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779829651; x=1780434451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FuG/OCefuxvzv1MSr9xGrIiR1NYDCf8b3OUyrtpmtVc=;
        b=q8b+O7vHYj4fDuXAokD1l+uLVNFFbP3dKR4gYtQRbgMlJEAFPYSI78WAZmwUQmI9My
         +y9/3X5cwjUeAp6vq/eWx0CB6Z81dwC2rLezgp0JN5reamCVcV21AI6iIibXZTOAZUPG
         dm2Ku+SfQVOoEra/IAlfDXy3DhgBmgw9+u/S+Gz6jN8Cl6MO2y2habFD6mOwM9o0YfB9
         w+Q0yK6U4uJibkvks5xJOmz2vUjH4yGCu/JTCBxrUDMqwgixpurs4IeBLtuVMzUCOTQI
         alFgFJePZN9MEZN7gBl5KfSo/iLGXqngnBgbkEPcAYnZBdt0TsXhl02G+piXbJkvqcff
         sd6g==
X-Forwarded-Encrypted: i=1; AFNElJ8Hj/qp9XUHGkrblzbUiKRScnJYg4zTvwo4z08qBtyZqRvrykH/mDSM909hidCMM9wu2Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywld3JOyaiMaoCwZsE1u5wZpvFJ2/eAm0juan5zY2NQx8YiR1Hr
	rZ8FsPyOvknpkTmyHSb2rTI9dgf/Aj2vD33EAwF5IoHRk5+uWsqHo4rRJE8JDmJJqO0a9Qw37Ji
	eRjjNdF5Hvg7sv2IWBFKcufGozt/Ifly88EZP+SCg
X-Gm-Gg: Acq92OEsQCxLfutmwf86E8U7VmwFYjVix6JC+67naXmSwzCdHEPKtdJDq+nNnctahkb
	95KyowA6xAseArA7tuUB1bQCHpOHhmdFt4CqGAOjVCaCaJ9Gs+Ud4PK+16ZO+yMO+Yj5uJ/MGnG
	uC9+Kfvlw7o9REfHzILR9AjxUy6D284c326aMa2U+b6fd513RICiRwKBHvyxxvn05m1qqyM0wxJ
	+NoQwQyXIR10CS1zcepgTxfVv/26g3JfNV+D0PYFqJMgRBaK78Zfu4Ph5q+gSxBa2IwHur1yymW
	haOVM9QRhoDy5wyQtlZBxRWS4/bpxs+JXQ/pvNPQub+EDgHXYJwHWqegtbxd3YkAp0jcNTuLZ+z
	0LF8kWyP2jLRpquGgrD58eMBx2OZT8VcHUA8aUrhZqtATfgRoaj/B2IgEUiR5
X-Received: by 2002:a05:7022:b9e:b0:12d:ca32:5a7 with SMTP id
 a92af1059eb24-1365f81907cmr6430290c88.10.1779829650600; Tue, 26 May 2026
 14:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com> <20260523083001.2911931-11-kuniyu@google.com>
 <202652620435.m7WK.martin.lau@linux.dev>
In-Reply-To: <202652620435.m7WK.martin.lau@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 May 2026 14:07:19 -0700
X-Gm-Features: AVHnY4LBglR5_PGxMxSrpIx4L85PylgzLxFNRSg3vNN7axUqqTCkyPBE673xDRU
Message-ID: <CAAVpQUCd_eDq2nVz=um3T3iR5x7dSX1Rpi1YVTF0T5j16ok95g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/11] bpf: tcp: Add SOCK_OPS rcvlowat hook.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 1:47=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Sat, May 23, 2026 at 08:29:39AM +0000, Kuniyuki Iwashima wrote:
> > Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVQ_CB.
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
> > The placement of tcp_bpf_rcvlowat() in tcp_ofo_queue() and
> > tcp_fastopen_add_skb() is chosen to provide the same snapshot
> > with tcp_queue_rcv().
> >
> > For example, if tcp_bpf_rcvlowat() were called before updating
> > TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF prog would
> > need to implement an unlikely if branch to strip SYN.
> >
> > In addition, TCP stack can queue overlapping skb into recvq.
> > Once rcv_nxt is updated with a new skb, BPF prog cannot infer
> > the previous one from skb->len.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v2: Add explanation of tcp_bpf_rcvlowat() placement.
> > ---
> >  include/net/tcp.h       | 12 ++++++++++++
> >  net/ipv4/tcp.c          |  2 ++
> >  net/ipv4/tcp_fastopen.c |  2 ++
> >  net/ipv4/tcp_input.c    | 10 ++++++++++
> >  4 files changed, 26 insertions(+)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index bc95d8e7b62e..a409f2ea710f 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2889,12 +2889,24 @@ static inline void bpf_skops_init_skb(struct bp=
f_sock_ops_kern *skops,
> >       skops->skb =3D skb;
> >       skops->skb_data_end =3D skb->data + end_offset;
> >  }
> > +
> > +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> > +
> > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *s=
kb)
> > +{
> > +     if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG)=
)
> > +             bpf_skops_rcvlowat(sk, skb);
> > +}
> >  #else
> >  static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
> >                                     struct sk_buff *skb,
> >                                     unsigned int end_offset)
> >  {
> >  }
> > +
> > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *s=
kb)
> > +{
> > +}
> >  #endif
> >
> >  /* Call BPF_SOCK_OPS program that returns an int. If the return value
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 3afeb69a547a..f7e32891bb4e 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copi=
ed)
> >               tcp_mstamp_refresh(tp);
> >               tcp_send_ack(sk);
> >       }
> > +
> > +     tcp_bpf_rcvlowat(sk, NULL);
>
> hmm... so NULL is a way for the bpf prog to tell where it is called?

Yes.  The selftest fetches bpf_cast_to_kern_ctx(ops)->skb first to
check it since we need to access skb->cb anyway to read
TCP_SKB_CB()->{seq,end_seq} for non-NULL case.


>
> With skb NULL, what does the bpf prog usually do?

In that case, the prog reads tp->copied_seq and some sequence
numbers from sk local storage and calls kfunc to adjust sk->sk_rcvlowat.
