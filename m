Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296C155A5D
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876044; cv=pass; b=B+5U286dFQoa76bVSBT1g7reVyCZyf6wh2tjQcpoQK32yE+Pwo+3+knAzgV/P+koSGToKiHIsbLkb/aySs/jjaM5O+h2tSh+IIbRq0uNXbfmBgJpUf+NHkW+iVxr3AO+xzEi8Pg1r/cy4WdFsl4s8QNatokOSwbJ96YLJbA2NY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876044; c=relaxed/simple;
	bh=RxtcwpztGp0mYEgrZ9qMRhx4+bmsCvWD3JFqEp/tmHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiEZHw/TwQH0BBa0qQisCFlbN4gG+ETbg2tN2ise0DVrOXEl7ZVBo37bo12mcPIgSRzYpFxqxaO1V0fWVGjQVdWM/EX0rBZVtliuszWxN1a1dLmVYjZtMLkpZrU99XON9Bdeb2BHKD2EnblaRmiFoayA4AfXnsQA0hEwBB9Eb4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BzFHX+Ka; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BzFHX+Ka"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb3865ea6fso10598a34.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 20:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782876042; cv=none;
        d=google.com; s=arc-20260327;
        b=f/Kcx4q5UMP09jiypiEqsI6JJnHvDzFtgn49EG0eVASkDjVrUxmjH3VGgzRUvtwBkb
         hGJgyX17bkK4mXwaEyutvX5NnQRHTDiQoemgglZZwWgVCF+VCZMT4nvS5zkRxabvgc0b
         +Ijzt0ir+AkWog/Uir7V1H5FZU26C6vU44xaQYeF2p5lp7zDlumavezkrkJpVtAdgSB9
         VfPmei8bUdeXSHYejDmwcv4lCuQpA0Yl1gSQ2lSODmD0nUKcV6FeLFyP25ZEig/GqLp/
         CZMs/vKU6jTS3bGbgsuGOvo17dnfl/rP1DodSaS+IrhbZqLJJ/v1hQLlJyJLUihH5txN
         GfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2N+msG67XKvItUVY55FS4/emZkqDvzrnsWiB4SJXA5o=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=rE6rz48udtucMSAnsjjWFWdy+Z0i/wUYGPFNWjMR2K71tjvazgFxoY1HBNDPd/gn2d
         9jgnWvLOVCzCPUyFE3DNAgiEH1uEj1aCPUiL+DMaF3MMkBF9ds7RFZcphQ4VazCKc6BO
         y3MTgwMK60x9EF4JnKKusfDnq7w68a8Wbs0WAl9Pw8ylktQYnmV6khhziDZHwohGUSyT
         RGFraI6NRumTMGzEy6I8uzzxS5ER2r/Rb0WYU2ghq3sKQBo7lACfDvFdkhHdZLjjGgUJ
         f7u0KbJF4Ko7RZHKtvxpZzAXojP4KlBhH1+DUrwdT/0T9q2XsxESTvRYCdkaQeX+/bnC
         l11Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782876042; x=1783480842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2N+msG67XKvItUVY55FS4/emZkqDvzrnsWiB4SJXA5o=;
        b=BzFHX+KaYSD23revJzb0Y10f4Q4KqA6DVC+6lK3Rukr04t3aUSaeETiN4JTvt7lTX2
         /JJSf9H1Q0M7DCMQKuqi9qw5iY7Yrr4x2rW+LIEQGu6zo2Y3+LczI+V97VIxe9al1h3r
         N/kIAk+6Ubq/cTBTP0mVgoLjbvdXeAOZhfk9YFjpVmYIVw5sl20oXCLNeoPnY3zVg7R2
         LaoLUxtS2hqTzDhNOPdsyDAq+tz7oPppyjwjPwzFyz7MmTsmFumoy1dbBqu5AWW8rZuS
         44Nh5TqyW/WD8EhAYK6jigqeSSRM9JzFZUXnMniU2RFn5Ecw9GWzGTt3ERW/mp6ELUyj
         SIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782876042; x=1783480842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2N+msG67XKvItUVY55FS4/emZkqDvzrnsWiB4SJXA5o=;
        b=cvP6rJxP/UbGdXykZdQjnAKxlOMIt/SMYpwOZGHNactGvDaB6RiETh34sAyFV+3Nww
         ZwOdfjIM1xRkC43jvvgekBFXvZ3MXcrEKv3giYvGXEypKPxOKtYINh1DlzlH/N2D2hB1
         HW1qFdmP7hoT5/Yany0yaXpk7o0hxKK8jdQvizEOvuwymPVxqgFiHIchyootD4J0ZEtK
         elaSoNkJj0Jbg7Hy6kyMRlGOxG/7KJ/gQoNIdvPssB9ZqQBOSjKhI0oow/jazwTp80mh
         y3Vtp2iWLS8/Zk3E74YRwEznbdAyuw5AtF6Y0526V0FanjnVXh4nSz0J7SQstpJuyYGO
         lFQw==
X-Gm-Message-State: AOJu0YxKtYY3TsWRHBcZScicgnUP5/IMzj9MycJiSEhI+5fxbDeDGruY
	ly0oJsSDZ13ou9nY80AxySeS8Ebs7iDozhwyWwXBvYwzBhPwPN1fmb5xlPrL6Lm7HY6USHI4Ekk
	Ni0U7Hk5pbIHZEaqRfQ1kKcEF0KY8+JpqDdrChpnkhA==
X-Gm-Gg: AfdE7cntCqXSWKPiXbKdgs2YC1J2e69RY9NqVgVw3PzeJblQKT6XnFdZcOr/a5hhspx
	vNlR0Z63FkLezj8gvve0tl4TVDtpt9ddIjP0IFC6SUGEL9nJVB3eokVwT+cXAzwNDopzYhxX7yr
	1SU2UtcT149zABrQgEtQ99zaf/lHEC1dTsdxPx6y7meERLTuNmzHuuEp4T/zpJOAr9mxAN1JPBB
	KXJnFN7k8LvUgsh94FRQfU3IEt6Bs4wYASeyjyLBNA+d9+ULHRoqdtrp3uJLg5PTH8McDyvmG0=
X-Received: by 2002:a05:6808:191f:b0:496:7ba:89b7 with SMTP id
 5614622812f47-49607ba95b6mr657735b6e.6.1782876041837; Tue, 30 Jun 2026
 20:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505062026.91724-3-cuiyunhui@bytedance.com> <20260505072635.27923C2BCB4@smtp.kernel.org>
In-Reply-To: <20260505072635.27923C2BCB4@smtp.kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 1 Jul 2026 11:20:30 +0800
X-Gm-Features: AVVi8CcoFpqxF5PhV14dTdaZbZMkY9ne_n8LdC7VwoKZ_u2i4GWjbagj4k94u-I
Message-ID: <CAEEQ3w=KmjNTn5NwyoU8DX8hkB74PiTyp=vNKnG_1P1WVCekrA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 2/3] riscv: introduce percpu.h into include/asm
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi sashiko,

On Tue, May 5, 2026 at 3:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Critical] The 8-bit and 16-bit `this_cpu_add` fallback logic fails to =
mask arithmetic overflow, corrupting adjacent percpu variables.
> - [High] The 32-bit and 64-bit `this_cpu_and` macros incorrectly perform =
an AND-NOT operation instead of a bitwise AND.
> - [High] Missing early-clobber modifiers (`=3D&r`) on output operands in =
`PERCPU_8_16_RET_OP` allow destructive register overlapping.
> --
>
> commit f4a490dc0b24e17cbd874e03d02e506d017e61b6
> Author: Yunhui Cui <cuiyunhui@bytedance.com>
>
> riscv: introduce percpu.h into include/asm
>
> This commit introduces a RISC-V percpu header to implement direct this_cp=
u
> operations. It provides macros for 8, 16, 32, and 64-bit read, write, and
> atomic memory operations.
>
> > diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/p=
ercpu.h
> > new file mode 100644
> > index 0000000000000..3b26fe45e70f4
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/percpu.h
>
> [ ... ]
>
> > +#define PERCPU_8_16_OP(name, amo_insn, sz, sfx, val_type, new_val_expr=
, asm_op)                      \
> > +static inline void __percpu_##name##_amo_case_##sz(void *ptr, unsigned=
 long val)             \
> > +{                                                                     =
                       \
> > +     if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&                        =
                       \
> > +             riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {     =
                       \
> > +             asm volatile ("amo" #amo_insn #sfx " zero, %[val], %[ptr]=
"                      \
> > +                     : [ptr] "+A"(*(val_type *)ptr)                   =
                       \
> > +                     : [val] "r"((val_type)((new_val_expr) & PERCPU_8_=
16_GET_MASK(sz)))      \
> > +                     : "memory");                                     =
                       \
> > +     } else {                                                         =
                       \
> > +             u32 *ptr32 =3D PERCPU_8_16_GET_PTR32(ptr);               =
                         \
> > +             const unsigned long shift =3D PERCPU_8_16_GET_SHIFT(ptr);=
                         \
> > +             const u32 mask =3D PERCPU_8_16_GET_MASK(sz) << shift;    =
                         \
> > +             const val_type val_trunc =3D (val_type)((new_val_expr)   =
                         \
> > +                                        & PERCPU_8_16_GET_MASK(sz));  =
                       \
> > +             u32 retx, rc;                                            =
                       \
> > +             val_type new_val_type;                                   =
                       \
> > +                                                                      =
                       \
> > +             asm volatile (                                           =
                       \
> > +                     "0: lr.w %0, %2\n"                               =
                       \
> > +                     "and %3, %0, %4\n"                               =
                       \
> > +                     "srl %3, %3, %5\n"                               =
                       \
> > +                     #asm_op " %3, %3, %6\n"                          =
                       \
>
> Is it possible for an 8-bit or 16-bit addition to overflow here? If there=
 are
> carry bits outside the subword boundary, they aren't masked out before th=
e
> result is shifted left.
>
> Could this silent overflow spill into and corrupt adjacent per-CPU variab=
les?

Thanks, will fix this in the next version.

>
> > +                     "sll %3, %3, %5\n"                               =
                       \
> > +                     "and %1, %0, %7\n"                               =
                       \
> > +                     "or %1, %1, %3\n"                                =
                       \
> > +                     "sc.w %1, %1, %2\n"                              =
                       \
> > +                     "bnez %1, 0b\n"                                  =
                       \
> > +                     : "=3D&r"(retx), "=3D&r"(rc), "+A"(*ptr32), "=3D&=
r"(new_val_type)             \
> > +                     : "r"(mask), "r"(shift), "r"(val_trunc), "r"(~mas=
k)                     \
> > +                     : "memory");                                     =
                       \
> > +             }                                                        =
                       \
> > +}
>
> [ ... ]
>
> > +#define PERCPU_8_16_RET_OP(name, amo_insn, sz, sfx, val_type, new_val_=
expr)                  \
> > +static inline val_type __percpu_##name##_return_amo_case_##sz(void *pt=
r, unsigned long val)  \
> > +{                                                                     =
                       \
> > +     if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&                        =
                       \
> > +             riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {     =
                       \
>
> [ ... ]
>
> > +     } else {                                                         =
                       \
> > +             u32 *ptr32 =3D PERCPU_8_16_GET_PTR32(ptr);               =
                         \
> > +             const unsigned long shift =3D PERCPU_8_16_GET_SHIFT(ptr);=
                         \
> > +             const u32 mask =3D (PERCPU_8_16_GET_MASK(sz) << shift);  =
                         \
> > +             const u32 inv_mask =3D ~mask;                            =
                         \
> > +             const val_type val_trunc =3D (val_type)((new_val_expr)   =
                         \
> > +                                        & PERCPU_8_16_GET_MASK(sz));  =
                       \
> > +             u32 old, new, tmp;                                       =
                       \
> > +                                                                      =
                       \
> > +             asm volatile (                                           =
                       \
> > +                     "0: lr.w %0, %3\n"                               =
                       \
> > +                     "and %1, %0, %4\n"                               =
                       \
> > +                     "srl %1, %1, %5\n"                               =
                       \
> > +                     "add %1, %1, %6\n"                               =
                       \
> > +                     "and %1, %1, %7\n"                               =
                       \
> > +                     "sll %1, %1, %5\n"                               =
                       \
> > +                     "and %2, %0, %8\n"                               =
                       \
> > +                     "or %2, %2, %1\n"                                =
                       \
> > +                     "sc.w %2, %2, %3\n"                              =
                       \
> > +                     "bnez %2, 0b\n"                                  =
                       \
> > +                     : "=3Dr"(old), "=3Dr"(tmp), "=3D&r"(new), "+A"(*p=
tr32)                        \
>
> Should the old and tmp output operands use the early-clobber modifier (=
=3D&r)?
>
> Since they are written to early in the instruction sequence before inputs
> like mask (%4), shift (%5), or val_trunc (%6) are consumed, could the com=
piler
> allocate them to the same physical registers, leading to clobbered inputs=
?
>
> > +                     : "r"(mask), "r"(shift), "r"(val_trunc), "r"(PERC=
PU_8_16_GET_MASK(sz)), \
> > +                     "r"(inv_mask)                                    =
                       \
> > +                     : "memory");                                     =
                       \
> > +             return (val_type)(tmp >> shift);                         =
                       \
> > +     }                                                                =
                       \
> > +}
>
> [ ... ]
>
> > +#define this_cpu_and_1(pcp, val)     _pcp_protect(__percpu_andnot_amo_=
case_8, pcp, ~(val))
> > +#define this_cpu_and_2(pcp, val)     _pcp_protect(__percpu_andnot_amo_=
case_16, pcp, ~(val))
> > +#define this_cpu_and_4(pcp, val)     _pcp_protect(__percpu_andnot_amo_=
case_32, pcp, ~(val))
> > +
> > +#ifdef CONFIG_64BIT
> > +#define this_cpu_and_8(pcp, val)     _pcp_protect(__percpu_andnot_amo_=
case_64, pcp, ~(val))
> > +#endif
>
> Since the underlying __percpu_andnot_amo_case_32 and 64 macros directly u=
se the
> amoand instruction on the value passed, does negating val here with ~(val=
)
> cause the hardware to perform an AND-NOT operation (pcp &=3D ~val) instea=
d of a
> bitwise AND (pcp &=3D val)?
>
> > +
> > +#define this_cpu_or_1(pcp, val)      _pcp_protect(__percpu_or_amo_case=
_8, pcp, val)
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505062026.91=
724-1-cuiyunhui@bytedance.com?part=3D2

Thanks,
Yunhui
