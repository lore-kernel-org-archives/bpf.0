Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71529387361
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145909; cv=none; b=UZIyidlFEaMYXjaZ3y3/CGR+b9Y3YGbblEsIk/fdiqQN+4sQg9GkJAVh4H8KVSr4X1NuYMyzDmDn5ca2ggo/PrMprjxQqniyyc3J3TXxhtiH+qtkZjjLAbjuMIWK5+HOpXz2UPI0A/HKYfTly9LhVm9cTG+NnZMhbq4GQYaMdFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145909; c=relaxed/simple;
	bh=rtCmYci7EucdOvGEhTH9iuLe0M0/Gsg15HBT11KEw7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+c1gJQOOQqMDzL4s6edUuGjCok/0LIM7wJJIiL2QkVPUXrSdEINpKIPbCFgf7PTOfKk9cChOw4wkefuj+z95+rpE1a6PC6vltE+e4M/LY0K+dv8L1kPp3rGr0kXXqAbGbOxkjQosXboqgbxBgvmgJLHrezxNEng4YKALpO2vKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=THYC/7UA; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="THYC/7UA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=tdf/x513yF/ZkawHceDioeU6RHO0Woxmmb2q/MqNTNQ=; b=THYC/7UA2KgmTTbEvzvhSa7lJ/
	oG1/W1+0U0ubS0aIlI8nbyi7HWKlJl+pMcw5KxCJ/C5nWKRIV5xZdoCSF4b3fHfTu8yU4LAqB0Q6n
	qabS7Ryo4Xet1QCZGdzVxJA08mXgsuxak+9kVM00lpXwzM8hZVC0xA+2o7py+nZFS4ePmygZpEKFI
	V6f+IVG+To77jj7lObDQsVu02K+kz6nlgNI7SJMSWJ6Jb+dqRu22ZU4RAvyaN1p3L6awKvaS/QM0a
	0ItETcRcnVylEasO5N6WukgN5Ec0AvxqqGHe5pSgDh7NSnEpy2iU7PeMOpqBFSbdY2qGJCjWFfu54
	EO623aEw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHf14-0009jW-35;
	Fri, 16 Oct 2026 12:18:23 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 1/3] bpf, s390: Mask the count of 32-bit shifts by register
Date: Fri, 16 Oct 2026 12:18:20 +0200
Message-ID: <20261016101822.632891-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28155/Fri Oct 16 08:24:17 2026)

RFC9669 defines the shifts as dst <<= (src & mask), dst >>= (src & mask)
and sign extending dst >>= (src & mask), where "shift operations use a mask
of 0x3F (63) for 64-bit operations and 0x1F (31) for 32-bit operations"
(Section 4.1), which the interpreter implements. On x86-64 and arm64 the
hardware does so by itself, so both JITs emit the shift alone and conform.

The 32-bit shifts by register of the s390x JIT do not conform to the spec.
They emit sll, srl and sra with the count in the address of the second
operand, of which the "rightmost six bits indicate the number of bit
positions to be shifted" (z/Architecture Principles of Operation,
SA22-7832-13), so a count of 32 to 63 clears the register, or fills it
with the sign for sra, instead of shifting by the count masked with 31.
The 64-bit sllg, srlg and srag take six bits as well, which is the mask
there, so only the 32-bit forms differ.

Put the count masked with 31 into %w1 and shift by that. A single risbg
does the copy and the mask: it inserts bits 59 to 63 of the source into
the same positions of %w1 and zeroes the rest, available since the
general-instructions-extension facility of z10, below the z196 the JIT
requires. One instruction more per shift by register, shifts by immediate
are not affected since the verifier rejects a count at or beyond the
width.

  # KERNEL_CMDLINE_EXTRA=nokaslr PLATFORM=s390x CROSS_COMPILE=s390x-linux-gnu- ./vmtest.sh -- \
    ./test_progs -t jit_insns/shift_counts,jit_insns/shifts,jit_insns/alu_edges,jit_insns/calls
  [...]
  #191/8   jit_insns/alu_edges:OK
  #191/9   jit_insns/shifts:OK
  #191/10  jit_insns/shift_counts:OK
  #191/21  jit_insns/calls:OK
  #191/22  jit_insns/helper_calls:OK
  #191     jit_insns:OK
  #192/3   jit_insns_blinded/alu_edges:OK
  #192/5   jit_insns_blinded/shifts:OK
  #192     jit_insns_blinded:OK
  Summary: 2/7 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 1b2566012b63..14c905697352 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -859,6 +859,14 @@ static int bpf_jit_probe_post(struct bpf_jit *jit, struct bpf_prog *fp,
 	return 0;
 }
 
+static void emit_shift_count32(struct bpf_jit *jit, u32 src_reg)
+{
+	/* risbg %w1,%src,59,128+63,0 */
+	_EMIT6(0xec000000 | reg(REG_W1, src_reg) << 16 | 59 << 8 | (0x80 | 63), 0x0055);
+	REG_SET_SEEN(REG_W1);
+	REG_SET_SEEN(src_reg);
+}
+
 static int emit_ldx(struct bpf_jit *jit, struct bpf_prog *fp, struct bpf_insn *insn)
 {
 	struct bpf_jit_probe probe;
@@ -1431,9 +1439,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_LSH
 	 */
-	case BPF_ALU | BPF_LSH | BPF_X: /* dst = (u32) dst << (u32) src */
-		/* sll %dst,0(%src) */
-		EMIT4_DISP(0x89000000, dst_reg, src_reg, 0);
+	case BPF_ALU | BPF_LSH | BPF_X: /* dst = (u32) dst << ((u32) src & 31) */
+		emit_shift_count32(jit, src_reg);
+		/* sll %dst,0(%w1) */
+		EMIT4_DISP(0x89000000, dst_reg, REG_W1, 0);
 		EMIT_ZERO(dst_reg);
 		break;
 	case BPF_ALU64 | BPF_LSH | BPF_X: /* dst = dst << src */
@@ -1456,9 +1465,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_RSH
 	 */
-	case BPF_ALU | BPF_RSH | BPF_X: /* dst = (u32) dst >> (u32) src */
-		/* srl %dst,0(%src) */
-		EMIT4_DISP(0x88000000, dst_reg, src_reg, 0);
+	case BPF_ALU | BPF_RSH | BPF_X: /* dst = (u32) dst >> ((u32) src & 31) */
+		emit_shift_count32(jit, src_reg);
+		/* srl %dst,0(%w1) */
+		EMIT4_DISP(0x88000000, dst_reg, REG_W1, 0);
 		EMIT_ZERO(dst_reg);
 		break;
 	case BPF_ALU64 | BPF_RSH | BPF_X: /* dst = dst >> src */
@@ -1481,9 +1491,10 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	/*
 	 * BPF_ARSH
 	 */
-	case BPF_ALU | BPF_ARSH | BPF_X: /* ((s32) dst) >>= src */
-		/* sra %dst,%dst,0(%src) */
-		EMIT4_DISP(0x8a000000, dst_reg, src_reg, 0);
+	case BPF_ALU | BPF_ARSH | BPF_X: /* ((s32) dst) >>= (u32) src & 31 */
+		emit_shift_count32(jit, src_reg);
+		/* sra %dst,0(%w1) */
+		EMIT4_DISP(0x8a000000, dst_reg, REG_W1, 0);
 		EMIT_ZERO(dst_reg);
 		break;
 	case BPF_ALU64 | BPF_ARSH | BPF_X: /* ((s64) dst) >>= src */
-- 
2.43.0

