Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C8737F727
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786560096; cv=pass; b=O817DEDEMcXkynL+m65PFVUg0kCoHblrJT/5ZFymRFI6jpuJIfkwAWGjBMGEuzcMzVsRovxcHOLyx2idhksh2vMcsyEE56C2xJS7pipzLxBhTBgw45odnvWu3kMs4xTW6ZKM0z9oJWGCQSgg87b3xbScSJfnIHngmR+XFDlYrRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786560096; c=relaxed/simple;
	bh=SZ72OMOSDg/pXKNqUQ++FGeZW4FDZPa1n6ff1kIFZhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhJJL7iRy9QhR6Gwz1S6vhDwUUfiXoxXfJDbGxkTuE5jA5OuJ1pbIWUPUQF7i/huL745L/Ug0Sye/76jUErEYFVKO98yHnsO3yBOLSyMdYC5bY39wfIxBnU66grOURfOptKvxCaqM6OFJNu03kBxF7MxGw4MD3i4aMhlfwnl29U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noTzNo4T; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noTzNo4T"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6682259cb3dso377401d50.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 11:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786560094; cv=none;
        d=google.com; s=arc-20260327;
        b=WrJlPWUPjjUlejCKkGx5s65Y1TBvEWOm0P1SDEv0qdWpDt7OrewJvFsNm1BafuZozT
         7R9J7hsuk3QdGmGXIhsopsrwQ5vtD+zzgprJyDcffa7OyX3H2c0v2Bj1eVLG+UyvT14O
         9RdTMg+t53OWY0TWZAjS5GNEWcpYioP+dwdbhewa4OAvQ9iawhu66lplrzQBDgvR5D/5
         sO7rIkJAronfZUj+pygOGYg7qi4fynCTVz0mmRtCEnXlWwTauuoeqYZAQCrjTL64Jp2i
         dMVwp0mKn6Dvy3L9rZwjpsg6uppS5PXvbLvpCUF/oxV7d6WZalmMHyMNMeRopOsGO4M5
         qqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=geRcQ8q8DxhXUSx4CcoJ+DNkzH/qfpyx1RGqpkdUYqs=;
        fh=KFuCT+lsuCBthncmPgCKNp8gBFIheQk8cxGC6Wnibas=;
        b=M1vWoUTEbgsJ2ZjngePXaoIafPCfK1aLU5cfVn7xbLECc0o3u34+gQ64w/Nv9fAaFc
         EdlFxIfdvPAO5yj3xyGUrZ9vzQMMFSh7/JS7PIW+3otR2oIrrCunVVffZDRUkg0dkqpb
         flYPst4ieo5LHWBWgU5qaRneZKNDcTphz0iE4b9bj5MpGzFP4VDuklFBJu8JMC0PuZYR
         M5SsuTEZ8SgpJowudahIsGChskx0Dsb0Nm/sUzDrVeJNLOLRwDKgcnV0Bk9KQbCCyn0g
         6iGYqauaeel1W99ZTOtpEsyds4jbW0vSfa8VmO+GXQ7QdC8hKZsLHRanZGh7nrP7EEU2
         /hxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786560094; x=1787164894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=geRcQ8q8DxhXUSx4CcoJ+DNkzH/qfpyx1RGqpkdUYqs=;
        b=noTzNo4TnfjtoBRtddFxS4rIcm3J7tSguDo0REKgYMYy7ODpyjCRfHeHSRD39wIdXY
         6AsV58JJE6iZNdxAArYkt1l86WQYq3hhS/jW51WrCNWHRhm6L/B1pE9Y6/dOP+ruDcw2
         47AJDN6WG2K46h54TGu9Os0lLZQ85SCavx0X/evQ6Q4ao8hugg4+1Kto343JQV4V6KtZ
         KoExHZ3pZayg6sJ1v7ZrQKp3sernUAKTl30Gncg8CvUkM2vg1RWNbzkAD0PwGWafK3Qk
         sK5vgtj7O0wPULkYNO+rf428QwjZ+cU1TXtbMUHad+jtABll1FJEV2vqTj4Wa/uNY/ll
         xjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786560094; x=1787164894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=geRcQ8q8DxhXUSx4CcoJ+DNkzH/qfpyx1RGqpkdUYqs=;
        b=sm94K2ouABpJv3z7SwZZHZ42JXMwMiiqyjpcI7kYqVv1MVqK2IJjqXLxpw0x6k3G+B
         NBqopyQNK10cRE/Th3C8hUG4xzUWRmmdySkoRAEcbXbJ9weVtR7r0TjAYegLQeYjwccW
         C4RBxu6+GFh62IFdZ7EOtghc476UCXNrMJEkL1e95HAipXDEooL2tqzNXtzEZjbposhA
         f/1rqFqa4OJPckdBLY+3mmeh2IO1f9nfHsoWcx7wiMB6sMe+A/0vbJEKxXWwZ5IrNHRF
         WTe4Y8ar3nw5sUo+NH2/nWgxB9LsmC6a94XNRHV6kzIEHsqXPmdedgfLGHbUwBoWwR71
         VThg==
X-Gm-Message-State: AOJu0Yz28nkY0NceCPsegTUoROnhuGE+ZUpB6DwIg4tnSwkcj3lYpDJn
	RT4eWFnWed8WmDGHzNYvLlU4Wz0uxdA+TVfv6YcEWSsisMCXb1xG86B+X4Zal7L5AcU1fKxZPoB
	3t9O5v7geAk6Z1g8pCJeMvqH9HURBPGo=
X-Gm-Gg: AR+sD11ejj0lptE/tkxVOdm27ISUKDb0rxWFsd9Cu9Yv8QbI2OO9WrV9bR5+aausH9j
	Bj4DhOytZXI64qV078WmDJHcBNJYqKIb11aizR0qB+K5saGZYSfB/4OsxBzgOru8zi4Vh4CR2ay
	ZSV2K9PY9/q4FgVsyd+gZ1txuAbsN3f6PmSELsu4C2bOAqQY954+I1IgDWa8l5kJjc3cSA7yRn5
	yFWf83dnC7WXyq28D/jn38o/XkhXeJdVLOwBwrjNw86cW5G/PHgUWQtmEYVGeSEFFBlYZqImisw
	Kvrbvf9nYyK/Lz0+TarQ3MOLbCTU/3T/08vTWU1VlcZR
X-Received: by 2002:a05:690e:809:20b0:668:13:14e with SMTP id
 956f58d0204a3-66c4fabe86cmr380484d50.18.1786560093904; Wed, 12 Aug 2026
 11:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-1-ameryhung@gmail.com> <20260706171918.317102-12-ameryhung@gmail.com>
 <DKD2DNYT38YH.2GNNCMCEA1OKH@etsalapatis.com>
In-Reply-To: <DKD2DNYT38YH.2GNNCMCEA1OKH@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 12 Aug 2026 11:41:23 -0700
X-Gm-Features: AUfX_mw9dVsZ9buvYJf00d92wxmscH-LXq-E8Q5dr9Szza6TBwGrC14yCzGYxSg
Message-ID: <CAMB2axNmd8m4hp5Vti4pzxhbufr63dKzFSpN6szH6wXDLPTLDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 11/15] bpf: tcp: Support selected sock_ops
 callbacks as struct_ops
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, shakeel.butt@linux.dev, roman.gushchin@linux.dev, 
	kuniyu@google.com, kerneljasonxing@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 2:11=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> > In LSFMMBPF 2025, I have talked about moving the BPF_PROG_TYPE_SOCK_OPS
> > to a struct_ops interface [1].
> >
> > The BPF_SOCK_OPS_*_CB enum interface has grown over time as new TCP
> > callback points were added. A BPF_PROG_TYPE_SOCK_OPS program now
> > commonly needs a large switch on sock_ops->op, and the shared
> > bpf_sock_ops_kern context has become harder to extend because different
> > callbacks have different locking, argument, skb, and helper
> > requirements. The existing 'union { u32 args[4]; u32 replylong[4]; }' i=
s
> > also not reliable in passing args to bpf prog when there are multiple
> > progs attached to a cgroup.
> >
> > The above has already been solved in struct_ops. Add a TCP-specific
> > struct_ops type, bpf_tcp_ops, and support attaching it to cgroups.
> > This allows each callback have its own func signature and allows
> > the verifier to select kfuncs/helpers based on the specific
> > struct_ops member being implemented.
> >
> > This patch wires up the following existing sock_ops callbacks:
> > - BPF_SOCK_OPS_TIMEOUT_INIT
> > - BPF_SOCK_OPS_RWND_INIT
> > - BPF_SOCK_OPS_RTT_CB
> > - BPF_SOCK_OPS_STATE_CB
> > - BPF_SOCK_OPS_RETRANS_CB
> > - BPF_SOCK_OPS_TCP_CONNECT_CB
> > - BPF_SOCK_OPS_TCP_LISTEN_CB
> > - BPF_SOCK_OPS_RTO_CB
> > - BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB
> > - BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB
> >
> > BASE_RTT is ignored as it is not particularly useful. NEEDS_ECN should
> > be done in bpf-tcp-cc instead. The tstamp ones should be a separate
> > struct_ops (e.g. "bpf_sock_ops") that can work in both TCP and UDP.
> >
> > timeout_init and rwnd_init could have a request_sock pointer. This patc=
h
> > tries a different API and direclty passes the request_sock pointer as
> > an arg.
> >
> > Two other approaches were considered before settling on having
> > bpf_get_retval() read the dispatcher's run_ctx via saved_run_ctx. The
> > first was to inherit the retval in the trampoline itself: add a helper
> > in the four __bpf_prog_enter*() paths that, for struct_ops programs,
> > copies the chained value from the caller's run_ctx (now saved_run_ctx)
> > into the program's own run_ctx. It works but puts a per-enter
> > program-type check on the generic trampoline fast path, taxing all
> > fentry/fexit/lsm callers for a cgroup-struct_ops-only feature. The
> > second was to do that same inherit only for the int-returning members
> > via a gen_prologue that emits a hidden kfunc at the start of
> > timeout_init/rwnd_init; this keeps the cost off the generic path and
> > scoped to bpf_tcp_ops, but needs a kfunc + BTF_ID + prologue-emission
> > machinery. The chosen approach avoids both: it touches neither the
> > trampoline nor the program, since saved_run_ctx already points at the
> > dispatcher's run_ctx that carries the value.
> >
> > [1], page 13: https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_j=
bxbAjByp/view?usp=3Dsharing
> >
> > Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> Two nits below.
>
> > ---
> >  include/linux/bpf.h    |   1 +
> >  include/net/tcp.h      | 113 ++++++++++++++++++++++++-
> >  net/ipv4/Makefile      |   1 +
> >  net/ipv4/af_inet.c     |   1 +
> >  net/ipv4/bpf_tcp_ops.c | 188 +++++++++++++++++++++++++++++++++++++++++
> >  net/ipv4/tcp.c         |   1 +
> >  net/ipv4/tcp_input.c   |   4 +
> >  net/ipv4/tcp_output.c  |   2 +
> >  net/ipv4/tcp_timer.c   |   1 +
> >  9 files changed, 310 insertions(+), 2 deletions(-)
> >  create mode 100644 net/ipv4/bpf_tcp_ops.c
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index df95ae690da5..91024d2da4ea 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2597,6 +2597,7 @@ struct bpf_trace_run_ctx {
> >  struct bpf_tramp_run_ctx {
> >       struct bpf_run_ctx run_ctx;
> >       u64 bpf_cookie;
> > +     int retval;
> >       struct bpf_run_ctx *saved_run_ctx;
> >  };
> >
>
> <SNIP>
>
> The retval is in bpf_tramp_run_ctx is generic, so maybe we can make the
> helper for retrieving it generic, too. Should we at least rename it to
> make this obvious?

The helper cannot easily be made generic: the chaining is done in
bpf_tcp_ops_call_int(), which is bpf_tcp_ops specific, and the helper
reads the retval out of that dispatcher's run_ctx via saved_run_ctx. A
bpf_cgroup_struct_ops_ name would over-promise for now. I would rather
keep bpf_tcp_ops_get_retval() and rename it if and when a second user
shows up (it likely will follow the same convention).

The commit message describes two other approaches that would make it
generic: 1) inheriting the retval in __bpf_prog_enter*(), and 2) a
gen_prologue-emitted kfunc, and why neither was chosen.

>
> > +{
> > +     struct bpf_tramp_run_ctx *ctx =3D
> > +             container_of(current->bpf_ctx, struct bpf_tramp_run_ctx, =
run_ctx);
> > +
> > +     /* bpf_get_retval() is only exposed to timeout_init/rwnd_init, wh=
ich
> > +      * always run via bpf_tcp_ops_call_int(). Its run_ctx carries the=
 int
> > +      * return value chained across the bpf_tcp_ops attached to the cg=
roup
> > +      * and is this program's saved_run_ctx.
> > +      */
> > +     if (WARN_ON_ONCE(!ctx->saved_run_ctx))
> > +             return 0;
> > +
> > +     return container_of(ctx->saved_run_ctx, struct bpf_tramp_run_ctx,
> > +                         run_ctx)->retval;
> > +}
> > +
>
> <SNIP>
