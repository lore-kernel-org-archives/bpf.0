Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793170529;
	b=BeH+Ue9MaSUjakeDlRVHqvZkllNl+MHlRV/9LKp0hzjoaoBwxU/fb71ZookfIa1jY1Hl
	 8Qr6A2ljGrG31/fqp2J/KwwnBLfoqCD3g/Rxt7zNDiVGAvgI63WYnsviT+KVtxsHNUCza
	 Y7ZRoTVdc7SK388Rasz9baOS7GTYOxokuoMS1QWSFEmAvhB34ijrI4fNveZpeacXVDd0M
	 TZYY5v55hnO37MAK98nrc0LcHLcVRAjSCVdzSxHj/S3TrgoZALpbXefbd84HuBTSS/qTV
	 5cA5+N282WgsanlOp1AfU4MEG1jugix4oKuZIvgppCs4Uo54S4ugwDsv7yzfYFJcR0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793170529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9Z+wpMPrDUXDCIRpdcyS4APCvIJAYsI33PKpa1Poqmk=;
	b=aAOFeqm4rW+G74VwfZoChDwFBXX3NPc+XCp6PYhM/RZI479vpxc5Kbhjf/zAuPLhui9k
	 QbwsebNelfmdkAd9H+zBYWVjJRn8QQQKTZetHOUCXCHR+Gq4n3iyoDkNf4tnVVnRxZ7LL
	 3QrbtgALyv1ncKgV4Z6ejua0SIwpYce3Ija+NP3Y1lzS/50HUA95Pt3L+NeGer6XefBlN
	 IvVr57DKceiO8Hv4LBcsDfi72H04leqdgT17ye8idwdcGeDr56NhOXqETJ6Tznw6md5JY
	 p4kIP+QA/tCJxBFMROKZ/RqTdYnAWgS50CCLu8wSB6vvOVRSOATHZGVWo0hgKXVZ+9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u87OFjpJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4847B606A31D
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 06:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4847B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u87OFjpJ
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4911df1e196so365660fac.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 23:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793170527; cv=none;
        d=google.com; s=arc-20260327;
        b=joRaq7GcY8bk7dp5S2T47KfFuq/iekEmPBS+bYZB1mYcX7oL7KIIjXi/oFPvqSbtKk
         bVYdboCUUXo5CVihmJw+m0iQ16hL+wjrV/QX9PJ3etrfKeMqt43YLyC9Jln1AfAmr/6m
         4dbwrc6LFkkORrTijQb3XzUi/tNoEWwZ2Hf4ATGfweWKvk0y/ZkzZGcbZCkbRzvHnStE
         K3Mut1DYz+3VYQHXGprarz6ugKEsX4TCBIYmBnNW+8Pfvd9MdY0TAbblmFbYFmtjRIn9
         2d+8IyXmh5/4GDQYN6hG/0EpH5krCvXJSbQBIYUnI+pQY2IZEegHRedM5mLyQ/35D3Tf
         nr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Z+wpMPrDUXDCIRpdcyS4APCvIJAYsI33PKpa1Poqmk=;
        fh=1/RRek0uSxQ+ck32sPyw1MH4MNC/kSFFqR3xyjIwmJU=;
        b=XNOBYrugZvDjsi0OIVknOmzfYAuOj7IBylKfuuBBamuTdxFSCj1Po/YfxUOv5o5R1r
         iI8OwwUXIToxXySJ34djhGENPKW12pkN+CPR3s/vcx7t3Ntp1VGtDS8jqQa+uSDv9yJS
         MdPDFqCcsf0RTqczILlZEsk2gEouFMmT4M0iRg9je64u7vY6G98+QsoihdQlcZKV7vqB
         +HndcqB0zE4k2WltBccQeNFZGf7s7F1TyUmWf/T5K7TF1cdx/r61N+jSdUQERz1sL5SQ
         rsN9GN/AQB9tLzZ9mUxysYjcd7kHQEjEVQc45owWS44QwvvyYaDJWQ9iVK1NWty7/Wqn
         DOew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793170527; x=1793775327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Z+wpMPrDUXDCIRpdcyS4APCvIJAYsI33PKpa1Poqmk=;
        b=u87OFjpJW6rGWCT+W0hB11VoWaPc0gJL5i80POVe4s4mzVhVxAbAPCzIT1ONcIv0Y7
         JpN1RFbgV2VN6W89B51zJTycf7mhIxzzNQduQFjF7AYzryHu+soXp3Z3jzy3p89rZ4jE
         PwSG/aVJ5p/9bo2kSeIfn0ZxChKzkE+MigSH79UqxHFjq/QE8v5SSMQl7QzKCmA/xgED
         3E98ftKbqJWm9XiToYHPv2F5KnrQJa3S71Q8to7GCeSEh4ClCmKuFqzryQSFyvUNxcII
         5JCgpuP+rnBJeA/qBbnUvovGOwLDkIKMh3cVOujwJt1+2GgaFRbF5ipXJfUpOZpt2hj0
         fWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793170527; x=1793775327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Z+wpMPrDUXDCIRpdcyS4APCvIJAYsI33PKpa1Poqmk=;
        b=d4E4ZeEQM59xSPFI41NO8ahyD+uuY4eTfpEGk13/vKcLMegq5pp5uiLIsQtdDcB/N1
         JmIxpjvBYkyYNXjrBm07NSOA0vlZBSeXmf+l5TcisQ104OAh80RF0PmK8FXo+UEh9xnn
         z/g0OG9Okzaw6Zwg14M/XtOPokQ4dI5tT9Wloc6sAkm5Jp4Ud4S7bdqixlfuIPiMnRZc
         VzGSXrhCO0CZ2rf3/hWxowqFrjDJwRl4NOV5yziYkSCOL7nF3a+GUmGSbshN30WJ9li8
         ExcDKew266u7ziwztkIo3AU+gIdZfcOHimPbpKDnczDW0sXgGrvcu8h1RyeC9NPHllq+
         z2pA==
X-Forwarded-Encrypted: i=1; AKwUvBxbeZfj5t6Cv7l46v1lh+HOQnYvPptIRMzsda6a+TMy+pdcBBycCBVC6qz1rUXQP74Z6GQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYILcwP1WWPQ1z7FWkbQSjikXfHg5ETqK91XGdh/vVHfs/ETiujP
	WTp9eYaAau48lcwAsW4BFy+zfOw2VvMpio1xXEB1xuyYPldShlDQDk/J33B8bfmqdGFFjfkddZn
	vYV1lhlN5+E+jqnZPP6QZ2WbUkgWXRDkvFMimGZ8=
X-Gm-Gg: AYBFou006CwpcuHwqUw+9po8VmLRO3Bp34xlPXIIZZq0Ikfn4nq7Y9fC8sgGmqwXn6U
	P6Pb8nz04HnsIkSd7ecsJZ1yYfrW1l/p+Yh1QJW3OHZQOWCivIfexvnLjuTY9lSi8r2UnzU1Qmp
	3zRMNXWf/tD2da/r0aRqG5QjKEESSqz/o7YktcnNVAHkm6WDq3dzi+HwrF6RXyOqna6y1QpkJha
	qNQC09bieoFSiTSIaZ3PnmhGQWRuvTX5hRshToRUkclLD//M0G0JaYe92HJLg8KBXB2EmxAR2CK
	mRtlX61ypJmURqQMNkTZB9Juh2g7lSp9tftBYvEwsHAJclZ6sKSDuia1CqW6212Nk4TCFbMflwJ
	trQeFcJDCd1fUC8dN/DkkkSD5KRXw7CMmDNg6Fg==
X-Received: by 2002:a05:6871:e805:b0:47a:c7e7:51b9 with SMTP id
 586e51a60fabf-4a8bb33f85bmr1191110fac.0.1793170526731; Tue, 27 Oct 2026
 23:55:26 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016081006.26069-1-yangtiezhu@loongson.cn>
 <20261016081006.26069-4-yangtiezhu@loongson.cn> <CAAhV-H4h1GQ7kvrYW2z2iVnEgZzeVsf=FY+qdNq9DDLDdkE_UA@mail.gmail.com>
In-Reply-To: <CAAhV-H4h1GQ7kvrYW2z2iVnEgZzeVsf=FY+qdNq9DDLDdkE_UA@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 28 Oct 2026 14:55:13 +0800
X-Gm-Features: AclHuK8LTZMGWBKMYHbQHb7Hl7DVSJkiNQ1S30IN50EuBvthDR9aR91i1Rr1oUo
Message-ID: <CAEyhmHS=tf8rxh9OjV+J-4uLVgBy0k15bF-DKEjeMLSvG0LDyA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] LoongArch: BPF: Optimize 32-bit operations using
 native instructions
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 12:19=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Hengqi,
>
> On Fri, Oct 16, 2026 at 4:10=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.=
cn> wrote:
> >
> > Currently, the LoongArch BPF JIT emits numerous redundant zero and sign
> > extensions across 32-bit operations, bloating the final JIT image size
> > and also leading to runtime overhead, particularly in the division and
> > modulo operations. Thus, it is necessary to optimize 32-bit operations
> > by emitting LoongArch native 32-bit word instructions.
> >
> > For general ALU32 operations, utilize native 32-bit word instructions
> > for core calculations. Given that the BPF spec requires the upper 32
> > bits of the destination register to be zero-extended upon completion,
> > use a unified 'bstrpickd' instruction to clear the upper 32 bits at
> > the common exit of build_insn(), while immediate loads are optimized
> > via (u32) casting to bypass the trailing extension.
> >
> > According to the LoongArch Reference Manual, native 32-bit division
> > and modulo instructions (DIV.W[U] and MOD.W[U]) require the upper
> > bits [63:31] of both input operands to be all 0s or all 1s (0x0 or
> > 0x1ffffffff), that is to say, they need to be properly sign-extended
> > by the software on CPU cores without the DIV32 feature. Otherwise,
> > the 32-bit division and modulo instructions could trigger undefined
> > hardware behaviors and return unexpected values.
> >
> > To ensure both performance and hardware compatibility, leverage the
> > newly introduced cpu_has_div32 helper:
> > (1) on newer CPUs with DIV32, emit native 32-bit div/mod instructions
> > directly for optimal performance;
> > (2) on older CPUs without DIV32, sign-extend the destination register
> > in place and the source register into a temporary register via 'addw'
> > before executing the native 32-bit div/mod instructions. Note that the
> > JIT compiler must never alter the state of the src register because it
> > remains read-only for the duration of the instruction.
> >
> > For JMP32 conditional branches, the source operands may originate from
> > 64-bit contexts where the upper 32 bits contain arbitrary data, so use
> > 6 independent case structures to prevent 64-bit comparison inversions.
> > Furthermore, use 'bstrpickd' to mask out upper bits for unsigned JMP32,
> > and 'addw' with GPR_ZERO to re-align sign bits for signed JMP32.
> >
> > With this patch, the emit_{zext, sext}_32() and is_signed_bpf_cond()
> > helpers are completely wiped out from the header and source files,
> > delivering a native execution stream with a reduced JIT image size,
> > especially for division and mod operations.
> >
> > All of the testcases of test_bpf passed on Loongson-3A6000 (with DIV32)
> > and Loongson-3A5000 (without DIV32), here are the test results:
> >
> > $ sudo modprobe test_bpf
> > $ dmesg -t | grep Summary
> > test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
> > test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
> > test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
> >
> > For the BPF selftests test_verifier and test_progs, there are no any
> > regressions.
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  arch/loongarch/include/asm/inst.h |   6 +
> >  arch/loongarch/net/bpf_jit.c      | 313 +++++++++++++++++-------------
> >  arch/loongarch/net/bpf_jit.h      |  18 --
> >  3 files changed, 183 insertions(+), 154 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include=
/asm/inst.h
> > index 585667e361c2..b55aae325300 100644
> > --- a/arch/loongarch/include/asm/inst.h
> > +++ b/arch/loongarch/include/asm/inst.h
> > @@ -752,11 +752,17 @@ static inline void emit_##NAME(union loongarch_in=
struction *insn, \
> >
> >  DEF_EMIT_REG3_FORMAT(addw, addw_op)
> >  DEF_EMIT_REG3_FORMAT(addd, addd_op)
> > +DEF_EMIT_REG3_FORMAT(subw, subw_op)
> >  DEF_EMIT_REG3_FORMAT(subd, subd_op)
> > +DEF_EMIT_REG3_FORMAT(mulw, mulw_op)
> >  DEF_EMIT_REG3_FORMAT(muld, muld_op)
> > +DEF_EMIT_REG3_FORMAT(divw, divw_op)
> >  DEF_EMIT_REG3_FORMAT(divd, divd_op)
> > +DEF_EMIT_REG3_FORMAT(modw, modw_op)
> >  DEF_EMIT_REG3_FORMAT(modd, modd_op)
> > +DEF_EMIT_REG3_FORMAT(divwu, divwu_op)
> >  DEF_EMIT_REG3_FORMAT(divdu, divdu_op)
> > +DEF_EMIT_REG3_FORMAT(modwu, modwu_op)
> >  DEF_EMIT_REG3_FORMAT(moddu, moddu_op)
> >  DEF_EMIT_REG3_FORMAT(maskeqz, maskeqz_op)
> >  DEF_EMIT_REG3_FORMAT(masknez, masknez_op)
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index 77cd96a6f84c..1a7c8effc37b 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -288,7 +288,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, =
int insn)
> >          * if (index >=3D array->map.max_entries)
> >          *       goto out;
> >          */
> > -       emit_zext_32(ctx, a2, true);
> > +       emit_insn(ctx, bstrpickd, a2, a2, 31, 0);
> >
> >         off =3D offsetof(struct bpf_array, map.max_entries);
> >         emit_insn(ctx, ldwu, t1, a1, off);
> > @@ -412,7 +412,6 @@ static int emit_atomic_rmw(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
> >                                 return -EINVAL;
> >                         }
> >                         emit_insn(ctx, amadddbb, src, t1, t3);
> > -                       emit_zext_32(ctx, src, true);
> >                         break;
> >                 case BPF_H:
> >                         if (!cpu_has_lam_bh) {
> > @@ -420,23 +419,23 @@ static int emit_atomic_rmw(const struct bpf_insn =
*insn, struct jit_ctx *ctx)
> >                                 return -EINVAL;
> >                         }
> >                         emit_insn(ctx, amadddbh, src, t1, t3);
> > -                       emit_zext_32(ctx, src, true);
> >                         break;
> >                 case BPF_W:
> >                         emit_insn(ctx, amadddbw, src, t1, t3);
> > -                       emit_zext_32(ctx, src, true);
> >                         break;
> >                 case BPF_DW:
> >                         emit_insn(ctx, amadddbd, src, t1, t3);
> >                         break;
> >                 }
> > +               if (!isdw)
> > +                       emit_insn(ctx, bstrpickd, src, src, 31, 0);
> >                 break;
> >         case BPF_AND | BPF_FETCH:
> >                 if (isdw) {
> >                         emit_insn(ctx, amanddbd, src, t1, t3);
> >                 } else {
> >                         emit_insn(ctx, amanddbw, src, t1, t3);
> > -                       emit_zext_32(ctx, src, true);
> > +                       emit_insn(ctx, bstrpickd, src, src, 31, 0);
> >                 }
> >                 break;
> >         case BPF_OR | BPF_FETCH:
> > @@ -444,7 +443,7 @@ static int emit_atomic_rmw(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
> >                         emit_insn(ctx, amordbd, src, t1, t3);
> >                 } else {
> >                         emit_insn(ctx, amordbw, src, t1, t3);
> > -                       emit_zext_32(ctx, src, true);
> > +                       emit_insn(ctx, bstrpickd, src, src, 31, 0);
> >                 }
> >                 break;
> >         case BPF_XOR | BPF_FETCH:
> > @@ -452,7 +451,7 @@ static int emit_atomic_rmw(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
> >                         emit_insn(ctx, amxordbd, src, t1, t3);
> >                 } else {
> >                         emit_insn(ctx, amxordbw, src, t1, t3);
> > -                       emit_zext_32(ctx, src, true);
> > +                       emit_insn(ctx, bstrpickd, src, src, 31, 0);
> >                 }
> >                 break;
> >         /* src =3D atomic_xchg(dst + off, src); */
> > @@ -464,7 +463,6 @@ static int emit_atomic_rmw(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx)
> >                                 return -EINVAL;
> >                         }
> >                         emit_insn(ctx, amswapdbb, src, t1, t3);
> > -                       emit_zext_32(ctx, src, true);
> >                         break;
> >                 case BPF_H:
> >                         if (!cpu_has_lam_bh) {
> > @@ -472,16 +470,16 @@ static int emit_atomic_rmw(const struct bpf_insn =
*insn, struct jit_ctx *ctx)
> >                                 return -EINVAL;
> >                         }
> >                         emit_insn(ctx, amswapdbh, src, t1, t3);
> > -                       emit_zext_32(ctx, src, true);
> >                         break;
> >                 case BPF_W:
> >                         emit_insn(ctx, amswapdbw, src, t1, t3);
> > -                       emit_zext_32(ctx, src, true);
> >                         break;
> >                 case BPF_DW:
> >                         emit_insn(ctx, amswapdbd, src, t1, t3);
> >                         break;
> >                 }
> > +               if (!isdw)
> > +                       emit_insn(ctx, bstrpickd, src, src, 31, 0);
> >                 break;
> >         /* r0 =3D atomic_cmpxchg(dst + off, r0, src); */
> >         case BPF_CMPXCHG:
> > @@ -494,13 +492,13 @@ static int emit_atomic_rmw(const struct bpf_insn =
*insn, struct jit_ctx *ctx)
> >                         emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -4)=
;
> >                 } else {
> >                         emit_insn(ctx, llw, r0, t1, 0);
> > -                       emit_zext_32(ctx, t2, true);
> > -                       emit_zext_32(ctx, r0, true);
> > +                       emit_insn(ctx, bstrpickd, t2, t2, 31, 0);
> > +                       emit_insn(ctx, bstrpickd, r0, r0, 31, 0);
> >                         emit_insn(ctx, bne, t2, r0, 4);
> >                         move_reg(ctx, t3, src);
> >                         emit_insn(ctx, scw, t3, t1, 0);
> >                         emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -6)=
;
> > -                       emit_zext_32(ctx, r0, true);
> > +                       emit_insn(ctx, bstrpickd, r0, r0, 31, 0);
> >                 }
> >                 emit_insn(ctx, dbar, DBAR_LLSC_MB);
> >                 break;
> > @@ -605,12 +603,6 @@ static int emit_atomic_ld_st(const struct bpf_insn=
 *insn, struct jit_ctx *ctx)
> >         return 0;
> >  }
> >
> > -static bool is_signed_bpf_cond(u8 cond)
> > -{
> > -       return cond =3D=3D BPF_JSGT || cond =3D=3D BPF_JSLT ||
> > -              cond =3D=3D BPF_JSGE || cond =3D=3D BPF_JSLE;
> > -}
> > -
> >  #define BPF_FIXUP_REG_MASK     GENMASK(31, 27)
> >  #define BPF_FIXUP_OFFSET_MASK  GENMASK(26, 0)
> >  #define REG_DONT_CLEAR_MARKER  0
> > @@ -707,7 +699,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
> >         u8 dst =3D regmap[insn->dst_reg];
> >         const s16 off =3D insn->off;
> >         const s32 imm =3D insn->imm;
> > -       const bool is32 =3D BPF_CLASS(insn->code) =3D=3D BPF_ALU || BPF=
_CLASS(insn->code) =3D=3D BPF_JMP32;
> > +       const bool is32 =3D BPF_CLASS(insn->code) =3D=3D BPF_ALU && BPF=
_OP(insn->code) !=3D BPF_END;
> >
> >         switch (code) {
> >         /* dst =3D src */
> > @@ -715,7 +707,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
> >         case BPF_ALU64 | BPF_MOV | BPF_X:
> >                 if (insn_is_cast_user(insn)) {
> >                         move_reg(ctx, t1, src);
> > -                       emit_zext_32(ctx, t1, true);
> > +                       emit_insn(ctx, bstrpickd, t1, t1, 31, 0);
> >                         move_imm(ctx, dst, (ctx->user_vm_start >> 32) <=
< 32);
> >                         emit_insn(ctx, beq, t1, LOONGARCH_GPR_ZERO, 2);
> >                         emit_insn(ctx, or, t1, dst, t1);
> > @@ -734,15 +726,12 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx, bool ext
> >                 switch (off) {
> >                 case 0:
> >                         move_reg(ctx, dst, src);
> > -                       emit_zext_32(ctx, dst, is32);
> >                         break;
> >                 case 8:
> >                         emit_insn(ctx, extwb, dst, src);
> > -                       emit_zext_32(ctx, dst, is32);
> >                         break;
> >                 case 16:
> >                         emit_insn(ctx, extwh, dst, src);
> > -                       emit_zext_32(ctx, dst, is32);
> >                         break;
> >                 case 32:
> >                         emit_insn(ctx, addw, dst, src, LOONGARCH_GPR_ZE=
RO);
> > @@ -752,151 +741,188 @@ static int build_insn(const struct bpf_insn *in=
sn, struct jit_ctx *ctx, bool ext
> >
> >         /* dst =3D imm */
> >         case BPF_ALU | BPF_MOV | BPF_K:
> > +               move_imm(ctx, dst, (u32)imm);
> > +               return 0;
> >         case BPF_ALU64 | BPF_MOV | BPF_K:
> >                 move_imm(ctx, dst, imm);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> dst =3D imm is the simplest case, I think the 64bit version can also
> "return 0" here. If you agree, I will modify it when apply.
>

I am fine with the change. Cheers.

> Huacai
>
> >
> >         /* dst =3D dst + src */
> >         case BPF_ALU | BPF_ADD | BPF_X:
> > +               emit_insn(ctx, addw, dst, dst, src);
> > +               break;
> >         case BPF_ALU64 | BPF_ADD | BPF_X:
> >                 emit_insn(ctx, addd, dst, dst, src);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> >
> >         /* dst =3D dst + imm */
> >         case BPF_ALU | BPF_ADD | BPF_K:
> > +               if (is_signed_imm12(imm)) {
> > +                       emit_insn(ctx, addiw, dst, dst, imm);
> > +               } else {
> > +                       move_imm(ctx, t1, (u32)imm);
> > +                       emit_insn(ctx, addw, dst, dst, t1);
> > +               }
> > +               break;
> >         case BPF_ALU64 | BPF_ADD | BPF_K:
> >                 if (is_signed_imm12(imm)) {
> >                         emit_insn(ctx, addid, dst, dst, imm);
> >                 } else {
> >                         move_imm(ctx, t1, imm);
> > -                       emit_zext_32(ctx, t1, is32);
> >                         emit_insn(ctx, addd, dst, dst, t1);
> >                 }
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> >
> >         /* dst =3D dst - src */
> >         case BPF_ALU | BPF_SUB | BPF_X:
> > +               emit_insn(ctx, subw, dst, dst, src);
> > +               break;
> >         case BPF_ALU64 | BPF_SUB | BPF_X:
> >                 emit_insn(ctx, subd, dst, dst, src);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> >
> >         /* dst =3D dst - imm */
> >         case BPF_ALU | BPF_SUB | BPF_K:
> > +               if (is_signed_imm12(-imm)) {
> > +                       emit_insn(ctx, addiw, dst, dst, -imm);
> > +               } else {
> > +                       move_imm(ctx, t1, (u32)imm);
> > +                       emit_insn(ctx, subw, dst, dst, t1);
> > +               }
> > +               break;
> >         case BPF_ALU64 | BPF_SUB | BPF_K:
> >                 if (is_signed_imm12(-imm)) {
> >                         emit_insn(ctx, addid, dst, dst, -imm);
> >                 } else {
> >                         move_imm(ctx, t1, imm);
> > -                       emit_zext_32(ctx, t1, is32);
> >                         emit_insn(ctx, subd, dst, dst, t1);
> >                 }
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> >
> >         /* dst =3D dst * src */
> >         case BPF_ALU | BPF_MUL | BPF_X:
> > +               emit_insn(ctx, mulw, dst, dst, src);
> > +               break;
> >         case BPF_ALU64 | BPF_MUL | BPF_X:
> >                 emit_insn(ctx, muld, dst, dst, src);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> >
> >         /* dst =3D dst * imm */
> >         case BPF_ALU | BPF_MUL | BPF_K:
> > +               move_imm(ctx, t1, (u32)imm);
> > +               emit_insn(ctx, mulw, dst, dst, t1);
> > +               break;
> >         case BPF_ALU64 | BPF_MUL | BPF_K:
> >                 move_imm(ctx, t1, imm);
> > -               emit_zext_32(ctx, t1, is32);
> >                 emit_insn(ctx, muld, dst, dst, t1);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> >
> >         /* dst =3D dst / src */
> >         case BPF_ALU | BPF_DIV | BPF_X:
> > -       case BPF_ALU64 | BPF_DIV | BPF_X:
> > -               if (!off) {
> > -                       emit_zext_32(ctx, dst, is32);
> > -                       move_reg(ctx, t1, src);
> > -                       emit_zext_32(ctx, t1, is32);
> > -                       emit_insn(ctx, divdu, dst, dst, t1);
> > -                       emit_zext_32(ctx, dst, is32);
> > -               } else {
> > -                       emit_sext_32(ctx, dst, is32);
> > -                       move_reg(ctx, t1, src);
> > -                       emit_sext_32(ctx, t1, is32);
> > -                       emit_insn(ctx, divd, dst, dst, t1);
> > -                       emit_zext_32(ctx, dst, is32);
> > +               if (cpu_has_div32) {
> > +                       if (!off)
> > +                               emit_insn(ctx, divwu, dst, dst, src);
> > +                       else
> > +                               emit_insn(ctx, divw, dst, dst, src);
> > +                       break;
> >                 }
> > +               /*
> > +                * Legacy fallback for !div32: src must be extended int=
o a
> > +                * temporary register to keep the original src register=
 intact.
> > +                */
> > +               emit_insn(ctx, addw, dst, dst, LOONGARCH_GPR_ZERO);
> > +               emit_insn(ctx, addw, t1, src, LOONGARCH_GPR_ZERO);
> > +               if (!off)
> > +                       emit_insn(ctx, divwu, dst, dst, t1);
> > +               else
> > +                       emit_insn(ctx, divw, dst, dst, t1);
> > +               break;
> > +       case BPF_ALU64 | BPF_DIV | BPF_X:
> > +               if (!off)
> > +                       emit_insn(ctx, divdu, dst, dst, src);
> > +               else
> > +                       emit_insn(ctx, divd, dst, dst, src);
> >                 break;
> >
> >         /* dst =3D dst / imm */
> >         case BPF_ALU | BPF_DIV | BPF_K:
> > +               move_imm(ctx, t1, (u32)imm);
> > +               if (!cpu_has_div32) {
> > +                       emit_insn(ctx, addw, dst, dst, LOONGARCH_GPR_ZE=
RO);
> > +                       emit_insn(ctx, addw, t1, t1, LOONGARCH_GPR_ZERO=
);
> > +               }
> > +               if (!off)
> > +                       emit_insn(ctx, divwu, dst, dst, t1);
> > +               else
> > +                       emit_insn(ctx, divw, dst, dst, t1);
> > +               break;
> >         case BPF_ALU64 | BPF_DIV | BPF_K:
> > -               if (!off) {
> > -                       move_imm(ctx, t1, imm);
> > -                       emit_zext_32(ctx, t1, is32);
> > -                       emit_zext_32(ctx, dst, is32);
> > +               move_imm(ctx, t1, imm);
> > +               if (!off)
> >                         emit_insn(ctx, divdu, dst, dst, t1);
> > -                       emit_zext_32(ctx, dst, is32);
> > -               } else {
> > -                       move_imm(ctx, t1, imm);
> > -                       emit_sext_32(ctx, t1, is32);
> > -                       emit_sext_32(ctx, dst, is32);
> > +               else
> >                         emit_insn(ctx, divd, dst, dst, t1);
> > -                       emit_zext_32(ctx, dst, is32);
> > -               }
> >                 break;
> >
> >         /* dst =3D dst % src */
> >         case BPF_ALU | BPF_MOD | BPF_X:
> > -       case BPF_ALU64 | BPF_MOD | BPF_X:
> > -               if (!off) {
> > -                       emit_zext_32(ctx, dst, is32);
> > -                       move_reg(ctx, t1, src);
> > -                       emit_zext_32(ctx, t1, is32);
> > -                       emit_insn(ctx, moddu, dst, dst, t1);
> > -                       emit_zext_32(ctx, dst, is32);
> > -               } else {
> > -                       emit_sext_32(ctx, dst, is32);
> > -                       move_reg(ctx, t1, src);
> > -                       emit_sext_32(ctx, t1, is32);
> > -                       emit_insn(ctx, modd, dst, dst, t1);
> > -                       emit_zext_32(ctx, dst, is32);
> > +               if (cpu_has_div32) {
> > +                       if (!off)
> > +                               emit_insn(ctx, modwu, dst, dst, src);
> > +                       else
> > +                               emit_insn(ctx, modw, dst, dst, src);
> > +                       break;
> >                 }
> > +               /*
> > +                * Legacy fallback for !div32: src must be extended int=
o a
> > +                * temporary register to keep the original src register=
 intact.
> > +                */
> > +               emit_insn(ctx, addw, dst, dst, LOONGARCH_GPR_ZERO);
> > +               emit_insn(ctx, addw, t1, src, LOONGARCH_GPR_ZERO);
> > +               if (!off)
> > +                       emit_insn(ctx, modwu, dst, dst, t1);
> > +               else
> > +                       emit_insn(ctx, modw, dst, dst, t1);
> > +               break;
> > +       case BPF_ALU64 | BPF_MOD | BPF_X:
> > +               if (!off)
> > +                       emit_insn(ctx, moddu, dst, dst, src);
> > +               else
> > +                       emit_insn(ctx, modd, dst, dst, src);
> >                 break;
> >
> >         /* dst =3D dst % imm */
> >         case BPF_ALU | BPF_MOD | BPF_K:
> > +               move_imm(ctx, t1, (u32)imm);
> > +               if (!cpu_has_div32) {
> > +                       emit_insn(ctx, addw, dst, dst, LOONGARCH_GPR_ZE=
RO);
> > +                       emit_insn(ctx, addw, t1, t1, LOONGARCH_GPR_ZERO=
);
> > +               }
> > +               if (!off)
> > +                       emit_insn(ctx, modwu, dst, dst, t1);
> > +               else
> > +                       emit_insn(ctx, modw, dst, dst, t1);
> > +               break;
> >         case BPF_ALU64 | BPF_MOD | BPF_K:
> > -               if (!off) {
> > -                       move_imm(ctx, t1, imm);
> > -                       emit_zext_32(ctx, t1, is32);
> > -                       emit_zext_32(ctx, dst, is32);
> > +               move_imm(ctx, t1, imm);
> > +               if (!off)
> >                         emit_insn(ctx, moddu, dst, dst, t1);
> > -                       emit_zext_32(ctx, dst, is32);
> > -               } else {
> > -                       move_imm(ctx, t1, imm);
> > -                       emit_sext_32(ctx, t1, is32);
> > -                       emit_sext_32(ctx, dst, is32);
> > +               else
> >                         emit_insn(ctx, modd, dst, dst, t1);
> > -                       emit_zext_32(ctx, dst, is32);
> > -               }
> >                 break;
> >
> >         /* dst =3D -dst */
> >         case BPF_ALU | BPF_NEG:
> > +               emit_insn(ctx, subw, dst, LOONGARCH_GPR_ZERO, dst);
> > +               break;
> >         case BPF_ALU64 | BPF_NEG:
> >                 emit_insn(ctx, subd, dst, LOONGARCH_GPR_ZERO, dst);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> >
> >         /* dst =3D dst & src */
> >         case BPF_ALU | BPF_AND | BPF_X:
> >         case BPF_ALU64 | BPF_AND | BPF_X:
> >                 emit_insn(ctx, and, dst, dst, src);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> >
> >         /* dst =3D dst & imm */
> > @@ -905,18 +931,18 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx, bool ext
> >                 if (is_unsigned_imm12(imm)) {
> >                         emit_insn(ctx, andi, dst, dst, imm);
> >                 } else {
> > -                       move_imm(ctx, t1, imm);
> > -                       emit_zext_32(ctx, t1, is32);
> > +                       if (is32)
> > +                               move_imm(ctx, t1, (u32)imm);
> > +                       else
> > +                               move_imm(ctx, t1, imm);
> >                         emit_insn(ctx, and, dst, dst, t1);
> >                 }
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> >
> >         /* dst =3D dst | src */
> >         case BPF_ALU | BPF_OR | BPF_X:
> >         case BPF_ALU64 | BPF_OR | BPF_X:
> >                 emit_insn(ctx, or, dst, dst, src);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> >
> >         /* dst =3D dst | imm */
> > @@ -925,18 +951,18 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx, bool ext
> >                 if (is_unsigned_imm12(imm)) {
> >                         emit_insn(ctx, ori, dst, dst, imm);
> >                 } else {
> > -                       move_imm(ctx, t1, imm);
> > -                       emit_zext_32(ctx, t1, is32);
> > +                       if (is32)
> > +                               move_imm(ctx, t1, (u32)imm);
> > +                       else
> > +                               move_imm(ctx, t1, imm);
> >                         emit_insn(ctx, or, dst, dst, t1);
> >                 }
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> >
> >         /* dst =3D dst ^ src */
> >         case BPF_ALU | BPF_XOR | BPF_X:
> >         case BPF_ALU64 | BPF_XOR | BPF_X:
> >                 emit_insn(ctx, xor, dst, dst, src);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> >
> >         /* dst =3D dst ^ imm */
> > @@ -945,19 +971,18 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx, bool ext
> >                 if (is_unsigned_imm12(imm)) {
> >                         emit_insn(ctx, xori, dst, dst, imm);
> >                 } else {
> > -                       move_imm(ctx, t1, imm);
> > -                       emit_zext_32(ctx, t1, is32);
> > +                       if (is32)
> > +                               move_imm(ctx, t1, (u32)imm);
> > +                       else
> > +                               move_imm(ctx, t1, imm);
> >                         emit_insn(ctx, xor, dst, dst, t1);
> >                 }
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> >
> >         /* dst =3D dst << src (logical) */
> >         case BPF_ALU | BPF_LSH | BPF_X:
> >                 emit_insn(ctx, sllw, dst, dst, src);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> > -
> >         case BPF_ALU64 | BPF_LSH | BPF_X:
> >                 emit_insn(ctx, slld, dst, dst, src);
> >                 break;
> > @@ -965,9 +990,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
> >         /* dst =3D dst << imm (logical) */
> >         case BPF_ALU | BPF_LSH | BPF_K:
> >                 emit_insn(ctx, slliw, dst, dst, imm);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> > -
> >         case BPF_ALU64 | BPF_LSH | BPF_K:
> >                 emit_insn(ctx, sllid, dst, dst, imm);
> >                 break;
> > @@ -975,9 +998,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
> >         /* dst =3D dst >> src (logical) */
> >         case BPF_ALU | BPF_RSH | BPF_X:
> >                 emit_insn(ctx, srlw, dst, dst, src);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> > -
> >         case BPF_ALU64 | BPF_RSH | BPF_X:
> >                 emit_insn(ctx, srld, dst, dst, src);
> >                 break;
> > @@ -985,9 +1006,7 @@ static int build_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx, bool ext
> >         /* dst =3D dst >> imm (logical) */
> >         case BPF_ALU | BPF_RSH | BPF_K:
> >                 emit_insn(ctx, srliw, dst, dst, imm);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> > -
> >         case BPF_ALU64 | BPF_RSH | BPF_K:
> >                 emit_insn(ctx, srlid, dst, dst, imm);
> >                 break;
> > @@ -995,9 +1014,7 @@ static int build_insn(const struct bpf_insn *insn,=
 struct jit_ctx *ctx, bool ext
> >         /* dst =3D dst >> src (arithmetic) */
> >         case BPF_ALU | BPF_ARSH | BPF_X:
> >                 emit_insn(ctx, sraw, dst, dst, src);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> > -
> >         case BPF_ALU64 | BPF_ARSH | BPF_X:
> >                 emit_insn(ctx, srad, dst, dst, src);
> >                 break;
> > @@ -1005,9 +1022,7 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx, bool ext
> >         /* dst =3D dst >> imm (arithmetic) */
> >         case BPF_ALU | BPF_ARSH | BPF_K:
> >                 emit_insn(ctx, sraiw, dst, dst, imm);
> > -               emit_zext_32(ctx, dst, is32);
> >                 break;
> > -
> >         case BPF_ALU64 | BPF_ARSH | BPF_K:
> >                 emit_insn(ctx, sraid, dst, dst, imm);
> >                 break;
> > @@ -1016,12 +1031,10 @@ static int build_insn(const struct bpf_insn *in=
sn, struct jit_ctx *ctx, bool ext
> >         case BPF_ALU | BPF_END | BPF_FROM_LE:
> >                 switch (imm) {
> >                 case 16:
> > -                       /* zero-extend 16 bits into 64 bits */
> >                         emit_insn(ctx, bstrpickd, dst, dst, 15, 0);
> >                         break;
> >                 case 32:
> > -                       /* zero-extend 32 bits into 64 bits */
> > -                       emit_zext_32(ctx, dst, is32);
> > +                       emit_insn(ctx, bstrpickd, dst, dst, 31, 0);
> >                         break;
> >                 case 64:
> >                         /* do nothing */
> > @@ -1034,13 +1047,11 @@ static int build_insn(const struct bpf_insn *in=
sn, struct jit_ctx *ctx, bool ext
> >                 switch (imm) {
> >                 case 16:
> >                         emit_insn(ctx, revb2h, dst, dst);
> > -                       /* zero-extend 16 bits into 64 bits */
> >                         emit_insn(ctx, bstrpickd, dst, dst, 15, 0);
> >                         break;
> >                 case 32:
> >                         emit_insn(ctx, revb2w, dst, dst);
> > -                       /* clear the upper 32 bits */
> > -                       emit_zext_32(ctx, dst, true);
> > +                       emit_insn(ctx, bstrpickd, dst, dst, 31, 0);
> >                         break;
> >                 case 64:
> >                         emit_insn(ctx, revbd, dst, dst);
> > @@ -1048,7 +1059,7 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx, bool ext
> >                 }
> >                 break;
> >
> > -       /* PC +=3D off if dst cond src */
> > +       /* PC +=3D off if dst cond src (64-bit) */
> >         case BPF_JMP | BPF_JEQ | BPF_X:
> >         case BPF_JMP | BPF_JNE | BPF_X:
> >         case BPF_JMP | BPF_JGT | BPF_X:
> > @@ -1059,31 +1070,38 @@ static int build_insn(const struct bpf_insn *in=
sn, struct jit_ctx *ctx, bool ext
> >         case BPF_JMP | BPF_JSGE | BPF_X:
> >         case BPF_JMP | BPF_JSLT | BPF_X:
> >         case BPF_JMP | BPF_JSLE | BPF_X:
> > +               jmp_offset =3D bpf2la_offset(i, off, ctx);
> > +               if (emit_cond_jmp(ctx, cond, dst, src, jmp_offset) < 0)
> > +                       goto toofar;
> > +               break;
> > +
> > +       /* PC +=3D off if dst cond src (32-bit unsigned) */
> >         case BPF_JMP32 | BPF_JEQ | BPF_X:
> >         case BPF_JMP32 | BPF_JNE | BPF_X:
> >         case BPF_JMP32 | BPF_JGT | BPF_X:
> >         case BPF_JMP32 | BPF_JGE | BPF_X:
> >         case BPF_JMP32 | BPF_JLT | BPF_X:
> >         case BPF_JMP32 | BPF_JLE | BPF_X:
> > +               jmp_offset =3D bpf2la_offset(i, off, ctx);
> > +               emit_insn(ctx, bstrpickd, t1, dst, 31, 0);
> > +               emit_insn(ctx, bstrpickd, t2, src, 31, 0);
> > +               if (emit_cond_jmp(ctx, cond, t1, t2, jmp_offset) < 0)
> > +                       goto toofar;
> > +               break;
> > +
> > +       /* PC +=3D off if dst cond src (32-bit signed) */
> >         case BPF_JMP32 | BPF_JSGT | BPF_X:
> >         case BPF_JMP32 | BPF_JSGE | BPF_X:
> >         case BPF_JMP32 | BPF_JSLT | BPF_X:
> >         case BPF_JMP32 | BPF_JSLE | BPF_X:
> >                 jmp_offset =3D bpf2la_offset(i, off, ctx);
> > -               move_reg(ctx, t1, dst);
> > -               move_reg(ctx, t2, src);
> > -               if (is_signed_bpf_cond(BPF_OP(code))) {
> > -                       emit_sext_32(ctx, t1, is32);
> > -                       emit_sext_32(ctx, t2, is32);
> > -               } else {
> > -                       emit_zext_32(ctx, t1, is32);
> > -                       emit_zext_32(ctx, t2, is32);
> > -               }
> > +               emit_insn(ctx, addw, t1, dst, LOONGARCH_GPR_ZERO);
> > +               emit_insn(ctx, addw, t2, src, LOONGARCH_GPR_ZERO);
> >                 if (emit_cond_jmp(ctx, cond, t1, t2, jmp_offset) < 0)
> >                         goto toofar;
> >                 break;
> >
> > -       /* PC +=3D off if dst cond imm */
> > +       /* PC +=3D off if dst cond imm (64-bit) */
> >         case BPF_JMP | BPF_JEQ | BPF_K:
> >         case BPF_JMP | BPF_JNE | BPF_K:
> >         case BPF_JMP | BPF_JGT | BPF_K:
> > @@ -1094,12 +1112,38 @@ static int build_insn(const struct bpf_insn *in=
sn, struct jit_ctx *ctx, bool ext
> >         case BPF_JMP | BPF_JSGE | BPF_K:
> >         case BPF_JMP | BPF_JSLT | BPF_K:
> >         case BPF_JMP | BPF_JSLE | BPF_K:
> > +               jmp_offset =3D bpf2la_offset(i, off, ctx);
> > +               if (imm) {
> > +                       move_imm(ctx, t1, imm);
> > +                       tm =3D t1;
> > +               } else {
> > +                       tm =3D LOONGARCH_GPR_ZERO;
> > +               }
> > +               if (emit_cond_jmp(ctx, cond, dst, tm, jmp_offset) < 0)
> > +                       goto toofar;
> > +               break;
> > +
> > +       /* PC +=3D off if dst cond imm (32-bit unsigned) */
> >         case BPF_JMP32 | BPF_JEQ | BPF_K:
> >         case BPF_JMP32 | BPF_JNE | BPF_K:
> >         case BPF_JMP32 | BPF_JGT | BPF_K:
> >         case BPF_JMP32 | BPF_JGE | BPF_K:
> >         case BPF_JMP32 | BPF_JLT | BPF_K:
> >         case BPF_JMP32 | BPF_JLE | BPF_K:
> > +               jmp_offset =3D bpf2la_offset(i, off, ctx);
> > +               if (imm) {
> > +                       move_imm(ctx, t1, imm);
> > +                       emit_insn(ctx, bstrpickd, t1, t1, 31, 0);
> > +                       tm =3D t1;
> > +               } else {
> > +                       tm =3D LOONGARCH_GPR_ZERO;
> > +               }
> > +               emit_insn(ctx, bstrpickd, t2, dst, 31, 0);
> > +               if (emit_cond_jmp(ctx, cond, t2, tm, jmp_offset) < 0)
> > +                       goto toofar;
> > +               break;
> > +
> > +       /* PC +=3D off if dst cond imm (32-bit signed) */
> >         case BPF_JMP32 | BPF_JSGT | BPF_K:
> >         case BPF_JMP32 | BPF_JSGE | BPF_K:
> >         case BPF_JMP32 | BPF_JSLT | BPF_K:
> > @@ -1107,19 +1151,12 @@ static int build_insn(const struct bpf_insn *in=
sn, struct jit_ctx *ctx, bool ext
> >                 jmp_offset =3D bpf2la_offset(i, off, ctx);
> >                 if (imm) {
> >                         move_imm(ctx, t1, imm);
> > +                       emit_insn(ctx, addw, t1, t1, LOONGARCH_GPR_ZERO=
);
> >                         tm =3D t1;
> >                 } else {
> > -                       /* If imm is 0, simply use zero register. */
> >                         tm =3D LOONGARCH_GPR_ZERO;
> >                 }
> > -               move_reg(ctx, t2, dst);
> > -               if (is_signed_bpf_cond(BPF_OP(code))) {
> > -                       emit_sext_32(ctx, tm, is32);
> > -                       emit_sext_32(ctx, t2, is32);
> > -               } else {
> > -                       emit_zext_32(ctx, tm, is32);
> > -                       emit_zext_32(ctx, t2, is32);
> > -               }
> > +               emit_insn(ctx, addw, t2, dst, LOONGARCH_GPR_ZERO);
> >                 if (emit_cond_jmp(ctx, cond, t2, tm, jmp_offset) < 0)
> >                         goto toofar;
> >                 break;
> > @@ -1129,7 +1166,8 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx, bool ext
> >         case BPF_JMP32 | BPF_JSET | BPF_X:
> >                 jmp_offset =3D bpf2la_offset(i, off, ctx);
> >                 emit_insn(ctx, and, t1, dst, src);
> > -               emit_zext_32(ctx, t1, is32);
> > +               if (BPF_CLASS(code) =3D=3D BPF_JMP32)
> > +                       emit_insn(ctx, bstrpickd, t1, t1, 31, 0);
> >                 if (emit_cond_jmp(ctx, cond, t1, LOONGARCH_GPR_ZERO, jm=
p_offset) < 0)
> >                         goto toofar;
> >                 break;
> > @@ -1139,9 +1177,9 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx, bool ext
> >         case BPF_JMP32 | BPF_JSET | BPF_K:
> >                 jmp_offset =3D bpf2la_offset(i, off, ctx);
> >                 move_imm(ctx, t1, imm);
> > -               emit_zext_32(ctx, t1, is32);
> >                 emit_insn(ctx, and, t1, dst, t1);
> > -               emit_zext_32(ctx, t1, is32);
> > +               if (BPF_CLASS(code) =3D=3D BPF_JMP32)
> > +                       emit_insn(ctx, bstrpickd, t1, t1, 31, 0);
> >                 if (emit_cond_jmp(ctx, cond, t1, LOONGARCH_GPR_ZERO, jm=
p_offset) < 0)
> >                         goto toofar;
> >                 break;
> > @@ -1468,6 +1506,9 @@ static int build_insn(const struct bpf_insn *insn=
, struct jit_ctx *ctx, bool ext
> >                 return -EINVAL;
> >         }
> >
> > +       if (is32)
> > +               emit_insn(ctx, bstrpickd, dst, dst, 31, 0);
> > +
> >         return 0;
> >
> >  toofar:
> > diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.=
h
> > index 57a98f8a055b..2bd0dc5b911c 100644
> > --- a/arch/loongarch/net/bpf_jit.h
> > +++ b/arch/loongarch/net/bpf_jit.h
> > @@ -72,24 +72,6 @@ static inline int epilogue_offset(const struct jit_c=
tx *ctx)
> >         return (to - from);
> >  }
> >
> > -/* Zero-extend 32 bits into 64 bits */
> > -static inline void emit_zext_32(struct jit_ctx *ctx, enum loongarch_gp=
r reg, bool is32)
> > -{
> > -       if (!is32)
> > -               return;
> > -
> > -       emit_insn(ctx, lu32id, reg, 0);
> > -}
> > -
> > -/* Signed-extend 32 bits into 64 bits */
> > -static inline void emit_sext_32(struct jit_ctx *ctx, enum loongarch_gp=
r reg, bool is32)
> > -{
> > -       if (!is32)
> > -               return;
> > -
> > -       emit_insn(ctx, addiw, reg, reg, 0);
> > -}
> > -
> >  /* Emit proper extension according to ABI requirements.
> >   * Note that it requires a value of size `size` already resides in reg=
ister `reg`.
> >   */
> > --
> > 2.42.0
> >
