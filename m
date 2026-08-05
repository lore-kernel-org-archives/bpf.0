Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D502F7EF6
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892525; cv=none; b=EemzCiY/U+Lt190npK7uG7/0eP7X5vlEM+0KJT2wBP0uo+RvpvcngtaZmW6BsH1cc20BmAlxVfVRkGOj+yk3T8dalIgA7MPpVTPeFeuYcSAhLgXLgJ7V8v7B9Asxkr5j9Ep3jD/jussj8htFw+GNAt3MAlrJiaAIiv63w3O39QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892525; c=relaxed/simple;
	bh=ouzw1/1tHbGnzKlD+RVKTtGeUW0cAclMCgSzOWhoW7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJNigvmzmrxhNZj2116flaYy5egk9CNROaFRzrOmL/TYViOsr/lQ24dzTHKuOeXnlWrmmw/gHxmEKeA+L6PC2DbvSqnNgOWRcTkilMKfw0mna8f+iCoyrbP9HU8knHERgEW73uBg66EQ70lnEpC6PYHtD5hy1yPNaxzstxPbcMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA7nAnHa; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA7nAnHa"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so85812f8f.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 18:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785892522; x=1786497322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wE0pxzSZgyl4elg5np7mGNBSkehaKoNBf2eYT6D2Tp4=;
        b=VA7nAnHav66Jc08PegtOnkB1TqP52bJEujOXyyT5rU/yRL/jOsjx3+kWAV6mMhnmQ4
         J/9y54DoKhNSokk+khwhsxnPbNIrRAeCG+IfKpYyYpAugUi4Ix3xWRGaI0nbv5b9NxYf
         BSQo0hoy72vu6lPikUsA7IqOloNWzknJQUkhCnbAwBkNScsOGvCT8W6bbTggwESt/XCy
         t0vE17Xg3ekD63lbuZR5aT1mCpH1IeJoCYb6jTfxrlKnhiRXDaX9VIgzX/2fhpke+iSG
         uwB5FIqCsyrPbWiePboie/taxrAGrIXECT082rA4+EzaTPsVEBqpYqJ/SxIE6spoQHuU
         MjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785892522; x=1786497322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wE0pxzSZgyl4elg5np7mGNBSkehaKoNBf2eYT6D2Tp4=;
        b=qVj7QP/7D4eVam9+mHue6u925UA5CU0Ezji03P1RRubqJqHD6Rw4guxc9zze63nAfq
         NMYnazMr3Yo1rnJ8/LFXcoPzrThbAw7Auanbn6Q1GJf/TBAIcA4aqnCMWaKFt7l+357e
         cQnDMG23S/LAWoFUhyFo2xNMezFRrYvAPH81fp0evl7Sx4meEuM3WUpc/BFJcI7widxl
         Bh9wugPfmBIfOqFPE365ka0nq42KsZJOLfhYUPAMkkMXhJLqOVI6nCpMj75W6Un7PRcp
         A+jMUpnnqfu8BqIye2BkRCSUt03X5/esPWPN6YwnFNbX9qXMatFCVG1BFRPBOKa3oXUC
         IFNQ==
X-Gm-Message-State: AOJu0YxPQTtsFOBJinAkES5Yaxz8WUHM8B1kRMWztuTal+HD0f0lXTbE
	tG0L48FZO2RZH0OwvVMmnPg8cf2iMme2rh11ZJ0MZGavkCD+vnr6BeNvAwg9LO7P
X-Gm-Gg: AR+sD127/F9zTCDEz8hq2pCjRI3EFUl4w02zPHao/iXzkWhO2lkKRoKDCk/dko5jG0Q
	yY5r48XZE5EdAXLqkQVq4ucWNiim8iFIu1GZ26VraBlSfa+JATq9gQwxTxIFi97iFXqonVGnS86
	mItK/1lsGYJ4J8cxveC+5n0FiHI+kzGGHp3t9KFD4MGlM5QSjrm/DqFI0mAOnD+teWRA9efrzjA
	J1txrdgRUmmBgeJYeMymaAcJK+TAofW56iq1+Vpr9JJHGOYMVS104quHu1Wftzstr/26LOXb0Xl
	WVJTHNl+xAJkAF39otWJwBC6NpS4F3yFmFGl4vVCqxQyA7PNB7Micsq4CgEDbSsbAzVgkaZLEt9
	cYT+THZXoAjVroBLbR5OZQdR3Gw8H3WzEfw0NPY6Dz42fZlqLXDr4ot4gRk2FaE/oLs7lsIyF9+
	TTKmJNzv7ZNpFWIcD2+FnP2sXy2T7HJdKfRn2Rg7BZPpkS6kZJKmtkTSmHux78KQb8zNc2iWRDl
	pUemDQbtV3ywdnMCw35cVyBV2NavyNffObru6wQ9SEEVRaKwkkCBsf2mW3SlcGR3IH8cQXxUGhJ
	255H8l8P0L7s+Xhhkdi3HCTZaW27TZyxd6CNnQ==
X-Received: by 2002:a05:600c:840f:b0:493:bd2a:93bb with SMTP id 5b1f17b1804b1-4994e7111e4mr26226105e9.3.1785892522318;
        Tue, 04 Aug 2026 18:15:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfda0cbsm4278451f8f.6.2026.08.04.18.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:15:22 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 4/6] selftests/bpf: Adjust veristat stack depth parsing
Date: Wed,  5 Aug 2026 03:15:12 +0200
Message-ID: <20260805011517.1717238-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805011517.1717238-1-memxor@gmail.com>
References: <20260805011517.1717238-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=memxor@gmail.com; h=from:subject; bh=ouzw1/1tHbGnzKlD+RVKTtGeUW0cAclMCgSzOWhoW7w=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauoz3XKjN25ltapa3Ou5AlPcQ9xuKTOOu/r7TtO11hU/ B65PXvbUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlciGVkmLBB97LbHpnbue/m eeoqy9z9tKX+TFJUq0rq9Mm8h9wZWRn+l4Y+KcpJZ0g7YNwpfW4Vh+H/t1/KGOStHh3Zqd4TmWj DBQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier now reports instruction and stack depth statistics using
uniform "subprog <id> (<name>) <kind>" records. Subprogram 0 is
classified as main, while other records are global or static. Each record
carries insns_own, insns_total, and stack depth.

Teach veristat to parse the new records while retaining support for the
legacy one-line stack depth format used by older kernels. Skip both
instruction counts and match only through the stack value so fields can
still be appended without breaking parsing.

Increase the bounded backward scan so it can include all 256
per-subprogram records.

Zero-initialize the legacy stack buffer because logs using the new
format do not populate it before the trailing tokenizer loop. This makes
the loop see an empty string instead of reading uninitialized data.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index c9c257784ee3..8dcc5c50d311 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -993,13 +993,15 @@ static void free_verif_stats(struct verif_stats *stats, size_t stat_cnt)
 
 static char verif_log_buf[64 * 1024];
 
-#define MAX_PARSED_LOG_LINES 100
+/* Keep room for all 256 subprogram records and trailing statistics. */
+#define MAX_PARSED_LOG_LINES 300
 
 static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *s)
 {
 	const char *cur;
-	int pos, lines, sub_stack, cnt = 0;
-	char *state = NULL, *token, stack[512];
+	long sub_stack;
+	int pos, lines, cnt = 0;
+	char *state = NULL, *token, stack[512] = {};
 
 	buf[buf_sz - 1] = '\0';
 
@@ -1025,11 +1027,17 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 				&s->stats[MARK_READ_MAX_LEN]))
 			continue;
 
+		if (1 == sscanf(cur, "stack depth max %ld", &s->stats[MAX_STACK]))
+			continue;
+		if (1 == sscanf(cur, "subprog %*d %*s %*s insns_own %*d insns_total %*d stack %ld", &sub_stack)) {
+			s->stats[STACK] += sub_stack;
+			continue;
+		}
 		if (2 == sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[MAX_STACK]))
 			continue;
 	}
 	while ((token = strtok_r(cnt++ ? NULL : stack, "+", &state))) {
-		if (sscanf(token, "%d", &sub_stack) == 0)
+		if (sscanf(token, "%ld", &sub_stack) == 0)
 			break;
 		s->stats[STACK] += sub_stack;
 	}
-- 
2.53.0

