Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8B551A74C
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913250; cv=none; b=IcciXLzhPeVEoEK0M6B0ak1yxJVRFmH1HOMRUUvBhQppUiuwHguKz8i6qe4IQPOHMVcE34gPcAzXYFEGgULS8YtaCO4anw/xuowUIb5eY1/m8ht5tJeC+1vcJfaZ8uT1Strv/uqp9s5F5BrhO6LFdcOJs2F1K4O06tXtex4/Qx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913250; c=relaxed/simple;
	bh=W1MA2joB5luLw2ghUuvEdPxQH7ZdmSi8vajeOw8heXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScMxNStPvlLatFL1nxNb+elkx6ZmWa0FpSrXmCJt3p04XQbrMtHUYQF13jotKqw2lN4uoqfSN6QYBcrqeoqPt+6DbpXyncxyrUZomsCRb4Fv5Fwn8m49ovtvkYacCccsu6QQ5U5njFhrbvspNjelrUyREJJThY3wmP9GKF/ZjGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=a9MaldMK; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="a9MaldMK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=o/jMau1cCbyVi0bG2CQovzbJ/7JuyjXb+KwftoRJzUQ=; b=a9MaldMKNsBwBplGBZOJeKZDIs
	8/x3aXkjWjR8wHTPJqZ2UD49nzzvqPADi1GdZ1QsT+C4lJkHQOSQd3NbB1fp7rdUXrwCQjEIYLPW1
	mFKKCWJzJR0o1BbJB7OE0CDVbSqFnUZQDRdIgBDDEGpbpt4UDIRiGI0a7IYvcINew7UwkOss3brIr
	D7+E9rzsViV5bBepOvNrIwxHGGQ21JSEnwmkUAIw0LXIBlrh+JVK36zzsUUHzzepSpzI9RjtHmuE+
	6Ad/+ju+apQ/MNgMJofVW6lAM429XuABfzENh8f+6eUDpgezoNZyNFOl53F6C9QwxHtb0CPIYPY+W
	jbqJqkKQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3L-000PRo-0I;
	Tue, 13 Oct 2026 19:12:39 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 14/18] bpf, x86: Multiply by 3, 5 and 9 with lea
Date: Tue, 13 Oct 2026 19:12:26 +0200
Message-ID: <20261013171230.523677-15-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013171230.523677-1-daniel@iogearbox.net>
References: <20261013171230.523677-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28152/Tue Oct 13 08:26:14 2026)

LLVM turns a multiplication by a power of two into a shift, but keeps
the other constants as a multiplication since BPF has no lea to lower
them into, so r *= 3 and friends reach the JIT as BPF_MUL with BPF_K
and were emitted as imul with an immediate, a 3 cycle instruction on
Intel and AMD. Emit lea dst, [dst + dst * 2/4/8] for 3, 5 and 9
instead, which is the same size and a single cycle on Intel and on
Zen 3 and later, two cycles on older AMD cores. r13 keeps the imul,
since it needs a displacement byte as base register, which makes the
lea a byte longer and a slow three operand form with 3 cycles of
latency on Intel.

Before/after for r1 *= 3:

  48 6b ff 03  imulq $0x3,%rdi,%rdi
  48 8d 3c 7f  leaq (%rdi,%rdi,2),%rdi

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 44 ++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 4e9c6bbe93d0..d1c22ae90fcc 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1163,17 +1163,22 @@ static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int off)
 	*pprog = prog;
 }
 
-static void emit_insn_suffix_SIB(u8 **pprog, u32 ptr_reg, u32 val_reg, u32 index_reg, int off)
+/*
+ * Emit the suffix for addressing *(ptr_reg + (index_reg << scale) + off)
+ * and val_reg, with a SIB byte
+ */
+static void emit_insn_suffix_SIB(u8 **pprog, u32 ptr_reg, u32 val_reg, u32 index_reg, int off,
+				 u8 scale)
 {
+	u8 sib = (scale << 6) | add_2reg(0, ptr_reg, index_reg);
 	u8 *prog = *pprog;
 
 	if (!off && !base_needs_disp(ptr_reg)) {
-		EMIT2(add_2reg(0x04, BPF_REG_0, val_reg),
-		      add_2reg(0, ptr_reg, index_reg) /* SIB */);
+		EMIT2(add_2reg(0x04, BPF_REG_0, val_reg), sib);
 	} else if (is_imm8(off)) {
-		EMIT3(add_2reg(0x44, BPF_REG_0, val_reg), add_2reg(0, ptr_reg, index_reg) /* SIB */, off);
+		EMIT3(add_2reg(0x44, BPF_REG_0, val_reg), sib, off);
 	} else {
-		EMIT2_off32(add_2reg(0x84, BPF_REG_0, val_reg), add_2reg(0, ptr_reg, index_reg) /* SIB */, off);
+		EMIT2_off32(add_2reg(0x84, BPF_REG_0, val_reg), sib, off);
 	}
 	*pprog = prog;
 }
@@ -1444,7 +1449,7 @@ static void emit_ldx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 i
 		EMIT2(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x8B);
 		break;
 	}
-	emit_insn_suffix_SIB(&prog, src_reg, dst_reg, index_reg, off);
+	emit_insn_suffix_SIB(&prog, src_reg, dst_reg, index_reg, off, 0);
 	*pprog = prog;
 }
 
@@ -1466,7 +1471,7 @@ static void emit_ldsx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32
 		EMIT2(add_3mod(0x48, src_reg, dst_reg, index_reg), 0x63);
 		break;
 	}
-	emit_insn_suffix_SIB(&prog, src_reg, dst_reg, index_reg, off);
+	emit_insn_suffix_SIB(&prog, src_reg, dst_reg, index_reg, off, 0);
 	*pprog = prog;
 }
 
@@ -1537,7 +1542,7 @@ static void emit_stx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 i
 		EMIT2(add_3mod(0x48, dst_reg, src_reg, index_reg), 0x89);
 		break;
 	}
-	emit_insn_suffix_SIB(&prog, dst_reg, src_reg, index_reg, off);
+	emit_insn_suffix_SIB(&prog, dst_reg, src_reg, index_reg, off, 0);
 	*pprog = prog;
 }
 
@@ -1569,7 +1574,7 @@ static void emit_st_index(u8 **pprog, u32 size, u32 dst_reg, u32 index_reg, int
 		EMIT2(add_3mod(0x48, dst_reg, 0, index_reg), 0xC7);
 		break;
 	}
-	emit_insn_suffix_SIB(&prog, dst_reg, 0, index_reg, off);
+	emit_insn_suffix_SIB(&prog, dst_reg, 0, index_reg, off, 0);
 	EMIT(imm, bpf_size_to_x86_bytes(size));
 	*pprog = prog;
 }
@@ -1713,7 +1718,7 @@ static int emit_atomic_rmw_index(u8 **pprog, u32 atomic_op, u32 size,
 		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
 		return -EFAULT;
 	}
-	emit_insn_suffix_SIB(&prog, dst_reg, src_reg, index_reg, off);
+	emit_insn_suffix_SIB(&prog, dst_reg, src_reg, index_reg, off, 0);
 	*pprog = prog;
 	return 0;
 }
@@ -2716,6 +2721,25 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_ALU | BPF_MUL | BPF_K:
 		case BPF_ALU64 | BPF_MUL | BPF_K:
+			/*
+			 * lea for 3, 5 and 9, which LLVM leaves as a
+			 * multiplication, but not for r13, which needs a
+			 * displacement as base and makes the lea a slow three
+			 * operand form on Intel.
+			 */
+			if ((imm32 == 3 || imm32 == 5 || imm32 == 9) &&
+			    !base_needs_disp(dst_reg)) {
+				/* lea dst_reg, [dst_reg + dst_reg * (imm32 - 1)] */
+				if (BPF_CLASS(insn->code) == BPF_ALU64)
+					EMIT1(add_3mod(0x48, dst_reg, dst_reg, dst_reg));
+				else if (is_ereg(dst_reg))
+					EMIT1(add_3mod(0x40, dst_reg, dst_reg, dst_reg));
+				EMIT1(0x8D);
+				emit_insn_suffix_SIB(&prog, dst_reg, dst_reg, dst_reg, 0,
+						     ilog2(imm32 - 1));
+				break;
+			}
+
 			maybe_emit_mod(&prog, dst_reg, dst_reg,
 				       BPF_CLASS(insn->code) == BPF_ALU64);
 
-- 
2.43.0

