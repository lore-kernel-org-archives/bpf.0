Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605554;
	b=dfX/jcaS4eVxYYp73bL0QO0205r48fIlTfiBhEuuOSy6qZfLaGYiFLiZljCtgax35wVZ
	 JhHuRWe3MNSqrz2ywlKpBPmycWq5LDZRGnVX+qOaYQH8mkcUyvdWUbVEohYW/ESJoV3PI
	 geLqalsXjZzEdLW5qff0ieJj5OR7xd4JzcYdoK4OvxwifCGgHf+5dZ7EnOQRyxEf1jQnZ
	 KVdyFlx91OjSXCjtAJT9zhwNapXtg2M1fbJKmtVu1op8+nWzXnrfNlly3FX3Cr74V52x9
	 f//xvT6OlkcydrhoE51aoqjhuQ39x3BzH7YEBkzvJLs6VoRuzQtUN3XArphaj4z17mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6sJWQmLBhokjKlXFaUuhboCAYafMOywAbBqFd/02/RI=;
	b=MefQjlh1igtF3sXpw4mjksDDlPdiwUnzvCyxNJ2mRC0lc3P7tYo/S9+iHg3VEye2xILR
	 zhMBeC2qciHW+kmrKhHWvEcM2rkhI8KNaOXxhaDxQYgBVo5LPMDDMoxFJni98q6+TNyS2
	 WIh3bPOIkG3IegdAjo4JuQKaoPzjkGVrlqAnyRKZ7UUgMl62poDx1T8v+LkllS7uX1ECI
	 rKg+yOb3aGRRuOO27H+z/LSWr8HXemg61avLpnQ7CDhzKN3VKdLAMa2InJrKq3pv54T0D
	 9SwRFktjMVPgIZHOryOlWIYhb5V6Mw53onCjkrt5QaclbtDLkLcwvt0sALzhT9q2fQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0VW5nDjy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31EE606A335
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F31EE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0VW5nDjy
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so14713305e9.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 13:32:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794605551; cv=none;
        d=google.com; s=arc-20260327;
        b=jgTdQSOvia941ySLerjilea7DSLVEYpWc9fjsITvpt2utWgniYP4gJBIhbCOpXkQxf
         6I3SB7fjnE5r3JrbhCD5/wm2IxMtp+Z8p3DnOcAboB0Sgtag8ArifEpM0fskBv312n0R
         4228cpNYUwDYClpwXCJURDx2eo+CJHH/11dR2/Y4j5j6KddzwAyYWErXRuxTVv2AlNI9
         m/tVZXsYN6LhmyNCZjwLwqsWxfI455NNsvTNfjXdrHv1dDgpL190jOgp08pzyhlLEbTm
         uI6A96LMg4OZG3bg6NEoAUq93t7uuQ4ChpE8QNH2HqMJLVeokxHFB2/NnYxC8cspZ8us
         7pdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6sJWQmLBhokjKlXFaUuhboCAYafMOywAbBqFd/02/RI=;
        fh=dwen16zAcOM15+ltKM8pE/Dphmatm2d+DCl4besD9/E=;
        b=KrRnsuMgmwV+70CarTWfyu7qBRlTF7DXKwhUEHanfRjSZTW6V+1P8kcQh3PjlAmTf5
         xAd2pqkf0EPSj5A2FRyhdaFyFQTXOZz3b9y5Tx8ZRahVXKilHk5+b6e4fsZ3oWq7gMyX
         NKDIJSECDaCNtSr1/ICXwTf9S3b3OfxBPCNKwYD5ECUiR4iXjSjj1XvzXqksggjudW7N
         XjKdoqxMCne6WnJqNJJufDx2qxIRF3k5Tv3VZiisS31z9y1rJmdLyG2AmDN/gLBLyEeY
         zqjFo1/FFHARvBJZEToo3NSnd6R4uHh6P0MidnGi/tU+1xzd9ebSwGFDFZ2oJqPIev3B
         M3zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794605551; x=1795210351; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6sJWQmLBhokjKlXFaUuhboCAYafMOywAbBqFd/02/RI=;
        b=0VW5nDjy0z7VIHAf1CVwNSR3YQTyg0ZBKL/RlEsNYa8ID23gd4vLSygRQhUtOScX17
         jqr2ldgxxIDbOLUw/DnfOgtizyoCxm4NWtHoW9arEczdgoLWCKxo9SRyLAiCA/TTpsIr
         qav6ksWDxAX8m2ZSwYYXqTuVjWs+Efx0MKgPiHU71fVkrpG5EQW4pyiYMk3r4pCWkbsd
         Fzm/ntnYhxnMjC4pBkaffGY8iJ/8Ja2qvzpd+qqRGdK2Kpb2r1w5honj4gPFce5g+g/q
         pCwfQLVp5H12c92u4TGuRgiMAsz2s4wbEhmMzygH2vc0LvRiNlgPxAh0jrdv4Dl33cSH
         hqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605551; x=1795210351;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6sJWQmLBhokjKlXFaUuhboCAYafMOywAbBqFd/02/RI=;
        b=Sr5+3+TZeIwzda0OWspFOjHy2JlB4rFn3lnf4vJJ+VzTyDqBobpDF3okkM1+eM+NjU
         RLNS41LKb1wcZyKnOZmv5tmgXfkmsM+7cbxkCP+1zxrtItzsCBSrVUHWfTbxm//WVee7
         7uoI0I9WaFIpiRuVuX+RzBrs2FAvm0uwBllJWIsKZ85/9AuI8lxFl1VUAE9xynJVGJpR
         myAMzxgx6Jsp6Xg59p3oF1pOt0e++Mqt2yvEjwey0dMBdNgxAZ8L0Fa6wOB9NoPSgEhP
         UdEKRcEZA1efpM21yPEAUQUQ3wPrEQLth30I1weB9F/iUMlIvJ2XQOQbs0h/Et5m0mnu
         F3jA==
X-Forwarded-Encrypted: i=1; AL+hErGug5zaY82+SGhNHF/68ztsl45Wm+flB+aqq4Aunye7wXNuz8+3hdQz/Dd3VP+CjAAN70w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YURgK2WBcV2OXjGDWf9QAok4k1rXXrGtTZxdfagGI1g1F5G+o
	HNcdBdeygHOMY/O32tVGxPP0KkAGxdfgH8s/lK4PtyNZcZeArYgClNjt3cCW3f9mPJI+I8kYKlW
	sMRvpMziSlqJb8HKxXbTkv2sOmlbpQ2s=
X-Gm-Gg: AYBFou0lGfaYZxCz1wgA5IGCFmW848J26n55/c1j/nFwTrH0v24N934IgOgFIvid/Y2
	Zq5d6aM2DoJpm+ZHTO1C5stW9VXJWvjtUQKhUX2dVW34JvZQaqf6NywFR8aJyD+n7sTyTP/+/Q9
	BFm0paq7N6D7d4pklEDqv0+0DAAS7mfhsdRzl81u9/9zLwe4NNmaNFIyDd+6P8eqt1JPkPbfRql
	K4Y8tHwCuxDTtyqRe9uLrhtsly4DEeBoH23SLIQHt6z5fIHTCCJt7u2jkcRTGVV9AmHoWOqgtvM
	mv4KS+c4RgNHwkc/rHGcjsEeS2rKo7XhVY9qKkuX5pBlNsNJwj4Mrl8y5foVdl51WIhBHw39trG
	gb3FhmnB7mZT4ecYQRHaJZhpBNd9MvBVKAP9ffNVmw5MVbvzdYa8xnZr8mcsLOh7UNNlCGLXDZV
	dJSBfXwDbq+cf9GgaJ58E+QAnXwxdobJrdCg==
X-Received: by 2002:a05:600c:3acf:b0:4ba:4395:560f with SMTP id
 5b1f17b1804b1-4bb55a70e39mr89013255e9.8.1794605551278; Fri, 13 Nov 2026
 13:32:31 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <b7b3f0926c35e8192180326438de9b6c119125a50ffb23b8d5754f31f47a999c@mail.kernel.org>
 <20261113065654.523979-1-yangfeng59949@163.com>
In-Reply-To: <20261113065654.523979-1-yangfeng59949@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Nov 2026 13:32:19 -0800
X-Gm-Features: AclHuK9TmY4dWZPMHP9iuLFY8aOnEsvx0IObqAHBLBRYcnAQbJ6W7m9iq_m4IYM
Message-ID: <CAEf4BzbVLzTsCHozzMoturR-pHznh4xVg0esWd7j0eqS9kPV1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: Add sleepable version of
 bpf_get_stack in raw_tp_prog_func_proto and tp_prog_func_proto
To: Feng Yang <yangfeng59949@163.com>
Cc: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@kernel.org, 
	martin.lau@linux.dev, mason@kernel.org, mathieu.desnoyers@efficios.com, 
	matt@bobrowski.net, memxor@gmail.com, mhiramat@kernel.org, 
	rostedt@goodmis.org, song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 10:57=E2=80=AFPM Feng Yang <yangfeng59949@163.com> =
wrote:
>
> On Fri,  6 Nov 2026 08:50:02 +0000 bot+bpf-ci@kernel.org wroted:
>
> [ ... ]
>
> > > @@ -1725,7 +1774,8 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id=
, const struct bpf_prog *prog)
> > >     case BPF_FUNC_get_stackid:
> > >             return &bpf_get_stackid_proto_raw_tp;
> > >     case BPF_FUNC_get_stack:
> > > -           return &bpf_get_stack_proto_raw_tp;
> > > +           return prog->sleepable ? &bpf_get_stack_proto_raw_tp_slee=
pable
> > > +                                  : &bpf_get_stack_proto_raw_tp;
> > >     case BPF_FUNC_get_attach_cookie:
> > >             return &bpf_get_attach_cookie_proto_tracing;
> > >     default:
> >
> > Can this make sleepable programs that load today fail to load?
> >
> > The new prototypes set .might_sleep =3D true, and check_helper_call() r=
ejects
> > such a helper whenever in_sleepable_context() is false:
> >
> >     if (fn->might_sleep && !in_sleepable_context(env)) {
> >             verbose(env, "sleepable helper %s#%d in %s\n", ...);
> >             ...
> >             return -EINVAL;
> >     }
> >
> > in_sleepable_context() is false inside bpf_rcu_read_lock(),
> > bpf_preempt_disable(), bpf_local_irq_save() and lock regions, and insid=
e
> > rcu callbacks such as bpf_for_each_map_elem() on hash maps and
> > bpf_find_vma().
> >
> > Before this patch the same call resolved to bpf_get_stack_proto_raw_tp =
or
> > bpf_get_stack_proto_tp, which do not set might_sleep and never fault.  =
For
> > example:
> >
> >     SEC("lsm.s/file_open")
> >     int prog(void *ctx) {
> >             bpf_rcu_read_lock();
> >             bpf_get_stack(ctx, buf, sizeof(buf), 0);
> >             bpf_rcu_read_unlock();
> >             return 0;
> >     }
>
> This patch is effectively d4dd9775ec24 + 9d02927fdf4e applied to the rema=
ining
> program types in one step: the resulting behavior matches uprobe.
> If the rejection is acceptable for uprobe, we would prefer to keep the ne=
w types consistent with it.
>
> > loads today and would be rejected with "sleepable helper bpf_get_stack#=
67 in
> > rcu_read_lock region".
> >
> > The call chain is bpf_lsm_func_proto() -> tracing_prog_func_proto() ->
> > raw_tp_prog_func_proto().  The same applies to sleepable raw_tp,
> > tracepoint, fentry/fexit/fmod_ret, fsession and iter programs.  It also
> > applies to every BPF_PROG_TYPE_SYSCALL program, since check_attach_btf_=
id()
> > forces those to be sleepable.
> >
> > The rejection happens even when BPF_F_USER_BUILD_ID is not passed, so t=
he
> > helper could not sleep in those calls.
> >
> > The commit message acknowledges this ("such programs load today") and c=
ites
> > commit 9d02927fdf4e as precedent.  That commit fixed prototypes that co=
uld
> > actually sleep in non-sleepable regions, whereas here the old prototype=
s
> > were correct.
> >
> > The verifier already records per-insn non-sleepable call sites in
> > env->insn_aux_data[insn_idx].non_sleepable, and specialize_kfunc() uses
> > that to pick bpf_arena_alloc_pages_non_sleepable().  Could the non-faul=
ting
> > implementation be selected the same way at fixup time for call sites th=
at
> > are not always sleepable, instead of rejecting them?
>
> If we do need to keep the existing unaffected behavior, would this change=
 be similar to
> the operation below?

I think it's reasonable to have sleepable implementation, and if
someone for whatever reason did call bpf_get_stack() under explicit
RCU lock, it's an easy fix.

We do have a bit more general problem to solve eventually where
non-sleepable program can have async callback in sleepable context
(like with task_work) and vice versa, perhaps, and we should have a
generic mechanism to keep track of that and substituting correct
helper/kfunc implementation based on such context. But that's a
separate and more general issue.

I think the change is good as is.

>
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 1d33a78d9373..d91211b15770 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -3416,6 +3416,9 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env=
)
>                                      func_id_name(insn->imm), insn->imm);
>                         return -EFAULT;
>                 }
> +               if (fn->might_sleep && env->insn_aux_data[i].non_sleepabl=
e &&
> +                   insn->imm =3D=3D BPF_FUNC_get_stack)
> +                       fn =3D bpf_get_stack_proto_nosleep(env->prog);
>                 insn->imm =3D BPF_CALL_IMM(fn->func);
>  next_insn:
>                 if (subprogs[cur_subprog + 1].start =3D=3D i + 1) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bb1659ce7a5c..f73dd67f523e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13107,6 +13107,10 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>                 return err;
>         }
>
> +       if (fn->might_sleep && !in_sleepable_context(env) &&
> +           func_id =3D=3D BPF_FUNC_get_stack)
> +               fn =3D bpf_get_stack_proto_nosleep(env->prog);
> +
>         /* eBPF programs must be GPL compatible to use GPL-ed functions *=
/
>         if (!env->prog->gpl_compatible && fn->gpl_only) {
>                 verbose(env, "cannot call GPL-restricted function from no=
n-GPL compatible program\n");
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 1229ee06dd71..9eed63059449 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1765,6 +1765,22 @@ static const struct bpf_func_proto bpf_get_stack_p=
roto_raw_tp_sleepable =3D {
>         .arg4_type      =3D ARG_ANYTHING,
>  };
>
> +const struct bpf_func_proto *
> +bpf_get_stack_proto_nosleep(const struct bpf_prog *prog)
> +{
> +       switch (resolve_prog_type(prog)) {
> +       case BPF_PROG_TYPE_TRACEPOINT:
> +               return &bpf_get_stack_proto_tp;
> +       case BPF_PROG_TYPE_RAW_TRACEPOINT:
> +       case BPF_PROG_TYPE_TRACING:
> +       case BPF_PROG_TYPE_LSM:
> +       case BPF_PROG_TYPE_SYSCALL:
> +               return &bpf_get_stack_proto_raw_tp;
> +       default:
> +               return &bpf_get_stack_proto;
> +       }
> +}
>
