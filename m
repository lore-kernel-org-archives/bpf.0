Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F693B47F7
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877111; cv=pass; b=VblvX1FBWSkhbYi1nez/s4pE0tuEtvMqDP6Qkv6aF30oHcyAg8NhMgCavkOuOlDrOZYEodOxZefukH/TMxthx7eKXXqund3Ota8eITJXSAXE6GLhxPu2JO9e9LDefDjQ+kYFoRXco4wBV/NW0sp6iCqm8Y199w+93YALofDLjEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877111; c=relaxed/simple;
	bh=9OMOUObyA/NJI8Nj5AuEVkMo+9Md8jL717X6LDMVPXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqVH1Th6/A7dscTJv5db8xxKke439SC4GahbFJBk7O5Pjt6U5tmp12K95MbZGuktHstO6BAmUL8h3IDR0lyfWAxoX2Gvb6+XiEnR7tFA/DSPCSWvf/JhnQ5QTpVJk6vZkQkk5ONJXiJCvcbNr45ImNhaPJA7bTiKATLZkIsZNEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxK/ARjG; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxK/ARjG"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c827313dac0so685023a12.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 13:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778877106; cv=none;
        d=google.com; s=arc-20240605;
        b=TtOPArbL4l1+qyMN9FmVV5MtWMvtNs3X3xy+i6vlJmghbGlazZytRpfY2XGRo9dzo0
         acAgTignKvcbaSUn836G2I5jHOLen1TtxHTVx39CSwVIwpHVVRGqmgbVEUd0nDwoKvpm
         Dmli0GeubwwedOBoRp/wVWVSiAqxrYthscfwf58kQ/MhQrwU7iO+m6qpRCxEMRraELf6
         gJs4g3aY5cH4X1MJdELvs4+EOQRnTgXgCcEN0vtqsXaMQTytV8k+M45p000Ojoofq+d8
         KUoWo9kOLec3lz6AED86WwHxv0Jar0QBce6fNIqLWYpz2h+xMXlpDLMR7A2PoLEZEQ9e
         kvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GfKMCbzq+rYGH17flAZI0P8SiAo/th+/psoW2A9BSc4=;
        fh=MvGIOrVCjjHAZCppGKn+WFWHQl6YhaO3PPmVwuICQUw=;
        b=Kr5ZO8s+TWlOttNfHpCWnkSDRIhWsEXKm5Qqag0prShGZh89rbIWxHyxIMMZlpZTrt
         wOd8IiumifosPIQsDMi2cz+OEVp0SAoIjbgHwejEHlyvPPvSUUsQV27zeU2zEZMehKJf
         xZLhL5Cgg1y7Wni3TjePVekfoJdBc08hzOIWfKFXy7wo+7O9WmaC/nDhQit3ImEqvo4r
         64aQumZ+e7v0Bkm+EISJ9zoYhOJSbsNY3l+TB5oXLXA84y3fZyNzBI61x2FiSsD/8War
         mF8j7IUIVOdoi8B/tEp9kusist+EXdhoUSO1VX/I4NnUg+V9+Qgnv2+ts5kl9kx++j43
         Drsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778877106; x=1779481906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfKMCbzq+rYGH17flAZI0P8SiAo/th+/psoW2A9BSc4=;
        b=bxK/ARjGYj3qePrf/PXxgkNvSEO82j7+vGjDXHLEbf5az10TkChLRa2r8SQ2oU2kod
         ndLFWbFDkoKtN9AxZ2NSXRewttsrWIYhpa3yQtRTC6r1+58J4DHYBkhcd2koCZanrUzA
         Lp3znOSLYTxNK7xlAJYVmRt4Uu33pV29+sF0ZBRYQj5lIrb5La/q2xVkEq1g7nWSMXjJ
         xwy+ZY1t+qIAs1doLgjQfhFRawG7gahyqpTekLEmgQCuw9dUrFI8oPmarpCLLxCDZBZf
         Sr0Bm36QZPcXFJ/SfuHqN4uVDe39BxCvIhcCnxbyXrja0dIknV2REUsBxzBChDgpd0y3
         KZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778877106; x=1779481906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GfKMCbzq+rYGH17flAZI0P8SiAo/th+/psoW2A9BSc4=;
        b=Z4aGgJSpmZ4OejTWcGi3b+3R1EcxnVhbZ3m+u5VT974xKr3xOMHukI0Q/i3eufNvqp
         hixt/49YaPnEY4Q9ypY1P4cjriSKTyjHPyK248l8OjjX0tU6ko0CgvuxD8lL7Xt/YwXb
         xlKKGQ/cN11D4pNDJ+XwBYBIkqeB8M0/YKn7HPzo+1z4hS27GBTnJyBXjULlDSJztWvY
         beFiZjwK59vV7gmZvTDduGVPDk25KKjN3Q5/mo45ciWndyx5CMxhxOZ89FHTfx9hwTo7
         USfu+eh2gnQd959s2TOmYcD1EhaqVJXLGWiQHB8Yx9nQtlAV/eg52HD2PeRossgc5MdE
         gqFw==
X-Forwarded-Encrypted: i=1; AFNElJ8oNGzRmIVu3v5DGY0r3ZEVQtfkuxB0P69e1o+ymFv5l4BcLRL9IuQtpDTD42Lw/yePpho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZLR0riHie0KmBIGDRvRQ65Rm3QEhUT9oghGChoZxbHHNBbXN
	eiERG/upRBwaLfaVVYhsEGqy9jxo6i1uuNvBBq1UnyOg0hOAurxIa/rflU+RqutBnLmign5PI//
	GZRvfslvaFNkogEv2IEm/CzY6PAHjh2s=
X-Gm-Gg: Acq92OHI0X466jrmhZUfmXAbvKdUmXI4R9C6Dm+xPBy6l3Lst6ru9h4lxNtd7S85tdp
	Su4hqy/fya7xgDEdQ+nAd93T34s6N1iBQpviBZCZwMYsuSLrBzsjPBEwrWAcfM6uOT1M7AN70sZ
	k0X3n9xO3EfEqzc4DFzaFKhx/i6kx+2xB2j6IJ07sV2IR+YRTHpFIfjajpE3XI4kn/OtknmIsBw
	87gWyErGq6jdhFlDaAjZotbkamIICO94Xxol17dCFvCXYhIb91QFWqMNG/5Hcr+8gFtVTSneA6F
	6UBzRqHGkr3h38Z+CyAndbWSGfHrvqqt1Q==
X-Received: by 2002:a17:90b:1d8e:b0:35b:d795:cf5d with SMTP id
 98e67ed59e1d1-3695137f713mr4228692a91.5.1778877105837; Fri, 15 May 2026
 13:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514135342.22130-1-jolsa@kernel.org> <20260514135342.22130-2-jolsa@kernel.org>
In-Reply-To: <20260514135342.22130-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 May 2026 13:31:31 -0700
X-Gm-Features: AVHnY4IkXbPoE27Y25mhMhjX45nN-pzqZNIcNXqxHbAb6I9OJRsGCw2MdyrOT6c
Message-ID: <CAEf4BzZxNLEeyDE2aJVm=T=RzDayaHzAbHxXQqn6M6uqa45obA@mail.gmail.com>
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 6:53=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Andrii reported an issue with optimized uprobes [1] that can clobber
> redzone area with call instruction storing return address on stack
> where user code may keep temporary data without adjusting rsp.
>
> Fixing this by moving the optimized uprobes on top of 10-bytes nop
> instruction, so we can squeeze another instruction to escape the
> redzone area before doing the call, like:
>
>   lea -0x80(%rsp), %rsp
>   call tramp
>
> Note the lea instruction is used to adjust the rsp register without
> changing the flags.

I think it should be very loudly explained that we can't go back to
nop10 and have to do short jump over patched sequence (and why).

>
> The optimized uprobe performance stays the same:
>
>         uprobe-nop     :    3.129 =C2=B1 0.013M/s
>         uprobe-push    :    3.045 =C2=B1 0.006M/s
>         uprobe-ret     :    1.095 =C2=B1 0.004M/s
>   -->   uprobe-nop10   :    7.170 =C2=B1 0.020M/s
>         uretprobe-nop  :    2.143 =C2=B1 0.021M/s
>         uretprobe-push :    2.090 =C2=B1 0.000M/s
>         uretprobe-ret  :    0.942 =C2=B1 0.000M/s
>   -->   uretprobe-nop10:    3.381 =C2=B1 0.003M/s
>         usdt-nop       :    3.245 =C2=B1 0.004M/s
>   -->   usdt-nop10     :    7.256 =C2=B1 0.023M/s
>
> [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org=
/
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel=
.org/
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 121 +++++++++++++++++++++++++++-----------
>  1 file changed, 86 insertions(+), 35 deletions(-)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index ebb1baf1eb1d..f7c4101a4039 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -636,9 +636,21 @@ struct uprobe_trampoline {
>         unsigned long           vaddr;
>  };
>
> +#define LEA_INSN_SIZE          5
> +#define OPT_INSN_SIZE          (LEA_INSN_SIZE + CALL_INSN_SIZE)
> +#define OPT_JMP8_OFFSET                (OPT_INSN_SIZE - JMP8_INSN_SIZE)
> +#define REDZONE_SIZE           0x80
> +
> +static const u8 lea_rsp[] =3D { 0x48, 0x8d, 0x64, 0x24, 0x80 };
> +
> +static bool is_lea_insn(const uprobe_opcode_t *insn)
> +{
> +       return !memcmp(insn, lea_rsp, LEA_INSN_SIZE);
> +}
> +
>  static bool is_reachable_by_call(unsigned long vtramp, unsigned long vad=
dr)
>  {
> -       long delta =3D (long)(vaddr + 5 - vtramp);
> +       long delta =3D (long)(vaddr + OPT_INSN_SIZE - vtramp);
>
>         return delta >=3D INT_MIN && delta <=3D INT_MAX;
>  }
> @@ -651,7 +663,7 @@ static unsigned long find_nearest_trampoline(unsigned=
 long vaddr)
>         };
>         unsigned long low_limit, high_limit;
>         unsigned long low_tramp, high_tramp;
> -       unsigned long call_end =3D vaddr + 5;
> +       unsigned long call_end =3D vaddr + OPT_INSN_SIZE;
>
>         if (check_add_overflow(call_end, INT_MIN, &low_limit))
>                 low_limit =3D PAGE_SIZE;
> @@ -826,8 +838,8 @@ SYSCALL_DEFINE0(uprobe)

should we change -ENXIO to -EPROTO or some other distinct error code,
so libbpf can avoid using nop5 attachment on kernels new enough to
support nop5 optimization, but old enough to not do this properly with
nop10?

>         regs->ax  =3D args.ax;
>         regs->r11 =3D args.r11;
>         regs->cx  =3D args.cx;
> -       regs->ip  =3D args.retaddr - 5;
> -       regs->sp +=3D sizeof(args);
> +       regs->ip  =3D args.retaddr - OPT_INSN_SIZE;
> +       regs->sp +=3D sizeof(args) + REDZONE_SIZE;
>         regs->orig_ax =3D -1;
>
>         sp =3D regs->sp;

[...]
