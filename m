Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C2643E487
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447377; cv=none; b=iMNmKXRh7FsFJ+MsPWuiOIHkR+InY0zIF1V+Gd7qqJgP/39MEDgZEsoCdRsb33g9FaSeOyVH/Rm9Ttt5Lmqt09A5RspDrXmg+zHwriuBgcVX35HxwnWK+UEDZYPIsh0bGPOB/LTkzgE3kxQ2hamu0bSeUmEjnVaWpYs9k4AaTvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447377; c=relaxed/simple;
	bh=ixxztuSJW7o8vdbV2a1z906U6yqu6uArf99UAbFq08Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6GJ5vQEeEisKNP/DKI82V41Ml1TMtAT3ezP6pkzdEhGHxI1gCI6WaQXAkkSyclJB3DeuarYO+nA6HNX80Axieqr+FQKIOeiomhu1tCbVlwkcWLzXr8tiw+w5geDlAfWkkIq+ER9OxCkOEJ/LawETs3dVb+D2QwDhM33P+vvTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDF/O9pu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDF/O9pu"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4980dc26022so30724895e9.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786447371; x=1787052171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1AOkCrY9bi28aQzDGxTuGUu2U3BAeGsVy+sCSxaGiak=;
        b=dDF/O9pujjxkKui/V2BVwqMGz6hEr4Heq5fnXdjyI9teoz6LDqXhuP8SaPrdyd1yTX
         gddt95HjKN5wjSa7eUbaZ6UU66DgW8pQbE55g31FJhyNKMXy0x0yUFIIDRfkZsrBcwOA
         JTf7tIg4SVDjpmsTqBv4rFLfPvOZZhZG/IpPGXFJQX8VbUzQ0IGdvxpr1GvFGlD17L3e
         ZUeAzgkHYrC0OYQtauJC87uRHjJTRDRe8ylnqqjOrYtdGsLeIjIe0kIS4HIWGqp1V2tP
         LtoEHnSjc4jf9Mz491/3nwuUlTcbq8xyhKjCikx9yjWiBh3/JOEFBRYvvwX+aevO9Yh2
         kD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786447371; x=1787052171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1AOkCrY9bi28aQzDGxTuGUu2U3BAeGsVy+sCSxaGiak=;
        b=ozHJ7RAve4gZ4PbUzN34Lq+OTEvP45dsZIPRirJoN1czQ8a/8HOZlQXzoVKeelOhti
         Tdn+tsFso/CBVTj3Q+ZXWY5ykATEr0TNiNpii12ICGGKfu/ZIvZPqv67xwXdwI1dGWtp
         LPAJt0LUZzHzKyAgxRk8v8VopoKLJ8R3FWvZxwjzuM6pjSs8nDqxbKiEiTANb+40NO6K
         7tbKad6VRkl4pRkAdvO/Q9a6+CqpLuPFv8PeIbCDOC8Gqgf92ohS7E4fhBfNhRKGwRcj
         DMSkCIeJhrFpsQkdltThBHDKkQQVcbKMlSlorH9eEVHFR/eWGB72F9y/Codt/+VBKMs3
         zGow==
X-Gm-Message-State: AOJu0YwHO64quUhNLzD1KCItPL5y4M/4UCtd8uXB/EagQpDd5b+o5UwV
	a1V1RLGe2q/UFivla/k/ObESOb/P4wUnBaLv+H6XZMXst5bnsZnQ37iWxP97bWjS
X-Gm-Gg: AR+sD10/HuksXBMzv2GRXo04a4NF5uCCB6YwUAdVIwY6seorOKysyHNx3Auuvw9qbQZ
	Fd6T3+iXu8QfhPSXb8KFZ9EgCfINpmqGm0nL4IKUglA7PX9DYgA4N1CPHWBYuKdX+w+opzNwjLW
	0WWoyPHmZ95dHyQHDuopaxcHHbC2CMO0qF8fajdjbIyonHmnGAlTMYlAWJL+4U9m0zyMzxK3hF3
	QrXPm7QvikF+SAEV+SJvgkeBmKPjKX3+D7gAODon+0J8nsqgTpQ97lHShs3O7OJdhdyoBQNJYbc
	tpnOh+LhB0Y5eIE5IfoedBdehgXeojVw35l8wxkNXwGo5LrJ2DLEJqjnlUT6voCSREUDafUT2fE
	bwNWabWZNeM5/iNrJrlJfE1rYpK4fn7dt9RXK9oVVFgW9UA8Su+BUTcziYCdKt8DH5GCkswl/Io
	9tySf/06FDCgYpRbc/mw+FkQW61a1mYU4mR6h9xTQVST3aqbLMwTf1B/9Z2rAf8YY+YylZXLFYU
	mBs
X-Received: by 2002:a05:600c:1c07:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-4997845f6c7mr32679415e9.9.1786447370443;
        Tue, 11 Aug 2026 04:22:50 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c2bcsm47547665e9.3.2026.08.11.04.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 04:22:49 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 4/5] selftests/bpf: Test trusted-or-null linux_binprm->mm
Date: Tue, 11 Aug 2026 14:21:53 +0300
Message-ID: <20260811112154.94053-5-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811112154.94053-1-tasos.papagiannnis@gmail.com>
References: <20260811112154.94053-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add verifier coverage for the linux_binprm->mm trusted-or-null
annotation. Verify that bpf_copy_from_user_mm() accepts the pointer
after a NULL check and rejects it without one.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 .../selftests/bpf/progs/verifier_lsm.c        | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
index c724bf389f5c..4fc835432af0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -5,6 +5,10 @@
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 
+extern int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
+				const void *unsafe_ptr__ign,
+				struct mm_struct *mm, u64 flags) __ksym;
+
 SEC("lsm/file_permission")
 __description("lsm bpf prog with -4095~0 retval. test 1")
 __success
@@ -212,4 +216,31 @@ __naked int retval_load_resets_bounds(void *ctx)
 	::: __clobber_all);
 }
 
+SEC("lsm.s/bprm_check_security")
+__description("null checking trusted-or-null linux_binprm mm")
+__success
+int BPF_PROG(copy_from_user_mm_with_null_check, struct linux_binprm *bprm, int ret)
+{
+	struct mm_struct *mm;
+	char dst[8];
+
+	mm = bprm->mm;
+	if (!mm)
+		return 0;
+
+	bpf_copy_from_user_mm(dst, sizeof(dst), (void *)bprm->p, mm, 0);
+	return 0;
+}
+
+SEC("lsm.s/bprm_check_security")
+__description("not null checking trusted-or-null linux_binprm mm")
+__failure __msg("Possibly NULL pointer passed to trusted R4")
+int BPF_PROG(copy_from_user_mm_without_null_check, struct linux_binprm *bprm, int ret)
+{
+	char dst[8];
+
+	bpf_copy_from_user_mm(dst, sizeof(dst), (void *)bprm->p, bprm->mm, 0);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

