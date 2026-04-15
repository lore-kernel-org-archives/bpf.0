Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7D2882DE
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776219966; cv=pass; b=VUjPO4ICC24ivplU5+CjVcx4RBm6slz2tocv2v2z8kpg5hoSJPlMtwQi3G5IbfTSPpjorfTLowJJEhxiYwoece3dyNJAkP0sGnf8hXMDoMz7sqxORbDeex65m/AVzghjFRd7X/zEoo/aahmrjsdNY27YdSvUSPQecHnYAqRErtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776219966; c=relaxed/simple;
	bh=MRxcm7Tt46pg3Kzyyf0G+uZbnfC1nYlRE224oNDetjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kadoj6q4aNig5qJE9AJ3UJwuJAYvyQSF5RRCX1K9apFIfBmz+jkV9kyMItQUTBkgo9NkTUlKkwDOGvuR77CSCmElLTG8nRjdRuX1lrCFrHWamqwjFfbq5Yz3c7/E/aS0MiY0+5Vbfa453fXlaPE5uvBxlJBlJl2EHaCOsXBEJTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIScvV3X; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIScvV3X"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-685013eb590so3931675eaf.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776219963; cv=none;
        d=google.com; s=arc-20240605;
        b=YZAQRt11yJkLlyOiWlvgTypnJlaI9enI/qCPtU0yp6jG0ZAYIibFSUoMAzwc4wYVhJ
         LNVnyIN3n3YmWZDcILYP3bvFfXg21IMsLc36hjZjL4kItA0ZhAQ2eQDwNFZpqYSRLn+P
         O/OJA1B6wE9jv5mlEutEE9P+bUUdAfqYNdUm1zs7hudnmt7DXbyuVdhKINCdrnKwT0Ld
         jniskkrKWD5AC+bbQEZvos1dTYNtL7UN034ci6ElyPxXzEW4c/P8mGsNdBNDSCxrpc2g
         jKKtqQEOfwc7CPV5+bGZg+h7mlsDMk9NxG4jhh1Qd/TGugbcfvrXqbeG8bpfKLYJ+/fc
         HhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gp8opaCO4NhzR0MzPaxnczut02ydEKc5TESqHBl8R9A=;
        fh=e7PVUNfQpoExfKUv3/5b5VT/14M1xs4qhzOmYAyfjbk=;
        b=dLrKsL09KSEc3XTeh5j9dSR43u+/CtXymk0OwNGJCBPoqw9wecqNUqrdwuV2FJNWI3
         94zRklij3pyxEkWucYs0sYM7v8mXkVxmHWuyHM3yVjTwo/Q28UshzOzkBgCViyA4a5si
         s1y5Ug+PYB2cEBhzxWzcmiTVekt0dE7sixn5Jpmw/RpZd2jEJrhqrvLHiGuhmDoxpynr
         IXBBmiuHPt3QDJJH+2ovJytniIcFLXHbVEoAfYq+/DggTpFGDmPoX9vZBvtAoOllLEXt
         pjFY27jyBKfDvN3wHi6TuXe2ekA3OE3foT9zUv5OOvrwdiJqgk1fI0ls0ABlZ1bK6FyS
         uQHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776219963; x=1776824763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gp8opaCO4NhzR0MzPaxnczut02ydEKc5TESqHBl8R9A=;
        b=jIScvV3X+DvoRN+vwAoa+FYu9MMYHNIraxziBNJhoQ221vjrC0+raCx0RTFnOCdP56
         /rrBEkPF10A3gYXzNYxitfcrpGudAae+yBQTk/YRGcfkL8ujAqNGWf81ysc5TmSLfmZB
         xXVM0zFdXl7QHC1U+ESBcceBrCpsgggyvIiHPwAyaSbATmeLzp8gF+5ryhj5MnRYyBPN
         FPTPKiO88s0o3vS5b2LzbuoR9OtMRKe682u2jCryAT7Zhi6MV2ghA1Fsaq1JYCzIkqQr
         S94d5zkHW9uylnSVqw1PoNo5ofwrEyV370HrZbiC5+mo1WwPeE80dOG74t9FqqAc5HjM
         naZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776219963; x=1776824763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gp8opaCO4NhzR0MzPaxnczut02ydEKc5TESqHBl8R9A=;
        b=ecSSrFSds/iBP6rxgxKVBVTrbUKKb1fQlcft8iHF340azy/VzCsbYmQRlKe8Z265PL
         M+CJpE9sUN0EbgekkR9gp3zL+/oi53M9qqq0LfG2TCFkXeWpKHWI+N9x27rR+do8Gf3K
         Fti6HQOrzH39RPXprnbRyCl1536VblTDsV8TsO/R/tSiitZJirt7G/Q1KmEp7m71utQk
         UB3Zl3wnP9Hk9mtBfMqg2TiBbXn7hMFTAwi8wtmQBf4L3oTQj7Yk+QWLEu9+FWexjgWp
         HRDKU1qJn8c2AWUKkN4b5KdOmPzMr6EytV4NVfQa82tde0p78GL+NqIiSmJtfx8NVZAF
         vlzg==
X-Forwarded-Encrypted: i=1; AFNElJ/P9TJDQZ4FfTFRMcYT6oSUg2QXx5+M+iL1lr6WaGxeP8dxaccTcmnxXn24ODpxDDz7qtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPZYZYltDh/g9KN9zTUXm7DHdkw3S2RKvv7xPKML+YBo/x4exO
	oUpPo1otnaoHpt7HoQ9DpS4kCDAUlNnmUzmCME+C7z3t3oUKdlUo8/giurvvyQZse/LBbgg32WW
	d/pIwDnxFkVmLJamBd9K/rhD679lu+Bs=
X-Gm-Gg: AeBDievcmXerddEuekApfGirM35YL7z0UtblzlFTSIO9qapL9ggWju+AGS2YfbTVNRg
	0Vv2BzkKZiU/7gP8ptE8ebH9RccxZYvPaLpmlGUvZojcog9eHOG/BccAB2KNtnH3OtjUNxSWlCU
	1GFsLXWatb/PQGvOPF7P6rg1xJoMsRwVb1rZPdEjVOiA0g5bs6BRE9SyV0nCYBzh/eWC20/glbh
	T2c57U1Dq3vKiT5spuU9iC16tpBhpCcDMJZV8nFK4NMgglvCkJ5UqyFBJpRL16Iywl3kJ+U8gBJ
	byLdUxGAAXKBmDFpwQ==
X-Received: by 2002:a05:6820:4a19:b0:68d:bb0e:9c97 with SMTP id
 006d021491bc7-68dbb0eababmr6173327eaf.7.1776219962919; Tue, 14 Apr 2026
 19:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413040506.26640-1-yangtiezhu@loongson.cn> <20260413040506.26640-5-yangtiezhu@loongson.cn>
In-Reply-To: <20260413040506.26640-5-yangtiezhu@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 15 Apr 2026 10:25:50 +0800
X-Gm-Features: AQROBzAYMUwwbM_D7VxSXaSrDZ-TdfqCtp088Lx3Nk63PjxURNHrlxO41NLFNU4
Message-ID: <CAEyhmHShzVtNg-ct0PGXGfMuF_4i7-BG-bfXvPrwS1wbCcKmZw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] LoongArch: BPF: Support load-acquire and
 store-release instructions
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 12:05=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> Use the LoongArch common memory access instructions with the barrier dbar
> to support the BPF load-acquire and store-release instructions.
>
> With this patch, the following testcases passed on LoongArch if the macro
> CAN_USE_LOAD_ACQ_STORE_REL is usable in bpf selftests:
>
>   sudo ./test_progs -t verifier_load_acquire
>   sudo ./test_progs -t verifier_store_release
>   sudo ./test_progs -t verifier_precision/bpf_load_acquire
>   sudo ./test_progs -t verifier_precision/bpf_store_release
>   sudo ./test_progs -t compute_live_registers/atomic_load_acq_store_rel
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 98 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index c9a32f124f5e..805f95cbe798 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -344,6 +344,99 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, i=
nt insn)
>  #undef jmp_offset
>  }
>
> +static int emit_atomic_ld_st(const struct bpf_insn *insn, struct jit_ctx=
 *ctx)
> +{
> +       const u8 t1 =3D LOONGARCH_GPR_T1;
> +       const u8 src =3D regmap[insn->src_reg];
> +       const u8 dst =3D regmap[insn->dst_reg];
> +       const s16 off =3D insn->off;
> +       const s32 imm =3D insn->imm;
> +
> +       switch (imm) {
> +       /* dst_reg =3D load_acquire(src_reg + off16) */
> +       case BPF_LOAD_ACQ:
> +               switch (BPF_SIZE(insn->code)) {
> +               case BPF_B:
> +                       if (is_signed_imm12(off)) {
> +                               emit_insn(ctx, ldbu, dst, src, off);
> +                       } else {
> +                               move_imm(ctx, t1, off, false);
> +                               emit_insn(ctx, ldxbu, dst, src, t1);
> +                       }
> +                       break;
> +               case BPF_H:
> +                       if (is_signed_imm12(off)) {
> +                               emit_insn(ctx, ldhu, dst, src, off);
> +                       } else {
> +                               move_imm(ctx, t1, off, false);
> +                               emit_insn(ctx, ldxhu, dst, src, t1);
> +                       }
> +                       break;
> +               case BPF_W:
> +                       if (is_signed_imm12(off)) {
> +                               emit_insn(ctx, ldwu, dst, src, off);
> +                       } else {
> +                               move_imm(ctx, t1, off, false);
> +                               emit_insn(ctx, ldxwu, dst, src, t1);
> +                       }
> +                       break;
> +               case BPF_DW:
> +                       if (is_signed_imm12(off)) {
> +                               emit_insn(ctx, ldd, dst, src, off);

See commit fe5757553bf9ebe45ae8ecab5922f6937c8d8dfc, need double check here=
.

> +                       } else {
> +                               move_imm(ctx, t1, off, false);
> +                               emit_insn(ctx, ldxd, dst, src, t1);
> +                       }
> +                       break;
> +               }
> +               emit_insn(ctx, dbar, 0b10100);
> +               break;
> +       /* store_release(dst_reg + off16, src_reg) */
> +       case BPF_STORE_REL:
> +               emit_insn(ctx, dbar, 0b10010);
> +               switch (BPF_SIZE(insn->code)) {
> +               case BPF_B:
> +                       if (is_signed_imm12(off)) {
> +                               emit_insn(ctx, stb, src, dst, off);
> +                       } else {
> +                               move_imm(ctx, t1, off, false);
> +                               emit_insn(ctx, stxb, src, dst, t1);
> +                       }
> +                       break;
> +               case BPF_H:
> +                       if (is_signed_imm12(off)) {
> +                               emit_insn(ctx, sth, src, dst, off);
> +                       } else {
> +                               move_imm(ctx, t1, off, false);
> +                               emit_insn(ctx, stxh, src, dst, t1);
> +                       }
> +                       break;
> +               case BPF_W:
> +                       if (is_signed_imm12(off)) {
> +                               emit_insn(ctx, stw, src, dst, off);
> +                       } else {
> +                               move_imm(ctx, t1, off, false);
> +                               emit_insn(ctx, stxw, src, dst, t1);
> +                       }
> +                       break;
> +               case BPF_DW:
> +                       if (is_signed_imm12(off)) {
> +                               emit_insn(ctx, std, src, dst, off);
> +                       } else {
> +                               move_imm(ctx, t1, off, false);
> +                               emit_insn(ctx, stxd, src, dst, t1);
> +                       }
> +                       break;
> +               }
> +               break;
> +       default:
> +               pr_err_once("bpf-jit: invalid atomic load/store opcode %0=
2x\n", imm);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *=
ctx)
>  {
>         const u8 t1 =3D LOONGARCH_GPR_T1;
> @@ -1326,7 +1419,10 @@ static int build_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx, bool ext
>         case BPF_STX | BPF_ATOMIC | BPF_H:
>         case BPF_STX | BPF_ATOMIC | BPF_W:
>         case BPF_STX | BPF_ATOMIC | BPF_DW:
> -               ret =3D emit_atomic_rmw(insn, ctx);
> +               if (bpf_atomic_is_load_store(insn))
> +                       ret =3D emit_atomic_ld_st(insn, ctx);
> +               else
> +                       ret =3D emit_atomic_rmw(insn, ctx);
>                 if (ret)
>                         return ret;
>                 break;
> --
> 2.42.0
>
