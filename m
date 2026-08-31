Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94ED3D4107
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167243; cv=none; b=rmtR0qqVnDZvt2/yTo0gToVVnt49qBl7iuyaZLxLJujYUzY+nkAFh++ir8isccSyWj8ZnFSq6g9JY6nVYtXBKJgs0Ie7SIjZxC3CyiSRic3jSEdMduGKBqTk9mZgcI7iTak1GzOZm+ouTZ/nYm2rWNKCM58uZctNLKNd1xm8BG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167243; c=relaxed/simple;
	bh=yBB1fad5mlp6iWM0uARLq/gmr+NgwzM5PoiXDO2yt7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpkBKS14GCBT4a3d/DfiSJdEY4WfUG0dN4j6ACP5OixLixuEKm2/7+/m8U5Va+eSsjNIeNvvCXO3wPISzf0mW6BcOD/G1b2jNzDivAxk88t/cj1QPKmIstvlx5wfOA+69PMzWX4W3yhOgSx6P3eM9oSAFtXyH0Zz3jG9UPT0HxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K98TbhDH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K98TbhDH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhFeqRL96mpgj/YjWSZc04DIWo2rmDytfV8bt3Yl7J8=;
	b=K98TbhDHF2WOr/oLL2PThKiqen8z82AmSDuvkVO/Ssx7rMaNCEGMiq0xZqQXgUJ1GdRH8W
	gG1rWThs2acwF18Os3O1nP0SqaUzInyrMngHJiJglZUP3x/fuHSR3DaNQT8ASP30BDaWOh
	8ajF+FuqlEo09jSzsc+dXVH79QMb9Ok=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-DAbWaGCWNIKMBEIyzKPUQg-1; Mon,
 31 Aug 2026 05:07:17 -0400
X-MC-Unique: DAbWaGCWNIKMBEIyzKPUQg-1
X-Mimecast-MFC-AGG-ID: DAbWaGCWNIKMBEIyzKPUQg_1788167235
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C887B1944D30;
	Mon, 31 Aug 2026 09:07:15 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4C46180034F;
	Mon, 31 Aug 2026 09:07:12 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 05/20] rv: Add in-kernel support for BPF monitors
Date: Mon, 31 Aug 2026 11:05:09 +0200
Message-ID: <20260831090524.106845-6-gmonaco@redhat.com>
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

Add support for BPF monitors via the struct_ops mechanism, which allows
BPF monitors to be loaded and appear almost like in-kernel modules.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/Kconfig  |  10 ++++
 kernel/trace/rv/Makefile |   1 +
 kernel/trace/rv/rv_bpf.c | 118 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 kernel/trace/rv/rv_bpf.c

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index efa930f94ea4..be11e5c85a60 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -126,3 +126,13 @@ config RV_MONITORS_KUNIT_TEST
 	  unrelated KUnit test is running.
 
 	  If unsure, say N.
+
+config RV_MON_BPF_STRUCT_OPS
+	bool "BPF struct_ops support for RV monitors"
+	depends on RV && BPF_SYSCALL && BPF_JIT
+	help
+	  Enable BPF programs to register as Runtime Verification monitors
+	  using the BPF struct_ops mechanism. This allows BPF monitors to
+	  be managed through the standard RV interface in sysfs alongside
+	  kernel monitors.
+	  It has no performance impact if not used.
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index cdbf68c84f5a..635461395cba 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
 obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) += rv_monitors_test.o
+obj-$(CONFIG_RV_MON_BPF_STRUCT_OPS) += rv_bpf.o
diff --git a/kernel/trace/rv/rv_bpf.c b/kernel/trace/rv/rv_bpf.c
new file mode 100644
index 000000000000..0450bcaf1b79
--- /dev/null
+++ b/kernel/trace/rv/rv_bpf.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF struct_ops support for Runtime Verification monitors
+ *
+ * Allows BPF programs to register as RV monitors via struct_ops.
+ * BPF monitors appear in /sys/kernel/tracing/rv/ alongside kernel monitors.
+ *
+ * Copyright (C) 2026-2029 Red Hat, Inc. Gabriele Monaco <gmonaco@redhat.com>
+ */
+
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+#include <linux/rv.h>
+
+static int bpf_rv_monitor_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int bpf_rv_monitor_init_member(const struct btf_type *t,
+				      const struct btf_member *member,
+				      void *kdata, const void *udata)
+{
+	const struct rv_monitor *umon = udata;
+	struct rv_monitor *kmon = kdata;
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+	int ret;
+
+	switch (moff) {
+	case offsetof(struct rv_monitor, name):
+		ret = bpf_obj_name_cpy(kmon->name, umon->name,
+				       sizeof(kmon->name));
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			return -EINVAL;
+		return 1;
+	case offsetof(struct rv_monitor, description):
+		ret = strscpy(kmon->description, umon->description);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
+			return -EINVAL;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int bpf_rv_monitor_reg(void *kdata, struct bpf_link *link)
+{
+	struct rv_monitor *mon = kdata;
+
+	pr_info("rv: Registering BPF monitor %s\n", mon->name);
+	return rv_register_monitor(mon, NULL);
+}
+
+static void bpf_rv_monitor_unreg(void *kdata, struct bpf_link *link)
+{
+	struct rv_monitor *mon = kdata;
+
+	pr_info("rv: Unregistering BPF monitor %s\n", mon->name);
+	rv_unregister_monitor(mon);
+}
+
+static int bpf_rv_monitor_validate(void *kdata)
+{
+	struct rv_monitor *mon = kdata;
+
+	if (!mon->enable)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct bpf_verifier_ops bpf_rv_monitor_verifier_ops = {
+	.get_func_proto = bpf_base_func_proto,
+	.is_valid_access = NULL,
+};
+
+static int rv_ops__mon_enable(void)
+{
+	return 0;
+}
+
+static void rv_ops__mon_disable(void) { }
+
+static void rv_ops__mon_reset(void) { }
+
+static struct rv_monitor __bpf_ops_rv_monitor = {
+	.name = "rv_monitor",
+	.description = "stub BPF monitor.",
+	.enable = rv_ops__mon_enable,
+	.disable = rv_ops__mon_disable,
+	.reset = rv_ops__mon_reset,
+	.enabled = 0,
+};
+
+static struct bpf_struct_ops bpf_rv_monitor_ops = {
+	.verifier_ops = &bpf_rv_monitor_verifier_ops,
+	.init = bpf_rv_monitor_init,
+	.init_member = bpf_rv_monitor_init_member,
+	.reg = bpf_rv_monitor_reg,
+	.unreg = bpf_rv_monitor_unreg,
+	.validate = bpf_rv_monitor_validate,
+	.name = "rv_monitor",
+	.cfi_stubs = &__bpf_ops_rv_monitor,
+	.owner = THIS_MODULE,
+};
+
+static int __init bpf_rv_monitor_init_ops(void)
+{
+	return register_bpf_struct_ops(&bpf_rv_monitor_ops, rv_monitor);
+}
+late_initcall(bpf_rv_monitor_init_ops);
-- 
2.55.0

