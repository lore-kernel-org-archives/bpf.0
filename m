Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366336A37C
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514898; cv=pass; b=PjP6n7g1zXzkmEM/7MJbmQDnRBVsMyBv5p96Hyl147TpoWJwmbjt4JD3oQ5Xh/GGs8GBqnURAe3yWS7GRSvHMvBen13T9qA6VwQiyzSKtCVxM+GtlAq/RuuGduuTxWziuIxn8WgSmTYhoOwWIiFAYKjeiOSqsQTmNsIU6FHH8yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514898; c=relaxed/simple;
	bh=Qv6p33Ms7lJZNhDoMpL46zV2EdNVYCWJ4HAmnz49Hbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4XwMTfVO8e5xz1g7VcINDWz2QtwBsZb2LHM/+H1Tawk4pmbK62NogPuNkaspAAwKfARR7VEBTtNWf3nQuAmvpT2jeSjer1r3THLejFkmNDL9kQWd0CYY40qgSvYOsVjDU9t4gysbT2GCNyUAn1E8L2uoDHPIJu3uIBnxz3fYaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCo7hwM6; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCo7hwM6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso441676f8f.2
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 05:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783514894; cv=none;
        d=google.com; s=arc-20260327;
        b=FFD9g9urTOMIw5vnoP9fwpAbycuAL50pSQAHC2PQbbYO938U703aTc/INS34IynnKt
         xDsI0ClG/827ooFZpEGpUAmMTCXKB1513SBYuPvVBgBHhDCRJgvX3QEL9mKkAtN2rpsB
         efmtUaiu2y0m1yGBXFM1SXc6Hh1WEJXiBml/9vUabNyT/IDwgDWwxNJEED1PAO6MlkMk
         4wsoQZznksZr9WHxD1UW8fDgmaH8nt2iWn2BriZuvpyhhC4AcLy473aUfD46vGH9TFGn
         o8z5OIdxy1mNJ2JeAU8/+C3LA05p/+n81B446pXfEpMXISMgQ7McV5Zp43d5saDy0ZzM
         g9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oM6cgiCUs2LYUfxBySpkCDnF3AdZ7CElaEXYvjTJo6I=;
        fh=D0/8KfkOmYdXlz//+WwHxA5lyUcVLbIcG1sFFBOmM00=;
        b=QgTRc8JQywDPC1y4SxVmDnOxSwQYWBaE0pK4kldMX+rwcZcd4d8u00VSG5C9FozDok
         X5XLOudeZDyc3vykJFEIdPSCxhhOV8cXH0Doq9ZDEjzuRGj/DaKN0GtCSFczkXdpaVUd
         b2T2fyabqFHstgpRg0rNnqNn/xC/xzSv7bg5ZIR+s2ramQiJthD01Hrltqzq57TZYEL+
         LG8FEJarwXtA0w4QxysXwG17WdiJAyyPNv4bsGlkq/yVrF0CY4C4BEXupcksnWmXpgVT
         p5Y0h726hJv/HL10+I6ir28ag0mIi3K1cZXQumzcwij+JfP3VXrJQkewsmsb7G3eET4V
         UfBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783514894; x=1784119694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM6cgiCUs2LYUfxBySpkCDnF3AdZ7CElaEXYvjTJo6I=;
        b=FCo7hwM691FMRO4KcjWPYfQk0oXREgyCTygmI/HzVPL7JnQoPUuiSgcIic+GEiAP6S
         iojMeBOHBpcVHi2+lfbBdp9auiXly6azMHlRXsODihN10jTudtBl36vIGVv5l9gNEEq8
         iUGW8j8GjgvfxNbMHZIvbZwtiAduBt7y1+VDkBieQuivVCMIOAM3xaAiJ1TE0SooHjvV
         NTsMhGANbC6bMF+sck6B701Ea8OxemuORdG3BW6H1nj/3AiQm2C2ivgvJgZQ2NNPZMBH
         nn8MWCiugnb8M0ATHuseUyek/se2ZnYHdg4SPuRLilHkGyaVq8VNz0cV4NBSAWoDftEy
         gBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783514894; x=1784119694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oM6cgiCUs2LYUfxBySpkCDnF3AdZ7CElaEXYvjTJo6I=;
        b=exh3h932BZA+tvgWzP6KiofBD95DLKQ3M7EF0LJuJau9+61ccVnwtPkr5OuVyeakFG
         aTmKttB7U9fxjVbIG4crXUdhVCVfFVtkDNlrqNZmKCO5D0I2OLovlFSspHPFpL4Z1IxY
         jQvfbCeiCO1ef5B6zozPG2+dKjCNt3JCT9enVXyVX02jsHCrR2TtuuX7Kc9d7NjW2jTl
         RWf8ZOecaPeWjn7XjvSR48cJ7buIj/tMDCZkpbc0aQCk8v1oBYzFgtHMkfeRWkTo14wL
         4XaVrewvfUYWrQj/BbbOvOHYyk8U7qEvgzPH3JTlqBf6yOAiD9XiNzXP3CYv693a4WAE
         STOg==
X-Forwarded-Encrypted: i=1; AHgh+RonBB/JVg21Z7N348XBb8l8up4DjZMwuzaRtN5/mKlcH/VXuQCv92GavcWg0Ld7T5QDmSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaoinDo3WcsuoXH3VRFbhidIrgzz3+MA4pg/jOJOhFVI+76/i8
	cYApDfV0HxY5AzBt9vgdfXwinRaAn1c9nlUGIiJtKDjdDw3YBEY5YcbMI8K+46HP7SNpn28M5xJ
	k0EMhO8LEvB6R8jZ+Dc1fmLG1xyspxNk=
X-Gm-Gg: AfdE7cncHn82c8knFk/En5m5nmCel+KR+8dqxhftT0CfuK82t8pFnW4v+UixzWtjy5i
	n7F24JjrASfs4opkLgXdWGRFTfoTWL+3FEs6iLaONhjzUVidf00Uu7imcMWYIQh+VrDHXJUvbxI
	jT9IgD+ShYzMqrxrbCVvG2aopx6iw4xLoNjYGMMTUOFS3EGrsWrirNPuOxFlzYOE95/5ha6aAnM
	qb03BUrHKi/uMfwdu+9iU5gUVSPX8YcoFaaAhu3gip8/uy/buFm7JrR7wJFA6Gzsu9ByEUSc7rb
	l73nrIjytIXgJhoec/njZ92IIvHYIMs=
X-Received: by 2002:a05:6000:2510:b0:46f:f12b:e453 with SMTP id
 ffacd0b85a97d-47df075e3d3mr2403687f8f.28.1783514894199; Wed, 08 Jul 2026
 05:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com> <20260708-kasan-v4-3-d5c177ab8227@bootlin.com>
In-Reply-To: <20260708-kasan-v4-3-d5c177ab8227@bootlin.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 8 Jul 2026 14:48:02 +0200
X-Gm-Features: AVVi8Ce28NN5OLVzXOb8-dZK-ndefrPCpQQGxxaCTFUnm6OWPadXfj-wXhMK9LA
Message-ID: <CA+fCnZcOPADt=dkhApCQwD40EB1WWP45PvdBtJ=hk1u1DAMUiQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 03/10] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	ebpf@linuxfoundation.org, Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 10:02=E2=80=AFAM Alexis Lothor=C3=A9 (eBPF Foundatio=
n)
<alexis.lothore@bootlin.com> wrote:
>
> Add a new Kconfig option CONFIG_BPF_JIT_KASAN that automatically enables
> generic KASAN (Kernel Address SANitizer) memory access checks for
> JIT-compiled BPF programs as well, when both KASAN (and more
> specifically, generic KASAN with KASAN_VMALLOC) and JIT compiler are
> enabled. This new Kconfig is not a user selectable one: it is either
> automatically enabled if KASAN is enabled on a compatible platform. When
> enabled, the JIT compiler will emit shadow memory checks before memory
> loads and stores to detect use-after-free or out-of-bounds accesses at
> runtime. The option is gated behind HAVE_EBPF_JIT_KASAN, as it needs
> proper arch-specific implementation.
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>
> ---
> Changes in v4:
> - reorganize dependencies (Andrey)
> - drop VMAP_STACK dependency
>
> Changes in v2:
> - add dependency on kasan for vmalloc and vmalloc'ed stack
> ---
>  kernel/bpf/Kconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f0..e1f3850d2f5a 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -17,6 +17,10 @@ config HAVE_CBPF_JIT
>  config HAVE_EBPF_JIT
>         bool
>
> +# KASAN support for JIT compiler
> +config HAVE_EBPF_JIT_KASAN
> +       bool
> +
>  # Used by archs to tell that they want the BPF JIT compiler enabled by
>  # default for kernels that were compiled with BPF JIT support.
>  config ARCH_WANT_DEFAULT_BPF_JIT
> @@ -101,4 +105,17 @@ config BPF_LSM
>
>           If you are unsure how to answer this question, answer N.
>
> +config BPF_JIT_KASAN
> +       bool
> +       depends on HAVE_EBPF_JIT_KASAN
> +       depends on KASAN_GENERIC
> +       depends on KASAN_VMALLOC
> +       depends on BPF_JIT
> +       default y if KASAN
> +       help
> +         Makes JIT compiler insert generic outline KASAN checks in BPF
> +         programs when they are inserted in the kernel. This feature is
> +         automatically enabled if the needed set of KASAN and BPF
> +         configuration options is enabled.
> +
>  endmenu # "BPF subsystem"
>
> --
> 2.54.0
>

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
