Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125491;
	b=x98YpWKkwHLdmdgPkdFJ265G/UXEcmnnut9r09OFQBhfUNZvZGCjlNZw33ZqPnK9dcb/
	 iVlhprsUuqkUrW6GiWqfpGDOuVG9pnNT2MEPYU5bmUkkMJUx0eYXtgW1aQ02MK2+1gzPP
	 rNHlsNFYe0sjmhnYeadyQsDQ1zGlY1ayvIs30sUDypi1I5grp3Ie9FqUH8WJYeGRyocTn
	 A5C2azkiF6F/HzSmGrBq30lr1s2xZ1nH08luV3c9OIOawn4AV5vWLaUNTeSqB9jbKOGiQ
	 kKjcmkjwe0h3b1MmJrlu9cQcyUNlTUgroLRjSCHM4aVFJ9E9NRlJYLpHdkSVW3VtNOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125491;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=xbOY7UqUG8GrSlc4nnXB5de6AWHat24002YaJjEAbV8=;
	b=XstcmIWSM1Wuj1BWCaG6ED6R1/bG0zBQfw54IGTS1X7VOwjAatE0hSf9WdUQYoIhnpQ/
	 ieUSoF1k4Q+AkVc+CLJ0sTVgfmxI7b+J3u2/RB1e3n8x1pKLSMoMMlruaOKxuoUuFbFtG
	 qK9F/KF7ZqHF5M8lmJl8R3u38Luf5MV71tAN14sNpN/z/IRkabnBJbg7ccRR1HSExv/JY
	 XDOaLoSMxkwW7dIMYLhUzp/0SsWVPoMjKNuUdRBCrAZWNgKd6zM50nKU0VNflyPrrnD5k
	 CUbRLfTLQhs2eoTkG/FEURqra5tG70J/9iOG1EpXFKUz1d4cDiNI+SWaoRKhwHEn1Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75CA606A326
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A75CA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xbOY7UqUG8GrSlc4nnXB5de6AWHat24002YaJjEAbV8=; b=Him4Lhe2hzuAF9ofs0/mpednIq
	iXjzD5BVBZxeL37gubRQEROcU3Vt3Dl2p5X7oT9f1YRCVSZ8wa6n0aJd/Z9IzPGHxNypn79bNoGbx
	FeznTbTDE9AQbHBXOwudmUPaUw2QG/W8wIsOUQprzyX/DxpBwEt60KtP5jtW7m6v06JJJW8mQl+c2
	fnk3vLlOC/a1tfslrrUhK9hJEYzej2BmXEFiFUyal46UxboGgoEHXuaWpa7c3PdPkhS2M3JNa4O+x
	9UJ+3/6vds1mBorBq5EEUIXnf8jjdnFJx2XbVHyC9YPGhBv4kjh4G7LxFiI+NRHU75lPzX5HUzufF
	OO7XXryQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqr-000Ij9-0e;
	Tue, 27 Oct 2026 19:24:49 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 04/21] arm64, insn: Reject sign extending loads of 64 bits
Date: Tue, 27 Oct 2026 19:24:28 +0100
Message-ID: <20261027182445.1156335-5-daniel@iogearbox.net>
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

The sign extending loads exist for bytes, halfwords and words. With the
size of a doubleword, the opc of LDRSB, LDRSH and LDRSW encodes PRFM,
so aarch64_insn_gen_load_store_imm() and
aarch64_insn_gen_load_store_reg() returned a prefetch, which leaves the
destination register as it was, instead of failing. The BPF JIT, their
only user, does not ask for one, as BPF_MEMSX has no BPF_DW form and the
verifier rejects the opcode, but return AARCH64_BREAK_FAULT for it as
for the other invalid operands.

Before/after for a sign extending load of 64 bits from x1 + 8 into x0:

  f9800420  prfm pldl1keep, [x1, #8]
  d4202000  brk #0x100

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/lib/insn.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index e70ac0238515..98a047de5e67 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -389,6 +389,12 @@ u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 		insn = aarch64_insn_get_ldr_reg_value();
 		break;
 	case AARCH64_INSN_LDST_SIGNED_LOAD_REG_OFFSET:
+		/* With the size of 64 bits this encodes PRFM */
+		if (size == AARCH64_INSN_SIZE_64) {
+			pr_err("%s: invalid size for a signed load %d\n",
+			       __func__, size);
+			return AARCH64_BREAK_FAULT;
+		}
 		insn = aarch64_insn_get_signed_ldr_reg_value();
 		break;
 	case AARCH64_INSN_LDST_STORE_REG_OFFSET:
@@ -437,6 +443,12 @@ u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
 		insn = aarch64_insn_get_ldr_imm_value();
 		break;
 	case AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET:
+		/* With the size of 64 bits this encodes PRFM */
+		if (size == AARCH64_INSN_SIZE_64) {
+			pr_err("%s: invalid size for a signed load %d\n",
+			       __func__, size);
+			return AARCH64_BREAK_FAULT;
+		}
 		insn = aarch64_insn_get_signed_load_imm_value();
 		break;
 	case AARCH64_INSN_LDST_STORE_IMM_OFFSET:
-- 
2.43.0

