Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86C199E89
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777248975; cv=none; b=jRVzsiyFJvIlieEEJkZayTQZSD2Gwdhw3tUFgt4KSQv5KBc8rVzFa5fB6Z7/fSlyJ/3OxfHwqzE77i77ThJdHnmqHih2ba1MINg+lajevhzwg1GdtY0UBg/KxEHyM3hmb45sV7iFk1dHFG2RJofpEBNvdvbNthvGgMPPHkh0zlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777248975; c=relaxed/simple;
	bh=NjT6WS99dzsH0BNHG0qiOHBrOhXLz3TwFeCMkEzyuU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFEk348tjk/t4ba9yfH4wl21yAJqP5RAPk5zfARiDBfusHAtW0Wx8hKgMN1PAJ1tD+xgdQZ442XzS8XaGnqcrUnSKGAY3zkBhDLa0YJdp+hCCDw86MgPX8uMTIkwG5NsnftEnGyt/HKmQJSgGCSyjmFtxmFFnRmn5N00EhnD2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jeo4rHrz; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jeo4rHrz"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8e8c0c2d2bcso571466485a.1
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 17:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777248973; x=1777853773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrEKOElBE1O+qzK7jpp9/RCzGfUO3JW960CxJ57Fjyc=;
        b=Jeo4rHrzN9MXkd4r4GVp0x1dC9avVGEfwPZoHuX2EMILEDyd99CRUdfSf6G3bmwtqi
         kTbxVmNEf8lM3F7Q4zb5W9+3YOFphzwQ5hoyqr81oKx5xgvN4svY8lLkB0T9fuUbUTwz
         SKW9ssU2jh9Zx3D+ghfdTxFi1cAJ19o5MLktdyhJXQ+BhVBBNIXqIijzHEoH2wAJNOnH
         uiOHhInUF6CT5hnifgzJ6XU1HGctS7D3GizZh1vFXKWatsw+RwzF/f3Pj5crJDJJexDc
         Qys4WncRswla+GMCr6mWA0wfeJGztcYMtLlBc+Iv9abBfU53bayc04riRuRF5pLwpf/M
         +BWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777248973; x=1777853773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wrEKOElBE1O+qzK7jpp9/RCzGfUO3JW960CxJ57Fjyc=;
        b=ZsnO4fenCTRHUPEmshGsNJ7WNlr5XntRst/S5wz4npeiL7NDmsxchARW57oY85JZss
         /sVDGndZ66aywetxIoGQjqRTnAkuKSQKAIO0F/qNCbnbzYaOcWm4dSRniZWHWLFIA2Vm
         o9Exx7O4jZrHOQNsuNkyBzsjIJ+lHM/S632U+EK+8oEcWdZ3li4Ko4dyjN3oyFLKxhbR
         O4z2YmoLNS+Gocgz7JB6vE6VsVzvA6g60A0OXUbZENbBsBFiR3VpAOdgXI8dJI2kA+HI
         OKUmjGbdnnIEW3ZXT8Sjy1HT1RN7Cc8rxMVw2oiVl8y/Vc8iOz0GiMP6V14llLcjA6kb
         SeJg==
X-Forwarded-Encrypted: i=1; AFNElJ/DuKHE7ASMp3emhc+Zax+W4abT5pRP2rEtP8+lxtxzFh2OaWV7W4Ny2tNzAqx1ROoI9Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBQsxTGeNy6l5dJ8nZRQq+CaV+pBHw+1LMPjMI/CKPZ2NQG4j
	eBAi6eKFENync0xuCJZ5AQJRma4dkHR6I0ybwGZfKakmw07QyYLJbA0U
X-Gm-Gg: AeBDieu05yvnR/b1+VDo06T2i8NlrSiL+w8jtUr3gQIIJLp0x906JBX5HcZn/Yep1uJ
	DgNQiet5yttcpCo7vkALS1apLP0TgZSje64fnbC82zWOJGX8bbUNiPHhi6ZdjiL4uBGToOEhHKR
	OdAixpSwS6Jny5+nOoBewEO0ZnzdBsLGmqbjYjfLPmabF4K8iYKMs999yjjlJtLYMHyz6I3KjfX
	37H7YY1aIsnv868f4M2bSLjmuNYOkUsc1jferyuxSCUnyoz3V9h59pYrq0tIxpr0alkLvJhMP94
	Y0hQ6VCIdYGsRRUNSVVeSrqik/cyjYksxcmiKA9GlVmeEM4ZbAezISuuADLy/p8LqK5YvstbzSQ
	Lcnhq+U2vcbPpPdYEntEjfBiJYhQATyL+kSXLvk+i77aPQcsZWTRCuGIhYNLXRdMO3OFQCOcVjn
	MrpxoN0tns2KcyfLqOKUo/Vmq2Dp9WVftEbcqa7x5cQtqtEsccPdT0oYzLhyJ8slBiXgpJeBpi/
	fHfHBwar66ckEgkdxXDWzpbxMKLxMAo6HvrjVd829w9vllOhKXD471wqrCG8Lg=
X-Received: by 2002:a05:620a:2913:b0:8cd:94f9:1bb1 with SMTP id af79cd13be357-8e79010e10emr5699714285a.27.1777248973121;
        Sun, 26 Apr 2026 17:16:13 -0700 (PDT)
Received: from battery.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d6ba19c3sm2464025485a.21.2026.04.26.17.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 17:16:12 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: add tests for bpf_init_inode_xattr kfunc
Date: Sun, 26 Apr 2026 20:15:58 -0400
Message-ID: <20260427001602.38353-3-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427001602.38353-1-dwindsor@gmail.com>
References: <20260427001602.38353-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Test bpf atomic inode xattr labeling in inode_init_security.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  3 ++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 49 +++++++++++++++++++
 .../bpf/progs/test_init_inode_xattr.c         | 32 ++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_init_inode_xattr.c

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index ae71e9b69051..15507a406266 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -92,4 +92,7 @@ extern int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags) __ksym __weak;
 extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str) __ksym __weak;
 
+extern int bpf_init_inode_xattr(const char *name__str,
+				const struct bpf_dynptr *value_p) __ksym __weak;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
index 43a26ec69a8e..26daef116ee2 100644
--- a/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
@@ -9,6 +9,7 @@
 #include <test_progs.h>
 #include "test_get_xattr.skel.h"
 #include "test_set_remove_xattr.skel.h"
+#include "test_init_inode_xattr.skel.h"
 #include "test_fsverity.skel.h"
 
 static const char testfile[] = "/tmp/test_progs_fs_kfuncs";
@@ -268,6 +269,51 @@ static void test_fsverity(void)
 	remove(testfile);
 }
 
+static void test_init_inode_xattr(void)
+{
+	struct test_init_inode_xattr *skel = NULL;
+	int fd = -1, err;
+	char value_out[32];
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
+	/* Create a new file — this triggers inode_init_security */
+	fd = open(testfile_new, O_CREAT | O_RDWR, 0644);
+	if (!ASSERT_GE(fd, 0, "create_file"))
+		goto out;
+
+	ASSERT_EQ(skel->data->init_result, 0, "init_result");
+
+	/* The initxattrs callback prepends "security." to the name */
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
+	ASSERT_EQ(strncmp(value_out, "test_value",
+			  sizeof("test_value")), 0, "xattr_value");
+
+out:
+	close(fd);
+	test_init_inode_xattr__destroy(skel);
+	remove(testfile_new);
+}
+
 void test_fs_kfuncs(void)
 {
 	/* Matches xattr_names in progs/test_get_xattr.c */
@@ -286,6 +332,9 @@ void test_fs_kfuncs(void)
 	if (test__start_subtest("set_remove_xattr"))
 		test_set_remove_xattr();
 
+	if (test__start_subtest("init_inode_xattr"))
+		test_init_inode_xattr();
+
 	if (test__start_subtest("fsverity"))
 		test_fsverity();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c b/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c
new file mode 100644
index 000000000000..450798893566
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_init_inode_xattr.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Isovalent, a Cisco company. */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_pid;
+int init_result = -1;
+
+const char xattr_name[] = "bpf.test_label";
+char xattr_value[] = "test_value";
+
+SEC("lsm/inode_init_security")
+int BPF_PROG(test_init_inode_xattr, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, struct xattr *xattrs, int *xattr_count)
+{
+	struct bpf_dynptr value_ptr;
+	__u32 pid;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	bpf_dynptr_from_mem(xattr_value, sizeof(xattr_value), 0, &value_ptr);
+	init_result = bpf_init_inode_xattr(xattr_name, &value_ptr);
+
+	return 0;
+}
-- 
2.53.0

