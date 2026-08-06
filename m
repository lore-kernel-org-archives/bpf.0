Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EFF3346A8
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043395; cv=pass; b=iEJLtvEaxZdnwGKBhFtJ/CIj83xxB5dkZTTvylRwq8TgeGHWKzWk8W3kHgxz0dI0PQOs0jeFuuv87O3IK9uovpix+yA2y71xJLI9RAXtDoF9n54NYEba1od8n5K7kaHxQFV7J6+PBI92VxOs2guyxGWa7pIUF5ur3TrNuwAMU9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043395; c=relaxed/simple;
	bh=/5QkW40DEDzN34JcZteyhI2f09fIznSld+T/Wb73gU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItLS/M/oKVfyWqSkMi2k3485gtEIS63Lq/2/X8G8O4mlPTixMSNR229mKlRkT82nCZWCRdbMExPVhKvOY75mLkzXd7oE0aKIfHkqNO4AWdyZ9pjzbaIbc8AFMEt05tnLjPEQGjqyQu/SV2fxfkGN2MdUv2A/1qZZ9JS45y6LOkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nFkmRT8/; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFkmRT8/"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8111c0c7561so32229507b3.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 12:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786043392; cv=none;
        d=google.com; s=arc-20260327;
        b=c/sgBN27so56Owy2TXByrRy6hMzlwjLaH5FZtScSvjk6OtTaRm+cDTrWVlnq28iHBq
         AwATCvlbOBJaZTS+2G5PFLYtY9Bj2BEtOfrpdlJVNTyAmwpFFIzDSi0tLKQkHQTOP6BX
         /5Iq0g5p5RHab48xQEKeiBK8iFYWtWpCPt9z1QJZB3C0ymc94CKjbMi1TLVcfPMe0mAE
         KOZYV13sAFflRyXd4o+cmbNbUDQd9jYim5HpxZjDKbtsXvEbQE9FEWZ+XP3wrH/ktAv7
         xB1p+onaJd3C/TtVZ5Ap+SJj8aGiBNtVlyk3rK8Wl9rir/bdZ4JF1aOWiVu9Y4oKkJbR
         FXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YFIhKLGVZGrhQZdcsa5EgdX2ngzhsHxALl87LpJmhsw=;
        fh=EzarLbYkmfX40GYulSvS5EZE73mRnFEJTW4851YD2g0=;
        b=PVqI9GyT4NEzvZ3C9X6PYvdmeDEx59HDpttboNC5ga2+hQLGzKOGm6GguMoFqSlYQd
         ONKLngJDwBs1RrOFncyY8Junq/Dxj5CvWC1pVybJdfEMTA3SgOCjHJULoU4xjiYV2epo
         0pz9tnVwAcPllUtd/dnKVuSPz81KPqurBeSvDini4EFCBP84796Itg0WiJAyGqdMzDED
         jspUXaEZG4suNtvf4sQqMJ/EGjHNdMvYbr7hRmEiv6/Ru32nZ4oXVvdE+0asLk9ZJsFa
         5YH/mimZL2WwjaGBtMjEi1ztUCmlhQskEOcXTtjx0N5aQC95pA2fiLOEBPW13aAhAzOw
         AnBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786043392; x=1786648192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YFIhKLGVZGrhQZdcsa5EgdX2ngzhsHxALl87LpJmhsw=;
        b=nFkmRT8/2NeSGUz8DFZs6kZiRZk8/ip+lpEKPglrNjvPEo28D0+OnDmu/HLZlpkeym
         PlhtGDrjpDCEHhDAMIko5hOe2FLXLhfrA67v6iqCoFHeZobbr83WSPMjnhNfXWZVzCAt
         vMsDmRXlpciCQMEOiH2SbaIIYXATDhffqraG/ZdGjidIPahehJ+ZIbCnkMplHA/ZnrGb
         wcXEHU6bapvgQq5/9WezGeC5ZO+j5c0k6jDHYK59pCVn6tho3T96W7ndOnSJavnBVO5R
         bzFRGSmMqvX5VpMpWM2P5zoP9zPnA6XG4pNVNDVY4Mc8JujpJtSb6CFKxek8U1lwuNeJ
         uzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786043392; x=1786648192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFIhKLGVZGrhQZdcsa5EgdX2ngzhsHxALl87LpJmhsw=;
        b=qkqsEjdZfx6I7gn4f7HCAUZjmhRbs/By4S96nPIBPMQR3n+Cdx77ny7E7Lo8HxR4Mz
         JrWhRRdZkqbPH6bbQTJ24Gb3zyfPYlpCSgZ+FLiUVNdoxlDokiOQ7zlP9LQNXjNob/iv
         anNYF8wo4z49jtnnq89xCZAkaMrxIZKk9BIddLdhCf8/0i5jO/XGR6De9YA2Yox/7CS2
         wBwhjMI5YMYrbPupukua6FuXE3UHFvsN1b3lcdl04rAoucouy0HGkmUQC8jaHX0JRUD0
         H5xsOO0WCWvkvrs4FvcBhDXxEyMcA190EE9jwP0/gWGIgNGpMF713SMsaw9g+LHHziVR
         zRfA==
X-Forwarded-Encrypted: i=1; AHgh+RqhNrHke5gc5AAQO9Z+lr3NLwI4nBnwixjYAOmFhMPAO2g6g/Ehc3VAaPqykg7GsSbnSFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr8tWvHog0Ip72SrqND6RY9NaZJl/SFb8ly0LabWM1MKL6VfmL
	PCQXUsP1ZOZclCfChZdce3U60g0PF7Q1hS5mTMWSbDEbSQ9jeiXGdx91TAAeZmaxEQBdgUiUGL6
	xyygheqsqSoj+vtxTRNls92xXQ0cE4IHuDVP2pjM5
X-Gm-Gg: AR+sD13r/ckF/LC7Wx10V9UtwFzk1eH4jO2/SXCAxkDZKHTLiejGWjFTTtu/msL0dIs
	KTjScVeIQMewZcegpQgZTL8J4yD0RFNjAeNGp+pJqxnXG9LM9sWlLxmZ9e/CUAw3BZuQNckh0YY
	IhO5w7o+CBuXhx8GtdCU902p+5GFq9X40I63AbLjp1Hd8rGbtm5HRcKIR7BBM/iB4sFNA1RQICq
	dkKlwXUBvmrQDP5fRg0ZTn6XqKfIteIAeDbS+ni/4UbbEjb5waX915lGUA1jK7sdWQoD/1cGgd6
	Vy/wYIT62Ygpv0UEgNV604u+7vqNXoTkraL+boQrIi0=
X-Received: by 2002:a05:690c:e3c9:b0:81f:3b6d:a0bb with SMTP id
 00721157ae682-8202276e445mr98989957b3.32.1786043391518; Thu, 06 Aug 2026
 12:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-bpf-lskel-fixes-2-v2-1-1ec545c6861c@google.com> <CAEf4BzbAjP_r7T_7dV4YMJTb0GnuVi0Ed_Oj7r8hia2xefv=ZQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbAjP_r7T_7dV4YMJTb0GnuVi0Ed_Oj7r8hia2xefv=ZQ@mail.gmail.com>
From: Sid Nayyar <sidnayyar@google.com>
Date: Thu, 6 Aug 2026 20:09:40 +0100
X-Gm-Features: AUfX_mwyHnCqmEedKGxIQ1LQR8gTzDwO3pyEg0HdONYwgfleXwlrLVtHx7CDAv4
Message-ID: <CA+OvW8aDu_-d3YCEtcJ5muGYhKMiRC2q6QQ5rG5r1x-64OKRZg@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: poison unresolved weak kfuncs in light skeletons
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Giuliano Procida <gprocida@google.com>, Matthias Maennich <maennich@google.com>, 
	Tiffany Yang <ynaffit@google.com>, Neill Kapron <nkapron@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 12:25=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jul 22, 2026 at 4:41=E2=80=AFAM Siddharth Nayyar <sidnayyar@googl=
e.com> wrote:
> > However, the generator fails to clear src_reg (which is set to
> > BPF_PSEUDO_KFUNC_CALL). This leaves the instruction looking like a vali=
d
> > pseudo kfunc call with a zero BTF ID. When the target verifier's
> > add_subprog_and_kfunc encounters this, it unconditionally scans all
> > BPF_PSEUDO_KFUNC_CALL instructions, sees imm =3D=3D 0, and panics or
>
> panics? as in can crash the kernel? overstatement or it's actually that b=
ad?

I meant the verifier rejects loading the BPF program, sorry if panic
was an overstatement.

> > fails the load (e.g. bpf_unspec#0 or -EINVAL). This entirely breaks
>
> also, I think we intentionally do not fail for kfunc with btf ID zero
> eagerly, so if subsequent dead code elimination logic proves this
> instruction is unreachable, it should be ignored anyways.
>
> can you please double check, this sounds suspicious. invalid helper vs
> invalid kfunc call shouldn't matter much (and if it does, we should
> fix *that*)

I investigated further and it seems like handling of unresolved weak
kfuncs in add_subprog_and_kfunc() works fine.

This change doesn't seem to add any functional benefit to BPF program
loading. Apologies for the noise.

Self-NACK

Regards,
Siddharth Nayyar

> > the verifier's dead-code elimination logic which expects to cleanly pru=
ne
> > branches protected by bpf_ksym_exists().
> >
> > Furthermore, when the generator processes subsequent references to the
> > same unresolved weak kfunc, it copies the imm and off fields from
> > the first occurrence but skips the src_reg field, meaning subsequent
> > calls also retain the poisonous BPF_PSEUDO_KFUNC_CALL flag.
> >
> > This patch fixes the issue by explicitly clearing src_reg for both the
> > initial occurrence and all subsequent occurrences of unresolved weak
> > kfuncs, converting them into standard invalid helper calls that the
> > verifier's dead-code eliminator can safely recognize and discard.
> >
> > Fixes: 18f4fccbf314 ("libbpf: Update gen_loader to emit BTF_KIND_FUNC r=
elocations")
> > Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> > Changes in v2:
> > - Rebased and added Fixes and Acked-by tags
> > - Link to v1: https://lore.kernel.org/r/20260622-bpf-lskel-fixes-2-v1-1=
-004d72cba5c2@google.com
> > ---
> >  tools/lib/bpf/gen_loader.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> > index d79695f01c87..a08071114347 100644
> > --- a/tools/lib/bpf/gen_loader.c
> > +++ b/tools/lib/bpf/gen_loader.c
> > @@ -783,10 +783,17 @@ static void emit_relo_kfunc_btf(struct bpf_gen *g=
en, struct ksym_relo_desc *relo
> >                 return;
> >         /* try to copy from existing bpf_insn */
> >         if (kdesc->ref > 1) {
> > -               move_blob2blob(gen, insn + offsetof(struct bpf_insn, im=
m), 4,
> > -                              kdesc->insn + offsetof(struct bpf_insn, =
imm));
> >                 move_blob2blob(gen, insn + offsetof(struct bpf_insn, of=
f), 2,
> >                                kdesc->insn + offsetof(struct bpf_insn, =
off));
> > +               move_blob2blob(gen, insn + offsetof(struct bpf_insn, im=
m), 4,
> > +                              kdesc->insn + offsetof(struct bpf_insn, =
imm));
> > +               /*
> > +                * jump over src_reg adjustment if imm (btf_id) is not =
0, reuse BPF_REG_0 from
> > +                * move_blob2blob. If btf_id is zero, clear BPF_PSEUDO_=
KFUNC_CALL flag in src_reg
> > +                * of call insn.
> > +                */
> > +               emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1));
> > +               emit(gen, BPF_ST_MEM(BPF_B, BPF_REG_8, 1, 0));
> >                 goto log;
> >         }
> >         /* remember insn offset, so we can copy BTF ID and FD later */
> > @@ -804,10 +811,12 @@ static void emit_relo_kfunc_btf(struct bpf_gen *g=
en, struct ksym_relo_desc *relo
> >         }
> >         kdesc->off =3D btf_fd_idx;
> >         /* jump to success case */
> > -       emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 3));
> > +       emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 4));
> >         /* set value for imm, off as 0 */
> >         emit(gen, BPF_ST_MEM(BPF_W, BPF_REG_8, offsetof(struct bpf_insn=
, imm), 0));
> >         emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn=
, off), 0));
> > +       /* clear src_reg (and dst_reg) to convert pseudo kfunc call int=
o invalid helper call */
> > +       emit(gen, BPF_ST_MEM(BPF_B, BPF_REG_8, 1, 0));
> >         /* skip success case for ret < 0 */
> >         emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 10));
> >         /* store btf_id into insn[insn_idx].imm */
> >
> > ---
> > base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
> > change-id: 20260622-bpf-lskel-fixes-2-758036ae9911
> >
> > Best regards,
> > --
> > Siddharth Nayyar <sidnayyar@google.com>
> >
