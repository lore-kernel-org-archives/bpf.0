Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716FB47CA76
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963885; cv=none; b=sbXgd7kRSn1rdn9FpThXcf1k9ZG9cRZgE+ymZXKJ5kJ8WYWrjZeqbhV7FBe4+fW4HhrjhiZi4M7aMmD3GnvJLx6fyjPRLSBa4MfquDetl4ycQr0d0jHPzldH+hZ00KY0fJ4Su6LN7ergfEeHzMAZiX37+SUhidUtG76+9dYYUxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963885; c=relaxed/simple;
	bh=yx0S6/ZP+SSfmF+uQS7nzDxqnpjKL4Ce/PiWEUCUI2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6tKM5hxZ0X37JWW6mqfeTAlVY0I8N2Bv9uZaEoZwZFAeE/vBs2skNpfhz+pLmLVIxxx5uqtsqIumG7o9Fxdf0j7wXeuzcEkyvbGNU9E/ao7f43RhumwKM99W0IXA0ND3dBGyRkVWiziEnJwY0PaOAPOdKRAuvag2mFeptZgCUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltACArJS; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltACArJS"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso4282075e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963882; x=1786568682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yo3K8ZMMe3hTPd/1Y7RkbZGt4f8cZ/qJNtDaCPos+LM=;
        b=ltACArJS862qxO4FJkZcsiiGPvTQiyN4dzAeJJ4VV+6ys6Gc3qTAsfaYjyfeS5J3Kv
         rwMBCXhImRTQadLnTqVpfMcPgujI057j/iqg8bwmhIyoxQaKv+5kYemQHuW/R35asozu
         QvmBHvrH/6OunJuwBNurfLLFRbDVL+NE/mVR5OfExv658016hJ5Acm2/HoZvqyKzhvM+
         tw8ih31iu2dIm6Fcj5NvEKvglE8IzHO1uzoy9/0ssPYPAi6p9+cIe9FBil+vsibcEYQx
         HlMoi4KkwqaFF1GeWJ2qIM4demFAFBQk6RHqOpvVnIWU7NCD4dKj1Xde5f9Th/9Fh/e2
         u/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963882; x=1786568682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yo3K8ZMMe3hTPd/1Y7RkbZGt4f8cZ/qJNtDaCPos+LM=;
        b=qAzaWdcE+548hTqtuj1b4WX6elfB35GOnYFnprMETor9Pq2gTrmFEpH3CgH8OWAYr/
         5+3DEDXHsJ9z3qByVu14pGVxX4Lbfj+sh3gCZGovjJ2XTttx1PoIQUHB7oj9qG5j55r6
         aj0/C4KjloFthfxi44uccvCOL+VMDDG7tJ89+j35E/QgWlJWvPwXNh3kMogDr4jlGhtT
         yVlWrgq0shfFH4K5/033e93uP2tS+c7A7wnkmrpG18bb7mCSiZE8GPAqUPXXrv9GAYa9
         weslL4h8NCpu80gpQgTHNiHB63RziOXgWj/u6Xg8p0Sx3oM748s9qBDccj7WXnEmtr4p
         N0og==
X-Gm-Message-State: AOJu0YyFCQT50gaq1jN7tbzzSHkhOxK2O1Ef8FOLGbLdFnRnDkZ5l3rY
	HEv2eMYtonVZ3/A3x/3iJJDxm3+y92XYSFLRCfnEXaFbKeabipSlgDUaIgKfRegV
X-Gm-Gg: AR+sD13ylH9RIi5TEgIN5CYi5xsQOBQelGnCiARZq/jGKkEoR0znkT7fVg/0sAnEAcM
	9uJyJv3cJWuik5I9f9n0BEYPKfQO3EMilR7JjgqG9VbUIIZb9JrU1gG2OnH1kt+lJJJjRbLncyl
	JfaCzAF2DuQ+1Wt1yeP1DkRu00UcWDhc/Fan2b7JluvdeIOsZ0CwQTpgK8b5m5RkRHrrAajfopv
	sQRReTC8r2wLqgUbGvDx6VlylQ8vjEYCC38Mhw+XEEBNErL9Rc5LWebAuM+SMiyqJNoQXWTRBWd
	UYeQ5Cjn7I2j9CtXJJB8o04tyxi9sV0+C1hI5y9JkFhYISUTEKEBAqZDgPXdgDbwg41LzkUKjWT
	u40v4LPYJ8ODavttYh6FI3r0JJeyYvZL52o7a5W3AYDnq3FEDSkVrxupxUZOZuWNHChOJgN4i97
	U7TI3+dxE71Ws8qgm/KSFuBnyt9mvp6cTRo7sa3Ue+yEefwShqTUe5Kln5qtNtdtf0z83D/Pfdf
	1wJOyzsDFBSc0+WNMTFsZzcc4Pxo/m266nZdaYQJBc2QzAjsJi2rc+VWRfICJQ1YPybx1pEV4Ic
	2fzfN7SLRxDuPtrjeshf/OLBzAk=
X-Received: by 2002:a05:600c:4e87:b0:495:573e:1c54 with SMTP id 5b1f17b1804b1-4994e7c1122mr110279365e9.9.1785963881564;
        Wed, 05 Aug 2026 14:04:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b183b2sm263937f8f.24.2026.08.05.14.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:41 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 12/13] selftests/bpf: Test stack-passed struct_ops arena arguments
Date: Wed,  5 Aug 2026 23:04:23 +0200
Message-ID: <20260805210427.3218326-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805210427.3218326-1-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5326; i=memxor@gmail.com; h=from:subject; bh=vTF9Aav75mjvlQMcde7zsXvBg7rM605VCBQb9EIF6pY=; b=kA0DAAoWRy03e2NUL4MByyZiAGpzopbIydVE7k2vxE0zhx86W2DU3/DoweBldyxsvn0JCJtz0 Yh1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmpzopYACgkQRy03e2NUL4OWsAEAvvad SGO3DNOtSTkcbsKWi+bT1HUVAEnGznVLBt/ap9ABAKV6AhCzhRLNWNofbQ8bBV5IK1C7/Tl4Zk2 5Vx9a2c4P
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Add a test_arena_stack member with eight leading scalar arguments so the
arena pointer is passed on the stack.

The callback validates the first and last scalar ctx slots before
dereferencing the pointer in ctx[8]. This exercises the indirect
trampoline stack layout and arena conversion together, and prevents a
regression where stack arguments are read one slot late.

Signed-off-by: Tejun Heo <tj@kernel.org>
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/struct_ops_arena.c    | 21 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 14 +++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  3 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 4 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena.c b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
index 40c856a748d2..ba04c73d8d96 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
@@ -46,10 +46,24 @@ int test_arena_nullable_cb(unsigned long long *ctx)
 	return 0;
 }
 
+SEC("struct_ops/test_arena_stack")
+int test_arena_stack_cb(unsigned long long *ctx)
+{
+	u64 __arena *ptr = (u64 __arena *)ctx[8];
+
+	arena_touch++;
+	/* pin the slot layout: the leading args fill ctx[0]..ctx[7] */
+	if (ctx[0] != 1 || ctx[7] != 8)
+		return 0xbad;
+	*ptr += 1;
+	return 0;
+}
+
 SEC(".struct_ops.link")
 struct bpf_testmod_ops3 testmod_arena = {
 	.test_arena = (void *)test_arena_cb,
 	.test_arena_nullable = (void *)test_arena_nullable_cb,
+	.test_arena_stack = (void *)test_arena_stack_cb,
 };
 
 SEC("syscall")
@@ -88,6 +102,13 @@ int trigger(void *ctx)
 	if (ret != 0xbee)
 		return 7;
 
+	/* the arena pointer is stack-passed into the trampoline here */
+	ret = bpf_testmod_ops3_call_test_arena_stack((u64 *)val);
+	if (ret)
+		return 8;
+	if (*val != 44)
+		return 9;
+
 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
 #endif
 	return 0;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 64ca43744c59..2963c29f96ba 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -407,11 +407,19 @@ static int bpf_testmod_ops3__test_arena_nullable(u64 *ptr__arena__nullable)
 	return 0;
 }
 
+static int bpf_testmod_ops3__test_arena_stack(u64 a, u64 b, u64 c, u64 d,
+					      u64 e, u64 f, u64 g, u64 h,
+					      u64 *ptr__arena)
+{
+	return 0;
+}
+
 static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_1 = bpf_testmod_test_3,
 	.test_2 = bpf_testmod_test_4,
 	.test_arena = bpf_testmod_ops3__test_arena,
 	.test_arena_nullable = bpf_testmod_ops3__test_arena_nullable,
+	.test_arena_stack = bpf_testmod_ops3__test_arena_stack,
 };
 
 static void bpf_testmod_test_struct_ops3(void)
@@ -440,6 +448,11 @@ __bpf_kfunc int bpf_testmod_ops3_call_test_arena_nullable(u64 *ptr__arena__nulla
 	return st_ops3->test_arena_nullable(ptr__arena__nullable);
 }
 
+__bpf_kfunc int bpf_testmod_ops3_call_test_arena_stack(u64 *ptr__arena)
+{
+	return st_ops3->test_arena_stack(1, 2, 3, 4, 5, 6, 7, 8, ptr__arena);
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -851,6 +864,7 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_2)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_nullable)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_stack)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index c367ec856776..33f2af5b7085 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -109,6 +109,9 @@ struct bpf_testmod_ops3 {
 	/* Used to test arena pointer arguments. */
 	int (*test_arena)(u64 *ptr);
 	int (*test_arena_nullable)(u64 *ptr);
+	/* enough leading args to force @ptr onto the stack on x86 and arm64 */
+	int (*test_arena_stack)(u64 a, u64 b, u64 c, u64 d, u64 e, u64 f,
+				u64 g, u64 h, u64 *ptr);
 };
 
 struct st_ops_args {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index a5b6b5db0dd5..dc7c40bd1299 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -123,6 +123,7 @@ u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
 void bpf_testmod_test_mod_kfunc(int i) __ksym;
 int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_arena_nullable(__u64 *ptr__arena__nullable) __ksym;
+int bpf_testmod_ops3_call_test_arena_stack(__u64 *ptr__arena) __ksym;
 
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
-- 
2.53.0

