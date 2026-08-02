Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748E489882;
	Sun,  2 Aug 2026 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785663901; cv=none; b=Qga+IzQZ3XfzhK+5FX9K5QA1yYruN3aldymGFRx7M8/hTGdRJUXPUbouN0wU/73MxQE6AIi+umEOCOpTuOltEFqN/D0if4YTme1ImiIEyPEbOJ+kwxJCUG1Fbp9D6avKaKSp+3lgyOraO4IdDPOFqtwtKk0rwOoNF/ALPHNNzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785663901; c=relaxed/simple;
	bh=Ww/YiWup2i15UucCBJ3OoekI3XS9iRZ0GCoteRPBGjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S75GXmJjfo7a0RocGYS6i2uSWg7PDmr9a33jGA5aCia8OPLd3dIIXRciJPuA7BpooMz0iKjL1V/vdQvSo3o3SOHo3fhyw6eNj7/T6LgZ6orXYWAuTEHF6P506xreUrxpvWsltG44SUO6Pfy3NmGrzAt1FNFzJyFf86oZeza/EnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hCZf82C0kzKHMbX;
	Sun,  2 Aug 2026 17:44:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 75FD34056E;
	Sun,  2 Aug 2026 17:44:49 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBHN0aQEW9qkilYAw--.4417S2;
	Sun, 02 Aug 2026 17:44:49 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Chiu <andybnac@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH] riscv: ftrace: Fix ftrace_modify_call failure on kprobed functions
Date: Sun,  2 Aug 2026 09:49:29 +0000
Message-Id: <20260802094929.3978390-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBHN0aQEW9qkilYAw--.4417S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4kAF4DArW5CF45Wr1fXrb_yoW5trW5pF
	yakw1qkr4rAanrKFZrKwn8urs7t3yDA34UAF93Ja4rAa4qkr15Jw4Ikr4ktr98ArZ8Jryf
	Z34qyr4UGryUAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

We are frequently hitting the following splat during the riscv bpf
selftests:

00000000026dc75a: expected (7c3ff297) but got (00100073)
------------[ ftrace bug ]------------
ftrace failed to modify
[<ffffffff03c44c1c>] bpf_kfunc_common_test+0x4/0x20 [bpf_testmod]
 actual:   e7:82:c2:ce
Updating ftrace call site to call a different ftrace function
ftrace record flags: 80100002
 (2)
 expected tramp: ffffffff80043904
------------[ cut here ]------------
WARNING: kernel/trace/ftrace.c:2278 at ftrace_bug+0x46e/0x4b0, CPU#1: test_progs/98
...
[<ffffffff80008f4e>] ftrace_bug+0x46e/0x4b0
[<ffffffff803d3e86>] ftrace_replace_code+0x16e/0x170
[<ffffffff803d42b6>] ftrace_modify_all_code+0x12e/0x1b8
[<ffffffff800430f4>] arch_ftrace_update_code+0x14/0x28
[<ffffffff803e0324>] ftrace_startup+0x14c/0x2a0
[<ffffffff803e133c>] ftrace_startup_subops+0x584/0x1050
[<ffffffff804500e6>] register_ftrace_graph+0x4e6/0x1018
[<ffffffff804cf9f6>] register_fprobe_ips+0xc66/0x12f8
[<ffffffff8049abe8>] bpf_kprobe_multi_link_attach+0x5d8/0xe68
[<ffffffff8050fcaa>] __sys_bpf+0x3d5a/0x47f0
[<ffffffff805107ee>] __riscv_sys_bpf+0xae/0x168
[<ffffffff80034d78>] syscall_handler+0x60/0x100
[<ffffffff8228b4f4>] do_trap_ecall_u+0x174/0x208
[<ffffffff822b69c4>] handle_exception+0x16c/0x178

After debugging, it can be triggered by similar commands below:
```
echo do_nanosleep > set_ftrace_filter
echo function > current_tracer
echo 'p do_nanosleep' > kprobe_events
echo 1 > events/kprobes/enable
echo 'f do_nanosleep' > dynamic_events
echo 1 > events/fprobes/enable
```

The reason is that attaching a kprobe to an ftrace-traced function entry
replaces its initial auipc insn with ebreak. When ftrace_modify_call
later runs, it expects auipc insn, so verification fails and triggers
ftrace_bug.

The expected auipc logic remains conceptually unchanged, and kprobe
single-stepping ensures normal execution. Therefore, if the first insn
is ebreak, bypassing the check to continue patching the jalr insn is
safe and avoids ftrace failures.

Fixes: b2137c3b6d7a ("riscv: ftrace: prepare ftrace for atomic code patching")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/kernel/ftrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index b430edfb83f4..be8b68514417 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -12,6 +12,7 @@
 #include <linux/stop_machine.h>
 #include <asm/cacheflush.h>
 #include <asm/text-patching.h>
+#include <asm/insn.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 void ftrace_arch_code_modify_prepare(void)
@@ -63,7 +64,9 @@ static int __ftrace_modify_call(unsigned long source, unsigned long target, bool
 		if (copy_from_kernel_nofault(replaced, (void *)source, 2 * MCOUNT_INSN_SIZE))
 			return -EFAULT;
 
-		if (replaced[0] != call[0]) {
+		/* Bypass the check if the auipc insn is a kprobe breakpoint */
+		if (replaced[0] != call[0] &&
+		    !(riscv_insn_is_ebreak(replaced[0]) || riscv_insn_is_c_ebreak(replaced[0]))) {
 			pr_err("%p: expected (%08x) but got (%08x)\n",
 			       (void *)source, call[0], replaced[0]);
 			return -EINVAL;
-- 
2.34.1

