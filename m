Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125492;
	b=U7jW6IA4nOVK+cRbj68DOEv3ELLidz701z7XOlq3NAtjrsTGxsabA6juPnzY1WieroAs
	 5chNHZ8zm1fSi7O8ZPeOgWNlh5it7t17fxJwZurn2BjOBv6Og32hb+PhzpckzljhR/PlB
	 8Yh6JGH2DyLnQ8MZa/aJrjreCatfbHLo3FbYkOZrxkH/3iLjSkH1F/p2nfOlTPusjTq93
	 6JGWE6XICt2IFuUvCw7gW89doJFVF2U5Ffneh7FD9WsKrVim5VZOe0898TRgiJSOih8in
	 VLr+9Rm8Ho3TfRAqAxxQmpQsu/qtWXEPgPT28jyHPeeSiJhaCHeOrEoaAxelWDhzZFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125492;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=ahBfo0V3i9YtHa5NuhxbTgKIiK60qgicxE6P0H5QFQ4=;
	b=1iVnd+C0KTxIsHvy8FUH82sRLZZWwzsqWSx4Sh7B/ceJIIIVrnQmkbDZ3xzp9yheN57a
	 HnuSecykQY4RZE5E+pfOJKfX0VwGBK124FAGd0E6DZs2G/6dZbxwKZLzr2Jpkd6bp+y/T
	 u+vAfff8a8FpqU73s0H1jJe+t5BUqJbxxkipkG7fyq/27h9jK72B/u2oULKNWt7Cq0OZM
	 kC0l92//j7c4Llspn72ZQkyf6teh/usvQkz19O6g8SKwYGxPlQtfL2dx4Tt7HzYBMwhjk
	 QBKij8Kx5Bec7d2b0Gtwj0P4vgBtB1F0ps9Yzt7sTkauAmb5jI+Kn7vVhkkneqUfCRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=UjruKvck;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59495606A321
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59495606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=UjruKvck
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ahBfo0V3i9YtHa5NuhxbTgKIiK60qgicxE6P0H5QFQ4=; b=UjruKvckQ16vf1Dsu0NDDnprcB
	jLv+sFQaK3Wi/LLooXOFGnH1q0qJ25tTPH3uhGR3jEd3LZ+zl/i7YXxYKbZnRYY4/ot9/Dj8fUrsy
	tzjf4osebAGDVggj0IqU7L8NcI9dLghF2mGqhur5wXKt9BQrMwQK/qE9czy2pYtpWs8/ZbVj5Gjj3
	bWleLK6SKs0sOorGx6+Dm4N7I07UM3E0JTLW8By8yE7AV7CYt9zjASmAUoAN8SXPtluLUvnuX2Thb
	4QPcx9b8FA+JT2s6C1g1UZSlVsDZFKM618MZzK+usykv5+Cp1E2cVwu1EGFl/yV5tIF7fnNByQ8W4
	CJJoT+uQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqr-000IjP-26;
	Tue, 27 Oct 2026 19:24:49 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 05/21] bpf, arm64: Keep the ll/sc atomics address apart from the old value
Date: Tue, 27 Oct 2026 19:24:29 +0100
Message-ID: <20261027182445.1156335-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027182445.1156335-1-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)

The ll/sc versions of the fetching atomics load the old value into the
source register, or into r0 for cmpxchg, and then store through the
address register. With a zero offset the address register is dst_reg
itself, so for src_reg == dst_reg of a fetch or xchg, or dst_reg == r0
of a cmpxchg, the ldxr overwrites the address and the stlxr stores to
whatever the old value was. The verifier keeps such programs away from
the JIT today, but the JIT should not depend on it. The LSE versions are
not affected, LD<op>, SWP and CAS have no register overlap constraint.

Take a copy of the address when the register taking the old value is
the address register.

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
index 7d5eb949cdf4..b651b4ba3e63 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -870,6 +870,7 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s32 imm = insn->imm;
 	const s16 off = insn->off;
 	const bool isdw = BPF_SIZE(code) == BPF_DW;
+	const int load_reg = bpf_atomic_load_reg(insn);
 	u8 reg = dst;
 	s32 jmp_offset;
 
@@ -883,6 +884,11 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
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

