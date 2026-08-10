Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B1360EF0
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369432; cv=none; b=r5Q1tWK5VFTKWsauEgdY6ampgLa8VThyhF8QssY8lpqza8RI4hPBJS1/O0S3v2mKhaWiERYsOAuis7NWo1m6rdw/iU/g2aUG20fnw0cPzmTHKWrbLej5t/5Ln44CIRw1Ou8YRccIarxwFS9Uoyjz55AeaVQmbd+fGDRTNkNgZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369432; c=relaxed/simple;
	bh=95PNA9AbUVlY3Kc6ud4gTESgXmRzCXFstRaSP9vCRZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyArdYmnPINUX/4yPHlyBPc5lhfWHSbr23xM/EerjiuM6xNjqk3/ADCQz6TFpTeoIgogm49yG3ey5wIleOQd4Ico8PV4H442xKl42+P+ZcxaVeolgEugQ17/e5/GrnFFd9SLHOlFz3oVzKDgtpfJDvqkR4E9sE7OyWBwF7xVjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=eLdiu7fi; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="eLdiu7fi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ScDjjwGqrunUe71QcXt5urmLuQExsACvV+5fr+zIvLY=; b=eLdiu7fipvNdZVqqQqOOYOSD0b
	cYTNKyvUviHhGPB+3F0Urh9RtAlRnU4fkBPxmqCIhx0Z2ZWKY/knf2UGDeG8/eK/cKj+Ke2L14T1e
	035bUrZAZU0LJSYtA/Su2mhhRzu6X4NmzkJLmmH4AJ4AKAn9fbj9ecO98JtzR1aone41FdlnyRjgG
	/9Khp+prfs/Kf0+NLFDKvoRrNkCisCN+oOPLMyZE/znk2bgZG6yU3CwwbCIRUQV8wn2EqeTWp02h6
	ReiBZWI8t+WZM9MIk6t8aQS871qbS67MEPL/8lEg6Ogh8DoPluBG1TnaUNgihvABdSrw3oonlqmNO
	FRxhEw5Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtQI8-00052b-1x;
	Mon, 10 Aug 2026 15:43:48 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 4/6] bpf, arm64: Clear fetch destination on faulting arena atomic
Date: Mon, 10 Aug 2026 15:43:44 +0200
Message-ID: <20260810134346.466004-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810134346.466004-1-daniel@iogearbox.net>
References: <20260810134346.466004-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28088/Mon Aug 10 08:24:15 2026)

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
add a separate ARENA_WRITE bit for the direction and fill FIXUP_REG in
from bpf_atomic_load_reg().

Fixes: e612b5c1d3ee ("bpf, arm64: Add support for lse atomics in bpf_arena")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 36 +++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index d14d297ebb96..796ff9193cfb 100644
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
+	bool is_arena, is_write = false;
 	int arena_reg;
 	unsigned long pc;
 	struct exception_table_entry *ex;
@@ -1183,13 +1187,25 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	 * dst_reg like a BPF_LDX does, hence it must not be treated as a store
 	 * here.
 	 */
-	if (BPF_CLASS(insn->code) != BPF_LDX && !bpf_atomic_is_load_acq(insn))
-		dst_reg = DONT_CLEAR;
+	if (BPF_CLASS(insn->code) != BPF_LDX && !bpf_atomic_is_load_acq(insn)) {
+		/*
+		 * A store has no destination register to clear, except for a
+		 * read-modify-write with BPF_FETCH, which also reads the old
+		 * value into src_reg, or into r0 for a BPF_CMPXCHG. Either way
+		 * the access is still reported as a write.
+		 */
+		int load_reg = bpf_atomic_load_reg(insn);
+
+		dst_reg = load_reg < 0 ? DONT_CLEAR : bpf2a64[load_reg];
+		is_write = true;
+	}
 
 	ex->fixup = FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
 
 	if (is_arena) {
 		ex->fixup |= BPF_ARENA_ACCESS;
+		if (is_write)
+			ex->fixup |= BPF_ARENA_WRITE;
 		/*
 		 * insn->src_reg/dst_reg holds the address in the arena region with upper 32-bits
 		 * being zero because of a preceding addr_space_cast(r<n>, 0x0, 0x1) instruction.
-- 
2.43.0

