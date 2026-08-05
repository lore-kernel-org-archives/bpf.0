Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2913B6BF7
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895680; cv=pass; b=XQdRfUFKYLPhGDiS/XP2ee1P1rj8PopP9TbQPbK2EK9i2K9mnAauR5wyoJiYPEXtwV2LHM+LnB9G/X8quhOqlIb9om/pZRbQuQpAidenGuS4xCeMPgLjyys76YffdEZg+BG6ypmcEAvi1OfJjVXjcHnsnnGdfpvrQO7a9b6N8dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895680; c=relaxed/simple;
	bh=bo2Al5DQlcAE1N4YHSqDS6taaDUG9W+7g7pyrnCn0uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngVs7OLEI7lzYdF+FpzW2ai1DibsLe2Vh2EulYxxPpF2brzI9R3AQmuwBAOlkTQKYR74nBq7ypi1uFus7FdIwRC/lGgtKy/aST5bo+ACtSW0fozq8ZxlT9ftNHOtwudcpRcPHcdfFzDcVrSg1jYiS/sFKZrzJ4KHN+44K0CAeFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOpoBd/w; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOpoBd/w"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6ae534c2aadso375041eaf.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 19:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785895673; cv=none;
        d=google.com; s=arc-20260327;
        b=L614VT63q3hBYJT0ZTWVcgGUfnLdqfUMMJvjMD3l63d+7X5bAF6UHwHUY5EcRPMN2T
         v+2A6A78+R2Nk9n72IdyrBFqeTTB1LGOWOiross3NTC8fiZWWo8Fif+ZrmSRfVM6ucIE
         WuW325Mef/114VCe7jqTQpEVGZS0h0FmBmWfw8vxXOv90NLOqLE6p7ZaKWnncAnxLc/w
         GWU8xz1YS7O9HOBhl9zBQ7U4LFothV0t2lCo6LK5jWEdkOibrO2tity3aDOmx299JWmg
         DOLUwv2dA1beBwUAz031D5NortiLMYbnJnLSg7DcLQRuSp2Yj/Z7rJppX2nCo4NjL5lH
         7aNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VVVHXn5WZE3TAq2lS738uM6fISl8R37mJNBh8dxBNlc=;
        fh=pgYjUvCcNkJvpaA/NJQZLbtdv6fiQqq/pm6jQksakjk=;
        b=PqmZrjmb/nMugpuRefPcXurN7pcl9SbHSaJYCYcxnr4DLFlAZ2DiwTvoUHpxXAql+L
         dNzD0CG66S4CxUsVdNqt4/IhbRJAKO7uMM1ehsOBV7bL1aZ4xKh4oSXqnFTLbc9a/0zA
         TjjV9wSTR8TgLUPK7jMUwV07ltKIg/8fQ5d83w4u0gkH2XJDA0YQF/xK0pBtV5yYw32w
         QNYZO814lJIUUs9gQoHHoOmteXFzyxtntFDywF5L3zcUZQ+BAXcWs/D1gs0o510z8b9g
         ngE+DFfrVm+dcWyscd4RToYSiWsfbQQmdVYFeut10/zkMQltvvH4W5l+64yRk6y77fm6
         Vleg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785895673; x=1786500473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VVVHXn5WZE3TAq2lS738uM6fISl8R37mJNBh8dxBNlc=;
        b=KOpoBd/w2fanh0jyBvIbHSZ2ZqhJERYPqijH33P1T/n7qL/d/q2CkgMUuA5vINrCIG
         rHlvjhliSeZN1NiDiICSvZarfm8sK3xH/DKv1ctvTVOEq2T18X+WKSbvh0ll61OmSAYL
         z2wvb8Ru0ePxomXipHkyOjD4wRtBhOqwN3+Wb2Akey6z2BDurx1p+mhs45LxICxydF5T
         MxElio9OYQ56/QIaYlxthT+TIPikm6DbNLWVTxkESvLX1yFI98iFlnjPO7o83OQz/Nza
         7QXQaZW+CMwTvjiO8nb5XsdTwPuC0iIBxunr29mUmjKYe4YT+WpZtlOPF2h2qYDjRg1t
         GfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785895673; x=1786500473;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VVVHXn5WZE3TAq2lS738uM6fISl8R37mJNBh8dxBNlc=;
        b=lq+9LxCIzHtSe69xBiGxl7JDu7PedsnHCXq84fzYd62M5xyZP5Dys+68OybW6MrsAW
         eUYw/JONDSdjNh7k82fOodMPkREaNhxoEMbUnoNushzxZAt/IuRwPmCaqX7szARDmBnY
         gwd7WdoajzE+QZLoMSHjUPsRH4i/77HnhnMBq++DSlVrZ6IC4MmP27asF6Wkcqk8xCkl
         eo5d1LQGYyzOAm5WPM9MyM92d3Fia0wcw46plN24ycRQix3mKdzBZPoXR66Y3PcPu0wi
         ufyddjGCkr+//YuYK1Y1GmqmUmocjYDqkcm5Eq3deSY2d1GvLjbvm1xQs5OvRzYsxf5n
         cCCg==
X-Forwarded-Encrypted: i=1; AHgh+RpLmMrGbriwwsSj4ahJ7gGL8XzIt7KhOO1CaQj0xz6Vj/kjRr5aFk24wOXUogpNPLIGVks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtlQxbrH4q5ZeHWNAbBfM0FTQGdoWRR2yxwVC5c/ilodwd1hFi
	K7MDPEXuPYIc+eKfLxl2qit0DaQyz4NBi1/eEk34xmcGaTdg9IrFyn6Rf2j3zQLf5X6DeLVMvta
	D4MGz32Flm8FGyj3k2iYPM0nDWrdWgfg=
X-Gm-Gg: AR+sD13qc8cWfrfg0cBLqCS5T/NNhxmXkSsuM27ZWZ5Xjk0SUPoZ00dXRb9UPnyuw2n
	Rw3mRMw1lx4mzFfMJGbHVdygmbgdMKAzS5yeuuu7bq0/PpcG3h6l7pTnwgYqv9Fa8Ihxn7/ezHf
	3AHoKv43J8+eYlJT5XuDRICS9dZ5QUP4aFisdEjT9rug61r2fwRzVQs1mIBmTYT3Eqi/9Y5KX+4
	bMJ0ti/kpTxd51+HzlNIy5a7KUOPRaFjRhdcpqjztWP8LdeEOHBknh5xS+Fmj85C7D6I8RwVQCd
	6Ct77bo1RJ1lfgJ5HZRJ1aezDbcTDwgkRjDDb5MDgf81ykpyLPab0gnj6w==
X-Received: by 2002:a05:6820:188d:b0:69e:98c0:4bd6 with SMTP id
 006d021491bc7-6ae96c3662emr1951640eaf.1.1785895673383; Tue, 04 Aug 2026
 19:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729022837.355549-1-chenguang.zhao@linux.dev> <20260729022837.355549-2-chenguang.zhao@linux.dev>
In-Reply-To: <20260729022837.355549-2-chenguang.zhao@linux.dev>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 5 Aug 2026 10:07:41 +0800
X-Gm-Features: AUfX_mxUnxXDGZm3CuFfAeIJjZntI0dLwAv3hjNI7wnI7mpI1FaKzmFthF5pw-c
Message-ID: <CAEyhmHTgCkt2Zezuwkqjgo+MRzA2fkpMcsz_0ddC0Y7semgyvw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] LoongArch: bpf: Fix memory ordering for
 value-returning atomics
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, yangtiezhu@loongson.cn, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 10:29=E2=80=AFAM Chenguang Zhao
<chenguang.zhao@linux.dev> wrote:
>
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>
> Per the Linux Kernel Memory Model, value-returning atomic RMW operations
> must provide sequentially consistent ordering (a full memory barrier). On
> LoongArch, plain AMO instructions and bare ll/sc loops do not satisfy thi=
s
> requirement by themselves.
>

The subject line could be:
  LoongArch: bpf: Align value-returning atomics with LKMM ordering

I think it's not a fix and we don't need a Fixes tag.

Other than that,
Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

> Update emit_atomic_rmw() to emit barrier-carrying instructions for all
> value-returning BPF atomics:
>
>  - BPF_FETCH (ADD/AND/OR/XOR): use am*_db.{b,h,w,d}
>  - BPF_XCHG: use amswap_db.{b,h,w,d}
>  - BPF_CMPXCHG: emit dbar 0x700 after the ll/sc loop, matching
>    __WEAK_LLSC_MB in cmpxchg.h
>
> Add the corresponding instruction encodings and emit helpers to inst.h.
> Non-value-returning RMW ops (plain BPF_ADD, BPF_AND, etc.) are left as
> weakly ordered, consistent with LKMM.
>
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  arch/loongarch/include/asm/inst.h | 18 +++++++++++++++++
>  arch/loongarch/net/bpf_jit.c      | 32 +++++++++++++++++--------------
>  2 files changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index 76b723590023..bdbc17d07110 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -199,6 +199,10 @@ enum reg3_op {
>         amswaph_op      =3D 0x70b9,
>         amaddb_op       =3D 0x70ba,
>         amaddh_op       =3D 0x70bb,
> +       amswapdbb_op    =3D 0x70bc,
> +       amswapdbh_op    =3D 0x70bd,
> +       amadddbb_op     =3D 0x70be,
> +       amadddbh_op     =3D 0x70bf,
>         amswapw_op      =3D 0x70c0,
>         amswapd_op      =3D 0x70c1,
>         amaddw_op       =3D 0x70c2,
> @@ -783,6 +787,20 @@ DEF_EMIT_REG3_FORMAT(amswapb, amswapb_op)
>  DEF_EMIT_REG3_FORMAT(amswaph, amswaph_op)
>  DEF_EMIT_REG3_FORMAT(amswapw, amswapw_op)
>  DEF_EMIT_REG3_FORMAT(amswapd, amswapd_op)
> +DEF_EMIT_REG3_FORMAT(amswapdbb, amswapdbb_op)
> +DEF_EMIT_REG3_FORMAT(amswapdbh, amswapdbh_op)
> +DEF_EMIT_REG3_FORMAT(amadddbb, amadddbb_op)
> +DEF_EMIT_REG3_FORMAT(amadddbh, amadddbh_op)
> +DEF_EMIT_REG3_FORMAT(amadddbw, amadddbw_op)
> +DEF_EMIT_REG3_FORMAT(amadddbd, amadddbd_op)
> +DEF_EMIT_REG3_FORMAT(amanddbw, amanddbw_op)
> +DEF_EMIT_REG3_FORMAT(amanddbd, amanddbd_op)
> +DEF_EMIT_REG3_FORMAT(amordbw, amordbw_op)
> +DEF_EMIT_REG3_FORMAT(amordbd, amordbd_op)
> +DEF_EMIT_REG3_FORMAT(amxordbw, amxordbw_op)
> +DEF_EMIT_REG3_FORMAT(amxordbd, amxordbd_op)
> +DEF_EMIT_REG3_FORMAT(amswapdbw, amswapdbw_op)
> +DEF_EMIT_REG3_FORMAT(amswapdbd, amswapdbd_op)
>
>  #define DEF_EMIT_REG3SA2_FORMAT(NAME, OP)                              \
>  static inline void emit_##NAME(union loongarch_instruction *insn,      \
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 29c281bef28e..5417a5624327 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -8,6 +8,9 @@
>  #include <asm/asm-offsets.h>
>  #include "bpf_jit.h"
>
> +/* dbar hint for ll/sc completion ordering, see __WEAK_LLSC_MB */
> +#define DBAR_LLSC_MB   0x700
> +
>  #define LOONGARCH_MAX_REG_ARGS 8
>
>  #define LOONGARCH_SAVE_RA_NINSNS   1
> @@ -433,7 +436,7 @@ static int emit_atomic_rmw(const struct bpf_insn *ins=
n, struct jit_ctx *ctx)
>                                 pr_err_once("bpf-jit: amadd.b instruction=
 is not supported\n");
>                                 return -EINVAL;
>                         }
> -                       emit_insn(ctx, amaddb, src, t1, t3);
> +                       emit_insn(ctx, amadddbb, src, t1, t3);
>                         emit_zext_32(ctx, src, true);
>                         break;
>                 case BPF_H:
> @@ -441,39 +444,39 @@ static int emit_atomic_rmw(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
>                                 pr_err_once("bpf-jit: amadd.h instruction=
 is not supported\n");
>                                 return -EINVAL;
>                         }
> -                       emit_insn(ctx, amaddh, src, t1, t3);
> +                       emit_insn(ctx, amadddbh, src, t1, t3);
>                         emit_zext_32(ctx, src, true);
>                         break;
>                 case BPF_W:
> -                       emit_insn(ctx, amaddw, src, t1, t3);
> +                       emit_insn(ctx, amadddbw, src, t1, t3);
>                         emit_zext_32(ctx, src, true);
>                         break;
>                 case BPF_DW:
> -                       emit_insn(ctx, amaddd, src, t1, t3);
> +                       emit_insn(ctx, amadddbd, src, t1, t3);
>                         break;
>                 }
>                 break;
>         case BPF_AND | BPF_FETCH:
>                 if (isdw) {
> -                       emit_insn(ctx, amandd, src, t1, t3);
> +                       emit_insn(ctx, amanddbd, src, t1, t3);
>                 } else {
> -                       emit_insn(ctx, amandw, src, t1, t3);
> +                       emit_insn(ctx, amanddbw, src, t1, t3);
>                         emit_zext_32(ctx, src, true);
>                 }
>                 break;
>         case BPF_OR | BPF_FETCH:
>                 if (isdw) {
> -                       emit_insn(ctx, amord, src, t1, t3);
> +                       emit_insn(ctx, amordbd, src, t1, t3);
>                 } else {
> -                       emit_insn(ctx, amorw, src, t1, t3);
> +                       emit_insn(ctx, amordbw, src, t1, t3);
>                         emit_zext_32(ctx, src, true);
>                 }
>                 break;
>         case BPF_XOR | BPF_FETCH:
>                 if (isdw) {
> -                       emit_insn(ctx, amxord, src, t1, t3);
> +                       emit_insn(ctx, amxordbd, src, t1, t3);
>                 } else {
> -                       emit_insn(ctx, amxorw, src, t1, t3);
> +                       emit_insn(ctx, amxordbw, src, t1, t3);
>                         emit_zext_32(ctx, src, true);
>                 }
>                 break;
> @@ -485,7 +488,7 @@ static int emit_atomic_rmw(const struct bpf_insn *ins=
n, struct jit_ctx *ctx)
>                                 pr_err_once("bpf-jit: amswap.b instructio=
n is not supported\n");
>                                 return -EINVAL;
>                         }
> -                       emit_insn(ctx, amswapb, src, t1, t3);
> +                       emit_insn(ctx, amswapdbb, src, t1, t3);
>                         emit_zext_32(ctx, src, true);
>                         break;
>                 case BPF_H:
> @@ -493,15 +496,15 @@ static int emit_atomic_rmw(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
>                                 pr_err_once("bpf-jit: amswap.h instructio=
n is not supported\n");
>                                 return -EINVAL;
>                         }
> -                       emit_insn(ctx, amswaph, src, t1, t3);
> +                       emit_insn(ctx, amswapdbh, src, t1, t3);
>                         emit_zext_32(ctx, src, true);
>                         break;
>                 case BPF_W:
> -                       emit_insn(ctx, amswapw, src, t1, t3);
> +                       emit_insn(ctx, amswapdbw, src, t1, t3);
>                         emit_zext_32(ctx, src, true);
>                         break;
>                 case BPF_DW:
> -                       emit_insn(ctx, amswapd, src, t1, t3);
> +                       emit_insn(ctx, amswapdbd, src, t1, t3);
>                         break;
>                 }
>                 break;
> @@ -524,6 +527,7 @@ static int emit_atomic_rmw(const struct bpf_insn *ins=
n, struct jit_ctx *ctx)
>                         emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -6);
>                         emit_zext_32(ctx, r0, true);
>                 }
> +               emit_insn(ctx, dbar, DBAR_LLSC_MB);
>                 break;
>         default:
>                 pr_err_once("bpf-jit: invalid atomic read-modify-write op=
code %02x\n", imm);
> --
> 2.25.1
>
