Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708867;
	b=cAKRY4Q16irCBTsJ8umIW5+/UzFRiZBxsqO0EMEZwv38Lf2g+2gTuYuR1OkPDVjcMhkl
	 P/mKB9rblafMARLivEZP7KL87DvzKBh7It+2BPeravphNoc3QJzn65RYbixQK6HjgbVtJ
	 xq3qxqfZZO64svK8G2yl+0iMy7WIEUktjjrg8fG5hybZgpRjS8RC2z5zzQLj+JUjwBts8
	 dO8C/mMbAHdlA2SiguWgdnGGufopG3/p1HPizC547MVfACHv/jTyn5f+/ZRX0dN0bzeMr
	 Gj0Z1I0F1uXOK6HbIPm/FNKeDp+bmddlVXLkHI2NMIrg1ElW0PeLoFDgAHczswRdbkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708867;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=06VwDIwTPZbhGhzDZwKLciHiESv93lKgkvyjUxZITQQ=;
	b=YrTZMPilChRG+kDdOKIakXEkW2A/MdrURcyAOfo9hWSaUh7rvlxHUlWLYV51oQpt63Kk
	 qVs9+BjP9TTclVhPcyvVJ5OepqsmvMnqNiMPzTCYHmniBdGGHB3Uy4wJcR9/9NkGnYepm
	 cRw+6i4NsyOSrWE98nMXbJldkcKCOSLEuGLmPyoPMAlAks8xv1i21UI8FEGnSfMmJaysa
	 6NXrIk/56HwEbAw16UaMJ8cbmZat42ONWS+WVNwBhyjB6q5TcOPbK85pGZ5PvpYj374s5
	 ohUYoAP6eOWlCULiV3tew+NRzLajxTVFHTiSE/vNnU7Aq2SFe7JfwBOB324KE0vuVUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=hjBVWVce;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB7606A33D
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DFB7606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=hjBVWVce
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=06VwDIwTPZbhGhzDZwKLciHiESv93lKgkvyjUxZITQQ=; b=hjBVWVceRZgGqxNW6zuj6YgWOu
	vOsjy/5G4pBNuj2LE2Mre4ejsMs3UTUDjVQC59UbO1NbcKgX4gPba7pcn+FAikF1sZf3xJLqsoXG0
	f1T+Y1p0VCOum5OHly+umIRVeikenkJWWHNehVFqs/CI0nSa0DVrZzqZtdNqDxBLRFs/HpKO8qCQE
	SHewMk8cqbw/oQzx3fDL1aYH6FPcexhPMCfWZ4L3dIehH/kJvRoC4zYeOwM9BEtYLOahwme0/1ZGZ
	cJpsjVpsIPrBYcqkMHGZfs+CZ6RGsfS5b8qGotXSEs0ePhdjq6q2yO4wSsP1aGBSBYGHFy4mvOf3M
	bGAAk6EA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc0-000MQK-2D;
	Tue, 03 Nov 2026 13:27:36 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org,
	Luis Gerhorst <luis.gerhorst@fau.de>
Subject: [PATCH bpf-next v2 03/20] bpf, arm64: Emit ISB SY in the speculation barriers
Date: Tue,  3 Nov 2026 13:27:16 +0100
Message-ID: <20261103122733.1383002-4-daniel@iogearbox.net>
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

The Spectre-BHB loop of the epilogue and BPF_NOSPEC on cores without
FEAT_SB end in an ISB, which the JIT took from
aarch64_insn_get_isb_value(), the template of the instruction matcher
with CRm 0. The Arm ARM lists every CRm other than 0b1111 as reserved:
those encodings execute as a full system barrier, but must not be relied
upon by software. Emit ISB SY with CRm 0b1111, as the assembler does for
the isb of the kernel's own barriers.

Before/after:

  d50330df  isb #0
  d5033fdf  isb

Fixes: 0dfefc2ea2f2 ("arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs")
Fixes: dff883d9e93a ("bpf, arm64, powerpc: Change nospec to include v1 barrier")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 arch/arm64/net/bpf_jit.h      | 2 +-
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 70fc329c661d..b2fe05fcdef0 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -347,6 +347,6 @@
 /* Barriers */
 #define A64_SB aarch64_insn_get_sb_value()
 #define A64_DSB_NSH (aarch64_insn_get_dsb_base_value() | 0x7 << 8)
-#define A64_ISB aarch64_insn_get_isb_value()
+#define A64_ISB (aarch64_insn_get_isb_value() | 0xf << 8)
 
 #endif /* _BPF_JIT_H */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 27f0194ce0fd..fe6c8bf3dc02 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1037,7 +1037,7 @@ static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
 		emit(A64_SUBS_I(true, r1, r1, 1), ctx);
 		emit(A64_B_(A64_COND_NE, -2), ctx);
 		emit(aarch64_insn_gen_dsb(AARCH64_INSN_MB_ISH), ctx);
-		emit(aarch64_insn_get_isb_value(), ctx);
+		emit(A64_ISB, ctx);
 	}
 
 	if (is_spectre_bhb_fw_mitigated()) {
-- 
2.43.0

