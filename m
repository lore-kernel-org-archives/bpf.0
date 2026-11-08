Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166080;
	b=v96dFIfVoJqDYh/X6BgPzHOkBKhZPEUATCUf8tlr5D2tjE8wuU6QY2RDNGD9QTO/QDql
	 D4EfJk83sOqZo9fctrSo2ibo25eGt0TGIu43LthEQVJJCReqTiaCVmne6LMCUhzxdI2f6
	 v4KmeuAek2jXREqiD5Rrk4NBtzTqxMRjL6dyWJMoKkp4Lw6qjNtSlPOwFjAGmxPEijtVM
	 KdxUH1FjTWx2bfXMTaIpcFHjww5I0ezATMHqfR5DfREzElhEYMOiPxAiNqGT14P0lt+Gz
	 C3nqkJN4DiFho7LvuY/yQOdWJLZNULyoVxEd9RyOhdzVluKWXCdPHNcfyDQfvUs2BDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166080;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=weC8+4O9CfQzjq2OVCmAPevBmwiR8smBlkHGy+mLj3I=;
	b=GAdU2LobktFtOrN/lCgOWaek8ZdkXwEobrXnQa1lGMq4i9w5IS3up+QoXvofdob2IFaw
	 KTwhPVrCDRnvDKmJdtZQLkoEA378IoNwD/r//kMLkvKqtUYFw+p6FN8Nz0IZYT0OIsZ88
	 QbBmThrGqOZcEJhhlFmlr7Ec5HLQNBpgJSUMa4PD4a0yISy2LixLT4VMGUV4xd3eydznd
	 qlwUYEakz23tATVCl9HB5RcYfY3IxWVDd0MgTK6HbuVMzfBPMKdsx5QKKQKHdovQDWqH1
	 6RPKUWUOi/LomWHdMZzpdOhssZIRJjgXppFbPOYGHOoYPQmu2CLCJrpX7tEzSYSs/ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=mz2I1mMR;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B3606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B8B3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=mz2I1mMR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=weC8+4O9CfQzjq2OVCmAPevBmwiR8smBlkHGy+mLj3I=; b=mz2I1mMRtz8Eh6rqBASM4BhHkf
	1m6Kjqp/m4R5OEoSuiRbp/XRPBz8/ucmxLKhnebKbC5zKHPIDx9ynGQTFBRPPO0pco5lFtA7DNc5t
	6DHWNJG/wjZgkgzeDPSwHwHRNa1XKCWCStBJrGLji9oPBvtZGO+TuGBlNuQisafRxYYz4zD1eUy7Z
	Tet69dU2S4p61qwqe14YD0vRcfW3qcDt24UF8I19chG6gEaU4PP+rhEhwgicGrHc3HWy/CCUnnsn+
	gKPTSCKZjum0G2uwendmBrtyO8ZP5V+pHTQJ8u9BBl4FvHpJl2hmPghiCRrG+6d3apJWb6C2kdwOr
	ET+/fhmA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8YY-000PoZ-0t;
	Sun, 08 Nov 2026 20:27:58 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 13/24] bpf, arm64: Use the unscaled forms for negative and unaligned offsets
Date: Sun,  8 Nov 2026 20:26:39 +0100
Message-ID: <8d6e8c8259aa677feef2b0103939d15b9f53fa0b.1794165614.git.daniel@iogearbox.net>
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

A load or store with a negative offset, or with one that is not a
multiple of the access size, needed a mov of the offset and the
register offset form. LDUR and STUR take a signed 9-bit byte offset at
the same latency. Use them for offsets from -256 to 255, which covers,
for example, packet fields behind the Ethernet header.

Before/after for r0 = *(u32 *)(r1 + 26) and r0 = *(u64 *)(r1 - 16):

  d280034a  mov x10, #0x1a
  b86a6808  ldr w8, [x0, x10]
  b841a008  ldur w8, [x0, #26]

  928001ea  mov x10, #0xfffffffffffffff0
  f86a6808  ldr x8, [x0, x10]
  f85f0008  ldur x8, [x0, #-16]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 53 +++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 05ba44f47313..e20c48028f71 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -365,6 +365,12 @@ static bool is_lsi_offset(int offset, int scale)
 	return true;
 }
 
+/* The unscaled forms take a signed 9-bit byte offset instead */
+static bool is_lsu_offset(int offset)
+{
+	return offset >= -SZ_256 && offset < SZ_256;
+}
+
 /* The A64 size of a BPF load or store, and the scale of its offset */
 static enum aarch64_insn_size_type a64_ldst_size(const u8 code, int *scale)
 {
@@ -384,18 +390,36 @@ static enum aarch64_insn_size_type a64_ldst_size(const u8 code, int *scale)
 	}
 }
 
-/* The A64 type of a BPF load or store, in the immediate or register offset form */
-static enum aarch64_insn_ldst_type a64_ldst_type(const u8 code, bool reg_offset)
-{
+/* The forms of a load or store: scaled unsigned immediate, unscaled, register offset */
+enum a64_ldst_form { A64_LDST_IMM, A64_LDST_UNSCALED, A64_LDST_REG };
+
+/* The A64 type of a BPF load or store in the given form */
+static enum aarch64_insn_ldst_type a64_ldst_type(const u8 code, enum a64_ldst_form form)
+{
+	static const enum aarch64_insn_ldst_type types[][3] = {
+		[A64_LDST_IMM] = {
+			AARCH64_INSN_LDST_LOAD_IMM_OFFSET,
+			AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET,
+			AARCH64_INSN_LDST_STORE_IMM_OFFSET,
+		},
+		[A64_LDST_UNSCALED] = {
+			AARCH64_INSN_LDST_LOAD_UNSCALED_IMM_OFFSET,
+			AARCH64_INSN_LDST_SIGNED_LOAD_UNSCALED_IMM_OFFSET,
+			AARCH64_INSN_LDST_STORE_UNSCALED_IMM_OFFSET,
+		},
+		[A64_LDST_REG] = {
+			AARCH64_INSN_LDST_LOAD_REG_OFFSET,
+			AARCH64_INSN_LDST_SIGNED_LOAD_REG_OFFSET,
+			AARCH64_INSN_LDST_STORE_REG_OFFSET,
+		},
+	};
+
 	if (BPF_CLASS(code) != BPF_LDX)
-		return reg_offset ? AARCH64_INSN_LDST_STORE_REG_OFFSET :
-				    AARCH64_INSN_LDST_STORE_IMM_OFFSET;
+		return types[form][2];
 	if (BPF_MODE(code) == BPF_MEMSX || BPF_MODE(code) == BPF_PROBE_MEMSX ||
 	    BPF_MODE(code) == BPF_PROBE_MEM32SX)
-		return reg_offset ? AARCH64_INSN_LDST_SIGNED_LOAD_REG_OFFSET :
-				    AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET;
-	return reg_offset ? AARCH64_INSN_LDST_LOAD_REG_OFFSET :
-			    AARCH64_INSN_LDST_LOAD_IMM_OFFSET;
+		return types[form][1];
+	return types[form][0];
 }
 
 /*
@@ -407,6 +431,7 @@ static void emit_ldst(const u8 code, const u8 rt, const u8 rn, const s32 off,
 		      const u8 tmp, struct jit_ctx *ctx)
 {
 	enum aarch64_insn_size_type size;
+	enum aarch64_insn_ldst_type type;
 	s32 off_adj = off;
 	u8 rn_adj = rn;
 	int scale;
@@ -423,12 +448,16 @@ static void emit_ldst(const u8 code, const u8 rt, const u8 rn, const s32 off,
 	}
 
 	if (is_lsi_offset(off_adj, scale)) {
-		emit(aarch64_insn_gen_load_store_imm(rt, rn_adj, off_adj, size,
-						     a64_ldst_type(code, false)), ctx);
+		type = a64_ldst_type(code, A64_LDST_IMM);
+		emit(aarch64_insn_gen_load_store_imm(rt, rn_adj, off_adj, size, type), ctx);
+	} else if (is_lsu_offset(off_adj)) {
+		type = a64_ldst_type(code, A64_LDST_UNSCALED);
+		emit(aarch64_insn_gen_load_store_unscaled(rt, rn_adj, off_adj, size, type), ctx);
 	} else {
+		type = a64_ldst_type(code, A64_LDST_REG);
 		emit_a64_mov_i(1, tmp, off, ctx);
 		emit(aarch64_insn_gen_load_store_reg(rt, rn, tmp, AARCH64_INSN_EXTEND_UXTX,
-						     0, size, a64_ldst_type(code, true)), ctx);
+						     0, size, type), ctx);
 	}
 }
 
-- 
2.43.0

