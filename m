Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B748BD39
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913245; cv=none; b=RejKvMU8lWsNhOYhhP3lYEN1H4LUWdH5BezQe3/HIDH/qbzGI+yLpqAWDEIh+xXjXVTU6IMgjh72esYcDZXg6HU7gFTHw4MD034hmJbFOw9GNglIr3UxxNO77ljq71GXVS/sLluu84q3J3n7VnfLG/7oJC1PnKar0pHE6/VLEI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913245; c=relaxed/simple;
	bh=Y32KlEmhsx2jGlUZtk01NNPA/Pg0Ed+BOfj0sWWhLbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chq5gd17R2riIcIHZ+1yvm1SNunKvQZJYmTn17VCQBkz4W/AWINH/zBbfhOymIQXrlCaAZyIvuWvhKUAyZGxKfuAlZUeiajil0kGLd0jzPlX4tMiAT4nxkOxWKdx2TaLMlIDtmfTiK0s/Yp7I36iL3Veswg5ChTr+8VdPQmURT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Mnb33Sd0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Mnb33Sd0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WvCiqftLVDQZskTvmlNS0g/DW+MiKksO0V/5JLqkEr4=; b=Mnb33Sd0dyNB3HHhUCwx8wKkWq
	uFq9aepEqoO7R99hUukZU8yLr5RKsRb4+VzZUPduxWXETuH4La3e4lHN2/7FcU9Mmv8tPQEYjgFgq
	bWhtLNjsRAR9VOpglOLVUnc8SSeeAFtA7YCR1q9caY2mqRX3u3QmYX2Z73+RJZkU+SXLhKlbYsd4u
	A33j7zauUt1aviPaW1+h/b1EixJDz6SiA1hZR4vfLwjiZXVGm28nG+5BhWo5qQTZEpCpRgxX+4rqz
	iMhxsjuX2mnf4aclVp/dvCe0rzeBa6+q595OocpPYmbI5XfikVoHX9olDRGYTG/Gqzpu4UV9eGH9Y
	o2m/oMvA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3E-000PQ5-1T;
	Tue, 13 Oct 2026 19:12:32 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 02/18] bpf, x86: Omit the displacement byte for zero offsets
Date: Tue, 13 Oct 2026 19:12:14 +0200
Message-ID: <20261013171230.523677-3-daniel@iogearbox.net>
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

A memory operand with a zero offset was encoded with a mod 01 ModR/M and
an explicit zero displacement byte. Use the mod 00 form instead, which
saves a byte for every load, store and atomic with a zero offset, as
LLVM emits them for the first field of a struct and for every plain
pointer dereference. The exception are rbp and r13 as base register,
where mod 00 with r/m 101 selects a RIP-relative disp32 and with SIB
base 101 a disp32 without base, so these keep their displacement byte.
Also let emit_st() reuse emit_insn_suffix() instead of open-coding the
ModR/M encoding.

Before/after for r0 = *(u64 *)(r1 + 0):

  48 8b 47 00  movq 0x0(%rdi),%rax
  48 8b 07     movq (%rdi),%rax

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index adec4f8e422e..70243ccbe423 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1120,18 +1120,26 @@ static void emit_movsx_reg(u8 **pprog, int num_bits, bool is64, u32 dst_reg,
 	*pprog = prog;
 }
 
+/*
+ * rbp and r13 as base register always need a displacement, since mod 00
+ * with r/m 101 encodes a RIP-relative disp32 and with SIB base 101 a
+ * disp32 without base instead.
+ */
+static bool base_needs_disp(u32 reg)
+{
+	return reg2hex[reg] == 5;
+}
+
 /* Emit the suffix (ModR/M etc) for addressing *(ptr_reg + off) and val_reg */
 static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int off)
 {
 	u8 *prog = *pprog;
 
-	if (is_imm8(off)) {
-		/* 1-byte signed displacement.
-		 *
-		 * If off == 0 we could skip this and save one extra byte, but
-		 * special case of x86 R13 which always needs an offset is not
-		 * worth the hassle
-		 */
+	if (!off && !base_needs_disp(ptr_reg)) {
+		/* No displacement */
+		EMIT1(add_2reg(0x00, ptr_reg, val_reg));
+	} else if (is_imm8(off)) {
+		/* 1-byte signed displacement */
 		EMIT2(add_2reg(0x40, ptr_reg, val_reg), off);
 	} else {
 		/* 4-byte signed displacement */
@@ -1144,7 +1152,10 @@ static void emit_insn_suffix_SIB(u8 **pprog, u32 ptr_reg, u32 val_reg, u32 index
 {
 	u8 *prog = *pprog;
 
-	if (is_imm8(off)) {
+	if (!off && !base_needs_disp(ptr_reg)) {
+		EMIT2(add_2reg(0x04, BPF_REG_0, val_reg),
+		      add_2reg(0, ptr_reg, index_reg) /* SIB */);
+	} else if (is_imm8(off)) {
 		EMIT3(add_2reg(0x44, BPF_REG_0, val_reg), add_2reg(0, ptr_reg, index_reg) /* SIB */, off);
 	} else {
 		EMIT2_off32(add_2reg(0x84, BPF_REG_0, val_reg), add_2reg(0, ptr_reg, index_reg) /* SIB */, off);
@@ -1507,11 +1518,7 @@ static void emit_st(u8 **pprog, struct bpf_insn *insn, u32 dst_reg,
 		break;
 	}
 
-	if (is_imm8(insn_off))
-		EMIT2(add_1reg(0x40, dst_reg), insn_off);
-	else
-		EMIT1_off32(add_1reg(0x80, dst_reg), insn_off);
-
+	emit_insn_suffix(&prog, dst_reg, BPF_REG_0, insn_off);
 	EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
 	*pprog = prog;
 }
-- 
2.43.0

