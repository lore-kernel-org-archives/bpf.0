Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E93176EF
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781128555; cv=none; b=CZbPK0qT0dpKHv9SgIxgeg45laLIUniixXb8glkZFEINOnKiinmFGWz8BKvHZYRkDMn8kI/thNTsmy+D9wY5cuEis6BbKPDS9ki9aS1lVfYuulmUUE+rP3n1TGb3wJ5HyLih61ROn2UG0osFPZWi4285ie3M1FonYMGiia307Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781128555; c=relaxed/simple;
	bh=Xd+iV7Z7Ts9EpzVEc30Xw8zHpduDF5PdUnmNqKlYDRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnxJkjINl7o5m1UkrLYfYyRYghFTZaIJ/txyIG+TB4dJXE2E3xwFekCYbgnN6ofR35VyRxVw7tS2d61jYZCQwREzuY/Dn3UqnETG2Nv/SWA5vJ2RxfLJ/L+vohBUpipQwroabGto+dnlrBjHKvVsLNqHSi+aPgw5R5ceUcSaMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NZx5kQWa; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NZx5kQWa"
Message-ID: <a56eebfa-9fac-44ca-a3a5-80c0a41bdebb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781128549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Xq3T8jGSwlCoS9TBcLots22CwpjKVQ5tiqS1ynXAs0=;
	b=NZx5kQWaP3w/38qQC11nz4BQvD9L76TDbmaNJ5n5o5iZ5epV6H+HYWaKJLB+m6YcrolrNB
	pxs2I/GGTwF6LVABh2E04hBajrRJpfvEXIbfWaB/Qt1H9MgDMg5mbL4syBW/TsJew6bs+m
	9M7v8eu16pO4qVkBmGyl78S+X4kc2No=
Date: Wed, 10 Jun 2026 14:55:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86
 under 5-level paging
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260610175651.647515-1-ihor.solodrai@linux.dev>
 <CA+fCnZcRLZS4r=FBB6EX-G3+=X675q96hkdR_wLJexeuW-tPVw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CA+fCnZcRLZS4r=FBB6EX-G3+=X675q96hkdR_wLJexeuW-tPVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/10/26 11:39 AM, Andrey Konovalov wrote:
> On Wed, Jun 10, 2026 at 7:57 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On x86_64 with 5-level paging (LA57) and inline generic KASAN, the
>> following flaky splat may be observed on boot:
>>
>>     BUG: KASAN: wild-memory-access in do_raw_spin_lock+0xcf/0x260
>>     Write of size 4 at addr ff110001000c90b8 by task swapper/0/0
>>
>>     CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.1.0-rc5-gcba33e0b2907 #1 PREEMPT(full)
>>     Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>>     Call Trace:
>>      <IRQ>
>>      dump_stack_lvl+0x54/0x70
>>      kasan_report+0x117/0x150
>>      ? do_raw_spin_lock+0xcf/0x260
>>      kasan_check_range+0x264/0x2c0
>>      do_raw_spin_lock+0xcf/0x260
>>      handle_edge_irq+0x35/0x770
>>      ? do_raw_spin_unlock+0x51/0x2a0
>>      __common_interrupt+0xae/0x120
>>      common_interrupt+0x7c/0x90
>>      </IRQ>
>>      <TASK>
>>      asm_common_interrupt+0x26/0x40
>>     RIP: 0010:identify_cpu+0x2b2/0x3460
>>     Code: 00 41 c7 07 00 00 00 00 4d 89 e6 49 c1 ee 03 43 0f b6 04 06 84 c0 0f 85 a3 1c 00 00 41 c7 04 24 00 00 00 00 31 c0 31 c9 0f a2 <89> c7 42 0f b6 44 05 00 84 c0 0f 85 ad 1c 00 00 41 89 3f 48 8b 44
>>     RSP: 0000:ffffffff97807df0 EFLAGS: 00000246
>>     RAX: 0000000000000020 RBX: 00000000756e6547 RCX: 000000006c65746e
>>     RDX: 0000000049656e69 RSI: 0000000000000000 RDI: ffffffff98632fd8
>>     RBP: 1ffffffff30c65fc R08: dffffc0000000000 R09: 0000000000000004
>>     R10: ffffffff98632fc4 R11: fffffbfff30c65fb R12: ffffffff98633050
>>     R13: ffffffff98633048 R14: 1ffffffff30c660a R15: ffffffff98632fe0
>>      identify_boot_cpu+0xd/0xd0
>>      arch_cpu_finalize_init+0x24/0x1f0
>>      start_kernel+0x31e/0x3e0
>>      x86_64_start_reservations+0x24/0x30
>>      x86_64_start_kernel+0x13a/0x140
>>      common_startup_64+0x12c/0x137
>>      </TASK>
>>
>> It fires very early in boot. If kasan_multi_shot is set, the reports
>> are non-fatal and keep repeating, and the boot CPU wedges before
>> userspace is reached. The accessed addresses are valid 5-level kernel
>> pointers, so the report is a false positive.
>>
>> The root cause is in generic KASAN not seeing
>> cpu_feature_enabled(X86_FEATURE_LA57) set, because the bit is cleared
>> in identify_cpu() when the offending interrupt happens [1]:
>>
>>   memset(&c->x86_capability, 0, ...);   /* clears X86_FEATURE_LA57 */
>>   ...
>>   get_cpu_cap(c);                       /* re-reads CPUID, restores it */
>>
>> addr_has_metadata() then uses the 4-level threshold, and 5-level
>> kernel addresses fall below it, so kasan_check_range() reports them as
>> wild-memory-access.
>>
>> Define USE_EARLY_PGTABLE_L5 in mm/kasan/generic.c so
>> addr_has_metadata() uses the stable variable, as
>> arch/x86/mm/kasan_init_64.c already does.
> 
> It took me some digging to find which stable variable you refer to
> here; I think this needs to be better explained.

Hi Andrey, thank you for the quick review.

Yeah, it's:

  unsigned int __section(".data") __pgtable_l5_enabled;

I'll add more details in next revision.

> 
>>
>> Some context on how this was noticed and reproduced below.
>>
>> We started seeing flaky splats as above [2][3] on BPF CI runs after
>> runner hardware has been upgraded. Specifically, new x86 runners are
>> c7i.metal-24xl AWS EC2 instances, which are Intel Sapphire Rapids
>> machines that support LA57 feature, and have it enabled.
>>
>> The splats can be reproduced with qemu on any x86_64 host with
>>   -cpu max -accel tcg
>>
>> Build a kernel with:
>>   CONFIG_KASAN=y
>>   CONFIG_KASAN_GENERIC=y
>>   CONFIG_KASAN_INLINE=y
>>
>> Boot it with kasan_multi_shot. The fault fires fast before userspace,
>> so no rootfs is required. For example:
>>
>>   qemu-system-x86_64 -display none -serial stdio -no-reboot \
>>     -smp 4 -m 5G -cpu max -accel tcg \
>>     -kernel arch/x86/boot/bzImage \
>>     -append "console=ttyS0,115200 earlyprintk=serial,0,115200 panic=-1 kasan_multi_shot nokaslr"
>>
>> It's a timing race, so a single boot hits it only sometimes.
>> However running several qemu instances in parallel on the same host
>> significantly increases the hitrate.
>>
>> I confirmed the proposed fix eliminates the splats.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/cpu/common.c?h=v7.1-rc7#n2001
>> [2] https://github.com/kernel-patches/bpf/actions/runs/27271262414/job/80542509369
>> [3] https://github.com/kernel-patches/bpf/actions/runs/27260143782/job/80505353689
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  mm/kasan/generic.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
>> index 2b8e73f5f6a7..b5f430f2dbb6 100644
>> --- a/mm/kasan/generic.c
>> +++ b/mm/kasan/generic.c
>> @@ -9,6 +9,13 @@
>>   *        Andrey Konovalov <andreyknvl@gmail.com>
>>   */
>>
>> +/*
>> + * check_region_inline() and addr_has_metadata() can run very early.
>> + * For example, in an interrupt taken while identify_cpu() has the CPU
>> + * capability bits temporarily cleared.
>> + */
>> +#define USE_EARLY_PGTABLE_L5
> 
> There are other users of addr_has_metadata(), besides ones in generic.c.
> 
> Thus, should we place this definition into mm/kasan/kasan.h? And
> likely guard it with ifdef KASAN_GENERIC || KASAN_SW_TAGS (HW_TAGS
> should not be affected by this AFAIU).

It appears setting USE_EARLY_PGTABLE_L5 in kasan.h will not work.

USE_EARLY_PGTABLE_L5 needs to be set before 
arch/x86/include/asm/pgtable_64_types.h is included, which is very early.

For example, it arrives to kasan/generic.c through a long path starting
at linux/interrupt.h:

   In file included from ./arch/x86/include/asm/pgtable_types.h:277,
                   from ./arch/x86/include/asm/processor.h:21,
                   from ./arch/x86/include/asm/cpufeature.h:5,
                   from ./arch/x86/include/asm/thread_info.h:59,
                   from ./include/linux/thread_info.h:62,
                   from ./include/linux/smp.h:119,
                   from ./include/linux/alloc_tag.h:14,
                   from ./include/linux/percpu.h:5,
                   from ./include/linux/context_tracking_state.h:5,
                   from ./include/linux/hardirq.h:5,
                   from ./include/linux/interrupt.h:11,
                   from mm/kasan/generic.c:13:

So if we want to cover all users of addr_has_metadata(), we'll have to
add #define USE_EARLY_PGTABLE_L5 in multiple files: generic.c, report.c,
report_generic.c, maybe others?

Any other ideas?

I determined the include path like follows:

cd linux # at 9716c086c8e8 torvalds/master
make defconfig
./scripts/config -e KASAN -e KASAN_GENERIC -e KASAN_INLINE
make olddefconfig
make mm/kasan/generic.i

# then modify pgtable_64_types.h

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 7eb61ef6a185..c6b754143fb4 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_PGTABLE_64_DEFS_H
 #define _ASM_X86_PGTABLE_64_DEFS_H
+#error TRACE
 
 #include <asm/sparsemem.h>

And then:
eval "$(grep '^savedcmd_' mm/kasan/.generic.i.cmd | head -1 | sed 's/^savedcmd_[^ ]* := //')"


> 
> And let's also extend the comment to explain better what's going on. I
> like the way the issue is explained here:
> 
> https://elixir.bootlin.com/linux/v7.0.12/source/arch/x86/boot/startup/sme.c#L36

ok

> 
>> +
>>  #include <linux/export.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/init.h>
>> --
>> 2.54.0
>>
>> --
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion visit https://groups.google.com/d/msgid/kasan-dev/20260610175651.647515-1-ihor.solodrai%40linux.dev.

