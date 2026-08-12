Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC7218592
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 22:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573175; cv=none; b=Seki58xgS/R5OK0sJireK7jrz2OFg+QCgyKl6eXdmH2Q1LxG38zyen7pBUfLFNc8Vs3LIt1EKVJ3MUzZLEVZbQRh/o6v9yOTIg9AprMEIo0Q5OapEPYGTCu/IkecPAiV8NfazHjqVf2vIZN6wu7UOyc0SxBj7tcS/ZX3So1ds0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573175; c=relaxed/simple;
	bh=9smPsmNWpLngNejUStT/lpLcMumQouPbVsyd0jNRLYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B25Mbi4TG3W9FcQTAPPS+HSiDTQIIKmDaVbXkcRGa9cHnq3eiTcmJbOGqvFBidmnpbt+CgNoZuuDjiE/S9dUOYF9bxjEsA9HFhUB+G2xO3c7ONY2OXvhACxWOlg/gOIVyT29lQ8w/7QgTm6iJw6gQj9rkgt0W1KJayGtHzxUlYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GofyDYp9; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GofyDYp9"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so325585e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786573172; x=1787177972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0w+DXeHQ+/vxKh8Nma+f/5//oo6s7YwLb7+GH8VJEk=;
        b=GofyDYp99UIzckg/XX0wdzgzxu9Ih09tsDONB9ZUtRhzMh+Wu3+4Mr5uDW0FOg4utE
         UsN7vjJnJec+ThtwyZUG9vv0RegCdElbRTsPtsCXKp/cMmLWrDSzsb0Y3nRY69OQ5IWl
         r8nrBaF/j1vbBI+GgTUDKiYxFbpQTPSYZhJ2eZ8gE5ZzGdcO9veogsXIedtFp/tiwHu+
         5gZUx+PCck8nkwUrcPnUgQ+gc0dtHtca/ScfVkoBmIl0P9GePXToqsXlkdBrDfUklHNB
         dCCSO2NqTSZoBLJEJ/aGvchQoQIJdXY9pb8oRS65LxTgeVyyX8ax4Uv5kYcbCezvIMA1
         rQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786573172; x=1787177972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0w+DXeHQ+/vxKh8Nma+f/5//oo6s7YwLb7+GH8VJEk=;
        b=l/lpKMqt2x1zQfLrAXJSac2DxwHxK/KcP0CNkJwx9wrRF8YMjzjgJdZoglUTHHWk1K
         2YZbaR1lTrvzbOf6wz8MQeEmIvjWnijzbLW9zvpnyZ0hqgWC3QN1OAJfxG84zqwYcJ+F
         wJ4nx9dlOx+8Yl9Luc9R492UisGAifO41bgfwDAkEyyMx+Kz+G+8nvRxaQai8PQfqRGN
         W1pwZNTc2N/FKP18WLY/va6dWte7R2r6N1hlu/dxn2wJFgQttY7wi+sGjCkXIXBfl0BL
         uWpRi2rr+7pXIZis6pxmoVjUGB9MeA5vYcmffkxZz5lBvsqkvTy1hJaKcHT+NPxcPX/I
         rFPg==
X-Gm-Message-State: AOJu0Yy28A0hUhdoQktsmk11NIir+DkSjJqcbl5HeH1xmu62pG6OrL6I
	P/rV6RA6vRUirZ6GXIC5kG8gA+M+l9UrMhVPPwFdUsqTVJhEB3xPcHBfeAZCplmE
X-Gm-Gg: AR+sD12ondmjKwli6OPOj9JafkUivlynChHv1wmkgSD+tYnhWnCZry7Z9xIvgcgwmG9
	vO3A18Ilvi+FpM/NJcXufqD0KRyneQr95DZmYkdxj2dS++UG7D/pqwLVstSvsVYTul9+COrR2TV
	+7v6Pr3LIBv734QqFjcQVxAyfOD7JLQvVQWfD1kXihawRZIp/NU7bhlEJ5qL2Rwe/du6AJa65Wo
	tChY/UUYH8fMI4C13k4IjFwgqivU2RFH3v03Px5wfMR8O5nu1jKMV5BXPjiOUngTT/rCkYDkMmw
	0eWgAg+9aBQGF7uTGDM1GhcNLhHsZAla0b6JxQOg76VVwQC24n8qJMccMPBMua6InZe3NgNvTsi
	8GLyknywQPPb1YZhEOlI204ha/RkyvnNL4sL9lnWLvuFNE+A912T48JQH1QZtJXRjeGbB21afcc
	lP1VyavPVq2t8Lt+34YtBdTeF9BruzfMc/X/EQKVtqv/A1Ltyq/lDYFiRXcxetdcCfIQUpBqWzZ
	KSRWVrKuJ5AwsIPMUhZMASb7JmjVIY2FyH5DFSKIcM5OnJv+lLju5fzxHFNuSeozGQo/dTURgAi
	b9Y3JfTkX6UIjJyMdPKNVR4BZPQ=
X-Received: by 2002:a05:600c:6287:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-499821845d2mr9562385e9.10.1786573171638;
        Wed, 12 Aug 2026 15:19:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981de6a05sm26543055e9.1.2026.08.12.15.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:19:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v8 4/6] selftests/bpf: Adjust veristat stack depth parsing
Date: Thu, 13 Aug 2026 00:19:21 +0200
Message-ID: <20260812221925.3358041-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812221925.3358041-1-memxor@gmail.com>
References: <20260812221925.3358041-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2922; i=memxor@gmail.com; h=from:subject; bh=9smPsmNWpLngNejUStT/lpLcMumQouPbVsyd0jNRLYg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavmw88nyaW/pOyYgzilD7G+fmD6RTv2xtsAd/afJXYXw 69cUX/YUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgImIbmdkeHN12vFUmY3dl3fH FB013MK4ZK7gjPKCO/fP7K4I/zft9BOGfzbNnmIa7z8p9Ll1L+Tf0Wk53STs15x7c3Yds7fOt59 RwwsA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier now reports instruction and stack depth statistics using
uniform "subprog <id> (<name>) <kind>" records. Subprogram 0 is classified
as main, while other records are global or static. Each record carries
insns_self, insns_total, and stack depth.

Teach veristat to parse the new records while retaining support for the
legacy one-line stack depth format used by older kernels. Skip both
instruction counts and match only through the stack value so fields can
still be appended without breaking parsing.

Increase the bounded backward scan so it can include all 256 per-subprogram
records.

Zero-initialize the legacy stack buffer because logs using the new format do
not populate it before the trailing tokenizer loop. This makes the loop see
an empty string instead of reading uninitialized data.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index c9c257784ee3..5c0ec3edce72 100644
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
 
@@ -1025,11 +1027,24 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 				&s->stats[MARK_READ_MAX_LEN]))
 			continue;
 
+		/*
+		 * New kernels emit one "subprog <id> (<name>) <kind>" record
+		 * per subprogram with the stack depth at the end, while old
+		 * kernels emit a single "stack depth <a+...+n> max <max>"
+		 * line. Match both formats so veristat works against either
+		 * kernel.
+		 */
+		if (sscanf(cur, "stack depth max %ld", &s->stats[MAX_STACK]) == 1)
+			continue;
+		if (sscanf(cur, "subprog %*d %*s %*s insns_self %*d insns_total %*d stack %ld", &sub_stack) == 1) {
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

