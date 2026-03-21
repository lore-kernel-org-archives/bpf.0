Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B911862
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774129262; cv=none; b=V5d9V/x0YRFt9acCbLOtZCATNZMj5nDI8sSSc3zgGyY6eA8aYmUPm6yjhTO/ZJuPzVflaQ4MeK9bkUvz5Kf+QNAUDGE5ActFw5Uh9ppKjlwUX4gWGZntBH0lq6jE1f1OhsGSr0ScaI9QTdeF8cMmxmtL3r+5VDB1NXmIPSvna6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774129262; c=relaxed/simple;
	bh=W9b8mkn2d/QQvmPyUvmCfl2ZxykFL2NGsclhDR8Pjuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1QMs1PmacCqKpA/mGvkIz/Jmus+X67CAY0SRyiVdKlrJx1cwlSUor/3SQyPr/GC7dPYAzZciB2HY3SMbghf8BULjiQGx6QKhWxiQwpVvK1PDIdr/h2zujQU1OOolhN9zYzuJLt51oSdq06WP+/aZNuEdyhBF/GWaUN+EOFisTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYKxDf5O; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYKxDf5O"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8296d553142so1343448b3a.3
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774129261; x=1774734061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzaWyJv8683y0pAKjfQ2NLFdvOf3yhLbEHEYZka/WkI=;
        b=BYKxDf5O8jiwehcQd/REf5tbmDu3H7e99QhZlMfeVg7HULmfMQ1ZLoiPHJMvjlhQ7N
         UjS0xUwJAz/7u3GNsVCfAOv3lD79RDO0ZE2DLyKpY6k0qI6HyjuQ7GFccaeWY/9ivgK9
         rJ2AAE1GVUw4HUkFgqSTVUznnRHBx4tIkkHxZKouOevdSJgO8Da3DvfmltDMD/88n4EV
         +aVWE3Yn4W5mHh74e2O+u5azZRnS/t+H1QSlJFTiOXx66kqb/XFWG1tVamiv79uPN+LZ
         mgcku+Ioe5A76fTVGhdtKdgqhLlt6Ztf2L4DlgzK9BxuphDuhgIPypAkox4xP+XJXP+O
         d9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774129261; x=1774734061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RzaWyJv8683y0pAKjfQ2NLFdvOf3yhLbEHEYZka/WkI=;
        b=d2ZfXW2OTvY+Qka7HpbINsERWtJQos9i0VkF4m05Rxikv3OBtfaaAOhL5KOYGYhhlH
         dCTBGycpUvXtN+EWdvg5tbg/Upk2H08m/Xzc6En+azlUwEZDt0D7yQdgo3+dlVg30KGC
         nBWvBA32+l5IzKaxK1C/TH2V0IVyWRBZqwVRBCxN1rTgMz6xnRtrFrZ8AlqAL8uyYOi6
         AmWV4AUEcJYt2HX7ttBcCrRkds2+pNX8wsJnB7W0wAjVxu8saHQ8Ti0UnjhAt9rSGFuU
         6p82DVerC9E/3yPEnsVKf9ZsZBB8Ud+TnC+bJXjeP89n2Emqir3XcPe7CstQMxmMokQL
         01gg==
X-Forwarded-Encrypted: i=1; AJvYcCVYQPAdCKfq6Qfz8OhNsOyA4vP6XMQyFfNjhb3YTlgOc4iVVKAkltsrA5/K/2JaK+xO4ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwImLoI+DfL2rJVXv4Bbw8VrdjWJf3CiIecoFbqCdH2ewRAgBZ8
	rJsts5fK/vGYONJtQkwhXCIj1+BOGQuWp3u9iwvrDkVraYV6zEkG8gND
X-Gm-Gg: ATEYQzxS62XuayRwFLXDRTnh1YvO4hOPv/5LDGRPhpl90VCQQemjWfhiodKHeTrNpj4
	FTZxIIjabL+upPPc6//cMEYioat2Gypf8O/hljX2xyVA4yxErnhYwxnGzqo0/vDPp3M/AxzI229
	GX8uqf6CMktad8F+NPXG9nmdfbxbcavqzDC4awnIdJu31R7hicpjJpd10+xiP0pQR8Ijhx9yTUd
	kOXmz7dEBcy6OD0/Xtg78zJwhs0rM5aVhJfPbDtJe1kkYzvu7wXYg7tm5I9y31JhiS421MBe3D2
	tgzfgePoBAtgSnSINvehXIIUlx7pugvo6l5htF4KJJeF7ZR++vTMrNOJ1wg6QLYmGsIU16kuOZN
	7s7PBiFLp+lWsJgj385GYs0OjHdjXNw/nJpsqLEPwzQW7nY8MdRfjkhWBSh1Qr8E7O1ripV++Dw
	EZrqgKvkQhGo8u+kpeLQ1FRfK6FEgFvEOtBup1TJzn7tDKAcZKbF4gIUc2B8j08khXW3U8
X-Received: by 2002:a05:6a00:bc93:b0:82a:7f1a:758c with SMTP id d2e1a72fcca58-82a8c247f22mr5291810b3a.11.1774129260608;
        Sat, 21 Mar 2026 14:41:00 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:277d::3ef:49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bc6745sm5475471b3a.23.2026.03.21.14.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 14:40:59 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: keisuke.nishimura@inria.fr
Cc: ameryhung@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	Varun R Mallya <varunrmallya@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Add test for struct_ops __ref argument in any position
Date: Sun, 22 Mar 2026 03:10:38 +0530
Message-ID: <20260321214038.80479-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320130219.63711-1-keisuke.nishimura@inria.fr>
References: <20260320130219.63711-1-keisuke.nishimura@inria.fr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to verify that the verifier correctly identifies refcounted
arguments in struct_ops programs, even when they are not the first
argument. This ensures that the restriction on tail calls for programs
with __ref arguments is properly enforced regardless of which argument
they appear in.

This test verifies the fix for check_struct_ops_btf_id() proposed by
Keisuke Nishimura [0], which corrected a bug where only the first
argument was checked for the refcounted flag.
The test includes:
- An update to bpf_testmod to add 'test_refcounted_multi', an operator with
  three arguments where the third is tagged with "__ref".
- A BPF program 'test_refcounted_multi' that attempts a tail call.
- A test runner that asserts the verifier rejects the program with
  "program with __ref argument cannot tail call".

[0]: https://lore.kernel.org/bpf/20260320130219.63711-1-keisuke.nishimura@inria.fr/

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 .../prog_tests/test_struct_ops_multi_args.c   |  9 +++++
 .../bpf/progs/struct_ops_multi_args.c         | 35 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  7 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  3 ++
 4 files changed, 54 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_multi_args.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
new file mode 100644
index 000000000000..0f321e889862
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_args.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "struct_ops_multi_args.skel.h"
+
+void test_struct_ops_multi_args(void)
+{
+	RUN_TESTS(struct_ops_multi_args);
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c b/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
new file mode 100644
index 000000000000..c62be15757f0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_multi_args.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Varun R Mallya */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} prog_array SEC(".maps");
+
+SEC("struct_ops/test_refcounted_multi")
+__failure __msg("program with __ref argument cannot tail call")
+int test_refcounted_multi(unsigned long long *ctx)
+{
+	/* ctx[2] is used because the refcounted variable is the third argument */
+	struct task_struct *refcounted_task = (struct task_struct *)ctx[2];
+
+	bpf_task_release(refcounted_task);
+	bpf_tail_call(ctx, &prog_array, 0);
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_ref_acquire = {
+	.test_refcounted_multi = (void *)test_refcounted_multi,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 94edbd2afa67..297b02372fa6 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1411,6 +1411,12 @@ static int bpf_testmod_ops__test_refcounted(int dummy,
 	return 0;
 }
 
+static int bpf_testmod_ops__test_refcounted_multi(int dummy, struct task_struct *task__nullable,
+						  struct task_struct *task__ref)
+{
+	return 0;
+}
+
 static struct task_struct *
 bpf_testmod_ops__test_return_ref_kptr(int dummy, struct task_struct *task__ref,
 				      struct cgroup *cgrp)
@@ -1423,6 +1429,7 @@ static struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_2 = bpf_testmod_test_2,
 	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
 	.test_refcounted = bpf_testmod_ops__test_refcounted,
+	.test_refcounted_multi = bpf_testmod_ops__test_refcounted_multi,
 	.test_return_ref_kptr = bpf_testmod_ops__test_return_ref_kptr,
 };
 
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index f6e492f9d042..863fd10f1619 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -39,6 +39,9 @@ struct bpf_testmod_ops {
 	int (*unsupported_ops)(void);
 	/* Used to test ref_acquired arguments. */
 	int (*test_refcounted)(int dummy, struct task_struct *task);
+	/* Used to test checking of __ref arguments when it not the first argument. */
+	int (*test_refcounted_multi)(int dummy, struct task_struct *task,
+				     struct task_struct *task2);
 	/* Used to test returning referenced kptr. */
 	struct task_struct *(*test_return_ref_kptr)(int dummy, struct task_struct *task,
 						    struct cgroup *cgrp);
-- 
2.53.0

