Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A63DCDB5
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167275; cv=none; b=EC4qkoeGC7jSnZvVOPp59U6iAFDhShlPSieHD8xwyZohCmgVNH6eVRVA1Wj49rcJTMigAm6lm9jyqc0bo7rQcsAUFTPVEVTMbJ7qRzaewNZbxdtbT557/x85Clt5CKLLxWBiVgulhlZkQp/q/drcVaF6zKRv8ORRGB5MQa9Z50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167275; c=relaxed/simple;
	bh=STe/Ew+lmpLpVGbXcSOX/igx68AFHMxRG+5JmNWIe5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BC+gXni+mGKnwEO2JKnKHMiMqxe2Npn69e+E9L8xtPovoTy3pejKKPoWjF/2rFWEWjd3tiscgD26PkST+XdpWd4I3qBH0rgLt47sbD1Md/M8OlxEI1jClD14oyvpaEXmPvBaxf9bx9KNMU5UeEVCMH5Fi06d+HWoxzLMPEOFguY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZ4zyzry; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZ4zyzry"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfwnhSnqYrdkMR3z87XdFahsTZzAfFRpyLcSXL3M+us=;
	b=LZ4zyzryjXOC9sLXFv5bzr/4wp9Q6VZ3KKSJMYyNwCxLHXYKrnaz/Y7l6mKpGguaRJPoKY
	QlU5dzg0SKe6CUxNzh/MW9uyLm7M2MZ42RbENJKKgW05cgm7hpUYfiolbzxJOUyLSd+5lT
	xHnn2/2L6nYBOCI/ngdm02+eYsnCL8M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-DUWvDvZfNIKVY-BcpxDYMQ-1; Mon,
 31 Aug 2026 05:07:50 -0400
X-MC-Unique: DUWvDvZfNIKVY-BcpxDYMQ-1
X-Mimecast-MFC-AGG-ID: DUWvDvZfNIKVY-BcpxDYMQ_1788167269
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A59F19540E2;
	Mon, 31 Aug 2026 09:07:49 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8716D18005BB;
	Mon, 31 Aug 2026 09:07:46 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 13/20] tools/rv: Implement BPF monitor loading and tracing
Date: Mon, 31 Aug 2026 11:05:17 +0200
Message-ID: <20260831090524.106845-14-gmonaco@redhat.com>
In-Reply-To: <20260831090524.106845-1-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Implement BPF monitor loading, execution, and optional tracing
functionality.

Running rv mon MON loads the MON monitor into the kernel and passing the
-t parameter also attaches to the event ring buffer printing events and
errors to standard output.

Event and state names as well as the ring buffer entry format are
dynamically parsed from BTF.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/Makefile              |   8 +-
 tools/verification/rv/Makefile.config       |  23 +
 tools/verification/rv/include/bpf_monitor.h |  14 +
 tools/verification/rv/src/Build             |   5 +
 tools/verification/rv/src/bpf_monitor.c     | 681 ++++++++++++++++++++
 tools/verification/rv/src/rv.c              |   6 +-
 6 files changed, 734 insertions(+), 3 deletions(-)
 create mode 100644 tools/verification/rv/include/bpf_monitor.h
 create mode 100644 tools/verification/rv/src/bpf_monitor.c

diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
index 8ae5fc0d1d17..af83566b930c 100644
--- a/tools/verification/rv/Makefile
+++ b/tools/verification/rv/Makefile
@@ -27,13 +27,17 @@ endif
 RV		:= $(OUTPUT)rv
 RV_IN		:= $(RV)-in.o
 
+TOOLS_INCLUDES = -I$(srctree)/tools/include
+
 VERSION		:= $(shell sh -c "make -sC ../../.. kernelversion | grep -v make")
 DOCSRC		:= ../../../Documentation/tools/rv/
 
 FEATURE_TESTS	:= libtraceevent
 FEATURE_TESTS	+= libtracefs
+FEATURE_TESTS	+= libbpf
 FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
+FEATURE_DISPLAY	+= libbpf
 
 all: $(RV)
 
@@ -55,9 +59,9 @@ ifeq ($(config),1)
   include Makefile.config
 endif
 
-CFLAGS		+= $(INCLUDES) $(LIB_INCLUDES)
+CFLAGS		+= $(INCLUDES) $(LIB_INCLUDES) $(TOOLS_INCLUDES)
 
-export CFLAGS OUTPUT srctree
+export CFLAGS OUTPUT srctree BUILD_BPF
 
 $(RV): $(RV_IN)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $(RV) $(RV_IN) $(EXTLIBS)
diff --git a/tools/verification/rv/Makefile.config b/tools/verification/rv/Makefile.config
index 066302230eb2..0600170ac217 100644
--- a/tools/verification/rv/Makefile.config
+++ b/tools/verification/rv/Makefile.config
@@ -43,6 +43,29 @@ else
   $(info libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
 endif
 
+ifndef BUILD_BPF
+  # BPF monitors are optional but enabled by default
+  BUILD_BPF := 1
+endif
+
+ifeq ($(BUILD_BPF),0)
+  $(info BPF monitor support disabled, building without BPF monitor support.)
+endif
+
+$(call feature_check,libbpf)
+ifeq ($(feature-libbpf), 1)
+  $(call detected,CONFIG_LIBBPF)
+else
+  $(info libbpf is missing, building without BPF monitor support.)
+  $(info Please install libbpf-dev/libbpf-devel)
+  BUILD_BPF := 0
+endif
+
+ifeq ($(BUILD_BPF),1)
+  CFLAGS += -DHAVE_LIBBPF
+  $(call lib_setup,bpf)
+endif
+
 ifeq ($(STOP_ERROR),1)
   $(error Please, check the errors above.)
 endif
diff --git a/tools/verification/rv/include/bpf_monitor.h b/tools/verification/rv/include/bpf_monitor.h
new file mode 100644
index 000000000000..60ce23589102
--- /dev/null
+++ b/tools/verification/rv/include/bpf_monitor.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _BPF_MONITOR_H
+#define _BPF_MONITOR_H
+
+#ifdef HAVE_LIBBPF
+int bpf_run_monitor(char *monitor_name, int argc, char **argv);
+#else
+static inline int bpf_run_monitor(char *monitor_name, int argc, char **argv)
+{
+	return 0;
+}
+#endif /* HAVE_LIBBPF */
+
+#endif
diff --git a/tools/verification/rv/src/Build b/tools/verification/rv/src/Build
index d781983c1a79..326503c22915 100644
--- a/tools/verification/rv/src/Build
+++ b/tools/verification/rv/src/Build
@@ -1,4 +1,9 @@
 rv-y += trace.o
 rv-y += utils.o
 rv-y += in_kernel.o
+
+ifeq ($(BUILD_BPF),1)
+  rv-y += bpf_monitor.o
+endif
+
 rv-y += rv.o
diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification/rv/src/bpf_monitor.c
new file mode 100644
index 000000000000..e13ae35678cb
--- /dev/null
+++ b/tools/verification/rv/src/bpf_monitor.c
@@ -0,0 +1,681 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF monitor support: allows rv to control BPF monitors.
+ *
+ * Copyright (C) 2026 Red Hat Inc, Gabriele Monaco <gmonaco@redhat.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <dirent.h>
+#include <libgen.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <linux/compiler.h>
+#include <linux/math.h>
+
+#include <bpf_monitor.h>
+#include <in_kernel.h>
+#include <utils.h>
+#include <rv.h>
+
+static char bpf_monitor_paths[][MAX_PATH] = {
+	"./bpf_monitors/",
+	"/usr/share/rv/bpf_monitors/",
+	"", /* Marker */
+};
+
+/* Path used for development monitors, searched first */
+#define DEVEL_PATH 0
+
+#define MAX_ENUMS 64
+#define MAX_LINKS 16
+#define RV_TRACE_EVENT	0
+#define RV_TRACE_ERROR	1
+#define BPF_PIN_BASE_PATH "/sys/fs/bpf/rv"
+#define RV_TRACE_STRUCT "rv_trace_entry"
+
+enum da_field_id {
+	FIELD_EVENT_TYPE,
+	FIELD_ID,
+	FIELD_CPU,
+	FIELD_PID,
+	FIELD_COMM,
+	FIELD_IS_FINAL,
+	FIELD_CURR_STATE,
+	FIELD_EVENT,
+	FIELD_NEXT_STATE,
+	FIELD_MAX,
+};
+
+static const char *const field_names[] = {
+	[FIELD_EVENT_TYPE] = "event_type",
+	[FIELD_ID] = "id",
+	[FIELD_CPU] = "cpu",
+	[FIELD_PID] = "pid",
+	[FIELD_COMM] = "comm",
+	[FIELD_IS_FINAL] = "is_final",
+	[FIELD_CURR_STATE] = "curr_state",
+	[FIELD_EVENT] = "event",
+	[FIELD_NEXT_STATE] = "next_state",
+};
+
+struct da_field {
+	size_t offset;
+	size_t size;
+};
+
+struct bpf_monitor_ctx {
+	char monitor_name[MAX_DA_NAME_LEN];
+	char state_names[MAX_ENUMS][MAX_DA_NAME_LEN];
+	char event_names[MAX_ENUMS][MAX_DA_NAME_LEN];
+	int num_states;
+	int num_events;
+	struct da_field field_metadata[FIELD_MAX];
+};
+
+/*
+ * bpf_fill_monitor_paths - fill the path for development builds
+ *
+ * RV searches for BPF monitors on absolute paths on the system as well
+ * as in the same directory of the rv binary. This is useful when running
+ * rv from the kernel tree. This function resolves right location.
+ */
+static void bpf_fill_monitor_paths(void)
+{
+	char tmp_path[MAX_PATH], *dir;
+	ssize_t len;
+
+	len = readlink("/proc/self/exe", tmp_path, MAX_PATH);
+	if (len > 0 && len != MAX_PATH) {
+		tmp_path[len] = '\0';
+		dir = dirname(tmp_path);
+		snprintf(bpf_monitor_paths[DEVEL_PATH], MAX_PATH, "%s/bpf_monitors", dir);
+	}
+}
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format,
+			   va_list args)
+{
+	if (level == LIBBPF_DEBUG && !config.debug)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+/*
+ * Helper functions for state/event name lookup
+ */
+static const char *get_state_name(struct bpf_monitor_ctx *ctx, uint32_t state)
+{
+	static char buf[16];
+
+	if (state < ctx->num_states && ctx->state_names[state][0] != '\0')
+		return ctx->state_names[state];
+
+	snprintf(buf, sizeof(buf), "%u", state);
+	return buf;
+}
+
+static const char *get_event_name(struct bpf_monitor_ctx *ctx, uint32_t event)
+{
+	static char buf[16];
+
+	if (event < ctx->num_events && ctx->event_names[event][0] != '\0')
+		return ctx->event_names[event];
+
+	snprintf(buf, sizeof(buf), "%u", event);
+	return buf;
+}
+
+/*
+ * extract_field_metadata - extract field metadata from BTF for efficient parsing
+ *
+ * Introspect the rv_trace_entry structure via BTF and store field offsets and
+ * sizes for direct memory access during event processing.
+ *
+ * Returns 0 on success, -1 on error
+ */
+static int extract_field_metadata(const struct btf *btf, struct bpf_monitor_ctx *ctx)
+{
+	const struct btf_type *trace_type;
+	const struct btf_member *members;
+	int type_id, vlen;
+
+	type_id = btf__find_by_name_kind(btf, RV_TRACE_STRUCT, BTF_KIND_STRUCT);
+	if (type_id <= 0) {
+		debug_msg("bpf: could not find struct '%s' in BTF\n", RV_TRACE_STRUCT);
+		return -1;
+	}
+
+	trace_type = btf__type_by_id(btf, type_id);
+	if (!trace_type) {
+		debug_msg("bpf: could not get type for '%s'\n", RV_TRACE_STRUCT);
+		return -1;
+	}
+
+	members = btf_members(trace_type);
+	vlen = btf_vlen(trace_type);
+
+	for (int i = 0; i < vlen; i++) {
+		const char *name = btf__name_by_offset(btf, members[i].name_off);
+		size_t offset = btf_member_bit_offset(trace_type, i) / 8;
+		size_t size = btf__resolve_size(btf, members[i].type);
+
+		if (!name || (ssize_t)size < 0)
+			continue;
+
+		debug_msg("bpf: field '%s' at offset %zu, size %lld\n", name,
+			  offset, (long long)size);
+
+		for (int j = 0; j < FIELD_MAX; j++) {
+			if (strcmp(name, field_names[j]) == 0) {
+				ctx->field_metadata[j].offset = offset;
+				ctx->field_metadata[j].size = size;
+				if (j == FIELD_ID)
+					config.has_id = true;
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * bpf_print_header - print trace output header
+ */
+static void bpf_print_header(void)
+{
+	printf("%16s-%-8s %5s %5s ", "<TASK>", "PID", "[CPU]", "TYPE");
+	if (config.has_id)
+		printf(" %8s", "ID");
+
+	printf("%24s x %-24s -> %-24s %s\n",
+		"STATE",
+		"EVENT",
+		"NEXT_STATE",
+		"FINAL");
+
+	printf("%16s %-8s %5s %5s ", " | ", " | ", " | ", " | ");
+
+	if (config.has_id)
+		printf(" %8s", " | ");
+	printf("%24s   %-24s    %-24s %s\n", " | ", " | ", " | ", "|");
+}
+
+static inline uint64_t read_field(uint64_t *entry, enum da_field_id id,
+				  const uint8_t *raw,
+				  const struct bpf_monitor_ctx *ctx)
+{
+	const struct da_field *field = &ctx->field_metadata[id];
+
+	switch (field->size) {
+	case 1:
+		return entry[id] = *(const uint8_t *)(raw + field->offset);
+	case 2:
+		return entry[id] = *(const uint16_t *)(raw + field->offset);
+	case 4:
+		return entry[id] = *(const uint32_t *)(raw + field->offset);
+	case 8:
+		return entry[id] = *(const uint64_t *)(raw + field->offset);
+	}
+	return 0;
+}
+
+/*
+ * handle_event - ring buffer callback for trace events
+ */
+static int handle_event(void *ctx, void *data, size_t data_sz)
+{
+	struct bpf_monitor_ctx *mon_ctx = ctx;
+	const uint8_t *raw = data;
+	uint64_t entry[FIELD_MAX] = {0};
+	const char *comm;
+
+	if (should_stop())
+		return 1;
+
+	if (config.has_id)
+		read_field(entry, FIELD_ID, raw, mon_ctx);
+	read_field(entry, FIELD_PID, raw, mon_ctx);
+
+	if (config.has_id && (config.my_pid == entry[FIELD_ID]))
+		return 0;
+	else if (config.my_pid == entry[FIELD_PID])
+		return 0;
+
+	read_field(entry, FIELD_EVENT_TYPE, raw, mon_ctx);
+	read_field(entry, FIELD_CPU, raw, mon_ctx);
+	comm = (const char *)(raw + mon_ctx->field_metadata[FIELD_COMM].offset);
+	read_field(entry, FIELD_CURR_STATE, raw, mon_ctx);
+	read_field(entry, FIELD_EVENT, raw, mon_ctx);
+
+	printf("%16s-%-8"PRIu64" [%.3"PRIu64"] ", comm, entry[FIELD_PID], entry[FIELD_CPU]);
+	if (entry[FIELD_EVENT_TYPE] == RV_TRACE_ERROR) {
+		printf("error ");
+		if (config.has_id)
+			printf(" %8"PRIu64"", entry[FIELD_ID]);
+		printf(" %24s x %-24s\n",
+		       get_state_name(mon_ctx, entry[FIELD_CURR_STATE]),
+		       get_event_name(mon_ctx, entry[FIELD_EVENT]));
+	} else {
+		printf("event ");
+		read_field(entry, FIELD_IS_FINAL, raw, mon_ctx);
+		read_field(entry, FIELD_NEXT_STATE, raw, mon_ctx);
+
+		if (config.has_id)
+			printf(" %8"PRIu64"", entry[FIELD_ID]);
+		printf(" %24s x %-24s -> %-24s %c\n",
+		       get_state_name(mon_ctx, entry[FIELD_CURR_STATE]),
+		       get_event_name(mon_ctx, entry[FIELD_EVENT]),
+		       get_state_name(mon_ctx, entry[FIELD_NEXT_STATE]),
+		       entry[FIELD_IS_FINAL] ? 'Y' : 'N');
+	}
+
+	return 0;
+}
+
+/*
+ * extract_enum_names - extract names from a BTF enum
+ *
+ * Reads enum member names from BTF and stores them in dest array.
+ * Returns the number of enum members extracted (excluding the
+ * {state/event}_max_NAME entry and trimming the _NAME padding).
+ */
+static int extract_enum_names(const struct btf *btf, const char *enum_kind,
+			       char dest[][MAX_DA_NAME_LEN], struct bpf_monitor_ctx *ctx)
+{
+	const struct btf_type *enum_type;
+	const struct btf_enum *enums;
+	char enum_name[64];
+	int type_id, vlen;
+	int count = 0;
+
+	snprintf(enum_name, sizeof(enum_name), "%ss_%s", enum_kind, ctx->monitor_name);
+	type_id = btf__find_by_name_kind(btf, enum_name, BTF_KIND_ENUM);
+	if (type_id <= 0) {
+		err_msg("bpf: could not find enum '%s' in BTF\n", enum_name);
+		return -1;
+	}
+	enum_type = btf__type_by_id(btf, type_id);
+	if (!enum_type) {
+		err_msg("bpf: could not get enum type for '%s'\n", enum_name);
+		return -1;
+	}
+
+	enums = btf_enum(enum_type);
+	vlen = btf_vlen(enum_type);
+
+	snprintf(enum_name, sizeof(enum_name), "%s_max_%s", enum_kind, ctx->monitor_name);
+	for (int i = 0; i < vlen && count < MAX_ENUMS; i++) {
+		const char *name = btf__name_by_offset(btf, enums[i].name_off);
+		size_t name_len;
+		const char *padding;
+
+		if (!name || !strcmp(name, enum_name))
+			continue;
+
+		padding = strrchr(name, '_');
+		name_len = strlen(name);
+		if (padding && !strcmp(ctx->monitor_name, padding + 1))
+			name_len = (size_t)(padding - name);
+
+		if (name_len >= MAX_DA_NAME_LEN)
+			name_len = MAX_DA_NAME_LEN - 1;
+		strncpy(dest[count], name, name_len);
+		dest[count][name_len] = '\0';
+		count++;
+	}
+
+	return count;
+}
+
+/*
+ * extract_btf_info - extract BTF types information from the monitor
+ *
+ * Extract state and event names from enums using BTF and extract field
+ * offsets for flexible event parsing.
+ */
+static int extract_btf_info(struct bpf_object *obj, struct bpf_monitor_ctx *ctx)
+{
+	const struct btf *btf;
+
+	btf = bpf_object__btf(obj);
+	if (!btf) {
+		err_msg("bpf: no BTF found in BPF object\n");
+		return -1;
+	}
+
+	if (extract_field_metadata(btf, ctx)) {
+		err_msg("bpf: failed to extract field metadata\n");
+		return -1;
+	}
+
+	ctx->num_states = extract_enum_names(btf, "state", ctx->state_names, ctx);
+	ctx->num_events = extract_enum_names(btf, "event", ctx->event_names, ctx);
+	if (ctx->num_states < 0 || ctx->num_events < 0) {
+		err_msg("bpf: failed to extract states (%d) or events names (%d)\n",
+			ctx->num_states, ctx->num_events);
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * find_bpf_object - search for BPF monitor object file in all directories
+ */
+static int find_bpf_object(const char *monitor_name, char *path_out, size_t path_len)
+{
+	char path[MAX_PATH];
+
+	bpf_fill_monitor_paths();
+	for (int i = 0; bpf_monitor_paths[i][0]; i++) {
+		size_t size = snprintf(path, sizeof(path), "%s/%s.o",
+				       bpf_monitor_paths[i], monitor_name);
+
+		if (size < MAX_PATH && access(path, R_OK) == 0) {
+			strncpy(path_out, path, path_len - 1);
+			path_out[path_len - 1] = '\0';
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * bpf_setup_ring_buffer - set up the ring buffer to trace events
+ *
+ * Find the ring buffer map, set up the events handler, and consume any
+ * pending data to start fresh.
+ */
+static struct ring_buffer *bpf_setup_ring_buffer(struct bpf_object *obj,
+						 struct bpf_monitor_ctx *ctx)
+{
+	struct ring_buffer *rb;
+	struct bpf_map *map;
+	char ringbuf_name[64];
+
+	if (extract_btf_info(obj, ctx))
+		return NULL;
+
+	snprintf(ringbuf_name, sizeof(ringbuf_name), "da_ringbuf_%s", ctx->monitor_name);
+	map = bpf_object__find_map_by_name(obj, ringbuf_name);
+	if (!map) {
+		err_msg("bpf: error finding ring buffer %s\n", ringbuf_name);
+		return NULL;
+	}
+
+	rb = ring_buffer__new(bpf_map__fd(map), handle_event, ctx, NULL);
+	if (!rb) {
+		err_msg("bpf: error opening ring buffer: %s\n", strerror(errno));
+		return NULL;
+	}
+
+	ring_buffer__consume(rb);
+
+	return rb;
+}
+
+/*
+ * reset_monitor_maps - clear all elements from monitor's maps
+ */
+static void reset_monitor_maps(struct bpf_object *obj)
+{
+	struct bpf_map *map;
+	bool err = false;
+
+	bpf_object__for_each_map(map, obj) {
+		enum bpf_map_type type = bpf_map__type(map);
+		int value_size = bpf_map__value_size(map);
+		int fd = bpf_map__fd(map);
+
+		if (fd < 0 || bpf_map__is_internal(map))
+			continue;
+
+		switch (type) {
+		case BPF_MAP_TYPE_HASH:
+		case BPF_MAP_TYPE_PERCPU_HASH: {
+			void *key = malloc(bpf_map__key_size(map));
+
+			if (!key) {
+				err = true;
+				break;
+			}
+
+			while (!err && bpf_map_get_next_key(fd, NULL, key) == 0)
+				err |= bpf_map_delete_elem(fd, key);
+
+			free(key);
+			debug_msg("bpf: reset hash map %s\n", bpf_map__name(map));
+			break;
+		}
+
+		case BPF_MAP_TYPE_PERCPU_ARRAY:
+			/*
+			 * Per-CPU maps require a buffer for all CPUs with each
+			 * element padded to 8 bytes
+			 */
+			value_size = libbpf_num_possible_cpus() *
+				     round_up(bpf_map__value_size(map), 8);
+			fallthrough;
+		case BPF_MAP_TYPE_ARRAY: {
+			uint32_t max_entries = bpf_map__max_entries(map);
+			void *zero_value = calloc(1, value_size);
+
+			if (!zero_value) {
+				err = true;
+				break;
+			}
+
+			for (uint32_t idx = 0; !err && idx < max_entries; idx++)
+				err |= bpf_map_update_elem(fd, &idx, zero_value, BPF_ANY);
+
+			free(zero_value);
+			debug_msg("bpf: zeroed array map %s\n", bpf_map__name(map));
+			break;
+		}
+		default:
+		}
+	}
+	if (err)
+		err_msg("bpf: errors during maps reset, continuing anyway.\n");
+}
+
+/*
+ * open_bpf_monitor - open and load a BPF monitor object
+ *
+ * If path is NULL, searches for the monitor by name. Otherwise uses the
+ * provided path directly.
+ *
+ * Returns loaded BPF object on success, NULL on error.
+ */
+static struct bpf_object *open_bpf_monitor(const char *monitor_name, const char *path)
+{
+	struct bpf_object *obj = NULL;
+	char _path[MAX_PATH];
+	int res;
+
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.pin_root_path = BPF_PIN_BASE_PATH,
+	);
+
+	if (!path) {
+		if (!find_bpf_object(monitor_name, _path, sizeof(_path))) {
+			err_msg("bpf: error finding monitor %s\n", monitor_name);
+			return NULL;
+		}
+		path = _path;
+	}
+
+	obj = bpf_object__open_file(path, &opts);
+	if (!obj) {
+		err_msg("bpf: error opening object file: %s\n", strerror(errno));
+		return NULL;
+	}
+
+	res = bpf_object__load(obj);
+	if (res) {
+		err_msg("bpf: error loading object file: %s\n", strerror(-res));
+		return NULL;
+	}
+
+	return obj;
+}
+
+/*
+ * attach_bpf_handlers - attach and pin all BPF programs
+ *
+ * Attaches all non-struct_ops programs and stores links in the provided array.
+ * Reuses existing pinned links when available.
+ *
+ * Returns number of attached programs on success, -1 on error.
+ */
+static int attach_bpf_handlers(const char *monitor_name, struct bpf_object *obj,
+				struct bpf_link **links, int *link_count)
+{
+	struct bpf_program *prog;
+	int res = 0;
+
+	bpf_object__for_each_program(prog, obj) {
+		struct bpf_link *link = NULL;
+		char pin_path[MAX_PATH];
+		const char *prog_name;
+		bool reused = true;
+
+		if (bpf_program__type(prog) == BPF_PROG_TYPE_STRUCT_OPS)
+			continue;
+
+		if (*link_count >= MAX_LINKS) {
+			err_msg("bpf: too many programs to attach (%d)\n", *link_count);
+			return -1;
+		}
+
+		prog_name = bpf_program__name(prog);
+		snprintf(pin_path, sizeof(pin_path), "%s/%s_%s",
+			 BPF_PIN_BASE_PATH, monitor_name, prog_name);
+
+		if (access(pin_path, F_OK) == 0)
+			link = bpf_link__open(pin_path);
+		if (!link) {
+			reused = false;
+			unlink(pin_path);
+			link = bpf_program__attach(prog);
+			if (!link) {
+				err_msg("bpf: error attaching program '%s': %s\n",
+					prog_name, strerror(errno));
+				return -1;
+			}
+		}
+		links[(*link_count)++] = link;
+
+		if (!reused) {
+			res = bpf_link__pin(link, pin_path);
+			if (res) {
+				err_msg("bpf: failed to pin link '%s': %s\n",
+					prog_name, strerror(-res));
+				return -1;
+			}
+		}
+	}
+	return res;
+}
+
+/*
+ * bpf_run_monitor - load and run a BPF monitor
+ *
+ * Returns 1 if monitor was found and executed, 0 if not found, -1 on error
+ */
+int bpf_run_monitor(char *monitor_name, int argc, char **argv)
+{
+	struct bpf_link *links[MAX_LINKS] = {0};
+	struct bpf_monitor_ctx ctx = {0};
+	struct ring_buffer *rb = NULL;
+	struct bpf_object *obj = NULL;
+	char structops_pin[MAX_PATH];
+	int res, link_count = 0, retval = -1;
+
+	/* If struct_ops is not registered this is not a BPF monitor */
+	snprintf(structops_pin, sizeof(structops_pin), "%s/rv_%s_kern",
+		 BPF_PIN_BASE_PATH, monitor_name);
+	if (access(structops_pin, F_OK) != 0)
+		return 0;
+
+	if (__ikm_read_enable(monitor_name) == 1) {
+		err_msg("bpf: monitor %s (BPF) is already enabled\n", monitor_name);
+		return -1;
+	}
+
+	strncpy(ctx.monitor_name, monitor_name, sizeof(ctx.monitor_name) - 1);
+
+	res = parse_arguments(monitor_name, argc, argv);
+	if (res)
+		mon_usage(1, monitor_name, "bpf: failed parsing arguments");
+
+	ikm_set_reactor(monitor_name);
+
+	libbpf_set_print(libbpf_print_fn);
+
+	obj = open_bpf_monitor(monitor_name, NULL);
+	if (!obj)
+		goto cleanup;
+
+	if (config.trace) {
+		rb = bpf_setup_ring_buffer(obj, &ctx);
+		if (!rb)
+			goto cleanup;
+	}
+
+	reset_monitor_maps(obj);
+
+	res = attach_bpf_handlers(monitor_name, obj, links, &link_count);
+	if (res < 0)
+		goto cleanup;
+
+	res = ikm_enable(monitor_name);
+	if (res < 0) {
+		err_msg("bpf: error enabling the monitor: %s\n", monitor_name);
+		goto cleanup;
+	}
+
+	if (config.trace)
+		bpf_print_header();
+
+	while (!should_stop()) {
+		if (!config.trace) {
+			sleep(1);
+			continue;
+		}
+		res = ring_buffer__poll(rb, 100);
+		if (res == -EINTR)
+			break;
+		if (res < 0) {
+			err_msg("bpf: error polling ring buffer: %s\n", strerror(-res));
+			goto cleanup;
+		}
+	}
+	retval = 1;
+
+cleanup:
+	ikm_disable(monitor_name);
+	reset_monitor_maps(obj);
+	ikm_reset_reactor(monitor_name);
+
+	for (int i = 0; i < link_count; i++) {
+		bpf_link__unpin(links[i]);
+		bpf_link__destroy(links[i]);
+	}
+
+	if (config.trace)
+		ring_buffer__free(rb);
+
+	bpf_object__close(obj);
+
+	return retval;
+}
diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index 09e0d8598619..e957e45ee2b1 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -13,6 +13,7 @@
 #include <trace.h>
 #include <utils.h>
 #include <in_kernel.h>
+#include <bpf_monitor.h>
 
 static int stop_session;
 
@@ -123,7 +124,10 @@ static void rv_mon(int argc, char **argv)
 	 * Call all possible monitor implementations, looking
 	 * for the [monitor].
 	 */
-	run += ikm_run_monitor(monitor_name, argc-1, &argv[1]);
+	run += bpf_run_monitor(monitor_name, argc-1, &argv[1]);
+
+	if (!run)
+		run += ikm_run_monitor(monitor_name, argc-1, &argv[1]);
 
 	if (!run)
 		err_msg("rv: monitor %s does not exist\n", monitor_name);
-- 
2.55.0

