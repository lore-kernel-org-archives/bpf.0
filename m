Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076413C5556
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774396791; cv=pass; b=S3mRywbMIVRpJaPLDrFLyhZzgHz1L0wvxWeHgK6esdYgy7VvW6bhA/i1dcq2SMIF1ZtRQuU3CGAi9WDYzXs4A8wpjjbofxvei/4vMauyHoFGpft5Qm0PDVyJfvaq2eEfQYdP9rweOYQpYMUgdTnKBp54NCZj8kSKA5dGt04WClI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774396791; c=relaxed/simple;
	bh=XbeGRET36mZqQ0lSSEZQyrYj1YmuFF8my6GhMPT4Fwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xr0e/ftabxeKguVRC61BNWxGKbqkef5OxsAhRX/UGB/H3Dbr66aXMxODuAIBhanbhy69Ioi1jbk8NQq0iatHachnUvxvNhuxcSdB6423Fw/DeHPhRHOdAFYPuIEMS7fWh5qeT86YoAHBRKFzpbYd9VudpFBpPxEhuCWYPi7s1Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgRDxGM3; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgRDxGM3"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ffe9a5b128so1640750137.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774396789; cv=none;
        d=google.com; s=arc-20240605;
        b=FivCIT5alBkvcIi/ZE2Glg35/JILoC86lduxQ2iyBq6tVHaizifRUXqE5UtfCMF2Ip
         zjmjHDm3tQs3XVOEWgPoorhUkIl2iqCcIQrradGzzL8A2QKmrXHufW+QJ6cs5irHULxi
         xWhB8VFkole+KDlXUeX0kV504tYBGgCq+ijB8qbErnOTggU/PRLI60f2no52rAIX8MlQ
         82nrzURtq8+FcJKj6ZpmPZIIfkzbilMV38esBV7x70R91jp9xuLTcbj/sz21QQCFJt74
         GsC37Xt6/CraX3sJo8nSebebEZLXVYShPh9WwdMAOLnvAv878j11EKsomO7ObVBFjImF
         gwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hGm6DPbfXuG3rLsEiNH1wUMYYktfpRSm1XaRXMhElP0=;
        fh=wsSThdFyvxnBMna4sDEREfGOcPQAPFhxV5Nc+Qlwn5Q=;
        b=LDqT+3Bq6WiqI6zAqaoIgqc50aEf+NC28ZnKU1/iJSUpCC5zIXvy1rvs2yr0qAmzdw
         /2miIw6dxyLuheziIYVGN79BSoYq3NHFEZNTT925wG+6D0Xwpv8CUsFgUXbmsT0awOvP
         wvR8yAfV/5proH6PWyW2526rM61VfkpShwDZeNuKgkCJ+lYe4JVom1Vi5tYQUN2osJyH
         PN5rF1n7muvTM7yePh9HmjBJXRNtSVlfcSALT4ao0ArKBAOzeI9NYR5DgZfkIqGOjjlT
         HSF35R9vxcjDXuRr7zJFqrWGKcwY7r+kdnuC3Zrj3npJs96ZCD+NG50iAD67lCuSBmAP
         OYSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774396789; x=1775001589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGm6DPbfXuG3rLsEiNH1wUMYYktfpRSm1XaRXMhElP0=;
        b=OgRDxGM3woJDJ2x2ozLV5n6LNtu24g0wGjxOQId6JR0RW5g0ggkRVzRHDWCbzFCW/w
         SjQY7iLacFau6XBqjlv1kphHqfe9Byh6TGDkzq4yPiDUp8+1tql8oqS4nvKa6duIb7kG
         NDUB87MGD215+8b8uDOtCYrNZgO+hq9lN16vVuEarQdw8P0511UZ0mzIbRuSYj3sS5ux
         MrRtGMLC6+sdN4W8CXlX/48SwtC/RUmqcPca5QHDw3UY+CyUrScc4m7wCyMQJixbPpgP
         2Cy6g0Kx6aLNQ3/kHD1hEvk9KVarRk60Fm/uQwAiR0Cuu1IC1QTEy/tk8M6ikUtR+JKA
         j1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774396789; x=1775001589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hGm6DPbfXuG3rLsEiNH1wUMYYktfpRSm1XaRXMhElP0=;
        b=CbBWYd/zYPED28h2GZ11I6ZoSlSav7MGdh4Tt1YUjzROowYOX8MHDPevL2iywoRPb+
         2xY+WaxQOfCevLrMq7FBfktG8ZrdXxphldJi3B/p0YtOp85LAxPYs2V2aD7ucOc6skLc
         9iuZ5Y2kgDw3m1N3X0v13E9u9ueRDo8NbGy3MwiMdEUfS4lvxP5kLKClBVB/b8u5YfN4
         kcbqUWR39CagdQvrtyV6R587hvbiwKHL0J+kGi69e/pAx7xIdHzJyaAOPT4gB9I83R3o
         YC7tz3PD7eascBTKCjng5T6ujMs3NTQeWu0p/eLY5qUEnbefXOICjWNaDoPweC/wv+xl
         HQnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8VIsvt0pTYrj1uXuOovTUCuL3xUVXTbb4TOf7F+aSaZ4QlDMTsMzKp1MF5NulW+YtjkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0tg1OzsfdgVdXOSS5rOWW0uhZDGwojKQctg7D7Y8BlCMNGu5
	LMOuEOiAC8BCJTJL6ACAV/LAgHoKg+zu0LZfanpID94i6ASVP70Xlpn9sirCzxlxu2hXdJPwsQu
	tHYtTZh0R59jRWdf7rTZWlutcJyQbAmE=
X-Gm-Gg: ATEYQzxflMGoFTc2bK5F0k6zEBfnZWeJ56Z3ZfxjasJpRNvGSZNmgLZMli8siqBRiDi
	lA+RMaZiWo6xj4vslYw5v8NAHQtFUajYjv+oEaCx/LWgZ5utQYvFWbhpEGq/kigpFQQOkoqm90p
	JZ0qwGSq2+K5aVK4ZxoKnu1LR+VzANvKg6EsIx2OyIXRwq5cvRl28CBWoUlvRV9MQCVSoJeeHSU
	dDvOOM9vuHSpz1RCCe2HWkrKv+eg9PA0Pun376MJOlo/26Ixc6ZFZX5nkGe8LL5OvYFRhZjPffd
	V/040yPOtFUWTgohnc2+/EgUDUuZnljFXJoTtJjXxw==
X-Received: by 2002:a05:6102:5a8e:b0:5ff:1cc2:aa98 with SMTP id
 ada2fe7eead31-60394875239mr813558137.35.1774396788898; Tue, 24 Mar 2026
 16:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774025082.git.paul.chaignon@gmail.com> <d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020.1774025082.git.paul.chaignon@gmail.com>
 <847173114a13630e1512ad05375c6b407720a916.camel@gmail.com>
In-Reply-To: <847173114a13630e1512ad05375c6b407720a916.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Tue, 24 Mar 2026 19:59:33 -0400
X-Gm-Features: AQROBzCrVUaMgDRfv1UyzLmeZr2ndv4GZnym7E7PbAAczBOcnia7f3vXIMYBr-o
Message-ID: <CAM=Ch05-XWF-x_VzUZAWhRO9eum-bjdutuwvPXEcOvnx_0omAA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] bpf: Simulate branches to prune based on
 range violations
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 3:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-03-20 at 17:49 +0100, Paul Chaignon wrote:
>
> [...]
>
> > @@ -16717,11 +16717,48 @@ static void find_good_pkt_pointers(struct bpf=
_verifier_state *vstate,
> >       }));
> >  }
> >
> > +static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf=
_reg_state *reg2,
> > +                             u8 opcode, bool is_jmp32);
> > +static u8 rev_opcode(u8 opcode);
> > +
> > +/* Learn more information about live branches by simulating both branc=
hes being
> > + * taken using regs_refine_cond_op. Because regs_refine_cond_op is sou=
nd when
> > + * the branch is taken, if it produces ill-formed register bounds, it =
must mean
> > + * that the branch is dead.
> > + */
> > +static int simulate_both_branches_taken(struct bpf_verifier_env *env, =
u8 opcode, bool is_jmp32)
> > +{
> > +     /* Fallthrough (FALSE) branch */
> > +     regs_refine_cond_op(&env->false_reg1, &env->false_reg2, rev_opcod=
e(opcode), is_jmp32);
> > +     reg_bounds_sync(&env->false_reg1);
> > +     reg_bounds_sync(&env->false_reg2);
> > +     /* If there is a range bounds violation in *any* of the abstract =
values in
> > +      * either reg_states in the FALSE branch (i.e. reg1, reg2), the
> > +      * FALSE branch must be dead. Only TRUE branch will be taken.
> > +      */
> > +     if (range_bounds_violation(&env->false_reg1) || range_bounds_viol=
ation(&env->false_reg2))
> > +             return 1;
> > +
> > +     /* Jump (TRUE) branch */
> > +     regs_refine_cond_op(&env->true_reg1, &env->true_reg2, opcode, is_=
jmp32);
> > +     reg_bounds_sync(&env->true_reg1);
> > +     reg_bounds_sync(&env->true_reg2);
> > +     /* If there is a range bounds violation in *any* of the abstract =
values in
> > +      * either reg_states in the TRUE branch (i.e. true_reg1, true_reg=
2), the
> > +      * TRUE branch must be dead. Only FALSE branch will be taken.
> > +      */
> > +     if (range_bounds_violation(&env->true_reg1) || range_bounds_viola=
tion(&env->true_reg2))
> > +             return 0;
>
> Why did you chose to limit these checks to range_bounds_violation(),
> excluding const_{subreg_,}tnum_out_of_sync_with_range_bounds()?

The main reason was because the invariant violations were typically
only detected by
range_bounds_violations().

> Also, it appears that tnum bounds checking functions are unnecessarily
> restricted and should be implemented as follows:
>
>   static bool const_tnum_out_of_sync_with_range_bounds(struct bpf_reg_sta=
te *reg)
>   {
>
>         u64 tnum_umin =3D reg->var_off.value;
>         u64 tnum_umax =3D reg->var_off.value | reg->var_off.mask;
>         s64 tnum_smin =3D (s64)tnum_umin;
>         s64 tnum_smax =3D (s64)tnum_smax;
>
>         // check that [tnum_umin, tnum_umax] and [reg->umin_value, reg->u=
max_value] intersect
>         // check that [tnum_smin, tnum_smax] and [reg->smin_value, reg->s=
max_value] intersect
>         return ...;
>   }
>
> Wdyt?

I like the idea! If we do this, we should also rename the function to simpl=
y
"tnum_range_mismatch" or something along those lines (as mentioned in
the other thread),
dropping the "const".

Technically, the verifier should maintain the invariant that all domain
pairs always have intersections. There are 10 domain pairs:
u64_s64, u64_tnum, s64_tnum, u32_s32, u32_tnum, s32_tnum,
u64_u32, u64_s32, u32_s64, s64_s32. We can have intersection checks
for each of these pairs, or we can stick to the major ones, i.e. the top 6
in this list.

Checking for intersections was part of the original idea in the RFC
for tnum_step()
I had sent a while back [1], which was about detecting intersection between
tnum and u64.

Generally a simple check will be
if (tmin > umax) || (tmax < umin) // no intersection

The original idea in the RFC was to use tnum_step to make this check
complete. Particularly, for cases like:

        t =3D x0x1 {1, 3, 9, 11}
        r =3D [4, 8] {4, 5, 6, 7, 8}

The above check won't suffice. We can add the following check:

if tnum_step(t, umin) > umax) // no intersection

Since tnum_step() has been upstreamed, maybe it is a good time to
revisit the idea, and have a sound and complete intersection check?
Or do you think that is overkill for this patch?

Also, then, should this patch introduce domain checks for all 10 domain pai=
rs?

[1]: https://lore.kernel.org/bpf/20251107192328.2190680-1-harishankar.vishw=
anathan@gmail.com/

> > +
> > +     /* Both branches are possible, we can't determine which one will =
be taken. */
> > +     return -1;
> > +}
> > +
> >  /*
> >   * <reg1> <op> <reg2>, currently assuming reg2 is a constant
> >   */
> > -static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct b=
pf_reg_state *reg2,
> > -                               u8 opcode, bool is_jmp32)
> > +static int is_scalar_branch_taken(struct bpf_verifier_env *env, struct=
 bpf_reg_state *reg1,
> > +                               struct bpf_reg_state *reg2, u8 opcode, =
bool is_jmp32)
> >  {
> >       struct tnum t1 =3D is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->=
var_off;
> >       struct tnum t2 =3D is_jmp32 ? tnum_subreg(reg2->var_off) : reg2->=
var_off;
>
> [...]
