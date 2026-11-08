Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166059;
	b=N8y+KfpTLaLdOixMUgf3oPK1Mjwgh3uqU5dR5TJzXKgD5nxZUGS4kAbuJIZ6dvb/ON1k
	 fM06U52otm4a/pQZM7pFvZC9pmxS2mFoQNKrJDrX1l4iGf7k07xl2cuulU5B9j4JYbX8Y
	 C0YOnCnP675h8QrUquFKfQv7E03ogq1se/s2xUb/1InrCd8d7dCwNbZtS2tZiRH1cklGS
	 9u5x1xWlSom3Vd1D4E2P8oY+NLrosQn+a7ANCEjCVdJo/BRASRDQQ3XKPqJr2d0mLqMKX
	 oirnoq5Ko35taL2nzvSwnjdJhFj+wiBZeCHMK9rI6PLZtiWFvccNzv0Ol/f/q22accA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166059;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=n46zZREDXWtGpmtwDb9tzqxC9JViX+WrtTDXcHX9MtI=;
	b=g9vghJbGJfWI7e9UBhpjxsjEOJpq63zFesmRSQBtDabhV+z++NDZgT7QYG7yG7ItC5qg
	 Ak7Kw1VAMkp8ERUpy2Y2K3MKTCSVkUk8NZa4BZ91f4J5e9HKxoJcHMm3QBwYHGoYnzRhm
	 AUa3xBg9apNs5YyT+ckDYufi9BtdYTlopAT54w8sz4OonNKJsAXtBgJ8WPCBNbYZx+546
	 JdDJ297sUcbt5L9o/fkET1ITsyz7gENY0JKXugCa22QJnaRuYooCoR+awUX2NjHq54bL1
	 eVmHwuZDnSnt/mwf9gLUhr470W+y8VNUW030bL4q5Y1jSitMug1BRxU1d5hx9YPPkqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=i5kKfx3f;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A08606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45A08606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=i5kKfx3f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=n46zZREDXWtGpmtwDb9tzqxC9JViX+WrtTDXcHX9MtI=; b=i5kKfx3fn8nbCW8h/29eMCE+GF
	/YqYjr4kK1zSBsaHNG4s5Bx9Vu7Kw0X1DupPvrKVSUWbcLjPacxhT4A05bvCEH/Eh4SnIfE2HYfWI
	muXzqoMdGl/9X5YXymRkW8Kx+9dNdMFtqKHPqdSqWEnkyq1Qnn8istadFvvzX/0RkoQTRm4o8ZVGU
	VQ0+Og0II462GQWOfSqhtVPyV4Pn09VZA4WM9ChWMtTAvKbahnNJMGCAWqc6ZQgTNJuh8DnDq6Iy6
	C0OcPKY5QE7iR6pNwYi56b89ErPgj7kCUCjUAo4GAPmjo13MJumq8ddKeOmxQ6I9ti7EKjXdrAZEw
	LX7BVMZg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8YC-000Plv-1D;
	Sun, 08 Nov 2026 20:27:37 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 08/24] arm64, insn: Reject invalid and unpredictable operands in the encoders
Date: Sun,  8 Nov 2026 20:26:34 +0100
Message-ID: <a039fe7efc077061852c80b14b6ebcc81cdef75d.1794165614.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794165614.git.daniel@iogearbox.net>
References: <cover.1794165614.git.daniel@iogearbox.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28177/Sun Nov  8 07:23:52 2026)

A few encoders return a valid instruction for operands the instruction
cannot take, instead of AARCH64_BREAK_FAULT:

  - The extended register add and sub put any @extend into the 3-bit
    option field, so -1 becomes SXTX and 8 becomes UXTB.
  - ADR truncates its offset to 32 bits before the range check, so an
    offset beyond 4GB can wrap into range.
  - STXR and STLXR accept a status register equal to the data or base
    register, LDP equal target registers, and pre- and post-index LDP
    and STP a target register equal to the base. The Arm ARM makes all
    of these CONSTRAINED UNPREDICTABLE.

Reject them. No caller passes such operands, so this only keeps a
future caller from silently emitting a wrong or unpredictable
instruction.

Also print the size, not the type, when the immediate offset load and
store encoder rejects a size.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/lib/insn.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 48a481aa9656..87a06bd08811 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -426,7 +426,7 @@ u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
 	u32 shift;
 
 	if (size < AARCH64_INSN_SIZE_8 || size > AARCH64_INSN_SIZE_64) {
-		pr_err("%s: unknown size encoding %d\n", __func__, type);
+		pr_err("%s: unknown size encoding %d\n", __func__, size);
 		return AARCH64_BREAK_FAULT;
 	}
 
@@ -542,6 +542,18 @@ u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 		return AARCH64_BREAK_FAULT;
 	}
 
+	/*
+	 * CONSTRAINED UNPREDICTABLE: LDP with Rt == Rt2, and a base written
+	 * back that is Rt or Rt2
+	 */
+	if ((reg1 == reg2 && (type == AARCH64_INSN_LDST_LOAD_PAIR_PRE_INDEX ||
+			      type == AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX)) ||
+	    (base != AARCH64_INSN_REG_SP && (reg1 == base || reg2 == base))) {
+		pr_err("%s: overlapping registers %d, %d, %d\n", __func__,
+		       reg1, reg2, base);
+		return AARCH64_BREAK_FAULT;
+	}
+
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
 					    reg1);
 
@@ -610,6 +622,15 @@ u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 		return AARCH64_BREAK_FAULT;
 	}
 
+	/* CONSTRAINED UNPREDICTABLE: the status register Rs as Rt or Rn */
+	if ((type == AARCH64_INSN_LDST_STORE_EX ||
+	     type == AARCH64_INSN_LDST_STORE_REL_EX) &&
+	    (state == reg || (state == base && base != AARCH64_INSN_REG_SP))) {
+		pr_err("%s: overlapping registers %d, %d, %d\n", __func__,
+		       state, reg, base);
+		return AARCH64_BREAK_FAULT;
+	}
+
 	insn = aarch64_insn_encode_ldst_size(size, insn);
 
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
@@ -1042,6 +1063,12 @@ u32 aarch64_insn_gen_add_sub_extended_reg(enum aarch64_insn_register dst,
 		return AARCH64_BREAK_FAULT;
 	}
 
+	if (extend < AARCH64_INSN_EXTEND_UXTB ||
+	    extend > AARCH64_INSN_EXTEND_SXTX) {
+		pr_err("%s: invalid extend encoding %d\n", __func__, extend);
+		return AARCH64_BREAK_FAULT;
+	}
+
 	if (shift < 0 || shift > 4) {
 		pr_err("%s: invalid shift encoding %d\n", __func__, shift);
 		return AARCH64_BREAK_FAULT;
@@ -1293,6 +1320,9 @@ u32 aarch64_insn_gen_adr(unsigned long pc, unsigned long addr,
 	switch (type) {
 	case AARCH64_INSN_ADR_TYPE_ADR:
 		insn = aarch64_insn_get_adr_value();
+		/* The s32 offset would truncate a difference beyond 4GB */
+		if ((long)(addr - pc) != (s32)(addr - pc))
+			return AARCH64_BREAK_FAULT;
 		offset = addr - pc;
 		break;
 	case AARCH64_INSN_ADR_TYPE_ADRP:
-- 
2.43.0

