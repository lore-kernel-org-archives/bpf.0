Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4123F0779;
	Mon, 18 May 2026 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102023; cv=none; b=KxmKmjaKChFTYI6//VOPvWcSVCpWPVzssFy8C29T9+pvGHiY9t0oGIukRBXL4xxbBtQFGE8RZnqhLOdBxHJqL1rQXIvnZODt9GohlkexR9l5u7YSy6ndaA56dpiMVfQOHnbTxACwioLbHJ+pPmsOb0Tqzwg2TopyM85xFX9Lq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102023; c=relaxed/simple;
	bh=3irRuXy2LUl63qYiGA6M7NDeALF0ZCY5JurvQLrlfqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUoZkP1LEcQQn6F0f6DJRzOePnE7o5thXSrFakXi674YXe79D0JwUdDxwJC/pSxSAXhXtqeYAzHkIUXiMx+39Z8/ayCpyASxWlTJSKc07Y0rwt4bByROAl+6TT7Ilpz+Xv7te/SHTBbqczBtiIG6rHoD5Jokkk8zPLF367KWg30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjyqKW5j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjyqKW5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89916C2BCB8;
	Mon, 18 May 2026 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779102022;
	bh=3irRuXy2LUl63qYiGA6M7NDeALF0ZCY5JurvQLrlfqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjyqKW5jVxivu7IPh8qJPgMewEBQ2Ar3IIzPRUXlS402oNTsb8LGtOwmWw+WsvDrj
	 LLXfOBNDEUzABn6pRVxWQ6AgI4t/BpwtqAOXfTBhmMAjClcfmFQjJPXfAMfPGdJ0E4
	 yL6P63KfYzYgtcXjQXrXFNDfYz/LIjGIbHC23nnsVcnNjWMsvd+FRJV24SE7LIc1aM
	 S7ZFjiHBd2e1hZmgP5oS1dRaj9imU9VGJp+U1QdkW4OvgyCppOgkcUGVFAu/ORseAQ
	 +hlryC5X1PdqZC1T15UZduKgfcGyJOehb1o5zNv9qwdvRUDku63DEi5z9aMk1EJjuu
	 9MvmedQ30LH5A==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 02/11] uprobes/x86: Allow to copy uprobe trampolines on fork
Date: Mon, 18 May 2026 12:59:48 +0200
Message-ID: <20260518105957.123445-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518105957.123445-1-jolsa@kernel.org>
References: <20260518105957.123445-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we do fork or clone without CLONE_VM the new process won't
have uprobe trampoline vma objects and at the same time it will
have optimized code calling the trampolines.

Fixing this by allowing vma uprobe trampoline objects to be copied
on fork to the new process.

Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 2be6707e3320..37faf038be33 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -702,7 +702,7 @@ static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
 
 	tramp->vaddr = vaddr;
 	vma = _install_special_mapping(mm, tramp->vaddr, PAGE_SIZE,
-				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
+				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
 				&tramp_mapping);
 	if (IS_ERR(vma)) {
 		kfree(tramp);
-- 
2.53.0

