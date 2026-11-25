Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602756;
	b=bR3lVerKO6817kmEDO1EMOBY6XUIVkb2Q7UwHYSWDXVCA8B8XWSmdhBM2/x+mp6prkAU
	 TWecxFUx7ffgE/US29qUC30XLnZ/0mMkBA3v5gwgyGtalUTArd4iTh1pohUsDbHihD1E9
	 jNRZSi2o4N349Mw24KaqdxH9kPO0M7sVK1//qHrgaSVAm1MEQL6g/8xPW4/A30PC3NXlR
	 rGBI1ZCLahD92fq+tjvbYpY7PP2OaTm8N4c9P6JCnLU4vo/va/7o5Rb9+O7r2++IgxD2b
	 /HhGMGmrNeRk3AkxEAXBW4GsKld3genq04bkUSbxQDJq5p25pQIK3vxDxjJOCcRyk1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602756;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=87gTgiD7MR15A5o/DOYg98octD+Ko4H+zSK7DmZdHPI=;
	b=tGecOB1V14ENXrLAQmYgAoeij1umeM7oAzzCEpG2aAZEQg4/5KkgewkPIhRNBvbQPqJs
	 Fz9bFKzm2HzaJf+bTD+u7dfKoJIVVjBPwv+r355zT/EMCBa3+e+GExhzFH82LvjGmA7KG
	 972gwzKtQK/LPiCQCJewX93XzblLpo44ntcur/QFRC/7UPo4PrwzITpZvCIR9WhOfBqQk
	 kQDHidjaR7QQ7gl6NdkxFMKBtMsylcpG58L5gBNty5wUl9eAduUGy3V2Q8G9ERzkkVK8o
	 2NW9kDyO4ShDDxZ0vZfLOEODaTl4gHkRON6CL/B/YvecVBHl0BoPLZAySZRlucI0BPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94113606A336;
	Wed, 25 Nov 2026 10:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94113606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxZ7U6uQZrz+UiAA--.5694S3;
	Wed, 25 Nov 2026 18:32:26 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBxpMwouQZrBEs3AA--.17721S2;
	Wed, 25 Nov 2026 18:32:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1] selftests/bpf: Restrict JIT tests to 64-bit LoongArch
Date: Wed, 25 Nov 2026 18:32:08 +0800
Message-ID: <20261125103208.15242-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpMwouQZrBEs3AA--.17721S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfZF13trW8ur47Wr13CrW5twc_yoW8ZFWxuo
	W3KFZIvw1UGw4UZrWa9r1fJryxXryjkr95XFW7Wa4rCFsrGr15CryUCws5ur4aq398Wayq
	ga47CasFvFZ7GF1kl-sFpf9Il3svdjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYy7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07jFa0PUUUUU=

Now that 32-bit LoongArch support has been added to the kernel while the
eBPF JIT remains 64-bit only (HAVE_EBPF_JIT depends on 64BIT), limit the
BPF JIT-specific test cases and architecture macros to 64-bit LoongArch.

Pass -D__loongarch_grlen to the BPF program compiler in Makefile, so that
it is able to guard the BPF test cases with __loongarch_grlen == 64 under
progs.

Furthermore, rename the macro __arch_loongarch to __arch_loongarch64 in
its definition and callers.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
This is a cleanup patch, inspired by Sashiko AI review:
https://lore.kernel.org/bpf/sashiko-outbox-228693@kernel.org/

 tools/testing/selftests/bpf/Makefile          |  2 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  6 ++--
 tools/testing/selftests/bpf/progs/stream.c    |  2 +-
 .../selftests/bpf/progs/test_ldsx_insn.c      |  3 +-
 .../bpf/progs/verifier_bpf_fastcall.c         |  2 +-
 .../selftests/bpf/progs/verifier_bswap.c      |  2 +-
 .../selftests/bpf/progs/verifier_jit_inline.c |  4 +--
 .../selftests/bpf/progs/verifier_ldsx.c       |  2 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c | 10 +++---
 .../selftests/bpf/progs/verifier_movsx.c      |  2 +-
 .../selftests/bpf/progs/verifier_patch_list.c |  4 +--
 .../selftests/bpf/progs/verifier_precision.c  |  3 +-
 .../selftests/bpf/progs/verifier_sdiv.c       | 34 +++++++++----------
 .../selftests/bpf/progs/verifier_stack_arg.c  |  4 +--
 .../selftests/bpf/progs/verifier_var_off.c    |  4 +--
 tools/testing/selftests/bpf/test_loader.c     | 10 +++---
 16 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ef6736d930e3..7c3d54305a4b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -364,7 +364,7 @@ define get_sys_includes
 $(shell $(1) $(2) -v -E - </dev/null 2>&1 \
 	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
 $(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}') \
-$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | awk '{printf("-D__BITS_PER_LONG=%d", $$3)}') \
+$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | awk '{printf("-D__loongarch_grlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}') \
 $(shell $(1) $(2) -dM -E - </dev/null | grep -E 'MIPS(EL|EB)|_MIPS_SZ(PTR|LONG) |_MIPS_SIM |_ABI(O32|N32|64) ' | awk '{printf("-D%s=%s ", $$2, $$3)}')
 endef
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 6b930cb48f8d..2a617e9a51ed 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -185,7 +185,7 @@
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
-#define __arch_loongarch	__arch("LOONGARCH")
+#define __arch_loongarch64	__arch("LOONGARCH64")
 #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
 #define __prepare_priv		__test_tag("test_prepare_priv")
 #define __load_if_JITed()	__test_tag("load_mode=jited")
@@ -285,7 +285,7 @@
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
      (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||		\
      defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) ||	\
-     defined(__TARGET_ARCH_loongarch)) &&				\
+     (defined(__TARGET_ARCH_loongarch) && __loongarch_grlen == 64)) &&	\
 	(__clang_major__ >= 18 || defined(__BPF_FEATURE_GOTOL))
 #define CAN_USE_GOTOL
 #endif
@@ -300,7 +300,7 @@
 	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||	\
 	 defined(__TARGET_ARCH_s390) ||					\
 	 defined(__TARGET_ARCH_powerpc) ||				\
-	 defined(__TARGET_ARCH_loongarch))
+	 (defined(__TARGET_ARCH_loongarch) && __loongarch_grlen == 64))
 #define CAN_USE_LOAD_ACQ_STORE_REL
 #endif
 
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 8c49a130150b..beba861803be 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -71,7 +71,7 @@ __arch_x86_64
 __arch_arm64
 __arch_s390x
 __arch_riscv64
-__arch_loongarch
+__arch_loongarch64
 __success __retval(0)
 __stderr("ERROR: Timeout detected for may_goto instruction")
 __stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
index 2a2a942737d7..4c58d00eb89d 100644
--- a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
+++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
@@ -7,7 +7,8 @@
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
      (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||       \
-     defined(__TARGET_ARCH_s390) || defined(__TARGET_ARCH_loongarch)) && \
+     (defined(__TARGET_ARCH_loongarch) && __loongarch_grlen == 64) || \
+     defined(__TARGET_ARCH_s390)) && \
      __clang_major__ >= 18
 const volatile int skip = 0;
 #else
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 2120f4e71fb8..b9e3c5741cf9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -979,7 +979,7 @@ __naked void may_goto_interaction_x86_64(void)
 SEC("raw_tp")
 __arch_arm64
 __arch_riscv64
-__arch_loongarch
+__arch_loongarch64
 __log_level(4)
 __msg("subprog 0 (may_goto_interaction) main {{.*}} stack 8")
 /* may_goto counter and timestamp */
diff --git a/tools/testing/selftests/bpf/progs/verifier_bswap.c b/tools/testing/selftests/bpf/progs/verifier_bswap.c
index 48ffb5b242d2..73e5465ee0cc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bswap.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
@@ -7,7 +7,7 @@
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
 	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
-	defined(__TARGET_ARCH_loongarch)) && \
+	(defined(__TARGET_ARCH_loongarch) && __loongarch_grlen == 64)) && \
 	(__clang_major__ >= 18 || defined(__BPF_FEATURE_BSWAP))
 
 SEC("socket")
diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
index 5b92da2ab75c..89a2c27358ba 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
@@ -12,7 +12,7 @@ __arch_arm64
 __jited("	mrs	x8, SP_EL0")
 __arch_riscv64
 __jited("	mv	t6, tp")
-__arch_loongarch
+__arch_loongarch64
 __jited("	move	$a5, $tp")
 int inline_bpf_get_current_task(void)
 {
@@ -23,7 +23,7 @@ int inline_bpf_get_current_task(void)
 
 SEC("fentry/bpf_fentry_test2")
 __success __retval(0)
-__arch_loongarch
+__arch_loongarch64
 __jited("	ld.wu	$a5, $tp, 16")
 int inline_bpf_get_smp_processor_id(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 232082428cb9..6d06a3e61c92 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -8,7 +8,7 @@
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
 	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
-	defined(__TARGET_ARCH_loongarch)) && \
+	(defined(__TARGET_ARCH_loongarch) && __loongarch_grlen == 64)) && \
 	(__clang_major__ >= 18 || defined(__BPF_FEATURE_LDSX))
 
 SEC("socket")
diff --git a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
index 8d231fb2a317..35e7054dc78f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_may_goto_1.c
@@ -12,7 +12,7 @@ __arch_x86_64
 __arch_s390x
 __arch_arm64
 __arch_riscv64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -34,7 +34,7 @@ __arch_x86_64
 __arch_s390x
 __arch_arm64
 __arch_riscv64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -58,7 +58,7 @@ __arch_x86_64
 __arch_s390x
 __arch_arm64
 __arch_riscv64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: r0 = 1")
 __xlated("1: exit")
 __success
@@ -87,7 +87,7 @@ __arch_x86_64
 __arch_s390x
 __arch_arm64
 __arch_riscv64
-__arch_loongarch
+__arch_loongarch64
 /* the main prog sets count, timestamp, owner */
 __xlated("0: r0 = ")
 __xlated("2: r0 = &(void __percpu *)(r0)")
@@ -132,7 +132,7 @@ __arch_x86_64
 __arch_s390x
 __arch_arm64
 __arch_riscv64
-__arch_loongarch
+__arch_loongarch64
 __success
 __retval(0)
 __naked void timed_may_goto_preserves_regs(void)
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 0197c2c21b8e..f038cd4c1d6b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -7,7 +7,7 @@
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
 	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
-	defined(__TARGET_ARCH_loongarch)) && \
+	(defined(__TARGET_ARCH_loongarch) && __loongarch_grlen == 64)) && \
 	(__clang_major__ >= 18 || defined(__BPF_FEATURE_MOVSX))
 
 SEC("socket")
diff --git a/tools/testing/selftests/bpf/progs/verifier_patch_list.c b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
index 80d08d93b625..0bcea2f07ba2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_patch_list.c
+++ b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
@@ -129,7 +129,7 @@ __naked void patch_list_may_goto(void)
 /* the JITs that support gotol */
 #if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
 	defined(__TARGET_ARCH_powerpc) || defined(__TARGET_ARCH_s390) || \
-	defined(__TARGET_ARCH_loongarch) || \
+	(defined(__TARGET_ARCH_loongarch) && __loongarch_grlen == 64) || \
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)
 
 /* The patches turn 8200 divisions into 32800 insns, too far for a 16-bit offset. */
@@ -400,7 +400,7 @@ __arch_x86_64
 __arch_s390x
 __arch_arm64
 __arch_riscv64
-__arch_loongarch
+__arch_loongarch64
 __success
 __xlated("23: call pc+7")
 __xlated("...")
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index d48daefd7b7b..d17ca3fe4f43 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -69,7 +69,8 @@ __naked int bpf_end_to_be(void)
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
 	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
-	defined(__TARGET_ARCH_loongarch)) && __clang_major__ >= 18
+	(defined(__TARGET_ARCH_loongarch) && __loongarch_grlen == 64)) && \
+	__clang_major__ >= 18
 
 SEC("?raw_tp")
 __success __log_level(2)
diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
index 02e2065c9669..fd7c82abebb8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -8,7 +8,7 @@
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
 	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
-	defined(__TARGET_ARCH_loongarch)) && \
+	(defined(__TARGET_ARCH_loongarch) && __loongarch_grlen == 64)) && \
 	(__clang_major__ >= 18 || defined(__BPF_FEATURE_SDIV_SMOD))
 
 SEC("socket")
@@ -775,7 +775,7 @@ SEC("socket")
 __description("SDIV64, overflow r/r, LLONG_MIN/-1")
 __success __retval(1)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: r2 = 0x8000000000000000")
 __xlated("2: r3 = -1")
 __xlated("3: r4 = r2")
@@ -811,7 +811,7 @@ SEC("socket")
 __description("SDIV64, r/r, small_val/-1")
 __success __retval(-5)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: r2 = 5")
 __xlated("1: r3 = -1")
 __xlated("2: r13 = r3")
@@ -841,7 +841,7 @@ SEC("socket")
 __description("SDIV64, overflow r/i, LLONG_MIN/-1")
 __success __retval(1)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: r2 = 0x8000000000000000")
 __xlated("2: r4 = r2")
 __xlated("3: r2 = -r2")
@@ -868,7 +868,7 @@ SEC("socket")
 __description("SDIV64, r/i, small_val/-1")
 __success __retval(-5)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: r2 = 5")
 __xlated("1: r4 = r2")
 __xlated("2: r2 = -r2")
@@ -891,7 +891,7 @@ SEC("socket")
 __description("SDIV32, overflow r/r, INT_MIN/-1")
 __success __retval(1)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: w2 = -2147483648")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
@@ -927,7 +927,7 @@ SEC("socket")
 __description("SDIV32, r/r, small_val/-1")
 __success __retval(5)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: w2 = -5")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
@@ -959,7 +959,7 @@ SEC("socket")
 __description("SDIV32, overflow r/i, INT_MIN/-1")
 __success __retval(1)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: w2 = -2147483648")
 __xlated("1: w4 = w2")
 __xlated("2: w2 = -w2")
@@ -986,7 +986,7 @@ SEC("socket")
 __description("SDIV32, r/i, small_val/-1")
 __success __retval(-5)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: w2 = 5")
 __xlated("1: w4 = w2")
 __xlated("2: w2 = -w2")
@@ -1009,7 +1009,7 @@ SEC("socket")
 __description("SMOD64, overflow r/r, LLONG_MIN/-1")
 __success __retval(0)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: r2 = 0x8000000000000000")
 __xlated("2: r3 = -1")
 __xlated("3: r4 = r2")
@@ -1040,7 +1040,7 @@ SEC("socket")
 __description("SMOD64, r/r, small_val/-1")
 __success __retval(0)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: r2 = 5")
 __xlated("1: r3 = -1")
 __xlated("2: r4 = r2")
@@ -1071,7 +1071,7 @@ SEC("socket")
 __description("SMOD64, overflow r/i, LLONG_MIN/-1")
 __success __retval(0)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: r2 = 0x8000000000000000")
 __xlated("2: r4 = r2")
 __xlated("3: w2 = 0")
@@ -1094,7 +1094,7 @@ SEC("socket")
 __description("SMOD64, r/i, small_val/-1")
 __success __retval(0)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: r2 = 5")
 __xlated("1: r4 = r2")
 __xlated("2: w2 = 0")
@@ -1117,7 +1117,7 @@ SEC("socket")
 __description("SMOD32, overflow r/r, INT_MIN/-1")
 __success __retval(0)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: w2 = -2147483648")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
@@ -1150,7 +1150,7 @@ SEC("socket")
 __description("SMOD32, r/r, small_val/-1")
 __success __retval(0)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: w2 = -5")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
@@ -1183,7 +1183,7 @@ SEC("socket")
 __description("SMOD32, overflow r/i, INT_MIN/-1")
 __success __retval(0)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: w2 = -2147483648")
 __xlated("1: w4 = w2")
 __xlated("2: w2 = 0")
@@ -1206,7 +1206,7 @@ SEC("socket")
 __description("SMOD32, r/i, small_val/-1")
 __success __retval(0)
 __arch_x86_64
-__arch_loongarch
+__arch_loongarch64
 __xlated("0: w2 = 5")
 __xlated("1: w4 = w2")
 __xlated("2: w2 = 0")
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index c642675dd92b..b4f219dfeb92 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -42,7 +42,7 @@ SEC("tc")
 __description("stack_arg: static subprog takes less than its prototype says")
 __success __retval(15)
 __load_if_JITed()
-__arch_x86_64 __arch_arm64 __arch_riscv64 __arch_s390x __arch_loongarch
+__arch_x86_64 __arch_arm64 __arch_riscv64 __arch_s390x __arch_loongarch64
 __naked void less_than_prototype(void)
 {
 	asm volatile ("r2 = %[jmp_table] ll; r3 = 0; call %[bpf_tail_call];"
@@ -1162,7 +1162,7 @@ __naked void stack_arg_precision_fallback(void)
 SEC("tc")
 __description("stack_arg: r11 where JIT has no stack arguments")
 __failure __msg("JIT does not support stack arguments")
-__arch_s390x __arch_loongarch
+__arch_s390x __arch_loongarch64
 __naked void r11_no_jit_support(void)
 {
 	asm volatile (".8byte %[st_r11]; r0 = 0; exit;"
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index bc45adafca33..4f2c1454a009 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -762,7 +762,7 @@ __naked void variable_offset_stack_access_ok(void)
 /* The next two need bpf_jit_bypass_spec_v1() */
 SEC("socket")
 __description("variable-offset stack write of a pointer")
-__arch_loongarch
+__arch_loongarch64
 __success __caps_unpriv(CAP_BPF) __failure_unpriv
 __msg_unpriv("R1 leaks addr into stack")
 __naked void stack_write_ptr_var_off(void)
@@ -785,7 +785,7 @@ __naked void stack_write_ptr_var_off(void)
 
 SEC("socket")
 __description("variable-offset stack pointer at the header of a loop")
-__arch_loongarch
+__arch_loongarch64
 __success __caps_unpriv(CAP_BPF) __success_unpriv
 __naked void stack_ptr_var_off_in_loop(void)
 {
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index d24e4fedae46..a4ca7a76c240 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -386,7 +386,7 @@ enum arch {
 	ARCH_ARM64	= 0x4,
 	ARCH_RISCV64	= 0x8,
 	ARCH_S390X	= 0x10,
-	ARCH_LOONGARCH	= 0x20,
+	ARCH_LOONGARCH64 = 0x20,
 };
 
 static int get_current_arch(void)
@@ -399,8 +399,8 @@ static int get_current_arch(void)
 	return ARCH_RISCV64;
 #elif defined(__s390x__)
 	return ARCH_S390X;
-#elif defined(__loongarch__)
-	return ARCH_LOONGARCH;
+#elif defined(__loongarch__) && __loongarch_grlen == 64
+	return ARCH_LOONGARCH64;
 #endif
 	return ARCH_UNKNOWN;
 }
@@ -605,8 +605,8 @@ static int parse_test_spec(struct test_loader *tester,
 				arch = ARCH_RISCV64;
 			} else if (strcmp(val, "s390x") == 0) {
 				arch = ARCH_S390X;
-			} else if (strcmp(val, "LOONGARCH") == 0) {
-				arch = ARCH_LOONGARCH;
+			} else if (strcmp(val, "LOONGARCH64") == 0) {
+				arch = ARCH_LOONGARCH64;
 			} else {
 				PRINT_FAIL("bad arch spec: '%s'\n", val);
 				err = -EINVAL;
-- 
2.42.0

