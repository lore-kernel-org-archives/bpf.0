Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805E4945A
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022443; cv=none; b=XdxrK+g0v87x9ALEGces18TdDrMhZPC7myPVqK4VitkbgkHOtZKn/nEtmjGFUTNfug8TlRABEYAAxMrwd2HEPne6/sweDLjRFgob5JmWdNpo1cY/WGReqnhmoZfOFVB9aJv2tLj9ex1ICK9Z150xOq3msb02ogDt6Z4XnmZjwy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022443; c=relaxed/simple;
	bh=9yoTapFo28LvIVoUkYb1pfLeni8XGtJrZbEGFV3wSS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq7deueazuM3My9q9+fMqd6A4j3zoIzw9TUbFkDPB0sfbOGHV9O6hpL3yLcUsg/iEkXycm+um++ZMm5Tt95r/ATaxziAxyjUmW6NgUud4owCQaTecDtkWTYWLxqxzp+QRFNlytVxnVZYBTxJRVoL24TP8cu5rSsuU2LXsmXl43o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APNir5gp; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APNir5gp"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso4020695276.1
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 18:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712022440; x=1712627240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkXuv0TmTiF5gZCfqhSKP7XLEz1Th6XHZtsINndvrPo=;
        b=APNir5gpL43nm+hQP7im58B1VPEa+arVpmwi6PWJa6Oq0m1WxId60U0Qj7YdxR8UEm
         yop1YNYGgIhY6lU6PMAtBbOHedoKuF4630Cl2l3b8QO4OKLP0o3mrqPX8DWYaba1NAIG
         9HVij1r+QXxAi61N+A1AF/24af3Yec69bR2jCCkh5IYy32UmGBqYk6/04d6CZya/yR1x
         LWTTZ69gm5TKKqYdCJuOS2/svQlNO1tVOhcYE3aM5sOCHa64QlJk0w6qV0O4QFcQ+lUc
         poO4QLNp2cSLhTsqhHDd3PYURcgpEWhwcuV6Jl4NukWYF6hRpOrkSjBylaX616jfCEvD
         AO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712022440; x=1712627240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkXuv0TmTiF5gZCfqhSKP7XLEz1Th6XHZtsINndvrPo=;
        b=Y2RocBFmmIepWWsozGQ0/W4vDuyvKg9X8Ly0kHKci7YZIuAQHiLXkS9wk+E8WIgW1O
         B52IXlB9770SbmK7Rx/jAyWQhkIZadOmEsNCDoXVIJdFhabGoQ4L4VWF9hMT8QCVmA/l
         yaKZJ7XK1k5GHie6fic2ybYPjaYg9E0YQqc+wEBkterYDwz//GSBEIZlsLlBKz2j8ZdD
         YfRBUG2dftCsil/89GveTN+V/hcPy65Wqx7+sQmpvVQD14jtgxt/z92sTnocqSj+wFYP
         9ZN4cN4c9lSGEUffS+BHWe4+vBDs7fA5dyo54zBNMXaeXmgwapczfYoKhzKV/LzQgewU
         DklA==
X-Forwarded-Encrypted: i=1; AJvYcCW8vAqdTwZJ9AAEaeBfHSdVsoFeHacY7ERY/ummGIOzI9WTxr/vZtpST8zB3apsIKIAgXcgMzroshzbSDFAEy1QDoOP
X-Gm-Message-State: AOJu0Yx2/pzoZyUUlWZA13Oi68Uo9n/Vg0rUDbQUjZ8UyMNRbAM4iTSC
	onpXkxnZPeWn2Vn0E057mF2OCOhpyK+orOuP6K/rBODmQXPTwVTWgypOw9/DHusijM5aVww0+6q
	+cnwbMv70Imfi7WBxPSYu6aVVkgY=
X-Google-Smtp-Source: AGHT+IHwf+HBSASwkS2h0YEHwpcGs8t2yAG8VkiwTLNqs371QXs5djfeevTvCa9NTPCbq4XculpUDRtjiMW3B6dUmBY=
X-Received: by 2002:a25:5882:0:b0:dcf:3ef5:4d30 with SMTP id
 m124-20020a255882000000b00dcf3ef54d30mr6196085ybb.17.1712022440463; Mon, 01
 Apr 2024 18:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329184740.4084786-1-andrii@kernel.org> <20240329184740.4084786-2-andrii@kernel.org>
 <660b5b8cc7162_801520889@john.notmuch>
In-Reply-To: <660b5b8cc7162_801520889@john.notmuch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Apr 2024 18:47:07 -0700
Message-ID: <CAEf4BzbywTmsNJvjCbU_5HWaHwq+J+A0vwf48h30f302POwa-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: add internal-only per-CPU LDX instructions
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 6:12=E2=80=AFPM John Fastabend <john.fastabend@gmail=
.com> wrote:
>
> Andrii Nakryiko wrote:
> > Add BPF instructions for working with per-CPU data. These instructions
> > are internal-only and users are not allowed to use them directly. They
> > will only be used for internal inlining optimizations for now.
> >
> > Two different instructions are added. One, with BPF_MEM_PERCPU opcode,
> > performs memory dereferencing of a per-CPU "address" (which is actually
> > an offset). This one is useful when inlined logic needs to load data
> > stored in per-CPU storage (bpf_get_smp_processor_id() is one such
> > example).
> >
> > Another, with BPF_ADDR_PERCPU opcode, performs a resolution of a per-CP=
U
> > address (offset) stored in a register. This one is useful anywhere wher=
e
> > per-CPU data is not read, but rather is returned to user as just
> > absolute raw memory pointer (useful in bpf_map_lookup_elem() helper
> > inlinings, for example).
> >
> > BPF disassembler is also taught to recognize them to support dumping
> > final BPF assembly code (non-JIT'ed version).
> >
> > Add arch-specific way for BPF JITs to mark support for this instruction=
s.
> >
> > This patch also adds support for these instructions in x86-64 BPF JIT.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 29 +++++++++++++++++++++++++++++
> >  include/linux/filter.h      | 27 +++++++++++++++++++++++++++
> >  kernel/bpf/core.c           |  5 +++++
> >  kernel/bpf/disasm.c         | 33 ++++++++++++++++++++++++++-------
> >  4 files changed, 87 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 3b639d6f2f54..610bbedaae70 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1910,6 +1910,30 @@ st:                    if (is_imm8(insn->off))
> >                       }
> >                       break;
> >
> > +             /* internal-only per-cpu zero-extending memory load */
> > +             case BPF_LDX | BPF_MEM_PERCPU | BPF_B:
> > +             case BPF_LDX | BPF_MEM_PERCPU | BPF_H:
> > +             case BPF_LDX | BPF_MEM_PERCPU | BPF_W:
> > +             case BPF_LDX | BPF_MEM_PERCPU | BPF_DW:
> > +                     insn_off =3D insn->off;
> > +                     EMIT1(0x65); /* gs segment modifier */
> > +                     emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, sr=
c_reg, insn_off);
> > +                     break;
> > +
> > +             /* internal-only load-effective-address-of per-cpu offset=
 */
> > +             case BPF_LDX | BPF_ADDR_PERCPU | BPF_DW: {
> > +                     u32 off =3D (u32)(void *)&this_cpu_off;
> > +
> > +                     /* mov <dst>, <src> (if necessary) */
> > +                     EMIT_mov(dst_reg, src_reg);
> > +
> > +                     /* add <dst>, gs:[<off>] */
> > +                     EMIT2(0x65, add_1mod(0x48, dst_reg));
> > +                     EMIT3(0x03, add_1reg(0x04, dst_reg), 0x25);
> > +                     EMIT(off, 4);
> > +
> > +                     break;
> > +             }
> >               case BPF_STX | BPF_ATOMIC | BPF_W:
> >               case BPF_STX | BPF_ATOMIC | BPF_DW:
> >                       if (insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
>
> [..]
>
> > +/* Per-CPU zero-extending memory load (internal-only) */
> > +#define BPF_LDX_MEM_PERCPU(SIZE, DST, SRC, OFF)                      \
> > +     ((struct bpf_insn) {                                    \
> > +             .code  =3D BPF_LDX | BPF_SIZE(SIZE) | BPF_MEM_PERCPU,\
> > +             .dst_reg =3D DST,                                 \
> > +             .src_reg =3D SRC,                                 \
> > +             .off   =3D OFF,                                   \
> > +             .imm   =3D 0 })
> > +
> > +/* Load effective address of a given per-CPU offset */
> > +#define BPF_LDX_ADDR_PERCPU(DST, SRC, OFF)                   \
>
> Do you need OFF here? It seems the above is using &this_cpu_off.

Nope, I don't. I already changed it to BPF_MOV instruction with no
off, as suggested by Alexei.

>
> > +     ((struct bpf_insn) {                                    \
> > +             .code  =3D BPF_LDX | BPF_DW | BPF_ADDR_PERCPU,    \
> > +             .dst_reg =3D DST,                                 \
> > +             .src_reg =3D SRC,                                 \
> > +             .off   =3D OFF,                                   \
> > +             .imm   =3D 0 })
> > +
