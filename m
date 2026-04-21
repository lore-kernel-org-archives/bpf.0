Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9A7285C91
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791714; cv=none; b=HX+Kru3QP2mPCsWV2xmRmQ9Y8kkKztXqbKl5xT6SpleRhzxXHpRM6C3eUTiqWFMZlZQxc+0RdbAwG3MOHMptqoi7ndhyQ2ihfkbjHPZoGL+9U/p0PCqLNg2YhvJP1x0y6eLIlps7mMwrzKUyYXuVD//MDgRzuOUAtyTnlt4g+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791714; c=relaxed/simple;
	bh=XgyUBlKA/SvuOVrqUhiqb18u9uwZKEC2TeZtLRo83dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GtUrgIZiVOcBsSzAPcThAYV49hrKjT8YWt3iI8/TLThIBBOQ9ci6Emu8068OZ6TbKxsneJ5aIJOelfEo9Qr+GuR3arKzHtxjJQEG4ajTag7BQhFw4AJgXvpq/O4V7ZiySMyIauhxkKxVHi4UhiOl2prVS80JIKozqTvqswYQb88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5fB189Y; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5fB189Y"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so31019555e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791712; x=1777396512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fqn33ovWYUYt1PkZ0Hy1fijLCC6tpmEKrNph35+cmnk=;
        b=D5fB189YeXH+a3suwSQAfLKnjcd394KQ66wKLGEyExDgWqbKjggi+M6PGMjjbQOjjf
         p0tb1Bb23EO8+t4AoRBzlm9Lb2eyVML9AjwFe/aVQ7qR3HznXAAzF6ZTU+E3RvNQMyV+
         FMFpB/rZLLKVvxIHgmwSXJg+9dqrKwnaJ3itHRN3eZ7LLYSDATRoUI2+gMOsSrVj4BZU
         bxE+CZXgPhop1G0WuMdHyyJYuK8k/cnis/M3JsazHPEPvLQAmphHdZyIGQWfkiust+RR
         fOyEkYwy/Ho3H/B+8JVc4fj+SJj2vBLJQhhsizWlzmprK14ebFXWNaMah/VbOE4JbMYD
         P9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791712; x=1777396512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fqn33ovWYUYt1PkZ0Hy1fijLCC6tpmEKrNph35+cmnk=;
        b=L73j2jWkFTLOvEwO+1dNlYCi7jJIIZgQL7Cy19KpslCEUTUd7pqQr5P7Q77eh6kpVd
         BqTlCxUIa0aZJOqNbbHhseI5isLu/rT5hq1AKy3pUpaYB6c8Sx6Hzuy5USG1goi2IdSX
         OUGdjknL6CUmC/2QLkp/7yteli7Z81faT//02vObnTaIs5uSYmCZNQAArmEWi0B1QLz8
         5ZjhrTnhXhk98gxCoRUu+u1RKcb51lKCffs+1GDWva+Gg9uRuZIUkEJ/DCZ4tDw/24e6
         wcOA92xVJy4ELUXz0v68CTwZ5ICQAlq80jsqp7Q8nciQYn3EfvnDw9+JkPffZryROt28
         /H0w==
X-Gm-Message-State: AOJu0YyIwLyuvWvxf4WX+IzkY3iEppeDyqS4NqOdLWKEP0LB+EtChaw1
	6aUJiLFrkzGR9NH3ovOO6RsEfi3+ZLoKBDWgoAogRT/HHZwALZQ136Oj
X-Gm-Gg: AeBDieuwwHPBQbBYHsM23IxKuB4y4YUHgZITJhNYv0QrbTtGmlBIOCD0mse/GOxaEB+
	HgO56W49yFfgJCu+gclOyaTjNYJvorG+DRWqAJTH08Q9//FqqQUsvgjN7LcGOgqAEnt3OMBtZxF
	NnVw3dEzXWPdJKxa8qDug7deHg6IxCrgowd4qCxj0siqMy+f5Cef0y/SNKqtlecKvO/CkenWQbi
	mqOxu0CIFIySQb6JqNmzjlHverNwJLrI19feD0OHk8N8yq/Mub5H8IvtXo0SSusJ197JDHVowk1
	xU6YoUoigkExc2XoGqqzZV3kwWNfk0Afr+WzmlMeotg1CReMqF/Fz4TIa0XYmc82eoq/Rkc84TK
	XcZxBNXomV/7JbdpRXjejVXH9A90Yax25osBcgZl5S/HgiRrM2avStHEdGqagOIWncvYxsNQjWj
	FIjG/RN5Zek9QtqRbj1huD374=
X-Received: by 2002:a05:600c:c4a5:b0:489:96e8:1ef0 with SMTP id 5b1f17b1804b1-48996e8200amr115927305e9.30.1776791711503;
        Tue, 21 Apr 2026 10:15:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc24cfsm38816903f8f.16.2026.04.21.10.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:15:11 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 21 Apr 2026 10:14:21 -0700
Subject: [PATCH bpf-next v11 5/6] libbpf: Add section handlers for
 sleepable tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-sleepable_tracepoints-v11-5-d8ff138d6f05@meta.com>
References: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
In-Reply-To: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776791703; l=5451;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=IqH3vgtfffkawvb69tDUekNeo+OyiI8tuSlpVBnywb8=;
 b=kel3IBE6nEolVexiTklqkKtetp8fhMa7zIisSkS1GtMePb0rPmqyfwWToRJTPXQ8oURK4nJ2V
 GUD8Afq73NbAh/CQboC8H542G7VXpi2Q8TxXs8ev9diIvdDXUcViFdO
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

