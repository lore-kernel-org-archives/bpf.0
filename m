Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F681EB1AA
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790429454; cv=none; b=efC2yO88fANCqd1QH7+X6uHxQTVZWpWOBnFF9uUCvQOtIVHVIyIkrA4d6EbOVnI5z7jYo/fIvuQM834xX0O+0veVLtI1hBZdYBjf93DQkdRbIm/qS8GhX7ERJmz/ygGDs93dk+ZyHHvW0wWnkj3OYvP4d/BrZyHZNiOc66HctWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790429454; c=relaxed/simple;
	bh=7BVB89PKLVO6i5G2jI7rGPJfLWFoJWGU1PnXo22Lcv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9P2BiGxz3cW6l2wITj8wybRjDl7YtTvLyl/kXycNTQhE8gohIF8e34hPkHPmvIJsdPOKsINK1erJ07AQgKMxCKJ3n7wxCi95/4quSBjuBWiSxq/vo2/kslrvO8+6AMxt6XYpUWYEj5B6Ew3uyOY6v99DIHB7W+C9j9CwAKzIfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuQeycjL; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuQeycjL"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-48880d1367fso557331f8f.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790429451; x=1791034251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1CFYJ5BBZus0Xc8QfUJLqSAqFlEwcYlRk/osGlbbe+s=;
        b=QuQeycjL3txOsOn9hExWZlvCDv3gukho+Br3BFcwHWEObTJ7JjNGD4SafK9bD4fcxb
         StXkIDnHEMgx/mW0kRPjUmg4RI3MPfoqHtL7dgPUWS/XnP0Ao041UtgqmntQSWBdzjC0
         rRrgDWXm6VCADAiwDiyOU9MOcelzRwrgR8CD0QxZ/YQjM9uHUCm4IE0paN6HBoWHeCjs
         mUCPOSmhGo7EL2JBI4qDeYadNOlz0uF72edqj8/G6cZyLaaVx5/LLMjcDoftVoC36Ddp
         BmeS2k47/l1DWnXsWxFXRGaZFJ4gLylySvsG7KQUzVbPV0aDhsXdXPV4Kkn3HqbRPvef
         rUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790429451; x=1791034251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1CFYJ5BBZus0Xc8QfUJLqSAqFlEwcYlRk/osGlbbe+s=;
        b=uoHIkXsBCnxjcO4WynXhJdyIa7lwlKhUmqf6hpwWYXdKjxkqegG/oeuoVPqkyFv4GG
         lEVEqlNwTwHr+vnf6cRRmZSWCR+YURfHXwZqFUY1q7uWxP1G5wiPZLWP9VuX1TcWBEZe
         eoDCCkpzfk0hFGw6OeBzLmm1wXJKvSqDOU5SuttRfKqmXl7rFFmD+OUTgv9N0/FafxJJ
         pAg4htgDjKsoal1RrVC1k6giOWYEE9wC64ifjDYrZg+QXWDCrUdovjzHPtVUI50Pr/ij
         NqDVTRAqxRDqDamoe2FIe7x20Nt/Jxtb9nfUqMvllGnFO4Rc06bUukqCMIoJ7ZAcwUJU
         Opxw==
X-Gm-Message-State: AFq9FYK+FC4W5URsQeY5PeAPnpdXmNRDm6sivMsIFV76pfIKK/1lqdiJ
	ACzFA2eGbXNu/4lxpMKdNTP2SvXgz5Sdx72+EHzEOkJ7oBxXMfmdLcL/OCc9EsKm
X-Gm-Gg: AYBFou0M8JRBwppqjihSxHe0ZQnjSOGwPkUuxTzogcNqoQMN1D9Na69wDEx4NC4nKJM
	mF7vt0qoXPmUrM57rTkS3n9jZ4PZf0s5d1Rh/fLFN2ppX3sGwkNbjNLfqczNj2HYbK/Kp3uch+0
	eFt1nSPoKmvPw9jjKaBdae5l5VbjILN2gOOjkM28xJlzEMth0fVyPpkVZGFKY3w7m285y73mjAB
	UOPnnLCiqQ0lxlJl+0/WZAA7h66iCqsGzcUYOo7RS6NwxjIcyBUibQxZfaIiBLItBi+AoLPXSi/
	4Hduxuvqx0uHsR56m7IFIyePS3aisP98RCxbve077iY0NOlp6YnsuM6RIJJmIFLM7IVZquhkUF5
	qFjY/lz2vNqO/1PXpgDjT4xsNKhVrny16nguTNXAYyMwAzbXFeTMsaEC2c3aA1+cVU/MXfbZHPj
	ehkeKRozx47mbzviP0I0lA3XRNeGSPOmecE8Vb0AA9q06jFdaHPMyS3t+OysYuZp/tcysET4h8C
	ng9RgyWj+GDQfw40qJSwCx0boI3+KTmD1IcEeut4hGHDmVijTO+JaZELyhSphIkUKCQsKSl/ap7
	lnwOyZBBBIrZe3cAH+WXOitEdxXkm8NBn3uAlg==
X-Received: by 2002:a5d:584a:0:b0:487:89:bf74 with SMTP id ffacd0b85a97d-4887db4b55bmr9932731f8f.51.1790429450957;
        Sat, 26 Sep 2026 06:30:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84205esm13920686f8f.37.2026.09.26.06.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 06:30:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 1/3] selftests/bpf: Test non-sleepable kfunc context
Date: Sat, 26 Sep 2026 15:30:43 +0200
Message-ID: <20260926133048.2962553-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926133048.2962553-1-memxor@gmail.com>
References: <20260926133048.2962553-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2318; i=memxor@gmail.com; h=from:subject; bh=7BVB89PKLVO6i5G2jI7rGPJfLWFoJWGU1PnXo22Lcv0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv7iSfbBfYFHNp7q0SNO7z6scDMmg+XliW95Di/8wFPt aWkftKJjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzE7SXDHy4mc2bpPVVT/3Rc myr+3evVVJH3p7T+ZU7kmH4g5d8u10BGhjsTpyiuWPTHxto1JSrol/WCflvTrT2/XkjGeFtrzb+ xlgUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A sleepable kfunc call can be rejected because the program itself is
not sleepable or because a sleepable program is inside an active
critical section.

Exercise the two causes separately. Call a sleepable kfunc directly
from a non-sleepable tracing program, then call it from a sleepable
tracing program inside an RCU read-side critical section. Assert both
the legacy verifier messages and the structured reasons.

Link: https://lore.kernel.org/bpf/2e42a1a2bf45f4d2aba7495bdc9f147558055740e2f3c8b9dae255f6c57fc13c@mail.kernel.org/
Link: https://lore.kernel.org/r/20260924170646.2366016-6-memxor@gmail.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/preempt_lock.c        | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 81c459435680..955391da326a 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -6,6 +6,8 @@
 #include "bpf_experimental.h"
 
 extern int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void *unsafe_ptr__ign, u64 flags) __weak __ksym;
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
 
 SEC("?tc")
 __failure __msg("BPF_EXIT instruction in main prog cannot be used inside bpf_preempt_disable-ed region")
@@ -179,6 +181,30 @@ int preempt_sleepable_kfunc(void *ctx)
 	return 0;
 }
 
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+__failure __msg("program must be sleepable to call sleepable kfunc bpf_copy_from_user_str")
+__msg("cannot be used in non-sleepable program")
+int non_sleepable_kfunc(void *ctx)
+{
+	u32 data;
+
+	bpf_copy_from_user_str(&data, sizeof(data), NULL, 0);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("kernel func bpf_copy_from_user_str is sleepable within rcu_read_lock region")
+__msg("cannot be used in RCU read lock region")
+int sleepable_kfunc_in_rcu(void *ctx)
+{
+	u32 data;
+
+	bpf_rcu_read_lock();
+	bpf_copy_from_user_str(&data, sizeof(data), NULL, 0);
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
 int __noinline preempt_global_subprog(void)
 {
 	preempt_balance_subprog();
-- 
2.53.0

