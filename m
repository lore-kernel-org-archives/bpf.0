Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698078;
	b=1IFNs8BtqHbDerwVszvi0tNpZxWbw1CepXWtoxg0zz39AqxR3Id0RBgUbtx7ZbLZahHl
	 D/SrLQOBi749cXLTXcKQsYOyoBY0PRhtPIoEtPgpneOORqXqvT6Dcum4/D42Q3vozJqu9
	 QaUV7cxx6Wv6oUzHRp3N9EyeNj5ODKj8bzMYjKRt5bQZcVgZoqquUl00J0xyae9x00fOI
	 XV+v9vyzlBDIvVklozwse5qQR8sO4GkaENsXix4lqkBYuTG7OyIjwFWxsHbho+RfU1bKl
	 ypCQ+iTKXpOmBG4cRSfZhFumgEyDRzsRxBOnms+kUXXagESwtOVLkSOITmRlVUQnhgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698078;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=zC8dAuQq149MZ5BsQEvyCxHSGduIDqnB2gj0ZZzxdpM=;
	b=XrooX89pEZpl/ON7Th/crBLGtvX/2tGkRYO4pu6fB0LBpjZkgUIy0NFY374BZnENq7ik
	 0ENvQM9yL4B0VKzc0f6/4+NFtBPVYxxuWF1nUcnUDf8fBHK4scbSlOERmPy9g/UjWwRPU
	 sVsiNnTqJhWprxjRH1vbR3xCJSg+LdcBamjl+DAVfEmPw2vebJttnoPpqfgta+ValQOXZ
	 07rDJqUS9x3p68J1TGRJblT1rPRyuRMZwjYf53Xzf0yn+7DgneZ8J1dLKmt9a/FgFZ3Xy
	 QRdgAITQ2lgFvMVjbBgs2Fs3cmYh1+VA1lLSlghtwZAZui5Q5PPDfBKo4LV5DuVZ07w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M8Zgmwxj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150AC606A33B
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 150AC606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M8Zgmwxj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zC8dAuQq149MZ5BsQEvyCxHSGduIDqnB2gj0ZZzxdpM=;
	b=M8ZgmwxjWth1nMENMkzIzrNCfndXn4lWGipXAz5Ctcl0s7nLk0YPYXXb7cVqt3BrmRN7yK
	cRgKpYqTCy+LAJnmtqN8qES2inVEpbndA2jCmNdERIbMPV7WE/SuW4VAEFj/Ckrm18Ss7Z
	lAolpHxWiXdJRelF/N5I0o0N5lwTc1o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-S3kHA3hUOKu_Uyhd_Sj9WA-1; Thu,
 26 Nov 2026 13:01:11 +0000
X-MC-Unique: S3kHA3hUOKu_Uyhd_Sj9WA-1
X-Mimecast-MFC-AGG-ID: S3kHA3hUOKu_Uyhd_Sj9WA_1795698069
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AA411955F74;
	Thu, 26 Nov 2026 13:01:09 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 586EB1800543;
	Thu, 26 Nov 2026 13:01:06 +0000 (UTC)
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
	Viktor Malik <vmalik@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 09/18] tools/rv: Implement BPF monitor discovery and listing
Date: Thu, 26 Nov 2026 13:59:55 +0100
Message-ID: <20261126130004.127155-10-gmonaco@redhat.com>
In-Reply-To: <20261126130004.127155-1-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
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
 tools/verification/rv/src/bpf_monitor.c     | 240 ++++++++++++++++++++
 tools/verification/rv/src/rv.c              |   2 +
 6 files changed, 287 insertions(+), 1 deletion(-)
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
index 000000000000..a5767617c720
--- /dev/null
+++ b/tools/verification/rv/src/bpf_monitor.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF monitor support: allows rv to control BPF monitors.
+ *
+ * Copyright (C) 2026 Red Hat Inc, Gabriele Monaco <gmonaco@redhat.com>
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <sys/stat.h>
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
+#define RV_LOCK_DIR "/run/rv"
+
+/*
+ * bpf_lock_acquire - take the ownership lock for a monitor
+ *
+ * The lock is held for the whole monitor lifetime and released by the kernel
+ * when the process exits, including on crashes. The lock file is never
+ * removed: unlinking it would allow two processes to lock different inodes.
+ *
+ * Returns the fd if the lock was acquired, -errno on error, -EAGAIN means busy.
+ */
+static int bpf_lock_acquire(const char *monitor_name)
+{
+	struct flock fl = { .l_type = F_WRLCK, .l_whence = SEEK_SET };
+	char path[MAX_PATH];
+	int fd, ret;
+
+	snprintf(path, MAX_PATH, "%s/%s.lock", RV_LOCK_DIR, monitor_name);
+
+	if (mkdir(RV_LOCK_DIR, 0700) && errno != EEXIST)
+		return -errno;
+
+	fd = open(path, O_RDWR | O_CREAT | O_CLOEXEC | O_NOFOLLOW, 0600);
+	if (fd < 0)
+		return -errno;
+
+	if (fcntl(fd, F_OFD_SETLK, &fl)) {
+		ret = errno;
+		close(fd);
+		return -ret;
+	}
+
+	return fd;
+}
+
+/*
+ * bpf_lock_is_held - check if a monitor is owned by a running process
+ *
+ * Use F_OFD_GETLK to query the lock without disturbing the owner.
+ *
+ * Returns 1 if the monitor is locked, 0 otherwise.
+ */
+static int bpf_lock_is_held(const char *monitor_name)
+{
+	struct flock fl = { .l_type = F_WRLCK, .l_whence = SEEK_SET };
+	char path[MAX_PATH];
+	int fd, ret;
+
+	snprintf(path, MAX_PATH, "%s/%s.lock", RV_LOCK_DIR, monitor_name);
+
+	fd = open(path, O_RDONLY | O_CLOEXEC | O_NOFOLLOW);
+	if (fd < 0)
+		return 0;
+
+	ret = fcntl(fd, F_OFD_GETLK, &fl);
+	close(fd);
+
+	return ret ? 0 : fl.l_type != F_UNLCK;
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
+		size = (size_t)(ext - entry->d_name);
+		if (size >= MAX_DA_NAME_LEN) {
+			err_msg("bpf: name too long, skipping %s/%s\n", path,
+				entry->d_name);
+			continue;
+		}
+		memcpy(name, entry->d_name, size);
+		name[size] = '\0';
+
+		size = snprintf(obj_path, sizeof(obj_path), "%s/%s", path,
+				entry->d_name);
+		obj = bpf_object__open_file(obj_path, NULL);
+		if (!obj || size >= MAX_PATH) {
+			err_msg("bpf: error opening object file %s: %s\n",
+				obj_path, strerror(errno));
+			continue;
+		}
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
+	       desc, bpf_lock_is_held(name) ? "[ON]" : "[OFF]");
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
2.56.1

