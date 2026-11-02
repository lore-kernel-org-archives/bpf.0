Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657272;
	b=FaUj/swoAh5HOe9WUBUqZG98dF93swqpQ6FeF/FRHNtvhwJ7txfA2rgyQGbKntW/C+hJ
	 +SJUw/5mO8PhXOP3vzT+nM6AfmxkXFBuucsD75vpWHHb9iM2vFT6yl4rLRS6C56nScQ/4
	 Ds3YhCm4ArLekCxH21u3V7jkiXJlDMXlgPTgvFyEnJSnyKgd5J+oaBv6fRTS0FQAwIaC3
	 eC4xtQy6s13Qxy28wxXg1Jg0n1+RLVQZAaAXqAZQ0tcFFeG7mh4drx7y15vVmSnY1mzfw
	 KxNKsoUI6I3eMqZZmTS1iNhewOGOUUyZYBmkqTViGllSoHvBBfBSD1qhhBXwURHfnSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657272;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qkG9AZrB9otknb3x+lqWx/DYaJ+beLGiJ2aE9sTzze8=;
	b=oKcYqqFcupwWSz4ole1ORa4l+09kz8iYPNir4xU4ttmxKGu1iGS0oVxA53IhAEmi9+9y
	 cxwoHHKBGd+/47njwKljZLt6A6p4uLfLbQQFEpdaovAIqxqkHpOe7C3iI69q3/wWM36JF
	 B/tOR7L0DTkCvYQk4jGpwJX9oJgylqrKxxpVg4xEb2vSmZS7eTiBq2+hTCTGXw4v8A5xC
	 m3ztuKl8jNCLdeSEjec8NcW6w+1xWJOaV9b7xau96ceC0hq+P0cVPZqulx/q0Ky3opggO
	 DCkn0uBbz1S3ovOjCpEKMbS3QLTPSOIgGZQGmFC6QMac5KR5OGDLpcg9d76A3oLj80g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CZhf06Qv;
	arc=none smtp.remote-ip=91.218.175.171
Received: from mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2F0606A330
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E2F0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CZhf06Qv
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=c8sb4EVJLfEmmqwqm5Jv2dluzAQaG63a3/ahLPxWZGA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793657268; v=1; x=1794262068;
 b=CZhf06Qvw9OjBidBCpH3XWpzMWb2MoT7aTdTSa/4rz3SSjtw2jTsJiar4+l9f9HoCqC+Sds7
 6u10Rej6ErdYjzuqZ3SdxVcSEnJmJrYOVTrVSM+mGNsk004AVluFVss02xMSXTfyUnfay++7yB5
 BX7rclB5LNtGw67kvSIOfBNw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7c46c2c072e57a77;
	Mon, 02 Nov 2026 22:07:48 +0000
X-Mizu-Trace-ID: 7c46c2c072e57a77
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
Subject: [PATCH bpf-next v3 3/8] selftests/bpf: report SKIP for arena tests a compiler cannot build
Date: Mon,  2 Nov 2026 14:07:12 -0800
Message-ID: <20261102220717.4079739-4-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220717.4079739-1-vineet.gupta@linux.dev>
References: <20261102220717.4079739-1-vineet.gupta@linux.dev>
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

Tests guarded by __BPF_FEATURE_ADDR_SPACE_CAST don't have a dummy fall back
when the compiler doesn't support the feature: so they are absent from such
a report entirely.
Every subtest inside one of those guards is invisible: 24 across seven
files, plus the five in stream_arena_fault_address, which has no guard
and fails to load instead (addressed separately, later in this series).

Give each guard an #else with a dummy marked __skip(), so the skip gap is
reported rather than invisible.  Add __skip_without_arena for it, which
expands to __skip() with a fixed reason when the compiler cannot do arena.

Measured on bpf-next with a stock bpf-gcc, test_progs before and after:
seven subtests appear that were previously absent from the report
altogether, and arena_kfunc_jit goes OK -> SKIP because every subtest
it has is now one of them.

  arena_kfunc_jit/arena_unsupported          SKIP
  compute_live_registers/arena_unsupported   SKIP
  jit_insns/arena_unsupported                SKIP
  verifier_arena/arena_unsupported           SKIP
  verifier_arena_large/arena_unsupported     SKIP
  verifier_ldsx/arena_unsupported            SKIP
  verifier_zext/arena_unsupported            SKIP
jit_insns_arena.c needs the same treatment and is easy to miss: both
of its programs are inside the guard, so without arena support the
object has none at all and RUN_TESTS(jit_insns_arena) runs zero
subtests without saying so.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 .../testing/selftests/bpf/progs/arena_kfunc_jit.c  |  9 +++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h       | 14 ++++++++++++++
 .../selftests/bpf/progs/compute_live_registers.c   | 10 ++++++++++
 .../testing/selftests/bpf/progs/jit_insns_arena.c  | 10 ++++++++++
 tools/testing/selftests/bpf/progs/verifier_arena.c |  9 +++++++++
 .../selftests/bpf/progs/verifier_arena_large.c     | 10 ++++++++++
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  |  9 +++++++++
 tools/testing/selftests/bpf/progs/verifier_zext.c  |  9 +++++++++
 8 files changed, 80 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
index b5a01cbc33a7..97912a7b6b5e 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
@@ -112,6 +112,15 @@ int arena_arg_jit_args5(void *ctx)
 				   (u64 *)&val[4]);
 	return 0;
 }
+#else
+
+SEC("socket")
+__skip_without_arena
+__success
+int arena_unsupported(void)
+{
+	return 0;
+}
 
 #endif /* __BPF_FEATURE_ADDR_SPACE_CAST */
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 1b264480e128..ed1ed1b5bd09 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -116,6 +116,10 @@
  *                   feature the toolchain or JIT cannot provide, so a run does
  *                   not report OK for coverage it never executed.
  *
+ * __skip_without_arena
+ *                   __skip() with a fixed reason when the compiler cannot do
+ *                   the arena address space, nothing otherwise.
+ *
  * __log_level       Log level to use for the program, numeric value expected.
  *
  * __flag            Adds one flag use for the program, the following values are valid:
@@ -156,6 +160,16 @@
 #define __success		__test_tag("test_expect_success")
 #define __description(desc)	__test_tag("test_description=" desc)
 #define __skip(reason)		__test_tag("test_skip=" reason)
+
+/*
+ * Without compiler arena support, report the test as SKIP rather than let it
+ * pass vacuously or fail to load.
+ */
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+#define __skip_without_arena
+#else
+#define __skip_without_arena	__skip("compiler does not support the arena address space")
+#endif
 #define __msg_unpriv(msg)	__test_tag("test_expect_msg_unpriv=" msg)
 #define __not_msg_unpriv(msg)	__test_tag("test_expect_not_msg_unpriv=" msg)
 #define __msg_next_unpriv(msg)	__test_tag("test_expect_msg_next_unpriv=" msg)
diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index 1ff24bbc7beb..e05431600358 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -403,6 +403,16 @@ __naked void addr_space_cast(void)
 		  __imm_addr(arena)
 		: __clobber_all);
 }
+#else
+
+SEC("socket")
+__skip_without_arena
+__success
+int arena_unsupported(void)
+{
+	return 0;
+}
+
 #endif
 
 static __used __naked int aux1(void)
diff --git a/tools/testing/selftests/bpf/progs/jit_insns_arena.c b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
index 95736eae2a58..ccda60e96524 100644
--- a/tools/testing/selftests/bpf/progs/jit_insns_arena.c
+++ b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
@@ -106,6 +106,16 @@ int cast_to_user(void *ctx)
 	: "r1", "r2", "r7", "r9");
 	return res != 0;
 }
+#else
+
+SEC("socket")
+__skip_without_arena
+__success
+int arena_unsupported(void)
+{
+	return 0;
+}
+
 #endif
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index b17a6dfc100d..121f8cea8c25 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -728,6 +728,15 @@ __naked void mixed_arena_stack_atomic(void)
 	  __imm(bpf_get_prandom_u32)
 	: __clobber_all);
 }
+#else
+
+SEC("socket")
+__skip_without_arena
+__success
+int arena_unsupported(void)
+{
+	return 0;
+}
 
 #endif /* defined(__BPF_FEATURE_ADDR_SPACE_CAST) */
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index dbdea14ca76f..34f0a0f88e12 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -348,5 +348,15 @@ int big_alloc4(void *ctx)
 #endif
 	return 0;
 }
+#else
+
+SEC("socket")
+__skip_without_arena
+__success
+int arena_unsupported(void)
+{
+	return 0;
+}
+
 #endif
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 49e8cd4bb4f9..35b20d0796db 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -450,6 +450,15 @@ void kfunc_root(void)
 {
 	bpf_arena_alloc_pages(0, 0, 0, 0, 0);
 }
+#else
+
+SEC("socket")
+__skip_without_arena
+__success
+int arena_unsupported(void)
+{
+	return 0;
+}
 
 #endif /* __BPF_FEATURE_ADDR_SPACE_CAST */
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_zext.c b/tools/testing/selftests/bpf/progs/verifier_zext.c
index 572017fe28fb..dbfeeea4cf9f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_zext.c
+++ b/tools/testing/selftests/bpf/progs/verifier_zext.c
@@ -381,6 +381,15 @@ __naked void zext_arena_cmpxchg32(void)
 		     BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_1, BPF_REG_2, 0))
 	: __clobber_all);
 }
+#else
+
+SEC("socket")
+__skip_without_arena
+__success
+int arena_unsupported(void)
+{
+	return 0;
+}
 
 #endif
 
-- 
2.53.0-Meta

