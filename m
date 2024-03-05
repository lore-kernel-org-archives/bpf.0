Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF83134BD
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673513; cv=none; b=gsE/X4Hd04Wg0jN5wqWKyAHi4YpBBU2WVS8BgagWkgs36s8ahSdi4iS8wvDYCkD2HZp4pvuQdTT44kp1Xpah3Dqb5I1PV5A7zJsgiHTfP2UThzCyHw8OxaavyLV2BcfHPir6jXN+ilMVq5DbFAVfrCwYMUhO0qEnYEyhN9PF37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673513; c=relaxed/simple;
	bh=1v1nrGDC4e+J0C/XU+sZ4ZJwKEjjS9Qe2OBfWqVUEqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbOWXkoDmxZo3BTIRKUKBtd+L8oVb2yMLaES6nhd/mrAGgxOeqsfXoAjsbmfTKaJw36i0wi/MqwgCDfOPC2BOPQJM1s/Gy9BDuYYJxYBO0k/brWqjRsiH2T2tqaIhetcYlBbe/l5TFx4rdyPzBh6V9ARYiEdbNRYnuKM5d5DrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjE9nqkL; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjE9nqkL"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d9c3f36c2so669641f8f.2
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 13:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709673510; x=1710278310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAPWDONohNoDHcBt06sV1Cmy03+BX/JiVlYcEcOg0yI=;
        b=QjE9nqkLZBYuK/IDs7Z2QLBf21RQV6mXVm4SQ5eUO2UHbSXiAYbg6cpDCsKCbKlAtP
         RRMUuukuafaYfGa0CKCIJw2VPtKAoaJAuI7v+gt/Er3mm90EAHtn1rqWwd7/Ul/OWP3j
         f6qgj/7zLCNkUcx5hLW72tmPKMmfeN5qn1vqGyBaYTwyr0yMucntm3vDxtyCjSAJDVBL
         vep1/+Zm2XO9bwbBm+lqZS45AUUEXB8eKCVdkv1XE+n9zyTEtPeOOAPULQDyRdZwoeNp
         NdMnbu4xphbwpjzokjDKHU8S02+nvFByCRHfHIg3F9oFGAYGFdV0RQB0Ux4Hp/tG6j/8
         JyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709673510; x=1710278310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAPWDONohNoDHcBt06sV1Cmy03+BX/JiVlYcEcOg0yI=;
        b=DccFrufqqWJl5gxoCF3v5f8OQc26GkGlzBhpsAMV6rhRH82Na8A/fGMoB4glVu1qwM
         dUdawr9HvzYv8Q1NS7IA9r6ASLH2Yicp301vskOPXY/C/IUBFcPjCcKjLr/kGZBWVH6K
         pB24Rwd9bhxxgct+/P42yXhquECVNl6aUYKG2Mc0b313z1WbrPd39dSCwVyxISmhnny3
         RPReC6YHaUrxsc5IWJK5bmOPALXmjZkDmH8uVCpaB2cu6iO5BK7J1Iep43VFER4hLpwl
         Eg2N92SePcV2gKRnLgcuPbr4YIFVtTaM8HFzzQWpDq7rUc3+2hvkdH3NymP7VtzkjSAq
         t02Q==
X-Gm-Message-State: AOJu0YxoEg8yhWRHJ+c9+FHKTXmn2q1D8GBFYJW3YsG1Wa2ZdHJKkZds
	vHP4AsfgmGkECigNT1Qxb8BBFEdMUlaPR8AlABsSDLPejOxqhbdZoXVZP4lUERPCaF+vq1XfCRL
	o0baWyM/+vu4W9DBg0ySICdGgFsI=
X-Google-Smtp-Source: AGHT+IE6XJRJkjWFxeqfvZUm/2H1S0TlkDsF/i0rnGfNUDa7TX3hykUqSeow9pu40e9d9pKNzTCxO9yCbTephRYHQnQ=
X-Received: by 2002:a05:6000:4c7:b0:33e:8fd:1173 with SMTP id
 h7-20020a05600004c700b0033e08fd1173mr10784341wri.60.1709673509699; Tue, 05
 Mar 2024 13:18:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305045219.66142-1-alexei.starovoitov@gmail.com>
 <20240305045219.66142-3-alexei.starovoitov@gmail.com> <CAEf4BzbvBwcCU2dHwDKdY1HC2z8yo_Tv_=23KOT7UaP1867fGQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbvBwcCU2dHwDKdY1HC2z8yo_Tv_=23KOT7UaP1867fGQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Mar 2024 13:18:18 -0800
Message-ID: <CAADnVQL0f=pP0qQvnu4ZnQGx_E3f+=Y+O4goRG96qaU6sfpqdw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/4] bpf: Recognize that two registers are
 safe when their ranges match
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 11:03=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 4, 2024 at 8:52=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > When open code iterators, bpf_loop or may_goto is used the following tw=
o states
> > are equivalent and safe to prune the search:
> >
> > cur state: fp-8_w=3Dscalar(id=3D3,smin=3Dumin=3Dsmin32=3Dumin32=3D2,sma=
x=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xf))
> > old state: fp-8_rw=3Dscalar(id=3D2,smin=3Dumin=3Dsmin32=3Dumin32=3D1,sm=
ax=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xf))
> >
> > In other words "exact" state match should ignore liveness and precision=
 marks,
> > since open coded iterator logic didn't complete their propagation,
> > but range_within logic that applies to scalars, ptr_to_mem, map_value, =
pkt_ptr
> > is safe to rely on.
> >
> > Avoid doing such comparison when regular infinite loop detection logic =
is used,
> > otherwise bounded loop logic will declare such "infinite loop" as false
> > positive. Such example is in progs/verifier_loops1.c not_an_inifinite_l=
oop().
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
>
> You haven't updated stacksafe() to work with enums (the code still
> assumes bool), please adjust.

great catch.

> pw-bot: cr
>
> Also, I wonder if we actually need three cases. We need EXACT only for
> infinite loop detection, right? I wonder if that infinite loop
> detection is actually that useful in practice, I rarely encounter it
> (if at all), and it constantly causes issues.
>
> What if we just dropped infinite loop detection logic altogether and
> have NOT_EXACT vs RANGE_WITHIN logic only?

The infinite loop logic is for better user experience.
With:
time ./test_verifier 145
#145/p calls: conditional call 6 OK
Summary: 1 PASSED, 0 SKIPPED, 0 FAILED

real    0m0.191s
user    0m0.001s
sys    0m0.053s

without (on prod kernel):
time ./test_verifier 145
#145/p calls: conditional call 6 FAIL
Unexpected error message!
    EXP: infinite loop detected
    RES: BPF program is too large. Processed 1000001 insn
verification time 5182443 usec
stack depth 0+0
processed 1000001 insns (limit 1000000) max_states_per_insn 4
total_states 33336 peak_states 33336 mark_read 1

real    0m5.375s
user    0m0.002s
sys    0m4.700s

I hope that eventually we can replace the 1M insn limit with
"if the verifier is making progress, keep going".
Then states_maybe_looping() will be replaced with something else.
It should address non-converging bpf_loop/open iterators
that hit 1M right now while walking the same insns over and over again.
Something like "did we visit this insn 1k times" may be enough.

> >  kernel/bpf/verifier.c | 39 ++++++++++++++++++++++-----------------
> >  1 file changed, 22 insertions(+), 17 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 226bb65f9c2c..74b55d5571c7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16254,8 +16254,8 @@ static int check_btf_info(struct bpf_verifier_e=
nv *env,
> >  }
> >
> >  /* check %cur's range satisfies %old's */
> > -static bool range_within(struct bpf_reg_state *old,
> > -                        struct bpf_reg_state *cur)
> > +static bool range_within(const struct bpf_reg_state *old,
> > +                        const struct bpf_reg_state *cur)
> >  {
> >         return old->umin_value <=3D cur->umin_value &&
> >                old->umax_value >=3D cur->umax_value &&
> > @@ -16419,21 +16419,26 @@ static bool regs_exact(const struct bpf_reg_s=
tate *rold,
> >                check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
> >  }
> >
> > +enum exact_level {
> > +       NOT_EXACT,
> > +       EXACT,
> > +       RANGE_WITHIN
> > +};
> > +
> >  /* Returns true if (rold safe implies rcur safe) */
> >  static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state=
 *rold,
> > -                   struct bpf_reg_state *rcur, struct bpf_idmap *idmap=
, bool exact)
> > +                   struct bpf_reg_state *rcur, struct bpf_idmap *idmap=
,
> > +                   enum exact_level exact)
> >  {
> > -       if (exact)
> > +       if (exact =3D=3D EXACT)
> >                 return regs_exact(rold, rcur, idmap);
> >
> > -       if (!(rold->live & REG_LIVE_READ))
> > +       if (!(rold->live & REG_LIVE_READ) && exact !=3D RANGE_WITHIN)
>
> imo, `exact =3D=3D NOT_EXACT` is easier to follow (we excluded EXACT abov=
e)

ok.

> >                 /* explored state didn't use this */
> >                 return true;
> > -       if (rold->type =3D=3D NOT_INIT)
> > +       if (rold->type =3D=3D NOT_INIT && exact !=3D RANGE_WITHIN)
>
> ditto
>
> >                 /* explored state can't have used this */
> >                 return true;
> > -       if (rcur->type =3D=3D NOT_INIT)
> > -               return false;
>
> do we need to remove this? in which case will it do the wrong thing?

Yes.
Consider cur-type =3D=3D rold->type =3D=3D NOT_INIT exact =3D=3D RANGE_WITH=
IN
and regsafe() will return false, but should return true via:
        default:
                return regs_exact(rold, rcur, idmap);

Having said that it's better to change above two 'if'-s to
if (rold->type =3D=3D NOT_INIT) {
    if (exact =3D=3D NOT_EXACT || rcur->type =3D=3D NOT_INIT)
      return true;
}
to avoid doing regs_exact() for the common case.

> >
> >         /* Enforce that register types have to match exactly, including=
 their
> >          * modifiers (like PTR_MAYBE_NULL, MEM_RDONLY, etc), as a gener=
al
> > @@ -16468,7 +16473,7 @@ static bool regsafe(struct bpf_verifier_env *en=
v, struct bpf_reg_state *rold,
> >                         return memcmp(rold, rcur, offsetof(struct bpf_r=
eg_state, id)) =3D=3D 0 &&
> >                                check_scalar_ids(rold->id, rcur->id, idm=
ap);
> >                 }
> > -               if (!rold->precise)
> > +               if (!rold->precise && exact !=3D RANGE_WITHIN)
>
> same, I think explicit `exact =3D=3D NOT_EXACT` is easier to follow

ok
