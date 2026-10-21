Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614622;
	b=iaKaAim+1PPFvmU41M3XB+fL1Jgn6OJYEA7/KJlvw2tc81iZbsIQWR+OxlZXehwANp73
	 hpdSU2PtwGLIfQCOuPwh+5o7Hxw/CV9vfhHwq3UB2o89VGN3FoKXiYJ5oBB0K3u1gTycH
	 WFHdTPDK1rm2YIe5tanGYVYSegf63kEWQRL4oz1iaNkDYSos3SWRXIOhYN3uz5Gb4rkhU
	 W9CMUezAguJT6wIQ2qcYXm5cOzAtVUy6f8xmaVWVkwDfxvS8bMGdQSa60iGoVW64+rCG+
	 u5FBOK4uw47k4dgIDHJD22V5GeLIH4SyyLJfHu2ke6wrMbuJyK5c/Y/VblV16SnE/hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614622;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=uwBkRONY0CxUKcgJBta2oRbm5jvOfx9iSukmJuTzqv4=;
	b=41bA52Loo8EpMmkulaSa3UEUNDZ45FqqJsuZH+b2n99+ni4/WJu7W+t6WMgr4ZQYWSR5
	 hT/i5WdV1cgd6gBJTfRGTkYl4GodGPr1PPLY8DMMq4WlrKQpWcCFgU73x8bGoaPUnpxAg
	 w7hFMf/n12NVoqef1dN1SHylKUQsu2U6TQil0PuiXNwAXdKTDRnnop5RoaxXLp9PtnPsR
	 UNyOQgN+CnBaKVV/RaeE94pevut0WB7ewpc5ltSchxP8nIHdNKXaEibELhuV2JIN/xzWb
	 lxA8M2M0CfJRwsz9D6oHXPpPVcUw9J2vvtHw4Zwe4Vae1bCYwe1EnR2o6amI1hvQX0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLLeibpO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CDA606A31E;
	Wed, 21 Oct 2026 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLLeibpO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025CE1F000C2;
	Wed, 21 Oct 2026 20:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792614622;
	bh=uwBkRONY0CxUKcgJBta2oRbm5jvOfx9iSukmJuTzqv4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CLLeibpO1keZ3tdRCvObTo1eEBK7tX6BN0OuXHfZaOGjHJtoExLwKdBOgi2bOXNrs
	 oVkQDSP7i1F/+PQbm0pGGr2VjSSEL/gvzz6ZZvHEJ7xX9WSihbVM11b7b73801RMW+
	 lRTD5UZaBxie7jPyczwPF60WZ8Bfx6dv+BjXsZZVgKBIspEyIh/vt7C7W4F3RnJ4Qj
	 vi7NdDmf2zXv9YPyNAPmIYNaygBi8inTgK6uoacsjBLio5WoruKGKuVuUNl+lQvaIW
	 lKmv7/BI3oVLIe9xbOdctGsoWyr0855n4mUEJtlf02X5aZC9CJPmIbTt5KLnUnDgcT
	 ZPXpPc1yr3S3w==
Content-Type: multipart/mixed; boundary="===============6870614147643086696=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ee17ec2f4f03fc7b762617b22b31286cefc0e3eaaacb6b89e2cfb559b0b6ce6e@mail.kernel.org>
In-Reply-To: <20261021195759.119421-4-jolsa@kernel.org>
References: <20261021195759.119421-4-jolsa@kernel.org>
Subject: Re: [RFC bpf-next 3/9] mm: Expose locked mprotect operation
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: bpf@vger.kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,linux-mm@kvack.org,akpm@linux-foundation.org,liam@infradead.org,ljs@kernel.org,linux-kselftest@vger.kernel.org,shuah@kernel.org,john.fastabend@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 21 Oct 2026 20:30:21 +0000 (UTC)

--===============6870614147643086696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> mm: Expose locked mprotect operation

TL;DR: do_mprotect_pkey_locked() has no !CONFIG_MMU stub, so once the next
patch calls it, CONFIG_MMU=n with CONFIG_BPF_SYSCALL=y kernels may fail to
link.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 63f40e615754..47e853093601 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3435,6 +3435,9 @@ extern long change_protection(struct mmu_gather *tlb,
>  extern int mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	  struct vm_area_struct *vma, struct vm_area_struct **pprev,
>  	  unsigned long start, unsigned long end, vm_flags_t newflags);
> +/* Caller must hold current->mm's mmap write lock. */
> +int do_mprotect_pkey_locked(unsigned long start, size_t len,
> +			    unsigned long prot, int pkey);

Can this declaration lead to an undefined reference on kernels built with
CONFIG_MMU=n and CONFIG_BPF_SYSCALL=y?

The prototype is unconditional and there is no !CONFIG_MMU stub, but the only
definition is in mm/mprotect.c, which is built only for MMU kernels:

mm/Makefile:
    mmu-$(CONFIG_MMU)	:= ... mprotect.o ...

The next patch in the series, f62943356e31 ("bpf: Add kfuncs to allocate and
seal user pages"), calls the helper from bpf_user_page_exec() in
kernel/bpf/helpers.c with no CONFIG_MMU guard:

    err = do_mprotect_pkey_locked(addr, PAGE_SIZE, PROT_READ | PROT_EXEC, -1);

helpers.o is built for any CONFIG_BPF_SYSCALL=y kernel, and BPF_SYSCALL has
no MMU dependency in kernel/bpf/Kconfig.  Builds without an MMU do appear to
be supported for bpf: arena.o is explicitly limited to
"ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)", and ced6a0993e2f fixed a
!MMU/32-bit bpf build break.

So once f62943356e31 is applied, would a CONFIG_MMU=n, CONFIG_BPF_SYSCALL=y
kernel fail to link?  This patch builds on its own, and nothing up to the end
of the series (1b0c19c85c7f) appears to add a fix.

Would it make sense to either declare the helper under "#ifdef CONFIG_MMU"
with a static inline stub that returns an error, or add a CONFIG_MMU guard
around the kfunc and its BTF_ID_FLAGS entry in the bpf patch?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39668036298
--===============6870614147643086696==--
