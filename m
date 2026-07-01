Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE140B373
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906919; cv=pass; b=iZbqY+QHcFrXSbTdTS009UmOF0DVcvAS7nCMqs2DCU2Y5iAL66epQNCr8+VFTQ+HIUR+A8yAvZtUGP9I9iKGC4jMfgftloKbyCnwA25iPIVQSJkOy44auYF+5/GJy00DmBkXE43ypbf0jBsuoik5t9fS3T437XeroLMjSiyL/Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906919; c=relaxed/simple;
	bh=dYoJPC7hXSm9fVbKu4PhTwv3WPvl9gDbfz5qduX7Q4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnD3FuUtgJwydjy9HsXNumXSlA+aeXCEUw4JGkseq7Tbq1xZgf5vvfzL0yHW34UGtttnjCY9sRvuwX+CQ7hLDz3x0DL6Qgrm1B56U6S6sIba7tArvzgchXqcA0ct0XWE+PIuzCcKbo9uUbiLGtnmpm+R1n/ETE3D7t2y2/qx6cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IiA+VcL3; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IiA+VcL3"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-488b3fd8d0dso236535b6e.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 04:55:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782906917; cv=none;
        d=google.com; s=arc-20260327;
        b=fd6UtWsprKtJ7ELdCs1GnZPJ9ox8iCX0dGhab3DuhBEDH7h/r23olTwR2b7nK7DZZ+
         QJrE3ONsOIlVI/L3zA5kerWVhIVIEcTPnslcwrRXpGMz4KRpsNnRvQNSYd1GykHv3N4+
         gJ1qC33H8l+zTVz6eCL5PllOI9UuFoGuaHTtpskeHcvDS1zoWgkPvbMCWI0VTlGCQB3z
         Kgv2Y3doFy4JD4NBZUULO/lL2OhCvwBrMpMAZaFYXK9Cb2nRpFGIx/VsVHrichIJAldv
         7VSd2ks3rkHo78YXVDsLfw0hbzkRNfc2BkjZzeMraNuZb4DHJdseOO1ZYf/5kx6nAVah
         zX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MAYeDwymAC7X4x23ohH+NiWECqUXh62wg52gYJBSoYo=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=p2MnALGikvbms6ycYTPmppxEEsuXlyCQJmdFyRHu9NMeGvwzvapsQvQzITkvbCWJWy
         7/yh4WcPUF9/+jhO4i/i3GwQHGs4dfg0wwp4YNAyjoLFhBkKrT1ljjjll+pKbIas0h28
         oAI7jauEbe+sG3/imWDlJHMvtS1x9cXb6uDxwn6q3R57mzTl0vSURQ67NqJZesqlnSMI
         nSGSiPr/9Jsf6iNKLfC62/b+YZgoiL6aiY4U0HGqcfgXnHJOJ+Fmzw6nrypTV4rumtWs
         Z5tv0zC01ZQSCxrk5toZaYX1drBvAn9qDTynlActRBPKPkrwMb3FCiatJubtQjGewQTr
         XVRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782906917; x=1783511717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAYeDwymAC7X4x23ohH+NiWECqUXh62wg52gYJBSoYo=;
        b=IiA+VcL3buN/m9czP6xo/Ow5nmuBKjijONO6zd2SDQWVLkU5fluhLnWFXpEjhN5gt0
         uDJ5mazfSnYw/lfukpRuBeYU9Goke4AiESWZiFBhh8Anu/zC+EYlrDba7ytK90bTpuNE
         g+1nc49K7bf9PKqeu6Kit/KnLwNISZTvr82uDiCGfVBUJ521b8qVBcEwFD7US3QsM2py
         spHLqQoFk5pSbf8MWJ4JC9Kz1pYfmrfDO9DYGQJd6x03N152UGqlW7n+HQXpctX6FyRf
         1BxZCcATX/ikiRSHxF1IxROkYqVMeYmqnKc9S/tWbdDPBPxiQJfmq54BhyTORyxUJ4Sv
         RO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906917; x=1783511717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MAYeDwymAC7X4x23ohH+NiWECqUXh62wg52gYJBSoYo=;
        b=KjfWucq7OZpiJlBuUMUoWt+cv1liZbllKXZeBIXXAvDTT64QKob74LfzLhK+St+Jbt
         y6wMdK/wW4PgAmhxoqD2Axv0UwXWfUqMe/0jRBhro2X4hb3BfRD4HUXfvK+guOz5vnmh
         WQ6DHQCeIUbzvtcjs0DAt2tkhBdG0tcMthKtJJH8p8Jta/nBEmN/oXjxME4afEnkii4m
         XuU+eAYAq9f3/OoiRpchLE1YJf4qHCX++DC9eGgJPzVIy/0ZO3gaEOjH4+gFqpNFWgJD
         8o+QZYNbLashIJ+9DIfIbi17YS+tZev1rlqJwexnLwfWxXl34WPsuFKLMxgOz22oETHZ
         WL5g==
X-Gm-Message-State: AOJu0YyNaR6IAPRxIeIwGltp0YkaK/KeIDQNvcoSHA7OaPowMGxiS7+8
	pxUAgWBW8AUB0Ns0+I8Biv32OwBFML5HeknqidUSuyegG4upFD7pwZkvCpYpvfL2y588bXb4rY3
	ZRZ6JHXsqS4b3JFHh8lYnn0Bac7Rz9ckdWMmNYFVZfmTYY3dnOR89+sZPqQ==
X-Gm-Gg: AfdE7cl6qiSBR8+Sma7JowcK00fiSRAMjRo3RlkSwR3rY0xx+r/4U35p2GcNXfirqjv
	D0sNPjL6UPO7DxwZJFEh/ssGvCdbzwgE7el4XtAkQklJ5tINXfu88ZjuL+RDRIw9OQoFDwykcZ3
	Sh4fcDLC0sCPJX6OyeehpnsgwezWBZZy/UuZT3heE7qcrTySd8utJFW9A/YxgLUxt3LQovgroxE
	qdjOpAi4VO1BspK+b2y3FzxtGrmIa5loDztMoyIZnXR5uvQbm7d2qjhNQXTelX+XlmWESRSLREz
	yVhtUID1UQ==
X-Received: by 2002:a05:6808:1390:b0:489:6c24:9d26 with SMTP id
 5614622812f47-4960efea9c7mr617068b6e.27.1782906916701; Wed, 01 Jul 2026
 04:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782877663.git.cuiyunhui@bytedance.com> <d6afed2c271de42efe2a3580ea30c7601cae9c0c.1782877663.git.cuiyunhui@bytedance.com>
 <20260701043814.0FEB81F000E9@smtp.kernel.org>
In-Reply-To: <20260701043814.0FEB81F000E9@smtp.kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 1 Jul 2026 19:55:04 +0800
X-Gm-Features: AVVi8CfLLTuKZzTE6HiqHPSHlVJOiUgvKHk-2H8WqqXcAJ8qtR4JfhzgBPojFdw
Message-ID: <CAEEQ3wkwP+y6eFTO+KL3SbZq=S6e0AZZB5GuAFO+4AmyoCfJRQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 2/3] riscv: introduce percpu.h into include/asm
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi sashiko,

On Wed, Jul 1, 2026 at 12:38=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Missing `<asm/cmpxchg.h>` silently drops NMI-safe ZACAS optimiza=
tion and causes arbitrary compile errors.
> --
>
> commit 81a0db6d3f915424f8959abac9007e01a81b105c
> Author: Yunhui Cui <cuiyunhui@bytedance.com>
>
> riscv: introduce percpu.h into include/asm
>
> This commit adds RISC-V specific this_cpu helpers for percpu operations.
> It uses AMOs for native-width operations, and Zabha or local 32-bit LR/SC
> fallbacks for 8/16-bit operations.
>
> > diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/p=
ercpu.h
> > new file mode 100644
> > index 0000000000000..46f1901d3bb88
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/percpu.h
>
> [ ... ]
>
> > +#define this_cpu_xchg_1(pcp, val)    _pcp_protect_return(xchg_relaxed,=
 pcp, val)
> > +#define this_cpu_xchg_2(pcp, val)    _pcp_protect_return(xchg_relaxed,=
 pcp, val)
> > +#define this_cpu_xchg_4(pcp, val)    _pcp_protect_return(xchg_relaxed,=
 pcp, val)
> > +
> > +#ifdef CONFIG_64BIT
> > +#define this_cpu_xchg_8(pcp, val)    _pcp_protect_return(xchg_relaxed,=
 pcp, val)
> > +#endif
> > +
> > +#define this_cpu_cmpxchg_1(pcp, o, n)        _pcp_protect_return(cmpxc=
hg_relaxed, pcp, o, n)
> > +#define this_cpu_cmpxchg_2(pcp, o, n)        _pcp_protect_return(cmpxc=
hg_relaxed, pcp, o, n)
> > +#define this_cpu_cmpxchg_4(pcp, o, n)        _pcp_protect_return(cmpxc=
hg_relaxed, pcp, o, n)
>
> [Severity: High]
> Does this missing <asm/cmpxchg.h> include lead to build failures?
>
> Since these macros rely on cmpxchg_relaxed, if callers expand them withou=
t
> manually including the atomic headers, it looks like cmpxchg_relaxed will
> be undefined.
>
> > +
> > +#ifdef CONFIG_64BIT
> > +#define this_cpu_cmpxchg_8(pcp, o, n)        _pcp_protect_return(cmpxc=
hg_relaxed, pcp, o, n)
> > +
> > +#define this_cpu_cmpxchg64(pcp, o, n)        this_cpu_cmpxchg_8(pcp, o=
, n)
> > +#endif
> > +
> > +#ifdef system_has_cmpxchg128
>
> [Severity: High]
> Will this macro evaluate to false and silently drop the NMI-safe ZACAS
> optimization?
>
> Because <asm/cmpxchg.h> is not included, if a file includes <asm/percpu.h=
>
> first (for example via <linux/spinlock.h> and <linux/irqflags.h>),
> system_has_cmpxchg128 is not defined here.
>
> Does this cause the kernel to silently fall back to
> this_cpu_generic_cmpxchg?
>
> Since the generic fallback only disables interrupts and does not block NM=
Is,
> could this introduce a data corruption race condition if a percpu variabl=
e
> is updated concurrently from both NMI and normal contexts?

I will add <asm/cmpxchg.h> to asm/percpu.h to make cmpxchg helpers and
system_has_cmpxchg128 available directly within this header.

>
> > +#define this_cpu_cmpxchg128(pcp, o, n)                                =
       \
> > +({                                                                   \
> > +     u128 ret__;                                                     \
> > +     typeof(pcp) *ptr__;                                             \
> > +                                                                     \
> > +     preempt_disable_notrace();                                      \
> > +     ptr__ =3D raw_cpu_ptr(&(pcp));                                   =
 \
> > +     if (system_has_cmpxchg128())                                    \
> > +             ret__ =3D cmpxchg128_local(ptr__, (o), (n));             =
 \
> > +     else                                                            \
> > +             ret__ =3D this_cpu_generic_cmpxchg(pcp, (o), (n));       =
 \
> > +     preempt_enable_notrace();                                       \
> > +     ret__;                                                          \
> > +})
> > +#endif
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782877663.=
git.cuiyunhui@bytedance.com?part=3D2

Thanks,
Yunhui
