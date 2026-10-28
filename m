Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220151;
	b=Sv7olBjSfrMrV4QsSr7HDlOXkh3AAt+3BmK6SqohYPzS2SYXZZOaST6Z0YXE6+K/dZxi
	 /UkSoPna4Exl1lhKpL7vdcCPZrBmsOKgVdm4m/ClnVH8CzCVGGFBqnma4NAxy7sGOVqI+
	 POl2qMMIYL3LJ/Rd90oEo5CDJS1uuZxlq2jag29ngol9mQwZLYDelP5oIdNmxNPeaClwC
	 JJV+yVPMhV4DiOK2IJr7F9oJ3RREqVxK+dvUfeMyHmLM5DjasaBABr8LNhZIn2ycNK9Y7
	 1H00Q/0ohdz+/EuASv+COjm1f2sfauv3NlQ1bsg0ywD+AanWLlB26PHefYKXfmwPHwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220151;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7GnlfLUqxLa1qmgtSzXk0awVKBaueQpZ17Sk9ik6AeA=;
	b=hf8noEhme76U5Z+iqS3fRx1oFFcFX9qLrdeb89o32PkcNjU8PpogaYp588QV0kuGCDou
	 FSJl+fPA3x4z0XTVCQav8HTBzV6ykE7gqCO2cxpIc+x1DneRw44lZz2ZIZEbmPVtkznHu
	 /tPKlKcLCCILyn3jVGJYbmQCmXfDCIEB7kecPqvwZNviJUaaYNhaCqFl/H9XMbTjUIWGn
	 XpcDJ42IfwhbgnYm7d0d+J/WMgBl7ZB6zQjxw2OlUpknYHjxmkniyENIGvLO9MewXi08Q
	 RAHhBR10PgZD/RHpjO7moGxBP7QqhIscEG1lwGBYI7ZIvJirRvi/1q+enNaFhss0Tvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c4msDS2s;
	arc=none smtp.remote-ip=95.215.58.83
Received: from mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5C60A2633
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 20:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3F5C60A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c4msDS2s
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UORUEyin/b189GkXIbkIRDcBj7As68zRxN9n/QHi4PI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793220148; v=1; x=1793824948;
 b=c4msDS2sot1RGFSfNhpZ+e+SR7BjFavMgqmZPXBMajM338gKxEVkNq1tjsCURN7ooo9ROmua
 pDjOK6w5kkGGwRYGRBaGokabPt2uOZJw0DVMPhAz/Zmzp6Yut41bHEw7zgvb64z4R9uJtinVQ2c
 QLAC46ktUzrwqvlrxjPoJd8g=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2c22f9e0759e8c61;
	Wed, 28 Oct 2026 20:42:28 +0000
X-Mizu-Trace-ID: 2c22f9e0759e8c61
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
Subject: [PATCH bpf-next v2 5/8] selftests/bpf: don't report arena tests as passing with an empty body
Date: Wed, 28 Oct 2026 13:41:55 -0700
Message-ID: <20261028204158.1021284-6-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028204158.1021284-1-vineet.gupta@linux.dev>
References: <20261028204158.1021284-1-vineet.gupta@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some arena tests put the __BPF_FEATURE_ADDR_SPACE_CAST guard inside the
function rather than around it, so without arena support the program
still exists, its body is empty, and __success __retval(0) is met by
doing nothing.  A reader sees

  #584/1	 verifier_arena/basic_alloc1_nosleep:OK

and concludes arena works.  That is worse than the tests which vanish
entirely, since nothing hints anything is missing.

The guard was never needed to compile those bodies: without the
feature __arena is still btf_type_tag("arena"), which every compiler
accepts.  What it avoided was the load failure that follows from no
addr_space_cast being emitted — but only for a body that dereferences
an arena pointer.  The arena kfuncs do not check theirs at all: the
address parameter of bpf_arena_{alloc,free,reserve}_pages() carries the
__ign suffix, get_kfunc_arg_type() returns ARG_IGNORE for it, and
check_func_arg() returns before any register type check.  So a test
that only passes pointers to those kfuncs needs no cast and runs fine.

test_loader checks skip_reason before it opens anything, so the body no
longer has to be empty to stay loadable: drop all 19 in-body guards.
They do not all need a tag in their place, which is why 19 guards go
and 7 tags arrive:

  6   dereference, so they get __skip_without_arena and report SKIP:
      basic_alloc1{,_nosleep}, basic_alloc2{,_nosleep}, big_alloc1,
      access_reserved
  11  never dereference, so they get no tag and run for real instead
      of reporting a vacuous OK
  2   big_alloc3 and big_alloc4, already inside the file's outer
      whole-program guard, so the in-body one was redundant

The 7th tag goes on check_arena_arg_ret(), which has no guard at all
and is the one verifier_arena subtest that really fails under a stock
GCC.

Measured on bpf-next with a stock bpf-gcc, for verifier_arena and
verifier_arena_large:

  verifier_arena/basic_alloc1            OK   -> SKIP
  verifier_arena/basic_alloc1_nosleep    OK   -> SKIP
  verifier_arena/basic_alloc2            OK   -> SKIP
  verifier_arena/basic_alloc2_nosleep    OK   -> SKIP
  verifier_arena_large/big_alloc1        OK   -> SKIP
  verifier_arena_large/access_reserved   OK   -> SKIP
  verifier_arena/check_arena_arg_ret     FAIL -> SKIP

the six that dereference stop claiming to pass, and check_arena_arg_ret
stops failing.  The eleven that do not dereference stay OK, having gone
from an empty body to actually running.

Removing the guards exposes the arena_base() calls they were hiding.
The previous patch made that macro opaque to GCC's -Warray-bounds, so
nothing is needed here beyond the guards going away.
arena_kfunc.c, verifier_arena_globals1.c and verifier_arena_globals2.c
have the same shape and are included here: nine more guards go, seven
more tags arrive, and seven more subtests go OK -> SKIP.  arena_kfunc.c
had six of those, the most of the three.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 .../testing/selftests/bpf/progs/arena_kfunc.c | 18 +++--------
 .../selftests/bpf/progs/verifier_arena.c      | 31 +++----------------
 .../bpf/progs/verifier_arena_globals1.c       |  6 ++--
 .../bpf/progs/verifier_arena_globals2.c       |  3 +-
 .../bpf/progs/verifier_arena_large.c          | 16 ++--------
 5 files changed, 14 insertions(+), 60 deletions(-)

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
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 3b3410802825..21b66d51c61e 100644
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
 
@@ -503,7 +482,6 @@ int arena_kfuncs_under_bpf_lock(void *ctx)
 	bpf_arena_free_pages(&arena, page, 1);
 
 	bpf_spin_unlock(&arena_bpf_test_lock);
-#endif
 
 	return 0;
 }
@@ -765,6 +743,7 @@ u32 __arena volatile *check_arena_arg_quals2(u32 volatile __arena *arg1, u32 __a
 
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
index 34f0a0f88e12..6ef99793cac1 100644
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
@@ -177,7 +172,6 @@ int free_reserved(void *ctx)
 	page = bpf_arena_alloc_pages(&arena, addr + __PAGE_SIZE, 2, NUMA_NO_NODE, 0);
 	if (!page)
 		return 3;
-#endif
 	return 0;
 }
 
@@ -292,7 +286,6 @@ SEC("socket")
 __success __retval(0)
 int big_alloc3(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *pages;
 	u64 i;
 	int err = 0;
@@ -314,8 +307,6 @@ int big_alloc3(void *ctx)
 
 	bpf_arena_free_pages(&arena, pages, LARGE_PAGE_CNT);
 	return err;
-#endif
-	return 0;
 }
 
 /* SYSCALL programs are always sleepable. */
@@ -323,7 +314,6 @@ SEC("syscall")
 __success __retval(0)
 int big_alloc4(void *ctx)
 {
-#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	char __arena *pages;
 	u64 i;
 	int err = 0;
@@ -345,8 +335,6 @@ int big_alloc4(void *ctx)
 
 	bpf_arena_free_pages(&arena, pages, LARGE_PAGE_CNT);
 	return err;
-#endif
-	return 0;
 }
 #else
 
-- 
2.53.0-Meta

