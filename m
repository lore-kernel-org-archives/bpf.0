Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6B3D72
	for <bpf@vger.kernel.org>; Sat, 30 Mar 2024 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711776185; cv=none; b=TxJEjdDhialjxMpn1LO2+tTjig46Ngobp1/nUYfl5yti6yc29xmA2/RoN9aCN7krw3brzYIbRiXP8kd844dMEWZDz8EA+Y+5w5PBTQC8gIjzwdGs6DqC+ye59X5yegJX1vwIAaZSvW1ERDmVDr4Hi/hDuntFIpdyiDvh4DzgSNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711776185; c=relaxed/simple;
	bh=DQfaq2e68SfAkfAZPa+8kjY6q1R2AsclMmwKgnJ7h4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecBq4B94g+dsZ9STwerQhGYmHrk4WA+2TZuVEQgb4K/jQQ4bFZInUeWrsjzX5y4hLXHCC7fR/76TMFkp+3YVlrviSlfp4KhI/qXc/0xWb92LhX4munMaFJwfDT4i4rK+Ik4dn7UQmKRD55e1cxlgTiiKXnKegVZM2q3W08bPXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTesXA3G; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTesXA3G"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dca1efad59so1798652a12.2
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711776183; x=1712380983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byLIs9Ewl10O6CPsEciZp5Foch7q1O2xYqS69IMsvJU=;
        b=iTesXA3G508qXSWy4t2VXB80uPi/k3blw0jsSoSzPsVyk2FZnPPKcwvDgUwh0+sL/B
         +pRNK/PSFIVEccnt4dd0NeE7PcBYraRROBWd++PanT+Pr7nAbZxmU9U5s3sXJnokqHij
         yRAHEvgj6t826YS4TFkTyzMlLpgfwi8p8jnKpV1+FBEngwyUdIa8w7N1Se9LjThZYQIf
         He7JfFUyrBxxdW3kKJ7ARiMtkNuldRw1eW0JiwCrX6fg8ENXp4G4osu2mrVngAJWFZN0
         ExZ8mkB9VaXEkNaEaHs0ibJMmGJTpvSKW/AUC6Iye5dI/cSrBkoAUkzWU8wQZytQil1/
         nv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711776183; x=1712380983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byLIs9Ewl10O6CPsEciZp5Foch7q1O2xYqS69IMsvJU=;
        b=m5te6cZdydtCZIJBVuiGyPC+fYXI0tLYIU9oWjkRvnu8az5aQ02o3OwFwOVl31zJGh
         VlVlCaQsEoJlomuOGdwJPL2Yl1oeWPo7ct2ac2brqy0UmUQ2wucB6AC6iVk7EWThZ0A9
         Bgah9gtg8+bq8kcz0T0OBQ4WgOhTvZ/RJzgYNILg2U0A7gz/4xruFSfPsHF3b4JMxIjm
         XWA708nFEG4CuDBizowMPFhR/huJnD4qW2SLvRP5qKwvC+Ayfm6gbPOgb3BJTbWBoKuN
         Z02VJsBR9hkNj0sbmCUF6Fw7XwTD2lyptZVClCgzMRUhtvAImT7+ClWskTr+39ohiHAn
         AKgg==
X-Forwarded-Encrypted: i=1; AJvYcCUusVY8K5HZ6w7DsFHOhGEfrzTVHKxGlCMArSDQ9zD/t91XtY8yyd2FDMlsuFjKe1HXoZ4Op9yieKPDNIRS3Uy4vS74
X-Gm-Message-State: AOJu0Ywjr88TtlI7cc4Ej0qGBB03fBRj15GMS0eQZ7oGiAJUUK12UzV5
	Pqr8XeBH7TceAxUUnM88nDC0mZypNDHbCzU2TyYPkbYFAbRbD9VdRRtjqFSVi9MQlK77fRxeHCt
	gWPfNbvaFYA2NXfVPcc106XzKAyI=
X-Google-Smtp-Source: AGHT+IGTm8Rsit+1Eh7244mNvtfc4SW/lrRXcZbUWCTdARE/k9izp/2eqsE6tNPRKNNLcR4B4TyUi1/2NNvXIyMiRYI=
X-Received: by 2002:a05:6a20:3d88:b0:1a3:c266:e7bd with SMTP id
 s8-20020a056a203d8800b001a3c266e7bdmr4375592pzi.38.1711776183185; Fri, 29 Mar
 2024 22:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329184740.4084786-1-andrii@kernel.org> <20240329184740.4084786-2-andrii@kernel.org>
 <ZgdcSDuyJ05z7sci@google.com>
In-Reply-To: <ZgdcSDuyJ05z7sci@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 22:22:51 -0700
Message-ID: <CAEf4BzYekOeYNiTjpU+P1NpcECRe7uoUMfN9H17TNVEKtPcsRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: add internal-only per-CPU LDX instructions
To: Stanislav Fomichev <sdf@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 5:26=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 03/29, Andrii Nakryiko wrote:
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
> > @@ -3365,6 +3389,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
> >       return true;
> >  }
> >
> > +bool bpf_jit_supports_percpu_insns(void)
> > +{
> > +     return true;
> > +}
> > +
> >  void bpf_jit_free(struct bpf_prog *prog)
> >  {
> >       if (prog->jited) {
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index 44934b968b57..85ffaa238bc1 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -75,6 +75,14 @@ struct ctl_table_header;
> >  /* unused opcode to mark special load instruction. Same as BPF_MSH */
> >  #define BPF_PROBE_MEM32      0xa0
> >
> > +/* unused opcode to mark special zero-extending per-cpu load instructi=
on. */
> > +#define BPF_MEM_PERCPU       0xc0
> > +
> > +/* unused opcode to mark special load-effective-address-of instruction=
 for
> > + * a given per-CPU offset
> > + */
> > +#define BPF_ADDR_PERCPU      0xe0
> > +
> >  /* unused opcode to mark call to interpreter with arguments */
> >  #define BPF_CALL_ARGS        0xe0
> >
> > @@ -318,6 +326,24 @@ static inline bool insn_is_cast_user(const struct =
bpf_insn *insn)
> >               .off   =3D OFF,                                   \
> >               .imm   =3D 0 })
> >
> > +/* Per-CPU zero-extending memory load (internal-only) */
> > +#define BPF_LDX_MEM_PERCPU(SIZE, DST, SRC, OFF)                      \
> > +     ((struct bpf_insn) {                                    \
> > +             .code  =3D BPF_LDX | BPF_SIZE(SIZE) | BPF_MEM_PERCPU,\
> > +             .dst_reg =3D DST,                                 \
> > +             .src_reg =3D SRC,                                 \
> > +             .off   =3D OFF,                                   \
> > +             .imm   =3D 0 })
> > +
>
> [..]
>
> > +/* Load effective address of a given per-CPU offset */
>
> nit: mark this one as internal only as well in the comment?
>

sure, will do, thanks

> (the change overall looks awesome, looking forward to trying it out)
