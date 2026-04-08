Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0493AE712
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674947; cv=none; b=Aeev2ei5kRWsJ1aqeVKYJ378eNQFFjzsTqmY7QnAB0wFR6lJ0hs4nVqwnfvJdwz4APHA5KDzdpS8cp6r2YJT+1Hkrt0NznVzP6yxszExRatEeBKPa4hYEe+9wyOhdRwdc9SswHp2wB00j4c0h7MVYY/pifQkCAK3uk8Gur/u3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674947; c=relaxed/simple;
	bh=/O5oeGgC5b3j64e2ru8U45y4Y9aDC/mlyIl6E36Mp3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrwePgwDaaEhrcPk5rFUDq3I3e8ldgq/qxCA3n5Sc1K6RPbgW62Jxz9TlPuLrnuqRMOeC/1jjOhJVL/HutyP90OJk73QkEDsbiBjLoIQ3BDuoOmf/GXFLvSJwXMjTvJWO8XQS/5Xo+k8uVNW0R+Pb4ZJbN9Rp/X7pP++rHwTdyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asZ0BkcD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asZ0BkcD"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so82186a91.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775674945; x=1776279745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlX1897QIvgYNBePjjdYhhpwHwSAdVuUlE8RPQRxA5g=;
        b=asZ0BkcDFzVkpCgd99FGNqyAxJlSVXlKlu2UH9Km993efpiSbHjeZz4swjpLbEqke9
         aGMNgjzocou7iimsQvisy3XDN/3jQLCAIrClOCFRb+TJRNqL+BvYelOLxR+iyxWe6yhN
         Cm6LdvKsPhEVVr2xdRUkOcQ8aCcuBehRy1Cyt0edt9h7zwt+i30L9KTcKDGK/6Fcv6X+
         O3tR/yhNGQxmc4NgbdyZ66OrUTijseQq+OZPetNrVSak9kaGvXnKOvXsSB5qdGqqVH/E
         dz4uh6IHdyJSnl5m6/i5BykhhQSU7SbI862ipZf+qwexeDT/Qh4lnP/rZKEQVvUQBmNO
         vBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674945; x=1776279745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MlX1897QIvgYNBePjjdYhhpwHwSAdVuUlE8RPQRxA5g=;
        b=S3lgCCo466SLKcyxRAOhKxwmsv3Ruw7kGZjgQtthLiiJ4sLvYUS6qC476j/cW4QQvC
         q/Go3cIIGGmLYqVZGGPdDqoWOAqjza2oHLc7NkG6k0qs4GUI6BTAhmqR15lM6V7bMB3x
         /CBlfWAJf3gFfnMzMGny6iN00e+BvS0ByBOBaMpstFzZklXX7h8dqElAp1/aPSqDVcdl
         wSNlRjBsNMH+dYZzz9zFfJj2feUfotkHxLyo6Le/Ko+425eNmemxW5UnOXK7chw1aXPF
         pn4ejhieXLue2k+lxrk0arVSWnQzjlaG+voulEoowcjf5Rj2wYFX4XCIFOCNc0CDnKNH
         ZOaw==
X-Gm-Message-State: AOJu0Yzus99oZ5w0u4mN6uNuuDEOJex8kdGX7Ihkf8T8a6sWJfBA4x0j
	RIehYcU6DWuceqby7jTXSXbYnEBHhuneLxlm0MCg2VqmFfo2Z+5txhS4GadCX057/4A=
X-Gm-Gg: AeBDievXqbz98HknDcet1Ei9ZIcGEi5Bv1WNNn+KXrDGdFZloqFJw9x+kmhGHeN/GDe
	vXgjR1UfzOHds0KzyBb7Nnp2T8oZ/MW/tM7pRhCZioTEKzdU53LNe56NIm9QJyqPStge3yBhvyt
	DHkWjm5rXmAOS0xaAjgpNFwXUyl/FQp4aF9FaHxnU1jMj5PBap8E1RfbxYogxtUJBYuKyFuo8Ew
	A3t8uXqhGdIhKJGWSW28zXfCn7d+aGb+MG8Yy2CfSqGyaV2ef2xnMCNSufBODEe4yAsl4nM3Ui6
	QrEDLGI1R4za5fkQguQEjBLc3rEjgeXQDdwWuzDSTU/FvTZ1VP84B8ZAPwsm/vT2Me5Cudl4v+Q
	FkSSX88tDtrjoxtOVwk6p75L/yJ1RKa+EvFMKeYuahkUsNUOQyJaqaJ6lwGHI6OFJHrEIXYHjLX
	b+dg7bxgcUSm5DAH96NHvLPrcAXU4VUkEw5SL8dVQ6+syDOFT0OC3PvEtKVMZCJQKPPAew
X-Received: by 2002:a17:90b:48c1:b0:35d:9276:eba7 with SMTP id 98e67ed59e1d1-35e353e8bc6mr422904a91.7.1775674945211;
        Wed, 08 Apr 2026 12:02:25 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34d0d9efsm143630a91.8.2026.04.08.12.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 12:02:24 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org,
	leon.hwang@linux.dev,
	memxor@gmail.com,
	jolsa@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add test to ensure kprobe_multi is not sleepable
Date: Thu,  9 Apr 2026 00:31:37 +0530
Message-ID: <20260408190137.101418-3-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408190137.101418-1-varunrmallya@gmail.com>
References: <20260408190137.101418-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to ensure that kprobe_multi programs cannot be attached
using the BPF_F_SLEEPABLE flag. This test succeeds when the kernel
rejects attachment of kprobe_multi when the BPF_F_SLEEPABLE flag is set.

Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 35 ++++++++++++++++++-
 .../bpf/progs/kprobe_multi_sleepable.c        | 25 +++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 78c974d4ea33..a07cd853ed2a 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -10,6 +10,7 @@
 #include "kprobe_multi_session_cookie.skel.h"
 #include "kprobe_multi_verifier.skel.h"
 #include "kprobe_write_ctx.skel.h"
+#include "kprobe_multi_sleepable.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -220,7 +221,9 @@ static void test_attach_api_syms(void)
 static void test_attach_api_fails(void)
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
 	struct kprobe_multi *skel = NULL;
+	struct kprobe_multi_sleepable *sl_skel = NULL;
 	struct bpf_link *link = NULL;
 	unsigned long long addrs[2];
 	const char *syms[2] = {
@@ -228,7 +231,7 @@ static void test_attach_api_fails(void)
 		"bpf_fentry_test2",
 	};
 	__u64 cookies[2];
-	int saved_error;
+	int saved_error, err;
 
 	addrs[0] = ksym_get_addr("bpf_fentry_test1");
 	addrs[1] = ksym_get_addr("bpf_fentry_test2");
@@ -351,9 +354,39 @@ static void test_attach_api_fails(void)
 	if (!ASSERT_EQ(saved_error, -ENOENT, "fail_8_error"))
 		goto cleanup;
 
+	/* fail_9 - sleepable kprobe multi should not attach */
+	sl_skel = kprobe_multi_sleepable__open();
+	if (!ASSERT_OK_PTR(sl_skel, "sleep_skel_open"))
+		goto cleanup;
+
+	sl_skel->bss->user_ptr = sl_skel;
+
+	err = bpf_program__set_flags(sl_skel->progs.handle_kprobe_multi_sleepable,
+				     BPF_F_SLEEPABLE);
+	if (!ASSERT_OK(err, "sleep_skel_set_flags"))
+		goto cleanup;
+
+	err = kprobe_multi_sleepable__load(sl_skel);
+	if (!ASSERT_OK(err, "sleep_skel_load"))
+		goto cleanup;
+
+	link = bpf_program__attach_kprobe_multi_opts(sl_skel->progs.handle_kprobe_multi_sleepable,
+						     "bpf_fentry_test1", NULL);
+	saved_error = -errno;
+
+	if (!ASSERT_ERR_PTR(link, "fail_9"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(saved_error, -EINVAL, "fail_9_error"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(sl_skel->progs.fentry), &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
 cleanup:
 	bpf_link__destroy(link);
 	kprobe_multi__destroy(skel);
+	kprobe_multi_sleepable__destroy(sl_skel);
 }
 
 static void test_session_skel_api(void)
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
new file mode 100644
index 000000000000..932e1d9c72e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+void *user_ptr = 0;
+
+SEC("kprobe.multi")
+int handle_kprobe_multi_sleepable(struct pt_regs *ctx)
+{
+	int a, err;
+
+	err = bpf_copy_from_user(&a, sizeof(a), user_ptr);
+	barrier_var(a);
+	return err;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

