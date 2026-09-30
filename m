Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171D46A60C
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798194; cv=pass; b=eWmTSPd9sOaIKtWW5He5QSOf/3CN1ROgKfgeZy4eN3SIeV2RVdLFD9fkpjCsyh1bQKXv8TPFUegD2WBTAXJt9oYepXwWXkssGg+GWuDhxgnFdAgRLQF1r2GLn92dZIVjoLQFaKNikSPvcSAwYwAnqy2JF221kbft1pdnoWzQJgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798194; c=relaxed/simple;
	bh=6qKTd/+Z/MIztcMAr1rNEuiJ3PiSEWXnW4vosW6VT+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWgwiO1wju6apNCYmxSHe9iMa2FyZNz67lUfoc7MdamGehwKsdmj/sOr71osYIrQMhhEK7UwV7BX3MUZ+EZRk9a7c2XgxFHmRLvye467Or+SjujBXYOjbSAmpBangoN3H+dMcexUr+GSfsMOrlR46mSfkHTWcUSmJXXlAuHu2M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clFOX5B+; arc=pass smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clFOX5B+"
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6d762782f99so2198907eaf.0
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790798191; cv=none;
        d=google.com; s=arc-20260327;
        b=MujGtJTB3bPPWIh1RS6UiBySyM807istTyi6hjRvBw58oKV4LkKtGb7NMgUndW6mYG
         OOXI9BnY28msvTYtDkRgI7SDkryZ8xHlOaHqixopfVvTfMGNV0MEtColSR5dOiWgLrOQ
         pXCbwMY+09xPdmRuC5RMsbJGKIxC+/CipXKZCWvvIMNo+ywLSQ/Srk9v1lMbmM5/Xjn2
         LoaF9O5+0YVH6vczrJJKIH+GJweNMME9soKd2GyVHUBD3d1Iajsbj14Q+C1W47uTRhIc
         1h5OvOIBRAOw/zxH5qdTXD6GVMYKeM4GyK5bxT6bJ8E1k91+UX+FuTz2TPhVjaKcYpOF
         U/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w0F37B+tLOjIaslCd8r67I+DKgBg3+OILi1YY5eM99c=;
        fh=UYcnBMP5m43eQTTAuROb86dW1wxg77kqyiY5utYDC1Q=;
        b=eKlD3f2uMtkNWu5FozhSpR2yb5B0xuiBWj13RbDsSjeMzYACCYsgqD59yiWMZxdvOg
         bZH7N6YOAumo5RXJSqEx9IHCMfrweGebPN1oMKVIROxn1T6hrHdMEwmwn+AI8TscIWHY
         k5MIR+xGkubM63x3sqFZDQyXPM3thTkoroijztu3EdooSRa0AhGmzLJmG20aNoZJphaF
         Ip5X0hB3FhyPKHd8CnGJJRJO/BxmMFbAiZyaKhnjgK5fXfxrJPJiw4oI8C/EsRk9SaTc
         ULaUlSLs+REC00u1vmL1d9Yt9/uyRj05+e2g6yfyVOYYiWCbMnSGxna6S/AA7j2lxSP3
         YXzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790798191; x=1791402991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w0F37B+tLOjIaslCd8r67I+DKgBg3+OILi1YY5eM99c=;
        b=clFOX5B+49mG2+PYTWYlp89p2vZzGxQFDTpU/mbpeJGBvxvnMsOactlmswO8SXWpo3
         L1cWYTpXjyUZyI6gDW3chb581+yrZYGuNOmJO01MjTvTO8CuHbgkBBUP2YKKG8SGoaq2
         evfmwWXNjKoOztEAmh1PMmT6j+Ff12PVjvT25sEPzrQSEv4JeS9L8S2h74nJfbXfpgSV
         K2EHUBNchOczSdsO1jmiis9wQ3YFkyLGadOmvGIjgLLv8+4GdGbk19Hf4j9vzmA8SXZR
         VrTT8DOnItXcg4CPhqbi5XuK3sn5HItpV/nz61BA5jubEgN8Dqp9P/+Dj+ES3ZT/NkBN
         6rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798191; x=1791402991;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w0F37B+tLOjIaslCd8r67I+DKgBg3+OILi1YY5eM99c=;
        b=flvr+4I+mnCVbco9rypm3XbChEv/0b0ldj3bWsrULIYmq7hzcVgrQrkoBMC9E3JDlF
         eHqtEpJixiymDD54Y/RldusNydzlpGM7XZOwa0nOQP/UbeiZnhUmQFe/3w8dLkPVJQ83
         nYXQk7PbTxMPwsKTDDcZzkxy66U19QtuX0m+DsSAZZRCSLcH5fbj9v7J0Y6S6b1aBTJK
         T3LLN7X15SSLDxKI8gy1V/MZzxDLfGywhJPLogZjq0UTV6z9okyyqNEpOWGlQy6zM3Ht
         LJBw54VYtTyGsCp38yc/ax2GXHroQvwXpsw2IxQ2W8B4iwcRQtNCjHexbsKBHBGzgI2n
         z/+A==
X-Forwarded-Encrypted: i=1; AKwUvBxxGCiJGc/ZuyMVpgBjFP8g3pgYeKTm4C0EbxDpMzsupgiJumywYN4/ooG6RtpB8cSoRtk=@vger.kernel.org
X-Gm-Message-State: AFuF++lub5GM+KGwijVs2ufnRSOJ5FzjRUomon6pLam8F/6V3F7qqbBy
	a2fJP4YRhJhKT5VRTr8a/4gkgsou7M/M4C0DAJTW1dtP+kCV4dHW/zYypaBJEVWFUNJCcGfKqXo
	dV75nBOHI5QoX0jHQbJzZ/SNqz7tDYmg=
X-Gm-Gg: AYBFou3JgyLqtQTIQl/XouqL7LtrqtMmNJ5hJ9McMp9XxTkQRTy8C8PIO/27ZJF2VbD
	hY8DWwk3wS5gBwCFU2nwhvsAaaxV3nm5CKSaIbyZs1JrlqQ/sQs/97fev7Y7UUoCqs2+SlcUWI/
	HWn4bB0p2q1wcMkoSFWDhJHTuHKe/mg5nnMnVidZCadVQ7sSTKi5/c13egyoAJNuV/GGd1mZW1f
	d5YyqKfhZxqbZugSvejpVPODnRKa0upzSx3FnFNWTm96KDVAvpl+lDtNlUlSoAZjRvLFdNmwkt5
	iu9L9r+i8HIW7eZaBD7orIACyR/oOrhdZsVHfAEgAZ5duud5hNOPZtgbV9KJfxQ/tw==
X-Received: by 2002:a05:6820:1985:b0:6b7:83c5:fde2 with SMTP id
 006d021491bc7-6dcf5052d1cmr2596155eaf.35.1790798191384; Wed, 30 Sep 2026
 12:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMB2axN93iJnrZAk6hWraSnz32FtRDdpz_UbzsVB4YU7gRK_3Q@mail.gmail.com>
 <20260927001921.604064-1-kuniyu@google.com>
In-Reply-To: <20260927001921.604064-1-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 30 Sep 2026 12:56:19 -0700
X-Gm-Features: AclHuK-j5DkZW6uMypd7HzN1Uf8VarzMnBABD-LSBVTFOv9w4EJ9zco0I2JQLao
Message-ID: <CAMB2axMwBuz3X4Uwn5uzZUqm91EbiMnbQX832wUFOQ44fOwDnQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, bpf@vger.kernel.org, 
	cleger@meta.com, daniel@iogearbox.net, eddyz87@gmail.com, edumazet@google.com, 
	john.fastabend@gmail.com, kuni1840@gmail.com, martin.lau@linux.dev, 
	memxor@gmail.com, ncardwell@google.com, netdev@vger.kernel.org, 
	sdf@fomichev.me, ukyab@berkeley.edu, willemb@google.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> From: Amery Hung <ameryhung@gmail.com>
> Date: Fri, 25 Sep 2026 10:33:50 -0700
> > On Thu, Sep 24, 2026 at 6:41=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Sep 24, 2026 at 05:39 PM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
> > > >> can we drop the flag ?
> > > >> hdr_opt_len() is called for every tx skb without per-socket opt-in=
.
> > > >
> > > > Oh, I assumed bpf_tcp_ops keeps the same behaviour.
> > >
> > > bpf_tcp_ops were moved out of BPF_SOCK_OPS_TEST_FLAG() guards on
> > > purpose. None of the existing members has per-socket opt-in.
> > > hdr_opt_len() runs for every tx skb, rtt() for every rtt sample.
> > > See the log of commit 3bb54768fe3e
> > > ("bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_op=
s"):
> > > "A per-member/per-cgroup gate could be added later if the extra
> > > fast-path work proves measurable."
> > >
> > > > We have a bpf prog to turn the hook on (from cgroup_skb/ingress),
> > > > only when ingress rate exceeds the allocated capacity, to signal th=
at
> > > > via a custom TCP option and turn the hook off from the hook itself.
> > > > (and I planned to post another patch for that)
> > >
> > > That should work today without another patch and without the flag.
> > > cgroup_skb/ingress prog does
> > >   bpf_sk_storage_get(&map, sk, 0, BPF_SK_STORAGE_GET_F_CREATE);
> > > when the rate is exceeded. hdr_opt_len() and write_hdr_opt() do
> > >   bpf_sk_storage_get(&map, sk, 0, 0);
> > > and return when it's NULL. write_hdr_opt() calls
> > > bpf_sk_storage_delete() after the option went out.
> > > cg_skb_func_proto() has both helpers and get_func_proto() in
> > > bpf_tcp_ops.c allows them in every member.
> > > egress_read_sock_fields() in test_sock_fields.c does the cgroup_skb
> > > part.
> > >
> > > > Anyway, is it because calling bpf prog is not very expensive
> > > > or per-prog switch is preferable to per-socket flag ?
> > >
> > > The switch is still per socket. It's sk_storage instead of a bit in
> > > tcp_sock, so every prog has its own.
> > >
> > > While such new flag is per socket, but it's one for all progs.
> > >
> > > And you want to take the last bit of u8 bpf_sock_ops_cb_flags...
> > >
> > > As far as the cost. A socket that didn't opt in pays for an indirect
> > > call into the prog and for bpf_sk_storage_get() that finds nothing,
> > > but only in cgroups where bpf_tcp_ops with enqueue_rcvq is attached.
> > > The members that are not set are NULL and bpf_tcp_ops_call() skips
> > > them. That's what hdr_opt_len() costs on tx.
> > >
> > > I don't remember what Amery measured, but worth benchmarking
> > > for your case.
> >
> > I did not benchmark the initial bpf_tcp_ops patch set, so per-socket
> > gating was deferred. Before deciding whether to add such a gate for
> > AutoLOWAT, could we compare:
> >
> > 1. No bpf_tcp_ops attached.
> > 2. No-op enqueue_rcvq() and dequeue_rcvq() callbacks attached.
> > 3. The same callbacks performing an sk-local-storage lookup (or maybe
> > rhashtable).
>
> I used tcp_rr (128 threads, 20000 flows) and didn't see a big
> perf diff between 1. and 2., but 3. showed some costs even when
> only looking up sk_storage and returning immediately:

Hey, sorry for the late reply.

Your result gave me some hope that we could implement the gate in the
BPF program, since callback dispatch appeared cheap.

However, my experiment with several program-local gate implementations
produced a different result. I ran the experiment using hdr_opt_len().
Except for the baseline, every case else had bpf_tcp_ops attached, and
only the hdr_opt_len member changed. I used loopback tcp_rr with 128
threads and 20,000 flows. All lookups missed, modeling sockets that
had not opted in.

|.                     | Throughput (tx/s) | diff   | diff (abs)     |
|-----------------------|-------------------|--------|----------------|
| no tcp_ops            | 2,231,461         | --     | --             |
| attached, NULL member | 2,200,750         | -1.38% | -30,711 tx/s   |
| no-op                 | 2,172,596         | -2.64% | -58,865 tx/s   |
| sk-storage            | 2,159,986         | -3.20% | -71,475 tx/s   |
| RHASH                  | 2,156,491         | -3.36% | -74,970 tx/s   |

The NULL-member result measures the cgroup struct_ops dispatch and
array scan. The difference from NULL member to no-op measures the
indirect call and trampoline, while the remaining difference measures
the program-local lookup.

Although hdr_opt_len() has a different signature and call frequency
from the RCVQ hooks, all three layers have observable fast-path
overhead. A program-local gate cannot avoid the dispatch and
trampoline costs. Therefore, a per-socket gate before dispatch seems
worthwhile for conditional hot-path callbacks.

>
>                     |    w/o bpf    |     w/ bpf    |  diff   |  diff (ab=
s)
>  -------------------+---------------+---------------+---------+----------=
---
>  num_transactions   | 1,209,349,692 | 1,185,180,017 |  -2.00% | -24.17M t=
x
>  throughput (tx/s)  | 20,318,689.83 | 19,953,668.49 |  -1.80% | -365.0K t=
x/s
>  remote_throughput  |    19,472,629 |    19,135,463 |  -1.73% | -337.2K t=
x/s
>  latency_min        |      50.83 us |      46.08 us |  -9.34% | -4.75 us
>  latency_p25        |     911.35 us |     911.35 us |   0.00% | 0.00 us
>  latency_p50        |     972.79 us |     983.03 us |  +1.05% | +10.24 us
>  latency_mean       |     983.64 us |   1,001.71 us |  +1.84% | +18.08 us
>  latency_p90        |   1,136.63 us |   1,187.83 us |  +4.50% | +51.20 us
>  latency_p95        |   1,208.31 us |   1,259.51 us |  +4.24% | +51.20 us
>  latency_p99        |   1,392.63 us |   1,454.07 us |  +4.41% | +61.44 us
>  latency_stddev     |     141.82 us |     158.53 us | +11.78% | +16.71 us
>  cpu time (u+s, 60s)|     8,165.91s |     8,312.57s |  +1.80% | +146.66s
>
>
> Given the other hooks in the fast path (hdr_opt_len(),
> parse_hdr(), etc) should add costs at the same level,
> I think we should guard them with flags.
>
> But u8 is too small, so I think we could add a new field
> (maybe u32?) and a new kfunc for bpf_tcp_ops only.  Also,
> I'd add CONFIG_BPF_SOCK_OPS_LEGACY to save some calls.
>
> What do you think ?

A separate bpf_tcp_ops mask in tcp_sock seems reasonable.

CONFIG_BPF_SOCK_OPS_LEGACY seems premature considering we don't have
feature parity with sockops at this moment (not saying we need to
fully duplicate though).

>
>
> >
> > >
> > > >> The prog in patch 8 already returns when the socket has no
> > > >> sk_storage.
> > > >
> > > > Yes, but this is only for bpf verifier.
> > >
> > > tcp_init_autolowat_cb() can be the only place that passes
> > > BPF_SK_STORAGE_GET_F_CREATE.
> > > So for a socket that didn't do setsockopt(BPF_TCP_AUTOLOWAT)
> > > other cbs will return NULL on lookup.
> > >
> > > tcp_disable_autolowat() will do:
> > >   bpf_sk_storage_delete(&tcp_autolowat_map, sk);
> > >   bpf_tcp_ops_set_rcvlowat(sk, 1);
> > >
> > > > Just an idea, would it make sense to add a kfunc to move bpf_tcp_op=
s
> > > > callback to a shadow pointer by allocating sizeof(bpf_tcp_ops) * 2 =
?
> >
> > A bpf_tcp_ops instance is shared by all sockets, so this would not
> > provide per-socket gating. Making it per-socket would require copying
> > the callback table for every tcp_sock, which seems more complex than
> > adding a gate directly to tcp_sock.
> >
> > Am I understanding your idea correctly?
>
> Yes, but this is overkill indeed.  I think most deployments
> use just a single SOCK_OPS/bpf_tcp_ops, and per-scoket flag
> would be enough.
