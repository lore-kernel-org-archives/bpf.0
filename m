Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A904A336EC6
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769128719; cv=pass; b=af7BkM7xAK5Dp5a3Sqvl3C9iy8l08cxyprgmJ5BwBFNUHjIqzvKTAgUDPviq9qtnyhigcM18aQdYPrTCGQHu/VBjQ+7jAStBPGMv8y16wCZqOqmbLVf9fIFdP5aHHsnvJSN53SSaTa9fToSvofgWX51W5AS93DhrLw3c/K11RZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769128719; c=relaxed/simple;
	bh=EQN+iIM8+dm37iZHB7GD4DOloPZVK3vMmDu9SRdIhIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVmEdU+8eJANCtcsYtV0v8OnN46AK+bryzjdKEEWNGBcFz/lZn2rYa62FMA4ya+uvjhQqbGgRhCzUEwZ3kf4Jsh136lSgg+xSYwnjQgYy8Vi7ln+4Os0g+X4IhFlYEe5YjoyxcPVeehMGIWe65iRTkXlbmmjZ9y6b1LxdYic3YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fofY/QnG; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fofY/QnG"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c2dc870e194so668316a12.2
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:38:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769128709; cv=none;
        d=google.com; s=arc-20240605;
        b=gJuasu54JMNsituDNRU3hH3PYMK/ziOYn8uUWjY48c0496iXLjfz/BTNCa6ExRj9F0
         9QMBgF0H/DP76H+AaSJc+fbvg191dFhQhB2vtnd2GJMEQmLI8CebdKVvPyhFya9gpBVx
         kRJwMQt3nU6igqNe0nWsxG11dNbTRHiIJdA9WE0EFjtdPb8cmIE7hyZRVITnHCchEonq
         kiJXGSrZKpV9p3gm6q0hcwf1qfOhbrA4/dKcn3tsVsHNBhs3ct1dDgu5hyPzBZ/zg++i
         MSlJztqHj5C0ytsa1J3MI7y4Yq5zL7ltkjPjqbs47IekKlmsqkoTphKSA6I5nGB6/h1z
         jlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rnmdPKuoPhsIINyfYoC1nWb1eqqRXOyPg3w53hnHIow=;
        fh=sDIk7vPsBCVo3MfwDcALPAcy+FaACR0PI9K73Zkvkvc=;
        b=UlASBXSNzBZXmqiXk7xBpHrs+7TDZI+hfA86oSHeV03ZczRDkH4VJokShmHHfvaO1J
         6A/VLN2f5d9Xl7lQS7AuG9pTblO0ZH+N0YUVLeYyYRpxsKmXly71RZ05S8M5XjqcHEyf
         WVkEfX389b5LABt9BTmc7aiuRUbLTvTlriXDaVpU+GkGDlS9LU9LWzs1iFiA5zo/Isky
         5wQefwpptB76SfzL9T2tl8mkQcnzrF7p+QcZSVHVqQZwUfBsHVDNN11i41tpYPpHV3Ta
         j5+QZ64onfvZEcYT2ra9F85T65+rj9UF3OfEYFHLxyTIFK252dVG2a2esjsNbDHUb/tg
         bd/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769128709; x=1769733509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnmdPKuoPhsIINyfYoC1nWb1eqqRXOyPg3w53hnHIow=;
        b=fofY/QnGXNsqtldx8i0PKqpGn0kWgvRy7lQ2ypKQQidxYauRWp5ma/aQD3iftcf0ub
         iXTKggjUQP6ht4pXkJEYmNXM7Y5sSjGtSjyL5sJGukZxUPy86m4gOHhocThbyOEHoeP4
         02RJKDbC9Z43VhUL779lFZcNiUGfwHfrrTdovZQh3a6EwhZcRU6fKAT7uHMQaeCBzU/X
         p31cyGfi+x0NeuOj4Z7qR9aUpHBmuchRrirg+BduRKZ3m1tgAoXS/QyZFjp7aJ8usT7t
         CYfgc8grDgnbGV0rMZP4YDBdiSEjvX8zwQynRhoyyY39ed8ISduwQ4lwyvn4ZdMX1Lu2
         2Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769128709; x=1769733509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rnmdPKuoPhsIINyfYoC1nWb1eqqRXOyPg3w53hnHIow=;
        b=hZzc+zn865m/wVMIFlgcpnA8dPrhs8AovQ/Rf5jread2Z4u8xMTlkbOojGJa0Du21n
         xUbsd714JChSaNCZpn6KsBTZfOKBqDjr4Uf092Dw3wezUt8C18b9xzzT1F3JzYXfkFis
         qai+dQ/Oo72BnLMYxTxWOIDSh8d++HLj2agCjiS2ohCh9QRNt4BeSCoQ+gaoRNRBZptX
         6Zhl00x7+xkX6nRNzBqb29J5qK8a9rFBq4kwtbOA6NFrCzV5RwbFu3L3z3L9qUOguMK+
         95Bct/JTQB9XHqgM47/kv7kpTJaYjPSoiPK9PmZfhnLeFQp3VeYrclkl4ZfJXS/caT2Z
         rOJg==
X-Forwarded-Encrypted: i=1; AJvYcCW10WixWwpxl3xlMEZwBLh0bh2uT54dRgjhhLEMoBxndyJdWfNbz1NmRU8pe38y4wu453E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5o6pGjIFHBsOJDvadhuQBIWlOUk2xjD0Q6hSN22rnG+FDxqt
	OSuZ41+jDn/2giQXdowJafOYJjN4XRhxqLcZNv7vF7ZvhoKOA/in1zBMZ3/uXn1jNMckXN/sMWi
	km7qTe+PATn/XkVlB//wVPewvowKdOjw=
X-Gm-Gg: AZuq6aJZLzRJcMc4mA523k+h4QlzCv/+gp9AfLlwhg6cVH0wKnMPXH7anX/g4nVxLU0
	PX04YcYzEeLmwpAuaNGV2jfPO9tWF8eeVzNcAEV8y5fvYZC/4QO9A6Cm98BPsq8RQ08KCYc6Ek6
	jYgexMWjnkxJbTnQ/exXWk3P0VC4tvpIiSGMd9K0geuxg1yVJugKtMuPWulRB++EoMJLkzzFjqF
	pWDFCH/rsoiSxediGgsKBsxHJISuV68T/OBUcEA7BlrAMWY+0gTCnHSY6vfUptjXfB8bTBYX37P
	NFhjgmuTaCc=
X-Received: by 2002:a05:6a20:9d94:b0:35e:3d4b:4cfe with SMTP id
 adf61e73a8af0-38e6f7be6ccmr1138557637.39.1769128708578; Thu, 22 Jan 2026
 16:38:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217093326.1745307-1-chen.dylane@linux.dev> <20251217093326.1745307-3-chen.dylane@linux.dev>
In-Reply-To: <20251217093326.1745307-3-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jan 2026 16:38:15 -0800
X-Gm-Features: AZwV_QifoUzy0XFoMYGDQsg9TBiqXuPA6VKirh7287oD12DKmY7OOfbENLMadiI
Message-ID: <CAEf4BzYEsKQxT--=oQELZ7g402FWpEuDEmxcovZXkck+k2U8HQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/2] bpf: Hold the perf callchain entry until
 used completely
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:34=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. The perf_callchain_entres has a small stack of entries, and
> we can reuse it as follows:
>
> 1. get the perf callchain entry
> 2. BPF use...
> 3. put the perf callchain entry
>
> And Peter suggested that get_recursion_context used with preemption
> disabled, so we should disable preemption at BPF side.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 68 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 12 deletions(-)
>

I took a bit closer look at these changes and I'm a fan of the
particular implementation, tbh. It's a bit of a maze how all these
different call chain cases are handled, so I might be missing
something, but I'd address this a bit differently.

First, instead of manipulating this obscure rctx as part of interface,
I'd record rctx inside the perf_callchain_entry itself, and make sure
that get_callchain_entry does have any output arguments.
put_callchain_entry() would then accept perf_callchain_entry reference
and just fetch rctx from inside it.

Then instead of open-coding get_perf_callchain by exposing
__init_perf_callchain_ctx, __get_perf_callchain_kernel, and
__get_perf_callchain_user, can't we have __get_perf_callchain() which
will accept perf_callchain_entry as an input and won't do get/put
internally. And then existing get_perf_callchain() will just do get +
__get_perf_callchain + put, while BPF-side code will do it's own get
(with preemption temporarily disabled), will fetch callstack in one of
a few possible ways, and then put it (unless callchain_entry is coming
from outside, that trace_in thing).

It's close to what you are doing, but I don't think anyone likes those
exposed __init_perf_callchain_ctx + __get_perf_callchain_kernel +
__get_perf_callchain_user. Can't we avoid that? (and also not sure we
need add_mark inside the ctx itself, do we?)

pw-bot: cr



> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c1..3bdd99a630d 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -210,13 +210,14 @@ static void stack_map_get_build_id_offset(struct bp=
f_stack_build_id *id_offs,
>  }
>
>  static struct perf_callchain_entry *
> -get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
> +get_callchain_entry_for_task(int *rctx, struct task_struct *task, u32 ma=
x_depth)
>  {
>  #ifdef CONFIG_STACKTRACE
>         struct perf_callchain_entry *entry;
> -       int rctx;
>
> -       entry =3D get_callchain_entry(&rctx);
> +       preempt_disable();
> +       entry =3D get_callchain_entry(rctx);
> +       preempt_enable();
>
>         if (!entry)
>                 return NULL;
> @@ -238,8 +239,6 @@ get_callchain_entry_for_task(struct task_struct *task=
, u32 max_depth)
>                         to[i] =3D (u64)(from[i]);
>         }
>
> -       put_callchain_entry(rctx);
> -
>         return entry;
>  #else /* CONFIG_STACKTRACE */
>         return NULL;
> @@ -320,6 +319,34 @@ static long __bpf_get_stackid(struct bpf_map *map,
>         return id;
>  }
>
> +static struct perf_callchain_entry *
> +bpf_get_perf_callchain(int *rctx, struct pt_regs *regs, bool kernel, boo=
l user,
> +                      int max_stack, bool crosstask)
> +{
> +       struct perf_callchain_entry_ctx ctx;
> +       struct perf_callchain_entry *entry;
> +
> +       preempt_disable();
> +       entry =3D get_callchain_entry(rctx);
> +       preempt_enable();
> +
> +       if (unlikely(!entry))
> +               return NULL;
> +
> +       __init_perf_callchain_ctx(&ctx, entry, max_stack, false);
> +       if (kernel)
> +               __get_perf_callchain_kernel(&ctx, regs);
> +       if (user && !crosstask)
> +               __get_perf_callchain_user(&ctx, regs, 0);
> +
> +       return entry;
> +}
> +
> +static void bpf_put_perf_callchain(int rctx)
> +{
> +       put_callchain_entry(rctx);
> +}
> +
>  BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, ma=
p,
>            u64, flags)
>  {
> @@ -328,20 +355,25 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs,=
 struct bpf_map *, map,
>         struct perf_callchain_entry *trace;
>         bool kernel =3D !user;
>         u32 max_depth;
> +       int rctx, ret;
>
>         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>                                BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID=
)))
>                 return -EINVAL;
>
>         max_depth =3D stack_map_calculate_max_depth(map->value_size, elem=
_size, flags);
> -       trace =3D get_perf_callchain(regs, kernel, user, max_depth,
> -                                  false, false, 0);
> +
> +       trace =3D bpf_get_perf_callchain(&rctx, regs, kernel, user, max_d=
epth,
> +                                      false);
>
>         if (unlikely(!trace))
>                 /* couldn't fetch the stack trace */
>                 return -EFAULT;
>
> -       return __bpf_get_stackid(map, trace, flags);
> +       ret =3D __bpf_get_stackid(map, trace, flags);
> +       bpf_put_perf_callchain(rctx);
> +
> +       return ret;
>  }
>
>  const struct bpf_func_proto bpf_get_stackid_proto =3D {
> @@ -435,6 +467,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         bool kernel =3D !user;
>         int err =3D -EINVAL;
>         u64 *ips;
> +       int rctx;
>
>         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>                                BPF_F_USER_BUILD_ID)))
> @@ -467,18 +500,26 @@ static long __bpf_get_stack(struct pt_regs *regs, s=
truct task_struct *task,
>                 trace =3D trace_in;
>                 trace->nr =3D min_t(u32, trace->nr, max_depth);
>         } else if (kernel && task) {
> -               trace =3D get_callchain_entry_for_task(task, max_depth);
> +               trace =3D get_callchain_entry_for_task(&rctx, task, max_d=
epth);
>         } else {
> -               trace =3D get_perf_callchain(regs, kernel, user, max_dept=
h,
> -                                          crosstask, false, 0);
> +               trace =3D bpf_get_perf_callchain(&rctx, regs, kernel, use=
r, max_depth,
> +                                              crosstask);
>         }
>
> -       if (unlikely(!trace) || trace->nr < skip) {
> +       if (unlikely(!trace)) {
>                 if (may_fault)
>                         rcu_read_unlock();
>                 goto err_fault;
>         }
>
> +       if (trace->nr < skip) {
> +               if (may_fault)
> +                       rcu_read_unlock();
> +               if (!trace_in)
> +                       bpf_put_perf_callchain(rctx);
> +               goto err_fault;
> +       }
> +
>         trace_nr =3D trace->nr - skip;
>         copy_len =3D trace_nr * elem_size;
>
> @@ -497,6 +538,9 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         if (may_fault)
>                 rcu_read_unlock();
>
> +       if (!trace_in)
> +               bpf_put_perf_callchain(rctx);
> +
>         if (user_build_id)
>                 stack_map_get_build_id_offset(buf, trace_nr, user, may_fa=
ult);
>
> --
> 2.48.1
>
