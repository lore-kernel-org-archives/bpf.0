Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ACF3A5456
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774912181; cv=pass; b=NCcXXot1/T5lCmdnVXnpXkxCfmtI4aFQwF1ODQUM31q61A7GIl+ZKvdkXirsf92u5EI4QOTVW7NOhdI7QRLw42nqjpv1ZM5wKWL7Ewr/QWD2J/318k9IOe/79ZUVIesMZWXDmRaWLX9s9kbJxZkMFxWsI/b4srdk92YhTrimoPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774912181; c=relaxed/simple;
	bh=S5YVnajUWF/APV2TH6Bv+HQmtdjsDU58kl3vNy/yC1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLQ7EOOtJ2yDhxOOrrh1ZTGeAqjecw33Zy2piJhwg7i2feeiwSNQ+2iDi7SQqINwE4yq0XsKpIPw9oT2SlDA9Wgh6UbX0L7I7XpcpB1wSuYlEQIbYkoONem8xLK2ZOe64YGPm5QrhyXOXraSwkIOIDLHGdWD6QIujiifDu/c0ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqFn69T+; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqFn69T+"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so4618596a91.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:09:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774912174; cv=none;
        d=google.com; s=arc-20240605;
        b=L+rWdPWgNCJhNWjpET17i/3h6T/r4DHCqX2k0T7KOHJ7pCJ47XZGjYiai/Jj3XdJbD
         oJs1WnQ61SedZ8ZRkdQiZl4qj764LjvO3q1mZp8lUJGwMAwpTz4+GbpzInQILsiRfen+
         5RYcwdbORofca9ldSl6WEuYbf/S7qZG/vEq+YbVs/dJLrxVAMzNTzhRas7aAcLyXhpwt
         lZRso0HWvDv2ZNJIiOfhxowRIQ7Vjeo/1T4XPkeDyOI8eJExxcp8imG/JzynlLxCAXeN
         zINXNI1y/oI4gSnhELkgAToRs2ML2Jdz7EshFya+yiRkPyvUjOrKfxrovWqwC1w4+3bV
         f1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YywPE3j/muqrtftqQYh7DmGXOu+2N7N/Si/odPolSuI=;
        fh=Qz+h7taVC6bsMvRXky5UtUpe9Gr3bfAExt/9lbBnEZ0=;
        b=dwrkP/sd67yU0hPJJim1rAGvM0CpQgduCasZggznwphWLIproDtjLxWDDNcUEJyLRM
         lLiui9pLliyoq7321duwOct6WEqH1xCoWNFR1j7Hb3ETF0n4IrH0oLMmsB8mOthxXRTV
         9zEWdIca1TSQXNBFeirvB/HNPcaRq36tOwwkwOZvulbnl7XMhwV+N1mN2fnwiJHsn4CQ
         496lrH7pwo+S3I1N1h5UDFcrdFzA8zb429x6a08QOzCaztiy3P7DDqnLOI5lcE5ynHPu
         GmNIgGdMbIbHSufbNnf8M/yVOIci5CHshUwOCf4DEosFBAHY6bw0ML1M/yjekwtcaTy0
         qWeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774912174; x=1775516974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YywPE3j/muqrtftqQYh7DmGXOu+2N7N/Si/odPolSuI=;
        b=WqFn69T+kCokorLqnSveHfbUum3fbpWYMh9NsOxYpzMJvUsDChv3HyoLmZ83JJi39o
         Bc389OHsZ5JYamgIQPPQBr1UTsEzHudzJvpd6vjS7iGf8bgsjfn9pNIB6R26bZyun+Hx
         0zzy/YmgrpI1Dffu1DqOUV/6PakOD+gOyyk67Xe2KsEwcHd6yrgehocrHzmFQAS3T8ls
         GUKfbgCanCvi23/PwzCAsZl02Amc3IcRFXSxdzgM3M8dGajx0GWL5pQXOZMt1KqM7cab
         7RMums8v+YCtxG6bZbZ2TOwgG5+Nnd3wg1Tt2dc4BY8eyfCe74YjmReyC4zU+4xZuaDS
         ZZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774912174; x=1775516974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YywPE3j/muqrtftqQYh7DmGXOu+2N7N/Si/odPolSuI=;
        b=Zf5SsRPnoP87ZHlYC4sZE9qeTTE2U8aUzD6TzM7fW87bjXbi8aePg8SWTOE8aK/YgH
         Xgh4f0nEfeSxbhrq+XasbqOunKuXO9alvDPGoM5sRvNsokEdr02z54s3/eL7/KNV+Bw+
         NZIpzdswjQ9voi5TPKs+iXQM6Asi7icTXAkMUcBGUmXYsDNlAVAcXu2aU3K4RHm8vosc
         zx7Rpl59ieELb9hYKRzGBLe8nSo2uy0vQE+NrkxZ1wmXjXaYamnlVxfkDGFES4YwajKP
         Lg60pD+yVGwqMFE12gnsBmTAFrEO/dSNbvlWH3BwCirWbdxC9g16ePwPh/AUdJRRv5KG
         28wA==
X-Gm-Message-State: AOJu0Yy0/FXCjvqR0vVjnI+qUUCho9ofPv6M9JiBX4JvrdSSNKGAsMAZ
	JXc09HMwfG4SOu3FRFw4cSXsM6iFLHFTt4fbDiuSESbv4yCNd7ZbYJcTkFmWuP17YFsFnPU5/XK
	sfUWF+On9nn5Z7GRYkAraeEFExEQLBhTKXKWA
X-Gm-Gg: ATEYQzzObUoZ8xRIdOvXuhtZbgbwxKI8FTZ4uQgaXO8ueXijqKaliHCAU7OxdT6QCxO
	6XZbuBhFhNhpqVK3jND07ptmOBurT6eLljw8kJjJnb+dP9IrYdul8ZUWjvkQ3ezqBJmDop0WrPA
	sTM7NvRRFMy2/cTARRm+s4oiJxPf3Y0pzQlzCWdfd9YmzYu4JLyMb3UOLBhmr+SNqlfGD1VqFDB
	84gaTQfGu2i9N1aeNTQDRX4/ErotmwKSlUvq5EnpuY4vAf5YnHUGhFNBynimJK0RlbBWQzqqGIF
	YxrhpQ48lNGM46Iqs/kV2/s=
X-Received: by 2002:a05:6a20:914b:b0:398:71e4:6287 with SMTP id
 adf61e73a8af0-39c8780e8f2mr15319740637.10.1774912173538; Mon, 30 Mar 2026
 16:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330143102.1265391-1-memxor@gmail.com> <20260330143102.1265391-2-memxor@gmail.com>
In-Reply-To: <20260330143102.1265391-2-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Mar 2026 16:09:21 -0700
X-Gm-Features: AQROBzBnn9YdbMYm05Beo_1TFNZscpmNmRs9AWgSe17D8f0G4f9fIG89K0e_ocs
Message-ID: <CAEf4BzYXB9vLRey9zRU-h23NB_Mf-Uc0MznrTrByZDpsSZJ0EQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix grace period wait for tracepoint bpf_link
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 7:31=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Recently, tracepoints were switched from using disabled preemption
> (which acts as RCU read section) to SRCU-fast when they are not
> faultable. This means that to do a proper grace period wait for programs
> running in such tracepoints, we must use SRCU's grace period wait.
> This is only for non-faultable tracepoints, faultable ones continue
> using RCU Tasks Trace.
>
> However, bpf_link_free() currently does call_rcu() for all cases when
> the link is non-sleepable (hence, for tracepoints, non-faultable). Fix
> this by doing a call_srcu() grace period wait.
>
> As far RCU Tasks Trace gp -> RCU gp chaining is concerned, it is deemed
> unnecessary for tracepoint programs. The link and program are either
> accessed under RCU Tasks Trace protection, or SRCU-fast protection now.
>
> The earlier logic of chaining both RCU Tasks Trace and RCU gp waits was
> to generalize the logic, even if it conceded an extra RCU gp wait,
> however that is unnecessary for tracepoints even before this change.
> In practice no cost was paid since rcu_trace_implies_rcu_gp() was always
> true. Hence we need not chaing any RCU gp after the SRCU gp.
>
> For instance, in the non-faultable raw tracepoint, the RCU read section
> of the program in __bpf_trace_run() is enclosed in the SRCU gp, likewise
> for faultable raw tracepoint, the program is under the RCU Tasks Trace
> protection. Hence, the outermost scope can be waited upon to ensure
> correctness.
>
> Fixes: a46023d5616e ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_=
CALL() with SRCU-fast")
> Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/tracepoint.h |  8 ++++++++
>  kernel/bpf/syscall.c       | 26 ++++++++++++++++++++++++--
>  2 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 22ca1c8b54f3..8227102a771f 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -113,6 +113,10 @@ void for_each_tracepoint_in_module(struct module *mo=
d,
>   */
>  #ifdef CONFIG_TRACEPOINTS
>  extern struct srcu_struct tracepoint_srcu;
> +static inline struct srcu_struct *tracepoint_srcu_ptr(void)
> +{
> +       return &tracepoint_srcu;
> +}
>  static inline void tracepoint_synchronize_unregister(void)
>  {
>         synchronize_rcu_tasks_trace();
> @@ -123,6 +127,10 @@ static inline bool tracepoint_is_faultable(struct tr=
acepoint *tp)
>         return tp->ext && tp->ext->faultable;
>  }
>  #else
> +static inline struct srcu_struct *tracepoint_srcu_ptr(void)
> +{
> +       return NULL;
> +}
>  static inline void tracepoint_synchronize_unregister(void)
>  { }
>  static inline bool tracepoint_is_faultable(struct tracepoint *tp)
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 274039e36465..89fa8f00adfa 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3261,6 +3261,17 @@ static void bpf_link_defer_dealloc_rcu_gp(struct r=
cu_head *rcu)
>         bpf_link_dealloc(link);
>  }
>
> +static bool bpf_link_is_tracepoint(struct bpf_link *link)
> +{
> +       /*
> +        * Only these combinations support a tracepoint bpf_link.
> +        * BPF_LINK_TYPE_TRACING raw_tp progs are hardcoded to use
> +        * bpf_raw_tp_link_lops, see bpf_raw_tp_link_attach().
> +        */
> +       return link->type =3D=3D BPF_LINK_TYPE_RAW_TRACEPOINT ||
> +              (link->type =3D=3D BPF_LINK_TYPE_TRACING && link->attach_t=
ype =3D=3D BPF_TRACE_RAW_TP);
> +}
> +
>  static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)
>  {
>         if (rcu_trace_implies_rcu_gp())
> @@ -3279,16 +3290,27 @@ static void bpf_link_free(struct bpf_link *link)
>         if (link->prog)
>                 ops->release(link);
>         if (ops->dealloc_deferred) {
> -               /* Schedule BPF link deallocation, which will only then
> +               struct srcu_struct *tp_srcu =3D tracepoint_srcu_ptr();
> +
> +               /*
> +                * Schedule BPF link deallocation, which will only then
>                  * trigger putting BPF program refcount.
>                  * If underlying BPF program is sleepable or BPF link's t=
arget
>                  * attach hookpoint is sleepable or otherwise requires RC=
U GPs
>                  * to ensure link and its underlying BPF program is not
>                  * reachable anymore, we need to first wait for RCU tasks
> -                * trace sync, and then go through "classic" RCU grace pe=
riod
> +                * trace sync, and then go through "classic" RCU grace pe=
riod.
> +                *
> +                * For tracepoint BPF links, we need to go through SRCU g=
race
> +                * period wait instead when non-faultable tracepoint is u=
sed. We
> +                * don't need to chain SRCU grace period waits, however, =
for the
> +                * faultable case, since it exclusively uses RCU Tasks Tr=
ace.
>                  */
>                 if (link->sleepable || (link->prog && link->prog->sleepab=
le))
>                         call_rcu_tasks_trace(&link->rcu, bpf_link_defer_d=
ealloc_mult_rcu_gp);
> +               /* We need to do a SRCU grace period wait for tracepoint-=
based BPF links. */
> +               else if (bpf_link_is_tracepoint(link) && tp_srcu)
> +                       call_srcu(tp_srcu, &link->rcu, bpf_link_defer_dea=
lloc_rcu_gp);

It bothers me that we have a special rule here just for tracepoints
(and non-sleepable ones only), and fetch that srcu_struct...  it feels
like we are missing some more fundamental link-type-specific grace
period callback that could be overridden by link ops. E.g., perhaps we
should be having something like


if (ops->call_rcu)
    ops->call_rcu(link, bpf_link_defer_dealloc_rcu_gp);
else
    /* current sleepable or non-sleepable RCU stuff */

and for non-sleepable rawtps we'll have link_ops->call_rcu set to
something that would fetch that tracepoint_srcu_ptr() and call
call_srcu().

I don't think we need to solve this right now, but if we ever have
second case where link's attach hook has some extra lifetime nuances
like this, we should generalize this. For now:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>                 else
>                         call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_g=
p);
>         } else if (ops->dealloc) {
> --
> 2.52.0
>
