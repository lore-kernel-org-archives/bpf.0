Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668E352953
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836702; cv=none; b=OiLZAavRXOWVPIg/Q/yc2UYS1rtPHKmfyAeMRQYA6h5VAzkGeEeZfeLpPLMlvLJ7kwNftMUXNXvmXhafR5pPJhJGNHZI0yz7ntb/ntCTTfwDZSKNC82DRTebp3M04UpmDzd1vS9DDowIX706fAeyXNrVZykWq6n2AP0FHlDKPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836702; c=relaxed/simple;
	bh=QE96R9eicSGpjinXpGU8uaHaRIew9YzdrFxbUp3vIgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXmdHJ1MarDeB1QIsOTJRi0+VOp//ROxJWnZjzHSkCnBEp3nWWSQnrzoaSfy5XsJ7o5eOdh02ojZB7DySEBLF3ZwY0DEZbJGhC7SOlUGOBjNHjmLwfBmrSbnMlIcE5WhPDDR9D8Wx6Sh7mWTV7heHSqs8jyhTyizsEKOGiaTcn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuADs2a8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuADs2a8"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-436317c80f7so787667f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 11:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770836699; x=1771441499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x44aAcQjnWa1QWZK/N7Lh2pdpMQOoZvekrVC+aS3QjU=;
        b=iuADs2a8Y+WNRVySQoDGSIt7XVCMA+QvGYXLpXnaC2tVV71Xzh2jhjEbuUDFI3JmIo
         bvybXthbl+tD0LlME8VWzLjvPxLJi3Kp5QWlKIEciYsfilBymyx/4dCNtYUAeowaACdA
         Vc853YZVyyfJtlYZisgFvi83mOGlHuKZxF0qIcCM+ejOqeTdvTrvWYl0cum9QDBQy3SZ
         0SGIZyRrFl5ir8eVcAouHQN+ikmgTmD093vLZrd7bJQoJZgIhgTgQkgcwhu+PbiSekjb
         w4wNYL5nQEGz4JCcDVqgboC3A6qNL0YfErDIsxP8dIyjL7s34N9f2tfljPzCrYj/N3RI
         B92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770836699; x=1771441499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x44aAcQjnWa1QWZK/N7Lh2pdpMQOoZvekrVC+aS3QjU=;
        b=WJnukQb7u71exNzfp9bxnlU2Rm5n2BEj8epINiXAF9Iif1Nyd7C5ver28XEjE2kIfz
         uXkj3yoUuwvKXnibOe719xeleNnl6S5jl/RXk6+6tRcMZDKJFv4dcyySLnzejUPPNd7x
         UPIh5xI54i8tODxICr2A8aYNI+1EgeZDQJ3VOA8JPULSwrtTS1OsXTVkD/vyMRQaTjQo
         vKNJcExNWFuQqu9fNWwOGMe8vvu9FR9Vk7q0gXPoK70QHpinN+C4NxIWYKpV+sgBUN1C
         bsO44Csu110EvEDs8s2urHrSZitPn7FILJzEpiwb6h2C2QpHXF+iWGWWeFvaGw32QXYw
         QTQg==
X-Forwarded-Encrypted: i=1; AJvYcCWiw2e9E+xfitpBMcz5RR4XHhGBF0N4th3iPuWy5TBZF0Kc9QAt7pX5V2gDtLlLDccr+uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDzpsGPwCBlU9aaiSItwsNruxBywrXopwcoIa4t0ppL1bGwbp
	K+XLpIdQjmjh26QOHFJgOlRFOyEHtquLh2atAWVZTRBXhMne5+kle4Dg
X-Gm-Gg: AZuq6aILgrcrRzLi9a9+7vtjvyLwPXGWUguOrKJiAvGt/CyNWf/NgCXpUsrPgHAPLCd
	DZK5ioBS1LkDigMYRIq4NzBsjgguFHa98eh18g8tx/b65wRwga4ne3VyIymWWW+L0RfdXIQ6Nrv
	+hr+bPwCek/b0emfpB/2dbyirZaoAq+kSFhpdEAoxt7BKbxIxxmzxRM8dM2kRrqYCTExzPCiNUS
	QgrPVi/ndzDczPAlkXvpnIVyyx51ZL1frdV7e2a3vTdV0+mCNjoaybqcPSDPrtvDT4y0iypSYQp
	QaPimVRs68mdnB/hehit8p54e12BENkc3WjClopZ8M9mOCUGHfwwI948DNGD8P+ub2FhLa3lAkc
	LCNmbc0LbUJLTY/1R+Ahf/rVDeu+bf30ISdfuymQWgleKhxhFYSzpF6wppq3mAHlSKeGaOkXwU+
	rmhQ9kFOPcfxPBwyYb/RpzuGMT2ZyR+M4gznV390zcOPp/+G1eRcAN6qJi48mklE6ykJcVc2FF3
	ANOT2bVab7iiUuaQuLf6NhGLDHyVQ==
X-Received: by 2002:a5d:6702:0:b0:436:15d3:ed2e with SMTP id ffacd0b85a97d-4378e3dc0ebmr22729f8f.0.1770836699462;
        Wed, 11 Feb 2026 11:04:59 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc8b9sm6174169f8f.24.2026.02.11.11.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 11:04:58 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v6 3/5] io_uring/bpf-ops: add kfunc helpers
Date: Wed, 11 Feb 2026 19:04:54 +0000
Message-ID: <d0b2f03831b4ea7caa39956325bef1a3b9653b4e.1770836401.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770836401.git.asml.silence@gmail.com>
References: <cover.1770836401.git.asml.silence@gmail.com>
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

