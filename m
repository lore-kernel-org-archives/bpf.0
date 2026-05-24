Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EDE156C6A
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779595395; cv=pass; b=JBFUFVNspsU7GwW3qi/l6g+m72rNlZhNhPAIDf5e76eZmWMElt+uEF4YrTbJzNFu0eCdfHkDtYBMxsdpBT9ysrY2aIspLQ7ordGa0hj6orzCrjuoPqMg1lxeFLydns9+aeK6Rf2aJMIp0qzZ6b2NcROxiyvvJZLXUQbEnTbt9TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779595395; c=relaxed/simple;
	bh=UK6MqR13SkmVeNHAVhpbyuwZEqU27LqGTv2pP1kGcwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nq2SlY2s4yDNkhABI41bNfvBMpWyHzZ5+fVVmUrcXUjZ3ZjVtfFfTVugnuOwhTSM1wqZyvS03/COMlfDiQF/nEFQ6TqJPaqTf+deeTGRyhbd3WQZYE+juUDwZ4Ve/f7fnzK+bsfFsRxcFFnlRpnqyka+82Vi47C/6FxfeABlOvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KWUjpMVM; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KWUjpMVM"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-132d1b2519eso1496597c88.0
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 21:03:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779595393; cv=none;
        d=google.com; s=arc-20240605;
        b=SWsjFuGJISZUZFYVEMCZ6GkSb8d9ELG5haR588WyJ4sPCD018dbZtUgBZ48EawoL/7
         HLwyNSjoSnbMxbkFnrBD+vCFPGRKvuGk6r6Fhu+NLDwSuEvVgpk2sF3GydU0Mop/2pci
         q66sdvOGjQil+GEHSTP981XCtHfgcTHocgPGl05ClCyV7Oi88846ZGPT1MIjCz7FuEF2
         V0jAsNOC4f7BhTQ262Q1nQ215iNrFMXyn2rPOYluMO3I/hj/mh1hFxzF3h/wXdA728oc
         cak7aNWrgbTBeuCsGGuZ9SPbtyF3FRPPUr9/P6X89A5uALoZGpsVpYmp9c6aYNDyvnZY
         Utow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pWhZ7WvslVBCIrg7rQU2VQHwQRiE5+pLZxvQ9Rg/MVk=;
        fh=aF0nqNUhndkzu7mgxDxAFAlUD7xa6ZjZtE9unN45+8k=;
        b=KuYd4wEx0YzS7hnbOBYcLz2rjwgHAOI5T3FwwjY6VFsUOXoNfniWm/dVXBcvx9Dzv+
         mGY/qYFdcpYgF81GwPn3VcqyUlpRMTPXEdHaL4GVWbnSmxHlFqAMWnnpnZta/6RxHFLC
         9pj6wdE6zBhjq7Kqf3X2c3SwJRlFMaV9TUAi5KqcU6R21MKIlwf02zk75vYwZV5BQWgw
         hSoALwwCrQoE5dPDsuZr4duliZgeJRYiTqK4XlBhzc58IZ6WWgLo9HebTZX7AyVK6NMZ
         Q1E6iVIc65o8YI8Uk5NYmbveWnZAYvRmOrTAJdGEsH2vAN+uy3uKSEQ6FVdzIovi0RjZ
         8nMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779595393; x=1780200193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWhZ7WvslVBCIrg7rQU2VQHwQRiE5+pLZxvQ9Rg/MVk=;
        b=KWUjpMVMKmwLsVDu8/oOhgIEhoqhnaj3VWTd2KmIoZz1a2IXf1sDy35S/+88gsjgg6
         2uNSLXNEl/s5muzDRSNxOzYilgM1UUDfNSVNnqQWrpGMduAOEVqSjC9zll0sB2Zdaylx
         XnPmK4HChDmKzieYCB2tO80q2FHxMlHJ1JRGzmRzO0sWQMNr2moPnj9fUatOBoZq+/z4
         HSQWavJDuEo/zIC0MC/ojbsoz1MobLa8ggBypcyUeu/3UaGMoOcxPgthf37EyVFoib8A
         a/3odHKhMFfjy7fM1iOCmNhpMy/5zNvIiaZ3k0/wiGEMc/uzIslCn5qkzerHO6G0ie8u
         Bm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779595393; x=1780200193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pWhZ7WvslVBCIrg7rQU2VQHwQRiE5+pLZxvQ9Rg/MVk=;
        b=RqbI7yz/oFWH3577aud3i4Huhr4/V5VoOvQVs4DTVcH9JzLzF0+7dzOHGhkq0A8uzj
         7vPELQhN59NqcCcbsJG5RiLtelQ/yMlbesQInp0YJOguI5EvIToZmQRlcWDxxLxTDLgi
         WrdQT6XgzDcJ0DCuJ39Dqfee4sEc4hFvLHxQKcGLipCZIifF9oPjgPpSiyVZiNM3M3kD
         FrIiuzcIHpIO+Nd0okP75QZ/1lA92l8FKL9D2Q4J3RNHGyXxnIkXIVo728mS60syfbW/
         4kndTF+glRj0KO+cHvX+khugv1DCujo2aE50rXVEq9SjwCkd9d8IuulGRxi1t/mX/1Bz
         0RQw==
X-Forwarded-Encrypted: i=1; AFNElJ+5njdAaKCCV8I6v38CVPD8LkBDHS1IfI4KvkLvZSt3A5LCZ/y7ivkYYUtQdzoj7RGgMfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzae0v/Uqg4mBrbzHfziWmPYplPJ13eMMPNxH4IRaBd+saubpzI
	i+s5x1dWYIawN7q1QmijAPyTdwr9YH2zSY3QkyjB/5LpGF0wAItgbIEBJ/IQcSdIHV+CGNgbN9w
	/myLS9SVuaf3ZNhpXK+2z2Pr3mocdGFJxBLDWgZfC
X-Gm-Gg: Acq92OElENZNkz8pdvTeYzOxBCq/OhKvOdkrIRug0XIoDMLMkQWR89KqiNM6V8URDK1
	d4E+X9oiH7sVQuOLHu/gmOSfHTnxIGOxMWmGNtYd+TVPVYY4K0XiUjplh+/HeNRzO2CXgGfaOfD
	jIESokn101O9HDminvaFG3Q86QHnZbEp7qtV//nrO2SiRdtz3exnWqclc9ASbTa5Xx5N2s12Du5
	VZPsyFrv949ZNdUcHDeAH+UicP9dnCQlA9c+BKBStEoSoZlSFsvXF7+n4jY93gOAPwmUs5z/qKv
	v0TVMrQwNMu6QC1rFJAShlg89KNa6wosGtaPvhE46H8+4s+dsjhnpZPmm5KShwm0O4+z2FsQjWx
	FqkQtg6jBsaOfh2OESH+SLVAFJ01eIpiWTzj9lf0cm4ydotB2oOQOcO4qxFa04Fw=
X-Received: by 2002:a05:7022:699b:b0:132:d182:3dd6 with SMTP id
 a92af1059eb24-1365f91f913mr4048606c88.16.1779595392068; Sat, 23 May 2026
 21:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-12-kuniyu@google.com> <9f7f313051e697158ce96e5d9cc5c49bae934655e982d10f58230dfd5b5c1084@mail.kernel.org>
In-Reply-To: <9f7f313051e697158ce96e5d9cc5c49bae934655e982d10f58230dfd5b5c1084@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 23 May 2026 21:03:00 -0700
X-Gm-Features: AVHnY4L7xop31Ge6-JC1JxJ6HABZ9qVVsdLZDfxPzzi3TYfd4RegrKRm4lmeG50
Message-ID: <CAAVpQUC5Z+NFC5RTvAeqmHBExQa7jaTiEtdCBSLMJepO0neNMg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 11/11] selftest: bpf: Add test for BPF_SOCK_OPS_RCVQ_CB.
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me, 
	edumazet@google.com, ncardwell@google.com, willemb@google.com, 
	ukyab@berkeley.edu, kuni1840@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 2:20=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/s=
elftests/bpf/bpf_kfuncs.h
> > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > @@ -64,6 +64,10 @@
> >  extern int bpf_sk_assign_tcp_reqsk(struct __sk_buff *skb, struct sock =
*sk,
> >                                  struct bpf_tcp_req_attrs *attrs, int a=
ttrs__sz) __ksym;
> >
> > +struct bpf_sock_ops_kern;
> > +extern int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern *sko=
ps_kern,
> > +                                      int rcvlowat) __ksym;
> > +
> >  void *bpf_cast_to_kern_ctx(void *) __ksym;
> >
> >  extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __w=
eak;
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tool=
s/testing/selftests/bpf/progs/bpf_tracing_net.h
> > --- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> > +++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> > @@ -74,6 +74,8 @@ #define ETH_P_IPV6          0x86DD
> >
> >  #define NEXTHDR_TCP          6
> >
> > +#define TCPHDR_FIN           0x01
> > +
> >  #define TCPOPT_NOP           1
> >  #define TCPOPT_EOL           0
> >  #define TCPOPT_MSS           2
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c b/t=
ools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> > @@ -0,0 +1,350 @@
>
> [ ... ]
>
> > +             .event =3D {
> > +                     { .type =3D RPC_EVENT_AUTOLOWAT,  .val =3D 1},
> > +                     /* The first descriptor is partial. */
> > +                     {.type =3D RPC_EVENT_SEND,        .len =3D 1},
> > +                     {.type =3D RPC_EVENT_EPOLL,       .nfds =3D 0},
> > +                     {.type =3D RPC_EVENT_RCVLOWAT,    .rcvlowat =3D R=
PC_DESC_SIZE},
> > +                     /* The first descriptor is available. */
> > +                     {.type =3D RPC_EVENT_SEND,        .len =3D RPC_DE=
SC_SIZE - 1},
> > +                     {.type =3D RPC_EVENT_EPOLL,       .nfds =3D 0},
> > +                     {.type =3D RPC_EVENT_RCVLOWAT,    .rcvlowat =3D R=
PC_DESC_SIZE + 150 + 100},
> > +                     /* The first header is ready. */
> > +                     {.type =3D RPC_EVENT_SEND,        .len =3D 100},
> > +                     {.type =3D RPC_EVENT_EPOLL,       .nfds =3D 0},
> > +                     {.type =3D RPC_EVENT_RCVLOWAT,    .rcvlowat =3D R=
PC_DESC_SIZE + 150 + 100},
> > +                     /* skb has the first payload and 1 byte of the ne=
xt descriptor. */
> > +                     {.type =3D RPC_EVENT_SEND,        .len =3D 150 + =
1},
> > +                     {.type =3D RPC_EVENT_EPOLL,       .nfds =3D 1},
> > +                     {.type =3D RPC_EVENT_RCVLOWAT,    .rcvlowat =3D R=
PC_DESC_SIZE + 150 + 100},
> > +                     /* After reading the first RPC message, SO_RCVLOW=
AT should be RPC_DESC_SIZE. */
> > +                     {.type =3D RPC_EVENT_RECV,        .len =3D RPC_DE=
SC_SIZE + 150 + 100},
> > +                     {.type =3D RPC_EVENT_EPOLL,       .nfds =3D 0},
> > +                     {.type =3D RPC_EVENT_RCVLOWAT,    .rcvlowat =3D R=
PC_DESC_SIZE},
>
> Does calling recv() actually trigger the BPF program to update SO_RCVLOWA=
T?
>
> Since the kernel only invokes BPF_SOCK_OPS_RCVQ_CB when a new skb is adde=
d
> to the receive queue, and not when data is dequeued via recv(),

Again, this is wrong.



> the BPF
> program doesn't seem to run here.
>
> Could this cause the test to fail unconditionally because sk_rcvlowat
> retains its previous value?
>
> Reference: https://lore.kernel.org/bpf/20260522083527.D40D51F000E9@smtp.k=
ernel.org/
> Reviewer: sashiko-bot@kernel.org (Fri, 22 May 2026 08:35:27 +0000)
>
> [ ... ]
>
> > +static void tcp_autolowat_run_rpc_test(struct tcp_autolowat_test_cb *c=
b,
> > +                                    struct rpc_test_case *test_case)
> > +{
> > +     struct rpc_event *event =3D test_case->event;
> > +     char *ptr =3D test_case->data;
> > +     struct epoll_event ev;
> > +     socklen_t optlen;
> > +     int err, optval;
> > +     char buf[4096];
> > +
> > +     if (tcp_autolowat_build_data(test_case))
> > +             return;
> > +
> > +     while (1) {
> > +             switch (event->type) {
> > +             case RPC_EVENT_END:
> > +                     return;
> > +             case RPC_EVENT_AUTOLOWAT:
> > +                     err =3D setsockopt(cb->child, SOL_BPF, BPF_TCP_AU=
TOLOWAT,
> > +                                      &event->val, sizeof(event->val))=
;
> > +                     if (!ASSERT_OK(err, "setsockopt"))
> > +                             return;
> > +                     break;
> > +             case RPC_EVENT_SEND:
> > +                     err =3D send(cb->client, ptr, event->len, 0);
> > +                     if (!ASSERT_EQ(err, event->len, "send"))
> > +                             return;
> > +
> > +                     ptr +=3D event->len;
> > +                     break;
>
> Could this lead to race conditions causing flaky tests?

No, it's over loopback.

>
> The test calls send() to transmit data and immediately executes the next
> event. Because network transmission over the loopback interface involves
> asynchronous softirq processing, send() might return before the packet is
> fully processed by the receiving socket.
>
> If the next event is RPC_EVENT_EPOLL with a timeout of 0, could
> epoll_wait() prematurely return 0? Similarly, for RPC_EVENT_RCVLOWAT,
> could getsockopt() read a stale sk_rcvlowat value before the TCP stack an=
d
> BPF program have finished processing the packet?
>
> Reference: https://lore.kernel.org/bpf/20260522083527.D40D51F000E9@smtp.k=
ernel.org/
> Reviewer: sashiko-bot@kernel.org (Fri, 22 May 2026 08:35:27 +0000)
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/progs/tcp_autolowat.c b/tools/=
testing/selftests/bpf/progs/tcp_autolowat.c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
> > @@ -0,0 +1,326 @@
>
> [ ... ]
>
> > +static int tcp_parse_descriptor(struct bpf_sock_ops *skops,
> > +                             struct tcp_autolowat_cb *cb,
> > +                             u32 seq, u32 end_seq)
> > +{
> > +     struct rpc_descriptor *rpc_desc;
> > +     u32 rpc_copied_seq;
> > +     u64 copy_len; /* u32 should work, but not for no_alu32 :/ */
> > +     u64 rpc_len;
> > +     int err;
> > +
> > +     rpc_copied_seq =3D cb->rpc_desc_seq + cb->rpc_desc_buff_len;
> > +
> > +     if (before(cb->rpc_desc_seq + RPC_DESC_SIZE, end_seq))
> > +             copy_len =3D RPC_DESC_SIZE - cb->rpc_desc_buff_len;
> > +     else
> > +             copy_len =3D end_seq - rpc_copied_seq;
> > +
> > +     /* Since LLVM commit 324e27e8bad83ca23a3cd276d7e2e729b1b0b8c7,
> > +      * clang omits the "copy_len =3D=3D 0" check below, which is nece=
ssary
> > +      * to satisfy the BPF verifier's range check for bpf_skb_load_byt=
es().
> > +      */
>
> This isn't a bug, but multi-line comments in the BPF subsystem are
> expected to have the opening '/*' on its own line:
>
>         /*
>          * Since LLVM commit ...
>          * ...
>          */
>
> Reference: https://lore.kernel.org/bpf/20260522083527.D40D51F000E9@smtp.k=
ernel.org/
> Reviewer: sashiko-bot@kernel.org (Fri, 22 May 2026 08:35:27 +0000)
>
> [ ... ]
>
> > +static void tcp_set_autolowat(struct bpf_sock_ops_kern *skops_kern,
> > +                           struct tcp_autolowat_cb *cb,
> > +                           struct tcp_sock *tp)
> > +{
> > +     /* To handle wraparound. */
> > +     u32 val =3D 0;
> > +
> > +     LOG("Setting rcvlowat: tp->copied_seq: %u, rpc_desc_seq: %u, rpc_=
end_seq: %u, rpc_desc_buff_len: %u",
> > +         TP_SEQ(copied_seq), CB_SEQ(rpc_desc_seq), CB_SEQ(rpc_end_seq)=
, cb->rpc_desc_buff_len);
> > +
> > +     if (before(tp->copied_seq, cb->rpc_desc_seq))
> > +             val =3D cb->rpc_desc_seq - tp->copied_seq;
> > +     else if (cb->rpc_desc_buff_len !=3D RPC_DESC_SIZE)
> > +             val =3D RPC_DESC_SIZE;
> > +     else
> > +             val =3D cb->rpc_end_seq - tp->copied_seq;
>
> Does this code incorrectly set SO_RCVLOWAT to the total combined size of
> all unread frames when multiple RPC frames are received in a single skb?
>
> If multiple complete frames arrive in the same skb, the parsing loop in
> tcp_do_autolowat() parses all of them and advances cb->rpc_desc_seq to th=
e
> end of the last parsed frame. This sets:
>
> val =3D cb->rpc_desc_seq - tp->copied_seq
>
> which evaluates to the length of all unread frames combined.
>
> If an application sequentially reads one frame at a time, tp->copied_seq
> advances and the queue size decreases, but sk_rcvlowat is not updated
> because BPF_SOCK_OPS_RCVQ_CB only fires on packet enqueue.

This comment is based on the wrong assumption too :/


>
> The remaining queue size will then be strictly less than sk_rcvlowat,
> causing epoll_wait to block and trapping the remaining fully-received
> frames in the receive queue.
>
> Could this hang applications that rely on epoll to read one message at a
> time?
>
> Reference: https://lore.kernel.org/bpf/20260522083527.D40D51F000E9@smtp.k=
ernel.org/
> Reviewer: sashiko-bot@kernel.org (Fri, 22 May 2026 08:35:27 +0000)
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/263285=
41814
