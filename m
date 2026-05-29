Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC923603E9
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019395; cv=none; b=YDsi6J4DpL/dWIxn4PhyAzmJkGXOBIetvcdrvMVlViJ9Vk4cAlwGt9OGeoVf8FMvk5wSdCba0Qvn7KX8nc3VeNjKeyj4XKNYJjOw18rhL+P1ckmAxPvdxi1yASU1P9C94byXbBwCGR5tdTQcPhrWlzpAHPV1bCgQdUV99wvH7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019395; c=relaxed/simple;
	bh=KTt0aucQRwSSY1v/g2cx63/4D7+yZyyp6PlNYp3orEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WC07J1I2BKGXZDFDwUxGr4g4OHHXiWKdNRoBENf4DpBte3aCNuFyovSczSfzcObs5ONeDBqkbP2jCvrMir1TVETw3h2bMCTuM0IGbKSr7ECLBFDxWWJb0r0iztZegX2rl2UnfF1aO5ggirwtfPPuA4UnRJlB6LN+xO5TZO2ji6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWzxkcxx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWzxkcxx"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3697f25d26eso7201836a91.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019393; x=1780624193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uif7b+czjKlcBWebCKP3CIhJtu2V0IJ9fXlMskACjYs=;
        b=cWzxkcxxMWPBvruPrCXa3hGMVAdfTgssTk20YqNfI5mLu34uqRBE+UHl3ZTl/h3+lB
         Ez4CmbmiQTwGzmHE4IfNyslg7VuTe+55yCAaxHhgs3zzZKRscTRlZr3n5/DEiDEEmo69
         TWDy9q+U0/p8JMo6i/zKQC4V2e2o64/j1YBwKK1Y1w0qav5ilckZEYgeF7hwx8CloirX
         pD2Ox2hg8dW03Uwpt6Gt2Gfb6oILA2MRSAv8+satNtUQ/yWp1sHsuSQMSdpfrM7h755E
         fkhOFZC0pkrInS2PmLOrY5Q3fvhyrGZse5gzpc0YnAJwBKj4gCQDtT14BaD3m8JKdPB0
         I7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019393; x=1780624193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uif7b+czjKlcBWebCKP3CIhJtu2V0IJ9fXlMskACjYs=;
        b=LGeGwSHKF7Pxz4De6To5BZkoNYLVcMGWrexM3+ZNomeOm3+zspvuNg34w6/W8nIN+3
         kO+j9e225s9g6iKZb+HBhVhr1XOhv/tiClzu9SENcWChX6GvJ7qpov8zPYoqDyUgiL1L
         bPFhHYXr2wsXxQjVGsRKIpIBnimo6JOQu8SNW1Or+CyuUCylre6yeXLPPSNoqy9lMzip
         ORqRS1FZHMxh6F81btcwjpvNvRR8kg47C4dwlbII0PjOpjJLOvS/3Fn5YxsVlTHAnAW6
         zwf3JZAX2Q6VpbkIGuM3Zb7RoxbjgR0xCcSkB7d4aybgPpxNjoBX9qgWR6ent2p8C/yb
         niNA==
X-Gm-Message-State: AOJu0YxcPh77ooqbEVqjD7JAVHjI1okJugCe9tviKdBbCPtfCg/rC1aN
	35oxdCM0e9uRrcjfLyV+rDPWhnR/w+LCshQIaiSp5hOtuDUwcBIQb6gKmG+yJg==
X-Gm-Gg: Acq92OFSSr3e4U5gSI20SWU6+k5ZyTT5zTtXUnbumj26IR0jw7vbQaE/OK34jMExkL6
	bDCtKDI1+rB2rLo5s6U2vaQFcmO80cgkJL6HudOF+KUTleYpyy2xZezrMMrlDXZXRxcqj1Gy25G
	uYiUjVGlcohB/fN/sAomwzWEUgS/+c0rVXQMoELrgXO61WeP1V/MvVIop4DdUg7FPkCl2HoJVfB
	YdIhJVpT+UpARR/yo86IMi4JmVUB6ZUIV2q7TfrXH8PxHF5oQJk1uWw6Dag6RJ0qzTLXUzW871Y
	icX9Qh5F6rsrFcNin5ZSIVHceYfr4KfGKPhME9GlFo4JOHlrozLmpancGZx/PN6PoqvSCnmyatk
	ea0qAqlLMP6bfQByy/AHTPKuWHTuE+kmeiJ0DlYl0GmIkBAape8KeG4bMJm3gyefZdMcI4Y6fHn
	uq7o6WaD+c2Y/SaP8h6rhge3G3CvvtxJVAY2c=
X-Received: by 2002:a17:90b:5410:b0:368:1064:62f2 with SMTP id 98e67ed59e1d1-36bbcc146femr1080719a91.3.1780019393156;
        Thu, 28 May 2026 18:49:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85771a7af3sm119510a12.5.2026.05.28.18.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 13/13] selftests/bpf: Test using dynptr after freeing the underlying object
Date: Thu, 28 May 2026 18:49:36 -0700
Message-ID: <20260529014936.2811085-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
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
 .../progs/bpf_qdisc_fail__invalid_dynptr.c    | 68 +++++++++++++++++
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c | 74 +++++++++++++++++++
 .../bpf_qdisc_fail__invalid_dynptr_slice.c    | 70 ++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c

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

