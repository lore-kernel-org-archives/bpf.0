Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7993B8413;
	Wed,  1 Jul 2026 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904467; cv=none; b=CyTG+hDTZYICSzamJL/heT2WH+GsuKbOGnbZDaGnloGdbRBzB8khvHgGqG0kAjv0DCy9sMtdkuvJMrwgYU4h/4cw5v4mrY0MCgEXZRtKJSqkpQQ6PZOMaLtb+HqRzNbX4J9BBcG/MNZQPbcUjorBtgJbcSv86tmsKDSk83LqyhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904467; c=relaxed/simple;
	bh=uWNSsQ5nooAPg9SGuXfuEik0pZXXEpwLRhXcY95+FDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kj4cSMuAyD38jT3O/UaD+Dqws8E2gg2NQ4DCkqNEutgMpgyqCoboGlaUZpvvYt1vYW9VvwcAhQE/rzoyeGPcqSa0u45CVNK6G+5EqdITAZ7vMUjVUPvCZLT58c/4V2zj4hCHoumBhSUdU2AJ8JhyyajUYNyITRtOLrwpvr7S5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVas6ixa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVas6ixa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A381F000E9;
	Wed,  1 Jul 2026 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782904466;
	bh=YVKq4klbVibOmH5jy+G13M3OVF8qflNh2OGvx3uM9XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cVas6ixaLI3kouQ+eQWrN4Vc7DZUI0kLeu1VrxzD74mgVNixJT9KIAgFmT6b5c9hs
	 7N/l8l+mHb1uqXZVuG3rSJs9gMNwSSmsMew9hSgbyOSKOaIVFeNWUAvfZL1IbyGe2d
	 SPDuqcpVtfyMEj79eKCg+ZSw6UbTRsVNc+0Y64OxeiNH6r/DKEInh/AAKFOfUgbQSK
	 zKD4a8blfiiW691JdY6AvWHoWYgHPeP2Ma9zeBFkhEPeaK8C8SGLuJruJdmtMDXUNb
	 rKM/FuOMf6ej9j3UNCIUqh81B/zILs1FiFlzHGLdqgyIiV52i5ax5bUHyVbkZgOaih
	 GxikXl4ND/nQg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv5 04/13] uprobes/x86: Allow to copy uprobe trampolines on fork
Date: Wed,  1 Jul 2026 13:13:28 +0200
Message-ID: <20260701111337.53943-5-jolsa@kernel.org>
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

When we do fork or clone without CLONE_VM the new process won't
have uprobe trampoline vma objects and at the same time it will
have optimized code calling that trampoline and crash.

Fixing this by allowing vma uprobe trampoline objects to be copied
on fork to the new process.

Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5730d41eb5f2..af5af7d67999 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -701,7 +701,7 @@ static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsign
 
 	*new_mapping = true;
 	return _install_special_mapping(mm, vaddr, PAGE_SIZE,
-				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
+				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
 				&tramp_mapping);
 }
 
-- 
2.54.0

