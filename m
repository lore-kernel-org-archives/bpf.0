Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCAA21257F
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771260713; cv=none; b=SBeUy3XUbk0RT9K7Ams3apbeaY2mxky0+Sr/v8kjuHE6JUCiFicXmWy3T+SteWJPZ02yHoEDguW1j3WnzCt+5Nr9kkGC3gb9B25eKWgYETB1Ov4WdhbJf9utSi05q52bQHYjUt5F6RJB28jUpPvegUy09ncjJfsd1lwcJHw6GMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771260713; c=relaxed/simple;
	bh=QE96R9eicSGpjinXpGU8uaHaRIew9YzdrFxbUp3vIgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAnncl9RbYbxsUMrCTc+V7nbYTNRmJO8cTldh3NnrEG1zbLOQRWqi04XxQCk5ngI6Fic24yn5vpO1+I2WhFfBHST3qiAiKG6RWjD18Nr6ZridQoUIDXZwYXi9VAAYRLRD7SSDVA9mG7tOGhrRcakF1LjVHHKw0LJkxpxblZH8dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEuRRMVa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEuRRMVa"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso16732995e9.2
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 08:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771260710; x=1771865510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x44aAcQjnWa1QWZK/N7Lh2pdpMQOoZvekrVC+aS3QjU=;
        b=AEuRRMVa98nEBKG2qQfT8RepXphEUpC4YVUkXgtdIolBu3jzrP1QqIHSEFZVNmBx1i
         RnjCQHGUEzQ1cD1a1O7XREJEJa4HxjREGYdsycsHE8yIUZrhIML8joaxQa2/Jpt/C6NY
         Rz4275LuPBMBWDy0oPnPJXGUInlEhRmmqaFMuz/GDLURJ5VOsgIldbF0SROiVw2CLA6L
         IShGPMyhTXIl+jywTscP/NMW1FHavA46eFr8mIxxyPcrxM6aePrSPJuQX5H72PW4MpGg
         BIXzbUiQCnnF0ww9vaTpmNweI4EDowvrjo98drujvuCkcjFt/gHzt8S1HjfE/KeKyBuU
         HRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771260710; x=1771865510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x44aAcQjnWa1QWZK/N7Lh2pdpMQOoZvekrVC+aS3QjU=;
        b=u7Nl46+QoOxD3Tb8isBpQYV+CaBiqeGQiDl9QlJL16Y5o921hPHKm6TOfXIVhvVNCk
         MfrPCzPPg83A8GYMCC2UyoJqYJ3vZ9mpR0HuPRjcwlwVVgjQSz9zARdyUvY6U2xb23ye
         zbqnr7k9Tj6CwVhwMeySQpspTOJXsw+7g5bBWRZ+lQOBJeDY0KfrILRcrUkugRlJ3jHb
         g1GQ/wEaltWeUVYM9TaFfs8HCKsbwE9qDJu/dmM4l5sHQphKkBD+XaE/jLtPyEkLeVkH
         JVAvFECerbG0j6lgwHuPoMiOjlG5YsBAOxXgFj/4PasS2YXCg/TFjuLUkdVDFwOF3xKb
         khnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2eFQ77T3tQJQv0z2SInrhmNmYZLa7a461+5HmOeD1zV5ppD/vxYGQMzfafi29QmcLimI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVbAC5dN4M5OHO3l4o1jOXFj876urnF/5UjfogeEhXCjRcksEb
	KGeA/EcHHBNNi7zSL1luzKFkJ4VFfnRThOjo+pCJtM14TQhnAiTr+TrRasbuuuAA
X-Gm-Gg: AZuq6aKnuyXW8sRYckZc16AzitVHdm1XRyvp9urZcf+ZCCCXm23ap1rB6e+ReD8rYvc
	57rUx0ZfgL+/knx+f1I3mc9a91Xcqt/o+ODi8TjBIaGGlanw3JVfBwoyBxc0+xSqa8luwG53vdB
	ZJJgh2wJK0GD4HZi8XJRfRbA+2n7wu6o8oIaWKEXj+MVcW8qTFVndeWviNeIzD6GKuKxrAUIwZD
	1e2o/PEPHdRZ5pJnyb8/AZYqr0VMtltv19P1IpxRj/h7B9yX3zfjvC2p+D4sT3aKs04RgLUC/14
	uuUgJ+UWhr2OE4XV/qLUbwGlPXB52EmTTNflBprzgJNTard6e+W+xwliX5J3diFiG75bYDiA85H
	qzc1D23N/S5HRq3DJAZj4YgC0fySDWUa2kt9RQF7ALZ618y65TyYIhdUfIcpawhWpbLx1csTyMG
	XJ6IFnHSdEHfgG9f9viArO1nApnWQGsSn9s/SNEu2RjRQMtysXqlvVRMY33e0GzsbJQtE/Z4AYM
	Qtp32Nb
X-Received: by 2002:a05:600c:348e:b0:47e:e2ec:9947 with SMTP id 5b1f17b1804b1-483710960eamr219840995e9.33.1771260709783;
        Mon, 16 Feb 2026 08:51:49 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837b64b08bsm76454255e9.6.2026.02.16.08.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 08:51:49 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v7 3/5] io_uring/bpf-ops: add kfunc helpers
Date: Mon, 16 Feb 2026 16:51:24 +0000
Message-ID: <de06ced9b6cdbf2e300d888de02ee061214d0e88.1771260487.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771260487.git.asml.silence@gmail.com>
References: <cover.1771260487.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two kfuncs that should cover most of the needs:

1. bpf_io_uring_submit_sqes(), which allows to submit io_uring requests.
   It mirrors the normal user space submission path and follows all
   related io_uring_enter(2) rules. i.e. SQEs are taken from the SQ
   according to head/tail values. In case of IORING_SETUP_SQ_REWIND,
   it'll submit first N entries.

2. bpf_io_uring_get_region() returns a pointer to the specified region,
   where io_uring regions are kernel-userspace shared chunks of memory.
   It takes the size as an argument, which should be a load time
   constant. There are 3 types of regions:
   - IOU_REGION_SQ returns the submission queue.
   - IOU_REGION_CQ stores the CQ, SQ/CQ headers and the sqarray. In
     other words, it gives same memory that would normally be mmap'ed
     with IORING_FEAT_SINGLE_MMAP enabled IORING_OFF_SQ_RING.
   - IOU_REGION_MEM represents the memory / parameter region. It can be
     used to store request indirect parameters and for kernel - user
     communication.

It intentionally provides a thin but flexible API and expects BPF
programs to implement CQ/SQ header parsing, CQ walking, etc. That
mirrors how the normal user space works with rings and should help
to minimise kernel / kfunc helpers changes while introducing new generic
io_uring features.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/bpf-ops.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 io_uring/bpf-ops.h |  6 +++++
 2 files changed, 61 insertions(+)

diff --git a/io_uring/bpf-ops.c b/io_uring/bpf-ops.c
index ea9c062a4d9f..1cc4fc647add 100644
--- a/io_uring/bpf-ops.c
+++ b/io_uring/bpf-ops.c
@@ -5,11 +5,58 @@
 
 #include "io_uring.h"
 #include "register.h"
+#include "memmap.h"
 #include "bpf-ops.h"
 #include "loop.h"
 
 static const struct btf_type *loop_params_type;
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_io_uring_submit_sqes(struct io_ring_ctx *ctx, u32 nr)
+{
+	return io_submit_sqes(ctx, nr);
+}
+
+__bpf_kfunc
+__u8 *bpf_io_uring_get_region(struct io_ring_ctx *ctx, __u32 region_id,
+			      const size_t rdwr_buf_size)
+{
+	struct io_mapped_region *r;
+
+	lockdep_assert_held(&ctx->uring_lock);
+
+	switch (region_id) {
+	case IOU_REGION_MEM:
+		r = &ctx->param_region;
+		break;
+	case IOU_REGION_CQ:
+		r = &ctx->ring_region;
+		break;
+	case IOU_REGION_SQ:
+		r = &ctx->sq_region;
+		break;
+	default:
+		return NULL;
+	}
+
+	if (unlikely(rdwr_buf_size > io_region_size(r)))
+		return NULL;
+	return io_region_get_ptr(r);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(io_uring_kfunc_set)
+BTF_ID_FLAGS(func, bpf_io_uring_submit_sqes, KF_SLEEPABLE);
+BTF_ID_FLAGS(func, bpf_io_uring_get_region, KF_RET_NULL);
+BTF_KFUNCS_END(io_uring_kfunc_set)
+
+static const struct btf_kfunc_id_set bpf_io_uring_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &io_uring_kfunc_set,
+};
+
 static int io_bpf_ops__loop_step(struct io_ring_ctx *ctx,
 				 struct iou_loop_params *lp)
 {
@@ -69,12 +116,20 @@ io_lookup_struct_type(struct btf *btf, const char *name)
 
 static int bpf_io_init(struct btf *btf)
 {
+	int ret;
+
 	loop_params_type = io_lookup_struct_type(btf, "iou_loop_params");
 	if (!loop_params_type) {
 		pr_err("io_uring: Failed to locate iou_loop_params\n");
 		return -EINVAL;
 	}
 
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&bpf_io_uring_kfunc_set);
+	if (ret) {
+		pr_err("io_uring: Failed to register kfuncs (%d)\n", ret);
+		return ret;
+	}
 	return 0;
 }
 
diff --git a/io_uring/bpf-ops.h b/io_uring/bpf-ops.h
index e8a08ae2df0a..b9e589ad519a 100644
--- a/io_uring/bpf-ops.h
+++ b/io_uring/bpf-ops.h
@@ -4,6 +4,12 @@
 
 #include <linux/io_uring_types.h>
 
+enum {
+	IOU_REGION_MEM,
+	IOU_REGION_CQ,
+	IOU_REGION_SQ,
+};
+
 struct io_uring_bpf_ops {
 	int (*loop_step)(struct io_ring_ctx *ctx, struct iou_loop_params *lp);
 
-- 
2.52.0

