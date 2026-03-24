Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D987F31691A
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379040; cv=none; b=uT+cH3v8I2JZ5N7oD90Yw285lDG+K273038Pn/kx+NK69JUIgjquq/okzdUQTGCt1YY3c6dylzjiK10RwFT9pjoE3r31noP0o0nLk1K/K5lia4C8BzVS8esAZ24Ndqr2L6D68dj5ggmvqxIX+jK0mgyrhEVxbCoR4PdzZtQhCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379040; c=relaxed/simple;
	bh=6KVvW/aM8vqFtMnjBm980/8EV3PRNui+l3ERq+9UpS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nsjkOmp9QAtli1FUruxuDXPzNK1OGw1STwmxyPXbM72SrM7NPM0t/5W9teJ3FidtKvM2/ruXyluhUaFtBHv9lZ7t93L9nBRco2XAocNSBO59p0fqUV+/bIZIQJs+1sfd+aeFx1OgWFOAEj3z1e4V2HiPKMRfT1AZbjrxHnY9DH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qI8lgep9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qI8lgep9"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486b96760easo15007085e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774379037; x=1774983837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4vEcbduH5bp7ek2wgqFiKxn5o1+bgYsdM6x832qHzw=;
        b=qI8lgep9tPbob4LSlbHfewrRlAcp9lAT9d8sJ9NTrktuLZ1lc28NbZejVhYvzqmN34
         XZR/U0FmZK6uzZrwUCtrVnjdkTroFPJlHu/jX+lJEK3gmmuoRSkS7+xyKIOn23G0bmD+
         9KkLauMFJuR+SrXDpB7s/WuF13SnNfZ0VDKqv6UfMoVzJqUJeXDwfhz4jpPZ4Ess7DfM
         QPxnT3zyc1xLbnYjzE0iFbfUE3fJehPOVkfq7uU3EC+cP684hHI1cAfrCSqnjUEw5qhC
         lAgUzscgkdRQaYVgAfo9rGnSXqwyfgC1lGYQsGTFonQTXGCpYTFe6bMenochm8+MODP/
         pnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379037; x=1774983837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g4vEcbduH5bp7ek2wgqFiKxn5o1+bgYsdM6x832qHzw=;
        b=ZiK6RjLXU7/YWFN13Z/XTS1G8mb2/2RatshzF0as62qt2GUeHRHiB0EcJNw5MhD7bI
         wh/SubDgem94cWoPBcDoSZAPSzbNA8kyWevmeeuHM8QuOgbzux2W4PGXriwAma31zKDI
         wV2+q6R/K1ldNtbbFXknqDHzl9SVLPZLnSbPX66cWw3lntGKRi2e/RDgXVqLk6yxF+XV
         MVc+XRWXEXKXOr6GDUfHftFEqkGehh/hq4S4lAhZtbyXYBGuVk0kQQjRxUQgc7jfVVJ4
         zQ2h4q7vRGI5RJGQYqDpGPIfZzJq7J7nw7J40FBLbKfopIjXtoQXKpCYo/ia0ePcNOJl
         Jl+g==
X-Gm-Message-State: AOJu0Yw91H4gHU1FdxmWIEP4/CN6+uIguL+aRIy8Ge2AO4Nli5B2dV/O
	5M2ACcmPxeSto7tggh/UKe4RJWAJRz51IxwZ0epmP5y5doTkc76QBkwg
X-Gm-Gg: ATEYQzxWYVC3KuBz1ftMBhjbldi4Pxwzo90CJ975B1ao/Dnj6Oi3cKDlnZnCmV0ErxD
	rqjGBWlxqAFvPSE0PkvXybBe1SKl/MYLPhc3rvORC5w4P8qeME13Ze/JCZeUP9bL83zKNU73HuY
	jcwFtQ0qGZXrMJWb7uZEfEdaoUyY/yBsqfcgXS6ZNsfap70KayCNosF1mB7osrxzvLxWzD6NKqN
	6e8kavYUpl628iS0CNnSXJkqaE6qV2FBdP2/ICyLFmhffoe04/CVMXITQNvs6qV7MIQ9VTeDq3b
	5zEZJevbfJwUcABrWCgbxlm3zCeTuDLcc7L5mqXWYl0zWp14DwvRq5vU2A35pFNEACtEQYTPNE8
	x3Mrqdf12Ok0yIzTNtdoT21i4njYKtBEYBtm48RTc37YWOGT1VrEbR9oa3mzH2g1SW5SmFcgh4H
	NfbUFYEHluKpd+
X-Received: by 2002:a05:600c:1d0e:b0:486:ff92:63d0 with SMTP id 5b1f17b1804b1-48715fe6f4dmr13435215e9.8.1774379036968;
        Tue, 24 Mar 2026 12:03:56 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48716547649sm6456195e9.0.2026.03.24.12.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:03:56 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 24 Mar 2026 12:03:43 -0700
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
Message-Id: <20260324-sleepable_tracepoints-v6-5-81bab3a43f25@meta.com>
References: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
In-Reply-To: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774379028; l=3939;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=9ZfIL/C4emuap6Ca7YKI4DksQl8pT1DrPTyUTfS7Lqw=;
 b=Hc631usL1iov3ziTncWvhwCatB7eL7udM+pgCOZusRShp/dRkfjvciFFYmvwbtYGBIJvPHYER
 BV8761iYQWOAvPw/177Qr29LYAbnNNAnclGmHvdo5/vzwp65SlTOcVO
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

