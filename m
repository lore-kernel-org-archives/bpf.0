Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82A1C10F03
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A5A2183E
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2Brv/hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfCSWUP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:20:15 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:51443 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfCSWUP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 18:20:15 -0400
Received: by mail-it1-f201.google.com with SMTP id e63so433252ita.1
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZgxmUh6O3jlArRZafvyJugfH/u2Yb0sWHdTxAViVUGU=;
        b=u2Brv/hd0MSAJK6kmTdG5AJ+0DeVrTxTiU65cwR24CQYxXL0OxvrkUMIufSBMODtru
         4ja7OhoAh9jpG3UyhfiLUfQyOcDTb9QDoJGZN61AQ+lFB5vmU/qMF3QgYi7BonpTmqz7
         bc9J0sJblQzxwIX2ngHz9QX0uCgLZ0JOw1bWKyDRzTvQa0Pvpy80H3o4OUAJCqygmm95
         8LOmY9pM8p8/OVsdoEDufXoMCh7xijH9+QqdpYyREqRw5ZyiZISHxB7IjOINNUVugi34
         CKbL6gWHvcZrntR4uOau91CFTF452NnrRmE8mmUmybSoqcFZX/P0vQp/2z0ONqLIviK9
         8BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZgxmUh6O3jlArRZafvyJugfH/u2Yb0sWHdTxAViVUGU=;
        b=YeuhadM+7idEei+UsAlKqWkqt1LvuP6ZHZpQXTNeGoOltNH5sde4RjK/qXuWXMfuza
         g8Th8iT6X0H5Buy3avFmprWhT97UTEefJxTU550Ja+mtOzL5TE8KSsX/3pgruAk6yhJb
         mBEzWU92f6rVaXNR1NHqt9t1lLNBuLPsT4urOTJbFqoX1I+JobORAtWmUBCqp/0/hzQ+
         VSKwvTMwVkO7xQaP1hvHdRoVuCTaz7UnjuzpfmdCLoX2BzJcB1dnmYqyfnr8Oox31JNm
         18F8tdspkLZWaAZnorwNcvxHJtiApBhTIeRSAbu2mO2j4Dzyn3lDO3WhbcCRAv4JONEM
         Fs2g==
X-Gm-Message-State: APjAAAVK4OjtNZPvL4S7ZBhFxcwVXCRMLoHI1fjChVw0QFv8CQcGzI/M
        E6PR9QONsEtfSvpBetmaprXd4q4=
X-Google-Smtp-Source: APXvYqyhtvxHjo2wTlZCy4mmtWrql2ONB9uJQ7970N/qlHB8mpCP6V2zeprX4A7qoqp6bD0JuPqNvck=
X-Received: by 2002:a24:3608:: with SMTP id l8mr2683213itl.35.1553034014159;
 Tue, 19 Mar 2019 15:20:14 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:19:47 -0700
In-Reply-To: <20190319221948.170441-1-sdf@google.com>
Message-Id: <20190319221948.170441-9-sdf@google.com>
Mime-Version: 1.0
References: <20190319221948.170441-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [RFC bpf-next v2 8/9] selftests/bpf: add flow dissector
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

With the per-cpu skb, we want to make sure we don't trigger any
shinfo access. Add small test which tries to read the data past
the packet boundary.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../prog_tests/flow_dissector_load_bytes.c    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c

diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
new file mode 100644
index 000000000000..facf5734c915
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_load_bytes.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_flow_dissector_load_bytes(void)
+{
+	struct bpf_flow_keys flow_keys;
+	__u32 duration = 0, retval, size;
+	struct bpf_insn prog[] = {
+		// BPF_REG_1 - 1st argument: context
+		// BPF_REG_2 - 2nd argument: offset, start at last byte + 1
+		BPF_MOV64_IMM(BPF_REG_2, sizeof(pkt_v4)),
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
+	/* make sure bpf_skb_load_bytes helper doesn't cause any
+	 * problems when used with the fake skb in the flow
+	 * dissector (try to read past the last byte)
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
+	      "err %d errno %d retval %d duration %d size %u/%lu\n",
+	      err, errno, retval, duration, size, sizeof(flow_keys));
+
+	if (fd >= -1)
+		close(fd);
+}
-- 
2.21.0.225.g810b269d1ac-goog

