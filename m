Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A236C0C8
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105037; cv=none; b=MKRzU6RSjC3LqSo9DDvgi5yWMNqT0lv3e0b/d9tGVsfpd6mjeebCZtMHkk4vvZHH+Qt1f3/EVQae1z/WmjNKbbWZvXs9HkcUh/iT3PjdS6RxXspaCf/Q3oFItc1RwG+vOLX+0k+crLYlD0hGtPxtW7ECKVfCA5DjdKkzlPWpqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105037; c=relaxed/simple;
	bh=5jRdTuwUhZAaumSNEYufeFsADb6/Se/xnS3/U7B4ubc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hIubmNcSXa9p5rN2onuDhiFSAe3M5KpEet5fp4PXEOgOcKEbIwVfKTfSOiL9AjDjZZ4eRhRmfVblb8G1ElcDxK1f5cTmCVt3Z3wST6R5m6UrlFj8vYlJjPE+irrliK15Mx9WLdgwzWcKtyJwELgSAR+MEVwTJKu0fT3c+02yObU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6gZAC64; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6gZAC64"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so1174626f8f.2
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 10:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769105030; x=1769709830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6IoQXN3Ba2g08NHbMeHbZAWe3CwXy2tKRnxNnDKDv0=;
        b=c6gZAC64w6u3dDckhTVb0me1yELxadcFDbWxzKQHjbvPDdnafv7/WlMianXOL6SXWE
         42sIwAiY8PyBiRaqiXeDb0+DTYZRp2VgYD7EaJd3aiBlEk73pm7RBXg4QMRgpZl3nXm/
         gUGl4ZtN38Rny+iC7Mm4MYmTDFfQmqG6Sti/dKOZ6tV/89k8JT2qx6PqB07xhvcIdrTn
         ZWY6b2SFHi6SpqpixO0r2vALRaxjvLsns4gvvV7gRwY5ME4CZ+SfOc6igLPog73PTupI
         5AP9L6r1yUziA0BvtgrKVLFCRKMBjwMPg+Bmvx31vgEnqNPN01qinjnLdTjCA1Hm1ylC
         UB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105030; x=1769709830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S6IoQXN3Ba2g08NHbMeHbZAWe3CwXy2tKRnxNnDKDv0=;
        b=UgxY8dUWY2kcuiqOvsyf/ssabzs9q4VxsOJ7VhL+Q5HFFb3zKlHREUZLNLsxMvEvLv
         DkpM3sAT8fEVzp1GuqVpUrU8weJ22ytofSArWa8fiDfjaSD6bhqkmbK97NfyEwcncurG
         lu0M9aLyxeZFdz7SwD8ae51Wb8eCkmt6HRkZJ5ac3ZP4BdI7/kX0WTXa+A4DhR1G/Fa1
         8RwWiG85Ju1pLn9ow9H5ikZtoY4DzOmivBUD5rRM3EqfjN7wDW3JweDyESptgqsddPRC
         E3mjamYfMcuQCZbjd4pya8dQd7dFfm2ElCrH+AvJ0R7PfMWuaDdvoDPdoLHEqTPShn0N
         FPhQ==
X-Gm-Message-State: AOJu0YwePjRSQAG/6OloMEsZojhl7wCt+LAP61QGlbUKN3RYALeg0YNs
	5+HFvRzHxtOFF7EmM4PjKxNRTBJCI0YEaut+g16cnm+Tbi8RFZ1fc3i2
X-Gm-Gg: AZuq6aKpZfynlKZhjpvTWH4Cyo8gMnYX0Bde98t0zAlH6x414bHcn1yOxq0SEC5GC4P
	lBYh9MlhL5jFAKcswc/Xxa57jiqyKT1nfEXHsFVWsxNYk6NEHhDPypfZwO/q34UUPmKKAdsg9nq
	z4g96JlKaCFp46Py5BkfjaJht/id8udtKVXY9LjvpTuMvT0zgYizYsioQeGLqsRnQcaeKHLft4Q
	j8s1vnY8d6Okc1pZ4GE5meRlCgG4RvN36/PhBE/mliLAfNdZLSucIBKILK1JS676sA3HI0RIiwr
	q94dqlQnA5H4SbovcWdHDJMbSp9n0Ab45EU3w21kO8yTAaQThuLAtxjY446vavCqiJck/qv7ZYr
	UotHpbpINm9QTv+oNumNU8usOkzAe3bxebHpSUMm8Y9vnr6X92AR/AmZJ87E52apg4sHeHxZFZR
	B6RAgdfKJyudQj
X-Received: by 2002:a05:6000:2313:b0:430:f5dc:d34a with SMTP id ffacd0b85a97d-435b15f8986mr826431f8f.29.1769105029878;
        Thu, 22 Jan 2026 10:03:49 -0800 (PST)
Received: from localhost ([2a02:8109:a307:d900:df8b:2445:a6ca:bb5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e715d3sm345369f8f.28.2026.01.22.10.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:03:49 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 22 Jan 2026 18:03:21 +0000
Subject: [PATCH bpf-next v7 8/8] selftests/bpf: Removed obsolete tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-timer_nolock-v7-8-04a45c55c2e2@meta.com>
References: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
In-Reply-To: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769105013; l=4020;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=fl4T2+GC7fB/8ww4SfQYQIu2HzHZsOIJ5LkoKve9x0Y=;
 b=P13ZdTjRYNXQnyb0uhr4kF4xwc5gmhIBh9AqEDq+yTWP6L7VKUDQY6opIqdQ36J6KGyT6EQjK
 wofPGWAAoUjCuH2MwM46fQtaG/jMjJ1pqpcT+z6GDmBgHAOfZhGgzmQ
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

