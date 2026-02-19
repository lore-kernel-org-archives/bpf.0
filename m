Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E3D342C8F
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771523292; cv=pass; b=DEE42e0tw86ENUTjSSHxWaY37S7UsPl1j1dlkygLubmI9Gdls/jhLW/2VRlru860cHK0yKS8YtUMVzGh+UUHkcdL9/dTM3taWGa8pWQA0jzip8mZCeXan9bVtgskLeSlFXOyGAEbvL9c9e6XBgwE6bLGg9OjMyUsjO9cdzDUjNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771523292; c=relaxed/simple;
	bh=60uAjxQjjAvkmuwXuk/0K+9B6lmy2ELyGpJMetuRYD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/jo4/36UhpQ9e1Py9uN4OSx9wxgt2ju40B9rClwT61Xl1u2ML5t8BYylvex1magynBxpjAG1M9GRDnCQuTfAyrE5ZUFkwQdu2KSfxN9RobkRYU5IxpypcpM/LEW+SC5k+yKLbDG27Jy0gWSXfKLMvyXMNeFSBdz1yKqWNLGI0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft6jMZGO; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft6jMZGO"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-437711e9195so873377f8f.1
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 09:48:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771523289; cv=none;
        d=google.com; s=arc-20240605;
        b=JzN4Sy68UXnHuasXEKgsRtPJHm9YufgrVZcty5h+dtncmoIFhj9C5XV0YOqixjHKQL
         Rlv+bHO50aiGjBSodb5DlmwQCksJwT+lCPWKUvmcwnuB/BYY7tOYYktcV4d+EZgsKfCC
         RUHO9O5uX/7tFK4T28aRJdoL2ub0hEdasp8q3q10oebKUu13n9mbT5UdEaoPdNlwq/l3
         mbRP/HuojGnCyamP4CvLaNsAggmUR/VKUrRgBVFdNXEah2WXXTV6eITmBuYik7JsEKCE
         rM6BoCxhwppE8BUiY/45/exLVoPs0iVUweeevY9VbJ6K3C5+KWviGbl/uIUW1Trmh/8o
         BJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qbNsSPMZwv1/3WEUw4zg9sK7Xs2yLlNrYKE6jqFxkMY=;
        fh=RfyL9753mxwlFzZ2AM2nqAyVKxmRN7jY8rNOcnPmHW4=;
        b=K5be0G9PycsmLC0lyzS/v5JiWl6erhroESg8N1G6AaWfJNUF7fIWWIqnsRs0G2XLE+
         nSBn/JpkE+nZnI4c6/mJzu5afPXjBcaKBLYVVe7b0HbKZmJ3vH5UDszeCfmTi0A8c9JW
         SrPtT+z9cqdIbbgDgjozyCl3NKLlQV4NWpjy6mEGNadt1d64+Qgs+vLD7ksPmBeS/xuy
         tSRlGTBBV8lJf0QRic4+6kfufCGqvGqy01pMNqBxN78QkDO/9OJ8okL5vg3XnoIyDvRw
         OXGzDxAwR9whkcA/0xVC9fyPhhdo2qJ0xsvlEvgNzu/L08i4RC1/UxPC3RnmitHgDcmB
         AKTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771523289; x=1772128089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbNsSPMZwv1/3WEUw4zg9sK7Xs2yLlNrYKE6jqFxkMY=;
        b=Ft6jMZGODzFMdNEkpgZzgREMuTADdBm53rxG96Q4S6LfKagXduBx6j8gBBkH4P+Vfv
         vavvNpvdK9bSO/fAQS322QgbIxWySJ6YN4ZFNpnUaSdRPxnVbkgw8YLF57/NWjUzFbww
         PN7kY9czZmd0nkuUF5E4umYYPt91q3u02J0pXCz2SsX8Egr+770ulgD5XFUOOgdAGm0J
         q9x2YYbBR7Kk5zAqW9oO/mvi7/+1VKfsNB/EdhYoIuq5E2s2qAiJbNPfoYH1L6ZVnL5i
         cFqejaAN/bf6UmNE3/0DHnze9ooc/Vdg8n4bYTQgoZQRzFt5XJCGGVh7MA1P89D0ghxI
         L6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771523289; x=1772128089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qbNsSPMZwv1/3WEUw4zg9sK7Xs2yLlNrYKE6jqFxkMY=;
        b=aCpPLSY2SVuyCn+5qkZCg2/GpmHhpHuxGkiUHht4iCBA3K4+XVnJw1YND9jLJYGBuO
         /22q1d5OkH8RUxRbxN7sNqUxySV6bjTFWWujn40kGDikpjC8GfYjMECDQZjYYeQimARt
         W3W4Fg1Lfi9Tw7tLE7ZaCxMS4pQ43YA50cN+Jivrbzks/BQewxQy891W5tD7KrnHT86n
         VD3IrlQ9tZ/5uxtRRjwrfhQI7Yxth2LTggmryGuRGYg+S54PqabOhF1Q6cilKPxMUNAQ
         Bm/bI6W+2/L/3iol2FcQYIV5prfOHjo21JcvWgwDhT4iqmFyU0A0imio9H9jyn1VWKYY
         dY1Q==
X-Gm-Message-State: AOJu0YzAsVGhhzKMrrUQbHOefIp0MNeHcBbHjHdXakprfgDpB4GigJwJ
	IUjQ6CpriY506PcEmYkvH3sKqagV/dSEW765tiOFTPBiOHz+IBSRbfb91kLoEIBAzO3T8Rjja/k
	E2tMIknchp4ah0V6U3A4pkS5xpxI2AnQ=
X-Gm-Gg: AZuq6aIh1QlznFP9HCgaCr41seKkPvlLKzA170rXtCldiRJn3eU+rY3FDFGHW3si1PO
	EqSuSMTzWh4O3loFZv+UtUenpWwFRwLlqNhB82+8+/tH/mfgkei9bKA0NJdYWOUkExpEf3cEV4G
	e0F9TfUAtuR0G1RMxXj4+M+L+zQWIInO2BrGh8oMs4dP+sHpKXGLvIXFXn7SEICDYGcmoPZ8Lsp
	66Ehp9zQ2uXeTwMPz4xWCtM9+ff0UyxnvrTQ8+SRVibJz6VEL1RqEfr/xerRQwh5eXwneeqsLjy
	3zUq6zH7xfPmgkcBzad8d4EWV2WQXXmJ2Wd/m0Bw4AjpD5OAmSagsjOWfoBMr+/ZdPOXdOyJOS4
	fZAHZZ/rv28gBlMrMggU=
X-Received: by 2002:a5d:588d:0:b0:436:369f:39fa with SMTP id
 ffacd0b85a97d-43796af9ed9mr39572765f8f.44.1771523288626; Thu, 19 Feb 2026
 09:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219142933.13904-1-leon.hwang@linux.dev> <20260219142933.13904-3-leon.hwang@linux.dev>
In-Reply-To: <20260219142933.13904-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Feb 2026 09:47:55 -0800
X-Gm-Features: AaiRm51ncUqJvIXG5s9TUaGOjPI7tmxDZZwdTCvAAoEMmGM4win76dnirbBawFI
Message-ID: <CAADnVQLNmQGKf5S5ZNwHYzScYBhnWFmnzLg=5Xxy4SgYKE3EfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] bpf, x86: Add 64-bit bitops kfuncs
 support for x86_64
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Peilin Ye <yepeilin@google.com>, 
	Luis Gerhorst <luis.gerhorst@fau.de>, Viktor Malik <vmalik@redhat.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 6:30=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Implement JIT inlining of the 64-bit bitops kfuncs on x86_64.
>
> bpf_rol64() and bpf_ror64() are always supported via ROL/ROR.
>
> bpf_ctz64() and bpf_ffs64() are supported when the CPU has
> X86_FEATURE_BMI1 (TZCNT).
>
> bpf_clz64() and bpf_fls64() are supported when the CPU has
> X86_FEATURE_ABM (LZCNT).
>
> bpf_popcnt64() is supported when the CPU has X86_FEATURE_POPCNT.
>
> bpf_bitrev64() is not inlined as x86_64 has no native bit-reverse
> instruction, so it falls back to a regular function call.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 141 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 070ba80e39d7..193e1e2d7aa8 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -19,6 +19,7 @@
>  #include <asm/text-patching.h>
>  #include <asm/unwind.h>
>  #include <asm/cfi.h>
> +#include <asm/cpufeatures.h>
>
>  static bool all_callee_regs_used[4] =3D {true, true, true, true};
>
> @@ -1604,6 +1605,127 @@ static void emit_priv_frame_ptr(u8 **pprog, void =
__percpu *priv_frame_ptr)
>         *pprog =3D prog;
>  }
>
> +static bool bpf_inlines_func_call(u8 **pprog, void *func)
> +{
> +       bool has_popcnt =3D boot_cpu_has(X86_FEATURE_POPCNT);
> +       bool has_bmi1 =3D boot_cpu_has(X86_FEATURE_BMI1);
> +       bool has_abm =3D boot_cpu_has(X86_FEATURE_ABM);
> +       bool inlined =3D true;
> +       u8 *prog =3D *pprog;
> +
> +       /*
> +        * x86 Bit manipulation instruction set
> +        * https://en.wikipedia.org/wiki/X86_Bit_manipulation_instruction=
_set
> +        */
> +
> +       if (func =3D=3D bpf_clz64 && has_abm) {
> +               /*
> +                * Intel=C2=AE 64 and IA-32 Architectures Software Develo=
per's Manual (June 2023)
> +                *
> +                *   LZCNT - Count the Number of Leading Zero Bits
> +                *
> +                *     Opcode/Instruction
> +                *     F3 REX.W 0F BD /r
> +                *     LZCNT r64, r/m64
> +                *
> +                *     Op/En
> +                *     RVM
> +                *
> +                *     64/32-bit Mode
> +                *     V/N.E.
> +                *
> +                *     CPUID Feature Flag
> +                *     LZCNT
> +                *
> +                *     Description
> +                *     Count the number of leading zero bits in r/m64, re=
turn
> +                *     result in r64.
> +                */
> +               /* emit: x ? 64 - fls64(x) : 64 */
> +               /* lzcnt rax, rdi */
> +               EMIT5(0xF3, 0x48, 0x0F, 0xBD, 0xC7);

Instead of emitting binary in x86 and arm JITs,
let's use in kernel disasm to check that all these kfuncs
conform to kf_fastcall (don't use unnecessary registers,
don't have calls to other functions) and then copy the binary
from code and skip the last 'ret' insn.
This way we can inline all kinds of kfuncs.

pw-bot: cr
