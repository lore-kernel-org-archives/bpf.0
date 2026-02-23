Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1260D286419
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855935; cv=none; b=GNmg3+7K3QhmRsFco+hhpwfPcTQNozdzBnblTUp40QpWLoh5bJ8tpVS1iXCun/xy5KNSVEdINkPyqVkLJwAA4pg07f3iV6GFcrQ6PZXKidFOUT2iCALkc65O0jsiloXlSdiE3i8x/ZTJKsaRDvGJT4iVrdgjDWQ4bYFKt/8SALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855935; c=relaxed/simple;
	bh=JcAht/qa/33o5T4UusYBavU6NZLX2xadKpFRFYm9xW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzPHfTnxosXvOHw0lv+QBuomto0u4erfNq9pTEPN5y7AVLii1QjDmTR4i0imoYETWp+EgUVavhs7s2hbImUJIti50+iYKE4vQ+GoS8N86dUEEHjwaCGeNP2T7rvc5VKi4BnwopAfS+MKAqy/+yr4FWIrPJGznUs+7hbHTVATy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddFZqdI3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddFZqdI3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso32142395e9.1
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771855932; x=1772460732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX4kuF2xTkbALeEIGcpADsbj7jTldz4sBZ4UTLDJrhg=;
        b=ddFZqdI3so5g71j3bokeRCZa1HSU6lQGo9rwqcjc+gH0a3vzVpPN6JN+EAC7imXj7K
         FDu+4T6SUaSRzVZKURZeRMhn7jra6gl8lX2ZgObdOdCgAYFTwpM2i/UZR2cSEUJKKRfq
         sHQA9WExNScboYsMdddnfXSC6BuXUjbqfxK/+YLDsh/owt1XuRP6u4E4hsbmlH1vhS5i
         Iin/3DzjyleOJZPMBU3ufSdGJOMGkNL/9edvNQtyImXvu3wz4ArG39whaumFobKsH38a
         GH77E/Xl8o3VixS26aJr0VASomM9PvIIpIX4ru9AWpkxGxk7Wr9IKOpKnk0iX89NILIv
         4ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855932; x=1772460732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XX4kuF2xTkbALeEIGcpADsbj7jTldz4sBZ4UTLDJrhg=;
        b=ncWJPIDtmHI7L2YXtIMnFQlBTF8f2NKDpDcVx7Q0+T7h7r89m1xgdcxlhph9gpaTOA
         uZ8V2AVj3f2iEOkxPHiZj7gNFP80cbIYB/RFdf01/ncIhn9/Vxc5l16iHO7gE4W5Bjzg
         29+8LmUNCa8kgJ19sMdeMFz84TKLpuraydISfxkUVXT3kpwO2TMfCroOJacGb7scEKqC
         FA6tGLmoZXHrIiE1KSZGypgIWCHptSn3p14IrRBaaUY3S0/Ldm9wBvsf1/zKEEof5BqZ
         cggkoSjyRw3RS5gpwqvctWfPk3XFXHsPkrKDjNcfC8JJ/YI6g5FbluSGIHm2sKfLpl+w
         woEg==
X-Forwarded-Encrypted: i=1; AJvYcCXnq4aUe1jpu+EYsqF2/7WdU4BWTCHa5CDnSunBzg47tcuosLjgCEFUHrCg8DBYosT0OtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6mZYh4dgO8wM8bgU6GHh3WIR8YSbOQCFA39ufqbme0BgumnCi
	RGFkb2DInXWlOPtjPihxKeTQ6Gae11XW2MK+AX4GtAOwtMdksgJDrGUq
X-Gm-Gg: AZuq6aJHo00MwN4Q9jlCVrF25FmEQyJrVpZgKo1RJmJb40GigkJKMIBtr0Jgj9/dMcw
	2Zj7w5MUZri4sx7IB9yWjfexng9p99XSwtHLT347jqVKMlxhcSg28r7D0trKmrlqoVC8HgkkgCc
	n1hIWZILlKLiA+lARhTgKzdAqZj3wydx7RqCgk3+KOHdnTOOEK/7Bpo1kGSybPxVpisCIZDBiWX
	2US9+aC0FDNKarH1hBYWcnuazArgZGHhDPQ0iqmA0UAVYp75m7wWmUTXqcXJjEbLZUvLoL6f01I
	KJUK8O4S2/2GvJw4KNEPence+xAE5orAPQLm/vqAhGChDRMCbXx6qOaOq2nqPxtDo8Ppap9CW9A
	fTgqn6G+Y6DdD6I8uAjhhhcpdbdbxfDiHiyUQ/arQ8RIkdWvrylNDEy7xGKTHeGEFfeesoJdq+a
	p0+Lm8LlSUFKYVNSx+N5sz6BX8nyV0+Teg13HneIZhKcF3NP7fyeCarQYC95jn7PLUvgDASwJSt
	hidDM7AdA==
X-Received: by 2002:a05:600c:5394:b0:480:6ab1:ed0d with SMTP id 5b1f17b1804b1-483a95b7180mr149325395e9.9.1771855932219;
        Mon, 23 Feb 2026 06:12:12 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm247077275e9.5.2026.02.23.06.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:12:11 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH 3/3] io_uring/selftests: add regbuf xor example
Date: Mon, 23 Feb 2026 14:12:02 +0000
Message-ID: <09ea9cdafd870002278c2c8a62023c81aa742e2c.1771850496.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771850496.git.asml.silence@gmail.com>
References: <cover.1771850496.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kfunc and an example of calculating xor for a registered buffer.
That's useful for cases where the registered buffer is not visible by
user space and exists in-kernel only. The rest depends on the BPF
writer, and one way to use it could be to execute all jobs like xor'ing
at the beginning and the do normal request processing (the example
program just stops). Another approach would be to implement it as a part
of BPF CQE processing.

We'll need to think through the registered buffer kfunc API before
merging anything similar (not to mention implementing it properly).

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/bpf-ops.c                            | 29 +++++++
 tools/testing/selftests/io_uring/Makefile     |  2 +-
 .../testing/selftests/io_uring/common-defs.h  |  6 ++
 tools/testing/selftests/io_uring/xor.bpf.c    | 31 +++++++
 tools/testing/selftests/io_uring/xor.c        | 83 +++++++++++++++++++
 5 files changed, 150 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/io_uring/xor.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/xor.c

diff --git a/io_uring/bpf-ops.c b/io_uring/bpf-ops.c
index 1ffe7ba73b89..51c239c7cb34 100644
--- a/io_uring/bpf-ops.c
+++ b/io_uring/bpf-ops.c
@@ -9,6 +9,7 @@
 #include "memmap.h"
 #include "bpf-ops.h"
 #include "loop.h"
+#include "rsrc.h"
 
 static DEFINE_MUTEX(io_bpf_ctrl_mutex);
 static const struct btf_type *loop_params_type;
@@ -47,11 +48,39 @@ __u8 *bpf_io_uring_get_region(struct io_ring_ctx *ctx, __u32 region_id,
 	return io_region_get_ptr(r);
 }
 
+__bpf_kfunc
+__u8 bpf_io_uring_xor_regbuf(struct io_ring_ctx *ctx, unsigned idx,
+				size_t size)
+{
+	const struct io_mapped_ubuf *imu;
+	struct io_rsrc_node *node;
+	struct iov_iter iter;
+	__u8 xor_res = 0;
+	__u8 buffer[512];
+	int i, ret;
+
+	node = io_rsrc_node_lookup(&ctx->buf_table, idx);
+	if (!node)
+		return 0;
+	imu = node->buf;
+	if (size > imu->len || size > sizeof(buffer))
+		return 0;
+
+	iov_iter_bvec(&iter, ITER_SOURCE, imu->bvec, imu->nr_bvecs, size);
+	ret = copy_from_iter(buffer, size, &iter);
+	if (ret != size)
+		return 0;
+	for (i = 0; i < size; i++)
+		xor_res ^= buffer[i];
+	return xor_res;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(io_uring_kfunc_set)
 BTF_ID_FLAGS(func, bpf_io_uring_submit_sqes, KF_SLEEPABLE);
 BTF_ID_FLAGS(func, bpf_io_uring_get_region, KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_io_uring_xor_regbuf, KF_SLEEPABLE);
 BTF_KFUNCS_END(io_uring_kfunc_set)
 
 static const struct btf_kfunc_id_set bpf_io_uring_kfunc_set = {
diff --git a/tools/testing/selftests/io_uring/Makefile b/tools/testing/selftests/io_uring/Makefile
index e0581f96d98a..3b139964f537 100644
--- a/tools/testing/selftests/io_uring/Makefile
+++ b/tools/testing/selftests/io_uring/Makefile
@@ -3,7 +3,7 @@ include ../../../build/Build.include
 include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
-TEST_GEN_PROGS := nops_loop overflow unreg cp rate_limiter
+TEST_GEN_PROGS := nops_loop overflow unreg cp rate_limiter xor
 
 # override lib.mk's default rules
 OVERRIDE_TARGETS := 1
diff --git a/tools/testing/selftests/io_uring/common-defs.h b/tools/testing/selftests/io_uring/common-defs.h
index dae3b0fe8588..ee6c36eae426 100644
--- a/tools/testing/selftests/io_uring/common-defs.h
+++ b/tools/testing/selftests/io_uring/common-defs.h
@@ -49,4 +49,10 @@ struct rate_limiter_state {
 	int res;
 };
 
+struct xor_state {
+	unsigned regbuf_idx;
+	unsigned xor_size;
+	__u8 xor_res;
+};
+
 #endif /* IOU_TOOLS_COMMON_DEFS_H */
diff --git a/tools/testing/selftests/io_uring/xor.bpf.c b/tools/testing/selftests/io_uring/xor.bpf.c
new file mode 100644
index 000000000000..c7c3b46ca1bf
--- /dev/null
+++ b/tools/testing/selftests/io_uring/xor.bpf.c
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "vmlinux.h"
+#include "common-defs.h"
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
+
+const volatile struct ring_info ri;
+
+SEC("struct_ops.s/xor_step")
+int BPF_PROG(xor_step, struct io_ring_ctx *ring, struct iou_loop_params *ls)
+{
+	struct xor_state *xs;
+
+	xs = (void *)bpf_io_uring_get_region(ring, IOU_REGION_MEM,
+				sizeof(*xs));
+	if (!xs)
+		return IOU_LOOP_STOP;
+
+	xs->xor_res = bpf_io_uring_xor_regbuf(ring, xs->regbuf_idx,
+						xs->xor_size);
+	return IOU_LOOP_STOP;
+}
+
+SEC(".struct_ops.link")
+struct io_uring_bpf_ops xor_ops = {
+	.loop_step = (void *)xor_step,
+};
diff --git a/tools/testing/selftests/io_uring/xor.c b/tools/testing/selftests/io_uring/xor.c
new file mode 100644
index 000000000000..c2e7d6af2c92
--- /dev/null
+++ b/tools/testing/selftests/io_uring/xor.c
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/stddef.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <time.h>
+
+#include <bpf/libbpf.h>
+#include <io_uring/mini_liburing.h>
+
+#include "helpers.h"
+#include "xor.bpf.skel.h"
+
+int main()
+{
+	struct xor_state *xs;
+	struct bpf_link *link;
+	struct xor *skel;
+	struct ring_ctx ctx;
+	__u8 *buffer;
+	size_t buf_size = 512;
+	struct iovec iov;
+	__u8 xorv = 0;
+	int ret, i;
+
+	ring_ctx_create(&ctx, sizeof(*xs));
+
+	skel = xor__open();
+	if (!skel) {
+		fprintf(stderr, "can't generate skeleton\n");
+		exit(1);
+	}
+	skel->struct_ops.xor_ops->ring_fd = ctx.ring.ring_fd;
+	skel->rodata->ri = ctx.ri;
+
+	ret = xor__load(skel);
+	if (ret) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+	link = bpf_map__attach_struct_ops(skel->maps.xor_ops);
+	if (!link) {
+		fprintf(stderr, "failed to attach ops\n");
+		return 1;
+	}
+
+
+	buffer = aligned_alloc(4096, buf_size);
+	if (!buffer) {
+		fprintf(stderr, "allocation failed\n");
+		return 1;
+	}
+
+	srand((unsigned)time(NULL));
+	for (i = 0; i < buf_size; i++) {
+		buffer[i] = rand() % 256;
+		xorv ^= buffer[i];
+	}
+
+	iov.iov_len = buf_size;
+	iov.iov_base = buffer;
+	ret = io_uring_register_buffers(&ctx.ring, &iov, 1);
+	if (ret < 0) {
+		fprintf(stderr, "can't register buffer\n");
+		return 1;
+	}
+
+	xs = ctx.region;
+	xs->regbuf_idx = 0;
+	xs->xor_size = buf_size;
+	ring_ctx_run(&ctx);
+
+	if (xs->xor_res != xorv) {
+		fprintf(stderr, "invalid result, %i %i\n", xorv, xs->xor_res);
+		return 1;
+	}
+
+	bpf_link__destroy(link);
+	xor__destroy(skel);
+	ring_ctx_destroy(&ctx);
+	return 0;
+}
-- 
2.52.0

