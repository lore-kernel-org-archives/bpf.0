Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562094;
	b=cZxxRZiIyeuG+bXYQklabarclxfTpTm/wsx6tAlCHygSHkV7EV+JAi/MpIVr1gKBaZIb
	 fH1oUBzB4uNKgkDMOZYggJATb1hPXOnC1Bzw6PNzOICj0oFqba9CVIucMvLecO8rvlmiY
	 YsFtTwrFGEx0VWQ0YUe0nuX88hXMHKTcwOyw8N0c7cmh8WEMnRkc57aBR21kFRplhs2B7
	 sM/DRKLEM4VZytfD//6UU1u3xSaFJ1dkKFkppbAxtysPSutPvAvrhf5vXsoeNKU08kWcR
	 iTx6xwmTq1oIsljEcBOGptPiniEEVRfgYXEKQ++rz9d1oESrC/8pAYaIOsveLIJOA9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562094;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=U2QxfSf5YgGlV5X/E3aQlzQ8QJV7+Or8zWPFdRREFkc=;
	b=cGFYGWwrZ4qJa0+sLvmpBesHHenRxywL4uB+ukMp0NlXcuv+W5WzB/tm4RQ7DoNgChgW
	 BQee2fYiASKT0lg6DGXA0IbQo+RjUdaY0cS98VmNP54/GIkfZwNujvCwWejXuc+yctAft
	 IOc+F3OKJy/jJAUbYHnFC1umSYJa4Oq0lPxbblyQdWGS5r/EFJpE8YdU+6FmPuDmJPvWP
	 S/OnETbOWMRWjoRUc+4Qm6/4EBxnrTwWdAKQbXPXEzQaKrql57AHG6L4DpmsEngcMblS5
	 0OZcFbOUMf2Em/yMC5E+BlOHyNhGWMOtB+h4qQb7+TowVO5SJn8BGUMmRhJxNcufglw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=bow9URVp;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F159606A32E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F159606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=bow9URVp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=U2QxfSf5YgGlV5X/E3aQlzQ8QJV7+Or8zWPFdRREFkc=; b=bow9URVpj2bjdwNxAu3RCdsq/7
	lB4y3VWEods9Zv/S6e1ZkK7TEJEcX0D1ofi591uRo6+NHeGAy9spnaMyMeSAKnRerVWsJ7+aZbviO
	+TiKbvwksA2HoD4Yxd0MLjbQ/LpIYIU+EbEtNn4FzKq+cM7qk3BilEMsZY0eli64K1IZ4EpRlCRFQ
	pnkRUu+hSQnXBT1sNK7Ggv1RCIAI2RJT9n07rJ7frxWPjzHlIE7cyXt2SZykLK2A0S+y7tIDmfqV/
	8w1UfRfRYDy+p7j3ZghzM9IYJ/p/mhbmkAbh8mQG09I5VxDrdPdc4gwPQIaoK9Kdfo/nqLupRo4DE
	kxbmxb1Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xVzio-000PyY-0K;
	Wed, 25 Nov 2026 00:14:45 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	will@kernel.org,
	memxor@gmail.com
Subject: [PATCH bpf-next 3/5] arm64, insn: Drop the unused outer shareable barrier types
Date: Wed, 25 Nov 2026 00:14:41 +0100
Message-ID: <20261124231443.3424414-4-daniel@iogearbox.net>
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

aarch64_insn_mb_type has AARCH64_INSN_MB_OSH, OSHST and OSHLD, but
__get_barrier_crm_val() maps none of them, so aarch64_insn_gen_dmb()
and aarch64_insn_gen_dsb() return AARCH64_BREAK_FAULT and print
"unknown barrier type" for three values of their own enum. Nothing
asks for them: the BPF JIT, the only user of the two encoders, emits
ISH barriers only, so neither it nor any other kernel code is
affected. Remove the three values rather than map them.

Found by checking the encoders against Arm's A64 ISA XML (2026-09).

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/include/asm/insn.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 4834bf8ab87e..b25dfd958f94 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -314,9 +314,6 @@ enum aarch64_insn_mb_type {
 	AARCH64_INSN_MB_NSH,
 	AARCH64_INSN_MB_NSHST,
 	AARCH64_INSN_MB_NSHLD,
-	AARCH64_INSN_MB_OSH,
-	AARCH64_INSN_MB_OSHST,
-	AARCH64_INSN_MB_OSHLD,
 };
 
 #define	__AARCH64_INSN_FUNCS(abbr, mask, val)				\
-- 
2.43.0

