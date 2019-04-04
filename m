Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FDCC10F0C
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 18:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AF620657
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 18:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sY+vf9sR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfDDSvk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:51:40 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:39942 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729864AbfDDSvk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Apr 2019 14:51:40 -0400
Received: by mail-pl1-f201.google.com with SMTP id q7so2321008plr.7
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2019 11:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eXwH0rL3JrhFX4XKOfUZYm2rVlEnxPjeCU+4Qtw5W5A=;
        b=sY+vf9sRnc5M24r3H2nHZDWg4QqSI2qhdmz/v4V6W9lHCiC/gB+VSjUpwuRPa3Rjs1
         LUgNxbsUabVV5Y96avK1EbnwCOtWLqnlXMruNzjAit4ecSwL/bReUeXGnmtQ8n0NdYju
         oxirVUD5LNlA2/bqljZTMMp9ObTsRDbq22y6WwRQMbPAOnKTfCmLRhhNZ/iug0ufAXjd
         KMjt+H2Fo5nP7gKYOF/d+jQAGd2Ry8RNbpTdropv7/9LfEb7QPqBVC/FMc+vrKvhH3dN
         6u+ocwKB0xSiGxMd+RiCpKk4iEHOLy+Rp2tbKHy6GdY10IR51wyhS2tb4sYLePz928Cz
         /dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eXwH0rL3JrhFX4XKOfUZYm2rVlEnxPjeCU+4Qtw5W5A=;
        b=msaHeXQUDvn4AEsDIlXvau5Q1aRi9GqtxaSCkESbH2F2usRKP4bzSmnmVvvuM5bVZ0
         v1LzwPEu4ZoCLoq7tIHTAx8hhqPynAPuiwHj/t7UUSlKgbPRjFIwXGZvfpSt2TX5adBp
         9eyxxZi3k1QcREEdAm86ZBxs7vs6kLXOCsmYw+751Kt3kTw6981JlSsMQlmdCiLATI/m
         sFiFmy2lmeGgmymWvBG0kS/BabIjq2ExXc6OdntMkiu3i1epMfo3I4QDlzfKD1liOyfU
         pTr/prxPZOzxfkyZODCCjv5509HElZW9bYsnK0eQ2nuPseMNgGCfYR3TW59BD5grXKSj
         i8eQ==
X-Gm-Message-State: APjAAAXCqjh1ID+v4VMKp74T78jfh6EupKsFV95A/Vfhmi6iPke0j4Un
        0vnHy4YDo6eaorOlqTNMVZvbT2o=
X-Google-Smtp-Source: APXvYqybBghgb6fyz1yZ+WSAgp7Kq2zmyy8SbNID2dvCqJJeHFoQxaCK0WwIa21McPzZKfMlnalPuUc=
X-Received: by 2002:a63:7117:: with SMTP id m23mr162904pgc.123.1554403899543;
 Thu, 04 Apr 2019 11:51:39 -0700 (PDT)
Date:   Thu,  4 Apr 2019 11:51:33 -0700
In-Reply-To: <20190404185133.95071-1-sdf@google.com>
Message-Id: <20190404185133.95071-3-sdf@google.com>
Mime-Version: 1.0
References: <20190404185133.95071-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next 3/3] selftests: bpf: add selftest for __sk_buff
 context in BPF_PROG_TEST_RUN
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
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

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../testing/selftests/bpf/prog_tests/skb_cb.c | 89 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_skb_cb.c | 21 +++++
 2 files changed, 110 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skb_cb.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_skb_cb.c

diff --git a/tools/testing/selftests/bpf/prog_tests/skb_cb.c b/tools/testing/selftests/bpf/prog_tests/skb_cb.c
new file mode 100644
index 000000000000..83f0b95ae0e9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/skb_cb.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_skb_cb(void)
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
+	err = bpf_prog_load("./test_skb_cb.o", BPF_PROG_TYPE_SCHED_CLS, &obj,
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
diff --git a/tools/testing/selftests/bpf/progs/test_skb_cb.c b/tools/testing/selftests/bpf/progs/test_skb_cb.c
new file mode 100644
index 000000000000..50c9df29668f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_skb_cb.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include "bpf_helpers.h"
+
+int _version SEC("version") = 1;
+char _license[] SEC("license") = "GPL";
+
+SEC("skb_cb")
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

