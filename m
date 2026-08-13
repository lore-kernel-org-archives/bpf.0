Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3832E88A4;
	Thu, 13 Aug 2026 04:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786596800; cv=none; b=AE9oZaav3VI3xl+999BzCh/WsbG9fBzSdtD1vUmaTENPxo5s0AbDV/hnzenZz3JhAZamvn2c84nGG5IMQeylmmtkPMwRKTVcuzmHQPmW5Ll1IzIUJasPBq66aSfCUubjKWX87jnhhRhkpHfjsAqzqDphxD8bqx6zcy5L7mX9jfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786596800; c=relaxed/simple;
	bh=/WeQs4kp94i9NU69HhPn78X79uzPNVFGzKZwcMv6Ntk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xwhht8jN9/8A4UZxlLC8hJDbx7lcbzlMrBK2K0ao8R2O5k+JkeRF6IBtqgzjivYFN10c4dTaTFnX6akA59A+s7g1qo4Y9voROGA45BM56hqhipR1ogQq9Kpm1F41x9JFts62Dzbkee+PQQRkXuyI034Jn74jDhTq5ccQz7fLXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8BxbdK1TX1qAMwAAA--.2512S3;
	Thu, 13 Aug 2026 12:53:09 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJCxPs+0TX1qpf0CAA--.20229S2;
	Thu, 13 Aug 2026 12:53:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH v1] LoongArch: BPF: Implement arch_bpf_stack_walk()
Date: Thu, 13 Aug 2026 12:53:06 +0800
Message-ID: <20260813045306.21571-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPs+0TX1qpf0CAA--.20229S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFWxKF43KFW3WryxWr4rJFc_yoW5GF1xpr
	s0kanxKrZ0g34xXry3tw4UZrZ8Xr4kCr47KFW3CFyrCF9rX3Wxur9YkayqqFn8ArykJa1I
	qrZ0kF9Ika95AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU90b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07jepB-UUUUU=

From: George Guo <guodongtai@kylinos.cn>

Implement arch_bpf_stack_walk() on top of the ORC unwinder within
the LoongArch BPF JIT backend to provide generic BPF stack walking
capabilities.

This function is required by advanced BPF features, including timed
may_goto timeout tracing and BPF exceptions. It will be invoked in
the BPF core subsystem unwinding paths: bpf_prog_find_from_stack(),
bpf_stream_stage_dump_stack(), and bpf_throw().

Co-developed-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
This is an independent feature, so split it from
https://lore.kernel.org/loongarch/20260702022322.51033-6-dongtai.guo@linux.dev/
Based on the latest loongarch-next, tested on Loongson-3A6000.

 arch/loongarch/net/bpf_jit.c | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 7533917c6d47..78c20df2a2f3 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2402,6 +2402,44 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+#if defined(CONFIG_UNWINDER_ORC)
+#include <asm/unwind.h>
+
+static noinline void walk_bpf_stackframe(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp),
+					 void *cookie, unsigned long fp)
+{
+	struct pt_regs dummyregs;
+	struct pt_regs *regs = &dummyregs;
+	struct unwind_state state;
+	unsigned long addr;
+
+	regs->regs[3] = (unsigned long)__builtin_frame_address(0);
+	regs->csr_era = (unsigned long)__builtin_return_address(0);
+	regs->regs[1] = 0;
+	regs->regs[22] = fp;
+
+	for (unwind_start(&state, current, regs);
+	     !unwind_done(&state); unwind_next_frame(&state)) {
+		addr = unwind_get_return_address(&state);
+		if (!addr || !consume_fn(cookie, (u64)addr, (u64)state.sp, (u64)state.fp))
+			break;
+	}
+}
+
+void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
+{
+	unsigned long fp;
+
+	/*
+	 * Capture the live frame pointer ($r22) at the very front-line before
+	 * any kernel C code clobbers it. This must be a thin wrapper with no
+	 * large stack locals to prevent the compiler from reusing $r22 early.
+	 */
+	asm volatile("move %0, $r22" : "=r"(fp));
+	walk_bpf_stackframe(consume_fn, cookie, fp);
+}
+#endif /* CONFIG_UNWINDER_ORC */
+
 bool bpf_jit_supports_timed_may_goto(void)
 {
 	return true;
-- 
2.42.0

