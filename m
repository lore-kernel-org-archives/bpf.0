Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562093;
	b=wmKnjBaXrMx1QLwYjpQoj7KJarbFDucmSLLY++qyIqmEoX70O9D7zqy/oBxRSq095NtU
	 xBtFGN18MB8ZnvLGFJ6wmEhr5buu+tPLKK54OXQXLudsZVXsme7CanRmZK/LvzEDDHc15
	 kQ5ZBnUKN3ZWSYCrUPpkMaxdtBBtrcuhtr93RoLxos0nkOccejkKiPgLJeHi8GkCsWv8u
	 EVsInYmIaq/FMGtV3x7FktUs3D2/BGktDZgPfY2PkNs5UIavy2iQznR+NFDDE21VwB1Al
	 H6BHUXhYoTloOL4Kxn6rNQu0y6cvcNrMaf+FpwIYFC7jYdWjRWFymzlFMSR75OPw70A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562093;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=Dmhx7q3wJgf2jJlxaqSvHvACZp9TpKQ97C6q2Gte8FM=;
	b=pUkid1AjSqh2igbPyYbLdR7vA/+njOVjFhNtAEwXjAmsHJaSbg7/uHhdiRrG8DFx4wBb
	 xVyKldGYuLs3ApzZb0UDaJNuoAoxFMcUrfURTH6/tKmQ2D1dDU6MNZRAVMt9Y8lR0xe7J
	 1Gg1VFfZvLjjlOHMZADg9+zwwWCROEtoNpWyoQCWat9jxJqnEuJKksxPyoO5CtewS4aT/
	 DfvwGIqwUJiejse+ENquqzSJwDTsuhN1Hof6QSiQ7UTOQg4MzqhxcjOA7K6Kvr5qIfuJV
	 5gS2Ppb79Al8ympZrC6NdDRim5425Ir6S/FimxdgNJ2SJSjlMFyll+rc1E+axFbRfMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=njxASfVd;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80AF606A326
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A80AF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=njxASfVd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Dmhx7q3wJgf2jJlxaqSvHvACZp9TpKQ97C6q2Gte8FM=; b=njxASfVdKABVSf5TIxwcOGRFJm
	v4Tzp0axveeEvNWOXey2i2Or9ME0wV3FvvQlwpD7+eOafQ7rhl70VwRRsJtewzYbAcog0t96L4j4F
	uG7DIbXPm2UmR5NtTYko4dHJAMGxXWpVJ0hPkmQzEWuUI04ydckdEoCdz/n4gDM3/KYScUWr/xPgV
	csP8ry5cd+YysQAv2t000Fvh2wo6egh1wZ1W89jdvuJ18Hrpq1AmSy1wZnV/YUa+Rr8sxdFGoMtZC
	NRoyPKxbVAE+NeKzFfu/wHYdur6OZ2DevgTPFn5pW3orgc5Myb2NEv+BTcyI48kgkWDzpC7tYLO/W
	n5wRzJYQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xVzin-000PyK-04;
	Wed, 25 Nov 2026 00:14:44 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	will@kernel.org,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/5] arm64, insn: Reject ADRP offsets that wrap in the encoder
Date: Wed, 25 Nov 2026 00:14:39 +0100
Message-ID: <20261124231443.3424414-2-daniel@iogearbox.net>
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

aarch64_insn_gen_adr() stores the ADRP page offset in an s32 before
the range check. For a target about 16TB or more away, the upper bits
of the page offset are dropped. The offset can then wrap into range,
and the encoder returns an ADRP to the wrong page instead of
AARCH64_BREAK_FAULT.

Keep the offset in an s64 and shift the ADRP page offset as signed,
like label_imm_common() does for the branches. This also covers ADR,
so its separate check for a 4GB wrap goes away.

The only ADRP user is the module PLTs, which stay within 4GB, so no
caller is affected. Offsets within range encode as before.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://sashiko.dev/#/patchset/cover.1794165614.git.daniel@iogearbox.net?part=8
---
 arch/arm64/lib/insn.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 540888474a71..9e4917e68061 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -1444,19 +1444,16 @@ u32 aarch64_insn_gen_adr(unsigned long pc, unsigned long addr,
 			 enum aarch64_insn_adr_type type)
 {
 	u32 insn;
-	s32 offset;
+	s64 offset;
 
 	switch (type) {
 	case AARCH64_INSN_ADR_TYPE_ADR:
 		insn = aarch64_insn_get_adr_value();
-		/* The s32 offset would truncate a difference beyond 4GB */
-		if ((long)(addr - pc) != (s32)(addr - pc))
-			return AARCH64_BREAK_FAULT;
-		offset = addr - pc;
+		offset = (s64)(addr - pc);
 		break;
 	case AARCH64_INSN_ADR_TYPE_ADRP:
 		insn = aarch64_insn_get_adrp_value();
-		offset = (addr - ALIGN_DOWN(pc, SZ_4K)) >> 12;
+		offset = (s64)(addr - ALIGN_DOWN(pc, SZ_4K)) >> 12;
 		break;
 	default:
 		pr_err("%s: unknown adr encoding %d\n", __func__, type);
-- 
2.43.0

