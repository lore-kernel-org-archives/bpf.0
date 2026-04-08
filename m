Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7693D6CA2
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673377; cv=none; b=gZoAXZRQ/d+RToks8FwGIcQKbmFZDX/P92AGsMVZsGmgv13RNFY+7IjSuBXvH+pv8FGVpHl27dg7RcBX9JgCa1UQ5iJ6SWrvCtW5t2sf62WqQ0F3nxZA7rNcKIoBOLmb4pObYvHQeOPxMNRI0SvbmuFC0wdYLpF+mrRnpaSY13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673377; c=relaxed/simple;
	bh=O2s8uGHtGDTM+CooH4aUZyAutlFsN8tZqF1i72fbLbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhM6o3MjH5sxi5P4EGuUviD7iq+wOB2lVB7ot6yZwml6CZadJ4lmt107h77eS/K+19gbvZZERYuVUfizt7Q2KYwEoGoC+RJcw9dvYpKLE+kjAxk/KSM28Ty4AavC1Oy02h9vmEgRS3dDrXRRqp/DDIs4JNTagdLEWIWjjzzSMN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcZqtXjj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcZqtXjj"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so41508b3a.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775673376; x=1776278176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yD3k6Q7y5NEPXrLGt2JK06kWKhKz/icejKZd6Cc4SCY=;
        b=rcZqtXjj+p7OgsGjIe9y0wOuhNUVpy77VBUmxwv86AmAinJ2x6NyteRBI+L0mAc/y5
         ESrEkNAvI5q0zzK9VRUalyjbmkEZRCx1YJzdNBI2IfuYPX4ckA9fomCWKChByZ0xlxN0
         Pra6854pM9o4mCdyJ30tkehQNT0bPsXuiPlUlZvYC7M+l+bJDzVU018tYPxilyA2I/uO
         Tt5WIRqTxtQjA+Y81UzHM1TW/CbR2MZHyrcouTCKeRmyXkxgpckOyz4QBupZMP/hESA4
         olVnWADkorN7neGKVbS5QzcpDLmLBEHOjl/fQx+78i3Qr+mufIq0GkQ6nfq2svNSjQFs
         g2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775673376; x=1776278176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yD3k6Q7y5NEPXrLGt2JK06kWKhKz/icejKZd6Cc4SCY=;
        b=d5TP7IrU49FF+QjuWwN1pnFb2DgLugfgkiBLAX+VQ0lhNdvdcEJm1lx/CoCA9zR7m5
         umJwY7fCL+5hE7oMoKRFNaksvtVVg11XCgMRx8VM7rmgq6wAhCgcoTlEhzi4TC3t0plC
         MdTUKYst3xNNhFTWJsjrTBBJZSSnX9EWaKE0aa6o8mSZfWoEhG7sBoayxxR1XEAcBqIJ
         PqLS3tTxuBDFlcijfEC4BXpnzg/n3wQjJA1h37mKafY3xQEwXz8JF1Q1J/oziClkwfgr
         Zdq/gCuHdrIX3Ajl+d/qb3erlFQj6HcFaa3B0t/hY+iplnE34U1vxccjr/G1xc3puRM0
         EsUw==
X-Gm-Message-State: AOJu0YzU8uI40SaEKHlWPYgvQNpbK3xa0hXj32Po7Ba7aULuIfmQc1JM
	p7ewIgeByQIFeBK1TjYaFtNdKlhHAWg6rYswhmGTnG6PH0L/XpQR3MmakSxILekdouA=
X-Gm-Gg: AeBDietWtYwqCskITp+4i2jP+a7L4AG7UInJsXKZ9Isrc+ZmW/zOFsNBCqHt9gLxUCd
	ddJyScgmltqGNSXvuL4Gr3/D36R8osuxrIgsRE6vN0dCJjWB6KO+93avXXBUVQjaJ7cQqUqiIzG
	7H6zrQmMGuviZHbPv30UKxm1AlCeffx0qWtVBM/oSl6Oq+tlPHmbuicHGHVKFxoJQWFkT0WK8Zb
	7pOfPCQlQXZXPzxMrXoq9KeJSzy4ibMb2s6j9ouhAJ+G8DtBJK5DH46xLL32c1rTQfgXbvei0Aw
	ny6Q84TYFV5GpXTR4E7Jwifssj8X8Ntb+NopWlwOJcpOmwhYGpQkcEhq9BXvwGfcxlBoZZq66Zw
	z/uk0xecxV/WgnGCx4V66O0iHXo25Br+se8ExDIHAdcGLfPhlO3KuYf71uBC1fK7pHFMv6ibaL3
	34E0qkH4w7nJ2QXmF8Poui26L8kZJyB1G3oh+VsMdtVemDjhHa6ObPmfAN1CTatMSLPSgY
X-Received: by 2002:a05:6a00:94dc:b0:82c:651f:3385 with SMTP id d2e1a72fcca58-82dd8a8a1d9mr524330b3a.34.1775673375464;
        Wed, 08 Apr 2026 11:36:15 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:4e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b21c92sm23113251b3a.11.2026.04.08.11.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:36:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add test to ensure kprobe_multi is not sleepable
Date: Thu,  9 Apr 2026 00:05:49 +0530
Message-ID: <20260408183549.92990-3-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408183549.92990-1-varunrmallya@gmail.com>
References: <20260408183549.92990-1-varunrmallya@gmail.com>
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
 .../bpf/prog_tests/kprobe_multi_test.c        | 78 ++++++++++++++++++-
 .../bpf/progs/kprobe_multi_sleepable.c        | 25 ++++++
 2 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 78c974d4ea33..e4f9021a84ed 100644
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
@@ -609,6 +642,47 @@ static void test_override(void)
 	kprobe_multi_override__destroy(skel);
 }
 
+static void test_attach_multi_sleepable(void)
+{
+	struct kprobe_multi_sleepable *skel;
+	int err;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = kprobe_multi_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_sleepable__open"))
+		return;
+
+	skel->bss->user_ptr = skel;
+
+	err = bpf_program__set_flags(skel->progs.handle_kprobe_multi_sleepable,
+				     BPF_F_SLEEPABLE);
+	if (!ASSERT_OK(err, "bpf_program__set_flags"))
+		goto cleanup;
+
+	/* Load should succeed even with BPF_F_SLEEPABLE for KPROBE types */
+	err = kprobe_multi_sleepable__load(skel);
+	if (!ASSERT_OK(err, "kprobe_multi_sleepable__load"))
+		goto cleanup;
+
+	skel->links.handle_kprobe_multi_sleepable =
+		bpf_program__attach_kprobe_multi_opts(skel->progs.handle_kprobe_multi_sleepable,
+						      "bpf_fentry_test1", NULL);
+
+	ASSERT_EQ(libbpf_get_error(skel->links.handle_kprobe_multi_sleepable),
+		  -EINVAL, "attach_multi_sleepable_err");
+
+	ASSERT_ERR_PTR(skel->links.handle_kprobe_multi_sleepable,
+		       "bpf_program__attach_kprobe_multi_opts");
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.fentry), &topts);
+
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+cleanup:
+	kprobe_multi_sleepable__destroy(skel);
+}
+
 #ifdef __x86_64__
 static void test_attach_write_ctx(void)
 {
@@ -676,5 +750,7 @@ void test_kprobe_multi_test(void)
 		test_unique_match();
 	if (test__start_subtest("attach_write_ctx"))
 		test_attach_write_ctx();
+	if (test__start_subtest("attach_multi_sleepable"))
+		test_attach_multi_sleepable();
 	RUN_TESTS(kprobe_multi_verifier);
 }
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

