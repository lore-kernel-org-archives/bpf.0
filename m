Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562093;
	b=y60zk1C28hk2UBOu1qowe8YMnG7LYkqDVAcRcVM1uu8ZIWUr5w2VxKMgmQwbiVUI3xsx
	 gK2bmugvtcDPWTG/QAyEMZl1A5DXXJpUCFTjxyYz8EL+59vu6A7gefpVlAGe1zvNgGZIZ
	 GtIaK5FMo20ONKddQoiCY9PZMltJmyjbdgAVbgFp/2d3DXyfGFvUkSk50kwyjdvSIFb7c
	 99EABFO8RgEwiALQ6JvfUppmw1D23qi0Whef76+X6F0FOHkykckeZxex8emB6N8nOMuHy
	 52ZHnZJF7zCdqNHP5JgIj3823ExdWawA58SBffe0JbZ/26d/8l2vksLfA2ADYhVM25w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562093;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=TS2F8/2yujXcpiNAXOp1mX31dDWHRuDyL2ha9CygunU=;
	b=ePvCSHonUuwfwxYD9ePDKsMEeDooH4QazD5P3xg+fAzsJ+dpgRw5MEsNIhJjm7NpHuwW
	 BwMQCmNpTI8SNZEi1gae3hCUdGNaBNWhbEQWDi6UCjbI8zY+VimGLKkI+JE0avVNJ3R1w
	 YDOwAiTr/3REXQPL75pGp49h6xYdtLUjwA5uvzFjRgMLYBvCEElsOl6Efsjj44sj/UdM+
	 eAKCmR8wSiyCEBc0SuyYXOChWTUlMuYe9860UR4uawyMNuRUvLESTlespbD6aqNSz8Le5
	 UnLhlecT9ajKugL09f9lAUl9nGxSSTnv/7OE65ieDFYE3NrqsyAgE5l59yG/ql9t4Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b="kQ/0h1Y5";
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F28606A323
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3F28606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=kQ/0h1Y5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=TS2F8/2yujXcpiNAXOp1mX31dDWHRuDyL2ha9CygunU=; b=kQ/0h1Y5LlM3vxrFsMsk1U7pZ+
	Mum9/VakzwYF8trh0IG6J382cPX87n2b4EwG68JfOiquiRmKTGld9BbD1/a5vgMRg0KuJLYE+cE+J
	mhh71E/oATxT6fN3h47AqOjMufeVSXaYdOjVOB48k+fV7yX3fLwKv3hHoEczCsTuAnxs9iPMdj9ct
	lSF9qBbo12oekQSWrCJShMV0OgStF+3LPp8hbTwKAp4MdhlZNYHy0n/LnEXadwgg7Uc1y4+I8k9T+
	AVSyNnNv3pTZ0TGda9u6pBkwwxDjYzP11w770s+LvNlGlveqLLklzVRo71y8bw1EGXqTKVfIN3D/q
	7Njd3oDw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xVzin-000PyQ-1v;
	Wed, 25 Nov 2026 00:14:45 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	will@kernel.org,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/5] arm64, insn: Reject a status register for the exclusive loads
Date: Wed, 25 Nov 2026 00:14:40 +0100
Message-ID: <20261124231443.3424414-3-daniel@iogearbox.net>
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

aarch64_insn_gen_load_store_ex() encodes @state into Rs for every
type. LDXR and LDAXR have no status register, their Rs field is
(1)(1)(1)(1)(1), so a @state other than the zero register gives a
CONSTRAINED UNPREDICTABLE encoding: UNDEFINED, a NOP, or executing
as if the bits were set. Return AARCH64_BREAK_FAULT instead, as for
the register overlaps of the stores.

Before/after for ldxr x0, [x1] with x2 as the status register:

  c8427c20  ldxr x0, [x1] with Rs = x2
  d4202000  brk #0x100

The BPF JIT is the only user of the encoder, through A64_LDXR(), and
passes the zero register, so neither it nor any other kernel code is
affected.

Found by checking the encoders against Arm's A64 ISA XML (2026-09).

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/lib/insn.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 9e4917e68061..1b4525c50504 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -751,6 +751,15 @@ u32 aarch64_insn_gen_load_store_ex(enum aarch64_insn_register reg,
 		return AARCH64_BREAK_FAULT;
 	}
 
+	/* The loads have no status register, Rs is (1)(1)(1)(1)(1) */
+	if ((type == AARCH64_INSN_LDST_LOAD_EX ||
+	     type == AARCH64_INSN_LDST_LOAD_ACQ_EX) &&
+	    state != AARCH64_INSN_REG_ZR) {
+		pr_err("%s: invalid status register %d for a load\n", __func__,
+		       state);
+		return AARCH64_BREAK_FAULT;
+	}
+
 	insn = aarch64_insn_encode_ldst_size(size, insn);
 
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn,
-- 
2.43.0

