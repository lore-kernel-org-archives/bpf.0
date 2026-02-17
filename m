Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E1833438D
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328038; cv=none; b=sYtXbtGrjdbVCFztnN/FYdHOF5f/DTLJpoXvQDRgG8TTHG/oMsFHkeczUOniaBDyVTFt8mOOC9zwMi4b2IQh4cqESd2vjWDdPLFhP/Wdw4aymHT6ICcmzI3evrOW7YdEYwkl0i/Y1wdoI8osBpAK2w9YLnK7CoGJaxHuCPDVaiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328038; c=relaxed/simple;
	bh=0On/O/JwrdhLe9LQEIpHxWB6lwVhQOmEdQjLmrIM6Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsUF6X4wo3QJpVjZ+W5wrq1SiKsY6jNqmxoz4lBtWuaasw3weyRKarrwyOC4Tjm0tqo40tvuvUuvm88QDBzxm1DSvvFx7+PBoveNJMlzgOvC/VNo+FpuGbFBDEMlzTCNrQIYXZ9OLEl9digcbu4PAZXUYZVfkxzFbnQFJwo+zMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsTQMwdU; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsTQMwdU"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43591b55727so4649644f8f.3
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 03:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771328035; x=1771932835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHo+GhzwemN1oIIYYrO9jf01kzrJwN539Cek687xENU=;
        b=LsTQMwdUO7R/oHp53J/BkdOX8FqB2/4KcaQ2t4e7Z6lTX1u0AMH+4XPhVfrKNBHh0R
         lm//1G1aKhSklRvvx9waFlTibXW6LpFIHS6kXPdUugbQ+77PtngISLZfwFVH3JF2s0vI
         Qx0LebE+qpuUhr83Ts2NTsE4/VRTCX6e8t62o0nulyjanBT3HtOpWhlN28NwILBC/NCb
         3RCb3qfmxYnNsz9CzW+6M4RCGCs7dMWOHthi9Z3F6PCYegOTD02/Otyt5g60l63MyZOn
         j4F23P+Rqe5gSvcGL6/NHlV/ZwkxDbjuRSW1cX24s3nNqQIN+Tr117doQ0hQoVGOgK6u
         kPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771328035; x=1771932835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nHo+GhzwemN1oIIYYrO9jf01kzrJwN539Cek687xENU=;
        b=hhFj1rOkVyx0OgstKXZmw27x9udo0MzDPTB5/RB49ntxio9vrXoDbKvksnil1WwWEa
         MQSsVwG2zdryjUlremaipli/wmbvXAHvEsRbtZl9tNlJfQvahvr9PpyJalha3fkiiVOK
         SxtfX42IAJg5f1ZrzsbsarzVrv8asr84evFByj2/vMTg6JgH3GqUGbOU5RuEn4/srkmH
         YdjodoJG8B0puxwLKPPqYVtSCzJoAe5XWaj2g8B1rMea2Sv2irDnWEE5CvZZoVjpQxrc
         +/S+2SYFIfVbexsEMsMj9/VTOVAnkiTrYp27qhvKUxxsuEDpBcBAUvtinsClmvKL+VX9
         9ppA==
X-Forwarded-Encrypted: i=1; AJvYcCVZXZtmP4vjH9nu/Ef8os93BZwrwqOKFksLQ1T9IdSoEy5Vm5QpaUBq2+ppH4ZdtJEbFgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDIPNK8QdG06wOx/4YnXxPJKl6wKtq+TJ1OZUSMXpub7+yCELQ
	qneqqOyKC0KR8bVLkEesU4XYerdSLpvCTrFbbfJRdwCnx4h6biRk6rOZd56NfA==
X-Gm-Gg: AZuq6aJCw2Kcbri32o2m8g5vx3UEHpnurL+GM7XpfNQ2ETYMcekknXoeI4NwPsqAv5k
	euD9L9HcP0ifvdCTYXKjX0MshQFUbNPJJdqIPzhB7tycKPvPug2Fm3Dq4/WJ2oNW1NU/WhQ88JT
	pLcwioqPAO4WDtCkOXpMbkdrwRUYXNSEL0iDbMa8/cdTSWpYlGHGwl1Cca0S7BOXKhZ/KcnD/w/
	Q3YE3+K+9BNI9ZwzQ0W0CcmyIwYDvSwzBGnjtRebwfOeQbwWZKYwtX869QnnAo1tGR1RGuP2ohj
	bosWbRIg17dfWpxN3aifcxB/a1hTNe7MemmnlZ++PBFNDq33fo/3wk3DsyodkrcSq7x9NtgGi9S
	63gVM9lUw0j0r1i/7DwSU/wHs2eSGFtbWNJxgqIuI5TPPjh9FvtStLTiQqgIKVRXfTcFNOf7cmv
	LkqNU7v8UJAaCx6owumCFWng1++Xjw1LwVj6TXzXbgfBVNi794uJokZbeOZn6TcdsUHY/BHWl9S
	qPP3jXjSDrs/6uXGjM6aUjafmRDwg==
X-Received: by 2002:a05:6000:2c0c:b0:435:dba0:7c0b with SMTP id ffacd0b85a97d-4379db31b43mr18479219f8f.3.1771328035155;
        Tue, 17 Feb 2026 03:33:55 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac800esm36258343f8f.27.2026.02.17.03.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:33:54 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v8 3/5] io_uring/bpf-ops: add kfunc helpers
Date: Tue, 17 Feb 2026 11:33:45 +0000
Message-ID: <60c053a451afc4307230a7e8bf08a97567cd5d96.1771327059.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771327059.git.asml.silence@gmail.com>
References: <cover.1771327059.git.asml.silence@gmail.com>
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
2.52.0

