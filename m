Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9B2C0F89
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770820385; cv=none; b=aZ5ACh4kZdyes0MVDoeZ/vccTeQz72TBcdpWjc2TEWflSQvPhYWx8O9nT7YkS/Cnoak+cyuZoRfzf0IYSfiphMK0KOSUQpbnawb6ML+IkCAYmsA0LdgeoPVV0C9K6atkixRl6Fe1db/YSel0QOunjPiNTcdRrf3AB3CYfKPiYwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770820385; c=relaxed/simple;
	bh=ALuKSSqac/+GM53UGJZlX8az80XWgYVG1bbhQsQ0qjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kN2QCUDEF2BJL4K6mvE4YHYfaUtz34ZaEJye46fgEalHhG8vgxkZBVx8m4uOK2WhOFcLQdc4ijqNmAfxGW7Du/oCpMa8m0qIUHextdKmYi7vJ88xUOhJ6oGSG1am0+5OxwPh4ydCLsUhSDwZroplmwlTHoA+YiuRiWHFyJzB8x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar5QEteU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar5QEteU"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so1558914f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 06:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770820382; x=1771425182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMIoPS42J6Pl/vzph2bdYRKefnhaAaVFjkhJhTrwf2U=;
        b=Ar5QEteUFJiiYP3nMG8O5EptBJHJv7KPMgBIxApKoQDwvdvJ6pkQQBgTS7PWL5YjRU
         oYuqYHrhFIIv/AkWRNWTaj6qMLE/d57YwuCqHfCxhkIyEJNpM5o7HYwQFny9eZyn8Ucv
         /YGYvzUqnQZme37S2BJs4Ad0MhSDIACAYx5GeeDRAgybkMgGpTO6ARW/E8PeGpPjfbgX
         6aLQ/4toqPRAqAaEM9hlxu71z1P+Dwkw11irQKXr65uicYs+qL6Xo0S3b+m3EEUeTUVV
         feisLNDpkd/4Bou7iYP3/WbEAiGW7o/PsLw/rgwSyFrHul9MHMjSx9CtNN4XT9k7b36+
         nJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770820382; x=1771425182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FMIoPS42J6Pl/vzph2bdYRKefnhaAaVFjkhJhTrwf2U=;
        b=jXEC+rqoLWoGHVeesvF17ZLU6TqRLpIbc2kYxJ8J+I+6lw15Qwb1aVe8g16kHNd9Iw
         AMsAg40YvKDqwyORiHB/8zMTCq/UkRgJw67T15efJQVWv7Q3fZsFmANPEyOAlgJpxABx
         CCfNFJqsJ3psyWjx4FM4ofjm4sgWqI9Lv3LYg3WgK31WdeFv8rYtCoSshJ0zK6EMa/42
         +ja7kRPDH2uuoqLvGlvKnefByNVDkRavTxxK/YLRRJKiNDgc/E+FFDo+AUA6ErE3zYTq
         WH09HC32Zm7ryPe4Ni1WEM6LhbiO2sj+B2Au/JfU/Vc9I/Sp3t3WAdahURz4jK/gDfgt
         M8Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXaiTQPghfxo7yRwsmjybM6mjAKxkv1lOAXqtQL08TZq6JszbF8YE0E9tSOR00JwmUC1jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbb7TT3JwCGCSXfTELReEzyZhlB8wl+UIgWaKS0MInlPVUPFap
	lAUwtWZYalfAr53fUI1Ogr4RUWhNM35FeyEAgiWYK1jhCBm/2Z8QmPH8
X-Gm-Gg: AZuq6aLyAfkbploKWqlmcfVyf1b4QkO51TWUToVfQt97r9UBN4BdrufkDwXnLTTjqvE
	KZl4OJmRPwdLiXPhljPAN7BSu4jGcAfnLCC+0NcDo6ItFqLjVkYwFGpLVu1ygEEkOKMKD6dvChJ
	rMLuU/QhIfbfNAv/JZblpgit+/lYSP5BLFz4x0/uMhLV20nMEhDyebBxQ9jQCT82fl5KvL7L6Nm
	NT/b96MGuqrycAkqNHPyBZyoFXQuMlIiebkyexhMpO8uWjJrywOzbezqiZ+/MSRIy9eMo06KhAD
	xObjcTPBAH69lK/lJB85fLoxFYg/3RKj0tFanF2cDSDqFNtK/nsLRuqcKkYi+7C8rOppZaWiqMn
	t5wjnoN7fE5aGTTKzmWpwpcZolNbPcb/A3WnHGKmYsw3vWeKQqhmQaOijyEdnhpazYRdPwZFxYd
	61EwfGgrIRKnNILtXAqrzaOw0ggp5g+OTodWqEauLZP0848UYdbUSrhBX5NydmeT0x4wlTV2sWw
	BGZMOfVMw==
X-Received: by 2002:a5d:4809:0:b0:436:32e9:994c with SMTP id ffacd0b85a97d-43632e99a5dmr18454994f8f.28.1770820381740;
        Wed, 11 Feb 2026 06:33:01 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:b997])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e39c75sm4973747f8f.29.2026.02.11.06.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 06:33:01 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v5 3/5] io_uring/bpf-ops: add kfunc helpers
Date: Wed, 11 Feb 2026 14:32:42 +0000
Message-ID: <1ac15fa8ce52a0ebf28555c8353eabf199d1d49a.1770818588.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770818588.git.asml.silence@gmail.com>
References: <cover.1770818588.git.asml.silence@gmail.com>
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
index 7db07eda5a48..66938514211f 100644
--- a/io_uring/bpf-ops.c
+++ b/io_uring/bpf-ops.c
@@ -4,11 +4,58 @@
 
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
2.52.0

