Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DBE25B088
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454167; cv=none; b=HxtK0lfos1g9kacJ6Crf9W77vXf/cQyRnM3egKF+QMhrAfXNsZkBUaPUIinc3vzXH6+XlageHRSjmE+ALgSIRhi+wdc4tCm1RMhMrqrOdzrzh1VUbcSe8ta68TVSTRoXhmk0ZJcMPYNtoGPx3QZElf3UHeE4ZcHVZ7rYSh+ap3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454167; c=relaxed/simple;
	bh=wIr5a8hPrPem3nSiecsLY0VbdEaT/h36CgV6uhrVLtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWo6Bfsr0FnfMrWxbXWltFBSbmWi+zpXIyxq3WZu2qm9JjHUCUO5vQE/OMGfD5n8zw7L29ha1ZfT9o/bWG1LzMba+FSTZXERLEKoG5aMTwP6LEg7lzvTS7CqnNtPilVa0L/tSxGvnjsiNDmDiOJfhrEMbe3RIPq9DnYRCQQYxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DnUKZZCt; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DnUKZZCt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Vuglml2+LapqcT7giL7eldKKtb1tOsWWku0Bnf8aY70=; b=DnUKZZCt3FnKKbshxaxItlXpDb
	YhJiq3KPprqXOHzVZaiO4vJyECTQVG4oNQCqtx7BxzCTmQ4/61MqjoPwt2xUFy1T38UXRpwt+rT9c
	Jqn4jWi41hwcrmv4yMTbobjqJV4721UjKtTZMr+8jf+7F/Q7QNpvtjIq/p+N0wsqHMjETXiK6lOqQ
	YKygg+jtZDSHknaJOw/E1qMocyU+8NKLGYb5HBQQrvkAv5OueNpLdqBLLCVves3Gxb5Nlk+6oS0z2
	Qi/63rwOmUZlJv8W0HydUhXfBfCpbBV03AQYzLv4XhmhHBYSo0paLF8UeZhqmdzNsnII0ffROXESf
	G2FYLwiw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtmKo-0009Ub-2F;
	Tue, 11 Aug 2026 15:16:02 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 3/6] bpf, x86: Clear fetch destination on faulting arena atomic
Date: Tue, 11 Aug 2026 15:15:57 +0200
Message-ID: <20260811131600.506721-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811131600.506721-1-daniel@iogearbox.net>
References: <20260811131600.506721-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28089/Tue Aug 11 08:25:05 2026)

populate_extable() encodes "there is no destination register to clear" as
DONT_CLEAR in the DST_REG field of the exception table metadata, and later
ex_handler_bpf() then reuses that very value to derive the direction it
reports the fault with is_write = (reg == DONT_CLEAR). The two coincide
for a plain load or store, but not for a RMW carrying BPF_FETCH. Such an
atomic writes memory, so it has to be reported as a WRITE, and it also reads
the old value into a register, src_reg for BPF_ADD | BPF_FETCH and BPF_XCHG,
r0 for BPF_CMPXCHG, so that register has to be cleared on fault. A single
DONT_CLEAR cannot say both, and the store branch picks it unconditionally:

  [...]
  } else {
          arena_reg = reg2pt_regs[dst_reg];
          fixup_reg = DONT_CLEAR;
  }
  [...]

The reported direction is therefore right, but on a fault over an unmapped
arena page the fetch destination keeps whatever it held before the atomic,
where every other BPF_PROBE_* access delivers 0. Give the metadata its own
ARENA_WRITE bit so that the reported direction no longer depends on whether
there is a register to clear, and fill DST_REG in from bpf_atomic_load_reg().
BPF_{AND,OR,XOR} | BPF_FETCH need no handling here, bpf_jit_supports_insn()
already rejects those in the arena.

Fixes: d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena to x86 JIT")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8dddb5d7af21..d920772af7d5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1473,17 +1473,20 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
  *
  * Bit layout of `fixup` (32-bit):
  *
- * +-----------+--------+-----------+---------+----------+
- * | 31        | 30-24  |   23-16   |   15-8  |    7-0   |
- * |           |        |           |         |          |
- * | ARENA_ACC | Unused | ARENA_REG | DST_REG | INSN_LEN |
- * +-----------+--------+-----------+---------+----------+
+ * +-----------+-------------+--------+-----------+---------+----------+
+ * | 31        | 30          | 29-24  |   23-16   |   15-8  |    7-0   |
+ * |           |             |        |           |         |          |
+ * | ARENA_ACC | ARENA_WRITE | Unused | ARENA_REG | DST_REG | INSN_LEN |
+ * +-----------+-------------+--------+-----------+---------+----------+
  *
  * - INSN_LEN (8 bits): Length of faulting insn (max x86 insn = 15 bytes (fits in 8 bits)).
  * - DST_REG  (8 bits): Offset of dst_reg from reg2pt_regs[] (max offset = 112 (fits in 8 bits)).
- *                      This is set to DONT_CLEAR if the insn is a store.
+ *                      This is set to DONT_CLEAR if the insn does not read into a register.
  * - ARENA_REG (8 bits): Offset of the register that is used to calculate the
  *                       address for load/store when accessing the arena region.
+ * - ARENA_WRITE (1 bit): This bit is set when the faulting instruction wrote to the arena region.
+ *                        It is independent of DST_REG, since a read-modify-write both writes to
+ *                        memory and reads the old value into a register.
  * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction accessed the arena region.
  *
  * Bit layout of `data` (32-bit):
@@ -1502,6 +1505,7 @@ static int emit_atomic_ld_st_index(u8 **pprog, u32 atomic_op, u32 size,
 #define FIXUP_INSN_LEN_MASK	GENMASK(7, 0)
 #define FIXUP_REG_MASK		GENMASK(15, 8)
 #define FIXUP_ARENA_REG_MASK	GENMASK(23, 16)
+#define FIXUP_ARENA_WRITE	BIT(30)
 #define FIXUP_ARENA_ACCESS	BIT(31)
 #define DATA_ARENA_OFFSET_MASK	GENMASK(31, 16)
 
@@ -1510,7 +1514,7 @@ bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 	u32 reg = FIELD_GET(FIXUP_REG_MASK, x->fixup);
 	u32 insn_len = FIELD_GET(FIXUP_INSN_LEN_MASK, x->fixup);
 	bool is_arena = !!(x->fixup & FIXUP_ARENA_ACCESS);
-	bool is_write = (reg == DONT_CLEAR);
+	bool is_write = !!(x->fixup & FIXUP_ARENA_WRITE);
 	unsigned long addr;
 	s16 off;
 	u32 arena_reg;
@@ -2348,6 +2352,7 @@ st:			insn_off = insn->off;
 				struct exception_table_entry *ex;
 				u8 *_insn = image + proglen + (start_of_ldx - temp);
 				u32 arena_reg, fixup_reg;
+				bool is_write;
 				s64 delta;
 
 				if (!bpf_prog->aux->extable)
@@ -2384,15 +2389,29 @@ st:			insn_off = insn->off;
 				    bpf_atomic_is_load_acq(insn)) {
 					arena_reg = reg2pt_regs[src_reg];
 					fixup_reg = reg2pt_regs[dst_reg];
+					is_write = false;
 				} else {
+					/*
+					 * A store has no destination register to clear,
+					 * except for a read-modify-write with BPF_FETCH,
+					 * which also reads the old value into src_reg, or
+					 * into r0 for a BPF_CMPXCHG. Either way the access
+					 * is still reported as a write.
+					 */
+					int load_reg = bpf_atomic_load_reg(insn);
+
 					arena_reg = reg2pt_regs[dst_reg];
-					fixup_reg = DONT_CLEAR;
+					fixup_reg = load_reg < 0 ? DONT_CLEAR :
+						    reg2pt_regs[load_reg];
+					is_write = true;
 				}
 
 				ex->fixup = FIELD_PREP(FIXUP_INSN_LEN_MASK, prog - start_of_ldx) |
 					    FIELD_PREP(FIXUP_ARENA_REG_MASK, arena_reg) |
 					    FIELD_PREP(FIXUP_REG_MASK, fixup_reg);
 				ex->fixup |= FIXUP_ARENA_ACCESS;
+				if (is_write)
+					ex->fixup |= FIXUP_ARENA_WRITE;
 
 				ex->data |= FIELD_PREP(DATA_ARENA_OFFSET_MASK, insn->off);
 			}
-- 
2.43.0

