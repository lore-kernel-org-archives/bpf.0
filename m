Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466D468C38;
	Mon, 24 Aug 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587577; cv=none; b=GDON+3OH8nWI88YhC+KSmjgw04sYtckhUG06rPHgcXsrYf3UKaTheo7Kmb0XVvIIHOAUHiTzBICA9PD8vjQy1ZiTLZGqHLv2+Q/eUaqTPs3Rx621dYYfP4rkeKPllzfHkz1DSjkLy6ousJhrShTeNvpk5QD1YCTru4Vrj2zd4mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587577; c=relaxed/simple;
	bh=Eti3rTlv+cxAVxk1vV0UCcKrMWkCOHT4UCvaZN/ysVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQYz4megbcGDIqh9xpebUlvnBF5gc5oZIr1uZXHC5jz+bH32B3ibB0KELrF2noCY6erL9QiHO1Em75PSmA2iPkP4WlckzD8gEboqYwhNn3b4xWuxFkSTtMBIDZvsVDkDML9Tr6j7OdePtWjrdwOC1pcB8zBEWSczXGvYgkJ3xDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=n5AF6xbs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="n5AF6xbs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BE991AC1;
	Mon, 24 Aug 2026 09:06:11 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 102303F85F;
	Mon, 24 Aug 2026 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787587575; bh=Eti3rTlv+cxAVxk1vV0UCcKrMWkCOHT4UCvaZN/ysVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5AF6xbsvYOJDb232Qg50DCemCE4qaYKTCUYp0BZbfqNZ6nujWbXQrRHrQjDCm99n
	 akrUnA9aq9/VXusaTW0mhrDpjwetDpb7unbe70ZAAywW7Ln4KarRk8gPk63sHOgK51
	 kLE5ugmLz2WbYPD7/SK3iKuatOMbzXplh0cSB1Mg=
From: Muhammad Usama Anjum <usama.anjum@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT - CORE)
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>
Subject: [PATCH 7/7] bpf: Batch TCO handling in string kfuncs
Date: Mon, 24 Aug 2026 17:04:53 +0100
Message-ID: <20260824160523.3907021-9-usama.anjum@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260824160523.3907021-1-usama.anjum@arm.com>
References: <20260824160523.3907021-1-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF string kfuncs cannot rely on NUL termination, so they scan memory with
kernel nofault loads. With Hardware Tag-Based KASAN in asynchronous or
asymmetric mode, every arm64 load sets and clears PSTATE.TCO.

Use bare loads and hold one nofault region across each string operation.
The scope guard restores TCO before page faults are enabled again on every
exit, including an access fault.

A character comparison performs two nofault loads. For N compared
characters, the number of dynamic MSR TCO executions therefore falls from
4N to 2.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 kernel/bpf/helpers.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3574a9a5721ec..f8c557161584e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3726,7 +3726,8 @@ __bpf_kfunc void __bpf_trap(void)
  *
  * Since strings are not necessarily %NUL-terminated, we cannot directly call
  * in-kernel implementations. Instead, we open-code the implementations using
- * __get_kernel_nofault instead of plain dereference to make them safe.
+ * __get_kernel_nofault_bare under guard(__kernel_nofault_bare)() to make them
+ * safe.
  */
 
 static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
@@ -3742,9 +3743,10 @@ static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, s
 		return 0;
 
 	guard(pagefault)();
+	guard(__kernel_nofault_bare)();
 	for (i = 0; i < len && i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&c1, s1, char, err_out);
-		__get_kernel_nofault(&c2, s2, char, err_out);
+		__get_kernel_nofault_bare(&c1, s1, char, err_out);
+		__get_kernel_nofault_bare(&c2, s2, char, err_out);
 		if (ignore_case) {
 			c1 = tolower(c1);
 			c2 = tolower(c2);
@@ -3843,8 +3845,9 @@ __bpf_kfunc int bpf_strnchr(const char *s__ign, size_t count, char c)
 		return -ENOENT;
 
 	guard(pagefault)();
+	guard(__kernel_nofault_bare)();
 	for (i = 0; i < count && i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&sc, s__ign, char, err_out);
+		__get_kernel_nofault_bare(&sc, s__ign, char, err_out);
 		if (sc == c)
 			return i;
 		if (sc == '\0')
@@ -3897,8 +3900,9 @@ __bpf_kfunc int bpf_strchrnul(const char *s__ign, char c)
 		return -ERANGE;
 
 	guard(pagefault)();
+	guard(__kernel_nofault_bare)();
 	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&sc, s__ign, char, err_out);
+		__get_kernel_nofault_bare(&sc, s__ign, char, err_out);
 		if (sc == '\0' || sc == c)
 			return i;
 		s__ign++;
@@ -3929,8 +3933,9 @@ __bpf_kfunc int bpf_strrchr(const char *s__ign, int c)
 		return -ERANGE;
 
 	guard(pagefault)();
+	guard(__kernel_nofault_bare)();
 	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&sc, s__ign, char, err_out);
+		__get_kernel_nofault_bare(&sc, s__ign, char, err_out);
 		if (sc == c)
 			last = i;
 		if (sc == '\0')
@@ -3964,8 +3969,9 @@ __bpf_kfunc int bpf_strnlen(const char *s__ign, size_t count)
 		return 0;
 
 	guard(pagefault)();
+	guard(__kernel_nofault_bare)();
 	for (i = 0; i < count && i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&c, s__ign, char, err_out);
+		__get_kernel_nofault_bare(&c, s__ign, char, err_out);
 		if (c == '\0')
 			return i;
 		s__ign++;
@@ -4014,12 +4020,13 @@ __bpf_kfunc int bpf_strspn(const char *s__ign, const char *accept__ign)
 	}
 
 	guard(pagefault)();
+	guard(__kernel_nofault_bare)();
 	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&cs, s__ign, char, err_out);
+		__get_kernel_nofault_bare(&cs, s__ign, char, err_out);
 		if (cs == '\0')
 			return i;
 		for (j = 0; j < XATTR_SIZE_MAX; j++) {
-			__get_kernel_nofault(&ca, accept__ign + j, char, err_out);
+			__get_kernel_nofault_bare(&ca, accept__ign + j, char, err_out);
 			if (cs == ca || ca == '\0')
 				break;
 		}
@@ -4058,12 +4065,13 @@ __bpf_kfunc int bpf_strcspn(const char *s__ign, const char *reject__ign)
 	}
 
 	guard(pagefault)();
+	guard(__kernel_nofault_bare)();
 	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		__get_kernel_nofault(&cs, s__ign, char, err_out);
+		__get_kernel_nofault_bare(&cs, s__ign, char, err_out);
 		if (cs == '\0')
 			return i;
 		for (j = 0; j < XATTR_SIZE_MAX; j++) {
-			__get_kernel_nofault(&cr, reject__ign + j, char, err_out);
+			__get_kernel_nofault_bare(&cr, reject__ign + j, char, err_out);
 			if (cs == cr || cr == '\0')
 				break;
 		}
@@ -4090,9 +4098,10 @@ static int __bpf_strnstr(const char *s1, const char *s2, size_t len,
 	}
 
 	guard(pagefault)();
+	guard(__kernel_nofault_bare)();
 	for (i = 0; i < XATTR_SIZE_MAX; i++) {
 		for (j = 0; i + j <= len && j < XATTR_SIZE_MAX; j++) {
-			__get_kernel_nofault(&c2, s2 + j, char, err_out);
+			__get_kernel_nofault_bare(&c2, s2 + j, char, err_out);
 			if (c2 == '\0')
 				return i;
 			/*
@@ -4102,7 +4111,7 @@ static int __bpf_strnstr(const char *s1, const char *s2, size_t len,
 			 */
 			if (i + j == len)
 				break;
-			__get_kernel_nofault(&c1, s1 + j, char, err_out);
+			__get_kernel_nofault_bare(&c1, s1 + j, char, err_out);
 
 			if (ignore_case) {
 				c1 = tolower(c1);
-- 
2.47.3

