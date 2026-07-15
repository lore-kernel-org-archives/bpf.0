Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30A43BCD01
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784152867; cv=none; b=VHtraBljpumDeYL/5wNKE5GErMtnns8er3rd7yyrrCHyAlWzYpYzABh4RvGQcIyhy36E8KNhwkVW1sgw9vUNS04TyiNqo2qK5yq81CrwoVMJOswOI7HgbMMnuy4hhzS7N2RJ7VlxDREOdt2aZsdFCC1pZRTG1+cJ0wT6KMYw+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784152867; c=relaxed/simple;
	bh=2pJh71fXz6UcwG+aVbaPEIV2mQWk95Psfsk2S2WpLu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpCROvbw1cGlBUlf6UqIcshh7h0kNFD0Y5FrjBgIavQqkNJKWkY9+L8yiHAl4fc9m69FKcB6Un5gf7fojVY5yt8Js+qoSQKH5GFBOoZQJlbiu4PqMt7b5bUqM8x8QenPAioQb11EXtkOCMb2obWFZIQyUg8V/IBLgakBMqSgu3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWQRyze5; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWQRyze5"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49541f698b8so520135e9.1
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 15:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784152864; x=1784757664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZmHGkM2Gi5ZYULmCI+f6CT0f33RPzzTxbkYtXWfOdhc=;
        b=kWQRyze5Tfbc7FttsP/jlicZ0mZUjFq27sF6GAUXrEJr8rpTt4QHE1aqONoA7EQWtg
         xBzPCH1UW6agWle5OgHNI7r0IaeBLNSEnZYslM5aM1gSQgVieEZzymw/87tADjZHMcCW
         zBZScaaJZZMOSz+z3KGNxuU7hGVQ8KB7UU4ObZ8PMQ84ZjADGs2ToQpeBhF1BDLmmkcg
         OXxKu3GNpO0RPkAkCuPKZQbxwKWbSIJ1EJiWEws36L9CARbEyZlrv5CtEUbLnRj5ifiq
         7PsdBdSLYecJpNiMj0cg38cHWO3ZPoGQ7qhFrMN+T33SMRnNWL1bIPuObYnmxigezg0O
         JmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784152864; x=1784757664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZmHGkM2Gi5ZYULmCI+f6CT0f33RPzzTxbkYtXWfOdhc=;
        b=e15alZsxzPV1mOocT2b1n819J7F+SDVQ2NhdZHGN7n8YXdRmOmg2GJjGr8XcknoKaj
         2NYhQ41rFZd2kDqrbhlYPYMiWYP6C1Tm3Uf4q6h7cPuKVMWODppvLQdSbi3welTRY2U5
         Rcki/gBYvIIKnTQeuuf/Gf4eImJ1bM8vQf9Jf1hlN3WgoNsFvH4fJ8crHkSw0uwbtDkH
         vSdlFmZf4FBJssyHnerLjMGnYIieyHcV9pL1a3mDDH0X9OFWn4DRsw50Hjd4gD8Easph
         cceuIOYbNZlbUTA1Wv94HA2mB7Jt9YjDoVbbeh3Fd+O0vxgbBbeW6mdEsqBIyEzVVh1t
         6u6g==
X-Gm-Message-State: AOJu0Yx28XKBxhhBqol1RZbhNia93Xo2Mh/BIfys65SGzTnF1iIzlort
	eyftjkid9uQWUfkt7DEozHSF+L2F34obtORULJlm5BX4asKWddomP3ftfL6umvNh
X-Gm-Gg: AfdE7cnRDeyUksGydzDIAJheaOvz4mpVqTOd8dOYTMC1w7BVRR3GDg1emFTMITIH1kV
	VfO2AcyC14A84JlxngGVrJgj3w4cVVnKYgk2RYqdQQ3EtL3L9N4ZID3qglT6gXSXpPldl8RYOmk
	sgBAM3C6EEPATgi9nCAxupDxGs6JSp3ptqMbmYgvD+4cRY7C6P/hvUNlQQKZn0wUBgTPwxw6MCP
	QLlW2ZGWiww7umlKdZ7Q68VNjKHcEg3n5GbdZfg679l9Zz0ZlZgy2TjLhiva5zzf52Y7kChGpim
	Lq1jg9k2bTFnRn82lTOcLXlSTmS9H+ehIjCpOHmyVivd/Kz1kiyBc4fYSKaJO/NlYVBgWB/v6Jc
	iRU3+xXLHSSkSUhMrUbaHXf9ajHy2Lpy1I9zpU6h4Dm4WqkzZK+DBQPHHjlfh2F4WSesgC53BqX
	B/I7Ufm5nZUZhEXEmupmTGnu9k4J9l/GJtcUHR1QOBADQ20Rif5aV25l8q0CXjVISILH6peUvuQ
	a3hNJS23mHDBrv+UiCHXtQ5aG1GXkFTO1hSPntek4aK1fETyXqV8W0=
X-Received: by 2002:a05:600c:1d16:b0:495:3b2f:df04 with SMTP id 5b1f17b1804b1-4953b2fe00emr57043255e9.34.1784152863756;
        Wed, 15 Jul 2026 15:01:03 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96fdsm19729242f8f.24.2026.07.15.15.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:01:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 9/9] selftests/bpf: Test stack-passed struct_ops arena arguments
Date: Thu, 16 Jul 2026 00:00:49 +0200
Message-ID: <20260715220052.1590783-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715220052.1590783-1-memxor@gmail.com>
References: <20260715220052.1590783-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5274; i=memxor@gmail.com; h=from:subject; bh=JIS7Wfhf3S5X7uvk7woORlEYAnTLNCOfmOHRGpyTbWs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuC6W7WtfVMNbcy+1h2605/EGzKprSn5tGTed8WK4c4n j3/UHBbRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbydBPD/5gmg6jM5fHTas3f J3pt8X/63E1D8sHiumvpL7dk6G+6uIKR4YdK0/QLRf1iL+KkhMwsWKTvbXUKzRN6fOF5CuPr/e9 quQE=
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
index 48ce36a6b82f..9e268fd69a93 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -380,11 +380,19 @@ static int bpf_testmod_ops3__test_arena_nullable(u64 *ptr__arena_nullable)
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
@@ -413,6 +421,11 @@ __bpf_kfunc int bpf_testmod_ops3_call_test_arena_nullable(u64 *ptr__arena_nullab
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
@@ -819,6 +832,7 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
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

