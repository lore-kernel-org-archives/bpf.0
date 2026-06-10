Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBAC351C28
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114244; cv=none; b=oUD6+EpniiJbwpmRACC/7m+zg0WXg4Fg1LDDR4rtJyVuYWoW6aOY2bvromfohvz7CxN6OqABbJjDkpwdXwc06c52Dt446g4UvMC+PxJArxVnJ7mzT7Tm5vf+u3GmuklX4t52DSmUGRuAatOZ+VN6VJNHpGr9hCJxlQbXiVRCzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114244; c=relaxed/simple;
	bh=PSyiABTrn2B9+RliA2ihw4lkCq8xGqmI9vbheu53qLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DD7pmSZ8lU+iLJ2tFGwaTgov8tBhwmSxW12HJ0If/SYqpqtUY46OeKuqajLeiwe0+mfK+lNKeHHAIWfOGonb0hFuAAo8eeKAaGerWMdC+In+15J5P1+lZgIiNYCShPg9viedO+L1IR1GWhNnHIYNlo6SKEY95aCz2i3cYIskz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FMZfG3P3; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FMZfG3P3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781114239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TtdGMbUuSGcoHFLrymBJZ08Jr0hWDxTV7oU5nDom8zw=;
	b=FMZfG3P3vcrwigPol9KDhU2dsyNDkkhZgt7JaxrvHVcNUI797BVeZ1Az7WWARoedhUfduI
	wza2iGuAXLuNgXS91NF1A8YDXvMi9SEt0ugqqGhZeXfmI9KstgiJ8yNK4ssC/j/ayfzQRu
	4LxBDVl/cztDWQvfMBNdTOStN09WdkM=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86 under 5-level paging
Date: Wed, 10 Jun 2026 10:56:51 -0700
Message-ID: <20260610175651.647515-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On x86_64 with 5-level paging (LA57) and inline generic KASAN, the
following flaky splat may be observed on boot:

    BUG: KASAN: wild-memory-access in do_raw_spin_lock+0xcf/0x260
    Write of size 4 at addr ff110001000c90b8 by task swapper/0/0

    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.1.0-rc5-gcba33e0b2907 #1 PREEMPT(full)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Call Trace:
     <IRQ>
     dump_stack_lvl+0x54/0x70
     kasan_report+0x117/0x150
     ? do_raw_spin_lock+0xcf/0x260
     kasan_check_range+0x264/0x2c0
     do_raw_spin_lock+0xcf/0x260
     handle_edge_irq+0x35/0x770
     ? do_raw_spin_unlock+0x51/0x2a0
     __common_interrupt+0xae/0x120
     common_interrupt+0x7c/0x90
     </IRQ>
     <TASK>
     asm_common_interrupt+0x26/0x40
    RIP: 0010:identify_cpu+0x2b2/0x3460
    Code: 00 41 c7 07 00 00 00 00 4d 89 e6 49 c1 ee 03 43 0f b6 04 06 84 c0 0f 85 a3 1c 00 00 41 c7 04 24 00 00 00 00 31 c0 31 c9 0f a2 <89> c7 42 0f b6 44 05 00 84 c0 0f 85 ad 1c 00 00 41 89 3f 48 8b 44
    RSP: 0000:ffffffff97807df0 EFLAGS: 00000246
    RAX: 0000000000000020 RBX: 00000000756e6547 RCX: 000000006c65746e
    RDX: 0000000049656e69 RSI: 0000000000000000 RDI: ffffffff98632fd8
    RBP: 1ffffffff30c65fc R08: dffffc0000000000 R09: 0000000000000004
    R10: ffffffff98632fc4 R11: fffffbfff30c65fb R12: ffffffff98633050
    R13: ffffffff98633048 R14: 1ffffffff30c660a R15: ffffffff98632fe0
     identify_boot_cpu+0xd/0xd0
     arch_cpu_finalize_init+0x24/0x1f0
     start_kernel+0x31e/0x3e0
     x86_64_start_reservations+0x24/0x30
     x86_64_start_kernel+0x13a/0x140
     common_startup_64+0x12c/0x137
     </TASK>

It fires very early in boot. If kasan_multi_shot is set, the reports
are non-fatal and keep repeating, and the boot CPU wedges before
userspace is reached. The accessed addresses are valid 5-level kernel
pointers, so the report is a false positive.

The root cause is in generic KASAN not seeing
cpu_feature_enabled(X86_FEATURE_LA57) set, because the bit is cleared
in identify_cpu() when the offending interrupt happens [1]:

  memset(&c->x86_capability, 0, ...);   /* clears X86_FEATURE_LA57 */
  ...
  get_cpu_cap(c);                       /* re-reads CPUID, restores it */

addr_has_metadata() then uses the 4-level threshold, and 5-level
kernel addresses fall below it, so kasan_check_range() reports them as
wild-memory-access.

Define USE_EARLY_PGTABLE_L5 in mm/kasan/generic.c so
addr_has_metadata() uses the stable variable, as
arch/x86/mm/kasan_init_64.c already does.

Some context on how this was noticed and reproduced below.

We started seeing flaky splats as above [2][3] on BPF CI runs after
runner hardware has been upgraded. Specifically, new x86 runners are
c7i.metal-24xl AWS EC2 instances, which are Intel Sapphire Rapids
machines that support LA57 feature, and have it enabled.

The splats can be reproduced with qemu on any x86_64 host with
  -cpu max -accel tcg

Build a kernel with:
  CONFIG_KASAN=y
  CONFIG_KASAN_GENERIC=y
  CONFIG_KASAN_INLINE=y

Boot it with kasan_multi_shot. The fault fires fast before userspace,
so no rootfs is required. For example:

  qemu-system-x86_64 -display none -serial stdio -no-reboot \
    -smp 4 -m 5G -cpu max -accel tcg \
    -kernel arch/x86/boot/bzImage \
    -append "console=ttyS0,115200 earlyprintk=serial,0,115200 panic=-1 kasan_multi_shot nokaslr"

It's a timing race, so a single boot hits it only sometimes.
However running several qemu instances in parallel on the same host
significantly increases the hitrate.

I confirmed the proposed fix eliminates the splats.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/cpu/common.c?h=v7.1-rc7#n2001
[2] https://github.com/kernel-patches/bpf/actions/runs/27271262414/job/80542509369
[3] https://github.com/kernel-patches/bpf/actions/runs/27260143782/job/80505353689

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 mm/kasan/generic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 2b8e73f5f6a7..b5f430f2dbb6 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -9,6 +9,13 @@
  *        Andrey Konovalov <andreyknvl@gmail.com>
  */
 
+/*
+ * check_region_inline() and addr_has_metadata() can run very early.
+ * For example, in an interrupt taken while identify_cpu() has the CPU
+ * capability bits temporarily cleared.
+ */
+#define USE_EARLY_PGTABLE_L5
+
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-- 
2.54.0

