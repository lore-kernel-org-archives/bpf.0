Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A133F8AD
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214421; cv=none; b=kXcqnJb1dUTQq4SZIp9Sq9ENTJliWqgi2AQkZZ0LEes766nTSKRq8Ibt0vctT15xMMIE0IMc4bYqcVhIcLlQewlZ9kVQqaY1HCLgEDpMywTPLlH/FYw9SeaTxgG65FqGm1qZp5WeHAURdLeTCYBSLzQW3cQVRNicOMIfDhmiOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214421; c=relaxed/simple;
	bh=NWJpeI/1k/9vPVgb++J1pU3sBb/BTOHNNpFqGvhmQHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZjHsD1uhNe1vgjocCk53JtPhNbMCjU5QQkYLWK2nV26Xp1TcagU6FjHMMCZ/YceYSBDyan4nTVTS0Ytk/oUH2+orzUM0wL+FlPUux+EAIWS2vOiL0D3CuUmM7/9x0/F65tv8x/rNuBCOtNBUn7sN2LVAUAjCipu6v6oGORI1kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rRcqCFCq; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRcqCFCq"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7c2fa14795aso28344417b3.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214414; x=1779819214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGJ9ymGUEKtLNacSkRlXr90Y+PFppYrhxlfdv5A8Yz4=;
        b=rRcqCFCq1twmEaPL7jMqPGNQj9e1ABbK9igCytUARvL4M0wAKEPuH9It4k9JlfVUqE
         2BT5Ezo8n7nfuXXfRrN5jaBVckrSNzP1RFiaxXXM7UTAPdy/kJzw/XMUHzCWYr3zkR/v
         Sie3YXoDxaCs5yxHFwN4qid8oKXgdMPS5c1vbqfZWcKY3pYUhJ+A9+4gnA07riQWIvf6
         ItYoLKRkiJgbilnZd640tRWDtbHnTSYY7t5RLJS0EqDMkFqTbQPvn00oDE+Pwfsn5iED
         km9mWjDuBtswTPA/tgsVp/wKi/lHkBDnGb0WA6n/kDi6JvVB6vr1qASVju0YMbtgcdA7
         UmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214414; x=1779819214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CGJ9ymGUEKtLNacSkRlXr90Y+PFppYrhxlfdv5A8Yz4=;
        b=SmvpYNc9lnw1AO2IrBZ7PI1XrNdxrnVng1UAher+Tg3NF8ac1Q+hfVyAt/F29wFnnS
         D2E1IeieSEx1s49C6RJiDuj9tSKPX7HScQKymbXmocFCD4mReV6nd/Ye7f1Z+FmAAiue
         dfCHyCwziddGOXWhUtecpMT2afxvW7jf+GU/BQmHeSx9a55l6vbvqH9rUcFKuck/y7UP
         1PmzQ9E5Hbua265TMTlJpA1i6Dxz7nUlxy2K1gyBNyKkBx8BZ6/eE1UX+9+tZxFhN2Ga
         VqYr992ffDiNFt1ugC6bXjK08C5stR9ViRW60mZkL2xYdAKGOPnDGG/5d3l2OP+bzxFi
         OCKA==
X-Gm-Message-State: AOJu0Yz+CLhBhZd4VyPcRRv3nIz1JXPxiKOb/Fy4TOwHNRQ+2puUgvV9
	V0GZgtbk0NUwl5hClEdaN8BC5kV77UzNahYZ0/f1AmsW7PjIH0rZIg+405VqpPKn
X-Gm-Gg: Acq92OGm7Fe1huaWyI/8uFoKlr9J1/6sMZBXH+x2z7f2GA77AHnTA7Ud/0RV3AuRYFx
	b1RMFjtX7gE4FY9yfq4hqBU0fwSlkFXR7Nb7Ff45rj+qx4yJ3JECSXC9grVK+Dvf0spJf+Yz501
	frDLtZkRT0BMmAxNderdNG8KZPOY4V51yQRpOLLU4xtbh9Oosw0MoI2FwlX6E333K/EfF24pT7Y
	GSPj96yolk9YsLk47TH12dAV5os5nrt7R7dvijxZ0fxXXjv85SihnSJAWT/L0UrOQffASYdNNve
	U2/mZ0P8X/BrGQvSd9Ve1LL9f9FzcAV0TffE1fmOpY9vGwaQvI5VanpmYw5WvLBRrXQpI6Wnsp3
	RlrWKHBVTZhIBj6l7d58FsAf5VtIdhXJnL+BvjWQQQr7QKGnc6QwIptZsxvRPFpY70FNro0Rg93
	wlBJ5ceDRr2avlcP0u
X-Received: by 2002:a05:690c:39b:b0:7c0:4f0:7bc1 with SMTP id 00721157ae682-7c95b8296bamr220148647b3.31.1779214414489;
        Tue, 19 May 2026 11:13:34 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:12::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc997b26a8sm40485957b3.15.2026.05.19.11.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:34 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 12/14] selftests/bpf: Test using dynptr after freeing the underlying object
Date: Tue, 19 May 2026 11:13:10 -0700
Message-ID: <20260519181314.2731658-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519181314.2731658-1-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure the verifier invalidates the dynptr and dynptr slice derived
from an skb after the skb is freed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  6 ++
 .../progs/bpf_qdisc_fail__invalid_dynptr.c    | 68 +++++++++++++++++
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c | 74 +++++++++++++++++++
 .../bpf_qdisc_fail__invalid_dynptr_slice.c    | 70 ++++++++++++++++++
 4 files changed, 218 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 730357cd0c9a..65277c8fc887 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -8,6 +8,9 @@
 #include "bpf_qdisc_fifo.skel.h"
 #include "bpf_qdisc_fq.skel.h"
 #include "bpf_qdisc_fail__incompl_ops.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
 
 #define LO_IFINDEX 1
 
@@ -223,6 +226,9 @@ void test_ns_bpf_qdisc(void)
 		test_qdisc_attach_to_non_root();
 	if (test__start_subtest("incompl_ops"))
 		test_incompl_ops();
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr);
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_cross_frame);
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_slice);
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
new file mode 100644
index 000000000000..1d96f7987a3f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
@@ -0,0 +1,68 @@
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
+__failure __msg("Expected an initialized dynptr as R1")
+int BPF_PROG(invalid_dynptr, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	bpf_qdisc_skb_drop(skb, to_free);
+
+	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
+	if (!hdr)
+		return NET_XMIT_DROP;
+
+	proto = hdr->h_proto;
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
+	.enqueue   = (void *)invalid_dynptr,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
new file mode 100644
index 000000000000..2e23b8593af9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
@@ -0,0 +1,74 @@
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
+static __noinline int free_skb(struct sk_buff *skb)
+{
+	bpf_kfree_skb(skb);
+	return 0;
+}
+
+SEC("struct_ops")
+__failure __msg("invalid mem access 'scalar'")
+int BPF_PROG(invalid_dynptr_cross_frame, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
+	if (!hdr)
+		return NET_XMIT_DROP;
+
+	free_skb(skb);
+
+	proto = hdr->h_proto;
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
+	.enqueue   = (void *)invalid_dynptr_cross_frame,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c
new file mode 100644
index 000000000000..731216c4e45a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c
@@ -0,0 +1,70 @@
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
+__failure __msg("invalid mem access 'scalar'")
+int BPF_PROG(invalid_dynptr_slice, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
+	if (!hdr) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	bpf_qdisc_skb_drop(skb, to_free);
+
+	proto = hdr->h_proto;
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
+	.enqueue   = (void *)invalid_dynptr_slice,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
-- 
2.53.0-Meta

