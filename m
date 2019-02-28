Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6753CC4360F
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 01:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B28218A5
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 01:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eSRwI3M1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbfB1BCE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:02:04 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:54521 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfB1BCD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 20:02:03 -0500
Received: by mail-qt1-f201.google.com with SMTP id j22so17041882qtq.21
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 17:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=95n6QdsqPcNtIuspkuuuFUNsPItQedo1bHA2bDFb1cU=;
        b=eSRwI3M1/+mBRZgsYpWs3gKhp/AP+4HrYEMlAx5EB4GLanDunplR7XVUI+U0uut+s2
         AhHanYN9UESunxNUrahe9hxGm5hh9O44DBjytxazdZu5zrCIL+H+6TGAJWZt08xqxUdG
         nfGUossw9VvV++32P9F4oTpVKIKLhNqr23FhAURYzTmQ/WvX/qN9Jc/LHAIWsO7aNo1E
         VL351efh7o2HybR1vfca+octAW+oC7RO6HC5Ah7F8fU81GpuKQu8nqsME2re+HQq7Q6c
         PzI1KVfP4fKCIiifoM/STMVGSdKzTQ77xCcJrluV0Ree4uantDQk1yY2jzXH1c9sKCCg
         FB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=95n6QdsqPcNtIuspkuuuFUNsPItQedo1bHA2bDFb1cU=;
        b=aJ2D+0TRAKcAZMJnK9VPlaL600rTww8jliKfo20FLPMG5VwS0mYz92cTlSPRL9e9gn
         M9uCjmTGnEpyliTgAOKsqQ435rtlwPS5zqBrbPwDDnIE/sjkarSsAfUa0BPG87OxW4iw
         UGbpaO1yzshQfa8knMTeVxhVcji+XA6oRylelRKcFpLRbiQkBXF2wl9+0PVfppRD5av+
         HyyVimkrszcE/VPx85LfF/w9X8pCsc2fH100BFoDbo+2mDd8ciKntWxagmnPnEUGnDKL
         W4n+MafaVFBQzkF0kkWh1RXmFe6hTjtmcHqTgpSa02bv/VKSGGFkCokWJhBeDXA8tlTo
         xAeQ==
X-Gm-Message-State: APjAAAUrz6uthIxw0zyJBbEjiVRpO9qWE5jyc57vdivFh3XN4SZ4Lrxt
        9lgIYVgcBIujbfvjbICFSFqqZ0c=
X-Google-Smtp-Source: APXvYqxCkDq/+KZY/+fAL/eUaPVpe/oWjkexPG1HanaD15xbfl5eSj3J174gHb5W1AOrnANgw1ml0bk=
X-Received: by 2002:a0c:d95d:: with SMTP id t29mr2487658qvj.55.1551315722043;
 Wed, 27 Feb 2019 17:02:02 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:01:51 -0800
In-Reply-To: <20190228010156.82981-1-sdf@google.com>
Message-Id: <20190228010156.82981-2-sdf@google.com>
Mime-Version: 1.0
References: <20190228010156.82981-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH bpf-next 2/7] selftests: bpf: break up test_progs - pkt access
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move pkt access prog tests into separate files.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/pkt_access.c     | 29 +++++++++++
 .../selftests/bpf/prog_tests/pkt_md_access.c  | 24 +++++++++
 tools/testing/selftests/bpf/test_progs.c      | 51 -------------------
 3 files changed, 53 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pkt_access.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pkt_md_access.c

diff --git a/tools/testing/selftests/bpf/prog_tests/pkt_access.c b/tools/testing/selftests/bpf/prog_tests/pkt_access.c
new file mode 100644
index 000000000000..4ecfd721a044
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/pkt_access.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_pkt_access(void)
+{
+	const char *file = "./test_pkt_access.o";
+	struct bpf_object *obj;
+	__u32 duration, retval;
+	int err, prog_fd;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_fd);
+	if (err) {
+		error_cnt++;
+		return;
+	}
+
+	err = bpf_prog_test_run(prog_fd, 100000, &pkt_v4, sizeof(pkt_v4),
+				NULL, NULL, &retval, &duration);
+	CHECK(err || retval, "ipv4",
+	      "err %d errno %d retval %d duration %d\n",
+	      err, errno, retval, duration);
+
+	err = bpf_prog_test_run(prog_fd, 100000, &pkt_v6, sizeof(pkt_v6),
+				NULL, NULL, &retval, &duration);
+	CHECK(err || retval, "ipv6",
+	      "err %d errno %d retval %d duration %d\n",
+	      err, errno, retval, duration);
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c b/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c
new file mode 100644
index 000000000000..ac0d43435806
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/pkt_md_access.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_pkt_md_access(void)
+{
+	const char *file = "./test_pkt_md_access.o";
+	struct bpf_object *obj;
+	__u32 duration, retval;
+	int err, prog_fd;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_fd);
+	if (err) {
+		error_cnt++;
+		return;
+	}
+
+	err = bpf_prog_test_run(prog_fd, 10, &pkt_v4, sizeof(pkt_v4),
+				NULL, NULL, &retval, &duration);
+	CHECK(err || retval, "",
+	      "err %d errno %d retval %d duration %d\n",
+	      err, errno, retval, duration);
+
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index e49a1e20dc63..91bb5c8a97c9 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -39,33 +39,6 @@ int bpf_find_map(const char *test, struct bpf_object *obj, const char *name)
 	return bpf_map__fd(map);
 }
 
-static void test_pkt_access(void)
-{
-	const char *file = "./test_pkt_access.o";
-	struct bpf_object *obj;
-	__u32 duration, retval;
-	int err, prog_fd;
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_fd);
-	if (err) {
-		error_cnt++;
-		return;
-	}
-
-	err = bpf_prog_test_run(prog_fd, 100000, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "ipv4",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
-
-	err = bpf_prog_test_run(prog_fd, 100000, &pkt_v6, sizeof(pkt_v6),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "ipv6",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
-	bpf_object__close(obj);
-}
-
 static void test_prog_run_xattr(void)
 {
 	const char *file = "./test_pkt_access.o";
@@ -647,28 +620,6 @@ static void test_bpf_obj_id(void)
 		bpf_object__close(objs[i]);
 }
 
-static void test_pkt_md_access(void)
-{
-	const char *file = "./test_pkt_md_access.o";
-	struct bpf_object *obj;
-	__u32 duration, retval;
-	int err, prog_fd;
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_fd);
-	if (err) {
-		error_cnt++;
-		return;
-	}
-
-	err = bpf_prog_test_run(prog_fd, 10, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, &retval, &duration);
-	CHECK(err || retval, "",
-	      "err %d errno %d retval %d duration %d\n",
-	      err, errno, retval, duration);
-
-	bpf_object__close(obj);
-}
-
 static void test_obj_name(void)
 {
 	struct {
@@ -2094,7 +2045,6 @@ int main(void)
 #define CALL
 #include <prog_tests/tests.h>
 #undef CALL
-	test_pkt_access();
 	test_prog_run_xattr();
 	test_xdp();
 	test_xdp_adjust_tail();
@@ -2102,7 +2052,6 @@ int main(void)
 	test_xdp_noinline();
 	test_tcp_estats();
 	test_bpf_obj_id();
-	test_pkt_md_access();
 	test_obj_name();
 	test_tp_attach_query();
 	test_stacktrace_map();
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

