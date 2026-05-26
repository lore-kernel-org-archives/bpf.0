Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4C3C141F;
	Tue, 26 May 2026 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829154; cv=none; b=VlbiEA5oZ2p6d4783zTeWN1BSyky44oXCtJ+T+MZcNNPhuh1LWd+6Jot7KIgpcxQCjFaOpeoy56y8ltLTbB1pIztRqGyDeufi2HBv6rXDeaamNagNs7SqVmK/EmBiXzYRaXyTJaUKFKlw+5jJKYRNIU7r646+zxXtTbnWk85ZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829154; c=relaxed/simple;
	bh=mgFOtiluf68RxRsWN3CdIq7vDTLHB0KFyRU6Opm627g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIfJ57iQJiiYxoNQjxdsUPVtjcOjenkAcvhHKMSUHmC1ITW5nK42xZ8Oxu4s4+nkxg5GjVGsotZcgaLR4b6HO5wG8eFroqj3oEjtgUKHeAMrPm59dM1xesOXPJhFP3ZDt+nUpO//aV+XQDfsOmce9FUk5ChjnXJbotbWw7eHcf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwxLSGWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwxLSGWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58841F000E9;
	Tue, 26 May 2026 20:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779829153;
	bh=uq6EAtzSlkIptRcI4/3GV5XasP2VpZO/zMy8k+zVl7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fwxLSGWATmLd5KKR4AY6l2hjHHv2GwuSknNN+MonNNsjIW1gr8ekeRCeEMkp4s7mc
	 lw+RG2iAPkwEoyBBxh45QKs4Db+G4mClABBd6v0fnntHqwJwz7woQYs7jBeZea2Tle
	 3lwUpmLljnuzFrSo+O4njxBKeGb71KJWELQcUwg3yeH3Ou57lE71EqdNmS9hWwZiXI
	 ZbSDr5K2FiU7c6s6tJHfdeNJmjeyI3UTdpNigeo9kmHsgwD0U21sgT1KNEPHqGhsE8
	 /80xhTqcjXKQkrZEOZ40q+bSZyL60f7nPWQvHvb8otvzo3OepscyA96dnWsef144RZ
	 qPbduQ16qJtsA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv4 03/13] uprobes/x86: Allow to copy uprobe trampolines on fork
Date: Tue, 26 May 2026 22:58:30 +0200
Message-ID: <20260526205840.173790-4-jolsa@kernel.org>
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

When we do fork or clone without CLONE_VM the new process won't
have uprobe trampoline vma objects and at the same time it will
have optimized code calling that trampoline and crash.

Fixing this by allowing vma uprobe trampoline objects to be copied
on fork to the new process.

Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 733655bc610e..c8af41ed681a 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -697,7 +697,7 @@ static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsign
 		return ERR_PTR(vaddr);
 
 	return _install_special_mapping(mm, vaddr, PAGE_SIZE,
-				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
+				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
 				&tramp_mapping);
 }
 
-- 
2.54.0

