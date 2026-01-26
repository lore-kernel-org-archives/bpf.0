Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C030250BF2;
	Mon, 26 Jan 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462340; cv=none; b=YejQT+fujLmAWWFEgx3s5Q/AXx1vmRk0GfE3XdFqtWnbvjy0U/nqO522aDIYiPm3nANIOrl4ci7k4s+xqXNWE+TLmt896ULd6Oa/PMS1j1OD3ruqsjsps75p6gKRZYcPRAHtmVvdTfpUifxxnqxPM+Au9vfi8g2Xyz8hV2TZWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462340; c=relaxed/simple;
	bh=RAYNDZM6TcEje/Rvo7pwq2pa5dI4dJ2Et1lajk1HJbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6IwyieJeW0Y5dAY6tH3Gane0Ax9oweEfY4D+ZC5mv6pVS3H4DBJ+5gzCmh0eq3yFuNRsMI7hOesRWW0X9/x5O5AMtc+Gsh/H0GZU9/WWODsnuKMHZYnlmaGeEJBUQTGWzaxjzQFUoMswzhY+8i0dJbSfB3F2hqOocSwfGBALg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WluEbgIe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WluEbgIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67066C116C6;
	Mon, 26 Jan 2026 21:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769462340;
	bh=RAYNDZM6TcEje/Rvo7pwq2pa5dI4dJ2Et1lajk1HJbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WluEbgIepl7Gg39oc6yNxTH6hrSH82gnMk/o4kVFw1TTac7FA7nwvGzqybjkyKVD5
	 r+PaIQhlCykZES26TNJUMuVaGgx6TvbOIUqlB+BmAVi4gCzfhAvC4rE/qDC7dRxF0r
	 3K61Fkj1iQmR1nUH7haapdTKrL5ah6AZRhHXlSRAsmE+zpztv+OKo2+6JkoIsaQgWX
	 eSXJfg/FypT9mxvVgqnQE7tdxIGqAz+uOm/7i59hDrLZ7Qyg1hTuvIUxOI3O6NVxYw
	 seA6NwQ5s1HeB1WVSnL5w5tKJ2TwU3rTiy7ftVv2IJ3OiVmnZp4xV4Cu17471vsCLz
	 O4jr+PrQB1XDA==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCHv2 bpf-next 1/6] x86/fgraph: Fix return_to_handler regs.rsp value
Date: Mon, 26 Jan 2026 22:18:32 +0100
Message-ID: <20260126211837.472802-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126211837.472802-1-jolsa@kernel.org>
References: <20260126211837.472802-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous change (Fixes commit) messed up the rsp register value,
which is wrong because it's already adjusted with FRAME_SIZE, we need
the original rsp value.

This change does not affect fprobe current kernel unwind, the !perf_hw_regs
path perf_callchain_kernel:

        if (perf_hw_regs(regs)) {
                if (perf_callchain_store(entry, regs->ip))
                        return;
                unwind_start(&state, current, regs, NULL);
        } else {
                unwind_start(&state, current, NULL, (void *)regs->sp);
        }

which uses pt_regs.sp as first_frame boundary (FRAME_SIZE shift makes
no difference, unwind stil stops at the right frame).

This change fixes the other path when we want to unwind directly from
pt_regs sp/fp/ip state, which is coming in following change.

Fixes: 20a0bc10272f ("x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/ftrace_64.S | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index a132608265f6..62c1c93aa1c6 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -364,6 +364,9 @@ SYM_CODE_START(return_to_handler)
 	UNWIND_HINT_UNDEFINED
 	ANNOTATE_NOENDBR
 
+	/* Store original rsp for pt_regs.sp value. */
+	movq %rsp, %rdi
+
 	/* Restore return_to_handler value that got eaten by previous ret instruction. */
 	subq $8, %rsp
 	UNWIND_HINT_FUNC
@@ -374,7 +377,7 @@ SYM_CODE_START(return_to_handler)
 	movq %rax, RAX(%rsp)
 	movq %rdx, RDX(%rsp)
 	movq %rbp, RBP(%rsp)
-	movq %rsp, RSP(%rsp)
+	movq %rdi, RSP(%rsp)
 	movq %rsp, %rdi
 
 	call ftrace_return_to_handler
-- 
2.52.0

