Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12073803C2
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776118828; cv=pass; b=OtebSoSpPtsFyaAL10kIdx0JaB2fkJkvqD8u513k4UvTANPTR4TK2E2XaE5P/33Le8YSKZ+vORraUDdlauDbiVxmHiiytDuih2dYMb2X05UJKVKNFbUoP9KOx/4KMXp415LGvKKBGRiOuuY+B58z8Enhyt2Yu2ZLovVNEb+lhuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776118828; c=relaxed/simple;
	bh=vxVQ2muHMuW2TUZfvshASG/qQsXz8ZNjUFFlQbYxcsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jbs75fSMZU37NsPxRDHoDu8kuiiho0GYE472XMg6WUh4ShIVuzurM2BCqBDEDpQucBT/eLQ7tg4Q/agtecVhU2gcdAPhp+njqjw4xE4mtxvFYBPFDfbcu4bRv+yrxuLuD5JZpgTDNBW4ExuPwJEV9BTkv+tqx9rVIoFgCTvbmw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUuHEjv9; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUuHEjv9"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so3166281f8f.3
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776118824; cv=none;
        d=google.com; s=arc-20240605;
        b=DYjX7kjrZujWmT4jgkxR7dEgLrLynpKDeOsRGqV7UzSu5kwcvLZWYQ0fslTKcBQhAq
         D/upEASvTCNdb/Px1u27cK/t6ewgt509wgGROkNbLLM7QASmYFU2Q72EGnSp4b9jLDKH
         gSx5ooO/Vi5eouu/EysX8wC9OrDo9Yc62AbTFs22AZh/NXAePDEzixNsH75v1pZ4c7DJ
         1UwoXeWZaOmLSbbn+1eLYhNM34UNPy5+Cb8dCpFsMFCX+Wp2PaDBoP7b1j5a7T6NBAFw
         KWCWKlW1102Vfwdg+F/aUkNGGoaIIYzN+oKqF80DNkSi8oft7OH0qMHv/Txz/VzxuQua
         La9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fp+8IeHiDM+bCUp+Ky89VxSnxaC5A7VFTmU45Et8ZaE=;
        fh=OQzVlbPeH/1D1Tev7KHBIEBobHaI6NbPbwX15GEh1lU=;
        b=afCCAcI5EEdeuV7phWtrSQ3sHKhS63PPlHqG+JlpwKCDOnJedtiMdfrU6TbnlF8Fq4
         2hGqbc7QRp+JxsH6D/7f5GIMCsjU+LjzGywGwCABPdptx4txQNotMHmdBdQa6DJylUGs
         S/CWy7rwrO1FBMvKDNBxiOPcNHW6QEvxJsbGuBtHb/U+uFqXdBRwV0u7d97slWlnDHPS
         VrTqUIu+P6xML9IgCg40Xb+cWpkZeT7hJLcsWOZL0KdnLg/FGPrVVWPEWq58FL0bvLcA
         SANK+pDka79aj4WkcwF74KhBL0oXR01ZxOE9hi5EUgwiBYpUTft7jj+K3bUAI5R2RfL0
         TY3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776118824; x=1776723624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp+8IeHiDM+bCUp+Ky89VxSnxaC5A7VFTmU45Et8ZaE=;
        b=nUuHEjv9Qng0o8+V9wNyx2C1uKpl067pNckpPRU8BSVRIZm6dfPLgPqP3Lw6xvRci+
         rrcuEMkS2XRywm2h09uyOmnKTQLHjpwyQGvjUnLR+ExxnIb4xqqDFxbjpBpiCdkyHDu6
         LngF2uqRRcGoW00iNEZr0UyyjrVcwf6T9kuuWf43+Q+4040c+17+hPikRfF7B+59GUTb
         v0zLOfHxr3+GJWfTCLexySi89isOOMhUvNlxmklB6c0vrs0x3+/IhBVk0aINzdLUFyEc
         ECICpTc89k2vaIx8sS2gDTBHGv8hhUFLZY3bqeBPytXxOYF2Wvk0vylCz5nLQgfVgPUv
         tQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776118824; x=1776723624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fp+8IeHiDM+bCUp+Ky89VxSnxaC5A7VFTmU45Et8ZaE=;
        b=TtLIGQtqAkPD5u16H4IhRQPcGgEl6YUgLYgEs713PDUnXhq/AukpWQrFuvqcD0WJCQ
         Qm7YwbKbyNMVr7z0JEdmRrvydYjzZo4+cJ0pVzrAs8uukVwWi63kGPPaO9DtVmLoLhG3
         0n17ZJeXHsnRvO+0o0K2Keo2wQmXLPRt0+f+fXrvP/JY+YweLK2Vx1a6Ja7Lo64eO79r
         hdNV+hz5AYteloJ4JNkHZL+bhO7CPnpTcqfAzq3Xzm2Dx3jActyPwlLkNL+qgGzpd+bZ
         OiX6AVzegsWIFLT+hHn01VmQl/Pdh0w7JDA/qDpog4F21ni8f9rYc8JM+2+wqlnEy9+z
         5AmQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cO1xZ+cmyzfTXK3CYNyjolZKeFR/5Tz1dLwm4ZZuWRjOZLsRqgXElT1WbQrno/jp+qrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0kF2WyM4MkDaQo5qD8pUGq5xBXlWBcT93dinnfYeWuf5Z5meV
	eHxz53cUnDD+KzCFIwABjaw6kx/GgFYWcu0AplNLPq7vJKeG41hWrxm+DjfzYn60HttGrf1kDvL
	Nunxg6OTj660ta/TxBYPlZSOT4W1Cg78=
X-Gm-Gg: AeBDievVq4NnSErVYkJhsvGmFm6nrhA7dv+Zt6KysRn0iVmEwu7aXzh4cLT4oXbAV9C
	AKWVmlGIkEftEIpHw7XEhnZ598THMeXsi3tM4X1OP5FDe06Dsl+KOmuA4SGaDvolhLyIBWjDkJ8
	kUKN7HjCtwOritBZJ9cZUondtxl3BRgSjp1XTAAfRTDadUMjE37932wBKZ71uHu/RyXfiPIOp6o
	laoK1N8Zimxp2z4p3cRzqJZPRYWPv1J1mmYtLKyDuoJDB98fLoh+uqTS4pYU4LBsEFWFV8e+mOE
	h7Yglut99isWkwbmm9vjSN+MHlTJ9Pb7oV579LUt
X-Received: by 2002:a05:6000:2303:b0:43d:7af0:3a8a with SMTP id
 ffacd0b85a97d-43d7af03dffmr7155232f8f.46.1776118824134; Mon, 13 Apr 2026
 15:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com> <20260413-kasan-v1-3-1a5831230821@bootlin.com>
In-Reply-To: <20260413-kasan-v1-3-1a5831230821@bootlin.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 14 Apr 2026 00:20:13 +0200
X-Gm-Features: AQROBzASLHf5ILBNuw_x5OeLAHJGUfv8fbkKsOkNoaIfzCwURKyPvUbS0Z-ZunI
Message-ID: <CA+fCnZf-o8tiv_tX9YB5eBUGx17OpztKZsEB6Awjw3WAqBAiUw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundatio=
n)
<alexis.lothore@bootlin.com> wrote:
>
> Add a new Kconfig option CONFIG_BPF_JIT_KASAN that automatically enables
> KASAN (Kernel Address Sanitizer) memory access checks for JIT-compiled
> BPF programs, when both KASAN and JIT compiler are enabled. When
> enabled, the JIT compiler will emit shadow memory checks before memory
> loads and stores to detect use-after-free, out-of-bounds, and other
> memory safety bugs at runtime. The option is gated behind
> HAVE_EBPF_JIT_KASAN, as it needs proper arch-specific implementation.
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>
> ---
>  kernel/bpf/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f0..28392adb3d7e 100644
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
> +       default y if BPF_JIT && KASAN_GENERIC

Should this be "depends on KASAN && KASAN_GENERIC"?


> +
>  endmenu # "BPF subsystem"
>
> --
> 2.53.0
>
