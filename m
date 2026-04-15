Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E82D73B6
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776219903; cv=pass; b=Z9FAQ3ItOVTgDbiWB4oUEXslv1hyKLv3D9FwCPQQcgASkdfXS/DmWM7hVNQKSBptxgtJ6yam36biMcddzE6JInSM8chke2hVHg3R03giQtzGLIuUZsiyWSuCaG7ewCJPq8u5yN4kBQ+0N6z/3h7TJYl0hDzw1a6bIgXeWPzT7k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776219903; c=relaxed/simple;
	bh=T5bPmxtrwr5CPFUcZhjltMGhNlJziA7tH+wj1zrYKec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLmF8u1AVCIpkuN+f7+vFLz6au9sSoKkEF7Vyg2dxc77BCzlIVpO7IrTMXjP6xJLd1ZafAAnvzNZfWIJd38GFZo2SsWdsalFahgbVuY8ZekGimki4iXesrDh2OpI1Ks+3OpJ7CAoX9gJ+JQQBQ17F6bTufiGmYwG734ugoCVk/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIA1PUHe; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIA1PUHe"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-41576c5c01cso4781277fac.3
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776219901; cv=none;
        d=google.com; s=arc-20240605;
        b=DdvSyYpCIf5Pc+7AYgYVB03mV02PxkU5avX3V3wb4I7ZGEk10nsbSz/3IuDpGagfp/
         Dqjpz02aieLkuWrE+fShndptoQOhpZfWiT5bTBHAN6PVH4LxISzW+SCp0HWo1rQoGFhD
         XysiSX7NkX4ZF9WXiZuqQgezDYPQ9340ztmOfbfE5HWpj14QsKzLed54OJlMq2X3nPjc
         9apH9xiD3zlT3cPcfObQM49UR6IUy2UaYQgVNS2r69OGl6UFIJ71ppDtGGYerbT0GJq+
         SQd6xMW0yP7QoycBpf8g32zaJr4l5tRi4Ar1vGfPzdljXLSmFC2xZCqZmdj2p7XBpoSV
         v/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jttgu4B43bPxLujJofIdsu6iWI/oDg34v0H1xOsCRr4=;
        fh=5ea3Wk5m7rQhPTRJH/UAxw1M/aY7pNBG9WoeduyzUDA=;
        b=KShARqhh/WHNdCpMGFQ6rWzKcX2pGRkVFAFjrf0LarebCLF6qioera75H5xmH0Iatq
         YJstoYOC9Oqns/HvY0voCjajm4cW7UBkOlhwf1wTSAztqLYcNLJasbdDuSSK+R7f7DQJ
         m3T8TCtZUdqsg80Ed0PrUVasYBmCNt5UCnyyGLLDXf396PreCeMojJPQlGn/qQa8tbKV
         Kc3IRbFGlYNKNHeVu8T7E1mfk/61Oe20OrFVuwXOh4GBT/xhopo6MIDP2A0vTTvMlORn
         BP1p8Wmn1o1XheN8+GMcJE3SC4tKnukUHrMofkObiYCrN2NWfmyb94PkQEqURAwx/uVt
         V6HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776219901; x=1776824701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jttgu4B43bPxLujJofIdsu6iWI/oDg34v0H1xOsCRr4=;
        b=XIA1PUHeS1NekZqSOFNyZtJgfW9xWoVFVa1xuk+WiY9Vco3lF744EBxNR5EBQWnorM
         ywN87EqQkow1VS2akTflircOF/XxQeiBOn6v/l/62rEfCxOd4hoxvSfsFTPUJWX40Asj
         YEb5HbAhgztaXf+JNSBpHUb5RHBOShy5inD4TzHmtzT8xjdgR8pX0HVr4fFl0FRAzLUl
         cMjpiUb1PMcdFE6dIqceVDk/3cHTIdMAi7rPHZeuEgueGM0yG7vmn33cNhjxfJ/Irmmw
         SoAC5R5TqVFmW8EkK8UEvMwSNrOuWllKihPq8P5ZG2FwvJZG8LftJj3MBjb1agjXvS1k
         I5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776219901; x=1776824701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jttgu4B43bPxLujJofIdsu6iWI/oDg34v0H1xOsCRr4=;
        b=srGqG4KpzD8kvnWWxMmbUjFse0pcjTyv+y1ttnYyiTfMvzi6sAK+O2MqOdDcMp3AgI
         KkbmRtix09wjBZ58zRZdjv6N7bNny5MoAC5sjw4ynnCRNWD1/dOt/FEe0luAps9I1AxN
         DvJqtBIUcpBZoksnb/vvCyt/oUV2ZU6x7Bh5gyD2f8LMWkUUAvMm3TmKRzv2LeBJHi8i
         fmaIBWsJzNDOL1jS1GecRbh7fUj5X+lmLw0iS3zZYGjQbinEddAjltbaOo7/h/C0RZ7J
         oqZg7C373hf3EHZopq5K+69/4XXRLNdArNeQ5PwTKgR71Wo2lw895ZpbbjfYkq7vaZSU
         Q/Jw==
X-Forwarded-Encrypted: i=1; AFNElJ9URgST0lpA8R9Vp4Dax6nZfEYj9mL/FUzgFiyHpfMdj8jiT8pjq1Nj3Jv1h9TimtNt8Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHDiV3AGECLO4GCzdIlNbO7y9DnJ6BP6UJyLuj9ANr1v2E+DiZ
	qxvrkn2R7YKVPXkxwK7YHi11zyPHbv9vcsI/Lmf3qK8DTsdze/1Oe6fCNqrh6WQSgDqPf1PUALE
	9vIv9wEmKuknk2PFdXiSR32oI/P+I2nM=
X-Gm-Gg: AeBDietNQ77i2z8iRWZKOI8Ce8J/91yiSOEgDeVyGUugaP5P772dvmgoTPNevYhkorN
	9/gjgplUwEZo/ErXU5utBL+rwLC7Jd3Azy+CZiTl4EKvxbcDxGpfnOCUCxeLCXUDN6k4VJT5/Bv
	qooGUTNDdcTKuTzwsgS1UwrX69o3JjmVRPZI3iLMV/78fzqg7oLb5KqW2MSrDiMlXVSa8bnpSZk
	dsyXRqjKp07/Jc9biNJtksxE8snfCPtDzQszCicTuiNFOcpt/q9WsONAbgHRjXTsyskGWDGuVdB
	QEui7ERTmTcvB3MQOQ==
X-Received: by 2002:a05:6871:2ee7:b0:41c:dd:9e13 with SMTP id
 586e51a60fabf-423e11e69d5mr11767935fac.39.1776219900892; Tue, 14 Apr 2026
 19:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413040506.26640-1-yangtiezhu@loongson.cn> <20260413040506.26640-3-yangtiezhu@loongson.cn>
In-Reply-To: <20260413040506.26640-3-yangtiezhu@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 15 Apr 2026 10:24:50 +0800
X-Gm-Features: AQROBzApEWzUWVYCnCJW51fFV79nskrsS9_jMRIB5MMaHw0XS7Bobt8tSYuCALc
Message-ID: <CAEyhmHSAHv5PcW+_FZd5EAivJWE+0nRKN3tAjiK7pS594nu8aA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] LoongArch: BPF: Add the default case in
 emit_atomic() and rename it
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 12:05=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> Like the other archs such as x86 and riscv, add the default case
> in emit_atomic() to print an error message for the invalid opcode
> and return -EINVAL , then make its return type as int.
>
> While at it, given that all of the instructions in emit_atomic()
> are only read-modify-write instructions, rename emit_atomic() to
> emit_atomic_rmw() to make it clear, because there will be a new
> function emit_atomic_ld_st() for load-acquire and store-release
> instructions in the later patch.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

>  arch/loongarch/net/bpf_jit.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 9cb796e16379..fefda4050a20 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -344,7 +344,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, in=
t insn)
>  #undef jmp_offset
>  }
>
> -static void emit_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx=
)
> +static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *=
ctx)
>  {
>         const u8 t1 =3D LOONGARCH_GPR_T1;
>         const u8 t2 =3D LOONGARCH_GPR_T2;
> @@ -448,7 +448,12 @@ static void emit_atomic(const struct bpf_insn *insn,=
 struct jit_ctx *ctx)
>                         emit_zext_32(ctx, r0, true);
>                 }
>                 break;
> +       default:
> +               pr_err_once("bpf-jit: invalid atomic read-modify-write op=
code %02x\n", imm);
> +               return -EINVAL;
>         }
> +
> +       return 0;
>  }
>
>  static bool is_signed_bpf_cond(u8 cond)
> @@ -1256,7 +1261,9 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
>
>         case BPF_STX | BPF_ATOMIC | BPF_W:
>         case BPF_STX | BPF_ATOMIC | BPF_DW:
> -               emit_atomic(insn, ctx);
> +               ret =3D emit_atomic_rmw(insn, ctx);
> +               if (ret)
> +                       return ret;
>                 break;
>
>         /* Speculation barrier */
> --
> 2.42.0
>
