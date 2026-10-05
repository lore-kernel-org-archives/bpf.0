Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5804AE11D
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226394; cv=none; b=iG68jpFHcKE6fv42WI1HCKGu9aQ2bCI20A4Bopw72beQ4EllQZ+dYebU2y+qFT44AEj2qBlnT6iEnuFAKsYWBEtFfwlCEkssHXoavwZngL0Scrx3WF/nVuTPvQCF+ApC5vvkvHFrDchX0gege1QlzjvfT5xz/CDESi3piawYEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226394; c=relaxed/simple;
	bh=yQjmIkiM54xnBiWVkkV4G9eSLrIMrPrBnQn0/eAxbqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rVt2LdVijE/TDsDsk0l02zR7Cg6c8wJcFwDQSelEBw7QyHGMcj4xmL8yrnTTWeAvzBlKda6rXcupuIwMUO7RpdZcvRghbmSFSaBG89i8VLXon7J43haW26fpF3qRoVol2lbeLB4DV3FwXEldvKyUHhn2pPdls+uPVVnZfpVyeiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKgmNtjw; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKgmNtjw"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c0b552ccfso1679158eec.3
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 11:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791226388; x=1791831188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P6SZeKIIPkz4gtXz+pcfUmCIL90dAClz+Izdurgt8TA=;
        b=mKgmNtjwGJUq8XZQKW7AauDfNqMs5y3ZoKdZT2X1RE/cbJvkTJmGejT/AgSI4LhEtK
         syFcH547/BK+JiT0AHgaxS0THvH4nDXDXFpB0FwoyncqEvIuERavkgLzOsusmkeA3GKE
         hT+b2GNYLEAqtZbLoxdTS91chHcepydRCB14LWjwzOS/aSL4QwoZ7GRt/zGcNf8L+ruE
         koiPzqCpJIQhq1MOhJATKyt14gjmL8WotdlQk97N1v06tm7gt7SHHSBdZwCN3qne9MoO
         ZonxZUkZjghmqTLGy8csc9uIv4MlUXUclrou2mBTVyQZtkrHZeBPgdMew9j9kUb3wLvf
         H78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226388; x=1791831188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P6SZeKIIPkz4gtXz+pcfUmCIL90dAClz+Izdurgt8TA=;
        b=tDehM60b1CjY148wPGJvEa09GnhIyXS+SU1FTiiWKx54KvHLi455nh4R+VZByhIUPF
         mjKCJ2uQ4UJ5qdHpLPEizulOD+YXHPYDcyqjSbnpMeBzHQu1f310GSToIX4CN2VjI8Ec
         B/liJ+nJwlXWne9R6OCpz7qy79kR8rSv6h54aAc2lIUEQMh+PxVkRXrQvUeAAFreilv9
         xYZ8sLtwMYB7WyYaM1kb241LI8UbZxwkyulFu6pXRWB2ubY2xqfBD+1AyTD5jW27NYqq
         NPY5ARuod6eSHCE2kGujWnLXngWxjb4+yONqgweMyogPBBkBoxgBtqFHvdn9te5PvgDx
         oklg==
X-Forwarded-Encrypted: i=1; AKwUvBw0aZe9LV2zClS18wKzg3L9wISFVRsf41L+Sc5uJeJIs4kVNonYFxMN98tmBAJ25/U0VQc=@vger.kernel.org
X-Gm-Message-State: AFuF++lOgQNU09/xUJQwxnCUrE6NA1+Z3kfQ87fMtNZBJzuhwksctNZJ
	mgVJnS4APKdg6b+Q6eECqoElJgj7wni1RnKJExJDbSCYTDgJpij/KdnT
X-Gm-Gg: AYBFou2OIq8LPfhcx42wvRjLVNBwaIQ4sSutw4oggl4nW77PrwFxZsoIdctoV7ZeggF
	ntY+REr+RSPiJjTD5ybMyCh2IiEAImFr7pyHnda1ogBRhrtIaQ9ZRh1Hvs3/SFcsJV93riqj/UV
	Uvs+5Hb1EdkDyqJDdy8y6ja7FK+PZf8SCIRcT2Nk5uXS/Nj49CecCEqjWkTWUGyqjXXkScIqbnu
	K3qLkDxc9cfRx5ivRFCiqa/Un1TSXZ70IAs3vOhK2g4lx+rQtfcf1zEJMXQ2QajD3rNHZ92z4s7
	u7Djw8V+zTzNpKMyNcSrPrpwjAqjzy+q1UeMu0y+wz38ul8pSn4N8TuhWQFzQ2nNxhCC1ZiDp0R
	BBGLnCR56/hdmEcTfE/XBGaxx5NKOXLiPFNx+2cJ+vSf8YCjGmbb/UHNPOVgiGhd75KUhvyRRs8
	OzQ6tNADr6/gJQe/KzCKROdxmoQzedmTzUnhg4dnEWiv52/xqKA79BiaV6rxbQDKD+4zQVbwhLz
	G0udxajNgr267ocoTi4/6HB5gUk6ASzTDfbcQLElj+gQNBJV1q2ji7epoHYkEcJW006oA86FA==
X-Received: by 2002:a05:7022:68b:b0:141:517e:52ef with SMTP id a92af1059eb24-14f5c1f22a9mr22840038c88.17.1791226387542;
        Mon, 05 Oct 2026 11:53:07 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (33.223.194.35.bc.googleusercontent.com. [35.194.223.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d83d6af11sm240093c88.10.2026.10.05.11.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 11:53:06 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: corbet@lwn.net,
	skhan@linuxfoundation.org,
	geert@linux-m68k.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	andrii@kernel.org,
	gerg@linux-m68k.org
Cc: rdunlap@infradead.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	jserv@ccns.ncku.edu.tw,
	marscheng@google.com,
	eleanor15x@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	bpf@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v7] m68k, bpf: Add initial BPF JIT compiler support
Date: Mon,  5 Oct 2026 18:52:51 +0000
Message-ID: <20261005185251.2422114-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a BPF JIT compiler for the m68k architecture.

The JIT generates m68k machine code targeting m68020+ processors and
coldfire parts with an mmu (ISA_B/ISA_C). It excludes plain 68000/68010
and non-mmu coldfire processors, as it relies on 32-bit branch
displacements (b<cc>.l) to handle large bpf programs.

Tested with the test_bpf.ko:
test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]

Tested-by: Daniel Palmer <daniel@thingy.jp>
Co-developed-by: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v7:
- Reject unsupported atomic operations in emit_atomic().
- Size subprog stack frames from stack_depth instead of MAX_BPF_STACK.
- Preserve callee's r2 across BPF_PSEUDO_CALL for aggregate returns.
- Handle BPF_ST | BPF_NOSPEC as a no-op.
- Fix tail call prologue offset on CF.
- Clean up state on extra_pass failure in bpf_int_jit_compile().

 .../features/core/eBPF-JIT/arch-support.txt   |    2 +-
 MAINTAINERS                                   |    6 +
 arch/m68k/Kbuild                              |    2 +-
 arch/m68k/Kconfig                             |    1 +
 arch/m68k/net/Makefile                        |    2 +
 arch/m68k/net/bpf_jit_comp.c                  | 1840 +++++++++++++++++
 6 files changed, 1851 insertions(+), 2 deletions(-)
 create mode 100644 arch/m68k/net/Makefile
 create mode 100644 arch/m68k/net/bpf_jit_comp.c

diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
index 83f77f55fc87..dacb50aef055 100644
--- a/Documentation/features/core/eBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -13,7 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |   loongarch: |  ok  |
-    |        m68k: | TODO |
+    |        m68k: |  ok  |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |       nios2: | TODO |
diff --git a/MAINTAINERS b/MAINTAINERS
index c31a32a2c748..b3b310c972a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4807,6 +4807,12 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	arch/loongarch/net/
 
+BPF JIT for M68K
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	arch/m68k/net/
+
 BPF JIT for MIPS (32-BIT AND 64-BIT)
 M:	Johan Almbladh <johan.almbladh@anyfinetworks.com>
 M:	Paul Burton <paulburton@kernel.org>
diff --git a/arch/m68k/Kbuild b/arch/m68k/Kbuild
index 7762af9f6def..058ad41a728c 100644
--- a/arch/m68k/Kbuild
+++ b/arch/m68k/Kbuild
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y				+= kernel/ mm/
+obj-y				+= kernel/ mm/ net/
 obj-$(CONFIG_Q40)		+= q40/
 obj-$(CONFIG_AMIGA)		+= amiga/
 obj-$(CONFIG_ATARI)		+= atari/
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 11835eb59d94..f334fca80f3f 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -31,6 +31,7 @@ config M68K
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_DEBUG_BUGVERBOSE
+	select HAVE_EBPF_JIT if MMU
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_HAS_NO_UNALIGNED
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MOD_ARCH_SPECIFIC
diff --git a/arch/m68k/net/Makefile b/arch/m68k/net/Makefile
new file mode 100644
index 000000000000..ec5b14763316
--- /dev/null
+++ b/arch/m68k/net/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o
diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
new file mode 100644
index 000000000000..6c40d358acd4
--- /dev/null
+++ b/arch/m68k/net/bpf_jit_comp.c
@@ -0,0 +1,1840 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * BPF JIT compiler for m68k
+ *
+ * Copyright (C) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <linux/bpf.h>
+#include <linux/filter.h>
+#include <linux/irqflags.h>
+#include <linux/slab.h>
+#include <asm/cacheflush.h>
+#include <linux/math64.h>
+#include <linux/limits.h>
+
+#define STACK_OFFSET(k) (-4 - (4 * (k)))
+
+enum {
+	BPF_R1_HI, BPF_R1_LO,
+	BPF_R2_HI, BPF_R2_LO,
+	BPF_R3_HI, BPF_R3_LO,
+	BPF_R4_HI, BPF_R4_LO,
+	BPF_R5_HI, BPF_R5_LO,
+	BPF_R6_HI, BPF_R6_LO,
+	BPF_R7_HI, BPF_R7_LO,
+	BPF_R8_HI, BPF_R8_LO,
+	BPF_R9_HI, BPF_R9_LO,
+	BPF_R10_HI, BPF_R10_LO,
+	BPF_AX_HI, BPF_AX_LO,
+	BPF_TC_HI, BPF_TC_LO,
+	BPF_JIT_SCRATCH_REGS,
+};
+
+#define SCRATCH_SIZE (BPF_JIT_SCRATCH_REGS * 4)
+
+#define TMP_REG_1 14
+#define TMP_REG_2 15
+
+#define M68K_D0 0
+#define M68K_D1 1
+#define M68K_D2 2
+#define M68K_D3 3
+#define M68K_D4 4
+#define M68K_D5 5
+
+static const s8 bpf2m68k[16][2] = {
+	[BPF_REG_0]  = {M68K_D1, M68K_D0},
+	[BPF_REG_1]  = {STACK_OFFSET(BPF_R1_HI),  STACK_OFFSET(BPF_R1_LO)},
+	[BPF_REG_2]  = {STACK_OFFSET(BPF_R2_HI),  STACK_OFFSET(BPF_R2_LO)},
+	[BPF_REG_3]  = {STACK_OFFSET(BPF_R3_HI),  STACK_OFFSET(BPF_R3_LO)},
+	[BPF_REG_4]  = {STACK_OFFSET(BPF_R4_HI),  STACK_OFFSET(BPF_R4_LO)},
+	[BPF_REG_5]  = {STACK_OFFSET(BPF_R5_HI),  STACK_OFFSET(BPF_R5_LO)},
+	[BPF_REG_6]  = {STACK_OFFSET(BPF_R6_HI),  STACK_OFFSET(BPF_R6_LO)},
+	[BPF_REG_7]  = {STACK_OFFSET(BPF_R7_HI),  STACK_OFFSET(BPF_R7_LO)},
+	[BPF_REG_8]  = {STACK_OFFSET(BPF_R8_HI),  STACK_OFFSET(BPF_R8_LO)},
+	[BPF_REG_9]  = {STACK_OFFSET(BPF_R9_HI),  STACK_OFFSET(BPF_R9_LO)},
+	[BPF_REG_10] = {STACK_OFFSET(BPF_R10_HI), STACK_OFFSET(BPF_R10_LO)},
+	[BPF_REG_AX] = {STACK_OFFSET(BPF_AX_HI),  STACK_OFFSET(BPF_AX_LO)},
+	[TMP_REG_1]  = {M68K_D3, M68K_D2},
+	[TMP_REG_2]  = {M68K_D5, M68K_D4},
+};
+
+struct jit_ctx {
+	const struct bpf_prog *prog;
+	u16 *target;
+	unsigned int idx;
+	int *offsets;
+};
+
+static noinline u32 jit_mul32(u32 a, u32 b)
+{
+	return a * b;
+}
+
+static noinline u32 jit_div32(u32 a, u32 b)
+{
+	return b ? a / b : 0;
+}
+
+static noinline u32 jit_mod32(u32 a, u32 b)
+{
+	return b ? a % b : a;
+}
+
+static noinline s32 jit_sdiv32(s32 a, s32 b)
+{
+	if (b == 0)
+		return 0;
+	if (a == S32_MIN && b == -1)
+		return S32_MIN;
+	return a / b;
+}
+
+static noinline s32 jit_smod32(s32 a, s32 b)
+{
+	if (b == 0)
+		return a;
+	if (a == S32_MIN && b == -1)
+		return 0;
+	return a % b;
+}
+
+static noinline u64 jit_mul64(u64 a, u64 b)
+{
+	return a * b;
+}
+
+static noinline u64 jit_div64(u64 a, u64 b)
+{
+	return b ? div64_u64(a, b) : 0;
+}
+
+static noinline s64 jit_sdiv64(s64 a, s64 b)
+{
+	if (b == 0)
+		return 0;
+	if (a == S64_MIN && b == -1)
+		return S64_MIN;
+	return div64_s64(a, b);
+}
+
+static noinline u64 jit_mod64(u64 a, u64 b)
+{
+	u64 rem;
+
+	if (b == 0)
+		return a;
+	div64_u64_rem(a, b, &rem);
+	return rem;
+}
+
+static noinline s64 jit_smod64(s64 a, s64 b)
+{
+	if (b == 0)
+		return a;
+	if (a == S64_MIN && b == -1)
+		return 0;
+	return a - div64_s64(a, b) * b;
+}
+
+static u32 jit_atomic32(u32 *ptr, u32 val, u32 op, u32 cmp)
+{
+	unsigned long flags;
+	u32 old;
+
+	local_irq_save(flags);
+	old = *ptr;
+	switch (op) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+		*ptr += val;
+		break;
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+		*ptr &= val;
+		break;
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+		*ptr |= val;
+		break;
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
+		*ptr ^= val;
+		break;
+	case BPF_XCHG:
+		*ptr = val;
+		break;
+	case BPF_CMPXCHG:
+		if (old == cmp)
+			*ptr = val;
+		break;
+	}
+	local_irq_restore(flags);
+
+	return old;
+}
+
+static u64 jit_atomic64(u32 *ptr, u32 val_hi, u32 val_lo, u32 op, u32 cmp_hi, u32 cmp_lo)
+{
+	unsigned long flags;
+	u64 old, val, cmp;
+	u64 *ptr64 = (u64 *)ptr;
+
+	val = ((u64)val_hi << 32) | val_lo;
+	cmp = ((u64)cmp_hi << 32) | cmp_lo;
+
+	local_irq_save(flags);
+	old = *ptr64;
+	switch (op) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+		*ptr64 += val;
+		break;
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+		*ptr64 &= val;
+		break;
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+		*ptr64 |= val;
+		break;
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
+		*ptr64 ^= val;
+		break;
+	case BPF_XCHG:
+		*ptr64 = val;
+		break;
+	case BPF_CMPXCHG:
+		if (old == cmp)
+			*ptr64 = val;
+		break;
+	}
+	local_irq_restore(flags);
+
+	return old;
+}
+
+static inline void emit_16(struct jit_ctx *ctx, u16 inst)
+{
+	if (ctx->target)
+		ctx->target[ctx->idx] = inst;
+	ctx->idx++;
+}
+
+static inline void emit_32(struct jit_ctx *ctx, u32 val)
+{
+	emit_16(ctx, val >> 16);
+	emit_16(ctx, val & 0xffff);
+}
+
+static inline bool is_stacked(s8 reg)
+{
+	return reg < 0;
+}
+
+static s8 bpf_get_reg32(s8 bpf_reg, s8 tmp_reg, struct jit_ctx *ctx)
+{
+	if (is_stacked(bpf_reg)) {
+		emit_16(ctx, 0x202e | (tmp_reg << 9));		/* move.l d16(%fp), reg */
+		emit_16(ctx, (u16)bpf_reg);
+		return tmp_reg;
+	}
+	return bpf_reg;
+}
+
+static void bpf_put_reg32(s8 bpf_reg, s8 src_reg, struct jit_ctx *ctx)
+{
+	if (is_stacked(bpf_reg)) {
+		emit_16(ctx, 0x2d40 | src_reg);			/* move.l reg, d16(%fp) */
+		emit_16(ctx, (u16)bpf_reg);
+	} else if (bpf_reg != src_reg) {
+		emit_16(ctx, 0x2000 | (bpf_reg << 9) | src_reg); /* move.l src, dst */
+	}
+}
+
+static void emit_alu32_neg(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
+	s8 d_reg = bpf_get_reg32(dst[1], tmp1[1], ctx);
+
+	emit_16(ctx, 0x4480 | d_reg);				/* neg.l d_reg */
+
+	bpf_put_reg32(dst[1], d_reg, ctx);
+	emit_16(ctx, 0x7000 | (tmp1[0] << 9));			/* moveq #0, tmp1 */
+	bpf_put_reg32(dst[0], tmp1[0], ctx);
+}
+
+static void emit_alu64_neg(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
+	s8 d_lo = bpf_get_reg32(dst[1], tmp1[1], ctx);
+	s8 d_hi = bpf_get_reg32(dst[0], tmp1[0], ctx);
+
+	emit_16(ctx, 0x4480 | d_lo);				/* neg.l d_lo */
+	emit_16(ctx, 0x4080 | d_hi);				/* negx.l d_hi */
+
+	bpf_put_reg32(dst[1], d_lo, ctx);
+	bpf_put_reg32(dst[0], d_hi, ctx);
+}
+
+static void emit_alu32_x(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *src = bpf2m68k[insn->src_reg];
+	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
+	const s8 *tmp2 = bpf2m68k[TMP_REG_2];
+	s8 d_reg, s_reg;
+
+	d_reg = bpf_get_reg32(dst[1], tmp1[1], ctx);
+	s_reg = bpf_get_reg32(src[1], tmp2[1], ctx);
+
+	switch (BPF_OP(insn->code)) {
+	case BPF_MOV:
+		if (insn->off == 8 || insn->off == 16) {
+			if (d_reg != s_reg)
+				emit_16(ctx, 0x2000 | (d_reg << 9) | s_reg); /* move.l src, dst */
+			if (insn->off == 8)
+				emit_16(ctx, 0x49c0 | d_reg);	/* extb.l d_reg */
+			else
+				emit_16(ctx, 0x48c0 | d_reg);	/* ext.l d_reg */
+		} else {
+			if (d_reg != s_reg)
+				emit_16(ctx, 0x2000 | (d_reg << 9) | s_reg); /* move.l src, dst */
+		}
+		break;
+	case BPF_ADD:
+		emit_16(ctx, 0xd080 | (d_reg << 9) | s_reg);	/* add.l src, dst */
+		break;
+	case BPF_SUB:
+		emit_16(ctx, 0x9080 | (d_reg << 9) | s_reg);	/* sub.l src, dst */
+		break;
+	case BPF_AND:
+		emit_16(ctx, 0xc080 | (d_reg << 9) | s_reg);	/* and.l src, dst */
+		break;
+	case BPF_OR:
+		emit_16(ctx, 0x8080 | (d_reg << 9) | s_reg);	/* or.l src, dst */
+		break;
+	case BPF_XOR:
+		emit_16(ctx, 0xb180 | (s_reg << 9) | d_reg);	/* eor.l src, dst */
+		break;
+	case BPF_LSH:
+	case BPF_RSH:
+	case BPF_ARSH: {
+		s8 count_reg = tmp2[1];
+
+		if (s_reg != count_reg)
+			emit_16(ctx, 0x2000 | (count_reg << 9) | s_reg); /* move.l src, count */
+
+		emit_16(ctx, 0x0280 | count_reg);		/* andi.l #imm, count */
+		emit_32(ctx, 0x1f);
+
+		if (BPF_OP(insn->code) == BPF_LSH)
+			emit_16(ctx, 0xe1a8 | (count_reg << 9) | d_reg); /* lsl.l count, dst */
+		else if (BPF_OP(insn->code) == BPF_RSH)
+			emit_16(ctx, 0xe0a8 | (count_reg << 9) | d_reg); /* lsr.l count, dst */
+		else
+			emit_16(ctx, 0xe0a0 | (count_reg << 9) | d_reg); /* asr.l count, dst */
+		break;
+	}
+	}
+
+	bpf_put_reg32(dst[1], d_reg, ctx);
+	emit_16(ctx, 0x7000 | (tmp1[0] << 9));			/* moveq #0, tmp1 */
+	bpf_put_reg32(dst[0], tmp1[0], ctx);
+}
+
+static void emit_alu32_k(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
+	const s8 *tmp2 = bpf2m68k[TMP_REG_2];
+	s8 d_reg;
+	s32 imm = insn->imm;
+	bool is_moveq = (imm >= -128 && imm <= 127);
+
+	d_reg = bpf_get_reg32(dst[1], tmp1[1], ctx);
+
+	switch (BPF_OP(insn->code)) {
+	case BPF_MOV:
+		if (is_moveq) {
+			emit_16(ctx, 0x7000 | (d_reg << 9) | (imm & 0xff)); /* moveq #imm, dst */
+		} else {
+			emit_16(ctx, 0x203c | (d_reg << 9));		/* move.l #imm, dst */
+			emit_32(ctx, imm);
+		}
+		break;
+	case BPF_ADD:
+		if (is_moveq) {
+			emit_16(ctx, 0x7000 | (tmp2[1] << 9) | (imm & 0xff)); /* moveq #imm, tmp2 */
+			emit_16(ctx, 0xd080 | (d_reg << 9) | tmp2[1]);	/* add.l tmp2, dst */
+		} else {
+			emit_16(ctx, 0x0680 | d_reg);			/* addi.l #imm, dst */
+			emit_32(ctx, imm);
+		}
+		break;
+	case BPF_SUB:
+		if (is_moveq) {
+			emit_16(ctx, 0x7000 | (tmp2[1] << 9) | (imm & 0xff)); /* moveq #imm, tmp2 */
+			emit_16(ctx, 0x9080 | (d_reg << 9) | tmp2[1]);	/* sub.l tmp2, dst */
+		} else {
+			emit_16(ctx, 0x0480 | d_reg);			/* subi.l #imm, dst */
+			emit_32(ctx, imm);
+		}
+		break;
+	case BPF_AND:
+		if (is_moveq) {
+			emit_16(ctx, 0x7000 | (tmp2[1] << 9) | (imm & 0xff)); /* moveq #imm, tmp2 */
+			emit_16(ctx, 0xc080 | (d_reg << 9) | tmp2[1]);	/* and.l tmp2, dst */
+		} else {
+			emit_16(ctx, 0x0280 | d_reg);			/* andi.l #imm, dst */
+			emit_32(ctx, imm);
+		}
+		break;
+	case BPF_OR:
+		if (is_moveq) {
+			emit_16(ctx, 0x7000 | (tmp2[1] << 9) | (imm & 0xff)); /* moveq #imm, tmp2 */
+			emit_16(ctx, 0x8080 | (d_reg << 9) | tmp2[1]);	/* or.l tmp2, dst */
+		} else {
+			emit_16(ctx, 0x0080 | d_reg);			/* ori.l #imm, dst */
+			emit_32(ctx, imm);
+		}
+		break;
+	case BPF_XOR:
+		if (is_moveq) {
+			emit_16(ctx, 0x7000 | (tmp2[1] << 9) | (imm & 0xff)); /* moveq #imm, tmp2 */
+			emit_16(ctx, 0xb180 | (tmp2[1] << 9) | d_reg);	/* eor.l tmp2, dst */
+		} else {
+			emit_16(ctx, 0x0a80 | d_reg);			/* eori.l #imm, dst */
+			emit_32(ctx, imm);
+		}
+		break;
+	case BPF_LSH:
+	case BPF_RSH:
+	case BPF_ARSH:
+		emit_16(ctx, 0x7000 | (tmp2[1] << 9) | (imm & 0x1f));	/* moveq #imm, count */
+
+		if (BPF_OP(insn->code) == BPF_LSH)
+			emit_16(ctx, 0xe1a8 | (tmp2[1] << 9) | d_reg);	/* lsl.l count, dst */
+		else if (BPF_OP(insn->code) == BPF_RSH)
+			emit_16(ctx, 0xe0a8 | (tmp2[1] << 9) | d_reg);	/* lsr.l count, dst */
+		else
+			emit_16(ctx, 0xe0a0 | (tmp2[1] << 9) | d_reg);	/* asr.l count, dst */
+		break;
+	}
+
+	bpf_put_reg32(dst[1], d_reg, ctx);
+	emit_16(ctx, 0x7000 | (tmp1[0] << 9));				/* moveq #0, tmp1 */
+	bpf_put_reg32(dst[0], tmp1[0], ctx);
+}
+
+static void emit_alu64_x(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *src = bpf2m68k[insn->src_reg];
+	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
+	const s8 *tmp2 = bpf2m68k[TMP_REG_2];
+	s8 d_lo, d_hi, s_lo, s_hi;
+
+	d_lo = bpf_get_reg32(dst[1], tmp1[1], ctx);
+	d_hi = bpf_get_reg32(dst[0], tmp1[0], ctx);
+	s_lo = bpf_get_reg32(src[1], tmp2[1], ctx);
+	s_hi = bpf_get_reg32(src[0], tmp2[0], ctx);
+
+	switch (BPF_OP(insn->code)) {
+	case BPF_MOV:
+		if (insn->off == 8 || insn->off == 16 || insn->off == 32) {
+			if (d_lo != s_lo)
+				emit_16(ctx, 0x2000 | (d_lo << 9) | s_lo); /* move.l src, dst */
+
+			if (insn->off == 8)
+				emit_16(ctx, 0x49c0 | d_lo);		/* extb.l d_lo */
+			else if (insn->off == 16)
+				emit_16(ctx, 0x48c0 | d_lo);		/* ext.l d_lo */
+
+			emit_16(ctx, 0x4a80 | d_lo);			/* tst.l d_lo */
+			emit_16(ctx, 0x5bc0 | d_hi);			/* smi d_hi */
+			emit_16(ctx, 0x49c0 | d_hi);			/* extb.l d_hi */
+		} else {
+			if (d_lo != s_lo)
+				emit_16(ctx, 0x2000 | (d_lo << 9) | s_lo); /* move.l s_lo, d_lo */
+			if (d_hi != s_hi)
+				emit_16(ctx, 0x2000 | (d_hi << 9) | s_hi); /* move.l s_hi, d_hi */
+		}
+		break;
+	case BPF_ADD:
+		emit_16(ctx, 0xd080 | (d_lo << 9) | s_lo);		/* add.l s_lo, d_lo */
+		emit_16(ctx, 0xd180 | (d_hi << 9) | s_hi);		/* addx.l s_hi, d_hi */
+		break;
+	case BPF_SUB:
+		emit_16(ctx, 0x9080 | (d_lo << 9) | s_lo);		/* sub.l s_lo, d_lo */
+		emit_16(ctx, 0x9180 | (d_hi << 9) | s_hi);		/* subx.l s_hi, d_hi */
+		break;
+	case BPF_AND:
+		emit_16(ctx, 0xc080 | (d_lo << 9) | s_lo);		/* and.l s_lo, d_lo */
+		emit_16(ctx, 0xc080 | (d_hi << 9) | s_hi);		/* and.l s_hi, d_hi */
+		break;
+	case BPF_OR:
+		emit_16(ctx, 0x8080 | (d_lo << 9) | s_lo);		/* or.l s_lo, d_lo */
+		emit_16(ctx, 0x8080 | (d_hi << 9) | s_hi);		/* or.l s_hi, d_hi */
+		break;
+	case BPF_XOR:
+		emit_16(ctx, 0xb180 | (s_lo << 9) | d_lo);		/* eor.l s_lo, d_lo */
+		emit_16(ctx, 0xb180 | (s_hi << 9) | d_hi);		/* eor.l s_hi, d_hi */
+		break;
+	}
+
+	bpf_put_reg32(dst[1], d_lo, ctx);
+	bpf_put_reg32(dst[0], d_hi, ctx);
+}
+
+static void emit_alu64_k(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
+	const s8 *tmp2 = bpf2m68k[TMP_REG_2];
+	s8 d_lo, d_hi, s_lo, s_hi;
+	u32 imm_lo = insn->imm;
+	u32 imm_hi = insn->imm < 0 ? 0xffffffff : 0;
+
+	d_lo = bpf_get_reg32(dst[1], tmp1[1], ctx);
+	d_hi = bpf_get_reg32(dst[0], tmp1[0], ctx);
+
+	if (BPF_OP(insn->code) == BPF_MOV) {
+		emit_16(ctx, 0x203c | (d_lo << 9));			/* move.l #imm, d_lo */
+		emit_32(ctx, imm_lo);
+		emit_16(ctx, 0x203c | (d_hi << 9));			/* move.l #imm, d_hi */
+		emit_32(ctx, imm_hi);
+		bpf_put_reg32(dst[1], d_lo, ctx);
+		bpf_put_reg32(dst[0], d_hi, ctx);
+		return;
+	}
+
+	s_lo = tmp2[1];
+	s_hi = tmp2[0];
+
+	emit_16(ctx, 0x203c | (s_lo << 9));				/* move.l #imm, s_lo */
+	emit_32(ctx, imm_lo);
+	emit_16(ctx, 0x203c | (s_hi << 9));				/* move.l #imm, s_hi */
+	emit_32(ctx, imm_hi);
+
+	switch (BPF_OP(insn->code)) {
+	case BPF_ADD:
+		emit_16(ctx, 0xd080 | (d_lo << 9) | s_lo);		/* add.l s_lo, d_lo */
+		emit_16(ctx, 0xd180 | (d_hi << 9) | s_hi);		/* addx.l s_hi, d_hi */
+		break;
+	case BPF_SUB:
+		emit_16(ctx, 0x9080 | (d_lo << 9) | s_lo);		/* sub.l s_lo, d_lo */
+		emit_16(ctx, 0x9180 | (d_hi << 9) | s_hi);		/* subx.l s_hi, d_hi */
+		break;
+	case BPF_AND:
+		emit_16(ctx, 0xc080 | (d_lo << 9) | s_lo);		/* and.l s_lo, d_lo */
+		emit_16(ctx, 0xc080 | (d_hi << 9) | s_hi);		/* and.l s_hi, d_hi */
+		break;
+	case BPF_OR:
+		emit_16(ctx, 0x8080 | (d_lo << 9) | s_lo);		/* or.l s_lo, d_lo */
+		emit_16(ctx, 0x8080 | (d_hi << 9) | s_hi);		/* or.l s_hi, d_hi */
+		break;
+	case BPF_XOR:
+		emit_16(ctx, 0xb180 | (s_lo << 9) | d_lo);		/* eor.l s_lo, d_lo */
+		emit_16(ctx, 0xb180 | (s_hi << 9) | d_hi);		/* eor.l s_hi, d_hi */
+		break;
+	}
+
+	bpf_put_reg32(dst[1], d_lo, ctx);
+	bpf_put_reg32(dst[0], d_hi, ctx);
+}
+
+static inline void emit_lsh64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
+{
+	if (CPU_IS_COLDFIRE) {
+		emit_16(ctx, 0xd080 | (d_lo << 9) | d_lo);		/* add.l d_lo, d_lo */
+		emit_16(ctx, 0xd180 | (d_hi << 9) | d_hi);		/* addx.l d_hi, d_hi */
+	} else {
+		emit_16(ctx, 0xe388 | d_lo);				/* lsll #1, d_lo */
+		emit_16(ctx, 0xe390 | d_hi);				/* roxl.l #1, d_hi */
+	}
+}
+
+static inline void emit_rsh64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
+{
+	if (CPU_IS_COLDFIRE) {
+		emit_16(ctx, 0xe288 | d_lo);				/* lsr.l #1, d_lo */
+		emit_16(ctx, 0xe288 | d_hi);				/* lsr.l #1, d_hi */
+		emit_16(ctx, 0x6400);					/* bcc 1f */
+		emit_16(ctx, 0x0006);
+		emit_16(ctx, 0x08c0 | d_lo);				/* bset #31, d_lo */
+		emit_16(ctx, 0x001f);
+	} else {
+		emit_16(ctx, 0xe288 | d_hi);				/* lsrl #1, d_hi */
+		emit_16(ctx, 0xe290 | d_lo);				/* roxr.l #1, d_lo */
+	}
+}
+
+static inline void emit_arsh64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
+{
+	if (CPU_IS_COLDFIRE) {
+		emit_16(ctx, 0xe288 | d_lo);				/* lsr.l #1, d_lo */
+		emit_16(ctx, 0xe280 | d_hi);				/* asr.l #1, d_hi */
+		emit_16(ctx, 0x6400);					/* bcc 1f */
+		emit_16(ctx, 0x0006);
+		emit_16(ctx, 0x08c0 | d_lo);				/* bset #31, d_lo */
+		emit_16(ctx, 0x001f);
+	} else {
+		emit_16(ctx, 0xe280 | d_hi);				/* asrl #1, d_hi */
+		emit_16(ctx, 0xe290 | d_lo);				/* roxr.l #1, d_lo */
+	}
+}
+
+static void emit_alu64_shift(const struct bpf_insn *insn, struct jit_ctx *ctx, bool is_imm)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
+	const s8 *tmp2 = bpf2m68k[TMP_REG_2];
+	s8 d_lo, d_hi, count_reg;
+	int loop_start, done_idx;
+
+	d_lo = bpf_get_reg32(dst[1], tmp1[1], ctx);
+	d_hi = bpf_get_reg32(dst[0], tmp1[0], ctx);
+	count_reg = tmp2[1];
+
+	if (is_imm) {
+		emit_16(ctx, 0x203c | (count_reg << 9));		/* move.l #imm, count_reg */
+		emit_32(ctx, insn->imm);
+	} else {
+		const s8 *src = bpf2m68k[insn->src_reg];
+		s8 s_lo = bpf_get_reg32(src[1], tmp2[1], ctx);
+
+		if (count_reg != s_lo)
+			emit_16(ctx, 0x2000 | (count_reg << 9) | s_lo);	/* move.l s_lo, count_reg */
+	}
+
+	emit_16(ctx, 0x0280 | count_reg);			/* andi.l #0x3f, count_reg */
+	emit_32(ctx, 0x3f);
+
+	emit_16(ctx, 0x4a80 | count_reg);				/* tst.l count_reg */
+	emit_16(ctx, 0x6700);						/* beq.w done_idx */
+	done_idx = ctx->idx;
+	emit_16(ctx, 0);
+
+	loop_start = ctx->idx;
+
+	if (BPF_OP(insn->code) == BPF_LSH)
+		emit_lsh64(ctx, d_lo, d_hi);
+	else if (BPF_OP(insn->code) == BPF_RSH)
+		emit_rsh64(ctx, d_lo, d_hi);
+	else if (BPF_OP(insn->code) == BPF_ARSH)
+		emit_arsh64(ctx, d_lo, d_hi);
+
+	emit_16(ctx, 0x5380 | count_reg);				/* subq.l #1, count_reg */
+	emit_16(ctx, 0x6600);						/* bne.w loop_start */
+	emit_16(ctx, (loop_start - (int)ctx->idx) * 2);
+
+	if (ctx->target)
+		ctx->target[done_idx] = (ctx->idx - done_idx) * 2;
+
+	bpf_put_reg32(dst[1], d_lo, ctx);
+	bpf_put_reg32(dst[0], d_hi, ctx);
+}
+
+static inline void emit_to_le16(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
+{
+	if (CPU_IS_COLDFIRE) {
+		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
+		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
+		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
+		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
+		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
+	} else {
+		emit_16(ctx, 0x0280 | d_lo);				/* andi.l #0xffff, d_lo */
+		emit_32(ctx, 0xffff);
+		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
+	}
+
+	emit_16(ctx, 0x7000 | (d_hi << 9));				/* moveq #0, d_hi */
+}
+
+static inline void emit_to_le32(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
+{
+	if (CPU_IS_COLDFIRE) {
+		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
+		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
+		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
+		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
+		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
+		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
+		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
+		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
+		emit_16(ctx, 0x2e80 | d_hi);				/* move.l d_hi, (%sp) */
+		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
+		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
+		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
+		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
+		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
+		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
+		emit_16(ctx, 0x809f | (d_lo << 9));			/* or.l (%sp)+, d_lo */
+	} else {
+		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
+		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
+		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
+	}
+
+	emit_16(ctx, 0x7000 | (d_hi << 9));				/* moveq #0, d_hi */
+}
+
+static inline void emit_to_le64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
+{
+	if (CPU_IS_COLDFIRE) {
+		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
+		emit_16(ctx, 0x2f00 | d_hi);				/* move.l d_hi, -(%sp) */
+
+		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
+		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
+		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
+		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
+		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
+		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
+		emit_16(ctx, 0x202f | (d_lo << 9));			/* move.l 4(%sp), d_lo */
+		emit_16(ctx, 0x0004);
+		emit_16(ctx, 0x2f40 | d_hi);				/* move.l d_hi, 4(%sp) */
+		emit_16(ctx, 0x0004);
+		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
+		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
+		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
+		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
+		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
+		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
+		emit_16(ctx, 0x81af | (d_lo << 9));			/* or.l d_lo, 4(%sp) */
+		emit_16(ctx, 0x0004);
+
+		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
+		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
+		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
+		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
+		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
+		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
+		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
+		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
+		emit_16(ctx, 0x2e80 | d_hi);				/* move.l d_hi, (%sp) */
+		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
+		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
+		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
+		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
+		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
+		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
+		emit_16(ctx, 0x809f | (d_lo << 9));			/* or.l (%sp)+, d_lo */
+
+		emit_16(ctx, 0x201f | (d_hi << 9));			/* move.l (%sp)+, d_hi */
+	} else {
+		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
+		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
+		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
+
+		emit_16(ctx, 0xe058 | d_hi);				/* ror.w #8, d_hi */
+		emit_16(ctx, 0x4840 | d_hi);				/* swap d_hi */
+		emit_16(ctx, 0xe058 | d_hi);				/* ror.w #8, d_hi */
+
+		emit_16(ctx, 0xc140 | (d_hi << 9) | d_lo);		/* exg d_lo, d_hi */
+	}
+}
+
+static void emit_bpf_end(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
+	s8 d_lo, d_hi;
+	bool to_le = BPF_SRC(insn->code) == BPF_TO_LE;
+	int imm = insn->imm;
+
+	d_lo = bpf_get_reg32(dst[1], tmp1[1], ctx);
+	d_hi = bpf_get_reg32(dst[0], tmp1[0], ctx);
+
+	if (to_le) {
+		switch (imm) {
+		case 16:
+			emit_to_le16(ctx, d_lo, d_hi);
+			break;
+		case 32:
+			emit_to_le32(ctx, d_lo, d_hi);
+			break;
+		case 64:
+			emit_to_le64(ctx, d_lo, d_hi);
+			break;
+		}
+	} else {
+		switch (imm) {
+		case 16:
+			emit_16(ctx, 0x0280 | d_lo);			/* andi.l #0xffff, d_lo */
+			emit_32(ctx, 0xffff);
+			emit_16(ctx, 0x7000 | (d_hi << 9));		/* moveq #0, d_hi */
+			break;
+		case 32:
+			emit_16(ctx, 0x7000 | (d_hi << 9));		/* moveq #0, d_hi */
+			break;
+		case 64:
+			break;
+		}
+	}
+
+	bpf_put_reg32(dst[1], d_lo, ctx);
+	bpf_put_reg32(dst[0], d_hi, ctx);
+}
+
+static void emit_math_call(const struct bpf_insn *insn, struct jit_ctx *ctx, bool is_64)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *src = bpf2m68k[insn->src_reg];
+	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
+	const s8 *tmp2 = bpf2m68k[TMP_REG_2];
+	s8 d_lo, d_hi, s_lo, s_hi = 0;
+	void *func = NULL;
+	u8 op = BPF_OP(insn->code);
+
+	d_lo = bpf_get_reg32(dst[1], tmp1[1], ctx);
+	d_hi = bpf_get_reg32(dst[0], tmp1[0], ctx);
+
+	if (BPF_SRC(insn->code) == BPF_X) {
+		s_lo = bpf_get_reg32(src[1], tmp2[1], ctx);
+		if (is_64)
+			s_hi = bpf_get_reg32(src[0], tmp2[0], ctx);
+	} else {
+		s_lo = tmp2[1];
+		emit_16(ctx, 0x203c | (s_lo << 9));			/* move.l #imm, s_lo */
+		emit_32(ctx, insn->imm);
+		if (is_64) {
+			s_hi = tmp2[0];
+			emit_16(ctx, 0x203c | (s_hi << 9));		/* move.l #imm, s_hi */
+			emit_32(ctx, insn->imm < 0 ? 0xffffffff : 0);
+		}
+	}
+
+	if (is_64) {
+		switch (op) {
+		case BPF_MUL:
+			func = (void *)jit_mul64;
+			break;
+		case BPF_DIV:
+			func = (void *)jit_div64;
+			break;
+		case BPF_MOD:
+			func = (void *)jit_mod64;
+			break;
+		}
+		if (BPF_CLASS(insn->code) == BPF_ALU64 && op == BPF_DIV && insn->off == 1)
+			func = (void *)jit_sdiv64;
+		if (BPF_CLASS(insn->code) == BPF_ALU64 && op == BPF_MOD && insn->off == 1)
+			func = (void *)jit_smod64;
+	} else {
+		switch (op) {
+		case BPF_MUL:
+			func = (void *)jit_mul32;
+			break;
+		case BPF_DIV:
+			func = (void *)jit_div32;
+			break;
+		case BPF_MOD:
+			func = (void *)jit_mod32;
+			break;
+		}
+		if (BPF_CLASS(insn->code) == BPF_ALU && op == BPF_DIV && insn->off == 1)
+			func = (void *)jit_sdiv32;
+		if (BPF_CLASS(insn->code) == BPF_ALU && op == BPF_MOD && insn->off == 1)
+			func = (void *)jit_smod32;
+	}
+
+	if (is_64) {
+		emit_16(ctx, 0x2f01);					/* move.l d1, -(%sp) */
+		emit_16(ctx, 0x2f00);					/* move.l d0, -(%sp) */
+
+		emit_16(ctx, 0x2f00 | s_lo);				/* move.l s_lo, -(%sp) */
+		emit_16(ctx, 0x2f00 | s_hi);				/* move.l s_hi, -(%sp) */
+		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
+		emit_16(ctx, 0x2f00 | d_hi);				/* move.l d_hi, -(%sp) */
+
+		emit_16(ctx, 0x207c);					/* movea.l #func, %a0 */
+		emit_32(ctx, (u32)func);
+		emit_16(ctx, 0x4e90);					/* jsr (%a0) */
+
+		emit_16(ctx, 0x4fef);					/* lea 16(%sp), %sp */
+		emit_16(ctx, 16);
+
+		emit_16(ctx, 0x2601);					/* move.l %d1, %d3 */
+		emit_16(ctx, 0x2400);					/* move.l %d0, %d2 */
+
+		emit_16(ctx, 0x201f);					/* move.l (%sp)+, d0 */
+		emit_16(ctx, 0x221f);					/* move.l (%sp)+, d1 */
+	} else {
+		emit_16(ctx, 0x2f01);					/* move.l d1, -(%sp) */
+		emit_16(ctx, 0x2f00);					/* move.l d0, -(%sp) */
+
+		emit_16(ctx, 0x2f00 | s_lo);				/* move.l s_lo, -(%sp) */
+		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
+
+		emit_16(ctx, 0x207c);					/* movea.l #func, %a0 */
+		emit_32(ctx, (u32)func);
+		emit_16(ctx, 0x4e90);					/* jsr (%a0) */
+
+		emit_16(ctx, 0x4fef);					/* lea 8(%sp), %sp */
+		emit_16(ctx, 8);
+
+		emit_16(ctx, 0x2600);					/* move.l %d0, %d3 */
+		emit_16(ctx, 0x7400);					/* moveq #0, %d2 */
+
+		emit_16(ctx, 0x201f);					/* move.l (%sp)+, d0 */
+		emit_16(ctx, 0x221f);					/* move.l (%sp)+, d1 */
+	}
+
+	bpf_put_reg32(dst[1], M68K_D3, ctx);
+	bpf_put_reg32(dst[0], M68K_D2, ctx);
+}
+
+static void emit_ldx(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *src = bpf2m68k[insn->src_reg];
+	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
+	s8 d_lo, d_hi;
+	bool is_mem_sx = BPF_MODE(insn->code) == BPF_MEMSX;
+
+	if (is_stacked(src[1])) {
+		emit_16(ctx, 0x206e);				/* movea.l d16(%fp), %a0 */
+		emit_16(ctx, (u16)src[1]);
+	} else {
+		emit_16(ctx, 0x2040 | src[1]);			/* movea.l src, %a0 */
+	}
+
+	d_lo = is_stacked(dst[1]) ? tmp1[1] : dst[1];
+	d_hi = is_stacked(dst[0]) ? tmp1[0] : dst[0];
+
+	switch (BPF_SIZE(insn->code)) {
+	case BPF_B:
+		if (!is_mem_sx)
+			emit_16(ctx, 0x7000 | (d_lo << 9));	/* moveq #0, d_lo */
+		emit_16(ctx, 0x1028 | (d_lo << 9));		/* move.b d16(%a0), d_lo */
+		emit_16(ctx, insn->off);
+		if (is_mem_sx)
+			emit_16(ctx, 0x49c0 | d_lo);	/* extb.l d_lo */
+		break;
+	case BPF_H:
+		if (!is_mem_sx)
+			emit_16(ctx, 0x7000 | (d_lo << 9));	/* moveq #0, d_lo */
+		emit_16(ctx, 0x3028 | (d_lo << 9));		/* move.w d16(%a0), d_lo */
+		emit_16(ctx, insn->off);
+		if (is_mem_sx)
+			emit_16(ctx, 0x48c0 | d_lo);	/* ext.l d_lo */
+		break;
+	case BPF_W:
+		emit_16(ctx, 0x2028 | (d_lo << 9));		/* move.l d16(%a0), d_lo */
+		emit_16(ctx, insn->off);
+		break;
+	case BPF_DW:
+		emit_16(ctx, 0x2028 | (d_hi << 9));		/* move.l d16(%a0), d_hi */
+		emit_16(ctx, insn->off);
+		emit_16(ctx, 0x41e8);				/* lea 4(%a0), %a0 */
+		emit_16(ctx, 4);
+		emit_16(ctx, 0x2028 | (d_lo << 9));		/* move.l d16(%a0), d_lo */
+		emit_16(ctx, insn->off);
+		break;
+	}
+
+	if (BPF_SIZE(insn->code) != BPF_DW) {
+		if (is_mem_sx) {
+			emit_16(ctx, 0x4a80 | d_lo);			/* tst.l d_lo */
+			emit_16(ctx, 0x5bc0 | d_hi);			/* smi d_hi */
+			emit_16(ctx, 0x49c0 | d_hi);			/* extb.l d_hi */
+		} else {
+			emit_16(ctx, 0x7000 | (d_hi << 9));	/* moveq #0, d_hi */
+		}
+	}
+
+	bpf_put_reg32(dst[1], d_lo, ctx);
+	bpf_put_reg32(dst[0], d_hi, ctx);
+}
+
+static void emit_stx(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *src = bpf2m68k[insn->src_reg];
+	const s8 *tmp2 = bpf2m68k[TMP_REG_2];
+	s8 s_lo, s_hi;
+
+	if (is_stacked(dst[1])) {
+		emit_16(ctx, 0x206e);				/* movea.l d16(%fp), %a0 */
+		emit_16(ctx, (u16)dst[1]);
+	} else {
+		emit_16(ctx, 0x2040 | dst[1]);			/* movea.l dst, %a0 */
+	}
+
+	s_lo = bpf_get_reg32(src[1], tmp2[1], ctx);
+
+	switch (BPF_SIZE(insn->code)) {
+	case BPF_B:
+		emit_16(ctx, 0x1140 | s_lo);			/* move.b s_lo, d16(%a0) */
+		emit_16(ctx, insn->off);
+		break;
+	case BPF_H:
+		emit_16(ctx, 0x3140 | s_lo);			/* move.w s_lo, d16(%a0) */
+		emit_16(ctx, insn->off);
+		break;
+	case BPF_W:
+		emit_16(ctx, 0x2140 | s_lo);			/* move.l s_lo, d16(%a0) */
+		emit_16(ctx, insn->off);
+		break;
+	case BPF_DW:
+		s_hi = bpf_get_reg32(src[0], tmp2[0], ctx);
+		emit_16(ctx, 0x2140 | s_hi);			/* move.l s_hi, d16(%a0) */
+		emit_16(ctx, insn->off);
+		emit_16(ctx, 0x41e8);				/* lea 4(%a0), %a0 */
+		emit_16(ctx, 4);
+		emit_16(ctx, 0x2140 | s_lo);			/* move.l s_lo, d16(%a0) */
+		emit_16(ctx, insn->off);
+		break;
+	}
+}
+
+static void emit_st(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *tmp = bpf2m68k[TMP_REG_1];
+
+	if (is_stacked(dst[1])) {
+		emit_16(ctx, 0x206e);				/* movea.l d16(%fp), %a0 */
+		emit_16(ctx, (u16)dst[1]);
+	} else {
+		emit_16(ctx, 0x2040 | dst[1]);			/* movea.l dst, %a0 */
+	}
+
+	emit_16(ctx, 0x203c | (tmp[1] << 9));			/* move.l #imm, tmp */
+	emit_32(ctx, insn->imm);
+
+	switch (BPF_SIZE(insn->code)) {
+	case BPF_B:
+		emit_16(ctx, 0x1140 | tmp[1]);			/* move.b tmp, d16(%a0) */
+		emit_16(ctx, insn->off);
+		break;
+	case BPF_H:
+		emit_16(ctx, 0x3140 | tmp[1]);			/* move.w tmp, d16(%a0) */
+		emit_16(ctx, insn->off);
+		break;
+	case BPF_W:
+		emit_16(ctx, 0x2140 | tmp[1]);			/* move.l tmp, d16(%a0) */
+		emit_16(ctx, insn->off);
+		break;
+	case BPF_DW:
+		emit_16(ctx, 0x203c | (tmp[0] << 9));		/* move.l #imm, tmp */
+		emit_32(ctx, insn->imm < 0 ? 0xffffffff : 0);
+
+		emit_16(ctx, 0x2140 | tmp[0]);			/* move.l tmp, d16(%a0) */
+		emit_16(ctx, insn->off);
+		emit_16(ctx, 0x41e8);				/* lea 4(%a0), %a0 */
+		emit_16(ctx, 4);
+		emit_16(ctx, 0x2140 | tmp[1]);			/* move.l tmp, d16(%a0) */
+		emit_16(ctx, insn->off);
+		break;
+	}
+}
+
+static int emit_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *src = bpf2m68k[insn->src_reg];
+	const s8 *tmp2 = bpf2m68k[TMP_REG_2];
+
+	switch (insn->imm) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
+	case BPF_XCHG:
+	case BPF_CMPXCHG:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (is_stacked(dst[1])) {
+		emit_16(ctx, 0x206e);				/* movea.l d16(%fp), %a0 */
+		emit_16(ctx, (u16)dst[1]);
+	} else {
+		emit_16(ctx, 0x2040 | dst[1]);			/* movea.l dst, %a0 */
+	}
+
+	if (insn->off) {
+		emit_16(ctx, 0x41e8);				/* lea d16(%a0), %a0 */
+		emit_16(ctx, insn->off);
+	}
+
+	if (BPF_SIZE(insn->code) == BPF_W) {
+		s8 s_lo = bpf_get_reg32(src[1], tmp2[1], ctx);
+
+		if (insn->imm != BPF_CMPXCHG) {
+			emit_16(ctx, 0x2f01);			/* move.l d1, -(%sp) */
+			emit_16(ctx, 0x2f00);			/* move.l d0, -(%sp) */
+		}
+
+		emit_16(ctx, 0x2f00 | M68K_D0);			/* move.l %d0, -(%sp) */
+		emit_16(ctx, 0x2f3c);				/* move.l #imm, -(%sp) */
+		emit_32(ctx, insn->imm);
+		emit_16(ctx, 0x2f00 | s_lo);			/* move.l s_lo, -(%sp) */
+		emit_16(ctx, 0x2f08);				/* move.l %a0, -(%sp) */
+
+		emit_16(ctx, 0x207c);				/* movea.l #func, %a0 */
+		emit_32(ctx, (u32)jit_atomic32);
+		emit_16(ctx, 0x4e90);				/* jsr (%a0) */
+
+		emit_16(ctx, 0x4fef);				/* lea 16(%sp), %sp */
+		emit_16(ctx, 16);
+
+		if (insn->imm == BPF_CMPXCHG) {
+			emit_16(ctx, 0x7200);			/* moveq #0, %d1 */
+		} else {
+			bool is_fetch = (insn->imm & BPF_FETCH) || insn->imm == BPF_XCHG;
+
+			if (is_fetch)
+				emit_16(ctx, 0x2600);		/* move.l %d0, %d3 */
+
+			emit_16(ctx, 0x201f);			/* move.l (%sp)+, d0 */
+			emit_16(ctx, 0x221f);			/* move.l (%sp)+, d1 */
+
+			if (is_fetch) {
+				bpf_put_reg32(src[1], M68K_D3, ctx);
+				emit_16(ctx, 0x7400);		/* moveq #0, %d2 */
+				bpf_put_reg32(src[0], M68K_D2, ctx);
+			}
+		}
+
+	} else if (BPF_SIZE(insn->code) == BPF_DW) {
+		s8 s_lo = bpf_get_reg32(src[1], tmp2[1], ctx);
+		s8 s_hi = bpf_get_reg32(src[0], tmp2[0], ctx);
+
+		if (insn->imm != BPF_CMPXCHG) {
+			emit_16(ctx, 0x2f01);			/* move.l d1, -(%sp) */
+			emit_16(ctx, 0x2f00);			/* move.l d0, -(%sp) */
+		}
+
+		emit_16(ctx, 0x2f00 | M68K_D0);			/* move.l %d0, -(%sp) */
+		emit_16(ctx, 0x2f00 | M68K_D1);			/* move.l %d1, -(%sp) */
+		emit_16(ctx, 0x2f3c);				/* move.l #imm, -(%sp) */
+		emit_32(ctx, insn->imm);
+		emit_16(ctx, 0x2f00 | s_lo);			/* move.l s_lo, -(%sp) */
+		emit_16(ctx, 0x2f00 | s_hi);			/* move.l s_hi, -(%sp) */
+		emit_16(ctx, 0x2f08);				/* move.l %a0, -(%sp) */
+
+		emit_16(ctx, 0x207c);				/* movea.l #func, %a0 */
+		emit_32(ctx, (u32)jit_atomic64);
+		emit_16(ctx, 0x4e90);				/* jsr (%a0) */
+
+		emit_16(ctx, 0x4fef);				/* lea 24(%sp), %sp */
+		emit_16(ctx, 24);
+
+		if (insn->imm == BPF_CMPXCHG) {
+			if (CPU_IS_COLDFIRE) {
+				emit_16(ctx, 0x2f00);		/* move.l %d0, -(%sp) */
+				emit_16(ctx, 0x2001);		/* move.l %d1, %d0 */
+				emit_16(ctx, 0x221f);		/* move.l (%sp)+, %d1 */
+			} else {
+				emit_16(ctx, 0xc141);		/* exg %d0, %d1 */
+			}
+		} else {
+			bool is_fetch = (insn->imm & BPF_FETCH) || insn->imm == BPF_XCHG;
+
+			if (is_fetch) {
+				emit_16(ctx, 0x2600);		/* move.l %d0, %d3 */
+				emit_16(ctx, 0x2401);		/* move.l %d1, %d2 */
+			}
+
+			emit_16(ctx, 0x201f);			/* move.l (%sp)+, d0 */
+			emit_16(ctx, 0x221f);			/* move.l (%sp)+, d1 */
+
+			if (is_fetch) {
+				bpf_put_reg32(src[1], M68K_D2, ctx);
+				bpf_put_reg32(src[0], M68K_D3, ctx);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void emit_tail_call(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s8 *r2 = bpf2m68k[BPF_REG_2];
+	const s8 *r3 = bpf2m68k[BPF_REG_3];
+	int jmp_out_1, jmp_out_2, jmp_out_3;
+
+	if (is_stacked(r2[1])) {
+		emit_16(ctx, 0x206e);				/* movea.l d16(%fp), %a0 */
+		emit_16(ctx, (u16)r2[1]);
+	} else {
+		emit_16(ctx, 0x2040 | r2[1]);			/* movea.l r2, %a0 */
+	}
+
+	if (is_stacked(r3[1])) {
+		emit_16(ctx, 0x242e);				/* move.l d16(%fp), %d2 */
+		emit_16(ctx, (u16)r3[1]);
+	} else {
+		emit_16(ctx, 0x2400 | r3[1]);			/* move.l r3, %d2 */
+	}
+
+	emit_16(ctx, 0xb4a8);					/* cmp.l d16(%a0), %d2 */
+	emit_16(ctx, offsetof(struct bpf_array, map.max_entries));
+	emit_16(ctx, 0x6400);					/* bcc.w jmp_out_1 */
+	jmp_out_1 = ctx->idx;
+	emit_16(ctx, 0);
+
+	emit_16(ctx, 0x262e);					/* move.l d16(%fp), %d3 */
+	emit_16(ctx, (u16)STACK_OFFSET(BPF_TC_LO));
+	emit_16(ctx, 0x4a83);					/* tst.l %d3 */
+	emit_16(ctx, 0x6700);					/* beq.w jmp_out_2 */
+	jmp_out_2 = ctx->idx;
+	emit_16(ctx, 0);
+
+	emit_16(ctx, 0x5383);					/* subq.l #1, %d3 */
+	emit_16(ctx, 0x2d43);					/* move.l %d3, d16(%fp) */
+	emit_16(ctx, (u16)STACK_OFFSET(BPF_TC_LO));
+
+	emit_16(ctx, 0xd482);					/* add.l %d2, %d2 */
+	emit_16(ctx, 0xd482);					/* add.l %d2, %d2 */
+	emit_16(ctx, 0x43e8);					/* lea d16(%a0), %a1 */
+	emit_16(ctx, offsetof(struct bpf_array, ptrs));
+	emit_16(ctx, 0xd3c2);					/* adda.l %d2, %a1 */
+
+	emit_16(ctx, 0x2051);					/* movea.l (%a1), %a0 */
+
+	emit_16(ctx, 0x2408);					/* move.l %a0, %d2 */
+	emit_16(ctx, 0x4a82);					/* tst.l %d2 */
+	emit_16(ctx, 0x6700);					/* beq.w jmp_out_3 */
+	jmp_out_3 = ctx->idx;
+	emit_16(ctx, 0);
+
+	emit_16(ctx, 0x2068);					/* movea.l d16(%a0), %a0 */
+	emit_16(ctx, offsetof(struct bpf_prog, bpf_func));
+
+	emit_16(ctx, 0x4ee8);					/* jmp d16(%a0) */
+	emit_16(ctx, CPU_IS_COLDFIRE ? 48 : 44);
+
+	if (ctx->target) {
+		ctx->target[jmp_out_1] = (ctx->idx - jmp_out_1) * 2;
+		ctx->target[jmp_out_2] = (ctx->idx - jmp_out_2) * 2;
+		ctx->target[jmp_out_3] = (ctx->idx - jmp_out_3) * 2;
+	}
+}
+
+static int emit_jmp(const struct bpf_insn *insn, struct jit_ctx *ctx, int curr_i)
+{
+	const s8 *dst = bpf2m68k[insn->dst_reg];
+	const s8 *src = bpf2m68k[insn->src_reg];
+	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
+	const s8 *tmp2 = bpf2m68k[TMP_REG_2];
+	s8 d_lo, d_hi = 0, s_lo, s_hi = 0;
+	bool is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
+	u8 op = BPF_OP(insn->code);
+	int target_insn;
+
+	if (is_jmp32 && op == BPF_JA)
+		target_insn = curr_i + 1 + insn->imm;
+	else
+		target_insn = curr_i + 1 + insn->off;
+
+	if (target_insn < 0 || target_insn > ctx->prog->len)
+		return -EOPNOTSUPP;
+
+	#define EMIT_JMP32(op_base) \
+		do { \
+			int disp = (ctx->offsets[target_insn] - (ctx->idx + 1)) * 2; \
+			emit_16(ctx, (op_base) | 0x00ff); \
+			emit_32(ctx, disp); \
+		} while (0)
+
+	if (op == BPF_JA) {
+		EMIT_JMP32(0x6000);				/* bra.l */
+		return 0;
+	}
+
+	d_lo = bpf_get_reg32(dst[1], tmp1[1], ctx);
+	if (!is_jmp32)
+		d_hi = bpf_get_reg32(dst[0], tmp1[0], ctx);
+
+	if (BPF_SRC(insn->code) == BPF_X) {
+		s_lo = bpf_get_reg32(src[1], tmp2[1], ctx);
+		if (!is_jmp32)
+			s_hi = bpf_get_reg32(src[0], tmp2[0], ctx);
+	} else {
+		s_lo = tmp2[1];
+		emit_16(ctx, 0x203c | (s_lo << 9));		/* move.l #imm, s_lo */
+		emit_32(ctx, insn->imm);
+		if (!is_jmp32) {
+			s_hi = tmp2[0];
+			emit_16(ctx, 0x203c | (s_hi << 9));	/* move.l #imm, s_hi */
+			emit_32(ctx, insn->imm < 0 ? 0xffffffff : 0);
+		}
+	}
+
+	if (op == BPF_JSET) {
+		emit_16(ctx, 0x2000 | (tmp1[1] << 9) | d_lo);	/* move.l d_lo, tmp1_lo */
+		emit_16(ctx, 0xc080 | (tmp1[1] << 9) | s_lo);	/* and.l s_lo, tmp1_lo */
+
+		if (!is_jmp32) {
+			EMIT_JMP32(0x6600);			/* bne.l */
+			emit_16(ctx, 0x2000 | (tmp1[0] << 9) | d_hi); /* move.l d_hi, tmp1_hi */
+			emit_16(ctx, 0xc080 | (tmp1[0] << 9) | s_hi); /* and.l s_hi, tmp1_hi */
+		}
+		EMIT_JMP32(0x6600);				/* bne.l */
+		return 0;
+	}
+
+	if (is_jmp32) {
+		emit_16(ctx, 0xb080 | (d_lo << 9) | s_lo);	/* cmp.l s_lo, d_lo */
+		switch (op) {
+		case BPF_JEQ:
+			EMIT_JMP32(0x6700);			/* beq.l */
+			break;
+		case BPF_JNE:
+			EMIT_JMP32(0x6600);			/* bne.l */
+			break;
+		case BPF_JGT:
+			EMIT_JMP32(0x6200);			/* bhi.l */
+			break;
+		case BPF_JGE:
+			EMIT_JMP32(0x6400);			/* bcc.l */
+			break;
+		case BPF_JLT:
+			EMIT_JMP32(0x6500);			/* bcs.l */
+			break;
+		case BPF_JLE:
+			EMIT_JMP32(0x6300);			/* bls.l */
+			break;
+		case BPF_JSGT:
+			EMIT_JMP32(0x6e00);			/* bgt.l */
+			break;
+		case BPF_JSGE:
+			EMIT_JMP32(0x6c00);			/* bge.l */
+			break;
+		case BPF_JSLT:
+			EMIT_JMP32(0x6d00);			/* blt.l */
+			break;
+		case BPF_JSLE:
+			EMIT_JMP32(0x6f00);			/* ble.l */
+			break;
+		}
+	} else {
+		emit_16(ctx, 0xb080 | (d_hi << 9) | s_hi);	/* cmp.l s_hi, d_hi */
+
+		switch (op) {
+		case BPF_JEQ:
+			emit_16(ctx, 0x6608);			/* bne.s .+8 */
+			emit_16(ctx, 0xb080 | (d_lo << 9) | s_lo); /* cmp.l s_lo, d_lo */
+			EMIT_JMP32(0x6700);			/* beq.l */
+			break;
+		case BPF_JNE:
+			EMIT_JMP32(0x6600);			/* bne.l */
+			emit_16(ctx, 0xb080 | (d_lo << 9) | s_lo); /* cmp.l s_lo, d_lo */
+			EMIT_JMP32(0x6600);			/* bne.l */
+			break;
+		case BPF_JGT:
+			EMIT_JMP32(0x6200);			/* bhi.l */
+			emit_16(ctx, 0x6508);			/* bcs.s .+8 */
+			emit_16(ctx, 0xb080 | (d_lo << 9) | s_lo); /* cmp.l s_lo, d_lo */
+			EMIT_JMP32(0x6200);			/* bhi.l */
+			break;
+		case BPF_JGE:
+			EMIT_JMP32(0x6200);			/* bhi.l */
+			emit_16(ctx, 0x6508);			/* bcs.s .+8 */
+			emit_16(ctx, 0xb080 | (d_lo << 9) | s_lo); /* cmp.l s_lo, d_lo */
+			EMIT_JMP32(0x6400);			/* bcc.l */
+			break;
+		case BPF_JLT:
+			EMIT_JMP32(0x6500);			/* bcs.l */
+			emit_16(ctx, 0x6208);			/* bhi.s .+8 */
+			emit_16(ctx, 0xb080 | (d_lo << 9) | s_lo); /* cmp.l s_lo, d_lo */
+			EMIT_JMP32(0x6500);			/* bcs.l */
+			break;
+		case BPF_JLE:
+			EMIT_JMP32(0x6500);			/* bcs.l */
+			emit_16(ctx, 0x6208);			/* bhi.s .+8 */
+			emit_16(ctx, 0xb080 | (d_lo << 9) | s_lo); /* cmp.l s_lo, d_lo */
+			EMIT_JMP32(0x6300);			/* bls.l */
+			break;
+		case BPF_JSGT:
+			EMIT_JMP32(0x6e00);			/* bgt.l */
+			emit_16(ctx, 0x6d08);			/* blt.s .+8 */
+			emit_16(ctx, 0xb080 | (d_lo << 9) | s_lo); /* cmp.l s_lo, d_lo */
+			EMIT_JMP32(0x6200);			/* bhi.l */
+			break;
+		case BPF_JSGE:
+			EMIT_JMP32(0x6e00);			/* bgt.l */
+			emit_16(ctx, 0x6d08);			/* blt.s .+8 */
+			emit_16(ctx, 0xb080 | (d_lo << 9) | s_lo); /* cmp.l s_lo, d_lo */
+			EMIT_JMP32(0x6400);			/* bcc.l */
+			break;
+		case BPF_JSLT:
+			EMIT_JMP32(0x6d00);			/* blt.l */
+			emit_16(ctx, 0x6e08);			/* bgt.s .+8 */
+			emit_16(ctx, 0xb080 | (d_lo << 9) | s_lo); /* cmp.l s_lo, d_lo */
+			EMIT_JMP32(0x6500);			/* bcs.l */
+			break;
+		case BPF_JSLE:
+			EMIT_JMP32(0x6d00);			/* blt.l */
+			emit_16(ctx, 0x6e08);			/* bgt.s .+8 */
+			emit_16(ctx, 0xb080 | (d_lo << 9) | s_lo); /* cmp.l s_lo, d_lo */
+			EMIT_JMP32(0x6300);			/* bls.l */
+			break;
+		}
+	}
+	#undef EMIT_JMP32
+	return 0;
+}
+
+static int emit_call(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const s8 arg_regs[] = { BPF_REG_5, BPF_REG_4, BPF_REG_3, BPF_REG_2, BPF_REG_1 };
+	const s8 *tmp1 = bpf2m68k[TMP_REG_1];
+	bool extra_pass = ctx->prog->jited;
+	u64 func_addr;
+	bool fixed;
+	int i, err;
+
+	err = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass, &func_addr, &fixed);
+	if (err)
+		return err;
+
+	for (i = 0; i < 5; i++) {
+		const s8 *reg = bpf2m68k[arg_regs[i]];
+		s8 d_lo = bpf_get_reg32(reg[1], tmp1[1], ctx);
+		s8 d_hi = bpf_get_reg32(reg[0], tmp1[0], ctx);
+
+		emit_16(ctx, 0x2f00 | d_lo);			/* move.l d_lo, -(%sp) */
+		emit_16(ctx, 0x2f00 | d_hi);			/* move.l d_hi, -(%sp) */
+	}
+
+	emit_16(ctx, 0x207c);					/* movea.l #func_addr, %a0 */
+	emit_32(ctx, (u32)func_addr);
+
+	emit_16(ctx, 0x4e90);					/* jsr (%a0) */
+
+	emit_16(ctx, 0x4fef);					/* lea 40(%sp), %sp */
+	emit_16(ctx, 40);
+
+	if (insn->src_reg != BPF_PSEUDO_CALL) {
+		if (CPU_IS_COLDFIRE) {
+			emit_16(ctx, 0x2f00);			/* move.l %d0, -(%sp) */
+			emit_16(ctx, 0x2001);			/* move.l %d1, %d0 */
+			emit_16(ctx, 0x221f);			/* move.l (%sp)+, %d1 */
+		} else {
+			emit_16(ctx, 0xc340);			/* exg %d0, %d1 */
+		}
+	} else {
+		emit_16(ctx, 0x2d48);				/* move.l %a0, d16(%fp) */
+		emit_16(ctx, (u16)STACK_OFFSET(BPF_R2_HI));
+		emit_16(ctx, 0x2d49);				/* move.l %a1, d16(%fp) */
+		emit_16(ctx, (u16)STACK_OFFSET(BPF_R2_LO));
+	}
+
+	return 0;
+}
+
+static void build_prologue(struct jit_ctx *ctx)
+{
+	int bpf_stack = ctx->prog->is_func ?
+			round_up(ctx->prog->aux->stack_depth, 4) : MAX_BPF_STACK;
+	int total_stack = SCRATCH_SIZE + bpf_stack;
+	int i;
+
+	emit_16(ctx, 0x7021);					/* moveq #33, %d0 */
+
+	emit_16(ctx, 0x4e56);					/* link %a6, #-total_stack */
+	emit_16(ctx, -total_stack);
+
+	if (CPU_IS_COLDFIRE) {
+		emit_16(ctx, 0x4fef);				/* lea -16(%sp), %sp */
+		emit_16(ctx, 0xfff0);
+		emit_16(ctx, 0x48d7);				/* movem.l d2-d5, (%sp) */
+		emit_16(ctx, 0x003c);
+	} else {
+		emit_16(ctx, 0x48e7);				/* movem.l d2-d5, -(%sp) */
+		emit_16(ctx, 0x3c00);
+	}
+
+	emit_16(ctx, 0x2d40);					/* move.l %d0, off(%fp) */
+	emit_16(ctx, (u16)STACK_OFFSET(BPF_TC_LO));
+
+	if (ctx->prog->is_func) {
+		const s8 arg_regs[] = { BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5 };
+
+		for (i = 0; i < 5; i++) {
+			int offset = 8 + i * 8;
+			const s8 *reg = bpf2m68k[arg_regs[i]];
+
+			emit_16(ctx, 0x202e); /* move.l offset(%fp), %d0 */
+			emit_16(ctx, offset);
+			bpf_put_reg32(reg[0], M68K_D0, ctx);
+
+			emit_16(ctx, 0x202e); /* move.l offset+4(%fp), %d0 */
+			emit_16(ctx, offset + 4);
+			bpf_put_reg32(reg[1], M68K_D0, ctx);
+		}
+	} else {
+		emit_16(ctx, 0x202e);				/* move.l 8(%fp), %d0 */
+		emit_16(ctx, 8);
+		bpf_put_reg32(bpf2m68k[BPF_REG_1][1], M68K_D0, ctx);
+
+		emit_16(ctx, 0x7000 | (M68K_D0 << 9));			/* moveq #0, %d0 */
+		bpf_put_reg32(bpf2m68k[BPF_REG_1][0], M68K_D0, ctx);
+	}
+
+	emit_16(ctx, 0x41ee);					/* lea -SCRATCH_SIZE(%fp), %a0 */
+	emit_16(ctx, -SCRATCH_SIZE);
+	emit_16(ctx, 0x2008);					/* move.l %a0, %d0 */
+
+	bpf_put_reg32(bpf2m68k[BPF_REG_10][1], M68K_D0, ctx);
+	emit_16(ctx, 0x7000 | (M68K_D0 << 9));			/* moveq #0, %d0 */
+	bpf_put_reg32(bpf2m68k[BPF_REG_10][0], M68K_D0, ctx);
+}
+
+static void build_epilogue(struct jit_ctx *ctx)
+{
+	if (ctx->prog->is_func) {
+		emit_16(ctx, 0x206e);				/* movea.l d16(%fp), %a0 */
+		emit_16(ctx, (u16)STACK_OFFSET(BPF_R2_HI));
+		emit_16(ctx, 0x226e);				/* movea.l d16(%fp), %a1 */
+		emit_16(ctx, (u16)STACK_OFFSET(BPF_R2_LO));
+	}
+
+	if (CPU_IS_COLDFIRE) {
+		emit_16(ctx, 0x4cd7);				/* movem.l (%sp), d2-d5 */
+		emit_16(ctx, 0x003c);
+		emit_16(ctx, 0x4fef);				/* lea 16(%sp), %sp */
+		emit_16(ctx, 0x0010);
+	} else {
+		emit_16(ctx, 0x4cdf);				/* movem.l (%sp)+, d2-d5 */
+		emit_16(ctx, 0x003c);
+	}
+
+	emit_16(ctx, 0x4e5e);					/* unlk %fp */
+	emit_16(ctx, 0x4e75);					/* rts */
+}
+
+static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, int i)
+{
+	u8 code = insn->code;
+
+	switch (code) {
+	case BPF_ALU | BPF_NEG:
+		emit_alu32_neg(insn, ctx);
+		break;
+	case BPF_ALU64 | BPF_NEG:
+		emit_alu64_neg(insn, ctx);
+		break;
+
+	case BPF_ALU | BPF_MOV | BPF_X:
+	case BPF_ALU | BPF_ADD | BPF_X:
+	case BPF_ALU | BPF_SUB | BPF_X:
+	case BPF_ALU | BPF_AND | BPF_X:
+	case BPF_ALU | BPF_OR  | BPF_X:
+	case BPF_ALU | BPF_XOR | BPF_X:
+	case BPF_ALU | BPF_LSH | BPF_X:
+	case BPF_ALU | BPF_RSH | BPF_X:
+	case BPF_ALU | BPF_ARSH | BPF_X:
+		emit_alu32_x(insn, ctx);
+		break;
+
+	case BPF_ALU | BPF_MOV | BPF_K:
+	case BPF_ALU | BPF_ADD | BPF_K:
+	case BPF_ALU | BPF_SUB | BPF_K:
+	case BPF_ALU | BPF_AND | BPF_K:
+	case BPF_ALU | BPF_OR  | BPF_K:
+	case BPF_ALU | BPF_XOR | BPF_K:
+	case BPF_ALU | BPF_LSH | BPF_K:
+	case BPF_ALU | BPF_RSH | BPF_K:
+	case BPF_ALU | BPF_ARSH | BPF_K:
+		emit_alu32_k(insn, ctx);
+		break;
+
+	case BPF_ALU64 | BPF_MOV | BPF_X:
+	case BPF_ALU64 | BPF_ADD | BPF_X:
+	case BPF_ALU64 | BPF_SUB | BPF_X:
+	case BPF_ALU64 | BPF_AND | BPF_X:
+	case BPF_ALU64 | BPF_OR  | BPF_X:
+	case BPF_ALU64 | BPF_XOR | BPF_X:
+		emit_alu64_x(insn, ctx);
+		break;
+
+	case BPF_ALU64 | BPF_MOV | BPF_K:
+	case BPF_ALU64 | BPF_ADD | BPF_K:
+	case BPF_ALU64 | BPF_SUB | BPF_K:
+	case BPF_ALU64 | BPF_AND | BPF_K:
+	case BPF_ALU64 | BPF_OR  | BPF_K:
+	case BPF_ALU64 | BPF_XOR | BPF_K:
+		emit_alu64_k(insn, ctx);
+		break;
+
+	case BPF_ALU64 | BPF_LSH | BPF_X:
+	case BPF_ALU64 | BPF_RSH | BPF_X:
+	case BPF_ALU64 | BPF_ARSH | BPF_X:
+		emit_alu64_shift(insn, ctx, false);
+		break;
+
+	case BPF_ALU64 | BPF_LSH | BPF_K:
+	case BPF_ALU64 | BPF_RSH | BPF_K:
+	case BPF_ALU64 | BPF_ARSH | BPF_K:
+		emit_alu64_shift(insn, ctx, true);
+		break;
+
+	case BPF_ALU | BPF_MUL | BPF_X:
+	case BPF_ALU | BPF_DIV | BPF_X:
+	case BPF_ALU | BPF_MOD | BPF_X:
+	case BPF_ALU | BPF_MUL | BPF_K:
+	case BPF_ALU | BPF_DIV | BPF_K:
+	case BPF_ALU | BPF_MOD | BPF_K:
+		emit_math_call(insn, ctx, false);
+		break;
+
+	case BPF_ALU64 | BPF_MUL | BPF_X:
+	case BPF_ALU64 | BPF_DIV | BPF_X:
+	case BPF_ALU64 | BPF_MOD | BPF_X:
+	case BPF_ALU64 | BPF_MUL | BPF_K:
+	case BPF_ALU64 | BPF_DIV | BPF_K:
+	case BPF_ALU64 | BPF_MOD | BPF_K:
+		emit_math_call(insn, ctx, true);
+		break;
+
+	case BPF_ALU | BPF_END | BPF_TO_BE:
+	case BPF_ALU | BPF_END | BPF_TO_LE:
+	case BPF_ALU64 | BPF_END | BPF_TO_BE:
+	case BPF_ALU64 | BPF_END | BPF_TO_LE:
+		emit_bpf_end(insn, ctx);
+		break;
+
+	case BPF_LD | BPF_IMM | BPF_DW: {
+		const struct bpf_insn *insn1 = insn + 1;
+		const s8 *dst = bpf2m68k[insn->dst_reg];
+		const s8 *tmp1 = bpf2m68k[TMP_REG_1];
+		s8 d_lo = bpf_get_reg32(dst[1], tmp1[1], ctx);
+		s8 d_hi = bpf_get_reg32(dst[0], tmp1[0], ctx);
+
+		emit_16(ctx, 0x203c | (d_lo << 9));			/* move.l #imm, d_lo */
+		emit_32(ctx, insn->imm);
+		emit_16(ctx, 0x203c | (d_hi << 9));			/* move.l #imm, d_hi */
+		emit_32(ctx, insn1->imm);
+
+		bpf_put_reg32(dst[1], d_lo, ctx);
+		bpf_put_reg32(dst[0], d_hi, ctx);
+		break;
+	}
+
+	case BPF_LDX | BPF_MEM | BPF_B:
+	case BPF_LDX | BPF_MEM | BPF_H:
+	case BPF_LDX | BPF_MEM | BPF_W:
+	case BPF_LDX | BPF_MEM | BPF_DW:
+	case BPF_LDX | BPF_MEMSX | BPF_B:
+	case BPF_LDX | BPF_MEMSX | BPF_H:
+	case BPF_LDX | BPF_MEMSX | BPF_W:
+		emit_ldx(insn, ctx);
+		break;
+
+	case BPF_STX | BPF_MEM | BPF_B:
+	case BPF_STX | BPF_MEM | BPF_H:
+	case BPF_STX | BPF_MEM | BPF_W:
+	case BPF_STX | BPF_MEM | BPF_DW:
+		emit_stx(insn, ctx);
+		break;
+
+	case BPF_ST | BPF_MEM | BPF_B:
+	case BPF_ST | BPF_MEM | BPF_H:
+	case BPF_ST | BPF_MEM | BPF_W:
+	case BPF_ST | BPF_MEM | BPF_DW:
+		emit_st(insn, ctx);
+		break;
+
+	case BPF_ST | BPF_NOSPEC:
+		break;
+
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		return emit_atomic(insn, ctx);
+
+	case BPF_JMP | BPF_TAIL_CALL:
+		emit_tail_call(insn, ctx);
+		break;
+
+	case BPF_JMP | BPF_JA:
+	case BPF_JMP32 | BPF_JA:
+	case BPF_JMP | BPF_JEQ | BPF_X:
+	case BPF_JMP | BPF_JEQ | BPF_K:
+	case BPF_JMP | BPF_JNE | BPF_X:
+	case BPF_JMP | BPF_JNE | BPF_K:
+	case BPF_JMP | BPF_JGT | BPF_X:
+	case BPF_JMP | BPF_JGT | BPF_K:
+	case BPF_JMP | BPF_JGE | BPF_X:
+	case BPF_JMP | BPF_JGE | BPF_K:
+	case BPF_JMP | BPF_JLT | BPF_X:
+	case BPF_JMP | BPF_JLT | BPF_K:
+	case BPF_JMP | BPF_JLE | BPF_X:
+	case BPF_JMP | BPF_JLE | BPF_K:
+	case BPF_JMP | BPF_JSGT | BPF_X:
+	case BPF_JMP | BPF_JSGT | BPF_K:
+	case BPF_JMP | BPF_JSGE | BPF_X:
+	case BPF_JMP | BPF_JSGE | BPF_K:
+	case BPF_JMP | BPF_JSLT | BPF_X:
+	case BPF_JMP | BPF_JSLT | BPF_K:
+	case BPF_JMP | BPF_JSLE | BPF_X:
+	case BPF_JMP | BPF_JSLE | BPF_K:
+	case BPF_JMP | BPF_JSET | BPF_X:
+	case BPF_JMP | BPF_JSET | BPF_K:
+	case BPF_JMP32 | BPF_JEQ | BPF_X:
+	case BPF_JMP32 | BPF_JEQ | BPF_K:
+	case BPF_JMP32 | BPF_JNE | BPF_X:
+	case BPF_JMP32 | BPF_JNE | BPF_K:
+	case BPF_JMP32 | BPF_JGT | BPF_X:
+	case BPF_JMP32 | BPF_JGT | BPF_K:
+	case BPF_JMP32 | BPF_JGE | BPF_X:
+	case BPF_JMP32 | BPF_JGE | BPF_K:
+	case BPF_JMP32 | BPF_JLT | BPF_X:
+	case BPF_JMP32 | BPF_JLT | BPF_K:
+	case BPF_JMP32 | BPF_JLE | BPF_X:
+	case BPF_JMP32 | BPF_JLE | BPF_K:
+	case BPF_JMP32 | BPF_JSGT | BPF_X:
+	case BPF_JMP32 | BPF_JSGT | BPF_K:
+	case BPF_JMP32 | BPF_JSGE | BPF_X:
+	case BPF_JMP32 | BPF_JSGE | BPF_K:
+	case BPF_JMP32 | BPF_JSLT | BPF_X:
+	case BPF_JMP32 | BPF_JSLT | BPF_K:
+	case BPF_JMP32 | BPF_JSLE | BPF_X:
+	case BPF_JMP32 | BPF_JSLE | BPF_K:
+	case BPF_JMP32 | BPF_JSET | BPF_X:
+	case BPF_JMP32 | BPF_JSET | BPF_K:
+		return emit_jmp(insn, ctx, i);
+
+	case BPF_JMP | BPF_CALL:
+		return emit_call(insn, ctx);
+
+	case BPF_JMP | BPF_EXIT:
+		build_epilogue(ctx);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int build_body(struct jit_ctx *ctx)
+{
+	const struct bpf_prog *prog = ctx->prog;
+	int i;
+
+	for (i = 0; i < prog->len; i++) {
+		const struct bpf_insn *insn = &prog->insnsi[i];
+		int ret;
+
+		if (!ctx->target)
+			ctx->offsets[i] = ctx->idx;
+
+		ret = build_insn(insn, ctx, i);
+		if (ret < 0)
+			return ret;
+
+		if (insn->code == (BPF_LD | BPF_IMM | BPF_DW)) {
+			i++;
+			if (!ctx->target)
+				ctx->offsets[i] = ctx->idx;
+		}
+	}
+
+	if (!ctx->target)
+		ctx->offsets[prog->len] = ctx->idx;
+
+	return 0;
+}
+
+bool bpf_jit_needs_zext(void)
+{
+	return true;
+}
+
+static void jit_fill_hole(void *area, unsigned int size)
+{
+	u16 *ptr;
+
+	for (ptr = area; size >= 2; size -= 2)
+		*ptr++ = 0x4afc;
+}
+
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_prog *prog)
+{
+	struct bpf_binary_header *header = prog->aux->jit_data;
+	struct jit_ctx ctx;
+	unsigned int image_size;
+	u8 *image_ptr;
+	bool extra_pass = prog->jited;
+
+	if (!prog->jit_requested)
+		return prog;
+
+	if (prog->jited && !prog->aux->func)
+		return prog;
+
+	memset(&ctx, 0, sizeof(ctx));
+	ctx.prog = prog;
+
+	ctx.offsets = kvcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);
+	if (!ctx.offsets)
+		goto out_free_hdr;
+
+	build_prologue(&ctx);
+	if (build_body(&ctx) < 0)
+		goto out_free_hdr;
+	build_epilogue(&ctx);
+
+	if (extra_pass) {
+		image_ptr = (u8 *)prog->bpf_func;
+		image_size = prog->jited_len;
+	} else {
+		image_size = ctx.idx * 2;
+		header = bpf_jit_binary_alloc(image_size, &image_ptr, 2, jit_fill_hole);
+		if (!header)
+			goto out_off;
+		prog->aux->jit_data = header;
+	}
+
+	ctx.target = (u16 *)image_ptr;
+	ctx.idx = 0;
+
+	build_prologue(&ctx);
+	if (build_body(&ctx) < 0)
+		goto out_free_hdr;
+	build_epilogue(&ctx);
+
+	flush_icache_range((u32)header, (u32)(ctx.target + ctx.idx));
+
+	if (bpf_jit_enable > 1)
+		bpf_jit_dump(prog->len, image_size, 2, ctx.target);
+
+	if ((!prog->aux->func || extra_pass) && bpf_jit_binary_lock_ro(header))
+		goto out_free_hdr;
+
+	prog->bpf_func = (void *)ctx.target;
+	prog->jited = 1;
+	prog->jited_len = image_size;
+	goto out_off;
+
+out_free_hdr:
+	if (header) {
+		bpf_jit_binary_free(header);
+		prog->aux->jit_data = NULL;
+		prog->bpf_func = NULL;
+		prog->jited = 0;
+		prog->jited_len = 0;
+	}
+out_off:
+	kvfree(ctx.offsets);
+	return prog;
+}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

