Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB72AC282DA
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 17:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB8620857
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 17:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k25hOwzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDIR1s (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:27:48 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:49769 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfDIR1r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 13:27:47 -0400
Received: by mail-qk1-f202.google.com with SMTP id 23so15061877qkl.16
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2019 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UGkvoUGvalrE4O9PVqzTvRKhxc7cE1P5JFCWJIKCuWs=;
        b=k25hOwzpBUAYswSu5bY3u2BQFNi2BlNtfkeHNl4OxNvbuNrgVmA7o6B5qNMNvvIClN
         yE4XfRHcHtLLM+4tTN28TeiOfEQFT0+mfoqwOfOR/2Pc+Jm8NA3Q5Pba8AivbUiCx6hF
         yirXoWUSn1HYadMB2HxWUiB+RLrU/sDcOyDa8N+n2wFl8XRTFNzbbVhCUqa9mVb+9WXt
         cffXtcc5jYaW8GdL1/kPQsbTYA/RciW0d5X8zeNKUxyhKwAXGlHqMG5Ys4GB4Pao8Q6R
         StGYJwNiPB0FIi3gg1qrvV8KreUTcEVT+xgxPPNn3iUKHy8vMtjUeuo8tYBedF4IG47c
         Kfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UGkvoUGvalrE4O9PVqzTvRKhxc7cE1P5JFCWJIKCuWs=;
        b=He7yRfqvqKyxa5FoA0rhDoFsrkhc14VjbLpS2VZ9qWBLsnjIn4P3CKYZ1G8xRpoGrK
         7HwgSTgkCQKfcRyHxdFLgdr/bjlnnpnrGQB6fCqhVboexVz0jAI0W9Nk6DILkrmqk72c
         MOeLm+R59tH5AjFNwhy+JHrirEH9FP/WCogt6wVmzZfDedWe3UtUIYgSEDR8p9yh0BXj
         QwOrrjHN4wa0sQhAX6yL2dARvRZIbLZYyTN2rtzT5kMbUPQX3CKzEbeRcZPhihkWE4SI
         EEr7qPIrjnY0ddMIRgvdS+rHxq8qJs8z3fNqNtesDpAFjDZoiSd9oc2ARFSMIe/F5v0k
         ZPjA==
X-Gm-Message-State: APjAAAXsZEnSfSHp8aROwVbZv2rzCqnWqG/hympr6ZQ5ujYgRaDs4d+/
        gJKouKWnPHTJlYAxbdB0cJWhgiA=
X-Google-Smtp-Source: APXvYqz7Sfl0RT+hHe8aiREQ9UEp6KD6b9m/kyk0SWszMhmI0ugQSxdhY3Z0acm4F/J+7CvRWhcMM5I=
X-Received: by 2002:ac8:277d:: with SMTP id h58mr5011892qth.31.1554830866241;
 Tue, 09 Apr 2019 10:27:46 -0700 (PDT)
Date:   Tue,  9 Apr 2019 10:27:39 -0700
In-Reply-To: <20190409172739.242389-1-sdf@google.com>
Message-Id: <20190409172739.242389-3-sdf@google.com>
Mime-Version: 1.0
References: <20190409172739.242389-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next v3 3/3] selftests: bpf: add selftest for __sk_buff
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

