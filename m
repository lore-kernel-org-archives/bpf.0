Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655221D5CE0
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 03:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775965998; cv=none; b=Kr2JHSzYXtTSZgpLs9je2as6Ia+287Ar2WgRtDXubVhWQhGYG0F6k2VK6tiISAFy997iyqaImJu+5ktoeT+h3EsNe0bKe5OV/E20QXzbfSQGh3yQ6Jv//jBccmPykcBGb6eiAK+QbPIpydeeETIqV03Bina6aTLfxwAssJogBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775965998; c=relaxed/simple;
	bh=Lu/oDFkatQ9quS801rXI3qRhnOm4VKKPcBwuO3QoAts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/cWuzR3DjxOTcQZBUaIEtaJeUShc15gvI/FYd5J5DFYxq/iriHngguyM3vz4mTE0AkJ2uAoE3SxIcRwQbiLTqe6r10fzwM9Xgt1vmLe34KNABlyzclMwXU2KGo0NqIMa+/AWOzrM/+fyeyPLdzvs7SxVAXCoX4YT6DZH+izUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [209.85.210.51])
	by gateway (Coremail) with SMTP id _____8BxD6oiF9tpLmkkAA--.41543S3;
	Sun, 12 Apr 2026 11:53:07 +0800 (CST)
Received: from mail-ot1-f51.google.com (unknown [209.85.210.51])
	by front1 (Coremail) with SMTP id qMiowJCxecEfF9tpWVZrAA--.44359S2;
	Sun, 12 Apr 2026 11:53:05 +0800 (CST)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dbff3ea81fso1608137a34.1
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 20:53:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwS9GWr0WDuJ87MEwZMS3mR7pYECLiM5PVwLNExq1B5ee7bZOy1O0gyt9blA/qkDvYl3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlaOsxTgrJLHpxxK3rtExqcZymuWszhSU2ZcaDImNlh78UjvRu
	91UujdX7iWsDAMOGceHs6sdziTG49Upc7LMqU4ZOwJZ2DLiHGvdQ0WmCik4ggJ3gb07L9XSDh/0
	ee1qG3hVv1qpnXFipQFWGxdOHt8A6iN7wBlMY758Qrw==
X-Received: by 2002:a53:d018:0:b0:651:b73b:251a with SMTP id
 956f58d0204a3-651b73b3411mr2397588d50.0.1775965599212; Sat, 11 Apr 2026
 20:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407062306.8915-1-yangtiezhu@loongson.cn> <20260407062306.8915-5-yangtiezhu@loongson.cn>
In-Reply-To: <20260407062306.8915-5-yangtiezhu@loongson.cn>
From: WANG Rui <wangrui@loongson.cn>
Date: Sun, 12 Apr 2026 11:46:27 +0800
X-Gmail-Original-Message-ID: <CAHirt9jnveJCgCt2TsuyQrJV0tCB+FJStgP6OaCiH8eJWLfpvw@mail.gmail.com>
X-Gm-Features: AQROBzD5i-4b6QMIxNy530j08dclbLPpFeIac85R-xUvjzsf53IoZemseVKWL6k
Message-ID: <CAHirt9jnveJCgCt2TsuyQrJV0tCB+FJStgP6OaCiH8eJWLfpvw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] LoongArch: BPF: Support load-acquire and
 store-release instructions
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:qMiowJCxecEfF9tpWVZrAA--.44359S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAryUWFW7Zw4DZr48XF1kZwc_yoW5tFW8pw
	srCFs5CrW8AasxWF9xJF4UWr4FkFsagr13WF12yrZ3GrsxX34UCr18KFnIvFZ5G3ykXFs3
	XFn0vw1293WUGrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==

On Tue, Apr 7, 2026 at 2:23=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
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
>  arch/loongarch/net/bpf_jit.c | 101 ++++++++++++++++++++++++++++++++++-
>  arch/loongarch/net/bpf_jit.h |  12 +++++
>  2 files changed, 112 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index c9a32f124f5e..f18a2858123f 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -344,6 +344,102 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, =
int insn)
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
> +                               emit_insn(ctx, ldb, dst, src, off);
> +                       } else {
> +                               move_imm(ctx, t1, off, false);
> +                               emit_insn(ctx, ldxb, dst, src, t1);
> +                       }
> +                       emit_zext_8(ctx, dst);

Could we use ld[x].{bu,hu,wu} here to simplify this?

> +                       break;
> +               case BPF_H:
> +                       if (is_signed_imm12(off)) {
> +                               emit_insn(ctx, ldh, dst, src, off);
> +                       } else {
> +                               move_imm(ctx, t1, off, false);
> +                               emit_insn(ctx, ldxh, dst, src, t1);
> +                       }
> +                       emit_zext_16(ctx, dst);
> +                       break;
> +               case BPF_W:
> +                       if (is_signed_imm12(off)) {
> +                               emit_insn(ctx, ldw, dst, src, off);
> +                       } else {
> +                               move_imm(ctx, t1, off, false);
> +                               emit_insn(ctx, ldxw, dst, src, t1);
> +                       }
> +                       emit_zext_32(ctx, dst, true);
> +                       break;
> +               case BPF_DW:
> +                       if (is_signed_imm12(off)) {
> +                               emit_insn(ctx, ldd, dst, src, off);
> +                       } else {
> +                               move_imm(ctx, t1, off, false);
> +                               emit_insn(ctx, ldxd, dst, src, t1);
> +                       }
> +                       break;
> +               }
> +               emit_insn(ctx, dbar, 0b10100);
> +               break;
> [ ... ]
> diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
> index a8e29be35fa8..9150de94ac60 100644
> --- a/arch/loongarch/net/bpf_jit.h
> +++ b/arch/loongarch/net/bpf_jit.h
> @@ -72,6 +72,18 @@ static inline int epilogue_offset(const struct jit_ctx=
 *ctx)
>         return (to - from);
>  }
>
> +/* Zero-extend 8 bits into 64 bits */
> +static inline void emit_zext_8(struct jit_ctx *ctx, enum loongarch_gpr r=
eg)
> +{
> +       emit_insn(ctx, bstrinsd, reg, LOONGARCH_GPR_ZERO, 63, 8);
> +}
> +
> +/* Zero-extend 16 bits into 64 bits */
> +static inline void emit_zext_16(struct jit_ctx *ctx, enum loongarch_gpr =
reg)
> +{
> +       emit_insn(ctx, bstrinsd, reg, LOONGARCH_GPR_ZERO, 63, 16);
> +}
> +
>  /* Zero-extend 32 bits into 64 bits */
>  static inline void emit_zext_32(struct jit_ctx *ctx, enum loongarch_gpr =
reg, bool is32)
>  {
> --
> 2.42.0
>
>

