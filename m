Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2670425B090
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782970297; cv=none; b=WEPsbMIbz0HBHt3h0+phCvLE6ZyjH/IR3TrUhXFbRHyKjBG2B3c5OY3SJ+iCmAi9fNZrQOfzqzIAn1ozD+GiU/AOautLPMaL3Y6nOx0SXNd0uGhT/nZiBwSbyPUGcz4S52ww2QUsY3nK2jzW5btzZEghpZNZ4TwhKffAQqpSwt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782970297; c=relaxed/simple;
	bh=m5krjPHU7C3RAjb/MhbTq1sGpigcJi5gInzm4Ir3mX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJf5CuVPkMGW7P2JHhapneU8dgK+1fGdUUx/65ZtWzSsLECwlh0KWbP7T+ewN3XG99d/cPZYQ8AdkA3frYhZ+VSPAwzJrNwYdMgcJG/g1BWDwWmqJESI7Fs2BudRT2/hZhDuOvHZHL1LQUtYmI/vFUInOlqx50eH8CnNHzJHO2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bxh_Cy90VqesgAAA--.4515S3;
	Thu, 02 Jul 2026 13:31:30 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxB8Gw90Vqn6C7AA--.15449S2;
	Thu, 02 Jul 2026 13:31:29 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	KaFai Wan <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	Leon Hwang <leon.hwang@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH bpf-next v6] bpf: Reject programs with inlined helpers if JIT is unavailable
Date: Thu,  2 Jul 2026 13:31:27 +0800
Message-ID: <20260702053127.23599-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxB8Gw90Vqn6C7AA--.15449S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr18Xr17XF13AF4fCw1UCFX_yoWrJFy8pF
	98C347Cr4jqF4I9a47Aw4xuw1Yqa1DWr17KF4rGryFka1aq3Z2q3ZYg3WYvFWfur4vkF1S
	vrn29rW09a4UXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4qg4DUUUU

When an architecture implements bpf_jit_inlines_helper_call(), such as
LoongArch, ARM64, PowerPC, and RISC-V, the verifier skips rewriting the
helper call offset (insn->imm) during the bpf_do_misc_fixups() phase,
because the helper is expected to be inlined by the JIT compiler. As a
result, insn->imm remains as the raw helper enum ID.

However, if JIT is disabled at runtime (net.core.bpf_jit_enable=0) or
if the JIT compilation later dynamically fails (e.g., due to OOM), the
core BPF subsystem falls back to the BPF interpreter.

When the interpreter executes (__bpf_call_base + insn->imm) with the
unpatched raw helper ID, it jumps into an unaligned invalid address
space, triggering an instruction alignment fault or a memory access
panic.

To avoid modifying the BPF interpreter's complexity for JIT-specific
paths, just introduce a 'jit_required' flag in struct bpf_prog. When
a program contains helper calls that skip rewriting for JIT inlining,
set this flag to 1. During runtime selection, if JIT compilation is
not available, explicitly reject loading with -ENOTSUPP instead of
falling back to the interpreter, safely preventing the kernel panic.

Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
v6:
  - Place 'jit_required' as a standalone u8 field right before 'stats'
    to reuse the existing 4-byte struct hole (offset 52) based on pahole
    analysis, avoiding the u16->u32 bitfield conversion in v5 which 
    unintentionally changed the layout/alignment of subsequent fields.

v5:
  - Drop the fallback interpreter fixups as per maintainer's feedback.
  - Introduce 'jit_required' member in struct bpf_prog to flag programs
    that strictly rely on JIT.
  - Reject loading with -ENOTSUPP in __bpf_prog_select_runtime() if JIT
    fails or is disabled for these programs.
  - Upgrade 'jited' bitfield group type from u16 to u32 in struct bpf_prog
    to prevent 17-bit overflow warning.

 include/linux/bpf.h | 1 +
 kernel/bpf/core.c   | 2 +-
 kernel/bpf/fixups.c | 4 +++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ba09795e0bfd..f5c283af3cf7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1889,6 +1889,7 @@ struct bpf_prog {
 		u8 digest[SHA256_DIGEST_SIZE];
 		u8 tag[BPF_TAG_SIZE];
 	};
+	u8			jit_required;	/* program strictly requires JIT compiler */
 	struct bpf_prog_stats __percpu *stats;
 	u8 __percpu		*active;	/* u8[BPF_NR_CONTEXTS] for recursion protection */
 	unsigned int		(*bpf_func)(const void *ctx,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 649cce41e13f..a55754bcc593 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2639,7 +2639,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
 
 		fp = bpf_prog_jit_compile(env, fp);
 		bpf_prog_jit_attempt_done(fp);
-		if (!fp->jited && jit_needed) {
+		if (!fp->jited && (jit_needed || fp->jit_required)) {
 			*err = -ENOTSUPP;
 			return fp;
 		}
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 12a8a4eb757f..94e0457a0aa3 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1841,8 +1841,10 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		/* Skip inlining the helper call if the JIT does it. */
-		if (bpf_jit_inlines_helper_call(insn->imm))
+		if (bpf_jit_inlines_helper_call(insn->imm)) {
+			prog->jit_required = 1;
 			goto next_insn;
+		}
 
 		if (insn->imm == BPF_FUNC_get_route_realm)
 			prog->dst_needed = 1;
-- 
2.42.0

