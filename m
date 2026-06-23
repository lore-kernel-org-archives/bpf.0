Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C7A384254;
	Tue, 23 Jun 2026 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174988; cv=none; b=HXvJ/jTKhV/hz4dTrIpgw1MuCeIw5ALkHyjehaYczvBwP0JaBi8U5879y0gz9uA//Dc/MBl5cek1VCsQbs+SAldbljCEo6VVhrD5ZgLLrePYaWQBmSrIIwoC/E6Z4wQqGwERmf08IhWlFhk0pygZ4N+wBLHBW+omEFj4AKQsHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174988; c=relaxed/simple;
	bh=es2BTXqGlsI2kAe1EuTYReDtTvji2hXEEeRj7fnpZ7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6Sc8nm22z/8/Suj3fDHsLN9IZRanYPrOYf9TxzQOhz+G90M/+erpbiwLBoy95PEVI1l5L9yDPypCEKAUbNNAb7A385prAUERAzhJT3PU9TWLv1+hpekMCCbFkjN/21yr1Zxx15GlVpq40Ap18Ni7KBTjIsxZamlHBIVlcgM7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oSEJJOft; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oSEJJOft"
Message-ID: <fdefc4f4-12d5-4c16-a452-3bdecd032176@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782174984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiVSLMbP5JKIaX7duhxu9i0pxEPSv8jIkF1+C1nDh/g=;
	b=oSEJJOftTnWmG948iiJVXISS8aMMeb/h72Hkg3EPhrOrP/dXubbUousJmdRMIlI/DSKEBJ
	iSAPATuspskVqtyncqJuP8bz61ns61Ll26p4r8XK3fln1qu3SD1ct+Pfn5ps6tlXv2kDQ5
	Lr8avKCxtPtEatfKTzbqgabjTZsk3HI=
Date: Mon, 22 Jun 2026 17:35:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86
 under 5-level paging
To: Borislav Petkov <bp@alien8.de>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andrey Konovalov <andreyknvl@gmail.com>
References: <20260610175651.647515-1-ihor.solodrai@linux.dev>
 <326b85af-c41a-4387-90a0-60720111934d@linux.dev>
 <20260618170913.GBajQmOQyOiBLqopUl@fat_crate.local>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260618170913.GBajQmOQyOiBLqopUl@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/18/26 10:09 AM, Borislav Petkov wrote:
> On Wed, Jun 17, 2026 at 03:13:33PM -0700, Ihor Solodrai wrote:
>> So my question to maintainers is what approach seems best?
> 
> The CPUID stuff is being rewritten currently and it should address your issue
> too. If not, then we need to rewrite it better.
> 
> Can you reproduce with this set applied ontop:
> 
> https://lore.kernel.org/r/20260528153923.403473-1-darwi@linutronix.de

Yes, the issue reproduces with this series.

Here is a splat:

[    1.554117] BUG: KASAN: wild-memory-access in do_raw_spin_lock+0x121/0x270
[    1.554117] Write of size 4 at addr ff110001000d10b8 by task swapper/0/0
[    1.554117] 
[    1.554117] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.1.0-00120-g0f76bd3ff8c1 #19 PREEMPT(full) 
[    1.554117] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-5.el9 11/05/2023
[    1.554117] Call Trace:
[    1.554117]  <IRQ>
[    1.554117]  dump_stack_lvl+0x68/0xa0
[    1.554117]  ? do_raw_spin_lock+0x121/0x270
[    1.554117]  kasan_report+0xca/0x100
[    1.554117]  ? do_raw_spin_lock+0x121/0x270
[    1.554117]  kasan_check_range+0x39/0x1c0
[    1.554117]  do_raw_spin_lock+0x121/0x270
[    1.554117]  ? __pfx_do_raw_spin_lock+0x10/0x10
[    1.554117]  handle_edge_irq+0x34/0x8b0
[    1.554117]  __common_interrupt+0x6e/0x170
[    1.554117]  common_interrupt+0x77/0xa0
[    1.554117]  </IRQ>
[    1.554117]  <TASK>
[    1.554117]  asm_common_interrupt+0x26/0x40
[    1.554117] RIP: 0010:__cpuid_reset_table+0xf7/0x7b0
[    1.554117] Code: 49 8d 7e 0c 45 8b 46 08 48 89 f8 48 c1 e8 03 4a 8d 2c 03 48 89 6c 24 68 42 0f b6 14 38 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 <84> d2 0f 85 da 04 00 00 45 8b 4e 0c 4c 89 f0 48 c1 e8 03 49 01 d9
[    1.554117] RSP: 0000:ffffffff84c07d98 EFLAGS: 00010202
[    1.554117] RAX: 0000000000000007 RBX: ffffffff85a7c990 RCX: 0000000000000000
[    1.554117] RDX: 0000000000000000 RSI: fffffbfff0b4f91c RDI: ffffffff83c2dcac
[    1.554117] RBP: ffffffff85a7c990 R08: 0000000000000000 R09: 0000000000000001
[    1.554117] R10: ffffffff85a7c8ec R11: 0000000000000000 R12: 000000000000ffff
[    1.554117] R13: ffffffff85a7c990 R14: ffffffff83c2dca0 R15: dffffc0000000000
[    1.554117]  ? __pfx___cpuid_reset_table+0x10/0x10
[    1.554117]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[    1.554117]  cpuid_scan_cpu_early+0x5a/0xd0
[    1.554117]  identify_cpu+0x2c1/0x13e0
[    1.554117]  ? lock_release+0xc9/0x290
[    1.554117]  arch_cpu_finalize_init+0x25/0x3c0
[    1.554117]  start_kernel+0x304/0x3f0
[    1.554117]  x86_64_start_reservations+0x18/0x30
[    1.554117]  x86_64_start_kernel+0x116/0x130
[    1.554117]  common_startup_64+0x12c/0x138
[    1.554117]  </TASK>

> 
> ?
> 

