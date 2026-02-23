Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE63F283FCF
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855856; cv=none; b=Al9i3pJv2JLww6a5uxdMj2AJXMkL5Er078p5B7LCrhRpn3BQAJ8xjdB7hlUU6a9ZCIA7O9MGEatg8VNu5mmKa7wx8KbH1YtTVz827P1yW+1xF/JMxWzpqYaWP2InUkwpDkdb1NbMDyqHSRZ9jzudrh2j8BYnVl3JaiSDD0L+gf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855856; c=relaxed/simple;
	bh=HG9gCfdxZ8NXc/JuUjKIrbu2UOcdgsOtx3fDYYJYGz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeMCMQU91wgNEGAaO7OP4SFfUjwbgY/nAC8bU0eEPusdfOrkzYRhNbpv1pj/KhpLd+7xVPCKw07swEGT5g/DVoE9cNeBq/O6VtnbpLNwws5GzYFvpPwtZiTjcb7a/+xblIlTHLUYN1KtT/aBiBtTJoq6KI4eryJUUGpeI9lk948=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYQz9gcm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYQz9gcm"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43590777e22so2658861f8f.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771855853; x=1772460653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuFvPPRb+x3GrCe+6epvyuao5Sr+A8ljbiWuuaOo9/s=;
        b=QYQz9gcmqEjEpCDXZU7jYpE1JrlY8kLkRVAltlIXi1X2uz8o73PrRSwAY/cjjOO7TQ
         pLbKAuWgzxISV9rK1D4EhW+QbdqIOAnR8PdfAmOKY4U5uMtPIBs6e6y5zt2v/ZTqOzXQ
         X5+MhOywxOWAOxoxXPdaekGpiOtPDXLzOPCRdZuRwAvuqRt8NxytuuNNm6zhlOKY5hvL
         m3vEH4x0f778Xg5GJTNF1cl+fk2nCSEsuzM2gbdkjyPOyBZ9Guel8c3D6XtFvHS+KTcR
         V9a7SXTyHKYTA8q2ItZzIiCD9+y4IzFQYwcbqwZfYH9aJJEAehmdHWpukr7DxIuQi0Jt
         He9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855853; x=1772460653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WuFvPPRb+x3GrCe+6epvyuao5Sr+A8ljbiWuuaOo9/s=;
        b=vBXpNYkm4LUc3P/4mJ57BAHhPm1pLFmL/YkHBDv80/g8XYnycWTL6jPaDYR6hxUhJD
         AWw0RoHEvFnTZNx6GEGDvwwhPgLhnGWtBUUifHntgimPpmgLjqakRmKDM8HloU9Tjshh
         bonrJRL228DvZScKfSo1pWoGxLaDsYo6eJBLFwOYMpXga5rp7ukWD3nBfgaVvJgNkbkw
         QXbeFJvQtwA1VUfyJmDwMMtK3fJaG1T0Ge+/gwfgNun/mVSdIVQS1SHloRawBIYWAynN
         6vLvlD0+9eF4mwDAVBgdfwd2OIEEOThDKvYAt3iF29ITgbzgptWJsyHAyJnXbfsB9Sur
         M0rg==
X-Forwarded-Encrypted: i=1; AJvYcCWb0GB0eedQ2yp1oD521y9Tmv7tnY2zbe94SdmGzeoY/YgjshVhdOzXVAMMjSrpMTjETCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVPuIz73qFcTCR8JnPXw7ImSLbNBpddwvXscHDxtEQi96PfxC
	gLvFQn7QhmvIbnfRXca2v94niiwDGQ8eC1wli2HV1LF34+jUWQUmaNhz
X-Gm-Gg: ATEYQzxuLj4L2GmoWA+eJ5HJRJOa1C+xfiu2ZXCy2HT8QCCsq2cUFbVR7K/NZmiClfh
	hCPyUxp9GAPVixsa2/fVgfeq17+ixStveFJeCocqSnTu/XiWdqBrbTSNhTc5SMXZZ8QSVQQmdvf
	o1EJyGN64pYOrk60pvXdo+uzEu5THRsPqoQMoy3JgRk4TIilpbIlRwuN/rmbE4mEJFbXJ5ViTSA
	RJQujgby2RAjZuqr3famqRcSndlrSyRs2nI8QjzOgQ9FuBgJGu4qc0Tn+DsMrocNHo+8xw/SI2e
	F0DfvjiAugUIbb5OWhMuYQntfcTyewCZIQZrYHl9QcpAlZBLVh6x5w2DNWw+BVLQbL7V+TqPVn2
	Sughj54aPW9oIe+yJ6P9AyoowKtgY30RqqC8eUa0/hQCT1IkVXcalX2aimBfF/g1XaZijdxsKvP
	HyGjWHrO3GzrBNNRbWt1QnhQPOEMpuQOdz+QEIF0dtMKrsxHOLlV+VS5huicoajCXoqstFtId6S
	i0PpU2Ifw==
X-Received: by 2002:a05:6000:40ca:b0:435:9e81:105a with SMTP id ffacd0b85a97d-4396f15b31cmr17556877f8f.20.1771855852937;
        Mon, 23 Feb 2026 06:10:52 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm19464640f8f.6.2026.02.23.06.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:10:52 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v9 09/10] io_uring/selftests: check loop CQ overflow handling
Date: Mon, 23 Feb 2026 14:10:20 +0000
Message-ID: <1538be8a738055bdb7a1a6493d8e4eca40c58a18.1771855761.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771855760.git.asml.silence@gmail.com>
References: <cover.1771855760.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that CQ overflowing works well with loop execution. It adds a
BPF program that first submits enough requests to trigger overflows and
then empties the CQ.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 tools/testing/selftests/io_uring/Makefile     |  2 +-
 .../testing/selftests/io_uring/overflow.bpf.c | 51 +++++++++++++++++++
 tools/testing/selftests/io_uring/overflow.c   | 50 ++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/io_uring/overflow.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/overflow.c

diff --git a/tools/testing/selftests/io_uring/Makefile b/tools/testing/selftests/io_uring/Makefile
index 5b9518140f4c..77df197449ef 100644
--- a/tools/testing/selftests/io_uring/Makefile
+++ b/tools/testing/selftests/io_uring/Makefile
@@ -3,7 +3,7 @@ include ../../../build/Build.include
 include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
-TEST_GEN_PROGS := nops_loop
+TEST_GEN_PROGS := nops_loop overflow
 
 # override lib.mk's default rules
 OVERRIDE_TARGETS := 1
diff --git a/tools/testing/selftests/io_uring/overflow.bpf.c b/tools/testing/selftests/io_uring/overflow.bpf.c
new file mode 100644
index 000000000000..f347066e90ad
--- /dev/null
+++ b/tools/testing/selftests/io_uring/overflow.bpf.c
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/types.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "vmlinux.h"
+#include "common-defs.h"
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
+
+const volatile struct ring_info ri;
+static unsigned submitted;
+
+SEC("struct_ops.s/overflow_loop_step")
+int BPF_PROG(overflow_loop_step, struct io_ring_ctx *ring,
+				 struct iou_loop_params *ls)
+{
+	struct io_uring *sq_hdr, *cq_hdr;
+	struct io_uring_sqe *sqe;
+	void *rings;
+
+	sqe = (void *)bpf_io_uring_get_region(ring, IOU_REGION_SQ,
+				ri.sq_entries * sizeof(struct io_uring_sqe));
+	rings = (void *)bpf_io_uring_get_region(ring, IOU_REGION_CQ,
+				ri.cqes_offset + ri.cq_entries * sizeof(struct io_uring_cqe));
+	if (!rings || !sqe)
+		return IOU_LOOP_STOP;
+	sq_hdr = rings + ri.sq_hdr_offset;
+	cq_hdr = rings + ri.cq_hdr_offset;
+
+	/* keep submitting until we overrun the CQ and trigger an overflow */
+	if (submitted < 2 * ri.cq_entries) {
+		*sqe = (struct io_uring_sqe){};
+		sqe->opcode = IORING_OP_NOP;
+		sq_hdr->tail++;
+
+		bpf_io_uring_submit_sqes(ring, 1);
+		submitted++;
+		return IOU_LOOP_CONTINUE;
+	}
+
+	if (cq_hdr->tail == cq_hdr->head)
+		return IOU_LOOP_STOP;
+	/* Consume all queued CQEs and let io_uring to flush overflown CQEs */
+	cq_hdr->head = cq_hdr->tail;
+	return IOU_LOOP_CONTINUE;
+}
+
+SEC(".struct_ops.link")
+struct io_uring_bpf_ops overflow_ops = {
+	.loop_step = (void *)overflow_loop_step,
+};
diff --git a/tools/testing/selftests/io_uring/overflow.c b/tools/testing/selftests/io_uring/overflow.c
new file mode 100644
index 000000000000..724f3894d362
--- /dev/null
+++ b/tools/testing/selftests/io_uring/overflow.c
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Test that the loop handling logic around BPF doesn't deadlock on overflows.
+ */
+#include <linux/stddef.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdlib.h>
+
+#include <bpf/libbpf.h>
+#include <io_uring/mini_liburing.h>
+
+#include "helpers.h"
+#include "overflow.bpf.skel.h"
+
+int main()
+{
+	struct bpf_link *link;
+	struct overflow *skel;
+	struct ring_ctx ctx;
+	int ret;
+
+	ring_ctx_create(&ctx, 0);
+
+	skel = overflow__open();
+	if (!skel) {
+		fprintf(stderr, "can't generate skeleton\n");
+		exit(1);
+	}
+	skel->struct_ops.overflow_ops->ring_fd = ctx.ring.ring_fd;
+	skel->rodata->ri = ctx.ri;
+
+	ret = overflow__load(skel);
+	if (ret) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+	link = bpf_map__attach_struct_ops(skel->maps.overflow_ops);
+	if (!link) {
+		fprintf(stderr, "failed to attach ops\n");
+		return 1;
+	}
+
+	ring_ctx_run(&ctx);
+
+	bpf_link__destroy(link);
+	overflow__destroy(skel);
+	ring_ctx_destroy(&ctx);
+	return 0;
+}
-- 
2.53.0

