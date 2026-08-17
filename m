Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC17937BE72
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994183; cv=none; b=HSqK2ZtCRWEaAGUdQMrJ5X0+eoozT1cjPghdiaW6WpY90uH7JB8P3WY2l8n/mD0KZvFci8P1OiVcW897gIZoKdmklpTVC1cFgRbY4KlyqRih3yfsyJlOxAP4Eid15GkqsorTu8shTduo25WMHxGK9tpmxTYetoda0d5NbJyCeRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994183; c=relaxed/simple;
	bh=LykVxy0GGMwLM43+P47yON3a3VEWvDWu4MFxsiXm6qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIELCmFh5kIRAOu09F21xJI+LwIIhikqyEmwHpTNowSuZVw63i09WCoUADUZf1VOXMZp4/CBokhjUSKDU8yX+k7v0FdwgqozLkukalMGKDmGevunKuNC6WeVQmKby+Z3OOHhanTkxG2ajhmYwAgcaxNf7NPLTdzhFC7xpT/WHJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=t912dZJp; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="t912dZJp"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38f620399a0so3309524a91.2
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1786994181; x=1787598981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hoi0fX2ObRusFR2K2zJ1pydOrmpwTieSGv/qGzhr7c8=;
        b=t912dZJpANC8a4QriO1ISF9rNGchLEAfVAyhOHM1B9A4dyY+xYSpowZ3syQt2KQL8i
         rv1nlpD+OjIB3KeTylvqqNsLk33Lr8nluB0uJqbgERL5NMBMKD/E345PXLViFrQNd9TP
         9NiZ3FSK3RYvlV5TfH7IyvgBuNKmOfp8xI6DAXDomWZXxJqMfe6gf9rX8mR0m+esbw39
         Nl+eV4zMQhRHzuc0Y9tlsyzZPvVSMD3m0uPVsw9Bzh9GokvuwokDhiYUSKSLqstID+2A
         WDwKn+e1j9Q7LuC1mXORRKo8Ld4mCQBVdFt7n2YZGJFQkJ2MMGvU3UJYaa8aQ0BukKhD
         oN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994181; x=1787598981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hoi0fX2ObRusFR2K2zJ1pydOrmpwTieSGv/qGzhr7c8=;
        b=Pouwh4b1CxB/h+nJ+91mkSdYOhUk+ofgyvRWbrUQu08I/1vXLyxZJ2CErSHgCypnGc
         Sft26gyyashbEIDIMz3NS4w9u2tCAnyWjhZXLYB5j16jfExQ3T82C19TO3nuSThQs5e1
         Vfoii92UMofltPA6LRn4ovddttIiW8eT8ODdMY7YxKmYo0XTLhPQNWTWnvpDQvbmSgcT
         V23JN17y9+QfCNtDkTqCzGNJlt7JdJRvOxUMm4+fLQ0EKnNHdJFVcUpxB+zg6/Rb4jPq
         sSAQ/fHxH0WYE8fCb3Z1tyM9qm71foQ+fFtkgjn6obs8e2FxLgHMiedDs8Kc4bHgtyrv
         lf4A==
X-Gm-Message-State: AOJu0YwWDPdBb2DYK71G2/x17dIyYxlMVA9ajkxtpx3S8P8ykmw0EeOj
	0XqskGBjWJQrtibM/Ww5qNnubxyd1mp80KOsY1RZSY06FG0mSznrL5d6yCsxGsCjEFXaQnmCyT8
	TRGkm
X-Gm-Gg: AR+sD11F/RF6YnqPKiKrAjUha9JHsFTGllaXJy7zpfMDRqasIdqeY2WgOa9kf3tT9mc
	02JVOQZTcmPZ6TT5lvfx0BAc13PE8B2Ua1/6s78Cy8gAihPTx1SFkyHUl4hWSDAFljVKYP/igJa
	EtYY46n/x/WB905WHSXTTScCtYamJSHDu1zCN3aJsQp4xm9JGxsq8PF3pqeGmGnEr0dbujHv3no
	zg1PnYlaSDvePOecOkHqU7Mwfbj4KhVOL2tzb73LEseFNakdiOkMOH+XGUGOfdd8jmV+kNXB6IA
	VrgmbtuOkB7wBdo8XAcWEe1p83vPuv80y5KY39p6hhhbcTzKiTLsohsu543k4xIKQPXlheWuP4L
	5cXpS7p8nXoFzT6w5jLLrtMkcQRedkyjj2cCyV/pGU8x5cKrXxT7rv0VqCWnzRvwQGNUpoCYC3t
	JITHZ3HTjwHnDGIyta0Dg6+TeSkjkD5gyATPi6Z9Sx7KuIIE9ixBWtTXPW8Bk78tioPfp2zzUIk
	7j/c/K9+SXqJx+tRdrmGiw=
X-Received: by 2002:a17:90b:3845:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-3955aa3f2f7mr2224068a91.15.1786994180804;
        Mon, 17 Aug 2026 12:16:20 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b62696bsm5485597a91.2.2026.08.17.12.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:16:20 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jose Marchesi <jose.marchesi@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/6] selftests/bpf: libarena: Normalize SPDX headers across files
Date: Mon, 17 Aug 2026 15:16:11 -0400
Message-ID: <20260817191616.11071-2-emil@etsalapatis.com>
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

Normalize SPDX in libarena for missing/inconsistent headers.
There are currently three files missing headers and two of them
(both originally authored by Kartikeya, CC'ed below) that are
GPLv2 only. This patch ensures all files in libarena have a
dual GPLv2/BSD-2-Clause license in the example of other non-
kernel BPF codebases, e.g., libbpf.

Add the customary BPF selftests/ SPDX tag to the bpf_may_goto.h
file that holds the may_goto and can_loop macros for BPF code.
The original authors of the code from when it was still in
bpf_experimental.h are CC'ed below. Also add the missing SPDX
license to the libarena bitmap.h header.

For bpf_arena_spinlock.h and bpf_atomic.h, move the license to
Dual GPLv2/BSD-2-Clause. This ensures all components have the
same license, with the same rationale as libbpf in tools/lib.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/libarena/include/bpf_arena_spin_lock.h       | 2 +-
 tools/testing/selftests/bpf/libarena/include/bpf_atomic.h      | 2 +-
 tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h    | 1 +
 tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h | 1 +
 .../testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c | 3 +++
 5 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
index ae6b72d15bb6..872fa20f29a5 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 #ifndef BPF_ARENA_SPIN_LOCK_H
 #define BPF_ARENA_SPIN_LOCK_H
diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
index 43c306e17f19..65582b2010ad 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 #ifndef BPF_ATOMIC_H
 #define BPF_ATOMIC_H
diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h b/tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h
index 9ba90689d6ba..b32a420d4e1a 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_may_goto.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
 #pragma once
 
 /*
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
index e2431ea6fdd6..8c5936ae9958 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
 #pragma once
 
 #define BITS_PER_BYTE		8
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
index 76319a529f02..e66b3a26ca3d 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
@@ -1,3 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
 #include <libarena/common.h>
 
 #include <libarena/asan.h>
-- 
2.54.0

