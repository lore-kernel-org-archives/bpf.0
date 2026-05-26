Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6482DAFBB;
	Tue, 26 May 2026 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829136; cv=none; b=Dr9wmTfsoDHBgi5abLfYGWueVO9TXHFUwqwwFkDqSqo9FHE4YC8Fm0p+n+h636dN2jNamBkKWwtRYhjTrarTu8rDz2GgP5zpuukces8/pKXPaBvkO6A2tcGuTgwss8ZP5texF+2J4+tCM6Wynzv9EE6n6VAIuCKwMVcVEoNCyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829136; c=relaxed/simple;
	bh=ZTP4ebl2idR1a3f+DvY1B5rzSJ78v1Y/nM8K7a6Ga/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuNAFKRS1QKptymRe8/x6gXf6/bCzPgK5Yw4uTIhtkNMay2ZW8C+j7/RF6WnZ7gBeFl8OSkOo+ha0YKXu+7fkpsGE3TPyemV2S8K1vF6WcabVrCQNwyqtP8J76kagM3EMuW+2EI8eXe2EiZ4sCJBYWue5X2n+JlYrUHYz2APBR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaSLefV0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaSLefV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56031F000E9;
	Tue, 26 May 2026 20:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779829134;
	bh=AZplZ0V5vfefnPds4w+lyGUlqzD+4ADV0U133iOSc3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GaSLefV0xwKB9vZSbQ0uiXBXJ0GArtT5zaACKJ38tLSNQh7hPUfiMxn/1Nw1UXJ9t
	 DuObnjKmZBHjLrzYCD/B2SeRypseXexGLGy+QIc8BbSMSb+Dfms9rFr5z5VR7s4yao
	 7qQwLTW7WHdgLecCH9ucATz+4OouLkdcNj4wRh0Xi/CE1uUDU414cOxwsEKaQLVHvt
	 kvNd9a/3KZ83GVEvjekE6AGPA1F6GGgukVEx09xWRClr2t0Hc7iJahSNSgaCpgbeNa
	 Po+ICoDkl0ZgBu5N3CBCokPPmsB9F0Lzlv+OFd5VjkYEg8TJQiu5Ltt9oUq6rkWySS
	 uvZcN2GR5IXJw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv4 01/13] uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
Date: Tue, 26 May 2026 22:58:28 +0200
Message-ID: <20260526205840.173790-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526205840.173790-1-jolsa@kernel.org>
References: <20260526205840.173790-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the unregister path we use __in_uprobe_trampoline check with
current->mm for the VMA lookup, which is wrong, because we are
in the tracer context, not the traced process.

Add mm_struct pointer argument to __in_uprobe_trampoline and
changing related callers to pass proper mm_struct pointer.

Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index ebb1baf1eb1d..2be6707e3320 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -761,9 +761,9 @@ void arch_uprobe_clear_state(struct mm_struct *mm)
 		destroy_uprobe_trampoline(tramp);
 }
 
-static bool __in_uprobe_trampoline(unsigned long ip)
+static bool __in_uprobe_trampoline(struct mm_struct *mm, unsigned long ip)
 {
-	struct vm_area_struct *vma = vma_lookup(current->mm, ip);
+	struct vm_area_struct *vma = vma_lookup(mm, ip);
 
 	return vma && vma_is_special_mapping(vma, &tramp_mapping);
 }
@@ -776,14 +776,14 @@ static bool in_uprobe_trampoline(unsigned long ip)
 
 	rcu_read_lock();
 	if (mmap_lock_speculate_try_begin(mm, &seq)) {
-		found = __in_uprobe_trampoline(ip);
+		found = __in_uprobe_trampoline(mm, ip);
 		retry = mmap_lock_speculate_retry(mm, seq);
 	}
 	rcu_read_unlock();
 
 	if (retry) {
 		mmap_read_lock(mm);
-		found = __in_uprobe_trampoline(ip);
+		found = __in_uprobe_trampoline(mm, ip);
 		mmap_read_unlock(mm);
 	}
 	return found;
@@ -1044,7 +1044,7 @@ static int copy_from_vaddr(struct mm_struct *mm, unsigned long vaddr, void *dst,
 	return 0;
 }
 
-static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
+static bool __is_optimized(struct mm_struct *mm, uprobe_opcode_t *insn, unsigned long vaddr)
 {
 	struct __packed __arch_relative_insn {
 		u8 op;
@@ -1053,7 +1053,7 @@ static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
 
 	if (!is_call_insn(insn))
 		return false;
-	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
+	return __in_uprobe_trampoline(mm, vaddr + 5 + call->raddr);
 }
 
 static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
@@ -1064,7 +1064,7 @@ static int is_optimized(struct mm_struct *mm, unsigned long vaddr)
 	err = copy_from_vaddr(mm, vaddr, &insn, 5);
 	if (err)
 		return err;
-	return __is_optimized((uprobe_opcode_t *)&insn, vaddr);
+	return __is_optimized(mm, (uprobe_opcode_t *)&insn, vaddr);
 }
 
 static bool should_optimize(struct arch_uprobe *auprobe)
-- 
2.54.0

