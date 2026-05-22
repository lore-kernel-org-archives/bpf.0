Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F482368958;
	Fri, 22 May 2026 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470543; cv=none; b=eJDk+RNVjCnvJ87z7bH7w+vPCx4iPTFrsd29sSCPx9ah+P2YVH8TwCGI3WsmNPv1s3/wNH4Jc6JwU0r0XiQgDZhbMag2aidN/e6Tpd9rwJ3LJlRc4ZTRlMoklINArb4Ne+qwvhPCUMPHY+M9cZ69GbbhkmLRqA+dCky9oU6+H/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470543; c=relaxed/simple;
	bh=+gGeozPvIz531uhJrKKGfpogsVzCZ+Ev3LWJP+eyiUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cz72DUScagA6m/8zjhCnRowxqOmoMSXXThKq8D4VKQM+dfEfErjCWgFX2AkwD7thmtgFYsE+p7m/N2d26WP7IrB8S8ITRc/yr+nAUUE4SQ5d7nPsnFmr2pDLZ6hyMkfjkjOZ9aLYd2XNxmPI7oIR+jJg0S/x6e7IBAjaA0X5oSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koyRjviy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koyRjviy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB681F00A3D;
	Fri, 22 May 2026 17:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470541;
	bh=Myvcdmsl6/fVRzdXvlKB28a4tjZpVUNPg3c8cwRTRc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=koyRjviy4q6sfifYODHDnPc65g8b+eojaCyZHhTg5Ealb/7ff1Zc/oU4ADJH398VU
	 4TKBt6TDzByn8jMibaau/poX7yGuTwHpL9zjQSGXHiDb9X8+PZUxGbZoGWA8MrvJml
	 MlGFKtmw8/TP0Fywdg0cb4oGppiZKrbXtufXBaFd6zOSQqDra52zbQHDUDIgsFq4Ls
	 t/6cpQAfOEOQCAYNuERyJPpiR/AUaatocDVr94Nw9/k7ISDd/7i4xLW24YIEI7BOKH
	 oL9pavpNyjmXnvIJ7BXg3psUbFkFFsdvbn/+StHApkXcCwKgxxtj5I1yZRb8v9sGka
	 q2y8MQd2JUZRg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/8] mm: Add ptep_try_set() for lockless empty-slot installs
Date: Fri, 22 May 2026 07:22:12 -1000
Message-ID: <20260522172219.1423324-2-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522172219.1423324-1-tj@kernel.org>
References: <20260522172219.1423324-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ptep_try_set(ptep, new_pte): atomically set *ptep to new_pte iff it is
currently pte_none(). Returns true on success, false if the slot was already
populated or the arch has no implementation.

The intended caller is the upcoming bpf_arena kernel-side fault recovery
path. The install runs from a page fault that can be nested under locks
held by the faulting kernel caller (e.g. a BPF program holding
raw_res_spin_lock_irqsave on its arena's spinlock), so trylock-and-retry
would A-A deadlock. Lock-free cmpxchg is the only viable option, which
constrains this helper to special kernel page tables where concurrent
writers cooperate via atomic accessors.

The generic version in <linux/pgtable.h> returns false. x86 and arm64
override with try_cmpxchg-based implementations on the underlying pteval.
Other architectures get the false stub - the callers there already fall
through to oops.

v2: Rename to ptep_try_set(). Tighten kerneldoc. (David, Alexei)
v3: Note that strict-zero cmpxchg is narrower than pte_none(). (Andrea)

Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 12 ++++++++++++
 arch/x86/include/asm/pgtable.h   | 12 ++++++++++++
 include/linux/pgtable.h          | 25 +++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 9029b81ccbe8..28bada97d443 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1830,6 +1830,18 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 	return __ptep_get_and_clear(mm, addr, ptep);
 }
 
+/*
+ * Note: strictly-zero compare is narrower than pte_none(), but the gap is
+ * harmless: a fresh kernel PTE has no software bits set.
+ */
+static inline bool ptep_try_set(pte_t *ptep, pte_t new_pte)
+{
+	pteval_t old = 0;
+
+	return try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte));
+}
+#define ptep_try_set ptep_try_set
+
 #define test_and_clear_young_ptes test_and_clear_young_ptes
 static inline bool test_and_clear_young_ptes(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, unsigned int nr)
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 13e3e9a054cb..15a5da68f180 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1284,6 +1284,18 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
 	} while (!try_cmpxchg((long *)&ptep->pte, (long *)&old_pte, *(long *)&new_pte));
 }
 
+/*
+ * Note: strictly-zero compare is narrower than pte_none(), but the gap is
+ * harmless: _PAGE_DIRTY and _PAGE_ACCESSED aren't set on untouched kernel PTEs.
+ */
+static inline bool ptep_try_set(pte_t *ptep, pte_t new_pte)
+{
+	pte_t old_pte = __pte(0);
+
+	return try_cmpxchg((long *)&ptep->pte, (long *)&old_pte, *(long *)&new_pte);
+}
+#define ptep_try_set ptep_try_set
+
 #define flush_tlb_fix_spurious_fault(vma, address, ptep) do { } while (0)
 
 #define  __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index cdd68ed3ae1a..b5739bb99fc1 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1036,6 +1036,31 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
 }
 #endif
 
+#ifndef ptep_try_set
+/**
+ * ptep_try_set - atomically set an empty kernel PTE
+ * @ptep: page table entry
+ * @new_pte: value to install
+ *
+ * Atomically set *@ptep to @new_pte iff *@ptep is pte_none(). Return true on
+ * success, false if the slot was already populated or the arch has no
+ * implementation.
+ *
+ * For special kernel page tables only - never user page tables. The caller must
+ * prevent concurrent teardown of @ptep and must accept that other writers may
+ * race. Concurrent clearers must use ptep_get_and_clear() so racing accesses
+ * agree on the outcome.
+ *
+ * Architectures opt in by providing a cmpxchg-based override and defining
+ * ptep_try_set as an identity macro. The generic stub returns false, which is
+ * correct for callers that fall through to oops on failure.
+ */
+static inline bool ptep_try_set(pte_t *ptep, pte_t new_pte)
+{
+	return false;
+}
+#endif
+
 #ifndef wrprotect_ptes
 /**
  * wrprotect_ptes - Write-protect PTEs that map consecutive pages of the same
-- 
2.54.0

