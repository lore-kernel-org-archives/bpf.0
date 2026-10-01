Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0E539771
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868140; cv=none; b=Z6u0Y6rzM0MaKiTybls6ApjFYkOWonh2r2XH7VzDdWEuS/zKkjoTDETu8cbndv0rIpPVHDnAyCmCS3WLx08pbTNOrjzG+HDTi+bpPXvn4MOE2ZV8vn2Wb4kk7rk0GAsouIE3x71TaWlnYl77q5d0jPW1g6mHokV2+n2jLBDzf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868140; c=relaxed/simple;
	bh=K7XJKasgzSkyQ1YcQuMWO0ETg2uH16JhJ477tursQZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1jBXkLqY+u9MV6KP/ljfPpwgsjkw2Q6IxPrD6rxwgbTsMfDViaYIbg7ypP/jPter4KjgzUGdfS0Dw3c2+uo9DxOiMq1/u66cDvqBuwFLMMQ2nnwS7j82lVX5+rD1ICRpNck7MWGK1sratqbdZ8eKuechHW1N00ry/6oLn5qzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUSJVIv7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUSJVIv7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+aFN+WRSneJ32eGbt9wh/A9RgDldU/qLR/JpjwYYJ+o=;
	b=bUSJVIv7vXgIGeHBaLvJPh671AInQ/GnJebAe5z9yY04wIUMgOw31WV/7L6CRIaL5IujxA
	+pHKuV6TJe/eAqs+LlonFyn/SargY57qCCbqJ7rBR5EWaUJccm1iANRL6tS+PhUn3gGLq7
	Yx7IHG0zfWPMADzonDsBe8rcpTH7/WE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-e1wqR3PmOi-XaT5Jds6IQg-1; Thu,
 01 Oct 2026 11:22:15 -0400
X-MC-Unique: e1wqR3PmOi-XaT5Jds6IQg-1
X-Mimecast-MFC-AGG-ID: e1wqR3PmOi-XaT5Jds6IQg_1790868134
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 000A01944AA4;
	Thu,  1 Oct 2026 15:22:14 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3836C1800351;
	Thu,  1 Oct 2026 15:22:10 +0000 (UTC)
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
Subject: [PATCH v2 12/15] tools/rv: Add reactors support to BPF monitors
Date: Thu,  1 Oct 2026 17:20:39 +0200
Message-ID: <20261001152042.124445-13-gmonaco@redhat.com>
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

The BPF implementation of RV monitors cannot use standard reactors in
the kernel and currently reactions are skipped.

Add rv_react() to build the printk format using BPF macros and pass that
to a BPF function with a single message parameter, since BPF doesn't
support variable arguments.
This function is defined as weak, so the rv tool can link a different
implementation on top at load time.

Implement a printk reactor that is simply reimplementing this function
passing the message to bpf_printk().

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h                       |   4 +-
 tools/verification/rv/Makefile                |  12 ++-
 tools/verification/rv/Makefile.rv             |   5 +
 .../rv/bpf_monitors/da_monitor_bpf.h          |  12 ++-
 tools/verification/rv/bpf_reactors/.gitignore |   2 +
 tools/verification/rv/bpf_reactors/panic.c    |  15 +++
 tools/verification/rv/bpf_reactors/printk.c   |  13 +++
 tools/verification/rv/src/bpf_monitor.c       | 102 +++++++++++++++++-
 8 files changed, 157 insertions(+), 8 deletions(-)
 create mode 100644 tools/verification/rv/bpf_reactors/.gitignore
 create mode 100644 tools/verification/rv/bpf_reactors/panic.c
 create mode 100644 tools/verification/rv/bpf_reactors/printk.c

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index ee1cec73ec85..28cff26aecfe 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -84,7 +84,8 @@ static struct rv_monitor rv_this;
 
 #ifdef __BPF__
 #include "da_monitor_bpf.h"
-#else
+#endif
+
 static void react(enum states curr_state, enum events event)
 {
 	rv_react(&rv_this,
@@ -93,7 +94,6 @@ static void react(enum states curr_state, enum events event)
 		 model_get_event_name(event),
 		 model_get_state_name(curr_state));
 }
-#endif
 
 /*
  * da_monitor_reset_state - reset a monitor and setting it to init state
diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
index bb81593acd71..44b0e3af1488 100644
--- a/tools/verification/rv/Makefile
+++ b/tools/verification/rv/Makefile
@@ -73,8 +73,11 @@ static: $(RV_IN)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RV)-static $(RV_IN) $(EXTLIBS)
 
 BPF_DIR		:= bpf_monitors
+BPF_REACT_DIR   := bpf_reactors
 BPF_SOURCES	:= $(wildcard $(BPF_DIR)/*.c)
 BPF_OBJECTS	:= $(BPF_SOURCES:.c=.o)
+BPF_REACT_SOURCES := $(wildcard $(BPF_REACT_DIR)/*.c)
+BPF_REACT_OBJECTS := $(BPF_REACT_SOURCES:.c=.o)
 VMLINUX_H	:= $(BPF_DIR)/vmlinux.h
 
 BPF_INCLUDES	:= -I$(srctree)/include/uapi
@@ -95,9 +98,14 @@ $(BPF_DIR)/%.o: $(BPF_DIR)/%.c $(VMLINUX_H)
 	$(Q)$(LLVM_STRIP) -g $@
 	$(Q)$(LLVM_OBJCOPY) --remove-section=.rel.rodata $@
 
--include $(BPF_SOURCES:.c=.d)
+$(BPF_REACT_DIR)/%.o: $(BPF_REACT_DIR)/%.c $(VMLINUX_H)
+	$(QUIET_CLANG)$(CLANG) $(BPF_CFLAGS) -c $< -o $@
+	$(Q)$(LLVM_STRIP) -g $@
+	$(Q)$(LLVM_OBJCOPY) --remove-section=.rel.rodata $@
+
+-include $(BPF_SOURCES:.c=.d) $(BPF_REACT_SOURCES:.c=.d)
 
-bpf: $(BPF_OBJECTS)
+bpf: $(BPF_OBJECTS) $(BPF_REACT_OBJECTS)
 
 rv.%: fixdep FORCE
 	make -f $(srctree)/tools/build/Makefile.build dir=. $@
diff --git a/tools/verification/rv/Makefile.rv b/tools/verification/rv/Makefile.rv
index 418748bc3aa1..3ac329851914 100644
--- a/tools/verification/rv/Makefile.rv
+++ b/tools/verification/rv/Makefile.rv
@@ -34,6 +34,7 @@ MKDIR		:= mkdir
 STRIP		:= strip
 BINDIR		:= /usr/bin
 BPF_MON_DIR	:= /usr/share/rv/bpf_monitors
+BPF_REACT_DIR	:= /usr/share/rv/bpf_reactors
 
 .PHONY: install
 install: doc_install
@@ -44,6 +45,10 @@ ifneq ($(wildcard bpf_monitors/*.o),)
 	$(Q)$(MKDIR) -p $(DESTDIR)$(BPF_MON_DIR)
 	$(call QUIET_INSTALL,bpf_monitors)$(INSTALL) bpf_monitors/*.o -m 644 $(DESTDIR)$(BPF_MON_DIR)
 endif
+ifneq ($(wildcard bpf_reactors/*.o),)
+	$(Q)$(MKDIR) -p $(DESTDIR)$(BPF_REACT_DIR)
+	$(call QUIET_INSTALL,bpf_reactors)$(INSTALL) bpf_reactors/*.o -m 644 $(DESTDIR)$(BPF_REACT_DIR)
+endif
 
 .PHONY: doc doc_clean doc_install
 doc:
diff --git a/tools/verification/rv/bpf_monitors/da_monitor_bpf.h b/tools/verification/rv/bpf_monitors/da_monitor_bpf.h
index 12f0f78b9c9d..a37d11fef6f1 100644
--- a/tools/verification/rv/bpf_monitors/da_monitor_bpf.h
+++ b/tools/verification/rv/bpf_monitors/da_monitor_bpf.h
@@ -17,7 +17,6 @@
 #include "bpf_atomic.h"
 
 /* BPF monitors don't support these */
-#define rv_react(...) do {} while (0)
 #define trace_rv_retries_error(...) do {} while (0)
 #define pr_warn(fmt, ...) bpf_printk(fmt, ##__VA_ARGS__)
 #define rv_monitoring_on() 1
@@ -75,8 +74,15 @@ static const struct rv_trace_entry __used *_btf_trace;
 
 static inline void da_monitor_reset(struct da_monitor *da_mon);
 
-/* BPF monitors do not use reactors */
-static inline void react(enum states curr_state, enum events event) { }
+__noinline __weak void bpf_rv_react(char *msg) { }
+
+#define rv_react(mon, fmt, ...)							  \
+	({									  \
+		char ___msg[256];						  \
+										  \
+		if (BPF_SNPRINTF(___msg, sizeof(___msg), fmt, ##__VA_ARGS__) > 0) \
+			bpf_rv_react(___msg);					  \
+	})
 
 /*
  * BPF monitor implementations
diff --git a/tools/verification/rv/bpf_reactors/.gitignore b/tools/verification/rv/bpf_reactors/.gitignore
new file mode 100644
index 000000000000..e5add9141ef5
--- /dev/null
+++ b/tools/verification/rv/bpf_reactors/.gitignore
@@ -0,0 +1,2 @@
+*.d
+vmlinux.h
diff --git a/tools/verification/rv/bpf_reactors/panic.c b/tools/verification/rv/bpf_reactors/panic.c
new file mode 100644
index 000000000000..775f91a300f0
--- /dev/null
+++ b/tools/verification/rv/bpf_reactors/panic.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+void bpf_rv_react(char *msg)
+{
+	struct pt_regs regs = { 0 };
+
+	crash_kexec(&regs);
+}
+
+char LICENSE[] SEC("license") = "GPL";
+static char DESCRIPTION[] SEC(".rodata.description") =
+	"panic the system if an exception is found.";
diff --git a/tools/verification/rv/bpf_reactors/printk.c b/tools/verification/rv/bpf_reactors/printk.c
new file mode 100644
index 000000000000..580410d2a1fc
--- /dev/null
+++ b/tools/verification/rv/bpf_reactors/printk.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+void bpf_rv_react(char *msg)
+{
+	bpf_printk("%s", msg);
+}
+
+char LICENSE[] SEC("license") = "GPL";
+static char DESCRIPTION[] SEC(".rodata.description") =
+	"prints the exception msg to the trace buffer.";
diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification/rv/src/bpf_monitor.c
index d43ee75d3904..35bd1f40a109 100644
--- a/tools/verification/rv/src/bpf_monitor.c
+++ b/tools/verification/rv/src/bpf_monitor.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2026 Red Hat Inc, Gabriele Monaco <gmonaco@redhat.com>
  */
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -14,6 +15,7 @@
 #include <libgen.h>
 #include <errno.h>
 #include <inttypes.h>
+#include <sys/mman.h>
 #include <bpf/libbpf.h>
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
@@ -36,6 +38,7 @@ static char bpf_base_paths[][MAX_PATH] = {
 #define MAX_ENUMS 64
 #define MAX_LINKS 16
 #define PROG_ENABLE_MON "enable_monitor"
+#define BPF_REACTOR "bpf_rv_react"
 #define RV_TRACE_STRUCT "rv_trace_entry"
 #define RV_TRACE_TYPE_ENUM "rv_trace_type"
 
@@ -676,12 +679,31 @@ static struct ring_buffer *bpf_setup_ring_buffer(struct bpf_object *obj,
 	return rb;
 }
 
+static void list_reactor_action(const char *name, struct bpf_object *obj)
+{
+	const struct btf *btf = bpf_object__btf(obj);
+
+	if (btf__find_by_name_kind(btf, BPF_REACTOR, BTF_KIND_FUNC) >= 0)
+		fprintf(stderr, "%s ", name);
+}
+
+/*
+ * list_reactors_from_path - list reactors from a specific base path
+ */
+static void list_reactors_from_path(const char *base_path)
+{
+	bpf_object_iterate_path(base_path, "bpf_reactors", list_reactor_action);
+}
+
 /*
  * bpf_usage_print_reactors - print available BPF reactors
  */
 void bpf_usage_print_reactors(void)
 {
-	fprintf(stderr, "  available BPF reactors: nop\n");
+	fprintf(stderr, "  available BPF reactors: nop ");
+	for (int i = 0; bpf_base_paths[i][0]; i++)
+		list_reactors_from_path(bpf_base_paths[i]);
+	fprintf(stderr, "\n");
 }
 
 /*
@@ -720,6 +742,7 @@ static struct bpf_object *open_bpf_monitor(const char *path, struct bpf_monitor_
 	int res;
 
 	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.object_name = ctx->monitor_name,
 		/* Define statically as arch is known, Kconfig may not be available */
 #ifdef __x86_64__
 		.kconfig = "CONFIG_X86_64=y\n",
@@ -795,6 +818,65 @@ static int attach_bpf_handlers(const char *monitor_name, struct bpf_object *obj,
 	return enable_mon_fd;
 }
 
+static int find_bpf_reactor(const char *reactor_name, char *path_out, size_t path_len)
+{
+	return find_bpf_file("bpf_reactors", reactor_name, path_out, path_len);
+}
+
+/*
+ * link_bpf_reactor - link the reactor function to the monitor
+ *
+ * Reactors are objects defining the BPF_REACTOR function, link that over the
+ * weak definition present in the monitor and return a file descriptor to the
+ * final linked object in memory.
+ *
+ * Returns memfd of final object on success, -1 on error.
+ */
+static int link_bpf_reactor(const char *monitor_path, const char *reactor_path)
+{
+	struct bpf_linker *linker = NULL;
+	int memfd = -1;
+	int err = 0;
+
+	memfd = memfd_create("linked_bpf", 0);
+	if (memfd < 0) {
+		err_msg("bpf: failed to create memfd: %s\n", strerror(errno));
+		return -1;
+	}
+
+	linker = bpf_linker__new_fd(memfd, NULL);
+	if (!linker) {
+		err_msg("bpf: failed to create BPF linker\n");
+		goto out;
+	}
+
+	err = bpf_linker__add_file(linker, monitor_path, NULL);
+	if (err) {
+		err_msg("bpf: failed to add monitor file to linker: %s\n", strerror(-err));
+		goto out;
+	}
+
+	err = bpf_linker__add_file(linker, reactor_path, NULL);
+	if (err) {
+		err_msg("bpf: failed to add reactor file to linker: %s\n", strerror(-err));
+		goto out;
+	}
+
+	err = bpf_linker__finalize(linker);
+	if (err) {
+		err_msg("bpf: failed to finalize BPF linker: %s\n", strerror(-err));
+		goto out;
+	}
+
+	bpf_linker__free(linker);
+	return memfd;
+
+out:
+	bpf_linker__free(linker);
+	close(memfd);
+	return -1;
+}
+
 /*
  * bpf_run_monitor - load and run a BPF monitor
  *
@@ -808,6 +890,7 @@ int bpf_run_monitor(char *monitor_name, int argc, char **argv)
 	struct bpf_object *obj = NULL;
 	int res, link_count = 0, enable_mon_fd, retval = -1;
 	char monitor_path[MAX_PATH];
+	int memfd = -1;
 
 	libbpf_set_print(libbpf_print_fn);
 	bpf_fill_base_paths();
@@ -830,8 +913,25 @@ int bpf_run_monitor(char *monitor_name, int argc, char **argv)
 
 	strncpy(ctx.monitor_name, monitor_name, sizeof(ctx.monitor_name) - 1);
 
+	if (config.reactor && strcmp(config.reactor, "nop")) {
+		char reactor_path[MAX_PATH];
+
+		if (!find_bpf_reactor(config.reactor, reactor_path, sizeof(reactor_path))) {
+			mon_usage(1, monitor_name,
+				  "bpf: failed to set %s reactor, is it available?",
+				  config.reactor);
+			goto cleanup;
+		}
+
+		memfd = link_bpf_reactor(monitor_path, reactor_path);
+		if (memfd < 0)
+			goto cleanup;
+
+		snprintf(monitor_path, sizeof(monitor_path), "/proc/self/fd/%d", memfd);
+	}
 
 	obj = open_bpf_monitor(monitor_path, &ctx);
+	close(memfd);
 	if (!obj)
 		goto cleanup;
 
-- 
2.55.0

