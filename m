Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708867;
	b=FEEUwXq8dFGywTWTEaXBqy4H+zMkB9H0Enu3Tg419+Lj1PHwUzDXJFnQ6hFCOipWNG8Y
	 nB9+/qpBdMRkye1Qid9W34X3mAdC908FGF/vrfuG0Z0L5+MzBA73Zl5CLU0S68gWiTGz0
	 MwVhIs1zFrIUq//cb806TuL4Rm64h/kegRwE69pKUWURLoumXAK2PqX5fYDCGDCuMjHp6
	 6vFN6E9sti89doR0wfBJzs6tWZ8vHH51HxpZraOBUmrlAnlSs7NbxiS/7xrdMpKWP9Yd+
	 tk0R2cQ0ngPKjT9eQfFI4orvOptKxS9yj23j791IhYqJGMJ5Yc8Z8dWhlRSUYzyNVSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708867;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=fiFNxHC7wDkDPiS8P5DPlRxywpevDdAJ6s5GcFc8SDQ=;
	b=qpRrC5KfELf9OR/JaYpMkKRQGY93M5g/rjpxrHQIk3h8CqoIP2QfFkRiSYWqc9SNUWSs
	 b2+erA/yhfOkAxq+Hr/E9MvuBmp+vlznzSHgjf8o4MZK2x7CoJ1yqhndcjYx0Dtj1T7Bq
	 eIjxjVfboABXDRLOIqZi9GxGHiakRa2j1zOcwFkIN1h5rpct9/IkErPpphH07W4KhW1+/
	 POL2qqkLecvicojup5lbJV8RMuT5mgnMoQgl9Y7In8+YYcn0N/kM0Ja5x/8u5Fz0Qyrzd
	 b2FV1BtTP8c0Lq6Dv5euxy0zRWYA5URblRwvMxH+nw51X1MYQsTc6fLVV6QofdkmHPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=KQQ+RJVL;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D28F606A337
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D28F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=KQQ+RJVL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fiFNxHC7wDkDPiS8P5DPlRxywpevDdAJ6s5GcFc8SDQ=; b=KQQ+RJVLZhsAw69zKaNyYciXSI
	2esXZXdw+0FaXa9mkULanIQ15SbLqECEKeQFvGzNO4gwYQCGTzFiV5BwdEK53U6Rw/4fJjXyc8oJx
	NC8vt6DdLWy9hMbCTEOaQizOpNedyPDFEfK/T2D8eFFiI+dq8zt7WmhmSmtvVcL49tt67tA3r1eHS
	7/MvQnPHpnY3oXid/BpMa1XnL1dPU7EBpj7c5SXbIG3h2BEAVYwIsvATv1RiuMxLxwB269jjWzkiJ
	Yud/W8b5bfZMTULT1LaOoxK88uEc5o2e4svfBEC/NKbPRUqFc0IDBSRvGNi+e04qh1OY/8fmLDbA5
	FN12F23g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc1-000MQW-33;
	Tue, 03 Nov 2026 13:27:37 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 05/20] bpf, arm64: Keep the ll/sc atomics address apart from the old value
Date: Tue,  3 Nov 2026 13:27:18 +0100
Message-ID: <20261103122733.1383002-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103122733.1383002-1-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

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
index fe6c8bf3dc02..99f1d9bd13ea 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -881,6 +881,7 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	const s32 imm = insn->imm;
 	const s16 off = insn->off;
 	const bool isdw = BPF_SIZE(code) == BPF_DW;
+	const int load_reg = bpf_atomic_load_reg(insn);
 	u8 reg = dst;
 	s32 jmp_offset;
 
@@ -894,6 +895,11 @@ static int emit_ll_sc_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
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

