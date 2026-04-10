Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9093175A69
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783512; cv=none; b=rWh0lH6xUu80+johF41gi92kF2/o+q+kvbi8pVGaibfWr9hnxnNPkMVx97ZrY6gJuRJXqiHhGYQZB+ofA/4Csudd1l4g2CUgc/jdDxi+Ay0Ah+wGlykQ5wrUmo/rzEb/SU1dg5vw08iGoamZDHRo3dpQCG/hmaqVaTzgiWmakI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783512; c=relaxed/simple;
	bh=xN+bWu4IBfGjrJKBX7HhrJ8Gc0RF27oIHiSnmSjs8oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYT1qv+fxGq029y2aAwsmc6cjItd11Yiz3TN2wGUHY3par8Xda2LM7crjG2Vtl4BJBVnnzXt8k/k+zDlpxYY2qwkh8rzhOl1d80+CVXgnxQ+qFeIBrd6YUkNxJsfHzQIDlPjuYW6D+mhJrewYYyvodn+g5TiHIpkpvF7xDV3AbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H05GPXP7; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H05GPXP7"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso810407eec.0
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 18:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775783510; x=1776388310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQrq4CjBDp27PWZZDEheQFYNQBJV+Q+638LakE1dMow=;
        b=H05GPXP778CnCmBc6QSaZyrzCS4fZmz/vDRBFBdA6v8MMxtyI0HzuJFVrzbj0Rm72O
         30fDzx4Ubti/z0DQINfkFAAtpmq1wxnLEwkcnGDkN5wnJvZiGUCxjRFhtyn03RNxE0Bq
         2vG/5xYsELBeq5xG7rSHpT96Orf1nC0/Kt27phG6kddeEjZV/e/S3mlBsZ2JgRARbpk2
         j0VHXkPwqIGwWtd1C2Phds/e5JNASPoomZwaN/JExnU8ilIFND0u2tX0gN5lbdOLuGuP
         AiS5509dr6mpFiIlRdF17CwdTB/iPcV9/T/CvmpVDRGqmLtHQiKlzN2YJh+vr4dGSaSF
         LJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783510; x=1776388310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQrq4CjBDp27PWZZDEheQFYNQBJV+Q+638LakE1dMow=;
        b=WTBU+ANbDChmCcOEmQ0cop4h6gCfq/7i6JvIVL+5etaHHLVkw1JX6UhVqzfquTg7HF
         csimcy0osFa4qiHEeubNY+PLupr+FV0vEFZusy9ztq18cT8ShRuCH21k2CBLBOqH559h
         fZguHz0PaY0uHkaDblzvWM68w/dXcjvoYU3wQxIOar1Bz1RVmMkU29rerSuPNm+cDBj+
         6mP7Tp4rGJttepy/YpraY1oDEZ8OZ2zM3KOhS3Tja4jbhNFfafb/xrJgd/a75w+B1f0f
         nOefVGwVnp4Ro8gX14EWdIQfnBxsTSi/cdxK5yfbo0q/X2mL9ErAF7Zil0huD+F9ejUV
         z01A==
X-Gm-Message-State: AOJu0YxoGZ4hMEjjmv0B+dJv6K79sEiaIVFhdHUuPwmoLQVONJTYHeF5
	mVIQI3m7XNuXVAH037EPNMNv3qWWroqicBze9TxbXE9GJD+CI2AdfUBvgHN+IYQn
X-Gm-Gg: AeBDieugNbm2AcWU/wiEgrkZqMhXa0c3KOG1xGh1Gnbt5/Ed/5PaUUTl6+RAC8Z1CRx
	7mexv+nRWsZmA7SRY5CHxlS1No8nWEQkNHVBmEa9m8JvezLYUpIvIbzdXvFCOSX1Wzdpp0YTsO+
	CxdF58+1e0aDiSfKYFsAX2QhNngBG1EK3Q9vxsPOu1aks7oqmXP11+I2jQ5W7gCV5BggZqb9Kxa
	94NoZ5i7A3xXGGcs2jdiqOQw4hNRreHs6awUFzfIbnFYqW9zLJx9qFM2XxsFKw6Mmy24IJomKuN
	jlosQiS1y+LGeAmfRQi0XTe2NdE1DsBYRdPyBUzNfnGvHmfXIiY4M/5tM9Q0E/1f7Y90LH2Mt1o
	pRRGBUZiELzjRq6NFkr7afMHcZdLz39Jb6m9IWnGQVGx4899aeuRLPRS053yvVtXqqbbJptzWIL
	6vKNV7N1P1nfqfJfKiwy/F0Msj0nZTaz3wG3L2lY3DMv+jagrIJfpS4QnnD+BXwJVgt+FQJP7X4
	Tu703I=
X-Received: by 2002:a05:7300:fb89:b0:2c1:7480:ff9b with SMTP id 5a478bee46e88-2d4106c7c60mr2640809eec.18.1775783509800;
        Thu, 09 Apr 2026 18:11:49 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm2174922eec.23.2026.04.09.18.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:11:49 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 03/13] bpf: Add spis_*() helpers for 4-byte stack slot bitmasks
Date: Thu,  9 Apr 2026 18:11:22 -0700
Message-ID: <20260409-patch-set-v2-3-651804512349@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409-patch-set-v2-0-651804512349@gmail.com>
References: <20260409-patch-set-v2-0-651804512349@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add helper functions for manipulating u64[2] bitmasks that represent
4-byte stack slot liveness. The 512-byte BPF stack is divided into
128 4-byte slots, requiring 128 bits (two u64s) to track.

These will be used by the static stack liveness analysis in the
next commit.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 67 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 410939d7b325..124828c9a916 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -224,6 +224,73 @@ enum bpf_stack_slot_type {
 
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
 
+/* 4-byte stack slot granularity for liveness analysis */
+#define BPF_HALF_REG_SIZE	4
+#define STACK_SLOTS		(MAX_BPF_STACK / BPF_HALF_REG_SIZE)	/* 128 */
+
+typedef struct {
+	u64 v[2];
+} spis_t;
+
+#define SPIS_ZERO	((spis_t){})
+#define SPIS_ALL	((spis_t){{ U64_MAX, U64_MAX }})
+
+static inline bool spis_is_zero(spis_t s)
+{
+	return s.v[0] == 0 && s.v[1] == 0;
+}
+
+static inline bool spis_equal(spis_t a, spis_t b)
+{
+	return a.v[0] == b.v[0] && a.v[1] == b.v[1];
+}
+
+static inline spis_t spis_or(spis_t a, spis_t b)
+{
+	return (spis_t){{ a.v[0] | b.v[0], a.v[1] | b.v[1] }};
+}
+
+static inline spis_t spis_and(spis_t a, spis_t b)
+{
+	return (spis_t){{ a.v[0] & b.v[0], a.v[1] & b.v[1] }};
+}
+
+static inline spis_t spis_xor(spis_t a, spis_t b)
+{
+	return (spis_t){{ a.v[0] ^ b.v[0], a.v[1] ^ b.v[1] }};
+}
+
+static inline spis_t spis_not(spis_t s)
+{
+	return (spis_t){{ ~s.v[0], ~s.v[1] }};
+}
+
+static inline bool spis_test_bit(spis_t s, u32 slot)
+{
+	return s.v[slot / 64] & BIT_ULL(slot % 64);
+}
+
+static inline void spis_or_range(spis_t *mask, u32 lo, u32 hi)
+{
+	u32 w;
+
+	for (w = lo; w <= hi && w < STACK_SLOTS; w++)
+		mask->v[w / 64] |= BIT_ULL(w % 64);
+}
+
+static inline spis_t spis_one_bit(u32 slot)
+{
+	if (slot < 64)
+		return (spis_t){{ BIT(slot), 0 }};
+	else
+		return (spis_t){{ 0, BIT(slot - 64) }};
+}
+
+static inline spis_t spis_single_slot(u32 spi)
+{
+	return spis_or(spis_one_bit(spi * 2), spis_one_bit(spi * 2 + 1));
+}
+
 #define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
 			  (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
 			  (1 << BPF_REG_5))

-- 
2.53.0
