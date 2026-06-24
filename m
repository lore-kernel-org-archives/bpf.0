Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF23749F5
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336801; cv=pass; b=fAgePIT8Ay51QrUiAyjfHFemAEQbP32+Bf599eqmbI/4lrVMPIiP+0+Aj76ZAra6XJyA+m4XLy9/q8zeGhLT29vCDwVKb4Ea19y8Xu7fDPOZ5k0/VRBvreCTjhvPL2f/eDXsmvAtt7G2t7NH2u63Bd5bzgN7Q3oO1dC3MYecEjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336801; c=relaxed/simple;
	bh=rvc4TEFeuCgkWrl/ybtdz29Xy4B2P8fBztIzw1BjsMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7+t3/pDrZFo3XAG5jHoPlr+WyDOPEN2wq/3Mj+dELk+0d2+fXsedI0uSQ2kBDgSBnle8qwbo6VzQ6itB/0nhduPj6pljrJh1wCgL0huPDvTVXZ0dK+GeP1Q+tYq6LigHYr5N0JACCJeXkaqKBvSXVHJdTDRK0CqeFXi1ZgRkGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uxy9/Wu0; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxy9/Wu0"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-139a71baa35so4005351c88.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782336798; cv=none;
        d=google.com; s=arc-20240605;
        b=P1CT/FrmkhE5PcdDmMsHWFctmVoCn4lVzqXyfGYuiDAVlmOCM1ht0vPUKyRKZIg8kV
         5UKUlAiZbGRBtDSl/EBp2McT0t0sTq9IOBi7mHgCasfqpw0dVewrgXEh6FZNqbqtHjgo
         OcZ8Qw7zz8VVSJqTs4wvKXOQeXB4v/tFMK5rmAlMjBf4ML0Pv+66Avjg0sCE+M3eKXNB
         fGAnA1gU3cEjP7dmi0ti2sZtb13wcgWXaCAo2K641n3r3KkP9xlGu1A4yPoZWfXSyLdZ
         0kKHutIYM3j/+2qjQaZ7p2DYSCyA5Utz78BevNNKotA8KvbTw6l5cK7Ph/HvHB4XSlDl
         Y+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kw+QxnRWB7e1dd6QCWe3t2Usoivr/aO8jOgSE/qHHmc=;
        fh=aSrX4Zr5oY0U/hLOy8hYr1HMn47CvgcoA53duzSA4UA=;
        b=QOo9uhNxPXJmJUQ1x5ztfVDAFTlb4E1EmphJbsVfS7GxhKW8uKso7L0RAR4SQoY2wL
         fWCpvRwQ0DpokircFenzREfVUkFi0R4toxnAJIf2iUF9cdxWLtHwevYAkhrpdV4DX4k3
         NazTEe15JkCSw2NSk0SnKME41JxtaHERH8OE/5qch0yzi7BUi5ObQkzC8mqD8QZ+nhxl
         5TPUGGbzNIb3bJt1rfyIspNIAlNi8ltB8ZdVxT1hRszbGgrKEfASh68mUv5uZIoLoL/9
         blCID4Lvq8BUuU1UVl9wyOidhV/hEH9+ajQ/oyTpYXaBc6MJYo419PtBDPaGhYeueLKG
         +93g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782336798; x=1782941598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kw+QxnRWB7e1dd6QCWe3t2Usoivr/aO8jOgSE/qHHmc=;
        b=uxy9/Wu0pVyaODyS4qe8Gq8UOoH+djcSG4AaNyFxyMZQ4JtTNL/3zKpQm0n2IP7MeU
         LedNpWoPJoSz8OrJn4frRAO4xWuQLO+f3QTzsjCrKOFdpdbbHKhBWl8njGgBBBPRYleU
         j5q8gMZ0ahIEEm01HPyQQWLStIuPIiM1N4QxaRAC/MrOO4qSPU7knLCunlf5Do+xDqNY
         Dw/+NNPkxiZ+7oD4pvwhRQpjvFHWdNoAkl6eEFfjQ35hr4kkA33FH0ua3m6fCy5Q2/vR
         avmpVRk0C8wDmgaAUI9mCHMmJz6DwWbs8ZpLBjIXPPlBN32wOT9LGvEdbWcaEmGk7kGf
         Uzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336798; x=1782941598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kw+QxnRWB7e1dd6QCWe3t2Usoivr/aO8jOgSE/qHHmc=;
        b=dhXNeBJsLsISRcs7NkFHgN4gDn/Y1FTih6tT7bkGC5aicx7GnYPMZWgMlW5GLagD8u
         s/laHcTle0McC54F6uQIGo/9AZGEqVqc2pMZUpGyjVEjC5F42MpRJB9egpu6tvbvJcTo
         0Y2u1VmSEhY5+dBGx8/tMMQyLJOqR1TblcB00UetOG+mQ1nzUkO4c/zvTPWnErJ3xjgS
         uHJDZlsWJ8fGUHjLLB1xmbsAOEI+eiM+PDbbqdVmy6K6XxEYDbNRYvaJbig5u/uiS58s
         BNoih+SgizCQ0ktzxf3pm/33VLie2dyenfztFn1OxC17eyxyHvWuchYIIGytqwzUoRJD
         TAnw==
X-Forwarded-Encrypted: i=1; AFNElJ8McemSH3Y5rgCkcomRuHvRNeGb9mIs8tIlU8z6E3QBA1uKpqe4KgFh0qNioTCFICTRYBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01LrwD1hDLUrEYKrk77+EEAOmfyWJR+xy05VRzO4RilVXF8Os
	oY9KqylOxn22Xm339qbpQ8vX5r/Xa01FFXIkrMNpeGXzunYowzyYcs8tyV75Rg+R49fANmtX4Er
	SlsQDGoV30kEWUjjq1AkCw5oidV8JWgJUAj9QM1Ez
X-Gm-Gg: AfdE7clKiq2VU8BjPk9W9ZuLJCTPCEqMTEL8+dnQDSfpa4prNg2PPQhrNaVFqDwv8kS
	d6ejwsN1QiheEg4Fhn2rUG44QgZCsHTAv8vMA7mAo35nP2JpZ6iDN3dCOpJEVQUvtWJ5SjfzXCe
	hQBBWRO/yVpfjUkGVbA7nqdqPbtY1N9CZoIb1pue1OU+2E9EdNtw+BTwPjvayqzPd0ZzDxpV3bo
	BeMtLRI78ULWTVKx8yr4A/w5ALM6jjpMLuPck6YcEoXqzftgZ3lxRFC7cDLZ9IQCNZIXak8AKVZ
	Nl1U0E3xOygjV4C0z9jyzuoxAh6G6Wq5sXVKR6EZrFgkyGoK8pyGzmSNnPGis9dRGzI3UrD74jE
	PSgeQ9p4JKPkQjnwZO20O1h/t/qVgMxLimoAzB/o=
X-Received: by 2002:a05:7022:623:b0:138:49ea:f463 with SMTP id
 a92af1059eb24-139d0c22beamr3720202c88.16.1782336797094; Wed, 24 Jun 2026
 14:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-sockmap-lookup-udp-leak-v1-0-05804f9308e4@rbox.co>
 <20260623-sockmap-lookup-udp-leak-v1-1-05804f9308e4@rbox.co>
 <87wlvoxdq1.fsf@cloudflare.com> <willemdebruijn.kernel.24d11e11d5dc0@gmail.com>
 <dd065bfb-52ce-48fd-b1ef-9c6166f714ed@rbox.co>
In-Reply-To: <dd065bfb-52ce-48fd-b1ef-9c6166f714ed@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 24 Jun 2026 14:33:05 -0700
X-Gm-Features: AVVi8CenWMo1L6C-o6EOGzBIYsJyV25RjaCHhELt7xS_6-7remiUvIF891YEneA
Message-ID: <CAAVpQUBHMrSiWqn0Zo_D7sUCLFdkKggduoijRdFtHx5CPiSpsg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Don't leak UDP socks on lookup-bind-release
To: Michal Luczaj <mhal@rbox.co>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 2:26=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 6/24/26 22:01, Willem de Bruijn wrote:
> > Jakub Sitnicki wrote:
> >> On Tue, Jun 23, 2026 at 08:03 PM +02, Michal Luczaj wrote:
> >>> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
> >>> sk_is_refcounted(unbound) =3D true, while sk_is_refcounted(bound) =3D=
 false.
> >>>
> >>> Because sockmap accepts unbound UDP sockets, a BPF program can increm=
ent a
> >>> socket's refcount via lookup. If the socket is subsequently bound, th=
e
> >>> transition from unbound to bound causes bpf_sk_release() to skip the
> >>> decrement of the refcount, causing a memory leak.
> >>>
> >>> unreferenced object 0xffff88810bc2eb40 (size 1984):
> >>>   comm "test_progs", pid 2451, jiffies 4295320596
> >>>   hex dump (first 32 bytes):
> >>>     7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
> >>>     02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
> >>>   backtrace (crc bdee079d):
> >>>     kmem_cache_alloc_noprof+0x557/0x660
> >>>     sk_prot_alloc+0x69/0x240
> >>>     sk_alloc+0x30/0x460
> >>>     inet_create+0x2ce/0xf80
> >>>     __sock_create+0x25b/0x5c0
> >>>     __sys_socket+0x119/0x1d0
> >>>     __x64_sys_socket+0x72/0xd0
> >>>     do_syscall_64+0xa1/0x5f0
> >>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>>
> >>> Maintain balanced refcounts across sk lookup/release: (re-)set
> >>> SOCK_RCU_FREE on proto update to treat the socket (whether bound or
> >>> unbound) as not requiring a refcount increment on (a RCU protected) l=
ookup.
> >>>
> >>> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for dat=
agram sockets")
> >>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >>> ---
> >>> Note: this issue is related to commit 67312adc96b5 ("bpf: reject unha=
shed
> >>> sockets in bpf_sk_assign").
> >>> ---
> >>>  net/ipv4/udp_bpf.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> >>> index ad57c4c9eaab..970327b59582 100644
> >>> --- a/net/ipv4/udp_bpf.c
> >>> +++ b/net/ipv4/udp_bpf.c
> >>> @@ -173,6 +173,9 @@ int udp_bpf_update_proto(struct sock *sk, struct =
sk_psock *psock, bool restore)
> >>>     if (sk->sk_family =3D=3D AF_INET6)
> >>>             udp_bpf_check_v6_needs_rebuild(psock->sk_proto);
> >>>
> >>> +   /* Treat all sockets as non-refcounted, regardless of binding sta=
te. */
> >>> +   sock_set_flag(sk, SOCK_RCU_FREE);
> >>> +
> >>>     sock_replace_proto(sk, &udp_bpf_prots[family]);
> >>>     return 0;
> >>>  }
> >>
> >> There is a side effect that an unhashed (unbound) UDP socket can now b=
e
> >> selected in sk_lookup with bpf_sk_assign.
> >
> > The commit does mention a related fix, beneath the ---, commit
> > 67312adc96b5 ("bpf: reject unhashed sockets in bpf_sk_assign").
> > That fixes a similar issue by exactly disallowing this:
> >
> >     Fix the problem by rejecting unhashed sockets in bpf_sk_assign().
> >     This matches the behaviour of __inet_lookup_skb which is ultimately
> >     the goal of bpf_sk_assign().
> >
> > So ..
> >
> >> Though perhaps that's for the
> >> better because TC bpf_sk_assign doesn't reject non-refcounted UDP
> >> sockets either, so we would have both socket dispatch sites behave the
> >> same way.
> >
> > .. there are two conflicting types of consistency here? Consistent with
> > __inet_lookup_skb or the TC bpf hook. Of those the first is the more
> > canonical.
> >
> >> Also, with this patch, if we insert & remove an unhashed UDP socket
> >> into/from a sockmap, we end up with an unhashed non-refcounted UDP
> >> socket. Not entirely sure if that is actually a problem or not.
> >>
> >> Willem, what is your take on having unhashed non-refcoted UDP sockets?
> >
> > I don't immediately see a problem, but I'm not an expert on SOCK_RCU_FR=
EE.
>
> Perhaps it's worth mentioning that unhashed non-refcounted UDP socket is
> already possible: first auto-bind via connect(AF_INET) (which also sets
> SOCK_RCU_FREE), then unhash via connect(AF_UNSPEC).

Setting SOCK_RCU_FREE itself should not cause a problem, but I think
we should take a step back.

AFAIU, 0c48eefae712 was to allow putting AF_UNIX SOCK_DGRAM sockets
into sockmap, not to allow using unconnected UDP sockets in sk_lookup etc.

Actually, v4 of the patch was implemented as such but did not get any feedb=
ack,
https://lore.kernel.org/bpf/20210508220835.53801-9-xiyou.wangcong@gmail.com=
/#t

... and v5 (the final commit) somehow removed the restriction for unconnect=
ed
UDP socket as well.
https://lore.kernel.org/bpf/20210704190252.11866-3-xiyou.wangcong@gmail.com=
/

Given the initial use case, sockmap redirect, is still blocked by
TCP_ESTABLISHED
check in sock_map_redirect_allowed(), I feel there is no point in supportin=
g
unconnected UDP sockets in sockmap.  It cannot get any skb from anywhere
(without buggy sk_lookup).
