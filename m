Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6783AB272;
	Tue,  1 Sep 2026 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264026; cv=none; b=eXYRsB8oysl9OcREeEOCvg4oRUkwAJMr7kqoYS/StqlOptY2PQ3duzlfjUrFGjAMJomId/bb7ZQNncRgUjPDHZq0ld1bIyy8epSZeSlFoJc+Px+BwaXGyePMZ5woXhrACUKrwV1B6kGA7AtPlry+884rZ4ZBRqWOECMtOI7B41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264026; c=relaxed/simple;
	bh=cUlET6psf7BIbfBdek5vbRlDBPnYp6oUXtNM0GJuQA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HriVd6PeIKgfNvPf/pN8mezsIhhKZe0RN6ZBahTcCjtzMYRgtOzX47iU9i/ImLR5Ez+q/6NLadYbT99bImh0rSKtlg2clSLQP9EJ8I2WVyeNha5uZl7du+EGPOObfYf/ZZ7PhpUvmEHkSemh12qFd99mCQTw38BvWhKyhf9bNms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MYy8vwNo; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MYy8vwNo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788264020; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1dN/5IHaSDbgKWn7C0l1t6XTBlAsWfAhnXn6F5BTEbg=;
	b=MYy8vwNoZ8rmhg118KS+4FaMPKdinxQTI2uP1jBL5ISYDNL4tXIZwmPm+V32WDU8Mzx/v0gZeiQMqLoS1LJhR/SKhM19nlubI0v0kasN6tgFHBh/rT9AzYRMvoOWvjflpPb8ydM4LcsZYDAZ2Il8VcHEne/JICMAMHrd+wzROzg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XA8S00n_1788264015;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XA8S00n_1788264015 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 20:00:19 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	shuah@kernel.org,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf, riscv: Register extable entries at probe insn call sites
Date: Tue,  1 Sep 2026 20:00:13 +0800
Message-ID: <20260901120013.16104-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add_exception_handler() filters insns by matching BPF_MODE() against
the probe mode values. These values occupy unused opcode slots and
collide with legitimate encodings: BPF_PROBE_MEM32SX (0xc0) shares
its mode value with BPF_ATOMIC. Relying on the mode alone therefore
risks registering exception table entries for the wrong instructions,
as would happen for plain atomics without the LDX class check.

Make the decision explicit at the call sites instead: register an
entry only when emitting a probe load, a PROBE_MEM32 store, or a
PROBE_ATOMIC atomic, and drop the fragile mode gate from
add_exception_handler() along with the now unused insn argument. No
functional change intended.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
base-commit: d761934c9483ecde93fe99d8705282f716dfee50

 arch/riscv/net/bpf_jit_comp64.c | 50 ++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index e7378be171a9..726c0169fc60 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -731,9 +731,8 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 	return true;
 }
 
-/* For accesses to BTF pointers, add an entry to the exception table */
-static int add_exception_handler(const struct bpf_insn *insn, int dst_reg,
-				 struct rv_jit_context *ctx)
+/* Add an entry to the exception table for a faulting probe insn */
+static int add_exception_handler(int dst_reg, struct rv_jit_context *ctx)
 {
 	struct exception_table_entry *ex;
 	unsigned long pc;
@@ -744,14 +743,6 @@ static int add_exception_handler(const struct bpf_insn *insn, int dst_reg,
 	    ctx->ex_insn_off <= 0 || ctx->ex_jmp_off <= 0)
 		return 0;
 
-	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
-	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
-	    BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
-	    !(BPF_MODE(insn->code) == BPF_PROBE_MEM32SX &&
-	      BPF_CLASS(insn->code) == BPF_LDX) &&
-	    BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
-		return 0;
-
 	if (WARN_ON_ONCE(ctx->nexentries >= ctx->prog->aux->num_exentries))
 		return -EINVAL;
 
@@ -1360,6 +1351,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 	return ret < 0 ? ret : size;
 }
 
+/* Probe loads fault on unmapped memory and need an exception table entry */
+static bool insn_is_probe_ldx(const struct bpf_insn *insn)
+{
+	return BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+	       BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
+	       BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
+	       BPF_MODE(insn->code) == BPF_PROBE_MEM32SX;
+}
+
 int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		      bool extra_pass)
 {
@@ -1929,9 +1929,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 		emit_ldx(rd, off, rs, BPF_SIZE(code), sign_ext, ctx);
 
-		ret = add_exception_handler(insn, rd, ctx);
-		if (ret)
-			return ret;
+		if (insn_is_probe_ldx(insn)) {
+			ret = add_exception_handler(rd, ctx);
+			if (ret)
+				return ret;
+		}
 
 		if (BPF_SIZE(code) != BPF_DW && insn_is_zext(&insn[1]))
 			return 1;
@@ -1959,9 +1961,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 		emit_st(rd, off, imm, BPF_SIZE(code), ctx);
 
-		ret = add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
-		if (ret)
-			return ret;
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
+			ret = add_exception_handler(REG_DONT_CLEAR_MARKER, ctx);
+			if (ret)
+				return ret;
+		}
 		break;
 
 	/* STX: *(size *)(dst + off) = src */
@@ -1981,9 +1985,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 		emit_stx(rd, off, rs, BPF_SIZE(code), ctx);
 
-		ret = add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
-		if (ret)
-			return ret;
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
+			ret = add_exception_handler(REG_DONT_CLEAR_MARKER, ctx);
+			if (ret)
+				return ret;
+		}
 		break;
 
 	/* Atomics */
@@ -2001,7 +2007,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			ret = emit_atomic_rmw(rd, rs, insn, ctx);
 
 		/* ret can be 1 (skip-zext); extable entry still needs to be added */
-		if (ret >= 0) {
+		if (ret >= 0 && BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
 			/*
 			 * A load-acquire reads into dst_reg, and a read-modify-write
 			 * carrying BPF_FETCH reads the old value into src_reg, or into
@@ -2010,7 +2016,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			 */
 			int load_reg = bpf_atomic_load_reg(insn);
 
-			ret = add_exception_handler(insn, load_reg < 0 ?
+			ret = add_exception_handler(load_reg < 0 ?
 					REG_DONT_CLEAR_MARKER : regmap[load_reg],
 					ctx) ?: ret;
 		}
-- 
2.50.1

