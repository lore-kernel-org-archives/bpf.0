Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562094;
	b=BP0flYc40zDOGGwATwCo33dCgPm+u4kSwebrv+pJn+RkxHmbVECYUgOmTdvpqVNZql7A
	 kTlKP4itXhD/YLAaLPletUpcI8QOIDrInKElzC2r+C/6TTLbKvyjQzbVetsYdFswh8JX9
	 WgUZSEokwdsLJDOu9oEDmh+USxQHDdtLp0AG7WF60CAAe1v/ZBvwnO+pCyRhZTdqBuGSv
	 pPTP/jzbEFWis+OmAQE81JSrVU1RguYujPQYV6gsMuai50G3pNJE3CsqsIQyKuqHdrhil
	 6VtLQJbE9a6/VZNtTZ24n9r0bwR0EAxfpVkgLbjiEG0rmVWnqUkYgzkmphybz4xhEDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562094;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=0o8S5vqh1f9DoGs7igiLzAZdHUkMqy/eiTsFZ7//zcI=;
	b=G0h3noUBGmtQPjIqI8cGPd90xWy0hrHxENR+Wu91TnCpuUR+wLXG03yas0gkEEp7NCHW
	 U5Mthxxhv5wZfifi8vDdKWuxEShOJNyDRmOhGPQ7iLnUmaGLTu/9fhXUGa2vBcxqzAsW3
	 Y8lvOYjYWfXxGQtfXV24CPrRkrvX8d85YaO83lVj+cIHHDfpgde461LF0TQA90G/2MuCv
	 gCK6IJhvAC8YuQrn29OADtjw/4X87gPQYFnLaSKaQ8dDZ3ga6hYjj7fv8PYcsARnPHWhD
	 UNKg4U//Y+Ilxx9HL84Xm7pIzuIewDObO83wmF1S8XaTYglctqpc0ekwdbWeE9BtsRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Y2EWGeur;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D28606A33B
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64D28606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Y2EWGeur
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0o8S5vqh1f9DoGs7igiLzAZdHUkMqy/eiTsFZ7//zcI=; b=Y2EWGeurYJ5G+czhuA9EWM1ZJ8
	U63G41sEd+pzAnG2rDk63D8Ft6lowLxjkYeiGRpplhoCilFosMk0tovwjsidQ9CiMcyx+kKHKGiWs
	SC7FA00B1BX7N+jr0mQHlitIBXKCfW2fHCKZ5id/qEquServxjlA3+hCW8rWv/7Pf4OW5l1r9k9ft
	oT212HrEwh1BoscauoY00PCPeJHu+N/jZScE47zNSw7g6d46612ogzeikfHzbA1tW5tmH7escr4OZ
	Krxfeh6D1ko7yaCj1mdCgRQeh1gB3d9o0+xMD6550z6V/S7t/AiF5ZcaiRuNvgF2x+sP0VSX42kPg
	8Ga2qbGw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xVzip-000Pym-12;
	Wed, 25 Nov 2026 00:14:46 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	will@kernel.org,
	memxor@gmail.com
Subject: [PATCH bpf-next 5/5] arm64, insn: Reject offsets out of reach in aarch64_set_branch_offset()
Date: Wed, 25 Nov 2026 00:14:43 +0100
Message-ID: <20261124231443.3424414-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124231443.3424414-1-daniel@iogearbox.net>
References: <20261124231443.3424414-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28193/Tue Nov 24 07:27:44 2026)

aarch64_set_branch_offset() puts the offset into the immediate of the
branch without a range or alignment check, so an offset beyond the
reach of the branch wraps: 128MB in a B becomes -128MB, 1MB + 8 in a
CBZ becomes -1MB + 8. Check the offset against the reach of the branch,
128MB for B and BL, 1MB for CBZ, CBNZ and B.cond and 32KB for TBZ and
TBNZ, and return AARCH64_BREAK_FAULT when it does not fit, like the
encoders do. Take the offset as an s64, and keep it in s64 in the
alternatives, so the distance reaches the check untruncated. An
alternative whose branch would be out of reach then gets a BRK patched
in instead of a wrapped branch.

The BPF JIT does not use the helper. Its only user, get_alt_insn(),
moves the branches of an alternative out of its replacement sequence
within the kernel image or a module, well within reach, so no kernel
code is affected.

Found by checking the encoders against Arm's A64 ISA XML (2026-09).

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/include/asm/insn.h   |  2 +-
 arch/arm64/kernel/alternative.c |  2 +-
 arch/arm64/lib/insn.c           | 28 ++++++++++++++++++++--------
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 302ee42d2b3c..55e6de8e7ad4 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -731,7 +731,7 @@ u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
 			 enum aarch64_insn_system_register sysreg);
 
 s32 aarch64_get_branch_offset(u32 insn);
-u32 aarch64_set_branch_offset(u32 insn, s32 offset);
+u32 aarch64_set_branch_offset(u32 insn, s64 offset);
 
 s64 aarch64_insn_adrp_get_offset(u32 insn);
 u32 aarch64_insn_adrp_set_offset(u32 insn, s64 offset);
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 2a1be7010e03..beb91a266fda 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -63,7 +63,7 @@ static __always_inline u32 get_alt_insn(struct alt_instr *alt, __le32 *insnptr,
 	insn = le32_to_cpu(*altinsnptr);
 
 	if (aarch64_insn_is_branch_imm(insn)) {
-		s32 offset = aarch64_get_branch_offset(insn);
+		s64 offset = aarch64_get_branch_offset(insn);
 		unsigned long target;
 
 		target = (unsigned long)altinsnptr + offset;
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 57a5c662411e..e4bc21c0c2cc 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -1506,24 +1506,36 @@ s32 aarch64_get_branch_offset(u32 insn)
 	BUG();
 }
 
+static u32 branch_imm_set(enum aarch64_insn_imm_type type, s64 range,
+			  u32 insn, s64 offset)
+{
+	if ((offset & 0x3) || offset < -range || offset >= range) {
+		pr_err("%s: invalid offset %lld\n", __func__, offset);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	return aarch64_insn_encode_immediate(type, insn, offset >> 2);
+}
+
 /*
  * Encode the displacement of a branch in the imm field and return the
- * updated instruction.
+ * updated instruction, or AARCH64_BREAK_FAULT for a displacement out of
+ * the reach of the branch.
  */
-u32 aarch64_set_branch_offset(u32 insn, s32 offset)
+u32 aarch64_set_branch_offset(u32 insn, s64 offset)
 {
 	if (aarch64_insn_is_b(insn) || aarch64_insn_is_bl(insn))
-		return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_26, insn,
-						     offset >> 2);
+		return branch_imm_set(AARCH64_INSN_IMM_26, SZ_128M, insn,
+				      offset);
 
 	if (aarch64_insn_is_cbz(insn) || aarch64_insn_is_cbnz(insn) ||
 	    aarch64_insn_is_bcond(insn))
-		return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_19, insn,
-						     offset >> 2);
+		return branch_imm_set(AARCH64_INSN_IMM_19, SZ_1M, insn,
+				      offset);
 
 	if (aarch64_insn_is_tbz(insn) || aarch64_insn_is_tbnz(insn))
-		return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_14, insn,
-						     offset >> 2);
+		return branch_imm_set(AARCH64_INSN_IMM_14, SZ_32K, insn,
+				      offset);
 
 	/* Unhandled instruction */
 	BUG();
-- 
2.43.0

