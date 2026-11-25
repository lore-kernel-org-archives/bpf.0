Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587379;
	b=CXOssRoVHjWkoA0ky+/R3Qc3dULsx6AZwKZmfujKonKpU4UaWJo8R9wyrmgJcwn3Qhjy
	 Qub92pibpf56WqyhfqBKfSGkuleVjLTXVZHRwHqFHWrY6gttfTywIhYA0Cf8xbsTynm6/
	 ONumpVLZ1E2RaWJdLIrBrvvfbCKAt1/Ukdl6+NXGyJgdO65dBH387VkMR5SvirItbgqvJ
	 cqDe4gNVjOTaKrwBftuKUSiyIf2Wdk2uDlIZqZNcnWCRtl9CDPcx8CrjcFVSetLZVPYgI
	 YVl8SdJsqwKfvUaLJgmbwvZv2eHdY3A0WS2bHrw5BwmhF8MB4xi+aXL/yEG+ybvSB+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=09MAmcu0nJvDv2rEHeASXKSxzXy8pllt4XI/+xpi/1s=;
	b=RX4Ub0h0yfHYqc/5AncnTiikiZ1V/rCyTRa6Mm50R5o4F64FJl+V+TwBBbrf1iSI7x8T
	 PS6c1pr065zZ76ucBv4kzEo/apjwDmQ0izWdJn8wEsw2CT8SY6eCs1+dWabSapaNZ38RQ
	 5m+1gRGlnJvbG+lUQ1m5e3jVpGeEhHDdCLK/Q8Tq9PvibcdE7Sd26hDHp3i+lINoQ0xvQ
	 FbMhX8QVbBaxBz5rU4U0gT07u+UbiySKmj5Lsz312m3LJ27g3oTG/GxAHJkFJC60I8kR5
	 kV1LstZOy5W5RWG686/OxjOTA4d3WftxqcWQNrmgYs6Z1X3vJ4oWQayZNgS+NYr+R8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dey8gARL;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176360A383F
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 06:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8176360A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dey8gARL
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-384c78aa0dbso7370470eec.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587378; x=1796192178; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=09MAmcu0nJvDv2rEHeASXKSxzXy8pllt4XI/+xpi/1s=;
        b=Dey8gARL0zl+HK26wbFMxiGBA8YcmX3NlX3SQdJW4Beg8yIFR+ZQWG9yXAbv1+4+LJ
         HinqCqD4ZUypotxYlZRr76P7/2euNfmqhQJIzZsIPHKr+ZtBqZuG3x7TPActSOHvtcb3
         cZbLonVfOAsQaDw3HEKozAsbJGiSK8+eV8PcU0WCfT0RSGK6qoU8LeOKa/OYv51m5sC6
         WJX84xg4RX0hrRx4C1csROeM5fZKSb1roRQhv2vjGEacBZJO4bXRBqfFN0yXweaKNp+M
         SwLSsIRI68ofoCgg7SV2B474VN9kWJ+XLWEBynRB4z0FRuWcbpPzfG2gOrgPqayAm2TC
         6Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587378; x=1796192178;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=09MAmcu0nJvDv2rEHeASXKSxzXy8pllt4XI/+xpi/1s=;
        b=go3hEyHfFh7H0zKzCani2NH8sANO0CQ58VPUIohNNeF2Y7VkIIG0TMtMA4LxKelWKJ
         uQjZ1lmbUdj6N8I2+7yNV22LgDJOCg0xkxaeqGyrq2/C149NN9qeylziNBu6lHkk+e/H
         NQzDn6dTwic5IKCbuFtccgH7CadRaix98PQTp66b0zMGODT1Uq0ypJ9yt/PkA5kjCuwz
         U1bpcxm4PgVSjt4NZBrYRvZlvAlXXZ/s7M4f6o1zrkYZe0jNjD42yIZ9/4nJLWvZ2Q0V
         hhGDEEVxvSe8LqC/l/2aDT2euUTtEjMZbBQqdK4kM4xtvFjQXbIoNFVPbluq7IyL1NBV
         E8bQ==
X-Forwarded-Encrypted: i=1; AL+hErFe/lPiAkFqPBWtOIjNYyerRCgNywbX/IOGn2EUL2Cs8WuQLhjbgG8sGO0OHPgSkTWNa/4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9q07+E0AwmET7JOvr3x8d3n7NzZVpEUtpBVm5qRpQQd0GyTww+
	ZPb0SKMucTEYPb6qQLBcRRLomP8gIjA1wSFd0M3ekKfwGYSVuDaeM7ui6yi1eQ8O2B7gkeoUOgh
	lcOqCKHvt5g==
X-Received: from dyba9.prod.google.com ([2002:a05:693c:63c9:b0:386:a06c:3241])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c72d:b0:369:f9c4:1fda
 with SMTP id 5a478bee46e88-38570845628mr15750428eec.27.1795587377097; Tue, 24
 Nov 2026 22:16:17 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:03 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-11-irogers@google.com>
Subject: [RFC PATCH v2 10/30] tracing: Skip internal ftrace frames under CONFIG_UNWINDER_DWARF_CFI
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Calibrate ftrace internal stack-trace skip counts under
CONFIG_UNWINDER_DWARF_CFI alongside CONFIG_UNWINDER_ORC so stack traces
captured from tracepoints and function tracers omit internal ftrace
wrapper frames consistently.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/trace/trace.c                | 4 ++--
 kernel/trace/trace_events_trigger.c | 2 +-
 kernel/trace/trace_functions.c      | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 65b9d67647e5..6d36c790c2b0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2156,7 +2156,7 @@ void __ftrace_trace_stack(struct trace_array *tr,
 	 * Add one, for this function and the call to save_stack_trace()
 	 * If regs is set, then these functions will not be in the way.
 	 */
-#ifndef CONFIG_UNWINDER_ORC
+#if !defined(CONFIG_UNWINDER_ORC) && !defined(CONFIG_UNWINDER_DWARF_CFI)
 	if (!regs)
 		skip++;
 #endif
@@ -2258,7 +2258,7 @@ void trace_dump_stack(int skip)
 	if (tracing_disabled || tracing_selftest_running)
 		return;
 
-#ifndef CONFIG_UNWINDER_ORC
+#if !defined(CONFIG_UNWINDER_ORC) && !defined(CONFIG_UNWINDER_DWARF_CFI)
 	/* Skip 1 to skip this function. */
 	skip++;
 #endif
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index a2487ad7fef8..c79df5b526e5 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1597,7 +1597,7 @@ static __init int register_trigger_snapshot_cmd(void) { return 0; }
 #endif /* CONFIG_TRACER_SNAPSHOT */
 
 #ifdef CONFIG_STACKTRACE
-#ifdef CONFIG_UNWINDER_ORC
+#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_DWARF_CFI)
 /* Skip 2:
  *   event_triggers_post_call()
  *   trace_event_raw_event_xxx()
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index acaba990aaaa..d601fdedceaa 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -251,7 +251,7 @@ function_args_trace_call(unsigned long ip, unsigned long parent_ip,
 	ftrace_test_recursion_unlock(bit);
 }
 
-#ifdef CONFIG_UNWINDER_ORC
+#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_DWARF_CFI)
 /*
  * Skip 2:
  *
@@ -602,7 +602,7 @@ ftrace_traceoff(unsigned long ip, unsigned long parent_ip,
 	tracer_tracing_off(tr);
 }
 
-#ifdef CONFIG_UNWINDER_ORC
+#if defined(CONFIG_UNWINDER_ORC) || defined(CONFIG_UNWINDER_DWARF_CFI)
 /*
  * Skip 3:
  *
-- 
2.56.1.831.g720f3f5937-goog

