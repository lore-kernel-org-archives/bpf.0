Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998336;
	b=luiSyNVEqQu+FNyph71npjBg7XOHoDoLc8i5HIQxuLpi4LIwpJPNFhSrQmSi1tZqSB1m
	 HGw/t4CHmagXDBGfvtuP20gtoxF3rsc8tgCqMM5BVOA0tm3lWEoUOF87+t72OYgeUQLIA
	 AEwwv5yHVpQQbWhXroo7fuSehSq5TsRwoUIb/R1xPGKhHyj5/nXL31adXFnkTwFEl+3zX
	 UX2Rr9BXvNtjKgzJGEiT9EsYirKp/YzyVHsRwrOhRkwofcB+2T7QJbD2AxaKbK1CkALtH
	 8K8MuatmqjloAStUI1e8ZWrSPg7PRD1c5UqgLFgfIVvpV2KBIqfLdwMDQXrrfzao9Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NiYqsbiEHPYukFA61TqPRmCuyZ7fxceskxzXhkevg7c=;
	b=03avLZsS+4SdbyjhXToRYYqlN6+Llwl7FJLhY+R5UAI3PWCyeyApasFggO8k9yy4SAcB
	 r19KrX1QvKcWXiEP05x0WI+6zmaucFcGEKnoKODiw/ieJ+MA56zKDyvZCGmPz88YGtqOp
	 vi2MgOJHtxlrbTDArVJ8/TU5HHwLtJw7QkJbt9KL+0V0Bex3UOU28DaB6L5zq0nTgOIli
	 0+hGor4Wi62UTaRlk5SmD7vScbmiRUPABwYBrLA9EPpGh4ooxE24pnNmS/mQdRZeLk5C4
	 k/ARMApMYIJJFRwEZbq3Hs4I5Hm+nAQFSlgSwBfsNkYWUSbWfHNh/c3kbZenH7kFOoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZKs4bXTM;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFC606EE8B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2AFC606EE8B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZKs4bXTM
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so11122805e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793998334; x=1794603134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NiYqsbiEHPYukFA61TqPRmCuyZ7fxceskxzXhkevg7c=;
        b=ZKs4bXTM0qdJSjqdefloVKdrzxsYXIIon4ivxBM55Pp/pG7RQ992vmqqh8YdTCsND+
         VZ/mDkkcZ1mchev1h5LAMjazf2uIhvX1DGykPMs8GYc8ALKSGBv1Ubg7Xr/dNSbBymPp
         HxDl07gnaPUNMCd5bmTRsFp5t/vjeV+gEQ1DOK/BJtOhhjG7EHDIUkNSM81X68Aoa7gc
         VFROOekgSIWWTbez+IdZJtlGg7mhNwHuQ5VMkx6symVuhiRGvO2nRWo1O46rwFgDfTcv
         ox5ew6jFMgZDz4diaz5KgcVvl24q7m8gUln7V8stk7lVMQSzOflKlPJlN13KlqrXldlH
         3p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793998334; x=1794603134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NiYqsbiEHPYukFA61TqPRmCuyZ7fxceskxzXhkevg7c=;
        b=oxvALTEPCh/RDnj0OIq/gdJ3bspgBywQr2cm6XBEJFjrItEWRjQ8sgEu4Ni7uJg11W
         5IUmStnLriFjiKRLIvos/IqRoWO1zEuD5mKqBkUlQPbRhZDZQFUnrGYMByBImbwcU7Ac
         U46MrW3XG0qNYvgVBn0HRL4OFM5FjfhOXviV/BQ69jG9ger1/tTO8JwHZOOYDXQyKOEZ
         5B/6/QI1jUZzfIb9X0BsJb49/q/6CaJ6cP9QE86SH3OPWY2HYwWUAwO71pmh94Us188K
         o3wl9Alr3M/0WlNRuH3PjLis+UZaAUGc8eahzNvdKGCGC6Nmklm0Fqfnu/l7hHB3O406
         j42g==
X-Forwarded-Encrypted: i=1; AKwUvBx5mUgbtqKeh+eapn3bDwZgUN21Gmdl6Rubsn+IfWE4FOf+4SyYGHKXqV8NBnTvOZXD9Ac=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ER9uOgaZ6Ky9WF+6G+OMdBdMy/xLb7E4amJbTQfY6tAPh4WVJ
	6KwaDCx+JeWnnvHarJ/ko2YsqRntKT6yXmx+Bz3u45h3eFjeaKm41Hzf
X-Gm-Gg: AYBFou3GG07Dhst2d/qYDnicOk5BUVkAMNJDnDfx1DfhRpj40zYvdXjjJbHH7bDL/uD
	5nq7w4QqnsFraYrxPFZ7xaIQRKPKt9f2X63tXPc3gqJprDxJZJvsdR1yWQyPjXeKJWN5U8Liw4K
	ZIXkG2WDZSAF7K3Yi5cOKISJEIyVNY7cVJklz4W0CdNSYIL6chk97mm8hdIcBH2ubrnezjKC/Wj
	icSbApqaDwae1ZkiJF8ZApmFCgIilam5f9H/Y722eHqJcoyc49fEqLe2xGtb4KVBXY9QFrn/Hfy
	KXbAt1icvWrC0iedH9s0rS0uFZ+igOYPmp+LUT/6eJoOGsX15Pnh4/ey7fQ0NAG2/LB+lRjKHnn
	ednyDjCG+2yIWwXyC8kJOQ3pZ7+XXp4vGmOSzr139/ioSoywfvfXgnDgZkLaNDzv5ARvrDJtXN5
	xkE/Ym/jLL+cGzYhAERWZrDcn889jVmhP+mG26U3EXHn0BC7GTurb6nZbaZ8eIES6+KCJrkq76u
	RoD3yZ5Qv+Jx89Qju1U20n9/o9YZYpArzrjWKonOMlsQMjtbRpnsLE5XBIOxWQ2C03L11taZ5wg
	p2AVTjGSxggG+t/vRZag0YLHsgFYjb2befSSjN6qNOBpTqs=
X-Received: by 2002:a05:600c:37c9:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4b6df8c9cbbmr58263025e9.21.1793998334195;
        Fri, 06 Nov 2026 12:52:14 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7da62edb4sm9075425e9.1.2026.11.06.12.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:52:13 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 12/18] bpf: Follow integer casts in bpf_scan_ir
Date: Fri,  6 Nov 2026 21:03:01 +0000
Message-ID: <20261106210314.1767267-12-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20261106205523.1765622-1-a.s.protopopov@gmail.com
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
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

Follow sign extensions and truncations between integers of at least 32
bits in the block of the return. They keep an error, for example an int
error which a function returns as long.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 scripts/llvm-plugins/bpf_scan_ir.cpp | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/scripts/llvm-plugins/bpf_scan_ir.cpp b/scripts/llvm-plugins/bpf_scan_ir.cpp
index 81de8f941568..a3c6336662fc 100644
--- a/scripts/llvm-plugins/bpf_scan_ir.cpp
+++ b/scripts/llvm-plugins/bpf_scan_ir.cpp
@@ -82,17 +82,39 @@ static bool errnoConstant(const Value *V, int64_t &N)
 	return N >= -MaxErrno && N < 0;
 }
 
+/* A sign extension or a truncation between integers of at least 32 bits */
+static bool preservesErrnoCast(const CastInst *Cast)
+{
+	Type *Src = Cast->getSrcTy(), *Dst = Cast->getDestTy();
+
+	if (Src->isIntegerTy() && Dst->isIntegerTy())
+		return (Cast->getOpcode() == Instruction::SExt ||
+			Cast->getOpcode() == Instruction::Trunc) &&
+		       Src->getIntegerBitWidth() >= 32 && Dst->getIntegerBitWidth() >= 32;
+	return false;
+}
+
 /*
  * Add the errors which V, the value returned in RET, is known to be on the
- * edges to RET from CLEANBBS to VALUES. V may be a PHI in RET. A PHI in an
- * earlier block is not followed: a later branch may split its values between
- * clean and dirty paths.
+ * edges to RET from CLEANBBS to VALUES. Follow the casts in RET which keep the
+ * error to a PHI in RET. A PHI in an earlier block is not followed: a later
+ * branch may split its values between clean and dirty paths.
  */
 static void collectErrnos(Value *V, BasicBlock *Ret, LazyValueInfo &LVI,
 			  const SmallPtrSetImpl<BasicBlock *> &CleanBBs, ReturnValues &Values)
 {
 	int64_t N;
 
+	while (auto *Cast = dyn_cast<CastInst>(V)) {
+		if (Cast->getParent() != Ret || !preservesErrnoCast(Cast))
+			return;
+		if (singleErrnoAtUse(Cast->getOperandUse(0), LVI, N)) {
+			Values.push_back(N);
+			return;
+		}
+		V = Cast->getOperand(0);
+	}
+
 	auto *Phi = dyn_cast<PHINode>(V);
 
 	if (!Phi || Phi->getParent() != Ret)
-- 
2.43.0

