Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E455474F
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548730; cv=pass; b=iSTvsGoVI5Q9SMaVaDqVoOVj/pwcln1VaXq5l3sPXsBW13R9SxKSZgeet/pfVw2TE/J/Ns2R6vE8D9P3yHnf7mBGmYkKo6pNmaDBhsNqC4CSFR90hYIsjUy11icMEoKLFhksg52mcNOWAz9pg/XiywXmhFep76iQRwd6MuOEfb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548730; c=relaxed/simple;
	bh=HFULCdGsLGiP7G4bYPVeClIHj1xRjR7NKVjvo5m2Ts8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHR4dXhQ75eOqEqWGq6+4y+l3xDAYjc5v9i0rj6WSRzGsWrw1xsVbUi5N2H6wKuNjcj6vbYW7lyVMCno4Mh2msMYTQQl+4LwNNM15nJR1X/sfBKQlG49RLTmjXYE4mq1+mHFXRKvbHjMZwSRoa4lQkPjghBEi1/F8yj5C1p7N8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2CJE5Pp; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2CJE5Pp"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65a380b554bso2934148a12.2
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 16:52:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771548727; cv=none;
        d=google.com; s=arc-20240605;
        b=HimzXqXD5VwIsOpelWZQN3l3UIpVV5NUmdpoESOxtTynCFyJaAuoQyptiesfQ2ITjC
         FABXCbmWOmXV4152iC3ZuTV2GNk6W961Xhb5iAZapDxDAu1LuuzGAsJzD8xWm1BLiyce
         CPjwMJXaBxkmkCoRVdW6QnXYrE6sEouLnRQKbGPUQqlZGwp/xieuJdoqBQUhe0DdYyA1
         aYJDMwrvWJJS4eDL78mVgMS5DcmShA2MGzX8H/W6jiPUK94yz0pJLpBLnZPneQxATktz
         z9NQSju8W/OUPtJzEdQklJ5LMejJoyWUS/0l7eLXi4mBOaDSmCVrnrBBhccDZSuqB+1D
         fsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lCRQFPi65X2kBYMRgvLmUnHgz7hQXjO6ZCppODpxZMA=;
        fh=cKMUHX+7uaxJJpnCJTUj05r6u3b5LIa8H8LPnjF8mDI=;
        b=ln/6k5pD5MHbzTa6JjO9gAPH/BSmZZnhd9OSqd3anmVefD0O3cr3qQEGc9l6ArAsLt
         o9JwSwHETI2pX+HmRtjuZFURAYDNa2wA8bAicGlt5Msoz+GXh0CC+VMlEBWbTzrUkA8C
         YTgnzRuvUTWmiTbskKJz+HIH061JTr9LySCQIAheu+sXVqo1EWKoIr+3YYQEXtdpvAc6
         v1OCzvitMittye1G6CyI+/dE9gQtG+MNfywieIpNFA6s3AvfEVwC+KAqj9//B/f5/aia
         Dy+6UwDUPYkeMrFYwKMnjR8lNNkv+L2N53B+uUpgPk3mkDkIU46flgPlLwIieqdlRlTh
         1w5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771548727; x=1772153527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCRQFPi65X2kBYMRgvLmUnHgz7hQXjO6ZCppODpxZMA=;
        b=S2CJE5PpcAffuaYQJy1+slS/i22Tu/WazvszUYIyavSUkGf+6sZMTASm1XQ89z+e8b
         svOYokG7IHdCi2KAJb8Heuo0bMxAr0ZWcR9f17iybvNftYEBe5XIBAD9FJvEAuGQ8qLm
         aHF/A2Q3XX3Mi82TOFToJmKU8ZDPAQiYjt5RTeRXAglgmzXtJgNcqvog+jq8S0JtAvBJ
         QVKJSsB3Gi8hIchzwTm8aYNEBcj74Z4R6KEeoXiClu0x66C4DFbn8noJtNKGg9x1JHfS
         hJHIVtwT23cJnx9B0mElKPDy1akb+Xr11XngCi4wg+bklQcqRKud5Nh6doC/Xv9Dh/gM
         2f9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771548727; x=1772153527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lCRQFPi65X2kBYMRgvLmUnHgz7hQXjO6ZCppODpxZMA=;
        b=AB84RSN7DW7SQ6aEl58hIWkVV8Bvu6jCH4YuPYZzwo4Tz4cZjPBv904oKOzyMmyr/n
         9A5UEi1J9FQcN2HOXC0G2KL/Sil1Yid8Jojn8AdMjCHK4E3voQbrPNEq6zrXSOACn0Yy
         e6hXdwRqB5suQk2AWDf46hK4o57PZTLYwiKuMyAXfPCG8SYPQq3MPLpn6ZNPYGu8E+Xe
         Eh/FSW918/i6eEB7r2M8MuUhmZqiz0//ACZEKNFNRn4q1TUNqJeqVC+aVAqCRDeXzXIP
         /g81+5jKhc1VmPdkbm6ud9pFfTpGP1Mh0+roCgDjATgJ4+cyaCHm9WxDieX3ZqZGU54g
         Dg9g==
X-Gm-Message-State: AOJu0Ywk4xapIXLxyqhU9dcIwbW4HYqVClYtYLLKfgwTB5VXdy026csR
	op4WbDWUpLtONRN12eIBXd5o0gB2hKpCl0HIVXJ6+uCvTZ4UDeJ3wg1xgAakG/L3WSnlbiqpi8N
	e82/U99fX1V5JogGGh5LY/NVWVEG/mpg=
X-Gm-Gg: AZuq6aI+bjL30+5Pa3xsbJpBhMFWJxpkrkhV7+8mS+aBf4n7EnE0j9mLfCMA5EkrXy1
	F7towXdMklr6TGJG/aV64AXPsNZZr1/CAK3+4duUd4zxO2ZbkH/ftfo22DzLI2vcSqVyuv39IK6
	Fxz2mWu5pA4K4KyxgtoTPQ3iVdSyTiAVSC9VH7r9RldRk6cY7zm3mNmBauBsJzCLmBwbDi0x+0s
	Dcw9SKQNbI+nmiYu0MMl/lmmhJl1o/4p2HiqSvwVniT/4y3+/2FcPVPHKCYXG15nHtZFL9wa5fD
	uWeH4Qp3
X-Received: by 2002:a17:906:7314:b0:b8e:d4ed:5eab with SMTP id
 a640c23a62f3a-b904dc686a6mr321757566b.31.1771548726992; Thu, 19 Feb 2026
 16:52:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218182555.1501495-1-puranjay@kernel.org> <20260218182555.1501495-3-puranjay@kernel.org>
 <99fd7227e0abc0558a2954e95c1e049edc9ba7b3.camel@gmail.com>
In-Reply-To: <99fd7227e0abc0558a2954e95c1e049edc9ba7b3.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 20 Feb 2026 00:51:55 +0000
X-Gm-Features: AaiRm53B_cdA8ZJc6taTOhVTyfdFAcNww6_mHJ11BIQIZvjVHUu8ZBQMfCbpHY0
Message-ID: <CANk7y0jJnUhp8yDW_CJQ2icm590hdSim+gmvou1A66244JtxeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Add KF_FORBID_SLEEP modifier for
 KF_ACQUIRE kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 10:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2026-02-18 at 10:25 -0800, Puranjay Mohan wrote:
>
> [...]
>
> > @@ -10510,6 +10514,8 @@ static int release_reference_nomark(struct bpf_=
verifier_state *state, int ref_ob
> >               if (state->refs[i].type !=3D REF_TYPE_PTR)
> >                       continue;
> >               if (state->refs[i].id =3D=3D ref_obj_id) {
> > +                     if (state->refs[i].forbid_sleep)
> > +                             state->forbid_sleep_count--;
>
> Nit: I'd do it inside release_reference_state() just to have a
>      fool-proof point for decrementing this counter.
>      As it stands release_reference_state() is called from two
>      more places and one need to think if .forbid_sleep_count
>      needs to be handled there as well (it is not, at the moment).

Yes, I will move it there.

>
> >                       release_reference_state(state, i);
> >                       return 0;
> >               }
> > @@ -10847,7 +10853,8 @@ static int check_func_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
> >
> >               if (env->subprog_info[subprog].might_sleep &&
> >                   (env->cur_state->active_rcu_locks || env->cur_state->=
active_preempt_locks ||
> > -                  env->cur_state->active_irq_id || !in_sleepable(env))=
) {
> > +                  env->cur_state->active_irq_id || env->cur_state->for=
bid_sleep_count ||
> > +                  !in_sleepable(env))) {
>
> The whole expression is the same as '!in_sleepable_context(env)', right?

Yes, in this case because if (env->cur_state->active_locks) { already
prints for this specific case, and if  active_locks=3D=3D0 then all this
hunk is equivalent to  !in_sleepable_context(env), will change it in
next version.

>
> >                       verbose(env, "global functions that may sleep are=
 not allowed in non-sleepable context,\n"
> >                                    "i.e., in a RCU/IRQ/preempt-disabled=
 section, or in\n"
> >                                    "a non-sleepable BPF program context=
\n");
> > @@ -11435,6 +11442,11 @@ static int check_resource_leak(struct bpf_veri=
fier_env *env, bool exception_exit
> >               return -EINVAL;
> >       }
> >
> > +     if (check_lock && env->cur_state->forbid_sleep_count) {
> > +             verbose(env, "%s cannot be used inside nosleep region\n",=
 prefix);
> > +             return -EINVAL;
> > +     }
> > +
>
> Is this check really necessary?
> Some resource is forbidding sleep here, so there would be an error report=
 already.

Yeah, maybe we will support KF_FORBID_SLEEP in future without
reference tracking, but for now I will remove it in the next version.

>
> [...]
>
> > @@ -11658,6 +11671,14 @@ static int check_helper_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn
> >               }
> >       }
> >
> > +     if (env->cur_state->forbid_sleep_count) {
> > +             if (fn->might_sleep) {
> > +                     verbose(env, "sleepable helper %s#%d in nosleep r=
egion\n",
> > +                             func_id_name(func_id), func_id);
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
>
> Wdyt about consolidating this code as something like:

I agree, will add a preparatory patch that does this and will use it in thi=
s one

>
>   if (fn->might_sleep && !in_sleepable_context(env)) {
>         verbose(env, "sleepable helper %s#%d in %s region\n",
>                 func_id_name(func_id), func_id, non_sleepable_context_des=
cription(env));
>         return -EINVAL;
>   }
>
> ?
>
> [...]
>
> > @@ -14113,6 +14139,11 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >               return -EACCES;
> >       }
> >
> > +     if (sleepable && env->cur_state->forbid_sleep_count) {
> > +             verbose(env, "sleepable kfunc %s in nosleep region\n", fu=
nc_name);
> > +             return -EACCES;
> > +     }
> > +
>
> Above this check there is:
>
>         if (sleepable && !in_sleepable(env)) {
>                 verbose(env, "program must be sleepable to call sleepable=
 kfunc %s\n", func_name);
>                 return -EACCES;
>         }
>
> Should it be `sleepable && !in_sleepable_context(env)` instead?
> If it should, then this hunk would be redundant.

This is just for printing the correct kind of message. Actually this
should go below after

=C2=BB       if (env->cur_state->active_irq_id && sleepable) {
=C2=BB       =C2=BB       verbose(env, "kernel func %s is sleepable within
IRQ-disabled region\n", func_name);
=C2=BB       =C2=BB       return -EACCES;
=C2=BB       }

=C2=BB       if (is_kfunc_rcu_protected(&meta) && !in_rcu_cs(env)) {
=C2=BB       =C2=BB       verbose(env, "kernel func %s requires RCU critica=
l
section protection\n", func_name);
=C2=BB       =C2=BB       return -EACCES;
=C2=BB       }


sleepable && !in_sleepable_context(env) will catch all of them
together, so maybe I could  consolidate all of then with a helper
like: non_sleepable_context_description()
but some of these checks and intermingled and would make reviewing
difficult so I will send it as a follow-up.
