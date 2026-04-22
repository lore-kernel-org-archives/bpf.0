Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57618325495
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886957; cv=none; b=DjNMLdXHIaYsAV+fTcT+AgSekriy36OMcVo1/vFc+Y+h6LBnD0fci1x1XoWWj+K9EbgoT8nyhjCzu4l/DO0OaqRCDmoxiWr6q7rulMUQg/izG8vExeCTjoLpsGZNWFJ5TA1SFJF9ueAe0NblxjYtfPbOzmHc5CIpWHE6DmZULVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886957; c=relaxed/simple;
	bh=XgyUBlKA/SvuOVrqUhiqb18u9uwZKEC2TeZtLRo83dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RpVzLHEt7hEWV1507CMcL8/Sv+/gz40GHSXYFzmsQPWTmMJ7JBodMxPcvF0TSiDesCxeeNnDaz6qG+L9fm0yVEDBsLmNl+gcKXQzj5gj20xCuO3geIGzuhbsEwgPJ/MSakcS7+CyRGJ3PdE818CgJuuJo0nZWna80SxU662pL4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQWprYvs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQWprYvs"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so72765915e9.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776886955; x=1777491755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fqn33ovWYUYt1PkZ0Hy1fijLCC6tpmEKrNph35+cmnk=;
        b=pQWprYvsj24MbegOWLNEdZJNVLMkDxJso8mrVmlYu4aj2nvr2V0YHaO7J/xydZLDIj
         8WVy5HI6ReVOO98fKCgvloDWHATRVXpTBDRc+YEZ4KHHGu5RcD0/8ywYEQR34UM+/Ykq
         W8dlj02mE6TNzazKtmZX3xq/BkCkZjnTZkmdtE5nIT2AdfMit22BEvXcsbcXg2bc2mOC
         hXjqypXjrWaJ+hh8s78RPZha32wkKqsuQ5VnwttzZu895TTYNb3fJ8wbWycRjzadm+Lz
         FWRbpMUrBsS1eWJeWXPBLWY2yecrRFNlYcxZyMP15F1Ym42JzsBgqDTFUl3t2KRmz7+I
         k/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886955; x=1777491755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fqn33ovWYUYt1PkZ0Hy1fijLCC6tpmEKrNph35+cmnk=;
        b=YoCSF+Bf894TppoVGr1C/aMIL0LEDE0jf7pwPsdcWLD425pyMAnkL7yRKVbu1jffFP
         jfTD0pbSjYEOsvI8S9p7GfFJd8vCI57JP3YsfGWqzu85oDND6FzltYHGZxKv+tUmkIso
         Tt9MXAyVEGtxs4dSrW4My0FjKRdffFEAqA7faUllhyau+GLMC/9txoVsuI4v27CNYn5P
         fxyxVjog/y/NcV16YeuQlxf0hICdV+gsGJaokWTlayxxuQ3ScBP0RdmRWC/Hc3Iz6iW5
         +c8DhXfzFE4ATGrVs1hHfpw89OAQvwTvWxHieR2GlTH9gXIw9HSCh/XBumSbfK96wvoT
         aTkQ==
X-Gm-Message-State: AOJu0YwZsJ3OP5EJ5mjPu23U6Ld0N26kHz+YFuYE4ZAl0FGzIIC/qYS+
	qYriwrGbfCtLIA3akxrUnYQfP2c2gsZlRFreZIAglYlMipLf+bD7d1TQ
X-Gm-Gg: AeBDiespAe7iv2YBuxD6M0QDWjmygnCHyjrkHu+3+2kzUuu6hJhs4FwEXBKcfVN1aPs
	pte4NCKQN52PJm0OWi8kerZ0hqVTyWKHJt70E3w/FEjAPILQlD6ina+5pKK+TZcSTaIsQU0lt0H
	7Lf7kjBNcQAb9kL3ZuSLMftNoNo3KnAat0hQxNx6samHaQT8+Sj2t4b4ZKVgwwWqkUGiurtkE9O
	LTidAoEmz8R2sI1pi7T2NFIXEL0c+efyGb9akHwQ+N1rjWHxYitZ+mUddLOFcaC5KAiDY+CRyGn
	U+nOfVKG0zA+QXEqWdR7nqLHdb8Qd5mRK1L0zvboeoOODsi4mjHZeRMA3IPkS62Kl3DCzjeIVSU
	ZnQ/j/FZ1gq2Tzoy70S9Jzp8//rctTjGBTLusjO7GEj7ih9GYDs0S5tcmdIpt/1wrBwQrEfQ8RX
	nYoPKMk4oxeM8vfD0QdituOZk=
X-Received: by 2002:a05:600c:4e4f:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-488fb778703mr345899585e9.15.1776886954737;
        Wed, 22 Apr 2026 12:42:34 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f8193sm423985815e9.1.2026.04.22.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:42:34 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 22 Apr 2026 12:41:10 -0700
Subject: [PATCH bpf-next v13 5/6] libbpf: Add section handlers for
 sleepable tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-sleepable_tracepoints-v13-5-99005dff21ef@meta.com>
References: <20260422-sleepable_tracepoints-v13-0-99005dff21ef@meta.com>
In-Reply-To: <20260422-sleepable_tracepoints-v13-0-99005dff21ef@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776886944; l=5451;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=IqH3vgtfffkawvb69tDUekNeo+OyiI8tuSlpVBnywb8=;
 b=EkNXCssNhecXTsH/4/fI1xIRbr1bxP5ke3qC3miYCGDPIH1QtAiZXtwU/9GhZXDmDC7jZu+og
 +x8yzXLGM4yA+bCaaIf6iObPR9qSF9zUnFhshtUpC3ab38Mu845BpdY
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

