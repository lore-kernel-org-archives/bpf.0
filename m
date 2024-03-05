Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01BF134BD
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675844; cv=none; b=kazdvqbSuz/vHsH1LmpeATlVV5WWR/tL+wAnWNSjXxLDJmFINLysUa8k8b2oVqri5VBll6c4nZppixHAOz7RQBsmRjyLZhlxOu+aIiK93sAGkgAI+mTJ3FwyQV2T/Olr3SisPfxXSN9spoZynijWhTyp50MdnKMDhkNbJe34ZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675844; c=relaxed/simple;
	bh=8wJW9CDRLZ5qSWAe4zJLIBWZf9pkXGPMM63sy+9+1r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGXxrP1wvce1cDRLi7wVO5LLhrWXKdKdvI5oFR9xgq0u0HECYdpMRREAXKKvHlQ3fxf8UCjc4p40ZRyA+jkz7SUkNFg6LdJZFQX3WVDKhyDuxkObY7VHEwDmOmiBBJsIqLiZ4rB756mGKpKApk8zgP+mnYn8qNbZgaXq+XUK1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTWDbyWb; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTWDbyWb"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29a2d0f69a6so4450617a91.3
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 13:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709675842; x=1710280642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ol/ZNySclnS+90e/4a4ogiou/YGL2RpnfeCpD7SfA4=;
        b=UTWDbyWb/GUlCeo/4KuaywxBJ6LEWdAaVtoJ5FLBNfqFBo6AzruSD6HfoO6d224i7N
         MU149G2dAUMQIOHVmuaNHlqmh+UF4mQJRR1MoE2MpMPt13fa8QMEGZjfX4RXig7h8mMq
         dBFN/eUWQ1m8cJF+pYdofxFzWDKxtmRrbNOXVCdCon7QO0zhezPjhvgr78k1uGwU0yvl
         x8CQp39DX0eS9Qy3BDRqANXr7acnd3mrI4iBq63yRWVzUmww1D9gtOeUzrvs0JYQeP2g
         5pF3JqwqvDNWko90N3Y5hikJbcTP5ZJQn+apS3LQHnGf5+XOk5zxKD7gnqF5N7uKSBOL
         zv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709675842; x=1710280642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ol/ZNySclnS+90e/4a4ogiou/YGL2RpnfeCpD7SfA4=;
        b=G9LIv+j8I3IExgAGNlXLmduUjvAVZEwQ3rs4GHgb/84OTJpIeIYtt3NbBa8UAenhod
         gI0Tp1O0i+uIQ/9yFoMOshQZg0IheWceaH/Jw1a7C89ahhsh9MpKHJVeFAj5lbKSbuJ6
         KR3Io/wdM3XfjlW0mIg7zULakoCTkFRCVoVfUTWBVGP3dYDKiJjRMq7yH9WnjEnKwi1s
         9udPctQHquTVaURSNXGibD0pggUugEoAGCjFlD/e2bFaeO8Hr2sHWuA5nwk9STI5QAPJ
         Jhb8I+T5gBSlI8Q5dSsVvGsz/s4TjE4ItBZ6dZJ8N2AgVkjm9wXyTCopvvEuO8HyNhFD
         LIXw==
X-Gm-Message-State: AOJu0YyxE25ZXZKq/3Zi4tMZP+t+UvlNoSfCBjOu1xZ76NNaLAijH15b
	vSP65APz7jn+PslnDxJFSRBKwmTs0xHMDERfaIuv7tFVoR0RDpNjLPczIBX94FoHS0tZ/UDP2CC
	9FFOop7iV5nYxccaYANvU/uYBMUE=
X-Google-Smtp-Source: AGHT+IEQysnDEqj1kqqlV1dXvkvSim4nH/+CGsG71Pz+IAUQc/yE7ormbbjCduO2eFazWDwaM2dAokoYWbUQmXYMG28=
X-Received: by 2002:a17:90b:889:b0:299:87ba:8a2 with SMTP id
 bj9-20020a17090b088900b0029987ba08a2mr11293318pjb.41.1709675842110; Tue, 05
 Mar 2024 13:57:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305045219.66142-1-alexei.starovoitov@gmail.com>
 <20240305045219.66142-3-alexei.starovoitov@gmail.com> <CAEf4BzbvBwcCU2dHwDKdY1HC2z8yo_Tv_=23KOT7UaP1867fGQ@mail.gmail.com>
 <CAADnVQL0f=pP0qQvnu4ZnQGx_E3f+=Y+O4goRG96qaU6sfpqdw@mail.gmail.com>
In-Reply-To: <CAADnVQL0f=pP0qQvnu4ZnQGx_E3f+=Y+O4goRG96qaU6sfpqdw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 13:57:10 -0800
Message-ID: <CAEf4BzYmzpLvzj911y8bvo7PXHSow+thoXcDVn77+=mrqKoM_Q@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/4] bpf: Recognize that two registers are
 safe when their ranges match
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:18=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 5, 2024 at 11:03=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Mar 4, 2024 at 8:52=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > When open code iterators, bpf_loop or may_goto is used the following =
two states
> > > are equivalent and safe to prune the search:
> > >
> > > cur state: fp-8_w=3Dscalar(id=3D3,smin=3Dumin=3Dsmin32=3Dumin32=3D2,s=
max=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xf))
> > > old state: fp-8_rw=3Dscalar(id=3D2,smin=3Dumin=3Dsmin32=3Dumin32=3D1,=
smax=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xf))
> > >
> > > In other words "exact" state match should ignore liveness and precisi=
on marks,
> > > since open coded iterator logic didn't complete their propagation,
> > > but range_within logic that applies to scalars, ptr_to_mem, map_value=
, pkt_ptr
> > > is safe to rely on.
> > >
> > > Avoid doing such comparison when regular infinite loop detection logi=
c is used,
> > > otherwise bounded loop logic will declare such "infinite loop" as fal=
se
> > > positive. Such example is in progs/verifier_loops1.c not_an_inifinite=
_loop().
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> >
> > You haven't updated stacksafe() to work with enums (the code still
> > assumes bool), please adjust.
>
> great catch.
>
> > pw-bot: cr
> >
> > Also, I wonder if we actually need three cases. We need EXACT only for
> > infinite loop detection, right? I wonder if that infinite loop
> > detection is actually that useful in practice, I rarely encounter it
> > (if at all), and it constantly causes issues.
> >
> > What if we just dropped infinite loop detection logic altogether and
> > have NOT_EXACT vs RANGE_WITHIN logic only?
>
> The infinite loop logic is for better user experience.
> With:
> time ./test_verifier 145
> #145/p calls: conditional call 6 OK
> Summary: 1 PASSED, 0 SKIPPED, 0 FAILED
>
> real    0m0.191s
> user    0m0.001s
> sys    0m0.053s
>
> without (on prod kernel):
> time ./test_verifier 145
> #145/p calls: conditional call 6 FAIL
> Unexpected error message!
>     EXP: infinite loop detected
>     RES: BPF program is too large. Processed 1000001 insn
> verification time 5182443 usec
> stack depth 0+0
> processed 1000001 insns (limit 1000000) max_states_per_insn 4
> total_states 33336 peak_states 33336 mark_read 1
>
> real    0m5.375s
> user    0m0.002s
> sys    0m4.700s
>
> I hope that eventually we can replace the 1M insn limit with
> "if the verifier is making progress, keep going".
> Then states_maybe_looping() will be replaced with something else.
> It should address non-converging bpf_loop/open iterators
> that hit 1M right now while walking the same insns over and over again.
> Something like "did we visit this insn 1k times" may be enough.

Yeah, my hopes were very low for getting rid of that check, but it
always is causing problems... Alright, fine, we'll have to live with a
more complicated tri-state exactness check, unfortunately.

>
> > >  kernel/bpf/verifier.c | 39 ++++++++++++++++++++++-----------------
> > >  1 file changed, 22 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 226bb65f9c2c..74b55d5571c7 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -16254,8 +16254,8 @@ static int check_btf_info(struct bpf_verifier=
_env *env,
> > >  }
> > >
> > >  /* check %cur's range satisfies %old's */
> > > -static bool range_within(struct bpf_reg_state *old,
> > > -                        struct bpf_reg_state *cur)
> > > +static bool range_within(const struct bpf_reg_state *old,
> > > +                        const struct bpf_reg_state *cur)
> > >  {
> > >         return old->umin_value <=3D cur->umin_value &&
> > >                old->umax_value >=3D cur->umax_value &&
> > > @@ -16419,21 +16419,26 @@ static bool regs_exact(const struct bpf_reg=
_state *rold,
> > >                check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
> > >  }
> > >
> > > +enum exact_level {
> > > +       NOT_EXACT,
> > > +       EXACT,
> > > +       RANGE_WITHIN
> > > +};
> > > +
> > >  /* Returns true if (rold safe implies rcur safe) */
> > >  static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_sta=
te *rold,
> > > -                   struct bpf_reg_state *rcur, struct bpf_idmap *idm=
ap, bool exact)
> > > +                   struct bpf_reg_state *rcur, struct bpf_idmap *idm=
ap,
> > > +                   enum exact_level exact)
> > >  {
> > > -       if (exact)
> > > +       if (exact =3D=3D EXACT)
> > >                 return regs_exact(rold, rcur, idmap);
> > >
> > > -       if (!(rold->live & REG_LIVE_READ))
> > > +       if (!(rold->live & REG_LIVE_READ) && exact !=3D RANGE_WITHIN)
> >
> > imo, `exact =3D=3D NOT_EXACT` is easier to follow (we excluded EXACT ab=
ove)
>
> ok.
>
> > >                 /* explored state didn't use this */
> > >                 return true;
> > > -       if (rold->type =3D=3D NOT_INIT)
> > > +       if (rold->type =3D=3D NOT_INIT && exact !=3D RANGE_WITHIN)
> >
> > ditto
> >
> > >                 /* explored state can't have used this */
> > >                 return true;
> > > -       if (rcur->type =3D=3D NOT_INIT)
> > > -               return false;
> >
> > do we need to remove this? in which case will it do the wrong thing?
>
> Yes.
> Consider cur-type =3D=3D rold->type =3D=3D NOT_INIT exact =3D=3D RANGE_WI=
THIN
> and regsafe() will return false, but should return true via:
>         default:
>                 return regs_exact(rold, rcur, idmap);

oh, very subtle and error-prone, so yeah, I like the explicit check below m=
ore

>
> Having said that it's better to change above two 'if'-s to
> if (rold->type =3D=3D NOT_INIT) {
>     if (exact =3D=3D NOT_EXACT || rcur->type =3D=3D NOT_INIT)
>       return true;
> }
> to avoid doing regs_exact() for the common case.

sure, give it a try, but I got to say that it is now quite hard to
follow the logic with the tri-state "exactness"

>
> > >
> > >         /* Enforce that register types have to match exactly, includi=
ng their
> > >          * modifiers (like PTR_MAYBE_NULL, MEM_RDONLY, etc), as a gen=
eral
> > > @@ -16468,7 +16473,7 @@ static bool regsafe(struct bpf_verifier_env *=
env, struct bpf_reg_state *rold,
> > >                         return memcmp(rold, rcur, offsetof(struct bpf=
_reg_state, id)) =3D=3D 0 &&
> > >                                check_scalar_ids(rold->id, rcur->id, i=
dmap);
> > >                 }
> > > -               if (!rold->precise)
> > > +               if (!rold->precise && exact !=3D RANGE_WITHIN)
> >
> > same, I think explicit `exact =3D=3D NOT_EXACT` is easier to follow
>
> ok
