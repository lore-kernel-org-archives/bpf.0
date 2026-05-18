Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7595C372696
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117831; cv=none; b=XETk2b6gGem6biO+Ns+XdHZ4Cr3DUYFCIBhBjs5UL1iJ31Du/bBtV351jcm0tkv1FZ6oXPHTZOOfiivNYM7WP9ZFNAGJC9ltUVPOnifUPxqzEotu6BDOp8dcTuLax4XgabIe0SajSmbeZYqAzqSmpyE1DH+NrCkZ5wdKZbOpB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117831; c=relaxed/simple;
	bh=oYKdPECkfbDJw5lqlozxgaBteqaMwPDfqiHCTq4kUKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DYpVdP5uMjU78RkH2ALd9HLga21pUB6IEn7WXXNIXxUevfQLx0tWQwKhLKAJyHIWARn5t3vJwh+9dJVGLTE72CDzx9MNV6JkRupRViSePqan4n/b0rglNoB40Qxe3/RNQM91j1XwdwX3gR0PjqwzzOR6YKfDUR+x+cmJ77S+aaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wurm0NR9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wurm0NR9"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd8f6ef4ba6so82545966b.3
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779117828; x=1779722628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i65bSW/HxaH7lUOGXOnVjIeyPkR0t/BQOq8mUJVWZcs=;
        b=Wurm0NR9wHOu/Rkdt/W3t3yFHcqmmeL1T7bmXXEQGmNMgQDBf7Wj73AeSH59nTDmuJ
         L34l37Xc9URAtDfJbgQVt6/jxN4lTe3byf/A/kdbsp64kQBoPdOxVHs1uE4cDp/qKLZb
         Pu1SqJIgOxlfzgqTQy2yZTs5sd3FQkHHTW2PZF36x18yRS5HISKWmbGG/zuLntjN38bP
         2vzCbwYMb0qtxuMw3ejwoalrgFKfqbSUyX55WIIn9Gmo1jQtDkeNX1dnRBCIgTSItBc6
         fJCK0QJ7njQIuLityafZgGWUTX8K+u9RBMQ/KqpM9FIthA7L+oJiJBVt5x77KlKbWxDX
         zDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117828; x=1779722628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i65bSW/HxaH7lUOGXOnVjIeyPkR0t/BQOq8mUJVWZcs=;
        b=PkFoZlc81XVcXcB7gjPT9NEGI5K0eaalte6H9N/ZtjSYnmxNpcMT3l3E+VUhVu2z1k
         szGzWUAXNHAvS6zExqSZGsLvAKK9jjLQ0vqcRELS3gYoMzeH+xSSJp8ZFH/m0C90OlC6
         24EPCiePiNJ1uszUCvGAtLy6qQFeHQQF+FWMUPEySmDQdy4Jq26lud+ua5o2cYGSRMHt
         R5x26Cy7TZtFqZuyJYass3J5KFFJiEMFZN+V0A1qtFGrWld0uosoivsFs4ZKSP52Lx4d
         NEMZYh6sgRiu+3f/mtEstPcE9Em2FHBnv2RwVM0iq8+jS0WUkh6y1Ihm67LXoD5C+Ju1
         KL5w==
X-Gm-Message-State: AOJu0Yz9oSbwPlk/EsijbLR+NXFZnFWHcD3jlfSiNQQEqhVC8ViPjrbX
	nh6riW1eBimP+dYQfiigfWzYx0meQNcl9KMRP+ANjcJ2PDI+IkRPYXXg
X-Gm-Gg: Acq92OHhRL4rbILJJ8f6OrOVSPc9CfQK7ntbkByKZ55v/7gVIZBPHvQmx4/waG9doAN
	MsePm+7ZB9zl9CQWQKZY7oKLdD2P2ALDqX/PV7QhcTX5KlsweCl5ShATzG3JC3VmyGQRPwRIVEN
	eo8EpSaNR9jVTPGZxKVUOQYz+ep3IfvRuFv1E84YhCGpMyvjhHSr+Ns16sLmm5vZg2sJ1zvx6aE
	v+brqgNTbeR+tknLuuyrFrdD3vjSgKaD7x9+aQpijDqTYhAAzvHGkRGk/MwPQl4yc7UMoMjywih
	QbEflqbf1DYgV7gW27iCXIgAh7bP3m0Q5UaqGhC81YZr6O1rNWCxD0dFYvVZtdGpO6s6Koy9Xj+
	3bsPzx7+SeL1OPOnbbBXDE/sovsGRTZVyYbF+9dUC27t0ZwuwoP8BRFIcOL/9lLYWa4Gdv7Qynw
	W/xmUYSJ1ZNlXw
X-Received: by 2002:a17:907:c00e:b0:bd5:af3:8a2a with SMTP id a640c23a62f3a-bd5177dbe1emr943312666b.18.1779117827668;
        Mon, 18 May 2026 08:23:47 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e5089fsm581002266b.49.2026.05.18.08.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:23:46 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 18 May 2026 08:23:16 -0700
Subject: [PATCH bpf-next v2 2/3] tracing: Expose tracepoint BTF ids via
 tracefs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-generic_tracepoint-v2-2-b755a5cf67bb@meta.com>
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
In-Reply-To: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>, linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779117822; l=9249;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=p3L+stMm3oR01jumzRDpRhjXxE3ix90HS/7k13ZUljc=;
 b=hjyPJeZIiqyH8Hi3pDNcFjxB55gfRJ9FeQz6d5/HFh3vtAPNWj8ttLeY7GLZV0lo4d72W1YFC
 KA+S24LxxG4Ae/TQtMggE7f4YS6k73FxgUJMSB+k+jZCEc4iEZg3WmW
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
 kernel/trace/trace_events.c   | 80 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_syscalls.c | 17 +++++++++
 4 files changed, 129 insertions(+), 1 deletion(-)

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
index c46e623e7e0d..b1c07f078f8d 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -22,6 +22,7 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/btf.h>
 
 #include <trace/events/sched.h>
 #include <trace/syscall.h>
@@ -2200,6 +2201,61 @@ event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
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
+	u32 raw_id = 0, tp_id = 0, obj_id = 0;
+	const u32 *ids;
+	struct btf *btf;
+	char buf[128];
+	int len;
+
+	/* Module unload could free call->class and ids[] mid-read. */
+	scoped_guard(mutex, &event_mutex) {
+		file = event_file_file(filp);
+		if (!file)
+			return -ENODEV;
+
+		call = file->event_call;
+		ids = call->class->btf_ids;
+		if (!ids)
+			return -ENOENT;
+		if (!(call->flags & TRACE_EVENT_FL_DYNAMIC))
+			mod = (struct module *)call->module;
+
+		btf = btf_get_module_btf(mod);
+		if (IS_ERR_OR_NULL(btf))
+			return -ENOENT;
+
+		/* Module-local ids in ids[] need base+local relocation. */
+		tp_id = btf_relocate_id(btf, ids[1]);
+
+		/*
+		 * Without FL_TRACEPOINT the dispatcher is shared (e.g. all
+		 * per-syscall events fan out from __bpf_trace_sys_enter), so
+		 * raw_btf_id has no per-event attach point — report 0.
+		 */
+		if (call->flags & TRACE_EVENT_FL_TRACEPOINT) {
+			t = btf_type_by_id(btf, btf_relocate_id(btf, ids[0]));
+			raw_id = t ? t->type : 0;
+		}
+		obj_id = btf_obj_id(btf);
+		btf_put(btf);
+	}
+
+	len = scnprintf(buf, sizeof(buf),
+			"btf_obj_id: %u\nraw_btf_id: %u\ntp_btf_id: %u\n",
+			obj_id, raw_id, tp_id);
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
+}
+#endif
+
 static ssize_t
 event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
 		  loff_t *ppos)
@@ -2700,6 +2756,13 @@ static const struct file_operations ftrace_event_id_fops = {
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
@@ -3093,6 +3156,14 @@ static int event_callback(const char *name, umode_t *mode, void **data,
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
@@ -3147,7 +3218,14 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
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

