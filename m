Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64243126B2
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220070; cv=pass; b=TF3izvyWJLrMQJT3XjrWZLeoEhPUO4+Aw1t1jiuaaJaFs/gp4hjjXzPpsP5zPfcs+V1dZrl8LCRGKD8VOSmJ0l/3QFwOgBOhHivCJ4ZrEQuZBdJt7y4VBxP8dM++FT2kgrS4DxTU/W3yuDm/F/39zIPH87AGcs9A72h8d3XfxDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220070; c=relaxed/simple;
	bh=Rg3JlwOrlQ5XbvGJDFfZ8rC8vvU78IBNAeleJd26Fm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwdf9b2NRMuX7k+UOKtR/rNfL2jX1Vims6EJUuf4saEbzR2hOx+20j5iWaE8mNfleN2hPqL4dEzHAfOstn4hQtHJOGvIu7dW4oY0XieIxZsbZqS2r8KkCDv+HqiIL/t8uGqMK5ow1+GgT36XzSzwv8pOzqRd+Ffq0YU/WPGMDnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nThoP3a6; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nThoP3a6"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4670676ba03so2078774b6e.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776220068; cv=none;
        d=google.com; s=arc-20240605;
        b=Vq+9iojckx6Cgz4dX4P0/X3c38mnUQwSD72sgDdR8K5n6TbnFpWQts5RIq0hHmvL6F
         ufAId96Zsk3hdsJMKs1tMg4/it+x3L9OI4EmUOBhufxT3mvbk9FMttYIvD5WwgLfcpVl
         OznNxj0h1y/rTigstsvzEoDEjcMdL6wVlTilibR8fWHYry77Ix3WuWjMayKywoPk/IF2
         7ceBXDUL4jJ1ixeSBwzTPRrvIZZism5b6uAeWRcEFZQ2MyQX6O2IdF2YiKKxudht2k+n
         9FL7ARS10yTkep5u6UUSVIaVi+TRIF9eHAg1iiSuqBmF7v9aj1giDbfutEaHLlktp8U6
         iplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P9QwzqZ+lHxRLuVTrCD+/Bo3+jO92j08BnbVftYHz5s=;
        fh=zKTE2Mx0WJiJwT4iP1DxXUacAv/DPH0cktBlEb0li+U=;
        b=iRktErTCyZnI236t+RxjGcGR1c/gnDWFUWzKGpgxfXOp/x0FKoUjM/0ETKUCpr2ay4
         s8Q7BcBN7tHkR7We/KESKLnmlJAN8nNqw04ljwTOxfvgj86iDemKKG+6F2zJtGP8dl+j
         MZ61CCpH51E6KMRoT3/B63J/k17wfd9pj4QqRgA2sUr55aCYpGPVv1giBOJm1VrOyxxX
         xMbQLKPfwkY9oWM/MMRb9JEzFs+gLChCwSHdHIWlzYe/932mVj8x4PAFB4+jAeix5k94
         VcSj42JYwbtmnenCtJrrb7mZmwfr3PTNenA4WaDd49Cx1cQRlE1kldZdckoDdpy3p8Qa
         IiiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776220068; x=1776824868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9QwzqZ+lHxRLuVTrCD+/Bo3+jO92j08BnbVftYHz5s=;
        b=nThoP3a6QV15V/QYb+llb/mqb2X7S+PS9ZMtz6XDoc9LEex6mQ0cxHAlGcG6/yXVVI
         m5O/vIGSpELEnzvnWv1mv4WrxVILMF4EVORgmbxJbB1ZrbTQsFClgttA/mAn/EeHVFfl
         5UiWJxX3OSirodOGcOY2GS6DioG8RFao1UXkHB8KSaw5E6EcOTs3yNZU8wYw8K/Ji3c5
         53MEk2QYpyJuej400QO+XG9FNVB6ixTPZEigZEN8LbpORvp4iLpDEXsWva887QvkCvVB
         ozGHdRj3Bg8UrW1LAeh8+/AZnhvMU++/7FpZb+NOagYCMAMzorNHW/u5M9m8c1hv/HUs
         LiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776220068; x=1776824868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P9QwzqZ+lHxRLuVTrCD+/Bo3+jO92j08BnbVftYHz5s=;
        b=RVjd3eDwI99ca/32mTQSQ7E4RPtLw8TUkXwArxT3p0Xv3qLFVMScPHfvU/tWorEU3w
         GZt5xkode1r2p7YgQ+TexrtmRGnwgiSPKBUZc/+7ZzbPBYSmGvD78dFBtWpvJIorYyP4
         hghSi9rtR60mmg3b/SvM67htDHdYzRIEjiZqlf4fnf1aziTR5NyYlnty0BE2syjsOWju
         yCrK0YIyu8DJAZFyQjG36+orOGkoSjzOs9ZJ37qNWWFEqrDuC4Sm3FmBkZrv6TZSNcmW
         NDSzoF5tgP65T8sknoyqxl/AyRqrKFwVwVjpLfNA+M4+0EwPceeGL1FBpTTnD5bQZWig
         FsRA==
X-Forwarded-Encrypted: i=1; AFNElJ+6f20884l9H+6/zCpcWukEPIU+YH1E9C9Ze35tslySF3wp0qbN1AMle5G9AkwmnYOKo2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKruWYuV0Te8l5ulQB2h7wk635CvT9EgBLOqKerh52WZrnPho5
	7Xify9LHpRcqHqMD8TMXdRpautBerCAkiq8r+Ni+h+M3zdO9VbTHuCitOCYT+lf3J601UId6sg+
	Cqu4tr04Zr3KVdU+ZutLLZLV7CrynzwA=
X-Gm-Gg: AeBDieugNxgmTnS5cMzjmfG29skitKeL+y8BadCmvAD7f1tlHMNi+G+vY2mgRtqb+Df
	8xeMpdXNeb8O8oaUiHx8RRCADQqaJZUp4MXd4uxeY+COuz8FZrgNY1hlB1SsA9ireSly+EPF5//
	CtgeR/GQC2XboZiSzEiioLoXm/YJ1b/g/Jev+3EF4joPSL+WnWAkGKdv4pj0eaovpNm1HfmxxrR
	vcYTYFqOwVpir4SKeSdz1sakqFjCvl9DDPteiw6KCpNn+rhoETushgX1rA76kT6+eVE4WiLD/xv
	ZSW8LBMTaaPJVMnoDg==
X-Received: by 2002:a05:6808:1c0d:b0:46a:6d33:65a8 with SMTP id
 5614622812f47-4789fb11b45mr9672786b6e.32.1776220068530; Tue, 14 Apr 2026
 19:27:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413040506.26640-1-yangtiezhu@loongson.cn> <20260413040506.26640-6-yangtiezhu@loongson.cn>
In-Reply-To: <20260413040506.26640-6-yangtiezhu@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 15 Apr 2026 10:27:37 +0800
X-Gm-Features: AQROBzCWeMr501FjNgFKBxyyGLNQVfp1RmcgcvkIqZvV0x5R_9jReZCjhCbJTzw
Message-ID: <CAEyhmHSoY9Pd+XMdKCUmv_P9xUm6A9VeY1UnXJNQnGwz8Rhfvw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] selftests/bpf: Make CAN_USE_LOAD_ACQ_STORE_REL
 usable for LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 12:05=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> In order to do the following load-acquire and store-release tests
> on LoongArch:
>
>   sudo ./test_progs -t verifier_load_acquire
>   sudo ./test_progs -t verifier_store_release
>   sudo ./test_progs -t verifier_precision/bpf_load_acquire
>   sudo ./test_progs -t verifier_precision/bpf_store_release
>   sudo ./test_progs -t compute_live_registers/atomic_load_acq_store_rel
>
> it needs to make CAN_USE_LOAD_ACQ_STORE_REL usable for LoongArch.
>

rephrase it as enable for LoongArch ?

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---

Other than that,

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

>  tools/testing/selftests/bpf/progs/bpf_misc.h           | 4 ++--
>  tools/testing/selftests/bpf/progs/verifier_precision.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
> index c9bfbe1bafc1..19f0bf44a9e1 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -257,8 +257,8 @@
>
>  #if __clang_major__ >=3D 18 && defined(ENABLE_ATOMICS_TESTS) &&         =
 \
>         (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||  \
> -        (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64)) || \
> -         (defined(__TARGET_ARCH_powerpc))
> +       (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
> +       defined(__TARGET_ARCH_powerpc) || defined(__TARGET_ARCH_loongarch=
))
>  #define CAN_USE_LOAD_ACQ_STORE_REL
>  #endif
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/too=
ls/testing/selftests/bpf/progs/verifier_precision.c
> index 4794903aec8e..6f325876efdd 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
> @@ -75,8 +75,8 @@ __naked int bpf_end_to_be(void)
>
>  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
>         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
> -       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && \
> -       __clang_major__ >=3D 18
> +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
> +       defined(__TARGET_ARCH_loongarch)) && __clang_major__ >=3D 18
>
>  SEC("?raw_tp")
>  __success __log_level(2)
> --
> 2.42.0
>
