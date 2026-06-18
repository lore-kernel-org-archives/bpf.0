Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E3351C2E
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814862; cv=none; b=InkqHW36uHLLu0RM6YzI+wxFudjxSyEOTGoBkjTl3n0nmKSlC/Lr1ICrEL1Q/9iukBdjKS9IKZvoXt13osNB7eGFkZtQ8dP3RRMJ5WPVdaY74oxC8zZDMgh1nWPnRs8dUL8ecv534Xx84vc+wcacWdO0KKfrL8G00Oq8F4/vyp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814862; c=relaxed/simple;
	bh=r4h8PrTc14+Jb9KVCjREjZqooDGZDEoHV/lbqWozPiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbIKWYz+qDc4lsox2K7I4BgZCooP2hvscbXRTP6sfXNtUel3JqenVFPXLdGfM4W+bkSbtJh8GXnRTe4E3hrOfL6bMLLu2pUp152tGkMxMTLUmNBa8jj8Cm51k8NWwTHZSdkT+44LnL/WBWQfPJBj/Ht5mrOdKKGijkdtQ7wRJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8eWgbdY; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8eWgbdY"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517dc520840so13607751cf.3
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 13:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781814858; x=1782419658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RMN0VH8IUwxnA/+jZ+RRwIijY8+Uf8ufr9lR4CaAaM=;
        b=h8eWgbdYfhT2dD7tpv5RKpSig598hqCPw+srqbVABP75cvdSdnl7WtCxvemAWxJ5tI
         96eDRhNGgHwxfFkEYuKgEAfGw6yWD0Y65KWH0vl1Ttn+1V3LaKhDt7HCm51KW0bFl2TI
         MhkH9GfrgbMVjoynjBC5YRP3kRk/DZtRm1JxDtWkELlz5QRLY4u/k05x/utxY/uPAi9y
         Qw4lEb8FDfDcXdZoyOFlb6mFa094pBXiDAMfxLu0EGuOOzt3IxWa4GG6FIiqbSyY0v43
         nnZRdnEE0eSxI79FWcEV2+q6FYPmw86L5AEsHKeC3K+8RwV+Ibx8GDQLHgppsydbzivB
         rpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781814858; x=1782419658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6RMN0VH8IUwxnA/+jZ+RRwIijY8+Uf8ufr9lR4CaAaM=;
        b=DStwSXjFpU72WNthPPX1/U5rQKlqLzAZvWkjLWiSoyRy5TaS45CNWhgacmPZMIaVF1
         6eJEIiKbo3MIK51HhYAwqEOtWgy73bYXWAap2WECrGWYjFyN2vxiukYT7pKUD5p51lgk
         mWuWC7vyKer9/hESxqfCPyzeUYEl0YQ3xGq6zQQnA4HoGlAzLMSw6sLYZJSAZQLrznzy
         oDSJGDAitAHrd+mv6YeV4f2MK4KqlM7Frmb5pIk8S36K/QYi9zuXGzA3iEVWYRjdmLNA
         16w4G7wyYJPJDtYC3ESLCRkt2anmgl2mwYjH1t/5UsTxmZVaGs/kx//Q8Pw0nITCJyiD
         1yqA==
X-Forwarded-Encrypted: i=1; AFNElJ8t0CnoBJ2keNRUW0SETBBQoisFjc/YJ651elJ/Q4myYOf3G1OGpKipVtaCU8lUtSFN8Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymQa1n5umaK3/vniNYi1A4fq86PRcQilxYG+ru5DLd8D/fz6nC
	KtnXyDj05jBb/JWjJhca8B/9laAkX3JV00Y4JSS84GmfSUqrKew5ImY/
X-Gm-Gg: AfdE7cmx+XGRGONcVx+6sHUU8ktrxcbM2fmQNZ+kFBie3bet2c58QuZk4c7baCUL3WD
	pdWLeDKvZKafATloaJYtJ9h2w/MJplzywpbX6LLYDP5uXNF/1dmZtwXzLY6LZvHmthdPFDY5o8G
	Kbtcw/SIV+LIkKvxKS6/u1wiPW2TQky0IyHb7JLN+NRd2MYCeLK9SS0OMejQiWPY1og41ZMMXv9
	0khFX/CQjKVEBzj/bEV97sQZbSYDP7o/RfbmzSNZ8dWPh7P1st9AIUvQHc1Ux2filZ2sAYLCBuG
	dTFdrs3tPWat9Z/WNtwlmDW3dnN5PlxtoVs1oFfMAred22sSd5+0QL4umTpjmqUJq3o9bLmBEBN
	IKH1736h/WpgP0MN70/jS2j44LQ7RmWU9MiLeidDzo9qO3/HAp3acq/bn7Zcd3xutHuBQZ6MVjS
	WD0C9p8RVqyckMzWyecrYiKXQAvSltW/0RxQW6HAnxyKT1dAxwzRx5/rgbFb6BG4kWF97fycBrr
	56B/MNImpQwqYt5N+PKw/mEmw==
X-Received: by 2002:a05:622a:14:b0:516:e249:e30f with SMTP id d75a77b69052e-519e4c94b36mr11943751cf.42.1781814858266;
        Thu, 18 Jun 2026 13:34:18 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8de5e12d1c3sm2176166d6.10.2026.06.18.13.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 13:34:17 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: add tests for bpf_init_inode_xattr kfunc
Date: Thu, 18 Jun 2026 16:34:11 -0400
Message-ID: <20260618203411.73917-3-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618203411.73917-1-dwindsor@gmail.com>
References: <20260618203411.73917-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test bpf atomic inode xattr labeling in inode_init_security.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 105 +++++++++++++++++-
 .../bpf/progs/test_init_inode_xattr.c         |  31 ++++++
 3 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index ae71e9b69051..69d3641ee2d8 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -92,4 +92,9 @@ extern int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags) __ksym __weak;
 extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str) __ksym __weak;
 
+struct xattr_ctx;
+extern int bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
+				const char *name__str,
+				const struct bpf_dynptr *value_p) __ksym __weak;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 43a26ec69a8e..0898898fb125 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -9,9 +9,10 @@
 #include <test_progs.h>
 #include "test_get_xattr.skel.h"
 #include "test_set_remove_xattr.skel.h"
+#include "test_init_inode_xattr.skel.h"
 #include "test_fsverity.skel.h"
 
-static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
+static const char testfile[] = "/tmp/labelme";
 
 static void test_get_xattr(const char *name, const char *value, bool allow_access)
 {
@@ -268,6 +269,102 @@ static void test_fsverity(void)
 	remove(testfile);
 }
 
+static void test_init_inode_xattr(void)
+{
+	struct test_init_inode_xattr *skel = NULL;
+	int fd = -1, err;
+	char value_out[64];
+	const char *testfile_new = "/tmp/test_progs_fs_kfuncs_new";
+
+	skel = test_init_inode_xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_init_inode_xattr__open_and_load"))
+		return;
+
+	skel->bss->monitored_pid = getpid();
+	err = test_init_inode_xattr__attach(skel);
+	if (!ASSERT_OK(err, "test_init_inode_xattr__attach"))
+		goto out;
+
+	/* Trigger inode_init_security */
+	fd = open(testfile_new, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		goto out;
+
+	ASSERT_EQ(skel->data->init_result, 0, "init_result");
+
+	/* initxattrs prepends "security." to the name. */
+	err = getxattr(testfile_new, "security.bpf.test_label", value_out,
+		       sizeof(value_out));
+	if (err < 0 && errno == ENODATA) {
+		printf("%s:SKIP:filesystem did not apply LSM xattrs\n",
+		       __func__);
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_GE(err, 0, "getxattr"))
+		goto out;
+
+	ASSERT_EQ(err, (int)sizeof(skel->data->xattr_value), "xattr_size");
+	ASSERT_EQ(strncmp(value_out, "unconfined_u:object_r:user_home_t:s0",
+			  sizeof("unconfined_u:object_r:user_home_t:s0")), 0,
+		  "xattr_value");
+
+out:
+	close(fd);
+	test_init_inode_xattr__destroy(skel);
+	remove(testfile_new);
+}
+
+/* Keep in sync with BPF_LSM_INODE_INIT_XATTRS in include/linux/bpf_lsm.h. */
+#define INIT_INODE_XATTR_MAX 4
+
+/* At most INIT_INODE_XATTR_MAX programs can attach to inode_init_security. */
+static void test_init_inode_xattr_attach_cap(void)
+{
+	struct test_init_inode_xattr *skel[INIT_INODE_XATTR_MAX + 1] = {};
+	struct bpf_link *link[INIT_INODE_XATTR_MAX + 1] = {};
+	struct bpf_link *extra = NULL;
+	int i, err;
+
+	/* Fill all available xattr slots */
+	for (i = 0; i < INIT_INODE_XATTR_MAX; i++) {
+		skel[i] = test_init_inode_xattr__open_and_load();
+		if (!ASSERT_OK_PTR(skel[i], "open_and_load"))
+			goto out;
+
+		link[i] = bpf_program__attach_lsm(skel[i]->progs.test_init_inode_xattr);
+		if (!ASSERT_OK_PTR(link[i], "attach_within_cap"))
+			goto out;
+	}
+
+	skel[INIT_INODE_XATTR_MAX] = test_init_inode_xattr__open_and_load();
+	if (!ASSERT_OK_PTR(skel[INIT_INODE_XATTR_MAX], "open_and_load_extra"))
+		goto out;
+
+	/* New additions fail with -E2BIG */
+	extra = bpf_program__attach_lsm(skel[INIT_INODE_XATTR_MAX]->progs.test_init_inode_xattr);
+	err = -errno;
+	if (!ASSERT_ERR_PTR(extra, "attach_over_cap_should_fail")) {
+		bpf_link__destroy(extra);
+		goto out;
+	}
+	ASSERT_EQ(err, -E2BIG, "attach_over_cap_errno");
+
+	bpf_link__destroy(link[0]);
+	link[0] = NULL; /* avoid double free in cleanup */
+
+	/* Freeing a slot lets the extra program attach */
+	extra = bpf_program__attach_lsm(skel[INIT_INODE_XATTR_MAX]->progs.test_init_inode_xattr);
+	ASSERT_OK_PTR(extra, "attach_after_detach");
+
+out:
+	bpf_link__destroy(extra);
+	for (i = 0; i <= INIT_INODE_XATTR_MAX; i++) {
+		bpf_link__destroy(link[i]);
+		test_init_inode_xattr__destroy(skel[i]);
+	}
+}
+
 void test_fs_kfuncs(void)
 {
 	/* Matches xattr_names in progs/test_get_xattr.c */
@@ -286,6 +383,12 @@ void test_fs_kfuncs(void)
 	if (test__start_subtest("set_remove_xattr"))
 		test_set_remove_xattr();
 
+	if (test__start_subtest("init_inode_xattr"))
+		test_init_inode_xattr();
+
+	if (test__start_subtest("init_inode_xattr_attach_cap"))
+		test_init_inode_xattr_attach_cap();
+
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c b/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c
new file mode 100644
index 000000000000..6f0e8b02ff88
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Cisco Systems, Inc. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_pid;
+int init_result = -1;
+
+static const char xattr_name[] = "bpf.test_label";
+char xattr_value[] = "unconfined_u:object_r:user_home_t:s0";
+
+SEC("lsm.s/inode_init_security")
+int BPF_PROG(test_init_inode_xattr, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr_ctx *xattr_ctx)
+{
+	struct bpf_dynptr value_ptr;
+	__u32 pid;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	bpf_dynptr_from_mem(xattr_value, sizeof(xattr_value), 0, &value_ptr);
+	init_result = bpf_init_inode_xattr(xattr_ctx, xattr_name, &value_ptr);
+
+	return 0;
+}
-- 
2.53.0

