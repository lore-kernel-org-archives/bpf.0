Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6904C43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8509C20840
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VSWYKk62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfCBDm3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:42:29 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37901 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfCBDm2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 22:42:28 -0500
Received: by mail-pl1-f201.google.com with SMTP id x11so19168311pln.5
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 19:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I0pGyStcZyAMwI6X28HWgX7AChHDBZcXKOzKJP279qU=;
        b=VSWYKk628Q7xnZl+cpC31Wlbr54DaHBFfWPw0jxXqbWoFwm0nAzEXg/itkvZAxBbHL
         QczUkhbHlj3fskRj5Qmd+QTWyZo3WMTfWT8MNY9i0zUj0HPadfsSbEIm4pCIPV0DUJg3
         n+KBFb6iYicKfiMiNmYqoW94OwvlHQbJDfKWL3Ceb3pj/zkhNh8mf6cE3nnIyYVUPSel
         dBRXhQ7p0UdYZtoSeHr3pk85Ldgw9maV4movJEIdxGriMARfVYQk20ec+U1W8EbOzbBk
         jFw5dMXxNSSofdRg//K0aU+nloyLIMmcwbVgkyNGp2zFi8dMANH+ncUBiIA5V3fy+1iX
         zAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I0pGyStcZyAMwI6X28HWgX7AChHDBZcXKOzKJP279qU=;
        b=O3bT0x9QiWuY8ylBS+qvpo40i6zyR9z2H/XUnmLFP5Ym1StVIjDyMNg/IL2z84MsQx
         +jAqfkV2aex8MRvqKQaTZxNURVjaS0tD1b1YLL8yYOW86+CI3x3ibS3Prop0NijPEUwJ
         W2ZOFZXbnsmTFVvVk2K0R8Joyv1SMLmtXZgBmKIrzH3uOkHnapY5OFzjeg9bRDFvJq8g
         5URA7gMtKNgziK2FsoewZuI4yOWBGY/s9Fgz/iUIQAN4Z/B0SaeALRrMk69HotBujvXP
         UbXU7EWt2tls/y6G2qqBlS/QG69nB/VMePFWQXpTGLpOulmy0CcuOetZ6kLsil5gQoNt
         Ya4g==
X-Gm-Message-State: AHQUAuYpGQqUNF/3ZrlFZdHbR2Pm2GrkY77wQWtDMlk8yPqTE+Ts0Ucp
        JeX6wYeqpcwSm1JglGM6P0kZS+w=
X-Google-Smtp-Source: AHgI3IYH7pTDDYSX2aAdMgxCyikHFmss7AUEN42e5GAQitoBiYbdrFJ5SoddIr7ysttpXTwnzzuhHyw=
X-Received: by 2002:a62:41c4:: with SMTP id g65mr3363769pfd.5.1551498147725;
 Fri, 01 Mar 2019 19:42:27 -0800 (PST)
Date:   Fri,  1 Mar 2019 19:42:14 -0800
In-Reply-To: <20190302034219.99480-1-sdf@google.com>
Message-Id: <20190302034219.99480-3-sdf@google.com>
Mime-Version: 1.0
References: <20190302034219.99480-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH bpf-next v3 2/7] selftests: bpf: break up test_progs - pkt access
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
index e3f74fb617c1..4f5709615749 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -40,33 +40,6 @@ int bpf_find_map(const char *test, struct bpf_object *obj, const char *name)
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
@@ -648,28 +621,6 @@ static void test_bpf_obj_id(void)
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
@@ -2095,7 +2046,6 @@ int main(void)
 #define CALL
 #include <prog_tests/tests.h>
 #undef CALL
-	test_pkt_access();
 	test_prog_run_xattr();
 	test_xdp();
 	test_xdp_adjust_tail();
@@ -2103,7 +2053,6 @@ int main(void)
 	test_xdp_noinline();
 	test_tcp_estats();
 	test_bpf_obj_id();
-	test_pkt_md_access();
 	test_obj_name();
 	test_tp_attach_query();
 	test_stacktrace_map();
-- 
2.21.0.352.gf09ad66450-goog

