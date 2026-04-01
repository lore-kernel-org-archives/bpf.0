Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA33E8681
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058433; cv=pass; b=NymqDIiJ8z8oJnBccBS6OXkYhvkz5ysWYkB/EOQc4xNAqbLaloA7rLQBjRvJmN8QMeq4fWdP0KlmbILanbBUc3vZ3MIrb0mwUI7mWGsyWkacQZqMrOl6SqAHOaDk67Ldmk8ngqetVTA5y2MVlZc/nuDXL16L8JoCRIu1KvB/fRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058433; c=relaxed/simple;
	bh=kqmXSX+K8QiS0uFznIAuUKyr5yrcD+aRgIZDNDTDpvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzaYHE1iJ7uR6CoY4xRPvoQVv2pi72kyRaVeR98YzdXXl8aNCrQEZ2auXqQtaV40+9ZU4kpKbxC/O7TyAV26+in1IdV7f/X0wr6kYIJ1qOZnTjcLKPeaG+nkfNNeEY8Z2/cMoOOqlyQQTVo+21727P2E0pD57AQAKy3YwRvU3Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh/CSPu0; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh/CSPu0"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfd832155so2236217f8f.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 08:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775058431; cv=none;
        d=google.com; s=arc-20240605;
        b=I6+eZMbAJnV+lPJ29+nHbq7Llfi2W+4Zc/NUiLUGMq8rpT1WD7RuQ5GJFj8dyUJHgG
         IeuRhyBjrbneeX/wp+SFRYdX7BGz80yDkwnVb3wd+pC2H5qo4064Fj+KDAZBcUCvSCfj
         MUSRZWMVx0nciZUii4WFjACx6ZJ03HXapBAIHom4Jbj6K87Oy5smmQypVpNtny2HKGir
         O/UR0820RPNx98kfjjVt+Hl6x/28NW9Zth4EVuwuAQfCYU0c6+OGIelt+wIllOZNMeme
         U0JUngywuOSuMhdUTN/y5dqDcGdof9bt9wN8GFx7rwQE9RfUcUfytrYIiY8yoDTSG9ED
         F3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zbBjrCg1hYp0fWF5YB/VWHS94qWsovJ0uNFuEWjVoXE=;
        fh=ZjZnlGJ4j6GsPbdN9KU7cNTEhuDuKixuJSySPsKlUQw=;
        b=MvDPQ0D9GeAyvVX2UJwcCCfy9tnDHLhYVnviIQVat0KlgeK7xhuZTicKA4HtpEtxTR
         a1eZKXOwPNt873efKUP5EPkNPg1rj3vnlCKB5wrj1skuIgzALEVsQletFte0KykbJY4G
         OxrV0hxI2hSdZIIZo7k/dyyjfaPI1hL7Bkgw0pCKYmaTV1lSnJYiHbkita7i7oS2YcL3
         SP2yf5euBznAx9Y/Pg6W02xlwmWA67cAkpMQxSedhmApE1QU/TRRg/PSqCQBHxXRqc2N
         9u6ZH/WSx4BdSq+n97d9MHrmDjWOXtgajge8/R5SyB0KQfguRcFQNBGyLv4kKnxpZqX+
         l92Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775058431; x=1775663231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbBjrCg1hYp0fWF5YB/VWHS94qWsovJ0uNFuEWjVoXE=;
        b=Gh/CSPu0VP0Jzv/GGbTOk9IzYOzs4Sk8y7lJwjX67+/LvT6Y0SuiOeDUK5cns98Z3V
         jLqqJKU/Cq/YGbpUMqcyM8k0y4O6VZmv++sESbOxoLEEA4DVzCrCsSr02+swpan82V36
         surlwBroBvFjyvZGQlnLeqeaODivJ8Cvr102xmoqYCOUlf0pjaaakwe3y7cBSUVtS8sT
         l+9+9NKhW+wqCx/izLPIvhgJf3ytBgX5fiQ3b6gp2Y67eqHPJJi5UCwRoCcnrPbwnAiY
         W1xF1duWus7LM4TH8fYcAK2/Plr2xwPNc+k3xJhnebsAFpkqae9+JmDg3uZMhdgGWgcK
         Ntag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775058431; x=1775663231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zbBjrCg1hYp0fWF5YB/VWHS94qWsovJ0uNFuEWjVoXE=;
        b=lfVpCR5oadBMsCFgFcyOvrQQx1aZ2wVVs/9D+njakX8bwcepBRHEYozGVTBExTKXh2
         1WW+ESwQ/xUzkB5rSBjPxrXoCkfpHRzgMZmk9amtHU3qzc/wiKwlfykal9btLCcZZtGd
         6eKM1pS4ygZhoCRn9OstTc3zPljXJmJk8kUx6OR/LHfQUJarsPhjLEx35U8gXkwSXrXs
         l6a96Xcdqc3JuiavfsNUXphvJbH/a1W4qiMAHY6hftqnOoufj3i5NXdFMod3pR98uMdn
         HoSWLm2rGGkkJ2Qo0vqMtaa8OWY+Aju6KAZqW7l/jVFBObFulQoSth8VtzF2by8P4gDZ
         Hygg==
X-Gm-Message-State: AOJu0Yx1Zur3WxDfsVxI9OfAHQuX2KGErshdNfeRC2WS+pxMKxTWIojU
	hczWfKZTAadll2j8UB7NiEEQ2y/2DYNfqwZj5Ulg5nIqwQiYYstbqUSAbDl273dYMw1DnI+lhzL
	tgL3AqEXiSyZJJOjoMGHjnxQmZJeSq9g=
X-Gm-Gg: ATEYQzxo7ZnuVhpvZQZA674HdXcIpPA6wFMgTPAxLGC4i1oy5fx2vamoL1tyU7ITPKv
	+/18WMQEI7ISik/isHLALhnhdV3gHGbweXXto1VVtU2c5HWddgiepvLRFcwFtBj5VkZH+yP5Rvr
	FHGU3RW8GXlaI6OaCB2cjwIanRRAjSPVC5/Usypq41gujjbZJCd09vIRwdq4S7uP9C8IblUBBoP
	xsQveRRDb1HyOvDwVQAKmN0jMvOtmU7bNmAAij6QJ3WxbXkoX6HAMnVW47Fe+YmJGelGQRF402/
	VAGnzKzHO4ZrBACtEgbpeDMBbERcS00eXl6rt8HSC1BfjdxqzNjy8aC/Ix5D2yDmxGNRbC3tZ5H
	K+8hgNdtq5sOT8uAQbKMzoy/mxQ==
X-Received: by 2002:a05:6000:40dd:b0:43c:fdd:ea96 with SMTP id
 ffacd0b85a97d-43d150b7718mr8145014f8f.26.1775058430644; Wed, 01 Apr 2026
 08:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401021635.34636-5-alexei.starovoitov@gmail.com> <2db51a83b7dcd83a4d5d0d23c5c01807a7ab4b07888976731aa0ba404a2d68ff@mail.kernel.org>
In-Reply-To: <2db51a83b7dcd83a4d5d0d23c5c01807a7ab4b07888976731aa0ba404a2d68ff@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Apr 2026 08:46:59 -0700
X-Gm-Features: AQROBzDVZTvWMwtMGKU__gCBiormUA6Zuto37lCD3EgTQZzXMWyewxTgm_VnCOE
Message-ID: <CAADnVQK7zAyOLUbOCauiX-C5gvuU7NWT4kb++RvdTLF5En98tg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Add compute_const_regs() and
 prune_dead_branches() passes
To: bot+bpf-ci@kernel.org
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 8:49=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> > new file mode 100644
> > index 000000000000..9e5abc6ab46a
> > --- /dev/null
> > +++ b/kernel/bpf/const_fold.c
>
> [ ... ]
>
> > +     /* Save computed constants into insn_aux[] if they fit into 32-bi=
t */
> > +     for (i =3D 0; i < insn_cnt; i++) {
> > +             u16 mask =3D 0, map_mask =3D 0, subprog_mask =3D 0;
> > +             struct bpf_insn_aux_data *aux =3D &insn_aux[i];
> > +             struct const_arg_info *ci =3D ci_in[i];
> > +
> > +             for (r =3D BPF_REG_0; r < MAX_BPF_REG; r++) {
>
> The loop iterates r from 0 to MAX_BPF_REG - 1 (=3D 10), but
> const_reg_vals[] in bpf_insn_aux_data is declared with 10 elements
> (indices 0-9).  When r =3D=3D 10 and the register happens to be tracked
> as a constant, this writes past the end of const_reg_vals[]:
>
> > +                     switch (c->state) {
> > +                     case CONST_ARG_CONST: {
> > +                             u64 val =3D c->val;
> > +
> > +                             if (val !=3D (u32)val)
> > +                                     break;
> > +                             mask |=3D BIT(r);
> > +                             aux->const_reg_vals[r] =3D val;
>
> Would this overflow const_reg_vals[] when r is BPF_REG_10?
> The array has 10 entries but the loop goes up to 10 inclusive.

Good point.
Changed it as:
-               for (r =3D BPF_REG_0; r < MAX_BPF_REG; r++) {
+               for (r =3D BPF_REG_0; r < sizeof(aux->const_reg_vals); r++)=
 {

> Since compute_const_regs() runs before the main verifier pass,
> register numbers in instructions haven't been validated yet.  A
> crafted program with dst_reg =3D BPF_REG_FP in an ALU instruction
> would cause the analysis to track R10 as a constant, then
> write one element past the array into the next instruction's
> bpf_insn_aux_data.
>
> Similarly, in const_reg_xfer():
>
> > +     struct const_arg_info *dst =3D &ci_out[insn->dst_reg];
> > +     struct const_arg_info *src =3D &ci_out[insn->src_reg];
>
> ci_out is a stack-local array of MAX_BPF_REG (11) elements, but
> dst_reg/src_reg are 4-bit fields that can hold values 0-15.
> Could instructions with register values above 10 cause an
> out-of-bounds access on the stack before the verifier rejects them?

nope. because earlier pass validated reg range.

> [ ... ]
>
> > +int prune_dead_branches(struct bpf_verifier_env *env)
> > +{
>
> [ ... ]
>
> > +             if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> > +                     src_val =3D (u32)insn->imm;
>
> For 64-bit JMP instructions (BPF_JMP class) with BPF_K source, the
> BPF interpreter sign-extends the 32-bit immediate to 64 bits:
>
> kernel/bpf/core.c, COND_JMP macro:
>     JMP_##OPCODE##_K:
>         if ((SIGN##64) DST CMP_OP (SIGN##64) IMM) {
>
> where IMM is insn->imm (s32), so (u64) IMM and (s64) IMM both
> sign-extend.
>
> Here the cast (u32)insn->imm zero-extends instead.  For negative
> immediates these produce different 64-bit values.  For example,
> with imm =3D -1:
>
>     (u32)(-1) =3D 0x00000000FFFFFFFF  (what prune_dead_branches uses)
>     (s64)(s32)(-1) =3D 0xFFFFFFFFFFFFFFFF  (what the interpreter uses)
>
> A concrete case: r1 =3D 0, then "if r1 s> -1 goto target":
>
>     interpreter: (s64)0 > (s64)(-1) =3D true, branch taken
>     prune_dead_branches: (s64)0 > (s64)0xFFFFFFFF =3D false, not taken
>
> The branch would be incorrectly rewritten to fall-through, and the
> jump target becomes dead code.  This also affects unsigned comparisons
> when both operands happen to match at 32 bits -- for instance
> JGE with dst_val =3D 0xFFFFFFFF and imm =3D -1:
>
>     interpreter: 0xFFFFFFFF >=3D 0xFFFFFFFFFFFFFFFF =3D false
>     prune: 0xFFFFFFFF >=3D 0xFFFFFFFF =3D true
>
> Should this be sign-extended to match the interpreter, something like
> src_val =3D insn->imm (relying on the implicit s32 to u64 conversion)?
> The JMP32 path already handles this correctly via the subsequent
> (s32) cast.

Agree. Fixed like this:
-                       src_val =3D (u32)insn->imm;
+                       src_val =3D insn->imm;

> > +             } else {
> > +                     if (!(aux->const_reg_mask & BIT(insn->src_reg)))
> > +                             continue;
> > +                     src_val =3D aux->const_reg_vals[insn->src_reg];

Note that this part is fine, since we did:
                                if (val !=3D (u32)val)
                                        break;
                                mask |=3D BIT(r);
                                aux->const_reg_vals[r] =3D val;
