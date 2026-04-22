Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2DD30DD30
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871654; cv=none; b=YG1I8Qs4s7bOVmDoj11W5hHd7e3OzxuPSpqMTTji8p3n7coyDn/nifTKCfqThFXB6soD8PYnvv6tII+tJqwL2TLoGnTRfVPeSl56scTjt/sv0NU7/KzvFWTZHKv4OGiUVCtiRKRGf+KuIFEJ3ds6ri0eTJyPu87zdiP2IXJbnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871654; c=relaxed/simple;
	bh=XgyUBlKA/SvuOVrqUhiqb18u9uwZKEC2TeZtLRo83dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OhvnfPHee+1QscHM+UxNeqAJ5NexL0Z80wl2C1Pagt0Qm7GmhwlB+PA+krz6pRzMUDNMcXqPwt3HLsL0btUtWSDS9bjEp0TcxT+uNCs6y4BslYBlqJ5yem6+e1SsSLblObgzSpCZAOQScHhDwYwuaBbgj15/qYC1k/PTIkA3ObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pw3jzEU3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pw3jzEU3"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso47979275e9.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 08:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871651; x=1777476451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fqn33ovWYUYt1PkZ0Hy1fijLCC6tpmEKrNph35+cmnk=;
        b=pw3jzEU37mHKnMAOKXf9/c3cfz1MDE+CaxmeRmxY6N+3SYTEImic01d1tcoHuKrdWD
         q84rF1kVXKA7O4YGXeqBNz6WIFiZFfhC5JLIZ2/Tm7pgUNzd9DEzEjx+w/b+jM6rJW+Y
         XA3XqoIodDftsW+In8Ydgg/mY2VQXqAG5puCys8Xpf2CTCp0fdIGJYFKR9ReH4A7jVS5
         4JwUuwxFFBeVpfZxzX2h+JfNG0EpqH16J3RNpy/YAXldaiOxXolourRwQI6aTbLwns8I
         Y2q8OdeMYT9bt4gUF+JnqS10Wc+EloAC6VSPjMkoCR1U9S9jhxvCqj5rA9HXz6ciGXck
         7TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871651; x=1777476451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fqn33ovWYUYt1PkZ0Hy1fijLCC6tpmEKrNph35+cmnk=;
        b=rwAs9U2BLAHm1qnRamDszt1kqlXZWDaviwR8TnNvTK527GX3YuSe/fKL78qhRJP2Ai
         FyrszOadThi7eY1pyxplUtxYGDDPjCCxIhVvav6Svv90Wiq6gXLe5j1jKo25KZ3DKl6D
         8grWPWqQTteIE5VKry6OHxHtjR3/IvSF1gh0MD5hE04MAyTHGUlar6wl2VVXKBFXbvNL
         NhIRlAHBpnKRb/JOzLrLkNUUz47Xbz9/J7SeU0gtk9kEsMjYHA71gXJW2u5x65G0qHQ/
         zCftYTTj4UV/PU975BWNZEJVgpwtBcSRswraRGAV2PwvdPUVQncFzLlokOLhYm11AANy
         B3FQ==
X-Gm-Message-State: AOJu0YzOUueEz+ye5eH9BiimBPulAD3zhmlIcqjNJEl9TrBo7GNKMlgR
	4iTa8Hvcv+pnywFUPxWw4nk5/KDG4D71CLRlac99gE3GqLtVOxGXTQeC/dwlC0Qk
X-Gm-Gg: AeBDiesRKtKMTe9zdcOMWcjElELdoVgH/1tAiO+dwDYrLG2bUms+DYvwGlUrUSj8mP0
	9M8AftqM5d79sEA5Vm1746F7sfzlh8s+UgWv2YMEeIaw8DmYWs3z1FTTR+jxnhMAOYHxh8jI5uR
	0qHrXOtT5CaEFxdHfilDvLO4OBn3bT2OlMqFCYKTdZ6h4f8pJq8vHZ8vS2igwlyybtmrfcqUTBU
	OAzcX8Ym4eAFeO8fkhMX3uVmNtOperC6pC6yy0BJhnGP3YELGVQrpfUIDwrbGlBVNFxJKN+E/wO
	fCHpz2hSr4LGxHJX+GaHAXsjagWC/xwKbkflgfW/KkunKodlmZ5YGhky48hlucyWWMFT8OLBjr2
	jOC3Qn52A1H+vPLo+U9kG61Vvif0VCFgh7YDbY6sjti2RHTa6O9fJND5BZhqFpPgp+Lvv1p/rgm
	inC/sj8rYBMEOLXGOqOQDTGCI=
X-Received: by 2002:a05:600c:1614:b0:489:1e8a:90b4 with SMTP id 5b1f17b1804b1-4891e8a91e8mr108642705e9.21.1776871650612;
        Wed, 22 Apr 2026 08:27:30 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891df9e50asm199666625e9.0.2026.04.22.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:27:30 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 22 Apr 2026 08:27:10 -0700
Subject: [PATCH bpf-next v12 5/6] libbpf: Add section handlers for
 sleepable tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-sleepable_tracepoints-v12-5-744bf0e3b311@meta.com>
References: <20260422-sleepable_tracepoints-v12-0-744bf0e3b311@meta.com>
In-Reply-To: <20260422-sleepable_tracepoints-v12-0-744bf0e3b311@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776871642; l=5451;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=IqH3vgtfffkawvb69tDUekNeo+OyiI8tuSlpVBnywb8=;
 b=oaSPnvgaPXpf8mjxzFGzn04RIAb/sff1tRHzJ1D6BUUgVWBDWx2z6MLBCFBWVcm1bTOYXiABi
 nk7ymYOsju5DFFW3HVWKbfbG/wuFWPrKPY5cwATKuV4P/rBFLK+LDha
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
index 83aae7a39d36..ab2071fdd3e8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10018,11 +10018,16 @@ static const struct bpf_sec_def section_defs[] = {
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
@@ -13152,25 +13157,61 @@ struct bpf_link *bpf_program__attach_tracepoint(const struct bpf_program *prog,
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
@@ -13234,37 +13275,22 @@ static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf
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

