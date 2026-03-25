Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F7324B2C
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464964; cv=none; b=bBhIqEPRwRWZ4LcyXTkYr4mZwsCJimcgYTQmoyMYw5lvluuXeMIyyqOMj5Oee0PMaH9XvEP+NI7glhcZkS+5WhtprAOJs+rhXpZ8fzpX1NST2rFMrFeAqMvNIhoyLmPT5wLl4BIVksLl2VsQw3GkE4yVRLdBPQ20UwDAvlBGXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464964; c=relaxed/simple;
	bh=6KVvW/aM8vqFtMnjBm980/8EV3PRNui+l3ERq+9UpS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JwSQwZqmTsjNbETX5nOkFKjgdOm//b6zJl0KevYk00A3BHM15dTtHP0Jre4JXXSKg/Qu8rBJgWCK6BWIJPmMg8tr5FFmBgOtdPauCdlxtyKPoPeZV/3lKTfASk95Bm+SykUw0KrQcyh+FMEA+bwQgiQ5KVahr5ZtXum6OCkP51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J85z+9fy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J85z+9fy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b9b1900bso97178f8f.1
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464959; x=1775069759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4vEcbduH5bp7ek2wgqFiKxn5o1+bgYsdM6x832qHzw=;
        b=J85z+9fyMfMYANMtDRrRgv+ta77psA7x5rOwd2O3g7YAxyJir6S2w3Tqv1ahxYtDen
         zr3QiAENvGTN9wIT6G9LbFwKINb4gunHLrv1IJauQmBq487O13YDquIuupI1hsjPtYd7
         I5b5Zd4ySF6pbbfnvxZZFWxsh1hcGmFfsoLouRVNua1GfUvgo1vN70z9MNb5z9Jnjxfj
         JIlShox9m0Y6+Tp6/BuClcHgVd9/OWXV+QIizF9fJHjjQLGV84xrgKKmiH6y8OBW8eoY
         Q8U6FNlcbixDNH+b2CniCcIyeUtMlUuu6+NbJaLnFIIATqJlGPN7IxPhHngm/5ef6DCO
         Ytxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464959; x=1775069759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g4vEcbduH5bp7ek2wgqFiKxn5o1+bgYsdM6x832qHzw=;
        b=T8ukr3MVTrJ+amuACh/9Y0oYwlghU4Lv6tiSKkLaaj/gEZT1dOPmAb6IVezNd0QGCV
         ZHi9DdUULqsXJJSbx8A7L0QTvZogztjV2oDBVZkMA73RwahuOX5AAb3Y4zj91b0310Qh
         iGLNotMjvZjDEMRKI+0n1zzxOnAaauxjjkGjujYrTJWqcIMkMR9z0oKkrLac/HDVQyFX
         EWQuslr5Vli9lhzvWwIktWpGnCUegZ663JdC/oFmvyh2XPy6Neg0KX+Gait7En/wmSuZ
         CCpgsQL7r6rQpuK504CkK0PtQWyr2YMvdukgcZYVBI5sdCImy74OKqkK00fxGmG+DE8e
         BwDw==
X-Gm-Message-State: AOJu0YyBjf+wxpgyWdrEg6jEayfETfofKFXPxU6w1gqSGtFPM5Femx1g
	XSHAIzFyCxztqMsNAGS/wD5PPYkz+2A7SZy2iKBw1aIKtd1uzSNJiH6vhVND4Vgp
X-Gm-Gg: ATEYQzyYFpdDqzQHaNCtJELQ54lwlS7PBillWyVH4Vu8V+t7ny9AiamaBpAmCEIBW6X
	u3iptkODE0vAEW2Z6DhbjNiMG0t/QHfwVdVhh90DQC1De+xRLKR6dfJfb74q4k3wxwzwMkeh0Fb
	89vQLZtTr36OL/of3VqVTRSDKaWKjxmrI/P6DvsRtwcYfpD+PJuL1JexCnxktuoARxWmpkIagBE
	GITHdub71sch/Qo6jcC7uY8hvayM2VDTH1jNmDWXLitDA1gR5sBVObCkMVKt6b1dzk1PbqwAKrC
	kBgHSAnjoW8wDiAOS4d4Zbl66mlkQ/dlahWSBiPRyzDwAcQ6r+JVh4OU0fR2paGF1YPsReKdJkC
	+8tHOx03U3LB4U2YLuuI7el0hPjZej1h8p2fBPq20Fiha5wKu69I4cvSYAcLweTi7ZqNsBO+kUe
	rkbMhbJsSuvA==
X-Received: by 2002:a05:6000:1acd:b0:43b:3bed:f34 with SMTP id ffacd0b85a97d-43b88a217femr6867143f8f.30.1774464959025;
        Wed, 25 Mar 2026 11:55:59 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b91945b28sm1559913f8f.15.2026.03.25.11.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:55:58 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 25 Mar 2026 11:55:22 -0700
Subject: [PATCH bpf-next v6 5/6] libbpf: Add section handlers for sleepable
 tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-sleepable_tracepoints-v6-5-2b182dacea13@meta.com>
References: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com>
In-Reply-To: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774464950; l=3939;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=9ZfIL/C4emuap6Ca7YKI4DksQl8pT1DrPTyUTfS7Lqw=;
 b=UTf/idTyudkOMh8t72YFwGb7cemw4PQcNyMLTRLBXlUGoyv1RjoxHDgM1pEwSz+5ySwdYUeW8
 9W3nTirkzk6B+N7bxaxLCSpub2nfYp6OkrQWOrcIp0oSz28zLuV77Ef
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

