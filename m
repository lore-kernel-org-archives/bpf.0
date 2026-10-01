Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470A152BE34
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868122; cv=none; b=J4UJ7+Wv2+CLkPGq5grKRlNoV3deKmsFxJiXf5fBAULtsL0j6OU9tYk0T6O2miCb9JgqKjZ85vUOexp1k2Jr0pnqkgs6LmczHNH7i5Y240SC1sPvKRnAfgYGKSHHldCt4pPiYRGT0qnP89cEdxO1nsOAXgZnW18wpPp3HvQm78k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868122; c=relaxed/simple;
	bh=8J65eDhmMb7gS7zkNSvT7Nfhk1sMTkzjckq3C7Ogo7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXuOP7K0D+8pOhh9IP3cF3HToCVAihvr1YoPC5ZBZcz5urCajie4jnOf2/gopWnUA7L2cHbjawvLzDVXDjxK1kkeeDemfDrqkj3OH7WXHVj7pKoGBelsRJ11WUBZXZqcWoIF7FCTAc3r1ZQ7mDiYZTsUBaEu5OE9v3dcgEtPBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJ8AnC4t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJ8AnC4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyEuURtNLnrHKKX6nmqdq7TCyAr4px2q0sPRXoZijyE=;
	b=KJ8AnC4tVK+M8UYnCNN9CHBqUImP4B4pjKrETaVLjATHKYV2Ub5lrHSv04zw0orAoD02B1
	Zd9Gs/sjvkWA3+rVzgiJc8IPbFypAy/x4mS6Y7uTmMov3TUemxM3SCZhY/jKUn4NF7QCXa
	9cg4NsmwWFpGH1ASjh71w/tdRzFPcrk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-RfbGcgcUN8GmEHy6-RPIfg-1; Thu,
 01 Oct 2026 11:21:53 -0400
X-MC-Unique: RfbGcgcUN8GmEHy6-RPIfg-1
X-Mimecast-MFC-AGG-ID: RfbGcgcUN8GmEHy6-RPIfg_1790868111
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A77A6195E916;
	Thu,  1 Oct 2026 15:21:51 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4E7F1800351;
	Thu,  1 Oct 2026 15:21:48 +0000 (UTC)
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
Subject: [PATCH v2 07/15] tools/rv: Implement BPF monitor discovery and listing
Date: Thu,  1 Oct 2026 17:20:34 +0200
Message-ID: <20261001152042.124445-8-gmonaco@redhat.com>
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

Implement the BPF monitor listing functionality that scans for compiled
BPF monitor object files and displays them in the monitor list.

If enabled, running rv list shows in-kernel and BPF monitors found in
/usr/share/rv/bpf_monitors/ or in ./bpf_monitors/ relative to the RV
binary's location (used during development).

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/Makefile              |   4 +-
 tools/verification/rv/Makefile.config       |  23 ++
 tools/verification/rv/include/bpf_monitor.h |  14 ++
 tools/verification/rv/src/Build             |   5 +
 tools/verification/rv/src/bpf_monitor.c     | 223 ++++++++++++++++++++
 tools/verification/rv/src/rv.c              |   2 +
 6 files changed, 270 insertions(+), 1 deletion(-)
 create mode 100644 tools/verification/rv/include/bpf_monitor.h
 create mode 100644 tools/verification/rv/src/bpf_monitor.c

diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
index 8ae5fc0d1d17..0a8c7a656f7f 100644
--- a/tools/verification/rv/Makefile
+++ b/tools/verification/rv/Makefile
@@ -32,8 +32,10 @@ DOCSRC		:= ../../../Documentation/tools/rv/
 
 FEATURE_TESTS	:= libtraceevent
 FEATURE_TESTS	+= libtracefs
+FEATURE_TESTS	+= libbpf
 FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
+FEATURE_DISPLAY	+= libbpf
 
 all: $(RV)
 
@@ -57,7 +59,7 @@ endif
 
 CFLAGS		+= $(INCLUDES) $(LIB_INCLUDES)
 
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
index 000000000000..e58bc45c5f75
--- /dev/null
+++ b/tools/verification/rv/include/bpf_monitor.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _BPF_MONITOR_H
+#define _BPF_MONITOR_H
+
+#ifdef HAVE_LIBBPF
+int bpf_list_monitors(char *container);
+#else
+static inline int bpf_list_monitors(char *container)
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
index 000000000000..a1de0c157712
--- /dev/null
+++ b/tools/verification/rv/src/bpf_monitor.c
@@ -0,0 +1,223 @@
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
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+
+#include <bpf_monitor.h>
+#include <utils.h>
+#include <rv.h>
+
+static char bpf_base_paths[][MAX_PATH] = {
+	".",
+	"/etc/rv",
+	"/usr/local/share/rv",
+	"/usr/share/rv",
+	"", /* Marker */
+};
+
+/* Path used for development, searched first */
+#define DEVEL_PATH 0
+
+
+/*
+ * bpf_read_enable - reads monitor's enable status
+ *
+ * Iterate through all BPF maps in the system, if the rv_mon_NAME map is
+ * loaded, the monitor is enabled.
+ * Since map names have limited size and may get truncated, check that also the
+ * corresponding BTF matches.
+ */
+static int bpf_read_enable(const char *monitor_name)
+{
+	char ringbuf_name[2 * MAX_DA_NAME_LEN];
+	uint32_t id = 0;
+
+	snprintf(ringbuf_name, sizeof(ringbuf_name),
+		 "rv_mon_%s", monitor_name);
+
+	while (bpf_map_get_next_id(id, &id) == 0) {
+		struct bpf_map_info info = { 0 };
+		uint32_t info_len = sizeof(info);
+		struct btf *btf;
+		int type_id;
+		int fd = bpf_map_get_fd_by_id(id);
+
+		if (fd < 0)
+			continue;
+
+		if (bpf_map_get_info_by_fd(fd, &info, &info_len) != 0) {
+			close(fd);
+			continue;
+		}
+		close(fd);
+
+		if (strncmp(info.name, ringbuf_name, BPF_OBJ_NAME_LEN - 1) != 0)
+			continue;
+
+		if (!info.btf_id)
+			continue;
+		btf = btf__load_from_kernel_by_id(info.btf_id);
+		if (!btf)
+			continue;
+
+		type_id = btf__find_by_name_kind(btf, ringbuf_name, BTF_KIND_VAR);
+		btf__free(btf);
+		if (type_id > 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * bpf_read_desc - read monitors' description
+ *
+ * Return the provided string containing the monitor's description, NULL
+ * otherwise.
+ */
+static char *bpf_read_desc(char *desc, struct bpf_object *obj, const char *monitor_name)
+{
+	struct bpf_map *map = bpf_object__find_map_by_name(obj, ".rodata.description");
+	const char *desc_data;
+	size_t desc_size;
+
+	if (!map) {
+		debug_msg("bpf: cannot find description for %s\n",
+			  monitor_name);
+		return NULL;
+	}
+	desc_data = bpf_map__initial_value(map, &desc_size);
+	if (!desc_data || desc_size == 0) {
+		debug_msg("bpf: empty description for %s\n", monitor_name);
+		*desc = 0;
+		return desc;
+	}
+
+	if (desc_size >= MAX_DESCRIPTION)
+		desc_size = MAX_DESCRIPTION - 1;
+	strncpy(desc, desc_data, desc_size);
+	desc[desc_size] = '\0';
+
+	return desc;
+}
+
+/*
+ * bpf_fill_base_paths - fill the path for development builds
+ *
+ * RV searches for BPF monitors on absolute paths on the system as well
+ * as in the same directory of the rv binary. This is useful when running
+ * rv from the kernel tree. This function resolves the right location.
+ */
+static void bpf_fill_base_paths(void)
+{
+	char tmp_path[MAX_PATH], *dir;
+	ssize_t len;
+
+	len = readlink("/proc/self/exe", tmp_path, MAX_PATH);
+	if (len > 0 && len != MAX_PATH) {
+		tmp_path[len] = '\0';
+		dir = dirname(tmp_path);
+		snprintf(bpf_base_paths[DEVEL_PATH], MAX_PATH, "%s", dir);
+	}
+}
+
+static void bpf_object_iterate_path(const char *base_path, const char *subdir,
+				    void (*action)(const char *name, struct bpf_object *obj))
+{
+	char path[MAX_PATH];
+	struct dirent *entry;
+	DIR *dir;
+	char *ext;
+
+	snprintf(path, sizeof(path), "%s/%s", base_path, subdir);
+	dir = opendir(path);
+	if (!dir) {
+		debug_msg("bpf: error opening directory: %s\n", path);
+		return;
+	}
+
+	while ((entry = readdir(dir)) != NULL) {
+		size_t size;
+		struct bpf_object *obj;
+		char name[MAX_DA_NAME_LEN], obj_path[MAX_PATH];
+
+		if (entry->d_name[0] == '.')
+			continue;
+
+		ext = strrchr(entry->d_name, '.');
+		if (!ext || strcmp(ext, ".o") != 0)
+			continue;
+
+		size = snprintf(obj_path, sizeof(obj_path), "%s/%s", path,
+				entry->d_name);
+		obj = bpf_object__open_file(obj_path, NULL);
+		if (!obj || size > MAX_PATH) {
+			err_msg("bpf: error opening object file %s: %s\n",
+				obj_path, strerror(errno));
+			continue;
+		}
+
+		strncpy(name, entry->d_name, sizeof(name));
+		ext = strrchr(name, '.');
+		if (ext)
+			*ext = '\0';
+
+		action(name, obj);
+
+		bpf_object__close(obj);
+	}
+
+	closedir(dir);
+}
+
+static void list_monitor_action(const char *name, struct bpf_object *obj)
+{
+	char desc[MAX_DESCRIPTION];
+
+	if (!bpf_read_desc(desc, obj, name)) {
+		err_msg("bpf: monitor %s does not have desc map, bug?\n", name);
+		return;
+	}
+
+	printf("%-*s %s %s\n", MAX_DA_NAME_LEN, name,
+	       desc, bpf_read_enable(name) ? "[ON]" : "[OFF]");
+}
+
+/*
+ * list_monitors_from_path - list monitors from a specific base path
+ */
+static void list_monitors_from_path(const char *base_path)
+{
+	bpf_object_iterate_path(base_path, "bpf_monitors", list_monitor_action);
+}
+
+/*
+ * bpf_list_monitors - list available BPF monitors from all sources
+ *
+ * @container: BPF monitors are not nested, skip listing.
+ *
+ * Returns 0 on success
+ */
+int bpf_list_monitors(char *container)
+{
+	if (container)
+		return 0;
+	bpf_fill_base_paths();
+	for (int i = 0; bpf_base_paths[i][0]; i++)
+		list_monitors_from_path(bpf_base_paths[i]);
+
+	return 0;
+}
diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index 09e0d8598619..7c4a2e49ff9d 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -13,6 +13,7 @@
 #include <trace.h>
 #include <utils.h>
 #include <in_kernel.h>
+#include <bpf_monitor.h>
 
 static int stop_session;
 
@@ -76,6 +77,7 @@ static void rv_list(int argc, char **argv)
 	}
 
 	ikm_list_monitors(container);
+	bpf_list_monitors(container);
 
 	exit(EXIT_SUCCESS);
 }
-- 
2.55.0

