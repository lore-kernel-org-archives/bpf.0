Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793064996;
	b=HaW275larZ7ysjcbXbOxcr2Itm2c66OyDLyHLcQO8nqZObUIRNjjCDRQMApJ/bPnmv5W
	 SfnECSOzjnt3bWIdzDDrC9rrpGiQq+Xfea/vkPxen0vYZAPQ85SCvH4CkQGATHmvAO3ey
	 MaOB1ti+oq5tpL8aLDGv/O8q3NgseVvylIZ3bdpAN0cdJgjAi2EV3xFCXirs7Sz8DtDIf
	 TcrdEpoAqU1C3Y9vMm3AflHIk3yXHROPj1Skb2kTAYtVf4PncOiDTwC8xM83GMkemNFyN
	 0EzPg4d6ytCE1FmHrIptD3TBNtYKXJ4FgNQ+R6w8AU7Yu6mRxRrzvbRy2Boa2cda6vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793064996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uJ7o4z3LZNIgv4lmDPckfI0AYkLgwXR/dko+SDg6wpc=;
	b=hwsrihmcCwDj/6n4HyIOVzX5O1OtomBDFa5OkI0D5SAVVKuZAtdumPKaY5ehqPsa6GYE
	 bpYiz3PXzSI+F+CZpUk+DhBwrVuYfbhHv+c94hHF4LYoTGRP7zV0OPGoIw6SPXa0HQUqc
	 QRbu8dkTgsnRFKKVL+w4YmdMJq7Yg/0wKSDTIW6F///VFaJczQUy1tb0s92YiOeDHRch8
	 qcyPwkprMrrg8VZD8r4/WNELgtOoUcTZbnSte+aLR0S+v95Jp1Qhe9MR1D+Lwmxxbn9Sl
	 T3A+sylNs8selgR8VqFq2xO2zJGLEeN8+8JnnqWk6JxhLPYZlz0DSv+0IEJEBRhRlOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TCHi4pYx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46622606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 01:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46622606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TCHi4pYx
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-48ed0b68895so1896270fac.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 18:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793064995; cv=none;
        d=google.com; s=arc-20260327;
        b=X0WhZPEKyrAbjlV5Y3vW/J4MK7DmhDsLxYMRy8niRvBNXn0m1kuViJAGfupu3k/QFK
         xzDL5aBh98071FQ1RR0Hro5tsK8J9o355wAr04glHvCZqWjw2xmh8wIGkDVKc87YocU7
         JuNJBuwhHkN716uq69JIMS6G1zWbOCgpoRkbGzJEcpxwJXkWSJKKdbaTJjuy/6ZSZReG
         wqwIxOPyMppTXaRMqAexio8qHbJinVXt5JgU1YEVm8eAI5fYSxQ4wMsRsN/kB8j6d5DD
         l13IV/oyzkCm4+ppSDnA0yuMfYrHF58bQBIqS2zildjhU5KZURrK018adj+61atFlYqg
         OQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uJ7o4z3LZNIgv4lmDPckfI0AYkLgwXR/dko+SDg6wpc=;
        fh=WeH16tyoDWdrRpA8T15eNpbcZm4zndzDlE2GgHHrkGI=;
        b=hgeqlDWgfpxPDo+8yfZYtZZl5yFQPssGyawcHhYQ/AZjXr3w8ubOmtb3Hv0z5N+tS3
         P74HNfTquvt3Kplwq8Cl85C+XKY7yATen2KF7m1DucskyT5GPa7rZ/j+sqPRgZz4Uz0A
         +9utjnv1zeQm3il9bdh+NJ/2y+ljWfQG0JH1W+bX899xnqfx8gSGk4ueoyj8fkVRS22F
         yqJIkZBByd7xbT+4ZbrqWYuAf+v6LyIuvpG2g7omRJsxH9oCSvx7xah+Fm26YLFCMYFD
         JP3YgEHcxrA5/MzsKMU7GV3NI04qeIZzjXXP+mbGQM2NgRp07yXnHI++WrXdUcQzs/nJ
         hCPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793064995; x=1793669795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uJ7o4z3LZNIgv4lmDPckfI0AYkLgwXR/dko+SDg6wpc=;
        b=TCHi4pYxc+HRnB6V8Amv//9+ux2NB1jGYN5Lzzzj6EbVdfVy60LTJ8c1H+yohnZt1G
         EO7LT0WDd6Cx+1Rl4KxvHgdzKekghD/KOIWlPuB0afm3B40k2NKwxyqSOwnGFkIwV9X7
         qWR6yH3updcY/eGnrbnNj68s+lH486j0Yxq4trhblCGUzuVo7Z+TcycF6e1+VWo234fz
         63GOoJmStbX3lZaS6H31mgKWaz8IyaG1DW3YvIPIGxFleRvnl6pYsVn3byVHDnyhwO/T
         /8ne0ySE4pTrUrE/sEBAB3kLe1OVKcNalsgRwWJRFHorVinvih2nWJxdBEQSs98q1Sov
         hxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793064995; x=1793669795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJ7o4z3LZNIgv4lmDPckfI0AYkLgwXR/dko+SDg6wpc=;
        b=JOPEkflb1Mb/1DdUFdGP1an0fbm/EB25B1dgYo4hwo+xzq/xgTSTzfW55kofnRwVaB
         WYHKT8lKsuirbmU862Q6gOjnEt63ZfpFkNs5qn3AVpVHOXMopXOii/0hZ70Zq//ypgeJ
         JGmqGArLu9EttjuhccnrzSW/gY5PxX75BR/3sVm608nzaoKCSIWDZyUz0YJ0YRIKdlYO
         Uu3zJK8thicOfjoqhHCCdZs1C1+LNW7Lot29hrqS409JNtJ/IYCuO2jP7e3/pIx63Jzx
         nn2Fsq+mUUw/QDJw6iNeUvu0HCw0LeIRosIILSd7EyFxr0gliZEwaF+wuvyIRCTIb5Nh
         +hHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEmw34LQEcar6WX/2u4kLUTKHnTEBugPdJEQwn8lYox6DLwA1qPH+NiqznC91du/LkG7k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhIKs6q9CeHCKisAVPW5AGci7Wh7T3VxNkEzy+X5PvXfJ25jiY
	J//4fFQTRDgFAOf/VH84o/qqaIeJD8ldGISPOPBAaUtlA1gEXw2vb1LVatdmM3fZPRVs+i/hAOU
	Lh0Q2fkPRF8d+KQQa8KEg8cuzNskJO6M=
X-Gm-Gg: AYBFou235VyPcgDAzBk1e1zhtgzwQKIAVpmAq7OkbRtfXM1xkwTzlfZVJdpsF1idtxu
	XA45JrbauACw8Vp4HyFATWwENfBpwGERwMWIWYLRqgpMHz2GOUHdCvH+ZuULqQ+eFQ3z74I2Zvc
	xRgG/iDQH5covdyPxjYR+Dq4hgM0XvnbxXByOr5hsdK3dK6vsUOFa7gui3/DX+7SlapQaRF2yGy
	AGLScNwhXKsuSS9OSFvRHf7jpZsvVLuYWFQTcuT5acg0hxxhPX9EZkufwenhAx6eElcc4sEc62z
	62GNR1IYRgxpK47am50+I5AYpPaz3P2unDtvAhG9gI1kaucYy6BkXad/2TocHsuInhF6KT/4I9g
	XG4w/Zd4JobBlhZJnjR6s4hH4XqP/uM4k8pS7pA==
X-Received: by 2002:a05:6871:a842:b0:4a8:d5f:a1f9 with SMTP id
 586e51a60fabf-4a83f5ad043mr5699465fac.30.1793064994997; Mon, 26 Oct 2026
 18:36:34 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016081006.26069-1-yangtiezhu@loongson.cn> <20261016081006.26069-3-yangtiezhu@loongson.cn>
In-Reply-To: <20261016081006.26069-3-yangtiezhu@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 27 Oct 2026 09:36:23 +0800
X-Gm-Features: AclHuK8NUGUQwNg3x4d8i8Yt9qwpmzt7G03qMuZrklzkhNQomf18NVm_P8aDiWc
Message-ID: <CAEyhmHTNA_XbSW+xWss6+7bT29NxazXB2UBGatRyPUQUc667jQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] LoongArch: BPF: Clean up and decouple is32
 parameter from move_imm()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 4:10=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> The current move_imm() relies on the 'is32' parameter for ALU32 and JMP32=
,
> forcing the helper to internally clear the upper 32 bits. However, this i=
s
> redundant for 64-bit immediate loads. Furthermore, it is even undesirable
> for load/store signed address offset computations.
>
> Clean up move_imm() by removing the 'is32' parameter which allows it to
> focus on loading values, while moving the zero-extension logic outward to
> the explicit callers. For 64-bit and load-store operations, just drop the
> parameter.
>
> This is preparation for later patch, no functional changes.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

>  arch/loongarch/net/bpf_jit.c | 102 +++++++++++++++++++----------------
>  arch/loongarch/net/bpf_jit.h |   7 +--
>  2 files changed, 58 insertions(+), 51 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index e78eb582c300..77cd96a6f84c 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -194,7 +194,7 @@ static void build_prologue(struct jit_ctx *ctx)
>         ctx->stack_size =3D stack_adjust;
>
>         if (ctx->arena_vm_start)
> -               move_imm(ctx, REG_ARENA, ctx->arena_vm_start, false);
> +               move_imm(ctx, REG_ARENA, ctx->arena_vm_start);
>  }
>
>  static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
> @@ -339,7 +339,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, in=
t insn)
>
>  static void emit_store_stack_imm64(struct jit_ctx *ctx, int reg, int sta=
ck_off, u64 imm64)
>  {
> -       move_imm(ctx, reg, imm64, false);
> +       move_imm(ctx, reg, imm64);
>         emit_insn(ctx, std, reg, LOONGARCH_GPR_FP, stack_off);
>  }
>
> @@ -355,7 +355,7 @@ static int emit_atomic_rmw(const struct bpf_insn *ins=
n, struct jit_ctx *ctx)
>         const s32 imm =3D insn->imm;
>         const bool isdw =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
>
> -       move_imm(ctx, t1, off, false);
> +       move_imm(ctx, t1, off);
>         emit_insn(ctx, addd, t1, dst, t1);
>         move_reg(ctx, t3, src);
>
> @@ -528,7 +528,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, ldbu, dst, src, off);
>                         } else {
> -                               move_imm(ctx, t1, off, false);
> +                               move_imm(ctx, t1, off);
>                                 emit_insn(ctx, ldxbu, dst, src, t1);
>                         }
>                         break;
> @@ -536,7 +536,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, ldhu, dst, src, off);
>                         } else {
> -                               move_imm(ctx, t1, off, false);
> +                               move_imm(ctx, t1, off);
>                                 emit_insn(ctx, ldxhu, dst, src, t1);
>                         }
>                         break;
> @@ -544,7 +544,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, ldwu, dst, src, off);
>                         } else {
> -                               move_imm(ctx, t1, off, false);
> +                               move_imm(ctx, t1, off);
>                                 emit_insn(ctx, ldxwu, dst, src, t1);
>                         }
>                         break;
> @@ -552,7 +552,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, ldd, dst, src, off);
>                         } else {
> -                               move_imm(ctx, t1, off, false);
> +                               move_imm(ctx, t1, off);
>                                 emit_insn(ctx, ldxd, dst, src, t1);
>                         }
>                         break;
> @@ -567,7 +567,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, stb, src, dst, off);
>                         } else {
> -                               move_imm(ctx, t1, off, false);
> +                               move_imm(ctx, t1, off);
>                                 emit_insn(ctx, stxb, src, dst, t1);
>                         }
>                         break;
> @@ -575,7 +575,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, sth, src, dst, off);
>                         } else {
> -                               move_imm(ctx, t1, off, false);
> +                               move_imm(ctx, t1, off);
>                                 emit_insn(ctx, stxh, src, dst, t1);
>                         }
>                         break;
> @@ -583,7 +583,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, stw, src, dst, off);
>                         } else {
> -                               move_imm(ctx, t1, off, false);
> +                               move_imm(ctx, t1, off);
>                                 emit_insn(ctx, stxw, src, dst, t1);
>                         }
>                         break;
> @@ -591,7 +591,7 @@ static int emit_atomic_ld_st(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, std, src, dst, off);
>                         } else {
> -                               move_imm(ctx, t1, off, false);
> +                               move_imm(ctx, t1, off);
>                                 emit_insn(ctx, stxd, src, dst, t1);
>                         }
>                         break;
> @@ -716,7 +716,7 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>                 if (insn_is_cast_user(insn)) {
>                         move_reg(ctx, t1, src);
>                         emit_zext_32(ctx, t1, true);
> -                       move_imm(ctx, dst, (ctx->user_vm_start >> 32) << =
32, false);
> +                       move_imm(ctx, dst, (ctx->user_vm_start >> 32) << =
32);
>                         emit_insn(ctx, beq, t1, LOONGARCH_GPR_ZERO, 2);
>                         emit_insn(ctx, or, t1, dst, t1);
>                         move_reg(ctx, dst, t1);
> @@ -753,7 +753,8 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>         /* dst =3D imm */
>         case BPF_ALU | BPF_MOV | BPF_K:
>         case BPF_ALU64 | BPF_MOV | BPF_K:
> -               move_imm(ctx, dst, imm, is32);
> +               move_imm(ctx, dst, imm);
> +               emit_zext_32(ctx, dst, is32);
>                 break;
>
>         /* dst =3D dst + src */
> @@ -769,7 +770,8 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>                 if (is_signed_imm12(imm)) {
>                         emit_insn(ctx, addid, dst, dst, imm);
>                 } else {
> -                       move_imm(ctx, t1, imm, is32);
> +                       move_imm(ctx, t1, imm);
> +                       emit_zext_32(ctx, t1, is32);
>                         emit_insn(ctx, addd, dst, dst, t1);
>                 }
>                 emit_zext_32(ctx, dst, is32);
> @@ -788,7 +790,8 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>                 if (is_signed_imm12(-imm)) {
>                         emit_insn(ctx, addid, dst, dst, -imm);
>                 } else {
> -                       move_imm(ctx, t1, imm, is32);
> +                       move_imm(ctx, t1, imm);
> +                       emit_zext_32(ctx, t1, is32);
>                         emit_insn(ctx, subd, dst, dst, t1);
>                 }
>                 emit_zext_32(ctx, dst, is32);
> @@ -804,7 +807,8 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>         /* dst =3D dst * imm */
>         case BPF_ALU | BPF_MUL | BPF_K:
>         case BPF_ALU64 | BPF_MUL | BPF_K:
> -               move_imm(ctx, t1, imm, is32);
> +               move_imm(ctx, t1, imm);
> +               emit_zext_32(ctx, t1, is32);
>                 emit_insn(ctx, muld, dst, dst, t1);
>                 emit_zext_32(ctx, dst, is32);
>                 break;
> @@ -831,12 +835,13 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>         case BPF_ALU | BPF_DIV | BPF_K:
>         case BPF_ALU64 | BPF_DIV | BPF_K:
>                 if (!off) {
> -                       move_imm(ctx, t1, imm, is32);
> +                       move_imm(ctx, t1, imm);
> +                       emit_zext_32(ctx, t1, is32);
>                         emit_zext_32(ctx, dst, is32);
>                         emit_insn(ctx, divdu, dst, dst, t1);
>                         emit_zext_32(ctx, dst, is32);
>                 } else {
> -                       move_imm(ctx, t1, imm, false);
> +                       move_imm(ctx, t1, imm);
>                         emit_sext_32(ctx, t1, is32);
>                         emit_sext_32(ctx, dst, is32);
>                         emit_insn(ctx, divd, dst, dst, t1);
> @@ -866,12 +871,13 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>         case BPF_ALU | BPF_MOD | BPF_K:
>         case BPF_ALU64 | BPF_MOD | BPF_K:
>                 if (!off) {
> -                       move_imm(ctx, t1, imm, is32);
> +                       move_imm(ctx, t1, imm);
> +                       emit_zext_32(ctx, t1, is32);
>                         emit_zext_32(ctx, dst, is32);
>                         emit_insn(ctx, moddu, dst, dst, t1);
>                         emit_zext_32(ctx, dst, is32);
>                 } else {
> -                       move_imm(ctx, t1, imm, false);
> +                       move_imm(ctx, t1, imm);
>                         emit_sext_32(ctx, t1, is32);
>                         emit_sext_32(ctx, dst, is32);
>                         emit_insn(ctx, modd, dst, dst, t1);
> @@ -899,7 +905,8 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>                 if (is_unsigned_imm12(imm)) {
>                         emit_insn(ctx, andi, dst, dst, imm);
>                 } else {
> -                       move_imm(ctx, t1, imm, is32);
> +                       move_imm(ctx, t1, imm);
> +                       emit_zext_32(ctx, t1, is32);
>                         emit_insn(ctx, and, dst, dst, t1);
>                 }
>                 emit_zext_32(ctx, dst, is32);
> @@ -918,7 +925,8 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>                 if (is_unsigned_imm12(imm)) {
>                         emit_insn(ctx, ori, dst, dst, imm);
>                 } else {
> -                       move_imm(ctx, t1, imm, is32);
> +                       move_imm(ctx, t1, imm);
> +                       emit_zext_32(ctx, t1, is32);
>                         emit_insn(ctx, or, dst, dst, t1);
>                 }
>                 emit_zext_32(ctx, dst, is32);
> @@ -937,7 +945,8 @@ static int build_insn(const struct bpf_insn *insn, st=
ruct jit_ctx *ctx, bool ext
>                 if (is_unsigned_imm12(imm)) {
>                         emit_insn(ctx, xori, dst, dst, imm);
>                 } else {
> -                       move_imm(ctx, t1, imm, is32);
> +                       move_imm(ctx, t1, imm);
> +                       emit_zext_32(ctx, t1, is32);
>                         emit_insn(ctx, xor, dst, dst, t1);
>                 }
>                 emit_zext_32(ctx, dst, is32);
> @@ -1097,7 +1106,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>         case BPF_JMP32 | BPF_JSLE | BPF_K:
>                 jmp_offset =3D bpf2la_offset(i, off, ctx);
>                 if (imm) {
> -                       move_imm(ctx, t1, imm, false);
> +                       move_imm(ctx, t1, imm);
>                         tm =3D t1;
>                 } else {
>                         /* If imm is 0, simply use zero register. */
> @@ -1129,7 +1138,8 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>         case BPF_JMP | BPF_JSET | BPF_K:
>         case BPF_JMP32 | BPF_JSET | BPF_K:
>                 jmp_offset =3D bpf2la_offset(i, off, ctx);
> -               move_imm(ctx, t1, imm, is32);
> +               move_imm(ctx, t1, imm);
> +               emit_zext_32(ctx, t1, is32);
>                 emit_insn(ctx, and, t1, dst, t1);
>                 emit_zext_32(ctx, t1, is32);
>                 if (emit_cond_jmp(ctx, cond, t1, LOONGARCH_GPR_ZERO, jmp_=
offset) < 0)
> @@ -1227,7 +1237,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>                 if (bpf_pseudo_func(insn))
>                         move_addr(ctx, dst, imm64);
>                 else
> -                       move_imm(ctx, dst, imm64, is32);
> +                       move_imm(ctx, dst, imm64);
>                 return 1;
>         }
>
> @@ -1268,7 +1278,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>                                 else
>                                         emit_insn(ctx, ldbu, dst, src, of=
f);
>                         } else {
> -                               move_imm(ctx, t1, off, is32);
> +                               move_imm(ctx, t1, off);
>                                 if (sign_extend)
>                                         emit_insn(ctx, ldxb, dst, src, t1=
);
>                                 else
> @@ -1282,7 +1292,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>                                 else
>                                         emit_insn(ctx, ldhu, dst, src, of=
f);
>                         } else {
> -                               move_imm(ctx, t1, off, is32);
> +                               move_imm(ctx, t1, off);
>                                 if (sign_extend)
>                                         emit_insn(ctx, ldxh, dst, src, t1=
);
>                                 else
> @@ -1296,7 +1306,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>                                 else
>                                         emit_insn(ctx, ldwu, dst, src, of=
f);
>                         } else {
> -                               move_imm(ctx, t1, off, is32);
> +                               move_imm(ctx, t1, off);
>                                 if (sign_extend)
>                                         emit_insn(ctx, ldxw, dst, src, t1=
);
>                                 else
> @@ -1304,7 +1314,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>                         }
>                         break;
>                 case BPF_DW:
> -                       move_imm(ctx, t1, off, is32);
> +                       move_imm(ctx, t1, off);
>                         emit_insn(ctx, ldxd, dst, src, t1);
>                         break;
>                 }
> @@ -1331,42 +1341,42 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx, bool ext
>
>                 switch (BPF_SIZE(code)) {
>                 case BPF_B:
> -                       move_imm(ctx, t1, imm, is32);
> +                       move_imm(ctx, t1, imm);
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, stb, t1, dst, off);
>                         } else {
> -                               move_imm(ctx, t2, off, is32);
> +                               move_imm(ctx, t2, off);
>                                 emit_insn(ctx, stxb, t1, dst, t2);
>                         }
>                         break;
>                 case BPF_H:
> -                       move_imm(ctx, t1, imm, is32);
> +                       move_imm(ctx, t1, imm);
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, sth, t1, dst, off);
>                         } else {
> -                               move_imm(ctx, t2, off, is32);
> +                               move_imm(ctx, t2, off);
>                                 emit_insn(ctx, stxh, t1, dst, t2);
>                         }
>                         break;
>                 case BPF_W:
> -                       move_imm(ctx, t1, imm, is32);
> +                       move_imm(ctx, t1, imm);
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, stw, t1, dst, off);
>                         } else if (is_signed_imm14(off)) {
>                                 emit_insn(ctx, stptrw, t1, dst, off);
>                         } else {
> -                               move_imm(ctx, t2, off, is32);
> +                               move_imm(ctx, t2, off);
>                                 emit_insn(ctx, stxw, t1, dst, t2);
>                         }
>                         break;
>                 case BPF_DW:
> -                       move_imm(ctx, t1, imm, is32);
> +                       move_imm(ctx, t1, imm);
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, std, t1, dst, off);
>                         } else if (is_signed_imm14(off)) {
>                                 emit_insn(ctx, stptrd, t1, dst, off);
>                         } else {
> -                               move_imm(ctx, t2, off, is32);
> +                               move_imm(ctx, t2, off);
>                                 emit_insn(ctx, stxd, t1, dst, t2);
>                         }
>                         break;
> @@ -1397,7 +1407,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, stb, src, dst, off);
>                         } else {
> -                               move_imm(ctx, t1, off, is32);
> +                               move_imm(ctx, t1, off);
>                                 emit_insn(ctx, stxb, src, dst, t1);
>                         }
>                         break;
> @@ -1405,7 +1415,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>                         if (is_signed_imm12(off)) {
>                                 emit_insn(ctx, sth, src, dst, off);
>                         } else {
> -                               move_imm(ctx, t1, off, is32);
> +                               move_imm(ctx, t1, off);
>                                 emit_insn(ctx, stxh, src, dst, t1);
>                         }
>                         break;
> @@ -1415,7 +1425,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>                         } else if (is_signed_imm14(off)) {
>                                 emit_insn(ctx, stptrw, src, dst, off);
>                         } else {
> -                               move_imm(ctx, t1, off, is32);
> +                               move_imm(ctx, t1, off);
>                                 emit_insn(ctx, stxw, src, dst, t1);
>                         }
>                         break;
> @@ -1425,7 +1435,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>                         } else if (is_signed_imm14(off)) {
>                                 emit_insn(ctx, stptrd, src, dst, off);
>                         } else {
> -                               move_imm(ctx, t1, off, is32);
> +                               move_imm(ctx, t1, off);
>                                 emit_insn(ctx, stxd, src, dst, t1);
>                         }
>                         break;
> @@ -1537,7 +1547,7 @@ static int emit_jump_and_link(struct jit_ctx *ctx, =
u8 rd, u64 target)
>                 return -EFAULT;
>         }
>
> -       move_imm(ctx, LOONGARCH_GPR_T1, target, false);
> +       move_imm(ctx, LOONGARCH_GPR_T1, target);
>         emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
>
>         return 0;
> @@ -1734,7 +1744,7 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, str=
uct bpf_tramp_image *im,
>                 emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP,=
 -run_ctx_off + cookie_off);
>
>         /* arg1: prog */
> -       move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
> +       move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p);
>         /* arg2: &run_ctx */
>         emit_insn(ctx, addid, LOONGARCH_GPR_A1, LOONGARCH_GPR_FP, -run_ct=
x_off);
>         ret =3D emit_call(ctx, (const u64)bpf_trampoline_enter(p));
> @@ -1755,7 +1765,7 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, str=
uct bpf_tramp_image *im,
>         /* arg1: &args_off */
>         emit_insn(ctx, addid, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -args_o=
ff);
>         if (!p->jited)
> -               move_imm(ctx, LOONGARCH_GPR_A1, (const s64)p->insnsi, fal=
se);
> +               move_imm(ctx, LOONGARCH_GPR_A1, (const s64)p->insnsi);
>         ret =3D emit_call(ctx, (const u64)p->bpf_func);
>         if (ret)
>                 return ret;
> @@ -1772,7 +1782,7 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, str=
uct bpf_tramp_image *im,
>         }
>
>         /* arg1: prog */
> -       move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p, false);
> +       move_imm(ctx, LOONGARCH_GPR_A0, (const s64)p);
>         /* arg2: prog start time */
>         move_reg(ctx, LOONGARCH_GPR_A1, LOONGARCH_GPR_S1);
>         /* arg3: &run_ctx */
> diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
> index bb58c42c2f2a..57a98f8a055b 100644
> --- a/arch/loongarch/net/bpf_jit.h
> +++ b/arch/loongarch/net/bpf_jit.h
> @@ -137,7 +137,7 @@ static inline void move_addr(struct jit_ctx *ctx, enu=
m loongarch_gpr rd, u64 add
>         emit_insn(ctx, lu52id, rd, rd, imm_63_52);
>  }
>
> -static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, =
long imm, bool is32)
> +static inline void move_imm(struct jit_ctx *ctx, enum loongarch_gpr rd, =
long imm)
>  {
>         long imm_11_0, imm_31_12, imm_51_32, imm_63_52, imm_51_0, imm_51_=
31;
>
> @@ -150,7 +150,7 @@ static inline void move_imm(struct jit_ctx *ctx, enum=
 loongarch_gpr rd, long imm
>         /* addiw rd, $zero, imm_11_0 */
>         if (is_signed_imm12(imm)) {
>                 emit_insn(ctx, addiw, rd, LOONGARCH_GPR_ZERO, imm);
> -               goto zext;
> +               return;
>         }
>
>         /* ori rd, $zero, imm_11_0 */
> @@ -195,9 +195,6 @@ static inline void move_imm(struct jit_ctx *ctx, enum=
 loongarch_gpr rd, long imm
>                 if (!is_signed_imm52(imm))
>                         emit_insn(ctx, lu52id, rd, rd, imm_63_52);
>         }
> -
> -zext:
> -       emit_zext_32(ctx, rd, is32);
>  }
>
>  static inline void move_reg(struct jit_ctx *ctx, enum loongarch_gpr rd,
> --
> 2.42.0
>
