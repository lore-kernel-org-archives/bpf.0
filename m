Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1395383FB
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868134; cv=none; b=N9Y0N/+wBIr1cOgaPvgfSHN/JGD74yJdme/IaFlpvx5ozcAbNIsFL7ww4WEZKd+gqpYHC2TIQmBlsEW9jUOfpdcUtbs+0xcJQeb60xOhvS1yeR1qwwYu+PHyVYXxJTzXClOOeeUeEaWYqlP68E3hc83jMPgwdYfzILlNTlLFwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868134; c=relaxed/simple;
	bh=TLwQqu3hSq8Srb8EvMbEYaewy5wZVQpQgNzPFYP/t7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQphb4CadG+Oqu90dQPrcCITgtQtAGYTxujkch814PR5nvvqmUyx8WFiDH1gXMWtjXsI8M5OOqXj3sua47c8n9b1tAGRK35sOBhLncSh4hDIcOgsvWfEc3GlUsmuZ3HZApNT7253Pdevyzj51jQReWsd6bqkK0MeFD1mgPOj7Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKN9Medz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKN9Medz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEnidkwCNAfecU7X8FeNldVo19UgzQyILayokJSvBNE=;
	b=MKN9Medzv8tc1WCjlwA6FX9FSpt5HetTNwgQZdJDRCSyvHATqw6jBWLrUE4SVu7pRgqz50
	EY5i7Bvivf4M81lMCp0Cs45vN8XZY9sqmI0KYpPOUqM3JsFcEsR9ajPkRP1SFazA5luE5j
	F8QyglfKhpnx1MAeWiXNrI3rz2XMWW8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-c_3gcWYpMRqkBRpLiw-HFQ-1; Thu,
 01 Oct 2026 11:22:06 -0400
X-MC-Unique: c_3gcWYpMRqkBRpLiw-HFQ-1
X-Mimecast-MFC-AGG-ID: c_3gcWYpMRqkBRpLiw-HFQ_1790868125
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61994180058D;
	Thu,  1 Oct 2026 15:22:05 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 764701800351;
	Thu,  1 Oct 2026 15:22:02 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH v2 10/15] tools/rv: Add BPF monitors
Date: Thu,  1 Oct 2026 17:20:37 +0200
Message-ID: <20261001152042.124445-11-gmonaco@redhat.com>
In-Reply-To: <20261001152042.124445-1-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add the code for 2 initial BPF monitors, both DA (the only currently
supported type):

* queue: per-task monitor stating tasks alternate enqueue and dequeue.
* nohz: per-cpu monitor stating the scheduler tick don't run when
  stopped and can run only after being resumed.

BPF monitors can include the in-kernel da_monitor.h, which is now
adapted to share as much common code and conditionally compile what
needs to be BPF or kernel specific.

Integrate BPF monitor building into main rv Makefile, if all tools are
available on the system.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h                       |  21 +-
 tools/verification/models/nohz.dot            |  16 +
 tools/verification/models/tqueue.dot          |  15 +
 tools/verification/rv/Makefile                |  42 +-
 tools/verification/rv/Makefile.config         |  26 ++
 tools/verification/rv/Makefile.rv             |   5 +
 tools/verification/rv/bpf_monitors/.gitignore |   2 +
 .../rv/bpf_monitors/da_monitor_bpf.h          | 368 ++++++++++++++++++
 tools/verification/rv/bpf_monitors/nohz.c     |  42 ++
 tools/verification/rv/bpf_monitors/nohz.h     |  49 +++
 tools/verification/rv/bpf_monitors/tqueue.c   |  30 ++
 tools/verification/rv/bpf_monitors/tqueue.h   |  47 +++
 12 files changed, 655 insertions(+), 8 deletions(-)
 create mode 100644 tools/verification/models/nohz.dot
 create mode 100644 tools/verification/models/tqueue.dot
 create mode 100644 tools/verification/rv/bpf_monitors/.gitignore
 create mode 100644 tools/verification/rv/bpf_monitors/da_monitor_bpf.h
 create mode 100644 tools/verification/rv/bpf_monitors/nohz.c
 create mode 100644 tools/verification/rv/bpf_monitors/nohz.h
 create mode 100644 tools/verification/rv/bpf_monitors/tqueue.c
 create mode 100644 tools/verification/rv/bpf_monitors/tqueue.h

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 7f0bdfd7cce3..ee1cec73ec85 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -14,14 +14,19 @@
 #ifndef _RV_DA_MONITOR_H
 #define _RV_DA_MONITOR_H
 
-#include <rv/automata.h>
-#include <linux/rv.h>
+#ifndef __BPF__
+/* Kernel includes */
 #include <rv/kunit.h>
-#include <linux/stringify.h>
 #include <linux/bug.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/hashtable.h>
+#endif /* __BPF__ */
+
+#include <linux/args.h>
+#include <rv/automata.h>
+#include <linux/rv.h>
+#include <linux/stringify.h>
 
 /*
  * Per-cpu variables require a unique name although static in some
@@ -77,6 +82,9 @@ static struct rv_monitor rv_this;
 #define da_id_type int
 #endif
 
+#ifdef __BPF__
+#include "da_monitor_bpf.h"
+#else
 static void react(enum states curr_state, enum events event)
 {
 	rv_react(&rv_this,
@@ -85,6 +93,7 @@ static void react(enum states curr_state, enum events event)
 		 model_get_event_name(event),
 		 model_get_state_name(curr_state));
 }
+#endif
 
 /*
  * da_monitor_reset_state - reset a monitor and setting it to init state
@@ -159,6 +168,7 @@ static inline bool da_monitor_handling_event(struct da_monitor *da_mon)
 	return 1;
 }
 
+#ifndef __BPF__
 #if RV_MON_TYPE == RV_MON_GLOBAL
 /*
  * Functions to define, init and get a global monitor.
@@ -685,6 +695,7 @@ static inline void da_trace_error(struct da_monitor *da_mon,
 						model_get_event_name(event));
 }
 #endif /* RV_MON_TYPE */
+#endif /* __BPF__ */
 
 /*
  * da_event - handle an event for the da_mon
@@ -806,7 +817,7 @@ static inline bool da_handle_start_run_event(enum events event)
 	return __da_handle_start_run_event(da_get_monitor(), event, 0);
 }
 
-#elif RV_MON_TYPE == RV_MON_PER_TASK
+#elif !defined(__BPF__) && RV_MON_TYPE == RV_MON_PER_TASK
 /*
  * Handle event for per task.
  */
@@ -847,7 +858,7 @@ static inline bool da_handle_start_run_event(struct task_struct *tsk,
 	return __da_handle_start_run_event(da_get_monitor(tsk), event, tsk->pid);
 }
 
-#elif RV_MON_TYPE == RV_MON_PER_OBJ
+#elif !defined(__BPF__) && RV_MON_TYPE == RV_MON_PER_OBJ
 /*
  * Handle event for per object.
  */
diff --git a/tools/verification/models/nohz.dot b/tools/verification/models/nohz.dot
new file mode 100644
index 000000000000..49adb25e32d8
--- /dev/null
+++ b/tools/verification/models/nohz.dot
@@ -0,0 +1,16 @@
+digraph state_automaton {
+	{node [shape = circle] "stopped"};
+	{node [shape = plaintext, style=invis, label=""] "__init_running"};
+	{node [shape = doublecircle] "running"};
+	{node [shape = circle] "running"};
+	"__init_running" -> "running";
+	"stopped" [label = "stopped"];
+	"stopped" -> "running" [ label = "tick_restart" ];
+	"running" [label = "running"];
+	"running" -> "running" [ label = "sched_tick" ];
+	"running" -> "stopped" [ label = "tick_stop" ];
+	{ rank = min ;
+		"__init_running";
+		"running";
+	}
+}
diff --git a/tools/verification/models/tqueue.dot b/tools/verification/models/tqueue.dot
new file mode 100644
index 000000000000..7aadf99ed29d
--- /dev/null
+++ b/tools/verification/models/tqueue.dot
@@ -0,0 +1,15 @@
+digraph state_automaton {
+	{node [shape = circle] "enqueued"};
+	{node [shape = plaintext, style=invis, label=""] "__init_dequeued"};
+	{node [shape = doublecircle] "dequeued"};
+	{node [shape = circle] "dequeued"};
+	"__init_dequeued" -> "dequeued";
+	"enqueued" [label = "enqueued"];
+	"enqueued" -> "dequeued" [ label = "sched_dequeue" ];
+	"dequeued" [label = "dequeued"];
+	"dequeued" -> "enqueued" [ label = "sched_enqueue" ];
+	{ rank = min ;
+		"__init_dequeued";
+		"dequeued";
+	}
+}
diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
index 0a8c7a656f7f..bb81593acd71 100644
--- a/tools/verification/rv/Makefile
+++ b/tools/verification/rv/Makefile
@@ -33,9 +33,13 @@ DOCSRC		:= ../../../Documentation/tools/rv/
 FEATURE_TESTS	:= libtraceevent
 FEATURE_TESTS	+= libtracefs
 FEATURE_TESTS	+= libbpf
+FEATURE_TESTS	+= clang-bpf-co-re
+FEATURE_TESTS	+= bpftool-btf
 FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
 FEATURE_DISPLAY	+= libbpf
+FEATURE_DISPLAY	+= clang-bpf-co-re
+FEATURE_DISPLAY	+= bpftool-btf
 
 all: $(RV)
 
@@ -43,7 +47,7 @@ include $(srctree)/tools/build/Makefile.include
 include Makefile.rv
 
 # check for dependencies only on required targets
-NON_CONFIG_TARGETS := clean install doc doc_clean doc_install
+NON_CONFIG_TARGETS := clean install doc doc_clean doc_install bpf
 
 config		:= 1
 ifdef MAKECMDGOALS
@@ -68,19 +72,51 @@ static: $(RV_IN)
 	$(eval LDFLAGS += -static)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RV)-static $(RV_IN) $(EXTLIBS)
 
+BPF_DIR		:= bpf_monitors
+BPF_SOURCES	:= $(wildcard $(BPF_DIR)/*.c)
+BPF_OBJECTS	:= $(BPF_SOURCES:.c=.o)
+VMLINUX_H	:= $(BPF_DIR)/vmlinux.h
+
+BPF_INCLUDES	:= -I$(srctree)/include/uapi
+BPF_INCLUDES	+= -I$(srctree)/include
+BPF_INCLUDES	+= -I$(BPF_DIR)
+
+BPF_CFLAGS	:= -g -O2 -target bpf -MMD -MP $(BPF_INCLUDES)
+BPF_CFLAGS	+= -Wall -Wno-unused-function -Wno-missing-declarations
+
+VMLINUX		:= ../../../vmlinux
+VMLINUX_BTF	?= $(if $(wildcard $(VMLINUX)) , $(VMLINUX), /sys/kernel/btf/vmlinux)
+
+$(VMLINUX_H): $(VMLINUX_BTF)
+	$(QUIET_GEN)$(SYSTEM_BPFTOOL) btf dump file $< format c > $@
+
+$(BPF_DIR)/%.o: $(BPF_DIR)/%.c $(VMLINUX_H)
+	$(QUIET_CLANG)$(CLANG) $(BPF_CFLAGS) -c $< -o $@
+	$(Q)$(LLVM_STRIP) -g $@
+	$(Q)$(LLVM_OBJCOPY) --remove-section=.rel.rodata $@
+
+-include $(BPF_SOURCES:.c=.d)
+
+bpf: $(BPF_OBJECTS)
+
 rv.%: fixdep FORCE
 	make -f $(srctree)/tools/build/Makefile.build dir=. $@
 
 $(RV_IN): fixdep FORCE
 	make $(build)=rv
 
+ifeq ($(BUILD_BPF_OBJS),1)
+all: bpf
+endif
+
 clean: doc_clean fixdep-clean
 	$(call QUIET_CLEAN, rv)
-	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
+	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '*.d' -delete
 	$(Q)rm -f rv rv-static fixdep FEATURE-DUMP rv-*
+	$(Q)rm -f $(VMLINUX_H)
 	$(Q)rm -rf feature
 
 check: $(RV)
 	RV=$(RV) prove -o --directives -f tests/
 
-.PHONY: FORCE clean check
+.PHONY: FORCE clean check bpf
diff --git a/tools/verification/rv/Makefile.config b/tools/verification/rv/Makefile.config
index 0600170ac217..1caad39ab0c9 100644
--- a/tools/verification/rv/Makefile.config
+++ b/tools/verification/rv/Makefile.config
@@ -66,6 +66,32 @@ ifeq ($(BUILD_BPF),1)
   $(call lib_setup,bpf)
 endif
 
+# Building BPF monitors requires clang and bpftool, RV with BPF monitors
+# support can still run without building monitors
+ifndef BUILD_BPF_OBJS
+  BUILD_BPF_OBJS := $(BUILD_BPF)
+endif
+
+ifeq ($(BUILD_BPF_OBJS),1)
+  $(call feature_check,clang-bpf-co-re)
+  ifeq ($(feature-clang-bpf-co-re), 1)
+    $(call detected,CONFIG_CLANG_BPF_CO_RE)
+  else
+    $(info clang is missing or does not support BPF CO-RE, cannot build BPF monitors.)
+    $(info Please install clang)
+    BUILD_BPF_OBJS := 0
+  endif
+
+  $(call feature_check,bpftool-btf)
+  ifeq ($(feature-bpftool-btf), 1)
+    $(call detected,CONFIG_BPFTOOL_BTF)
+  else
+    $(info bpftool is missing or does not support btf, cannot build BPF monitors.)
+    $(info Please install bpftool)
+    BUILD_BPF_OBJS := 0
+  endif
+endif
+
 ifeq ($(STOP_ERROR),1)
   $(error Please, check the errors above.)
 endif
diff --git a/tools/verification/rv/Makefile.rv b/tools/verification/rv/Makefile.rv
index 2497fb96c83d..418748bc3aa1 100644
--- a/tools/verification/rv/Makefile.rv
+++ b/tools/verification/rv/Makefile.rv
@@ -33,12 +33,17 @@ INSTALL		:= install
 MKDIR		:= mkdir
 STRIP		:= strip
 BINDIR		:= /usr/bin
+BPF_MON_DIR	:= /usr/share/rv/bpf_monitors
 
 .PHONY: install
 install: doc_install
 	$(Q)$(MKDIR) -p $(DESTDIR)$(BINDIR)
 	$(call QUIET_INSTALL,rv)$(INSTALL) $(OUTPUT)rv -m 755 $(DESTDIR)$(BINDIR)
 	$(Q)@$(STRIP) $(DESTDIR)$(BINDIR)/rv
+ifneq ($(wildcard bpf_monitors/*.o),)
+	$(Q)$(MKDIR) -p $(DESTDIR)$(BPF_MON_DIR)
+	$(call QUIET_INSTALL,bpf_monitors)$(INSTALL) bpf_monitors/*.o -m 644 $(DESTDIR)$(BPF_MON_DIR)
+endif
 
 .PHONY: doc doc_clean doc_install
 doc:
diff --git a/tools/verification/rv/bpf_monitors/.gitignore b/tools/verification/rv/bpf_monitors/.gitignore
new file mode 100644
index 000000000000..e5add9141ef5
--- /dev/null
+++ b/tools/verification/rv/bpf_monitors/.gitignore
@@ -0,0 +1,2 @@
+*.d
+vmlinux.h
diff --git a/tools/verification/rv/bpf_monitors/da_monitor_bpf.h b/tools/verification/rv/bpf_monitors/da_monitor_bpf.h
new file mode 100644
index 000000000000..12f0f78b9c9d
--- /dev/null
+++ b/tools/verification/rv/bpf_monitors/da_monitor_bpf.h
@@ -0,0 +1,368 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * BPF support for DA monitors.
+ *
+ * BPF programs can include the in-kernel da_monitor directly, this
+ * header contains all the BPF compatibility layer.
+ *
+ * Copyright (C) 2026 Red Hat Inc, Gabriele Monaco <gmonaco@redhat.com>
+ */
+
+#ifndef _DA_MONITOR_BPF_H
+#define _DA_MONITOR_BPF_H
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_atomic.h"
+
+/* BPF monitors don't support these */
+#define rv_react(...) do {} while (0)
+#define trace_rv_retries_error(...) do {} while (0)
+#define pr_warn(fmt, ...) bpf_printk(fmt, ##__VA_ARGS__)
+#define rv_monitoring_on() 1
+#define da_implicit_guard()
+#define IS_ENABLED(conf) 0
+
+/*
+ * Also used to filter out events higher values imply lower ones.
+ * Userspace will parse this enum but expects EVENT to imply ERROR(s) and ERROR
+ * to imply any other ERROR* type.
+ */
+enum rv_trace_type {
+	RV_TRACE_NONE,
+	RV_TRACE_ERROR,
+	RV_TRACE_EVENT,
+};
+
+/* Configuration set from userspace before loading */
+const volatile SEC(".rodata.trace_level") enum rv_trace_type trace_level = RV_TRACE_NONE;
+
+/*
+ * BPF ring buffer for trace events
+ * Events and errors are sent to userspace via this ringbuf
+ */
+struct rv_trace_entry {
+	uint8_t event_type;
+	uint8_t is_final;
+	char comm[TASK_COMM_LEN];
+#if RV_MON_TYPE == RV_MON_PER_TASK || RV_MON_TYPE == RV_MON_PER_OBJ
+	uint32_t id;
+#endif
+	uint32_t pid;
+	uint32_t cpu;
+	uint32_t curr_state;
+	uint32_t event;
+	uint32_t next_state;
+};
+
+#define rv_mon_map CONCATENATE(rv_mon_, MONITOR_NAME)
+#define rv_rb CONCATENATE(rv_rb_, MONITOR_NAME)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 256 * 1024);
+} rv_rb SEC(".maps");
+
+#ifndef __used
+#define __used __attribute__((used))
+#endif
+
+/* Force types to be included in BTF for userspace parsing */
+static const enum states __used _btf_states;
+static const enum events __used _btf_events;
+static const struct rv_trace_entry __used *_btf_trace;
+
+static inline void da_monitor_reset(struct da_monitor *da_mon);
+
+/* BPF monitors do not use reactors */
+static inline void react(enum states curr_state, enum events event) { }
+
+/*
+ * BPF monitor implementations
+ * These use BPF maps instead of kernel data structures
+ */
+
+#if RV_MON_TYPE == RV_MON_GLOBAL
+/*
+ * BPF Global monitor - uses a single-entry BPF array map
+ */
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, union rv_task_monitor);
+} rv_mon_map SEC(".maps");
+
+static inline struct da_monitor *da_get_monitor(void)
+{
+	__u32 key = 0;
+	union rv_task_monitor *mon = bpf_map_lookup_elem(&rv_mon_map, &key);
+
+	return &mon->da_mon;
+}
+
+#elif RV_MON_TYPE == RV_MON_PER_CPU
+/*
+ * BPF Per-CPU monitor - uses BPF per-cpu array map
+ */
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, union rv_task_monitor);
+} rv_mon_map SEC(".maps");
+
+static inline struct da_monitor *da_get_monitor(void)
+{
+	__u32 key = 0;
+	union rv_task_monitor *mon = bpf_map_lookup_elem(&rv_mon_map, &key);
+
+	return &mon->da_mon;
+}
+
+#elif RV_MON_TYPE == RV_MON_PER_OBJ || RV_MON_TYPE == RV_MON_PER_TASK
+/*
+ * BPF Per-Object monitor - uses BPF hash map
+ * Note: monitor_target_bpf type must be compatible with BPF
+ * Types and structs must be different not to collide with vmlinux.h
+ */
+
+#if RV_MON_TYPE == RV_MON_PER_TASK
+/*
+ * BPF Per-Task monitor - uses BPF hash map indexed by PID
+ *
+ * Just a special case of per-object monitor with API consistent with in-kernel
+ * monitors (no need to pass the id).
+ */
+
+#define da_get_monitor(tsk) da_get_monitor_bpf(BPF_CORE_READ(tsk, pid), tsk)
+#define da_handle_event(tsk, event) \
+	da_handle_event_bpf(BPF_CORE_READ(tsk, pid), tsk, event)
+#define da_handle_start_event(tsk, event) \
+	da_handle_start_event_bpf(BPF_CORE_READ(tsk, pid), tsk, event)
+#define da_handle_start_run_event(tsk, event) \
+	da_handle_start_run_event_bpf(BPF_CORE_READ(tsk, pid), tsk, event)
+
+typedef struct task_struct *monitor_target_bpf;
+static inline void da_destroy_storage(da_id_type id);
+
+SEC("tp_btf/sched_process_exit")
+int BPF_PROG(handle_obj_cleanup, struct task_struct *p, bool group_dead)
+{
+	da_destroy_storage(p->pid);
+	return 0;
+}
+
+#else
+
+#define da_get_monitor da_get_monitor_bpf
+#define da_handle_event da_handle_event_bpf
+#define da_handle_start_event da_handle_start_event_bpf
+#define da_handle_start_run_event da_handle_start_run_event_bpf
+
+#endif /* RV_MON_PER_TASK */
+
+struct da_monitor_storage_bpf {
+	da_id_type id;
+	monitor_target_bpf target;
+	union rv_task_monitor rv;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10240);
+	__type(key, da_id_type);
+	__type(value, struct da_monitor_storage_bpf);
+} rv_mon_map SEC(".maps");
+
+static inline struct da_monitor *da_get_monitor_bpf(da_id_type id, monitor_target_bpf target)
+{
+	struct da_monitor_storage_bpf *storage;
+
+	storage = bpf_map_lookup_elem(&rv_mon_map, &id);
+	return storage ? &storage->rv.da_mon : NULL;
+}
+
+static inline struct da_monitor *da_create_storage(da_id_type id,
+						    monitor_target_bpf target,
+						    struct da_monitor *da_mon)
+{
+	struct da_monitor_storage_bpf new_storage = {
+		.id = id,
+		.target = target,
+	};
+
+	if (da_mon)
+		return da_mon;
+
+	bpf_map_update_elem(&rv_mon_map, &id, &new_storage, BPF_NOEXIST);
+	return da_get_monitor_bpf(id, target);
+}
+
+static inline void da_destroy_storage(da_id_type id)
+{
+	bpf_map_delete_elem(&rv_mon_map, &id);
+}
+
+static inline da_id_type da_get_id(struct da_monitor *da_mon)
+{
+	return container_of(da_mon, struct da_monitor_storage_bpf, rv.da_mon)->id;
+}
+
+static inline monitor_target_bpf da_get_target(struct da_monitor *da_mon)
+{
+	return container_of(da_mon, struct da_monitor_storage_bpf, rv.da_mon)->target;
+}
+
+/*
+ * Handle event for per object and per task
+ */
+
+static inline void __da_handle_event(struct da_monitor *da_mon,
+				     enum events event, da_id_type id);
+static inline bool __da_handle_start_event(struct da_monitor *da_mon,
+					   enum events event, da_id_type id);
+static inline bool __da_handle_start_run_event(struct da_monitor *da_mon,
+					       enum events event, da_id_type id);
+
+/*
+ * da_handle_event - handle an event
+ */
+static inline void da_handle_event_bpf(da_id_type id, monitor_target_bpf target, enum events event)
+{
+	struct da_monitor *da_mon;
+
+	da_mon = da_get_monitor_bpf(id, target);
+	if (likely(da_mon))
+		__da_handle_event(da_mon, event, id);
+}
+
+/*
+ * da_handle_start_event - start monitoring or handle event
+ *
+ * This function is used to notify the monitor that the system is returning
+ * to the initial state, so the monitor can start monitoring in the next event.
+ * Thus:
+ *
+ * If the monitor already started, handle the event.
+ * If the monitor did not start yet, start the monitor but skip the event.
+ */
+static inline bool da_handle_start_event_bpf(da_id_type id, monitor_target_bpf target,
+					 enum events event)
+{
+	struct da_monitor *da_mon;
+
+	da_mon = da_get_monitor_bpf(id, target);
+	da_mon = da_create_storage(id, target, da_mon);
+	if (unlikely(!da_mon))
+		return 0;
+	return __da_handle_start_event(da_mon, event, id);
+}
+
+/*
+ * da_handle_start_run_event - start monitoring and handle event
+ *
+ * This function is used to notify the monitor that the system is in the
+ * initial state, so the monitor can start monitoring and handling event.
+ */
+static inline bool da_handle_start_run_event_bpf(da_id_type id, monitor_target_bpf target,
+					     enum events event)
+{
+	struct da_monitor *da_mon;
+
+	da_mon = da_get_monitor_bpf(id, target);
+	da_mon = da_create_storage(id, target, da_mon);
+	if (unlikely(!da_mon))
+		return 0;
+	return __da_handle_start_run_event(da_mon, event, id);
+}
+
+static inline void da_reset_bpf(da_id_type id, monitor_target_bpf target)
+{
+	struct da_monitor *da_mon;
+
+	da_mon = da_get_monitor_bpf(id, target);
+	if (likely(da_mon))
+		da_monitor_reset(da_mon);
+}
+
+#endif /* RV_MON_TYPE */
+
+static inline void *_da_trace_common(enum states curr_state, enum events event,
+				     enum rv_trace_type type)
+{
+	struct rv_trace_entry *entry;
+	static const char stub_comm[] = "<XXX>";
+
+	if (trace_level < type)
+		return NULL;
+
+	entry = bpf_ringbuf_reserve(&rv_rb, sizeof(*entry), 0);
+	if (!entry)
+		return NULL;
+	entry->event_type = type;
+	entry->cpu = bpf_get_smp_processor_id();
+	entry->pid = bpf_get_current_pid_tgid() & 0xffffffff;
+	if (bpf_get_current_comm(entry->comm, TASK_COMM_LEN))
+		__builtin_memcpy(entry->comm, stub_comm, sizeof(stub_comm));
+	entry->curr_state = curr_state;
+	entry->event = event;
+
+	return entry;
+}
+
+#if RV_MON_TYPE == RV_MON_PER_TASK || RV_MON_TYPE == RV_MON_PER_OBJ
+static inline void _da_trace_id(struct rv_trace_entry *entry, da_id_type id)
+{
+	entry->id = id;
+}
+#else
+static inline void _da_trace_id(struct rv_trace_entry *entry, da_id_type id) { }
+#endif
+
+/*
+ * BPF trace events implementation using ring buffer
+ */
+static inline void da_trace_event(struct da_monitor *da_mon,
+				  enum states curr_state, enum events event,
+				  enum states next_state,
+				  da_id_type id)
+{
+	struct rv_trace_entry *entry = _da_trace_common(curr_state, event, RV_TRACE_EVENT);
+
+	if (!entry)
+		return;
+	_da_trace_id(entry, id);
+	entry->is_final = model_is_final_state(next_state);
+	entry->next_state = next_state;
+
+	bpf_ringbuf_submit(entry, 0);
+}
+
+static inline void da_trace_error(struct da_monitor *da_mon,
+				  enum states curr_state, enum events event,
+				  da_id_type id)
+{
+	struct rv_trace_entry *entry = _da_trace_common(curr_state, event, RV_TRACE_ERROR);
+
+	if (!entry)
+		return;
+	_da_trace_id(entry, id);
+
+	bpf_ringbuf_submit(entry, 0);
+}
+
+/*
+ * enable_monitor - BPF program to be called manually after all handlers are attached
+ */
+SEC("syscall")
+int enable_monitor(void *ctx)
+{
+	rv_this.enabled = 1;
+	return 0;
+}
+
+#endif // _DA_MONITOR_BPF_H
diff --git a/tools/verification/rv/bpf_monitors/nohz.c b/tools/verification/rv/bpf_monitors/nohz.c
new file mode 100644
index 000000000000..cb19944fad77
--- /dev/null
+++ b/tools/verification/rv/bpf_monitors/nohz.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#define RV_MON_TYPE RV_MON_PER_CPU
+#include "nohz.h"
+#include <rv/da_monitor.h>
+
+/*
+ * This monitor is broken on purpose to test errors, sched_tick can run with
+ * stopped ticks for one last time (deferred tick reprogram).
+ * A way to fix this monitor is to handle the sched_tick event only when
+ * tick_nohz_handler returns HRTIMER_RESTART (i.e. it isn't stopping the tick).
+ */
+SEC("fentry/sched_tick")
+int BPF_PROG(handle_sched_tick)
+{
+	da_handle_start_event(sched_tick_nohz);
+	return 0;
+}
+
+SEC("fentry/tick_nohz_restart_sched_tick")
+int BPF_PROG(handle_tick_restart)
+{
+	da_handle_start_event(tick_restart_nohz);
+	return 0;
+}
+
+SEC("tp_btf/tick_stop")
+int BPF_PROG(handle_tick_stop, int success, int dependency)
+{
+	if (success)
+		da_handle_event(tick_stop_nohz);
+	return 0;
+}
+
+static struct rv_monitor rv_this = {
+	.enabled = 0,
+};
+
+char LICENSE[] SEC("license") = "GPL";
+char DESCRIPTION[] SEC(".rodata.description") = "tick does not run when stopped.";
diff --git a/tools/verification/rv/bpf_monitors/nohz.h b/tools/verification/rv/bpf_monitors/nohz.h
new file mode 100644
index 000000000000..ef1c88f31f51
--- /dev/null
+++ b/tools/verification/rv/bpf_monitors/nohz.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of nohz automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME nohz
+
+enum states_nohz {
+	running_nohz,
+	stopped_nohz,
+	state_max_nohz,
+};
+
+#define INVALID_STATE state_max_nohz
+
+enum events_nohz {
+	sched_tick_nohz,
+	tick_restart_nohz,
+	tick_stop_nohz,
+	event_max_nohz,
+};
+
+struct automaton_nohz {
+	char state_names[state_max_nohz][32];
+	char event_names[event_max_nohz][32];
+	unsigned char function[state_max_nohz][event_max_nohz];
+	unsigned char initial_state;
+	bool final_states[state_max_nohz];
+};
+
+static const struct automaton_nohz automaton_nohz = {
+	.state_names = {
+		"running",
+		"stopped",
+	},
+	.event_names = {
+		"sched_tick",
+		"tick_restart",
+		"tick_stop",
+	},
+	.function = {
+		{       running_nohz,      INVALID_STATE,       stopped_nohz },
+		{      INVALID_STATE,       running_nohz,      INVALID_STATE },
+	},
+	.initial_state = running_nohz,
+	.final_states = { 1, 0 },
+};
diff --git a/tools/verification/rv/bpf_monitors/tqueue.c b/tools/verification/rv/bpf_monitors/tqueue.c
new file mode 100644
index 000000000000..e05c5c13c634
--- /dev/null
+++ b/tools/verification/rv/bpf_monitors/tqueue.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#define RV_MON_TYPE RV_MON_PER_TASK
+#include "tqueue.h"
+#include <rv/da_monitor.h>
+#define PF_EXITING 0x00000004
+
+SEC("tp_btf/sched_dequeue_tp")
+int BPF_PROG(handle_sched_dequeue, struct task_struct *tsk, int cpu)
+{
+	if (!(BPF_CORE_READ(tsk, flags) & PF_EXITING))
+		da_handle_start_event(tsk, sched_dequeue_tqueue);
+	return 0;
+}
+
+SEC("tp_btf/sched_enqueue_tp")
+int BPF_PROG(handle_sched_enqueue, struct task_struct *tsk, int cpu)
+{
+	da_handle_event(tsk, sched_enqueue_tqueue);
+	return 0;
+}
+
+static struct rv_monitor rv_this = {
+	.enabled = 0,
+};
+
+char LICENSE[] SEC("license") = "GPL";
+char DESCRIPTION[] SEC(".rodata.description") = "enqueue and dequeue tasks.";
diff --git a/tools/verification/rv/bpf_monitors/tqueue.h b/tools/verification/rv/bpf_monitors/tqueue.h
new file mode 100644
index 000000000000..1dac577d6bc4
--- /dev/null
+++ b/tools/verification/rv/bpf_monitors/tqueue.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of tqueue automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME tqueue
+
+enum states_tqueue {
+	dequeued_tqueue,
+	enqueued_tqueue,
+	state_max_tqueue,
+};
+
+#define INVALID_STATE state_max_tqueue
+
+enum events_tqueue {
+	sched_dequeue_tqueue,
+	sched_enqueue_tqueue,
+	event_max_tqueue,
+};
+
+struct automaton_tqueue {
+	char state_names[state_max_tqueue][32];
+	char event_names[event_max_tqueue][32];
+	unsigned char function[state_max_tqueue][event_max_tqueue];
+	unsigned char initial_state;
+	bool final_states[state_max_tqueue];
+};
+
+static const struct automaton_tqueue automaton_tqueue = {
+	.state_names = {
+		"dequeued",
+		"enqueued",
+	},
+	.event_names = {
+		"sched_dequeue",
+		"sched_enqueue",
+	},
+	.function = {
+		{        INVALID_STATE,      enqueued_tqueue },
+		{      dequeued_tqueue,        INVALID_STATE },
+	},
+	.initial_state = dequeued_tqueue,
+	.final_states = { 1, 0 },
+};
-- 
2.55.0

