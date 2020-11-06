Return-Path: <SRS0=kVCt=EM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FF4C388F7
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 00:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D705420786
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 00:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="kc2XFpTC";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCOx0iu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbgKFAGw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:06:52 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59487 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729162AbgKFAGt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 19:06:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 371905C0236;
        Thu,  5 Nov 2020 19:06:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 05 Nov 2020 19:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=mkQNWZBo7LAmh
        Gnqr0maVLRmZnUOpV0QQCTASmqfUzw=; b=kc2XFpTCzvdVbSWvKFkR3brub8cob
        cFB4LY6w8D0QsjQU/qrNwVbTqCvgU2jGinCmZyI75uPCQHrPTGandCV/+zlgBy44
        CMOdhjpjdcSqFHsGSGVBhdCbDNoNGp6Df3re3ufMU1tUOoveujq16BtmYJLYYuht
        75vdo/ip3BagD3oHwg7qv0onyvJftuPD+lZNExrLMxdzDsc6RRE4jkcQBbRqCGFx
        9pNHwrLhjH5vdKW/8X6o07ivHa3kiy/xMh0p6GxfZIS98kyFbVoWWMoSZsTaBQ4Z
        H0Iimvi8MeRtuqS8woezslb9JLfXJwCkNukf+ukirr7IZC7pVtUeSzRCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=mkQNWZBo7LAmhGnqr0maVLRmZnUOpV0QQCTASmqfUzw=; b=cCOx0iu/
        pl2ufcvgyJkeo3c0cnCRagpzc6oEfb07uAAw15qDvUB9JmTzEsyuFdT1PctsFPj9
        VR2vjWmuXxFBBhNB8HeoPGBzGDjW+ZY9NBkTQpQVlUBWqGHvDa1eKRhEu3bEoUM4
        m7BjHhbIeWJZ3VXrH3Mm+VMhB6D7vsGEV8anC7qsycajqC4CfGngmrza4ZwNaYZP
        95i8v7tE3EHGC+ODghtoJYQa4BPV9UOM5vmXW/Y/WHxffwwgowdJJLtDH+GSyEMV
        +Sk8bd0V9ZPnTDCHVWIpwyFxt9/6frj7Knq4pWvVS/cnPHyzXhi0137NlzoHXaMZ
        xc20UgA9DnuHbA==
X-ME-Sender: <xms:mJOkXw9thcV-esprnfquqNNHkbjRvEJjOSq2W2-e-h-wXxg1ZYeM7Q>
    <xme:mJOkX4sFlc1iEsD_e6rTDRD6aSFFVDKZonQOcqpGwIAFIa5V4YipqFzNZYFRFqDWJ
    3aiW8sxmA43C88riA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgkeduleekhfetvefhge
    fgvdegfeejfefguedvuddthffggffhhedtueeuteefieenucfkphepieelrddukedurddu
    tdehrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:mJOkX2CW8gjR8xvZJmDfjReii6m1OActMZuqlz2DImQMk_xVYL_nQQ>
    <xmx:mJOkXwezx-cshV_BwwGsFnuqGPhs9j0xp8toWk8JqX4H7KtBv0HelQ>
    <xmx:mJOkX1NIl3PPM79RqtBSHIddx_eDfNrWW8XsULoI69T1bojfbg3MFg>
    <xmx:mJOkX41lzknFsSmIG6PmDaVq8XIUa_1oNNfO-H9usDsvnxj2mAmr5w>
Received: from localhost.localdomain (c-69-181-105-64.hsd1.ca.comcast.net [69.181.105.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A71C328037B;
        Thu,  5 Nov 2020 19:06:47 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com
Subject: [PATCH bpf v4 2/2] selftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes after NUL
Date:   Thu,  5 Nov 2020 16:06:35 -0800
Message-Id: <8b8c8f51aff8fabac4425da9b0054b4c976c944b.1604620776.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604620776.git.dxu@dxuuu.xyz>
References: <cover.1604620776.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously, bpf_probe_read_user_str() could potentially overcopy the
trailing bytes after the NUL due to how do_strncpy_from_user() does the
copy in long-sized strides. The issue has been fixed in the previous
commit.

This commit adds a selftest that ensures we don't regress
bpf_probe_read_user_str() again.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../bpf/prog_tests/probe_read_user_str.c      | 71 +++++++++++++++++++
 .../bpf/progs/test_probe_read_user_str.c      | 25 +++++++
 2 files changed, 96 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_user_str.c

diff --git a/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
new file mode 100644
index 000000000000..e419298132b5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "test_probe_read_user_str.skel.h"
+
+static const char str1[] = "mestring";
+static const char str2[] = "mestringalittlebigger";
+static const char str3[] = "mestringblubblubblubblubblub";
+
+static int test_one_str(struct test_probe_read_user_str *skel, const char *str,
+			size_t len)
+{
+	int err, duration = 0;
+	char buf[256];
+
+	/* Ensure bytes after string are ones */
+	memset(buf, 1, sizeof(buf));
+	memcpy(buf, str, len);
+
+	/* Give prog our userspace pointer */
+	skel->bss->user_ptr = buf;
+
+	/* Trigger tracepoint */
+	usleep(1);
+
+	/* Did helper fail? */
+	if (CHECK(skel->bss->ret < 0, "prog_ret", "prog returned: %ld\n",
+		  skel->bss->ret))
+		return 1;
+
+	/* Check that string was copied correctly */
+	err = memcmp(skel->bss->buf, str, len);
+	if (CHECK(err, "memcmp", "prog copied wrong string"))
+		return 1;
+
+	/* Now check that no extra trailing bytes were copied */
+	memset(buf, 0, sizeof(buf));
+	err = memcmp(skel->bss->buf + len, buf, sizeof(buf) - len);
+	if (CHECK(err, "memcmp", "trailing bytes were not stripped"))
+		return 1;
+
+	return 0;
+}
+
+void test_probe_read_user_str(void)
+{
+	struct test_probe_read_user_str *skel;
+	int err, duration = 0;
+
+	skel = test_probe_read_user_str__open_and_load();
+	if (CHECK(!skel, "test_probe_read_user_str__open_and_load",
+		  "skeleton open and load failed\n"))
+		return;
+
+	/* Give pid to bpf prog so it doesn't read from anyone else */
+	skel->bss->pid = getpid();
+
+	err = test_probe_read_user_str__attach(skel);
+	if (CHECK(err, "test_probe_read_user_str__attach",
+		  "skeleton attach failed: %d\n", err))
+		goto out;
+
+	if (test_one_str(skel, str1, sizeof(str1)))
+		goto out;
+	if (test_one_str(skel, str2, sizeof(str2)))
+		goto out;
+	if (test_one_str(skel, str3, sizeof(str3)))
+		goto out;
+
+out:
+	test_probe_read_user_str__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
new file mode 100644
index 000000000000..3ae398b75dcd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include <sys/types.h>
+
+pid_t pid = 0;
+long ret = 0;
+void *user_ptr = 0;
+char buf[256] = {};
+
+SEC("tracepoint/syscalls/sys_enter_nanosleep")
+int on_write(void *ctx)
+{
+	if (pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	ret = bpf_probe_read_user_str(buf, sizeof(buf), user_ptr);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.28.0

