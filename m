Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681F3542F8
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697617; cv=none; b=drFrTwyTJBptdy83kT16o3iwoqjRAMKSlFpeK3i8gDJIfTNVK8cW4o7oHkxo4HUg2WF/eiSt1809jDEsYIXj1X3xfoObh8gUatOipn5BQjJ+Vwu1lPzdkT9VpAdkNzTwiQHtNbeZggPLNTQYn+gJiK4bkdXmPv2ZEQCqCU5x1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697617; c=relaxed/simple;
	bh=6KVvW/aM8vqFtMnjBm980/8EV3PRNui+l3ERq+9UpS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWc9LS4Lvk34Y+I0bFnvFE/H/v9TKZuNywHuuLNlFm3jvQyj1rifl3oXAKAkGAYT2buaZDggoOvwHHYmk1dQezhVMEZZ0y1/C2LouBMvJXAN1meSCdJr/CbrMN15Yej7B8SPVxGTZVci5o8f+WEIZy4jnjHHewjhH5mjKiKa100=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQNesvRR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQNesvRR"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48541edecf9so55153175e9.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773697614; x=1774302414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4vEcbduH5bp7ek2wgqFiKxn5o1+bgYsdM6x832qHzw=;
        b=eQNesvRR0KFM32W0gAwuc3VqDaUffIPaEF6JpScFAfRta7f71os50L0wulsu3aUTmZ
         xFk8alpZh6EbhXwwV+9mbXEC07O3wZfI38jR4mzpE6Dq+Vh4EMRdIb4SQkmrh5CtDnv2
         vAGdOfE1F0LIKjYqXdZMVo121b654rttl0oKXqF7Myh45lYgYYFjktYryXLlLQW95VY8
         wLL5ihmkkkYRYoKlQ/sO4AbJblZBdkZKj5RnpHZ80FqJ1iiebmOAiXfxpx8GNI+8fdi2
         wea/a43Vat4txRrZxqMexyiwFlNkl82+aT7QU4/z5daz+GcNoRYOkIo49sl9CArgL4m9
         tDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697614; x=1774302414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g4vEcbduH5bp7ek2wgqFiKxn5o1+bgYsdM6x832qHzw=;
        b=eZI6ET/RmH0Q44NvHT0SUvU0IpjX+PAwIZUv12Y03zbb2Ow2aWCITOH1eQLuC1NU6f
         2df4eBuONZW4yWaC9j3acTG8q8y26tfVhNcXwvXcHYG+OsWkNaMr7rIACQM+hRTPlgyE
         6SObFIw867o513JKYtLPQ7+G7oU6qxuXsCFNVPnFnIZMSQyiO1x4AHnoNNCPqzxEHR6y
         +8gBqbE4++qrNt88hZpHYlUiUX093wX57pbcKJAUifJECuzBlWVsANffSQ3Jdqt0KgWA
         x5oQ/dg+e42Khjj/SufEEY3toR9DOMyS1428foQcXgoU/PDaUA8wMLLCWDgvDLuzvM6D
         qvQg==
X-Gm-Message-State: AOJu0YyXXhYyPVoClxzB54Tym3C9llZueyl3S5ZfnVYAfN6YkjNMteny
	1JBSvgBEvd91IQZNQKtPlWgFJrHuWtLOsgFHtCPqW3EaZ8stXwRHnLXR
X-Gm-Gg: ATEYQzzmkKnkqcpzwQvbHqZBa/kG25sEoe88O4WJCLQb5hTn3pah5G7Gq97h0Fml4oa
	wjCHSdXlhyXFjMT6ZobcXF28E45gy52jNvogh8VMmbj2id/Fp6gQ+UpaU7EX48V/pNb4X833yx9
	PUM0k/wAgFR6IpYWjlAgHHahDLzB0x2dFY2QEeTHC1iq1rk4/Hau2BR+ID+Z+hg4+h0b2Gn24Um
	NWA3K3rnnHbrvesNEnsdwlKl/fbLCGw0TVxKuefmP5wDllhdbFQ79iHWZmcEFebyls9AncUT9aa
	IIh/TSLK5iQW2VtLVlBPzGzNdomlw21wTMGdwBd6lGyzFySMPjFU2ibHLqYI6OwFmlh8SB+yFMk
	XGl+Js3SGQOUvlUk/dBiBa0V9r83o3/vEeqcfa/jz+mMSzUxTsqyGVtnAx2FAAqCqdwwqprfoo2
	mwyAQO8SEbJ+fj
X-Received: by 2002:a05:600c:5395:b0:485:4278:2558 with SMTP id 5b1f17b1804b1-485566c6a81mr257448145e9.6.1773697614249;
        Mon, 16 Mar 2026 14:46:54 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaffbbdsm18465515e9.15.2026.03.16.14.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:46:53 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 16 Mar 2026 14:46:47 -0700
Subject: [PATCH bpf-next v5 4/5] libbpf: Add section handlers for sleepable
 tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-sleepable_tracepoints-v5-4-85525de71d25@meta.com>
References: <20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com>
In-Reply-To: <20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773697607; l=3939;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=9ZfIL/C4emuap6Ca7YKI4DksQl8pT1DrPTyUTfS7Lqw=;
 b=1P9Ja97J2FBHWlx6neRkeiWaUSlduBenwwCwbxl1qekQngOLecekRLIOhIS+t2n+/sbwyi37k
 IpmBLvsfowuD4ZCo6wmX9alT+9JRP7ZiVXAATfJ9QdJR05M82h0sVUd
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

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

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0662d72bad20..625d49a21bcf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9858,11 +9858,16 @@ static const struct bpf_sec_def section_defs[] = {
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
@@ -12985,23 +12990,41 @@ struct bpf_link *bpf_program__attach_tracepoint(const struct bpf_program *prog,
 
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
@@ -13065,6 +13088,8 @@ static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf
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

