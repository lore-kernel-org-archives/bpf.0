Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EE137F006
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293366; cv=none; b=CvVmIPQPAvpFN8qQ0dnZridVmEGTXenILbnNZiWEcpRIgL2D1lXgKHMQonxta5Gipxu/gX5n5gMQiSYj1QydCQ/1q2f+Ws2oiM7e8Jw6ZUiJdqHcwOoT90Nme8UrofDm54wvK+kEwswgM986lObMCp1OqJ9x26rHb6QGiCa1IgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293366; c=relaxed/simple;
	bh=AdYwKi1Bg3lgA5dSyRx3tWvWXX1QUBVVDvIyfvyK8R8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H38qybo2+a7ZIWd7T/vAFuI0kwxv7c2Z/qKnGNY8d7ROH8i/V7zOx057tbfKCka8wV33ZvniWP9lPkPcUgyI7+7TN9M6Opwcyb2C2lvphDgIejI323choksjr3J0VP8O57NFjw+ev0fkLBSbvhx7oQGrDd3rNI+LW5ygGW2HMe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=brOAb7K2; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="brOAb7K2"
Message-ID: <a9aa8bd7-4b3e-4ded-ba9c-6115bb1a5bc8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781293352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QLZc+bqOjpJQqkbYIVO2qgsWd8vMlqHdKvbCmBuh0Y=;
	b=brOAb7K2GmoEqTh0l7IiYkch0zYK2c6+jUxruMDFAQD9tKJSt3HwYn6JGIZIQmrppMrU2H
	VVABEx9NGfPgJuo3eDtc9l7efrJkdw7klR50XggUB+zmfm+RnSkMruSU6Rz86wiQCXBz1z
	cM+zBQYUFEWxqCFlQuU5XrBs9I1S+q0=
Date: Fri, 12 Jun 2026 12:42:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86
 under 5-level paging
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260610175651.647515-1-ihor.solodrai@linux.dev>
 <aiwxWk0gOV4ZlKcT@thinkstation>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aiwxWk0gOV4ZlKcT@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/12/26 9:30 AM, Kiryl Shutsemau wrote:
> On Wed, Jun 10, 2026 at 10:56:51AM -0700, Ihor Solodrai wrote:
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
>>
> 
> I'd rather not push USE_EARLY_PGTABLE_L5 into generic KASAN code.
> 
> It's an x86 paging detail in arch-independent files. It's incomplete
> (report.c and report_generic.c also call addr_has_metadata()). And it's
> a permanent slowdown on the KASAN hot path -- pgtable_l5_enabled()
> becomes a runtime load of __pgtable_l5_enabled on every check, whereas
> cpu_feature_enabled() gets patched to a constant after alternatives.
> 
> And it leaves the real bug in place: the window where
> boot_cpu_data.x86_capability reads back zero is visible to *any*
> cpu_feature_enabled() caller in interrupt context, not just KASAN.
> 
> The window is opened by identify_cpu() itself, so fix it there:
> 
> 	diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> 	--- a/arch/x86/kernel/cpu/common.c
> 	+++ b/arch/x86/kernel/cpu/common.c
> 	@@ -2003,6 +2003,7 @@ static void generic_identify(struct cpuinfo_x86 *c)
> 	  */
> 	 static void identify_cpu(struct cpuinfo_x86 *c)
> 	 {
> 	+	unsigned long flags;
> 	 	int i;
> 	@@ -2022,12 +2023,21 @@ static void identify_cpu(struct cpuinfo_x86 *c)
> 	 	c->x86_cache_alignment = c->x86_clflush_size;
> 	+
> 	+	/*
> 	+	 * x86_capability is cleared and repopulated from CPUID below. On
> 	+	 * the boot CPU this runs with IRQs on and before alternatives are
> 	+	 * patched, so cpu_feature_enabled() reads the live bits; an
> 	+	 * interrupt in this window sees e.g. X86_FEATURE_LA57 as disabled.
> 	+	 */
> 	+	local_irq_save(flags);
> 	 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
> 	 #ifdef CONFIG_X86_VMX_FEATURE_NAMES
> 	 	memset(&c->vmx_capability, 0, sizeof(c->vmx_capability));
> 	 #endif
> 	 	generic_identify(c);
> 	+	local_irq_restore(flags);
> 
> save/restore keeps it correct for the secondary-CPU callers that already run
> with IRQs off.
> 
> I reproduced your splat with parallel TCG guests (-cpu max, kasan_multi_shot):
> ~10% of boots hit it, 0/~200 with the above.

Hi Kiryl, thank you for testing.

I thought of disabling IRQs here too, and AI bot flagged this as well [1].

I wasn't sure it'd be a good fix, because I don't know if it has any
undesirable consequences, and whether it's actually a complete fix.
For example, can a NMI hit this?

[1] https://lore.kernel.org/bpf/7b6d449f-c70c-4e8e-bfc4-a2f75517395c@linux.dev/

> 
> I am not sure how wide the irq-off window suppose to be. I scoped it to
> memset() .. generic_identify(), where LA57 is restored. Later code
> (apply_forced_caps(), ->c_init(), setup_sm*p()) only refines bits.
> 
> Widen it to be defensive, or keep it tight?

If we scope this narrowly, then it remains LA57-specific, because we protect
only a portion of the capabilities array.
IIUC to ensure x86_capability is "ready", a proper scope should be
entire identify_cpu(). And this may be a problem, because mcheck_cpu_init()
does kmalloc(GFP_KERNEL) [2], for example.

So I have doubts disabling IRQ is the right approach.

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/cpu/mce/genpool.c?h=v7.1-rc7#n119

> 
> Any better solution?
> 

What if we define a static key for LA57 feature for KASAN?
This will avoid the performance hit we get with USE_EARLY_PGTABLE_L5.
And KASAN won't care about x86_capability being cleared.
Is that feasible/acceptable?

That will be a KASAN-specific LA57-specific fix however.
The underlying "capabilities are temporarily cleared on boot"
issue would remain. Although it wasn't a problem until this bug surfaced.

Something like this:

diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index d7e33c7f096b..6c1ebcb4a417 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -36,6 +36,35 @@ static inline void kasan_populate_shadow_for_vaddr(void *va, size_t size,
                                                   int nid) { }
 #endif
 
+#ifdef CONFIG_KASAN_GENERIC
+#include <linux/jump_label.h>
+
+DECLARE_STATIC_KEY_TRUE(kasan_la57_enabled);
+
+#define addr_has_metadata addr_has_metadata
+static __always_inline bool addr_has_metadata(const void *addr)
+{
+       unsigned int shift = static_branch_likely(&kasan_la57_enabled) ? 56 : 47;
+
+       return (unsigned long)addr >= (-1UL << shift);
+}
+#endif /* CONFIG_KASAN_GENERIC */
+
 #endif
 
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a4268c47f2bc..79bad61f4891 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -28,6 +28,7 @@
 #include <linux/stackprotector.h>
 #include <linux/utsname.h>
 #include <linux/efi.h>
+#include <linux/kasan.h>
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
@@ -2581,6 +2582,19 @@ void __init arch_cpu_finalize_init(void)
 {
        struct cpuinfo_x86 *c = this_cpu_ptr(&cpu_info);
 
+#ifdef CONFIG_KASAN_GENERIC
+       if (!__pgtable_l5_enabled)
+               static_branch_disable(&kasan_la57_enabled);
+#endif
+
        identify_boot_cpu();
 
        select_idle_routine();
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 998b6010d6d3..3cb20b4d8799 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task.h>
 #include <linux/vmalloc.h>
+#include <linux/jump_label.h>
 
 #include <asm/e820/types.h>
 #include <asm/pgalloc.h>
@@ -20,6 +21,12 @@
 
 extern struct range pfn_mapped[E820_MAX_ENTRIES];
 
+DEFINE_STATIC_KEY_TRUE(kasan_la57_enabled);
+
 static p4d_t tmp_p4d_table[MAX_PTRS_PER_P4D] __initdata __aligned(PAGE_SIZE);
 
 static __init void *early_alloc(size_t size, int nid, bool should_panic)






