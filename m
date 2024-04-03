Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899815686D
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180783; cv=none; b=r/JUgC+gHtOis3XAv/EkLf41Y04gLxMbaNDL3U7gs09JHM4276Zl77wihP45hcfn71nzmlfbARMikDhnbP92EPsQUy10AodE/DiCST+KsYzYBZqHLzfByCE1vefZgJtS18z+qsL9RQ1a4ZMtclkmHGY7jdbzyBRSBFLCcHXzA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180783; c=relaxed/simple;
	bh=W8pe94i52/FAy/6CVTO2eatvvocArHrO+ddtF9UkS1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izHCuUhSIWIYdqGTw6q38rrNrb5czSFcjtr7V0kNobAgzgDgCQQusHlISZRb10WEjpMgVwm4zvWDDKzchf4UBFbGr7zmV1C+/KdCUjyL/CRnSMrKvNphdLBAr2rfeZBQnBFiNuoAzj+YYkylQZ9giunaJtAS12ADbo7l1QcpzTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhAhK6n1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhAhK6n1"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6fb9a494aso289041b3a.0
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712180782; x=1712785582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8a7JLMR9APXxT95h5CkO9ig701fknsfFfdRvjJcnfg=;
        b=DhAhK6n1lcHXqJDmBX9V5XIxcItbRsb9mkHTWrFsGIgxacrrDVQU5atw2tCgd21AL9
         8rd/ngLHEA3X84F2z9Urz16YDDCaELR1v3sBVz1MpCGgTJW6U8bx4pJLwPxKrkWLivgd
         ST0uh5rUaZUZvMZEfbw3W3DtTbC/tPO7O2bPs7FxSOr8n90ZIzLm6zHkAbB7y+mu8GY7
         RuplkMbaENH4r1133KvzI4nIlu9OZRfD/MDVioBEgTVFXA3D07aBfvp3gW8wZsoM+8Db
         k/nDZR4xz4Jdd/Kv4mdIjSjU1BC+NFJ+lAn4suqq0SUmXQaf535g+9IPaZGjRR4PN/lG
         RzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712180782; x=1712785582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8a7JLMR9APXxT95h5CkO9ig701fknsfFfdRvjJcnfg=;
        b=CdYojhYBBOUwxsakmCCP39gGTp2qbRZnHmhI52fUBM0dv3K6eaL9vd6F8WF1Wm7qNM
         Q3uoaRdARjn5fyPXmTozooBYdz1XtDm0ntBf50fvSjTI8Sv85Z37E/m9a8ZaO/Hq7aPc
         VCstN+p6eX5zPCWfrkxoKmOP8+k2Dcxm9Vegzw6xZwJcfZeIpmNeLaQibrqMBWQZ6Hd/
         ehWwOgbLV2tyJ98oFP9IoJx+xVd9l3OUj+LBA6najm7tTLE29AY93neINR2Tskmq2ken
         bfJ2T37d9YWBU/1Stid8XiYuS47ku5bwp3OxK7OLlyYfe9yAELt80XjwRgSK2CyGkTsH
         DFlw==
X-Forwarded-Encrypted: i=1; AJvYcCUUHhN7fnUYlP+1SY4bLI0+mwA3ztaepWhN20+/gOdW8u+OZHvRAzw28l4Vjrw0ScAKWnIU3Mo3e2i2FieqNKTeRAkk
X-Gm-Message-State: AOJu0YzHddzMt25+izbWozVzaGGI2vmjqlNrQioIvmCtaNVAaJ1X3tsg
	5YIGdKrehsmK6SvZgu1pboZnmpsmWQ/CR3FfX0n8bE6fSTEoEcgT3fEJltFlo/EVnYvWwQzVbuc
	errEJ8kUeZ7SQPlUw0+V9Ug7WuQE=
X-Google-Smtp-Source: AGHT+IE9tDkq6NcQuhzeeZNvGCXbdz+YeyQZAm3Bw5TV/MwWCeDPAfOX5LXEovwwD59Fos4ZK/7yrnH1UAiO2bH3NMU=
X-Received: by 2002:a05:6a20:9184:b0:1a5:6c53:b1f4 with SMTP id
 v4-20020a056a20918400b001a56c53b1f4mr959938pzd.39.1712180781599; Wed, 03 Apr
 2024 14:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403202409.2615469-1-tao.lyu@epfl.ch> <660dcccad5d07_21448208ee@john.notmuch>
In-Reply-To: <660dcccad5d07_21448208ee@john.notmuch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 14:46:07 -0700
Message-ID: <CAEf4BzZL6dCZx8Mve1RYXRJ1JeA6xqZeYN0V4Jfr9Xg04vAZrg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix verifier error due to narrower scalar
 spill onto 64-bit spilled scalar slots
To: John Fastabend <john.fastabend@gmail.com>
Cc: Tao Lyu <tao.lyu@epfl.ch>, bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	sanidhya.kashyap@epfl.ch, mathias.payer@nebelwelt.net, 
	meng.xu.cs@uwaterloo.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:40=E2=80=AFPM John Fastabend <john.fastabend@gmail=
.com> wrote:
>
> Tao Lyu wrote:
> > The verifier previously aimed to reject partial overwrite on an 8-byte =
stack slot
> > that contains a spilled pointer.
> > However, it rejects all partial stack overwrites
> > as long as the targeted stack slot is a spilled register,
> > because it does not check if the stack slot is a spilled pointer.
> >
> > Finally, incomplete checks will result in the rejection of valid progra=
ms,
> > which spill narrower scalar values onto scalar slots, as shown below.
> >
> > 0: R1=3Dctx() R10=3Dfp0
> > ; asm volatile ( @ repro.bpf.c:679
> > 0: (7a) *(u64 *)(r10 -8) =3D 1          ; R10=3Dfp0 fp-8_w=3D1
> > 1: (62) *(u32 *)(r10 -8) =3D 1
> > attempt to corrupt spilled pointer on stack
> > processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0.
> >
> > The issue is fixed by adding a check on the spilled register type of ta=
rgeted slots.
> >
> > Fixes: ab125ed3ec1c ("bpf: fix check for attempt to corrupt spilled poi=
nter")
> > Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> > ---
>
> A test case would be nice.

+1, please see progs/verifier_spill_fill.c, seems like a logical place

>
> >  kernel/bpf/verifier.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 17c06f1505e4..3064ba7c140f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4493,6 +4493,7 @@ static int check_stack_write_fixed_off(struct bpf=
_verifier_env *env,
> >        */
> >       if (!env->allow_ptr_leaks &&
> >           is_spilled_reg(&state->stack[spi]) &&
> > +         state->stack[spi].spilled_ptr.type !=3D SCALAR_VALUE &&
> >           size !=3D BPF_REG_SIZE) {
>
> Might be worth a helper we have is_spilled_reg and is_spilled_scalar_reg
> maybe a is_spilled_not_scalar_reg() is nice. Perhaps Andrii has a style
> opinion. Or,
>
>  is_spilled_reg(...) && !is_spilled_scalar_reg(...)

yeah, I'd probably go with this, definitely not "is_spilled_not_scalar_reg"=
 :)

>
> Not sure I like that any better than whats there in patch though.
>
> >               verbose(env, "attempt to corrupt spilled pointer on stack=
\n");
> >               return -EACCES;
> > --
> > 2.25.1
> >
> >
>
>
