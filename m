Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484A13DA7D2
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167282; cv=none; b=CjTY6M7INcGk00LAQJYnAEzBoJSxnn7wued+LxKM0YJTGaMiHFmEXCiSa32++EKuA+ZV/fKpAxNA+iOAiOLeFbRHDo74GykKmrEACDj3L9vSWU01+FbxDfxfNnxRQF8XlvV+1dXW7KAzZKv6oSS+EtevbBXaSTb5gkHnSGr2tGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167282; c=relaxed/simple;
	bh=9TuIq3wJtcCMx9IPEWJoDwyQnj7w/CXofFuvtgGhiZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cR1wBRYJX6qLUXTHRAxWbT3RPspymibT7m1J1QRs2hvgMLj869OpRwTjYShdHMDHtbgBfWqnd8M/R5ZXb08dE83yiEegHpufSMa3yK6XsWWullhRHSqFpHJNKCS8T/KooTVQIe91WGZ3LVD40uWU1RCcxom81t1bXH7TG9xnNHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ReG4p4jV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReG4p4jV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Gn6KUnO72LwEsrI5QgHpm6UHRTiVPqLtbbYl9Aw8D4=;
	b=ReG4p4jVdHKmHdZd5Q53HagJiEoVJdadeFi0mH19raS/WiuQZ84Sqno2R5lqAmIP71xxvR
	jXB3diOpcCpmJPZB2xMEBI9giG9FXMQQhIQE7632zkGG1rYkcyB6ipO8h91oPcKfsW3dzt
	VWx8mPpVlE09scKHpPBQNnVsWPZnRVM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-MW5EDFuLN2uHpyHmxO_gmg-1; Mon,
 31 Aug 2026 05:07:54 -0400
X-MC-Unique: MW5EDFuLN2uHpyHmxO_gmg-1
X-Mimecast-MFC-AGG-ID: MW5EDFuLN2uHpyHmxO_gmg_1788167273
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 854471944A92;
	Mon, 31 Aug 2026 09:07:53 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E94D180034F;
	Mon, 31 Aug 2026 09:07:50 +0000 (UTC)
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
Subject: [RFC PATCH 14/20] tools/rv: Implement BPF monitor registration logic
Date: Mon, 31 Aug 2026 11:05:18 +0200
Message-ID: <20260831090524.106845-15-gmonaco@redhat.com>
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

Add support for registering and unregistering BPF monitors from
userspace via the struct_ops mechanism. The implementation scans known
paths for BPF monitor objects, loads them, and attaches their struct_ops
maps.
After registration, BPF monitors appear as normal in-kernel monitors the
RV sysfs interface works seamlessly (besides tracepoints!).

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/include/bpf_monitor.h |   7 +
 tools/verification/rv/src/bpf_monitor.c     | 338 ++++++++++++++++++++
 tools/verification/rv/src/rv.c              |   4 +
 3 files changed, 349 insertions(+)

diff --git a/tools/verification/rv/include/bpf_monitor.h b/tools/verification/rv/include/bpf_monitor.h
index 60ce23589102..beb98b63c5f8 100644
--- a/tools/verification/rv/include/bpf_monitor.h
+++ b/tools/verification/rv/include/bpf_monitor.h
@@ -4,11 +4,18 @@
 
 #ifdef HAVE_LIBBPF
 int bpf_run_monitor(char *monitor_name, int argc, char **argv);
+void rv_bpf(int argc, char **argv);
 #else
 static inline int bpf_run_monitor(char *monitor_name, int argc, char **argv)
 {
 	return 0;
 }
+
+static inline void rv_bpf(int argc, char **argv)
+{
+	fprintf(stderr, "rv: BPF support not compiled in\n");
+	exit(1);
+}
 #endif /* HAVE_LIBBPF */
 
 #endif
diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification/rv/src/bpf_monitor.c
index e13ae35678cb..7e24a71dfac7 100644
--- a/tools/verification/rv/src/bpf_monitor.c
+++ b/tools/verification/rv/src/bpf_monitor.c
@@ -11,6 +11,7 @@
 #include <unistd.h>
 #include <dirent.h>
 #include <libgen.h>
+#include <getopt.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <bpf/libbpf.h>
@@ -679,3 +680,340 @@ int bpf_run_monitor(char *monitor_name, int argc, char **argv)
 
 	return retval;
 }
+
+/*
+ * register_monitor_from_file - register a single BPF monitor via struct_ops
+ *
+ * Opens, loads, and attaches a BPF monitor's struct_ops map, then pins the
+ * resulting link.
+ *
+ * Returns 0 on success, -1 on error
+ */
+static int register_monitor_from_file(const char *path, const char *name)
+{
+	struct bpf_object *obj = NULL;
+	struct bpf_link *link = NULL;
+	struct bpf_map *map;
+	char map_name[MAX_DA_NAME_LEN + 8];
+	char pin_path[MAX_PATH];
+	int res, retval = -1;
+
+	obj = open_bpf_monitor(name, path);
+	if (!obj)
+		goto cleanup;
+
+	snprintf(map_name, sizeof(map_name), "rv_%s_kern", name);
+	map = bpf_object__find_map_by_name(obj, map_name);
+	if (!map) {
+		err_msg("bpf: error finding struct_ops map for %s\n", name);
+		goto cleanup;
+	}
+
+	link = bpf_map__attach_struct_ops(map);
+	if (!link) {
+		err_msg("bpf: error attaching struct_ops for %s: %s\n",
+			name, strerror(errno));
+		goto cleanup;
+	}
+
+	snprintf(pin_path, sizeof(pin_path), "%s/%s", BPF_PIN_BASE_PATH, map_name);
+	res = bpf_link__pin(link, pin_path);
+	if (res) {
+		err_msg("bpf: error pinning link for %s: %s\n",
+			name, strerror(-res));
+		goto cleanup;
+	}
+
+	debug_msg("bpf: registered %s\n", name);
+	retval = 0;
+
+cleanup:
+	bpf_link__destroy(link);
+	bpf_object__close(obj);
+
+	return retval;
+}
+
+/*
+ * register_monitors_from_path - register all BPF monitors from a path
+ *
+ * Scans directory for *.o files and registers each one via struct_ops.
+ *
+ * Returns number of monitors registered from this path
+ */
+static int register_monitors_from_path(const char *path, bool *error)
+{
+	struct dirent *entry;
+	DIR *dir;
+	char *ext;
+	int count = 0;
+
+	dir = opendir(path);
+	if (!dir)
+		return 0;
+
+	while ((entry = readdir(dir)) != NULL) {
+		char name[MAX_DA_NAME_LEN], mon_path[MAX_PATH];
+		size_t size;
+
+		if (entry->d_name[0] == '.')
+			continue;
+
+		ext = strrchr(entry->d_name, '.');
+		if (!ext || strcmp(ext, ".o") != 0)
+			continue;
+
+		size = snprintf(mon_path, sizeof(mon_path), "%s/%s",
+				path, entry->d_name);
+		if (size >= MAX_PATH) {
+			err_msg("bpf: path too long: %s/%s\n", path, entry->d_name);
+			*error = true;
+			continue;
+		}
+
+		strncpy(name, entry->d_name, sizeof(name) - 1);
+		name[sizeof(name) - 1] = '\0';
+		ext = strrchr(name, '.');
+		if (ext)
+			*ext = '\0';
+
+		if (register_monitor_from_file(mon_path, name) == 0)
+			count++;
+		else
+			*error = true;
+	}
+
+	closedir(dir);
+	return count;
+}
+
+/*
+ * bpf_struct_ops_supported - check if the kernel supports BPF monitors
+ */
+static bool bpf_struct_ops_supported(void)
+{
+	struct btf *btf;
+	int type_id;
+
+	btf = btf__load_vmlinux_btf();
+	if (!btf)
+		return false;
+
+	type_id = btf__find_by_name_kind(btf, "bpf_struct_ops_rv_monitor", BTF_KIND_STRUCT);
+	btf__free(btf);
+
+	if (type_id <= 0)
+		return false;
+
+	return true;
+}
+
+/*
+ * bpf_register_monitors - register all BPF monitors via struct_ops
+ *
+ * Scans known paths for BPF monitor objects, loads them, and attaches their
+ * struct_ops maps. The resulting links are pinned so monitors remain
+ * registered with the kernel RV subsystem even after this process exits.
+ *
+ * Returns command exit status (SUCCESS/FAILURE)
+ */
+static int bpf_register_monitors(void)
+{
+	int count = 0;
+	bool error = false;
+
+	bpf_fill_monitor_paths();
+
+	for (int i = 0; bpf_monitor_paths[i][0]; i++)
+		count += register_monitors_from_path(bpf_monitor_paths[i], &error);
+
+	printf("registered %d BPF monitor(s)\n", count);
+
+	return error ? EXIT_FAILURE : EXIT_SUCCESS;
+}
+
+/*
+ * is_struct_ops - return true if d_name matches rv_<mon>_kern
+ *
+ * Also store <mon> in name_out when returning true.
+ */
+static bool is_struct_ops(char *d_name, char *name_out)
+{
+	const int rvlen = strlen("rv_"), kernlen = strlen("_kern");
+	int len = strlen(d_name);
+
+	if (len > rvlen + kernlen && !strncmp(d_name, "rv_", rvlen) &&
+	    !strcmp(d_name + len - kernlen, "_kern")) {
+		len -= rvlen + kernlen;
+		if (name_out) {
+			if (len >= MAX_DA_NAME_LEN)
+				len = MAX_DA_NAME_LEN - 1;
+			strncpy(name_out, d_name + rvlen, len);
+			name_out[len] = '\0';
+		}
+		return true;
+	}
+	return false;
+}
+
+enum unregister_pass {
+	CHECK_ACTIVE,
+	UNLINK_HANDLERS,
+	UNLINK_STRUCT_OPS,
+	MAX_PASSES,
+};
+
+/*
+ * bpf_unregister_monitors - unregister all BPF monitors
+ *
+ * Removes all pinned links and maps from BPF_PIN_BASE_PATH, including the
+ * struct_ops. This unregisters the monitors from the RV subsystem and cleans
+ * up all associated resources.
+ *
+ * First iterate over the directory to check if any BPF monitor is active,
+ * this is best effort. Then unlink all handlers and at last all struct_ops.
+ *
+ * Returns command exit status (SUCCESS/FAILURE)
+ */
+static int bpf_unregister_monitors(void)
+{
+	struct dirent *entry;
+	DIR *dir;
+	int count = 0;
+
+	dir = opendir(BPF_PIN_BASE_PATH);
+	if (!dir) {
+		err_msg("bpf: cannot open %s: %s\n",
+			BPF_PIN_BASE_PATH, strerror(errno));
+		return EXIT_FAILURE;
+	}
+
+	for (int pass = CHECK_ACTIVE; pass < MAX_PASSES; pass++) {
+		rewinddir(dir);
+		while ((entry = readdir(dir)) != NULL) {
+			char pin_path[MAX_PATH];
+			char mon_name[MAX_DA_NAME_LEN];
+			int is_ops;
+
+			if (entry->d_name[0] == '.')
+				continue;
+
+			is_ops = is_struct_ops(entry->d_name, mon_name);
+
+			switch (pass) {
+			case CHECK_ACTIVE:
+				if (is_ops && __ikm_read_enable(mon_name) == 1) {
+					err_msg("bpf: monitor %s is enabled, cannot unregister\n",
+						mon_name);
+					closedir(dir);
+					return EXIT_FAILURE;
+				}
+				continue;
+			case UNLINK_HANDLERS:
+				if (is_ops)
+					continue;
+				fallthrough;
+			case UNLINK_STRUCT_OPS:
+				snprintf(pin_path, sizeof(pin_path), "%s/%s",
+					 BPF_PIN_BASE_PATH, entry->d_name);
+
+				if (unlink(pin_path)) {
+					err_msg("bpf: failed to unlink %s: %s\n", pin_path,
+						strerror(errno));
+				} else if (is_ops) {
+					count++;
+					debug_msg("bpf: unregistered %s\n", mon_name);
+				}
+				break;
+			}
+		}
+	}
+
+	closedir(dir);
+
+	printf("unregistered %d BPF monitor(s)\n", count);
+	return EXIT_SUCCESS;
+}
+
+/*
+ * rv_bpf - handle BPF monitor registration commands
+ */
+void rv_bpf(int argc, char **argv)
+{
+	static const char *const usage[] = {
+		"",
+		"  usage: rv bpf [-h] [-v] {register,unregister}",
+		"",
+		"\tmanage BPF monitor registration",
+		"",
+		"\t-h/--help: print this menu",
+		"\t-v/--verbose: print debug messages",
+		"",
+		"\tregister:   register all available BPF monitors",
+		"\tunregister: unregister all BPF monitors",
+		NULL,
+	};
+	int print_help = 0, retval = EXIT_SUCCESS;
+
+	while (1) {
+		static struct option long_options[] = {
+			{"help",	no_argument,		0, 'h'},
+			{"verbose",	no_argument,		0, 'v'},
+			{0, 0, 0, 0}
+		};
+		int option_index = 0;
+		int c = getopt_long(argc, argv, "hv", long_options, &option_index);
+
+		/* detect the end of the options */
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 'h':
+			print_help = 1;
+			retval = EXIT_SUCCESS;
+			break;
+		case 'v':
+			config.debug = 1;
+			break;
+		default:
+			print_help = 1;
+			retval = EXIT_FAILURE;
+			break;
+		}
+	}
+
+	/* requires at least one argument after options */
+	if (optind >= argc && !print_help) {
+		print_help = 1;
+		retval = EXIT_FAILURE;
+	}
+
+	if (print_help) {
+		fprintf(stderr, "rv version %s\n", VERSION);
+		for (int i = 0; usage[i]; i++)
+			fprintf(stderr, "%s\n", usage[i]);
+		exit(retval);
+	}
+
+	if (!bpf_struct_ops_supported()) {
+		err_msg("bpf: kernel does not support BPF monitors\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (!strcmp(argv[optind], "register")) {
+		retval = bpf_register_monitors();
+		exit(retval);
+	}
+
+	if (!strcmp(argv[optind], "unregister")) {
+		retval = bpf_unregister_monitors();
+		exit(retval);
+	}
+
+	/* invalid sub-command */
+	fprintf(stderr, "rv version %s\n", VERSION);
+	for (int i = 0; usage[i]; i++)
+		fprintf(stderr, "%s\n", usage[i]);
+	exit(EXIT_FAILURE);
+}
diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index e957e45ee2b1..3e6e5e786746 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -149,6 +149,7 @@ static void usage(int exit_val, const char *fmt, ...)
 		"	command: run one of the following command:",
 		"	  list: list all available monitors",
 		"	  mon:  run a monitor",
+		"	  bpf:  manage BPF monitors registration",
 		"",
 		"	[command options]: each command has its own set of options",
 		"		           run rv command -h for further information",
@@ -189,6 +190,9 @@ int main(int argc, char **argv)
 	if (!strcmp(argv[1], "list"))
 		rv_list(--argc, &argv[1]);
 
+	if (!strcmp(argv[1], "bpf"))
+		rv_bpf(argc - 1, &argv[1]);
+
 	if (!strcmp(argv[1], "mon")) {
 		/*
 		 * monitor's main should monitor should_stop() function.
-- 
2.55.0

