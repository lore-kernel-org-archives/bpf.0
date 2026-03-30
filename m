Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A49D3E274E
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909243; cv=none; b=B2ttY8QZRyGwbqwFgz1iRaY5RYLxLmr8zztDnIQAiHFCVvtAGO54aITt3ZXFNOXVAbIdHp2WetyR8iutdfamijc+QMXO1iDPE9pZ9iiQL0SciQUemB1N4yjQefiVu/FtDvoVEInnlwzgA3YeQpgvBoRDU1Wom9Ry7iZKRbuotkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909243; c=relaxed/simple;
	bh=csk5hHIUGe79fJtAIWPvglkGBu6nuG+PgHIfNDZPeeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crAC4sC2kYmW93Ov+j06EH5ozBEUonukW2T734UGkKzpVIMnRtEHaAb2LXZ3fMfpp7Q5g91jRcNHPm78dFRUggRwGQKcZ5UkkaEWi/LihUTrINH2vMpRxv56b/dKQm1HPs50FyXoa5KQo8a0JUFDdkSl1JEhMvg7F6QbDNMG43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfLHVplE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfLHVplE"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so50114725e9.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909233; x=1775514033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6eVRgkdj++KifaYWWPNYsIFtv9cMZzpioyMPFaKMWQ=;
        b=mfLHVplESW+IznvRvpdKRg+w92+dMC82H5WJTasLCZrweylXvebRVYMAaJMrgPofCx
         CNaYSW0urUgvDbNc2lnhA6dqa0EVOvCFnHqDg+TgCNnjyH2KgYRBFKk2I8nJfDp5cEEv
         3EABMiJBts+HKSbwff39SGngKY7AxLZ5ix3AKIVwm4f6Bb6nW0/W+3XQCUBgsfjE5GD6
         t09jql284OBD4luinRmH+mb4BmdDm1g8mZjtBWrts3M8QEQrSAz09HVpgZDKbHPVmt5v
         JD2tG9YXbBk13q2sHHPcfWuY5ROwxCAbYrqiNRd/J8KJbM/OB7R9fY40jqcGb658s6qI
         em4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909233; x=1775514033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s6eVRgkdj++KifaYWWPNYsIFtv9cMZzpioyMPFaKMWQ=;
        b=R/+pkNIH0aCMxsrJ0GMirrxz4L5qZub0CqFdyJXE7c7nGnrOBTF9OuEJJuij4FrhPr
         ky1/bcVnYg2bSEvqyEdhDuTQDT+bSMCgTU873afQphbx0/DN0iBg1LH9qnEAeq/h1Zg1
         zdYRp6OG9Nal6ZiJDiaBvO+wXJIFMS9BqAUZY9s22OY/1ZXFWA+QfV2yHVdkak8T4NJr
         gbQiSX/zVHglUxnJ2Oeq2lnrlkvzXomU97GId2qmd+98s8hvaOwC93e72Y5rOJSTp+1H
         J0ZQ0NoB4ri57ZXzyoMQ5iXrFvtZkW669tJGs1Ow5lZHUMfU/xIVVYXUmX9HfHJs4hjA
         nR2Q==
X-Gm-Message-State: AOJu0YyHXI0Xy1bc0l/zgP+vfSWgp1fH8YQOkbPID/p/BF4lat/jRBQo
	HI9F76XZqvRfAgXF9P4O8PO8AdXqC7bsZTu+WY1FOnY6zQXh+9lZ19zQ
X-Gm-Gg: ATEYQzx9kZLlt87NmAB23GBjrDyYgZNdBUpQvwrfLOedNBEkmEAwzC+2P8W4J6DdUd/
	pxe57c2uxDp/uC7nFwvAWA+WX014YYHG/6IMREF5RHQsAfrozTJpdjWsQtbwvTWY+9vOLPF1XS1
	Gh6l31ux5YXaIrcjvd4ta/SSor4t0cSXaKQKQIHwHIffrQyr6Qw3H9Srh5iIMJKIlIyZZhryHjX
	VEyJeT6mf7zpMWU2fgqlteMKOgAYswdFXLMafzbv+ImbiIDebHRdxp+idHnGxG5PNbUtw20bjma
	R0nHFpcWY0ZZwtiAD180YQtTje5hHMGSJRVCzToc2j2s2evuK9pS26q89ZBiqxA8kXyA/l00FCV
	ApxeKSxUggPpx07snqkjUKO6lzBSWPF0g3iKz/C8+Q3UJblj8MiNshVCiFm1bw89ZNSYKvBmB9H
	x8E9mQFWgrliD3tQ34P+syhdk=
X-Received: by 2002:a05:600c:4744:b0:485:3193:6ddb with SMTP id 5b1f17b1804b1-48727d5a2c7mr234963635e9.3.1774909233315;
        Mon, 30 Mar 2026 15:20:33 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a648f3dsm4764715e9.0.2026.03.30.15.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:20:32 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 30 Mar 2026 15:17:28 -0700
Subject: [PATCH bpf-next v8 5/6] libbpf: Add section handlers for sleepable
 tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-sleepable_tracepoints-v8-5-2e323467f3a0@meta.com>
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
In-Reply-To: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774909220; l=3993;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=VCLFI6Vsh3et0dBUgArop6/4/CThw8hFNjFj2uOriww=;
 b=ENxg714yE8blao/zI8oo2nchkbV26vquVIMV9hMsOvIk9ehSv3xTZIwOgN9qB3nzQJgNv0fb1
 QNT9ZKschg0ChIyNaXWR+A5h7u9ZzWVIExz+4srCzr7XD5UvBFyXbv6
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add SEC_DEF entries for sleepable tracepoint variants:
  - "tp_btf.s+"     for sleepable BTF-based raw tracepoints
  - "raw_tp.s+"     for sleepable classic raw tracepoints
  - "raw_tracepoint.s+" (alias)
  - "tp.s+"         for sleepable classic tracepoints
  - "tracepoint.s+" (alias)

Update attach_raw_tp() to recognize "raw_tp.s" and
"raw_tracepoint.s" prefixes when extracting the tracepoint name.

Rewrite attach_tp() to use a prefix array including "tp.s/" and
"tracepoint.s/" variants for proper section name parsing.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9ea41f40dc82..a353dc7a4d41 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9982,11 +9982,16 @@ static const struct bpf_sec_def section_defs[] = {
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
@@ -13109,23 +13114,41 @@ struct bpf_link *bpf_program__attach_tracepoint(const struct bpf_program *prog,
 
 static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
+	static const char *const prefixes[] = {
+		"tp.s/",
+		"tp/",
+		"tracepoint.s/",
+		"tracepoint/",
+	};
 	char *sec_name, *tp_cat, *tp_name;
+	size_t i;
 
 	*link = NULL;
 
-	/* no auto-attach for SEC("tp") or SEC("tracepoint") */
-	if (strcmp(prog->sec_name, "tp") == 0 || strcmp(prog->sec_name, "tracepoint") == 0)
+	/* no auto-attach for bare SEC("tp"), SEC("tracepoint") and .s variants */
+	if (strcmp(prog->sec_name, "tp") == 0 ||
+	    strcmp(prog->sec_name, "tracepoint") == 0 ||
+	    strcmp(prog->sec_name, "tp.s") == 0 ||
+	    strcmp(prog->sec_name, "tracepoint.s") == 0)
 		return 0;
 
 	sec_name = strdup(prog->sec_name);
 	if (!sec_name)
 		return -ENOMEM;
 
-	/* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
-	if (str_has_pfx(prog->sec_name, "tp/"))
-		tp_cat = sec_name + sizeof("tp/") - 1;
-	else
-		tp_cat = sec_name + sizeof("tracepoint/") - 1;
+	/* extract "<prefix><category>/<name>" */
+	tp_cat = NULL;
+	for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
+		if (str_has_pfx(prog->sec_name, prefixes[i])) {
+			tp_cat = sec_name + strlen(prefixes[i]);
+			break;
+		}
+	}
+	if (!tp_cat) {
+		free(sec_name);
+		return -EINVAL;
+	}
+
 	tp_name = strchr(tp_cat, '/');
 	if (!tp_name) {
 		free(sec_name);
@@ -13189,6 +13212,8 @@ static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf
 		"raw_tracepoint",
 		"raw_tp.w",
 		"raw_tracepoint.w",
+		"raw_tp.s",
+		"raw_tracepoint.s",
 	};
 	size_t i;
 	const char *tp_name = NULL;

-- 
2.52.0

