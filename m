Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36273FA5DE
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252502; cv=none; b=C5BNYj5P5Iz6q6RYcc7lX/jUn8OSz0Um3msTQFuC0l4jcsenkFGnIc2PxMEmqExugNyBRHF3Wjw/v6Fu60kSGCdncLyp2xiFS9Q5fBv4Rh3L69lV33eKg6ubfU+3nsXnEaVQomQm1EJ8PXlqoz6wGHR8V10SYZCb7dgdi4mcrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252502; c=relaxed/simple;
	bh=3d/Fyjd46ZVO2gRY09JC7UlwzifghFjy4ul4H0Kss9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chd8D48gNaH4YjxEVqrTkCMZUuOHmnZBk1xNdK3/jVba0kkDL6t6tf13tHFF6L/9n5RhFQAVXOhb7wtEtELk+iiZLGGgWNhHTw1ENSS9MsqWNUSXMfeRm7RYb6qZkDf+vFwnl57jtwUAVUxt/iIBUmUolBn+LG3JYRyOixQQBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJZHPn+3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJZHPn+3"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso1056205b3a.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252500; x=1778857300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsLW/tTbgLTFufuJHQiQcJEA4R3DBVkdsJ0iG5BPYaY=;
        b=SJZHPn+3WU33MM+Ov+qrPF2bY1aFl/gaUrBvJIa0BBNX6s01pgWJropr+kDA2+fMXj
         VbORGibVMnXqZai7a3M5GLTVqnNDSF6BFIu6Q1akuDb5G434mQJzWqigL3nBMtQHttNT
         yPgm5yFFcI59cFCnCXpBXdL8X/qeBtmXOuMVdW12asPcQZ+O0niB6o1o2VeFs96Er2JR
         l4NMiA8cHJGDHaZ3l7DzteLXX0R5fc1wVikiPDhQxaKgtRzqQfI2G3LffAvxPtCIxRRx
         SS3W8bjUjfSdkSpDs1Ha4J/aFNlbnxceNjKjiFutJ+T9A80KTkgy1ArCxeNGC7NHHywC
         nrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252500; x=1778857300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hsLW/tTbgLTFufuJHQiQcJEA4R3DBVkdsJ0iG5BPYaY=;
        b=U8DumvMjVRTZps0WbqI5U5Ly+t5WaKNldH0w8baByx7Df5vRgIX3ZFGygUpG6z0k1f
         Dhfxkpq1qf9cA8edsCPqMynC2gKkqdb8AdBeRoO2swhQVJtQYzgl52fTZt9vtexTEX0k
         hoAYSh2QhESL+9s6GQ6/TqmcBu4u4daMYh4/EiHv+XJdyn03cderLojRP64VfyI55SoD
         gbNAzLc33vJmmAUI7ebfCdwvC3sWBUcviVFXAjTJU2SJ+afuD8Zpr6qplH/9pUYnqr6Z
         WQ208ICroPIiS2bU/ndq+IAfrIjp2TmW2FP480LgNl8hmRCyLeWH1gKq7tgkXQ0+2nsF
         Bx4g==
X-Forwarded-Encrypted: i=1; AFNElJ9m9Mo7BR14vBy2hAvb+FlTjeUJXELrfG4BI5Aem70hD/jLVj3Rqdy00h7ioVFMDeYWdgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/yP09+sgGy7Dt0dYnetiwjyae0eZQ+xkBc2TMw4g1J7RRL0wl
	GF2nnQTQj6IVPR1YZkkj1n9mh3OYxV6n8GlxmQz/DDjvzECbIuNJgz8C
X-Gm-Gg: Acq92OEn6fJw/2vv5H7vBEozk5rAuTn6Hb/zsLUN7OrBWAyUUUGI+sycQDKHzEgWtHp
	bQu0tw0ge9prl85HxdMjw9KHrNU8m+qorCiU5v5j3vkQwTklhUQasn3PPTUsDwvSupRegkRQsRD
	S64qL8lUbBY2EVMyYcaJJGMXT9+TmnIncOjB6rzyoyDjt9jw4hSaONHyRHaWzpKsZczSh/2LXKI
	J/6EK7Emo9OFIqAdyyY2DnrPfi94KaLgSxoxhmfik7aqHlGCtb3FoMZTxFB5h7BV/UmgAbBwWGU
	x+kQpQyUhAxgn34exv5wcme0/AVNB4Ym6QQfJpnaKGSv/82ZAsJSC6KHDG6Q9xHBEwTx36gEjuZ
	eNIPDYfv16hNT+4xdCPimPNULYyP67d4AzjVKBu7ce6yZoLJiAXWvxklPN/mMHI2eHdyLIQiNKB
	uaZUnNqwvVy2Tsk0BUvI3Fy29zpXHgNNcdhGL/
X-Received: by 2002:a05:6a00:e05:b0:835:3861:812c with SMTP id d2e1a72fcca58-83bb82a196bmr6454088b3a.23.1778252499764;
        Fri, 08 May 2026 08:01:39 -0700 (PDT)
Received: from localhost.localdomain ([114.231.84.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965945c1bsm13110064b3a.15.2026.05.08.08.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:01:39 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	roman.gushchin@linux.dev,
	inwardvessel@gmail.com,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	surenb@google.com
Cc: tz2294@columbia.edu,
	baohua@kernel.org,
	lance.yang@linux.dev,
	dev.jain@arm.com,
	laoar.shao@gmail.com,
	gutierrez.asier@huawei-partners.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH v2 4/4] samples: bpf: add mthp_ext
Date: Fri,  8 May 2026 23:00:55 +0800
Message-ID: <20260508150055.680136-5-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508150055.680136-1-vernon2gm@gmail.com>
References: <20260508150055.680136-1-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

Design mthp_ext case to address real workload issues.

The main functions of the mthp_ext are as follows:

- When sub-cgroup is under high memory pressure (default, full 100ms 1s),
  it will automatically fallback to using 4KB.
- When the anon+shmem memory usage of sub-cgroup falls below the minimum
  memory (default 16MB), small-memory processes will automatically
  fallback to using 4KB.
- Under normal conditions, when there is no memory pressure and the
  anon+shmem memory usage exceeds the minimum memory, all mTHP sizes
  shall be utilized by kernel.
- Monitor the root-cgroup (/sys/fs/cgroup) directory by default, with
  support for specifying any cgroup directory.

Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 samples/bpf/.gitignore     |   1 +
 samples/bpf/Makefile       |   7 +-
 samples/bpf/mthp_ext.bpf.c | 148 ++++++++++++++++
 samples/bpf/mthp_ext.c     | 339 +++++++++++++++++++++++++++++++++++++
 samples/bpf/mthp_ext.h     |  30 ++++
 5 files changed, 524 insertions(+), 1 deletion(-)
 create mode 100644 samples/bpf/mthp_ext.bpf.c
 create mode 100644 samples/bpf/mthp_ext.c
 create mode 100644 samples/bpf/mthp_ext.h

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index 0002cd359fb1..2a73581876b4 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -49,3 +49,4 @@ iperf.*
 /vmlinux.h
 /bpftool/
 /libbpf/
+mthp_ext
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 95a4fa1f1e44..357c7d1c45ef 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -37,6 +37,7 @@ tprogs-y += xdp_fwd
 tprogs-y += task_fd_query
 tprogs-y += ibumad
 tprogs-y += hbm
+tprogs-y += mthp_ext
 
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
@@ -122,6 +123,7 @@ always-y += task_fd_query_kern.o
 always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
+always-y += mthp_ext.bpf.o
 
 COMMON_CFLAGS = $(TPROGS_USER_CFLAGS)
 TPROGS_LDFLAGS = $(TPROGS_USER_LDFLAGS)
@@ -289,6 +291,8 @@ $(obj)/hbm_out_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 $(obj)/hbm.o: $(src)/hbm.h
 $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 
+mthp_ext: $(obj)/mthp_ext.skel.h
+
 # Override includes for xdp_sample_user.o because $(srctree)/usr/include in
 # TPROGS_CFLAGS causes conflicts
 XDP_SAMPLE_CFLAGS += -Wall -O2 \
@@ -347,10 +351,11 @@ $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h $(src)/x
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-c $(filter %.bpf.c,$^) -o $@
 
-LINKED_SKELS := xdp_router_ipv4.skel.h
+LINKED_SKELS := xdp_router_ipv4.skel.h mthp_ext.skel.h
 clean-files += $(LINKED_SKELS)
 
 xdp_router_ipv4.skel.h-deps := xdp_router_ipv4.bpf.o xdp_sample.bpf.o
+mthp_ext.skel.h-deps := mthp_ext.bpf.o
 
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/samples/bpf/mthp_ext.bpf.c b/samples/bpf/mthp_ext.bpf.c
new file mode 100644
index 000000000000..3524dc45fda4
--- /dev/null
+++ b/samples/bpf/mthp_ext.bpf.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include "mthp_ext.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <vdso/bits.h>
+
+struct mem_info {
+	unsigned long long stall;
+	unsigned int order;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct mem_info);
+} cgrp_storage SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 256 * 1024);
+} events SEC(".maps");
+
+struct config_local configs;
+
+/*
+ * mthp_choose_impl - Choose the custom mTHP orders, read order from cgrp_storage,
+ *		      which is Adjustment by the cgroup_scan().
+ * @cgrp: control group
+ * @orders: original orders
+ *
+ * Return suited mTHP orders.
+ */
+SEC("struct_ops/mthp_choose")
+unsigned long BPF_PROG(mthp_choose_impl, struct cgroup *cgrp, unsigned long orders)
+{
+	struct mem_info *info;
+	unsigned int order;
+
+	if (configs.fixed) {
+		order = configs.init_order;
+		goto out;
+	}
+
+	info = bpf_cgrp_storage_get(&cgrp_storage, cgrp, 0, 0);
+	if (!info)
+		return orders;
+
+	order = info->order;
+out:
+	if (!order)
+		return 0;
+
+	orders &= BIT(order + 1) - 1;
+	return orders;
+}
+
+SEC(".struct_ops.link")
+struct bpf_mthp_ops mthp_ops = {
+	.mthp_choose = (void *)mthp_choose_impl,
+};
+
+/* backport from kernel/cgroup/cgroup.c */
+static bool cgroup_has_tasks(struct cgroup *cgrp)
+{
+	return cgrp->nr_populated_csets;
+}
+
+/*
+ * cgroup_scan - scan all descendant cgroups under root cgroup.
+ *
+ * 1. When the memory usage of the sub-cgroup falls below the <min> threshold,
+ *    it will automatically fall back to using 4KB size; otherwise, it will
+ *    use all mTHP sizes.
+ * 2. When memory.pressure stall time of the sub-cgroup exceeds <threshold>,
+ *    it will automatically fall back to using 4KB size; otherwise, it will
+ *    use all mTHP sizes.
+ *
+ * Return 1 indicates termination of the iteration loop, and return 0 indicates
+ * iteration to the next sub-cgroup.
+ */
+SEC("iter.s/cgroup")
+int cgroup_scan(struct bpf_iter__cgroup *ctx)
+{
+	struct cgroup *cgrp = ctx->cgroup;
+	struct mem_cgroup *memcg;
+	struct mem_info *info;
+	struct alert_event *e;
+	unsigned long curr_mem;
+	unsigned long long curr_stall;
+	unsigned long long delta;
+
+	if (!cgrp)
+		return 1;
+
+	if (!cgroup_has_tasks(cgrp))
+		return 0;
+
+	info = bpf_cgrp_storage_get(&cgrp_storage, cgrp, 0,
+				    BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!info)
+		return 0;
+
+	memcg = bpf_get_mem_cgroup(&cgrp->self);
+	if (!memcg)
+		return 0;
+
+	bpf_cgroup_flush_stats(cgrp);
+	curr_stall = bpf_cgroup_stall(cgrp, PSI_MEM_FULL);
+	if (!info->stall) {
+		info->order = configs.init_order;
+		goto UPDATE;
+	}
+	delta = curr_stall - info->stall;
+	bpf_mem_cgroup_flush_stats(memcg);
+	curr_mem = bpf_mem_cgroup_page_state(memcg, NR_ANON_MAPPED) +
+		   bpf_mem_cgroup_page_state(memcg, NR_SHMEM);
+	if ((curr_mem && curr_mem < FROM_MB(configs.min_mem)) ||
+	     delta >= configs.threshold)
+		info->order = 0;
+	else
+		info->order = PMD_ORDER;
+
+	if (configs.debug) {
+		e = bpf_ringbuf_reserve(&events, sizeof(*e), 0);
+		if (e) {
+			e->prev_stall = info->stall;
+			e->curr_stall = curr_stall;
+			e->delta = delta;
+			e->mem = curr_mem;
+			e->order = info->order;
+			bpf_probe_read_kernel_str(e->name, sizeof(e->name),
+						  cgrp->kn->name);
+			bpf_ringbuf_submit(e, 0);
+		}
+	}
+
+UPDATE:
+	info->stall = curr_stall;
+	bpf_put_mem_cgroup(memcg);
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/samples/bpf/mthp_ext.c b/samples/bpf/mthp_ext.c
new file mode 100644
index 000000000000..120c331ff26a
--- /dev/null
+++ b/samples/bpf/mthp_ext.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <signal.h>
+#include <time.h>
+#include <stdbool.h>
+#include <getopt.h>
+#include <sys/epoll.h>
+#include <sys/stat.h>
+#include <linux/limits.h>
+#include <linux/bpf.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include "mthp_ext.h"
+#include "mthp_ext.skel.h"
+
+#define DEFAULT_ROOT		"/sys/fs/cgroup"
+#define DEFAULT_THRESHOLD_MS	100UL
+#define DEFAULT_INTERVAL_MS	1000UL
+#define DEFAULT_ORDER		PMD_ORDER
+#define DEFAULT_MIN_MEM		16
+
+static bool exiting;
+
+static void usage(const char *name)
+{
+	fprintf(stderr,
+		"Usage: %s [OPTIONS]\n\n"
+		"Monitor specified cgroup, adjust mTHP size via cgroup_bpf.\n\n"
+		"Currently supports fixed mTHP size and automatic mTHP size adjustment.\n"
+		"By default, it monitors the entire cgroup and automatically\n"
+		"adjusts mTHP size within the specified time window <interval>.\n"
+		"1. When the memory size of the sub-cgroup falls below\n"
+		"   the <min> threshold, it will automatically fall back to\n"
+		"   using 4KB size; otherwise, it will use all mTHP sizes.\n"
+		"2. When memory.pressure stall time of the sub-cgroup exceeds\n"
+		"   <threshold>, it will automatically fall back to using 4KB\n"
+		"   size; otherwise, it will use all mTHP sizes.\n\n"
+		"Options:\n"
+		"  -r, --root=PATH        Root cgroup path (default: /sys/fs/cgroup)\n"
+		"  -t, --threshold=MS     threshold in ms (default: %lu)\n"
+		"  -i, --interval=MS      interval in ms (default: %lu)\n"
+		"  -o, --order=NR         Initial mthp order (default: %d)\n"
+		"  -m, --min=MB           Minimum memory size for mTHP (default: %d)\n"
+		"  -f, --fixed            Use fixed order, disable auto-adjustment\n"
+		"  -d, --debug            Enable debug output\n"
+		"  -h, --help             Show this help\n",
+		name, DEFAULT_THRESHOLD_MS, DEFAULT_INTERVAL_MS, DEFAULT_ORDER,
+		DEFAULT_MIN_MEM);
+}
+
+static void sig_handler(int sig)
+{
+	exiting = true;
+}
+
+static int setup_psi_trigger(const char *cgroup_path, const char *type,
+			     unsigned long stall_us, unsigned long window_us)
+{
+	char path[PATH_MAX];
+	char trigger[128];
+	int fd, nr;
+
+	snprintf(path, sizeof(path), "%s/memory.pressure", cgroup_path);
+	fd = open(path, O_RDWR | O_NONBLOCK);
+	if (fd < 0) {
+		fprintf(stderr, "ERROR: open PSI file failed\n");
+		return -errno;
+	}
+
+	nr = snprintf(trigger, sizeof(trigger), "%s %lu %lu",
+		      type, stall_us, window_us);
+	if (write(fd, trigger, nr) < 0) {
+		fprintf(stderr, "ERROR: write PSI trigger failed\n");
+		close(fd);
+		return -errno;
+	}
+
+	return fd;
+}
+
+static int trigger_scan(struct bpf_link *iter_link)
+{
+	char buf[256];
+	int fd;
+
+	fd = bpf_iter_create(bpf_link__fd(iter_link));
+	if (fd < 0) {
+		fprintf(stderr, "ERROR: bpf_iter_create failed: %s\n",
+			strerror(errno));
+		return -1;
+	}
+
+	/* Read to trigger the iter program execution */
+	while (read(fd, buf, sizeof(buf)) > 0)
+		;
+
+	close(fd);
+	return 0;
+}
+
+static void *monitor_thread(int psi_fd, struct config_local *configs,
+		struct bpf_link *iter_link, struct ring_buffer *rb)
+{
+	struct epoll_event e;
+	int epoll_fd;
+	int nfds;
+
+	epoll_fd = epoll_create1(0);
+	if (epoll_fd < 0) {
+		fprintf(stderr, "ERROR: epoll_create1 failed\n");
+		return NULL;
+	}
+
+	e.events = EPOLLPRI;
+	e.data.fd = psi_fd;
+	if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, psi_fd, &e)) {
+		fprintf(stderr, "ERROR: epoll_ctl failed\n");
+		goto CLOSE;
+	}
+
+	/* First initialization */
+	trigger_scan(iter_link);
+
+	/* Auto adjustment */
+	while (!exiting) {
+		nfds = epoll_wait(epoll_fd, &e, 1, configs->interval * 2);
+		trigger_scan(iter_link);
+
+		if (configs->debug) {
+			printf("PSI: memory pressure %s\n", nfds ? "high" : "low");
+			ring_buffer__poll(rb, 0);
+		}
+	}
+
+CLOSE:
+	close(epoll_fd);
+	return NULL;
+}
+
+static int handle_event(void *ctx, void *data, size_t len)
+{
+	struct alert_event *e = data;
+
+	printf("cgroup %s: stall %llu -> %llu (+%llu), mem %luMB, mthp order=%d\n",
+		e->name[0] ? e->name : "/",
+		e->prev_stall, e->curr_stall, e->delta, TO_MB(e->mem), e->order);
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	const char *root_path = DEFAULT_ROOT;
+	unsigned long threshold = DEFAULT_THRESHOLD_MS;
+	unsigned long interval = DEFAULT_INTERVAL_MS;
+	unsigned int init_order = DEFAULT_ORDER;
+	unsigned int min_mem = DEFAULT_MIN_MEM;
+	bool fixed = false;
+	bool debug = false;
+	struct mthp_ext *skel;
+	struct bpf_link *iter_link;
+	struct bpf_link *ops_link;
+	struct ring_buffer *rb;
+	int root_fd;
+	int psi_fd;
+	int err = 0;
+	int opt;
+
+	static struct option long_options[] = {
+		{"root",       required_argument, 0, 'r'},
+		{"threshold",  required_argument, 0, 't'},
+		{"interval",   required_argument, 0, 'i'},
+		{"order",      required_argument, 0, 'o'},
+		{"min",        required_argument, 0, 'm'},
+		{"fixed",      no_argument,       0, 'f'},
+		{"debug",      no_argument,       0, 'd'},
+		{"help",       no_argument,       0, 'h'},
+		{0, 0, 0, 0}
+	};
+
+	while ((opt = getopt_long(argc, argv, "r:t:i:o:m:fdh",
+				  long_options, NULL)) != -1) {
+		switch (opt) {
+		case 'r':
+			root_path = optarg;
+			break;
+		case 't':
+			threshold = strtoul(optarg, NULL, 10);
+			break;
+		case 'i':
+			interval = strtoul(optarg, NULL, 10);
+			break;
+		case 'o':
+			init_order = min(strtoul(optarg, NULL, 10), PMD_ORDER);
+			break;
+		case 'm':
+			min_mem = strtoul(optarg, NULL, 10);
+			break;
+		case 'f':
+			fixed = true;
+			break;
+		case 'd':
+			debug = true;
+			break;
+		case 'h':
+			usage(argv[0]);
+			return 0;
+		default:
+			usage(argv[0]);
+			return -EINVAL;
+		}
+	}
+
+	if (!threshold || !interval) {
+		fprintf(stderr, "ERROR: threshold and interval must be > 0\n");
+		usage(argv[0]);
+		return -EINVAL;
+	}
+
+	signal(SIGINT, sig_handler);
+	signal(SIGTERM, sig_handler);
+
+	root_fd = open(root_path, O_RDONLY);
+	if (root_fd < 0) {
+		fprintf(stderr, "ERROR: open '%s' failed: %s\n",
+			root_path, strerror(errno));
+		return -errno;
+	}
+
+	skel = mthp_ext__open();
+	if (!skel) {
+		fprintf(stderr, "ERROR: failed to open BPF skeleton\n");
+		err = -ENOMEM;
+		goto open_skel_fail;
+	}
+
+	skel->bss->configs.threshold = threshold;
+	skel->bss->configs.interval = interval;
+	skel->bss->configs.init_order = init_order;
+	skel->bss->configs.min_mem = min_mem;
+	skel->bss->configs.fixed = fixed;
+	skel->bss->configs.debug = debug;
+
+	err = mthp_ext__load(skel);
+	if (err) {
+		fprintf(stderr, "ERROR: failed to load BPF program: %d\n", err);
+		goto load_skel_fail;
+	}
+
+	/* Attach struct_ops to root cgroup for mthp_choose */
+	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
+	opts.flags = BPF_F_CGROUP_FD;
+	opts.target_fd = root_fd;
+	ops_link = bpf_map__attach_struct_ops_opts(skel->maps.mthp_ops, &opts);
+	err = libbpf_get_error(ops_link);
+	if (err) {
+		fprintf(stderr, "ERROR: attach struct_ops failed: %d\n", err);
+		ops_link = NULL;
+		goto attach_opts_fail;
+	}
+
+	printf("Monitoring         : %s\n"
+	       "threshold          : %lums\n"
+	       "Interval           : %lums\n"
+	       "Initial order      : %d%s\n"
+	       "min memory         : %dMB\n"
+	       "Debug              : %s\n"
+	       "Press Ctrl+C to exit.\n\n",
+	       root_path, threshold, interval, init_order,
+	       fixed ? " (fixed)" : " (auto)", min_mem,
+	       debug ? "on" : "off");
+
+	if (fixed) {
+		while (!exiting)
+			usleep(interval * 1000);
+		goto exit_fixed;
+	}
+
+	/* Auto adjustment, attach cgroup iter for scanning root + descendants */
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, iter_opts);
+	union bpf_iter_link_info linfo = {
+		.cgroup.cgroup_fd = root_fd,
+		.cgroup.order = BPF_CGROUP_ITER_DESCENDANTS_PRE,
+	};
+	iter_opts.link_info = &linfo;
+	iter_opts.link_info_len = sizeof(linfo);
+	iter_link = bpf_program__attach_iter(skel->progs.cgroup_scan, &iter_opts);
+	err = libbpf_get_error(iter_link);
+	if (err) {
+		fprintf(stderr, "ERROR: attach cgroup iter failed: %d\n", err);
+		iter_link = NULL;
+		goto attach_iter_fail;
+	}
+
+	/* Set up ring buffer for receiving alerts */
+	rb = ring_buffer__new(bpf_map__fd(skel->maps.events),
+			      handle_event, NULL, NULL);
+	if (!rb) {
+		fprintf(stderr, "ERROR: failed to create ring buffer\n");
+		err = -ENOMEM;
+		goto rb_fail;
+	}
+
+
+	psi_fd = setup_psi_trigger(root_path, "some", threshold * 1000,
+				   interval * 1000);
+	if (psi_fd < 0) {
+		fprintf(stderr, "ERROR: PSI trigger setup failed\n");
+		err = -EINVAL;
+		goto psi_setup_fail;
+	}
+
+	monitor_thread(psi_fd, &skel->bss->configs, iter_link, rb);
+
+	close(psi_fd);
+psi_setup_fail:
+	ring_buffer__free(rb);
+rb_fail:
+	bpf_link__destroy(iter_link);
+exit_fixed:
+attach_iter_fail:
+	bpf_link__destroy(ops_link);
+attach_opts_fail:
+load_skel_fail:
+	mthp_ext__destroy(skel);
+open_skel_fail:
+	close(root_fd);
+
+	printf("\nExiting...\n");
+
+	return err;
+}
diff --git a/samples/bpf/mthp_ext.h b/samples/bpf/mthp_ext.h
new file mode 100644
index 000000000000..e29d80aa15bf
--- /dev/null
+++ b/samples/bpf/mthp_ext.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __MTHP_EXT_H__
+#define __MTHP_EXT_H__
+
+#define CGROUP_NAME_LEN 128
+#define PMD_ORDER	9
+#define min(a, b)	((a) < (b) ? a : b)
+#define FROM_MB(s)	(s * 1024UL * 1024UL)
+#define TO_MB(s)	(s / 1024UL / 1024UL)
+
+struct config_local {
+	unsigned long threshold;
+	unsigned long interval;
+	unsigned int  init_order;
+	unsigned int  min_mem;
+	bool fixed;
+	bool debug;
+};
+
+struct alert_event {
+	unsigned long long prev_stall;
+	unsigned long long curr_stall;
+	unsigned long long delta;
+	unsigned long mem;
+	unsigned int  order;
+	char name[CGROUP_NAME_LEN];
+};
+
+#endif /* __MTHP_EXT_H__ */
-- 
2.53.0

