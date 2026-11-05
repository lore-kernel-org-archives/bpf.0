Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874269;
	b=5cbtlvp60w1QcVGYNPUE5+wJbmqU30Zywhyhs/LwHUlCCxMrjEE3E2eq7mV6lXdCJXii
	 eGxxKRzv4JZ3E8IjntlofcN/aHj20U7ofWjeYpyeUWhz+d/WqL2w/q7GIZR1zDD55iNa/
	 W/Pr4gCA6FFeOSVBMKgLDklpkWlYhQwpESF8pQ8LAsCeNW3prFQLg27ijbG5HoM2GnjlH
	 YS413O6N9lzrEk/9VkcUSjMI1yohJedSdg9RfjReeSLruKrox1o5dqtbgm9ZdXVT7xf5d
	 GktE82YQx22lYInySRDrXzzf/u/oLErGMhWBL7uHAdNLC2kFINA2thtzIYDkfarpkIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874269;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aWC1fpeZM+QP/64/LlbIQvYUrFOSEHGeQ7yKHlmi7Q4=;
	b=voqIu+sAbbLJaHGhCjgNs/UFtrU1US7j9mzbFktzfMwBxReu/vdDHXPLr21fXRH/+kwF
	 CLc5Rwdfy44+UVhFTVLiJVHhdtPXa6lKE0ridclMPMxM3fcf13fz+MfEDUNoaIcmMClna
	 VJqkdpYDpeSF4v6x3mvxFmHEZsXfFBvyYJn6fAqvbGDeXxtDx8AqwWrUFmRMEucUezMc+
	 mReUYt/TL/FpXxj/NYg73HtOLI7SAxsoUg3xVAIL6JQbyTTjELVyQhamDoYqOC5JaACA5
	 nvtjjLMuvQRHX4ZEapROTBafvp1loMt0wWcFDW/LpJCY7g6q5eX9Vzqgzq/b0AphvUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PvrlS2RW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBB606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PvrlS2RW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB141F000C1;
	Thu,  5 Nov 2026 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874268;
	bh=aWC1fpeZM+QP/64/LlbIQvYUrFOSEHGeQ7yKHlmi7Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PvrlS2RWgoBlYHhRbQrzIuQyJVAFuCu+bZv9Cfk800sCPW8P+l4+/Yz0JFzGfU5pQ
	 zMveaNA84cLq42MOcPiqkms5RcfFvLWJqrIGNO23P1AVPilD2XIKjbQtH3xZcvGZQY
	 0WY8UNzV0GwPzVzV3RzOnbeiwTiWxFaziOCIJlJebLwtR4E3ROWmxxCe9h7Jsor361
	 Rc48aftWaHsPmDYJVkBzl3JlDaAtXaf9Pbdve3awJTwgW2tSBiT05/w1uJ8k3GgZUf
	 E5xVdoe4XqOzLs48iqhlw36NdIniUtjH4NzJtZNfoN1Ukhkt59TKQLZInXlvOu8Ji9
	 nTkFjnQK88bGg==
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
Subject: [PATCHv3 bpf-next 4/8] selftests/bpf: Test const kfunc memory arguments
Date: Thu,  5 Nov 2026 11:23:38 +0100
Message-ID: <20261105102343.311331-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105102343.311331-1-jolsa@kernel.org>
References: <20261105102343.311331-1-jolsa@kernel.org>
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

Verify that const kfunc arguments accept read-only global data,
writable stack data, and const scalar structs. Check that read-only
data is rejected when passed to a writable memory argument.

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
index 0063e60d6f2f..f2152591982b 100644
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
+	TC_TEST(kfunc_call_test_const_mem, 0),
 	SYSCALL_TEST(kfunc_syscall_test, 0),
 	SYSCALL_NULL_CTX_TEST(kfunc_syscall_test_null, 0),
 	TC_TEST(kfunc_call_test_static_unused_arg, 0),
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
index 7e93f7fb1329..bef956d3f89e 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_fail.c
@@ -4,6 +4,8 @@
 #include <bpf/bpf_helpers.h>
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
+static const char kfunc_mem_rodata[] = "read-only data";
+
 static struct bpf_spin_lock kfunc_call_lock SEC(".data.A");
 
 SEC("?tc")
@@ -47,6 +49,14 @@ int kfunc_syscall_test_null_fail(struct syscall_test_args *args)
 	return 0;
 }
 
+SEC("?tc")
+int kfunc_call_test_mem_len_fail_readonly(struct __sk_buff *skb)
+{
+	bpf_kfunc_call_test_mem_len_pass1((void *)kfunc_mem_rodata,
+					  sizeof(kfunc_mem_rodata));
+	return 0;
+}
+
 SEC("?tc")
 int kfunc_call_test_get_mem_fail_rdonly(struct __sk_buff *skb)
 {
diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
index 8e6560c31e78..4f4a6713aa6e 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -5,6 +5,9 @@
 #include "bpf_misc.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
+static const char kfunc_const_data[] = "read-only source";
+static const struct prog_test_pass1 kfunc_const_struct = { .x0 = 1 };
+
 static struct bpf_spin_lock kfunc_call_lock SEC(".data.A");
 
 SEC("tc")
@@ -208,6 +211,17 @@ int kfunc_call_test_pass(struct __sk_buff *skb)
 	return 0;
 }
 
+SEC("tc")
+int kfunc_call_test_const_mem(struct __sk_buff *skb)
+{
+	char stack_data[] = "read-write";
+
+	bpf_kfunc_call_test_const_mem(kfunc_const_data, sizeof(kfunc_const_data));
+	bpf_kfunc_call_test_const_mem(stack_data, sizeof(stack_data));
+	bpf_kfunc_call_test_const_struct(&kfunc_const_struct);
+	return 0;
+}
+
 struct syscall_test_args {
 	__u8 data[16];
 	size_t size;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 76fbe64755ef..41ff36f0ca77 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1049,6 +1049,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_arena_args5_test)
 BTF_ID_FLAGS(func, bpf_kfunc_arena_stack_arg_test)
 BTF_ID_FLAGS(func, bpf_kfunc_arena_mixed_test)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_const_mem)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_const_struct)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_zero_offset_test, KF_ACQUIRE)
@@ -1552,6 +1554,14 @@ __bpf_kfunc void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
 {
 }
 
+__bpf_kfunc void bpf_kfunc_call_test_const_mem(const void *mem, int mem__sz)
+{
+}
+
+__bpf_kfunc void bpf_kfunc_call_test_const_struct(const struct prog_test_pass1 *p)
+{
+}
+
 __bpf_kfunc void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
 {
 }
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index e9902e651d72..0a7df1798603 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -203,6 +203,8 @@ void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
 void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p) __ksym;
 
 void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
+void bpf_kfunc_call_test_const_mem(const void *mem, int mem__sz) __ksym;
+void bpf_kfunc_call_test_const_struct(const struct prog_test_pass1 *p) __ksym;
 __u64 bpf_kfunc_arena_arg_test(__u64 *val__arena) __ksym;
 __u64 bpf_kfunc_arena_cap_test(__u64 *val__arena) __ksym;
 __u64 bpf_kfunc_arena_cap_nullable_test(__u64 *val__arena__nullable) __ksym;
-- 
2.43.0

