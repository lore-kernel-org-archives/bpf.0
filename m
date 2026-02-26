Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E82D94AC
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110132; cv=none; b=jACgLkBnsFOiAlJxGbI7MkXnR4PK/GMXDyt0EfXD2dVEkS3s0jspPFwQXtfoh3MvtxmBmHE6+cCAq+MrFd5pM27hQKKZfIF/EZgHmcj8Y3uhkMoszKJ2R75pejArJcaegvQ4GgYuErLtsBPvuPX+IhxahrwP4Ruu+THkD+VRAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110132; c=relaxed/simple;
	bh=SzOVkdAJnAZVcqrU09MenmaB/QPocxmGAqrdT+QS6tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnvGvwb2MqlsuygFJfvr4+5JsPUz/O8OgjMFcOsWrx1RXfa2YUWEyNSzUGdB70obW3ofZ5dz9/HkretPVp//uK2qjL4LbmftEX7xrT0dA8Ki1tMFOeB4qWZc5emf6vNgXGBZh76zPU3fmKHpWjJGDzYfKPtXwgli/jxb74i15qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw5gfrxx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw5gfrxx"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4398d1f06caso769007f8f.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 04:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772110130; x=1772714930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSRqAwdk1Btnm7V8ndK1fwdFXhphECwdHx4TrxZYE2c=;
        b=Xw5gfrxxcSm01Mu2mAgKvNOvPee11UujcsXBhpWMh4RhI1mvbV6BBExT7puwv8IQFw
         XPo0Qr99I1m5yjlhDG9+wUc1Cj6P99AzduF0E81PStF6/IFLCPsykja+FbU9uyghZCVX
         kRcqMeKhGmEfL6dE03FXtiw5+dUSHRO5yXJIw5RBi4QWkTlAnVkGqiRqj5qGBB8g1xf5
         LmIjVrW4wS5zVR8bBcwkI5kHqO48XH1Zbne3bAeSYo6HbHFFjC0bIaza0gUFH9Ge16r1
         rP8+hMAFrpZ5Xz14UYlWPnsNSKWQTWILZ3agHCXaVM7EkV9LSSz24yGH7l3QJDF4owf7
         D4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110130; x=1772714930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kSRqAwdk1Btnm7V8ndK1fwdFXhphECwdHx4TrxZYE2c=;
        b=UjiNm1peMzw+5jaiGwzNGX6S6ff5Z+Qr5eMEk3joBkCp8dETRKSQBdnLDzqQSAwoOz
         GM560LQhuRh5eCM6RsDwBkMmVxQufALvUVqUYZip0IsZ2NhF9EhpNnlWr4ny6lP81VPl
         fwyqal3oAS/YtnhWG/wtf8qdZYgbYbEtG1FzVTSb+mU+d0SlcQ1sCA8rMLuCdINzkkYc
         IHKbenZpX2VFyffO10Oxomt1KtkV7+srWyOpKuJWOCW3h302YLfz7BnF5edy+UZBW2qm
         wt/TDUpOv7d7d31BV7uUhj2fipzUdZXEBTDLlILb9hl2QyTZHiMHxBG9r1F3oRgy3Eu3
         nEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvTR4pLnkusA86pGSG3iFPT+3Zk5UtGPFvFz8T86bL9AMdrTVYY2uavUmcn5+Y9sjNwrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ6JFkH9utPcCQhOisBQBoihUWUUWratH4KJd1bJxkArHRcafz
	31ba8KEuECyIy8UCIPWfiET55AmvrvDeNhUuf6lw3v5n8TfPyHO+uyIquQt/6A==
X-Gm-Gg: ATEYQzzWpCmbv7XcdlQn8LuqoAZA8A7Kkjukcbyvmz6/X7fjAjl+6ajUVy2+hwjYpEZ
	xlH2wpufHwOp+5U613SKbmeQQH1547Ow4l6PUkR/Flg7qdMtoUNmsfcWbgK6TsSNXWA4oyi9IVV
	cMRSHMOHU3b9eKEWSe9FN8UWjQD6hOBSWgiVRjt5YDeGQ/YXeGTYX8wYgNlptLMR9zZpDMFf3Vl
	OtJH8orxtdmquok85e4yqduiqqb9Ygvd0Jt9lk4aTmm4jIc1T29AACrbWdTq0AKB6flW1d5UyAb
	GiVfc1Z1vOWG1CrXceEUeS8VtwnDvQHX0+7rk7pOY8db5e5bUkxKGMKPilTkits3dckdsBzDaR9
	dNZtaKI3mrdU+H8Q5X4xoOPdU4dGGlEPv/vOUuHPw7E7I1Ddt59h9QBIC28ujvQMG/HjqZbutGA
	UQ5+rG5hRh6Z/i0fBoBTbMkH4TccBhKCE1Q4Ne9O7za6lsoTEVeTVmFHzN4tyIk/cnnT25uftBJ
	jnd48A8zA==
X-Received: by 2002:a05:6000:2484:b0:432:5b81:480 with SMTP id ffacd0b85a97d-439942a5891mr7708251f8f.24.1772110129557;
        Thu, 26 Feb 2026 04:48:49 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:2ab0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c977sm43734576f8f.32.2026.02.26.04.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:48:49 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v10 3/4] io_uring/bpf-ops: add kfunc helpers
Date: Thu, 26 Feb 2026 12:48:40 +0000
Message-ID: <967bcc10e94c796eb273998621551b2a21848cde.1772109579.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772109579.git.asml.silence@gmail.com>
References: <cover.1772109579.git.asml.silence@gmail.com>
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
index 975db5a78188..17518f4ecca9 100644
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
@@ -68,12 +115,20 @@ io_lookup_struct_type(struct btf *btf, const char *name)
 
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
2.53.0

