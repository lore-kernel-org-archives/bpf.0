Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4021437473
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389019; cv=none; b=RiqEOYxIs0EvwGgCL0fe0Eg7j1PJF5x3W1+JKP9T9psyD7gr1mhGIJ/UEOnoHlMcoWrpUMnybudG7q8QlBvD2/ijFNX2x7+dDgxej0gGhckJpwTEkMqwGlnOW2fw7q26BNkYuf4tdMd/ZvMMkV2MV6tp9R6HYRW0eZMv8bJAu9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389019; c=relaxed/simple;
	bh=6H0gHlkQ3TU1Zmh++F6NJdT0j6Sx24eI0hbDT5wdizg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgxKPAs3bXHJeqmGaXxmRdFmLfQJVG02gL4qy5PPnrIKovpse2WERCPiJ+VdvBwJ6+Gj3cUme+0VXoJlGPw4x4XTNyiLItF38N3lKs8Tp9IQqp8Ats2yU+KADL4kYU7sFF/ZTOAOjufyx9qECLbLj6tNmDOgSX083j0uIjYsDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2w8mVWy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2w8mVWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3721F00A3A;
	Mon, 10 Aug 2026 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786389012;
	bh=46E5G3SUc5WRgybNXsZYt+iz8hcGD+cHFUinzm14K8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U2w8mVWyg9eDKgZWIzXEJSMs3KclihH9XWTAMXgwzBZRQ/aCaogrdlj7XZTrVk2c0
	 d9Xa1vtTz/zRTVjuSCcVAXAHHN6DMNhAhAAL71nIXDoZMFQrUQPagLiPs9suS5D0cz
	 IMkiSbLEGvqE8XLOMdIIpr8ALKRYdMRtLj7R3TOILm0vrsBc8cldJoV5M6fVKblz64
	 euYvfrvi3qEmWOTFOwqt/u/k7/BR2sX3abt+OmWq9HT75P0pHG8yFvfhgC38WNSAf2
	 Pvf9X9LFH5OaUP9CTsoedN8Vt1rb2cEXoMcOaz5/dcUdmZ2aZPqRQE21pn3u3fsvhp
	 8E89FskMY+Njw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH bpf-next 6/7] selftests/bpf: Enable __arena argument tests on arm64
Date: Mon, 10 Aug 2026 12:09:19 -0700
Message-ID: <20260810190922.3408757-7-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810190922.3408757-1-puranjay@kernel.org>
References: <20260810190922.3408757-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena kfunc and struct_ops argument tests were restricted to x86-64
because it was the only JIT that implemented the conversions. arm64 does
now, so let them run there too: tag every program in arena_kfunc.c with
__arch_arm64 in addition to __arch_x86_64, and widen the __x86_64__
guards in the struct_ops arena test.

Without this the tests report SKIP on arm64 rather than exercising the
newly added JIT support.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/test_struct_ops_arena.c   | 10 +++++-----
 tools/testing/selftests/bpf/progs/arena_kfunc.c        |  9 +++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
index 940ec2cda0d52..7f9f54ba3fbe5 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -6,7 +6,7 @@
 #include "struct_ops_arena_attach.skel.h"
 #include "struct_ops_arena_fail.skel.h"
 
-#if defined(__x86_64__)
+#if defined(__x86_64__) || defined(__aarch64__)
 /*
  * Attach callbacks with __arena and __arena__nullable arguments and drive
  * them through the bpf_testmod_ops3_call_test_arena*() kfuncs.
@@ -111,11 +111,11 @@ static void arena_arg_attach(void)
 void serial_test_struct_ops_arena(void)
 {
 	/*
-	 * Arena struct_ops arguments need JIT support, currently x86-64 only.
-	 * Elsewhere verification fails with "JIT does not support arena
-	 * arguments", so the programs cannot even load.
+	 * Arena struct_ops arguments need JIT support, currently x86-64 and
+	 * arm64 only. Elsewhere verification fails with "JIT does not support
+	 * arena arguments", so the programs cannot even load.
 	 */
-#if defined(__x86_64__)
+#if defined(__x86_64__) || defined(__aarch64__)
 	if (test__start_subtest("arena_arg"))
 		arena_arg();
 	if (test__start_subtest("arena_arg_fail"))
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index cdcea889da586..bf0d304e0e59c 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -27,6 +27,7 @@ volatile u64 stash;
 
 SEC("syscall")
 __arch_x86_64
+__arch_arm64
 __success __retval(0)
 int arena_arg_forms(void *ctx)
 {
@@ -70,6 +71,7 @@ int arena_arg_forms(void *ctx)
  */
 SEC("syscall")
 __arch_x86_64
+__arch_arm64
 __success __retval(0)
 int arena_arg_rebase(void *ctx)
 {
@@ -111,6 +113,7 @@ int arena_arg_rebase(void *ctx)
 
 SEC("syscall")
 __arch_x86_64
+__arch_arm64
 __success __retval(0)
 int arena_args5(void *ctx)
 {
@@ -142,6 +145,7 @@ int arena_args5(void *ctx)
 
 SEC("syscall")
 __arch_x86_64
+__arch_arm64
 __success __retval(0)
 int arena_arg_mixed(void *ctx)
 {
@@ -169,6 +173,7 @@ int arena_arg_mixed(void *ctx)
 /* kernel-side faults on unpopulated pages recover via the scratch page */
 SEC("syscall")
 __arch_x86_64
+__arch_arm64
 __success __retval(0)
 int arena_arg_unpopulated(void *ctx)
 {
@@ -189,6 +194,7 @@ int arena_arg_unpopulated(void *ctx)
 
 SEC("syscall")
 __arch_x86_64
+__arch_arm64
 __failure __msg("arena pointer requires a program with an associated arena")
 int arena_arg_no_arena(void *ctx)
 {
@@ -198,6 +204,7 @@ int arena_arg_no_arena(void *ctx)
 
 SEC("syscall")
 __arch_x86_64
+__arch_arm64
 __failure __msg("is not a pointer to arena or scalar")
 int arena_arg_bad_reg(void *ctx)
 {
@@ -213,6 +220,7 @@ int arena_arg_bad_reg(void *ctx)
 	defined(__BPF_FEATURE_STACK_ARGUMENT)
 SEC("syscall")
 __arch_x86_64
+__arch_arm64
 __failure __msg("arena pointer cannot be a stack argument")
 int arena_arg_stack(void *ctx)
 {
@@ -223,6 +231,7 @@ int arena_arg_stack(void *ctx)
 #else
 SEC("syscall")
 __arch_x86_64
+__arch_arm64
 __description("arena_arg_stack: not supported, dummy test")
 __success
 int arena_arg_stack(void *ctx)
-- 
2.53.0-Meta

