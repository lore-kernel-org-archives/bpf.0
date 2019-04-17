Return-Path: <SRS0=eni5=ST=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59FDC10F12
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A94C20835
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+hfMgbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfDQHzz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:55:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40980 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731443AbfDQHzt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Apr 2019 03:55:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id w30so26310314qta.8;
        Wed, 17 Apr 2019 00:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OsrSxX+m2jg/f2b2QUY0V+ZqPkW/p1aTKD+pGKvJnhE=;
        b=C+hfMgbz3+RPog/Cqh9oh+5y3M4ufHHHoNDc1OdScL0kFo0F/VFRKeyiIEe9h4TENn
         53K2jCslZNZj3fQUsjrHtVtdFdlYagAX+DlxvraK/yf0T9f7omloPIaa3X0aqeio9pYl
         oigP75lpuGYKj6SRHa1yIXxBN2H9wnCSGSQB7eOT6XjdrZ+HJVHvRJvn08RdKx+qYm+z
         ZLxkYVEqbPPCf6PCDhOQZmaiWdeeDEQrBBQsDCYaspeyAud+U+uGUAKoVgWRuFWg4N/I
         D++iOfRLT3dvC2SNlVb8+9/MyiFIRE0Iz8h4I1LC4rHF0Qwr2D7GrzoV8tyv2Kt3y+zT
         ZFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OsrSxX+m2jg/f2b2QUY0V+ZqPkW/p1aTKD+pGKvJnhE=;
        b=rWFqQlK5kv4jswM5iw0JfCQOtj8cINZl/ijO9vH3GLAnm1i2i3tFmJx3I6oc13i7zI
         dL/TCm2/5nU7KnJFT9pylx3rz1Wr8boVw31Aa2XJRbY+gp950vzb9aksoIdoBupnNOBt
         sMaZzX7oAOCmAdasl96ymn9/m6rr6gTnZ88iTeKaMdl00jBkc7TqT5IZotfSkXI/o4sv
         /ARdmkKXXYswppOYusQErfkr62rbr9/MYqmla1fwTI49Xom/bE5fGe86UOyDZ5n8VYEQ
         YGpRLBL6AqURBTm3kBI1CC6U6fWtydf69p1caeXWmGfl2FWmymkCqJAnak7xSjLmSoWp
         5ttg==
X-Gm-Message-State: APjAAAWnKTzn8dOoW7ovHBJDKN5T2D2CK+ay6gC0may5qTjXhzu2SkbI
        eUXaSvL2oKDT5JlIT9qfw6fuo0ISvf9KudIbojY=
X-Google-Smtp-Source: APXvYqzgw1fLcIZ70c33TPAej/sfBKHJaQDYSNox6c6AJtzSfLH750FRv8G+3jDfbsSZ/s3VfXnHJuAI9LQdYJgmAbE=
X-Received: by 2002:ac8:1a4f:: with SMTP id q15mr70678285qtk.10.1555487748269;
 Wed, 17 Apr 2019 00:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com> <1555349185-12508-15-git-send-email-jiong.wang@netronome.com>
In-Reply-To: <1555349185-12508-15-git-send-email-jiong.wang@netronome.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Wed, 17 Apr 2019 09:55:36 +0200
Message-ID: <CAJ+HfNh+ZA5npa9DiFyQG3yWUpk7eCQ2RP1nToMrg5eSfNGzOA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 14/15] riscv: bpf: eliminate zero extension code-gen
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Apr 2019 at 19:26, Jiong Wang <jiong.wang@netronome.com> wrote:
>
> CC: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>
> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> ---
>  arch/riscv/net/bpf_jit_comp.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp.c b/arch/riscv/net/bpf_jit_comp.=
c
> index 80b12aa..9cba262 100644
> --- a/arch/riscv/net/bpf_jit_comp.c
> +++ b/arch/riscv/net/bpf_jit_comp.c
> @@ -731,6 +731,7 @@ static int emit_insn(const struct bpf_insn *insn, str=
uct rv_jit_context *ctx,
>  {
>         bool is64 =3D BPF_CLASS(insn->code) =3D=3D BPF_ALU64 ||
>                     BPF_CLASS(insn->code) =3D=3D BPF_JMP;
> +       struct bpf_prog_aux *aux =3D ctx->prog->aux;
>         int rvoff, i =3D insn - ctx->prog->insnsi;
>         u8 rd =3D -1, rs =3D -1, code =3D insn->code;
>         s16 off =3D insn->off;
> @@ -743,7 +744,7 @@ static int emit_insn(const struct bpf_insn *insn, str=
uct rv_jit_context *ctx,
>         case BPF_ALU | BPF_MOV | BPF_X:
>         case BPF_ALU64 | BPF_MOV | BPF_X:
>                 emit(is64 ? rv_addi(rd, rs, 0) : rv_addiw(rd, rs, 0), ctx=
);
> -               if (!is64)
> +               if (!is64 && aux->no_verifier_zext)
>                         emit_zext_32(rd, ctx);
>                 break;
>
> @@ -771,19 +772,19 @@ static int emit_insn(const struct bpf_insn *insn, s=
truct rv_jit_context *ctx,
>         case BPF_ALU | BPF_MUL | BPF_X:
>         case BPF_ALU64 | BPF_MUL | BPF_X:
>                 emit(is64 ? rv_mul(rd, rd, rs) : rv_mulw(rd, rd, rs), ctx=
);
> -               if (!is64)
> +               if (!is64 && aux->no_verifier_zext)
>                         emit_zext_32(rd, ctx);
>                 break;
>         case BPF_ALU | BPF_DIV | BPF_X:
>         case BPF_ALU64 | BPF_DIV | BPF_X:
>                 emit(is64 ? rv_divu(rd, rd, rs) : rv_divuw(rd, rd, rs), c=
tx);
> -               if (!is64)
> +               if (!is64 && aux->no_verifier_zext)
>                         emit_zext_32(rd, ctx);
>                 break;
>         case BPF_ALU | BPF_MOD | BPF_X:
>         case BPF_ALU64 | BPF_MOD | BPF_X:
>                 emit(is64 ? rv_remu(rd, rd, rs) : rv_remuw(rd, rd, rs), c=
tx);
> -               if (!is64)
> +               if (!is64 && aux->no_verifier_zext)
>                         emit_zext_32(rd, ctx);
>                 break;
>         case BPF_ALU | BPF_LSH | BPF_X:
> @@ -867,7 +868,7 @@ static int emit_insn(const struct bpf_insn *insn, str=
uct rv_jit_context *ctx,
>         case BPF_ALU | BPF_MOV | BPF_K:
>         case BPF_ALU64 | BPF_MOV | BPF_K:
>                 emit_imm(rd, imm, ctx);
> -               if (!is64)
> +               if (!is64 && aux->no_verifier_zext)
>                         emit_zext_32(rd, ctx);
>                 break;
>
> @@ -882,7 +883,7 @@ static int emit_insn(const struct bpf_insn *insn, str=
uct rv_jit_context *ctx,
>                         emit(is64 ? rv_add(rd, rd, RV_REG_T1) :
>                              rv_addw(rd, rd, RV_REG_T1), ctx);
>                 }
> -               if (!is64)
> +               if (!is64 && aux->no_verifier_zext)
>                         emit_zext_32(rd, ctx);
>                 break;
>         case BPF_ALU | BPF_SUB | BPF_K:
> @@ -895,7 +896,7 @@ static int emit_insn(const struct bpf_insn *insn, str=
uct rv_jit_context *ctx,
>                         emit(is64 ? rv_sub(rd, rd, RV_REG_T1) :
>                              rv_subw(rd, rd, RV_REG_T1), ctx);
>                 }
> -               if (!is64)
> +               if (!is64 && aux->no_verifier_zext)
>                         emit_zext_32(rd, ctx);
>                 break;
>         case BPF_ALU | BPF_AND | BPF_K:
> @@ -906,7 +907,7 @@ static int emit_insn(const struct bpf_insn *insn, str=
uct rv_jit_context *ctx,
>                         emit_imm(RV_REG_T1, imm, ctx);
>                         emit(rv_and(rd, rd, RV_REG_T1), ctx);
>                 }
> -               if (!is64)
> +               if (!is64 && aux->no_verifier_zext)
>                         emit_zext_32(rd, ctx);
>                 break;
>         case BPF_ALU | BPF_OR | BPF_K:
> @@ -917,7 +918,7 @@ static int emit_insn(const struct bpf_insn *insn, str=
uct rv_jit_context *ctx,
>                         emit_imm(RV_REG_T1, imm, ctx);
>                         emit(rv_or(rd, rd, RV_REG_T1), ctx);
>                 }
> -               if (!is64)
> +               if (!is64 && aux->no_verifier_zext)
>                         emit_zext_32(rd, ctx);
>                 break;
>         case BPF_ALU | BPF_XOR | BPF_K:
> @@ -928,7 +929,7 @@ static int emit_insn(const struct bpf_insn *insn, str=
uct rv_jit_context *ctx,
>                         emit_imm(RV_REG_T1, imm, ctx);
>                         emit(rv_xor(rd, rd, RV_REG_T1), ctx);
>                 }
> -               if (!is64)
> +               if (!is64 && aux->no_verifier_zext)
>                         emit_zext_32(rd, ctx);
>                 break;
>         case BPF_ALU | BPF_MUL | BPF_K:
> @@ -936,7 +937,7 @@ static int emit_insn(const struct bpf_insn *insn, str=
uct rv_jit_context *ctx,
>                 emit_imm(RV_REG_T1, imm, ctx);
>                 emit(is64 ? rv_mul(rd, rd, RV_REG_T1) :
>                      rv_mulw(rd, rd, RV_REG_T1), ctx);
> -               if (!is64)
> +               if (!is64 && aux->no_verifier_zext)
>                         emit_zext_32(rd, ctx);
>                 break;
>         case BPF_ALU | BPF_DIV | BPF_K:
> @@ -944,7 +945,7 @@ static int emit_insn(const struct bpf_insn *insn, str=
uct rv_jit_context *ctx,
>                 emit_imm(RV_REG_T1, imm, ctx);
>                 emit(is64 ? rv_divu(rd, rd, RV_REG_T1) :
>                      rv_divuw(rd, rd, RV_REG_T1), ctx);
> -               if (!is64)
> +               if (!is64 && aux->no_verifier_zext)
>                         emit_zext_32(rd, ctx);
>                 break;
>         case BPF_ALU | BPF_MOD | BPF_K:
> @@ -952,7 +953,7 @@ static int emit_insn(const struct bpf_insn *insn, str=
uct rv_jit_context *ctx,
>                 emit_imm(RV_REG_T1, imm, ctx);
>                 emit(is64 ? rv_remu(rd, rd, RV_REG_T1) :
>                      rv_remuw(rd, rd, RV_REG_T1), ctx);
> -               if (!is64)
> +               if (!is64 && aux->no_verifier_zext)
>                         emit_zext_32(rd, ctx);
>                 break;
>         case BPF_ALU | BPF_LSH | BPF_K:
> @@ -1503,6 +1504,11 @@ static void bpf_flush_icache(void *start, void *en=
d)
>         flush_icache_range((unsigned long)start, (unsigned long)end);
>  }
>
> +bool bpf_jit_hardware_zext(void)
> +{
> +       return false;
> +}
> +
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  {
>         bool tmp_blinded =3D false, extra_pass =3D false;
> --
> 2.7.4
>

Really interesting set!

For the RV-JIT patch:

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>
