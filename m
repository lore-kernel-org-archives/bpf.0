Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729953;
	b=cdpwMfZLOjCw1EiPzmAh4tbSiGQEDRNYhYoLDdmfRFofpX5v4Qwy+RYqdNfv8Lr81BlJ
	 jOoONv8TOPd8mL3u2v7AACC6BQtfCoH26O/MO4W5S9NwfVKucUfriDU8LwlOeSGz13bU2
	 eAJUwwFi4kcpGZ6dvhOtUAXddwlSxIFK19DgYUIF2XDZ62nUBrBnBXPHa3P3gkrQnfhFM
	 4p0wAO2mvRi7LkIDxTMnpcXLQPtEvsHuIGT4SO2dLW56myMh2wktR69txdJNds+1ZeYX5
	 soQBEi0kMtwNSANmFTtg/gGR7ppQwQ6CcBvayXf0WRuHjuYb7vZMsg5B5WdnO+c23ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729953;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2/bU6xUAsoDMbB4mdbD2DKeV8fFLeUa1OgRRTYh5YSg=;
	b=Yz9oD0JGGW/p3yYw8hHS83Io3qm1HRK9pz1jFjXGs5VQUd0Ls3Pon2X21kJ2B5+c8LIs
	 aMyuZedGb4PJwPJTuX3L8GsLwlff9HwHubYVZmAmZOdGE4YU2GvRO5yW36EeudU0GSnrq
	 SCR6ztmk4UdawGaN1JoeyFAq1gQQ6zqyNT+x5nF15kXdGy61jU5TeNrqLJpGKNaFV0ACz
	 0qdJ+lsJD/NE9BUgWkyhOeDDza0uB67IeVOsKP8Q30Ha1PdobnqryRF4gMmqBd0YY3UH/
	 jjL834H5jXhYkJJmyqIb6XGvPAwOx0Sk7gbiBvMQbd+35PaBHeFII7gM+8Y+OJgIfAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gEZDcUeA;
	arc=none smtp.remote-ip=95.215.58.117
Received: from mta1.migadu.com (out-117.mta1.migadu.com [95.215.58.117])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FAB606D802
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04FAB606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gEZDcUeA
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XZn1i9S3NQ6InFtIi7X9JpATyHMdjNCXCg2C3TBqWbE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793729950; v=1; x=1794334750;
 b=gEZDcUeACZrucZvcFIAQrHJpjewjjGA0sgRGr1lw+gktySU/cVNWkuUCl4UF74nhEZEz4Cbi
 vgFX32O76Bqc2cOHx1mJtMMaJCEHCu7KUOwaFjMpj/rsswIMFjhChi/PWBN0FYAwgPpCECHmIJI
 v+aPs/BNq1H3a8q44IVw5zEQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 79c1b962357c3975;
	Tue, 03 Nov 2026 18:19:09 +0000
X-Mizu-Trace-ID: 79c1b962357c3975
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jose.marchesi@oracle.com,
	david.faust@oss.qualcomm.com,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v4 6/8] selftests/bpf: drop the arena guards and tag the tests that need arena
Date: Tue,  3 Nov 2026 10:18:14 -0800
Message-ID: <20261103181816.254686-7-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103181816.254686-1-vineet.gupta@linux.dev>
References: <20261103181816.254686-1-vineet.gupta@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arena tests are gated behind __BPF_FEATURE_ADDR_SPACE_CAST inside the
function body which is not ideal. For BPF_GCC which currently lacks
arena support, it leave an empty function which returns success (0)
giving the false impression that it is implemented and works.

  #626/9   verifier_arena/basic_alloc1:OK

Turns out depite the lack of support most arena tests can be built and
work too. So drop the guards and let the programs be built.
Add __skip_without_arena for the few that do need the feature and will
be marked SKIP.

Measured on bpf-next with a stock bpf-gcc, test_progs before and
after. 20 subtests that were invisible now run and pass, five more now
say why they do not, and 13 empty bodies stop claiming to pass. One of
each:

  verifier_ldsx/Arena LDSX, S8                          -> OK
  verifier_arena_large/big_alloc2                       -> SKIP
  verifier_arena/basic_alloc1                      OK   -> SKIP

verifier_hmul_arena.c is also included in the sweep as it used the old
pattern of using __skip() and changing this makes the usage consistent.

  verifier_hmul_arena                              SKIP -> OK

Approach suggested by Alexei Starovoitov.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3 -> v4: replaces 3/8 and 5/8.
  The #else dummies pattern removed (Alexei)
  The guards go and the tests that need arena are tagged instead.

 .../testing/selftests/bpf/progs/arena_kfunc.c | 18 +++-------
 .../selftests/bpf/progs/arena_kfunc_jit.c     |  5 +--
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  9 +++++
 .../bpf/progs/compute_live_registers.c        |  2 --
 .../selftests/bpf/progs/jit_insns_arena.c     |  2 --
 .../selftests/bpf/progs/verifier_arena.c      | 35 +++----------------
 .../bpf/progs/verifier_arena_globals1.c       |  6 ++--
 .../bpf/progs/verifier_arena_globals2.c       |  3 +-
 .../bpf/progs/verifier_arena_large.c          | 21 +++--------
 .../selftests/bpf/progs/verifier_hmul_arena.c | 15 --------
 .../selftests/bpf/progs/verifier_ldsx.c       |  4 ---
 .../selftests/bpf/progs/verifier_zext.c       |  4 ---
 12 files changed, 27 insertions(+), 97 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
index 5d1cb1a7e8ee..757aa0618571 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
@@ -29,9 +29,9 @@ SEC("syscall")
 __arch_x86_64
 __arch_arm64
 __success __retval(0)
+__skip_without_arena
 int arena_arg_forms(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	u64 __arena *val;
 	u64 ret;
 
@@ -59,7 +59,6 @@ int arena_arg_forms(void *ctx)
 		return 4;
 
 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
-#endif
 	return 0;
 }
 
@@ -75,7 +74,6 @@ __arch_arm64
 __success __retval(0)
 int arena_arg_rebase(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	u64 __arena *val;
 	u64 base, off;
 
@@ -107,7 +105,6 @@ int arena_arg_rebase(void *ctx)
 		return 7;
 
 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
-#endif
 	return 0;
 }
 
@@ -115,9 +112,9 @@ SEC("syscall")
 __arch_x86_64
 __arch_arm64
 __success __retval(0)
+__skip_without_arena
 int arena_args5(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	u64 __arena *val;
 
 	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
@@ -139,7 +136,6 @@ int arena_args5(void *ctx)
 		return 3;
 
 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
-#endif
 	return 0;
 }
 
@@ -147,9 +143,9 @@ SEC("syscall")
 __arch_x86_64
 __arch_arm64
 __success __retval(0)
+__skip_without_arena
 int arena_arg_mixed(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	u64 __arena *val;
 
 	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
@@ -166,7 +162,6 @@ int arena_arg_mixed(void *ctx)
 		return 3;
 
 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
-#endif
 	return 0;
 }
 
@@ -177,7 +172,6 @@ __arch_arm64
 __success __retval(0)
 int arena_arg_unpopulated(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	u64 __arena *val;
 
 	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
@@ -188,7 +182,6 @@ int arena_arg_unpopulated(void *ctx)
 	bpf_kfunc_arena_arg_test((u64 *)stash);
 
 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
-#endif
 	return 0;
 }
 
@@ -220,9 +213,9 @@ SEC("syscall")
 __arch_x86_64
 __arch_arm64
 __success __retval(0)
+__skip_without_arena
 int arena_arg_subprog(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	u64 __arena *val;
 	int ret;
 
@@ -238,9 +231,6 @@ int arena_arg_subprog(void *ctx)
 
 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
 	return ret;
-#else
-	return 0;
-#endif
 }
 
 SEC("syscall")
diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
index b5a01cbc33a7..16c3dd93ed98 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
@@ -23,8 +23,6 @@ struct {
 /* volatile to force the scalar reloads below */
 volatile u64 stash;
 
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
-
 SEC("syscall")
 __arch_x86_64
 __jited("...")
@@ -93,6 +91,7 @@ __jited("	cbz	w4, L0")
 __jited("	add	x4, x28, w4, uxtw")
 __jited("L0:	{{.*}}")
 __success
+__skip_without_arena
 int arena_arg_jit_args5(void *ctx)
 {
 	u64 __arena *val;
@@ -113,6 +112,4 @@ int arena_arg_jit_args5(void *ctx)
 	return 0;
 }
 
-#endif /* __BPF_FEATURE_ADDR_SPACE_CAST */
-
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 1b264480e128..6b930cb48f8d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -116,6 +116,10 @@
  *                   feature the toolchain or JIT cannot provide, so a run does
  *                   not report OK for coverage it never executed.
  *
+ * __skip_without_arena
+ *                   __skip() when the compiler does not support the arena
+ *                   address space, nothing otherwise.
+ *
  * __log_level       Log level to use for the program, numeric value expected.
  *
  * __flag            Adds one flag use for the program, the following values are valid:
@@ -156,6 +160,11 @@
 #define __success		__test_tag("test_expect_success")
 #define __description(desc)	__test_tag("test_description=" desc)
 #define __skip(reason)		__test_tag("test_skip=" reason)
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+#define __skip_without_arena
+#else
+#define __skip_without_arena	__skip("compiler does not support the arena address space")
+#endif
 #define __msg_unpriv(msg)	__test_tag("test_expect_msg_unpriv=" msg)
 #define __not_msg_unpriv(msg)	__test_tag("test_expect_not_msg_unpriv=" msg)
 #define __msg_next_unpriv(msg)	__test_tag("test_expect_msg_next_unpriv=" msg)
diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index 1ff24bbc7beb..a54f68bcd2ba 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -378,7 +378,6 @@ __naked void ldabs(void)
 }
 
 
-#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 __log_level(2)
 __msg(" 6: .12345.... (85) call bpf_arena_alloc_pages")
@@ -403,7 +402,6 @@ __naked void addr_space_cast(void)
 		  __imm_addr(arena)
 		: __clobber_all);
 }
-#endif
 
 static __used __naked int aux1(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/jit_insns_arena.c b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
index 997a897d66eb..ee591f0dcf95 100644
--- a/tools/testing/selftests/bpf/progs/jit_insns_arena.c
+++ b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
@@ -32,7 +32,6 @@ struct {
 #define VAL_SUM	0x11224578aaccef10
 #endif
 
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 SEC("syscall")
 __success __retval(0)
 int arena_zero_off(void *ctx)
@@ -106,6 +105,5 @@ int cast_to_user(void *ctx)
 	: "r1", "r2", "r7", "r9");
 	return res != 0;
 }
-#endif
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 146febd99523..cadb13f023d2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -27,9 +27,9 @@ struct {
 
 SEC("socket")
 __success __retval(0)
+__skip_without_arena
 int basic_alloc1_nosleep(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	volatile int __arena *page1, *page2, *no_page;
 
 	page1 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
@@ -52,15 +52,14 @@ int basic_alloc1_nosleep(void *ctx)
 		return 6;
 	if (*page2 != 0 && *page2 != 2) /* use-after-free should return 0 or the stored value */
 		return 7;
-#endif
 	return 0;
 }
 
 SEC("syscall")
 __success __retval(0)
+__skip_without_arena
 int basic_alloc1(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	volatile int __arena *page1, *page2, *no_page, *page3;
 
 	page1 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
@@ -91,7 +90,6 @@ int basic_alloc1(void *ctx)
 		return 9;
 	if (*page1 != 1)
 		return 10;
-#endif
 	return 0;
 }
 
@@ -125,9 +123,9 @@ int free_scalar_below_arena(void *ctx)
 
 SEC("socket")
 __success __retval(0)
+__skip_without_arena
 int basic_alloc2_nosleep(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	volatile char __arena *page1, *page2, *page3, *page4;
 
 	page1 = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);
@@ -157,15 +155,14 @@ int basic_alloc2_nosleep(void *ctx)
 		return 7;
 	if (*page4 != 0)
 		return 8;
-#endif
 	return 0;
 }
 
 SEC("syscall")
 __success __retval(0)
+__skip_without_arena
 int basic_alloc2(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	volatile char __arena *page1, *page2, *page3, *page4;
 
 	page1 = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);
@@ -195,7 +192,6 @@ int basic_alloc2(void *ctx)
 		return 7;
 	if (*page4 != 0)
 		return 8;
-#endif
 	return 0;
 }
 
@@ -233,7 +229,6 @@ SEC("socket")
 __success __retval(0)
 int basic_reserve1_nosleep(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *page;
 	int ret;
 
@@ -257,7 +252,6 @@ int basic_reserve1_nosleep(void *ctx)
 	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
 	if (page)
 		return 4;
-#endif
 	return 0;
 }
 
@@ -265,7 +259,6 @@ SEC("syscall")
 __success __retval(0)
 int basic_reserve1(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *page;
 	int ret;
 
@@ -289,7 +282,6 @@ int basic_reserve1(void *ctx)
 	page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
 	if (page)
 		return 4;
-#endif
 	return 0;
 }
 
@@ -297,7 +289,6 @@ SEC("socket")
 __success __retval(0)
 int basic_reserve2_nosleep(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *page;
 	int ret;
 
@@ -309,7 +300,6 @@ int basic_reserve2_nosleep(void *ctx)
 	page = bpf_arena_alloc_pages(&arena, page, 1, NUMA_NO_NODE, 0);
 	if ((u64)page)
 		return 2;
-#endif
 	return 0;
 }
 
@@ -317,7 +307,6 @@ SEC("syscall")
 __success __retval(0)
 int basic_reserve2(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *page;
 	int ret;
 
@@ -329,7 +318,6 @@ int basic_reserve2(void *ctx)
 	page = bpf_arena_alloc_pages(&arena, page, 1, NUMA_NO_NODE, 0);
 	if ((u64)page)
 		return 2;
-#endif
 	return 0;
 }
 
@@ -338,7 +326,6 @@ SEC("socket")
 __success __retval(0)
 int reserve_twice_nosleep(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *page;
 	int ret;
 
@@ -351,7 +338,6 @@ int reserve_twice_nosleep(void *ctx)
 	ret = bpf_arena_reserve_pages(&arena, page, 1);
 	if (ret != -EBUSY)
 		return 2;
-#endif
 	return 0;
 }
 
@@ -359,7 +345,6 @@ SEC("syscall")
 __success __retval(0)
 int reserve_twice(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *page;
 	int ret;
 
@@ -372,7 +357,6 @@ int reserve_twice(void *ctx)
 	ret = bpf_arena_reserve_pages(&arena, page, 1);
 	if (ret != -EBUSY)
 		return 2;
-#endif
 	return 0;
 }
 
@@ -381,7 +365,6 @@ SEC("socket")
 __success __retval(0)
 int reserve_invalid_region_nosleep(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *page;
 	int ret;
 
@@ -403,7 +386,6 @@ int reserve_invalid_region_nosleep(void *ctx)
 	ret = bpf_arena_reserve_pages(&arena, page, (1ULL << 32) - 1);
 	if (ret != -EINVAL)
 		return 4;
-#endif
 	return 0;
 }
 
@@ -411,7 +393,6 @@ SEC("syscall")
 __success __retval(0)
 int reserve_invalid_region(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *page;
 	int ret;
 
@@ -433,7 +414,6 @@ int reserve_invalid_region(void *ctx)
 	ret = bpf_arena_reserve_pages(&arena, page, (1ULL << 32) - 1);
 	if (ret != -EINVAL)
 		return 4;
-#endif
 	return 0;
 }
 
@@ -478,7 +458,6 @@ SEC("syscall")
 __success __retval(0)
 int arena_kfuncs_under_bpf_lock(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *page;
 	int ret;
 
@@ -503,13 +482,10 @@ int arena_kfuncs_under_bpf_lock(void *ctx)
 	bpf_arena_free_pages(&arena, page, 1);
 
 	bpf_spin_unlock(&arena_bpf_test_lock);
-#endif
 
 	return 0;
 }
 
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
-
 /*
  * Test that scalar += PTR_TO_ARENA correctly upgrades the
  * destination register to a PTR_TO_ARENA.
@@ -740,8 +716,6 @@ __naked void mixed_arena_stack_atomic(void)
 	: __clobber_all);
 }
 
-#endif /* defined(__BPF_FEATURE_ADDR_SPACE_CAST) */
-
 static __noinline
 u32 __arena *check_arena_arg_nonglobal(u32 __arena *arg)
 {
@@ -782,6 +756,7 @@ u32 __arena volatile *check_arena_arg_quals2(u32 volatile __arena *arg1, u32 __a
 
 SEC("syscall")
 __success __retval(0)
+__skip_without_arena
 int check_arena_arg_ret(void *ctx)
 {
 	u32 __arena *page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
index 45d364b0bc85..31be4c944252 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
@@ -30,9 +30,9 @@ volatile char __arena global_data[GLOBAL_PAGES][PAGE_SIZE];
 
 SEC("syscall")
 __success __retval(0)
+__skip_without_arena
 int check_reserve1(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	const u8 magic = 0x5a;
 	__u8 __arena *guard, *globals;
 	volatile char __arena *ptr;
@@ -60,7 +60,6 @@ int check_reserve1(void *ctx)
 		if (*ptr != magic)
 			return i + 3;
 	}
-#endif
 	return 0;
 }
 
@@ -69,9 +68,9 @@ int check_reserve1(void *ctx)
  */
 SEC("syscall")
 __success __retval(0)
+__skip_without_arena
 int check_relocation(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	const u8 magic = 0xfa;
 	u8 __arena *ptr;
 
@@ -80,7 +79,6 @@ int check_relocation(void *ctx)
 	if (*ptr != magic)
 		return 1;
 
-#endif
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c b/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
index b51594dbc005..cd48d6bd782e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals2.c
@@ -30,9 +30,9 @@ char __arena global_data[ARENA_PAGES][PAGE_SIZE];
 
 SEC("syscall")
 __success __retval(0)
+__skip_without_arena
 int check_reserve2(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	void __arena *guard;
 	int ret;
 
@@ -42,7 +42,6 @@ int check_reserve2(void *ctx)
 	ret = bpf_arena_reserve_pages(&arena, guard, 1);
 	if (!ret)
 		return 1;
-#endif
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index dbdea14ca76f..89f32a7772ac 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -22,9 +22,9 @@ struct {
 
 SEC("syscall")
 __success __retval(0)
+__skip_without_arena
 int big_alloc1(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	volatile char __arena *page1, *page2, *no_page, *page3;
 	u64 base;
 
@@ -79,16 +79,15 @@ int big_alloc1(void *ctx)
 		return 13;
 	if (*(page2 - PAGE_SIZE) != 0)
 		return 14;
-#endif
 	return 0;
 }
 
 /* Try to access a reserved page. Behavior should be identical with accessing unallocated pages. */
 SEC("syscall")
 __success __retval(0)
+__skip_without_arena
 int access_reserved(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	volatile char __arena *page;
 	char __arena *base;
 	const size_t len = 4;
@@ -118,7 +117,6 @@ int access_reserved(void *ctx)
 		if (*page)
 			return 2 + 2 * i + 1;
 	}
-#endif
 	return 0;
 }
 
@@ -127,7 +125,6 @@ SEC("syscall")
 __success __retval(0)
 int request_partially_reserved(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	volatile char __arena *page;
 	char __arena *base;
 	int ret;
@@ -142,7 +139,6 @@ int request_partially_reserved(void *ctx)
 	page = bpf_arena_alloc_pages(&arena, base, 5, NUMA_NO_NODE, 0);
 	if ((u64)page != 0ULL)
 		return 2;
-#endif
 	return 0;
 }
 
@@ -150,7 +146,6 @@ SEC("syscall")
 __success __retval(0)
 int free_reserved(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *addr;
 	char __arena *page;
 	int ret;
@@ -177,11 +172,9 @@ int free_reserved(void *ctx)
 	page = bpf_arena_alloc_pages(&arena, addr + __PAGE_SIZE, 2, NUMA_NO_NODE, 0);
 	if (!page)
 		return 3;
-#endif
 	return 0;
 }
 
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 #define PAGE_CNT 100
 __u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
 __u8 __arena *base;
@@ -220,6 +213,7 @@ __noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,
 
 SEC("syscall")
 __success __retval(0)
+__skip_without_arena
 int big_alloc2(void *ctx)
 {
 	__u8 __arena *pg;
@@ -290,9 +284,9 @@ int big_alloc2(void *ctx)
 /* Nonsleepable because it binds to a socket program. */
 SEC("socket")
 __success __retval(0)
+__skip_without_arena
 int big_alloc3(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *pages;
 	u64 i;
 	int err = 0;
@@ -314,16 +308,14 @@ int big_alloc3(void *ctx)
 
 	bpf_arena_free_pages(&arena, pages, LARGE_PAGE_CNT);
 	return err;
-#endif
-	return 0;
 }
 
 /* SYSCALL programs are always sleepable. */
 SEC("syscall")
 __success __retval(0)
+__skip_without_arena
 int big_alloc4(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *pages;
 	u64 i;
 	int err = 0;
@@ -345,8 +337,5 @@ int big_alloc4(void *ctx)
 
 	bpf_arena_free_pages(&arena, pages, LARGE_PAGE_CNT);
 	return err;
-#endif
-	return 0;
 }
-#endif
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c b/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c
index b94892fff2f8..b4bcfb6b9646 100644
--- a/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_hmul_arena.c
@@ -5,8 +5,6 @@
 #include "bpf_misc.h"
 #include "../../../include/linux/filter.h"
 
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
-
 #define BPF_UHMUL64_IMM(DST, IMM) \
 	BPF_RAW_INSN(BPF_ALU64 | BPF_MUL | BPF_K, DST, 0, BPF_UHMUL, IMM)
 
@@ -58,17 +56,4 @@ __naked void shmul64_arena_ptr(void)
 	: __clobber_all);
 }
 
-#else
-
-SEC("socket")
-__description("HMUL arena tests require compiler support for addr_space_cast")
-__skip("compiler doesn't support addr_space_cast")
-__success
-int dummy_test(void)
-{
-	return 0;
-}
-
-#endif
-
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 45b2e52fd715..8084a428d9e2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -257,8 +257,6 @@ __naked void ldsx_ctx_8(void)
 	: __clobber_all);
 }
 
-#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
-
 struct {
 	__uint(type, BPF_MAP_TYPE_ARENA);
 	__uint(map_flags, BPF_F_MMAPABLE);
@@ -451,8 +449,6 @@ void kfunc_root(void)
 	bpf_arena_alloc_pages(0, 0, 0, 0, 0);
 }
 
-#endif /* __BPF_FEATURE_ADDR_SPACE_CAST */
-
 #else
 
 SEC("socket")
diff --git a/tools/testing/selftests/bpf/progs/verifier_zext.c b/tools/testing/selftests/bpf/progs/verifier_zext.c
index 572017fe28fb..9fce1dd8ef7b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_zext.c
+++ b/tools/testing/selftests/bpf/progs/verifier_zext.c
@@ -324,8 +324,6 @@ __naked void alu64_and_conditionals(void)
 	: __clobber_all);
 }
 
-#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
-
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 __arch_s390x
 __xlated("7: w1 = w0")
@@ -382,8 +380,6 @@ __naked void zext_arena_cmpxchg32(void)
 	: __clobber_all);
 }
 
-#endif
-
 /* Check if probe mem loads keep their zero extension. */
 SEC("socket")
 __success __log_level(2)
-- 
2.53.0-Meta

