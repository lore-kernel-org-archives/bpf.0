Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A33B19CF
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994184; cv=none; b=ROyChfMKdp63BJBEGrcQK0xkTpM4kC2uVoDi3vCXPwvod5Eb4P0ga1SJham+RYIGH6pEhRPRuCsr/MPSoA5am53G4b6Nx7UdEqTWX194QGHw7jMAuRfKk/gMlviB1AhfQkWwqVSW6rIwxgCe8uefSBuze1KEf40CCBp60nNWV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994184; c=relaxed/simple;
	bh=iTlH4Z2NunuNmz3+zsjpBG0uQjHGXDm18lz4nF4m9aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciRZE9g9+e79GCp15/qWlV9C7OQJo0EpYHxfPrzJzhrmVcArKlMvdjUQRAHgPurIsEDQyUTiRPwHzWypq7/5dmM2U1DlJ2xXZFgvpoQp26KxSZXl0LCJdjDUNsXTHWD4ECsW7iKDsdI67rjVz9m+D+AUDSFG207Weq8MysN1yvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=xWYIlVcF; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="xWYIlVcF"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e041ea211so3716336a91.0
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1786994182; x=1787598982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5pqjsgrQUYPS8LDVIHRlMp8J2KKjxmk5yKWzlo3JEQM=;
        b=xWYIlVcFdSu6s+qHfKHNET/hGMhN4WbCWctR7t6qYafiooj6jZgl7qUk8CxjCojLdf
         07c5qpcatNsfG/ag0vxDbs7HI7mIB+nwc4zGYiBxGDsHEJGoYni9ypGKDh56icMiS0a/
         24sTtuSxNLfr8O3j4w7wHFh2k8UVJ79K4GgKU7CfpDA4ayLDTCl0CnakNOvEKFt/1Lnv
         C+en9yxiB0XE61HT8g2R42UdNoaS7fJhOeYrIkJj37GqQqS33S0QqoMpv1dD6ZiETLEy
         s3B+xaupemXKYAS5P4pIip7YFCm3cpF09nwSp89BYEDvE//wSotCW1Op9+n/8yRgwm0R
         5+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994182; x=1787598982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5pqjsgrQUYPS8LDVIHRlMp8J2KKjxmk5yKWzlo3JEQM=;
        b=bytbshy5H1FxlnMA5o6+MFuIC8X+WURFWtpsDUzsB/HXbwfC2ij9XOubv6bwhH7XEy
         CsI7nDDEy3ymkbH6AomJkVwZ/AdR6N3JJLzdRPUk1fAYHhTkxQNHzC3Nh+tuor6jgFn8
         mLoxvq2WzKy7mahHCbs7Z80tnR0v1DENLqgzZvJHX9fUa8PsVDF2iMRDU+c7kkRi2mzz
         3Y8x17RVabpRaGH9ETosH7G/1N9fPMzM7Vn++BAiwapbdZrq6ij3TPOVt+fAS5ve+clO
         mZxKnWG9RC8cboIAAV4gqIVfz9oj2BepxxsOy8bjusxisIQtOMn6717JNILra79xFqhz
         2DiQ==
X-Gm-Message-State: AOJu0YxdpIS8Sd7ot0+kda6t2JGf87+BxexRbJyMttzXRDWdbh15fpZ4
	FC6bmFQx5QG69ARqxnOBg0iBFa7o7MVfGSQrM1mZjPlnmkebqiJLEWEJFUkzmEHdSyrjW6ox7GZ
	Pa8bPJVc=
X-Gm-Gg: AR+sD11MNEaxbRkwjksJqLRGmxXYov0U3XkdKBm3Ywps6X05gI9ErO78sxl2DOPCRIB
	Mwv3qUY+GEzxEzO/94GZO7Iob1+ikMY9WSSj6TILoj100qmpelQFsHcMQVCh3fKNcSetvExqBrr
	Zg2THz1US5X708Kb665aAz39ZCnJdXr7witw/FONSrLYorccukkCg87kl+Xc53tprYr07VuIrfM
	RUAIyXuw0+f4J97ewgiF6tLbgFcDr3sVPqNtdIEVHM4ViUM7/LrEwp8cQ8lXrXwBMeTPiIRip3i
	MCFxu20Zx4yEsFRm41sGF+0/evJZcYt1v5JAzko1E89m/PSOLAZNM13bmfh/CwkCbf1O1kWmrZf
	FTN8mbuXjM+ztIU4XIvH4odDtdlHxph++kaof99VVAvwPWwSt+UeDOP2WupnTw3igQi7/l0ejXu
	9PdJ/NxkP2W/I4ExpuT/Dc50BuHYhtp4pLuwy4wVSB6mXKKLisG8BWc+oOXsXm2W499Xf96VWVA
	D6agx0F40azn3dD05eit9X2jYg/Bq8KmQ==
X-Received: by 2002:a17:90b:3ec7:b0:392:c80b:8eff with SMTP id 98e67ed59e1d1-3955a7852dfmr2267281a91.11.1786994181938;
        Mon, 17 Aug 2026 12:16:21 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b62696bsm5485597a91.2.2026.08.17.12.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:16:21 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 2/6] selftests/bpf: libarena: Inline nonatomic bitmap operations
Date: Mon, 17 Aug 2026 15:16:12 -0400
Message-ID: <20260817191616.11071-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817191616.11071-1-emil@etsalapatis.com>
References: <20260817191616.11071-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The libarena code currently defines the non-atomic bitmap set/get
operations as __weak functions, in accordance with the libarena
coding style. This, however, is significant overhead to call
functions that span single-digit instructions.

Make an exception and expose the getters/setters as static inline
functions in the header. Since the function body is now inlined
into the caller, mark reads/writes with READ_ONCE()/WRITE_ONCE()
to prevent compiler optimizations from breaking code that locklessly
polls the bitmap.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/bitmap.h    | 29 +++++++++++++++++--
 .../selftests/bpf/libarena/src/bitmap.bpf.c   | 18 ------------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
index 8c5936ae9958..163e2b83d943 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
 #pragma once
 
+#include <bpf_atomic.h>
+
 #define BITS_PER_BYTE		8
 #define BYTES_TO_BITS(nb)	((nb) * BITS_PER_BYTE)
 
@@ -16,11 +18,8 @@ struct arena_bitmap {
 struct arena_bitmap __arena *bmp_alloc(size_t bits);
 void bmp_free(struct arena_bitmap __arena *bmp);
 
-void __bmp_set_bit(u32 bit, struct arena_bitmap __arena *bmp);
-void __bmp_clear_bit(u32 bit, struct arena_bitmap __arena *bmp);
 void bmp_set_bit(u32 bit, struct arena_bitmap __arena *bmp);
 void bmp_clear_bit(u32 bit, struct arena_bitmap __arena *bmp);
-bool bmp_test_bit(u32 bit, struct arena_bitmap __arena *bmp);
 bool bmp_test_and_clear_bit(u32 bit, struct arena_bitmap __arena *bmp);
 bool bmp_test_and_set_bit(u32 bit, struct arena_bitmap __arena *bmp);
 
@@ -33,3 +32,27 @@ void bmp_copy(size_t bits, struct arena_bitmap __arena *dst, struct arena_bitmap
 bool bmp_intersects(size_t bits, struct arena_bitmap __arena *arg1, struct arena_bitmap __arena *arg2);
 bool bmp_subset(size_t bits, struct arena_bitmap __arena *big, struct arena_bitmap __arena *small);
 void bmp_print(size_t bits, struct arena_bitmap __arena *bmp);
+
+static __always_inline
+void __bmp_set_bit(u32 bit, struct arena_bitmap __arena *bmp)
+{
+	volatile u64 __arena *word = &bmp->bits[BIT_WORD(bit)];
+
+	*word |= BIT_MASK(bit);
+}
+
+static __always_inline
+void __bmp_clear_bit(u32 bit, struct arena_bitmap __arena *bmp)
+{
+	volatile u64 __arena *word = &bmp->bits[BIT_WORD(bit)];
+
+	*word &= ~BIT_MASK(bit);
+}
+
+static __always_inline
+bool bmp_test_bit(u32 bit, struct arena_bitmap __arena *bmp)
+{
+	u64 word = READ_ONCE(bmp->bits[BIT_WORD(bit)]);
+
+	return word & BIT_MASK(bit);
+}
diff --git a/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
index 5ff8e688ddc7..0390f20ce366 100644
--- a/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
@@ -34,24 +34,6 @@ void bmp_free(struct arena_bitmap __arena *bmp)
 	arena_free(bmp);
 }
 
-__weak
-void __bmp_set_bit(u32 bit, struct arena_bitmap __arena *bmp)
-{
-	bmp->bits[BIT_WORD(bit)] |= BIT_MASK(bit);
-}
-
-__weak
-void __bmp_clear_bit(u32 bit, struct arena_bitmap __arena *bmp)
-{
-	bmp->bits[BIT_WORD(bit)] &= ~BIT_MASK(bit);
-}
-
-__weak
-bool bmp_test_bit(u32 bit, struct arena_bitmap __arena *bmp)
-{
-	return bmp->bits[BIT_WORD(bit)] & BIT_MASK(bit);
-}
-
 __weak
 bool bmp_test_and_clear_bit(u32 bit, struct arena_bitmap __arena *bmp)
 {
-- 
2.54.0

