Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166039;
	b=TmXLWbxiwlNIko8Auafh1Sr9UVCBPbGRBjfJcyf+T1WmWKgEGHZ4yf55DlLHb9m4RURm
	 9eHvf6e5V0Fw+LjSGwCoBmyXR7yAeBDOw5R+KAWnWf5KpxPmXMswx9bxgHXctoL9htCF0
	 3U8Ser2pFOiY4RIh44Il6v0rUx6oN/DGmNfgkzODA5cNrtnL5/ESk0QWfO+9seBsc/vNl
	 a/Lmh5Qlhr0/ZS+TVAytK8o2D+GmnarTupYaqxMZyXQOZsgkPotx+nkeVZh4JhQ+BB+Bf
	 IPnkbpdrI9CwFHGHGRAy1lIPQTi1NcCBAsx8IHQrNyEJqJOIBTS8NK6wVEkioydIOlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166039;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=MFEV+jOZqsyQ+DSKrvJ1KBz0EZsNqgCoaUvspDKyWA8=;
	b=PCUKchCtyvnwkz6wpKj/ZuBk5zT+4ycz5iPEJejM4M6g3B9j0NU2H9YZAQ5L9fPcOa6Z
	 BWKtrdz9Jzcz3cEQj78VX73RmaxM69Uw5S4JGij9J8btTTAwscmd4lmbr0S6yjtcXC3P1
	 Za02rrIX0P4wihvhnRkAUafBxdUIDDLt8yS0dIupWoJn6vyVyNJzO6dKbJAWhUvB89br2
	 DNKLZ6CXxp7dBMDlyjxhXZzAC/CNWWqfQ8l6mapdfBtlMGX6PaXO1wKl1OxfafpAnqa2k
	 R5UKcd9TwAv3pq8La+1McjvasR443TsDnw9xyRnonAnWOB7w0+tXrbomRz+fkHwG3ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Yody17lY;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00428606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00428606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Yody17lY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MFEV+jOZqsyQ+DSKrvJ1KBz0EZsNqgCoaUvspDKyWA8=; b=Yody17lY7xbaiyoDhb7v+gOlPz
	asqzaGcFVAzIPHcImQH6suZnkNKTqOY6htwJ+rKu5/J3fOeVeRNJeomfbi+2UkaOfULfQj3ixw5O3
	WZwM9M7NP0ECZYCVg+5ufyS4mqiOIafqRRsuoPZXESvzReTI+k5WzjuK3DH24gZ0L8piRIVqbhqNF
	V7p2PHX/4d3ZEJtj3QvcRirbO3bxpZxGFOSGis4vfjTga5ugqw/sGhjgGsCgFghjdho1HkTrpoLFA
	0pQxdrH7iDO2+yjr++0X5xw0ELy+Vl1zk1IBB8p1NBkWXsREzElwqKTlVHfj2DsuJFF+KKW/tUw20
	mFZ3eGLg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Xs-000Pgx-1W;
	Sun, 08 Nov 2026 20:27:17 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org,
	Luis Gerhorst <luis.gerhorst@fau.de>
Subject: [PATCH bpf-next v3 04/24] bpf, arm64: Emit ISB SY in the speculation barriers
Date: Sun,  8 Nov 2026 20:26:30 +0100
Message-ID: <55381dc4324aa5ee8a9ae73f9d61211e4681dba0.1794165614.git.daniel@iogearbox.net>
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

The Spectre-BHB loop in the epilogue and BPF_NOSPEC on CPUs without
FEAT_SB both end in an ISB. The JIT takes its encoding from the
instruction matcher's template, which leaves CRm as 0. The Arm ARM
lists that encoding as reserved.

Emit ISB SY instead, with CRm set to 0b1111. This is also what the
assembler emits for the kernel's own isb().

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
index 52e9d8eda3e9..79fb399681dd 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -343,6 +343,6 @@
 /* Barriers */
 #define A64_SB aarch64_insn_get_sb_value()
 #define A64_DSB_NSH (aarch64_insn_get_dsb_base_value() | 0x7 << 8)
-#define A64_ISB aarch64_insn_get_isb_value()
+#define A64_ISB (aarch64_insn_get_isb_value() | 0xf << 8)
 
 #endif /* _BPF_JIT_H */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 976282418909..cb17e6daaea4 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1044,7 +1044,7 @@ static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
 		emit(A64_SUBS_I(true, r1, r1, 1), ctx);
 		emit(A64_B_(A64_COND_NE, -2), ctx);
 		emit(aarch64_insn_gen_dsb(AARCH64_INSN_MB_ISH), ctx);
-		emit(aarch64_insn_get_isb_value(), ctx);
+		emit(A64_ISB, ctx);
 	}
 
 	if (is_spectre_bhb_fw_mitigated()) {
-- 
2.43.0

