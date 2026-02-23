Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3250524CEEA
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855847; cv=none; b=mB/VRHiEa/c5kab+lAbXWPrkJhdipkeHy2yLsLHd3qy6g0kh23ot0NtSt0u/7d8lK51C6+7+a4/AVK2DBONlVr4jbdiOIQB31urRzcekV3QOpXZCp6LcOLcHaqI9Le4Xygi4bZR4g1DZ+wK3snvNqoGqBqWUSMpaN+dQ2lvI40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855847; c=relaxed/simple;
	bh=SzOVkdAJnAZVcqrU09MenmaB/QPocxmGAqrdT+QS6tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Of0Kok2hvE3YfMWwzeUGdP02f8Ba4vAq4xDv5TcyKZMvUn0QoK6Od4gkQ7aBjW3zXSCqpJnii+9zCG5sXEoXZ4U4nYdxseW/182aHfyOc08P4Nfcr1VMslyBwc4zshL6Q2UF9amYZMJRx0Xs+AF8Hx8wQbWDBfvph6BUFkoQogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jW0CFaOc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW0CFaOc"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43626796202so3766846f8f.3
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771855844; x=1772460644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSRqAwdk1Btnm7V8ndK1fwdFXhphECwdHx4TrxZYE2c=;
        b=jW0CFaOcu3k3Ao8Ro4b13Vz8Fr26RQR4UI8vDGfWSgvZv5HWVqVkJUtBXrgKh/z1A1
         rLmlKGJ6QkfBpeZds1qoKnP8KmPdnbUwIyVL/8yp9w7CnHPbAHU8J5GwhwRmRZs29f30
         C+sW2e+F4Qz7AZy1qPE8zzR5KMsJCts1rc8iELq33xW6m46wMc4S9uOYBvF2gLEZuK8K
         cf5vt2fjpTSfKtEnDfHmUcam7OPYlu/PCd/xCDkNYWI5yMhLSBby4/1pY4ELiWMbY5ah
         VrYhSuIPZNaxH//mM3k0iNsk8kFFCm2ySxh4IkaYXlfQ8kK2JK4+qVYABakMGXhzwjGu
         DsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855844; x=1772460644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kSRqAwdk1Btnm7V8ndK1fwdFXhphECwdHx4TrxZYE2c=;
        b=Ok2GrgpQmQwiq/jWDpB7OyDXGTw7aPYDHpWEdOpQhmhC6LTwYo6YPum1rAq1ZFl626
         k9fDljXJ3fXV4fHLqyql6wakC0MaXyCatKfk7FiQRi5R5jz5ot758ROrDT/vohQBrsJK
         eFyNCscQl2Obc4jm/6VnNtyz1pY4VasaLl6OUqFexNpY6ieZzmvVAcrk1h63Jz3UHDNm
         jUtIS7LvrLPMbaAfsj1TK+tfZnizYgvdpO+LEQBM8BRAIDLHgvARezf6wcgpefS4CC+G
         mr4WsShwcc3tHObJtEbM4AM/1eIkkdM0Agyj4AjNBLzFyaeANmsbzVgOJzSkcRsTFGfF
         rLZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVds8y2B3heEr9coNl6howpr1B8csHT5sEUJGFGVK21qEQQew06FkgT2BTp7zZjvDkQy8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSlwQRABQQ0qIS2u0Ib4bAi2H3RQyPXgzsp+4CkGW7iAsTlhgr
	yernJqROJ/TZsLFWzT2mVuodUdR1eUPH626eklBNkmphpZZfvR4FcZmo
X-Gm-Gg: ATEYQzyY1kVVcorLtuMXRrF1lAOiZrkz58lnAE9QD6j8AjmESuwonquLZWYe7hsVu46
	mlbpETOmocnJDbJ5ILOAlb6ny0GdanyjZXHvWwtcdkOqcZpXQEF/2CGJHTV9BZl5YaZLlTqkP5Z
	4LZOF6/hdRgxtTdBUmJFY5EYu1OK2ZcedqIqq49UxZrFJgRH8r4/6UlEmKeaOY1FKN63XtmAnbn
	YBAbOj+Bf5/EM+i2ohIC5xLbZrzVO6vZjkQBHehv+uYi7WzR1hRKTiFXoBkH/v/qdnaoTLoppEX
	GrK+ulA2kvAWFKo3ovIMO6FOlYx5d+If1Bcw0ihetPdh8D3eHiIq9vdg/J0Yk471OSlLCV3FaWe
	3ISVVpDC/6v+U8VRlqHAyydDJHn6FPL68RH05GECy/HdYlVXdN441BU91oueGml99J3cf8evS38
	Hq6h9YTOQDRO01tMO7ozT7/CK/JFHEPoMCcvX0a/jQFmSBnYzrLr7T1o3Rm+KGBlylbgSOCPMG1
	iEOgC1ugjuU8lG6QGbW
X-Received: by 2002:a05:6000:26c2:b0:436:8058:449 with SMTP id ffacd0b85a97d-4396f17b48dmr16230773f8f.45.1771855844380;
        Mon, 23 Feb 2026 06:10:44 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm19464640f8f.6.2026.02.23.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:10:43 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v9 03/10] io_uring/bpf-ops: add kfunc helpers
Date: Mon, 23 Feb 2026 14:10:14 +0000
Message-ID: <60c053a451afc4307230a7e8bf08a97567cd5d96.1771855761.git.asml.silence@gmail.com>
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

