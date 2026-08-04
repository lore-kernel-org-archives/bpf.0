Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F794427F8E
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831082; cv=none; b=B0+0fYi9pzf7h+IWsdmc0Yz7gcvBMz7lAoPVMZIUqrT970Eltynus3/LC3tRzaYaVGG4hUhiVH9UFq3ssuxQFKQxyjVEvViTgqW37ss+aZcaMwkQF68GMBL69ref1vuv/OmF+dOudLGHmHJu3iedWcicl8mAtK/FJxkLizcSoHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831082; c=relaxed/simple;
	bh=cuvzTR/LMiH/B3y/0s3joPV62K9l9J7qztltyBCb77s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iophAQuBigwV2dkTKibG8qKf57m69Is/nJ8S/u8SdwbyZSKxM4rFHvfcLaYGDVN3tDfXECuClRkQ4ZCyF8ONWx1/eS6VVpGix5taLeoo3wg48X2+8T9BwXXJQe2QBxoQDbJkeFChWeG1w4Z728fMS6f61j1V5MwAIoSu9CbkknU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3raSBPg; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3raSBPg"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-4700bd8aed1so370552f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 01:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785831079; x=1786435879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//uMpqmfb+KEfjMXQ+RP4zFNF4W+IxnnR4GUT+DpYGg=;
        b=Z3raSBPgV9mVyeG2yxKPPmYQ7gWg1RhN80dAW3CZT40Nsrt0j/hTVSrkU9+u4V9+Hy
         rhLYeez7K9fbiHETB6uyzhgs8mMV2CHK88IeLCTM7M43eNwzcxtW6CU0YgWoe1ulXQwZ
         Dkbi/YPYuSXZbbJjMBC/HcSAIsb+rbodA6FWtIvVji5FjLkDE/Na7J6k8rpQqPuZtKtH
         4TVV8Cqh/VrxplP9Ji1hzmqGw1Oij0Xisz20oFaI5WOGWbP9RKrMugjFDV2Q37hSB/9H
         vlTF/sntmdYGrGftKW4CfoVJfRz1YE8N8tqPVZ0Y+e56ofWJ8FoXnvpGH7F0rJdA1OfT
         n/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785831079; x=1786435879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=//uMpqmfb+KEfjMXQ+RP4zFNF4W+IxnnR4GUT+DpYGg=;
        b=AAgA+8oVgdoJp3szZk1f6wrcZvZCSII79pxUm/lFt1mOXzreiEb2ppldrJhmCDvkJK
         ukIgmTZAqjkPg3vgFtZvVVy0yINkzXjWQQxnbAmTmFh2tU96aJVUyj45N7RsJs+GrXQi
         a51zBiER4B8i7BLCdiSWc85sYuxdZiCkj/Hc4HEi7uJ7rWtCm+RQWo/BvrklRoml9wHG
         WJrXJYvN9II+3AHgH0E6v7fLKnhU7WDH7624zY6i0oHECrHOWqkR5bsTUOggYEfsYQb2
         juvc48FQUyi1Y31aJveldYkpmMYLSGckJnJCY0Qt6mwhkO6nn1FOisr6y+uzuflL8Rea
         F2xw==
X-Gm-Message-State: AOJu0Ywa75DIL9n2uYGIF830yqyVZczPrwc5mlAG92Bnod9z1QRnTCS1
	X+AhsQ1qkJOFrp7lvpaYTF9SKyPO5Ci6DPCFlPg+8NiVrYwq2tWxyEJCAU/iB0hJ
X-Gm-Gg: AR+sD11jEsXboJN0esqjz3bJZAAmqZo5DrG2QduITZUcQWAtAWv1toeLuugObC3IKWv
	dk4Nz1p0JfmqALVDxRxeqJAi578Db5JaHwPqa0KYRbi7JVAs3EJESt8wrQiLDMZFzFv5lWSIszs
	QPbW5Hp4qZyLvlqkAfWoMmAf/SesdIvj62rvmRRYU/UKD0noMqmqK5B+mIGPskNaq56zNW34tJD
	/hsfw7GsCeNx69FhT3tVLNxzV4e35LkvHIy2NhQb9GkV5KoRshu6aTMbs441SR2PSZ70F3x6vN3
	TrtZmw2a4PCyaRIJQ1utGAjaJ4AF8dm1zpbSHa2ACVriOnNz9VVt1ZrBzybtjeKJH/CshJQFXOA
	c5M1pwGTTmmteU69X2yuzgnWP5Bwd+xztM0Vdw3HNMyhPQsySxGwY1iJmXkpYWX9dB0nvo1b/4E
	GiV2wRSTcdKahGAXV58awwzUb/eXR9BUnpHpPxqcf+NjX2JLQlPNujkG10NylECMZuMqLeNH6GO
	fgoimNiYeFvKU8Nnvb7VuuTs0q+39ht+U/XasG9QN54WvR8C/I/36NnpRo2/DWZ2k8Grt5VbfXU
	xnt6FXRWyAr9wv5ktvQExCBlk+o=
X-Received: by 2002:a05:6000:1182:b0:47f:8603:a879 with SMTP id ffacd0b85a97d-47fe81b68camr5073830f8f.11.1785831077740;
        Tue, 04 Aug 2026 01:11:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fe9a3f516sm2642471f8f.17.2026.08.04.01.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:11:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 2/3] selftests/bpf: Adjust veristat stack depth parsing
Date: Tue,  4 Aug 2026 10:11:11 +0200
Message-ID: <20260804081114.3871564-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804081114.3871564-1-memxor@gmail.com>
References: <20260804081114.3871564-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2451; i=memxor@gmail.com; h=from:subject; bh=cuvzTR/LMiH/B3y/0s3joPV62K9l9J7qztltyBCb77s=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatwnu/z6hsz7wcXLJhQfl3C4UjGeZGOzafuS+4Iebvgb JtVZUFtRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbiw8HwV2gL2xnXGbsb/n4L FpyW8W73Ld/9YpaPrpyrrv+3Oft++AqGf7adTBkKb1rLLWZzzVAVK/o77+LjiUIHDosU3Gt/9mr PFF4A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier now reports instruction and stack depth statistics using one
record per program. Teach veristat to parse the new prog and subprog records
while retaining support for the legacy one-line stack depth format used by
older kernels. Match only through the stack value so that additional fields
can be appended without breaking parsing.

Increase the bounded backward scan so it can include all 256 per-subprogram
records.

Zero-initialize the legacy stack buffer because logs using the new format do
not populate it before the trailing tokenizer loop. This makes the loop see
an empty string instead of reading uninitialized data.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index c9c257784ee3..92424771679f 100644
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
 
@@ -1025,11 +1027,18 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 				&s->stats[MARK_READ_MAX_LEN]))
 			continue;
 
+		if (1 == sscanf(cur, "stack depth max %ld", &s->stats[MAX_STACK]))
+			continue;
+		if (1 == sscanf(cur, "prog %*s insns %*d stack %ld", &sub_stack) ||
+		    1 == sscanf(cur, "subprog %*d %*s insns %*d stack %ld", &sub_stack)) {
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

