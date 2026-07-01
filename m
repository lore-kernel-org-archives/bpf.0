Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF40423A7C;
	Wed,  1 Jul 2026 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904457; cv=none; b=BzJosBgk3VD5UndYXWYz/TT622+UUwFDjjL1GTFHT4gevCygDmZklwsiQ8Oqb+WAWCtVemP1lfdL11LtLbxy4Z1VOdak6tBIQPEQwGXjpg2x1YFfC7wjGx8xknQ5G3MG7/BH12Hbk0B2FwtVE3TwbK0ZL2/u6+43WVVGBP8n/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904457; c=relaxed/simple;
	bh=S0/qigRFNQB2DyqwnS7tWAAYzPxciHiJDzfcg0xefEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HU+UzFdxMEjwwxCBU0LIxWRP8hmLTVX7bCiloO7mmTgZYuPhotgcI0teeNKS+pBxJ/oarstqz1FCcGOFNYfgQEJgbdGDL0YogbW8/NLLHJBBb4l2wHr9pLGtVSZTGBZYyaYNB0+Za+iUXR6ifCPxh1sb0fqNPOASuneh8ZWLqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvTSFiDa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvTSFiDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CE51F000E9;
	Wed,  1 Jul 2026 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782904456;
	bh=c/lAbgXackBzXsg+TZ9XN/Wcgm+f8IrXnSQIBPAI+1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FvTSFiDa3W/6rk03jNP7PVY+uX2RhPuEzMxwubp7tJm7rV4IFhnoA8r3BMoow+Wlu
	 slK0HzIUg16IS/iRI7BWnnFTk0Tz200QGc8MfJGbOsCeAEHtfXwruzNlyoNQrVPMPi
	 UHHottjcwSWeJKnmMS58xs4rV0AA5sABlrCQvN4/JCdsm8+RB9DAqyeUU/4ZiwISHn
	 IAWam5hKudg/V3ClpLOmJJ6lbuF3iQfYEW7CaIckeLahDU3LpFrIID/rdd+CD3LZql
	 EkWXo8z8R6u6GokrHLDe3BzfvOeQVseai9pKv5vxxM8KI1O/TDhOMrKiajYeKwBsdX
	 sioX3lEWON2Kw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv5 03/13] uprobes/x86: Do not leak trampoline vma mapping on optimization failure
Date: Wed,  1 Jul 2026 13:13:27 +0200
Message-ID: <20260701111337.53943-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111337.53943-1-jolsa@kernel.org>
References: <20260701111337.53943-1-jolsa@kernel.org>
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

