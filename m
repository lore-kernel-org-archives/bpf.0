Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2A43B1B4
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790468365; cv=none; b=BKkPnwhF3Q21k5/3mulasKyg9KbwRXP0Uj14wM9wd9zF5N78gBHmZuFOrdinMreHLmZUSP+m0V4vxc4fO8Q/wZ+OcyT2cpsqtdjqAW7i1wWaB9sSJDXhoqahgL/BhG9bQ6NUjIwT4ESGN8EmFNr4qeUlv0xKMr2mvZVIRzAQ7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790468365; c=relaxed/simple;
	bh=OpxJJg/lpzy9Omuc4zH4GerzVWXFIKf5U5NmmEG2bEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ch/nZ+OyXVItzGBEL2zdZtkUdwsb7WvG0gJy6J+98lIwk53WqqmobK7n06TIq90lkg5qXchPcUIblYh9GBcqJVBWBqOPSpsP65vuzIMyb4PZW5nuBeO4PXMASK0u+UMAVp2yOOvwsuYxB6k0sQ9JfMdZYa+pMLzfUDHhboMqPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNVQY3zH; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNVQY3zH"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-385d2703b64so2383813a91.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 17:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790468363; x=1791073163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IEdIa9RMQ1QXL88PLw7o/+9OHA7bgZryG9p24nbS8RY=;
        b=VNVQY3zH4TF2gZ50SdretIZ4V1n7t7i7ZrEer29/sqT1/8dzeGsIlNkBM1UoQDjkqo
         cU6T2x9B9vGma8LeKaxCcl0ohuHeA2ArxlWxy+A75CLc3KJ8f2X520lnXsSSC9A/ftlS
         gB7rz8C1EcinpLiqB2Y0yViH54kFohLGUvhJme6xLt6XfGrWzR7wcsaqY5EJ81NWrHwu
         Vi7KnsjFER9lzo3Y9tJNqjaIdODY2ZyDlwTr/dM2eHekDEnxqthmaH5JGjkHbhy4kJB2
         MQp3rTDYAs7v1CVUxN4tufCXDiXCJ/VaZO2YYVjKCzcuXnOO89XBDqxkmSxjx6uF+Hpb
         XaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790468363; x=1791073163;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IEdIa9RMQ1QXL88PLw7o/+9OHA7bgZryG9p24nbS8RY=;
        b=PdGlG8CKaO4gzC0oBo71jUmF/n8Y7TQ/ZGyZJ1kYBHTV9ucgEYP3F3fNn0MRy0zVuj
         nmx+eKM80TzfgWZRNrdFdn8+Le8ni8FFeiKW/sTL6QO9DLEUAy0vW9MiLKeqdhNxyEOT
         uxo9cgrNlx5DdRrASXBA9IauKleGTuVcZu5qFEAjti6zkjsNmRWqEGbgfAp6GbNMkG7U
         MhZctMrMOA5FNs+jSIQ1cr8zqAHZw+w72mKy9xl6a7t/JLaVcU2aCH1VlHET3Ei+Xrin
         NwUMQf4zEVEdRski2Nq/jRp1n3y8o9XqLBB62xVObUsOs0R6Ut0TJNokA506LB8dBkw/
         kGLg==
X-Forwarded-Encrypted: i=1; AKwUvBydQsWPIxoKGhYzJbLzyquRiGMIq+75z8YZnEFcPl+B0fMie4LulyGUUF/y/fJku5gZV1w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHvpO9X8ul+L+CQkEkvFovJDzpXczT3hTKKrvC5Iz8YWAf/ytP
	QrrX02TggIM+OKnKqEQNmqUa948q5Z9be/4DHa21tzfannm7vn0JWaLiWUSEzC7cyQPT34bH+NH
	gQWtGVw==
X-Received: from pjbhs10.prod.google.com ([2002:a17:90b:200a:b0:3a0:e233:a080])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2250:b0:39e:6c68:fd93
 with SMTP id 98e67ed59e1d1-3a098b92bf7mr5492586a91.40.1790468362413; Sat, 26
 Sep 2026 17:19:22 -0700 (PDT)
Date: Sun, 27 Sep 2026 00:18:38 +0000
In-Reply-To: <CAMB2axN93iJnrZAk6hWraSnz32FtRDdpz_UbzsVB4YU7gRK_3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAMB2axN93iJnrZAk6hWraSnz32FtRDdpz_UbzsVB4YU7gRK_3Q@mail.gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260927001921.604064-1-kuniyu@google.com>
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: ameryhung@gmail.com
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, bpf@vger.kernel.org, 
	cleger@meta.com, daniel@iogearbox.net, eddyz87@gmail.com, edumazet@google.com, 
	john.fastabend@gmail.com, kuni1840@gmail.com, kuniyu@google.com, 
	martin.lau@linux.dev, memxor@gmail.com, ncardwell@google.com, 
	netdev@vger.kernel.org, sdf@fomichev.me, ukyab@berkeley.edu, 
	willemb@google.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 25 Sep 2026 10:33:50 -0700
> On Thu, Sep 24, 2026 at 6:41=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Sep 24, 2026 at 05:39 PM Kuniyuki Iwashima <kuniyu@google.com> =
wrote:
> > >> can we drop the flag ?
> > >> hdr_opt_len() is called for every tx skb without per-socket opt-in.
> > >
> > > Oh, I assumed bpf_tcp_ops keeps the same behaviour.
> >
> > bpf_tcp_ops were moved out of BPF_SOCK_OPS_TEST_FLAG() guards on
> > purpose. None of the existing members has per-socket opt-in.
> > hdr_opt_len() runs for every tx skb, rtt() for every rtt sample.
> > See the log of commit 3bb54768fe3e
> > ("bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops"=
):
> > "A per-member/per-cgroup gate could be added later if the extra
> > fast-path work proves measurable."
> >
> > > We have a bpf prog to turn the hook on (from cgroup_skb/ingress),
> > > only when ingress rate exceeds the allocated capacity, to signal that
> > > via a custom TCP option and turn the hook off from the hook itself.
> > > (and I planned to post another patch for that)
> >
> > That should work today without another patch and without the flag.
> > cgroup_skb/ingress prog does
> >   bpf_sk_storage_get(&map, sk, 0, BPF_SK_STORAGE_GET_F_CREATE);
> > when the rate is exceeded. hdr_opt_len() and write_hdr_opt() do
> >   bpf_sk_storage_get(&map, sk, 0, 0);
> > and return when it's NULL. write_hdr_opt() calls
> > bpf_sk_storage_delete() after the option went out.
> > cg_skb_func_proto() has both helpers and get_func_proto() in
> > bpf_tcp_ops.c allows them in every member.
> > egress_read_sock_fields() in test_sock_fields.c does the cgroup_skb
> > part.
> >
> > > Anyway, is it because calling bpf prog is not very expensive
> > > or per-prog switch is preferable to per-socket flag ?
> >
> > The switch is still per socket. It's sk_storage instead of a bit in
> > tcp_sock, so every prog has its own.
> >
> > While such new flag is per socket, but it's one for all progs.
> >
> > And you want to take the last bit of u8 bpf_sock_ops_cb_flags...
> >
> > As far as the cost. A socket that didn't opt in pays for an indirect
> > call into the prog and for bpf_sk_storage_get() that finds nothing,
> > but only in cgroups where bpf_tcp_ops with enqueue_rcvq is attached.
> > The members that are not set are NULL and bpf_tcp_ops_call() skips
> > them. That's what hdr_opt_len() costs on tx.
> >
> > I don't remember what Amery measured, but worth benchmarking
> > for your case.
>=20
> I did not benchmark the initial bpf_tcp_ops patch set, so per-socket
> gating was deferred. Before deciding whether to add such a gate for
> AutoLOWAT, could we compare:
>=20
> 1. No bpf_tcp_ops attached.
> 2. No-op enqueue_rcvq() and dequeue_rcvq() callbacks attached.
> 3. The same callbacks performing an sk-local-storage lookup (or maybe
> rhashtable).

I used tcp_rr (128 threads, 20000 flows) and didn't see a big
perf diff between 1. and 2., but 3. showed some costs even when
only looking up sk_storage and returning immediately:

                    |    w/o bpf    |     w/ bpf    |  diff   |  diff (abs)
 -------------------+---------------+---------------+---------+------------=
-
 num_transactions   | 1,209,349,692 | 1,185,180,017 |  -2.00% | -24.17M tx
 throughput (tx/s)  | 20,318,689.83 | 19,953,668.49 |  -1.80% | -365.0K tx/=
s
 remote_throughput  |    19,472,629 |    19,135,463 |  -1.73% | -337.2K tx/=
s
 latency_min        |      50.83 us |      46.08 us |  -9.34% | -4.75 us
 latency_p25        |     911.35 us |     911.35 us |   0.00% | 0.00 us
 latency_p50        |     972.79 us |     983.03 us |  +1.05% | +10.24 us
 latency_mean       |     983.64 us |   1,001.71 us |  +1.84% | +18.08 us
 latency_p90        |   1,136.63 us |   1,187.83 us |  +4.50% | +51.20 us
 latency_p95        |   1,208.31 us |   1,259.51 us |  +4.24% | +51.20 us
 latency_p99        |   1,392.63 us |   1,454.07 us |  +4.41% | +61.44 us
 latency_stddev     |     141.82 us |     158.53 us | +11.78% | +16.71 us
 cpu time (u+s, 60s)|     8,165.91s |     8,312.57s |  +1.80% | +146.66s


Given the other hooks in the fast path (hdr_opt_len(),
parse_hdr(), etc) should add costs at the same level,
I think we should guard them with flags.

But u8 is too small, so I think we could add a new field
(maybe u32?) and a new kfunc for bpf_tcp_ops only.  Also,
I'd add CONFIG_BPF_SOCK_OPS_LEGACY to save some calls.

What do you think ?


>=20
> >
> > >> The prog in patch 8 already returns when the socket has no
> > >> sk_storage.
> > >
> > > Yes, but this is only for bpf verifier.
> >
> > tcp_init_autolowat_cb() can be the only place that passes
> > BPF_SK_STORAGE_GET_F_CREATE.
> > So for a socket that didn't do setsockopt(BPF_TCP_AUTOLOWAT)
> > other cbs will return NULL on lookup.
> >
> > tcp_disable_autolowat() will do:
> >   bpf_sk_storage_delete(&tcp_autolowat_map, sk);
> >   bpf_tcp_ops_set_rcvlowat(sk, 1);
> >
> > > Just an idea, would it make sense to add a kfunc to move bpf_tcp_ops
> > > callback to a shadow pointer by allocating sizeof(bpf_tcp_ops) * 2 ?
>=20
> A bpf_tcp_ops instance is shared by all sockets, so this would not
> provide per-socket gating. Making it per-socket would require copying
> the callback table for every tcp_sock, which seems more complex than
> adding a gate directly to tcp_sock.
>=20
> Am I understanding your idea correctly?

Yes, but this is overkill indeed.  I think most deployments
use just a single SOCK_OPS/bpf_tcp_ops, and per-scoket flag
would be enough.
