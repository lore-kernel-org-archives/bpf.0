Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AD7283FC3
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855934; cv=none; b=MyJ1qpRtSmVurdOTqZ3m0pnTeXSGn+OagFTjI71PH2afPC4tpALC6XlerG5tbFCnJqooHaVzskI6XUy+mEmA9t0qTqYMD77qZaGdfqcnYN2b4tOxDcdQtjZfkiyPyP/rMwOe4CEi/ZNhPn7t8maNViFa5xMFWuGPO8VkHNph6pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855934; c=relaxed/simple;
	bh=aTDQVecntenam5S7kU1weulGUTKGlTTsfnzGapduOIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKwwDGxKoD1K9vYA2uUdZTFCCC1n+di9kwYID9vMGWRedAVENKWW8yGpYNP+THN66p1DKtWlotvlZ/0Wa99HyknlIHUkS8uYcjWCixa4w6pnRkoLMY+ckEPqFX9wyDVktKezCncVfKMsfkHYYcV0ZBIKC06jiMEKciCCgmXMAsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0UxnODx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0UxnODx"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4836d4c26d3so38467105e9.2
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771855931; x=1772460731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBP6e52KEPK+2NDEKlDHrJpbPjaEvsvQBokttYVMRUI=;
        b=C0UxnODxgRA8s6PraPAukB1V1u5mZmgCODhUhrgEbIK87OJhqIN7R9QSAdV8G279h/
         Lj/3KKkWiFoUAQguU1tyg7Ut0Mz0JhcvmqCmQikiM0LaOanhjf8Ahf9tlUrsXxHX1NJK
         JoEwaESOirZ3+yFR5pyOvFIk5LsX2PxEuEA+W1F38t/JkZ/GZyX0LL26iTPvCjzM/9+A
         AAXo5CsuMepP5RbSudx5TH444vCL/cUi7yimhSsxp5GClygAUwH41N4i1eALxsrI+K08
         9ZY2I9W/iyLa9RkuL6OiVMZqBZDuyw8yYfbN1s4wUEyMu1j3QUP2/krNjQGwyvyUnbuz
         5yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855931; x=1772460731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SBP6e52KEPK+2NDEKlDHrJpbPjaEvsvQBokttYVMRUI=;
        b=r74+cEuibogLrHh+qWosGpjD+aNyakfxc1UkjqUjVYLPkIcZ6DeNIt09INmM3O3N6d
         aKxrTo7rTKlUwzjL4CLeT1qrygI0Ath/WoIBrvdXMsXQkVgFNLQZbdcldtDtp0rjryLA
         rj2CvcdHQ1CeBzF3RMv5T795K29g7JgKgeUkhVVcbAyVzzcnAtH214/ucZohWsjr2s/q
         tF3S3/fIuwYm9NPh/Q7y6LcrRhmVU+voyVYslAyW7m8aPlUVGtCAgwCr670NVrcx2vha
         f9yVeLdZ1cGGJGHOcTMny/IFxNZ97SqyqX4UXiHbTfe6UCUVfNSo2J/hz2+w4IZ9UwWy
         et9A==
X-Forwarded-Encrypted: i=1; AJvYcCVDchORzyMgIiSEhUiQoz5JCnQlqiPlKpe/QYpVoB/0vvKnVtrkt8xiV4UXlcUC7C4BMsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYsPpsaGoJGyh6RoY0XlbOFQ5yu+RNfLIvuC5ZpUUiFUXxbqs5
	iKMjs84nFrJOETMB7z75e8qOxDvkUyDMmb1oxoAgA9QjnPg2KYzIAj72
X-Gm-Gg: AZuq6aJPLNMRMladBNvlaZG8zI4lZARFVQ8W/X+ZDVzKXcHTrLGArfkuMBNLmnXxUyH
	EOkSvWAzBYyVgydHkiZTcpnKp9lnYMec0RBN+9ZG+X/dF0U2L9aPnjKQzU3KQlBHVNtL8BzRdzi
	BPd8xjkGwPPQTNob8ckOyKCDhWYSso/7POZzHMckoA/zrZKXGodpBcOLmIbRs3sKQrgPJwmiKWW
	PhGUo7Yubh3aZ5GTLl0JAc/WQYK1ZGA6pXwiD584RSyyEZnSGGzktoVWfiCLT6SURVXnJFBmPbc
	FU3HXZbq6zUQLiHXDF3dxEztPOBJSsIhUV31B4O8As/1yxKuYTMt13W7OVF6tAWikEqXNhAGMiJ
	fhcfRg8DYPFoFooFGxY/rgDxjjNUN0emwxJJbIlLQNvcXw54mJkPacKpu+ZvLjJN5CBRBjWMFYL
	VC6zcmfBl3n2SkW6ZYXL05if4/xOa0dd3Mcma/u2j7FIzMIgUlOggilofPhDCdElcv/H8arbfws
	PvM1gIdgntik61k6Kax
X-Received: by 2002:a05:600c:470f:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-483a95a852cmr152754095e9.4.1771855930781;
        Mon, 23 Feb 2026 06:12:10 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm247077275e9.5.2026.02.23.06.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:12:09 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH 2/3] io_uring/selftests: add rate limiter BPF program
Date: Mon, 23 Feb 2026 14:12:01 +0000
Message-ID: <0a7b1658b4ac231320086a1c295bfcae34888c90.1771850496.git.asml.silence@gmail.com>
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

Show how io_uring can be extended with features using BPF, which
would've otherwise required extra complexity and overhead in the common
io_uring for somewhat niche users. The rate limiter program caps how
many requests can be in flight at the same time. If the user queues up
more SQEs than the cap, their execution will be delayed until previous
requests has completed. It'll automatically handle submitting deferred
SQEs, as well will correct the waiting parameters based. E.g. if the
user submits 8 SQEs and wants to wait for CQEs but limits it at 2
requests at a time, the program will wait for 2 CQEs multiple times
until there are all 8 CQEs.

The test executes timeout requests and measures the total time to make
sure they're not executed in parallel.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 tools/testing/selftests/io_uring/Makefile     |   2 +-
 .../testing/selftests/io_uring/common-defs.h  |  11 ++
 tools/testing/selftests/io_uring/helpers.h    |  15 +-
 .../selftests/io_uring/rate_limiter.bpf.c     |  84 +++++++++
 .../testing/selftests/io_uring/rate_limiter.c | 172 ++++++++++++++++++
 5 files changed, 279 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/io_uring/rate_limiter.bpf.c
 create mode 100644 tools/testing/selftests/io_uring/rate_limiter.c

diff --git a/tools/testing/selftests/io_uring/Makefile b/tools/testing/selftests/io_uring/Makefile
index 26e4cf721b86..e0581f96d98a 100644
--- a/tools/testing/selftests/io_uring/Makefile
+++ b/tools/testing/selftests/io_uring/Makefile
@@ -3,7 +3,7 @@ include ../../../build/Build.include
 include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
-TEST_GEN_PROGS := nops_loop overflow unreg cp
+TEST_GEN_PROGS := nops_loop overflow unreg cp rate_limiter
 
 # override lib.mk's default rules
 OVERRIDE_TARGETS := 1
diff --git a/tools/testing/selftests/io_uring/common-defs.h b/tools/testing/selftests/io_uring/common-defs.h
index 20b59adbe703..dae3b0fe8588 100644
--- a/tools/testing/selftests/io_uring/common-defs.h
+++ b/tools/testing/selftests/io_uring/common-defs.h
@@ -38,4 +38,15 @@ struct cp_state {
 	int res;
 };
 
+struct rate_limiter_state {
+	unsigned inflight;
+	unsigned max_inflight;
+	unsigned cached_cq_tail;
+	unsigned target_cq_tail;
+	bool waitiing;
+
+	unsigned to_wait;
+	int res;
+};
+
 #endif /* IOU_TOOLS_COMMON_DEFS_H */
diff --git a/tools/testing/selftests/io_uring/helpers.h b/tools/testing/selftests/io_uring/helpers.h
index b6d1b8ca64b8..6894e081e3c0 100644
--- a/tools/testing/selftests/io_uring/helpers.h
+++ b/tools/testing/selftests/io_uring/helpers.h
@@ -31,7 +31,9 @@ static inline void ring_ctx_destroy(struct ring_ctx *ctx)
 	free(ctx->region);
 }
 
-static inline void ring_ctx_create(struct ring_ctx *ctx, size_t region_size)
+static inline void ring_ctx_create_flags(struct ring_ctx *ctx,
+					 size_t region_size,
+					 unsigned ring_flags)
 {
 	struct io_uring_mem_region_reg mr;
 	struct io_uring_region_desc rd;
@@ -47,11 +49,11 @@ static inline void ring_ctx_create(struct ring_ctx *ctx, size_t region_size)
 
 	memset(&params, 0, sizeof(params));
 	params.cq_entries = cq_entries;
-	params.flags = IORING_SETUP_SINGLE_ISSUER |
+	params.flags = ring_flags |
+			IORING_SETUP_SINGLE_ISSUER |
 			IORING_SETUP_DEFER_TASKRUN |
 			IORING_SETUP_NO_SQARRAY |
-			IORING_SETUP_CQSIZE |
-			IORING_SETUP_SQ_REWIND;
+			IORING_SETUP_CQSIZE;
 
 	ret = io_uring_queue_init_params(sq_entries, &ctx->ring, &params);
 	if (ret) {
@@ -92,4 +94,9 @@ static inline void ring_ctx_create(struct ring_ctx *ctx, size_t region_size)
 	ri->cq_entries = cq_entries;
 }
 
+static inline void ring_ctx_create(struct ring_ctx *ctx, size_t region_size)
+{
+	ring_ctx_create_flags(ctx, region_size, IORING_SETUP_SQ_REWIND);
+}
+
 #endif /* IOU_TOOLS_HELPERS_H */
diff --git a/tools/testing/selftests/io_uring/rate_limiter.bpf.c b/tools/testing/selftests/io_uring/rate_limiter.bpf.c
new file mode 100644
index 000000000000..c4fb74ee6a62
--- /dev/null
+++ b/tools/testing/selftests/io_uring/rate_limiter.bpf.c
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Limit the number of inflight requests, and automatically submits more
+ * when previous requests complete. The user can wait for more CQEs than
+ * the maximum inflight number, in which case it will loop submitting
+ * and waiting until the specified to_wait is satisfied. It's a simple
+ * example and doesn't handle lots of edge cases.
+ */
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
+#define t_min(a, b) ((a) < (b) ? (a) : (b))
+
+SEC("struct_ops.s/rate_limiter_loop_step")
+int BPF_PROG(rate_limiter_loop_step, struct io_ring_ctx *ring, struct iou_loop_params *ls)
+{
+	struct io_uring *cq_hdr, *sq_hdr;
+	unsigned nr_new_cqes, extra_wait;
+	struct rate_limiter_state *rls;
+	unsigned to_submit;
+	unsigned cq_tail;
+	int ret, to_wait;
+	void *rings;
+
+	rings = (void *)bpf_io_uring_get_region(ring, IOU_REGION_CQ,
+				ri.cqes_offset + ri.cq_entries * sizeof(struct io_uring_cqe));
+	rls = (void *)bpf_io_uring_get_region(ring, IOU_REGION_MEM, sizeof(*rls));
+	if (!rings || !rls)
+		return IOU_LOOP_STOP;
+	cq_hdr = rings + ri.cq_hdr_offset;
+	sq_hdr = rings + ri.sq_hdr_offset;
+
+	/* Recalculate the inflight count, we only consider new CQEs */
+	cq_tail = cq_hdr->tail;
+	nr_new_cqes = cq_tail - rls->cached_cq_tail;
+	if (nr_new_cqes > ri.cq_entries) {
+		rls->res = -ERANGE;
+		return IOU_LOOP_STOP;
+	}
+	rls->cached_cq_tail = cq_tail;
+	rls->inflight -= nr_new_cqes;
+
+	/* Submit SQEs if we're under the QD limit */
+	to_submit = t_min(sq_hdr->tail - sq_hdr->head, ri.sq_entries);
+	to_submit = t_min(to_submit, rls->max_inflight - rls->inflight);
+	if (to_submit) {
+		ret = bpf_io_uring_submit_sqes(ring, to_submit);
+		if (ret != to_submit) {
+			rls->res = ret;
+			return IOU_LOOP_STOP;
+		}
+		rls->inflight += to_submit;
+	}
+
+	to_wait = rls->to_wait;
+	if (to_wait) {
+		rls->to_wait = 0;
+		rls->target_cq_tail = cq_hdr->head + to_wait;
+		rls->waitiing = true;
+	}
+	if (!rls->waitiing)
+		return IOU_LOOP_STOP;
+
+	if ((int)(cq_hdr->tail - rls->target_cq_tail) >= 0)
+		return IOU_LOOP_STOP;
+
+	extra_wait = rls->target_cq_tail - cq_hdr->tail;
+	extra_wait = t_min(extra_wait, rls->inflight);
+	ls->cq_wait_idx = cq_hdr->tail + extra_wait;
+	return IOU_LOOP_CONTINUE;
+}
+
+SEC(".struct_ops.link")
+struct io_uring_bpf_ops rate_limiter_ops = {
+	.loop_step = (void *)rate_limiter_loop_step,
+};
diff --git a/tools/testing/selftests/io_uring/rate_limiter.c b/tools/testing/selftests/io_uring/rate_limiter.c
new file mode 100644
index 000000000000..4b9bdd4d6b44
--- /dev/null
+++ b/tools/testing/selftests/io_uring/rate_limiter.c
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/stddef.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <sys/time.h>
+
+#include <bpf/libbpf.h>
+#include <io_uring/mini_liburing.h>
+
+#include "common-defs.h"
+#include "helpers.h"
+#include "rate_limiter.bpf.skel.h"
+
+static struct rate_limiter *skel;
+static struct bpf_link *rate_limiter_link;
+
+static void setup_bpf_prog(struct ring_ctx *ctx)
+{
+	int ret;
+
+	skel = rate_limiter__open();
+	if (!skel) {
+		fprintf(stderr, "can't generate skeleton\n");
+		exit(1);
+	}
+
+	skel->struct_ops.rate_limiter_ops->ring_fd = ctx->ring.ring_fd;
+	skel->rodata->ri = ctx->ri;
+
+	ret = rate_limiter__load(skel);
+	if (ret) {
+		fprintf(stderr, "failed to load skeleton\n");
+		exit(1);
+	}
+
+	rate_limiter_link = bpf_map__attach_struct_ops(skel->maps.rate_limiter_ops);
+	if (!rate_limiter_link) {
+		fprintf(stderr, "failed to attach ops\n");
+		exit(1);
+	}
+}
+
+static void t_io_uring_prep_timeout(struct io_uring_sqe *sqe,
+				    struct __kernel_timespec *ts)
+{
+	memset(sqe, 0, sizeof(*sqe));
+	sqe->opcode = (__u8)IORING_OP_TIMEOUT;
+	sqe->fd = -1;
+	sqe->addr = (unsigned long)ts;
+	sqe->len = 1;
+}
+
+static unsigned long long mtime_since(const struct timeval *s,
+				      const struct timeval *e)
+{
+	long long sec, usec;
+
+	sec = e->tv_sec - s->tv_sec;
+	usec = (e->tv_usec - s->tv_usec);
+	if (sec > 0 && usec < 0) {
+		sec--;
+		usec += 1000000;
+	}
+
+	sec *= 1000;
+	usec /= 1000;
+	return sec + usec;
+}
+
+static inline struct io_uring_cqe *io_uring_peek_cqe(struct io_uring *ring)
+{
+	struct io_uring_cq *cq = &ring->cq;
+	const unsigned int mask = *cq->kring_mask;
+	unsigned int head = *cq->khead;
+
+	read_barrier();
+	if (head != *cq->ktail)
+		return &cq->cqes[head & mask];
+
+	return NULL;
+}
+
+static void run_ring(struct ring_ctx *ctx)
+{
+	struct rate_limiter_state *rls = ctx->region;
+	const unsigned long ms_per_req = 500;
+	const unsigned max_inflight = 2;
+	const unsigned nr_reqs = 8;
+	struct io_uring *ring = &ctx->ring;
+	struct timeval tv_start, tv_end;
+	struct __kernel_timespec ts;
+	struct io_uring_cqe *cqe;
+	struct io_uring_sqe *sqe;
+	unsigned nr_cqes = 0;
+	unsigned long dt;
+	int i, ret;
+
+	rls->max_inflight = max_inflight;
+	ts.tv_sec = 0;
+	ts.tv_nsec = ms_per_req * 1000000;
+
+	for (i = 0; i < nr_reqs; i++) {
+		sqe = io_uring_get_sqe(ring);
+		if (!sqe) {
+			fprintf(stderr, "get sqe failed\n");
+			exit(1);
+		}
+
+		t_io_uring_prep_timeout(sqe, &ts);
+	}
+
+	gettimeofday(&tv_start, NULL);
+
+	ret = io_uring_submit(ring);
+	if (ret || rls->res) {
+		fprintf(stderr, "sqe submit failed: %d %d\n", ret, rls->res);
+		exit(1);
+	}
+
+	rls->to_wait = nr_reqs;
+	ret = io_uring_enter(ring->ring_fd, 0, 0, 0, NULL);
+	if (ret < 0) {
+		ret = -errno;
+		fprintf(stderr, "wait failed %i\n", ret);
+		exit(1);
+	}
+	if (rls->res) {
+		fprintf(stderr, "bpf wait failed %i\n", rls->res);
+		exit(1);
+	}
+
+	while (1) {
+		cqe = io_uring_peek_cqe(ring);
+		if (!cqe)
+			break;
+		if (cqe->res != -ETIME) {
+			fprintf(stderr, "invalid cqe %d\n", ret);
+			exit(1);
+		}
+		io_uring_cqe_seen(ring);
+		nr_cqes++;
+	}
+
+	if (nr_cqes != nr_reqs) {
+		fprintf(stderr, "CQEs missing\n");
+		exit(1);
+	}
+
+	gettimeofday(&tv_end, NULL);
+	dt = mtime_since(&tv_start, &tv_end);
+
+	if (dt < nr_reqs / max_inflight * ms_per_req) {
+		fprintf(stderr, "timeout fired too fast %lu\n", dt);
+		exit(1);
+	}
+}
+
+int main()
+{
+	struct ring_ctx ctx;
+
+	ring_ctx_create_flags(&ctx, sizeof(struct nops_state), 0);
+	setup_bpf_prog(&ctx);
+
+	run_ring(&ctx);
+
+	bpf_link__destroy(rate_limiter_link);
+	rate_limiter__destroy(skel);
+	ring_ctx_destroy(&ctx);
+	return 0;
+}
-- 
2.52.0

