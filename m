Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96744334CD
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355341; cv=none; b=ROyLPmCkcw9RRyFAlyJAFeH5ORMmfhdktjqS2JVmy6AbG4yefjaeegsNkKId81dOhYVBXNl9rTWLGvq1QScqV6+vN7KLY6iXHbT+ujvITMauyYHiWgDgKSVek/8rFruD7ZRirvICxt7Dqit/f99FqKbHK4+9wF2SIJ0qSwTCL80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355341; c=relaxed/simple;
	bh=UP8UarlaPbJGGDqPfkB4z8Px7M3mX78s0gbVSTi+R8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVOq3+JR7iYBjr04cAyJ1wN46wba/220o45FZA1nhtFmi6SlbW9d5/eq3KHqCCQwZ7uN3B25ooUSkcZHGor0Lg/yzwZP5CyR/ZLUY7jus97G1NnaFm0JaIGjtvvDzu35O1sOLiu8LUJu8oGr8vVfi2dbU2HJ+h3qvIyfwN6cZ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpfHMnhq; arc=none smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpfHMnhq"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c1971f5efc3so89591766b.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355338; x=1787960138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I8DyRfH94//e75LObyCeiGduB5kIujTF3txe+GLd9/A=;
        b=BpfHMnhqYbrEjh8KYbEof7WVJg1Xhys0Xfr7SjrRlFALQLjPLAQJg5IdLZx08GcWAw
         zOExXnXFP67lJ2XGz1QRYuXgZWeO7tS2tjeBdLXwp+Q8FI3BCqEYQvt1NLm/vWK8O2lJ
         izKHv+BKSnIkrFLXHPq0WQmIwrCkVt1pYfiC3vtnfWjy0PF2wGVY7esPF0oxe1zyRTa8
         XDhQDattRqnAw8PNmzgPJdQjD14v7wwZpwHD33INAamsoFyA8tgBcBLr9arzeUfS4WvQ
         j2Qu+NrcjjYhVqQTPzdTyAELSlNDLe7MJP5Jv/cYvbpHLoUGwf1ioFtxBgK/Y3/kLeJj
         uaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355338; x=1787960138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I8DyRfH94//e75LObyCeiGduB5kIujTF3txe+GLd9/A=;
        b=DVAQO5AbfLUtE8NPZ3SgFcLleSb4pUMfkXdFB5X/IW1ybNdpKnhS3TS0RCG7+9hmRT
         6WjzLzrx+v5ioSSeQZTbx2AbcsJZslbTE7xY4OCzJ3UCyh1yH1lqKsGwHym2fownBgMk
         6BvSjBLlTiih7Zj6zFSOphx6zOClhkmbX0lA++FFG81ykyIL4hUW42GXpfPy0DQ/CcHy
         xoFiyUwjeyJ0wjrvFm5K5tJucE4rKm7HieL9k7R4MRrJpx4/ZqQJZIhYEMo2185vz4Jh
         A+0vmsVh5ah77qkMXUQtPQYEnYks/XKIffyAPsNyyHMT1LYUPxLZk97IW03YRMpqmjtJ
         m8Gw==
X-Gm-Message-State: AFuF++mpzeYDPtTqazUFgC4LVO3QS7KJscmRNxMmgPNqk6sL9SWPUH54
	VaL15BGGFJNc3DGgXqCeCcBiWmBzrZ8XiZAh9DasH7kwMH3U99f1B9EodclMEVBD
X-Gm-Gg: AR+sD121oL1MemsMEgxeTre3obO/x4rFnA27I9psWxfL0liU4tmfTmsEm1qrmrSwgsK
	69F18O77zAP8E1zCAzIW5Dav2wvlCdeyv+4rPG33wv3ojyoTGVqnvSQewAhCmZLNbmljc5nEFP/
	w02Y+M3OciJntBhDz5gEFTDTNZOfkIIlVdX2KYp6r1MGlurd0Do2cC5N3t7kahT0GqlzU6g9WQG
	YPGxC2nrbJ6gkdQe1G2vwp9/6QikyTICEzZ+u7rBsu0aOOw08Cuv6gdOASsRqR2OX+DSjqO1RMe
	McDvLoBFuNvRHHnEgYmT6gBWjlExateV7r/ElcvyXFfg+LgZ99bRw6UfxhvornWK6d0oHsQmPN7
	IesmWKI7fdsYctM8spUeFGRAAo2o14Pizjk+gUoNzwIod+dHG9DvgkSYFCiJQcHeVt0gVLyA914
	jVU0ngNfrxMwNDqPH6WD6LjZyXErdRX6StHSNURpBmNKCOzFF1lBmSEDlXJ14LrcffW07hJZkF+
	AHw4DSA+6Vn4JFQHCyoXQSeVoX7dSe9wJD+1Wwdo8L/XP7+TPmhIxhg740tYI4AmEHITdNZiaYx
	ouM1ofPB4/xF6925CSBgvhY3aTHgchPuc6I8SA==
X-Received: by 2002:a17:906:eecd:b0:c20:f871:1018 with SMTP id a640c23a62f3a-c24920d5db2mr197304166b.21.1787355337674;
        Fri, 21 Aug 2026 16:35:37 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f99basm37254966b.37.2026.08.21.16.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:37 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 13/14] selftests/bpf: Exercise arena arguments on every capable JIT
Date: Sat, 22 Aug 2026 01:35:07 +0200
Message-ID: <20260821233516.3426127-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821233516.3426127-1-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6708; i=memxor@gmail.com; h=from:subject; bh=UP8UarlaPbJGGDqPfkB4z8Px7M3mX78s0gbVSTi+R8Y=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjwQTf8hnzSv7sfro3VufCjKf7NAvzZyktDZ63fEJ2v EDYI6+KjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExk1nGGv9JODD0RUTnajOXy TwovsGVzh6vLLDkVMXmL/sO2vLushxgZ9hf9u/T65sJq5qV5hnd21X577OEyb5WR0o6Lc4yOb+Z 0ZgMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The arena kfunc runtime tests are restricted to x86-64 and arm64, so new
JIT implementations can compile without exercising rebasing, nullable
arguments, five-register calls, or the verifier capability gate.

Run those tests on RISC-V, s390, LoongArch, and PowerPC64 as well. Teach
test_loader about PowerPC64 so it can select the newly annotated programs.

Enable the struct_ops arena tests on RISC-V, s390, and LoongArch, whose
indirect trampolines now implement the separate reverse-conversion path.
PowerPC64 remains covered only for kfunc arguments because it does not
advertise the struct_ops capability.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_arena.c    | 16 ++++++---
 .../testing/selftests/bpf/progs/arena_kfunc.c | 36 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  1 +
 tools/testing/selftests/bpf/test_loader.c     |  5 +++
 4 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
index 7f9f54ba3fbe..7f44b00af06d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -6,7 +6,13 @@
 #include "struct_ops_arena_attach.skel.h"
 #include "struct_ops_arena_fail.skel.h"
 
-#if defined(__x86_64__) || defined(__aarch64__)
+#if defined(__x86_64__) || defined(__aarch64__) || \
+	(defined(__riscv) && __riscv_xlen == 64) || defined(__s390x__) || \
+	defined(__loongarch__)
+#define HAVE_ARENA_STRUCT_OPS_ARGS
+#endif
+
+#ifdef HAVE_ARENA_STRUCT_OPS_ARGS
 /*
  * Attach callbacks with __arena and __arena__nullable arguments and drive
  * them through the bpf_testmod_ops3_call_test_arena*() kfuncs.
@@ -111,11 +117,11 @@ static void arena_arg_attach(void)
 void serial_test_struct_ops_arena(void)
 {
 	/*
-	 * Arena struct_ops arguments need JIT support, currently x86-64 and
-	 * arm64 only. Elsewhere verification fails with "JIT does not support
-	 * arena arguments", so the programs cannot even load.
+	 * Arena struct_ops arguments need JIT support. Elsewhere verification
+	 * fails with "JIT does not support arena arguments", so the programs
+	 * cannot even load.
 	 */
-#if defined(__x86_64__) || defined(__aarch64__)
+#ifdef HAVE_ARENA_STRUCT_OPS_ARGS
 	if (test__start_subtest("arena_arg"))
 		arena_arg();
 	if (test__start_subtest("arena_arg_fail"))
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index bf0d304e0e59..8ee2bd4d6633 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -28,6 +28,10 @@ volatile u64 stash;
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
+__arch_riscv64
+__arch_s390x
+__arch_loongarch
+__arch_powerpc64
 __success __retval(0)
 int arena_arg_forms(void *ctx)
 {
@@ -72,6 +76,10 @@ int arena_arg_forms(void *ctx)
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
+__arch_riscv64
+__arch_s390x
+__arch_loongarch
+__arch_powerpc64
 __success __retval(0)
 int arena_arg_rebase(void *ctx)
 {
@@ -114,6 +122,10 @@ int arena_arg_rebase(void *ctx)
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
+__arch_riscv64
+__arch_s390x
+__arch_loongarch
+__arch_powerpc64
 __success __retval(0)
 int arena_args5(void *ctx)
 {
@@ -146,6 +158,10 @@ int arena_args5(void *ctx)
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
+__arch_riscv64
+__arch_s390x
+__arch_loongarch
+__arch_powerpc64
 __success __retval(0)
 int arena_arg_mixed(void *ctx)
 {
@@ -174,6 +190,10 @@ int arena_arg_mixed(void *ctx)
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
+__arch_riscv64
+__arch_s390x
+__arch_loongarch
+__arch_powerpc64
 __success __retval(0)
 int arena_arg_unpopulated(void *ctx)
 {
@@ -195,6 +215,10 @@ int arena_arg_unpopulated(void *ctx)
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
+__arch_riscv64
+__arch_s390x
+__arch_loongarch
+__arch_powerpc64
 __failure __msg("arena pointer requires a program with an associated arena")
 int arena_arg_no_arena(void *ctx)
 {
@@ -205,6 +229,10 @@ int arena_arg_no_arena(void *ctx)
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
+__arch_riscv64
+__arch_s390x
+__arch_loongarch
+__arch_powerpc64
 __failure __msg("is not a pointer to arena or scalar")
 int arena_arg_bad_reg(void *ctx)
 {
@@ -221,6 +249,10 @@ int arena_arg_bad_reg(void *ctx)
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
+__arch_riscv64
+__arch_s390x
+__arch_loongarch
+__arch_powerpc64
 __failure __msg("arena pointer cannot be a stack argument")
 int arena_arg_stack(void *ctx)
 {
@@ -232,6 +264,10 @@ int arena_arg_stack(void *ctx)
 SEC("syscall")
 __arch_x86_64
 __arch_arm64
+__arch_riscv64
+__arch_s390x
+__arch_loongarch
+__arch_powerpc64
 __description("arena_arg_stack: not supported, dummy test")
 __success
 int arena_arg_stack(void *ctx)
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 5eacf1b43252..c35359c97e44 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -159,6 +159,7 @@
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
 #define __arch_loongarch	__arch("LOONGARCH")
+#define __arch_powerpc64	__arch("POWERPC64")
 #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
 #define __load_if_JITed()	__test_tag("load_mode=jited")
 #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 07807757b518..221393f2a8ef 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -378,6 +378,7 @@ enum arch {
 	ARCH_RISCV64	= 0x8,
 	ARCH_S390X	= 0x10,
 	ARCH_LOONGARCH	= 0x20,
+	ARCH_POWERPC64	= 0x40,
 };
 
 static int get_current_arch(void)
@@ -392,6 +393,8 @@ static int get_current_arch(void)
 	return ARCH_S390X;
 #elif defined(__loongarch__)
 	return ARCH_LOONGARCH;
+#elif defined(__powerpc64__)
+	return ARCH_POWERPC64;
 #endif
 	return ARCH_UNKNOWN;
 }
@@ -585,6 +588,8 @@ static int parse_test_spec(struct test_loader *tester,
 				arch = ARCH_S390X;
 			} else if (strcmp(val, "LOONGARCH") == 0) {
 				arch = ARCH_LOONGARCH;
+			} else if (strcmp(val, "POWERPC64") == 0) {
+				arch = ARCH_POWERPC64;
 			} else {
 				PRINT_FAIL("bad arch spec: '%s'\n", val);
 				err = -EINVAL;
-- 
2.53.0

