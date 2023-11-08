Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26486199AD;
	Wed,  8 Nov 2023 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrtIxDVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C90C433C7;
	Wed,  8 Nov 2023 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699453489;
	bh=C7bH1hbWj8YrBfom6n8ilePk5KjymNF9xGwzwSVwNXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BrtIxDVHCOf0bu7JTKatkcA1ju3b4gZ5Vq2cFTvDyE2hler0OWBAWZiYjwlq/XTFW
	 cOQRUyVfmG0PW8gKTTT+y8ELQduQW2nrpD7ZDyRatTmEMe0n8c87whRGPQQkf4aQmQ
	 soFdmpFj9Udi095GJApvsV4kFZI0j0dFBMK5gD2M9ZaPFqkkUhzskZfCXyFuOk2arW
	 SNodYq316Vv+wsG5ot4CFf7UolCyxFSJcyfYmOQAVb1dQV/GbQNeCak+xYgTIc832o
	 wsPQd8exyei5fNIzk9xPzKv0eWvtirfrrNUe/gQcKIbSPxdMXwACfDpw5MCX9pTkDI
	 B1lMlio7rEaMw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>
Subject: [RFC PATCH v2 02/31] x86: tracing: Add ftrace_regs definition in the header
Date: Wed,  8 Nov 2023 23:24:43 +0900
Message-Id: <169945348320.55307.17578137376868880969.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169945345785.55307.5003201137843449313.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add ftrace_regs definition for x86_64 in the ftrace header to
clarify what register will be accessible from ftrace_regs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Newly added.
---
 arch/x86/include/asm/ftrace.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 897cf02c20b1..fc60974a1d89 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -36,6 +36,12 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 struct ftrace_regs {
+	/*
+	 * On the x86_64, the ftrace_regs saves;
+	 * rax, rcx, rdx, rdi, rsi, r8, r9, rbp and rsp.
+	 * Also orig_ax is used for passing direct trampoline address.
+	 * x86_32 doesn't support ftrace_regs.
+	 */
 	struct pt_regs		regs;
 };
 

