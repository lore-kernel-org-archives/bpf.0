Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09612C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87772085A
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bap2qXcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbfB1XYz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:24:55 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:37370 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731381AbfB1XYx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 18:24:53 -0500
Received: by mail-yw1-f73.google.com with SMTP id r67so19553117ywd.4
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=95n6QdsqPcNtIuspkuuuFUNsPItQedo1bHA2bDFb1cU=;
        b=Bap2qXcG+IB6MjKNJ8fP9civu3cANBhGyGz2K7c1fIhdD3mQXr+4TKGEbp0Eo3EM4I
         UUHqqPgnZlT27ytEmloIr0jgx2bPrlJ7Tkf3m7xJK5W5S8qnY4urwIj7TlGnJCMOJpr1
         4Bmd+3cKmRI5lTkBxlbEAjxK4iDt3FCihYyKrkUpAhD+68v4uCpUjyff/ksg+h4mPPzx
         faKIXZLLTkLAJlSAE8jwPVYAdZFF8WWTHiFA5ABzcA3Gr6XAgSr8rVz6C45lZrSyPEKD
         IKzoCdt+ZAMykRM70vFXsCL7wxD9rpWZ0J3cTsFZVKABBloT7Dowj5bvR2jDOQKLYlhJ
         Mjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=95n6QdsqPcNtIuspkuuuFUNsPItQedo1bHA2bDFb1cU=;
        b=DN8qZYUCKT6pGlz/N0QeuKb1WB6+C4KAkogNMTW0Kb6PB3Nqtbn9qYz8b4wADdEwee
         xackwrXNKshk9hS72WqnRGtrA5XfZ375L/w+cIQ6IquVOdI5J/m9WTG2XFv9XhPeQUTl
         wrIYoMDtYafuRTxIv6kDi1B/fBziEoP0+DCelgelMqxfGp6jmGRJrjYXf4IAix0DHp8Y
         1bU34City4pXwszbdB8lQUiql+zrcdVaKb7b6jO/8eTkoT9XwSLQwTbQ0aXM6UG6KxDw
         eHqfgIo6GbB87qyGH/nKVEfljcsR0NpcfsyILYVyx6JYIe6jue7FIga/73Wmr6hByD+C
         pYWw==
X-Gm-Message-State: APjAAAVkWFIMido6XzNaI48YKarMau+GIiMEDRVR/wscCO2Soyir9yDn
        dpd1vlk3iXusVQ92bIyweoO0KgE=
X-Google-Smtp-Source: APXvYqyROHE8xsQkRVLWL+sLJpeW3CrDE/TjSwF+ysJ5Bq4AxyrG7CS+fU2/ECbozDZAH0sbgEQZneo=
X-Received: by 2002:a81:84c1:: with SMTP id u184mr845252ywf.9.1551396292540;
 Thu, 28 Feb 2019 15:24:52 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:24:35 -0800
In-Reply-To: <20190228232440.28668-1-sdf@google.com>
Message-Id: <20190228232440.28668-3-sdf@google.com>
Mime-Version: 1.0
References: <20190228232440.28668-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH bpf-next v2 2/7] selftests: bpf: break up test_progs - pkt access
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

