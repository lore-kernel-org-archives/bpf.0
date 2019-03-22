Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BC0C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35EC218A5
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 19:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7DOFwpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfCVT7c (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:59:32 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35575 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfCVT73 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 15:59:29 -0400
Received: by mail-pf1-f201.google.com with SMTP id g1so2502488pfo.2
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2019 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9QvjqYwTqMejp3FCqs/sgeSpn7O3jg1GGMZcxNeaUYA=;
        b=r7DOFwpncgtRdmdWjnjKoQTHLSJ4yqOg3ghbDntfxgq5ebXDPtOKb63HGL2SkrgfiP
         eY5Tv/Q01ZV5aHccYqGeQolM7E/5MkSTMOYNchy2UOPAUz2bRSVZe+L0EST89vECgawL
         0R8AzQ9L0vdHB+IhhyqZvGLsu6HAB+06lXKzj7VSkllsHWZDv05/H/2i46PZWPwdM4nc
         VfDMpCP/sYOJP69+1MS/OkOHPxVz9OOBVcQp4bUaJ5f2eomWzwFhhPoeZ4XbkA1tKDUj
         nvq/LIfpS3aK80f0tEfoGgSTgc0pbNmauD2T09I8XxEsD46bNVWUl5ezoT5QgiZ5hu8P
         MYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9QvjqYwTqMejp3FCqs/sgeSpn7O3jg1GGMZcxNeaUYA=;
        b=krTp2k5FYp91Lr9w+nEsIdsuFTv9CkEaeSUBgMJ3KiqTrJ8TdYbajioG8ZkrI9xw0O
         Q6jVFcVKUglHKxgOW8EZcb5Qnpj3pY6zI+zo2azDrC3aKdMsdCrnzXyTvgcS5KPGxJAF
         2+OS9WBwReKCRhuT3kGzd2LfKNBaW3HTLKJkVmMNiZ70WfN09w6+Tw6hAMMgPd6P9kWh
         DPPk5eiNheJZDpHSUrkfmVarPjLoRB1PDixUWAnOA7DRb31jMukTaGq+OjAvnqpFW+UI
         ndF8ErSpaZDL9Bqat59sDQbycB3kxMLY/WzusZnmunJpfHhy+V2QSH3jHU3aW22pzG8X
         gW+A==
X-Gm-Message-State: APjAAAV24HT+H/rxqfBtFz+vwOtXXPm5mfrAqlwVaCmKaFrY8YWB46ra
        XgMUaPftiU2i+Jqm7eQQnYSPhBo=
X-Google-Smtp-Source: APXvYqwFlcqkeEGJ7TIofo1gZCBuWLD+ABHCwGOSIzsEpjouqjuSBuk4/konLeUs8lLgbLJQje9aRXI=
X-Received: by 2002:a65:4608:: with SMTP id v8mr10879167pgq.9.1553284767765;
 Fri, 22 Mar 2019 12:59:27 -0700 (PDT)
Date:   Fri, 22 Mar 2019 12:59:03 -0700
In-Reply-To: <20190322195903.162516-1-sdf@google.com>
Message-Id: <20190322195903.162516-9-sdf@google.com>
Mime-Version: 1.0
References: <20190322195903.162516-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [RFC bpf-next v3 8/8] selftests/bpf: add flow dissector
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
index 000000000000..a73065bcf9e9
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

