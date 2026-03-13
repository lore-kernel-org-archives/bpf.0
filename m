Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3769382392
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435903; cv=none; b=fmMCAZx5nIS1RN4ifrtdIclrHUFTiBhi2q3/d5usZE22lmXyYa9D9HVMv27xauzN+t9EFwo7LMwKGZL6Ur97AsYiE83ZQ86j66EY4+suooTBI9H5TpYrnO0gznQ1WTKuZBjpLSbSgonpcEI12/qPEmfBDzsRPFi92esc1CAIWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435903; c=relaxed/simple;
	bh=B+ri6C3W/IqDapcyAF7rNWxXdNW/PGtG7QnADHcQOdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q0T2u2qs2G7MYmTMrK9LwVgUwLmGfSV5hIBXiIN4VbHV9sc0zvGDbMumhjSAvW48+OXG9BqPu7217gzSnwfbXgodJr6+0Fp8UUaEEuGSbeYgLg4Av2u1Kv1+d70Q4UuxqKlPB1iqPIseHbMExyD+s4mQztO2/Qc+MMiS6uGjFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuG20jEt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuG20jEt"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so2175292f8f.3
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773435900; x=1774040700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdW497dvfae56ZFXWNu/BxbSFp6GIyE2sTPgPLKcxPo=;
        b=BuG20jEtTnUMqp6Cd8DWd1JlM1DRYDrg+zTKvO5sDJGb7WPR6syM8nS9H/Ue+Qy2ZA
         jSpncExhHcXUrvoqpiWlTJKhkKI1VWtcssDSIK326SXmMU+iYH62mAl3E/MUOOZstjg0
         w/a56bJH2Yli0Trc7xr8WRoZmYDmLNLB6+wRVYQckCNWNWzcIgONiixqXuyY8DwLs/Jv
         qxyb0sWJ/DZBG5g3zkaBFh87pBnccdIM5xHKgU/wu/9aEqp1bnnK8IZgELXSwkFX/W/L
         R4ae0zxLYf8rZ9QM7RLidYEMin59eNTZx0eewC6qyXO/uhLbniTuVIizo98XnZ/+2952
         QcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435900; x=1774040700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wdW497dvfae56ZFXWNu/BxbSFp6GIyE2sTPgPLKcxPo=;
        b=AfFZghvNSsGB827tk+JTIe5AhK/ebINRrVkbLDmpUInKBVKPXHlbYmn42xwK4k7mw6
         IDUA7hsBn/z8i/7kUDvptiwT7RLHiExA21hz8ZlsaxyHw6pRbi+n4wIaDiIlUDH123qx
         SpSd3IlroQIRNm5DDXOYQXl+jEUV77Uiiv9uDFsmEgpLqEAL2gZTgGDhimiaeBl9N60H
         y/iF+rB8KZN387KGJgSJFya9hqf3Mf2TcKOri1Bq8ceyXyTlAqeqMIDMP6YasrGQZxeW
         bwcTSsUcCVl8E1hfBdkcokCLMWU6tGSgFXHJN4loys+utIH8d2fPBw2ee9jkstytWD0g
         L2Yw==
X-Gm-Message-State: AOJu0Yzy905jSsFcIP9njo1pWqjnQNY3bCItUnfUHHc5QWM5WIhpt0NY
	UjwTcqLjyyNkKso5LsW4dWE+e4BybWOCAubLBrQPNnF9HlQUlG7hSyA7
X-Gm-Gg: ATEYQzx/hOE8Y0GSCcGGiGbdGzpGP0dvFIR9D6NimX4wboDRZChEm6++3q11Vlt3G7f
	oLW2wh8LRcmoPvxiPUAimdd843jvy2gXeyke46YFic+unhIT83O57nDmHuGNjR65QG2VUSoUoMR
	LWwtlJVdmjhNbp2A/d1hj7kymhdqWnQ3s7xFXgFbJvJ4RdNIJLGSW3PVLy96vZTZRymmLgEV4n7
	xP8D6dpWaPlP8eoPqszVRjYrBLLguWFBaNFRUqV0BxkA2FVrQsa81iQnS2ny+UCJFOQRG9Eqq0I
	fRYG3EGu97qAeDfbpjm03u3E0n9UzByejlwmrgH/oNIENzUrfODE9OH3AucEoIslLV0A7S63M24
	MAOPnmEX4w9iErVbbcKtRkMG9/dIznZlNjmNHcXiNBL2KAXMvHPCmqvQTFR3ZoNxCFMkJUx3h94
	6PrItzsQpRxaIphR/0
X-Received: by 2002:adf:fd90:0:b0:439:b3c5:ea20 with SMTP id ffacd0b85a97d-43a04d75799mr7081005f8f.5.1773435899806;
        Fri, 13 Mar 2026 14:04:59 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe23afc5sm22772183f8f.39.2026.03.13.14.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:04:59 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Mar 2026 14:04:24 -0700
Subject: [PATCH bpf-next v4 4/5] libbpf: Add section handlers for sleepable
 tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-sleepable_tracepoints-v4-4-debc688a66b3@meta.com>
References: <20260313-sleepable_tracepoints-v4-0-debc688a66b3@meta.com>
In-Reply-To: <20260313-sleepable_tracepoints-v4-0-debc688a66b3@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773435891; l=3566;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=epDyw9IhjbmaC5/9DGsy9/9ebgpS2TeGWAs17yQPonw=;
 b=J9h31A5EHxge3w6yPRMp0AahrALNu2zKi5LO32zTayoXSUieoOIdbRsUzH+/uweOMJjjg/bxn
 vTC+vXyj8V3AhZSn/B/znL8kvi0meI8tZroz9mHicFWFRaVlAfW9tLo
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
 tools/lib/bpf/libbpf.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0662d72bad20..ef79a980c0bb 100644
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
@@ -12985,7 +12990,14 @@ struct bpf_link *bpf_program__attach_tracepoint(const struct bpf_program *prog,
 
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
 
@@ -12997,11 +13009,19 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
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
@@ -13065,6 +13085,8 @@ static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf
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

