Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9A34F483
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 05:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982401; cv=none; b=ZqDGW3PdFZiyBmB9IVb6H2rjl6qFD4QGo0uImaq9qNVa8DImS3gkpX6ZE28n2exI3GL+UNxQ9d92j6TmbSVkTJjwAyMwg4s8ReO1HKARDLwcFP8r/h0Bknqot736aJ+LTJBu36IdHze/fGJbBmC9mhg8UFTdmtPNzDYHjQmREPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982401; c=relaxed/simple;
	bh=p3b+oqPtAuju1RYgsAl7ReClPI6uVR8SOh2hQIDKGlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dni1zvuP2AUM8pqnVkbIZfMibebiFzYtuwFkkBpzwK6nvLGHC4NbhNgCjh7AQ9XnDGZb5nVXFNU2BpINj1xcIqSRxPFGEzvtR7NWFkpkAdHx4uWIQUS6YV4G+8f858o3e/LjJsfqis3e1qcx1Pu3C3p0y8yywXLPthPkldUuMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ux4Sxe57; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ux4Sxe57"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780982397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qqv7V2fOPtI/ThmR4RMSaDZYBMTub7x0mcT3c/TCl7o=;
	b=Ux4Sxe57og2EYdBgnIZvy0cSOLF9yLWtWin3GQWmouHEodCUIvvez5+X2r0GUqwrqd53Jq
	CmmT5DtrtboERLh7WRMjnZiatGY9NrclpTXmn6pDm73lPPWFlKHQFKZm4QM2cIbXoUYj6i
	FEIWEDC/DcQtfVpbohDn/TT2CaszR2U=
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Tue, 09 Jun 2026 05:19:27 +0000
Subject: [PATCH 2/2] arm64: ftrace: allow DIRECT_CALLS without CALL_OPS
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-arm64-ftrace-direct-calls-v1-2-4a46f266697f@linux.dev>
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

arm64 gained ftrace direct calls in commit 2aa6ac03516d ("arm64:
ftrace: Add direct call support") on top of
DYNAMIC_FTRACE_WITH_CALL_OPS, using the per-callsite ops pointer as a
fast path to reach the direct trampoline. Since commit baaf553d3bc3
("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS"), CALL_OPS is
mutually exclusive with CFI: the pre-function NOPs would change the
offset of the pre-function kCFI type hash, and the compiler support
needed to keep that offset consistent does not exist yet.

The result is that a CONFIG_CFI=y kernel loses CALL_OPS, and with it
DIRECT_CALLS, and with it every BPF trampoline attachment to kernel
functions: register_fentry() returns -ENOTSUPP, so fentry/fexit,
fmod_ret and BPF LSM programs cannot attach at all. This is a real
problem for hardened arm64 deployments that rely on BPF LSM for
security monitoring while keeping kCFI enabled.

CALL_OPS is an optimization for direct calls, not a dependency. When
the direct trampoline is within BL range, the callsite branches
straight to it and ftrace_caller is not involved. When it is out of
range, ftrace_find_callable_addr() already falls back to
ftrace_caller, and the DIRECT_CALLS machinery there
(FREGS_DIRECT_TRAMP, ftrace_caller_direct_late) is gated on
DIRECT_CALLS alone, not CALL_OPS: the ops dispatch invokes
call_direct_funcs(), which stores the trampoline address in
ftrace_regs, and ftrace_caller tail-calls it. s390 and loongarch use
this same mechanism for HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS without
having CALL_OPS at all, and DYNAMIC_FTRACE_WITH_ARGS without CALL_OPS
is already a supported arm64 configuration (GCC builds with
CC_OPTIMIZE_FOR_SIZE do not satisfy the CALL_OPS select condition).

Drop the CALL_OPS requirement from the
HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS select. Configurations that
keep CALL_OPS (!CFI clang builds, and GCC builds without
CC_OPTIMIZE_FOR_SIZE) are unchanged. CALL_OPS-less configurations
take the ftrace_caller ops-dispatch path for out-of-range direct
calls, trading the per-callsite fast path for working BPF
trampolines; in-range attachments still branch directly with no
overhead. GCC -Os builds also gain DIRECT_CALLS as a side effect.
That is intended: s390 and loongarch already ship DIRECT_CALLS
without any per-callsite fast path.

Assisted-by: Claude:unspecified
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe60738e5943b..2cd7d536671c9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -188,7 +188,7 @@ config ARM64
 		if (GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS || \
 		    CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS)
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
-		if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
+		if DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
 		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI && \
 		    (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))

-- 
2.52.0

