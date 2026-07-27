Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC137F01C
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162595; cv=none; b=HSQ3F09+RfPPO9vql2UmVHqMbf3l63sCp0UupEaRfv9zJ2sj1YUc8hlL5vwyyjZXRBDmQPGvrMnqqJ/Xd0WxL6qyhflE3LsxjooMKaozx92UcOdaU5v1wswp1gJ2BCGOkXnMNbZLAmclH8U+2rUwLZVoW6jGXibv2aTAqV4JmAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162595; c=relaxed/simple;
	bh=xgUC/3Fkqjw/e5LtHgVt3noPBmTgTj7kOpfQkp1kQRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZW3QqlOheNkdIInlzFQwT4y/BtwsnzToZurvdf1DNq2wEvZZa+Mkrv9sCUL//dJMvThhhE+v5VUZnb6ORjp6XAlKudQp4/3NqvZxFvfs/qAz48OpxVXjsKMOc+7N4+q0VcpJ9BaNeaBgw4PU8eHh4XU5LhN9jOCfsMNmpRca+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZyLvmu/M; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZyLvmu/M"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785162589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TelY/e6rhqBnbaI//+7mxab5yF5lSU4GighDsL8mjtU=;
	b=ZyLvmu/MHYpDNbUorLcBJbddnw77+HeD/DLH4+630pkX74zlnxiewseIkfb1Qk4Jrr5wk1
	p/eTme8zssK5AaRtUalWpSb6uaj87dcJkyHuzHz+PqgI2S2cA7G0GafjxFncbd3VXndOc0
	h047oJQZ2gXZPMmOr+7CsnF2v8yKmCE=
From: Leon Hwang <leon.hwang@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] arm64: ftrace: enable single ftrace_ops for direct calls
Date: Mon, 27 Jul 2026 22:28:43 +0800
Message-ID: <20260727142844.21212-2-leon.hwang@linux.dev>
In-Reply-To: <20260727142844.21212-1-leon.hwang@linux.dev>
References: <20260727142844.21212-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The BPF tracing multi link updates several direct-call sites through one
ftrace_ops. Its implementation is therefore gated by
HAVE_SINGLE_FTRACE_DIRECT_OPS in addition to
DYNAMIC_FTRACE_WITH_DIRECT_CALLS.

Select HAVE_SINGLE_FTRACE_DIRECT_OPS whenever arm64 enables dynamic ftrace
direct calls. This enables BPF tracing multi links on arm64. Also
generalize the unreachable-trampoline comment because the single-ops path
does not use ops->direct_call.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/arm64/Kconfig         | 2 ++
 arch/arm64/kernel/ftrace.c | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0de419ed780f..c98dca76859b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -188,6 +188,8 @@ config ARM64
 		    CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS)
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
 		if DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_SINGLE_FTRACE_DIRECT_OPS \
+		if DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
 		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI && \
 		    (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index e1a3c0b3a051..56ba72a87dfa 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -301,8 +301,7 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
 
 	/*
 	 * If a custom trampoline is unreachable, rely on the ftrace_caller
-	 * trampoline which knows how to indirectly reach that trampoline
-	 * through ops->direct_call.
+	 * trampoline which knows how to indirectly reach that trampoline.
 	 */
 	if (*addr != FTRACE_ADDR && !reachable_by_bl(*addr, pc))
 		*addr = FTRACE_ADDR;
-- 
2.55.0

