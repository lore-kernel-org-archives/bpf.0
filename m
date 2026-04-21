Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F973A1D05
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809429; cv=none; b=PQxMTxtflkhTbyZzPaP3pUFx33ORYOYwRp510JlUyICbAfS0hGIG/w2xj5ViPzofwmJcPQ5m1yX/TMfwNOgDFBXeQuDVERx/A4wKdipGv1SRseR8SBsttNjr2F0ax27UwHd8WcKvYf4ir7kOWRo396Pj1K4EYFVcWUTqS/c1Bhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809429; c=relaxed/simple;
	bh=o72cBAvkomlz02FtjAM/uQMhr3e5Z35AgXo7SBCRXko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I17bHIa/Tu/FH+ZN7Pvj1zgwNRsY0wBpkUAKI0Bj+Sx8FORvyKfiq4cByBt3rprQ/gZ2cesvBSDlQ/6+7ViJwH490Wyuy/rW/+jXcamtwDTBw6FDnn60T1S2JJkpal8sF4yG85Be5bBS/zwSe4+19ETdKUzG4aiebnUPISWr4AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPa0CWDC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPa0CWDC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad9516a653so24618125ad.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809427; x=1777414227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6GR+fTkq3Uedb8lJqPIpFLwpiwmbc1o8ZoLNraEbVw=;
        b=iPa0CWDCsRBUHbQwAsVhCB7ZJVnTKTv/rCciMba3YLCsMg5UGu/HFlAcW/SuwX0FsN
         V0P3uoxg190LY9n6OeyQLbJ/im68kxVyhLxkX5ie3qHeX/gfCVAkIJq/Gd7flLf7FNr+
         Shd8moJJisCt0/YGe5pNnNOSx0OMpvd7WrCDMrSnqHPIMYLLppH2C9/8WvpSRg6CauyY
         zi7YzGsZrkV5I6WZ8mJLY615n8/00gH2zbohW7O83v9WKlR4Q+HyzhB1u8n+iHNBs4pC
         2jWl0Abz3ldNpV1/bh73ZGRH/4IgSQqTyhQ/k/20f7itbeUbH05lHQQQMPlpxF7cbuUi
         7lNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809427; x=1777414227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6GR+fTkq3Uedb8lJqPIpFLwpiwmbc1o8ZoLNraEbVw=;
        b=gaVIlve69NNNjNvl1CijfMdbnL0yZoUB/RkQSsHE/LmDulbD5LHNTJQhMpjSeF7O58
         VkTafpqyDGSfJpJOG6PcuFQCQLLgojcTAmU9J0MaHXHfGWDnKnd/V5nLWny843UCBEyz
         kZPZVr3TcQkccUYSsvWEev4gn6YgcCI0Fw2vHISaHvGM4aiY+LsdI8yEMOSVPIS8CZrR
         l9mbRAlmVRNfgv25FEwDeNGpE9f5EqTdegx1C8r69cRx2k/hJRGZNcuRqFCIffYUIs03
         8P5lE852ziVc4C5J9F2zY1GN0O4mjAXZdrkTz0IGsxo4F7BSwVlOL13cblqVtmV8w2ad
         Tffg==
X-Gm-Message-State: AOJu0YyR/RyhgnyVDj+kvpzMg1s24Dq5QeDSZ4Rql+53djALJopgiAuY
	2jqeaIRF6wARUpJzJA4tdg9aoiNiCtVgv852P68PpxD2cthjUIZ2CDLhc1dKHA==
X-Gm-Gg: AeBDietIqlyzQ17qTzGckyM5nqBBrAU+la9x1gpdjDBBWXJcL3jxKlnfEMuppFsC7Aq
	yIbOoQhP7/95ArEI68FBXgPcxwRtZBdHl1DEn4rj1dRvrWUSCr9crIuEwQi1Y6blV2+oyQRKXmH
	h0SCYJoPw3XkPowUecbCPqcZFIvpjD1mjeZipJxNObEFfkdEuD/H5aaPfQpuPkqTe4/iUCwnhEw
	f960bZWPoXh/GYVZVTCK0g0i39957aloniy7np9ixEUZ7f9Z9/h4pmp1C0mxWU78m4LwCpbeXP3
	OANzmF5F4HT4os9kq6TlgQI38oIN4rabyJnpIZy2yYNP9cIVTw6R1Ur0gzG3GcLMer6wDtQzSCI
	ZKsCFrwc8HpiZDgOpDLDGVuLWAZMathFZ1RL8Gis64hkO2dq4YJOorEhRUVWI/x00PJLCoePu79
	Zj68TlykGPKQCFgIYqzwz/wmvP
X-Received: by 2002:a17:903:fa3:b0:2b2:ebed:7af8 with SMTP id d9443c01a7336-2b5f9e5df98mr204879535ad.1.1776809426891;
        Tue, 21 Apr 2026 15:10:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab30f29sm142158255ad.68.2026.04.21.15.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:26 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 8/9] selftests/bpf: Test using slice after invalidating dynptr clone
Date: Tue, 21 Apr 2026 15:10:15 -0700
Message-ID: <20260421221016.2967924-9-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parent object of a cloned dynptr is skb not the original dynptr.
Invalidate the original dynptr should not prevent the program from
using the slice derived from the cloned dynptr.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +
 ..._qdisc_dynptr_use_after_invalidate_clone.c | 75 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 65277c8fc887..77f1c0550c9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -11,6 +11,7 @@
 #include "bpf_qdisc_fail__invalid_dynptr.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
+#include "bpf_qdisc_dynptr_use_after_invalidate_clone.skel.h"
 
 #define LO_IFINDEX 1
 
@@ -229,6 +230,7 @@ void test_ns_bpf_qdisc(void)
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr);
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_cross_frame);
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_slice);
+	RUN_TESTS(bpf_qdisc_dynptr_use_after_invalidate_clone);
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
new file mode 100644
index 000000000000..cca2accf081d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int proto;
+
+SEC("struct_ops")
+__success
+int BPF_PROG(dynptr_use_after_invalidate_clone, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr, ptr_clone;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &ptr_clone);
+
+	hdr = bpf_dynptr_slice(&ptr_clone, 0, NULL, sizeof(*hdr));
+	if (!hdr) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	*(int *)&ptr = 0;
+
+	proto = hdr->h_proto;
+
+	bpf_qdisc_skb_drop(skb, to_free);
+
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops")
+__auxiliary
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+__auxiliary
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)dynptr_use_after_invalidate_clone,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
+
-- 
2.52.0

