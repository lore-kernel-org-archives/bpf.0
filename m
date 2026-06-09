Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA033C062D
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 05:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982405; cv=none; b=NX9TGsIf+FbaPUdw3FOOLzHnnwwsi6qq+v9eIsyXaUSrrb/wUZT5oDz1+9XASIHpJOg0xm248QifVDHmnOU4sC/3s2VKgORDBF9nkj4wk6te6hQnMoPpQhuKLUWZJPRwrLFrRuYEy6tZCX8wLg3BYn7lE8o8GKviA5PldUkjM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982405; c=relaxed/simple;
	bh=idGronfk/CNWgoMTgjyc2YqGwMIt5TpuaKIUvksXZeQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YRjZm8jYYcDY2En1G+zpVv7l81nKaj57tAkym4viON/h/1imie1YajMUPomQI8acbU8SEk8AImDSwoyMQDqOzkdSKjF1OAWnrBQCT8wLYRG3Ix62j84paNGB5X/IIBY7Agrrncan9ED1cDguZ8WgMxruflmCrn4EwYd7lxvGEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k+jlu7oE; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k+jlu7oE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780982390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ClAMcshP9ole+jZsJ6EjKcYMFHKoHLwcztBI66MgTZo=;
	b=k+jlu7oEVRMPaM5cZ0DElHGQr26MJ5LHN0b3FzhQmloM/0Qot3EJAJj0Fvb1geyVU9Na+S
	R739AVvmFqxlSXDfecnwF9G+611PlKBgQbh7b9dt4Mfkl30r2cg/pjnr8RF6B7ouVv/MN4
	d9IQAY6Nmoh2745sJ4Y8fioopbNvITU=
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Subject: [PATCH 0/2] arm64: ftrace: support DIRECT_CALLS without CALL_OPS
Date: Tue, 09 Jun 2026 05:19:25 +0000
Message-Id: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF2iJ2oC/yWM0Q6CMAxFf4X02cYxlSX+ivGhjAI1MEw7jQnh3
 x36eG7uOSsYq7DBtVpB+S0mSypQHyqII6WBUbrC4J1vXOMCks7NGfusFBk7UY4ZI02TYX3x/uS
 4Dy4EKP5TuZfPr327/9le7aMIe3B/tGSMrVKK4z4tKoOk40yWWWHbvkKjaSSdAAAA
X-Change-ID: 20260607-arm64-ftrace-direct-calls-152230ef7077
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

On arm64, HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS is currently selected
only when DYNAMIC_FTRACE_WITH_CALL_OPS is available. CALL_OPS, in
turn, is mutually exclusive with kCFI: the pre-function NOPs it needs
would change the offset of the pre-function type hash (see
baaf553d3bc3 ("arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")),
and the compiler support needed to reconcile the two does not exist
yet.

The result is that a CONFIG_CFI=y arm64 kernel has no
ftrace direct calls at all, so register_fentry() fails with -ENOTSUPP
and no BPF trampoline can attach: fentry/fexit, fmod_ret and BPF LSM
programs are all unavailable. Deployments that want both kCFI
hardening and BPF-based security monitoring currently have to give
one of them up. systemd's bpf-restrict-fs feature hits this today:
https://lore.kernel.org/all/20250610232418.GA3544567@ax162/

CALL_OPS is an optimization for direct calls, not a dependency.
In-BL-range trampolines are reached by a direct branch without
consulting the ops pointer, and out-of-range trampolines already
fall back to ftrace_caller, where the DIRECT_CALLS machinery
(call_direct_funcs() storing the trampoline in ftrace_regs, the
ftrace_caller tail-call) is gated on DIRECT_CALLS alone. s390 and
loongarch ship HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS this way,
without having CALL_OPS at all.

Patch 1 prepares ftrace_modify_call() to build without CALL_OPS by
widening its #ifdef and using the existing ftrace_rec_update_ops()
wrapper (no functional change for current configurations). Patch 2
drops the CALL_OPS requirement from the DIRECT_CALLS select.

Configurations that keep CALL_OPS (clang !CFI, and GCC without
CC_OPTIMIZE_FOR_SIZE) are unchanged. We verified this: in an arm64
clang build, every object file is byte-identical before and after
the series except ftrace.o itself, and its disassembly is identical.
CFI builds (and GCC -Os builds) gain working direct calls, with
out-of-range attachments taking the ftrace_caller dispatch path
instead of the per-callsite fast path.

We tested on a 6.18.y-based kernel and on this base with clang
kCFI builds (CONFIG_CFI=y, enforcing) under qemu (TCG, and KVM on an
arm64 host) and on GB200-based arm64 hardware: fentry/fexit, fmod_ret
and BPF LSM programs load, attach and execute; the ftrace-direct
sample modules (including both modify samples, exercising
ftrace_modify_call()) run cleanly; no CFI violations observed. The
fentry_test, fexit_test, fentry_fexit, fexit_sleep, fexit_stress,
modify_return, tracing_struct, lsm and trampoline_count selftests and
the ftrace direct-call selftests (test.d/direct) pass on the new
configuration with results identical to a CALL_OPS kernel built from
the same tree, and a broader test_progs sweep showed no differences
attributable to this series. Without the series, all of the above
fail at attach time with -ENOTSUPP.

riscv has the same gap (its DIRECT_CALLS select also requires
CALL_OPS, and its CALL_OPS is likewise !CFI); if this approach is
acceptable for arm64 we can follow up there.

---
Jose Fernandez (Anthropic) (2):
      arm64: ftrace: prepare ftrace_modify_call() for use without CALL_OPS
      arm64: ftrace: allow DIRECT_CALLS without CALL_OPS

 arch/arm64/Kconfig         | 2 +-
 arch/arm64/kernel/ftrace.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260607-arm64-ftrace-direct-calls-152230ef7077

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

