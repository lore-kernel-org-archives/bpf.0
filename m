Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D463148C5
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 05:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982399; cv=none; b=S9wTwbZaOzRXYR5Ifw/dptB+WMvoxgRKO2ZkrNY3r+OcbU0PJjyRepilgPReFg0KKegX9dKzAhtkOKot1bNHtsFgXDTC3ocl89f8sNavgKm/QE3M4/DvI6k6caX80p+qf7ev8S+kICKhPdfmR0kQUyqMfvxyAavRWRRSYtuhtQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982399; c=relaxed/simple;
	bh=QxJKs+t2WCqlYgD8OA6WaPWGq5DHx4YMZnP6WjslTPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qc+MshIOe1W9Y9lZ5f236mCQmqEG4txPikPYmvD7oBAM2GiIusXaAwQLuT+gGT5rhvWggR6WBaR/KCAzqJCkBpnhdNmmQQEVCbDB9bdMQjmmAaQQvh3zZBgnB5UCZ1src6aUsmgBG9eMuLWuswpb3FDDzVMdLHVDT9o73lTGvok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CsQ6WOyw; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CsQ6WOyw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780982394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVmqcnVsjodgCjG3U/o5eRCKAusFzgiBIJq4ut+6lTg=;
	b=CsQ6WOywrUqfG/jYS6DeCAEfy3Mucvl8747hxez4wCFKgNWvESAh7FrW/4ZrkN16ffN0Y9
	+gND0uCghNRWgOOIsMvrrag32fn5ube0Ku/eHm644yqIC9NWjOyzOihlw59ti4993532TT
	p6nytidjYkMGT1uWj9o1t0V2BZ9ZC2Q=
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Tue, 09 Jun 2026 05:19:26 +0000
Subject: [PATCH 1/2] arm64: ftrace: prepare ftrace_modify_call() for use
 without CALL_OPS
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-arm64-ftrace-direct-calls-v1-1-4a46f266697f@linux.dev>
References: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
In-Reply-To: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
 bpf@vger.kernel.org, Florent Revest <revest@chromium.org>, 
 Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huawei.com>, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
X-Migadu-Flow: FLOW_OUT

ftrace_modify_call() is guarded by CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
and calls ftrace_rec_set_ops(rec, arm64_rec_get_ops(rec)) directly,
which only exists when CALL_OPS is enabled.

Generic ftrace also needs ftrace_modify_call() when
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS is enabled, to retarget a
callsite between two non-FTRACE_ADDR destinations, as happens when a
direct trampoline is modified. The next patch allows DIRECT_CALLS without
CALL_OPS, so widen the guard to cover both configurations and switch
the body to the ftrace_rec_update_ops() wrapper, which already has a
stub for the !CALL_OPS case. ftrace_make_call() already uses the same
wrapper today.

No functional change: with CALL_OPS enabled, ftrace_rec_update_ops()
expands to the exact call this replaces.

Assisted-by: Claude:unspecified
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 arch/arm64/kernel/ftrace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 5a1554a441628..e1a3c0b3a0514 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -409,7 +409,8 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	return ftrace_modify_code(pc, old, new, true);
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS) || \
+	defined(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS)
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
 {
@@ -417,7 +418,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 	u32 old, new;
 	int ret;
 
-	ret = ftrace_rec_set_ops(rec, arm64_rec_get_ops(rec));
+	ret = ftrace_rec_update_ops(rec);
 	if (ret)
 		return ret;
 

-- 
2.52.0

