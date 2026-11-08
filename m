Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166029;
	b=JoFMoNhdM4Hb5QPL8IGQjsGxsrM8E5/diZFcf6zHHSGuizKjTHupovJFFz034PTIYDQw
	 N2a6Xr+ywVkkOb4esOFNUEzLR9+Wrjo6cJfRU9q66OnHd3geRMhd6zL8+mOlC3wEUAqE7
	 P5mEek5jC/9U71RoK97mpDX9sGcbhCvOYpIjVLGxIt7FnnzQehTFbbwIaCDsLkdhJTA7X
	 UJsenRc7IxMEjut5mb/qmYjJL6yHn3Pt/NUwAZbCVsA/KCJzxbm2lEjxH+Y2fZvrLtDJm
	 CUNcsBDP9PIC7lxh3UUEpVL4HUZUL/LYL89EfU5FRFjosOkiGmcqxxdwEXL278E3ISw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166029;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=WFGlINNYhUau+aSgeAqconM9kVgThz3VlMdjcV9bLk4=;
	b=4BfMlGDcowURGKP/NiKR52pX8wXQdFGeiv3Kwn3ofabyv1yaQLh5/JI24eF2a6K0VCCs
	 8RjA2HCuvYj3LDJ1Oyy83wJkWsu71074yBQ85Pk/MjhmBNGNqUyqroJqdpCZEIfjl85vX
	 hAcBeIWkfCvpFMb6aB29as3ihKInsMatQOgjrTTRex673RP7WphvxBpf/RWWNeUwHPHvc
	 3uBlYnWZgYXwedcU1JwVgkRwbGwnB+tN8ZAaWWgrGOYjmR2oEVoeEw9gE5VexjhBHU1PB
	 0a8QH/i6A2cb7qhHAav7+GjyWWlNoyXTSGJGzWwZQ4FD0CdmAzw7sHLxAm+bbuYlscQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Bfj31yR1;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE3606A32A
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85BE3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=Bfj31yR1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=WFGlINNYhUau+aSgeAqconM9kVgThz3VlMdjcV9bLk4=; b=Bfj31yR1LHFpeCJztm/43iJd4V
	qEmNQO2s5qY48KCAHvaAA23xGlkzXX/1fB8RCkneeXH2NEVQelFBnKUU/dnbg65mv+HzwvLCrMtKV
	zQnDgKWN1C1WiqsS1wdi5ZVMMPNzN63yTjk04Ps7AMrlQFaoSxFmt/l/XAt2mSHfFoDPOBqjn4GJc
	bLPXXqhoQwL0E/gUqkSg5x8fvwnm7RlNEeAoS7m4E8K67GiwbizPxF0HTMl8hkcuHYtm8s9NkFeaH
	IJDFp7Y295jKpUzaoY6ylndfcPBwV10wuFWSLVgbMNLrx85vtdW3pwzyTjeCBtLRG0X5KadraxHBc
	sx2BLXCA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Xc-000Pdf-29;
	Sun, 08 Nov 2026 20:27:01 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 01/24] bpf, arm64: Remove unused A64_BL, A64_BTI_C and A64_LDR32LIT
Date: Sun,  8 Nov 2026 20:26:27 +0100
Message-ID: <797791cc4e63fee4c1642c04bb568a69d7dfadc5.1794165614.git.daniel@iogearbox.net>
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

A64_BL() and A64_LDR32LIT() never had a user. A64_BTI_C lost its last
user when commit a3f25d614bc7 ("bpf, arm64: Fix BTI type used for
freplace attached functions") made the prologue emit BTI JC. Remove
them.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 70fc329c661d..52e9d8eda3e9 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -45,7 +45,6 @@
 #define A64_BRANCH(offset, type) aarch64_insn_gen_branch_imm(0, offset, \
 	AARCH64_INSN_BRANCH_##type)
 #define A64_B(imm26)  A64_BRANCH((imm26) << 2, NOLINK)
-#define A64_BL(imm26) A64_BRANCH((imm26) << 2, LINK)
 
 /* Unconditional branch (register) */
 #define A64_BR(Rn)  aarch64_insn_gen_branch_reg(Rn, AARCH64_INSN_BRANCH_NOLINK)
@@ -87,8 +86,6 @@
 #define A64_LDR64I(Xt, Xn, imm) A64_LS_IMM(Xt, Xn, imm, 64, LOAD)
 
 /* LDR (literal) */
-#define A64_LDR32LIT(Wt, offset) \
-	aarch64_insn_gen_load_literal(0, offset, Wt, false)
 #define A64_LDR64LIT(Xt, offset) \
 	aarch64_insn_gen_load_literal(0, offset, Xt, true)
 
@@ -324,7 +321,6 @@
 #define A64_AUTIASP A64_HINT(AARCH64_INSN_HINT_AUTIASP)
 
 /* BTI */
-#define A64_BTI_C  A64_HINT(AARCH64_INSN_HINT_BTIC)
 #define A64_BTI_J  A64_HINT(AARCH64_INSN_HINT_BTIJ)
 #define A64_BTI_JC A64_HINT(AARCH64_INSN_HINT_BTIJC)
 #define A64_NOP    A64_HINT(AARCH64_INSN_HINT_NOP)
-- 
2.43.0

