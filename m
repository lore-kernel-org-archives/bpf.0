Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166107;
	b=NZKYh6mdVlzX9x8SA7VeayhCSsUqQvWFbKUhX5rw6AKYaPRQ5NBe9b5mPS8hcU0/BDdb
	 FAdzsVSjtDvB7YP5mXgBAZ4CzupXuUW1z4T2SyBd9AGdzuzI0i76L77M2Vdzy2Wt/BLat
	 5MlU9BFOTl0ABiE/Q4NhF4HiSG1RXD3xDZAxDGDcuk3EuaJQxHmTBirR71gfbKoRNgL5Z
	 E0B+EtML+WamKO1/JzC0tA+l5KtEQ5DU5eOGWlFeAGJ/WFshrKAS9lcYoUeK55ox284jX
	 XLuE0SqYKCcspZN/9VQTK/N3dSfyfhINqJ6AbbG41d1joXQHfCN1obGl/ACmM8Kje5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166107;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=mwNBTc8j9SDv7UIZVjDiV+P0V714+vWPKSf+QAmBWPE=;
	b=ZOffGv7JA+UUJUsE+CVnBD1vkPg/wdPa5jnHqOR3/dO7vCghQXq2eS0s4j+hN2//Uabh
	 Lo7DA33g5H4vUoCfvNTYXCLvBvsfrIFDKBB9eiSrH4MsX6ycH4xrKA9h5DlMXFG1fdS1c
	 9HuoA0v3W1daoUAW09xvRwyclNHXL56jBtHCoUPl3gXKKGBgsZwnu33Oaith4acR0WGXK
	 IyKEv1PkmHfeNwxz4Kmz4kXC8EASQAVH9g4DowecHoAj+f+T6phiibZXI45m2RPHEFJjZ
	 Yd98qwZ2NTMPeuzA0S+FUVrhJL26hVwl/3H1fUUqmVr+W0n4Su8wGb5/ctXCoBsdWRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=F9H7I5cC;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CA3606A320
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99CA3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=F9H7I5cC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=mwNBTc8j9SDv7UIZVjDiV+P0V714+vWPKSf+QAmBWPE=; b=F9H7I5cCT0vWroayJnjcz8cFta
	RJwkjbaOK5EHfawykd8EkHBS/7yPgGCi+EzypKzVRCPGHMjueretJB8kbGa48LCsPr63ehzio+ZEd
	EwoB3Qo1SpM6SmkL2gcynMcmDcy1SFQgyjuaJHtitJnVJUC6w45GJTVMdY+D1TOKfCrJkqD00jFUf
	B5WEWcJKDEdMB2F9xrynMI1CoNd42k+qrxvSKScXSzgQHmSOcC11t/nYlmjW7U022c/qh0MiYGHI3
	7kP3eTG51t4GL1l9CI4kXAiS9a2VTutc3tcQS4lmBcgOzFrOHKaOvSlwO2/z5S+779OYSF154D3PT
	ioEoUCtg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Yy-000PsH-1k;
	Sun, 08 Nov 2026 20:28:25 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 19/24] bpf, arm64: Use mov or mvn for AND, OR and XOR with all ones
Date: Sun,  8 Nov 2026 20:26:45 +0100
Message-ID: <16fd55629bcb969a47506d1c2722df2807a1af17.1794165614.git.daniel@iogearbox.net>
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

The logical immediate forms cannot encode all ones, so AND, OR and XOR
with -1 moved the constant into a temporary first. The XOR is common,
as LLVM lowers every bitwise NOT to r ^= -1.

Emit an mvn for the XOR and a mov of -1 for the OR. For the AND, emit a
32-bit mov to zero extend the 32-bit variant, and nothing for the
64-bit one.

Before/after for w1 &= -1 and w1 ^= -1:

  1280000a  mov w10, #0xffffffff
  0a0a0000  and w0, w0, w10
  2a0003e0  mov w0, w0

  1280000a  mov w10, #0xffffffff
  4a0a0000  eor w0, w0, w10
  2a2003e0  mvn w0, w0

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a79c401c5262..b1f438d85721 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1911,6 +1911,12 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	case BPF_ALU | BPF_AND | BPF_K:
 	case BPF_ALU64 | BPF_AND | BPF_K:
+		/* All ones only zero extends the 32-bit variant */
+		if (imm == -1) {
+			if (!is64)
+				emit(A64_MOV(0, dst, dst), ctx);
+			break;
+		}
 		a64_insn = A64_AND_I(is64, dst, dst, imm);
 		if (a64_insn != AARCH64_BREAK_FAULT) {
 			emit(a64_insn, ctx);
@@ -1921,6 +1927,11 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	case BPF_ALU | BPF_OR | BPF_K:
 	case BPF_ALU64 | BPF_OR | BPF_K:
+		/* The or with all ones is the move of -1 */
+		if (imm == -1) {
+			emit(A64_MOVN(is64, dst, 0, 0), ctx);
+			break;
+		}
 		a64_insn = A64_ORR_I(is64, dst, dst, imm);
 		if (a64_insn != AARCH64_BREAK_FAULT) {
 			emit(a64_insn, ctx);
@@ -1931,6 +1942,11 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	case BPF_ALU | BPF_XOR | BPF_K:
 	case BPF_ALU64 | BPF_XOR | BPF_K:
+		/* The xor with all ones is the not */
+		if (imm == -1) {
+			emit(A64_MVN(is64, dst, dst), ctx);
+			break;
+		}
 		a64_insn = A64_EOR_I(is64, dst, dst, imm);
 		if (a64_insn != AARCH64_BREAK_FAULT) {
 			emit(a64_insn, ctx);
-- 
2.43.0

