Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F822798F8
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958017; cv=pass; b=A4ZEpRqjoqzhYGF+ujgKXfoU2bX4jPARgz7F+mx6i2yVPCQmpPShCr9A1qTy4CR14GFC9WRffitlHoz/rrP7Dsfa/bQ3znWemVw3OAl9ftKI/KmRh3Dl+qVpIBRtptUAhEoYsAc8wTXD9yfqVasuubbFA2YFP21s+zsBOWoXpTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958017; c=relaxed/simple;
	bh=o8cqZvmBqnTjVd0ACTXD2YpvSRrjBHllBYhAPavAzc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoADKGbvUdqh5nCB+mbkUV2PpBmD14reh7xSLbm27/RaT79ccne9/NzLKr3L2JQyo/1QZRnJZsh00WjU10fSxQhXKiD0K/l7QK48xP9qRdMrCnUMFbxrPJunjvWhQu8+3JlMBXSKso69z9MMTlUYhrUJ2Cd2VEaEIrxrl1sYIzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkX3m2fG; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkX3m2fG"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-435f177a8f7so5704403f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 10:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771958015; cv=none;
        d=google.com; s=arc-20240605;
        b=DWiaDZJDpEjtSZ3sBIlU/PzHRY/t5tPKXPjTZqzMe2uifMzeZec1O5WXLbBbv4Sn1A
         0zDTjHRVuI9thSxG3Er+ucCEPcgNt0ax1kSnqf1lyd0VN3oyz+0fks3ou83zoqxLSipt
         4cyeg6gpeEo4ykIHe5W66bUjfM3v9dJsG01+MyNQdhVqdmUCQBhcZyGHowTpR3tngJVt
         nFtJCE/NE1oHC7SsZ95YJVy3OSN83dmPfYcbmZs2UVwtqlfGsrhEjO3g2H0axvaqdObG
         C3r7TSuO7AHnnaGLM1re4TMRyZ1nwuYu3ef3a2KFo9/2PP27zEDGpHC8efq1P9HGgBKJ
         tVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PDhzDEMkfLjeQ4OV45s41sCmUK2L5cJz/c/O2/TB68g=;
        fh=AosLc/FhPKRODQ6XBdAGPMR8Mt/rVrHG/Ds9v1/1d9Q=;
        b=OrHJwr3iq+SBCl8UjWkydA8nttD3CCjtUuq2YR05+mqmnFt0976bccD/wphNriquLn
         1amAVtJEZ8iInpRd4BCyCvyagfPvCK8xVq0zRsUkChyCXX4Y/a62hAaS/MyGrhUcz7l3
         IULUtIj5wefBOc7o+mG0FfxicFKOmE2qoXYAeeLjhdmgTcSVCVUv32YLqRVyEAf7IDbK
         dSmP+Ta4Q2ZZrD0yD+9igLFLgmlfCd1PscvjcAC56wPEm458rKPPs1mirNKVQ7/MKMSF
         ZkmYBmE27BUfZqYPJOGO2fWod5Cg1oX1J5d8QUzApEbkNIAMQobKa7UINVj4b6AKWmYp
         hSQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771958015; x=1772562815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDhzDEMkfLjeQ4OV45s41sCmUK2L5cJz/c/O2/TB68g=;
        b=KkX3m2fGj1cpI8mnl+FMrGSqMRLdjE3YFLmxZDJ9ZtGosWV6eAzmQflEPt9cUCKNq+
         m5AXJn77xfrAhqs7fJqJo+Wy8wnQyz05pgFwYqlBKV/ZjdpffUAOUqdyj/UH+ooR53kd
         LW828OiG0bhAc7cNfYbHfAPj+HnmUOIcn3Wrnr+9n7xZNvfOUxEI3UfnVGQhaT19FRnP
         FAM/UnDr1MxHyW1FxdUZCxk2GS8qdeIqfAkovZyC4u3kk6Om0CPvoYyCDVFE+ewVugZk
         i9Aq/SHYby3LL2AzpS1MmVgm5edC4jhR2frR/+ZZ7m1U6V+30m3gbrFDM33gvuOiCMun
         jPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771958015; x=1772562815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PDhzDEMkfLjeQ4OV45s41sCmUK2L5cJz/c/O2/TB68g=;
        b=SMBbFlXkxRBNOkGBnRrXhMNgoKzCsyQfsnhoTr7xmsMnXrNrrM7eO6kFcoLSn3dna+
         5zhoTMDv+AI9I0AS+vBPQ9Qksxj9Zwf108QEGyn1GO0BcSvJjrJLqjJAF8fnJVC8BM23
         TGpbAxIlC4v6l5jfnWgVg8CAGDso0OvbOunsHJ9WkHX4EWi3feGZ2jKm4/CfzrzNiufu
         uGUoa/XJFxNqxSfEpfNSfM+xOj0nuDI3dpBqJXhkte3+UsIHuioCoZ8O1sZ+xk1O8N61
         myHYDPhxnYDrepadj0mc6bmVArcdCajQDumGYj7RYcl4yrkLFWThcFHgeo4BEvhGB6HK
         8F+w==
X-Gm-Message-State: AOJu0Yzc6wBOG0YCrcgqpAy3pa2A+c882uzN8WRLpUtS5PZXK1h5FTah
	OwgtS5iNpS+QZrcZmIgR++N3uAtW3f9jjmJmno2ksFuv2hGJUsusIY0O/Rs34keQEorrU1zIJ2p
	phJ9AEs8IYUX1RacI74VPEVuf/hyLLFMC9g==
X-Gm-Gg: ATEYQzwyOc1vwaMEuektRkEVuH4/rRDcP0tOZnjMne/wDsNWmecSx+htB+zlV96LYnS
	k50SOUOgaii9YCNd6APd517MkUlsL7DrZ91ObT0b4l7sKLcfKwR+KVllf/f/NLqEPfAbjNyP/Fd
	vWPc6UtrC0fgcjR1PZQAPiaJlEhw2DuV13gtxW3JP/DmZURHR6/RTHtOUK1MvOlOWf1Um/ythn8
	wM1EfpISXlmt/jAsdsl6b9tXRq+uZLNKRzv2/ZYterx6EelBdHly43/D18raH/2nPtv52iqox1f
	u6iKUhz61L1X6gu0ZJo4NoBZ+Y8RAs/BhR1PK03PGQdVxczc1atTEQsDqPD/ZFPz7c0F8PHj/MF
	fLiqskLgt
X-Received: by 2002:a05:6000:18a6:b0:439:8ca7:ec48 with SMTP id
 ffacd0b85a97d-4398ca7ecc7mr2597154f8f.57.1771958014446; Tue, 24 Feb 2026
 10:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220062959.195101-1-hbathini@linux.ibm.com> <20260220062959.195101-2-hbathini@linux.ibm.com>
In-Reply-To: <20260220062959.195101-2-hbathini@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 10:33:22 -0800
X-Gm-Features: AaiRm50X-tSQROlmMEkz47dChp--vUK24lFpMFh5kATCz-RKp67vdjv97zMauE0
Message-ID: <CAADnVQKwCX6mUbQeLTCtG7dKe+P_UUBig5KMTkF+t-6SW7wAkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] bpf: zero extend function arguments while calling
 kernel function
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
	Abhishek Dubey <adubey@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 10:30=E2=80=AFPM Hari Bathini <hbathini@linux.ibm.c=
om> wrote:
>
> For kernel functions, even if a function parameter is not of u64 size,
> it may still be cast to a data type of u64 size. In fact, page_cnt, a
> u32 argument in bpf_arena_reserve_pages() kfunc is implicitly getting
> typecasted to long. Without zero extension for that argument, the
> verifier_arena/reserve_invalid_region selftest fails on ppc64le. So,
> be more conservative and do zero extension for all arguments. JIT
> compile code can eliminate unnecessary zero extension code-gen.
>
> Fixes: e6ac2450d6de ("bpf: Support bpf program calling kernel function")
> Reported-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  kernel/bpf/verifier.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f0ca69f888fa..3f6e0e1c71e4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12018,8 +12018,11 @@ static void __mark_btf_func_reg_size(struct bpf_=
verifier_env *env, struct bpf_re
>                 /* Function return value */
>                 reg->subreg_def =3D reg_size =3D=3D sizeof(u64) ?
>                         DEF_NOT_SUBREG : env->insn_idx + 1;
> -       } else if (reg_size =3D=3D sizeof(u64)) {
> -               /* Function argument */
> +       } else {
> +               /*
> +                * Be more conservative and do zero extension for all arg=
uments,
> +                * as how these arguments get used in kernel is anybody's=
 guess.
> +                */
>                 mark_insn_zext(env, reg);

This needs a selftest and better explanation of what's going on.
So far the patch doesn't make sense to me at all.
zext marking is only to simplify JIT's life for extensions
from 32-bit to 64-bit. All <=3D 32 extensions are done by LLVM
when it generates bpf code on the caller side.
If native callee messed it up, it's a bug in JIT that
doesn't do correct job for kfunc calling and translation
from bpf ABI to native.
