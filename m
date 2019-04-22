Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08DFC282CE
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2622077C
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 15:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bo4rkvnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfDVP4M (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 11:56:12 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:35438 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbfDVP4L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 11:56:11 -0400
Received: by mail-pg1-f201.google.com with SMTP id e12so8235885pgh.2
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2019 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y4TmOKDtsK+fh/31X/badyrer/jMZamM7Pc3AhY/t4A=;
        b=bo4rkvnKRt9b5Ykf1r3ZSAqXqYzm4BNI6IRtoXUEbzl5+VmJkdbrp3SglSiLvYoE2C
         YvolDku+XzmTm+R0Nmpn+naHcMxRPjW+ivRUzXv8E7SVCgs6afZB/Jj4eaUObdLSSmlz
         PoGdClYGU9gGAVv5ppdOyLvDUFWG5HgeP76EkXuvsqIP4XNU13tlUwq7LTjc2N1h6FFE
         BW4nFUxJ1UafjkBCcZzZBob/cyhnxycCxWyQZiXyszZfkyhgDQsHblV9shT2b3HEW+++
         DG35vASLtyd/Ns6zwsRCKeN21U7iPAfNuDp3MdQzNQZlr74LGGoQD8c88Ui5RHbcAP/J
         vlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y4TmOKDtsK+fh/31X/badyrer/jMZamM7Pc3AhY/t4A=;
        b=nRh+Bl0bwbtay0mqaXEcnZwPzDSb0nnnWFq3ByfBVHqVZypTEQ1B3l1RjCR2658aUr
         0eNy9oW2qdXZi6O5Ba8ozqxcFde1SJcc6CSsHNjD/2uV/dro3dFVC8eDQqgX7FrP8kjm
         pnxEaTzzWcN/iXsfDc3vI4iWwSKgg36cwkTAzCSChT2SRhShYNvouHLhhHz2TW+GpRaL
         KOXwwDUrYui4XFjRU6D3Mqa3EON6ypUxxtQje0nnqcGRcJfM7ShQeO21tOGwywE6OW4k
         xhqlnpNFSKh7QTYZG93jTd/T7Q5DRDqOHiZq/nBr6PKS1OG67tJLRl8B0xo1keCwoSUo
         j0YA==
X-Gm-Message-State: APjAAAV0yX0OPEnxbuoUFFJcz/NOo7oW+a5bhPrvycfUmaFj0sz5No7M
        JAi8nQx3c4WaTmKbT12MTV5HVBE=
X-Google-Smtp-Source: APXvYqx5+tS2X1nddSfZ4p6uincJMK1/5hrUSF0/J+zRwgMN4lYGUeN7dJpclFFIKtZyagCSEh4/8c8=
X-Received: by 2002:a63:7f0b:: with SMTP id a11mr18359559pgd.234.1555948570530;
 Mon, 22 Apr 2019 08:56:10 -0700 (PDT)
Date:   Mon, 22 Apr 2019 08:55:49 -0700
In-Reply-To: <20190422155552.222910-1-sdf@google.com>
Message-Id: <20190422155552.222910-7-sdf@google.com>
Mime-Version: 1.0
References: <20190422155552.222910-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH bpf-next v6 6/9] selftests/bpf: add flow dissector
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
2.21.0.593.g511ec345e18-goog

