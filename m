Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12915689D
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182213; cv=none; b=lCy2Drl43x5v+sV9Lf6PQ+E3zvwxWGM3WFC6GR2JojeVJJK/JaTQ+QNKebOZo2/pYY6Yt0CM0fow3u8qSXMnqiawuTNxkToJ4urcFFooMmXxL+RE414KN2MnQlP+QIl4Tb0w7Xs5wq8OGHHxVenBV/1YdO/nV99h+Z7O0Gha+hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182213; c=relaxed/simple;
	bh=ciASpvK9hLxkO78w3cjoSrNsdsGqAfmIX7zsNNQ+K8A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=P+7Z4OHaNPs4LOsBGBT+tLA9yfF4dxuup8TQ67hx48uq/REv+pxokI1AGU0WsMG2ZJvQrWyLti5OBkSg7TMPeeZQ5Uzb3I4DYmnavxthZsIrvBT2eNY2Ut8z7b91N6mBLv6wnlbYtF4wqF5ADEf/UEvYpWzaKdebtV8esX3JD2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPG6dxAY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPG6dxAY"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0f3052145so2845975ad.2
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712182211; x=1712787011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nI5MgmL823HzXE6o/aOLxub2ONY5oTfgYgK8CmuV/+8=;
        b=RPG6dxAYsnc11KXMyqogr/mJatXHRyF3CZErw61FEynh132FC332192jiCbJVoE1CC
         ThvoLZ3PNtUzmIrqsMKTw1viTXLhBde/Xl8g6EkHa7KZzBSjHvHzenjUnIKX+BrY5MOO
         a0Qumq7qlE7FQMUqGwK1TXshGnM+VQQ74oM4lCoIbNER89HQJgbBqKDXCs3dXF8djqxh
         K5LjM6ev7nRa8GjpqeZiIWxbTSvGFGP4fqL8doHG3IilKL86K9IGOIzMXamBJxttihvR
         yMp+Aje0HkvfeNZ8LTUsIShxL71YnbNSgdRe7Eqk5h93d1dVGHb5OA2bl/DRnZud/90W
         7SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712182211; x=1712787011;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nI5MgmL823HzXE6o/aOLxub2ONY5oTfgYgK8CmuV/+8=;
        b=RzmVMmYrmdXUkoH9Wv0vrFbWnQZIRPjI3fok96/Zwptz0Ophy6I6JZE1CSPaNG3MoV
         T2gciPZSOFrkyWN2KhGTbYh/4H0zNBhdwRsHFV6INxb4WeJkUklCOZU40Vpqg2ISC8bI
         Tzkra8P8a6QRqAHTAai1L26zbhHDKaPa3h3azF6fPT4jLXMsl8L0pOu6wSZ8ddYFwgN0
         grfwvkmjYkscyqofBOhoIycMuiNS8XqYzQi2o7B94jgNGzQT2tupuSRhS9VDGDlZxmLv
         QXLm+vpqhxCwAHekI8hp3gSDQO48IBMQNzqx9yFcjjRY4o6b5JOoVa91rFLUX8O4v7GY
         N5eg==
X-Gm-Message-State: AOJu0YzAc9RBq9U2xBVmLstOY0Mm9h4e6cfXqa/SdU/3k8yOptVV5IJ1
	wYP53VXa9Bu12fD3oBzydjKBck0T+BiDchiJSSjRz29FYkd4aUoS
X-Google-Smtp-Source: AGHT+IGr0RlQ9Umr0faReBB1+UyX1fVMqh95mDrXoFUe+xXL5Bstsd+8GQXANlKmdhXm8LPohYi8kg==
X-Received: by 2002:a17:902:c94e:b0:1de:fbc2:99f0 with SMTP id i14-20020a170902c94e00b001defbc299f0mr672740pla.2.1712182210916;
        Wed, 03 Apr 2024 15:10:10 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b001dde004b31bsm14160419pln.166.2024.04.03.15.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 15:10:10 -0700 (PDT)
Date: Wed, 03 Apr 2024 15:10:09 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org, 
 kernel-team@meta.com
Message-ID: <660dd3c19a5c9_2144820828@john.notmuch>
In-Reply-To: <CAEf4BzZ_6hzWoniF+6jb6cOXK48EHNMH0ziZ1o26KW+Zo7OKyQ@mail.gmail.com>
References: <20240402190542.757858-1-andrii@kernel.org>
 <20240402190542.757858-3-andrii@kernel.org>
 <CAEf4BzZ_6hzWoniF+6jb6cOXK48EHNMH0ziZ1o26KW+Zo7OKyQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] bpf: inline bpf_get_branch_snapshot()
 helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko wrote:
> On Tue, Apr 2, 2024 at 12:05=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> >
> > Inline bpf_get_branch_snapshot() helper using architecture-agnostic
> > inline BPF code which calls directly into underlying callback of
> > perf_snapshot_branch_stack static call. This callback is set early
> > during kernel initialization and is never updated or reset, so it's o=
k
> > to fetch actual implementation using static_call_query() and call
> > directly into it.
> >
> > This change eliminates a full function call and saves one LBR entry
> > in PERF_SAMPLE_BRANCH_ANY LBR mode.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 55 +++++++++++++++++++++++++++++++++++++++++=
++
> >  1 file changed, 55 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fcb62300f407..49789da56f4b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20157,6 +20157,61 @@ static int do_misc_fixups(struct bpf_verifie=
r_env *env)
> >                         goto next_insn;
> >                 }
> >
> > +               /* Implement bpf_get_branch_snapshot inline. */
> > +               if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&=

> > +                   insn->imm =3D=3D BPF_FUNC_get_branch_snapshot) {
> > +                       /* We are dealing with the following func pro=
tos:
> > +                        * u64 bpf_get_branch_snapshot(void *buf, u32=
 size, u64 flags);
> > +                        * int perf_snapshot_branch_stack(struct perf=
_branch_entry *entries, u32 cnt);
> > +                        */
> > +                       const u32 br_entry_size =3D sizeof(struct per=
f_branch_entry);
> > +
> > +                       /* struct perf_branch_entry is part of UAPI a=
nd is
> > +                        * used as an array element, so extremely unl=
ikely to
> > +                        * ever grow or shrink
> > +                        */
> > +                       BUILD_BUG_ON(br_entry_size !=3D 24);
> > +
> > +                       /* if (unlikely(flags)) return -EINVAL */
> > +                       insn_buf[0] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_=
3, 0, 7);
> > +
> > +                       /* Transform size (bytes) into number of entr=
ies (cnt =3D size / 24).
> > +                        * But to avoid expensive division instructio=
n, we implement
> > +                        * divide-by-3 through multiplication, follow=
ed by further
> > +                        * division by 8 through 3-bit right shift.
> > +                        * Refer to book "Hacker's Delight, 2nd ed." =
by Henry S. Warren, Jr.,
> > +                        * p. 227, chapter "Unsigned Divison by 3" fo=
r details and proofs.
> > +                        *
> > +                        * N / 3 <=3D> M * N / 2^33, where M =3D (2^3=
3 + 1) / 3 =3D 0xaaaaaaab.
> > +                        */

Nice bit of magic. Thanks for the reference.

> > +                       insn_buf[1] =3D BPF_MOV32_IMM(BPF_REG_0, 0xaa=
aaaaab);
> > +                       insn_buf[2] =3D BPF_ALU64_REG(BPF_REG_2, BPF_=
REG_0, 0);
> =

> Doh, this should be:
> =

> insn_buf[2] =3D BPF_ALU64_REG(BPF_MUL, BPF_REG_2, BPF_REG_0);
> =

> I'll wait a bit for any other feedback, will retest everything on real
> hardware again, and will submit v2 tomorrow.
> =

> pw-bot: cr
> =


LGTM. With above fix,

Acked-by: John Fastabend <john.fastabend@gmail.com>

> =

> > +                       insn_buf[3] =3D BPF_ALU64_IMM(BPF_RSH, BPF_RE=
G_2, 36);
> > +
> > +                       /* call perf_snapshot_branch_stack implementa=
tion */
> > +                       insn_buf[4] =3D BPF_EMIT_CALL(static_call_que=
ry(perf_snapshot_branch_stack));
> > +                       /* if (entry_cnt =3D=3D 0) return -ENOENT */
> > +                       insn_buf[5] =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_=
0, 0, 4);
> > +                       /* return entry_cnt * sizeof(struct perf_bran=
ch_entry) */
> > +                       insn_buf[6] =3D BPF_ALU32_IMM(BPF_MUL, BPF_RE=
G_0, br_entry_size);
> > +                       insn_buf[7] =3D BPF_JMP_A(3);
> > +                       /* return -EINVAL; */
> > +                       insn_buf[8] =3D BPF_MOV64_IMM(BPF_REG_0, -EIN=
VAL);
> > +                       insn_buf[9] =3D BPF_JMP_A(1);
> > +                       /* return -ENOENT; */
> > +                       insn_buf[10] =3D BPF_MOV64_IMM(BPF_REG_0, -EN=
OENT);
> > +                       cnt =3D 11;
> > +
> > +                       new_prog =3D bpf_patch_insn_data(env, i + del=
ta, insn_buf, cnt);
> > +                       if (!new_prog)
> > +                               return -ENOMEM;
> > +
> > +                       delta    +=3D cnt - 1;
> > +                       env->prog =3D prog =3D new_prog;
> > +                       insn      =3D new_prog->insnsi + i + delta;
> > +                       continue;
> > +               }
> > +
> >                 /* Implement bpf_kptr_xchg inline */
> >                 if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&=

> >                     insn->imm =3D=3D BPF_FUNC_kptr_xchg &&
> > --
> > 2.43.0
> >
> =



