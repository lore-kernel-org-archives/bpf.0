Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0313161BA
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776121032; cv=none; b=UrdTh9HLeAjEpw4ZO9RlnHV+lxwGfytLa8Ivgx8UKoW++zFDpdS0us8ml2YCyLBfs9oOFKXtngAtQkJ/2O7zeNzfdN9ZnfKCLCvBjdlppKwspSmmpsau3jytvhGjJLrZmngfFgxsbRD/7UtoHLd08aocvTYOc+0dKZW8aeIhKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776121032; c=relaxed/simple;
	bh=iEBINv1Tt1e+zu1b9jfKw5vSvUBKepLaVvplsTNbSaM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=khCMnjgVAwp8CdZHPqCsX07zTfg77DZKxGC7R6SFzzQF9qkuULJ3XVZKSADGz1hWMi1NPT/oBbEFLIiNOAfLczJnLoFtxFJg1vpxAOiTJI7dR1zMHI+JUGNl8nsUd65atWGMNzfRL9UCwt1i+u8OTpB53PtHh6My+fhkcC+t2yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWp5Tsb7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWp5Tsb7"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824c9da9928so3441584b3a.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776121031; x=1776725831; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dC2xZEaoECjSJiLfkudLOIMwiNFINJIA9EAqa6RKO58=;
        b=hWp5Tsb7n7akzRZcVST9gEjKUzbHIS4QegerUZytCmh+lFcdYgxfDUOtJAUGeVrs0I
         TFkGYHedpIcnZ4D+aELwzvyX9Z0nctKKuaUuftrWsgSy7ik2Tizo7hvyepAByzJbCgl+
         2eQUSDrZ2Ioxs3a4ifz7ugKm/PSGF2nlI3uEIhTG8MVui9hnV8jarfP+HfPdynvwIaM1
         q+YfWX+Dz6rKcMQMB7IWa+/oIf2QtGSzAKnoQ6f5P5ZuPHQBU1KMqKJqcQ3qX4z39b7h
         VwLzbcmNcIiWj2SN47uepFJ1fSwoDalMXhSdLMeZTWoX74i+Ec+xJ33u52/2FHd2yEIf
         +Okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776121031; x=1776725831;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dC2xZEaoECjSJiLfkudLOIMwiNFINJIA9EAqa6RKO58=;
        b=rCUR1iDRc6c7kJzInNGn0M9O+9p6OQMQJpSmfJ/nk2IFC6dKXTLonf965rBjullPAz
         quz38U/lJvUKWqAds3T9pt8kanP0MsNoZOKt/8YaJXulSa6tSNjq8HwWuAdGNL4dNqNr
         2Ty++ShrYBX4vLUgY9Qt/uHeSMeVzF9RhIft8JL1omPrpFU1iwRF0cvOEGuWvEdab9jo
         1rNdb69x00e7a1jQGqi+CmGWUr08X+MtqQTX0DVTopdNyl66XusdYlOpjf293n+3Gr/T
         H3+3KVcPMn5Jnr8rzunTDPn5aGlArUOHjCmAIpg1ZkxZD4TpMC0byD8FMCFUjEmeDaEs
         pTUg==
X-Gm-Message-State: AOJu0YzbfTUzHXGMo2vP2e0Qp2WF6Fpgyw0/CCNVRVU+Wnyvvn5J7klS
	NoUfLvA99Zs4HkaFTrmXKpNxEcr4fRb2n7D9P3q3HBkMn9EQsswMjm7Z
X-Gm-Gg: AeBDies5LAtuJ+UyeKAVojZA0AryrFcn2kGCyLuJaRevdAD+uhOF3pHOvue4/utRplA
	ETXWomLPijrvliiP6Rj/fB4lImYp6dQS6oviWkCmhJo0X4yn/vgVB4CzN3hdm5WfTipC8d7DF4F
	vUwmvP3qpjhnfGKKRQDsYIO5zd9yaACVL8bFccRqRFE8EY7dKfWc88CmKRYReRPCagj6G0eM7wY
	/OVS7xgPob6jBYJ91j209YVe3+FHm/6PRLGDBcOEuHdwx8uPSi4s04BN9OYUphkbHluaeGShMb5
	4K+f+VxcmET0cjVqe3S8vP5mP626APRmw/n8Qn/wV6SxpgLJXvC0yU5t2J3NRJBfH9uVaBOhbNl
	L3MeoIF4pq1+0yUYd+yjyjVuVoysjrK08wBIC4sApqAxYcHBtO5W37WbETapWqMLZvPfZ4PKVx1
	ks14el9AGDnEvrWwrTFTwAlVIQjC0snxhJK04eYAgXAwBylSnUuc25
X-Received: by 2002:a05:6a00:2183:b0:82c:7f08:8826 with SMTP id d2e1a72fcca58-82f0c1600dbmr15614250b3a.17.1776121030629;
        Mon, 13 Apr 2026 15:57:10 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c35194asm15564079b3a.20.2026.04.13.15.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 15:57:10 -0700 (PDT)
Message-ID: <5299deae0a38a4fd5e5e66df2ae816196ff7f5ca.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: fix arg tracking for
 imprecise/multi-offset BPF_ST/STX
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Mon, 13 Apr 2026 15:57:07 -0700
In-Reply-To: <CAADnVQLfiX0B1Lg4-n8qFNztmM5BJNkWCYeE3RAT2qxtifuO0g@mail.gmail.com>
References: <20260413-stacklive-fixes-v2-0-ff91c4f8d273@gmail.com>
	 <20260413-stacklive-fixes-v2-1-ff91c4f8d273@gmail.com>
	 <CAADnVQLfiX0B1Lg4-n8qFNztmM5BJNkWCYeE3RAT2qxtifuO0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-04-13 at 15:42 -0700, Alexei Starovoitov wrote:
> On Mon, Apr 13, 2026 at 2:58=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > BPF_STX through ARG_IMPRECISE dst should be recognized as a local
> > spill and join at_stack with the written value. For example,
> > consider the following situation:
> >=20
> >    // r1 =3D ARG_IMPRECISE{mask=3DBIT(0)|BIT(1)}
> >    *(u64 *)(r1 + 0) =3D r8
> >=20
> > Here the analysis should produce an equivalent of
> >=20
> >   at_stack[*] =3D join(old, r8)
> >=20
> > BPF_ST through multi-offset or imprecise dst should join at_stack with
> > none instead of overwriting the slots. For example, consider the
> > following situation:
> >=20
> >    // r1 =3D ARG_IMPRECISE{mask=3DBIT(0)|BIT(1)}
> >    *(u64 *)(r1 + 0) =3D 0
> >=20
> > Here the analysis should produce an equivalent of
> >=20
> >   at_stack[*r1] =3D join(old, none).
> >=20
> > Move the definition of the clear_overlapping_stack_slots() in order to
> > have __arg_track_join() visible. Remove the OFF_IMPRECISE constant to
> > avoid having two ways to express imprecise offset. Only
> > 'offset-imprecise {frame=3DN, cnt=3D0}' remains.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  kernel/bpf/liveness.c | 110 ++++++++++++++++++++++++++++--------------=
--------
> >  1 file changed, 61 insertions(+), 49 deletions(-)
> >=20
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index 1fb4c511db5a..23d19147f123 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
> > @@ -574,7 +574,7 @@ static int print_instances(struct bpf_verifier_env =
*env)
> >   *
> >   *   precise {frame=3DN, off=3DV}      -- known absolute frame index a=
nd byte offset
> >   *        |
> > - *   offset-imprecise {frame=3DN, off=3DOFF_IMPRECISE}
> > + *   offset-imprecise {frame=3DN, cnt=3D0}
> >   *        |                        -- known frame identity, unknown of=
fset
> >   *   fully-imprecise {frame=3DARG_IMPRECISE, mask=3Dbitmask}
> >   *                                 -- unknown frame identity; .mask is=
 a
> > @@ -607,8 +607,6 @@ enum arg_track_state {
> >         ARG_IMPRECISE   =3D -3,   /* lost identity; .mask is arg bitmas=
k */
> >  };
> >=20
> > -#define OFF_IMPRECISE  S16_MIN /* arg identity known but offset unknow=
n */
> > -
> >  /* Track callee stack slots fp-8 through fp-512 (64 slots of 8 bytes e=
ach) */
> >  #define MAX_ARG_SPILL_SLOTS 64
> >=20
> > @@ -622,28 +620,6 @@ static bool arg_is_fp(const struct arg_track *at)
> >         return at->frame >=3D 0 || at->frame =3D=3D ARG_IMPRECISE;
> >  }
> >=20
> > -/*
> > - * Clear all tracked callee stack slots overlapping the byte range
> > - * [off, off+sz-1] where off is a negative FP-relative offset.
> > - */
> > -static void clear_overlapping_stack_slots(struct arg_track *at_stack, =
s16 off, u32 sz)
> > -{
> > -       struct arg_track none =3D { .frame =3D ARG_NONE };
> > -
> > -       if (off =3D=3D OFF_IMPRECISE) {
> > -               for (int i =3D 0; i < MAX_ARG_SPILL_SLOTS; i++)
> > -                       at_stack[i] =3D none;
> > -               return;
> > -       }
> > -       for (int i =3D 0; i < MAX_ARG_SPILL_SLOTS; i++) {
> > -               int slot_start =3D -((i + 1) * 8);
> > -               int slot_end =3D slot_start + 8;
> > -
> > -               if (slot_start < off + (int)sz && slot_end > off)
> > -                       at_stack[i] =3D none;
> > -       }
> > -}
> > -
> >  static void verbose_arg_track(struct bpf_verifier_env *env, struct arg=
_track *at)
> >  {
> >         int i;
> > @@ -863,16 +839,15 @@ static void arg_track_alu64(struct arg_track *dst=
, const struct arg_track *src)
> >         *dst =3D arg_join_imprecise(*dst, *src);
> >  }
> >=20
> > -static s16 arg_add(s16 off, s64 delta)
> > +static bool arg_add(s16 off, s64 delta, s16 *out)
> >  {
> >         s64 res;
> >=20
> > -       if (off =3D=3D OFF_IMPRECISE)
> > -               return OFF_IMPRECISE;
> >         res =3D (s64)off + delta;
> > -       if (res < S16_MIN + 1 || res > S16_MAX)
> > -               return OFF_IMPRECISE;
> > -       return res;
> > +       if (res < S16_MIN || res > S16_MAX)
> > +               return true;
> > +       *out =3D res;
> > +       return false;
>=20
> Nice. It's almost check_add_overflow().
> May be something like:
>   s16 d =3D delta;
>   if (d !=3D delta)
>     return true;
>   return check_add_overflow(off, d, out);

I modeled api after the check_add_overflow() but using it directly
didn't occur to me for some reason.

I don't think the s16 cast is necessary, check_add_overflow results in
a call to __builtin_add_overflow(), which is documented as:

  > Built-in Function: bool __builtin_add_overflow (type1 a, type2 b, type3=
 *res)
  >   ...
  >   These built-in functions promote the first two operands into
  >   infinite precision signed type and perform addition on those
  >   promoted operands. The result is then cast to the type the third
  >   pointer argument points to and stored there. If the stored result is
  >   equal to the infinite precision result, the built-in functions
  >   return false, otherwise they return true. As the addition is
  >   performed in infinite signed precision, these built-in functions
  >   have fully defined behavior for all argument values.

> I'm curious whether asm will be better.

Disasm looks identical.
I'll respin with check_add_overflow(), fixes tag and a test nit from sashik=
o.
