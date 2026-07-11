Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9B136358
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783738290; cv=none; b=PSOQGYiUW7UUUQZYe/ptj+uulFTj+gVsFBy+q9QF6MXHXRkls+CLp9fpn/IntCFfuLoyrXAFeuYALsjothY5Rt3Y1Tcm2qVteJkiOxHipfK9kxAy/zud6umFhIfMTmXXlwPwMdQNWhoemVSSMgbJ/GEbPPCz/zJFPWSJhYEi7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783738290; c=relaxed/simple;
	bh=8OD4lybpLPBiG3f7B8/dI3HQIJ2e8RXpWqRnlIAt9zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXLh5dpuNbB+PIeWNye1j9WekO6JLYXepUDxeC2STDkis8p1JNul+M58X+DSyjWavkX2yyNC0nUX+GJAs9yJPVf9DQcCuzQE88haMpfU0hjdF0M1pBS5Wbb8lHTPlLjkauiFgN2H+3XpftTOD+5I74hvPX/sxgW3SQOZgFngndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV3NnJAh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV3NnJAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC33C1F00A3D
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 02:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783738285;
	bh=eWCslgAQBYBPJUnWQvReoomA8SLhzSUYDA4HX6ERh30=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eV3NnJAhNDimeTLkGTAQTWQphXWeRCIugbYvpdvo2NQIcWJvEryxz1Ik7xogllMPt
	 C4g2lnBzix+1YuaDgVxyhfvZWsoZzQFMabEPmwwekbKyFbOhb2s3YrkS6i8SY2Au7D
	 B/uXjAKU7+5b+iNnj0Qa4MIn7GjAMkQl7bh6CyUM2JQukF6d/u6A895ABV+f3TQ0ru
	 yy/XhVpQz/wlyKibbZbaVRjtmFFb8pXD53vvRZcvCYc/rixbWf9+wsmkzQRjJTONQ0
	 TkQb85lMu6aVKnuvX5ep5a1zxVvGBFmvWdgTji7dOb7KeEgIv1/FCTB2KGZ1eMv3aX
	 MmL5QxuEyIM9w==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-693c51a8a19so2323214a12.3
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 19:51:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoNP8P9rIt8+q7reJ0q/0t23+yMqg1Moo6/MUIL06XsOjfG5kGDH8cRUZwgW0q/U0RGmGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWyBQKB8NBlOs0sq20dfLohJ2c1839kFCSJZAiwBWEsFdS8YTv
	bg1G1ei1OzhW0vpE6TvqahgK+sPO1g/N5+o0tre9l6uwjO43Gu8kymaFJaDT7gFjIgbQMwiweoO
	aGgDHNlhEh04CWDoGeOu4q0H9/lQKmKg=
X-Received: by 2002:a05:6402:2756:b0:699:8397:55f4 with SMTP id
 4fb4d7f45d1cf-69c5f2502e0mr586538a12.35.1783738284133; Fri, 10 Jul 2026
 19:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709135344.1744677-1-main.kalliope@gmail.com> <bca7ef40-932f-1841-16fd-6da4197678c5@loongson.cn>
In-Reply-To: <bca7ef40-932f-1841-16fd-6da4197678c5@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 11 Jul 2026 10:51:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H75ZHaYnvdyW1t92h0DPkG6Cy_tYjG6C3T0HE5vvYdiDA@mail.gmail.com>
X-Gm-Features: AUfX_mzxYHsuQ-8-2Z0KxpArXWQE453IlW51HaAPNlTTBHLDJmoaq199MF1mRO8
Message-ID: <CAAhV-H75ZHaYnvdyW1t92h0DPkG6Cy_tYjG6C3T0HE5vvYdiDA@mail.gmail.com>
Subject: Re: [PATCH bpf] LoongArch: bpf: zero-extend signed ALU32 div/mod results
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Nicholas Dudar <main.kalliope@gmail.com>, bpf@vger.kernel.org, hengqi.chen@gmail.com, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 6:14=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Cc: Huacai Chen <chenhuacai@kernel.org> loongarch@lists.linux.dev
>
> On 2026/7/9 =E4=B8=8B=E5=8D=889:53, Nicholas Dudar wrote:
> > ALU32 operations write a 32-bit result and leave the upper 32 bits of
> > the BPF register zero. The LoongArch JIT sign-extends the result of
> > signed ALU32 BPF_DIV and BPF_MOD (off=3D1), so a negative 32-bit quotie=
nt
> > or remainder leaves bits 63:32 set in JITted code while the verifier
> > and interpreter model those bits as zero.
> >
> > Keep sign-extension on the operands, which signed divide needs, and
> > zero-extend the ALU32 result after the divide or modulo instruction,
> > matching the unsigned ALU32 div/mod paths and every other ALU32
> > operation in this JIT.
> >
> > Fixes: 2425c9e002d2 ("LoongArch: BPF: Support signed div instructions")
> > Fixes: 7b6b13d32965 ("LoongArch: BPF: Support signed mod instructions")
> > Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > ---
> > Reported privately to security@kernel.org first; posting to the list
> > at the maintainer's request. The patch is the same.
> >
> >   arch/loongarch/net/bpf_jit.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index 2738b4db1165..c91d474faba7 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -835,7 +835,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
> >                       move_reg(ctx, t1, src);
> >                       emit_sext_32(ctx, t1, is32);
> >                       emit_insn(ctx, divd, dst, dst, t1);
> > -                     emit_sext_32(ctx, dst, is32);
> > +                     emit_zext_32(ctx, dst, is32);
> >               }
> >               break;
> >
> > @@ -852,7 +852,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
> >                       emit_sext_32(ctx, t1, is32);
> >                       emit_sext_32(ctx, dst, is32);
> >                       emit_insn(ctx, divd, dst, dst, t1);
> > -                     emit_sext_32(ctx, dst, is32);
> > +                     emit_zext_32(ctx, dst, is32);
> >               }
> >               break;
> >
> > @@ -870,7 +870,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
> >                       move_reg(ctx, t1, src);
> >                       emit_sext_32(ctx, t1, is32);
> >                       emit_insn(ctx, modd, dst, dst, t1);
> > -                     emit_sext_32(ctx, dst, is32);
> > +                     emit_zext_32(ctx, dst, is32);
> >               }
> >               break;
> >
> > @@ -887,7 +887,7 @@ static int build_insn(const struct bpf_insn *insn, =
struct jit_ctx *ctx, bool ext
> >                       emit_sext_32(ctx, t1, is32);
> >                       emit_sext_32(ctx, dst, is32);
> >                       emit_insn(ctx, modd, dst, dst, t1);
> > -                     emit_sext_32(ctx, dst, is32);
> > +                     emit_zext_32(ctx, dst, is32);
> >               }
> >               break;
> >
> >
> > base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
>
> Here is the link:
> https://lore.kernel.org/bpf/20260709135344.1744677-1-main.kalliope@gmail.=
com/
>
> When executing "sudo modprobe test_bpf" on LoongArch with v7.2-rc1,
> there are 4 failed testcases without this patch:
>
> test_bpf: #811 ALU32_SDIV_K: registers jited:1 ret 1354 !=3D 1 (0x54a !=
=3D
> 0x1)FAIL (1 times)
> test_bpf: #812 ALU32_SMOD_K: registers jited:1 ret 1354 !=3D 1 (0x54a !=
=3D
> 0x1)FAIL (1 times)
> test_bpf: #875 ALU32_SDIV_K: all immediate value magnitudes jited:1 ret
> 0 !=3D 1 (0x0 !=3D 0x1)FAIL (1 times)
> test_bpf: #876 ALU32_SMOD_K: all immediate value magnitudes jited:1 ret
> 0 !=3D 1 (0x0 !=3D 0x1)FAIL (1 times)
>
> But the failures were not present in v7.1, these regressions were
> exposed by commit c8f0ee969f76 ("bpf: Exhaustive test coverage for
> signed division and modulo"), which added these cases in v7.2-rc1.
>
> With the provided patch, all tests pass as expected.
>
> Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
I have queued this patch for loongarch-fixes, thanks.

Huacai

>
> Thanks,
> Tiezhu
>
