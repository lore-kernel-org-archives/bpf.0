Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113A313283
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 06:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097661; cv=none; b=TaKT/dtYfCnrBq3LCgqCTrNdvbiTjKhyB5OKtTM1KFzEiYiltsTr/e5wo882aK93q4vU8lr2T2L3RO8qN+IO4ZYHVwOFNMV/HXQ7o+TQlqAS8mkzvc7A9MV9NDZDB4pjo5p8z5IHiyj3f+Zd9xAn3gEC5gVkinqKavZDw1qQ3aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097661; c=relaxed/simple;
	bh=f/M2fiqgudxqd7zGlXp00ebs8J8lc1fmZ/ceysiFP0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ir+rzgZwIr9ScpLpdavPtgMamOjKdY7CBtp7Ad42m4pAlaPJIUo/j7vJBbnYuwAo8tF516J0zJiKTETs+xK6ntnzFk2f7V2cEXZTANoobTSGMBJqLIBZdK+xt/Mn1xJkPknksmWQ2T7eMOUORa2U2mfDaE+g9onatEu4obZh8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcAY4pEO; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcAY4pEO"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7eb64085c45so3198956a34.2
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784097659; x=1784702459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mPNQs5TwrjEX2lxzY40Aw6m/ZaTAn9YZ5N4zk7cl7MQ=;
        b=EcAY4pEO198QeoeU/x3Q22F+/9gyelFdDpeXaCZ8zz02Fy+keQm0dqD6YP2w2S9Fi8
         lKlIlvVoV5KGJa1oeaxKGAAu6bTNXKQ1bwV/TBJL6nCxnb4riRju8ntDKNI7ii6B+pCz
         6QBf/WvE4YfXzrpd1E/6TeUg5iVeS2gVwNVqxq3hvQPE4x0PFHILPlMCOZXRcuvchWUO
         9Ku/03aFAQppdvvEUvuWpSEd8fMHgCU4kr2a2ivQ+7p5uDqMQlxoXJ/txs5O4Itn/TEi
         sXX9jB6PKi1zN2/sgtW5DLbqRna3m8+KIUtlSA/Kyr51pFGUFWRuAgvm8g5+hfbzWa7n
         +Asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784097659; x=1784702459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mPNQs5TwrjEX2lxzY40Aw6m/ZaTAn9YZ5N4zk7cl7MQ=;
        b=NSEPM9fky7JyUBz6QObVEoE3Sfn9u6LG18FPDv4CnD76MA4UYKWDYudNLV1RKBRVnJ
         fwudOv6UykqvSg7oWJ1OP72bzcdrlFQ5oGK+NN7wz+kRoU3zjnXmJCOlIE2FIBxzVaS2
         qWA6sBbkMxxOoV91JXklHSlmY77FVAmv2a+Q9tJfhAL6iH4GHRi2BfKmMeVDAHZpO2Et
         5zKtxLdwz/5CbQtZsvQXkTleQ0dEim4V/BmZONCZNSrq/cJ81Q012HxQwfx5zY7jN9XO
         BzIL+umcj1QgwVmlgYBy2+/sIDsH0V61aw4I1/gZpEstNyhjSAaAaUaAyy1GMRTFsBI+
         vlkg==
X-Gm-Message-State: AOJu0YxxKJpTdnyJ5VzqHvJrb0nla+RkFofCVgYBOJWrWjPUV2gQC5k3
	gaqJTT2t7xahyQlDmqJTTI1cng0w+WcivgUeeqK2dT4n7eLiYpP12vb8w//mag==
X-Gm-Gg: AfdE7ckiyvBuW73dOZ787/Blo5/aytYOSJ1F2oat+95omSVDpjCEi+/2jBt8Qfxzqqs
	igos0DHQ8seXa3rn1D+yvXLxq0lGaQIA+u4yN4ZaXHDo5zzuyO+hEKBuXy9D8iYBSlzEBUmm768
	qeh3dXDc2W15uGl2ihHDIKS4ZWHpD41u+tTCQRtqverPEXFPb7CjVRGYCiOkbzBeBMCsCyOGBcE
	hHmm0cFBzMDsmTWxfBI9nQ6uAtGg9gS6thvNXviAu4VBa7bnwDFv8ywYwwDF9IwZukbjBPKv2vp
	IQTDBWa5M+bGD+pH/Wj/8eebvMhSv+tak6tOPWAXRP25xXVRHkqmd2VDvJvnpwgBntK6C3bNk7/
	68g/QoRlI3riiA7mk1V3JduRiiYrLvqG5SWm5RsgdOS4MQkCYPmzVjLWzyQ0a6QOdsWG+5/vHgy
	dKhQ==
X-Received: by 2002:a05:6830:358f:b0:7dc:4947:36a1 with SMTP id 46e09a7af769-7ec59b7c70amr975746a34.12.1784097659058;
        Tue, 14 Jul 2026 23:40:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ec2183a28fsm7649089a34.24.2026.07.14.23.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:40:58 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 5/7] selftests/bpf: Test kfunc returning zero-sized allocation buffer
Date: Tue, 14 Jul 2026 23:40:45 -0700
Message-ID: <20260715064047.1793790-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715064047.1793790-1-ameryhung@gmail.com>
References: <20260715064047.1793790-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test passing an explicit rdwr_buf_size of 0 to
bpf_kfunc_call_test_get_rdwr_mem() and then reading the returned R0.
R0 should be a zero-sized PTR_TO_MEM, so the access must be rejected
with "min value is outside of the allowed memory range".

This covers the pre-existing bug where a zero size argument was
treated as "no size argument": the verifier fell through to
btf_resolve_size() and sized R0 after the pointed-to return type,
wrongly allowing the read.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/kfunc_call.c     |  1 +
 .../selftests/bpf/progs/kfunc_call_fail.c     | 27 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index c9fce95d220e..7af5560f2a08 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -66,6 +66,7 @@ static struct kfunc_test_params kfunc_tests[] = {
 	TC_FAIL(kfunc_call_test_get_mem_fail_rdonly, 0, "R0 cannot write into rdonly_mem"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_use_after_free, 0, "invalid mem access 'scalar'"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_oob, 0, "min value is outside of the allowed memory range"),
+	TC_FAIL(kfunc_call_test_get_mem_fail_zero_size, 0, "min value is outside of the allowed memory range"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_oversized, 0, "allocation size exceeds u32 max"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_not_const, 0, "is not a const"),
 	TC_FAIL(kfunc_call_test_mem_acquire_fail, 0, "acquire kernel function does not return PTR_TO_BTF_ID"),
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
index 6144ce3ff0b2..64b6a0b0ab1c 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
@@ -103,6 +103,33 @@ int kfunc_call_test_get_mem_fail_oob(struct __sk_buff *skb)
 	return ret;
 }
 
+SEC("?tc")
+int kfunc_call_test_get_mem_fail_zero_size(struct __sk_buff *skb)
+{
+	struct prog_test_ref_kfunc *pt;
+	unsigned long s = 0;
+	int *p = NULL;
+	int ret = 0;
+
+	pt = bpf_kfunc_call_test_acquire(&s);
+	if (pt) {
+		/*
+		 * An explicit rdwr_buf_size of 0 gives R0 a zero-sized buffer,
+		 * so any access is out of bounds, hence -EACCES. Previously the
+		 * verifier treated a zero size as "no size argument" and sized
+		 * R0 after the pointed-to return type, wrongly allowing the read.
+		 */
+		p = bpf_kfunc_call_test_get_rdwr_mem(pt, 0);
+		if (p)
+			ret = p[0];
+		else
+			ret = -1;
+
+		bpf_kfunc_call_test_release(pt);
+	}
+	return ret;
+}
+
 SEC("?tc")
 int kfunc_call_test_get_mem_fail_oversized(struct __sk_buff *skb)
 {
-- 
2.52.0

