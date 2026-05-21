Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464D3D0919;
	Thu, 21 May 2026 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367467; cv=none; b=U3pPOUo34MkqvHFW+I4omEc+GANh4NdjXNxp83fb0drRiwdSK54HRX6n2SfHgyhEjh3FN++6f1csVx4lU2l9cDlK9795Fr6H2ffNQHYD25JKfPVI7yAa7ahnAuwXCo+4uKxzEeIf0p5efpY1OswZU9A2VcRrs20KsZnWeDQUi2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367467; c=relaxed/simple;
	bh=pwe3w15mmIl73aXqvc4+Z2tQBuuBDFisy0tWh0fC4yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYenjtpJ5g0CcgPr/QqQA003Jx5ssLQtMWNlAyh5+TvnGRBwXjn+uvdzYZP3dN+fU5Bo6bxQBPtTRPgB5mhu3R1glhq1+nr384GpGDB+hbifnVPQQk1DkeSk8sJgMsDzLpx6JGeJHCd5eh2z0o5i/VKxkg9TIRBWlo6rIdZbx68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShqDW7NB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShqDW7NB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DCD1F00A3F;
	Thu, 21 May 2026 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367466;
	bh=vQlRB6TudihgIp/i92dd8AxlEAZLBXhhYsAnB28lfx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ShqDW7NBrJivfrSKSJbzNX3ugkWEtlJcs8c3oVC1gK1U+CvaTMIU6bSyTBldAI500
	 QTXFPXP8l0QAYyJ7hfSaORjOsrUt+FeYwjWvgP3BIiTCcICKyo9h/YoZ5EEH5ZNSJE
	 Zm9UPOBrEruYjpQwpPiT5PIoWrxeL3jw+1bimQrpwPlxHWmddeP2JLAZ1DbvpucMZu
	 11q7FdL4t7UImOSvzikZwkk3R0f/Lj9/ehWlQVoHTDwwIAweKUUkhjPDWJ/5Z/jQAK
	 ltu6+Il0Z3KHuhmfAfihIH/yaFHS8jmnIe8qIDRkSxAMjt0h8ctI+4shPvy6eQOOkw
	 FKwvcZD+5+4+w==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 01/12] uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
Date: Thu, 21 May 2026 14:44:00 +0200
Message-ID: <20260521124411.31133-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521124411.31133-1-jolsa@kernel.org>
References: <20260521124411.31133-1-jolsa@kernel.org>
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
2.53.0

