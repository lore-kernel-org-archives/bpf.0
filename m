Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B93FE36C
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913417; cv=pass; b=eWo1s6dNNonQE7+bguR1OUMbpT2gAP9HtULLQUQst9KRdyI+emUMk5aupE6xHH5Fy2LWiLeXNjF9Ud9hRPOCbLNmM3eFVnjUS7EUk52VGjfONzx/u303ha5qbpI9aOA55555yG+FgfDG/zNdy0F+2P8CRBliG77croShH4WnNjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913417; c=relaxed/simple;
	bh=T/XOZkzAUaRuNTmlxBWLgaieY4+bTVH/XsWWHxZWp08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PB1wRNhaW6qx4ccG+HGcdx9GydylWJPUCufgBwHHDmgf2EmanznD/5G5CfZOovXDieY/Zi/ZMjvMovx4vTNiO9vyO/eopL3GiXU7gAYr5kwCq3pcvgSauDRDdo9wYsJ4xkDIRldKxkMzZ58eC87XqU7MKvjgIuX2Ar/+XpBkkrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgkj2NOi; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgkj2NOi"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so3712455e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 06:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782913414; cv=none;
        d=google.com; s=arc-20260327;
        b=Rgzjj74gpr6wsEIhsUKPbPpXNmbL3qp6UsrJhSkrZOIJalAy+9qxR8oj+JmLhVZYMI
         7cG8DprC2yyY23ulLnaZsvZi2dAcxY2Ml3rJxX8tYKKbyYCTIRaRVvm7iHWEJt1nEErS
         rw0O/GcH1k++AUq1n6FaS7CwBgboOGcqIkpbRiGffjgJb9ASIn1e6hMgB2uX+em2Bbjh
         Dw1nchLJckWy8oo+MPg7bC1uQXPW8kraUhsO+7qX0N3ROUQY2Aa4km03SOAuVf2qqGHP
         BfN7dqIg42oljs6H1v+ROJ7yYfFQuBX8M6PhB1RNLFYsQ42DZzljdZn3Bx8LXjgzJjEk
         AekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vSjIvUCBKaf+29BRz9OSwHOmh+Y7ZrvWCNVxdtqpkPc=;
        fh=jjtafzmplg1S7+4TO6QUQdt2FkZuQ0ytqufiw+XMQSI=;
        b=l8zIIqt0X7I6lJSX0hZgwoRN7umxyLvu26vjKpXIMo/XK5xVBdxLiYz36+0ZDk9/LQ
         FuFMjCY5tIA2Unt8f1/PPrF3TMX0mgU0mIsNyFInFGqIgDmjEkS0f6YZavK1YLSa6CUV
         7PsWQk7wkMZBUfjwGp9rUb29J9Ga1eUtv7MQOPS6/p0NGfsYe8qdCEwFzs8GBkq8tfXx
         hJ6B3+xzsUmXnikx+zC1hSM2sPY+zg45cg5Ym5Eb1vC+RT4kaehfQvXs4dK0ZjTHQvhZ
         FWoOXNl+4NADXTaEDNo6RNpyACcwiTRIpMlWukOlOnrkkipqxNhcNkHaSWhwBwuN9Gyr
         Pu4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782913414; x=1783518214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSjIvUCBKaf+29BRz9OSwHOmh+Y7ZrvWCNVxdtqpkPc=;
        b=rgkj2NOi0U9805CIRIw5hpGTPFAM2glen2HcSS4j5CcL4vLrHLCtzWSIeW7bbRfWsS
         zQ47FpVhQzbqcQa80YcAQYcx77rHz51gmh1d6lKG9o3OPCIyNVH5BC1WJW0+NDSZG+M9
         owzeqkauYPG7QNVlRwDbZ8qEwqY1YLEpGSbV6KwSa668Z2s5kxVvSEUotD6SUSIhGSaG
         r57+jV4ShQ34SvY6EhIUQj85t8xQAUKWhmq6s99xYgekVCgI4IlJt5BWAKiZcDbx/EKs
         zL2d+IR0qRW7ohxyf24vxVYnNdBbcOs0tCY0mXuOABcjoxmvLLm0/JRQUlaNxdjsz8lO
         /f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782913414; x=1783518214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vSjIvUCBKaf+29BRz9OSwHOmh+Y7ZrvWCNVxdtqpkPc=;
        b=WYXStQpPC3Rr+Lt2veal4rPdmHW2SpgBXRWlY8XFguR+LYwFYwS91lmfZYfh4g5GwW
         v/qka9ykmtMKWkNZpocEYx9pgND1xfiVoUE+JbOWxZHe+tXo6ic84JaXitFVcJb61Uyt
         v+MlrYEmCtbVmc3jGPNvUyaOSNtBzBIJi1y2TdpOHpY3yPWDhCqXHZ0MtxWXRAnLRBrt
         ewNgqLryfKe60DG05i4UzJaNT+yF2Zagzzc0j+bkYdVfQyPIh9REirTujtBLXDpgYbeB
         YDzkEptF2KxrkH6WB11C1tK4LDQRyRn5MwsUmBfy4O/MTFaAwxITw5GP70wk9PUhJ/O0
         bCzA==
X-Forwarded-Encrypted: i=1; AFNElJ+Ii22ayuZAXDTFLzkRbGWkJgcGqMgRNwlnmVs1Z7dpjCxr6SPMIHXLHNSqYzJg7btNsbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6+ULL7zHs903W4CzwDxo2VDPpXoSnQpecwRVv/mwJMcJNR4Vv
	2IYwTrIYh9o95oL7OHzRuetXWMMkE0bxxNJOz/XvjZsFoWdJiXsyLTOmbqbpN5yVyX+g22A7laz
	Mppc618EjhMRsCkvIiwMNrmB8haZM5No=
X-Gm-Gg: AfdE7cm5rqvyVovR0jflpoe7f0mmQ1obVkZ2hEwt57Hq/5iMBuiCfvPpcnF5DPFdnSS
	Xyn+s6fwq4vqV4k2qPEno4H9hlRUwzy8zuOBgNbOYPT8LwDhnGigBIJcO9JHfAQLEMrQM+OabB7
	SBG9Gxa7I60aCynomnHJs9tfZBGDdOTLcL7Y0h78wTraZGuO9yJAMyQY6R4CUxCXU7D5/TBYQZJ
	PBIDROwNXbTCmuamRy6z007gXGmHioDRVY3WrDoeAGHe+lpQBOkdkEtTuXy512Xo5KWaEMAeYN+
	mTHVJ3WOgVs5mmO0wNGzaw9zZcShDxo=
X-Received: by 2002:a05:600c:1993:b0:493:b549:3be0 with SMTP id
 5b1f17b1804b1-493c3cdec7dmr11711945e9.17.1782913414133; Wed, 01 Jul 2026
 06:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com> <20260701-kasan-v3-3-bd09bb942d86@bootlin.com>
In-Reply-To: <20260701-kasan-v3-3-bd09bb942d86@bootlin.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 1 Jul 2026 15:43:14 +0200
X-Gm-Features: AVVi8CcJ4nu4CgC77rt5bmHSBbezlbOVmQluh7pACcz4JswCAgdtoM35RXoiH5E
Message-ID: <CA+fCnZcJzRvq9942LXgTpq5067u4DvXQRjdNDpq-5vOZpQuCVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/10] bpf: add BPF_JIT_KASAN for KASAN
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

On Wed, Jul 1, 2026 at 12:03=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundatio=
n)
<alexis.lothore@bootlin.com> wrote:
>
> Add a new Kconfig option CONFIG_BPF_JIT_KASAN that automatically enables
> generic KASAN (Kernel Address SANitizer) memory access checks for
> JIT-compiled BPF programs as well, when both KASAN_GENERIC and JIT
> compiler are enabled. This new Kconfig is not a user selectable one: it
> is either automatically enabled if KASAN is enabled on a compatible
> platform, or disabled. When enabled, the JIT compiler will emit shadow
> memory checks before memory loads and stores to detect use-after-free or
> out-of-bounds accesses at runtime. The option is gated behind
> HAVE_EBPF_JIT_KASAN, as it needs proper arch-specific implementation.
>
> As KASAN instrumentation for eBPF program will depend on the info that
> can be accessed during each instruction verification, there may be
> instructions that will be instrumented even if they don't really need to
> (eg: global subprograms that access caller stack memory passed as
> argument). To make sure that those additional checks do not trigger any
> crash, make sure that VMAP_STACK is enabled so that programs stack has
> shadow memory allocated.
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>
> ---
> Changes in v2:
> - add dependency on kasan for vmalloc and vmalloc'ed stack
> ---
>  kernel/bpf/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f0..a8e004f88b92 100644
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
> @@ -101,4 +105,9 @@ config BPF_LSM
>
>           If you are unsure how to answer this question, answer N.
>
> +config BPF_JIT_KASAN
> +       bool
> +       depends on HAVE_EBPF_JIT_KASAN
> +       default y if BPF_JIT && KASAN_GENERIC && KASAN_VMALLOC && VMAP_ST=
ACK

I think it make sense to put KASAN_GENERIC into the "depends on"
section, as __asan_load/storeX() are only defined for the Generic
mode. SW_TAGS mode is expected to be soon implemented for x86-64, and
that mode uses different checking function names.

Would also be great to add description for this config option.

Thank you!



> +
>  endmenu # "BPF subsystem"
>
> --
> 2.54.0
>
