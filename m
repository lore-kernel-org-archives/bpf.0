Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166063;
	b=iK6H67Hg+JthRBzFN+5UDQca1EJNwFmSwnEQzzdcU28M4dcTGdBoweEFN9c2nOdZTWYP
	 o0cOn1CG8Vu953kMM0S1ScvosEo3WzAm3x4gvSrevOcknCOU4XGua+Okp49I4m9usjvdL
	 6oyB9WpSgxy9S/+Qad1BLqjQH3aOFeM3KPMGN87HvjQgysA3/ojTX/vvSET6VARPnhi7D
	 vSEKNzcuvfVLQ5joI9q1uHXo0GsNXhmIgHwgjfjrL1XTPa37WmdTXho/nO9HOptXUatlR
	 wPWXBbw3tdBVl5BQz1jz+TuUSptSxQl4PRGs3o7d4FqyVqBJiMiL2oKuz6LZPJLHO/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166063;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=1NfLdiiJdrZKOg/WmCmjb2G6qCrI6AK05MgaqU6mQP8=;
	b=a4apLOWAKSaJjImQKL3TiIgMmqSDwzGtbaLLEooBp2FS/VqNvBSi7Mg25MtmOevU014v
	 73BfsSu1NembMsmNNvbMNZEERA/2sH3u7Ds6uAhdWFpYBthQMi3bvO+U4NdaAyGz4Y2lL
	 3v7oXgibmOaE8Ezlr1aB8BBRUXu5lyTcpTp4Updyk84LqzXWcAJXMxKBK5LhgOE9uHmS7
	 DKuGnzv0fCLVvqBz9asMHSZJpk4EQcIXmMA6g+NfknsIOhzxoAKklGO3SKZVmLQhqzB8C
	 U8MR/jtZHrYmiXD+yt1ziH61LFAJztuO8U4YRo0FzVf9/jdMv7TEEaYqMRyQRTdyn4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=U9NhmMYm;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7F606A326
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECD7F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=U9NhmMYm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1NfLdiiJdrZKOg/WmCmjb2G6qCrI6AK05MgaqU6mQP8=; b=U9NhmMYmahQZYkxBIHTcJNkCjp
	uNhhfB6mRFy6UB9qYL+yne1Nf5ECTHNyjpQZIoIF4wHLF7bK2Zq9h/R5OwrPA4cemPwn6eMTGkkfn
	A0DoWHqRaH/xKDjI4XLf3WMEmdDedHxVjnbnJ6GQ58c6v/j1PvIzqY6sWqwN7JZuUTAugBomM1Ztg
	GnU9MBu/SjT72Yd9oKXg0RfPl94ujGoqf5vwue9nFqFUb9cREbeEt5P24ZEOBQYVfztX4HgRMkWot
	zReq8/+i7VKWpjk8c6O3DTlz0M+dTpleXM4gO0S6L+3UbuGJgibwKVz9Ty5tR9MxsKrA2yR62dh5c
	JYb7857A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8YG-000Pma-2W;
	Sun, 08 Nov 2026 20:27:41 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 09/24] bpf, arm64: Widen the branch offsets before scaling them to bytes
Date: Sun,  8 Nov 2026 20:26:35 +0100
Message-ID: <820ffb112d7268f86be14f414f3c32090cc7b028.1794165614.git.daniel@iogearbox.net>
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

The branch macros shift their instruction count left by 2 as an int. A
count of magnitude 2^29 or more overflows, possibly into range, and
yields a valid branch to the wrong place instead of AARCH64_BREAK_FAULT.
No caller gets near that, but widen the count to a long before scaling
it, so that the encoders range check the full offset.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 79fb399681dd..d3e70de49b44 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -19,12 +19,16 @@
 #define A64_VARIANT(sf) \
 	((sf) ? AARCH64_INSN_VARIANT_64BIT : AARCH64_INSN_VARIANT_32BIT)
 
+/* Branch offsets in bytes, widened first so a far count cannot wrap */
+#define A64_BR_OFF(imm) ((long)(imm) * AARCH64_INSN_SIZE)
+
 /* Compare & branch (immediate) */
 #define A64_COMP_BRANCH(sf, Rt, offset, type) \
 	aarch64_insn_gen_comp_branch_imm(0, offset, Rt, A64_VARIANT(sf), \
 		AARCH64_INSN_BRANCH_COMP_##type)
-#define A64_CBZ(sf, Rt, imm19) A64_COMP_BRANCH(sf, Rt, (imm19) << 2, ZERO)
-#define A64_CBNZ(sf, Rt, imm19) A64_COMP_BRANCH(sf, Rt, (imm19) << 2, NONZERO)
+#define A64_CBZ(sf, Rt, imm19) A64_COMP_BRANCH(sf, Rt, A64_BR_OFF(imm19), ZERO)
+#define A64_CBNZ(sf, Rt, imm19) \
+	A64_COMP_BRANCH(sf, Rt, A64_BR_OFF(imm19), NONZERO)
 
 /* Conditional branch (immediate) */
 #define A64_COND_BRANCH(cond, offset) \
@@ -39,12 +43,12 @@
 #define A64_COND_GT	AARCH64_INSN_COND_GT /* signed > */
 #define A64_COND_LE	AARCH64_INSN_COND_LE /* signed <= */
 #define A64_COND_LT	AARCH64_INSN_COND_LT /* signed < */
-#define A64_B_(cond, imm19) A64_COND_BRANCH(cond, (imm19) << 2)
+#define A64_B_(cond, imm19) A64_COND_BRANCH(cond, A64_BR_OFF(imm19))
 
 /* Unconditional branch (immediate) */
 #define A64_BRANCH(offset, type) aarch64_insn_gen_branch_imm(0, offset, \
 	AARCH64_INSN_BRANCH_##type)
-#define A64_B(imm26)  A64_BRANCH((imm26) << 2, NOLINK)
+#define A64_B(imm26)  A64_BRANCH(A64_BR_OFF(imm26), NOLINK)
 
 /* Unconditional branch (register) */
 #define A64_BR(Rn)  aarch64_insn_gen_branch_reg(Rn, AARCH64_INSN_BRANCH_NOLINK)
-- 
2.43.0

