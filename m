Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD2371043
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511351; cv=none; b=QpA5qaq3tP5uCgPJjPL6cvfJIbiAGDPgOhloRfPS+yGQr9LqeXx2S1OuQ5po3Y/efJElp3HoU88/KvY7uZA88oVN/wlYt0AxAc9k6xmr7LtUTgGfe0u3p3Pv/e7Hv/IhnVThqiIQ5n3kdtMBPu7iPX9qpjx6wdb/iSxjwijSS5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511351; c=relaxed/simple;
	bh=KDcP1mIxyjc3WE2ChlMOYepGWkKFHZmtQU0cPtkBrgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz23aVITUMRW/cP8/W1CnPztsAt0qjfgf5a8m9NSDBvTC5j7PKsMKNERL2h2uidDJsj6AwA9Tp68CBJYixMSED6aD2oy8FjM5mgnFfvnh/d7xuUYC+XJMG95nI1LoTCjES2bbp5jM/RMwMch3/FbWYzAYQmfsSPuheaU9LKb1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYEuVt6g; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYEuVt6g"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3665b67ed66so1853724a91.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778511350; x=1779116150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d7IqJggZrwHqytcUiR9O/Gr2W4bZC/PK+mrUhm5A2Io=;
        b=NYEuVt6gHMpcNSUqzIfZouOCBWrAVZ4RN0GWRc+OEmEd+nuHthSiGIyOs3x0KSF5gD
         SrU5Bmq/RRqBYExeWQhuAxMWOdg//p0qfKuFWCpf3BSqrelGyf4rTjzrJ0tKfSg9hU6L
         iO6pqKlnGgJa7nJFVjdRP+WMp6mVPknH9zoGYu7xeM5VDq0JHs/WrV84XOcjXGc70L5J
         SIsiTMtV0IMO9UitfFXDbj0IgynsuTSv9ArkWtfdovvUjXsfLcSQmKvpJkldF70ZtPXw
         X0BZsrOqlIgEGpkhWwFlB/o2gQhpSOv7ZFu++MJrkixwNRK0lx3wmQJmibvEmJmmehnN
         nvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511350; x=1779116150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7IqJggZrwHqytcUiR9O/Gr2W4bZC/PK+mrUhm5A2Io=;
        b=b1svZ11CtlFmH+apnBBsfdzLB7yy+QokkFq8qhTPIjpyIcJtXueMsO3zUhk2/zLQX+
         EAnzNLrz1srzvL3cKCiECdb3fmt6N1W3VGhTmevP7WiSccWCHKA4UcgP+XkV6LOHh0uz
         1/5je66dOYEr9xKts5svkGhj1rcSmVvvuYioWnCg/9oHY/KsG/ydHWL0EVOjTmOEnfy6
         qxJ6ne6emUfXWv9/ZJxSfJNpLteZt94z7wCsc5ffZ/6/SrKM1l8SKDqpZHWOSMlqX1Y7
         iFKEoGgkOiGfizglEJSuWHO6aMBwM+++SYdfYu+5M7JCr7tdYn0RcWU5U9II7xaiF66Y
         C48A==
X-Forwarded-Encrypted: i=1; AFNElJ9MviZVKrSOCvFKA5qJ0VYvjESJHGDatBuZOHdMvvHtgOQTcRxC/MidCaS7tfEqEnTHGmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySTqvAsE+90/+oy7dmcHGuqRIOuNzgBMc+TvbZ2GiLVBHohlTs
	u39qSDtxkxUaWyV1dnKQhSAMU2B0ayU9nEq4DOSl7QxA1z5YG7dbGs2G
X-Gm-Gg: Acq92OG5Qr1Z67KiQs2K9RvIfrrV+R3YukTRzmqbz7FuAdaQ3IodDGLXNySNLiasoZT
	hhhXJAknXROxk0eI6Jbd6eC311Rs/9rRGl0n9XDpmz3vOygVFxK8DrD8grTEMJNJmyZVDUC4LaW
	eTPjvCbDTa7+40FoPaFMEVV41S+DjiEMk6CTeMCB4OWXcLEdaPKvR7onitzbK6rEyqQVf8wyeLi
	vqm1VDqP039zl7AVlSL1/B1YszIEmml1rGcDL27WEQGXw3dcscq+YAycCm3Krt+/crK9a0Xw93D
	DiLnMGigR6ushRs0wcgfO50iJH9j2uuZsC8WL0awL/8e7UoTVwD9w/Z/BMzCW9MbZMD4+N6tDnn
	mSqO37rKwF6dGBCYcIqWRg4GCpQITFM3Ovqb/WGRz3v1En4vEvnxK7w+aVObDv1E0aIUYh34BhN
	5C3SgfvHlXGraN
X-Received: by 2002:a17:902:f54f:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2bc7a847f38mr101597595ad.0.1778511349533;
        Mon, 11 May 2026 07:55:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e8eef3sm107168145ad.65.2026.05.11.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:55:49 -0700 (PDT)
Date: Mon, 11 May 2026 07:55:48 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 7/8] bpf: tcp: Add SOCK_OPS rcvlowat hook.
Message-ID: <agHtUHUEMis-p5Aw@devvm7509.cco0.facebook.com>
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-8-kuniyu@google.com>
 <af4AO2-9jwluWuik@devvm7509.cco0.facebook.com>
 <CAAVpQUBTbcpf+kNOqXj-2=Qjx86TeZ-sHVGKT-Vwj=GVXz4hEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUBTbcpf+kNOqXj-2=Qjx86TeZ-sHVGKT-Vwj=GVXz4hEA@mail.gmail.com>

On 05/08, Kuniyuki Iwashima wrote:
> On Fri, May 8, 2026 at 8:28 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 05/08, Kuniyuki Iwashima wrote:
> > > Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVLOWAT_CB.
> > >
> > > Let's invoke the BPF SOCK_OPS prog when
> > >
> > >   1. TCP stack enqueues skb to sk->sk_receive_queue
> > >      -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()
> > >
> > >   2. TCP recvmsg() completes
> > >      -> __tcp_cleanup_rbuf()
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
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > I was reading the series expecting to find some skb_queue_walk-like
> > implementation, but since it's a cgroup hook we obviously don't
> > need to do that.. So at this point BPF_SOCK_OPS_RCVLOWAT_CB_FLAG
> > is basically a "rx queue skb" hook, right?
> 
> If recvmsg() hook w/o skb is not confusing, yes.
> 
> > So should we make
> > the name more generic? There is really nothing lowat-specific
> > here besides your new kfunc to read the payload?
> 
> Do you have any suggestions?  BPF_SOCK_OPS_RCVQ ?

Yeah, idk, maybe something like this :-)

> 
> 
> >
> > > ---
> > >  include/net/tcp.h       | 14 ++++++++++++++
> > >  net/ipv4/tcp.c          |  2 ++
> > >  net/ipv4/tcp_fastopen.c |  2 ++
> > >  net/ipv4/tcp_input.c    | 10 ++++++++++
> > >  4 files changed, 28 insertions(+)
> > >
> > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > index 4e9e634e276b..003e46c9b500 100644
> > > --- a/include/net/tcp.h
> > > +++ b/include/net/tcp.h
> > > @@ -737,6 +737,20 @@ static inline struct request_sock *cookie_bpf_check(struct net *net, struct sock
> > >  }
> > >  #endif
> > >
> > > +#ifdef CONFIG_CGROUP_BPF
> > > +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> > > +
> > > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
> > > +{
> > > +     if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVLOWAT_CB_FLAG))
> > > +             bpf_skops_rcvlowat(sk, skb);
> > > +}
> > > +#else
> > > +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
> > > +{
> > > +}
> > > +#endif
> > > +
> > >  /* From net/ipv6/syncookies.c */
> > >  int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th);
> > >  struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 1d9e52fc454f..80144b97a87a 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copied)
> > >               tcp_mstamp_refresh(tp);
> > >               tcp_send_ack(sk);
> > >       }
> > > +
> > > +     tcp_bpf_rcvlowat(sk, NULL);
> > >  }
> > >
> > >  void tcp_cleanup_rbuf(struct sock *sk, int copied)
> > > diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> > > index 471c78be5513..91bf421fc5b6 100644
> > > --- a/net/ipv4/tcp_fastopen.c
> > > +++ b/net/ipv4/tcp_fastopen.c
> > > @@ -281,6 +281,8 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
> > >       TCP_SKB_CB(skb)->seq++;
> > >       TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
> > >
> > > +     tcp_bpf_rcvlowat(sk, skb);
> > > +
> >
> > I'm also not sure about the particular placement of some of these..
> > For example here, why do it before updating tp? Why not after?
> >
> > (and same for tcp_ofo_queue)
> 
> Basically, it's to give the same snapshot with tcp_queue_rcv().
> 
> For example, if you call tcp_bpf_rcvlowat() before updating
> TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF
> prog will need to implement an unlikely if branch to strip SYN.
> 
> Also, TCP stack can queue overlapping skb into recvq.
> Once you update rcv_nxt with a new skb, you cannot infer
> the previous one from skb->len.

I see, makes sense, thanks!
