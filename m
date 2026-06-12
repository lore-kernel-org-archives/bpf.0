Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781B3E3142;
	Fri, 12 Jun 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281819; cv=none; b=kInGhAg2mI7/l+NR2G8VJeGXorDLImuPtz8rtd2RPOvnm0YKvl2XBdnEDmSiPLnLHJejOLAtnluxA+IeCfmamMkS9BocBcGI53C1HIhnVilJl0X5hbhkQ2XWhBN8FOjYsSRq6kaS+ao2EABgSaOGRllR6XU76JYL4vDjpuPzPoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281819; c=relaxed/simple;
	bh=pGBQjDj2aJeWPsYi7TaMdnIvSJr91BPbvr/nvzbC5t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhYnlYW+yYkiFIDerbD9pt1lVb1ACVsqkmaJ0YD3Dcn67gmBgDi8mGMdtW3YfyxnMEJJUPEKdZcshQTPyEOgkqMNvigc2XrM64KoZpXz8tfieFU/GG7rYNp7REWR1+BKAAqFm/NFqsBq1HiLVOp4hRh1y20GjGfaXeSIX1VggbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=C83N6X9Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kXVVRqdH; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="C83N6X9Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kXVVRqdH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 8C4C91380117;
	Fri, 12 Jun 2026 12:30:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 12:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781281811; x=
	1781289011; bh=JPWIUmv7o85y77DNU8cNkhUSgD6pQKzFSK9Rh6/dB9M=; b=C
	83N6X9YVBl5cOmSZUJ9pC7/NcHioDQkEIDEmefxCV83WSGiqh/zG75U49EB9gNhL
	eQpdLKC50sfDjQ4PbF+RcylSPmYW5yqXjsADA5m+Jq6fFd2WjMJZA55Kwx9nqPyC
	s7+aHctdevRwRuwAkavgBpQswSCu2I9VCNOISXpoZeNhgTZaYJEfzkUTnmj9zUpT
	YHT+bldDdgWkEyedj9bOnubtID67wUBwk3B0hE8yFL7LFc5ZVtH++D60wklkWoKa
	xVRjuBrHOfMeV5C/GSvl73VZ0bkw3aVDRgpVh5/PqHyIS4KhE1nu86Amh9A2g070
	N2dKgqER2ir9ciEG7/SWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781281811; x=1781289011; bh=JPWIUmv7o85y77DNU8cNkhUSgD6pQKzFSK9
	Rh6/dB9M=; b=kXVVRqdH7NvGJXoomPyI6L1DzGjLvTGSK7GqXxbO8y6STXl5Cy8
	FO12TsMfGrtscwVdx2I6SEESmPG6my7nx7Pi/COQT78eF0DepOXU+yc6teBVfKEz
	Q53UbIxlDWxjzh3SH/BA/esBm7NuZDpgRmgW+rBK7DA4WFXf95grtkomaU6A+s9j
	HzcWVDJY/GnMeOAoLLv4c1Tz09K3/p22w0XIpgAys7IU1oXs4w2kSsUyXCbObfGL
	CaJC7Kjla63UwECAzQM6mbFvy1LJs5Gkl252AwMDKsX8dN4uhk7lfPircRMVNRPZ
	ppqhj2mOeOZKg4vMHRAFfKK2wqWxgnqk3zQ==
X-ME-Sender: <xms:ETQsah_K7dW98Y7oWvRFzjwl-EXYcJ85m4Z6fFaK78ow6-uglhnJ_g>
    <xme:ETQsag1M1XeMtw0fS9WBkhBQApkqYi6eS3774AtIiGSmhsCZUHJmySkmcvvuSUw4k
    RyXpBxMVeN7Jt4FvEKPT1Uj7r-o_fP-HnyYks3VZQW-4OP_VhUPQDo>
X-ME-Received: <xmr:ETQsauZT-l7MZqAyxCUqmNjUGoCdvz8UwJyew_oLWjRjomajE6yeReV56bq97g>
X-ME-Proxy-Cause: dmFkZTETIJWWZf8ko10xeT8E6KYd8EuVMIA0Cz31xlXx76CsNvlZ3aEUn7dUUu82qH57kj
    f2RHsSsq+OSFmAT1A70MvbNlhjJU6JKSZ4oW1PC5b87cZH2YRQGUPuqTBi7c5zWzu2BTi8
    1Y9gwX6IOu2TYJdFRacCRB2gCTH+AZAvbt3kMiMJ8pFUIikJM6Ltb60os/2XTy9AHUgqvg
    58puxntgllAItlimqthqFv3/AIZJHUe5YEKQPXEQAVE+RLo6418I8sItQ0/B6/ggIpj+c4
    FUJfO8C9CSTsYwkKmfBBbTLWCdzFN8hsWOk9I+5WcJO9zCIsY9nSYflQbQMCh3Jpc+0Wgr
    GLqM/erXuyvNJftHPZTjsinHEcVMkhqjCBFAsUH6AWO6HUh5v8CgRKQCXFQkpYPzIgPK0h
    Hypq56bGvBWafx3fie7CNXDMlxtDDLaXfJ72nz70XhumfvirXDwWwx/3iIbI5YZpROWJTM
    Gj+eWGH+usWort9ZVE8kvc2SAQm6jXEkgAHvTmY0CY5NTuCMG4FsNfSl9rqzPKAg3xub3Z
    yl0CpSRjxScDZx2J9epC9Bn8dGm7oa9h7iovTPUR6m4BR+sXOMylFJnMsgEkQsdwIIhKUM
    /ZkwABCnDfq+K7P45sX42uD8BxHWFpGcASDaQ9x4HKuU/3ss9eE9+OWbSSBw
X-ME-Proxy: <xmx:ETQsaktLkBo8-R-vi0ogXEisCQDRbozJSPTJqsStYKwiqyP5VMuq9A>
    <xmx:ETQsatAacXQ-QWA8VdFLims196dSrzFIKwCDiVKO1qMhay_FJ11sMA>
    <xmx:ETQsanCUzn4c11x6bRq2zYJEALigfkvbqOuT7MssNJSSlGq3cTfsVA>
    <xmx:ETQsavkWZt5zXs3ROnobBNlkThMvcgjfbT92xbLC2piqVmgCVFa2-A>
    <xmx:EzQsaktksHf3FF8v3WOEzbmdHkMnPkTQw8lNY5r6T56sCgVCCZlvyox5>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 12:30:07 -0400 (EDT)
Date: Fri, 12 Jun 2026 17:30:02 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86
 under 5-level paging
Message-ID: <aiwxWk0gOV4ZlKcT@thinkstation>
References: <20260610175651.647515-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610175651.647515-1-ihor.solodrai@linux.dev>

On Wed, Jun 10, 2026 at 10:56:51AM -0700, Ihor Solodrai wrote:
> On x86_64 with 5-level paging (LA57) and inline generic KASAN, the
> following flaky splat may be observed on boot:
> 
>     BUG: KASAN: wild-memory-access in do_raw_spin_lock+0xcf/0x260
>     Write of size 4 at addr ff110001000c90b8 by task swapper/0/0
> 
>     CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.1.0-rc5-gcba33e0b2907 #1 PREEMPT(full)
>     Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>     Call Trace:
>      <IRQ>
>      dump_stack_lvl+0x54/0x70
>      kasan_report+0x117/0x150
>      ? do_raw_spin_lock+0xcf/0x260
>      kasan_check_range+0x264/0x2c0
>      do_raw_spin_lock+0xcf/0x260
>      handle_edge_irq+0x35/0x770
>      ? do_raw_spin_unlock+0x51/0x2a0
>      __common_interrupt+0xae/0x120
>      common_interrupt+0x7c/0x90
>      </IRQ>
>      <TASK>
>      asm_common_interrupt+0x26/0x40
>     RIP: 0010:identify_cpu+0x2b2/0x3460
>     Code: 00 41 c7 07 00 00 00 00 4d 89 e6 49 c1 ee 03 43 0f b6 04 06 84 c0 0f 85 a3 1c 00 00 41 c7 04 24 00 00 00 00 31 c0 31 c9 0f a2 <89> c7 42 0f b6 44 05 00 84 c0 0f 85 ad 1c 00 00 41 89 3f 48 8b 44
>     RSP: 0000:ffffffff97807df0 EFLAGS: 00000246
>     RAX: 0000000000000020 RBX: 00000000756e6547 RCX: 000000006c65746e
>     RDX: 0000000049656e69 RSI: 0000000000000000 RDI: ffffffff98632fd8
>     RBP: 1ffffffff30c65fc R08: dffffc0000000000 R09: 0000000000000004
>     R10: ffffffff98632fc4 R11: fffffbfff30c65fb R12: ffffffff98633050
>     R13: ffffffff98633048 R14: 1ffffffff30c660a R15: ffffffff98632fe0
>      identify_boot_cpu+0xd/0xd0
>      arch_cpu_finalize_init+0x24/0x1f0
>      start_kernel+0x31e/0x3e0
>      x86_64_start_reservations+0x24/0x30
>      x86_64_start_kernel+0x13a/0x140
>      common_startup_64+0x12c/0x137
>      </TASK>
> 
> It fires very early in boot. If kasan_multi_shot is set, the reports
> are non-fatal and keep repeating, and the boot CPU wedges before
> userspace is reached. The accessed addresses are valid 5-level kernel
> pointers, so the report is a false positive.
> 
> The root cause is in generic KASAN not seeing
> cpu_feature_enabled(X86_FEATURE_LA57) set, because the bit is cleared
> in identify_cpu() when the offending interrupt happens [1]:
> 
>   memset(&c->x86_capability, 0, ...);   /* clears X86_FEATURE_LA57 */
>   ...
>   get_cpu_cap(c);                       /* re-reads CPUID, restores it */
> 
> addr_has_metadata() then uses the 4-level threshold, and 5-level
> kernel addresses fall below it, so kasan_check_range() reports them as
> wild-memory-access.
> 
> Define USE_EARLY_PGTABLE_L5 in mm/kasan/generic.c so
> addr_has_metadata() uses the stable variable, as
> arch/x86/mm/kasan_init_64.c already does.
> 

I'd rather not push USE_EARLY_PGTABLE_L5 into generic KASAN code.

It's an x86 paging detail in arch-independent files. It's incomplete
(report.c and report_generic.c also call addr_has_metadata()). And it's
a permanent slowdown on the KASAN hot path -- pgtable_l5_enabled()
becomes a runtime load of __pgtable_l5_enabled on every check, whereas
cpu_feature_enabled() gets patched to a constant after alternatives.

And it leaves the real bug in place: the window where
boot_cpu_data.x86_capability reads back zero is visible to *any*
cpu_feature_enabled() caller in interrupt context, not just KASAN.

The window is opened by identify_cpu() itself, so fix it there:

	diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
	--- a/arch/x86/kernel/cpu/common.c
	+++ b/arch/x86/kernel/cpu/common.c
	@@ -2003,6 +2003,7 @@ static void generic_identify(struct cpuinfo_x86 *c)
	  */
	 static void identify_cpu(struct cpuinfo_x86 *c)
	 {
	+	unsigned long flags;
	 	int i;
	@@ -2022,12 +2023,21 @@ static void identify_cpu(struct cpuinfo_x86 *c)
	 	c->x86_cache_alignment = c->x86_clflush_size;
	+
	+	/*
	+	 * x86_capability is cleared and repopulated from CPUID below. On
	+	 * the boot CPU this runs with IRQs on and before alternatives are
	+	 * patched, so cpu_feature_enabled() reads the live bits; an
	+	 * interrupt in this window sees e.g. X86_FEATURE_LA57 as disabled.
	+	 */
	+	local_irq_save(flags);
	 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
	 #ifdef CONFIG_X86_VMX_FEATURE_NAMES
	 	memset(&c->vmx_capability, 0, sizeof(c->vmx_capability));
	 #endif
	 	generic_identify(c);
	+	local_irq_restore(flags);

save/restore keeps it correct for the secondary-CPU callers that already run
with IRQs off.

I reproduced your splat with parallel TCG guests (-cpu max, kasan_multi_shot):
~10% of boots hit it, 0/~200 with the above.

I am not sure how wide the irq-off window suppose to be. I scoped it to
memset() .. generic_identify(), where LA57 is restored. Later code
(apply_forced_caps(), ->c_init(), setup_sm*p()) only refines bits.

Widen it to be defensive, or keep it tight?

Any better solution?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
