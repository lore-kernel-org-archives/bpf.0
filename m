Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512D2C282DA
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA0220848
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Blzr7hld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfDORiU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:38:20 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:42164 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfDORiT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:38:19 -0400
Received: by mail-vs1-f74.google.com with SMTP id w69so3484783vsc.9
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=skkanlZEBmRM/3Jwze42ywa2CAtMNsYRV5aNsz49UBM=;
        b=Blzr7hldcakYNNDgDodwhnSeyBu2BTKapZQxOgkX2rQ1yewbFZWX1BCrTvFCjG990z
         gkWkkxoy/YQoh51xPOThMrrRTEmrkTI0c9UcqqZlOXWiE9eB/KuzXE4u8qsoUaqJO7+g
         fGV5KLDd2mMIwTPFk/GRB291UZ2ATrg4YskWMsqcORHN661IsWg3cktblJwMTIwk3fKQ
         lidiid8LOKU/npwbIHt+AD5G0aYAHdgaMr6nIGmK+R9PhUx0FPBggs9XVQNDr/kO6fC4
         PCDC//iQLSLOktoaXvbM7s44XgC0pb/dcAfr12s77zYjbjK0raD59c5JNy7ZKYukWk5B
         easQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=skkanlZEBmRM/3Jwze42ywa2CAtMNsYRV5aNsz49UBM=;
        b=sKBM9FcKoH2UHyEb59Fx15yW31AwVo3pkKpwH2SnATtWaJVagXfw6P676RHvYkpV8p
         DBhFFYeO0n1nMqA/nriIdmYLxhkXsuPHzCZOYBR3lLPvJ+nkhgmFnbEptI2VfNgKEsp8
         BWuTMFuBJav5o8b0v8/b7W82uyIUw36bts3lXuBznwXxHB/taN73tBpiRQSNuUVaVVbS
         8c5+ryrtGvjtLvL1qTqyHBEf65hC9qi3AkohVYtwjEynQDuXTS0YeGimLzxHEPdGBDhb
         tlh9aeyoD+ODN5J6S8sBURvr03m0rBbDaQrRylDGwMBjTRbo7j6PPqf6YwAKs/VAv3v5
         1TKw==
X-Gm-Message-State: APjAAAUFp/VssvQklSJJKdyYR5wuRGIcmIyrnnFKVHvp/uD+RN3B8NOE
        VptwZDH1p3RheexKfatCgVwmNWQ=
X-Google-Smtp-Source: APXvYqy8GFvXYnQ2KDk9JpvltbZpyAdb+XnZ7U8pyh4jZu9wLYxjCfLSWeVX0436OhLFZEGjec9k3y4=
X-Received: by 2002:ab0:2396:: with SMTP id b22mr1509546uan.1.1555349898373;
 Mon, 15 Apr 2019 10:38:18 -0700 (PDT)
Date:   Mon, 15 Apr 2019 10:38:01 -0700
In-Reply-To: <20190415173801.257254-1-sdf@google.com>
Message-Id: <20190415173801.257254-7-sdf@google.com>
Mime-Version: 1.0
References: <20190415173801.257254-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH bpf-next v5 6/6] selftests/bpf: add flow dissector
 bpf_skb_load_bytes helper test
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        simon.horman@netronome.com, willemb@google.com,
        peterpenkov96@gmail.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When flow dissector is called without skb, we want to make sure
bpf_skb_load_bytes invocations return error. Add small test which tries
to read single byte from a packet.

bpf_skb_load_bytes should always fail under BPF_PROG_TEST_RUN because
it was converted to the skb-less mode.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../prog_tests/flow_dissector_load_bytes.c    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
new file mode 100644
index 000000000000..dc5ef155ec28
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_flow_dissector_load_bytes(void)
+{
+	struct bpf_flow_keys flow_keys;
+	__u32 duration = 0, retval, size;
+	struct bpf_insn prog[] = {
+		// BPF_REG_1 - 1st argument: context
+		// BPF_REG_2 - 2nd argument: offset, start at first byte
+		BPF_MOV64_IMM(BPF_REG_2, 0),
+		// BPF_REG_3 - 3rd argument: destination, reserve byte on stack
+		BPF_ALU64_REG(BPF_MOV, BPF_REG_3, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -1),
+		// BPF_REG_4 - 4th argument: copy one byte
+		BPF_MOV64_IMM(BPF_REG_4, 1),
+		// bpf_skb_load_bytes(ctx, sizeof(pkt_v4), ptr, 1)
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
+			     BPF_FUNC_skb_load_bytes),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
+		// if (ret == 0) return BPF_DROP (2)
+		BPF_MOV64_IMM(BPF_REG_0, BPF_DROP),
+		BPF_EXIT_INSN(),
+		// if (ret != 0) return BPF_OK (0)
+		BPF_MOV64_IMM(BPF_REG_0, BPF_OK),
+		BPF_EXIT_INSN(),
+	};
+	int fd, err;
+
+	/* make sure bpf_skb_load_bytes is not allowed from skb-less context
+	 */
+	fd = bpf_load_program(BPF_PROG_TYPE_FLOW_DISSECTOR, prog,
+			      ARRAY_SIZE(prog), "GPL", 0, NULL, 0);
+	CHECK(fd < 0,
+	      "flow_dissector-bpf_skb_load_bytes-load",
+	      "fd %d errno %d\n",
+	      fd, errno);
+
+	err = bpf_prog_test_run(fd, 1, &pkt_v4, sizeof(pkt_v4),
+				&flow_keys, &size, &retval, &duration);
+	CHECK(size != sizeof(flow_keys) || err || retval != 1,
+	      "flow_dissector-bpf_skb_load_bytes",
+	      "err %d errno %d retval %d duration %d size %u/%zu\n",
+	      err, errno, retval, duration, size, sizeof(flow_keys));
+
+	if (fd >= -1)
+		close(fd);
+}
-- 
2.21.0.392.gf8f6787159e-goog

