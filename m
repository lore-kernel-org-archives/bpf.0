Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC264AEBE4;
	Thu, 17 Sep 2026 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688988; cv=none; b=WFZ60xnPeV7FJGJVrYuJQ5KE+xDiNTXYFI96b/ix5AuOcZksgjUdKBlL0I5d3NBiZKtfnY7qqn43eAh1wyv0Gh7NL5zFrVMlFXSVQ8Y2nErDNGAnO5ljZXyYeFExwOJfuciu6SXAlA19xB4KEw/S3lyo/V8GLo8TYuAHrB4hXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688988; c=relaxed/simple;
	bh=c4jpVS5mimtM1nAX96GRWi1jm9CewtBxJ09LwY03vng=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qR9b0kVnSACDZAUBtoUwLS2D3CoRwv4+UK9W25VCH/WrDmIe7LkO+ofuX+2WQC1lAbcraNdP9rIu0VlFZaxTUoVIVAeR+jmvLHtDNK0Nrc+rUJK2qpJaomsw/law458/eR/3VaYS9Z+xxpfeBrM45pWemtglbbH173fpqjO74w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sid2cVmU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sid2cVmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B18C1F00893;
	Thu, 17 Sep 2026 23:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789688986;
	bh=VagvpoC7o+wosB0YXPDcway2+++m7SLZ0SGSIXuxt28=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Sid2cVmU1ZbtiuT3X5ebKPtdM5I51CpdHzOKq3i8Sa6KdONiAu2+FHspXKq8qTeFi
	 AHMgWRPeQjgxmTgMedZHl8WTJU6PdpogC6cC1/4jI9XyDAx30LGLbGQRlbcbQR2EtF
	 8bmpFCotLNRiV8D3Tioi5ZSy55Ogl1f7PJ+u2ua+INItsM8xQ8Tn/syOTgYXmUBMih
	 3d6HrqedJuV71adSDpMa0kTisM9Dss8KECIhFxV6N8kIb8EhfMVJmYF03tAjLSBVP+
	 AS4Utm9wRcS6ppkwe631Ape4mh8LlfgZ5Vc8ejcg1vdFCZaa4zVRwjcbGrYFpHHgMD
	 kyVN/mD+lgU4g==
Content-Type: multipart/mixed; boundary="===============8739673785949913501=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a9512df5e75c264e0f20e8e61da2e3d8b2c7e6e5212217490acb7a94ed609bda@mail.kernel.org>
In-Reply-To: <20260916195203.1099646-5-ihor.solodrai@linux.dev>
References: <20260916195203.1099646-5-ihor.solodrai@linux.dev>
Subject: Re: [PATCH v3 4/5] x86/cpu: Move 32-bit SEP setup into identify_cpu()
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,bp@alien8.de,dave.hansen@linux.intel.com,mingo@redhat.com,tglx@kernel.org
Cc: ast@kernel.org,andrii@kernel.org,ryabinin.a.a@gmail.com,akpm@linux-foundation.org,hpa@zytor.com,andreyknvl@gmail.com,linux-kernel@vger.kernel.org,x86@kernel.org,bpf@vger.kernel.org,kasan-dev@googlegroups.com,linux-mm@kvack.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 23:49:45 +0000 (UTC)

--===============8739673785949913501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 2b2a4c40ef76c..83d613d07997e 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2126,6 +2126,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  	mcheck_cpu_init(c);
>
>  	numa_add_cpu(smp_processor_id());
> +
> +	if (IS_ENABLED(CONFIG_X86_32))
> +		enable_sep_cpu();
>  }

Does using IS_ENABLED() here comply with the kernel coding style?

Looking at enable_sep_cpu(), it's declared in arch/x86/include/asm/processor.h
as `extern void enable_sep_cpu(void);` but the definition only exists inside
`#ifdef CONFIG_X86_32` in this file (arch/x86/kernel/cpu/common.c:2138-2160),
with no `#else` stub for 64-bit builds.

Documentation/process/coding-style.rst explains when IS_ENABLED() can and
cannot be used:

    The compiler will constant-fold the conditional away ... However, this
    approach still allows the C compiler to see the code inside the block,
    and check it for correctness (syntax, types, symbol references, etc).
    Thus, you still have to use an #ifdef if the code inside the block
    references symbols that will not exist if the condition is not met.

The symbol enable_sep_cpu() won't exist in 64-bit builds, so this seems to
be exactly the case the documentation warns against.

In practice this links correctly because the kernel is always built at -O2
or -Os, and both GCC and Clang will drop the untaken arm of a constant if.
But it depends on the optimizer eliminating the dead code before the linker
sees it.

A survey of other `if (IS_ENABLED(CONFIG_X86_32))` sites in arch/x86 shows
that they all reference symbols that exist in both builds, making this the
first site to rely on dead-code elimination for link correctness.

Would it be more correct to either keep the `#ifdef CONFIG_X86_32` around
this call, or add a static inline stub for the 64-bit case in processor.h?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35285131592
--===============8739673785949913501==--
