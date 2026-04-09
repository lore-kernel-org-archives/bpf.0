Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76FB313531
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698411; cv=none; b=jH6nhopYxYqEUp2DDyN0gZFbcFF8xxWxvm8DmBkk6G58i8033o0rNlHhX/JGhKGf6i82myxQWUNOU1cqKMS6Dr6eogktaUAVSFqXambOvIXy6Q56FT4UvLYW5l4eqku5cH6pS9Rnf4b/BOyhJ/EmrECLf2qo+1xCFeINoDnT5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698411; c=relaxed/simple;
	bh=t5vGe7TMKa4PA+BUf1OmAHHvkdGna51Al7R6d0KarEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6wszJ55QpRfAIfVAFat8j8G9iB9HuWz9hSVe4UToCb9JcbEgHxG4VBCHP4dnSKvDZs7ILFZ6/rIML9Kx/zDQivv/px+HLLk2RXApyMTMaJkqUSB/PvAk4OVuKMbQe7Pozdq3iPXtwYY/VvvGNEwRzoKuA0EOmDeqosknsbkyKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r17bO5JM; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r17bO5JM"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c2575ff49so1605742c88.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 18:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775698407; x=1776303207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHoetn2+CS1fcRHMnRlcxzWH1JFHbv0etEvUXE9LzJ8=;
        b=r17bO5JMaxWf/jgy3h16Sg/CkbQxkcyfg2AQX9jJ6x9pn74pw6p22g3LodpjxDfvc+
         GgwFCKTx27tf5+ub791yXiHocEGZ07G6oSke44rdd6gRc5mhwNKB89VG/2QaISFjRYrd
         OhvLw/cdG/X27RCINgTT6WgvUxvphaFSlAzxcCACgalKtVYKnEDGWEoh1K+Se/p0sxRH
         qM1m/485DSrs3q6wS0xmUaYRsMdsvRySxPB2X85DvaNewucVCOpgVt5Vy7wDi2lQ1oAE
         rLsp+yBCW5U4Lngr24sbc52yBjylAInXWq4/NC/lfI0RSC6VdGHIS3Mix99hg96unGtK
         F4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775698407; x=1776303207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YHoetn2+CS1fcRHMnRlcxzWH1JFHbv0etEvUXE9LzJ8=;
        b=a9DPOQsr35QFF8KrpRl2QuuzZhHPxHqhmGDyTY1hU1sME5syChVrb0s8TZvoP+MhUo
         7UY4PFrYwXmxxK+FZ2WunwD2sRZegk0BVp3Jk1In4J2p3t1x0F/spX5WPxnDa8MyBX+o
         ItgfeMRQZKoSFhn0HQoCaYpqTjGCy58T+uYqSTKgSQvb+XP7MOACGZoJnEjnNiaOmoEA
         dAxkIaf6LXLsLn4rzrhF1PP4RkBVhDtI+hiRz7aGzeu7DAlCZwSHnr1mZwMJ1PfS2g00
         tN+dDWcQKyilCMWrC17YWuzii2IMTdR//e/trC3xjwN+dyXEWTrXg8hC/wz8UkuTTj0R
         EJfw==
X-Gm-Message-State: AOJu0Yxm57YbHIsqovaBTmyMIossX9Uy3jFjZmsob4R1OuZxxEUuLVyk
	CN8buu+iiX117zJ5ktpP1eisMvT5qjXGjPi6MUGcpfGI7FIre/1v9Fu8mF993oa0
X-Gm-Gg: AeBDievK1tsbA19VZjnKT+cB/V9mlaCgbc2TtDobga3i6PY6Bye5tBnROdWMPjWKnCf
	tbDVbgQIyF/cWw76//DJ3eNsAH95tJUQK9noOTCmK3719Ycrf4CvfAqirvBZ+K4akhdUGrhtXVW
	gZcs4moGDKgg8OasqwqKeSS3CilZ5h2vG3uIoWmbVHb7apJrslObDW7mjlLa4R09NuG2tqirdiW
	tUhmR/zc3ks6JWpj21W0tQCUzxm3C6dWO9/LJCCwYjhpMe3qzu5BV03OOkX5MKMvZ6x3aDC2A9e
	wzVmLSK5s0mx8ixvzsf3RdHZqNAgZgC4DepGpqHTJ7RZy54KgdfWZwav5X9lVoakouA5zmaHPhM
	+g5ay8aErevrFzjy2jU4ujsulvXdlmxmVtgfg6Oo0dXNjLdfcME9AMFxFlOFjCHws/ZAYRwOkCt
	wrTsw5NYqpUqw0ydN8mX+Bws+3ll18XBluHuVZxg0/dpVFCP0pXycR1mK1SxRw0M1T9UwQfZXtd
	csHbFWXgEUWhw==
X-Received: by 2002:a05:7022:6997:b0:128:d7a7:526b with SMTP id a92af1059eb24-12bfb745137mr13309994c88.22.1775698407472;
        Wed, 08 Apr 2026 18:33:27 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::c05])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c0ce7dfe8sm15943230c88.3.2026.04.08.18.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:33:27 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 03/14] bpf: Add spis_*() helpers for 4-byte stack slot bitmasks
Date: Wed,  8 Apr 2026 18:33:05 -0700
Message-ID: <20260408-patch-set-v1-3-1a666e860d42@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
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
 include/linux/bpf_verifier.h | 97 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 410939d7b3253f62c18b85072c921395709d7a3a..64361cb49073935f0c218f1c4d7807cf113f8aa3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -224,6 +224,103 @@ enum bpf_stack_slot_type {
 
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
+static inline void spis_set_bit(spis_t *s, u32 slot)
+{
+	s->v[slot / 64] |= BIT_ULL(slot % 64);
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
+/*
+ * Return a mask with both 4-byte sub-slots of an 8-byte SPI set.
+ * Each 8-byte SPI maps to two consecutive 4-byte stack slots:
+ *   spi -> slots [spi*2, spi*2+1]
+ */
+static inline spis_t spis_single_slot(u32 spi)
+{
+	spis_t m = SPIS_ZERO;
+
+	spis_set_bit(&m, spi * 2);
+	spis_set_bit(&m, spi * 2 + 1);
+	return m;
+}
+
+/*
+ * Return a mask with only the MSB (higher-addressed) 4-byte half
+ * of an 8-byte SPI set. This is sub-slot spi*2+1.
+ */
+static inline spis_t spis_msb_half_slot(u32 spi)
+{
+	spis_t m = SPIS_ZERO;
+
+	spis_set_bit(&m, spi * 2 + 1);
+	return m;
+}
+
+/*
+ * Return a mask with only the LSB (lower-addressed) 4-byte half
+ * of an 8-byte SPI set. This is sub-slot spi*2.
+ */
+static inline spis_t spis_lsb_half_slot(u32 spi)
+{
+	spis_t m = SPIS_ZERO;
+
+	spis_set_bit(&m, spi * 2);
+	return m;
+}
+
 #define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
 			  (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
 			  (1 << BPF_REG_5))

-- 
2.53.0
