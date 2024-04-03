Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386E152E01
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166694; cv=none; b=BlTrnkNASEKUVqsE3Z9FP4M8JH9nbEmV6e5SRBlsEE8rB8yMXcrFleOoSDzc/bz+LmqobKiWhOxDbOx7v/ihT3x1l1vM1uXUi4/pA0iNtD1lyYzu8F4roroz/mB0C9c0XTCNXxAu1aGpsjBfIHfQaZljTt8ciLPPbLHTJWcUxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166694; c=relaxed/simple;
	bh=0IIJpog3SkpieXnqH+mGUepKsW36O6vEzRbYtUS0iW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IY/xr+fd3NSe6x7N+0cxWzddo7qRT2lPMgC3umY2d6j31IZNj7/Lr3sdgPXN+mml+s241fLn4s7araoEuw2uEkPunYqx70L9yDetPeqgsepYgm+kEgfc2/xQpdBP1JKC+Jz0gB4MTFq5jKZLkrZHVq3fQLD2rj3q4v+zVkAM+jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNWW3KkX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNWW3KkX"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343aa6ae9e8so48782f8f.0
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712166690; x=1712771490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVYJZl0jx5WwJ2dsoFApCfG3A3osVHI1r+vbO/MaGG0=;
        b=NNWW3KkXQdILdNDr/mU0pgJcB6ljHMSvRmLR9ZCtXFfqXbisciHSZkZFGbgz2CNN+F
         mRaIKW/dKhE7RXI8gt33T9gsE4bHtbavjTBdTlyYMo0zS7Nt3euv1ExMqeM/9vsATJv9
         ndi5DWDVcZwSbXHywO76WaABX5ZR1oCGyagKzILbbluWZG+fChmqGXQOkOLj53iGIgY3
         ytbtjkkxmAuyDwDxtHF2Jn1SwxuSy8Cue6kMP+bF9cf6nk8ZB+FRQvBp2Uf7Cr6Oxj+T
         khSFxINITI8bBpLSsbqi3nj4BHpGdYwX8qJKi5tkPJj4dIaJAiR70hyrJB+Q3Rls4SDm
         c8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712166690; x=1712771490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVYJZl0jx5WwJ2dsoFApCfG3A3osVHI1r+vbO/MaGG0=;
        b=qkimhM2bkQSMFQ9gYMko45vNa0NUFP00mnGT19/YudAd/afkU9Scu2Huz0K7/OZocM
         cKA4+X+j0bGq2RMlGdAv5wLDQXtgK4355K/z/PqD7Eqo/BsoHMRiH8SrAaP2HcIT2nHI
         uoUwU9NiieOzBMZQXB/Ac3unFPdggjgqpHIKAyCYMnF617I7tjO2fN3gJqvkjjFXxAUU
         TLKPz6kL6wH4AGAe+BbVxCBTBjaQaSEURRPSsGU/GlyMAkFR6c77OlwysFjPJVCSIsxA
         Y8G0cbLzqqdBqP6+X6GFtCjTQOXxbqwJLhtghEUdd2ImCWxP8rAxxHdAYMVRfhVjuonu
         GNgQ==
X-Gm-Message-State: AOJu0YxCy20b8NWRCckElmvPWTFyQL0ZrnK9NgIWi6qL1lSbQ6BMJJF1
	66+u74HBm3QIG9sYnUn1CqIbInpp/g549yseqZpBsFsNcZ+z6USXsyhHF0XQuwkoDd2w1P+IwZq
	qkJK3jfETD+g1dFQ2791a+l/m0+Y=
X-Google-Smtp-Source: AGHT+IG44IPHnvgWdI/vWXOG3oOzpxaLjArGOZd2EHaD85MtbtR9mmoGgiMaZz4BKEP/Go1ke8h/A7pXNHc/z98RaYk=
X-Received: by 2002:adf:e404:0:b0:343:9c77:9381 with SMTP id
 g4-20020adfe404000000b003439c779381mr111740wrm.50.1712166689584; Wed, 03 Apr
 2024 10:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402190542.757858-1-andrii@kernel.org> <20240402190542.757858-3-andrii@kernel.org>
In-Reply-To: <20240402190542.757858-3-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Apr 2024 10:51:18 -0700
Message-ID: <CAADnVQJoyFoU53eSqC4OtfbnEO7CS=TCSPKpW=vJB4qY5QJJdg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] bpf: inline bpf_get_branch_snapshot() helper
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 12:05=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Inline bpf_get_branch_snapshot() helper using architecture-agnostic
> inline BPF code which calls directly into underlying callback of
> perf_snapshot_branch_stack static call. This callback is set early
> during kernel initialization and is never updated or reset, so it's ok
> to fetch actual implementation using static_call_query() and call
> directly into it.
>
> This change eliminates a full function call and saves one LBR entry
> in PERF_SAMPLE_BRANCH_ANY LBR mode.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 55 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fcb62300f407..49789da56f4b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20157,6 +20157,61 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                         goto next_insn;
>                 }
>
> +               /* Implement bpf_get_branch_snapshot inline. */
> +               if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&
> +                   insn->imm =3D=3D BPF_FUNC_get_branch_snapshot) {
> +                       /* We are dealing with the following func protos:
> +                        * u64 bpf_get_branch_snapshot(void *buf, u32 siz=
e, u64 flags);
> +                        * int perf_snapshot_branch_stack(struct perf_bra=
nch_entry *entries, u32 cnt);
> +                        */
> +                       const u32 br_entry_size =3D sizeof(struct perf_br=
anch_entry);
> +
> +                       /* struct perf_branch_entry is part of UAPI and i=
s
> +                        * used as an array element, so extremely unlikel=
y to
> +                        * ever grow or shrink
> +                        */
> +                       BUILD_BUG_ON(br_entry_size !=3D 24);
> +
> +                       /* if (unlikely(flags)) return -EINVAL */
> +                       insn_buf[0] =3D BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 0=
, 7);

optimizing this out with is_reg_const(R3) is probably overkill?
Just mentioning in case you need to skip this branch.

> +
> +                       /* Transform size (bytes) into number of entries =
(cnt =3D size / 24).
> +                        * But to avoid expensive division instruction, w=
e implement
> +                        * divide-by-3 through multiplication, followed b=
y further
> +                        * division by 8 through 3-bit right shift.
> +                        * Refer to book "Hacker's Delight, 2nd ed." by H=
enry S. Warren, Jr.,
> +                        * p. 227, chapter "Unsigned Divison by 3" for de=
tails and proofs.
> +                        *
> +                        * N / 3 <=3D> M * N / 2^33, where M =3D (2^33 + =
1) / 3 =3D 0xaaaaaaab.
> +                        */
> +                       insn_buf[1] =3D BPF_MOV32_IMM(BPF_REG_0, 0xaaaaaa=
ab);
> +                       insn_buf[2] =3D BPF_ALU64_REG(BPF_REG_2, BPF_REG_=
0, 0);
> +                       insn_buf[3] =3D BPF_ALU64_IMM(BPF_RSH, BPF_REG_2,=
 36);
> +
> +                       /* call perf_snapshot_branch_stack implementation=
 */
> +                       insn_buf[4] =3D BPF_EMIT_CALL(static_call_query(p=
erf_snapshot_branch_stack));
> +                       /* if (entry_cnt =3D=3D 0) return -ENOENT */
> +                       insn_buf[5] =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0=
, 4);
> +                       /* return entry_cnt * sizeof(struct perf_branch_e=
ntry) */
> +                       insn_buf[6] =3D BPF_ALU32_IMM(BPF_MUL, BPF_REG_0,=
 br_entry_size);
> +                       insn_buf[7] =3D BPF_JMP_A(3);
> +                       /* return -EINVAL; */
> +                       insn_buf[8] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVAL)=
;
> +                       insn_buf[9] =3D BPF_JMP_A(1);
> +                       /* return -ENOENT; */
> +                       insn_buf[10] =3D BPF_MOV64_IMM(BPF_REG_0, -ENOENT=
);
> +                       cnt =3D 11;
> +
> +                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +
> +                       delta    +=3D cnt - 1;
> +                       env->prog =3D prog =3D new_prog;
> +                       insn      =3D new_prog->insnsi + i + delta;
> +                       continue;
> +               }
> +
>                 /* Implement bpf_kptr_xchg inline */
>                 if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&
>                     insn->imm =3D=3D BPF_FUNC_kptr_xchg &&
> --
> 2.43.0
>
