Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B25391E68
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122009; cv=none; b=opZ7xjfwhTszxpkcPeqnnOf/F/ZZWhcRNMGhbAdAQihYUHYkHxJj9jFtusGbUrNnZTlWlCzzSv9fBCP30efAIDzQoeM6F4vgDuk6gLVUO+dIMOrpZjQ+sUIVabJC2yugwv36oSvHqe8pV/KohPToQo21cR9+jzZ3PVztgBa2ovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122009; c=relaxed/simple;
	bh=5nMc9qAcFEsGx3C7PmryTlLfGSZTMZVInAVBgvQtejY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raJTj3gCMRMyAd5vwUWYZyqz8jSjxSJpSYqxzn0FJT+0WsHuOMKi/QzeHDnPMlR9epHz4UDx/XOrhNISNNch50B8V/4stQQThGFyzBHSKAfFBrtYs6m15C0Jo7UVkwV066fei1WCQloceaJLhRXxk9/hwHDN0ApvhlyUjEXmCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG7MGOBv; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG7MGOBv"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35c124d2613so347763a91.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 02:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775121997; x=1775726797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81j40jm7xzkIDR0AUEs06y3jjZUfu/jUEFBO6OwZcOw=;
        b=ZG7MGOBvrOPdrSlJltkWWUZi7E2sgqmqfiuTaPjkWBNPF5s7PnyiRm36zvCIDtr6uX
         +c5B60RkEJue0Rewey+xsrKzgSWEJ3RGtrBQSHwstOEDhxuaxQbAklu3VtBcvAY/QGit
         MQKvw1sQbldvJBtUXOyLOcODIUqy+W5uIiM/TcJtYVKAbG97W9VcasXGLAXlbpv5HZay
         kq+BMPmCzbj4Vtes57fdyohUNWJbkjQW7gH737dCD/A7vXXgzFUMRFjTipV5Th0MRj3G
         e849m1pvOVsB132tO5tWgEHQa0DMaoiVDR2OLgv4xW+TLnnWTqXxY1bRkVL5sXDVOjhZ
         Fcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775121997; x=1775726797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=81j40jm7xzkIDR0AUEs06y3jjZUfu/jUEFBO6OwZcOw=;
        b=MwFdIwHWyEmsiX24LUcklFM/hglHBf4kWEldG5prA5km5Be/Gt7nydxWGKhaXLjSKt
         3Njo8eD4BfaRGtUsLNicfFNwYyQcdFBw2e55jcQ07g0hhLZTqNyYbpI7ex8R1dsSQ1xh
         2Xd8jaODkMwJ1m2+p550s7QxcZyKL/ppkcsKsJr6njbN2cmq4XkcXfG4ZBlA7sBvFVYF
         poAEkMCneF1DBc/zJCaJD2kUts4drusiglbr5SrkFhnd94B9ZEjz4DFNYcWJLlVJxV4m
         k1NsjgzK5fTMcR1luaJwBanW6zrhW5QQ2gv68xp7cVnN7bmbiDpRsJgZspCiReD2xdat
         Jxug==
X-Forwarded-Encrypted: i=1; AJvYcCVOgx5UPG4nzIiCJFm6dAp1Vc6zIB78dXbAgCY0p355Ms8X5fHLf9Rq6oEnraNWzBsAvNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84asYXdhdd5x//kEosLOy5yaiT3WuTpoBX38N2U2zyeSmpLLn
	lei41G5gF8XV3sluL313Fg48oZAMaQc+asemyVaKw+OUs9T+tUE+Regw
X-Gm-Gg: AeBDievW25R33ur69P4XjdqCPXRPyzAcTd4T3GIK+NIICwjJOB1Zmev0mLqWWmF6w+2
	mqcsfgI/3LqI1/M9K3oNxCs8YbVzRjpz/75fyrlVpDkH8Kh1uJZ1ybVJDsjVvW2Yq+sCdh8WS62
	QMqUGAaHkF3w64PpeaDGBekew5dfTzEHHXvsHtejdXKTTCRDrq8L6JFbp57EoYdjSflqn2cK1F9
	pZVHoFfwupT5kTq7ZsYZhYwBichNpTFAKEHzhhFCqWWUtFmblRj90op33cPhuC4eQTT4geEMFDL
	JKT2RVGWfg7kFx5L4qL8gS11/TJNOlnziIeERN20CWoCqpuR+RSxF4cwAJQrAMOupEgTqFdYAmB
	fpXVsQAZQR6EeLsQTJ/4Z5J2anU7gLQ+DJEVTVBf0i2DV/FiDYc2+P72QmuNpaXNP1Wuo74dbgB
	exXmYwL8CqUK/YvtnL2phzF7zqLp+HpNmMhulHA8jykeH0
X-Received: by 2002:a17:90b:5350:b0:359:8dfd:64c8 with SMTP id 98e67ed59e1d1-35dc6f3b854mr6703431a91.24.1775121996713;
        Thu, 02 Apr 2026 02:26:36 -0700 (PDT)
Received: from yafangs-Air ([2409:891f:1aa0:8613:19f3:7bee:2e41:149e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f50e9sm2227645a91.6.2026.04.02.02.26.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 02:26:36 -0700 (PDT)
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
Subject: [RFC PATCH 2/4] trace: Allow kprobes to override livepatched functions
Date: Thu,  2 Apr 2026 17:26:05 +0800
Message-ID: <20260402092607.96430-3-laoar.shao@gmail.com>
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

Introduce the ability for kprobes to override the return values of
functions that have been livepatched. This functionality is guarded by the
CONFIG_KPROBE_OVERRIDE_KLP_FUNC configuration option.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/trace/Kconfig        | 14 ++++++++++++++
 kernel/trace/bpf_trace.c    |  3 ++-
 kernel/trace/trace_kprobe.c | 17 +++++++++++++++++
 kernel/trace/trace_probe.h  |  5 +++++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 49de13cae428..db712c8cb745 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1279,6 +1279,20 @@ config HIST_TRIGGERS_DEBUG
 
           If unsure, say N.
 
+config KPROBE_OVERRIDE_KLP_FUNC
+	bool "Allow kprobes to override livepatched functions"
+	depends on KPROBES && LIVEPATCH
+	help
+	  This option allows BPF programs to use kprobes to override functions
+	  that have already been patched by Livepatch (KLP).
+
+	  Enabling this provides a mechanism to dynamically control execution
+	  flow without requiring a reboot or a new livepatch module. It
+	  effectively combines the persistence of livepatching with the
+	  programmability of BPF.
+
+	  If unsure, say N.
+
 source "kernel/trace/rv/Kconfig"
 
 endif # FTRACE
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c901ace836cb..08ae2b1a912c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1935,7 +1935,8 @@ int perf_event_attach_bpf_prog(struct perf_event *event,
 		if (!tp)
 			return -EINVAL;
 		if (!trace_kprobe_on_func_entry(tp) ||
-		    !trace_kprobe_error_injectable(tp))
+		    (!trace_kprobe_error_injectable(tp) &&
+		     !trace_kprobe_klp_func_overridable(tp)))
 			return -EINVAL;
 	}
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 768702674a5c..6f05451fbc76 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -213,6 +213,23 @@ bool trace_kprobe_error_injectable(struct trace_kprobe *tp)
 	return within_error_injection_list(trace_kprobe_address(tp));
 }
 
+bool trace_kprobe_klp_func_overridable(struct trace_kprobe *tp)
+{
+	bool overridable = false;
+#ifdef CONFIG_KPROBE_OVERRIDE_KLP_FUNC
+	struct module *mod;
+	unsigned long addr;
+
+	addr = trace_kprobe_address(tp);
+	rcu_read_lock();
+	mod = __module_address(addr);
+	if (mod && mod->klp)
+		overridable = true;
+	rcu_read_unlock();
+#endif
+	return overridable;
+}
+
 static int register_kprobe_event(struct trace_kprobe *tk);
 static int unregister_kprobe_event(struct trace_kprobe *tk);
 
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 958eb78a9068..84bd2617db7c 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -271,6 +271,7 @@ struct trace_kprobe {
 #ifdef CONFIG_KPROBE_EVENTS
 bool trace_kprobe_on_func_entry(struct trace_kprobe *tp);
 bool trace_kprobe_error_injectable(struct trace_kprobe *tp);
+bool trace_kprobe_klp_func_overridable(struct trace_kprobe *tp);
 #else
 static inline bool trace_kprobe_on_func_entry(struct trace_kprobe *tp)
 {
@@ -281,6 +282,10 @@ static inline bool trace_kprobe_error_injectable(struct trace_kprobe *tp)
 {
 	return false;
 }
+static inline bool trace_kprobe_klp_func_overridable(struct trace_kprobe *tp)
+{
+	return false;
+}
 #endif /* CONFIG_KPROBE_EVENTS */
 
 static inline unsigned int trace_probe_load_flag(struct trace_probe *tp)
-- 
2.47.3

