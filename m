Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEA636EA82
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542346; cv=none; b=Fkn9WBzFTev+hXF85LncRCxCuMaayYLZ0jAO4g+fJnQ8jnMLL9SO2c/j2hsDOimDxvWIV8UfISLS8UOHjEFoakpMB39/s70RspfR5kiI5ya8bQJVAfrWfIfEe1q8GdcsGVZLTIJz7f0ymTI6sKI0sxlho5hGhjAqTP8Rs9mwX9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542346; c=relaxed/simple;
	bh=5jRdTuwUhZAaumSNEYufeFsADb6/Se/xnS3/U7B4ubc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUcQryyFmptHiC8J0lU4XrzUV4aNHRTJZiRQBEpUPXSx4+U7Pp/6aGV9uQKokjaVG9C7LoHqAY3coXtbQqRKYsZ0hdCpsyNVYcmAFrhtHZQ6jL746kRzGHkZ500Zl9RWwU6hEVdY42l7IZlM50lkKNEhChalIQCZAfpB8zcXjkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9PU7DDZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9PU7DDZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso62074475e9.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769542343; x=1770147143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6IoQXN3Ba2g08NHbMeHbZAWe3CwXy2tKRnxNnDKDv0=;
        b=i9PU7DDZEnGV2aUwJMubQ44MlAb3wHsB2lLu4MM78HXfbHTyp2NgwOloCLQ5vWNdtG
         C2hq3uLrLC75tMYikG4DZvBgZlnHGuUO5SvQeXedJ+qqO6PxxpTGQEhvG7qS2cpCpdg6
         +PzJN0cNyB9DkALdBNA/pqKsveuieN+bSuMYCfTf+ye7TIukTdLVdMGBBvFbqmC+Ho41
         EaUlFYG86f/okuWYf9Ttm4iXAsr2ic+jw3j6+aPx8W37F7HFyEozIRkU6p66A10MzPaF
         zKSaHSGcVDZXjOuTzvPJCgSOqBGTtXTSjpWSyxCHbSzglW2TYUz1XtiIzyAMSPVzULyY
         f49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769542343; x=1770147143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S6IoQXN3Ba2g08NHbMeHbZAWe3CwXy2tKRnxNnDKDv0=;
        b=d3YxaSEaXlILFo4acuz0yUOk+n2EYP+QxukEGovhKm7Tr+6a/YhpZbVpNhcj+iYmu4
         4HxvFlECZjKS0MwgqgTIUhZc6ne5z3RBXBYEpN2DnU00o+VMivZBn+PsWlta1i82/fGX
         05WyBOnEsGfnB0xNK032aBfsOmKRe50ktVmMYHtea5U1V574gW0S2hmsun+vmYk6RU/v
         W84C3nW1TYnHypxPmHH9B6WL1+KqAoUmreejxGsyk2S8snZ/k5mkbUfQZFhehucVCHhn
         Mn2rGeRboBu+cpdtILFxWGoX07Jm1/2wS15LG72iut68IbA+O0sw4HI2+0V2sxxU0NJl
         moBA==
X-Gm-Message-State: AOJu0Yw/DFOKFZv1hVYHrLpt84DlIfbW0Gf1sFrh+FmoyW7+rIPfRpPJ
	cjiEql6Cc152xKi1GTU0PExEJ13BseGjIo5DVrVUDR5Qb0SUQCcp/WxQ5zh7yLMQ
X-Gm-Gg: AZuq6aLNgryeLKeqlr2YG63T4DjRN43/2gZHu7QpM/z8ZnZes43FhiduykubabiN5xI
	X2FvVQzGRRxYfL04V2yBJUchbmfcQdMjh+MfLCVmQGJrbyj0wuQi887/8ghdb4UI5ftAmgH8xHM
	zBYsjSEVPAPd5DLaWplphGoo9YiF9Z+NbIksbFlCAM+5ksjfZkAcpo+K2RFf4/YDH8HA901qPM4
	up069Z8Nm0lAMIy5/uQlPHcPwVCFw2kWU3S/UvOCg/9lZIEMdmjhgPocllTFdBw6e/FIF9C0Ra9
	RVUc17oU6lYc/lLtSawEjt5PZuLM4zyosk0gV4mvESP0DXY9FM+yZ1PluUzqxkJQdnPWmydnCBa
	5X4OUAXUmPDicu4ZZ4I3kLdUAr4E2zDnb8Y4JH8RT1yBLfWsb6G+kSZlf8R6oNpdk5h3VLyaVfg
	lhTPnFs9MgKufXzHJHXCwfs7Onje48Vw==
X-Received: by 2002:a05:600c:6095:b0:479:3a89:121d with SMTP id 5b1f17b1804b1-48069c6223cmr35083345e9.36.1769542343496;
        Tue, 27 Jan 2026 11:32:23 -0800 (PST)
Received: from localhost (i68975BB5.versanet.de. [104.151.91.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm83043945e9.4.2026.01.27.11.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 11:32:23 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 27 Jan 2026 19:31:25 +0000
Subject: [PATCH bpf-next v8 8/8] selftests/bpf: Removed obsolete tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-timer_nolock-v8-8-5a29a9571059@meta.com>
References: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
In-Reply-To: <20260127-timer_nolock-v8-0-5a29a9571059@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769542292; l=4020;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=fl4T2+GC7fB/8ww4SfQYQIu2HzHZsOIJ5LkoKve9x0Y=;
 b=kCGoED38mf99lzOIaUhmTBRt70aMCSgINZ0DeEVny20qRTHTwkjgFQ09a9Kd7K0NbSauqSc1z
 atyYCG/YmkUAo/Q5WeMFpjz/QmFKO4sLe7c+jSevjo8nWABIymipqx/
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Now bpf_timer can be used in tracepoints, so these tests are no longer
relevant.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../bpf/progs/verifier_helper_restricted.c         | 111 ---------------------
 1 file changed, 111 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
index 059aa716e3d0badba8a62ff3c957ce0847e72001..889c9b78b912e444d22b92eef5d524a35fe9e595 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_restricted.c
@@ -17,17 +17,6 @@ struct {
 	__type(value, struct val);
 } map_spin_lock SEC(".maps");
 
-struct timer {
-	struct bpf_timer t;
-};
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
-	__type(key, int);
-	__type(value, struct timer);
-} map_timer SEC(".maps");
-
 SEC("kprobe")
 __description("bpf_ktime_get_coarse_ns is forbidden in BPF_PROG_TYPE_KPROBE")
 __failure __msg("program of this type cannot use helper bpf_ktime_get_coarse_ns")
@@ -84,106 +73,6 @@ __naked void bpf_prog_type_raw_tracepoint_1(void)
 	: __clobber_all);
 }
 
-SEC("kprobe")
-__description("bpf_timer_init isn restricted in BPF_PROG_TYPE_KPROBE")
-__failure __msg("tracing progs cannot use bpf_timer yet")
-__naked void in_bpf_prog_type_kprobe_2(void)
-{
-	asm volatile ("					\
-	r2 = r10;					\
-	r2 += -8;					\
-	r1 = 0;						\
-	*(u64*)(r2 + 0) = r1;				\
-	r1 = %[map_timer] ll;				\
-	call %[bpf_map_lookup_elem];			\
-	if r0 == 0 goto l0_%=;				\
-	r1 = r0;					\
-	r2 = %[map_timer] ll;				\
-	r3 = 1;						\
-l0_%=:	call %[bpf_timer_init];				\
-	exit;						\
-"	:
-	: __imm(bpf_map_lookup_elem),
-	  __imm(bpf_timer_init),
-	  __imm_addr(map_timer)
-	: __clobber_all);
-}
-
-SEC("perf_event")
-__description("bpf_timer_init is forbidden in BPF_PROG_TYPE_PERF_EVENT")
-__failure __msg("tracing progs cannot use bpf_timer yet")
-__naked void bpf_prog_type_perf_event_2(void)
-{
-	asm volatile ("					\
-	r2 = r10;					\
-	r2 += -8;					\
-	r1 = 0;						\
-	*(u64*)(r2 + 0) = r1;				\
-	r1 = %[map_timer] ll;				\
-	call %[bpf_map_lookup_elem];			\
-	if r0 == 0 goto l0_%=;				\
-	r1 = r0;					\
-	r2 = %[map_timer] ll;				\
-	r3 = 1;						\
-l0_%=:	call %[bpf_timer_init];				\
-	exit;						\
-"	:
-	: __imm(bpf_map_lookup_elem),
-	  __imm(bpf_timer_init),
-	  __imm_addr(map_timer)
-	: __clobber_all);
-}
-
-SEC("tracepoint")
-__description("bpf_timer_init is forbidden in BPF_PROG_TYPE_TRACEPOINT")
-__failure __msg("tracing progs cannot use bpf_timer yet")
-__naked void in_bpf_prog_type_tracepoint_2(void)
-{
-	asm volatile ("					\
-	r2 = r10;					\
-	r2 += -8;					\
-	r1 = 0;						\
-	*(u64*)(r2 + 0) = r1;				\
-	r1 = %[map_timer] ll;				\
-	call %[bpf_map_lookup_elem];			\
-	if r0 == 0 goto l0_%=;				\
-	r1 = r0;					\
-	r2 = %[map_timer] ll;				\
-	r3 = 1;						\
-l0_%=:	call %[bpf_timer_init];				\
-	exit;						\
-"	:
-	: __imm(bpf_map_lookup_elem),
-	  __imm(bpf_timer_init),
-	  __imm_addr(map_timer)
-	: __clobber_all);
-}
-
-SEC("raw_tracepoint")
-__description("bpf_timer_init is forbidden in BPF_PROG_TYPE_RAW_TRACEPOINT")
-__failure __msg("tracing progs cannot use bpf_timer yet")
-__naked void bpf_prog_type_raw_tracepoint_2(void)
-{
-	asm volatile ("					\
-	r2 = r10;					\
-	r2 += -8;					\
-	r1 = 0;						\
-	*(u64*)(r2 + 0) = r1;				\
-	r1 = %[map_timer] ll;				\
-	call %[bpf_map_lookup_elem];			\
-	if r0 == 0 goto l0_%=;				\
-	r1 = r0;					\
-	r2 = %[map_timer] ll;				\
-	r3 = 1;						\
-l0_%=:	call %[bpf_timer_init];				\
-	exit;						\
-"	:
-	: __imm(bpf_map_lookup_elem),
-	  __imm(bpf_timer_init),
-	  __imm_addr(map_timer)
-	: __clobber_all);
-}
-
 SEC("kprobe")
 __description("bpf_spin_lock is forbidden in BPF_PROG_TYPE_KPROBE")
 __failure __msg("tracing progs cannot use bpf_spin_lock yet")

-- 
2.52.0

