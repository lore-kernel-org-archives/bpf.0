Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A70259C9C;
	Tue, 10 Mar 2026 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125231; cv=none; b=Z/41A7YUQZ08qWVpSLY7BKXge7u++TAj0AnYlTHMfrA9sZ2+AtKkxrGm1MShdQEzXoZtyBM0DRde6rEiQ72rROfU9hWYTlQDFD7ElwzMO3ekM3Aaqi+sWhZv9tEIIDuzP6KTTmSks/QWRTh0q/c8LVage/CCBaLDZ1cfXlJq6sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125231; c=relaxed/simple;
	bh=NGXnINS+4MWplVm84Ymg8CZ66+TZtIsYwugcsy69u8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flBmW1EyQ7XJjP4SZ8IwI8WKSUIHlXKhHNuDOnABxP49YzfWOQml/ZlLVtmeKV9ElRQzHxUew7hcQOXpq6hSg5wcxknEMeByQhAF+ZhuSnRAsUYEyDHA8hud10IttMFLEFV5m2kPtqKyt9LGsia3/7GtuMb4oR9UNPnK3zg02Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Axz6tsvq9p62oZAA--.15618S3;
	Tue, 10 Mar 2026 14:47:08 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxHMJrvq9pRuhRAA--.23272S2;
	Tue, 10 Mar 2026 14:47:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] LoongArch: BPF: Make arch_protect_bpf_trampoline() return 0
Date: Tue, 10 Mar 2026 14:47:06 +0800
Message-ID: <20260310064706.4985-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMJrvq9pRuhRAA--.23272S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr15Ww4rZr1Dtr47ZF48KrX_yoW5Ww1Dpr
	y3Cryakr4kXr1UZr4DJ3Wjvr90qa1Dua1UGry8Kry8C3s8X348tryjk348XFWrCFWrt3W8
	Xa1kXrnxta1DJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOdb8UUUUU=

Occasionally, there exists "text_copy_cb: operation failed" when executing
bpf selftests, the reason is copy_to_kernel_nofault() failed and the ecode
of estat register is 0x4 (PME: Page Modification Exception) due to the pte
is not writeable, the root cause is that there is another place to set pte
readonly which is in the generic weak arch_protect_bpf_trampoline().

There are two ways to fix this race condition issue, the direct way is to
modify the generic weak arch_protect_bpf_trampoline() to add a mutex lock
for set_memory_rox(), but the other simple and proper way is to just make
arch_protect_bpf_trampoline() return 0 in the arch-specific code because
LoongArch already uses BPF prog pack allocator for trampoline.

Here are the trimmed kernel log messages:

  copy_to_kernel_nofault: memory access failed, ecode is 0x4
  copy_to_kernel_nofault: caller is text_copy_cb+0x50/0xa0
  text_copy_cb: operation failed
  ------------[ cut here ]------------
  bpf_prog_pack bug: missing bpf_arch_text_invalidate?
  WARNING: kernel/bpf/core.c:1008 at bpf_prog_pack_free+0x200/0x228
  ...
  Call Trace:
  [<9000000000248914>] show_stack+0x64/0x188
  [<9000000000241308>] dump_stack_lvl+0x6c/0x9c
  [<90000000002705bc>] __warn+0x9c/0x200
  [<9000000001c428c0>] __report_bug+0xa8/0x1c0
  [<9000000001c42b5c>] report_bug+0x64/0x120
  [<9000000001c7dcd0>] do_bp+0x270/0x3c0
  [<9000000000246f40>] handle_bp+0x120/0x1c0
  [<900000000047b030>] bpf_prog_pack_free+0x200/0x228
  [<900000000047b2ec>] bpf_jit_binary_pack_free+0x24/0x60
  [<900000000026989c>] bpf_jit_free+0x54/0xb0
  [<900000000029e10c>] process_one_work+0x184/0x610
  [<900000000029ef8c>] worker_thread+0x24c/0x388
  [<90000000002a902c>] kthread+0x13c/0x170
  [<9000000001c7dfe8>] ret_from_kernel_thread+0x28/0x1c0
  [<9000000000246624>] ret_from_kernel_thread_asm+0xc/0x88

  ---[ end trace 0000000000000000 ]---

Here is a simple shell script to reproduce:

  #!/bin/bash

  for ((i=1; i<=1000; i++))
  do
    echo "under testing $i ..."
    dmesg -c > /dev/null
    ./test_progs -t fentry_attach_stress > /dev/null
    dmesg -t | grep "text_copy_cb: operation failed"
    if [ $? -eq 0 ]; then
      break
    fi
  done

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 3bd89f55960d..4f1af3b7a363 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1568,6 +1568,11 @@ void arch_free_bpf_trampoline(void *image, unsigned int size)
 	bpf_prog_pack_free(image, size);
 }
 
+int arch_protect_bpf_trampoline(void *image, unsigned int size)
+{
+	return 0;
+}
+
 /*
  * Sign-extend the register if necessary
  */
-- 
2.42.0

