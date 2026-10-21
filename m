Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612743;
	b=LDIeWD9Ssg4GHV0B3l409gPnFFn6tl8XJZwxu3r8v3QwfR3h2wThTY3G6ujZesGqX1ea
	 FB2H4Y3rlSyYELhbLlJLrZBHjjGdovsEFEWdf9Bg4HWtLL8/5R3sGo6gX6cLPIJV9K4kH
	 qvD+ndM3XneBue//smFNHS9hImkb8GSOvqaDUyZJrflZgyCsJZ4biTiIUILCw4ORg6OgO
	 F9tWnyENsjCXhK8ip5TsFjF8754rlxteWPLBuft/vMIYD6sUKZtrFhtLepxPc9+ZDwFBW
	 5T0WpDddj2zQh4Yn0ZZRx/rmfwElw8bR9IivyjpLkhUXVYHC76ctFOCOvxhwim/AXnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612743;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2xbtEJ7CZhaLOgThbWGPoTOo9rCIMzg+aSiILL7GT3I=;
	b=MvonBmqjqvgiqK99bWVZL1ar+sv1S6vU0m3+mB8rfJeQwU15GtaO5Eg9oCWXNG9ayBBQ
	 LEcQZBW9wQ+mlnm1fRUT1Xa83yw1nCpv8oNK7l+21UdhlToxvLpczCvOfpUe4G71NrWcZ
	 mfO8bkf7bFSeen1skvJBuWasM+y25Cv5BG2COUMr40ztV/XK2P4V5IFweLaoSL5pxeJM9
	 difyhRWqfv8sK82oXJSnWzJDeCHQzfi3GukCIuN1xyJD+Tf7WTP027hFvOtj4zhNdY6WT
	 xwq+KjcR1M96FJCtnsPOEfOh84mZ4rXmLqUzEISfMQFyqTKAHDYwwiHHYWwc3LrClRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byOdch+K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346E606A31B;
	Wed, 21 Oct 2026 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byOdch+K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4918E1F000C1;
	Wed, 21 Oct 2026 19:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792612742;
	bh=2xbtEJ7CZhaLOgThbWGPoTOo9rCIMzg+aSiILL7GT3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=byOdch+K6VCuXwjsPgOyFHhwtPhNGXX7T1/mAeqD8RDsWfsK/TLqignAdIMLi1Dwb
	 1J7a81cWkky9XfR+hKPSssRBJJ9bJceSRkqppuKusPW7tXNcGTxebIrWFfQErCXaCz
	 jNTXbxAksL1yFzpkEkn9zKTma+9SBkKeNaEzuVRNeFS/rpMytgAl1X/ujAqIpUMXfk
	 iLv+RUZU9KszPlcdNK5b4BIS/9wsALQYfMwxwtmBqt3wOwdcVqD3S02jm8dELnKfXm
	 pKifqrN9xELz/D0FjfOo8Jfh6qFRsPZw9FSDyd8aftazxzxeQhwVcrFg9YKG8FN66G
	 mn+adC+hNTRNA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [RFC bpf-next 5/9] selftests/bpf: Add __srcptr kfunc arguments test
Date: Wed, 21 Oct 2026 21:57:54 +0200
Message-ID: <20261021195759.119421-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021195759.119421-1-jolsa@kernel.org>
References: <20261021195759.119421-1-jolsa@kernel.org>
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

Add positive kfunc tests for read-only global and writable stack sources
annotated with __srcptr. Also verify that a read-only source is rejected
when passed to a writable mem_len argument.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c  |  2 ++
 tools/testing/selftests/bpf/progs/kfunc_call_fail.c  | 10 ++++++++++
 tools/testing/selftests/bpf/progs/kfunc_call_test.c  | 12 ++++++++++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c |  5 +++++
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h     |  1 +
 5 files changed, 30 insertions(+)

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
index 8e6560c31e78..b944e2e186b6 100644
--- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
+++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
@@ -5,6 +5,8 @@
 #include "bpf_misc.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
+static const char srcptr_rodata[] = "read-only source";
+
 static struct bpf_spin_lock kfunc_call_lock SEC(".data.A");
 
 SEC("tc")
@@ -208,6 +210,16 @@ int kfunc_call_test_pass(struct __sk_buff *skb)
 	return 0;
 }
 
+SEC("tc")
+int kfunc_call_test_srcptr(struct __sk_buff *skb)
+{
+	char stack_data[] = "read-write source";
+
+	bpf_kfunc_call_test_srcptr(srcptr_rodata, sizeof(srcptr_rodata));
+	bpf_kfunc_call_test_srcptr(stack_data, sizeof(stack_data));
+	return 0;
+}
+
 struct syscall_test_args {
 	__u8 data[16];
 	size_t size;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 6380f52f4dd2..5d72f94a8912 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1024,6 +1024,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_arena_args5_test)
 BTF_ID_FLAGS(func, bpf_kfunc_arena_stack_arg_test)
 BTF_ID_FLAGS(func, bpf_kfunc_arena_mixed_test)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_srcptr)
 BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQUIRE)
 BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_zero_offset_test, KF_ACQUIRE)
@@ -1527,6 +1528,10 @@ __bpf_kfunc void bpf_kfunc_call_test_mem_len_pass1(void *mem, int mem__sz)
 {
 }
 
+__bpf_kfunc void bpf_kfunc_call_test_srcptr(const void *src__srcptr, int src__sz)
+{
+}
+
 __bpf_kfunc void bpf_kfunc_call_test_mem_len_fail1(void *mem, int len)
 {
 }
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 3b810f1e438f..919c4c450ef1 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -198,6 +198,7 @@ void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p) __ksym;
 void bpf_kfunc_call_test_ref(struct prog_test_ref_kfunc *p) __ksym;
 
 void bpf_kfunc_call_test_mem_len_pass1(void *mem, int len) __ksym;
+void bpf_kfunc_call_test_srcptr(const void *src__srcptr, int src__sz) __ksym;
 __u64 bpf_kfunc_arena_arg_test(__u64 *val__arena) __ksym;
 __u64 bpf_kfunc_arena_cap_test(__u64 *val__arena) __ksym;
 __u64 bpf_kfunc_arena_cap_nullable_test(__u64 *val__arena__nullable) __ksym;
-- 
2.54.0

