Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1B396D25
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194136; cv=none; b=ZNdZ6QO2nuPn5GLwBWv5wNq5tCbqLQoiSfK+G0nQ8Mv/iYAOiRcZZtZNEqcBSJUcrE2t4SW76UcOa+PuTz50D7RlXQNYCTN5xJzo0K0O1jXMvKGaWoUO2SQxKbjqL0ZV3HjGZbNJihV0DOvJwu4iPror8tql/3Z49WnrbOQ80fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194136; c=relaxed/simple;
	bh=BXF26WfspQD1f+THse2SOP2gHSc/2CF0BXE5D15lMrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEwJCPq7NZMZrrd0LLVS9lopFGX+h//Kajb+rcko5xqhVgId3+ynEqUc35DZRzqkVSKQUS8lVxyOGLuhUCbg2c8kYdOGJ3dDCh9PPExmkp1phf2wRtQTrdsWFM0yc7DoAdej18YwySEC82BVLLEIu65M5bXVhtwR2tUvDApalSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rT/feOGW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rT/feOGW"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8423f626a65so40989b3a.2
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194134; x=1781798934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvQawD0Kg/papzUrEu4jlkugdLsQZFEA+b1BBuoukfo=;
        b=rT/feOGW6AYHMtF1IIshdESdaCVpcHWniXWeQ5zd+F1gGe/LSvkyfbGP9w9Xr4FlJc
         mZYs3iyAAwGV1k1u9xFFp4tezQRdrdnJkPt9mf1acOZfeo6B17P5L8WAIigwtJx28xI8
         YP/j6zgm67Icm/DUFA5QcMOTxgTcbNBLpoOnaS7WXMhuNOWjnzrb+Bdb/XDJbAigw3UV
         0PP/p9v5FT1s1HJkdi6KiNol7ceCpkvtHTRKENIlCuFXsKRsLi4qcMBxW48FDYZPJFTm
         HB8n09Vmf3VkJNfu/Iep/2wovIsxxwYo4PaP/gxLGrkQDA/qv3Sfbetz8sjZJqINvSTN
         QRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194134; x=1781798934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvQawD0Kg/papzUrEu4jlkugdLsQZFEA+b1BBuoukfo=;
        b=bjbW1zUiY3ZmcCf+vXfnbz7ODnQqgmtg6/GmKDtQpxZR8nN0cmVDQMAgi58dKCGTkK
         R0jELFmRL/meNL+LU6Ln6ZXY8tsoSHVmBReTSJgfN7tcCAYuOvcTuisakqfydIc/Omjj
         fY7UiANmLYZSJu6PlRFMB1alTjCOyZsCReh55sAy8/Y37rfU0uhzbbXCSkV33K+6HHfh
         Zk+K275OivHY8y7Z6WH6yHfjLx5JeDMsaovooB36S7SXnNQND0I9qvKvTlb6vBbdg7Ph
         U5V0AOrVcFfwO+1tbEfX+zGK6042nJoA+GpIcLh/KA1BJs3WvKsUUpO09PhjGAD5q8KX
         a/fA==
X-Gm-Message-State: AOJu0YyaFtWqX7CvjOX85JQqx/fYIUu+ZFcdrp8qXgTha6FCJgrD6/4G
	AEDnQqKyQlSWkgWT812uNmt8rcy75leCfE8raJIXMF3Q0MeTNa+dmLBMXh/cE28JdarNrA==
X-Gm-Gg: Acq92OE2N41r7U5iJQ19Gk15oQuBuEHDVr2khS8X2gZqdPiqpLk/r18j6/FaWwaDjxx
	3S0cK6C6Tn7glJ2E4iCwFCHpFTCuzd9hwwlHzeBcvT8T6myb6uzhA0Iz/04u/zel3FJIvjLDKwB
	pWnvsr5pfFwzWc2a8j4O/16wZ2QGI9tkMtTtdHOGx5YrrnDE8gRowbeTuGfkYJH2a8QXcyxzaKs
	M6MP8+wqts/gQmuuU20FKkQw0G/V+gGUa7/aA36fjgCXdpT5qS+B12fAopRY7sIxStFu6g0a5dz
	89iCrtzof5kAIRK6jlXZouezCWlWQe0QbtY4D/FsMgohMIAFum9kHMGnq0Ea2RRfJmY8CNiyhx2
	iLqAtljbWYW8Yi6fu38hsgWwQYKZYtIct6My3dU9J90ZxR5F48PLw1P+zsfW68+mg2d3rd7ZzTO
	f7hWJLAVJcbzpNnjyL1OIPMCPeMzAi6qJI9w==
X-Received: by 2002:a05:6a00:9a6:b0:842:3aee:12c0 with SMTP id d2e1a72fcca58-843370762e7mr3967784b3a.23.1781194134186;
        Thu, 11 Jun 2026 09:08:54 -0700 (PDT)
Received: from localhost.localdomain ([188.253.121.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-843382e5788sm2274495b3a.43.2026.06.11.09.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 09:08:53 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar pruning selftest
Date: Fri, 12 Jun 2026 00:07:49 +0800
Message-ID: <20260611160749.391279-1-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a verifier runtime test for a branch pattern where a helper return
value and a related scalar stay live across the same control-flow
sequence. Rust/Aya-generated eBPF can naturally produce this shape when
a match on a helper status keeps data derived before the helper call
live across the same branches. Such code commonly uses the helper return
value in r0, where 0 means success, producing an r0 == 0 / r0 != 0
branch shape.

The test preserves that branch shape but shifts the success value to 1
before branching. Using r0 == 1 / r0 != 1 avoids depending on the
verifier's not-equal-zero refinement, so the test exercises linked
scalar precision and pruning behavior directly instead of being masked
by zero-specific range refinement.

On affected kernels the verifier can explore an impossible path where
r0 and r7 are linked by scalar ID, keep the wrong branch, and make the
test return 1. With linked scalar precision tracked per instruction,
state pruning keeps the real success path, and the test returns 0.

Suggested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 70ae14d60..de71d547f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -448,6 +448,41 @@ __naked void linked_regs_broken_link_2(void)
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("helper retval linked scalar pruning")
+__success __retval(0)
+__naked void helper_retval_linked_scalar_pruning(void)
+{
+	asm volatile (
+	"r7 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
+	"r5 = *(u32 *)(r1 + %[__sk_buff_data]);"
+	"r7 -= r5;"
+	"r2 = 0;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 1;"
+	"call %[bpf_skb_load_bytes];"
+	"r0 += 1;"
+	"r6 = 1;"
+	/* success path keeps r7 independent; failure path links r7 to r0. */
+	"if r0 == 1 goto l0_%=;"
+	"r7 = r0;"
+"l0_%=: if r0 != 1 goto l1_%=;"
+	"r7 <<= 32;"
+	"r7 >>= 32;"
+	"if r7 != %[test_data_len] goto l1_%=;"
+	"r0 = 0;"
+	"exit;"
+"l1_%=: r0 = r6;"
+	"exit;"
+	:
+	: __imm(bpf_skb_load_bytes),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(test_data_len, TEST_DATA_LEN)
+	: __clobber_all);
+}
+
 /* Check that mark_chain_precision() for one of the conditional jump
  * operands does not trigger equal scalars precision propagation.
  */

base-commit: 30dee2c176e7954f63d1fa3e52d172f30beb9bfb
-- 
2.43.0

