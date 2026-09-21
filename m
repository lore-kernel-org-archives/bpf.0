Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CA15665C
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 02:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958337; cv=none; b=Nek+rvMyfLEqAuLlD38/djEphZTmPpqthdcKmFQD104i3QFPpJNphOVm2XLHH5m7o18UwZjI5Xl0UzzU33Dq1dxbWtPspabDuFHTUu9mOa9VUGGQfJ+vCpnMSoGsN9IjX9TvjZlBKwArhFX7H+BuADhBJGyLEQGv6eDiP9FEaiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958337; c=relaxed/simple;
	bh=nPvtJHwLozcLnmZnJa5Oxp0QARJ0hbGYGFb3ZT4Alq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqRRtjufGX0qUupJmEAmEL3mRl0RYnG37imwxBo1lhp+0j6RTl/a/1ruNHma/Ixxx/xegSQ41jMbR1HZvgwzfSviPr6Vv736a1ExJbIEdnX5GX3khtogCKSaJbcxw5WLpvcciCzPuqNOOMGRPv44nEKFombkRCGLmf+uZ8Q33zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrOEL6PR; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrOEL6PR"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49fceb35b5cso6623905e9.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789958334; x=1790563134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HVTm4yQJlZYQep5rFFz6aYQ1W2ykBK/sTBKXInWRLoY=;
        b=BrOEL6PRoUJQCOoP4CHU9XoGJb+UznYrqdbem9VRAby+TGVx2CiAFf0DvCac7Wn8+9
         4j6eGLaxOWRev7CU3yKCOmyMLx2T91noCvDOWyd+nx+b/cHrNgp3myiYKkRf4LdvsfXR
         A1eSosKz+OkDkrQ01OFFud2SnSnWBxdzamoX/MmrjwGmchHHV/M9bx6sNqIcxltG+lxl
         GT27rVPqVDvp5y0lFRhu+7ibVs0kOAbxlvJ568cGRH8fdYOvCWVnuDXWS3QWuWA/4ZOf
         9euUKGyrWuFB9ndgyW4tuGm4DrR2xOyiOmHMe0/Q/Qba6Has4cZIqwbMncI6Im/CMKMT
         TzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958334; x=1790563134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HVTm4yQJlZYQep5rFFz6aYQ1W2ykBK/sTBKXInWRLoY=;
        b=NjAINWMakAZrV7eit7s6DCNRfSovOsCk+c6U2QjAzbUiqpfFHullG8D0O1K585KKax
         n4hOJkh61tm66mj4+U1tbaj76eizP+ffBM/9oIxYoTc/fEj69gggivTE9Fdiq/opgOv3
         pJELfzLdw1jyash0x79VSL9J/xO1Lv02Vb73Y0my26Z6aUl71jAt3irFQGaGH8/Qfpbe
         sNvzBt9rsgPSFBgG0a7+0XBi16bhU+Ls+99FWwHK1oC/vyIY6Wn93tIxeFojMIKXT1kj
         kV/cFKBtfUPZ4NwzEuzlUwEzpcuRCsS1ebC67J3ojmnCz2879csgF6v/oLKS1JtXdIiP
         jIGg==
X-Gm-Message-State: AFuF++nFlmy6r5MqizzNyASZj81IARlFuWHZ95o6OofxCWkmFpEnplTR
	wE/f1ua72MTV/pAQKakYs0ybu5qyDnlonHVZcRu5vmuaFLu6h5ox15QR9ieZgYGM
X-Gm-Gg: AYBFou2AK3Ze2ZlAhXl4Cs+L7/DaDXhsjs1lW/JyjWvObTEdfInQtWIF/YbLyGikMQY
	8POmzYCVGxb2iG+nxVtIy23abKrp6mw3xbnV390pSAqVC32oOLuzgxdpU3oabezub4hde73FSmS
	St0aZEe6OYni7bt307SZJWY8uZIszC2bVYRfJZ43SeLOT0rdE+o7uV/AwZTJuGDUJT3ExxRBVG8
	yc+lMQIljAfyi/+2VpSH1aXachHyml08UsRmj0TzXonNN1uvLBJBzTgkCW8xAtS9BHBID40KOo3
	uxrS7quirFJ1O9lqtaPbBwpmQoM7Vgc3x57PusSPwcz8P7D0TH6kT1d5+LP6ZevrtHm45dOyzEp
	KRuN/yXIF4KBPY9nHa/Hc/p1xPhNSlhd+s/U/Cw5Oisn2XRbr3TnaYF95RRWO4G3FmOhcu8Bc3m
	UGHHue2NW2etOjU5hsJK3+WeJCWSYFgsc7aLrXx0QDkkygS8MKqBF7xdLD3iSd3gXGui11tVoWk
	wvfsvwjmu9ZUkyfO9aAcrZrE1NMIKQAtk7vAuHh6mJ8V48hcHPbxWKe229DTIK/oEwO3bAgiJEI
	bwv3Cfs6sGmqX8OMc/ov1iYnvmVNBuGpjlsnkf3zMOsIYm7o
X-Received: by 2002:a05:600c:3b05:b0:49c:fa21:e746 with SMTP id 5b1f17b1804b1-49fc57570c8mr116771935e9.28.1789958333877;
        Sun, 20 Sep 2026 19:38:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd068059sm200173495e9.5.2026.09.20.19.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:38:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 05/11] selftests/bpf: Cover generic __uninit output initialization
Date: Mon, 21 Sep 2026 04:38:29 +0200
Message-ID: <20260921023843.411943-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921023843.411943-1-memxor@gmail.com>
References: <20260921023843.411943-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7824; i=memxor@gmail.com; h=from:subject; bh=nPvtJHwLozcLnmZnJa5Oxp0QARJ0hbGYGFb3ZT4Alq0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvD9M2ej+fxuq0uXjQtwkLi+58lLFG54nujvh4McFi78 f+veaJlHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZhIkBnD/7IEqQnBYdaLZj45 oeC/8Ull0MF1ZxfsUWi9vLuBf8GWRCVGhhdX3qy22c5088zjlRy/DJ/+YnFhC43et3ZXLOOukgN GYdwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise the struct and sized-buffer cases where stack liveness poisons an
output before a kfunc call. Check that the verifier accepts these outputs
and that the kfunc initializes the memory read after the call.

Verify that an uninitialized input aliasing an output is still rejected
without CAP_PERFMON or CAP_SYS_ADMIN. Include an initialized alias as a
positive control, using an int-width store so its value is independent of
endianness.

Use __prepare_priv to resolve the test module's BTF before dropping to
CAP_BPF and CAP_NET_ADMIN for program loading. Keep multiple-output and
argument-slot coverage separate from these immediate regression tests.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_kfunc_uninit.c         | 100 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  25 +++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   3 +
 4 files changed, 130 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 973bbeda9318..ffeba2d1464a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -56,6 +56,7 @@
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_jit_convergence.skel.h"
 #include "verifier_kfunc_packet_access.skel.h"
+#include "verifier_kfunc_uninit.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_ldsx.skel.h"
 #include "verifier_leak_ptr.skel.h"
@@ -223,6 +224,7 @@ void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
 void test_verifier_kfunc_packet_access(void)  { RUN_TESTS(verifier_kfunc_packet_access); }
+void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc_uninit); }
 void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
new file mode 100644
index 000000000000..f7818303e703
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+/* Keep the kfunc BTF records used by the inline assembly. */
+void __kfunc_btf_root(void)
+{
+	asm volatile ("" :
+		: "r"(&bpf_kfunc_test_uninit_struct),
+		  "r"(&bpf_kfunc_test_uninit_mem),
+		  "r"(&bpf_kfunc_test_uninit_alias));
+}
+
+SEC("tc")
+__success __retval(10)
+__flag(BPF_F_TEST_STATE_FREQ)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void struct_poisoned_at_checkpoint(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 16) = 0;"
+		"*(u64 *)(r10 - 8) = 0;"
+		"goto +0;"
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_kfunc_test_uninit_struct];"
+		"r0 = *(u32 *)(r10 - 16);"
+		"r1 = *(u32 *)(r10 - 12);"
+		"r0 += r1;"
+		"r1 = *(u32 *)(r10 - 8);"
+		"r0 += r1;"
+		"r1 = *(u32 *)(r10 - 4);"
+		"r0 += r1;"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_struct) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(0x2a2a2a2a)
+__flag(BPF_F_TEST_STATE_FREQ)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void sized_buffer_poisoned_at_checkpoint(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 8) = 0;"
+		"goto +0;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 8;"
+		"call %[bpf_kfunc_test_uninit_mem];"
+		"r0 = *(u32 *)(r10 - 8);"
+		"r1 = *(u32 *)(r10 - 4);"
+		"if r0 == r1 goto +1;"
+		"r0 = 0;"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_mem) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(7)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void initialized_input_alias(void)
+{
+	asm volatile (
+		"*(u32 *)(r10 - 8) = 7;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = r1;"
+		"call %[bpf_kfunc_test_uninit_alias];"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_alias) : __clobber_all);
+}
+
+SEC("tc")
+__success
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__failure_unpriv __msg_unpriv("invalid read from stack")
+__naked void uninitialized_input_alias(void)
+{
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = r1;"
+		"call %[bpf_kfunc_test_uninit_alias];"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_alias) : __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index fd2c0cdc91b1..542edeb28b27 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -17,6 +17,7 @@
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <linux/un.h>
+#include <linux/unaligned.h>
 #include <linux/filter.h>
 #include <linux/rcupdate_trace.h>
 #include <net/sock.h>
@@ -1316,6 +1317,27 @@ __bpf_kfunc void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p)
 {
 }
 
+__bpf_kfunc void bpf_kfunc_test_uninit_struct(struct prog_test_pass1 *out__uninit)
+{
+	out__uninit->x0 = 1;
+	out__uninit->x1 = 2;
+	out__uninit->x2 = 3;
+	out__uninit->x3 = 4;
+}
+
+__bpf_kfunc void bpf_kfunc_test_uninit_mem(void *out__uninit, u32 out__sz)
+{
+	memset(out__uninit, 0x2a, out__sz);
+}
+
+__bpf_kfunc int bpf_kfunc_test_uninit_alias(int *out__uninit, const int *in)
+{
+	int value = get_unaligned(in);
+
+	put_unaligned(42, out__uninit);
+	return value;
+}
+
 __bpf_kfunc void bpf_kfunc_call_test_fail1(struct prog_test_fail1 *p)
 {
 }
@@ -1747,6 +1769,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_int_mem_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass_ctx)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_struct)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_mem)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_alias)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index d3696d5254c9..91b64e783123 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -289,6 +289,9 @@ __u64 bpf_kfunc_call_stack_arg_big(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
 void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb) __ksym;
 void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
 void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
+void bpf_kfunc_test_uninit_struct(struct prog_test_pass1 *out__uninit) __ksym;
+void bpf_kfunc_test_uninit_mem(void *out__uninit, __u32 out__sz) __ksym;
+int bpf_kfunc_test_uninit_alias(int *out__uninit, const int *in) __ksym;
 void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
 
 void bpf_kfunc_call_test_destructive(void) __ksym;
-- 
2.53.0

