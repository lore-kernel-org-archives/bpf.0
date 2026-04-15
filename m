Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F13FCC
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776219883; cv=pass; b=CVdsPcQ0ERBsqtjlNpzMj3Llt8Dsk7c0zNOQLc2+Kl7Ogz/D/VbZON3759b7qFJ9ahwi8fvSm0dlrRTW6+PWotFUo0pjQpWDzxReL7lbkgW+4m/FQ8AFN3WhgHjpDKnSWGCvCw0D/o2dNnyEV7xAMPgShFDvMbLbKqCdrd/Bja8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776219883; c=relaxed/simple;
	bh=UWfwp+MsLObrA5DXDZcWrRQds+drx65djGxTh7vqpUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guJJjU9LIHtTEC30ovkxe9cyAi12V6u42zhS3nApkII1OCF93j3V+BcYSdqKCCM//cNOYv/3RLxVthWwneL5+YSHbWpSy7xh7EFSpIvSWBoTufQwV2nbW2GzbCfb+8wMKakFPVut0q2bWu/8Jw0rneKEOssGcbrnyTyKlMVgzRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+IFSXCr; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+IFSXCr"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4043b27ddeaso3271079fac.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776219881; cv=none;
        d=google.com; s=arc-20240605;
        b=Uv0YHNh0pJ0fMsONpTeUcEydpwHJvqgEJraf3MJUrOCip+/V/fyduOj9SLG9UnAdQI
         eea/w71pE1pun/ExqgEJ433i3qsl1iOTCk+4ZRGpNSFAE5Ac+kZgkYci93J5CiyG3qdY
         cxnbE3C7u+HYHgwt/JWChrnttjIB2ouR6ppN3Choi2QRmXi5EWUR/SaHRggMdoh9skU0
         C5wUY53++oNMzguKQz1J2ur88DbXqz7Vg9q2ax2yo3gzaIlBT4kAJoKkz9+qn8IjkUEN
         n28+mTiyyd9bTdV/bGTm36ggCoUlsdKxMXnAu7wT0etH+2oVf/C/QwfsSfNB2m7dXfcr
         uNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IJilSYQVRtHj9Uy3sgn/sow7EaaBHExHVWk6iwVjy0Y=;
        fh=ay2E3zjcgrfA84jjwx0X+aEKlRKFvXiugI7IWdu5LYE=;
        b=YK6Nu4+CValg84vTPsNYH028aJVUtGBUHfxes5vrqBjoHikdQEzn0sK7mFeSupQM0y
         YT/f97FT/KNjfjPDB3Ry6AnKitTKh4eQOYRfTHvW1cK1OsmFzrJcTV+frQz0rrZfJUUN
         1XgyPDuIWmXHgJiSiVmeFjYtiSJ7h6niVktA4yGPY4dju6ABZJ7vSENyURf6cuBK3+a3
         uyKQF1OOzvS4nymF7LWHSQA5u+YdOb/p1W9W4KMpCo422VFcUcag40i79Db/Ibvb7MOn
         LnD4Ls4/CrL9DUo9j2KElZCtr9t29T8wIzuko7YWxysr3MH2B1b0DO5wHXZGw8bAiqWz
         q6Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776219881; x=1776824681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJilSYQVRtHj9Uy3sgn/sow7EaaBHExHVWk6iwVjy0Y=;
        b=U+IFSXCrlSNXmivLcUZvqss0Q1pxs2SLr/24K8vnFH0OsxSVUPagp+y5vNjwNkUwmG
         1wD0RPMuwrR8fZlMkAgCzFvcL6K2zP7pCf1RYPdDCmDwPllVUCzDKnCHJsC7pRegwL4Q
         ptI479zel2JQdFoyQBT37EhleGIReJ+QuMoVHsGYmFRyPQbI6K+vjUje9D6dhchepy4a
         pIaUpNX5CD8nkGTyEggcHmKLpqJtRfaQPG14+ZwvRL12ia8Xcsj3Q3n6GEpojj9j0fV/
         I6ejEI7ZFFuPVeOikkR3sPELUwZeLY238Hf6XZv2ngK2VCB2gswOA2vonypEQ9tlqtkn
         M2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776219881; x=1776824681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IJilSYQVRtHj9Uy3sgn/sow7EaaBHExHVWk6iwVjy0Y=;
        b=JibI6ofCoaLs8eWF/k2z22/A5VCNqfT3sstzs/xaBK31gowhmUuGt2Y6mTb5vAU7r8
         /iRZomaCYPySUldhLppUipYgk6xCePu2ETWkMTQUljpbvxi9cXflIeTeEdyBwI2pMV1v
         POU7iQ7GIFRzE5KCN6gq5kWPc/dnLcCyg8SHgCGECXaHgoDIHVB5MFzhnc8ppTSPlhpy
         Y1BRu7a8fcN2NE2TD4K6B5Rc2FML516DTRnDyPyFCBTSdc82u7v/qU+R5587VWNlqIZZ
         kNIqQFUjbboXCq5QHaqcSLdseSHD3LSrdKtqPgQRVqYUykoHh7euABXaC9lOgkQfOo9S
         MdxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yDRIhAlGfKEOT+DguO/XJC/c1GJpk+QqoztZ2qS0+C/sTTWSuPp+tJTbxy4Dkz3PpZcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUc6O9irlgXnjsTbcl4htnaFzjQMjWYKnieR/4lLpegLwWyXVC
	BxjM+R8qkeslc3NBZNI2WC7cQdkdEeTlTYmaCAh8Xd8M0RUgndmwGLqAG36h5K6KaxSY5me1OP+
	QEK+tp9P7Gn7L3v78AVpKtoIiM+HvzfZWt31CSoE=
X-Gm-Gg: AeBDiesmyX/g7nxVW/woQOe+bveTC8/qVBLp6LdXHUaB3SCuq9/H8jhD5LDMZQJj8RR
	smXoVH+y5w1X6cmfzZ3D5leNly0l4pnRfNAD10br3zgvqLhgPvRDi/4B4xULxg9RdRPEME2yLJD
	EdyzNTkUKHxRGQwor7OGdqFrSMGKeLEdKzirTZDKrt7pTqhUPWDUEGd9ok739uuwEhrtjypGdEg
	z3GQFHwztlyObASqb0Q4diIFtJyCB5UgZhTebUL8xKmv7+XOT5FyD1TjmgjAp0WlWBp4inegSV0
	hcHk5Ro1UJbLflKfeQ==
X-Received: by 2002:a05:6871:5209:b0:424:6bb7:7c71 with SMTP id
 586e51a60fabf-4246bb78b0fmr1714256fac.25.1776219881271; Tue, 14 Apr 2026
 19:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413040506.26640-1-yangtiezhu@loongson.cn> <20260413040506.26640-2-yangtiezhu@loongson.cn>
In-Reply-To: <20260413040506.26640-2-yangtiezhu@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 15 Apr 2026 10:24:30 +0800
X-Gm-Features: AQROBzDpJH47XKFw6kmUmaX-OosWEpJHltr2ni0L6hYYkkYko-HDnJrmfTL26CQ
Message-ID: <CAEyhmHS7xC1=3GrZLqf-u9+2-vg0BNu2hKE+y3bHNUQPD6yvow@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] LoongArch: Define instruction formats for
 AM{SWAP/ADD}.{B/H} and DBAR
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 12:05=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> The 8 and 16 bit read-modify-write atomic instructions amadd.{b/h} and
> amswap.{b/h} were newly added in the latest LoongArch Reference Manual,
> define the instruction format and check whether support via cpucfg.
>
> Furthermore, define the instruction format for DBAR which will be used
> to support BPF load-acquire and store-release instructions.
>
> This is preparation for later patch.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

>  arch/loongarch/include/asm/cpu-features.h |  1 +
>  arch/loongarch/include/asm/cpu.h          |  2 ++
>  arch/loongarch/include/asm/inst.h         | 10 ++++++++++
>  arch/loongarch/include/uapi/asm/hwcap.h   |  1 +
>  arch/loongarch/kernel/cpu-probe.c         |  4 ++++
>  arch/loongarch/kernel/proc.c              |  2 ++
>  6 files changed, 20 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/i=
nclude/asm/cpu-features.h
> index 8eefe7a2098b..f9d3188accfc 100644
> --- a/arch/loongarch/include/asm/cpu-features.h
> +++ b/arch/loongarch/include/asm/cpu-features.h
> @@ -68,5 +68,6 @@
>  #define cpu_has_msgint         cpu_opt(LOONGARCH_CPU_MSGINT)
>  #define cpu_has_avecint                cpu_opt(LOONGARCH_CPU_AVECINT)
>  #define cpu_has_redirectint    cpu_opt(LOONGARCH_CPU_REDIRECTINT)
> +#define cpu_has_lam_bh         cpu_opt(LOONGARCH_CPU_LAM_BH)
>
>  #endif /* __ASM_CPU_FEATURES_H */
> diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/as=
m/cpu.h
> index 1e60ab264cd0..b423b1f41145 100644
> --- a/arch/loongarch/include/asm/cpu.h
> +++ b/arch/loongarch/include/asm/cpu.h
> @@ -126,6 +126,7 @@ static inline char *id_to_core_name(unsigned int id)
>  #define CPU_FEATURE_MSGINT             30      /* CPU has MSG interrupt =
*/
>  #define CPU_FEATURE_AVECINT            31      /* CPU has AVEC interrupt=
 */
>  #define CPU_FEATURE_REDIRECTINT                32      /* CPU has interr=
upt remapping */
> +#define CPU_FEATURE_LAM_BH             33      /* CPU has AM{SWAP/ADD}[_=
DB].{B/H} instructions */
>
>  #define LOONGARCH_CPU_CPUCFG           BIT_ULL(CPU_FEATURE_CPUCFG)
>  #define LOONGARCH_CPU_LAM              BIT_ULL(CPU_FEATURE_LAM)
> @@ -160,5 +161,6 @@ static inline char *id_to_core_name(unsigned int id)
>  #define LOONGARCH_CPU_MSGINT           BIT_ULL(CPU_FEATURE_MSGINT)
>  #define LOONGARCH_CPU_AVECINT          BIT_ULL(CPU_FEATURE_AVECINT)
>  #define LOONGARCH_CPU_REDIRECTINT      BIT_ULL(CPU_FEATURE_REDIRECTINT)
> +#define LOONGARCH_CPU_LAM_BH           BIT_ULL(CPU_FEATURE_LAM_BH)
>
>  #endif /* _ASM_CPU_H */
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index f9f207082d0e..76b723590023 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -36,6 +36,7 @@
>
>  enum reg0i15_op {
>         break_op        =3D 0x54,
> +       dbar_op         =3D 0x70e4,
>  };
>
>  enum reg0i26_op {
> @@ -194,6 +195,10 @@ enum reg3_op {
>         fstxs_op        =3D 0x7070,
>         fstxd_op        =3D 0x7078,
>         scq_op          =3D 0x70ae,
> +       amswapb_op      =3D 0x70b8,
> +       amswaph_op      =3D 0x70b9,
> +       amaddb_op       =3D 0x70ba,
> +       amaddh_op       =3D 0x70bb,
>         amswapw_op      =3D 0x70c0,
>         amswapd_op      =3D 0x70c1,
>         amaddw_op       =3D 0x70c2,
> @@ -543,6 +548,7 @@ static inline void emit_##NAME(union loongarch_instru=
ction *insn,   \
>  }
>
>  DEF_EMIT_REG0I15_FORMAT(break, break_op)
> +DEF_EMIT_REG0I15_FORMAT(dbar, dbar_op)
>
>  /* like emit_break(imm) but returns a constant expression */
>  #define __emit_break(imm)      ((u32)((imm) | (break_op << 15)))
> @@ -763,6 +769,8 @@ DEF_EMIT_REG3_FORMAT(stxb, stxb_op)
>  DEF_EMIT_REG3_FORMAT(stxh, stxh_op)
>  DEF_EMIT_REG3_FORMAT(stxw, stxw_op)
>  DEF_EMIT_REG3_FORMAT(stxd, stxd_op)
> +DEF_EMIT_REG3_FORMAT(amaddb, amaddb_op)
> +DEF_EMIT_REG3_FORMAT(amaddh, amaddh_op)
>  DEF_EMIT_REG3_FORMAT(amaddw, amaddw_op)
>  DEF_EMIT_REG3_FORMAT(amaddd, amaddd_op)
>  DEF_EMIT_REG3_FORMAT(amandw, amandw_op)
> @@ -771,6 +779,8 @@ DEF_EMIT_REG3_FORMAT(amorw, amorw_op)
>  DEF_EMIT_REG3_FORMAT(amord, amord_op)
>  DEF_EMIT_REG3_FORMAT(amxorw, amxorw_op)
>  DEF_EMIT_REG3_FORMAT(amxord, amxord_op)
> +DEF_EMIT_REG3_FORMAT(amswapb, amswapb_op)
> +DEF_EMIT_REG3_FORMAT(amswaph, amswaph_op)
>  DEF_EMIT_REG3_FORMAT(amswapw, amswapw_op)
>  DEF_EMIT_REG3_FORMAT(amswapd, amswapd_op)
>
> diff --git a/arch/loongarch/include/uapi/asm/hwcap.h b/arch/loongarch/inc=
lude/uapi/asm/hwcap.h
> index 49519b4362c6..90e96113ba51 100644
> --- a/arch/loongarch/include/uapi/asm/hwcap.h
> +++ b/arch/loongarch/include/uapi/asm/hwcap.h
> @@ -19,5 +19,6 @@
>  #define HWCAP_LOONGARCH_PTW            (1 << 13)
>  #define HWCAP_LOONGARCH_LSPW           (1 << 14)
>  #define HWCAP_LOONGARCH_SCQ            (1 << 15)
> +#define HWCAP_LOONGARCH_LAM_BH         (1 << 16)
>
>  #endif /* _UAPI_ASM_HWCAP_H */
> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cp=
u-probe.c
> index 657bbae6c1c7..93466fc7d33d 100644
> --- a/arch/loongarch/kernel/cpu-probe.c
> +++ b/arch/loongarch/kernel/cpu-probe.c
> @@ -177,6 +177,10 @@ static void cpu_probe_common(struct cpuinfo_loongarc=
h *c)
>                 c->options |=3D LOONGARCH_CPU_LAM;
>                 elf_hwcap |=3D HWCAP_LOONGARCH_LAM;
>         }
> +       if (config & CPUCFG2_LAM_BH) {
> +               c->options |=3D LOONGARCH_CPU_LAM_BH;
> +               elf_hwcap |=3D HWCAP_LOONGARCH_LAM_BH;
> +       }
>         if (config & CPUCFG2_SCQ) {
>                 c->options |=3D LOONGARCH_CPU_SCQ;
>                 elf_hwcap |=3D HWCAP_LOONGARCH_SCQ;
> diff --git a/arch/loongarch/kernel/proc.c b/arch/loongarch/kernel/proc.c
> index a8127e83da65..d4ce5b585453 100644
> --- a/arch/loongarch/kernel/proc.c
> +++ b/arch/loongarch/kernel/proc.c
> @@ -64,6 +64,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>                 seq_puts(m, " cpucfg");
>         if (cpu_has_lam)
>                 seq_puts(m, " lam");
> +       if (cpu_has_lam_bh)
> +               seq_puts(m, " lam_bh");
>         if (cpu_has_scq)
>                 seq_puts(m, " scq");
>         if (cpu_has_ual)
> --
> 2.42.0
>
