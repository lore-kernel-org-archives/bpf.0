Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B7A51A74C
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913058; cv=none; b=MSkTdovdLHAxVpVFBVcFWamJNd15S3gMjSIoyJvEil1MRRZWSIIzgQUzAIqHvVaggc9XALY0tuuYYkg8UMJqchTdZQMJ21o34VSweIbNSay9sdOhRYDqqa14GNp/J/O6lF2kBfz4VRKFLGdfY4NFh9lxA6SThtpZcFTFTzw6iaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913058; c=relaxed/simple;
	bh=z0y/bBeciGt28LSzqXx+Zz5rSrFyA/D4Q1GTtChvScA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZTcQLxrwV1QOQbZsEFfSZzs6fVgh74WZUaQ/dKuYKABtfH1EMqYvvIz8P0FKSUHufanVMhmuS8JLH630jjH6tzzZoUOrvOgVuFToYyOKrZTqxIE31bf5re+JxcHYzx4chHqSnPpFhkOTlaOh+ZsMOHOyY/R9bEbuGvZnICYfn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=UJ4ODm8Z; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UJ4ODm8Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DFgovOanS9Dw6m1X1Q3Lv0k8zpzfqTJsbWg/w9sJ/Ug=; b=UJ4ODm8ZAq3R9uhzyIq2UA89YJ
	vwg7fZEo3NaGTU5vWPb0hl1JIYj3p3qw7SKWbsCCXNckOM7I12zfHSZXBgKPNuM0XGXbv1coHQkVs
	uFdjU1aNpsqckNYMigBTUencsZ6ZjD5c1Yb36+GJXbohE/L3fKPh7TOa2AhdKKf/HWLdbT1MXaBfx
	I+sCWGKWwBK80LpuaIiBHB4JgR8RvT7vy7xf4Gt/k6Mn84Ep8JDB8MFQ6ZcnyTm7NKleG9JPyzKNt
	hSgVpDap7VjHKuwml3J5oLq/RiniBn6jAy5JBAz9Yuhkq1ZvDK33NmXxH+RxSBEWYPrUdtzSCrSsj
	xqVc6LcQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3I-000PR0-08;
	Tue, 13 Oct 2026 19:12:36 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 08/18] bpf, x86: Use shorter and faster forms for some ALU immediates
Date: Tue, 13 Oct 2026 19:12:20 +0200
Message-ID: <20261013171230.523677-9-daniel@iogearbox.net>
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

An add or sub of 1 or -1 is an inc or dec, which is a byte shorter and a
single uop on all current cores, and the flags they leave untouched are
not read across BPF instructions anyway. An add of 128 is the sub of
-128 and the other way round, which fits into an imm8. An and of a 64-bit
register with a non-negative immediate clears the upper half just like
the 32-bit and does, which drops the REX.W prefix on the lower eight
registers. A shift left by one is the add of the register to itself, the
same size and a single uop that runs on more ports. LLVM emits all of
them, r += 1 for every counter, r &= mask for the masks beyond the
byte and word ones and r <<= 1 for x * 2 and x + x, and does the same
replacements for native code.

Before, for r1 += 1, r1 += 128, r1 &= 0x3ff and r1 <<= 1:

  48 83 c7 01           addq $0x1,%rdi
  48 81 c7 80 00 00 00  addq $0x80,%rdi
  48 81 e7 ff 03 00 00  andq $0x3ff,%rdi
  48 d1 e7              shlq %rdi

After:

  48 ff c7              incq %rdi
  48 83 ef 80           subq $-0x80,%rdi
  81 e7 ff 03 00 00     andl $0x3ff,%edi
  48 01 ff              addq %rdi,%rdi

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 3e367600a0ad..1c84d2a02aba 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1219,9 +1219,22 @@ static void emit_alu_imm(u8 **pprog, u32 op, u32 dst_reg, s32 imm, bool is64)
 		[BPF_OR] = 0x0D, [BPF_XOR] = 0x35,
 	};
 	u8 *prog = *pprog;
-
+	bool inc;
+
+	/* A non-negative mask clears the upper half like the 32-bit and does */
+	if (op == BPF_AND && imm >= 0)
+		is64 = false;
+	/* add 128 is sub -128 and the other way round, which fit into an imm8 */
+	if ((op == BPF_ADD || op == BPF_SUB) && imm == 128) {
+		op = op == BPF_ADD ? BPF_SUB : BPF_ADD;
+		imm = -128;
+	}
+	inc = op == BPF_ADD ? imm == 1 : imm == -1;
 	maybe_emit_1mod(&prog, dst_reg, is64);
-	if (is_imm8(imm))
+	/* inc or dec for +-1, the flags are not read across instructions */
+	if ((op == BPF_ADD || op == BPF_SUB) && (imm == 1 || imm == -1))
+		EMIT2(0xFF, add_1reg(inc ? 0xC0 : 0xC8, dst_reg));
+	else if (is_imm8(imm))
 		EMIT3(0x83, add_1reg(modrm[op], dst_reg), imm);
 	else if (is_axreg(dst_reg))
 		EMIT1_off32(short_op[op], imm);
@@ -1247,11 +1260,16 @@ static void emit_shift_imm(u8 **pprog, u32 op, u32 reg, u8 imm, bool is64)
 {
 	u8 *prog = *pprog;
 
-	maybe_emit_1mod(&prog, reg, is64);
-	if (imm == 1)
-		EMIT2(0xD1, add_1reg(simple_alu_opcodes[op], reg));
-	else
-		EMIT3(0xC1, add_1reg(simple_alu_opcodes[op], reg), imm);
+	/* The shift left by one is an add of the register to itself */
+	if (op == BPF_LSH && imm == 1) {
+		emit_alu_reg(&prog, BPF_ADD, reg, reg, is64);
+	} else {
+		maybe_emit_1mod(&prog, reg, is64);
+		if (imm == 1)
+			EMIT2(0xD1, add_1reg(simple_alu_opcodes[op], reg));
+		else
+			EMIT3(0xC1, add_1reg(simple_alu_opcodes[op], reg), imm);
+	}
 
 	*pprog = prog;
 }
-- 
2.43.0

