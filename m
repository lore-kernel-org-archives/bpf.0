Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309198;
	b=ARGJez1j0QWXfAMr1aihpz5Q4dr5e0HGhEZ8VSZ1LC47stj3k4FrqxzNjm7x7YgXO3bd
	 rLJ3xMgUi+jOihWT1YEJOfuJAfpQ1DOHA0JWM9Hkh+R7KKO3ZOP5lODQeMErCjFvRGaOm
	 +iNWlkuxrHfg6xIZXTr7jSgpRCsD9P+wvVL/dQbT6NBwFzhSyaFd+gpyeJ+wGQxTUP4do
	 LAwaE9R0Orht2xtrG8zzYjU53rGnyLZ0qg9rKF396Q2xoHisLwbiPd2JY95YzuK/UWxFV
	 b4njHWXnt6bkIfoSYXdy/20XHwCFI+iYXtkU2zUW1MsGIPWpv4NW2b5Ih5X9VtgDIYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309198;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5blMgoBP0rICIuH/UYufNrjnwQHz9NNj7WSk+4g5PdA=;
	b=EixpTyMseRdvVSU5ZXcMzGlAUXd7bEhHxruRMPjMesAP0EmyIr6L5CXbOlDty97H8+fp
	 q35ZTDyEWA85DjVrw8hiK/K7A9Kk996t4xOhFR8n54E7XIAm7A8Ufw4fO8tZ8IJb7jmW3
	 pwFMwUJ6TbyechT25ldvdDedYEAzrE1PEywbRZemdCBP9d+zPTNEUb8NfdRv8xfpzkbgJ
	 wLt2Uuch2ZxZyE+GJTqM3oDdq/Wi3UyiwmDCZAtDQRQWvJMDLkpTBGmiUKL8patQqVsvJ
	 IoTg+y8oMsSBM2sDkoiLpn2UOKWIdJxLHMwh16jz3rG35EwuSUZedWnfSYHQu882VMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LMlAPzA/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD286606A31D
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMlAPzA/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAE01F01816;
	Thu, 29 Oct 2026 21:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309197;
	bh=5blMgoBP0rICIuH/UYufNrjnwQHz9NNj7WSk+4g5PdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LMlAPzA/v5n9cD2RIi/AaDnxrFqTzT2B1cWbHqCSg2ea4FAkuUNaXOyDBj5fmdJOT
	 2/GupRcRcgyRf0Avznr31ciy3JyLx1es/iu5FDR4G7xVw7UPga5yMsun/qt/eQV9TQ
	 cHLriz2cvO+582oJSWS6vkWmV/Ca5NrguJqwFlbfYV0cyNH+JRFEJTB4ZBSAxhChJi
	 nLbZZ7RSXLz1tLxd9XO0fcBuqlkZmsPJakK2jr3K3DFeSrpuyQMNuzKX6PHQ/Ddvcm
	 1947+Bp2SuvpGbNpM3nIY95G/0vpu3jETDi+UA4oVE/y/EQMF9FWCAGzO78EBhGAdG
	 madVkYDQuCN4w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: [PATCH bpf-next 4/8] selftests/bpf: Test __srcptr kfunc arguments
Date: Thu, 29 Oct 2026 22:25:47 +0100
Message-ID: <20261029212551.56964-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029212551.56964-1-jolsa@kernel.org>
References: <20261029212551.56964-1-jolsa@kernel.org>
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

Verify that __srcptr kfunc arguments accept read-only global data,
writable stack data, and a pointer to a read-only struct of scalars.

Also verify that read-only data is rejected when passed to a kfunc
argument that requires writable memory.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/kfunc_call.c  |  2 ++
 .../testing/selftests/bpf/progs/kfunc_call_fail.c  | 10 ++++++++++
 .../testing/selftests/bpf/progs/kfunc_call_test.c  | 14 ++++++++++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 10 ++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |  2 ++
 5 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index 0063e60d6f2f..9b832c5961f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -63,6 +63,7 @@ static struct kfunc_test_params kfunc_tests[] = {
 	 */
 	SYSCALL_NULL_CTX_FAIL(kfunc_syscall_test_fail, -EINVAL, "processed 4 insns"),
 	SYSCALL_NULL_CTX_FAIL(kfunc_syscall_test_null_fail, -EINVAL, "processed 4 insns"),
+	TC_FAIL(kfunc_call_test_mem_len_fail_readonly, 0, "write into map forbidden"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_rdonly, 0, "R0 cannot write into rdonly_mem"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_use_after_free, 0, "invalid mem access 'scalar'"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_oob, 0, "min value is outside of the allowed memory range"),
@@ -82,6 +83,7 @@ static struct kfunc_test_params kfunc_tests[] = {
 	TC_TEST(kfunc_call_test5_asm, 0),
 	TC_TEST(kfunc_call_test_ref_btf_id, 0),
 	TC_TEST(kfunc_call_test_get_mem, 42),
+	TC_TEST(kfunc_call_test_srcptr, 0),
 	SYSCALL_TEST(kfunc_syscall_test, 0),
 	SYSCALL_NULL_CTX_TEST(kfunc_syscall_test_null, 0),
 	TC_TEST(kfunc_call_test_static_unused_arg, 0),
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
index 7e93f7fb1329..1ab85faaf8db 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
@@ -4,6 +4,8 @@
 #include <bpf/bpf_helpers.h>
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
+static const char mem_len_rodata[] = "read-only data";
+
 static struct bpf_spin_lock kfunc_call_lock SEC(".data.A");
 
 SEC("?tc")
@@ -47,6 +49,14 @@ int kfunc_syscall_test_null_fail(struct syscall_test_args *args)
 	return 0;
 }
 
+SEC("?tc")
+int kfunc_call_test_mem_len_fail_readonly(struct __sk_buff *skb)
+{
+	bpf_kfunc_call_test_mem_len_pass1((void *)mem_len_rodata,
+					  sizeof(mem_len_rodata));
+	return 0;
+}
+
 SEC("?tc")
 int kfunc_call_test_get_mem_fail_rdonly(struct __sk_buff *skb)
 {
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index 8e6560c31e78..fc862fce3f2f 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -5,6 +5,9 @@
 #include "bpf_misc.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
+static const char srcptr_rodata[] = "read-only source";
+static const struct prog_test_pass1 srcptr_struct_rodata = { .x0 = 1 };
+
 static struct bpf_spin_lock kfunc_call_lock SEC(".data.A");
 
 SEC("tc")
@@ -208,6 +211,17 @@ int kfunc_call_test_pass(struct __sk_buff *skb)
 	return 0;
 }
 
+SEC("tc")
+int kfunc_call_test_srcptr(struct __sk_buff *skb)
+{
+	char stack_data[] = "read-write source";
+
+	bpf_kfunc_call_test_srcptr(srcptr_rodata, sizeof(srcptr_rodata));
+	bpf_kfunc_call_test_srcptr(stack_data, sizeof(stack_data));
+	bpf_kfunc_call_test_srcptr_struct(&srcptr_struct_rodata);
+	return 0;
+}
+
 struct syscall_test_args {
 	__u8 data[16];
 	size_t size;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 6380f52f4dd2..87967c7236a7 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1024,6 +1024,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_arena_args5_test)
 BTF_ID_FLAGS(func, bpf_kfunc_arena_stack_arg_test)
 BTF_ID_FLAGS(func, bpf_kfunc_arena_mixed_test)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_srcptr)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_srcptr_struct)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_zero_offset_test, KF_ACQUIRE)
@@ -1527,6 +1529,14 @@ __bpf_kfunc void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
 {
 }
 
+__bpf_kfunc void bpf_kfunc_call_test_srcptr(const void *src__srcptr, int src__sz)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_call_test_srcptr_struct(const struct prog_test_pass1 *p__srcptr)
+{
+}
+
 __bpf_kfunc void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
 {
 }
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 3b810f1e438f..6de080682618 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -198,6 +198,8 @@ void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
 void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p) __ksym;
 
 void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
+void bpf_kfunc_call_test_srcptr(const void *src__srcptr, int src__sz) __ksym;
+void bpf_kfunc_call_test_srcptr_struct(const struct prog_test_pass1 *p__srcptr) __ksym;
 __u64 bpf_kfunc_arena_arg_test(__u64 *val__arena) __ksym;
 __u64 bpf_kfunc_arena_cap_test(__u64 *val__arena) __ksym;
 __u64 bpf_kfunc_arena_cap_nullable_test(__u64 *val__arena__nullable) __ksym;
-- 
2.54.0

