Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EFB42F71F
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212148; cv=none; b=FwgdEFUCOHrZ9eDt9yiHoaBqoXzgvzNhZSEAIZFb+ZnH3zh9XTZnkTJbcNqXUqL4k1woBxCG+MPaNCk2b/TeGAWsv9BP2dVBb/9enDkMZK/9qsnqbItEpqDkoj+W3H7KcoV+Kwpcajh9cIXw3hH6yTqKD7fWyf3KTXFdBKh9UjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212148; c=relaxed/simple;
	bh=m2dzVoqI8XAWj2ycfPSQkIQLOjCvq6cIUNWx365btec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBQwoO/UwiOkL2FzR88zsWzsbbVXRNt0YSmGkcamXYB42dmDv+LbxDu1OEJCT1muPpak3WHY1UBIF/n6pZeul97lsQ2VsgATjUSnuxyJrddeHWONeNn2b/MVhV5dGXaqyIRz0t06jIyrXUFdBBJhI0dhxr47njw30Rsuk2Jj2Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gT6wB3S0; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gT6wB3S0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784212143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uoY/N/ojtKzgaX5M5kqWpsRSKeYM7+C0F5rloiA8XWo=;
	b=gT6wB3S0aIz17LheDmG0eppQnm+V6GWaAP744H/GDsf3i+wzSDCKGTpnnRKZB4APYqO88j
	y5LmP6jys50UmB93zBhZQEQ9FDDZc1XgL76YitCQFK3sw30qcOgj2B7uClapcctHjNh83c
	h0E0HCoFhz9BCdq9me627fi12a/LdWU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	memxor@gmail.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Woojin Ji <random6.xyz@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/3] selftests/bpf: Run arena tests serially
Date: Thu, 16 Jul 2026 22:24:59 +0800
Message-ID: <20260716142746.8794-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260716142746.8794-1-jiayuan.chen@linux.dev>
References: <20260716142746.8794-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Every arena reserves a 4GB kernel vmalloc region at creation. On a KASAN
build that eagerly populates ~512MB of shadow memory per arena. Running the
arena tests in parallel keeps several arenas alive at once, which exhausts
the memory of a small CI VM and trips the OOM killer during map creation.

Make the arena tests serial so at most one arena is alive at a time.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/arena_atomics.c      | 2 +-
 tools/testing/selftests/bpf/prog_tests/arena_direct_value.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/arena_htab.c         | 2 +-
 tools/testing/selftests/bpf/prog_tests/arena_list.c         | 2 +-
 tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c    | 2 +-
 tools/testing/selftests/bpf/prog_tests/arena_strsearch.c    | 2 +-
 tools/testing/selftests/bpf/prog_tests/libarena.c           | 2 +-
 tools/testing/selftests/bpf/prog_tests/libarena_asan.c      | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
index d98577a6babc..1ad5d03d07ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_atomics.c
@@ -222,7 +222,7 @@ static void test_store_release(struct arena_atomics *skel)
 		  "store_release64_result");
 }
 
-void test_arena_atomics(void)
+void serial_test_arena_atomics(void)
 {
 	struct arena_atomics *skel;
 	int err;
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c b/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
index 4b4adb3f4b71..01fcf4965ea4 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
@@ -66,7 +66,7 @@ static void test_arena_direct_value_one_past_end(void)
 	close(map_fd);
 }
 
-void test_arena_direct_value(void)
+void serial_test_arena_direct_value(void)
 {
 	if (test__start_subtest("one_past_end"))
 		test_arena_direct_value_one_past_end();
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_htab.c b/tools/testing/selftests/bpf/prog_tests/arena_htab.c
index d69fd2465f53..91ccf0402980 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_htab.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_htab.c
@@ -81,7 +81,7 @@ static void test_arena_htab_asm(void)
 	arena_htab_asm__destroy(skel);
 }
 
-void test_arena_htab(void)
+void serial_test_arena_htab(void)
 {
 	if (test__start_subtest("arena_htab_llvm"))
 		test_arena_htab_llvm();
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_list.c b/tools/testing/selftests/bpf/prog_tests/arena_list.c
index 4f2866a615ce..2648e06f53d0 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_list.c
@@ -68,7 +68,7 @@ static void test_arena_list_add_del(int cnt, bool nonsleepable)
 	arena_list__destroy(skel);
 }
 
-void test_arena_list(void)
+void serial_test_arena_list(void)
 {
 	if (test__start_subtest("arena_list_1"))
 		test_arena_list_add_del(1, false);
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
index acb9d53b5973..545b05d7a0aa 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
@@ -101,7 +101,7 @@ static void test_arena_spin_lock_size(int size)
 	return;
 }
 
-void test_arena_spin_lock(void)
+void serial_test_arena_spin_lock(void)
 {
 	repeat = 1000;
 	if (test__start_subtest("arena_spin_lock_1"))
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_strsearch.c b/tools/testing/selftests/bpf/prog_tests/arena_strsearch.c
index f81a0c066505..0c1c6cbfa0f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_strsearch.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_strsearch.c
@@ -23,7 +23,7 @@ static void test_arena_str(void)
 	arena_strsearch__destroy(skel);
 }
 
-void test_arena_strsearch(void)
+void serial_test_arena_strsearch(void)
 {
 	if (test__start_subtest("arena_strsearch"))
 		test_arena_str();
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/testing/selftests/bpf/prog_tests/libarena.c
index ba5a5a50f7c0..df7e4b8dc394 100644
--- a/tools/testing/selftests/bpf/prog_tests/libarena.c
+++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
@@ -202,7 +202,7 @@ static void run_libarena_parallel_test(struct libarena *skel, struct bpf_program
 	run_libarena_parallel_fini(skel, name, prefixlen);
 }
 
-void test_libarena(void)
+void serial_test_libarena(void)
 {
 	struct arena_alloc_reserve_args args;
 	struct libarena *skel;
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena_asan.c b/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
index f897405f701d..9c31b17dbf39 100644
--- a/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
+++ b/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
@@ -85,7 +85,7 @@ static void run_test(void)
  * Run the test depending on whether LLVM can compile arena ASAN
  * programs.
  */
-void test_libarena_asan(void)
+void serial_test_libarena_asan(void)
 {
 #ifdef HAS_BPF_ARENA_ASAN
 	run_test();
-- 
2.43.0

