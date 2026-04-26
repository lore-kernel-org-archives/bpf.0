Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F1357702
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230180; cv=none; b=g26KEb40nJ5TZuvE16OQKhcbVW/GnwMbB9JYj48dnIJwUPH5HdTK05mwSsJ8ntYvyOI5YWOla01hn6yjMT3f3RMqLlSbbmq7MJI0Lz47YM+hhiNfVBziAap8MfqixgWf2452iA1dUiVtzLNMDqr0b+tbWkFcifgTGpvSWumEF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230180; c=relaxed/simple;
	bh=4ouPdCQ5TthuW5wokGQn0/43icp8SwDR2fQ0QQ3JVi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ykj2IQoa0SPR0tUMnqBfVJZY0GARGHSFdAbhznydZjkaW2jwvrMb6WOqQr/ASwnzjt5FLeelxF01DfX4/mBJjUJqVDI2jsitnxAGvZDDQV6GioV5eSx/duLDW6tgkDKeBwXtzBrGDJKe0Rwt+6y6h1uOmJZfGZEY0vaiOAyTGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=mjlZRZ0D; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="mjlZRZ0D"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b7adb38d65so33089225ad.2
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 12:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777230175; x=1777834975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKte3GLtzAoQC6KpJOJigm/JzgYPGPBtteidmVIscAY=;
        b=mjlZRZ0DHJEnb5p0z/O4+BvnDzH7mqO4iK2AwS5C02LF8U99eOYcexITnrWiEW9cOY
         RlKTwlW+LU6fLniTfCsSZeJelSZCrH/3Bu5XBwSKTZRY6OArkbe5X3ekEUBM9b5tD7gN
         yITMN18IDpbt5xRObSWHYiRbjykpCPpdYIrB03AC6tVWV4Xhz65srIGzWmm3bPJwqN35
         Q77B/Ha0A+GgsBPigcRnAIWeTxg6Ucl06QPsPvyACNZ5nJ3h+0nIML7BAYjmkZ55oRCt
         xbauYhqxOtDUwc7Aq/xp6iui5iVcrROaDnLodM+PlfTqjvNSsoIUakB9rhvBExoSQDYk
         B9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230175; x=1777834975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bKte3GLtzAoQC6KpJOJigm/JzgYPGPBtteidmVIscAY=;
        b=Dyo0NQTiR/wOu7lR6gwO0s4HZ7ipxOi/UeNB44RaaEwbJVa+05oEmxdqYOvrp8JOcL
         f1L4yEZDrg2gxa//33G/HqPVplZSMHDiGOW+fbdMYT5UMCYmq1On5svOy6B2NZg/a3Mq
         h+tIspGxcu8DKMKKiG6Be8o+y7m+xS2axMB1Z3qIWy67Pshud9NvzTakMEW/jMsn/L6X
         ByXqPvzQkgoX8LGnrpW2DyGdPyZF6pBIdzcDRWCakV/bUjB2VSGZXzu1SVBzOl0fuG0J
         RF5trKtuEwnUUUniyKbNs9SOmBkBKR8QhhVK40XpnPcCo5CZm0FFmLhO4yKpi3zlqyDt
         oqAw==
X-Gm-Message-State: AOJu0YwHuu0J80/QCooT9VdaTcy/O5YG+rR2Z+fHWbiefeHWad50H59g
	4DTWYzblQaX4dJV45PEcCouRr4dIxonJPz/U8xpvvh5GU3nHRor0w5Tx3icb/jNPMMygOa73Zhd
	wEX8YHtc=
X-Gm-Gg: AeBDievlPV5yTJUDNWVM8Gw+aSfBLqjyLTt2fV0GFUxkcet2cOJtQo6LF71fnN4xhxX
	aV/eRdq67nVvI+1FG9cK5FLWVwg9p6+Tmb4eScrCHQPQ0GAuOjOmkr/sA+1yj09B7iylF6BfPEy
	dbY4bcz3WCy2RF9kizDeHNw8g0iW/Dxkd9I3xBU4xhuvcjLvLg0kDf1Sn0mGpxiIEO0CXZInZzI
	mNgW9/Qexdhyfr+3QzaaI8f2Ctv4Qk7tdw2O0UWd10h56o7+QAXvlSm78R/nH4Tp7IHYWaHcUgo
	0OQ5CKK4iAfeF8wee7msAprFVQkG09xDIdF1OZCSM9jPv+vyPlmK9qu3SatpYKp282/q6qXXSOY
	cDfXzIf3eu2jrqgFCi8dZ0Y1jeZzFVhXni3bRvRUbOeRbHo4lq7DLwxymi8aXv3lEX8sXgc0M8Q
	ApILqPGUwejs01
X-Received: by 2002:a17:902:e54e:b0:2ae:ce35:2686 with SMTP id d9443c01a7336-2b5f9e64c77mr401449105ad.5.1777230174997;
        Sun, 26 Apr 2026 12:02:54 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::2af6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caf1sm298935875ad.42.2026.04.26.12.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:02:54 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobfrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Bobrowski <mattbobrowski@google.com>
Subject: [PATCH bpf-next v9 1/8] selftests/bpf: Add ifdef guard for WRITE_ONCE macro in bpf_atomic.h
Date: Sun, 26 Apr 2026 15:02:44 -0400
Message-ID: <20260426190251.4456-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426190251.4456-1-emil@etsalapatis.com>
References: <20260426190251.4456-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WRITE_ONCE macro is identically defined both in bpf_atomic.h
and in bpf_arena_common.h. However, the bpf_atomic.h definition has no
ifdef guard. If bpf_atomic.h is included after bpf_arena.common.h,
compilation fails because of the duplicate definition.

Guard the definiton in bpf_atomic.h with and ifdef to let programs
include the two headers in any order. Duplicating the definition is
the simplest solution out of all the alternatives:

- Keeping one of the two existing definitions is not possible because
both BPF atomics and arena programs need the macro, and the two features
are independent. Using one should not require the header for the other.

- Factoring out the definition into a new header that only includes it
is more churn than just duplicating it.

- Factoring out the definition into bpf_experimental.h requires all
users of WRITE_ONCE to include the header. However, the arena library
introduced in subsequent commits must be self-contained, while
bpf_experimental.h is in the base selftests/bpf directory.

Both headers are moved to the arena library in a subsequent patch.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
---
 tools/testing/selftests/bpf/bpf_atomic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_atomic.h b/tools/testing/selftests/bpf/bpf_atomic.h
index c550e5711967..d89a22d63c1c 100644
--- a/tools/testing/selftests/bpf/bpf_atomic.h
+++ b/tools/testing/selftests/bpf/bpf_atomic.h
@@ -42,7 +42,9 @@ extern bool CONFIG_X86_64 __kconfig __weak;
 
 #define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
 
+#ifndef WRITE_ONCE
 #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *)&(x)) = (val))
+#endif
 
 #define cmpxchg(p, old, new) __sync_val_compare_and_swap((p), old, new)
 
-- 
2.53.0

