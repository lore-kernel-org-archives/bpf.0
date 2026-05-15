Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818233F9F4F
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863302; cv=none; b=swG4xR7y12DANKM5rBOLVA5Kl/UMWyYMBVJ0gMBxydv9igV5H0P2IjNfW3s4o3EKBjvkc0PZK6l8QbPWuhk8LZJ6C+gAptR2F7GwCp4GTLhcL7k1w2k4KjuZKb9dP1k2w4MmpOIXRP6KgtwSIr65ZgeByYkPQOs/+rb+EYduS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863302; c=relaxed/simple;
	bh=IdulbVGacJ/bQzx5089I84qacT3J4BC4q3nuRc0e034=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rheKbN94Fb64mlW4e7S2OkRAezwvejVeiRrMJ+RPZUyWpvqqSBi+OIGeTgczDHCVQzFQOFBQNirKwuhUGUUSuYtY41o9X0jcRBHzQmvThfQkYu2fqwi8REw2+lsbOtEXIZot2rFLyeXjhjEw+DnHvNDBMc1J+KmEvhUfBKtAcko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxSp5ozA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxSp5ozA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48d146705b4so100245e9.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778863297; x=1779468097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CregFwv3ydHvopUmGYHDk+66XeIMPS+Ef7u0JPHldLU=;
        b=GxSp5ozAlnZEvnkUTo3uy1Zcsf+EY4dtIdJD7IKkZKg0L4v7grX50zxDzkfPfYBKfP
         1RY1En7xyoJOU+UJCa8SaLM6o95FZKoWjpGHOwI3hNaVKN/cILAto16N1U6dcDXBJjN+
         wpjjycV+V1nwm7ZD11bpxKTMLRQljbiBVKYEUdE7UfC4sM1v9fyzkDE+6xdEF5DIkRHm
         NNpMN0Nq0dcotzBLIaE8sgyuORQqJTRyJ35LEC6hSoywkZjtbCJ7xATRWdEB4+0nTU8T
         eBt+jS5fvkzorzAnvXtN5pdr3HSyPjS8cmHWeI0LFX6sR9qgvNJFAXO0CkuvIcYsrjVf
         D6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863297; x=1779468097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CregFwv3ydHvopUmGYHDk+66XeIMPS+Ef7u0JPHldLU=;
        b=i5EKX6CZFipxGrzbDUtExrr2tWk5NXVOYJJsWOGZDvreJNyW68ITo0BtcsqElaRDg9
         MYja9mgUyciEfebj2HUooTGQHGDgrTaVlDiD4GHW4Gjrm38wqyK9CIFjdO/cr02a7Sfa
         3qr2Iqn7YTmKOZB0EV6OAM/q7IW6pH1UxMs08cou6vXdoPqD7xMdpOMR2wQ/UM+gP+sx
         DkBfbxj6s+PvlBkY06EZkMJm6N49+A+CVAtsVlSNsV2/pfVd8Hpc6b49wP0gl9JMXv52
         hX8INc+W+y//cOplTF5snNOiCg9ENQMaw/oWqHyLqAjCfNq0pAB4nsaDiKwM/cF4KEGx
         7Q/w==
X-Gm-Message-State: AOJu0YwEBWG1IzuV4ZWgNfdcDeYq+E9/0NOul67k1338WjnY+MsMVGTj
	lWiCue2LuObYtpJRiD8Xkoqiwgp/BMavL54GVH87yCZ29DbsNo+s0+wwpNltnpcG
X-Gm-Gg: Acq92OEAipA9C+dKSKAHf6Hv2NXoen9Df08FqX81ov7ztMKCMxXJ1rawe6MEg2oQLzl
	erFcFMYJX4VBlNhZhtkzKFXyepQEWXGlRW3iPPA6xHpJamO+T6cMaeY+Q+J3S8cRA1Vs3xwxsDy
	PGzMpqejfqCgylnQJqk0dxlN8uZ3U9JiLfF51ol6lt55YYmVChBBpkH0pKeaS2Podm0TcrJntht
	+2T9QpxKslVbXLAwmLnZ1/B3p3R8b/ZAEzE+MkSQoH//47LI+K+mX3Ny8OnOv5ubNNmw83/EfcE
	hl7kdKkKfsJgKF4YU9b/JHxdcxXLmLdkeGuUPvYrwWfHWIQatYtAzGBusISD01R59Gv0NmqqyGH
	MF0VNpNe8vC2WitqQIIZHygUK3TbiYYNq2RrQjf14IlHH/Sxh7Esp7Fnvo0wYDvkstWPMJVsF2s
	dxIJvZMoUyCKDl4Q==
X-Received: by 2002:a05:600c:c087:b0:488:d6eb:e63c with SMTP id 5b1f17b1804b1-48fe61f2768mr52857995e9.15.1778863297490;
        Fri, 15 May 2026 09:41:37 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fead18659sm18898645e9.7.2026.05.15.09.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:41:37 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 15 May 2026 09:41:02 -0700
Subject: [PATCH bpf-next 2/3] tracing: Expose tracepoint BTF ids via
 tracefs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-generic_tracepoint-v1-2-aa619fa94132@meta.com>
References: <20260515-generic_tracepoint-v1-0-aa619fa94132@meta.com>
In-Reply-To: <20260515-generic_tracepoint-v1-0-aa619fa94132@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778863293; l=9202;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=FYLk0fSlZN5CRpcg9Ye/5vSWuNFZ8ZEhafryjMGdr9U=;
 b=yaZLbWEfFfMCX91J2p7Fvs3gzL73+C2Eym26YT7sfPkH2Gc74C0F4iyTDYyWSj6bO6Pmdq0IZ
 TqPKkGMwJdLAuL6g9y/NP3pRtT52YdETr586b/J9/F/yJm72KjXn8l+
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add events/<sys>/<event>/btf_ids, a per-template file that exposes
the BTF ids resolve_btfids fills in for each tracepoint:

  btf_obj_id  BTF object owning the ids below
  raw_btf_id  FUNC_PROTO of __bpf_trace_<call> (named args), consumed
              by raw_tp / tp_btf BPF programs
  tp_btf_id   trace_event_raw_<call> ring-buffer record, consumed by
              classic BPF_PROG_TYPE_TRACEPOINT programs

DECLARE_EVENT_CLASS now emits a 2-entry BTF_ID_LIST (FUNC __bpf_trace_*
and STRUCT trace_event_raw_*) and stores the pointer in
trace_event_class.

Per-syscall events under syscalls/ share the handcrafted classes
event_class_syscall_{enter,exit} instead of going through
DECLARE_EVENT_CLASS. Wire those classes to the BTF id lists
generated for sys_enter / sys_exit so all  ~700 per-syscall
events expose the shared dispatcher prototype and record.
The per-syscall events do not own their own tracepoint
(they share sys_enter/sys_exit), so raw_btf_id is reported as 0
on those events; the meaningful raw_btf_id is exposed on
raw_syscalls/sys_{enter,exit}/btf_ids where raw_tp / tp_btf
programs can actually attach.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/trace_events.h  |  9 +++++
 include/trace/trace_events.h  | 24 +++++++++++++
 kernel/trace/trace_events.c   | 81 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_syscalls.c | 17 +++++++++
 4 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d49338c44014..3d55b3cc014a 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -298,6 +298,15 @@ struct trace_event_class {
 	struct list_head	*(*get_fields)(struct trace_event_call *);
 	struct list_head	fields;
 	int			(*raw_init)(struct trace_event_call *);
+#ifdef CONFIG_BPF_EVENTS
+	/*
+	 * Per-template BTF ids set by DECLARE_EVENT_CLASS via BTF_ID() and
+	 * patched by resolve_btfids at link time. NULL for handcrafted classes.
+	 *   [0] FUNC   __bpf_trace_<template>
+	 *   [1] STRUCT trace_event_raw_<template>
+	 */
+	const u32		*btf_ids;
+#endif
 };
 
 extern int trace_event_reg(struct trace_event_call *event,
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index fbc07d353be6..09ad57ac4b73 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -19,6 +19,7 @@
  */
 
 #include <linux/trace_events.h>
+#include <linux/btf_ids.h>
 
 #ifndef TRACE_SYSTEM_VAR
 #define TRACE_SYSTEM_VAR TRACE_SYSTEM
@@ -397,6 +398,27 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #define _TRACE_PERF_INIT(call)
 #endif /* CONFIG_PERF_EVENTS */
 
+#ifdef CONFIG_BPF_EVENTS
+/*
+ * Per-template BTF id list, populated at link time by resolve_btfids:
+ *   [0] FUNC   __bpf_trace_<call>     (the BPF dispatcher)
+ *   [1] STRUCT trace_event_raw_<call> (the ring-buffer record)
+ * Exposed via the events/<sys>/<name>/btf_ids tracefs file.
+ */
+#define _TRACE_BTF_IDS_DECLARE(call)					\
+	extern u32 __bpf_trace_btf_ids_##call[];			\
+	BTF_ID_LIST_GLOBAL(__bpf_trace_btf_ids_##call, 2)		\
+	BTF_ID(func,   __bpf_trace_##call)				\
+	BTF_ID(struct, trace_event_raw_##call)
+
+#define _TRACE_BTF_IDS_INIT(call)					\
+	.btf_ids		= __bpf_trace_btf_ids_##call,
+
+#else
+#define _TRACE_BTF_IDS_DECLARE(call)
+#define _TRACE_BTF_IDS_INIT(call)
+#endif /* CONFIG_BPF_EVENTS */
+
 #include "stages/stage6_event_callback.h"
 
 
@@ -474,6 +496,7 @@ static inline void ftrace_test_probe_##call(void)			\
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 _TRACE_PERF_PROTO(call, PARAMS(proto));					\
+_TRACE_BTF_IDS_DECLARE(call)						\
 static char print_fmt_##call[] = print;					\
 static struct trace_event_class __used __refdata event_class_##call = { \
 	.system			= TRACE_SYSTEM_STRING,			\
@@ -483,6 +506,7 @@ static struct trace_event_class __used __refdata event_class_##call = { \
 	.probe			= trace_event_raw_event_##call,		\
 	.reg			= trace_event_reg,			\
 	_TRACE_PERF_INIT(call)						\
+	_TRACE_BTF_IDS_INIT(call)					\
 };
 
 #undef DECLARE_EVENT_SYSCALL_CLASS
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..d463fb44c790 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -22,6 +22,7 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/btf.h>
 
 #include <trace/events/sched.h>
 #include <trace/syscall.h>
@@ -2200,6 +2201,62 @@ event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 }
 #endif
 
+#ifdef CONFIG_BPF_EVENTS
+static ssize_t
+event_btf_ids_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct trace_event_file *file;
+	struct trace_event_call *call;
+	const struct btf_type *t;
+	struct module *mod = NULL;
+	u32 raw_id, tp_id;
+	const u32 *ids;
+	struct btf *btf;
+	char buf[128];
+	int len;
+
+	/* Module unload could free call->class and ids[] mid-read. */
+	guard(mutex)(&event_mutex);
+
+	file = event_file_file(filp);
+	if (!file)
+		return -ENODEV;
+
+	call = file->event_call;
+	ids = call->class->btf_ids;
+	if (!ids)
+		return -ENOENT;
+	if (!(call->flags & TRACE_EVENT_FL_DYNAMIC))
+		mod = (struct module *)call->module;
+
+	btf = btf_get_module_btf(mod);
+	if (IS_ERR_OR_NULL(btf))
+		return -ENOENT;
+
+	/* Module-local ids in ids[] need base+local relocation. */
+	tp_id = btf_relocate_id(btf, ids[1]);
+
+	/*
+	 * Without FL_TRACEPOINT the dispatcher is shared (e.g. all
+	 * per-syscall events fan out from __bpf_trace_sys_enter), so
+	 * raw_btf_id has no per-event attach point — report 0.
+	 */
+	if (call->flags & TRACE_EVENT_FL_TRACEPOINT) {
+		t = btf_type_by_id(btf, btf_relocate_id(btf, ids[0]));
+		raw_id = t ? t->type : 0;
+	} else {
+		raw_id = 0;
+	}
+
+	len = scnprintf(buf, sizeof(buf),
+			"btf_obj_id: %u\nraw_btf_id: %u\ntp_btf_id: %u\n",
+			btf_obj_id(btf), raw_id, tp_id);
+	btf_put(btf);
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
+}
+#endif
+
 static ssize_t
 event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
 		  loff_t *ppos)
@@ -2700,6 +2757,13 @@ static const struct file_operations ftrace_event_id_fops = {
 };
 #endif
 
+#ifdef CONFIG_BPF_EVENTS
+static const struct file_operations ftrace_event_btf_ids_fops = {
+	.read = event_btf_ids_read,
+	.llseek = default_llseek,
+};
+#endif
+
 static const struct file_operations ftrace_event_filter_fops = {
 	.open = tracing_open_file_tr,
 	.read = event_filter_read,
@@ -3093,6 +3157,14 @@ static int event_callback(const char *name, umode_t *mode, void **data,
 	}
 #endif
 
+#ifdef CONFIG_BPF_EVENTS
+	if (call->class->btf_ids && strcmp(name, "btf_ids") == 0) {
+		*mode = TRACE_MODE_READ;
+		*fops = &ftrace_event_btf_ids_fops;
+		return 1;
+	}
+#endif
+
 #ifdef CONFIG_HIST_TRIGGERS
 	if (strcmp(name, "hist") == 0) {
 		*mode = TRACE_MODE_READ;
@@ -3147,7 +3219,14 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 			.callback	= event_callback,
 		},
 #endif
-#define NR_RO_EVENT_ENTRIES	(1 + IS_ENABLED(CONFIG_PERF_EVENTS))
+#ifdef CONFIG_BPF_EVENTS
+		{
+			.name		= "btf_ids",
+			.callback	= event_callback,
+		},
+#endif
+#define NR_RO_EVENT_ENTRIES	(1 + IS_ENABLED(CONFIG_PERF_EVENTS) + \
+				 IS_ENABLED(CONFIG_BPF_EVENTS))
 /* Readonly files must be above this line and counted by NR_RO_EVENT_ENTRIES. */
 		{
 			.name		= "enable",
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e98ee7e1e66f..9134461a8def 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -1303,12 +1303,26 @@ struct trace_event_functions exit_syscall_print_funcs = {
 	.trace		= print_syscall_exit,
 };
 
+#ifdef CONFIG_BPF_EVENTS
+/*
+ * BTF id lists generated by DECLARE_EVENT_CLASS for the sys_enter and
+ * sys_exit tracepoints. The auto-generated event_class_sys_{enter,exit}
+ * is unused (per-syscall events share the handcrafted classes below),
+ * but the id lists themselves are global and reusable.
+ */
+extern u32 __bpf_trace_btf_ids_sys_enter[];
+extern u32 __bpf_trace_btf_ids_sys_exit[];
+#endif
+
 struct trace_event_class __refdata event_class_syscall_enter = {
 	.system		= "syscalls",
 	.reg		= syscall_enter_register,
 	.fields_array	= syscall_enter_fields_array,
 	.get_fields	= syscall_get_enter_fields,
 	.raw_init	= init_syscall_trace,
+#ifdef CONFIG_BPF_EVENTS
+	.btf_ids	= __bpf_trace_btf_ids_sys_enter,
+#endif
 };
 
 struct trace_event_class __refdata event_class_syscall_exit = {
@@ -1321,6 +1335,9 @@ struct trace_event_class __refdata event_class_syscall_exit = {
 	},
 	.fields		= LIST_HEAD_INIT(event_class_syscall_exit.fields),
 	.raw_init	= init_syscall_trace,
+#ifdef CONFIG_BPF_EVENTS
+	.btf_ids	= __bpf_trace_btf_ids_sys_exit,
+#endif
 };
 
 unsigned long __init __weak arch_syscall_addr(int nr)

-- 
2.53.0-Meta

