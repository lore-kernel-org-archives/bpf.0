Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5CA34F24E
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775537857; cv=none; b=pIso7u1GH3U0oyzwsjpAOIet42Md7q9qzAtH2zPaqoWJLp06op9xSXGo8OKrcaLVNGZI2n+MHQdmCLLc4od6aQmzr9qV63gD3d9TDCPLeIc4xfmARaAMLOKxOK9/dC1qP643uXfuHjSivgOpQ3SpQZZyYUrmiwqxHezc9KvZl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775537857; c=relaxed/simple;
	bh=19IOVoNvwMpLQrHaDDretdhiMTOwOvEURgvhzstx33k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nh/h4zJbjlQU12YQMXsRDnNtw8ZhsL/rNXPH5I954tWBoy13BlLSexoiJDuna8Q1T79W5gBKKhaYOS5naqnB39mCsE85q4Cn5BE3QTnu1PZkHAhcl3WyGtRzxrlhpyClOxmPRfF7VADtzEWfWqpQX51jhKaNRZEUYVz+M1BZ1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=VVq9Cj+S; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="VVq9Cj+S"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82a7ebc729dso1903394b3a.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 21:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775537856; x=1776142656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU32o5qQpsEsrYr51TRcqCr11DqNvKS79WaFIwLOsGI=;
        b=VVq9Cj+S0/UQ+yZlZpiNtGG8DbJXC9Sc8iiQeH9BI9Eer9TLYNkOVw96J6L0HkB8wM
         Ho+n3JyvUfdRTo/a4thGHb4Sp+ntLfiArrvbDwoHYrKKVsvsdtSADXo2LTexgpINJ4SW
         zzlDJBaBUODnhyKgKcobsT059LFH/hnCJjy2b4jRPYrCrObWSMVZOCqVOakg55kS4Nzy
         9i4fubCuuggvWmFB2CB1d8vPfBGgeZPYkTdj1qrnpxYq/KnjLn7B5WAzXreoWViIJlh7
         9M3X475Ll2EHUhnRkdEkD4eLnG/doSc8Cxkz5AIfcYoYDIf1TGd75bwRA09an3+xsRFe
         v4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775537856; x=1776142656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JU32o5qQpsEsrYr51TRcqCr11DqNvKS79WaFIwLOsGI=;
        b=WTMFFdUNIPWy6poe/KZ0Sn8TzWHa32dZ2D0W3hppbsz5p8F9nD08AfCZlPx7KaSESk
         EXV4/AenLN23MaaXzEpdW3mJMfJcxYhkR8qLT1VnLhlYCBVe0BxSbqWu47Qi+jVWbyep
         nULv6GkcFDhujQuNhMnpQWvacouzVoRWdW9ULrrHiKgirRRPswOcLQlwTJgMLVSkTEWH
         Lopgm/kmHufqeZLQvI2bQ16+DKCtUsIUfDstnYtsBwYNJpS/P1/YPa+rPW5/DmEzp0y+
         b9/ygrqvIsQlra7W//93vN/xmEUuHWb5+ETl2iNJ7gblpWoCv6Mnsgwhex6MHVP8cWuA
         oQjg==
X-Gm-Message-State: AOJu0YwwRRPUNqG+12gl7iS0BPXFpTQTvkMQlD4Jrq6I+569cEjdLSO7
	S19VllhfJjTya82qveRkJY+8tWz7mwyjRiFw/dvKURi1UbnfzMx0JDiNaJoMN32vuRC3y5slexA
	3Ht5j6Dc0hA==
X-Gm-Gg: AeBDieuimFEfD8gqB76nzo574zz1cg2OUg6iHdBwIXZemWa3O5TNn3ng1AAfpOChS9j
	P55PDEzRDH9YtO+6UwdKPAd1anqxetASj4aiJcZG7RjL+scFBIIies5pxgw/A2PmFy8jIJq6GBN
	b0UgY/txYIQmqz5y6dC0NbEjTwG1uSlBEH1dIfsu8XUmwsjzQ8UO/KcRL5ErQmfD8+t3q3vH6HT
	OaLu9IDiV1kKrI7idaWzojfLYZsjfrmDJu1xLCCDhQFYx6xGk9HL+2xURS9lXpE4pxvS3LfpePN
	xuFUZEhZGI3w482/nngrRBABHqGpTbjw9MDmw6NJYImWhGHvRZHq2+zw6HZbM/N2qjaYsaV82k8
	/X4dNv+v62DpYZ2UqDr9W9/okGTNp71e9hsrrsR2q0iGO0XQ52aPtP0uLEryu6oKxYxZmUM5jHY
	G8Xg==
X-Received: by 2002:a05:6a00:4b4c:b0:81f:ac78:ed22 with SMTP id d2e1a72fcca58-82d0db53f18mr16610961b3a.37.1775537855809;
        Mon, 06 Apr 2026 21:57:35 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b2694csm16156807b3a.2.2026.04.06.21.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:57:35 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 3/9] selftests/bpf: Move bpf_arena_spin_lock.h to the top level
Date: Tue,  7 Apr 2026 00:57:24 -0400
Message-ID: <20260407045730.13359-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407045730.13359-1-emil@etsalapatis.com>
References: <20260407045730.13359-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_arena_spin_lock.h header is useful for all programs and not
just the selftests. Move it to the top level of the BPF selftests
to make it more readily accessible.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/{progs => }/bpf_arena_spin_lock.h | 4 ++--
 tools/testing/selftests/bpf/progs/arena_spin_lock.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename tools/testing/selftests/bpf/{progs => }/bpf_arena_spin_lock.h (99%)

diff --git a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
similarity index 99%
rename from tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
rename to tools/testing/selftests/bpf/bpf_arena_spin_lock.h
index f90531cf3ee5..680c9e6cb35d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
@@ -107,7 +107,7 @@ struct arena_qnode {
 #define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
 #define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
 
-struct arena_qnode __arena qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
+struct arena_qnode __weak __arena __hidden qnodes[_Q_MAX_CPUS][_Q_MAX_NODES];
 
 static inline u32 encode_tail(int cpu, int idx)
 {
@@ -240,7 +240,7 @@ static __always_inline int arena_spin_trylock(arena_spinlock_t __arena *lock)
 	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL));
 }
 
-__noinline
+__noinline __weak
 int arena_spin_lock_slowpath(arena_spinlock_t __arena __arg_arena *lock, u32 val)
 {
 	struct arena_mcs_spinlock __arena *prev, *next, *node0, *node;
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
index 086b57a426cf..6c04e7707644 100644
--- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
@@ -4,7 +4,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
-#include "bpf_arena_spin_lock.h"
+#include "../bpf_arena_spin_lock.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
-- 
2.53.0

