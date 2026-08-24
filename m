Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D41A36B90D;
	Mon, 24 Aug 2026 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587554; cv=none; b=ECKQVoOoAQNpKAoiAasmwKgkPzyDI7/7I7o4c4sY03cB5s+SmDDG1NO3VcfITeKhRYuxvBp3YNKXSiw72d2QvwTz0oPnJE7vj3wn+w7ex4zIk5xfHjRM0wEWeW0uSiwJhc8IEnggeBywhnjUtxJPB0dQHcSTaSrQ9DFMiAKbOtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587554; c=relaxed/simple;
	bh=z3HgR5JrV87UUef5omwF+7GRZHLLMVnWFEywPKlYZN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/sj/DoyaQb47X3AbYuArKAePMPcZUflJ7O7nJCst1rzJP/98iu4MzpWVrSMysf4u8NuK1W/eDVd73uGDsCm3WGJh2d5nNPLGKtuKHPJaJ7sT/4pCH32hIWfG2pq2C2z2wRO7p6/AVeUNet/Obe0xyCfi/F0EXtUZ8ikfmBehDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MzfdHSGU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MzfdHSGU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C63FC1756;
	Mon, 24 Aug 2026 09:05:46 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.2.198.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67FFE3F85F;
	Mon, 24 Aug 2026 09:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787587550; bh=z3HgR5JrV87UUef5omwF+7GRZHLLMVnWFEywPKlYZN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzfdHSGUI4MR4hpSZEjGYjwit9tca6UiDVjwbEHbeT9dUPE7UHQ86d+HRFpo98vex
	 uwdglyCvZ9EqcSEXQhaNrCFd3FdwW9vV37RTPRQ7R85BMRMoAFvajoPp1TuM/0tmJ7
	 7w742yIUkmItIqYVPtE8QtBTxCTTT7GLQC3vNQVc=
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
Subject: [PATCH 1/7] arm64: uaccess: Add batched kernel nofault accessors
Date: Mon, 24 Aug 2026 17:04:46 +0100
Message-ID: <20260824160523.3907021-2-usama.anjum@arm.com>
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

With Hardware Tag-Based KASAN in asynchronous or asymmetric mode, arm64
sets and clears PSTATE.TCO around every kernel nofault load or store. A
loop pays that cost for every access even though tag checking can stay
disabled until the operation finishes.

Separate TCO management from the fault-tolerant access and add begin and
end hooks for callers that want to batch several accesses. Keep the
existing accessors self-contained, and provide aliases and no-op hooks
for architectures that do not need special handling.

A context switch re-enables tag checking, so a batched region must not
schedule. Continue to evaluate accessor arguments before overriding TCO,
as those expressions may block.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 arch/arm64/include/asm/uaccess.h | 71 ++++++++++++++++++++++++--------
 include/linux/uaccess.h          | 16 +++++++
 2 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 9f5bd9c69c249..1a14eb2a51dce 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -270,28 +270,43 @@ do {									\
 #define get_user	__get_user
 
 /*
- * We must not call into the scheduler between __mte_enable_tco_async() and
- * __mte_disable_tco_async(). As `dst` and `src` may contain blocking
- * functions, we must evaluate these outside of the critical section.
+ * Nofault load without TCO management for use inside a
+ * __begin/__end_kernel_nofault_bare() region.
  */
-#define __get_kernel_nofault(dst, src, type, err_label)			\
+#define __get_kernel_nofault_bare(dst, src, type, err_label)		\
 do {									\
 	__typeof__(dst) __gkn_dst = (dst);				\
 	__typeof__(src) __gkn_src = (src);				\
 	do { 								\
 		__label__ __gkn_label;					\
-									\
-		__mte_enable_tco_async();				\
 		__raw_get_mem("ldr", *((type *)(__gkn_dst)),		\
 		      (__force type *)(__gkn_src), __gkn_label, K);	\
-		__mte_disable_tco_async();				\
 		break;							\
 	__gkn_label:							\
-		__mte_disable_tco_async();				\
 		goto err_label;						\
 	} while (0);							\
 } while (0)
 
+/*
+ * We must not call into the scheduler between __mte_enable_tco_async() and
+ * __mte_disable_tco_async(). As dst and src may contain blocking functions,
+ * evaluate them before overriding TCO.
+ */
+#define __get_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	__label__ __gkn_tco_err;					\
+	__typeof__(dst) __gkn_tco_dst = (dst);				\
+	__typeof__(src) __gkn_tco_src = (src);				\
+	__mte_enable_tco_async();					\
+	__get_kernel_nofault_bare(__gkn_tco_dst, __gkn_tco_src, type,	\
+				     __gkn_tco_err);			\
+	__mte_disable_tco_async();					\
+	break;								\
+__gkn_tco_err:								\
+	__mte_disable_tco_async();					\
+	goto err_label;							\
+} while (0)
+
 #define __put_mem_asm(store, reg, x, addr, label, type)			\
 	asm goto(							\
 	"1:	" store "	" reg "0, [%1]\n"			\
@@ -366,28 +381,48 @@ do {									\
 
 #define put_user	__put_user
 
-/*
- * We must not call into the scheduler between __mte_enable_tco_async() and
- * __mte_disable_tco_async(). As `dst` and `src` may contain blocking
- * functions, we must evaluate these outside of the critical section.
- */
-#define __put_kernel_nofault(dst, src, type, err_label)			\
+/* Nofault store without TCO management; see __get_kernel_nofault_bare. */
+#define __put_kernel_nofault_bare(dst, src, type, err_label)		\
 do {									\
 	__typeof__(dst) __pkn_dst = (dst);				\
 	__typeof__(src) __pkn_src = (src);				\
 									\
 	do {								\
 		__label__ __pkn_err;					\
-		__mte_enable_tco_async();				\
 		__raw_put_mem("str", *((type *)(__pkn_src)),		\
 			      (__force type *)(__pkn_dst), __pkn_err, K);	\
-		__mte_disable_tco_async();				\
 		break;							\
 	__pkn_err:							\
-		__mte_disable_tco_async();				\
 		goto err_label;						\
 	} while (0);							\
-} while(0)
+} while (0)
+
+/*
+ * We must not call into the scheduler between __mte_enable_tco_async() and
+ * __mte_disable_tco_async(). As `dst` and `src` may contain blocking
+ * functions, we must evaluate these outside of the critical section.
+ */
+#define __put_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	__label__ __pkn_tco_err;					\
+	__typeof__(dst) __pkn_tco_dst = (dst);				\
+	__typeof__(src) __pkn_tco_src = (src);				\
+	__mte_enable_tco_async();					\
+	__put_kernel_nofault_bare(__pkn_tco_dst, __pkn_tco_src, type,	\
+				     __pkn_tco_err);			\
+	__mte_disable_tco_async();					\
+	break;								\
+__pkn_tco_err:								\
+	__mte_disable_tco_async();					\
+	goto err_label;							\
+} while (0)
+
+/*
+ * A context switch re-enables tag checking, hence the no-scheduling
+ * requirement for a bare nofault region.
+ */
+#define __begin_kernel_nofault_bare()	__mte_enable_tco_async()
+#define __end_kernel_nofault_bare()	__mte_disable_tco_async()
 
 extern unsigned long __must_check __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
 #define raw_copy_from_user(to, from, n)					\
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index eddbbb65ccc4f..7ae1854673471 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -637,6 +637,22 @@ do {							\
 
 #endif  /* !__get_kernel_nofault */
 
+/*
+ * Architectures may use the begin/end hooks to establish state shared by a
+ * sequence of bare nofault accesses. Every path out of the region must call
+ * the end hook. The region, including expressions passed to the bare
+ * accessors, must not call into the scheduler.
+ */
+#ifndef __get_kernel_nofault_bare
+#define __get_kernel_nofault_bare	__get_kernel_nofault
+#define __put_kernel_nofault_bare	__put_kernel_nofault
+#endif
+
+#ifndef __begin_kernel_nofault_bare
+#define __begin_kernel_nofault_bare()	do {} while (0)
+#define __end_kernel_nofault_bare()	do {} while (0)
+#endif
+
 /**
  * get_kernel_nofault(): safely attempt to read from a location
  * @val: read into this variable
-- 
2.47.3

