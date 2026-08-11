Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE4D25B091
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454168; cv=none; b=DCk4jJJQKCMEvC7uSVzbK0SveuDX7coU3G8KIBOESnji0ILng19w5M0FWlKx5P6Ow9FVrBfJsRArzOisylYpQW3SoTTjVfp/ZMTrX6+CDyBC8y0lO9I3J0bauqvDP4uSUt+1Nt6EKGzXzTqnOknTT3oVBpr6wpnoFNUnzATE1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454168; c=relaxed/simple;
	bh=S90Mh5H+5eCN7uQTQzq9EWoClpX+hcuOeVk/mhKpmtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cV7IzF0rT8tb7jkXkMRDZiJzEf69zBiu7Eda8mpGdwwjA3v+kNFxNhWRwgXmdp4m0DN0xkOI+fVMZKa8unCUsdh4ANJ4zWO6GNCwz/piqez6BSjAlKj6vBbRTQmkiNLKnyHxHx52i9II9hQgLAJgXIgEHCCJhP0Htu4SrK/aw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=IET44Mxv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IET44Mxv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7O+w3sa9TWeJZZkVqCukfwaOEG6j+duIKB0elNrRwiw=; b=IET44MxvRcqPhS3Rr0/Gp3av0/
	sBD7+hgg/BNxIAoR5dthcgOC7xY2ni2mxkEiivC9yqSqTd086w5D/Wvj6QpHy2VITxFM/tDV77a5O
	ZH4CjqZM0gugwryZeessnGVvOHPX7ZjdqRUGgfTEYZip3fQqbAzCdq7oZX971dASll6VZwdl8w+s7
	+ZIGjHNsYY/Lbgmi6a9TQvjpwb9yiB/sfUuD3f81mQxnT0GZVEEa5XJ1kBIu/wWrR+uY7NINUNn1k
	R5Vea9FUBupab7IsOjrCU7GXwL9v2H+JmY8P7SZWFSAiu/INeaPvm6HpAbIm3hJjjsQ/vaz1gWRar
	Sy8GDj7g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtmKp-0009Uj-0x;
	Tue, 11 Aug 2026 15:16:03 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 4/6] bpf, arm64: Clear fetch destination on faulting arena atomic
Date: Tue, 11 Aug 2026 15:15:58 +0200
Message-ID: <20260811131600.506721-4-daniel@iogearbox.net>
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

Same problem as on x86-64: add_exception_handler() folds "there is no
destination register to clear" and "this is a store" into one DONT_CLEAR
value ...

  if (BPF_CLASS(insn->code) != BPF_LDX && !bpf_atomic_is_load_acq(insn))
          dst_reg = DONT_CLEAR;

... which ex_handler_bpf() then reads back as the access direction:

  bool is_write = (dst_reg == DONT_CLEAR);

A RMW carrying BPF_FETCH is both. emit_lse_atomic() reads the old value
into src_reg for BPF_{ADD,AND,OR,XOR} | BPF_FETCH and BPF_XCHG, and into
r0 for BPF_CMPXCHG, so a fault over an unmapped arena page is correctly
reported as a WRITE but leaves that register holding a stale value instead
of the 0 that every other BPF_PROBE_* access delivers. Same as on x86-64,
add a separate ARENA_WRITE bit for the direction.

FIXUP_REG is now filled in by the callers of add_exception_handler(), the
BPF_PROBE_ATOMIC one deriving it from bpf_atomic_load_reg(), so that the
helper only has to determine the direction. This is how the riscv64 JIT
already does it, and it stops the two store callers from handing in a
dst_reg that was only going to be overwritten with DONT_CLEAR anyway.

Fixes: e612b5c1d3ee ("bpf, arm64: Add support for lse atomics in bpf_arena")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Puranjay Mohan <puranjay@kernel.org>
---
 v1 -> v2:
   - move bpf_atomic_load_reg into build_insn (Eduard)

 arch/arm64/net/bpf_jit_comp.c | 44 ++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index d14d297ebb96..74b4083791da 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1082,23 +1082,27 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
  *
  * Bit layout of `fixup` (32-bit):
  *
- * +-----------+--------+-----------+-----------+----------+
- * |   31-27   | 26-22  |     21    |   20-16   |   15-0   |
- * |           |        |           |           |          |
- * | FIXUP_REG | Unused | ARENA_ACC | ARENA_REG |  OFFSET  |
- * +-----------+--------+-----------+-----------+----------+
+ * +-----------+--------+-------------+-----------+-----------+----------+
+ * |   31-27   | 26-23  |      22     |     21    |   20-16   |   15-0   |
+ * |           |        |             |           |           |          |
+ * | FIXUP_REG | Unused | ARENA_WRITE | ARENA_ACC | ARENA_REG |  OFFSET  |
+ * +-----------+--------+-------------+-----------+-----------+----------+
  *
  * - OFFSET (16 bits): Offset used to compute address for Load/Store instruction.
  * - ARENA_REG (5 bits): Register that is used to calculate the address for load/store when
  *                       accessing the arena region.
  * - ARENA_ACCESS (1 bit): This bit is set when the faulting instruction accessed the arena region.
+ * - ARENA_WRITE (1 bit): This bit is set when the faulting instruction wrote to the arena region.
+ *                        It is independent of FIXUP_REG, since a read-modify-write both writes to
+ *                        memory and reads the old value into a register.
  * - FIXUP_REG (5 bits): Destination register for the load instruction (cleared on fault) or set to
- *                       DONT_CLEAR if it is a store instruction.
+ *                       DONT_CLEAR if the instruction does not read into a register.
  */
 
 #define BPF_FIXUP_OFFSET_MASK      GENMASK(15, 0)
 #define BPF_FIXUP_ARENA_REG_MASK   GENMASK(20, 16)
 #define BPF_ARENA_ACCESS           BIT(21)
+#define BPF_ARENA_WRITE            BIT(22)
 #define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
 #define DONT_CLEAR 5 /* Unused ARM64 register from BPF's POV */
 
@@ -1109,7 +1113,7 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 	s16 off = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
 	int arena_reg = FIELD_GET(BPF_FIXUP_ARENA_REG_MASK, ex->fixup);
 	bool is_arena = !!(ex->fixup & BPF_ARENA_ACCESS);
-	bool is_write = (dst_reg == DONT_CLEAR);
+	bool is_write = !!(ex->fixup & BPF_ARENA_WRITE);
 	unsigned long addr;
 
 	if (is_arena) {
@@ -1132,7 +1136,7 @@ static int add_exception_handler(const struct bpf_insn *insn,
 {
 	off_t ins_offset;
 	s16 off = insn->off;
-	bool is_arena;
+	bool is_arena, is_write;
 	int arena_reg;
 	unsigned long pc;
 	struct exception_table_entry *ex;
@@ -1181,15 +1185,18 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	/*
 	 * A load-acquire is of BPF_STX class, but reads from src_reg into
 	 * dst_reg like a BPF_LDX does, hence it must not be treated as a store
-	 * here.
+	 * here. A read-modify-write carrying BPF_FETCH is reported as a write
+	 * even though it does have a register to clear, see the callers.
 	 */
-	if (BPF_CLASS(insn->code) != BPF_LDX && !bpf_atomic_is_load_acq(insn))
-		dst_reg = DONT_CLEAR;
+	is_write = BPF_CLASS(insn->code) != BPF_LDX &&
+		   !bpf_atomic_is_load_acq(insn);
 
 	ex->fixup = FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
 
 	if (is_arena) {
 		ex->fixup |= BPF_ARENA_ACCESS;
+		if (is_write)
+			ex->fixup |= BPF_ARENA_WRITE;
 		/*
 		 * insn->src_reg/dst_reg holds the address in the arena region with upper 32-bits
 		 * being zero because of a preceding addr_space_cast(r<n>, 0x0, 0x1) instruction.
@@ -1889,7 +1896,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			break;
 		}
 
-		ret = add_exception_handler(insn, ctx, dst);
+		ret = add_exception_handler(insn, ctx, DONT_CLEAR);
 		if (ret)
 			return ret;
 		break;
@@ -1956,7 +1963,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			break;
 		}
 
-		ret = add_exception_handler(insn, ctx, dst);
+		ret = add_exception_handler(insn, ctx, DONT_CLEAR);
 		if (ret)
 			return ret;
 		break;
@@ -1979,7 +1986,16 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			return ret;
 
 		if (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
-			ret = add_exception_handler(insn, ctx, dst);
+			/*
+			 * A load-acquire reads into dst_reg, and a read-modify-write
+			 * carrying BPF_FETCH reads the old value into src_reg, or into
+			 * r0 for a BPF_CMPXCHG. Clear that register on fault, the
+			 * remaining atomics have no destination register.
+			 */
+			int load_reg = bpf_atomic_load_reg(insn);
+
+			ret = add_exception_handler(insn, ctx, load_reg < 0 ?
+						    DONT_CLEAR : bpf2a64[load_reg]);
 			if (ret)
 				return ret;
 		}
-- 
2.43.0

