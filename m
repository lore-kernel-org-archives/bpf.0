Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80A3BCD20
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535319; cv=none; b=tkzJE89zBzqd+fq68sBHNmKvRTbbkfR94ulGFO6WD+ghTRp2Iz9v0sTKkmfpeDKVvlo5eJb1Kmlp0HXkQeIqCJknHqMmtXx/HUF8F/sUg+Qu2kd2cCYmiHM7Wm1fyxenOc5iCakm/Q7+vcjkiX3/GOCkd555UIZ9/O8X8ToKNcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535319; c=relaxed/simple;
	bh=v9l7tVvrVmZba6RbmYUyb8MQTP/pDEanXcjNhFrjUxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5QUFTj1jK8gcEavf0vtRPqjP+60MIaCEEXRJ1Ge26UIYYk/nFDpllcxYoFg6+19c2xQlBvVvrpbqQQq9ET0aRk1xnbh2+zFedb2pJZxvCcmcsCsLVLiiiWn96J0TUKNrqjRXex4d6o2eA+8ztBvpCTjIhhlsFFRo1tWrWG1LLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=jJw1dPLh; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="jJw1dPLh"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so366219a91.3
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535317; x=1790140117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wuJ2qCnS/wmK7OW9fsN5CCesdI0U+o2AEkrSo+G4ms=;
        b=jJw1dPLhJSnuG9Gh1vMwSr+ktNh7SQLON6ojgVMcpCAHSstTny8Q8VVrv3Yqbq9ILg
         tyxC9mn7wfhPfjcF3YlK9PMq1i0hvDTyplpvXByRhtWXYKWMPmK23R4RlkRgwWSG/bdq
         MMf+OesyLBaFdcCwnAhdwwZBNJiAraaT8L6+gWBbEEhxVNeRHfkMmB4hR5pneHdLUPqZ
         zgOtivJ4LO2LZdPfnx3y2tZ8rGIVWxaUOtgGGGtymdTTacBEuRF9jwLnXzgcHYQksc6u
         ALn2wZhYXvvCJt6wKZP1JWLdvhn06ONjRvEkCztf2Sm0JKwguxmraXi14Dt5PVE1mPDZ
         mZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535317; x=1790140117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wuJ2qCnS/wmK7OW9fsN5CCesdI0U+o2AEkrSo+G4ms=;
        b=0O3sXMHF8EqBKJ46UQiNZ1iE3cZ/MThckR8nbu2uLJpNaHkrwDnSCNCnCDb4u2adIx
         nqi0DOSNcW2IK+RcD4WGlTM08xUysBNQiLw6U/HcEqkGOAMTvGkamqWaffHfYrZoz4Ck
         bgEhIacRUEiOXxkhMkknjWkSXPtAi8Bx3VKL8IqQ7sZ3FLkZjDbnfEYfF35BZr7ITZQj
         3aFpKLOl7Eri4Y3KN2gjGv1KJUVnv0zq9Zqs/gzOEhuhoVxkXhH0p17ohPrxOLUngJBE
         29PmFYwYURVOE+KMgWfK8ho3IVZB2nNzPduNFI9HA/OPSWfzIRxxZBo5AdJKCTfQRBCI
         Kd4Q==
X-Gm-Message-State: AFuF++myB9up+Mf/AEBsfpnMyDUfhNYRsAPToGTqZ6ursUlpeLhya9yy
	6KYg3ywpuJVQNV9GdtLDE9kUoKhDflSJ3qSsZhcm0YgFpw2X+i2tw1+IFOHFryc6tFI/3gRsBCM
	XxRRxrXM=
X-Gm-Gg: AYBFou3hW3OZyqu6DVvdRyN3oYP9rLw6Zf4P5ppsp9Pnv5SxpOlTkiEMMp2iY0dyPZ+
	DPF6RLAcIn/+/cdRFK7IsSSb2DWcEnQvkSFnRjUI9SFRna77J7GjnZ0ZJ+HYExa5R1B3L7y5pWg
	ojvJ2OCu7yEhbID20uxlVQDW5ohRdbVcphwNORclgt7BhVgy9SA3tLDpOPWVFsx3unRlhyjll6v
	8+lSSF7uWuCiJ0uoQuwLS13zpw6k0HAxUSYfhzil3OqtwkJA0XEnCXfS66JUc/f9ya60YZcSOIV
	k9r+c7Q1zMiCwl8SIFJR/vHjHcqlJs0aWWfC2t841TGElVtg7IW65/S0zTB1V/kXbrvLqGNXhqE
	ZNU7rLQliRfLwR6C2Sk8LUWUvmxI6BoxXXZ9k7H2Nr7aSaLrsjNIrAwi3UnT9uANg/Iw66sRhWz
	e2kjPodIzOL9Q+G5/jWidVp0CCbPrEWBFavU+TdX23CGfLsObJEB1HSMaF4shHuAwgXJR7QkBrG
	iBVaxcoopnhVfhDV3Hnf0DeuX/P3SSEvOWxDnv6NoJwuSHbAA==
X-Received: by 2002:a17:90b:3c91:b0:39e:1310:cb36 with SMTP id 98e67ed59e1d1-39e1e5110e4mr2908224a91.20.1789535317119;
        Tue, 15 Sep 2026 22:08:37 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:36 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 02/11] selftests/bpf: Test dynptr slices past end of skb
Date: Wed, 16 Sep 2026 05:08:20 +0000
Message-ID: <20260916050830.8774-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916050830.8774-1-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to ensure dynptr slices cannot include
past the end of the linear area of an skb.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c | 10 ++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 20 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 5fda11590..439656036 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -9,6 +9,7 @@
 enum test_setup_type {
 	SETUP_SYSCALL_SLEEP,
 	SETUP_SKB_PROG,
+	SETUP_SKB_PROG_NONLINEAR,
 	SETUP_SKB_PROG_TP,
 	SETUP_XDP_PROG,
 };
@@ -32,6 +33,7 @@ static struct {
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_slice_non_linear", SETUP_SKB_PROG_NONLINEAR},
 	{"test_dynptr_skb_meta_data", SETUP_SKB_PROG},
 	{"test_dynptr_skb_meta_flags", SETUP_SKB_PROG},
 	{"test_adjust", SETUP_SYSCALL_SLEEP},
@@ -94,7 +96,9 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 		bpf_link__destroy(link);
 		break;
 	case SETUP_SKB_PROG:
+	case SETUP_SKB_PROG_NONLINEAR:
 	{
+		struct __sk_buff ctx = {};
 		int prog_fd;
 		char buf[64];
 
@@ -106,6 +110,12 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 			    .repeat = 1,
 		);
 
+		if (setup_type == SETUP_SKB_PROG_NONLINEAR) {
+			ctx.data_end = ETH_HLEN + sizeof(struct iphdr);
+			topts.ctx_in = &ctx;
+			topts.ctx_size_in = sizeof(ctx);
+		}
+
 		prog_fd = bpf_program__fd(prog);
 		if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
 			goto cleanup;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index e0745b6e4..b668ebd61 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -10,6 +10,7 @@
 #include "errno.h"
 
 #define PAGE_SIZE_64K 65536
+#define TEST_SKB_LINEAR_SIZE (sizeof(struct ethhdr) + sizeof(struct iphdr))
 
 char _license[] SEC("license") = "GPL";
 
@@ -211,6 +212,25 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
 	return 1;
 }
 
+SEC("?tc")
+int test_dynptr_skb_slice_non_linear(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	void *data;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* Ensure we cannot read past the end of the buffer. */
+	data = bpf_dynptr_slice(&ptr, TEST_SKB_LINEAR_SIZE + 1, NULL, 1);
+	if (data)
+		err = 2;
+
+	return 1;
+}
+
 SEC("?tc")
 int test_dynptr_skb_meta_data(struct __sk_buff *skb)
 {
-- 
2.54.0

