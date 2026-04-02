Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA623939AE
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122002; cv=none; b=UqKW9ufC3JDxgIP/jDjZzLLPw4Y7vdVky7LYK6drbWCHfhl2SpNveaYitZdO92+fkt/sgv4BI/q7Goe8TFVcB7KfoQscR9ztD4sAJNh3g/7KvLT14l0IY1Ya8RtSDj+t372q+r/769OYnm0vBw1wcfj9WDxxT+ir+26qiOUock8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122002; c=relaxed/simple;
	bh=ej1QnT2eQaleNxlMgrs1gAsCPfQsz0m2v5hxcKmj2rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z85v/s2eMQuC/q/HEnnyR0ddDxdJhsWAq7WSfkdqx1gWgr+0NkugkxtU3IbR09BhS4PCTRRklyJSvZKjhSiSrPcDH5/Eh71KSxfCMBvPUApht9Ky9qAb3sOY+ped/ffAcb5LRiwJP9ByQEChSZw9ifBTaZYXsmwGh8BPktXoJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F03xzT2Z; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F03xzT2Z"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso390879a91.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775121989; x=1775726789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SG/JGJww/E4NFDS2ytnaNRFZJ2JnJt66danprE2gSxY=;
        b=F03xzT2ZtDi9zfHTPvbpiGmxCiZqaXs2IInz/hYR6jKRDhxsREf3+kiceC4XG3YfPI
         wALlAiGtb8sC4pEAEGeOVl9Zpz71P07gmCrD0e5khcTptydUKVcTxGDw2SuXnmhBTUyA
         a9B+g14Ggcn3bLyk/SrUZSlGyf7AJnqAYCMPIKvQHMzYFpNnLv9oL8lVaoIw6hzZvqDV
         acV2y1bGXFO991EZbfJj78HwgTzg2ZFsBc6Ia8Xx59HSBWJPrMk6kS+loq9i1cWhOQR7
         0yPnWXnbHTt8m8j1P9qA85GCM4cETPCXFd7Am48Sl4XU7TNictnA/RmJSi3jnC0T+jQ1
         AhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775121989; x=1775726789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SG/JGJww/E4NFDS2ytnaNRFZJ2JnJt66danprE2gSxY=;
        b=AmH5n1eaEiB+rs6JYIJIZax0Q1XqxG/tbw5//2H04KoXCXCFCTZgdQYtsP8xu8qaER
         4wOFaGT4rDOLIE3P1r/QXR8WIWhwxrWXRuX9ZRtcPHLkKYdBnH8l8n1qqWfTSo6ko1+A
         Shv94N8bqWlXPxrGZTcCoxTp0AWJhuR6uONgtkX2u5AMZbKH8aoPeX2EHRnR5sti7and
         UfbW9fLGNYm3TJXYLahyZtK9qrp9zwv9oC6UHhJb1xPytH8YrahEIsjW/Jkm388VWVvG
         JQk74JZta+SLnxYGZ5VsfTJnZNQoUXUu0c6aBFU3ooMa9wvTnArRTnltC4czBQ0Mvek6
         g6ow==
X-Forwarded-Encrypted: i=1; AJvYcCXlP2oD+7QDVIPCEF6DVMTgoURlrRrix9wjgKC9b+cdxiIc/TnEEOFfP0Vp1ahA4X2m+ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw35ppF0mZkamnIcoYdSY2jpc6UqUmqgg4+DwW93ttFrHIOFOrz
	y3mP1xl++0aT0CMDSsbzdjC0vkqA9EQxRXb7m/lFc+8g70C4HUwhtbyD
X-Gm-Gg: AeBDiesLEQZ4oxldLG2xRLfEoq2fb7pBqQ3NS+IW/htZX+EyJEV3OTuveeI+oJpRxAf
	rSjrI4r1dFTFxf7bbHXiu4WsczYLQ56XdI7TTrtklOP9iop0mcgCbXGnkA+a7PxN+XdnsQxt4b9
	eLW0J+t4mtG8G3ZsK7rp4oV8GHFnmeEgcRwqRse4RcgTvNHDTc9PMvWSstzP6mnDqhXzjHWIA4m
	xtcoEImS5ZBppLtXPChBVaDEqg5HCMH91DPLrCmw5wLXSgKspf5THGNOPn0zbsH17srqZPdiQtf
	6WviyPi553ZBia2L+W7//l00tZc7ywq+MNqqDy758zdyzihmSFjOBCwlEkLEEt+hLPc31oGL8HA
	1L02kwnht7DxeKje2cM5FiCnPhIG4s89AFb7YihoZ5X59v/EYY0798aGEt2V0zcYn2f/I97BjPo
	3LpmDlR0QKsnL1zXcYygWQq6j2zpSrQLINgJeB/JAteD/A
X-Received: by 2002:a17:90b:3a8b:b0:35d:93ff:2859 with SMTP id 98e67ed59e1d1-35dc6f92e1amr6324093a91.22.1775121989484;
        Thu, 02 Apr 2026 02:26:29 -0700 (PDT)
Received: from yafangs-Air ([2409:891f:1aa0:8613:19f3:7bee:2e41:149e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f50e9sm2227645a91.6.2026.04.02.02.26.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 02:26:29 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: jpoimboe@kernel.org,
	jikos@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	joe.lawrence@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Cc: live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 1/4] trace: Simplify kprobe overridable function check
Date: Thu,  2 Apr 2026 17:26:04 +0800
Message-ID: <20260402092607.96430-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402092607.96430-1-laoar.shao@gmail.com>
References: <20260402092607.96430-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the logic for checking overridable kprobe functions by removing
redundant code.

No functional change.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/trace/bpf_trace.c    | 13 ++++++---
 kernel/trace/trace_kprobe.c | 40 +++++----------------------
 kernel/trace/trace_probe.h  | 54 ++++++++++++++++++++++++++-----------
 3 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0b040a417442..c901ace836cb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1929,10 +1929,15 @@ int perf_event_attach_bpf_prog(struct perf_event *event,
 	 * Kprobe override only works if they are on the function entry,
 	 * and only if they are on the opt-in list.
 	 */
-	if (prog->kprobe_override &&
-	    (!trace_kprobe_on_func_entry(event->tp_event) ||
-	     !trace_kprobe_error_injectable(event->tp_event)))
-		return -EINVAL;
+	if (prog->kprobe_override) {
+		struct trace_kprobe *tp = trace_kprobe_primary_from_call(event->tp_event);
+
+		if (!tp)
+			return -EINVAL;
+		if (!trace_kprobe_on_func_entry(tp) ||
+		    !trace_kprobe_error_injectable(tp))
+			return -EINVAL;
+	}
 
 	mutex_lock(&bpf_event_mutex);
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a5dbb72528e0..768702674a5c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -53,17 +53,6 @@ static struct dyn_event_operations trace_kprobe_ops = {
 	.match = trace_kprobe_match,
 };
 
-/*
- * Kprobe event core functions
- */
-struct trace_kprobe {
-	struct dyn_event	devent;
-	struct kretprobe	rp;	/* Use rp.kp for kprobe use */
-	unsigned long __percpu *nhit;
-	const char		*symbol;	/* symbol name */
-	struct trace_probe	tp;
-};
-
 static bool is_trace_kprobe(struct dyn_event *ev)
 {
 	return ev->ops == &trace_kprobe_ops;
@@ -212,33 +201,16 @@ unsigned long trace_kprobe_address(struct trace_kprobe *tk)
 	return addr;
 }
 
-static nokprobe_inline struct trace_kprobe *
-trace_kprobe_primary_from_call(struct trace_event_call *call)
-{
-	struct trace_probe *tp;
-
-	tp = trace_probe_primary_from_call(call);
-	if (WARN_ON_ONCE(!tp))
-		return NULL;
-
-	return container_of(tp, struct trace_kprobe, tp);
-}
-
-bool trace_kprobe_on_func_entry(struct trace_event_call *call)
+bool trace_kprobe_on_func_entry(struct trace_kprobe *tp)
 {
-	struct trace_kprobe *tk = trace_kprobe_primary_from_call(call);
-
-	return tk ? (kprobe_on_func_entry(tk->rp.kp.addr,
-			tk->rp.kp.addr ? NULL : tk->rp.kp.symbol_name,
-			tk->rp.kp.addr ? 0 : tk->rp.kp.offset) == 0) : false;
+	return !kprobe_on_func_entry(tp->rp.kp.addr,
+			tp->rp.kp.addr ? NULL : tp->rp.kp.symbol_name,
+			tp->rp.kp.addr ? 0 : tp->rp.kp.offset);
 }
 
-bool trace_kprobe_error_injectable(struct trace_event_call *call)
+bool trace_kprobe_error_injectable(struct trace_kprobe *tp)
 {
-	struct trace_kprobe *tk = trace_kprobe_primary_from_call(call);
-
-	return tk ? within_error_injection_list(trace_kprobe_address(tk)) :
-	       false;
+	return within_error_injection_list(trace_kprobe_address(tp));
 }
 
 static int register_kprobe_event(struct trace_kprobe *tk);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 9fc56c937130..958eb78a9068 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -30,6 +30,7 @@
 
 #include "trace.h"
 #include "trace_output.h"
+#include "trace_dynevent.h"
 
 #define MAX_TRACE_ARGS		128
 #define MAX_ARGSTR_LEN		63
@@ -210,21 +211,6 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 #define ASSIGN_FETCH_TYPE_END {}
 #define MAX_ARRAY_LEN	64
 
-#ifdef CONFIG_KPROBE_EVENTS
-bool trace_kprobe_on_func_entry(struct trace_event_call *call);
-bool trace_kprobe_error_injectable(struct trace_event_call *call);
-#else
-static inline bool trace_kprobe_on_func_entry(struct trace_event_call *call)
-{
-	return false;
-}
-
-static inline bool trace_kprobe_error_injectable(struct trace_event_call *call)
-{
-	return false;
-}
-#endif /* CONFIG_KPROBE_EVENTS */
-
 struct probe_arg {
 	struct fetch_insn	*code;
 	bool			dynamic;/* Dynamic array (string) is used */
@@ -271,6 +257,32 @@ struct event_file_link {
 	struct list_head		list;
 };
 
+/*
+ * Kprobe event core functions
+ */
+struct trace_kprobe {
+	struct dyn_event	devent;
+	struct kretprobe	rp;	/* Use rp.kp for kprobe use */
+	unsigned long __percpu	*nhit;
+	const char		*symbol;	/* symbol name */
+	struct trace_probe	tp;
+};
+
+#ifdef CONFIG_KPROBE_EVENTS
+bool trace_kprobe_on_func_entry(struct trace_kprobe *tp);
+bool trace_kprobe_error_injectable(struct trace_kprobe *tp);
+#else
+static inline bool trace_kprobe_on_func_entry(struct trace_kprobe *tp)
+{
+	return false;
+}
+
+static inline bool trace_kprobe_error_injectable(struct trace_kprobe *tp)
+{
+	return false;
+}
+#endif /* CONFIG_KPROBE_EVENTS */
+
 static inline unsigned int trace_probe_load_flag(struct trace_probe *tp)
 {
 	return smp_load_acquire(&tp->event->flags);
@@ -329,6 +341,18 @@ trace_probe_primary_from_call(struct trace_event_call *call)
 	return list_first_entry_or_null(&tpe->probes, struct trace_probe, list);
 }
 
+static nokprobe_inline struct trace_kprobe *
+trace_kprobe_primary_from_call(struct trace_event_call *call)
+{
+	struct trace_probe *tp;
+
+	tp = trace_probe_primary_from_call(call);
+	if (WARN_ON_ONCE(!tp))
+		return NULL;
+
+	return container_of(tp, struct trace_kprobe, tp);
+}
+
 static inline struct list_head *trace_probe_probe_list(struct trace_probe *tp)
 {
 	return &tp->event->probes;
-- 
2.47.3

