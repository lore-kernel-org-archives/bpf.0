Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166050;
	b=WMGiQEYmiCMu9EZ2402WvDFHHfcFVGBqZYO5uBbuw7Ozba8kfCo7d6Sq84Inwmmro7Uc
	 rjm9/KUOKekfywLPwgyyttl/OTiwOjKYWZ3TQ/6gwdNzYO4HND6+OlAvnGOFVykl+Bh8d
	 FgUGgPw/+U+AXmdB2+FNmDmO9/KqfeCmV+ExFU7Bxw2aqP/3Sg7jc6a2U5pxUY+vP9t1P
	 csH2VEbbVnYz/11u1iqVfwgsWoQNvwfgXGo6+wrFvY81hqcalHOy530ZeAlbOwr0Vt/I4
	 td69r5vrOFBDNqNA0FqU6/o+xKbq/C/94vvRTnWPDcY1Xu4+R/v3v+HPgI5CUDq8TtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166050;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=cOt2cvZ2cQTKBaS/0Ted1zNorQsn3aqx0swRwP7+56E=;
	b=ctfIiD6L/K6SGQicDeBnEhcjSG0kPQVQ4WORmAeTK2TpLKtpwe5wAbW7wWadGEk/itpY
	 ALzUaYjsbvX7mAvb5YsAF7mcb7jIzokW97SiOSgesf/FU6v/bW05p6R2kcBpx5DEfjEHj
	 Qcvxc0gkIlkB4vtO8RXvB6DoMpA5gmAYzgOKBJCm9+9FIRphTozAwTr66BKgWyzJhOFb+
	 XXBzhYhQCjN4C74A634N3vkP8ruBwUhO1pXpSZaCGqmF7DJ1T3EIGtW4kmyag4UuSUK/r
	 VS/KI3qh04sOxj8B1zIhGvGv79nmKJVcsip1dud38W1Mb2w3crL8MwJX69NluwUR3Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=RMpwBPPL;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBC606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8DBC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=RMpwBPPL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cOt2cvZ2cQTKBaS/0Ted1zNorQsn3aqx0swRwP7+56E=; b=RMpwBPPLm0gIHKaVUO8kWmw7Q7
	ze0si6Y6k3rx31TiTLh17kGbJqlruybffW3AY7XeW4C0gHQggzYmHE2eflBkXRgYqNrFzLsHpN6g1
	5cg5eJk8nK6HQ9OwWmSnutiLCJguVGi7L1eZsxp2Cn04rQQ1O2rjR5qOuUDekhH+T/1BbcMbEf0RY
	P4sXqrzSkrGqlsRNI1tBknJpc2MlD2fgv3nPRfWV6dRa8Tm+SKlepIPCD3YhkQ4KK6mDYUJAtW+pt
	MO3WlNrTbHqN8/mWFVvEhIzGNYQzC/ogFS1vZAZG8Dc38QoeJQYfAhesx5tHN3B+Gwofzv3R1IlEB
	WOPCip4Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Y3-000Pj1-1G;
	Sun, 08 Nov 2026 20:27:28 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 06/24] bpf, arm64: Keep the ll/sc atomics address apart from the old value
Date: Sun,  8 Nov 2026 20:26:32 +0100
Message-ID: <48822456403635c57d6cd67e115f28473dac62ad.1794165614.git.daniel@iogearbox.net>
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

With a zero offset, the ll/sc fetching atomics use dst_reg directly as
the address. They load the old value into src_reg, or into r0 for
cmpxchg, and then store through dst_reg. If that register is dst_reg
itself, the load overwrites the address, and the store then uses the
old value as its address. The verifier rejects such programs, but the
JIT should not rely on that.

Copy the address into a temporary when the register receiving the old
value is the address register. The LSE forms are not affected.

Before/after for r1 = atomic_fetch_add((u64 *)(r1 + 0), r1) without LSE:

  aa0003e9  mov x9, x0
  c85f7c00  ldxr x0, [x0]
  8b09000b  add x11, x0, x9
  c80cfc0b  stlxr w12, x11, [x0]
  35ffffac  cbnz w12, ...
  d5033bbf  dmb ish

  aa0003ea  mov x10, x0
  aa0003e9  mov x9, x0
  c85f7d40  ldxr x0, [x10]
  8b09000b  add x11, x0, x9
  c80cfd4b  stlxr w12, x11, [x10]
  35ffffac  cbnz w12, ...
  d5033bbf  dmb ish

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index cb17e6daaea4..fa57783d7014 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -888,6 +888,7 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s32 imm = insn->imm;
 	const s16 off = insn->off;
 	const bool isdw = BPF_SIZE(code) == BPF_DW;
+	const int load_reg = bpf_atomic_load_reg(insn);
 	u8 reg = dst;
 	s32 jmp_offset;
 
@@ -901,6 +902,11 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		emit_a64_add_i(1, tmp, reg, tmp, off, ctx);
 		reg = tmp;
 	}
+	/* The load of the old value must not clobber the address */
+	if (load_reg >= 0 && bpf2a64[load_reg] == reg) {
+		emit(A64_MOV(1, tmp, reg), ctx);
+		reg = tmp;
+	}
 
 	if (imm == BPF_ADD || imm == BPF_AND ||
 	    imm == BPF_OR || imm == BPF_XOR) {
-- 
2.43.0

