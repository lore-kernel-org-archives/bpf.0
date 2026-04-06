Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A9328243
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473813; cv=none; b=Z5Zm9AuSk6U0Ja/EWljtBnhAwU9Zi83wiJQN2CoiniNNNJ1p/qnq05vOq85eBH5MckEmliicc+fKhyPjtoX6rHV1MtOxRCVO7b9Mql6EheMofW39tMVgfBBCwTjfhdRgiS5tfeN8DOaF9IaWExd77oQvZroE9NU08uAhpV4gn68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473813; c=relaxed/simple;
	bh=XpB4sapMEaWdRKAxdjENAq5+BRYXQ90qkIR45TqeilY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KON4vb6hZh5W+GRLH6JcYUdBcwe0qg2hZfbhhrZyzb0GgEAzcFscuHWAD2zE8CusOWcFgai5DDSd26fy3KRInMq5r7ZkjOy/XdapqwuRaYpBj++yidI2+7Inr2moXderAaKXSi6xtyUqrPxUwV4TF6t+h08FF6ts3tbU209TKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsRpJTef; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsRpJTef"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so1751353a91.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 04:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775473811; x=1776078611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIac6Ou4TesFmOZ6i8CaLe998Q+ulUkplCTpXRbszY8=;
        b=HsRpJTefhI1Hynga7eH9g889/zekh1V2l5PVzV/6IU+YTMIfkZeMEk8KnwdHVGsWcW
         d/zecH09IxXyCnw5GIBtCDbIoWI1xwsVCCY9noRyB0tfNISOjLz9Nn28WrGQu5lZ4IQp
         1/7Ed3VMd9h5MKeQ02kgsCesfkdRUivnJTUOuWZSYiGLT3eEIxyqdDVJ3dk7JYNw2asU
         8Lm3tYVJt6vFERJHZ3+nhq1zCqolicvg8cbOT2ZK8aMeW2ooVOK9x8+g1AvdfwWqIa+i
         XNQPuxSg4pNDwX8pjDoLbwVyMt3vQvQF2oGBgQ3sJezts6wydsfN5skY655JqovDAntI
         Hmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775473811; x=1776078611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIac6Ou4TesFmOZ6i8CaLe998Q+ulUkplCTpXRbszY8=;
        b=KWQEFFPIpfSl5t0TkXeVsOzvkKxKj94811RtTqABULzu2PxFmaFEhxQOpHaP5CcMAN
         Lj02LePj/euWUS4kbM3uxozwd0v9KzhUrhGDGqrzH4JrFhC4tx73JIghYWgb8yAfyHbd
         szJZB8VApUNgAXB3r0n2GkJd2rITjp4JRmBLkmFsQVQXBCEXqq8RyO/dS0eD8WSNfdwD
         TJAxPvrlJmmic+0JuvKH46SZoRb4udztu882zxTEq+MRD50YWZ4uu5dBG4YeMplleX3W
         BclQayvISLWA8FnKsAQJercUK4uaZezWGCakHK//iMyPvd1vzr4Emu/4shrNCWLYyLHf
         lbyA==
X-Forwarded-Encrypted: i=1; AJvYcCWcz6KnFVNKluq9Jbea6wLJljpgBhYuWhxWFm3hJYKiV0rICXwGlo/rbFiGXN5I3M8GpOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVdN0SomY7uwdCwHiVRomqgmF8TkI7+I1POg/GHS9Lh7yMQE4
	mgcLKZiH/EwC7Zg3Kvx4XJNx6fdjdt2Ky2K8MI0ptHa57P0RRutDGqAe
X-Gm-Gg: AeBDiesBBR2XGHSCuSE/i8C5rkY2p/kV/8V4bZkw/ISpgGgP2Ozg9TE2ug/3WIcKR1s
	9DkZON8fhheGxpriQLpft6ROfF7A7vNHJ5TSRKmSlrDv6ZUJEFr9AHBMJH3jeh3F/fL5PVsTCTR
	U8kQYjxVdN/s/IzUrA52iAR+ZL989f/S+nfl5De5wF6VTLr77rw7snpYJnc3nMbwCl8TXynaUOc
	kaDWls1PTEh8WsXmB1gcUpKokul64WKbcJiuYoJRNAu6d9Eh2HmSLRZM/2gxub/48wy5mLAW9A0
	73kuuSq1GnYSqd6MIKs5i9O//ur4j+eraDwIoltXYzkK2rEnBPXnUuh9Fc6ZNDJiUhC7ChVpZEY
	TivwrPljlGcibiBFNEPRrsbE9iVaXNP2lbfxjudMn5NDJj9uS3f+rlEOM2x2zSDSgW8c8gxYrzC
	2onIBr6mWQbnuObkp+AO56qVv7ZD06OYlhFz8=
X-Received: by 2002:a17:903:32c3:b0:2ae:5350:3a4e with SMTP id d9443c01a7336-2b2821ca1e7mr104351605ad.21.1775473811462;
        Mon, 06 Apr 2026 04:10:11 -0700 (PDT)
Received: from C6-AF-E1-B8-1C-91 ([223.185.248.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497c117sm132631625ad.40.2026.04.06.04.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 04:10:10 -0700 (PDT)
From: Adith-Joshua <adithalex29@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: john.fastabend@gmail.com,
	martin.lau@linux.dev,
	bpf@vger.kernel.org,
	Adith-Joshua <adithalex29@gmail.com>
Subject: [PATCH] bpf: verifier: restrict insn_array_maps to jump tables
Date: Mon,  6 Apr 2026 16:39:58 +0530
Message-ID: <20260406110958.13434-1-adithalex29@gmail.com>
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

