Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF43D8133
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841273; cv=pass; b=Gmq8u5RGnPPAM6en96XF6ENWYrMsjsT/pxMeXSaaxXtToHxnS2iGVuMF45kcx60HyvpI63lQIbaDzdxdaSToUrPT9B7MsDRJkqGiNcuW/fi2e+qqj49ULEAwEMdILHPtFdClr6aRbrdiNMfFdXDLu94t1Rote/BZbF4saFjpITA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841273; c=relaxed/simple;
	bh=z/euYNrr2+BYwM4a/WfQWCBjyGxEkyKa2+Erlae4Q9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaE2Lj1dJY2ud5B5C4wqaApJGVylDAosskouONf/0Nt0vkZtVMwx3//BXcLkvK6RPJec8XXN8fgBAA9u/Jk1pBTdjhILtFtGt9+CSbL2lOvPkssIOkwiFOYbUps7Ln/oYtyc5zQeG4+O0WroPSfRwhcp7Hoq8myByXN+s3y4Bfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=dHR7qY+s; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="dHR7qY+s"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64c9cabfe5dso1253897d50.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 06:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773841270; cv=none;
        d=google.com; s=arc-20240605;
        b=dqTErNFblgcOyytADcmICKXFqbDDPT3PbLQFZH1vspizAGmyigNooL3/dI1H2gWhQX
         k3aSk4yNZ/8gINecc9XmvX6PIC9vdRLnZllCz5Agtf2BqfiPE4uhXuLMBt9AdKEBzM6/
         7he31Oay3D/HLeb7NhmcJf0pbMjngjEo/MpLznQw3/A6YiKPCyrofDiZPHapacDf+Tk/
         xtbs9G8NgNgDxiiyBKsHDWdWkADqr1d0iQaAaS5jHU3nNPQ9Z2q4Tmy67UyFiClgp9yb
         xNLn170Cg4ls8VKeJkBf1yi5j7R/K3QSE8uSogP+teH8ceD1DnfgGpClIFtKpDfxEWhX
         J2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wty4xQgtcbhRseyO6oF0j7oAkj0isukvCLYNA7lfurA=;
        fh=b8z5WOUi9J20ZE02YZlvGRhTecU6vNIeKu/KwgKxpEM=;
        b=PUKYNnI7jAC6wdt29w7tRSxoNfgWVloTgCWqm7XT/BmPt98Ja16hzommvwHXOlhn36
         uq6xhoY5f+FwggESdE4gyNiF4kwAIHX/HfwPdMijmbdnBk9SBjWFr4qc+bDNVd61/5G5
         brXuVJYieBqUOxB8SjiBOZuKKOMq8KYWsC0yv91VvUdYKOPT24sNhRu36ToQ4wbN/oIj
         5/TFB8xfPMgvNUauP8y4sysxJCdbihAkK4Exv9Ruyg8xOyWDHJQOTy0syKnzpjvybt43
         zaoYEEr7/gveRjebNbSl6UCFO8EpXr2GkVyWXmvjfOlKjBHffNq36QEqc8Y27KC1ny8c
         f8Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773841270; x=1774446070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wty4xQgtcbhRseyO6oF0j7oAkj0isukvCLYNA7lfurA=;
        b=dHR7qY+sinjlf6f57N5bwU+OWVeO6VT/zMk8d5oKM2o0C3T8Sp3ZXtAZnObYRPtEuS
         WxeTpi4go96TnLWYkgmt0aOjP12Oom65Mqlj/ZXyeCiWwe9nUNYh0kjb1prG23oA2epx
         cn30OSbs08MsHXAF/CUKjs3yT+zkspQGYoKWXJNWn66iOVv2wPMZyxzLIcioiugwFxfg
         32vsERmsQU2CI9vR7x93m/U0LoXOJ4GmUg+0O2CF8uPdju5yiY98JkPblnudsOWA9czF
         fuHnXYn3/+TjbO+xnvUORLjB26mHpUBRG5VZnCpy91sjI0TevBprEamvrGjxg0V5lh6g
         zI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773841270; x=1774446070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wty4xQgtcbhRseyO6oF0j7oAkj0isukvCLYNA7lfurA=;
        b=OaT+aiOAXGHYb9oSY8Y3IqMvTtagJeHMEZR/ykHbtSOfWxQBE7zYUf0qkZA3EabJ+K
         6pzIfuOvObJAmRsXQ3fsrOIGTJ8raC3Jc3ggXt9K+fJmzJLlQciId2ZT9VPLnTzALtWQ
         WTi0Feq4U9O1GsdB2q063pPdMqXpJJpRQkmtwYjJ8b/Xi64ImruZ5LnpHVL0sNt3FY7T
         UgzPBX0dazKQoQahQg6dj10WuIunX5iUmajLBeMv+g4IeD8OLJLpzCTlrl3YffwFAR20
         SIsja8qpZmwN2P8Sh8L1HX6nqDoto/2F0smft08JgkOMNhsOQ8ojHypmlmwewwBEpZ37
         AFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk8539OCF3RC95pgnT0WGC8WZY0bYsVpYGrrZC0n1CMz7Qp2rqBJonTl9F7tqzL1U81FY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqo1dvQcZvAmR42WnEPSbsnV0in8KZL7cMfNOQjOuReHg3wvTm
	9cYWbG/owvkvVWNTL6/Em5UaRja4DAP8kPppKlZQ8CSgMmPJ4oTr3R0kg/1LNgCSfGsd1keqP8e
	sv7N/Tggcs1h9EF4++X1wdgSZAVFzRndLF0iAGlZxng==
X-Gm-Gg: ATEYQzxLo+T4F0/uf/pCcZSQjwfDXX3lqxzL4jIWc6T6JUl/RwB+CuOlzApmuot83ug
	bdaj6+FowcdjByb/VdJXWrivuARcvECsux/eaL9m7fnqHw/k59I3lEbZTN+nYZZCJDcl9R1n8Ya
	Ie35sa3IBaCD9ENKSs2JElJDM/gyeaFwquw9H+3KsrweuixUg+K/8ypq4pTE5vwPXhYzsYnVo/K
	0AvA7VJosmRYNBmx6fKR2BfR4yE06mzADwwWzondARl6MSUdzJmTkAlo59zd6il1fbV3aNKNiHb
	aM7Ju8hbBHy/fhFdVA==
X-Received: by 2002:a05:690e:419b:b0:649:b234:3905 with SMTP id
 956f58d0204a3-64e88b4f88fmr5765244d50.41.1773841270022; Wed, 18 Mar 2026
 06:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-5-vineeth@bitbyteword.org> <f7to6ktnjxi.fsf@redhat.com>
In-Reply-To: <f7to6ktnjxi.fsf@redhat.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Wed, 18 Mar 2026 09:40:58 -0400
X-Gm-Features: AaiRm51CXqWYj3bhPG1VWTfExv82dHZMJIVk-_egP6VLHUZcmabQcnoPToaB-4M
Message-ID: <CAO7JXPhfpUb1VM_=mwSUqHPQrLvBW=wurz_apWQkMXssPAQPJA@mail.gmail.com>
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

On Thu, Mar 12, 2026 at 11:31=E2=80=AFAM Aaron Conole <aconole@redhat.com> =
wrote:
>
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> writes:
>
> > Replace trace_foo() with the new trace_invoke_foo() at sites already
> > guarded by trace_foo_enabled(), avoiding a redundant
> > static_branch_unlikely() re-evaluation inside the tracepoint.
> > trace_invoke_foo() calls the tracepoint callbacks directly without
> > utilizing the static branch again.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > Assisted-by: Claude:claude-sonnet-4-6
> > ---
> >  net/core/dev.c             | 2 +-
> >  net/core/xdp.c             | 2 +-
> >  net/openvswitch/actions.c  | 2 +-
> >  net/openvswitch/datapath.c | 2 +-
> >  net/sctp/outqueue.c        | 2 +-
> >  net/tipc/node.c            | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 14a83f2035b93..a48fae2bbf57e 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6444,7 +6444,7 @@ void netif_receive_skb_list(struct list_head *hea=
d)
> >               return;
> >       if (trace_netif_receive_skb_list_entry_enabled()) {
> >               list_for_each_entry(skb, head, list)
> > -                     trace_netif_receive_skb_list_entry(skb);
> > +                     trace_invoke_netif_receive_skb_list_entry(skb);
> >       }
> >       netif_receive_skb_list_internal(head);
> >       trace_netif_receive_skb_list_exit(0);
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 9890a30584ba7..53acc887c3434 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -362,7 +362,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info =
*xdp_rxq,
> >               xsk_pool_set_rxq_info(allocator, xdp_rxq);
> >
> >       if (trace_mem_connect_enabled() && xdp_alloc)
> > -             trace_mem_connect(xdp_alloc, xdp_rxq);
> > +             trace_invoke_mem_connect(xdp_alloc, xdp_rxq);
> >       return 0;
> >  }
> >
> > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > index 792ca44a461da..420eb19322e85 100644
> > --- a/net/openvswitch/actions.c
> > +++ b/net/openvswitch/actions.c
> > @@ -1259,7 +1259,7 @@ static int do_execute_actions(struct datapath *dp=
, struct sk_buff *skb,
> >               int err =3D 0;
> >
> >               if (trace_ovs_do_execute_action_enabled())
> > -                     trace_ovs_do_execute_action(dp, skb, key, a, rem)=
;
> > +                     trace_invoke_ovs_do_execute_action(dp, skb, key, =
a, rem);
>
> Maybe we should just remove the guard here instead of calling the
> invoke.  That seems better to me.  It wouldn't need to belong to this
> series.
>
> >               /* Actions that rightfully have to consume the skb should=
 do it
> >                * and return directly.
> > diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> > index e209099218b41..02451629e888e 100644
> > --- a/net/openvswitch/datapath.c
> > +++ b/net/openvswitch/datapath.c
> > @@ -335,7 +335,7 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_bu=
ff *skb,
> >       int err;
> >
> >       if (trace_ovs_dp_upcall_enabled())
> > -             trace_ovs_dp_upcall(dp, skb, key, upcall_info);
> > +             trace_invoke_ovs_dp_upcall(dp, skb, key, upcall_info);
>
> Same as above.  Seems OVS tracepoints are the only ones that include
> the guard without any real reason.
>

Makes sense. Its simple enough that I think I will include it as a
separate patch in v2 and remove these changes from this patch. Thanks
for pointing it out.

Thanks,
Vineeth
