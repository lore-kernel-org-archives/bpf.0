Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702C31F991
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761490; cv=none; b=k9l7bwgWuLUnJBKQAkE8Lt6ctGT8c2zqFsvekI88O+f2f8MP+3fzIxwlCv0+4VH/ndlsqJNKBKDsGBoqCoXxMUf0LxiZDEQUUV9mXbG0/19B5jzcJYlM6BMTfk5s4j9CuUdzxY7HPqX8LLoof67fPhCn5KHgOoI86HatHXP9oLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761490; c=relaxed/simple;
	bh=ZKuVkri5y1gnACou6yAeOPakhVIsGxzkUe1o4Eymg9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmCTgGL1xx0oskSN3B3ZsLh+g9JmurIVfzG+F8LPmKQNCuAtGs9TFVpqBQhWU+QsiQKdjrSIlhJLoVmz6WQcB8j6OQV/rjlL7OuuzmKlIIDll/DvlJwyGg2jEl1eWOMekabVVvo182tXDlctZZrPWO1dIRaEnYonXV3cbCAKALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpVX9RLj; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpVX9RLj"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so8053555e9.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761487; x=1786366287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7NAilbKnTEbglVGic9CUTi553FNy2f1/oh88d+EVBB0=;
        b=KpVX9RLjx8XCRYM8TAyPFWOKeTTR7qj9vtIcFvI4TM+/9bIhNDOeIMR0vPatdjon5L
         pC6rdH1qe/WfjC8//YbQh/w8jkZIUSADtyO/8WaKqAMz9Bn6VwXONIoouCftTOkLpSEH
         Rd/JjosS+sOkdDoZnfWrOF/Ve73NpHHP9hezX34lO5vbaUi34Y6y70B94Hhm3jAr34I6
         uPfkkUGOZhtZfQ2nb4gbsItTlJf5VAQUhi+bgzoV5J102ofl8TtjHL0tSCpRqH3MNOJ5
         BUWTaBA58UeEN7Id7UIVQmlcJzndjJT1xxuWtcYh4moRIZGcB1/w4/1ykyXeR04rIThg
         JoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761487; x=1786366287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7NAilbKnTEbglVGic9CUTi553FNy2f1/oh88d+EVBB0=;
        b=kr5Db0Qr3+2PZoADvSA7raN6G+qFRwYX72oGqPENxh8J38LDBQZaY8RxHfKvuY2MX0
         YFu6cyPtIqFBK5OLxrgXi2HRKzAKq7X5OrDNNraIuEL4AX0ructJVtpqvHGZFvLXR5h1
         wsf9PUajHZ5lfeBKV2Us1oL0qca8dEHNaKfppP4qqv7ZrRdPfQMLfBPCXckH99uCdLRz
         KdAjtu8aYyaX0CE/xTh4SGnSOh0SKxLXFerRG2qPXS0QHqFW/KxaEUQIXdALlexY/DAa
         q+iFfDA/Nl/yp7YtN2vLcJ6gwAn4qt2oWqosLmXNplgP3lZ9CK6J+y2LWn0tE5v1gjHD
         AFdA==
X-Gm-Message-State: AOJu0YyrnfYY/5mUwhAa2fWB3KqDvaesh/Q9lEZjLLfQRiICYWjCTjPr
	dx7nS1fB70wzRJ088rBTnqhweqKEj1NW+piFKSX7NJm6ZlUuMm+T9oFebB0UOzxA
X-Gm-Gg: AR+sD119jZWFL3U62sVrR2BNLaH+hFqahOHMVdS0662hXn3jC6O9tvEK2PnGbWXRYak
	hKG/lSkabEY2mDYGVixpbOHjeUPF0ZiBZTkVftw2K/5lQa0NK9WDb3Fo502bUfqhhSy2T7j063H
	x9KUuP2sk4liZc8JJop+NE5X8129+0zTUxhbAq6elzjyfTFIj3Zzr9gMhl4ECLZTyZ2zmlkD7A/
	L6ifWhVD45vhUS2SdQT+OOpK7494qxoaihvY/U5MCmQxthJsIeDBJszaYE5HTOYhOw/fq3Ngmfu
	2ggJqNSBg3R9wbmHMon2J8BplHhExMIIUZ2V1Y3h2heKl33hlHeUE1sWJ2YBvC1Ts38D1x3CpP1
	KUM6uhWvRjezawPAhLoz9EMjrqMJft6d1w1UC1Bfxx6yWqgcWsZdn7hhnzbO2Hq+Q6GCIcOtVkf
	91SP9aQ0kgn08M/TVPyRYzuZT2fEJplCcUe2v8v9v4KKDCuURrJNR/zHoDMXCTeSzBz1lm39EbK
	gb/6DJcnsi4MZkdBcOVh02/DMPRrCn4DuYwYhJJTr++RvH2uI42RkN8VczkrFkQ3mRtJ2jXO9Mg
	710gU8IvlYX04F9eX0iOCWpCPlXv
X-Received: by 2002:a05:600c:8b14:b0:493:c845:bc20 with SMTP id 5b1f17b1804b1-4980c66c94bmr230511435e9.4.1785761487066;
        Mon, 03 Aug 2026 05:51:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dd0asm225271355e9.14.2026.08.03.05.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:51:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 9/9] selftests/bpf: Test stack-passed struct_ops arena arguments
Date: Mon,  3 Aug 2026 14:51:10 +0200
Message-ID: <20260803125115.2264733-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803125115.2264733-1-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5274; i=memxor@gmail.com; h=from:subject; bh=8/YL+acujJDuMagqoqUQiDsXx8MGvbXjSCOyatpG9zA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIaugb4tgsdSqs2/aNc4f0LI32+ITXt9urVfyftIinknxP FdKOLZ1lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLszowMt6ptGO7W3WPIqds/ tyvYcUrHzqn795t/ZcqIaJij/uDsZIY/fGusE38cXNguFrb9zMKbDpEzjhpsqxbYwrriw62pezW XsAIA
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
index 396e5b467855..fdeaa56356b5 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -407,11 +407,19 @@ static int bpf_testmod_ops3__test_arena_nullable(u64 *ptr__arena_nullable)
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
@@ -440,6 +448,11 @@ __bpf_kfunc int bpf_testmod_ops3_call_test_arena_nullable(u64 *ptr__arena_nullab
 	return st_ops3->test_arena_nullable(ptr__arena_nullable);
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
index ff0d3894d7af..1a72d0fda53c 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -123,6 +123,7 @@ u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
 void bpf_testmod_test_mod_kfunc(int i) __ksym;
 int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_arena_nullable(__u64 *ptr__arena_nullable) __ksym;
+int bpf_testmod_ops3_call_test_arena_stack(__u64 *ptr__arena) __ksym;
 
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
-- 
2.53.0

