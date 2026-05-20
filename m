Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC3032B104
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246053; cv=none; b=ZUZQ167mF6DYNbvas6Jjfm+qK4O9F6N50fY1hEG5feVeQ5AjXX/jf3vCJiyuX7lPyvj2J45WzcdxP0ARgcJO7qECB/YIr4N60pk3+AtFkvAvfM4f/0XBZIVHR+0vexjxgDoohiC1uuIuZBzQas14rnhMmrT0oB/5AmfcBb1Q6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246053; c=relaxed/simple;
	bh=2R05xtp6oSNCG45xxuw3C565pij5UvJwaEmjTDTytgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOm2jHaMpexRjACxLVQ8r8b8PuoYGYB8y6DbRdw5IqzSfMk/jrPUAwqCsfGtArO89F3MFNB5Qdb6QTKBDwWFu7utW1aSRxlD1Yco/j4m3slSsZQMgTL8wRIOvKNuVIpU7f1RTPxAEnYk+Kj5CtCJS75GQw3GzCltN/9BMWLU4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W18TpoQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W18TpoQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214831F000E9
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 03:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779246052;
	bh=YjH9+CxNm3i91NMc9o3j22DzhplX1a1RU/pc4F3hRTY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W18TpoQQ6k0YBcxRGIxzwPIAdk4VrVGC3tVdOxEnaY09A+4BNNplQre7+YWal/1oP
	 rg/Ex8qUkNMiA5RfCUtp4VCrGVbuZweWiXe3g/Kj35+PLFDNCD0EH4yjTFhI9KDoIB
	 4SeRmU6KLQImTvyXWLL/p9yY+3ZDnkKWnayFlpJ32kbZEQ+8+5odOSdSceTcpQg/lR
	 CfKP2gUTvmF5fiF7Nt0UvpR9wAAC6ejs3MIBU4z5AQHp7k16funp1tXzbHs21rZQYz
	 tnex7QDYLqrOYZnTNFfzxHOzF6GKTweStXjp0YiwJqiTfdZchmIys3g6F15X5pSYWA
	 XZ+wdZfjgLTtg==
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48909558b3aso45543195e9.0
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:00:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YwC3NAzWFnjxz2TrOlIiquwR+wV9RRXmR3+4x/i1AR966hblQDT
	GEtFHSZjRuxyfUm6sHyXGtiq7pmcdFR/j7YHFowEC6sfBAH9wOf/ZIB7IPSuthWxCt10wBmEMSk
	oOxkSbI2SXwaWfqKelNeMU11NMwC7wsQyW3NO28jI
X-Received: by 2002:a05:600c:1f94:b0:489:1d23:4524 with SMTP id
 5b1f17b1804b1-48fe60de736mr323896625e9.5.1779246050743; Tue, 19 May 2026
 20:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519215358.126364-1-kpsingh@kernel.org> <20260519231709.3D4561F000E9@smtp.kernel.org>
In-Reply-To: <20260519231709.3D4561F000E9@smtp.kernel.org>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 20 May 2026 05:00:37 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6rxGSrixr9sChFyXyu3JcjG3JmZGR5YgA0vV0WNJPs0g@mail.gmail.com>
X-Gm-Features: AVHnY4KogdrLN5rYE7c2YdjnAPa-dmFVVlDhSLQc_3WxQgUARPMySW9BEeeIhMk
Message-ID: <CACYkzJ6rxGSrixr9sChFyXyu3JcjG3JmZGR5YgA0vV0WNJPs0g@mail.gmail.com>
Subject: Re: [PATCH] bpf, libbpf: reject non-exclusive metadata maps in the
 signed loader
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 1:17=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] The generated BPF loader program uses a hardcoded 8-byte read (B=
PF_DW) to access the `excl_prog_sha` pointer field, which causes the BPF ve=
rifier to reject the loader on 32-bit architectures and silently bypasses t=
he exclusivity check.

I plan to move this to the kernel with a kfunc anyways. Any
suggestions for the 32 bit fix (apart from an ugly union in bpf_map).

> - [High] Branch target offset calculation is off-by-one, causing the jump=
 target to land past the beginning of the cleanup block.
> --

Yeah this is valid:

 Compute the cleanup-label offset after emitting the MOV that sets the
  error code in R7. Otherwise the JMP lands one insn past cleanup_label
  and skips the first FD-close, matching the emit_check_err() pattern.

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index becfda5b9025..6950443ba698 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -592,9 +592,9 @@ static void emit_signature_match(struct bpf_gen *gen)
                gen->hash_insn_offset[i] =3D gen->insn_cur - gen->insn_star=
t;
                emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_3, 0, 0, 0, 0, 0))=
;

-               off =3D  -(gen->insn_cur - gen->insn_start -
gen->cleanup_label) / 8 - 1;
+               emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
+               off =3D -(gen->insn_cur - gen->insn_start -
gen->cleanup_label) / 8 - 1;
                if (is_simm16(off)) {
-                       emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
                        emit(gen, BPF_JMP_REG(BPF_JNE, BPF_REG_2,
BPF_REG_3, off));
                } else {
                        gen->error =3D -ERANGE;
@@ -610,9 +610,9 @@ static void emit_signature_match(struct bpf_gen *gen)
        emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
                                         0, 0, 0, 0));
        emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1,
SHA256_DWORD_SIZE * sizeof(__u64)));
+       emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
        off =3D -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8=
 - 1;
        if (is_simm16(off)) {
-               emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
                emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, off));
        } else {
                gen->error =3D -ERANGE;

>
> commit 51df41105aded76b418cec093cbbaaad09c03147
> Author: KP Singh <kpsingh@kernel.org>
>
> bpf, libbpf: reject non-exclusive metadata maps in the signed loader
>
> This patch updates the BPF loader to verify that metadata maps are exclus=
ive
> while they are frozen. It places excl_prog_sha in struct bpf_map and emit=
s a
> check in gen_loader to reject the map with -EINVAL if excl_prog_sha is NU=
LL.
>
> > diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> > index cd5c2543f54d8..becfda5b90253 100644
> > --- a/tools/lib/bpf/gen_loader.c
> > +++ b/tools/lib/bpf/gen_loader.c
> [ ... ]
> > @@ -601,6 +601,23 @@ static void emit_signature_match(struct bpf_gen *g=
en)
> >                       emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
> >               }
> >       }
> > +
> > +     /* Reject if the metadata map is not exclusive. Without exclusivi=
ty
> > +      * the cached map->sha[] verified above can be stale: another BPF
> > +      * program with map access could have mutated the contents betwee=
n
> > +      * BPF_OBJ_GET_INFO_BY_FD and loader execution.
> > +      */
> > +     emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
> > +                                      0, 0, 0, 0));
> > +     emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, SHA256_DWORD_=
SIZE * sizeof(__u64)));
>
> [Severity: High]
> Does this 8-byte read (BPF_DW) cause issues on 32-bit architectures?
>
> Since pointers are 4 bytes long on 32-bit systems, the verifier will reje=
ct
> the loader program with an access size mismatch error (-EACCES) because i=
t
> expects the memory access size to exactly match the BTF-defined pointer
> size.
>
> Also, if the verifier check were bypassed, wouldn't an 8-byte read stradd=
le
> both the 4-byte excl_prog_sha and the adjacent 4-byte ops pointer? Since
> ops is always non-zero, the resulting 64-bit value would never be 0,
> causing the BPF_JEQ check below to silently fall through and bypass the
> exclusivity check.
>
> > +     off =3D -(gen->insn_cur - gen->insn_start - gen->cleanup_label) /=
 8 - 1;
> > +     if (is_simm16(off)) {
> > +             emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
> > +             emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, off));
>
> [Severity: High]
> Is the branch target offset calculation off by one?
>
> The offset off is computed based on insn_cur before emitting the
> BPF_MOV64_IMM instruction. Since emitting the BPF_MOV64_IMM instruction
> advances insn_cur by 8 bytes, and BPF branch offsets are evaluated relati=
ve
> to the instruction immediately following the branch itself, the actual ju=
mp
> target evaluates to cleanup_label + 8 bytes (1 instruction) instead of th=
e
> cleanup_label itself.
>
> This skips the first instruction of the cleanup block. If nr_progs > 0, i=
t
> skips loading the first FD into BPF_REG_1 and calls sys_close() with an
> uninitialized or stale register (e.g., a map pointer), potentially closin=
g a
> random/incorrect file descriptor in the system. If nr_progs =3D=3D 0 and
> nr_maps > 0, it may jump into the middle of a 16-byte BPF_LD_IMM64
> instruction, causing verifier rejection.
>
> Does this need to be adjusted, even though it appears to be a pattern cop=
ied
> from the loop above it?
>
> > +     } else {
> > +             gen->error =3D -ERANGE;
> > +             emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
> > +     }
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519215358.12=
6364-1-kpsingh@kernel.org?part=3D1
