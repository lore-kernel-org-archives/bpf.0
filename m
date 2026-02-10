Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4F367F27
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732905; cv=none; b=Zue6KX8HC22J5AdqTuKG24WI0ahtxE2+52aBuwIIlTZXWcxRhEyJuLFghKvNFCID6Fke8tTRmYdTyN8oBchez3YvJLAzPNrMurDhx3+L6JXUadHKYkFAe7A6e66P+6mEshNGuKBi5eMU/qTlVCtrHF5vY3XXgqKzQ20Vc6hUYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732905; c=relaxed/simple;
	bh=sqiT3+uyyM6ebZdpvR35gZBu+tS3jCmQS4gar3sPAAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJn1uWe5a2CxMTUT5lvo3aA42Cb125qByueqXCyH9rO3ZNTqEQhVOKW9JknNXbstyFfh7ogI3Z4+zZ7dgLBIYE3cse+IHMMnH98xsGBRFvKQuegMVEuLDEyWyHRlLQQklFMqTMoKMhMaaI59IeFvy5gL4djpp/9JvWlBSEOek8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBkAPhNV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBkAPhNV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770732903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0Nfw5s3TJqNVpXObSZjuDTJd7YW0mVz1NbVuQpSRk4=;
	b=jBkAPhNV1we6gq3suTosksV0Bywnp+7EHAl0bjvmZo0zeEmPySFbbrmModytrBKRDw64uR
	PRiEjbkse0OHjk5SF3qmD84e9vE+AKXH8CWVzj2ZKcL9qENEKQA6/GY9I74oUtsed8jNPr
	7dOLtkWtIldDe3l2YWyTi9+DePhJbck=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-x145FXEgPxaKqDLRBG2O3Q-1; Tue,
 10 Feb 2026 09:15:00 -0500
X-MC-Unique: x145FXEgPxaKqDLRBG2O3Q-1
X-Mimecast-MFC-AGG-ID: x145FXEgPxaKqDLRBG2O3Q_1770732898
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28EA2195608A;
	Tue, 10 Feb 2026 14:14:58 +0000 (UTC)
Received: from vmalik-fedora.brq.redhat.com (unknown [10.43.17.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 043D430002D8;
	Tue, 10 Feb 2026 14:14:53 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jordan Rome <linux@jordanrome.com>,
	Viktor Malik <vmalik@redhat.com>,
	Qais Yousef <qyousef@layalina.io>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Split sleepable fentry from LSM test
Date: Tue, 10 Feb 2026 15:14:32 +0100
Message-ID: <d394f49fc30e0a803ce14fb51be01979738cea05.1770732776.git.vmalik@redhat.com>
In-Reply-To: <cover.1770732776.git.vmalik@redhat.com>
References: <cover.1770732776.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The test_lsm/lsm_basic test contains a test attaching to a sleepable
fentry, which doesn't logically fit into the LSM test suite. In
addition, it makes the entire test fail on kernels which do not support
sleepable fentry programs.

Factor out the sleepable fentry part into a new test fentry_sleepable.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 .../bpf/prog_tests/fentry_sleepable.c         | 28 +++++++++++++++++++
 .../selftests/bpf/prog_tests/test_lsm.c       |  8 ------
 .../selftests/bpf/progs/fentry_sleepable.c    | 28 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       | 21 --------------
 4 files changed, 56 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_sleepable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_sleepable.c b/tools/testing/selftests/bpf/prog_tests/fentry_sleepable.c
new file mode 100644
index 000000000000..efe3ea616575
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_sleepable.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <unistd.h>
+#include "fentry_sleepable.skel.h"
+
+void test_fentry_sleepable(void)
+{
+	struct fentry_sleepable *skel;
+	int buf = 1234;
+	int err;
+
+	skel = fentry_sleepable__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_sleepable__open_and_load"))
+		return;
+
+	err = fentry_sleepable__attach(skel);
+	if (!ASSERT_OK(err, "fentry_sleepable__attach"))
+		goto cleanup;
+
+	syscall(__NR_setdomainname, &buf, -2L);
+	syscall(__NR_setdomainname, 0, -3L);
+	syscall(__NR_setdomainname, ~0L, -4L);
+
+	ASSERT_EQ(skel->bss->copy_test, 3, "copy_test");
+
+cleanup:
+	fentry_sleepable__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/test_lsm.c b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
index bdc4fc06bc5a..67c7c437574a 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_lsm.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_lsm.c
@@ -55,7 +55,6 @@ int exec_cmd(int *monitored_pid)
 static int test_lsm(struct lsm *skel)
 {
 	struct bpf_link *link;
-	int buf = 1234;
 	int err;
 
 	err = lsm__attach(skel);
@@ -82,15 +81,8 @@ static int test_lsm(struct lsm *skel)
 
 	ASSERT_EQ(skel->bss->mprotect_count, 1, "mprotect_count");
 
-	syscall(__NR_setdomainname, &buf, -2L);
-	syscall(__NR_setdomainname, 0, -3L);
-	syscall(__NR_setdomainname, ~0L, -4L);
-
-	ASSERT_EQ(skel->bss->copy_test, 3, "copy_test");
-
 	lsm__detach(skel);
 
-	skel->bss->copy_test = 0;
 	skel->bss->bprm_count = 0;
 	skel->bss->mprotect_count = 0;
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/fentry_sleepable.c b/tools/testing/selftests/bpf/progs/fentry_sleepable.c
new file mode 100644
index 000000000000..621548b97564
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_sleepable.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int copy_test = 0;
+
+SEC("fentry.s/" SYS_PREFIX "sys_setdomainname")
+int BPF_PROG(test_sys_setdomainname, struct pt_regs *regs)
+{
+	void *ptr = (void *)PT_REGS_PARM1_SYSCALL(regs);
+	int len = PT_REGS_PARM2_SYSCALL(regs);
+	int buf = 0;
+	long ret;
+
+	ret = bpf_copy_from_user(&buf, sizeof(buf), ptr);
+	if (len == -2 && ret == 0 && buf == 1234)
+		copy_test++;
+	if (len == -3 && ret == -EFAULT)
+		copy_test++;
+	if (len == -4 && ret == -EFAULT)
+		copy_test++;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index 7de173daf27b..dd5d41903a26 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -9,7 +9,6 @@
 #include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include "bpf_misc.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -161,23 +160,3 @@ int BPF_PROG(test_task_free, struct task_struct *task)
 {
 	return 0;
 }
-
-int copy_test = 0;
-
-SEC("fentry.s/" SYS_PREFIX "sys_setdomainname")
-int BPF_PROG(test_sys_setdomainname, struct pt_regs *regs)
-{
-	void *ptr = (void *)PT_REGS_PARM1_SYSCALL(regs);
-	int len = PT_REGS_PARM2_SYSCALL(regs);
-	int buf = 0;
-	long ret;
-
-	ret = bpf_copy_from_user(&buf, sizeof(buf), ptr);
-	if (len == -2 && ret == 0 && buf == 1234)
-		copy_test++;
-	if (len == -3 && ret == -EFAULT)
-		copy_test++;
-	if (len == -4 && ret == -EFAULT)
-		copy_test++;
-	return 0;
-}
-- 
2.53.0

