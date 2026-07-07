Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9787D18B0F
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461711; cv=none; b=ObmMVOKgJVBiIwmDw4PWcZAB5ATxbk5JYwFKVYdDCjxwXjyRcFdkJYk8w+gorPYsZs1XQLFNY+6HWpFJ/lcrHObUaSsiFVen0Jw3wwiTg98U/ThIwGEYiOdWj1a4Z33VyxPwHQyGA6YWe9GhnNc0kPkK0bPClNqtV8IsP6jSrWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461711; c=relaxed/simple;
	bh=EH7BGEd7IPxkBwudBIoOYABW/r7rttT0SB3BnUl4FiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0pAGEbCTP3svcfpeCZ3ZYJqf0RDP5x0hGo9vBoOBxxguKGrWl50DJpX18AsGDUsUZOZLk2Uad+BRp9IvRibltLDBV0URFDIZZh45fl9rs91hmFJCBp/n0nSXPkPe/P/4NjGJgDq/6qcA0ej6rxs7kRlHHZMrElYjac2DKYG4DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 084711CDFD9C58; Tue,  7 Jul 2026 15:01:36 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next] selftests/bpf: Rename libarena struct bitmap to struct arena_bitmap
Date: Tue,  7 Jul 2026 15:01:36 -0700
Message-ID: <20260707220136.910374-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When building bpf selftest with latest bpf-next, I got the following fail=
ure:

  In file included from /home/yhs/work/bpf-next/tools/testing/selftests/b=
pf/libarena/selftests/test_parallel_bitmap.bpf.c:8:
  /home/yhs/work/bpf-next/tools/testing/selftests/bpf/libarena/include/li=
barena/bitmap.h:11:8: error: redefinition of
        'bitmap'
     11 | struct bitmap {
        |        ^
  /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include/vmlin=
ux.h:51320:8: note: previous definition is here
   51320 | struct bitmap {
         |        ^

The vmlinux.h struct bitmap comes from drivers/md/md-bitmap.c:
  struct bitmap {
	struct bitmap_counts { ... }
	...
  }

To fix the issue, I renamed libarena struct bitmap to arena_bitmap to avo=
id the conflict.

Cc: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/libarena/include/libarena/bitmap.h    | 36 +++++++++---------
 .../bpf/libarena/selftests/test_bitmap.bpf.c  | 24 ++++++------
 .../selftests/test_parallel_bitmap.bpf.c      |  2 +-
 .../selftests/bpf/libarena/src/bitmap.bpf.c   | 38 +++++++++----------
 4 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap=
.h b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
index cf6b63f5d9a4..e2431ea6fdd6 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/bitmap.h
@@ -8,27 +8,27 @@
 #define BIT_MASK(nr)		(1ULL << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG_LONG)
=20
-struct bitmap {
+struct arena_bitmap {
 	u64 bits[0];
 };
=20
-struct bitmap __arena *bmp_alloc(size_t bits);
-void bmp_free(struct bitmap __arena *bmp);
+struct arena_bitmap __arena *bmp_alloc(size_t bits);
+void bmp_free(struct arena_bitmap __arena *bmp);
=20
-void __bmp_set_bit(u32 bit, struct bitmap __arena *bmp);
-void __bmp_clear_bit(u32 bit, struct bitmap __arena *bmp);
-void bmp_set_bit(u32 bit, struct bitmap __arena *bmp);
-void bmp_clear_bit(u32 bit, struct bitmap __arena *bmp);
-bool bmp_test_bit(u32 bit, struct bitmap __arena *bmp);
-bool bmp_test_and_clear_bit(u32 bit, struct bitmap __arena *bmp);
-bool bmp_test_and_set_bit(u32 bit, struct bitmap __arena *bmp);
+void __bmp_set_bit(u32 bit, struct arena_bitmap __arena *bmp);
+void __bmp_clear_bit(u32 bit, struct arena_bitmap __arena *bmp);
+void bmp_set_bit(u32 bit, struct arena_bitmap __arena *bmp);
+void bmp_clear_bit(u32 bit, struct arena_bitmap __arena *bmp);
+bool bmp_test_bit(u32 bit, struct arena_bitmap __arena *bmp);
+bool bmp_test_and_clear_bit(u32 bit, struct arena_bitmap __arena *bmp);
+bool bmp_test_and_set_bit(u32 bit, struct arena_bitmap __arena *bmp);
=20
-void bmp_clear(size_t bits, struct bitmap __arena *bmp);
-void bmp_and(size_t bits, struct bitmap __arena *dst, struct bitmap __ar=
ena *src1, struct bitmap __arena *src2);
-void bmp_or(size_t bits, struct bitmap __arena *dst, struct bitmap __are=
na *src1, struct bitmap __arena *src2);
-bool bmp_empty(size_t bits, struct bitmap __arena *bmp);
-void bmp_copy(size_t bits, struct bitmap __arena *dst, struct bitmap __a=
rena *src);
+void bmp_clear(size_t bits, struct arena_bitmap __arena *bmp);
+void bmp_and(size_t bits, struct arena_bitmap __arena *dst, struct arena=
_bitmap __arena *src1, struct arena_bitmap __arena *src2);
+void bmp_or(size_t bits, struct arena_bitmap __arena *dst, struct arena_=
bitmap __arena *src1, struct arena_bitmap __arena *src2);
+bool bmp_empty(size_t bits, struct arena_bitmap __arena *bmp);
+void bmp_copy(size_t bits, struct arena_bitmap __arena *dst, struct aren=
a_bitmap __arena *src);
=20
-bool bmp_intersects(size_t bits, struct bitmap __arena *arg1, struct bit=
map __arena *arg2);
-bool bmp_subset(size_t bits, struct bitmap __arena *big, struct bitmap _=
_arena *small);
-void bmp_print(size_t bits, struct bitmap __arena *bmp);
+bool bmp_intersects(size_t bits, struct arena_bitmap __arena *arg1, stru=
ct arena_bitmap __arena *arg2);
+bool bmp_subset(size_t bits, struct arena_bitmap __arena *big, struct ar=
ena_bitmap __arena *small);
+void bmp_print(size_t bits, struct arena_bitmap __arena *bmp);
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.b=
pf.c b/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
index e7d32f44d687..76319a529f02 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_bitmap.bpf.c
@@ -8,7 +8,7 @@
 #define MID_BIT		(BITS_PER_LONG_LONG + 1)
 #define LAST_BIT	(TEST_BITS - 1)
=20
-static void test_bmp_setall(struct bitmap __arena *bmp)
+static void test_bmp_setall(struct arena_bitmap __arena *bmp)
 {
 	volatile u32 i;
=20
@@ -19,7 +19,7 @@ static void test_bmp_setall(struct bitmap __arena *bmp)
 SEC("syscall")
 __weak int test_bitmap_alloc_free(void)
 {
-	struct bitmap __arena *bmp;
+	struct arena_bitmap __arena *bmp;
=20
 	bmp =3D bmp_alloc(TEST_BITS);
 	if (!bmp)
@@ -47,7 +47,7 @@ __weak int test_bitmap_alloc_free(void)
 SEC("syscall")
 __weak int test_bitmap_bit_ops(void)
 {
-	struct bitmap __arena *bmp;
+	struct arena_bitmap __arena *bmp;
=20
 	bmp =3D bmp_alloc(TEST_BITS);
 	if (!bmp)
@@ -97,7 +97,7 @@ __weak int test_bitmap_bit_ops(void)
 	return -EINVAL;
 }
=20
-static bool test_bitmap_test_and_clear_single(struct bitmap __arena *bmp=
, size_t ind)
+static bool test_bitmap_test_and_clear_single(struct arena_bitmap __aren=
a *bmp, size_t ind)
 {
 	if (bmp_test_and_clear_bit(ind, bmp))
 		return false;
@@ -116,7 +116,7 @@ static bool test_bitmap_test_and_clear_single(struct =
bitmap __arena *bmp, size_t
 	return true;
 }
=20
-static bool test_bitmap_test_and_set_single(struct bitmap __arena *bmp, =
size_t ind)
+static bool test_bitmap_test_and_set_single(struct arena_bitmap __arena =
*bmp, size_t ind)
 {
 	if (bmp_test_and_set_bit(ind, bmp))
 		return false;
@@ -138,7 +138,7 @@ static bool test_bitmap_test_and_set_single(struct bi=
tmap __arena *bmp, size_t i
 SEC("syscall")
 __weak int test_bitmap_test_and_clear_bit(void)
 {
-	struct bitmap __arena *bmp;
+	struct arena_bitmap __arena *bmp;
=20
 	bmp =3D bmp_alloc(TEST_BITS);
 	if (!bmp)
@@ -167,7 +167,7 @@ __weak int test_bitmap_test_and_clear_bit(void)
 SEC("syscall")
 __weak int test_bitmap_test_and_set_bit(void)
 {
-	struct bitmap __arena *bmp;
+	struct arena_bitmap __arena *bmp;
=20
 	bmp =3D bmp_alloc(TEST_BITS);
 	if (!bmp)
@@ -194,7 +194,7 @@ __weak int test_bitmap_test_and_set_bit(void)
 SEC("syscall")
 __weak int test_bitmap_and(void)
 {
-	struct bitmap __arena *src1 =3D NULL, *src2 =3D NULL, *dst =3D NULL;
+	struct arena_bitmap __arena *src1 =3D NULL, *src2 =3D NULL, *dst =3D NU=
LL;
=20
 	src1 =3D bmp_alloc(TEST_BITS);
 	src2 =3D bmp_alloc(TEST_BITS);
@@ -240,7 +240,7 @@ __weak int test_bitmap_and(void)
 SEC("syscall")
 __weak int test_bitmap_or(void)
 {
-	struct bitmap __arena *src1 =3D NULL, *src2 =3D NULL, *dst =3D NULL;
+	struct arena_bitmap __arena *src1 =3D NULL, *src2 =3D NULL, *dst =3D NU=
LL;
=20
 	src1 =3D bmp_alloc(TEST_BITS);
 	src2 =3D bmp_alloc(TEST_BITS);
@@ -285,7 +285,7 @@ __weak int test_bitmap_or(void)
 SEC("syscall")
 __weak int test_bitmap_subset(void)
 {
-	struct bitmap __arena *big =3D NULL, *small =3D NULL;
+	struct arena_bitmap __arena *big =3D NULL, *small =3D NULL;
=20
 	big =3D bmp_alloc(TEST_BITS);
 	small =3D bmp_alloc(TEST_BITS);
@@ -329,7 +329,7 @@ __weak int test_bitmap_subset(void)
 SEC("syscall")
 __weak int test_bitmap_intersects(void)
 {
-	struct bitmap __arena *arg1 =3D NULL, *arg2 =3D NULL;
+	struct arena_bitmap __arena *arg1 =3D NULL, *arg2 =3D NULL;
=20
 	arg1 =3D bmp_alloc(TEST_BITS);
 	arg2 =3D bmp_alloc(TEST_BITS);
@@ -362,7 +362,7 @@ __weak int test_bitmap_intersects(void)
 SEC("syscall")
 __weak int test_bitmap_copy(void)
 {
-	struct bitmap __arena *arg1 =3D NULL, *arg2 =3D NULL;
+	struct arena_bitmap __arena *arg1 =3D NULL, *arg2 =3D NULL;
=20
 	arg1 =3D bmp_alloc(TEST_BITS);
 	arg2 =3D bmp_alloc(TEST_BITS);
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel=
_bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_paral=
lel_bitmap.bpf.c
index eec2871e2b0d..ea1fac95b461 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap=
.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap=
.bpf.c
@@ -12,7 +12,7 @@
 #define TEST_BITMAP_SYNC_SPINS	BPF_MAX_LOOPS
 #define TEST_BITMAP_ITERS	10 * 1000 * 1000
=20
-static struct bitmap __arena *bitmap;
+static struct arena_bitmap __arena *bitmap;
 static volatile u64 started;
 static volatile bool test_abort;
=20
diff --git a/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/bitmap.bpf.c
index 80e814401fb9..5ff8e688ddc7 100644
--- a/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
@@ -10,16 +10,16 @@
 #include <libarena/bitmap.h>
=20
 __weak
-struct bitmap __arena *bmp_alloc(size_t bits)
+struct arena_bitmap __arena *bmp_alloc(size_t bits)
 {
-	struct bitmap __arena *bmp;
+	struct arena_bitmap __arena *bmp;
 	size_t size =3D BITS_TO_LONG_LONGS(bits) * sizeof(bmp->bits[0]);
=20
 	/* Assume long-aligned masks. */
 	if (bits % BITS_PER_LONG_LONG)
 		return NULL;
=20
-	bmp =3D (struct bitmap __arena *)arena_malloc(size);
+	bmp =3D (struct arena_bitmap __arena *)arena_malloc(size);
 	if (!bmp)
 		return NULL;
=20
@@ -29,31 +29,31 @@ struct bitmap __arena *bmp_alloc(size_t bits)
 }
=20
 __weak
-void bmp_free(struct bitmap __arena *bmp)
+void bmp_free(struct arena_bitmap __arena *bmp)
 {
 	arena_free(bmp);
 }
=20
 __weak
-void __bmp_set_bit(u32 bit, struct bitmap __arena *bmp)
+void __bmp_set_bit(u32 bit, struct arena_bitmap __arena *bmp)
 {
 	bmp->bits[BIT_WORD(bit)] |=3D BIT_MASK(bit);
 }
=20
 __weak
-void __bmp_clear_bit(u32 bit, struct bitmap __arena *bmp)
+void __bmp_clear_bit(u32 bit, struct arena_bitmap __arena *bmp)
 {
 	bmp->bits[BIT_WORD(bit)] &=3D ~BIT_MASK(bit);
 }
=20
 __weak
-bool bmp_test_bit(u32 bit, struct bitmap __arena *bmp)
+bool bmp_test_bit(u32 bit, struct arena_bitmap __arena *bmp)
 {
 	return bmp->bits[BIT_WORD(bit)] & BIT_MASK(bit);
 }
=20
 __weak
-bool bmp_test_and_clear_bit(u32 bit, struct bitmap __arena *bmp)
+bool bmp_test_and_clear_bit(u32 bit, struct arena_bitmap __arena *bmp)
 {
 	u64 val =3D BIT_MASK(bit);
 	u32 idx =3D BIT_WORD(bit);
@@ -77,7 +77,7 @@ bool bmp_test_and_clear_bit(u32 bit, struct bitmap __ar=
ena *bmp)
 }
=20
 __weak
-bool bmp_test_and_set_bit(u32 bit, struct bitmap __arena *bmp)
+bool bmp_test_and_set_bit(u32 bit, struct arena_bitmap __arena *bmp)
 {
 	u64 val =3D BIT_MASK(bit);
 	u32 idx =3D BIT_WORD(bit);
@@ -101,7 +101,7 @@ bool bmp_test_and_set_bit(u32 bit, struct bitmap __ar=
ena *bmp)
 }
=20
 __weak
-void bmp_clear_bit(u32 bit, struct bitmap __arena *bmp)
+void bmp_clear_bit(u32 bit, struct arena_bitmap __arena *bmp)
 {
 	u64 val =3D BIT_MASK(bit);
 	u32 idx =3D BIT_WORD(bit);
@@ -116,7 +116,7 @@ void bmp_clear_bit(u32 bit, struct bitmap __arena *bm=
p)
 }
=20
 __weak
-void bmp_set_bit(u32 bit, struct bitmap __arena *bmp)
+void bmp_set_bit(u32 bit, struct arena_bitmap __arena *bmp)
 {
 	u64 val =3D BIT_MASK(bit);
 	u32 idx =3D BIT_WORD(bit);
@@ -131,7 +131,7 @@ void bmp_set_bit(u32 bit, struct bitmap __arena *bmp)
 }
=20
 __weak
-void bmp_clear(size_t bits, struct bitmap __arena *bmp)
+void bmp_clear(size_t bits, struct arena_bitmap __arena *bmp)
 {
 	size_t nwords =3D BITS_TO_LONG_LONGS(bits);
 	volatile u32 i;
@@ -148,7 +148,7 @@ static __always_inline u64 bmp_last_word_mask(size_t =
bits)
 }
=20
 __weak
-void bmp_and(size_t bits, struct bitmap __arena *dst, struct bitmap __ar=
ena *src1, struct bitmap __arena *src2)
+void bmp_and(size_t bits, struct arena_bitmap __arena *dst, struct arena=
_bitmap __arena *src1, struct arena_bitmap __arena *src2)
 {
 	size_t nwords =3D BITS_TO_LONG_LONGS(bits);
 	volatile u32 i;
@@ -161,7 +161,7 @@ void bmp_and(size_t bits, struct bitmap __arena *dst,=
 struct bitmap __arena *src
 }
=20
 __weak
-void bmp_or(size_t bits, struct bitmap __arena *dst, struct bitmap __are=
na *src1, struct bitmap __arena *src2)
+void bmp_or(size_t bits, struct arena_bitmap __arena *dst, struct arena_=
bitmap __arena *src1, struct arena_bitmap __arena *src2)
 {
 	size_t nwords =3D BITS_TO_LONG_LONGS(bits);
 	volatile u32 i;
@@ -174,7 +174,7 @@ void bmp_or(size_t bits, struct bitmap __arena *dst, =
struct bitmap __arena *src1
 }
=20
 __weak
-bool bmp_empty(size_t bits, struct bitmap __arena *bmp)
+bool bmp_empty(size_t bits, struct arena_bitmap __arena *bmp)
 {
 	size_t nwords =3D BITS_TO_LONG_LONGS(bits);
 	volatile u32 i;
@@ -190,7 +190,7 @@ bool bmp_empty(size_t bits, struct bitmap __arena *bm=
p)
 }
=20
 __weak
-void bmp_copy(size_t bits, struct bitmap __arena *dst, struct bitmap __a=
rena *src)
+void bmp_copy(size_t bits, struct arena_bitmap __arena *dst, struct aren=
a_bitmap __arena *src)
 {
 	size_t nwords =3D BITS_TO_LONG_LONGS(bits);
 	volatile u32 i;
@@ -203,7 +203,7 @@ void bmp_copy(size_t bits, struct bitmap __arena *dst=
, struct bitmap __arena *sr
 }
=20
 __weak
-bool bmp_subset(size_t bits, struct bitmap __arena *big, struct bitmap _=
_arena *small)
+bool bmp_subset(size_t bits, struct arena_bitmap __arena *big, struct ar=
ena_bitmap __arena *small)
 {
 	size_t nwords =3D BITS_TO_LONG_LONGS(bits);
 	volatile u32 i;
@@ -219,7 +219,7 @@ bool bmp_subset(size_t bits, struct bitmap __arena *b=
ig, struct bitmap __arena *
 }
=20
 __weak
-bool bmp_intersects(size_t bits, struct bitmap __arena *arg1, struct bit=
map __arena *arg2)
+bool bmp_intersects(size_t bits, struct arena_bitmap __arena *arg1, stru=
ct arena_bitmap __arena *arg2)
 {
 	size_t nwords =3D BITS_TO_LONG_LONGS(bits);
 	volatile u32 i;
@@ -235,7 +235,7 @@ bool bmp_intersects(size_t bits, struct bitmap __aren=
a *arg1, struct bitmap __ar
 }
=20
 __weak
-void bmp_print(size_t bits, struct bitmap __arena *bmp)
+void bmp_print(size_t bits, struct arena_bitmap __arena *bmp)
 {
 	size_t nwords =3D BITS_TO_LONG_LONGS(bits);
 	volatile u32 i;
--=20
2.53.0-Meta

