Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E0480335
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905667; cv=pass; b=YMAlYn75uJ5B0MiDvjToIbcDvAd/DuscUTQOfKqA9czFdkPyFlVbh+6WM6VHzX+nVrRYU90MpgirGxNVIrPKXycBTIF9SOa1plOmcs/1smXuue2h273+L+NmxYmJphdtqgp82faN7jfD1f3BrbFwexrgCirk1gRY4QW7L2LLJXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905667; c=relaxed/simple;
	bh=W4jIRWkMkdIsGUUuTl5uhgAhh9gHu3V6CoJE+iqvjRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIw7wetlt3QxHTA2gaRgzOzUfll4Eja1bgmsQaTiamFAY41YRlXvGiWAQJtehz3gtcf/uFwxjiLbOCLlhpm5nC4Xg1AFJEsoWmqD2jGau8cOcOmvXYQPEFt+DHL3nHS3WvAhY7pdeZ7Q3ce4Ydas361qL4b2nQRm3CJwELnh91c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hWC/BOto; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hWC/BOto"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9ed64d490so217638a34.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 04:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782905664; cv=none;
        d=google.com; s=arc-20260327;
        b=jpP37LygO8qim8y29eu7PbzFER3cbWwo2Bunw3qGGo+rRp4Tf66XMCSJKy3m7jjXEA
         XHmOiYgHn1RM4QtVllJ7X3KgOpWXTYu6D6LZBi0SY0r0RxdouD0/lxZL2G6kjTDwjmx8
         fRKHgZk2XwkrMcLedezkZQBfPv4p843gKg69vRhHe6ccy4dmUlxw9nQ+2XgLkf4G49M0
         yzcB3cVSe7bITYgt4eYkUoNcDlkwWbWIDdnDRa9LSwvt1rLycmJlWyeGM6YYxicHYnu4
         1C/GmxinNzhRsLy5a29/+9mRUG/89vlF21kNl30st9r/9TuMwiR6uzF7UVAb8QGf2WBW
         7Ffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4faTMgKNiTFwecAROGzTjTqdDKLQ5/Ado1VdunwSeFg=;
        fh=ojzAiWD2I4vdVEMhC/VPidti+xtDE/RKrJjl2QjrttQ=;
        b=h8wheDLxHDTDkDVqWYLbAoiiixdFSbwtYkyehqBFMXpKXnefTYZoM/VTfjun9YiSKc
         t2zJdjaxBpN4d2tkkm33Dk/0LC7iGPmcMOqMuZ51gUy6X6QWtkDdAUct8p32apIjCv/6
         9kzM8/z3HtKMX1UFScxy/QE9uIH4Z7hsiJ3amXKjvedqlnQFjeSUc1JTEkxkdDCzKIHc
         WkgndoF0PEiuSceViyfIhGn3OEIU7qJwFkhfJbLZIDvoNEfUKzOG24lcca1dFBTTuWHL
         M2suFyUTjFESCR2IQVCblPwUkVIfbjfUUthr/BzR7niZFBFAj4hvXGWE1L/WFKShvLfF
         eLUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782905664; x=1783510464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4faTMgKNiTFwecAROGzTjTqdDKLQ5/Ado1VdunwSeFg=;
        b=hWC/BOtoxnBTywuTEBFhl+b+E3u6cfeUWPthx2gZW32QZo/uzPChnkmSgsmQgOC8nq
         OEfTF9LpH+BZpuIXxnfJZP0pIJEZZLIcqm+v4MXzFmMJzGlRbpfUyAr6zkHlMaelJl/V
         443cOISjnX2USrZwNHlC8jgLZEioiBke1PpA62Epx5IRNMaE1heMwyqsk9sGTjkTUCV8
         zxJhtHwih9ywSz5Q47fghLFFevbcvAxYQ58d7XnX0KlL2ga21SATxepJPQFqPmmzxTLn
         jSE0n2BlW5bXqHPee687JG9DDi4yINjCEuE3onwgJQb8Urlfelh0nh0ZYWcZBnoyGeOy
         +L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782905664; x=1783510464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4faTMgKNiTFwecAROGzTjTqdDKLQ5/Ado1VdunwSeFg=;
        b=X9DUBxhzqw5v2pWGinh+U/t0Xd7SRMO9yhmAj4vssd8KGOGPKRuqc0+x2ADh4cmUIG
         IaQvOHORww8G6PYCGG/i/Ua42/ubkZm0sW1hJjuB9FM8pLcUkbmsUmfxKt8x9toR8ctq
         dnEAluTrj/lHPyw8kLW5LiIHiRR/JwJKtz2H6r/d6O8gkbWdemGCxtE5Cix+xMPKFCm+
         tlHDQiNob9o4YCGL/ajY0ajfqPVY1W+YtUsOokGUgYqo8XYJzmLfff6zRLswNBDLq06O
         N0JaP635UKEN4ZP2HEw7hCePvQHpR7zElLPmAYPuiZrb6KkpQpVM8/i2BNG3WyAwCJtI
         acnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nDy/orz4UoznW+OGmZrts5dnIC1p1IZqlJYZzx9V9oLKnQ/2B7KMXuK+r/NDH3c691QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4FVP6pHVN96MNac4hX+ncdTYIKe5RD1fwPDYTmSVT3DAzqOX
	XqvoV7VQtyNP3puLBxhn2Uv3o/6vdzKr0ObEWSaZ7Bu6rIun1/bc2oN6P9I3K5OdxnV3lVWxpAj
	YWDLzDaJIkhJ9fIP4W7IHUkqL3cRkn6rdIHoZLtMxzQ==
X-Gm-Gg: AfdE7ckXkBduNeO7oGSjvUOIaD8nSDxGnALZBaE4My6jXuWf2P7llwO4S8XnaRTrP/v
	HGbxgYTa3y0dmh/4uwFNNXyvk8Clky7/Z6H5Uc6wECzlGz3T4zo/L47ghAnqltCvBbg7lSiSyrl
	ajJkaP8G1KvZWbc9dc1+EtNj895fyW/2EBDsP7tQtUF9aZVjLqyUducnlCwXG6qyfxy4xWtHK6v
	aty6HUd5dOJgz+OCroPahdtN9ZAR++l16/bFnbcWlwJ9FP8AiHZYevZzJ+U4p7NTDf+d8mLmg0=
X-Received: by 2002:a05:6830:268c:b0:7e9:eaf2:ee22 with SMTP id
 46e09a7af769-7eb4cc4c951mr544254a34.22.1782905664119; Wed, 01 Jul 2026
 04:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d6afed2c271de42efe2a3580ea30c7601cae9c0c.1782877663.git.cuiyunhui@bytedance.com>
 <bf03528b891e5f09ec46d075649474ce5f2228e80afe1d6fe5481789e9dca9d3@mail.kernel.org>
In-Reply-To: <bf03528b891e5f09ec46d075649474ce5f2228e80afe1d6fe5481789e9dca9d3@mail.kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 1 Jul 2026 19:34:12 +0800
X-Gm-Features: AVVi8CdSDzogNfvB7WcojkNKIVGKoMGTBqHUYhLn3ECuyFSx3CWlfNAiYqksifk
Message-ID: <CAEEQ3w=d_t2WDAa7Zmemm9fk-guMmwdX11wUFG2odFaCwz6y8w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 2/3] riscv: introduce percpu.h into include/asm
To: bot+bpf-ci@kernel.org
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org, 
	thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk, 
	rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com, 
	conor.dooley@microchip.com, tglx@kernel.org, debug@rivosinc.com, 
	seanwascoding@gmail.com, andybnac@gmail.com, menglong8.dong@gmail.com, 
	cyrilbur@tenstorrent.com, wangruikang@iscas.ac.cn, atishp@rivosinc.com, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	arnd@arndb.de, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, qingfang.deng@siflower.com.cn, 
	llvm@lists.linux.dev, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi bot+bpf-ci,

On Wed, Jul 1, 2026 at 1:06=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/p=
ercpu.h
> > new file mode 100644
> > index 000000000000..46f1901d3bb8
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/percpu.h
> > @@ -0,0 +1,283 @@
>
> [ ... ]
>
> > +#define PERCPU_8_16_OP(name, amo_insn, sz, sfx, val_type, new_val_expr=
, asm_op)                      \
> > +static inline void __percpu_##name##_amo_case_##sz(void *ptr, unsigned=
 long val)             \
> > +{                                                                     =
                       \
> > +     if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&                        =
                       \
> > +             riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {     =
                       \
> > +             asm volatile ("amo" #amo_insn #sfx " zero, %[val], %[ptr]=
"                      \
> > +                     : [ptr] "+A"(*(val_type *)ptr)                   =
                       \
> > +                     : [val] "r"((val_type)((new_val_expr) & PERCPU_8_=
16_GET_MASK(sz)))      \
> > +                     : "memory");                                     =
                       \
> > +     } else {                                                         =
                       \
> > +             u32 *ptr32 =3D PERCPU_8_16_GET_PTR32(ptr);               =
                         \
> > +             const unsigned long shift =3D PERCPU_8_16_GET_SHIFT(ptr);=
                         \
> > +             const u32 mask =3D PERCPU_8_16_GET_MASK(sz) << shift;    =
                         \
> > +             const val_type val_trunc =3D (val_type)((new_val_expr)   =
                         \
> > +                                        & PERCPU_8_16_GET_MASK(sz));  =
                       \
> > +             u32 retx, rc;                                            =
                       \
> > +             val_type new_val_type;                                   =
                       \
> > +                                                                      =
                       \

This does not impact functional correctness. I will rename LR/SC
fallback local variables to use consistent naming, and keep the return
helper separate since it only handles add operations for now.

> > +             asm volatile (                                           =
                       \
> > +                     "0: lr.w %0, %2\n"                               =
                       \
> > +                     "and %3, %0, %4\n"                               =
                       \
> > +                     "srl %3, %3, %5\n"                               =
                       \
> > +                     #asm_op " %3, %3, %6\n"                          =
                       \
> > +                     "and %3, %3, %8\n"                               =
               \
> > +                     "sll %3, %3, %5\n"                               =
                       \
> > +                     "and %1, %0, %7\n"                               =
                       \
> > +                     "or %1, %1, %3\n"                                =
                       \
> > +                     "sc.w %1, %1, %2\n"                              =
                       \
> > +                     "bnez %1, 0b\n"                                  =
                       \
> > +                     : "=3D&r"(retx), "=3D&r"(rc), "+A"(*ptr32), "=3D&=
r"(new_val_type)             \
> > +                     : "r"(mask), "r"(shift), "r"(val_trunc), "r"(~mas=
k),                    \
> > +                       "r"(PERCPU_8_16_GET_MASK(sz))                  =
                       \
> > +                     : "memory");                                     =
                       \
> > +             }                                                        =
                       \
> > +}
>
> [ ... ]
>
> > +#define PERCPU_8_16_RET_OP(name, amo_insn, sz, sfx, val_type, new_val_=
expr)                  \
> > +static inline val_type __percpu_##name##_return_amo_case_##sz(void *pt=
r, unsigned long val)  \
> > +{                                                                     =
                       \
> > +     if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&                        =
                       \
> > +             riscv_has_extension_unlikely(RISCV_ISA_EXT_ZABHA)) {     =
                       \
> > +             register val_type ret;                                   =
                       \
> > +             asm volatile ("amo" #amo_insn #sfx " %[ret], %[val], %[pt=
r]"                    \
> > +                     : [ptr] "+A"(*(val_type *)ptr), [ret] "=3Dr"(ret)=
                         \
> > +                     : [val] "r"((val_type)((new_val_expr) & PERCPU_8_=
16_GET_MASK(sz)))      \
> > +                     : "memory");                                     =
                       \
> > +             return ret + (val_type)((new_val_expr) & PERCPU_8_16_GET_=
MASK(sz));             \
> > +     } else {                                                         =
                       \
> > +             u32 *ptr32 =3D PERCPU_8_16_GET_PTR32(ptr);               =
                         \
> > +             const unsigned long shift =3D PERCPU_8_16_GET_SHIFT(ptr);=
                         \
> > +             const u32 mask =3D (PERCPU_8_16_GET_MASK(sz) << shift);  =
                         \
> > +             const u32 inv_mask =3D ~mask;                            =
                         \
> > +             const val_type val_trunc =3D (val_type)((new_val_expr)   =
                         \
> > +                                        & PERCPU_8_16_GET_MASK(sz));  =
                       \
> > +             u32 old, new, tmp;                                       =
                       \
>
> This isn't a bug, but the two LR/SC fallback loops name the same roles
> differently.  The non-return loop uses:
>
>         u32 retx, rc;
>         val_type new_val_type;
>
> while the return loop above uses:
>
>         u32 old, new, tmp;
>
> The loaded word, the scratch/merge register and the computed field play t=
he
> same role in both loops.  Could they use one consistent set of names (e.g=
.
> old/new/tmp) so the two loops read as clearly parallel?  As a smaller poi=
nt,
> new_val_type reads like a type name rather than a value, and new shadows =
a
> common keyword.
>
> > +                                                                      =
                       \
> > +             asm volatile (                                           =
                       \
> > +                     "0: lr.w %0, %3\n"                               =
                       \
> > +                     "and %1, %0, %4\n"                               =
                       \
> > +                     "srl %1, %1, %5\n"                               =
                       \
> > +                     "add %1, %1, %6\n"                               =
                       \
> > +                     "and %1, %1, %7\n"                               =
                       \
> > +                     "sll %1, %1, %5\n"                               =
                       \
> > +                     "and %2, %0, %8\n"                               =
                       \
> > +                     "or %2, %2, %1\n"                                =
                       \
> > +                     "sc.w %2, %2, %3\n"                              =
                       \
> > +                     "bnez %2, 0b\n"                                  =
                       \
>
> This isn't a bug, but the read-modify-write LR/SC sequence here is nearly
> identical to the one in PERCPU_8_16_OP, differing only in operand numberi=
ng.
> The non-return loop parameterises the operation via #asm_op, but this loo=
p
> hardcodes add:
>
>         "add %1, %1, %6\n"
>
> Was the intent to keep the return path add-only, or could the two loops s=
hare
> one templated sequence?
>
> > +                     : "=3D&r"(old), "=3D&r"(tmp), "=3D&r"(new), "+A"(=
*ptr32)                      \
> > +                     : "r"(mask), "r"(shift), "r"(val_trunc), "r"(PERC=
PU_8_16_GET_MASK(sz)), \
> > +                     "r"(inv_mask)                                    =
                       \
> > +                     : "memory");                                     =
                       \
> > +             return (val_type)(tmp >> shift);                         =
                       \
> > +     }                                                                =
                       \
> > +}
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/284940=
34360

Thanks,
Yunhui
