Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792779237;
	b=NC0yN71FTBi8T1Bl0IV/v4qyDSL+znI8p/FcCU267YSEAGaX0tHd6xe+R519v47d9WBH
	 ycFcp0+CVJy2ri894swFtK1cXA1+IMYrPxN4CMmuMc7Qauz+5o1r9gOAyY9ZvC0dO4tNQ
	 rmbM6I70XpRMR5vkkWNv8sEeRxQcRYk792EqSB/UWBz8kHmBBlWpyfCqmAq1rPid0Fmy3
	 c5EUGi/aynvTMFMdVV6oHHBsKayctwvuRPJ83vaKl7tkwZwZ7mch79+ndrM1tPfVnBHwm
	 uRBINtjY2OA21TZpN43hlrxbsoXM+w6A4cvWCDKxbZRx9Is+QTYBnwkAvMm1FNEjqpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=a8AhxehP29nTMFMYLaAQmj4iROvDwdVGWATuOgUSYxE=;
	b=xlYGqnQpSpl2MTU+Pxi8KRpBElyNghspvv98p8DzAkjjlCWB+jFgb+l5AEZGzSWjiGqD
	 7dJ/n9mNiXGnuIZmUTEkiq4hT0VYkj6s2tZ2hakR8OKFQs3KyUbonMb4pLzZh1x+/keEv
	 J4aQxLLCXBMUr6C/QMQkqfeUeYGumhmeSU+k4tJd5JwBci+o5o73U2j/11lk2g3lD+M6v
	 +Xje6/k+c9OpxbJ0dIw2zL+acGrb9zKHF57FGwKYKWDf5sB68Xy4KUN9pvKwuXGgZq0Vw
	 A9tNu+6by26o2qOmFilMOFKEkomcqwLp9N+SRRi4Z1W0N5Fv/TiCos/IDkDDio5ruew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XsJdhaxl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9F606A321
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 18:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B9F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XsJdhaxl
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so834631a91.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 11:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792779236; cv=none;
        d=google.com; s=arc-20260327;
        b=PR++L4LRpFA/ttCeqWjSyxSiCEgUrLjruH9YWScTG8tx0It2RUQJYFB1lHNchYluZX
         XyuDHKf+9qcJvTBq8M7UuOcFDwjGv4Vnjk3GSo2uhbJ+a2QKOPSo2OQvXcniuLN0eh+U
         0b54VdgEjzTDFTY/bm6i2oqtrCAj4t45PMepBRHse/jD6ztalNsCn2EG08HpYh5SG9tU
         Vivs3c7M0Cq3wSLu9iIwdbGtFORorBJ9YuSxbDw6ztis/CSQ/+MQ3rRozDoLBxh+r6kp
         n4OfD4MlvDKeBW8+D2lx/Sb666SbfSq7L2AybCMOHxBrHRH2nIkEakiN2kM0/Hc2olCF
         MCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8AhxehP29nTMFMYLaAQmj4iROvDwdVGWATuOgUSYxE=;
        fh=E4SfiSY47BwTsJniEpvEH5D/WW8Z9s5h07aNY3KbuHc=;
        b=b8Vs6PKs8uh9H6PhdUlVzwwKtBNNBBGoiTCfSVU9wV8Jj2P+u76UkpnZec44SZRgKF
         hLR3aR1DHEuBrVE/3/q0AsVfydzbynCf45ty6s9BaldzmVsiwyXCO7exchMbCIpczs55
         3BxHkM+OaQlbGS6cmTZqN5QAw1jUf1qMyFMa82P+IHce9cd8h0oPcNHCQ8CM3vQUOh9r
         v8f9Laq0c1zN9kKLOrTWeNApnSxLqUqulj71RVe8c+nHpD4AYvb4Eg3TcGbFRCas77/E
         LvqhrS5s+7ge4rE4eEWFoWB2L0EOSEHJKJXZmrlu7xUujSkl5UootOClLJCfN4PITeH+
         jkOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792779236; x=1793384036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a8AhxehP29nTMFMYLaAQmj4iROvDwdVGWATuOgUSYxE=;
        b=XsJdhaxlHUIV+RHxX+IslIZvg/0cJk3Jas2+lOtbhCi5h3POK3aAQYWGAKJSlgSlBG
         PhLR7BWQrw7Lws805TJLiOxUxCYox/cbyo4xrtd0HceO+4KwX9i4Nlce0IyMPdsWdlVV
         L5pukF/Oov+6kshOmkGgpaqb8xh79aydURJ1gFFD2CftTIC5HXlnO3WRbrM3oI6Y8lw6
         reoF7CnBh73ZCi97+S//5V1iLynG/2Rj3N9MfqCHha8tBhAACD4DxgxGobSCF0A/Fb+n
         /Y2K19+87cdeUnqExRe2K9eHCBr/y6OyI248S7cS3s80HJ1jVG+DZZIDfvOxB+//DgQb
         V5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792779236; x=1793384036;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8AhxehP29nTMFMYLaAQmj4iROvDwdVGWATuOgUSYxE=;
        b=LEHTKrW6WSN1FJX268OvvfRx4fDkywhoO+cmmGdzmK+jDTR1/zXcfyn/G0n2j+GdCx
         YGZbv4OHtvj6LcB8Okn0/0irQkmrz6SyjyAoDsGFB9VPWeF0NxhQPF1nDwdcrW/ZUlVd
         usmMSnS/MxDf9Btji8Twx5Dxzoe84emWKKkUoVGYKqhIoNJhz63KMx42bnJPnLPoUyKP
         /UlWxXtWFabLig09sSVS1veM60Kt4VYH1+wjVcniBweIuzB3VpENMdsJK+rL2PX5qDEv
         emAwC4hPRTsqIj4BAzi6q/koYA+M/Ea6Eec9hyQHejnuAMZP+bL6uwQziBFVM0ddoKad
         LiJw==
X-Forwarded-Encrypted: i=1; AKwUvBwPCW/oVetbE/3NMQY0ELDp8mfD5Vo+jiCAt8arFXumMD1aQZhq5J7BVWi4bhrIBWZV9ZA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3fgxTYqIgl/4ensP8AJAlN/UpYgiqO0aZwFlY8nu7Y5P570QB
	kIH5Q4xKq3/usD/h3xn6oiuzyPnyWX9FBIxD85F8DieQ2U9rrG3ysqHHUXZsAHZVki7swq0aQI/
	0R/I3BNXnJl9K6mub/4nFzTte6DOLytyZ5DAY
X-Gm-Gg: AYBFou0NIyfODGBj8607++owQpekyN7KvAO8750mHbmwIeKOwAfk7tMpkEeCQoRcrre
	qKzIvWv2PzAonWqOu52wg98jIsnH8eP2shoEhRYSun3LGpIWrLWkLhxM7EyBNdC5ZfpQmAmzXnz
	u4w0dyrQ/Cm4Pz5uL4EsBji6NYvnEkev2dKqusSrHeomVjmVWL0PYv386BFIfL67FWFdCTFi/Re
	sFM/4CdHlkl2kD1eG4ksSSy6QYaRdw3HTc2J2C/yhyy9AWazVVOYDjh16JWvaoig+iINDQo+5Cq
	CjuzhViIFJ6VztvN7QZgjpean8INXFudz4TgMNv2zgmuwBQZxOclPQmB70rJgVN7uc/bMcdw5IH
	pv0HcLd2QSLNVrQhy4VM76GjDzFbBX50ohLV8cA5hVnAutj+rKNc8/M4UBIQxMcNQ9ki6oNIqe1
	AniP6N4wQfzB9fAuMZ0Q==
X-Received: by 2002:a17:90a:ec8e:b0:3ac:e9d4:5530 with SMTP id
 98e67ed59e1d1-3adeae84a18mr82020a91.24.1792779236236; Fri, 23 Oct 2026
 11:13:56 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021174406.2891598-1-vineet.gupta@linux.dev> <20261021174406.2891598-2-vineet.gupta@linux.dev>
In-Reply-To: <20261021174406.2891598-2-vineet.gupta@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Oct 2026 11:13:44 -0700
X-Gm-Features: AclHuK_b8jFh1n9PBk8gfcCMD41lkp9YMQ4GmFMcfbETjnWBAQczU9_yN8yeaC4
Message-ID: <CAEf4BzaTYgNwiBtvYoSw1wzuFZchs-2CCP93gh2OeDt-919-eQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
To: Vineet Gupta <vineet.gupta@linux.dev>, mhiramat@kernel.org, rostedt@goodmis.org
Cc: mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org, 
	peterz@infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 10:44=E2=80=AFAM Vineet Gupta <vineet.gupta@linux.d=
ev> wrote:
>
> When ftrace graphing is turned on, all tasks in the system missing
> return stack page are assigned one. This is done in a simplistic
> multi-sweep loop of FTRACE_RETSTACK_ALLOC_SIZE (currently 32) tasks
> at a time as follows:
>
>    start_graph_tracing()
>         do {
>                 alloc_retstack_tasklist
>         } while (-EAGAIN);
>
>    alloc_retstack_tasklist()
>         alloc x32           # GFP_KERNEL, may sleep
>         rcu_read_lock()     # preempt off
>                 for_each_process_thread    walk N_total, no cond_resched
>                      t->ret_stack =3D new_page
>         rcu_read_unlock()   # preempt enable but no explicit yield
>
> Each successive iteration of loop invokes for_each_process_thread()
> which doesn't support cursor based resume and always restarts from the
> init_task. Thus each successive loop needs to skip the tasks assigned
> ret_stack in prior sweeps and thus take longer and longer to find the
> candidate 32 tasks. And while the loop end calls rcu unlock,
> and re-enables preemption briefly, there is no explicit yield.
>
> The total number of iterations turn out to be
>
>         N_total * N_null / (2 * FTRACE_RETSTACK_ALLOC_SIZE)
>
> where N_total is the number of threads on the system and N_null the numbe=
r
> of those whose ret_stack is still NULL. After boot with no fgraph user th=
at
> is every thread.
>
> This is not a tracing-only path. Since commit 4346ba160409 ("fprobe:
> Rewrite fprobe on function-graph tracer") fprobe is built on fgraph,
> so an ordinary kprobe_multi BPF attach that flips ftrace_graph_active
> from 0 to 1 pays the whole cost inside one bpf() syscall. Commit
> 2c67dc457bc6 ("tracing: fprobe: optimization for entry only case")
> narrows that to return and session probes but does not remove it.
>
> A host running hundreds of thousands of threads, with the current batch
> size of 32, turns the ftrace_graph_active 0 -> 1 transition into a
> multi-second, and eventually multi-minute, operation which showed up as
> RCU stall and softlockup_panic on heavily loaded Meta Fleet machines
> with preemption disabled.
>
>     rcu: INFO: rcu_sched self-detected stall on CPU
>     rcu: 0-....: (20718 ticks this GP) (t=3D21000 jiffies g=3D913 q=3D8 n=
cpus=3D8)
>     CPU: 0 UID: 0 PID: 160141 Comm: bpftrace
>      ___slab_alloc+0x549/0xa20
>      kmem_cache_alloc_noprof+0x16c/0x340
>      register_ftrace_graph+0x3d7/0x6c0
>      register_fprobe_ips+0x2d5/0x310
>      bpf_kprobe_multi_link_attach+0x218/0x7e0
>      __sys_bpf+0x267a/0x27a0
>
> Fix this by allocating inline with GFP_NOWAIT instead of pre-allocating
> a fixed batch. GFP_NOWAIT does not sleep, so it is legal inside the RCU
> read-side critical section.
>
> A single sweep now serves every task, so the walk becomes O(N) rather
> than O(N_total * N_null), and the retry loop is no longer the normal
> path.
>
> The pre-allocated array remains as the fallback when GFP_NOWAIT fails.
> The runs below never needed it, so it was exercised with failslab
> injection: at a 100% failure rate every task falls back and -EAGAIN
> retries ~1560 times for 50000 threads, with no stall or splat.
>
> The open-coded rcu_read_lock() and the goto unwind are kept as-is so
> this stays easy to backport; converting them to scope-based cleanup is
> left to a follow-up.
>
> smp_store_release() is a drop-in replacement for the smp_wmb() and
> plain store it replaces.
>
> Measured on a 60-core Sapphire Rapids machine running a PREEMPT_LAZY
> kernel (CONFIG_PREEMPT_DYNAMIC=3Dy, mode lazy), timing the write that
> drives the ftrace_graph_active 0 -> 1 transition. Threads are spawned
> while fgraph is inactive so every one of them has ret_stack =3D=3D NULL,
> and the loop was instrumented to count sweeps:
>
>         threads   before              after
>                   sweeps   time       sweeps   time
>         100000     3126     15.3 s      1       0.019 s
>         200000     6253     59.1 s      1       0.047 s
>         400000    12503    227.8 s      1       0.092 s
>
> The sweep count is 1 throughout. Time now scales linearly with the
> thread count at roughly 230 ns per task, which is the allocation and
> initialisation of one shadow stack.
>
> Fixes: f201ae2356c7 ("tracing/function-return-tracer: store return stack =
into task_struct and allocate it dynamically")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> Tested-by: Vineet Gupta <vineet.gupta@linux.dev>
> Cc: stable@vger.kernel.org
> ---
>  kernel/trace/fgraph.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

I presume this will go through Masami and Steven's tree, is that right?

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index ed455b53513b..4c74f1a15ad4 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1033,13 +1033,16 @@ void ftrace_stub_graph(struct ftrace_graph_ret *t=
race, struct fgraph_ops *gops,
>  trace_func_graph_ret_t ftrace_graph_return =3D ftrace_stub_graph;
>  trace_func_graph_ent_t ftrace_graph_entry =3D ftrace_graph_entry_stub;
>
> -/* Try to assign a return stack array on FTRACE_RETSTACK_ALLOC_SIZE task=
s. */
> +/*
> + * Loop thru all the tasks in the system and assign ret_stack.
> + * The @ret_stack_list is a small pre-allocated fallback, in case
> + * the GFP_NOWAIT allocations here fail.
> + */
>  static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
>  {
> -       int i;
> -       int ret =3D 0;
>         int start =3D 0, end =3D FTRACE_RETSTACK_ALLOC_SIZE;
>         struct task_struct *g, *t;
> +       int i, ret =3D 0;
>
>         if (WARN_ON_ONCE(!fgraph_stack_cachep))
>                 return -ENOMEM;
> @@ -1056,20 +1059,26 @@ static int alloc_retstack_tasklist(unsigned long =
**ret_stack_list)
>
>         rcu_read_lock();
>         for_each_process_thread(g, t) {
> -               if (start =3D=3D end) {
> -                       ret =3D -EAGAIN;
> -                       goto unlock;
> -               }
> +               unsigned long *rs;
>
> -               if (t->ret_stack =3D=3D NULL) {
> -                       atomic_set(&t->trace_overrun, 0);
> -                       ret_stack_init_task_vars(ret_stack_list[start]);
> -                       t->curr_ret_stack =3D 0;
> -                       t->curr_ret_depth =3D -1;
> -                       /* Make sure the tasks see the 0 first: */
> -                       smp_wmb();
> -                       t->ret_stack =3D ret_stack_list[start++];
> +               if (t->ret_stack)
> +                       continue;
> +
> +               rs =3D kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
> +               if (!rs) {
> +                       if (start =3D=3D end) {
> +                               ret =3D -EAGAIN;
> +                               goto unlock;
> +                       }
> +                       rs =3D ret_stack_list[start++];
>                 }
> +
> +               atomic_set(&t->trace_overrun, 0);
> +               ret_stack_init_task_vars(rs);
> +               t->curr_ret_stack =3D 0;
> +               t->curr_ret_depth =3D -1;
> +               /* Make sure the tasks see the 0 first: */
> +               smp_store_release(&t->ret_stack, rs);
>         }
>
>  unlock:
>
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> --
> 2.53.0-Meta
>
