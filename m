Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08A2517A5
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913592; cv=pass; b=jWvdZhq/33juFFcLgNxvJ4hoFEJoGiuYcAwywDJ/jt+l0SZmwdP5itA/eEcKUzs05XQi3EDDJ/TfjinbtwvYKm+tAm9OpSU2TV7PIjti89SNF9QbPBys6gjsvxH41zp/V6oBvXM+2pYz/xBbyTskoMv9GT3/pAKSuPmwsmJJOU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913592; c=relaxed/simple;
	bh=Ygpn0hK1smQWcR0LYsrbFcRF2NaJlsQXSFnetNp/AFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ln2eZ6fsyJF76GyyyO9VQxbN6uVGDT4hfpo9wbvu8qV/r4JsVui3qp3Jz8aSQZ5cM5D3LvTFojLlKjgcOj+hloABxACAk07FWX+US5AG5kayaKy2r8Jd5OM/vQQuBT8hpzIUl2pDonvpfzP5S3HQgR0B5TXFMnmh4S4S/65g410=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WGVKQ9lK; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WGVKQ9lK"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-495ecb0de70so514411b6e.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 06:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782913589; cv=none;
        d=google.com; s=arc-20260327;
        b=He1OMJg7JhqDAdZUAFa1auEh1DXnfeZUUdHe2pOWyokA/7TtChIk33A+OKPEXaW8Vm
         Uj5dHeKjTEsvohy9UGNBLpGAaKg2FVZkforJaHxoDx7tc6XnT2oOzxo2ffoaAmwb19cQ
         t8aTQP9B0zp69T13F/3csvq7i50IiMR52fck30bkI0o+CW1z/vZIUjIqKOMLALSWQAaC
         bOtCWp1Vxo3bxIfb1r+1k5dRwbJLR/a/iYI11CLWmmFqKe4hyp9BWb702pheU1HBXhOv
         Q0O0oIP2pQw1ICdV5HimM0iJy3N+i7TkuxgyPs6lRwoqm7iyD007AnjVkv2Vz3DrPEYW
         /znw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6n0sBFaOXUEf6Jh9qw+qogE2tc0XtPoPSK5HD/x03Dg=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=R3YxM3kuL9YmlZiEDHDq3UoEXSJDPDpvjEHmHYT0H5ZjMX52DiNnw2seIx3AIEnrpX
         GCgIkUSDnT26jryij/CPgQNtGgMnN5mVLDVkGHuXQaa84VNY3si0uoTsS4Qif7duKOAK
         nTYRzKmm9zWjA2Wk3tGTL0o6flkZysawwvVvfyEi6gmIqiIuDmK5CT+4WzayVMVgImKS
         osAT88R6YNrHuFTbEe1fXJa+67NihC3xGYQHqhlnYOI5lKZ+J4uSl28ih94toYAFazxR
         iVxgmXeJRyl+AIi3W3NOQ9WBqfibA5wdn+YvsNuKRm1H2A5XDUZ2TvkxstrrDwxKNunT
         sRdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782913589; x=1783518389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n0sBFaOXUEf6Jh9qw+qogE2tc0XtPoPSK5HD/x03Dg=;
        b=WGVKQ9lK7rfyni1J5f8eTVhGJl3ZKXQ6fQUoM16CLBhzwN2DEeATHB0ZRbyekgZCTL
         NgdDTlH1k5xplg7KU3grcOf4zYq/2hriCfHoZkPBLLfcBOAmKAkVO2ZDL9OA+agRytAI
         mw4OVCEzXcGg2BMz2/3JLlDsJKAzEqBuS6wuMzd7HRxn1J8NMKppe5l3GUtXTMBv03V2
         faj0pdYbgoS1y+ACQcQeHlkiK26XHNH3yDCJ6JmJOkkmXAyB9QT3AQ9MMrGCzr7TRSk9
         9xm1nXRqGObvLQ3P2EA5opWCEO0zShwjoUlm8gTZ+EI7BD/XX16IiFS5uR+SXRdT0LeQ
         jExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782913589; x=1783518389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6n0sBFaOXUEf6Jh9qw+qogE2tc0XtPoPSK5HD/x03Dg=;
        b=rgK7kOw0fY7D9NaWhNTAYyswAyoDVT1zWJkHUJ4WTkTtXAqyJC65HvPiMyBG3dmd0o
         5b4qN7vogitrOKNFO0nVXO+G3xNa3AKAepzDuvKuLtHgALK5blDbrBk+RRdXB+N5Z3mL
         r2uL/tjceGkGy4oubw8WZYZgXb7BsJlNX9Nxqeb8dRCz6tbr3Vw2Oj15v8xeXGHI14xy
         v4yCnJaLtF9vXbvtkm8xvQMfHeXlv+fzB6wyp7iekBv3g5FaE3PARehnwCeXgLe6jRhE
         6t30c45SkLPZCfaZZU9mhIYECFzMwQDgUURlED7o58IQSEJ2PsxboanmXLXbjyrjeuqU
         yriA==
X-Gm-Message-State: AOJu0Yy7dXqKjDD8nZg83yjx4FOxe15C9UdyAXQgve95mJw147kcELsb
	ZnAnpcwe2hbmIxb7LCkE3f0ZVnVOXYstPTFcTKIIVCY/I7w+xkTxk9hOa1R0URngNCB6ocjkkEf
	s/wAZIMemQtttqBMymZhg3qytyf6GI93yxGbgIT8yuYhLUJK91eVqdwj1JQ==
X-Gm-Gg: AfdE7cl1PE21Mr/9+N+XQQuqlabfUSsdnlpuXkGs3BJ3inMn1SwwfGeZtxNUGgtOrJZ
	ce5PYTUQc67yXpMAwoed8U4SciN5Zj28UiqMptyc8mSxadNv4/5DzYjzcFP78GyiGdJ9RF88ttT
	dsHcq5SWiPh2eJ2EwRHcd92aCd+z/kh4twm4DwjZ6eEvVJFoo8LQN3qkw3QvlNv9+kndYJTn/cO
	A+BuOgeNTN7WjnHmaeF++F8QBNCSSfs0wTJH77hcmyP7dUgd5WTYtFH7jU4EuqGCyNPw9pE4D5B
	8O0A3azsHg==
X-Received: by 2002:a05:6808:190c:b0:48c:4c00:596a with SMTP id
 5614622812f47-4962d70ee64mr384835b6e.5.1782913589182; Wed, 01 Jul 2026
 06:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701122948.57584-1-cuiyunhui@bytedance.com>
 <20260701122948.57584-3-cuiyunhui@bytedance.com> <20260701124631.32E671F000E9@smtp.kernel.org>
In-Reply-To: <20260701124631.32E671F000E9@smtp.kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 1 Jul 2026 21:46:17 +0800
X-Gm-Features: AVVi8CdQEJSpt-0JWy6AZwBd7PbD8qH7GvKvOCKZEUE_xOA1QCretpoH4h0GtzQ
Message-ID: <CAEEQ3w=OUGQg+-eXEWpY7-74Q9MN0Yd7aPXMwoa=Q6XF1K=P4Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 2/3] riscv: introduce percpu.h into include/asm
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi sashiko,

On Wed, Jul 1, 2026 at 8:46=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Inconsistent naming and semantics for 8/16-bit vs 32/64-bit 'andn=
ot' percpu operations.
> --
>
> commit 8c96e5a266e5953bcbbc15476c253fbdd307508b
> Author: Yunhui Cui <cuiyunhui@bytedance.com>
>
> riscv: introduce percpu.h into include/asm
>
> Add RISC-V specific this_cpu helpers so common percpu operations can use
> short architecture sequences instead of the generic implementation.
> Native-width operations use AMOs, while 8/16-bit operations use Zabha whe=
n
> available and a local 32-bit LR/SC fallback otherwise.
>
> > diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/p=
ercpu.h
> > new file mode 100644
> > index 0000000000000..34483253e946f
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/percpu.h
>
> [ ... ]
>
> > +#ifdef CONFIG_64BIT
> > +#define PERCPU_OP(name, amo_insn)                                    \
> > +     __PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)                    \
> > +     __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)
> > +#else
> > +#define PERCPU_OP(name, amo_insn)                                    \
> > +     __PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)
> > +#endif
> > +
> > +PERCPU_OP(add, add)
> > +PERCPU_OP(andnot, and)
>
> [Severity: Low]
> This isn't a bug, but is the naming here intentional? This defines
> __percpu_andnot_amo_case_32 and __percpu_andnot_amo_case_64, but since it
> passes the 'and' instruction and operates on the value directly, it perfo=
rms
> a standard bitwise and rather than an and-not.
>
> > +PERCPU_OP(or, or)
>
> [ ... ]
>
> > +#define PERCPU_OP_8_16(op_name, op, expr, final_op)                  \
> > +     PERCPU_8_16_OP(op_name, op, 8, .b, u8, expr, final_op);         \
> > +     PERCPU_8_16_OP(op_name, op, 16, .h, u16, expr, final_op)
> > +
> > +PERCPU_OP_8_16(add, add, val, add)
> > +PERCPU_OP_8_16(andnot, and, ~(val), and)
>
> [Severity: Low]
> Conversely, for 8-bit and 16-bit operations, the andnot operation actuall=
y
> performs an and-not by passing ~(val).
>
> > +PERCPU_OP_8_16(or, or, val, or)
>
> [ ... ]
>
> > +#define this_cpu_and_1(pcp, val)     _pcp_protect(__percpu_andnot_amo_=
case_8, pcp, ~(val))
> > +#define this_cpu_and_2(pcp, val)     _pcp_protect(__percpu_andnot_amo_=
case_16, pcp, ~(val))
> > +#define this_cpu_and_4(pcp, val)     _pcp_protect(__percpu_andnot_amo_=
case_32, pcp, val)
> > +
> > +#ifdef CONFIG_64BIT
> > +#define this_cpu_and_8(pcp, val)     _pcp_protect(__percpu_andnot_amo_=
case_64, pcp, val)
> > +#endif
>
> [Severity: Low]
> Because of the semantic difference between the underlying helpers, the 1 =
and 2
> byte wrappers pass ~(val) while the 4 and 8 byte wrappers pass val.
>
> Would it be clearer to harmonize the semantics across all sizes so the
> wrappers do not have to compensate?

I will fix this in v7 by making all this_cpu_and_*() helpers
consistently adopt plain AND semantics.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122948.57=
584-1-cuiyunhui@bytedance.com?part=3D2

Thanks,
Yunhui
