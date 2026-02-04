Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77FA39B4A6
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196375; cv=none; b=mlYt7oVv5xEKQ6+Cia9HZQsWP0FPFS11rPfe87W25cC5iM3MFtXmuXexq3PVS6rG6s57r2AFvRBjEu6JrsOUn1LvHTBb9JcjUMlOo1iJuKnYJ9FXwyCZ9gjVFjawb6xzFelLPhqx6CXDAQtLGKTVK3XlWNadA8Zg0dd4c3h2aWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196375; c=relaxed/simple;
	bh=10y9KpWT3eWsJ8kCFASlAvpjw3PDU1GRKWOZqBI6OYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKYddzOso5Ogje6pF5Lb0i9JqJtl2wPDSFkhJUscWN9B2TjFCerlnkiDg0qWxoFGbcfMIjkMnPYoEGcOQaGXSnD1tnfwpyX3lTLKxmTnXjr4RkFypbNCkm0LUioEl5yGBJ3Gjs6jIa3+E2dXuYhzWRCe7mVcer06edHnEkJcT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=fail smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.32.2.84])
	by mtasvr (Coremail) with SMTP id _____wB3FGWDDYNp4uF8AA--.559S3;
	Wed, 04 Feb 2026 17:12:35 +0800 (CST)
Received: from localhost.localdomain (unknown [112.32.2.84])
	by mail-app1 (Coremail) with SMTP id yy_KCgB3y9Z6DYNpHzkFBg--.9500S2;
	Wed, 04 Feb 2026 17:12:27 +0800 (CST)
From: Tianci Cao <ziye@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next v2 1/2] bpf: Add bitwise tracking for BPF_END
Date: Wed,  4 Feb 2026 17:11:45 +0800
Message-Id: <20260204091146.52447-2-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204091146.52447-1-ziye@zju.edu.cn>
References: <20260204091146.52447-1-ziye@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgB3y9Z6DYNpHzkFBg--.9500S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?b47GgAXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083m9YdTa8lQerqvWm+lkv19AnuHV5z9cAim3x8G9opFm2nv9tDXlw97Iqxlxm/eKONzaX
	81z03VBJWy2RDRXSmw3N5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW3Xw4ktFyxKrW5XrWfXF1rKrX_yoW3CFy3pa
	yDGa93Ww48XasrZwnIvw1Iyw15tws5Xr4xK3sF9a42yF12qry5Jr1YqF1ayr15Awn2gF12
	q3Z0vrW293WjvrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1yrW5UUUUU==

This patch implements bitwise tracking (tnum analysis) for BPF_END
(byte swap) operation.

Currently, the BPF verifier does not track value for BPF_END operation,
treating the result as completely unknown. This limits the verifier's
ability to prove safety of programs that perform endianness conversions,
which are common in networking code.

For example, the following code pattern for port number validation:

int test(struct pt_regs *ctx) {
    __u64 x = bpf_get_prandom_u32();
    x &= 0x3f00;           // Range: [0, 0x3f00], var_off: (0x0; 0x3f00)
    x = bswap16(x);        // Should swap to range [0, 0x3f], var_off: (0x0; 0x3f)
    if (x > 0x3f) goto trap;
    return 0;
trap:
    return *(u64 *)NULL;   // Should be unreachable
}

Currently generates verifier output:

1: (54) w0 &= 16128                   ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=16128,var_off=(0x0; 0x3f00))
2: (d7) r0 = bswap16 r0               ; R0=scalar()
3: (25) if r0 > 0x3f goto pc+2        ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=63,var_off=(0x0; 0x3f))

Without this patch, even though the verifier knows `x` has certain bits
set, after bswap16, it loses all tracking information and treats port
as having a completely unknown value [0, 65535].

According to the BPF instruction set[1], there are 3 kinds of BPF_END:

1. `bswap(16|32|64)`: opcode=0xd7 (BPF_END | BPF_ALU64 | BPF_TO_LE)
   - do unconditional swap
2. `le(16|32|64)`: opcode=0xd4 (BPF_END | BPF_ALU | BPF_TO_LE)
   - on big-endian: do swap
   - on little-endian: truncation (16/32-bit) or no-op (64-bit)
3. `be(16|32|64)`: opcode=0xdc (BPF_END | BPF_ALU | BPF_TO_BE)
   - on little-endian: do swap
   - on big-endian: truncation (16/32-bit) or no-op (64-bit)

Since BPF_END operations are inherently bit-wise permutations, tnum
(bitwise tracking) offers the most efficient and precise mechanism
for value analysis. By implementing `tnum_bswap16`, `tnum_bswap32`,
and `tnum_bswap64`, we can derive exact `var_off` values concisely,
directly reflecting the bit-level changes.

Here is the overview of changes:

1. In `tnum_bswap(16|32|64)` (kernel/bpf/tnum.c):

Call `swab(16|32|64)` function on the value and mask of `var_off`, and
do truncation for 16/32-bit cases.

2. In `adjust_scalar_min_max_vals` (kernel/bpf/verifier.c):

Call helper function `scalar_byte_swap`.
- Only do byte swap when
  * alu64 (unconditional swap) OR
  * switching between big-endian and little-endian machines.
- If need do byte swap:
  * Firstly call `tnum_bswap(16|32|64)` to update `var_off`.
  * Then reset the bound since byte swap scrambles the range.
- For 16/32-bit cases, truncate dst register to match the swapped size.

This enables better verification of networking code that frequently uses
byte swaps for protocol processing, reducing false positive rejections.

[1] https://www.kernel.org/doc/Documentation/bpf/standardization/instruction-set.rst

Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/tnum.h  |  5 +++++
 kernel/bpf/tnum.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/linux/tnum.h b/include/linux/tnum.h
index c52b862dad45..fa4654ffb621 100644
--- a/include/linux/tnum.h
+++ b/include/linux/tnum.h
@@ -63,6 +63,11 @@ struct tnum tnum_union(struct tnum t1, struct tnum t2);
 /* Return @a with all but the lowest @size bytes cleared */
 struct tnum tnum_cast(struct tnum a, u8 size);
 
+/* Swap the bytes of a tnum */
+struct tnum tnum_bswap16(struct tnum a);
+struct tnum tnum_bswap32(struct tnum a);
+struct tnum tnum_bswap64(struct tnum a);
+
 /* Returns true if @a is a known constant */
 static inline bool tnum_is_const(struct tnum a)
 {
diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index f8e70e9c3998..76e71489529a 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -8,6 +8,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/tnum.h>
+#include <linux/swab.h>
 
 #define TNUM(_v, _m)	(struct tnum){.value = _v, .mask = _m}
 /* A completely unknown value */
@@ -253,3 +254,42 @@ struct tnum tnum_const_subreg(struct tnum a, u32 value)
 {
 	return tnum_with_subreg(a, tnum_const(value));
 }
+
+struct tnum tnum_bswap16(struct tnum a)
+{
+	u64 low16_value, low16_mask;
+	u64 swapped_value, swapped_mask;
+
+	low16_value = a.value & 0xFFFF;
+	low16_mask = a.mask & 0xFFFF;
+
+	swapped_value = __builtin_bswap16(low16_value);
+	swapped_mask = __builtin_bswap16(low16_mask);
+
+	return TNUM(swapped_value, swapped_mask);
+}
+
+struct tnum tnum_bswap32(struct tnum a)
+{
+	u64 low32_value, low32_mask;
+	u64 swapped_value, swapped_mask;
+
+	low32_value = a.value & 0xFFFFFFFF;
+	low32_mask = a.mask & 0xFFFFFFFF;
+
+	swapped_value = __builtin_bswap32(low32_value);
+
+	swapped_mask = __builtin_bswap32(low32_mask);
+
+	return TNUM(swapped_value, swapped_mask);
+}
+
+struct tnum tnum_bswap64(struct tnum a)
+{
+	u64 swapped_value, swapped_mask;
+
+	swapped_value = __builtin_bswap64(a.value);
+	swapped_mask = __builtin_bswap64(a.mask);
+
+	return TNUM(swapped_value, swapped_mask);
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7ff8394e0da..ec1ad2b5c606 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15844,6 +15844,7 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_XOR:
 	case BPF_OR:
 	case BPF_MUL:
+	case BPF_END:
 		return true;
 
 	/*
@@ -16033,12 +16034,50 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		else
 			scalar_min_max_arsh(dst_reg, &src_reg);
 		break;
+	case BPF_END: {
+		/* Byte swap operation - update var_off using tnum_bswap.
+		 * Three cases:
+		 * 1. bswap* (ALU64 + TO_LE): unconditional swap
+		 * 2. to_le* (ALU + TO_LE): swap on big-endian, zero
+		 *    extension or no-op on little-endian
+		 * 3. to_be* (ALU + TO_BE): swap on little-endian, zero
+		 *    extension or no-op on big-endian
+		 */
+
+		bool to_le = BPF_SRC(insn->code) == BPF_TO_LE;
+		bool is_big_endian;
+#ifdef CONFIG_CPU_BIG_ENDIAN
+		is_big_endian = true;
+#else
+		is_big_endian = false;
+#endif
+		/* Apply bswap if alu64 or switch between large and small end machines*/
+		bool need_bswap = (!alu32) || (to_le ? is_big_endian : !is_big_endian);
+
+		if (need_bswap) {
+			/* Apply byte swap to var_off */
+			if (insn->imm == 16)
+				dst_reg->var_off = tnum_bswap16(dst_reg->var_off);
+			else if (insn->imm == 32)
+				dst_reg->var_off = tnum_bswap32(dst_reg->var_off);
+			else if (insn->imm == 64)
+				dst_reg->var_off = tnum_bswap64(dst_reg->var_off);
+
+			/* Reset bounds so they can be re-derived from new var_off */
+			__mark_reg_unbounded(dst_reg);
+		}
+		/* For bswap16/32, coerce dst register to match the swapped size */
+		if (insn->imm == 16 || insn->imm == 32)
+			coerce_reg_to_size(dst_reg, insn->imm / 8);
+		break;
+	}
 	default:
 		break;
 	}
 
 	/* ALU32 ops are zero extended into 64bit register */
-	if (alu32)
+	/* BPF_END is already handled above, no need for additional zero extension */
+	if (alu32 && opcode != BPF_END)
 		zext_32_to_64(dst_reg);
 	reg_bounds_sync(dst_reg);
 	return 0;
@@ -16218,7 +16257,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		}
 
 		/* check dest operand */
-		if (opcode == BPF_NEG &&
+		if ((opcode == BPF_NEG || opcode == BPF_END) &&
 		    regs[insn->dst_reg].type == SCALAR_VALUE) {
 			err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
 			err = err ?: adjust_scalar_min_max_vals(env, insn,
-- 
2.34.1

