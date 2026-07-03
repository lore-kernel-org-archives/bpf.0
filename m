Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782D368D6F;
	Fri,  3 Jul 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079400; cv=none; b=P31XhFhsdx1/hXFlrD+Ofai3bJj1+lL0LeUuVpQHRAGSju0yq9Scuv2163Ex87ArkGNTm+hdAIMNUfg+1zMNrOikCmEmdSfwIaOp5hdMS5rl/Yvt3V7T4jx37Ko1v3ylTBXC68PhRDR8V6RyzF3U/mpn0N1Y6CDvG7gsh58uJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079400; c=relaxed/simple;
	bh=S0/qigRFNQB2DyqwnS7tWAAYzPxciHiJDzfcg0xefEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY7hYNS+Q2MkbGSbbT+XwxORSAfkXDDCsnL8lcncsED4DY3Rv9MQXr7HMScFhKrg8f9S6jno6GHYlDgSyyUIBNDPupRhAjloBrPe5Emo6UKMbvyA6DAFkqlkoCjgebYD1JV5g34kW0JGmo6vwpQPovECybj+G8BcclMDnQ3oSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md5WcaVu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md5WcaVu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A901F000E9;
	Fri,  3 Jul 2026 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079398;
	bh=c/lAbgXackBzXsg+TZ9XN/Wcgm+f8IrXnSQIBPAI+1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Md5WcaVuW+0cON+Mb+G53CCfYlfuRFETP9w1oaWnvoLrrgdzZUbeWJzmwDO3KgMmN
	 b4/nwoLTmc2NAWXX69StH1nqI65bewwd4G7y9GHaC33Lchd87abu0PcH0VZNcdkUCb
	 7LI4NTEqiTf9CwnGMkUvzpFQfEln5xJ2htLbsGQ4cNaKs2IDs6iVdJ0VcOJYAUzXO2
	 C7bWIg8ovemOeQxxDufQKoh2rl7zqdJfOd0hIiPOktfUOFDQaM7xJqgJIb00wwllZb
	 uVMlr27+GgkU6znQgL0/XR+oVB9QDBkckfGJsM8CXXJTpK04fN9J/SXHg1ZHR8oavX
	 ddpSoqcxKBG7g==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv6 03/13] uprobes/x86: Do not leak trampoline vma mapping on optimization failure
Date: Fri,  3 Jul 2026 13:49:07 +0200
Message-ID: <20260703114917.238144-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703114917.238144-1-jolsa@kernel.org>
References: <20260703114917.238144-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case the optimization fails, we leak new-ly created trampoline
vma mapping (in case we just created it), let's unmap it.

Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index d2933cf77cd3..5730d41eb5f2 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -677,11 +677,14 @@ static unsigned long find_nearest_trampoline(unsigned long vaddr)
 	return high_tramp;
 }
 
-static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsigned long vaddr)
+static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsigned long vaddr,
+						    bool *new_mapping)
 {
 	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 
+	*new_mapping = false;
+
 	if (vaddr > TASK_SIZE || vaddr < PAGE_SIZE)
 		return ERR_PTR(-EINVAL);
 
@@ -696,6 +699,7 @@ static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsign
 	if (IS_ERR_VALUE(vaddr))
 		return ERR_PTR(vaddr);
 
+	*new_mapping = true;
 	return _install_special_mapping(mm, vaddr, PAGE_SIZE,
 				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
 				&tramp_mapping);
@@ -1053,6 +1057,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
 {
 	struct pt_regs *regs = task_pt_regs(current);
 	struct vm_area_struct *vma, *tramp;
+	bool new_mapping;
 	int ret;
 
 	if (!user_64bit_mode(regs))
@@ -1060,10 +1065,13 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
 	vma = find_vma(mm, vaddr);
 	if (!vma)
 		return -EINVAL;
-	tramp = get_uprobe_trampoline(mm, vaddr);
+	tramp = get_uprobe_trampoline(mm, vaddr, &new_mapping);
 	if (IS_ERR(tramp))
 		return PTR_ERR(tramp);
-	return WARN_ON_ONCE(swbp_optimize(auprobe, vma, vaddr, tramp->vm_start));
+	ret = swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
+	if (WARN_ON_ONCE(ret) && new_mapping)
+		WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NULL));
+	return ret;
 }
 
 void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
-- 
2.54.0

