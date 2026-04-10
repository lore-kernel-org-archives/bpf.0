Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC53DFC7F
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840997; cv=none; b=uSL6w9t7UW42Qs+nwpF1wKyNaiOjD9/WCZdG8qiMV7PnMPtdhPh2HGusdk/NJlisi+pSSWLy11ZRIPCQRuF5NXD9cKRSFcCQ1+7XjIwRCJYTKqZeKmKRjGa0e4fQgr1xpgFlHgmZssPVSkX07DtQMGf5vZtMuNP8prUQkcg2FbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840997; c=relaxed/simple;
	bh=y+Brj1FOQEfNV7bO2DQDXKhVpsQsFU1OnbKJr2Q74MM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/lV5gqG9lKIoDrgGcj+3e+hpfumReOBpdD+NQxrI8XPz6xagE5+bu3JNlaNw/p3RsY3niySvUGdsJihSlmlazSXbLRhPFvPhlp5S+sZqjwpOamGgCePHPk1S5pqwvjBFKWXXDvMMiEixb4SBJWvpAr1KvLVYhIPFSK5u5NKGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN6WL0rv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN6WL0rv"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cf7683a28so1536700f8f.2
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775840994; x=1776445794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnPwJnFXEehoikq27IKtxywFlVANi5ey/F9Nd/QDxlc=;
        b=lN6WL0rvE1OpYlSVUZQcFS1AbJr4+in6g1okPpnyRUF6QMFwiNIa5FUz2PblD1KHev
         zRy0lcszXvbwRPIhjhldm39aW5VzVuL3LuxW0pxWE/SrlxWlD7JDPg0rKV7udevUhxYM
         iohXcKjJUeVbOx1uPTQQSRWAq5LLaKCV+/O+fPo+SaCbXvcAKF9rsB23TexsfDM3v2IO
         70XKvjbMk7u3R7Vey0JJ9//ZCRo2va7AASetkobRjBT0D7hB934MuEH88wcoxNWEATAd
         AQ2OHVaG6sqYt2la/Q2AzUxH0i/Ru+r9Shbjp9H4D805cD215JJu9jufVp1TM6ruwXEj
         QL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840994; x=1776445794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RnPwJnFXEehoikq27IKtxywFlVANi5ey/F9Nd/QDxlc=;
        b=rdNW48wEPTO9OcUlSh3J7xFkQBL53UjG52VIjD2y1KYCDuQTf5hgWkgqMabXEy7NbP
         u/hUYxMhygQ+tPV0L0x5XyBo5gUgv+MBtN5Be6HbeExZ+vwgeaKGwKM80kkFlYQE/LXn
         g5HfP/b4TadT54yNwSqYwPs5btmyFQzhViE1xFtI5v298Ks+TeDjM6k3EAypFh/GFRfv
         MfCRrtAnHBWv/QVs4Gftq0OyCiv78/Crfr2uvS3ThaHF7Jgw8ondf81cUJVAOFArX+G/
         e8vfD7KUr2x0CAruC/m8IivHsaqNOixHlqxra8qMWyO6USSqSJbYVVEZs5HxkvuEFzes
         SLCw==
X-Gm-Message-State: AOJu0YyO4CUH+V3/rr0kAOo3fsYlOqPaoG+Qi+95gzwgPDs/qTM9tBdy
	V0h1qsR+ym2UoN0reIw5c+ti1QkL6yQRsKsWZF/3XKeCaSQwzHFQToPV
X-Gm-Gg: AeBDieu+d2UXY6LS5eglpI4D6+kIx1SLdRfLiP8YkSMmIZacthl1nS8mAOysaMt5wMg
	QCjAQmbiV3AMiTcrJnq5sj9p7mV+tu3l08uw++fELtIi4bfZtoavfrp13vqeEY0hll+rHuwWR4K
	kh31c5ZvfbPiwc1xbz86uHjFz6lBuSu51E8zVPT+uX8KOulwDVocfthrVPp3LEh9gytq/IBoVSp
	Edckh0HJU1D/qwrHLkqYp0WX8dq1KNcQLBQXpX+ul4YnvA2OXrs8CHKRqGK6Fj7/yFkG1ArwW1D
	ugxyAuFH6xEf7RJ4w0ZPxuQ7cX7pzHKwCf+N6jEOU8/apOtCVzHLGXotZrK4mJgQl+khvnStOUF
	g2aXTrnYen+gl/CeK8vsyVhA5U/KGaoszu1qAtjf0BLIvIkGv4LvKHlP2ZWcda6ws/Zjzggmmol
	IIr2jJ45SYdrSS
X-Received: by 2002:a05:6000:2309:b0:439:ac8f:5db1 with SMTP id ffacd0b85a97d-43d6427aa48mr5690964f8f.15.1775840994137;
        Fri, 10 Apr 2026 10:09:54 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm8882927f8f.25.2026.04.10.10.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:09:53 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 10 Apr 2026 10:09:33 -0700
Subject: [PATCH bpf-next v9 5/6] libbpf: Add section handlers for sleepable
 tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sleepable_tracepoints-v9-5-e719e664e84c@meta.com>
References: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
In-Reply-To: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775840983; l=5451;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=8/0Crb22Qd2Mz/eslWYKmrRo38F6JZE/FbYhiwvoPdQ=;
 b=2B0t9mFPCeZCGGE7/1WH+b/TJuMuYxx70XmxqPILNMLAt4RoVcOJ+rag8MHmwsr7BWoObzVuC
 MNXLsxXtTcjBW+jMFu2vSEL2+V4XUQXmKPiCEHB/9BvYJu/SfX+hlXW
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
index 42bdba4efd0c..5cb040a13490 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10009,11 +10009,16 @@ static const struct bpf_sec_def section_defs[] = {
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
@@ -13136,25 +13141,61 @@ struct bpf_link *bpf_program__attach_tracepoint(const struct bpf_program *prog,
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
@@ -13218,37 +13259,22 @@ static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf
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

