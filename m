Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607D73D8108
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843217; cv=pass; b=c86JaQg87+LK6kmGWgESegbctwtcS0xzEZH9FrLmpmgntgmZZ+MArk+cLUXQ3yJBQj9TBCc9kOWjv6pjsWgEF8/483JP0t6oX+pL1hc6J02ue1yLABYz7M9FYls7FZHs/BNaMRtldtJ+7kJNhNvPrihHhPQU6bDeyKjJyeO1kt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843217; c=relaxed/simple;
	bh=z/89pA0UO58ZBkQTFOgdhyZuqhcSfbmElffwmdziG+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWNgGcNRBIoYezMRNh7reb7DLjJQzrPV6zWGFpn+AnR8I2EbrdC6Csaj9ZzhRCXyN/VCvU7qXTJeP7WjpUr3yhjaT40z7crjvdiEpuRb3Y7/8/eIYIbh3IeMJ4839+sJUeXVTkb23wM44Qwm1KQllHfHjrCYlVqgjyQmV13PETQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=iLv8Kcr6; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="iLv8Kcr6"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899e87b04d8so100202876d6.3
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 07:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773843213; cv=none;
        d=google.com; s=arc-20240605;
        b=FZfoWIYvyDQtvUPzriQC5mrvr36SxKEOwe/pQENN8Ihrw0304Qa7nABHAW/FT0uFYd
         qqpcSESWhvZOFfav5rrZxfbxF7eCy9dVtuOXaRBVkbHuWrptPrKTH04TWMXyviITy51J
         meZ6fQvsvEgWHnrS+0548YC3luA2xjJ+79kt5LQKBLZocTK5khrPfB4plU7j8CNVEjrU
         c6l0fPmF+ZUaczK/GbpexLRPtmeXXMir85fQVZxhbKboic2TqMae3R2nC3SIgX5ngXSZ
         AHMOGSPtGxmKz+mmunRYTnUrisYLg1OQ4Ob/t8kSo49DoEKXLlKa9u3JiHzVZ1e9RmeF
         ZHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=doH9jKyIV2pcWr9QqHgYapLUvNmJgzZV6s5pft4p5hM=;
        fh=BJknILWXeNbOv8ceXs92/R2vWp+4JetLHPvjXtV4KRI=;
        b=Mo3OX5Xc0AxGpaLu2xVJqptcjsiEPaGT6N5TSYCn6EXf1/ONAKmrzgyvZPeszizzEy
         BgszSuyOJRrLR2prPkCOYmblWGjSj0aDOlhl+8JX6cHb3hNnaGxu+AMvPVWQJw2GFu8e
         5SNlUxixJ7kobfzgdVWNa4aDzlaf1jNObdgBPoDQiEoQWF07o+/i76gMwY/agvd0hIFE
         G7cWnxJdoj30kzWrHnvA55TZn4Zx5pjDSDYHtF4XpcuXReYHAZFuxa3HyO3u86wUYCQi
         +T0YzCwF+mCrL05Vnp+itj7QsGayMPsKSafsvPRZJ9vXg4Xxd+qInr9Ke2Da4sqLyRwO
         Se9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773843213; x=1774448013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doH9jKyIV2pcWr9QqHgYapLUvNmJgzZV6s5pft4p5hM=;
        b=iLv8Kcr6ga2PE/qEE7gatlTbBuKuabs1y16ZU02HWWuD2F8/SlRbYD+MiJWlt2c2k2
         dduToabSVGSFcR3YzXAZivojolCfyFq8mmgx+i8+nMzfCVMkvmzgOhaHyHJ+GW5PKCux
         y4LrDFzCZ9GUaBfw7b/v/VPzts3OrrzNDJm5Orsva+cV3IuaLj8awNAPzB3LEy1AStu7
         M3P6XzAaHLQ1uullDaiNWw/xpwfx7tRGkwpdMmNeujw02McXPZfPeKTvafM8x9Ig1crv
         CyUXQV1PUOOqeUP+J6++WbBD6wJO0ngS50NoDJCoCVThx5tVRIS65X5U7WMQ0ChpvW8n
         TqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773843213; x=1774448013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=doH9jKyIV2pcWr9QqHgYapLUvNmJgzZV6s5pft4p5hM=;
        b=HJ0ad2ff8/KfJVUlYcAMmZWzOWvJUObS97HP1ZkdibR1Ag1y4m+ZMVeLqC230UCKiE
         6pZibSqzwpEUXgctEbRPlBYsNf9h70HnoQrSTxabCWDwN+UmCXB1ekztGmWcvrnm0v2T
         cWPTG1HYjA3kcoZa2s9xZe+4h8MdO1gRUhR1IjesmE4khp/RRWCjI/kUQe1+XrMjmEYJ
         yqO/dk35TIpKVuzPXW3O5s+v0bZVjAl6WDvUyfiNDFhnnGs7RTP5Kc0MJBUqGNaKxqCV
         +Mq8CUlC5OOm2B6sho8zEJbH5JejBrsEQfv3NCgIr3of0Bh7ulI9Dp7uuPC5WWP3tfdu
         jGkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCy7UO6qPwPK0A5mGf0nV7qxNiybX9mh7OIaWSjlsPsD2MH0bu3dPlqojADX4266mzxHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZoAoy2ad+Hzi5nLq2AZebxmwNND6W8bQ4pfE2YniGFFhOZ2GZ
	Otnm8E8iLRoOsHYr1GVa8I7BGA1MFHWZTXBBxWXTdUzwSD4DdAcKyG2PUcqp/b8K75m/6YahIfm
	WYVCKpCcqBd7+FZ1B0OUNbloW1lfgpEn5tuSp643stg==
X-Gm-Gg: ATEYQzyzEQZE8nI/Txmm56uWvnLVckHE2Y+foUEjB0Zk0oQxNXKXuQGgJpGiHZ9yiDr
	WfhxZgMFHljytu/OGTDCPx670QhOmQQqGhovbwLCaijx0DAwQ3+m+kVOIT1lsu8SrOY9MvMRkeS
	n9yLuABjGl2J4r/wWdkA3/IsqndtwLNZaVAisuoE3XhrfmfcA4oNiEv62mbLb1soU+3cJEdIECY
	MzCxVez9YGJt4u8wB8W6vkhhlaGoSU+eq4yMId4AnMRtfylaqe+LdJknxJDyUoTxYJ8y0Hf1H2l
	HK76P5M=
X-Received: by 2002:a05:6214:2466:b0:89c:4cb3:4ea1 with SMTP id
 6a1803df08f44-89c6b50cda1mr53811646d6.20.1773843213183; Wed, 18 Mar 2026
 07:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-5-vineeth@bitbyteword.org> <f7to6ktnjxi.fsf@redhat.com>
 <CAO7JXPhfpUb1VM_=mwSUqHPQrLvBW=wurz_apWQkMXssPAQPJA@mail.gmail.com>
In-Reply-To: <CAO7JXPhfpUb1VM_=mwSUqHPQrLvBW=wurz_apWQkMXssPAQPJA@mail.gmail.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Wed, 18 Mar 2026 10:13:22 -0400
X-Gm-Features: AaiRm51A0epLogiUfwoUvX3H17X7FM-N_YItWsuNQqgGdOd0yFIoTXs_t_Yz52g
Message-ID: <CAO7JXPgiM12_KcM+-Kxw2A9yC7-G1wwXCmbyVqpAcckojfRrTw@mail.gmail.com>
Subject: Re: [PATCH 04/15] net: Use trace_invoke_##name() at guarded
 tracepoint call sites
To: Aaron Conole <aconole@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, dev@openvswitch.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 9:40=E2=80=AFAM Vineeth Remanan Pillai
<vineeth@bitbyteword.org> wrote:
>
> On Thu, Mar 12, 2026 at 11:31=E2=80=AFAM Aaron Conole <aconole@redhat.com=
> wrote:
> >
> > "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> writes:
> >
> > > Replace trace_foo() with the new trace_invoke_foo() at sites already
> > > guarded by trace_foo_enabled(), avoiding a redundant
> > > static_branch_unlikely() re-evaluation inside the tracepoint.
> > > trace_invoke_foo() calls the tracepoint callbacks directly without
> > > utilizing the static branch again.
> > >
> > > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > > Assisted-by: Claude:claude-sonnet-4-6
> > > ---
> > >  net/core/dev.c             | 2 +-
> > >  net/core/xdp.c             | 2 +-
> > >  net/openvswitch/actions.c  | 2 +-
> > >  net/openvswitch/datapath.c | 2 +-
> > >  net/sctp/outqueue.c        | 2 +-
> > >  net/tipc/node.c            | 2 +-
> > >  6 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 14a83f2035b93..a48fae2bbf57e 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -6444,7 +6444,7 @@ void netif_receive_skb_list(struct list_head *h=
ead)
> > >               return;
> > >       if (trace_netif_receive_skb_list_entry_enabled()) {
> > >               list_for_each_entry(skb, head, list)
> > > -                     trace_netif_receive_skb_list_entry(skb);
> > > +                     trace_invoke_netif_receive_skb_list_entry(skb);
> > >       }
> > >       netif_receive_skb_list_internal(head);
> > >       trace_netif_receive_skb_list_exit(0);
> > > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > > index 9890a30584ba7..53acc887c3434 100644
> > > --- a/net/core/xdp.c
> > > +++ b/net/core/xdp.c
> > > @@ -362,7 +362,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_inf=
o *xdp_rxq,
> > >               xsk_pool_set_rxq_info(allocator, xdp_rxq);
> > >
> > >       if (trace_mem_connect_enabled() && xdp_alloc)
> > > -             trace_mem_connect(xdp_alloc, xdp_rxq);
> > > +             trace_invoke_mem_connect(xdp_alloc, xdp_rxq);
> > >       return 0;
> > >  }
> > >
> > > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > > index 792ca44a461da..420eb19322e85 100644
> > > --- a/net/openvswitch/actions.c
> > > +++ b/net/openvswitch/actions.c
> > > @@ -1259,7 +1259,7 @@ static int do_execute_actions(struct datapath *=
dp, struct sk_buff *skb,
> > >               int err =3D 0;
> > >
> > >               if (trace_ovs_do_execute_action_enabled())
> > > -                     trace_ovs_do_execute_action(dp, skb, key, a, re=
m);
> > > +                     trace_invoke_ovs_do_execute_action(dp, skb, key=
, a, rem);
> >
> > Maybe we should just remove the guard here instead of calling the
> > invoke.  That seems better to me.  It wouldn't need to belong to this
> > series.
> >
> > >               /* Actions that rightfully have to consume the skb shou=
ld do it
> > >                * and return directly.
> > > diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> > > index e209099218b41..02451629e888e 100644
> > > --- a/net/openvswitch/datapath.c
> > > +++ b/net/openvswitch/datapath.c
> > > @@ -335,7 +335,7 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_=
buff *skb,
> > >       int err;
> > >
> > >       if (trace_ovs_dp_upcall_enabled())
> > > -             trace_ovs_dp_upcall(dp, skb, key, upcall_info);
> > > +             trace_invoke_ovs_dp_upcall(dp, skb, key, upcall_info);
> >
> > Same as above.  Seems OVS tracepoints are the only ones that include
> > the guard without any real reason.
> >
>
> Makes sense. Its simple enough that I think I will include it as a
> separate patch in v2 and remove these changes from this patch. Thanks
> for pointing it out.
>
On a second look, I'm not sure if this was for performance reasons.
The discussion in the io_uring patch in this series points out that
the check made there was deliberate and for performance reasons to
avoid 6 mov instruction in the hot path. Just wanted to double check
if that was the case here, before I remove the check?

Thanks,
Vineeth
