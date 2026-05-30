Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E21F3B87
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100590; cv=none; b=fDOVE8ky646IunjXFdHv63GRX3B/YWXPDzBPcP1CZRt7JBbD6i0d1xsIFVkgbk896m/8O2C857mXNybDBTRpaWgPZmdcD4fcQCbOmXdZSVc9KjE357+76zEzePSNvBrkrWxabVHuPkvJxKhOyUqS5kcUq3DT3Ww5KydnzFKBfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100590; c=relaxed/simple;
	bh=Lx4c9V5/QvYf/N2reFs933ZtfUWinQFdNJ/WSKGCf7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7AykMR0sgHRAOPDEUxRqPUtcD68hwxYzqQ2qYgwJVxPqmxk7ZT0GqV09xRpoBJgxoLV1UnJ/zYYvc8nwppHoNR/Kf18hf3oP4i+rAyQtup+k94EPAW304IBPWSui8wZsPj6OZxJkVpV1FEETAo98dawnodgnrbkHW5x+x87g7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=eeZ2qum4; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="eeZ2qum4"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-132830d8281so3336049c88.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780100588; x=1780705388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm4vR0bSmWs0T1cZkadLVTgEEdKxDPIOmjQ7Aijkq3E=;
        b=eeZ2qum4bwtFMVS5eQjRBvgWhz2BbzZiEelkb1jM8pnSevWpHnf3iwoNMVKwKLHKE4
         ayFd5QgXC4SQEftN9ClIfkKpt4Bn2tdYPzdDjJLv2wiIXKFaxT1/4JQvQ8Jwkpod0GPX
         xC8Uxd4ZioGNfOY8aJYpdMg3Bg0cDOuDWFrow9jr/UFAlI5yDmt9GvoHKz0BvZ8jm8D6
         Od7G44xISDHiUaLR0Ol1zp6zeWrK8XkyxPKcrJOoIpx4wPO8XTv93yZMIq9nrkKSbE6t
         Ra8mhlWhYs1p9z6E8Li9I1yspRDzhrSvA+aLgoCZcI5iSD5JNv9thCyjHPPVOFvwIIhD
         PoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100588; x=1780705388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vm4vR0bSmWs0T1cZkadLVTgEEdKxDPIOmjQ7Aijkq3E=;
        b=nbfDDgJsgLbxyidtUUGMvbAN5ZxNq79vWuQORexr1+KDQ8m03iHbtcWD771uyrPrkr
         Ntwfq8+VonmVmNaiiDLOjAnZYWVVvGwt5tJSmTDsjeN9fyEvlmMrLM73zK8FncSfFU4w
         MS/EigC0yq8+xiEnaeGZ3x/1/MFpxJYxm/BzNZB5cBVwHV+Nxrwvmx1B+zwUW5NvzbFd
         GnWlmUIwEoRZT8fTmiC87llLxXYhpGQPZ011cdfTlqz/Kff6MtD3tzq2VECs3+0q60dR
         000nowtuaWA9zBmnUeXYoaUJrnzldIu2rZ7L/B+qmsfTgO82CKpo5oaNvc1Eb7PlB5ra
         0N9Q==
X-Gm-Message-State: AOJu0YyMzKWDQeZzMKJUSsGdvsDBNunRRo0LTpMpRjmMKDyg5a8F4rb1
	F5Fj7SSwgQM4TgpQdQXCGzP5h5sS7xcdbjvGL906DgE7b+GJpLHuMb9mD+eyGwJiWtc4+xpRtYg
	DJ8TJ3gmO30lS
X-Gm-Gg: Acq92OHGm0Ws9vWAIgaivxvhu3RjvWmkY6a7ztDS5eHzWjv5h4T8v6a1aRqZlfP8kp1
	WzKgPQJ9TdhJYBBxBQaB8rIoGvIdqo+l9kIOBXgoIoE/3RQjtBm31Ghh7iXD7pQBQ+3g2g2MPUF
	8pdgbSFWyjATMhhDyHutDL1m31WY50AuKxuL5MCMf6X10PlIZ3ym2pIcLLr9RjS2GnkosjqV690
	q9RtTZmlXSL5kLdP7wyzEK3rAmOK3vVvLZcu9BIFyRs8GoDixxMqnAa6CZtIfDRXdQZeicGVqX1
	lfQgueootZYdoBsRrwtXuZoAPm7NzamINzVybANJfDz2FExgq+0Ximo8yp1lVkQoz8PhCdLMqoN
	utUfT1AlGLlelDmv2nsnkFTxfUdM8na7o2FW3jh3auMf9iLHFndcjlfoqgvU+IoGVzoRiILYiLh
	haW2BemSLcMSY4/UexOYn7yxnHnzHahg==
X-Received: by 2002:a05:7022:527:b0:135:dc82:85f7 with SMTP id a92af1059eb24-137d3f1860fmr842978c88.4.1780100588407;
        Fri, 29 May 2026 17:23:08 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::9529])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b35a5f44sm2070540c88.1.2026.05.29.17.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:23:07 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 2/5] verifier: parse BTF type tags for function arguments
Date: Fri, 29 May 2026 20:22:56 -0400
Message-ID: <20260530002259.4505-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530002259.4505-1-emil@etsalapatis.com>
References: <20260530002259.4505-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BTF parsing logic for function arguments goes through
the arguments' decl tags, but does not go into their type
tags. Add type tag parsing for function arguments.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/btf.c | 120 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 85 insertions(+), 35 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 17d4ab0a8206..c6a930aca67e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7802,6 +7802,84 @@ enum btf_arg_tag {
 	ARG_TAG_ARENA	  = BIT_ULL(5),
 };
 
+static int btf_scan_decl_tags(struct bpf_verifier_env *env,
+			      const struct btf *btf,
+			      const struct btf_type *fn_t,
+			      u32 arg_idx, bool is_global, u32 *tags)
+{
+	int id = btf_named_start_id(btf, false) - 1;
+
+	/*
+	 * The 'arg:<tag>' decl_tag takes precedence over the derivation
+	 * of the register type from the BTF type itself.
+	 */
+	while ((id = btf_find_next_decl_tag(btf, fn_t, arg_idx, "arg:", id)) > 0) {
+		const struct btf_type *tag_t = btf_type_by_id(btf, id);
+		const char *tag = __btf_name_by_offset(btf, tag_t->name_off) + 4;
+
+		/* disallow arg tags in static subprogs */
+		if (!is_global) {
+			bpf_log(&env->log,
+				"arg#%d type tag is not supported in static functions\n",
+				arg_idx);
+			return -EOPNOTSUPP;
+		}
+
+		if (strcmp(tag, "ctx") == 0) {
+			*tags |= ARG_TAG_CTX;
+		} else if (strcmp(tag, "trusted") == 0) {
+			*tags |= ARG_TAG_TRUSTED;
+		} else if (strcmp(tag, "untrusted") == 0) {
+			*tags |= ARG_TAG_UNTRUSTED;
+		} else if (strcmp(tag, "nonnull") == 0) {
+			*tags |= ARG_TAG_NONNULL;
+		} else if (strcmp(tag, "nullable") == 0) {
+			*tags |= ARG_TAG_NULLABLE;
+		} else if (strcmp(tag, "arena") == 0) {
+			*tags |= ARG_TAG_ARENA;
+		} else {
+			bpf_log(&env->log, "arg#%d has unsupported set of tags\n", arg_idx);
+			return -EOPNOTSUPP;
+		}
+	}
+	if (id != -ENOENT) {
+		bpf_log(&env->log, "arg#%d type tag fetching failure: %d\n", arg_idx, id);
+		return id;
+	}
+
+	return 0;
+}
+
+static int btf_scan_type_tags(struct bpf_verifier_env *env,
+			      const struct btf *btf, u32 type_id,
+			      u32 *tags)
+{
+	const struct btf_type *t;
+
+	/* Find the first pointer type in the chain. */
+	t = btf_type_skip_modifiers(btf, type_id, NULL);
+	if (!t || !btf_type_is_ptr(t))
+		return 0;
+
+	/* We got a pointer, get all associated type tags. */
+	t = btf_type_by_id(btf, t->type);
+	while (t && btf_type_is_type_tag(t)) {
+		const char *tag = __btf_name_by_offset(btf, t->name_off);
+
+		if (strcmp(tag, "arena") == 0) {
+			*tags |= ARG_TAG_ARENA;
+		} else {
+			bpf_log(&env->log, "function signature member has unsupported type tag '%s'\n",
+				tag);
+			return -EOPNOTSUPP;
+		}
+
+		t = btf_type_by_id(btf, t->type);
+	}
+
+	return 0;
+}
+
 /* Process BTF of a function to produce high-level expectation of function
  * arguments (like ARG_PTR_TO_CTX, or ARG_PTR_TO_MEM, etc). This information
  * is cached in subprog info for reuse.
@@ -7820,6 +7898,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	struct btf *btf = prog->aux->btf;
 	const struct btf_param *args;
 	const struct btf_type *t, *ref_t, *fn_t;
+	int err;
 	u32 i, nargs, btf_id;
 	const char *tname;
 
@@ -7903,42 +7982,13 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	 */
 	for (i = 0; i < nargs; i++) {
 		u32 tags = 0;
-		int id = btf_named_start_id(btf, false) - 1;
-
-		/* 'arg:<tag>' decl_tag takes precedence over derivation of
-		 * register type from BTF type itself
-		 */
-		while ((id = btf_find_next_decl_tag(btf, fn_t, i, "arg:", id)) > 0) {
-			const struct btf_type *tag_t = btf_type_by_id(btf, id);
-			const char *tag = __btf_name_by_offset(btf, tag_t->name_off) + 4;
-
-			/* disallow arg tags in static subprogs */
-			if (!is_global) {
-				bpf_log(log, "arg#%d type tag is not supported in static functions\n", i);
-				return -EOPNOTSUPP;
-			}
+		err = btf_scan_decl_tags(env, btf, fn_t, i, is_global, &tags);
+		if (err)
+			return err;
 
-			if (strcmp(tag, "ctx") == 0) {
-				tags |= ARG_TAG_CTX;
-			} else if (strcmp(tag, "trusted") == 0) {
-				tags |= ARG_TAG_TRUSTED;
-			} else if (strcmp(tag, "untrusted") == 0) {
-				tags |= ARG_TAG_UNTRUSTED;
-			} else if (strcmp(tag, "nonnull") == 0) {
-				tags |= ARG_TAG_NONNULL;
-			} else if (strcmp(tag, "nullable") == 0) {
-				tags |= ARG_TAG_NULLABLE;
-			} else if (strcmp(tag, "arena") == 0) {
-				tags |= ARG_TAG_ARENA;
-			} else {
-				bpf_log(log, "arg#%d has unsupported set of tags\n", i);
-				return -EOPNOTSUPP;
-			}
-		}
-		if (id != -ENOENT) {
-			bpf_log(log, "arg#%d type tag fetching failure: %d\n", i, id);
-			return id;
-		}
+		err = btf_scan_type_tags(env, btf, args[i].type, &tags);
+		if (err)
+			return err;
 
 		t = btf_type_by_id(btf, args[i].type);
 		while (btf_type_is_modifier(t))
-- 
2.54.0

