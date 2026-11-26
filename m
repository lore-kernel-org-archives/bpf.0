Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698082;
	b=R/TalKTu3hJVps3BozHDzISyvySGlMeQqd+7uDPa7RmubxkUfrbj1Ad/oD4ZuVwuBv8v
	 xkNPIA5EtximgjPbrbicP6ui0DqY7bXy5Ja9Hs+lVR88AYt0/ShZRsshUUAJ5kwM39VHX
	 sQO46yjEMcOx3RqdjHeeV2kXt2a95CwyJMUCow5unhJOrPN6fvNfc5MKHGmNW82hYi5Pb
	 1pN2G2u4GY0Te7XJxUvGB6OxXBcLrJR8SJUGsqdoYnN3TuT/bpNYYJTtlI6UtX0Z+bSEr
	 An8X1fJblwk3vbh5VRG8eCRnHoUdU7zyUPlcLCHJ2aYGA2Gw9miWSD4xlXXC/533iKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698082;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=zGvc4KxJZB3NeERGpYzcEekNx68KNzuyEnfFZOh/Vyg=;
	b=Vd2tfUEVLXkQ4eE+dYeb5zK0ajsuUWxe6e64OUYDOLNXtNJCgMQy3DbYnd08NukZ2hg5
	 RQ7M109l8eAmnJF9Z55nmXoios7Iqi1dJRoc5GKFXG3n24Bhwb7ivu3LdC6/IsW/6L6lE
	 8p3auje9kYEu4HDOPgi1sW7WlVRqq3/0l18M0+JPrXBn2RY6mwI9M2ZryjFKQcNXuQp+2
	 8z7K/QZBpfizWx8F4pMbwHt7boqkDvfsLPkTnOUc+f5kLS2C5lie3EW+l+ZjwoxBgfAAR
	 LEWAqRPTfF7JiYw60wZD0HvIBrkMFvuLeRJPlFyWdFA954tMr91Ym385EAtvUYSCRwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Io/4HgWD";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6839606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6839606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Io/4HgWD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGvc4KxJZB3NeERGpYzcEekNx68KNzuyEnfFZOh/Vyg=;
	b=Io/4HgWDFd0JafKZCZEZp15N6Zbsn921DLx2c+6bsroYsIzF8aaRNVfH60/nJv/vREjsBP
	nZ//AH+6EXqgXBILZFtY2mH2j8RfcUvpNRm1ZKdCrsGCl8QptrBckuvW6+VXFIzyoBuqig
	qw1LM6bGGsXnGdGuLvKS3yfSXgt7dhc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-NA64PonHN82whrqr7ZISag-1; Thu,
 26 Nov 2026 13:01:17 +0000
X-MC-Unique: NA64PonHN82whrqr7ZISag-1
X-Mimecast-MFC-AGG-ID: NA64PonHN82whrqr7ZISag_1795698074
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B2981956069;
	Thu, 26 Nov 2026 13:01:14 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 094A81801A73;
	Thu, 26 Nov 2026 13:01:10 +0000 (UTC)
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
Subject: [PATCH v3 10/18] tools/rv: Implement BPF monitor loading and tracing
Date: Thu, 26 Nov 2026 13:59:56 +0100
Message-ID: <20261126130004.127155-11-gmonaco@redhat.com>
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

Implement BPF monitor loading, execution, and optional tracing
functionality.

Running rv mon MON loads the MON monitor into the kernel and passing the
-t parameter also attaches to the trace events using the same utilities
shared with in-kernel monitors.
The shared infrastructure still needs refactoring and wiring with new
generic trace events.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/include/bpf_monitor.h |   6 +
 tools/verification/rv/include/utils.h       |   2 +
 tools/verification/rv/src/bpf_monitor.c     | 490 ++++++++++++++++++++
 tools/verification/rv/src/rv.c              |   3 +
 tools/verification/rv/src/utils.c           |   7 +-
 5 files changed, 506 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rv/include/bpf_monitor.h b/tools/verification/rv/include/bpf_monitor.h
index e58bc45c5f75..e650f11afdab 100644
--- a/tools/verification/rv/include/bpf_monitor.h
+++ b/tools/verification/rv/include/bpf_monitor.h
@@ -4,11 +4,17 @@
 
 #ifdef HAVE_LIBBPF
 int bpf_list_monitors(char *container);
+int bpf_run_monitor(char *monitor_name, int argc, char **argv);
 #else
 static inline int bpf_list_monitors(char *container)
 {
 	return 0;
 }
+
+static inline int bpf_run_monitor(char *monitor_name, int argc, char **argv)
+{
+	return 0;
+}
 #endif /* HAVE_LIBBPF */
 
 #endif
diff --git a/tools/verification/rv/include/utils.h b/tools/verification/rv/include/utils.h
index 61f77a72a1a2..d6b4e60df7ff 100644
--- a/tools/verification/rv/include/utils.h
+++ b/tools/verification/rv/include/utils.h
@@ -10,11 +10,13 @@ void mon_usage(int exit_val, char *monitor_name, const char *fmt, ...);
 int parse_arguments(char *monitor_name, int argc, char **argv);
 
 void ikm_usage_print_reactors(void);
+void bpf_usage_print_reactors(void);
 
 struct config {
 	bool debug;
 	bool is_container;
 	bool trace;
+	bool is_bpf;
 	int has_id;
 	int my_pid;
 	char *initial_reactor;
diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification/rv/src/bpf_monitor.c
index a5767617c720..5c9c4d9b4835 100644
--- a/tools/verification/rv/src/bpf_monitor.c
+++ b/tools/verification/rv/src/bpf_monitor.c
@@ -16,11 +16,13 @@
 #include <dirent.h>
 #include <libgen.h>
 #include <errno.h>
+#include <inttypes.h>
 #include <bpf/libbpf.h>
 #include <bpf/bpf.h>
 #include <bpf/btf.h>
 
 #include <bpf_monitor.h>
+#include <trace.h>
 #include <utils.h>
 #include <rv.h>
 
@@ -36,6 +38,31 @@ static char bpf_base_paths[][MAX_PATH] = {
 #define DEVEL_PATH 0
 
 #define RV_LOCK_DIR "/run/rv"
+#define MAX_ENUMS 64
+#define MAX_LINKS 16
+#define PROG_ENABLE_MON "enable_monitor"
+#define PROG_INIT_TASK "init_task"
+#define RV_TRACE_STRUCT "rv_trace_entry"
+#define RV_TRACE_TYPE_ENUM "rv_trace_type"
+
+#define CPU_POSSIBLE "/sys/devices/system/cpu/possible"
+#define CPU_MAX "/sys/devices/system/cpu/kernel_max"
+
+enum trace_type_id {
+	TRACE_TYPE_ERROR,
+	TRACE_TYPE_EVENT,
+	TRACE_TYPE_MAX,
+};
+
+static const char *const trace_type_names[] = {
+	[TRACE_TYPE_ERROR] = "RV_TRACE_ERROR",
+	[TRACE_TYPE_EVENT] = "RV_TRACE_EVENT",
+};
+
+struct bpf_monitor_ctx {
+	char monitor_name[MAX_DA_NAME_LEN];
+	int trace_types[TRACE_TYPE_MAX];
+};
 
 /*
  * bpf_lock_acquire - take the ownership lock for a monitor
@@ -238,3 +265,466 @@ int bpf_list_monitors(char *container)
 
 	return 0;
 }
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
+ * extract_trace_type_metadata - extract trace type enum values from BTF
+ *
+ * Introspect the rv_trace_type enum via BTF and store enum values for
+ * event type dispatch and configuration.
+ *
+ * Returns 0 on success, -1 on error
+ */
+static int extract_trace_type_metadata(const struct btf *btf, struct bpf_monitor_ctx *ctx)
+{
+	const struct btf_type *enum_type;
+	const struct btf_enum *enums;
+	int type_id, vlen, filled = 0;
+
+	for (int i = 0; i < TRACE_TYPE_MAX; i++)
+		ctx->trace_types[i] = -1;
+
+	type_id = btf__find_by_name_kind(btf, RV_TRACE_TYPE_ENUM, BTF_KIND_ENUM);
+	if (type_id <= 0) {
+		debug_msg("bpf: could not find enum '%s' in BTF\n", RV_TRACE_TYPE_ENUM);
+		return -1;
+	}
+
+	enum_type = btf__type_by_id(btf, type_id);
+	if (!enum_type) {
+		debug_msg("bpf: could not get type for '%s'\n", RV_TRACE_TYPE_ENUM);
+		return -1;
+	}
+
+	enums = btf_enum(enum_type);
+	vlen = btf_vlen(enum_type);
+
+	for (int i = 0; i < vlen; i++) {
+		const char *name = btf__name_by_offset(btf, enums[i].name_off);
+
+		if (!name)
+			continue;
+
+		for (int j = 0; j < TRACE_TYPE_MAX; j++) {
+			if (strcmp(name, trace_type_names[j]) == 0) {
+				ctx->trace_types[j] = enums[i].val;
+				++filled;
+				break;
+			}
+		}
+	}
+
+	if (filled < TRACE_TYPE_MAX) {
+		debug_msg("bpf: could not find all trace types in BTF\n");
+		return -1;
+	}
+
+	return 0;
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
+	if (extract_trace_type_metadata(btf, ctx)) {
+		err_msg("bpf: failed to extract trace type metadata\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * find_bpf_file - search for a BPF object file in a specific subdirectory
+ */
+static int find_bpf_file(const char *subdir, const char *name, char *path_out, size_t path_len)
+{
+	char path[MAX_PATH];
+
+	for (int i = 0; bpf_base_paths[i][0]; i++) {
+		size_t size = snprintf(path, sizeof(path), "%s/%s/%s.o",
+				       bpf_base_paths[i], subdir, name);
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
+ * find_bpf_monitor - search for BPF monitor object file in all directories
+ */
+static int find_bpf_monitor(const char *monitor_name, char *path_out, size_t path_len)
+{
+	return find_bpf_file("bpf_monitors", monitor_name, path_out, path_len);
+}
+
+/*
+ * bpf_usage_print_reactors - print available BPF reactors
+ */
+void bpf_usage_print_reactors(void)
+{
+	fprintf(stderr, "  available BPF reactors: nop\n");
+}
+
+/*
+ * bpf_enable_tracing - set the trace_level variable in .rodata
+ *
+ * Find trace_level in a special section of .rodata and set its value before
+ * loading.
+ *
+ * Returns 0 on success, -1 on error.
+ */
+static int bpf_enable_tracing(struct bpf_object *obj, struct bpf_monitor_ctx *ctx)
+{
+	struct bpf_map *map = bpf_object__find_map_by_name(obj, ".rodata.trace_level");
+	size_t data_size;
+	int *trace_level;
+
+	if (!map)
+		return -1;
+
+	trace_level = bpf_map__initial_value(map, &data_size);
+	if (!trace_level || data_size != sizeof(*trace_level))
+		return -1;
+
+	*trace_level = ctx->trace_types[TRACE_TYPE_EVENT];
+	return 0;
+}
+
+static int readline(char *buf, size_t size, const char *path)
+{
+	FILE *f;
+
+	f = fopen(path, "r");
+	if (!f)
+		return -errno;
+
+	if (!fgets(buf, size, f)) {
+		fclose(f);
+		return -EINVAL;
+	}
+	fclose(f);
+
+	if (!strchr(buf, '\n'))
+		return -E2BIG;
+	return 0;
+}
+
+/*
+ * get_nr_cpu_ids: Find the maximum number of CPUs
+ *
+ * The BPF programs iterate over CPUs during initialisation, the highest id + 1
+ * is a safe value in case of a sparse CPU mask.
+ * Fall back to the maximum number of CPUs.
+ *
+ * Returns nr_cpu_ids or a negative errno.
+ */
+static int get_nr_cpu_ids(void)
+{
+	char buf[4096], *comma, *dash, *sep;
+
+	if (readline(buf, sizeof(buf), CPU_POSSIBLE)) {
+		int res = readline(buf, sizeof(buf), CPU_MAX);
+
+		return res ?: strtol(buf, NULL, 10) + 1;
+	}
+
+	comma = strrchr(buf, ',');
+	dash = strrchr(buf, '-');
+	sep = dash && (!comma || dash > comma) ? dash : comma;
+
+	return strtol(sep ? sep + 1 : buf, NULL, 10) + 1;
+}
+
+/*
+ * open_bpf_monitor - open and load a BPF monitor object from a file path
+ *
+ * Returns loaded BPF object on success, NULL on error.
+ */
+static struct bpf_object *open_bpf_monitor(const char *path, struct bpf_monitor_ctx *ctx)
+{
+	struct bpf_object *obj = NULL;
+	int res, nproc = get_nr_cpu_ids();
+	char kconfig[128];
+
+	if (nproc <= 0) {
+		err_msg("bpf: error getting possible CPUs: %s\n", strerror(-nproc));
+		return NULL;
+	}
+	/* Define statically what is known, Kconfig may not be available. */
+	snprintf(kconfig, sizeof(kconfig), "CONFIG_NR_CPUS=%d\n",
+		 nproc);
+
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.object_name = ctx->monitor_name,
+		.kconfig = kconfig,
+	);
+
+	obj = bpf_object__open_file(path, &opts);
+	if (!obj) {
+		err_msg("bpf: error opening object: %s\n", strerror(errno));
+		return NULL;
+	}
+
+	res = extract_btf_info(obj, ctx);
+	if (res || bpf_enable_tracing(obj, ctx)) {
+		err_msg("bpf: failed to enable tracing\n");
+		bpf_object__close(obj);
+		return NULL;
+	}
+
+	res = bpf_object__load(obj);
+	if (res) {
+		err_msg("bpf: error loading object: %s\n", strerror(-res));
+		bpf_object__close(obj);
+		return NULL;
+	}
+
+	return obj;
+}
+
+/*
+ * attach_bpf_handlers - attach all BPF programs
+ *
+ * Attach all handler programs and store links in the provided array. Skip
+ * known non-handler programs.
+ *
+ * Returns fd of enable program on success, -1 on error.
+ */
+static int attach_bpf_handlers(const char *monitor_name, struct bpf_object *obj,
+				struct bpf_link **links, int *link_count)
+{
+	struct bpf_program *prog;
+	int enable_mon_fd = -1;
+
+	bpf_object__for_each_program(prog, obj) {
+		struct bpf_link *link = NULL;
+		const char *prog_name;
+
+		/* Special program to initialise the monitor */
+		if (!strcmp(bpf_program__name(prog), PROG_ENABLE_MON)) {
+			enable_mon_fd = bpf_program__fd(prog);
+			continue;
+		}
+
+		/* Task iterator program to initialise existing tasks */
+		if (!strcmp(bpf_program__name(prog), PROG_INIT_TASK))
+			continue;
+
+		if (*link_count >= MAX_LINKS) {
+			err_msg("bpf: too many programs to attach (%d)\n", *link_count);
+			return -1;
+		}
+
+		prog_name = bpf_program__name(prog);
+		link = bpf_program__attach(prog);
+		if (!link) {
+			err_msg("bpf: error attaching program '%s': %s\n",
+				prog_name, strerror(errno));
+			return -1;
+		}
+		links[(*link_count)++] = link;
+	}
+	if (enable_mon_fd < 0)
+		err_msg("bpf: could not find program %s\n", PROG_ENABLE_MON);
+	return enable_mon_fd;
+}
+
+/*
+ * bpf_init_tasks - initialize storage for existing tasks using task iterator
+ *
+ * Runs the task iterator program if present in the object, initializing
+ * task storage for all currently existing tasks before monitor is enabled.
+ * Silently succeed if the program is not there (not a per-task monitor).
+ *
+ * Returns 0 on success, -errno on error.
+ */
+static int bpf_init_tasks(struct bpf_object *obj)
+{
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	char buf[128];
+	int iter_fd, retval = 0;
+	ssize_t len;
+
+	prog = bpf_object__find_program_by_name(obj, PROG_INIT_TASK);
+	if (!prog)
+		return 0;
+
+	link = bpf_program__attach_iter(prog, NULL);
+	if (!link)
+		return -errno;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (iter_fd < 0) {
+		bpf_link__destroy(link);
+		return -errno;
+	}
+
+	do {
+		len = read(iter_fd, buf, sizeof(buf));
+	} while (len > 0 || (len < 0 && errno == EINTR));
+
+	retval = (len < 0) ? -errno : 0;
+
+	close(iter_fd);
+	bpf_link__destroy(link);
+
+	return retval;
+}
+
+/*
+ * bpf_validate_name - check that a monitor name is valid
+ *
+ * Avoid path separators, special directories and long names.
+ *
+ * Returns 0 if the name is valid, -1 otherwise.
+ */
+static int bpf_validate_name(const char *monitor_name)
+{
+	if (!monitor_name[0] || strlen(monitor_name) >= MAX_DA_NAME_LEN)
+		return -1;
+
+	if (strchr(monitor_name, '/'))
+		return -1;
+
+	if (!strcmp(monitor_name, ".") || !strcmp(monitor_name, ".."))
+		return -1;
+
+	return 0;
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
+	struct trace_instance inst = {0};
+	struct bpf_monitor_ctx ctx = {0};
+	struct bpf_object *obj = NULL;
+	int res, link_count = 0, enable_mon_fd, retval = -1, lock_fd = -1;
+	char monitor_path[MAX_PATH];
+
+	libbpf_set_print(libbpf_print_fn);
+	bpf_fill_base_paths();
+
+	if (bpf_validate_name(monitor_name)) {
+		err_msg("bpf: invalid monitor name: %s\n", monitor_name);
+		return -1;
+	}
+
+	if (!find_bpf_monitor(monitor_name, monitor_path, sizeof(monitor_path)))
+		return 0;
+
+	config.is_bpf = true;
+
+	/* we should be good to go */
+	res = parse_arguments(monitor_name, argc, argv);
+	if (res)
+		mon_usage(1, monitor_name, "bpf: failed parsing arguments");
+
+	lock_fd = bpf_lock_acquire(monitor_name);
+	if (lock_fd == -EAGAIN) {
+		err_msg("bpf: monitor %s (BPF) is already enabled\n", monitor_name);
+		return -1;
+	}
+	if (lock_fd < 0) {
+		err_msg("bpf: cannot lock monitor %s: %s\n",
+			monitor_name, strerror(-lock_fd));
+		return -1;
+	}
+
+	strncpy(ctx.monitor_name, monitor_name, sizeof(ctx.monitor_name) - 1);
+
+	if (config.reactor && strcmp(config.reactor, "nop")) {
+		mon_usage(1, monitor_name,
+				"bpf: failed to set %s reactor, is it available?",
+				config.reactor);
+	}
+
+	obj = open_bpf_monitor(monitor_path, &ctx);
+	if (!obj)
+		goto cleanup;
+
+	if (config.trace) {
+		if (trace_instance_setup(&inst, monitor_name))
+			goto cleanup;
+	}
+
+	enable_mon_fd = attach_bpf_handlers(monitor_name, obj, links, &link_count);
+	if (enable_mon_fd < 0)
+		goto cleanup;
+
+	res = bpf_init_tasks(obj);
+	if (res) {
+		err_msg("bpf: error initializing tasks: %s\n", strerror(-res));
+		goto cleanup;
+	}
+
+	res = bpf_prog_test_run_opts(enable_mon_fd, NULL);
+	if (res) {
+		err_msg("bpf: error enabling the monitor: %s\n", strerror(-res));
+		goto cleanup;
+	}
+
+	if (config.trace)
+		trace_print_header(inst.seq);
+
+	while (!should_stop()) {
+		if (config.trace) {
+			res = tracefs_iterate_raw_events(inst.tep,
+							 inst.inst,
+							 NULL,
+							 0,
+							 collect_registered_events,
+							 &inst);
+			if (res) {
+				err_msg("bpf: error reading trace buffer\n");
+				break;
+			}
+		}
+
+		sleep(1);
+	}
+
+	retval = 1;
+
+cleanup:
+	for (int i = 0; i < link_count; i++)
+		bpf_link__destroy(links[i]);
+
+	trace_instance_destroy(&inst);
+
+	bpf_object__close(obj);
+
+	close(lock_fd);
+
+	return retval;
+}
diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index 7c4a2e49ff9d..571c9a14c1a2 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -127,6 +127,9 @@ static void rv_mon(int argc, char **argv)
 	 */
 	run += ikm_run_monitor(monitor_name, argc-1, &argv[1]);
 
+	if (!run)
+		run += bpf_run_monitor(monitor_name, argc-1, &argv[1]);
+
 	if (!run)
 		err_msg("rv: monitor %s does not exist\n", monitor_name);
 	exit(run > 0 ? EXIT_SUCCESS : EXIT_FAILURE);
diff --git a/tools/verification/rv/src/utils.c b/tools/verification/rv/src/utils.c
index e19dd65ec789..1b1ad7a3ca32 100644
--- a/tools/verification/rv/src/utils.c
+++ b/tools/verification/rv/src/utils.c
@@ -81,7 +81,10 @@ void mon_usage(int exit_val, char *monitor_name, const char *fmt, ...)
 	for (i = 0; usage[i]; i++)
 		fprintf(stderr, "%s\n", usage[i]);
 
-	ikm_usage_print_reactors();
+	if (config.is_bpf)
+		bpf_usage_print_reactors();
+	else
+		ikm_usage_print_reactors();
 	exit(exit_val);
 }
 
@@ -132,7 +135,7 @@ int parse_arguments(char *monitor_name, int argc, char **argv)
 		}
 	}
 
-	debug_msg("ikm: my pid is %d\n", config.my_pid);
+	debug_msg("%s: my pid is %d\n", config.is_bpf ? "bpf" : "ikm", config.my_pid);
 
 	return 0;
 }
-- 
2.56.1

