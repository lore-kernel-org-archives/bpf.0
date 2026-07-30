Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6B20468E
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785452791; cv=pass; b=V4mh2V0GzRUm9lbrmOmikMxqh8sttkjd1Y8bCBm1NPEd4fpeIH3Ue2FFr185c+kwcmramJK/h1lKTi4bjKoS+eL07VcBN5WZTVzxYzBAYdKWOEEHpF+c26QCd0PRFSeY/O8DoX5sOeS27DORA2oedcAyK38P9kYq4lYAqd2zVwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785452791; c=relaxed/simple;
	bh=hFcx+xmuLrnjob5KnyV5Z59iA9x83mMKe+VgXDhYjlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2tiQdt8zi+WAn+ubTQQmbWYg/mbOnU7nzIMgYl5e/DFr7oYcnb3Plb6DN9zna7miFOojCYBd8ArRw25QSqzqJDQSeCMUEHEpn3w0ReWzq1XHDhxgQpAdAT0o+exHc2ChstbdulXBQ4qpR28zbEbyyIg/z+D9pWWuc7ogPzwNSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZ4/aj6B; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZ4/aj6B"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so432034b3a.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 16:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785452789; cv=none;
        d=google.com; s=arc-20260327;
        b=i9vQiYy8gjX1Siop+plyNHMQTzVgeMXlnHe2ElP3xTtn04ObTWABCGYBX2bqaSKAox
         mD2i0TTovYfcNkyUzqrEmAsdF1SBqyh9YlEHsWzbOG0DZrXUftz2M75tno6lIfc0xVqB
         kdoew5QXWsa36Otzp0mGUAl60A4AH03agTu5LPlHv98/emb8UKm0LsewNdPQAtkXgq26
         y9Y98rf8Ldn9MWyxcG10jNeTLa02VABOm5o1gIIeGsItpqEC9g3I7ohGyrNcEooVcrCK
         jlsE5Pf9uMg85A+Q79lskcwmRMMirXDRMQ6t4znqCYlmFBS9Flvn97kWCOWJxB/YBuuA
         IR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5+Kqf/6pGxeL6TLlH+AWqCDY7Cg+0VkNaA0LAonuLow=;
        fh=vjwWRINjim018+9CfzJARc84v1D9MVu4CedScQpdLP0=;
        b=abgSnS6OqgHq2A0SCp52Fs83WOm+5heYVbfieUTvkbka32fUPI/Qjq1QTcdenuneP3
         8A5wL7517RoEMZDG8pGOuNOHiptfGE0kdOwL4PBkcGvhmCmMLnckFRVF5+vAC8uIaHca
         oY5vFo+SM8UDxTYcuvgbDdLzGZqFnFq7DkbDmqiF6zPl+XyoKPvwTmJh3k07jXDhR6XJ
         /PbI/rZ0tMCyQMbH4Mt2MHtK6cPvzYxWEif/7eHQMvHfok/E6dEnQvEtC6/6NfYkUt6P
         uggaPXjeCQb3NgWR+yaIsIWAvGkIrLDtFyrjzwFzvqgLY0GlKWh0EwsaV+8nerCLIZ12
         maaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785452789; x=1786057589; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5+Kqf/6pGxeL6TLlH+AWqCDY7Cg+0VkNaA0LAonuLow=;
        b=nZ4/aj6BYB5waj0YLLZxol+FxsJ3xsOgzjT2s4BsIsAwEDqR9wbNEpjjhPiJLqmgAf
         mp/R3d+5AvNq6Af0BYK4mS7LxxyDoMxBlMWeJG80xzmEexmk/TXQZb2IBAg8Zc11QCi/
         yZ8RPyBwmC+PCn6lVmoYlKoCIcq6ZKZzgfdcR6pSqYEPTI3p1/LCCuWxZW+ek7fs7gXY
         rL8LtsmiEUEB7shBOSjQbvvqa5JepUM/jbVpNy6h/P7lAua2AEbHFx68FeEgWjMPzgfS
         FXeIc5cLUiWWFsUyoDsXlFyGp/cFNfow4Pm/q2pRzLSFm2xaJ72Pz/x1TetzJ9uroyzs
         ZY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785452789; x=1786057589;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+Kqf/6pGxeL6TLlH+AWqCDY7Cg+0VkNaA0LAonuLow=;
        b=QEoVRc9p+W75KjKgx0bUD+HTmhofzMST/Ad6Qjolkfxi5bR9AEyQgzxXjiBel2dDJX
         9N+NjaTQYWp+jY54byigM3Q1g6/Wjbs6ZNfA7//+pVekodTAAdr9CgPVSfMHhtqopUoE
         Q9JZIUhN6qDNsJCCqyfC0MSohmVjKqErv7ptU0mb5yOofE3P4ZDzr/CoY+hdZJQiHLCF
         RsC1veqX9izX3NjoQSDGNKuExp0MhHOFmPVLu+kgw4w7Z0IL4EgeOU6Qx6S96/NVKLKR
         4XvbC9FyLICdbfGJZyJk+un0OXJm96Btc3XWu/9QJ/485CxSVd6A2ZrhFQINyEz6Xzm7
         psPg==
X-Forwarded-Encrypted: i=1; AHgh+RpYBP79lQ73bx3uEbnN6nCebjTKaSp06gkLlfJkCBdj2aatNe4OOAGTX45y+Xi/VfF1aJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnf4Hb0uM2AIt+oPFF2rved0uWEljQaxvuYb1DVGET08XQKmlJ
	yxpCwK1Lbw/AatSPk7qc+jLZrmiFwsmRlLxYb94BFZ96NR59VO3QQN0Tt7QQynwTnczssj/JpPJ
	Xb4bYy+DTctnwSD7idUWKA3TA2fwN66U=
X-Gm-Gg: AR+sD11n5AQ71LQsTw9QTFkfEclHws7WbAocjdJUjHHM95UxkqYA9jEPb6EQjw5RnIl
	ECRjJqtwXqqukub0bP8CTF+g0N/hkp2Y6pNOD4ZdfPNZvYKjpsy0+V3Jl9WLJlyku9cisckhOYv
	A8dMjvC2+ZMmRO2TrxbA9f+wzE9LI0rvf/fptBvSfEfixnSlnzJzWoM7fmMXjV3rNbgjScqouqI
	+Q+GJzAq7bpSr04s/tebLnVBMkoVJu4CrephziiNZse0SC6R+7WQ/5lxjzx6c3foDwoeJi9b56V
	IXpoNGkYlblt7vEhFDmVb2AB52DN//zVkI4egrnfC/4ufpY9W0Wy56FUHdiFLjgH0agFKQx28+l
	SXIDZ0q9NwRk/v1vB9QfPfX9yOhWXNUMdmIrRKXlkSQ==
X-Received: by 2002:a05:6a00:8c02:b0:847:711f:49ab with SMTP id
 d2e1a72fcca58-84ebc2206ebmr4140775b3a.22.1785452789236; Thu, 30 Jul 2026
 16:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729083807.1588544-1-jolsa@kernel.org> <20260729083807.1588544-10-jolsa@kernel.org>
In-Reply-To: <20260729083807.1588544-10-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 16:06:14 -0700
X-Gm-Features: AUfX_mwKq8KOXbbJS4eTdTynKG9GPOH_evIAmIXKOQEBT976ZMX3pr-rRnsWLaQ
Message-ID: <CAEf4BzYRzFH+n7Cj2jKpcG6LOZJMh7O38=R7MnoH2jFKxSG1Tg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 09/11] bpf: Remove trace_in argument from __bpf_get_stack
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>, 
	Tao Chen <chen.dylane@linux.dev>, STAR Labs SG <info@starlabs.sg>, 
	Arnaud Lecomte <contact@arnaud-lcm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 1:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Now with the new callchain_* helper functions we can process trace_in
> case directly in bpf_get_stack_pe function and remove it from
> __bpf_get_stack which makes things easier for preemption fix in
> following change.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/stackmap.c | 46 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 875f530f3597..bdf48a7ad2e8 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -783,7 +783,6 @@ static long callchain_finalize(void *buf, u32 size, u=
32 trace_nr, u32 elem_size,
>  }
>
>  static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *ta=
sk,
> -                           struct perf_callchain_entry *trace_in,
>                             void *buf, u32 size, u64 flags, bool may_faul=
t)
>  {
>         bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
> @@ -822,10 +821,7 @@ static long __bpf_get_stack(struct pt_regs *regs, st=
ruct task_struct *task,
>         if (may_fault)
>                 rcu_read_lock(); /* need RCU for perf's callchain below *=
/
>
> -       if (trace_in) {
> -               trace =3D trace_in;
> -               trace->nr =3D min_t(u32, trace->nr, max_depth);
> -       } else if (kernel && task) {
> +       if (kernel && task) {
>                 trace =3D get_callchain_entry_for_task(task, max_depth);
>         } else {
>                 trace =3D get_perf_callchain(regs, kernel, user, max_dept=
h,
> @@ -856,7 +852,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>  BPF_CALL_4(bpf_get_stack, struct pt_regs *, regs, void *, buf, u32, size=
,
>            u64, flags)
>  {
> -       return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, false =
/* !may_fault */);
> +       return __bpf_get_stack(regs, NULL, buf, size, flags, false /* !ma=
y_fault */);
>  }
>
>  const struct bpf_func_proto bpf_get_stack_proto =3D {
> @@ -872,7 +868,7 @@ const struct bpf_func_proto bpf_get_stack_proto =3D {
>  BPF_CALL_4(bpf_get_stack_sleepable, struct pt_regs *, regs, void *, buf,=
 u32, size,
>            u64, flags)
>  {
> -       return __bpf_get_stack(regs, NULL, NULL, buf, size, flags, true /=
* may_fault */);
> +       return __bpf_get_stack(regs, NULL, buf, size, flags, true /* may_=
fault */);
>  }
>
>  const struct bpf_func_proto bpf_get_stack_sleepable_proto =3D {
> @@ -896,7 +892,7 @@ static long __bpf_get_task_stack(struct task_struct *=
task, void *buf, u32 size,
>
>         regs =3D task_pt_regs(task);
>         if (regs)
> -               res =3D __bpf_get_stack(regs, task, NULL, buf, size, flag=
s, may_fault);
> +               res =3D __bpf_get_stack(regs, task, buf, size, flags, may=
_fault);
>         put_task_stack(task);
>
>         return res;
> @@ -936,6 +932,33 @@ const struct bpf_func_proto bpf_get_task_stack_sleep=
able_proto =3D {
>         .arg4_type      =3D ARG_ANYTHING,
>  };
>
> +static int __bpf_get_stack_pe(struct perf_callchain_entry *trace, void *=
buf, u32 size,
> +                             u64 flags)
> +{
> +       bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
> +       u64 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> +       bool user =3D flags & BPF_F_USER_STACK;
> +       u32 elem_size, max_depth, nr_trace;
> +       bool kernel =3D !user;
> +
> +       if (kernel && user_build_id)
> +               return -EINVAL;
> +
> +       elem_size =3D user_build_id ? sizeof(struct bpf_stack_build_id) :=
 sizeof(u64);
> +       if (unlikely(size % elem_size))
> +               return -EINVAL;
> +
> +       max_depth =3D stack_map_calculate_max_depth(size, elem_size, flag=
s);
> +       trace->nr =3D min_t(u32, trace->nr, max_depth);
> +
> +       if (trace->nr < skip)
> +               return -EFAULT;
> +
> +       nr_trace =3D callchain_store(trace, buf, elem_size, flags);
> +       return callchain_finalize(buf, size, nr_trace, elem_size, user_bu=
ild_id,
> +                                 user, false /* !may_fault */);
> +}
> +
>  BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
>            void *, buf, u32, size, u64, flags)
>  {
> @@ -947,7 +970,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_da=
ta_kern *, ctx,
>         int err =3D -EINVAL;
>
>         if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
> -               return __bpf_get_stack(regs, NULL, NULL, buf, size, flags=
, false /* !may_fault */);
> +               return __bpf_get_stack(regs, NULL, buf, size, flags, fals=
e /* !may_fault */);
>
>         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>                                BPF_F_USER_BUILD_ID)))
> @@ -966,7 +989,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_da=
ta_kern *, ctx,
>
>         if (kernel) {
>                 trace->nr =3D nr_kernel;

this whole count_kernel_ip() logic above, why do we have it? I don't
think we can have combined user and kernel stack trace, so how can we
end up with PERF_CONTEXT_USER "ip" at all? I might be missing
something subtle here, but can you please check again if this whole
trace->nr calculation/override is even necessary.

> -               err =3D __bpf_get_stack(regs, NULL, trace, buf, size, fla=
gs, false /* !may_fault */);
> +               err =3D __bpf_get_stack_pe(trace, buf, size, flags);
>
>         } else { /* user */
>                 u64 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> @@ -974,9 +997,8 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_da=
ta_kern *, ctx,
>                 skip +=3D nr_kernel;
>                 if (skip > BPF_F_SKIP_FIELD_MASK)
>                         goto clear;
> -
>                 flags =3D (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> -               err =3D __bpf_get_stack(regs, NULL, trace, buf, size, fla=
gs, false /* !may_fault */);
> +               err =3D __bpf_get_stack_pe(trace, buf, size, flags);
>         }
>
>         /* restore nr */
> --
> 2.54.0
>
