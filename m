Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CB52D47E9
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264597; cv=none; b=fV8+Tihie2uY1//eCxEDM8JRd6zctwkw20IA991sZZkIL2qbR4E0jUwxRUSgtW7+BAcajnpjoiQNueNCZ7evybEq4lgwqJTiG/xs8wdFFpfcwSyQ2Am3FV9AD9aSoi6Ipymr3NSZM2zMFVjYH+P1vRprF7qGBzCbpRHcoQcTUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264597; c=relaxed/simple;
	bh=ihh513US5oT90bHSPr+duwI7EZJMh9DRh5PJa5TNNSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ruyekllVUoVJQN/ma8R4muvFfvGstR4Hp9Gr10oAYpykIIkhsrakd8NinJs5AHDCJ4Tr9o3J2jdf57JYWVS6R0SmG0US6GJQ47qW2XQeFCFhbzu2iQn87KBTIdTIDsAWPjvExkHPVPeqhuBKD/375n/OQoPendX0CIYCpqZJN+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHxobhLW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHxobhLW"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a041eae5so51420975e9.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264594; x=1776869394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E70ZMBWJZhK85obAHiuHYPey5rQME57o4kDe3vEnRuA=;
        b=aHxobhLWR9vz0J9z76U2aM3rZCDcWYUhCNsD7JdGqGLHA2WFKKNVJWC4NWg4ojXtJf
         teDLMsAros5IWJG8ePL94Q6Ccwg3YrKX6Z3oWBBvmPdWcF/7IhIOcKLBNgYVZV1FIt1Q
         HQ9Rpt9k7uRF8w6by9ZBTKIsHteHuSHol12EQnDkCgPJFFiY/3JpZX8PHyR8CJbHb8qz
         sBnXvu7fexmqHhJagngBPWboG73cg5Zc6BVFM011v8QvvF/GVWTGrr+oHLcNTsKSFL+D
         UfwUKCLgiqERW10AbtsslFFyVe5mC+p2d6lMkqXmHz7YUwh95Vtu04zBfAWhqdNZ43d+
         zrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264594; x=1776869394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E70ZMBWJZhK85obAHiuHYPey5rQME57o4kDe3vEnRuA=;
        b=Bi4UDzM0J2WG+RzGqScM0YI5e8iM2C2hm8m6OC5xpjwjYGF89Qmtr5woZgIxLtkc1R
         SvdPxflFQGn9kcpJkpkstbdHMpDvulRwe/YXVNomkKkYgGSh1mHA13qjGzaQRJqrRKX7
         0l1jXNfxdH4lrnepjUT2KTfjSqptgzChfq0q7BfRHIM+iaTadVx/AfKfYESvCyc7jn/y
         mf2vOam4Ss8/BjF2d/BNItK0e2VpMheB9ReYwc0dDVBJUzwdeQnjAYsQ2Z3mrNiK3Qq2
         MJm8Dbb2OR4UWwzbXuKUWIfljNm3qoubeLiNM0gwCz1CMITlxPvcrCEcH327dB5sosr0
         4XTw==
X-Gm-Message-State: AOJu0Yy99HSVvTdZxynWBCOustQKrgE6ngJ3IgowjPuUvdPwO5Iq8AK1
	ymq4yS9Y76mL1MtpVqTCI6AFtMidS+ndrlR2pPmh97400eE1ulswz10OcD6ZTepx12Y=
X-Gm-Gg: AeBDieuGPhlXYYlJzS2+SgDaVF8GFZNwSPJ1ndevzLFQ7Znb0lw7TbisGByEzaEU/XG
	HsPdDIm5Yuf6XOzq+xMFitn3b6SOqBfnCEOpQyhdCHflZPAU/qVtjK5Chxcy7LdCqoGIaF0GWb5
	V4QdgWdwuNoDBDUgzk91QfmdBXXyD8P8mWGWkT5UyoSUwUk29dDq2+Oy5BMXFHgQm88xyH1l9MZ
	SQ6EJqYTHOxQaQ1v4zRLh9G5NU8gKGpPkPGqB9BkUZdSzLcgDI/bhsn0T+gVkYZVPSscsmb+VP6
	AtK/At+JeMHTGMqQcAmKTFlGr38jL6TzwpxWkysSZ+85oOpgel1iDOdH3tMJTQ8OTI+Yps1PbIU
	s6royKGV2RbdV0hu5lplJ0NmziDmNy4EwRb/u5EAP6JG48gM6WfzIeDB+tCCtNhYAJcvhYnrYdg
	UN1vOuguGtRhkETQ==
X-Received: by 2002:a05:600c:8284:b0:488:d228:a133 with SMTP id 5b1f17b1804b1-488d683d280mr290017415e9.14.1776264594389;
        Wed, 15 Apr 2026 07:49:54 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:75::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f1dee8a2sm57073425e9.7.2026.04.15.07.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:49:53 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 15 Apr 2026 07:49:07 -0700
Subject: [PATCH bpf-next v10 5/6] libbpf: Add section handlers for
 sleepable tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-sleepable_tracepoints-v10-5-161f40b33dd7@meta.com>
References: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
In-Reply-To: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776264581; l=5451;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=eTmcNq5RXaU3EYYP4gEwQn3tpJBjYybUFzPxvv/9sZ0=;
 b=H3whpYFVnj0Q2jsopBiJBUAxHjiMj0paglQVGqAwBcYi55qlf7j/NFdXMD+OjvRvuAAS+sMVq
 GQlE0L89BYXDD6aKeMKs3YSz0a8vOUzMLRvT/+Aap5U1hwvCqo3LItX
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add SEC_DEF entries for sleepable tracepoint variants:
  - "tp_btf.s+"     for sleepable BTF-based raw tracepoints
  - "raw_tp.s+"     for sleepable raw tracepoints
  - "raw_tracepoint.s+" (alias)
  - "tp.s+"         for sleepable classic tracepoints
  - "tracepoint.s+" (alias)

Extract sec_name_match_prefix() to share the prefix matching logic
between attach_tp() and attach_raw_tp(), eliminating duplicated
loops and hardcoded strcmp() checks for bare section names.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 88 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8b0c3246097f..f3faf42995c7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10017,11 +10017,16 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("netkit/peer",		SCHED_CLS, BPF_NETKIT_PEER, SEC_NONE),
 	SEC_DEF("tracepoint+",		TRACEPOINT, 0, SEC_NONE, attach_tp),
 	SEC_DEF("tp+",			TRACEPOINT, 0, SEC_NONE, attach_tp),
+	SEC_DEF("tracepoint.s+",	TRACEPOINT, 0, SEC_SLEEPABLE, attach_tp),
+	SEC_DEF("tp.s+",		TRACEPOINT, 0, SEC_SLEEPABLE, attach_tp),
 	SEC_DEF("raw_tracepoint+",	RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
 	SEC_DEF("raw_tp+",		RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
+	SEC_DEF("raw_tracepoint.s+",	RAW_TRACEPOINT, 0, SEC_SLEEPABLE, attach_raw_tp),
+	SEC_DEF("raw_tp.s+",		RAW_TRACEPOINT, 0, SEC_SLEEPABLE, attach_raw_tp),
 	SEC_DEF("raw_tracepoint.w+",	RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
 	SEC_DEF("raw_tp.w+",		RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
 	SEC_DEF("tp_btf+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("tp_btf.s+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fentry+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fmod_ret+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fexit+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF, attach_trace),
@@ -13144,25 +13149,61 @@ struct bpf_link *bpf_program__attach_tracepoint(const struct bpf_program *prog,
 	return bpf_program__attach_tracepoint_opts(prog, tp_category, tp_name, NULL);
 }
 
+/*
+ * Match section name against a prefix array. Returns pointer past
+ * "prefix/" on match, empty string for bare sections (exact prefix
+ * match), or NULL if no prefix matches.
+ */
+static const char *sec_name_match_prefix(const char *sec_name,
+					 const char *const *prefixes,
+					 size_t n)
+{
+	size_t i;
+
+	for (i = 0; i < n; i++) {
+		size_t pfx_len;
+
+		if (!str_has_pfx(sec_name, prefixes[i]))
+			continue;
+
+		pfx_len = strlen(prefixes[i]);
+		if (sec_name[pfx_len] == '\0')
+			return sec_name + pfx_len;
+
+		if (sec_name[pfx_len] != '/' || sec_name[pfx_len + 1] == '\0')
+			continue;
+
+		return sec_name + pfx_len + 1;
+	}
+	return NULL;
+}
+
 static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
+	static const char *const prefixes[] = {
+		"tp.s",
+		"tp",
+		"tracepoint.s",
+		"tracepoint",
+	};
 	char *sec_name, *tp_cat, *tp_name;
+	const char *match;
 
 	*link = NULL;
 
-	/* no auto-attach for SEC("tp") or SEC("tracepoint") */
-	if (strcmp(prog->sec_name, "tp") == 0 || strcmp(prog->sec_name, "tracepoint") == 0)
+	match = sec_name_match_prefix(prog->sec_name, prefixes, ARRAY_SIZE(prefixes));
+	if (!match) {
+		pr_warn("prog '%s': invalid section name '%s'\n", prog->name, prog->sec_name);
+		return -EINVAL;
+	}
+	if (!match[0]) /* bare section name no autoattach */
 		return 0;
 
 	sec_name = strdup(prog->sec_name);
 	if (!sec_name)
 		return -ENOMEM;
 
-	/* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
-	if (str_has_pfx(prog->sec_name, "tp/"))
-		tp_cat = sec_name + sizeof("tp/") - 1;
-	else
-		tp_cat = sec_name + sizeof("tracepoint/") - 1;
+	tp_cat = sec_name + (match - prog->sec_name);
 	tp_name = strchr(tp_cat, '/');
 	if (!tp_name) {
 		free(sec_name);
@@ -13226,37 +13267,22 @@ static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf
 		"raw_tracepoint",
 		"raw_tp.w",
 		"raw_tracepoint.w",
+		"raw_tp.s",
+		"raw_tracepoint.s",
 	};
-	size_t i;
-	const char *tp_name = NULL;
+	const char *match;
 
 	*link = NULL;
 
-	for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
-		size_t pfx_len;
-
-		if (!str_has_pfx(prog->sec_name, prefixes[i]))
-			continue;
-
-		pfx_len = strlen(prefixes[i]);
-		/* no auto-attach case of, e.g., SEC("raw_tp") */
-		if (prog->sec_name[pfx_len] == '\0')
-			return 0;
-
-		if (prog->sec_name[pfx_len] != '/')
-			continue;
-
-		tp_name = prog->sec_name + pfx_len + 1;
-		break;
-	}
-
-	if (!tp_name) {
-		pr_warn("prog '%s': invalid section name '%s'\n",
-			prog->name, prog->sec_name);
+	match = sec_name_match_prefix(prog->sec_name, prefixes, ARRAY_SIZE(prefixes));
+	if (!match) {
+		pr_warn("prog '%s': invalid section name '%s'\n", prog->name, prog->sec_name);
 		return -EINVAL;
 	}
+	if (!match[0])
+		return 0;
 
-	*link = bpf_program__attach_raw_tracepoint(prog, tp_name);
+	*link = bpf_program__attach_raw_tracepoint(prog, match);
 	return libbpf_get_error(*link);
 }
 

-- 
2.52.0

