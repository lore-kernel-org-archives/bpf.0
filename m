Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BB6C10F13
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 16:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E68C20857
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 16:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fxbh9XPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfDHQEn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:04:43 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:49467 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfDHQEk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 12:04:40 -0400
Received: by mail-ua1-f73.google.com with SMTP id y1so1664048uaq.16
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2019 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UGkvoUGvalrE4O9PVqzTvRKhxc7cE1P5JFCWJIKCuWs=;
        b=fxbh9XPdlDOaJC8XUJxnKcNfry3+J8FLiZ20tBYGW8yPYs84nfWC/fxdbV/a20PCaJ
         oYyY2LYuUIhfZufKl/JDucU4bLhxw/6onrRxW9Dh/uMWDw1ti9YqbMBdkHr0od3DjvHY
         T8ADTaT0GKbXkHnKeZwd6vrJbbr8VUsiynIt8oo39B59swvvWLMkt8an9WlXXLk314BT
         +Ha2JKgo1XiMgAs+v7/YM7maaF7bOCSfi4aLWIBHzz/tA9NLUW51H30ynnS1br1VsJPY
         AZYGQD36uhhNOol5BxQ9XOpPcWdUXYIbJlA5pZp8uw+CQQ6gbsGIAI2ldBE61FGEg7AJ
         uabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UGkvoUGvalrE4O9PVqzTvRKhxc7cE1P5JFCWJIKCuWs=;
        b=gH4pRQ2HXJVX8m8YdfrBlj7mxIl1DiTY4Alj5awoHgMFWxAL8QHmOTzsGkTlssk5du
         U9kgnIg1CGHmQrULREdynlJhirNrUuy4eI+O8E65qT9OWZaDKVIdjp3es53lKkwWO2lZ
         BWHTC/MkygBZvHpIz0WHUjE+tb5RSFYJsdpMCJs8S5Qn0QJQsTFVQGLYmu92VUCpYaRz
         tTVYo7K2rAl5aKuju35xYzwlaZatScCmYRSlj3+jG9kUFsIov8769fRIHJwO2F9TMTJ9
         Q1mrnuwsRRYZooEO5tbFC0A5q38s/mSE7KA9V/THo5eLlw368O8vIhQMTISAyAHbSmPj
         XNwg==
X-Gm-Message-State: APjAAAV+0ukTqzOpUmOHDnPUZGJUV1kk5ybKVxlTw2ZB2VvkVE43cUTd
        pppAvfqLtjrCb46TX7mLkRQfJgI=
X-Google-Smtp-Source: APXvYqzKanfDADmrg7RY6tfAaNVtQasx9KY7EMfTigyA7F7RY7yHyVouSOFYRX4ONojXM88VMCAPzx4=
X-Received: by 2002:ab0:6893:: with SMTP id t19mr3028311uar.24.1554739479661;
 Mon, 08 Apr 2019 09:04:39 -0700 (PDT)
Date:   Mon,  8 Apr 2019 09:04:32 -0700
In-Reply-To: <20190408160432.151478-1-sdf@google.com>
Message-Id: <20190408160432.151478-3-sdf@google.com>
Mime-Version: 1.0
References: <20190408160432.151478-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next v2 3/3] selftests: bpf: add selftest for __sk_buff
 context in BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Simple test that sets cb to {1,2,3,4,5} and priority to 6, runs bpf
program that fails if cb is not what we expect and increments cb[i] and
priority. When the test finishes, we check that cb is now {2,3,4,5,6}
and priority is 7.

We also test the sanity checks:
* ctx_in is provided, but ctx_size_in is zero (same for
  ctx_out/ctx_size_out)
* unexpected non-zero fields in __sk_buff return EINVAL

Cc: Martin Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/skb_ctx.c        | 89 +++++++++++++++++++
 .../selftests/bpf/progs/test_skb_ctx.c        | 21 +++++
 2 files changed, 110 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skb_ctx.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_skb_ctx.c

diff --git a/tools/testing/selftests/bpf/prog_tests/skb_ctx.c b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
new file mode 100644
index 000000000000..e95baa32e277
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/skb_ctx.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_skb_ctx(void)
+{
+	struct __sk_buff skb = {
+		.cb[0] = 1,
+		.cb[1] = 2,
+		.cb[2] = 3,
+		.cb[3] = 4,
+		.cb[4] = 5,
+		.priority = 6,
+	};
+	struct bpf_prog_test_run_attr tattr = {
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.ctx_in = &skb,
+		.ctx_size_in = sizeof(skb),
+		.ctx_out = &skb,
+		.ctx_size_out = sizeof(skb),
+	};
+	struct bpf_object *obj;
+	int err;
+	int i;
+
+	err = bpf_prog_load("./test_skb_ctx.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
+			    &tattr.prog_fd);
+	if (CHECK_ATTR(err, "load", "err %d errno %d\n", err, errno))
+		return;
+
+	/* ctx_in != NULL, ctx_size_in == 0 */
+
+	tattr.ctx_size_in = 0;
+	err = bpf_prog_test_run_xattr(&tattr);
+	CHECK_ATTR(err == 0, "ctx_size_in", "err %d errno %d\n", err, errno);
+	tattr.ctx_size_in = sizeof(skb);
+
+	/* ctx_out != NULL, ctx_size_out == 0 */
+
+	tattr.ctx_size_out = 0;
+	err = bpf_prog_test_run_xattr(&tattr);
+	CHECK_ATTR(err == 0, "ctx_size_out", "err %d errno %d\n", err, errno);
+	tattr.ctx_size_out = sizeof(skb);
+
+	/* non-zero [len, tc_index] fields should be rejected*/
+
+	skb.len = 1;
+	err = bpf_prog_test_run_xattr(&tattr);
+	CHECK_ATTR(err == 0, "len", "err %d errno %d\n", err, errno);
+	skb.len = 0;
+
+	skb.tc_index = 1;
+	err = bpf_prog_test_run_xattr(&tattr);
+	CHECK_ATTR(err == 0, "tc_index", "err %d errno %d\n", err, errno);
+	skb.tc_index = 0;
+
+	/* non-zero [hash, sk] fields should be rejected */
+
+	skb.hash = 1;
+	err = bpf_prog_test_run_xattr(&tattr);
+	CHECK_ATTR(err == 0, "hash", "err %d errno %d\n", err, errno);
+	skb.hash = 0;
+
+	skb.sk = (struct bpf_sock *)1;
+	err = bpf_prog_test_run_xattr(&tattr);
+	CHECK_ATTR(err == 0, "sk", "err %d errno %d\n", err, errno);
+	skb.sk = 0;
+
+	err = bpf_prog_test_run_xattr(&tattr);
+	CHECK_ATTR(err != 0 || tattr.retval,
+		   "run",
+		   "err %d errno %d retval %d\n",
+		   err, errno, tattr.retval);
+
+	CHECK_ATTR(tattr.ctx_size_out != sizeof(skb),
+		   "ctx_size_out",
+		   "incorrect output size, want %lu have %u\n",
+		   sizeof(skb), tattr.ctx_size_out);
+
+	for (i = 0; i < 5; i++)
+		CHECK_ATTR(skb.cb[i] != i + 2,
+			   "ctx_out_cb",
+			   "skb->cb[i] == %d, expected %d\n",
+			   skb.cb[i], i + 2);
+	CHECK_ATTR(skb.priority != 7,
+		   "ctx_out_priority",
+		   "skb->priority == %d, expected %d\n",
+		   skb.priority, 7);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_skb_ctx.c b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
new file mode 100644
index 000000000000..7a80960d7df1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_skb_ctx.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include "bpf_helpers.h"
+
+int _version SEC("version") = 1;
+char _license[] SEC("license") = "GPL";
+
+SEC("skb_ctx")
+int process(struct __sk_buff *skb)
+{
+	#pragma clang loop unroll(full)
+	for (int i = 0; i < 5; i++) {
+		if (skb->cb[i] != i + 1)
+			return 1;
+		skb->cb[i]++;
+	}
+	skb->priority++;
+
+	return 0;
+}
-- 
2.21.0.392.gf8f6787159e-goog

