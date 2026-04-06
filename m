Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24AF388E5E
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494584; cv=none; b=bFmOSb0nO1TiM5fpmQIr2QwQauXLubl0P37My/evZaKontdGQZVo8dIbwRYsVEHqd64oa2B4BoPoEk7TX+qk3/cOz4l2c79QbzShNJn8lkvDkgJmCKEmpOUHcSWl5jbgvSiqzoT5Da/w9lsOVEoSQua48O9jaWuwV+v9UoH/v5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494584; c=relaxed/simple;
	bh=XpB4sapMEaWdRKAxdjENAq5+BRYXQ90qkIR45TqeilY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9qfkLYLVDd7bsDpzKPFG+GfvZT9ZBIMs0CfVbPmuJEFKhMtx21oahMN1Rd7vXMGfw//asYqk3eXJs0e/pt24dI1Bzyt5zLf/c9DD2HvtYwM4ALjJzV3IY0NiMahx8h+sI2RsuLomyut6CXpCZPum6wRIC7wsvTXE6+rfTYnkDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkWRgqU5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkWRgqU5"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so1600154a91.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775494582; x=1776099382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIac6Ou4TesFmOZ6i8CaLe998Q+ulUkplCTpXRbszY8=;
        b=RkWRgqU5a6LXXokSNyzRkXK8f19fQR1wZdHkkzBLJxLs0gwcMle/BojLqBf6S0dxax
         kcxZlz1cQQXXWESZrxm4mltKd0EXC6vJzMv7J35UF9cFW3ktROZd8kR05pX4Jjkrm7Xm
         Qr0g0pJgaZ8juuJiTCPwSs2wypgnpYqCwT1x/Kyzvez1qpbBPsFlI7wbg7wQbmmW3mhX
         DpSOYynvPAdvOJEaDjoXnnRJOaQXxmvzAXLX+oMv0MMMNSgkIqVbOGTOtwAnbPgwdkyq
         hDlgVmuXxIvQhy6VgsVxGKl3O5tY0qFCFSG149VKjYLc8fQdxVqlP3GeFInyUFKe0M7d
         e2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775494582; x=1776099382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIac6Ou4TesFmOZ6i8CaLe998Q+ulUkplCTpXRbszY8=;
        b=pGLN1+kJFAsz27MP4PTQ3iSiU73o/UIglUd9MC6tvpgxmXq91lkEYtoZP0SXvZVnR1
         Tw4k/8K59pXqlXU2IQSmbgTfc55hQX3wCzYlkq4cOhTSOCOUM+a1rorEJS0DHJzflIGT
         uerOLNOhV/3Jso5A1WBKqZzXkJJZ0HelZNRrSvWSbhy/Tg/ySntAssEHZw1QVXZ79KHf
         wU+pGmjy3dGuHsftSDtjMSDspA1pHsR2/QLMKopHWMx4AGMq/Kfm+v6VcOA4jFoE0uZF
         +ueCk9eC2WzOGss/DV94nsQt9iTfCbr/XWV7sdV70Vo98DDOfglgz31+VLM8swSShqeH
         mkGQ==
X-Gm-Message-State: AOJu0YxNr7caPnDIawRFjjsrJiWS6cTab9sTfKQHauP2sNH6eMmEJwWM
	NXvAjrtLwrLXZuBt82etNQIEngYw+cfywUkWUrb1JYUtPeJjl1kVaOOC3Nt43aHt
X-Gm-Gg: AeBDietLM9xpnlgqAHYr05Ziv0MB1Ewr+VgmM/+eKYaOnk+kY/lDMMphQ3EAKcjogv0
	RScfaPMC49gQa/9ZkUr0IWIREfwVrkVHqU0Uyz1aeSKURb4taqNBxdlMO9gdFV+QxgJkCU0mxgk
	ruEbZ+lYQ2O5iak3zUVjySgv0NtDmF1TKGRZypm2UDrXK01+2Mco0j33Mdj3WIcu4eK0VgiG3FU
	wLl+iF5TkKpUZdfD555XGPcWZO02NrHxImKaEujYA+rRrwqMDzzmeSb320gqkdyv1R3vYw4u9Zp
	jDqfz7DWxMlnMLSHQJKC1GSwzN98Xus9QBQ/yfxU92jVCnkQdaKNNmOAvLzhBuWrOO35s7ORyzo
	uycgd5KP1q7Vm+zl4p2KDdIB31dFuZExNAyzoD2b1NHhhf4OtSfK9xEkuWrrmeRPz2Jqd33/RNs
	agH4DwMGNaBE/509u34pBQubBW07o+M52H2AxLdWmmsF8aJw==
X-Received: by 2002:a17:90b:2fc3:b0:35b:97ba:acee with SMTP id 98e67ed59e1d1-35de6977523mr11862118a91.17.1775494581721;
        Mon, 06 Apr 2026 09:56:21 -0700 (PDT)
Received: from C6-AF-E1-B8-1C-91 ([223.188.119.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe5e1b9esm20795499a91.3.2026.04.06.09.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 09:56:21 -0700 (PDT)
From: Adith-Joshua <adithalex29@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	Adith-Joshua <adithalex29@gmail.com>
Subject: [PATCH] bpf: verifier: restrict insn_array_maps to jump tables
Date: Mon,  6 Apr 2026 22:26:11 +0530
Message-ID: <20260406165612.12115-1-adithalex29@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

jt_from_subprog() currently iterates over all insn_array_maps
and treats them as jump tables. However, this may include maps
that are not actual jump tables, such as static keys or maps
used for indirect calls.

Restrict processing to BPF_MAP_TYPE_INSN_ARRAY maps with
multiple entries, which correspond to jump tables.

This improves correctness by avoiding unrelated maps during
jump table collection while keeping the logic simple.

Signed-off-by: Adith-Joshua <adithalex29@gmail.com>
---
 kernel/bpf/verifier.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e3814152b52f..e2583dfd7bf2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18693,12 +18693,16 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
 	int i;
 
 	for (i = 0; i < env->insn_array_map_cnt; i++) {
-		/*
-		 * TODO (when needed): collect only jump tables, not static keys
-		 * or maps for indirect calls
-		 */
 		map = env->insn_array_maps[i];
 
+		/* Only consider instruction array maps with multiple entries.
+		 * These correspond to jump tables. Skip others (e.g. static keys,
+		 * indirect call maps).
+		 */
+		if (map->map_type != BPF_MAP_TYPE_INSN_ARRAY ||
+		    map->max_entries <= 1)
+			continue;
+
 		jt_cur = jt_from_map(map);
 		if (IS_ERR(jt_cur)) {
 			kvfree(jt);
-- 
2.53.0

