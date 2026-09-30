Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636B3E1681
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802197; cv=pass; b=XBy51LWb+kvsIm4eTLwcj7evcqz4SDavgCGTALskxsFWsg3W/D2devvo9WIN7p2gjDpoaXKJnzVFe8JbmSJeEVOGfwH8wKn8v9xYeLEIFIMV8SbQIc2grrbRoA7xw4a6wGUh54UQrpapf/hquQHhDX8CGPpQwsx3aV/7sQWcYvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802197; c=relaxed/simple;
	bh=lIhm7UC2kT5ROrHVGw4LQXZLeUC0iPiXA/+b3RzceXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNMyLlvncjjnyZ8BmmtiH9RBHvX2QWHvYfA9Yq2nOQ2YWJ6bfeueWWyov6OT3zR1cFsOHPapreQydixjnkc+MEGZFnyUcNnM6lCYW7gd9qsQXMVqRv1RWCFDIm6Z93SOul3eTJEZilt7pA1276hCiUi3MUl2qmv82hyPi/jB0gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qd+iHHvI; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qd+iHHvI"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144ecebb6cbso2136271c88.3
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 14:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790802195; cv=none;
        d=google.com; s=arc-20260327;
        b=NJhmfN08+4cIeVheKQd2G2wUChoSc7XtoVAmunUSC/CVS6ZNTgwuGyU4D3wFrVFXMC
         rx+cpljYG+M6++NBBFXr6lKO2q0MRujh00Z0mtx9D+E41+tAIoHeFyZdloVxoKt97VKm
         u4cRWYcLZ5K4CHez2J3LbGbwE7HeLi17ZsVXQX96jNe6tcgCbVyhiDAT9TSewi9dwITg
         CHFBNySd+LknwgkNgdEqw6fHeVKLKYW9VixapbH0Hpt/CV3YJa0/Kca487oqzAyaMRcI
         evooj4zwehSt5KDhNsEG1OkvaaGJ/xebb38N38A0SdQ8IRdh04vL1w7b9nQrkoDkOmVD
         TBWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=alY1D4dr1/XbPo3crLHK96vQqmMKQi2M+hPvkA6+sWc=;
        fh=588sVmmzvUEEJBziH4VkQaVqh8Z0RgfolrKFkB8bhT0=;
        b=K66beSH+B37JAVCU54yXfIhdvWkbaOqtwzFRCz1nOg1Mlyk9ouT8pPGPpK0zRvZSlH
         EaCnd23awTj82Jq3YmgQ6VYQovq1SNKRI6spw8bZ2iHbsp4OLLntGi/iaBIir567DylX
         Wi+LepIwRNfRfuxo7VlvvL6qbZjEoU7gOY9sxxk/6jHxctqUvbZ3pSEl9XRhc1DYa7GZ
         kwxlbgCnUdZ3UTqNpoUs+eyVtDcwOwNQdSBo8hubEW5ClSxjbVPXN/97Dc18hW8nk9ez
         7LzbCMhCKbaQRkau0zYrGsN93gMunDrTEjVOeQJgaj+mQNEm6kBl2EXp3aEFAni7P8Fq
         JjNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790802195; x=1791406995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=alY1D4dr1/XbPo3crLHK96vQqmMKQi2M+hPvkA6+sWc=;
        b=Qd+iHHvIq2nIlrh4smLew+TTx3U7PRu78lh9sVRQK9PGesBC8GugKfzKQapihU3szW
         aOK0AIN+IwxqanoHxaE+P82yZ1twM2718k1TvgzvUUvI0afNRMHvlY03QvkpkRLVbxoW
         XRtIsHJSmfUatag3GNZqu6e9HtDsDsJuVB33QK65x+9+W2kI8EeaQLRzcCpTozTrfbxK
         FAJpvvfEh5WtqYiej2alLawVDh5CAMrbEHjHLyXlxy6T3/s3P5NA+0+HxSqjIczqbgIw
         nkmSzB69asGhGWSzbW0nLLBMdnszuSziatPjUgX+28yLQzQCg/aPbIwqyGlLIUq2GKN4
         kgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790802195; x=1791406995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alY1D4dr1/XbPo3crLHK96vQqmMKQi2M+hPvkA6+sWc=;
        b=XAY406XTNzLPYmByyOTRdCUR38TDy1tku/RwhzefQXVUdI3kKBYYRVksdbtZVzhgZG
         bthIgui7QwZo32JR+nSYCNppNwZg17lUXvlWghxmh2bcoFFXjgAoJ1qL+GbNE8DXlMsm
         z9KQewjlL0YfJgZeLTzp9QqzCIYMiy+CCLbgOqmQ58HttWyQpknjfOHFToVcsl7pi2x3
         3O85e2PeG5sM3YDYb16jvr5Ju+xO2EIp4nZST7O/tXr5UR5TtPY+IVOXRNES8Jo/Av9H
         UmyqhnOqnZP7kM9Iw3L7PraNKxdNz8g4QWZtb+aS/bK7By3OcudGvXXuwxOKUK+TOE+C
         m21A==
X-Forwarded-Encrypted: i=1; AKwUvBw2x9rdrhNnYARkdBLkeM5bb+gvYxLX2nkeSfOmXfyYRn8If1RtZCesg9C0ZywXX71bPUo=@vger.kernel.org
X-Gm-Message-State: AFuF++kWRVB9t9XJZfmvwIVSog9zDP+lKE3qEL/M2rLqaa59Gsme5jrf
	KhlL7TDlZHg6ANp+Hfxt2rxOWZNf3tcgEThnsgUDt+wLQIaISUBQHV8P7rvRwPN8Ad6mmY7br1O
	wN4Is6+EKYqB5S8eqVMq7HYVE5w3GpeMdiWs7Glw2
X-Gm-Gg: AYBFou24tqRAhJqRCZsPFjQdWHRjIAPxmhjA4nuVYxqt/6117rQOXHM2r+fz87PZjwg
	5sZ9+0Dq4fU7b74dhwI/ZdMBybXCH6siranZo3RS8+GARoRQ+KHUyX1aYQyCtjj2AvWyDNe1pKU
	9gkE7DfJWbKz6wvD9K5i/61hcC/PJT9yGYRJDC213BRu2Bagsxtt9t/+WlARoUltKpc0aGam+xQ
	IpCExTYwCgAXX2pH/WD/5TIobzkBAGwHR2Taf0kkzqQv3Z3pJhQ5Bl9N73W11oTrJA2Foob/TqT
	9cH5b9vTybBh+fJ1jtvf7niUH4h1NmuQjroiw3MnrcWcXM2ogydaruO5LXOGkSQMFsRJiOTNWn0
	9oRGZjFBfI7Q1UPNIgqiI2YZ5PZdDOkQCLbXoi1nT8AyUFRyhqd5yvuN5zh3pJXY7yUZSWolQA3
	4gpKDho4nzq61txc9B3LxtzUXQOY/4Du32V30=
X-Received: by 2002:a05:7022:ed02:b0:144:fa79:174 with SMTP id
 a92af1059eb24-14d33f39d82mr1949574c88.44.1790802193969; Wed, 30 Sep 2026
 14:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMB2axN93iJnrZAk6hWraSnz32FtRDdpz_UbzsVB4YU7gRK_3Q@mail.gmail.com>
 <20260927001921.604064-1-kuniyu@google.com> <CAMB2axMwBuz3X4Uwn5uzZUqm91EbiMnbQX832wUFOQ44fOwDnQ@mail.gmail.com>
In-Reply-To: <CAMB2axMwBuz3X4Uwn5uzZUqm91EbiMnbQX832wUFOQ44fOwDnQ@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 30 Sep 2026 14:03:02 -0700
X-Gm-Features: AclHuK84XmHn8n--BuXAOq17HM-w4ciTYGzcvqjBetaRb-dVT79FM-kQwsYTBYA
Message-ID: <CAAVpQUCRm-7HqHT2ViSraEWkxF_QWiGJb93fx_BOwPgD2aUtuA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
To: Amery Hung <ameryhung@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, bpf@vger.kernel.org, 
	cleger@meta.com, daniel@iogearbox.net, eddyz87@gmail.com, edumazet@google.com, 
	john.fastabend@gmail.com, kuni1840@gmail.com, martin.lau@linux.dev, 
	memxor@gmail.com, ncardwell@google.com, netdev@vger.kernel.org, 
	sdf@fomichev.me, ukyab@berkeley.edu, willemb@google.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 12:56=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Sat, Sep 26, 2026 at 5:19=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > From: Amery Hung <ameryhung@gmail.com>
> > Date: Fri, 25 Sep 2026 10:33:50 -0700
> > > On Thu, Sep 24, 2026 at 6:41=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Thu, Sep 24, 2026 at 05:39 PM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> > > > >> can we drop the flag ?
> > > > >> hdr_opt_len() is called for every tx skb without per-socket opt-=
in.
> > > > >
> > > > > Oh, I assumed bpf_tcp_ops keeps the same behaviour.
> > > >
> > > > bpf_tcp_ops were moved out of BPF_SOCK_OPS_TEST_FLAG() guards on
> > > > purpose. None of the existing members has per-socket opt-in.
> > > > hdr_opt_len() runs for every tx skb, rtt() for every rtt sample.
> > > > See the log of commit 3bb54768fe3e
> > > > ("bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_=
ops"):
> > > > "A per-member/per-cgroup gate could be added later if the extra
> > > > fast-path work proves measurable."
> > > >
> > > > > We have a bpf prog to turn the hook on (from cgroup_skb/ingress),
> > > > > only when ingress rate exceeds the allocated capacity, to signal =
that
> > > > > via a custom TCP option and turn the hook off from the hook itsel=
f.
> > > > > (and I planned to post another patch for that)
> > > >
> > > > That should work today without another patch and without the flag.
> > > > cgroup_skb/ingress prog does
> > > >   bpf_sk_storage_get(&map, sk, 0, BPF_SK_STORAGE_GET_F_CREATE);
> > > > when the rate is exceeded. hdr_opt_len() and write_hdr_opt() do
> > > >   bpf_sk_storage_get(&map, sk, 0, 0);
> > > > and return when it's NULL. write_hdr_opt() calls
> > > > bpf_sk_storage_delete() after the option went out.
> > > > cg_skb_func_proto() has both helpers and get_func_proto() in
> > > > bpf_tcp_ops.c allows them in every member.
> > > > egress_read_sock_fields() in test_sock_fields.c does the cgroup_skb
> > > > part.
> > > >
> > > > > Anyway, is it because calling bpf prog is not very expensive
> > > > > or per-prog switch is preferable to per-socket flag ?
> > > >
> > > > The switch is still per socket. It's sk_storage instead of a bit in
> > > > tcp_sock, so every prog has its own.
> > > >
> > > > While such new flag is per socket, but it's one for all progs.
> > > >
> > > > And you want to take the last bit of u8 bpf_sock_ops_cb_flags...
> > > >
> > > > As far as the cost. A socket that didn't opt in pays for an indirec=
t
> > > > call into the prog and for bpf_sk_storage_get() that finds nothing,
> > > > but only in cgroups where bpf_tcp_ops with enqueue_rcvq is attached=
.
> > > > The members that are not set are NULL and bpf_tcp_ops_call() skips
> > > > them. That's what hdr_opt_len() costs on tx.
> > > >
> > > > I don't remember what Amery measured, but worth benchmarking
> > > > for your case.
> > >
> > > I did not benchmark the initial bpf_tcp_ops patch set, so per-socket
> > > gating was deferred. Before deciding whether to add such a gate for
> > > AutoLOWAT, could we compare:
> > >
> > > 1. No bpf_tcp_ops attached.
> > > 2. No-op enqueue_rcvq() and dequeue_rcvq() callbacks attached.
> > > 3. The same callbacks performing an sk-local-storage lookup (or maybe
> > > rhashtable).
> >
> > I used tcp_rr (128 threads, 20000 flows) and didn't see a big
> > perf diff between 1. and 2., but 3. showed some costs even when
> > only looking up sk_storage and returning immediately:
>
> Hey, sorry for the late reply.
>
> Your result gave me some hope that we could implement the gate in the
> BPF program, since callback dispatch appeared cheap.
>
> However, my experiment with several program-local gate implementations
> produced a different result. I ran the experiment using hdr_opt_len().
> Except for the baseline, every case else had bpf_tcp_ops attached, and
> only the hdr_opt_len member changed. I used loopback tcp_rr with 128

Thanks for testing.  To be fair, I used two machines on the same rack,
and it seems loopback has bottleneck on CPU rather than network,
less relaxed.


> threads and 20,000 flows. All lookups missed, modeling sockets that
> had not opted in.
>
> |.                     | Throughput (tx/s) | diff   | diff (abs)     |
> |-----------------------|-------------------|--------|----------------|
> | no tcp_ops            | 2,231,461         | --     | --             |
> | attached, NULL member | 2,200,750         | -1.38% | -30,711 tx/s   |
> | no-op                 | 2,172,596         | -2.64% | -58,865 tx/s   |
> | sk-storage            | 2,159,986         | -3.20% | -71,475 tx/s   |
> | RHASH                  | 2,156,491         | -3.36% | -74,970 tx/s   |
>
> The NULL-member result measures the cgroup struct_ops dispatch and
> array scan. The difference from NULL member to no-op measures the
> indirect call and trampoline, while the remaining difference measures
> the program-local lookup.
>
> Although hdr_opt_len() has a different signature and call frequency
> from the RCVQ hooks, all three layers have observable fast-path
> overhead. A program-local gate cannot avoid the dispatch and
> trampoline costs. Therefore, a per-socket gate before dispatch seems
> worthwhile for conditional hot-path callbacks.
>
> >
> >                     |    w/o bpf    |     w/ bpf    |  diff   |  diff (=
abs)
> >  -------------------+---------------+---------------+---------+--------=
-----
> >  num_transactions   | 1,209,349,692 | 1,185,180,017 |  -2.00% | -24.17M=
 tx
> >  throughput (tx/s)  | 20,318,689.83 | 19,953,668.49 |  -1.80% | -365.0K=
 tx/s
> >  remote_throughput  |    19,472,629 |    19,135,463 |  -1.73% | -337.2K=
 tx/s
> >  latency_min        |      50.83 us |      46.08 us |  -9.34% | -4.75 u=
s
> >  latency_p25        |     911.35 us |     911.35 us |   0.00% | 0.00 us
> >  latency_p50        |     972.79 us |     983.03 us |  +1.05% | +10.24 =
us
> >  latency_mean       |     983.64 us |   1,001.71 us |  +1.84% | +18.08 =
us
> >  latency_p90        |   1,136.63 us |   1,187.83 us |  +4.50% | +51.20 =
us
> >  latency_p95        |   1,208.31 us |   1,259.51 us |  +4.24% | +51.20 =
us
> >  latency_p99        |   1,392.63 us |   1,454.07 us |  +4.41% | +61.44 =
us
> >  latency_stddev     |     141.82 us |     158.53 us | +11.78% | +16.71 =
us
> >  cpu time (u+s, 60s)|     8,165.91s |     8,312.57s |  +1.80% | +146.66=
s
> >
> >
> > Given the other hooks in the fast path (hdr_opt_len(),
> > parse_hdr(), etc) should add costs at the same level,
> > I think we should guard them with flags.
> >
> > But u8 is too small, so I think we could add a new field
> > (maybe u32?) and a new kfunc for bpf_tcp_ops only.  Also,
> > I'd add CONFIG_BPF_SOCK_OPS_LEGACY to save some calls.
> >
> > What do you think ?
>
> A separate bpf_tcp_ops mask in tcp_sock seems reasonable.

I will add another flag and kfunc in the next version.


>
> CONFIG_BPF_SOCK_OPS_LEGACY seems premature considering we don't have
> feature parity with sockops at this moment (not saying we need to
> fully duplicate though).

This can be a separate topic, and I also think we don't need
feature parity.  I think some hooks are not used in many
deployments.


>
> >
> >
> > >
> > > >
> > > > >> The prog in patch 8 already returns when the socket has no
> > > > >> sk_storage.
> > > > >
> > > > > Yes, but this is only for bpf verifier.
> > > >
> > > > tcp_init_autolowat_cb() can be the only place that passes
> > > > BPF_SK_STORAGE_GET_F_CREATE.
> > > > So for a socket that didn't do setsockopt(BPF_TCP_AUTOLOWAT)
> > > > other cbs will return NULL on lookup.
> > > >
> > > > tcp_disable_autolowat() will do:
> > > >   bpf_sk_storage_delete(&tcp_autolowat_map, sk);
> > > >   bpf_tcp_ops_set_rcvlowat(sk, 1);
> > > >
> > > > > Just an idea, would it make sense to add a kfunc to move bpf_tcp_=
ops
> > > > > callback to a shadow pointer by allocating sizeof(bpf_tcp_ops) * =
2 ?
> > >
> > > A bpf_tcp_ops instance is shared by all sockets, so this would not
> > > provide per-socket gating. Making it per-socket would require copying
> > > the callback table for every tcp_sock, which seems more complex than
> > > adding a gate directly to tcp_sock.
> > >
> > > Am I understanding your idea correctly?
> >
> > Yes, but this is overkill indeed.  I think most deployments
> > use just a single SOCK_OPS/bpf_tcp_ops, and per-scoket flag
> > would be enough.
