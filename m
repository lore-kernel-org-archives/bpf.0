Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664472;
	b=Kcyv80Jex8jVfUdqQoYF7mTTnZ6zKMiRGzyKUtI0pP/Rec59xN1ZepARsxAk7EiB0hKl
	 ru1R+JT8UxXPtPDgCz4Y6MApF8Km6OFpRF+34csNBWBvbS9oCtWECC7CKp6aBfEze5OJr
	 tq37TUWjg8RE+CAJtz6ycmKu/gkiEbtZ5LrSjQdTgYLgjc0P+WyPcXHArYKFeM3S+T2AP
	 8r0iHnRV5esA9/rLYXk6U/Nphs8tjZnp4vE0KXmAoUzuBlebuR81SWQkMrTLLhy1x/cU6
	 fZKlBcOym/3SyrImq+RtCSEWzLOpBT+WTTpbCxjnI3rYAnLS1NrPV9LgMp3yvcuDKWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664472;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WWcpvyiKx9QdAEGQBV+Rm5SmC+zVbKadnyjvc+R3wRA=;
	b=Sp8DRJ5y9Jok4hRv0myN3Lx4C+guQqvtXLkoZfhZVx9VR+xN6dd4nc1PfVHajOB4USsi
	 eVUVTTD2H3ytfSNgA31PqTo8QdFqYlOqdS739vCsZ1ZDBmDgqIqL3G3uXkgQisunzArFr
	 7mrdliiVK0xtw2XZRVBEvM9CC/esdgr5wiwVB9nNzb7C36mW1MILoUFbOS/NXk8edbuyW
	 J+HZ2ZPAsaWfIqaKFEiBH82c0Qyl1wT1bPNyNJDsNH+QwICqUuouiEuD3obgRGu5BqM2+
	 CXXjFTHaCgB4WbkZJPDOjJpiwVMD462amdRuTcqbsmLca8B92IPu1SGjRJrsayL27Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XP85efvG;
	arc=none smtp.remote-ip=95.215.58.230
Received: from mta1.migadu.com (out-230.mta1.migadu.com [95.215.58.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C4606A68C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D1C4606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XP85efvG
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=F3uhmG/jC5tq5XsmcCz1nyolzy2MtfiIpZ5NsbKeVf0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795664469; v=1; x=1796269269;
 b=XP85efvG8Iv5LvXElHt56+QgtdQuNcpPX/wcUheblQV7Qa2nyhxSaKATKVv6MXhhu3W7qoi6
 mHPPsQYJ5wBvz5+X8M5rlOcTgrQWDJyZJB3HjrTP+KoDQQkweGPELpq34YzyDi8L34wzLOtjSYV
 jNJg0AYnRYDobZWI4TO2iNNA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4c2135ef4223dfca;
	Thu, 26 Nov 2026 03:41:09 +0000
X-Mizu-Trace-ID: 4c2135ef4223dfca
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] LoongArch: BPF: Add support for signed arena loads
Date: Thu, 26 Nov 2026 12:40:46 +0900
Message-ID: <20261126034048.7370-5-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126034048.7370-1-dongtai.guo@linux.dev>
References: <20261126034048.7370-1-dongtai.guo@linux.dev>
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

From: George Guo <guodongtai@kylinos.cn>

Currently, the verifier rejects sign-extending loads from arena on
LoongArch with "sign extending loads from arena are not supported yet",
because the JIT does not implement bpf_jit_supports_insn() and the weak
default returns false.

In order to support them, implement bpf_jit_supports_insn() and handle
BPF_PROBE_MEM32SX like BPF_PROBE_MEM32: add the arena base held in
REG_ARENA to the address, use sign-extending load instructions, and add
an exception table entry for the load.

This is similar to commit b4757714cc63 ("bpf, riscv: Add support for
signed arena loads").

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 20f29ea01bda..03c88cd9c96a 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -709,7 +709,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 
 	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
 	    BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
-	    BPF_MODE(insn->code) != BPF_PROBE_MEM32)
+	    BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
+	    BPF_MODE(insn->code) != BPF_PROBE_MEM32SX)
 		return 0;
 
 	if (WARN_ON_ONCE(ctx->num_exentries >= ctx->prog->aux->num_exentries))
@@ -1389,10 +1390,16 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
 	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
+	/* LDX | PROBE_MEM32SX: dst = *(signed size *)(src + REG_ARENA + off) */
+	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
+	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
 		sign_extend = BPF_MODE(code) == BPF_MEMSX ||
-			      BPF_MODE(code) == BPF_PROBE_MEMSX;
+			      BPF_MODE(code) == BPF_PROBE_MEMSX ||
+			      BPF_MODE(code) == BPF_PROBE_MEM32SX;
 
-		if (BPF_MODE(code) == BPF_PROBE_MEM32) {
+		if (BPF_MODE(code) == BPF_PROBE_MEM32 ||
+		    BPF_MODE(code) == BPF_PROBE_MEM32SX) {
 			emit_insn(ctx, addd, t2, src, REG_ARENA);
 			src = t2;
 		}
@@ -2676,6 +2683,11 @@ bool bpf_jit_supports_arena(void)
 #endif
 }
 
+bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena)
+{
+	return true;
+}
+
 bool bpf_jit_supports_fsession(void)
 {
 	return true;
-- 
2.53.0

