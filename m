Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA03E4510
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167306; cv=none; b=c3HZRYOCSHas+2sqBCozHaR4QA9mf9N5ob2QRYuVw5MhvY0aQtpP/i9PA/uZr/fvpjE/U//LziqETmz6HTaoT4N+3QxYtk7LduS1a1iJHOHb6OQHGefacw5WnFmzw+qbVNnKe5V+xueqSkxQvVtqztxeziBjuHtaQwi87tUP4UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167306; c=relaxed/simple;
	bh=07G9mbWUZANCVxFbifnelQ/MS9URdMr6lWuIx/p3RwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQCnhQy3IXqJ78qlftTyhKrcvcU38m3dWO0lfUgeFkHRaHqkQpWbawWFXCD36eb+s2ASIJLp+lf0s4RUjD04/iPD+zHlLJSFMTAA8BM8rt7Xn96hNLgOVLBjL+5EathtHWGTm05Gco2Hr/wGU7L459RFTLd2WWZ/kMsIDRcSSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0gq5rXC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0gq5rXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZqEJDnBRZEwxmWnx5FvxUNAzxzmaxFYz8vRpvX4T0E=;
	b=R0gq5rXCgKmw93NLtQYMiTL7CT4HO3XKUPMWY08aHel4cc/7NaJ/16kxPPpRv5weKAan3d
	XHUEMT6F9xHCqe3y/thZhj/Gr6Fs39XChiwYQMT0KDJXoy/JPDn7xBY/K7PRzGYs7/7D7J
	IZUEPdyvBmBM0SqsG0P2cCT2ABy9GD0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-mnOYfhuoMCa0Prfhzlo2Hw-1; Mon,
 31 Aug 2026 05:08:21 -0400
X-MC-Unique: mnOYfhuoMCa0Prfhzlo2Hw-1
X-Mimecast-MFC-AGG-ID: mnOYfhuoMCa0Prfhzlo2Hw_1788167300
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29C491944D41;
	Mon, 31 Aug 2026 09:08:20 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 298B2180034F;
	Mon, 31 Aug 2026 09:08:16 +0000 (UTC)
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
Subject: [RFC PATCH 20/20] verification/rvgen: Add selftest for rvgen -b
Date: Mon, 31 Aug 2026 11:05:24 +0200
Message-ID: <20260831090524.106845-21-gmonaco@redhat.com>
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

Add selftest cases for BPF monitors generation.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 .../tests/golden/da_bpf_cpu/da_bpf_cpu.c      | 40 ++++++++++++++
 .../tests/golden/da_bpf_cpu/da_bpf_cpu.h      | 47 ++++++++++++++++
 .../tests/golden/da_bpf_obj/da_bpf_obj.c      | 54 +++++++++++++++++++
 .../tests/golden/da_bpf_obj/da_bpf_obj.h      | 47 ++++++++++++++++
 .../verification/rvgen/tests/rvgen_monitor.t  | 11 ++++
 5 files changed, 199 insertions(+)
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h

diff --git a/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c b/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c
new file mode 100644
index 000000000000..37659b2ebce2
--- /dev/null
+++ b/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#define RV_MON_TYPE RV_MON_PER_CPU
+#include "da_bpf_cpu.h"
+#include <rv/da_monitor.h>
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ */
+SEC(/* XXX: tracepoint or other probe */)
+int BPF_PROG(handle_event_1, /* XXX: fill header */)
+{
+	da_handle_event(event_1_da_bpf_cpu);
+	return 0;
+}
+
+SEC(/* XXX: tracepoint or other probe */)
+int BPF_PROG(handle_event_2, /* XXX: fill header */)
+{
+	/* XXX: validate that this event always leads to the initial state */
+	da_handle_start_event(event_2_da_bpf_cpu);
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct rv_monitor rv_da_bpf_cpu_kern = {
+	.name = "da_bpf_cpu",
+	.description = "auto-generated",
+	.enable = da_monitor_enable_bpf,
+	.disable = da_monitor_disable_bpf,
+	.reset = da_monitor_reset_bpf,
+	.enabled = 0,
+};
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h b/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h
new file mode 100644
index 000000000000..fd8125118d81
--- /dev/null
+++ b/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of da_bpf_cpu automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME da_bpf_cpu
+
+enum states_da_bpf_cpu {
+	state_a_da_bpf_cpu,
+	state_b_da_bpf_cpu,
+	state_max_da_bpf_cpu,
+};
+
+#define INVALID_STATE state_max_da_bpf_cpu
+
+enum events_da_bpf_cpu {
+	event_1_da_bpf_cpu,
+	event_2_da_bpf_cpu,
+	event_max_da_bpf_cpu,
+};
+
+struct automaton_da_bpf_cpu {
+	char state_names[state_max_da_bpf_cpu][32];
+	char event_names[event_max_da_bpf_cpu][32];
+	unsigned char function[state_max_da_bpf_cpu][event_max_da_bpf_cpu];
+	unsigned char initial_state;
+	bool final_states[state_max_da_bpf_cpu];
+};
+
+static const struct automaton_da_bpf_cpu automaton_da_bpf_cpu = {
+	.state_names = {
+		"state_a",
+		"state_b",
+	},
+	.event_names = {
+		"event_1",
+		"event_2",
+	},
+	.function = {
+		{       state_b_da_bpf_cpu,       state_a_da_bpf_cpu },
+		{            INVALID_STATE,       state_a_da_bpf_cpu },
+	},
+	.initial_state = state_a_da_bpf_cpu,
+	.final_states = { 1, 0 },
+};
diff --git a/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.c b/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.c
new file mode 100644
index 000000000000..bbd46615a1a5
--- /dev/null
+++ b/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#define RV_MON_TYPE RV_MON_PER_OBJ
+typedef /* XXX: define the target type */ *monitor_target_bpf;
+#include "da_bpf_obj.h"
+#include <rv/da_monitor.h>
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ */
+SEC(/* XXX: tracepoint or other probe */)
+int BPF_PROG(handle_event_1, /* XXX: fill header */)
+{
+	int id = /* XXX: how do I get the id? */;
+	monitor_target_bpf t = /* XXX: how do I get t? */;
+	da_handle_event(id, t, event_1_da_bpf_obj);
+	return 0;
+}
+
+SEC(/* XXX: tracepoint or other probe */)
+int BPF_PROG(handle_event_2, /* XXX: fill header */)
+{
+	/* XXX: validate that this event always leads to the initial state */
+	int id = /* XXX: how do I get the id? */;
+	monitor_target_bpf t = /* XXX: how do I get t? */;
+	da_handle_start_event(id, t, event_2_da_bpf_obj);
+	return 0;
+}
+
+/* XXX: obj is being destroyed, remove if not required (e.g. obj is static) */
+SEC(/* XXX: tracepoint or other probe */)
+int BPF_PROG(handle_obj_cleanup, /* XXX: fill header */)
+{
+	int id = /* XXX: how do I get the id? */;
+	da_destroy_storage(id);
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct rv_monitor rv_da_bpf_obj_kern = {
+	.name = "da_bpf_obj",
+	.description = "auto-generated",
+	.enable = da_monitor_enable_bpf,
+	.disable = da_monitor_disable_bpf,
+	.reset = da_monitor_reset_bpf,
+	.enabled = 0,
+};
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h b/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h
new file mode 100644
index 000000000000..385006098049
--- /dev/null
+++ b/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of da_bpf_obj automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME da_bpf_obj
+
+enum states_da_bpf_obj {
+	state_a_da_bpf_obj,
+	state_b_da_bpf_obj,
+	state_max_da_bpf_obj,
+};
+
+#define INVALID_STATE state_max_da_bpf_obj
+
+enum events_da_bpf_obj {
+	event_1_da_bpf_obj,
+	event_2_da_bpf_obj,
+	event_max_da_bpf_obj,
+};
+
+struct automaton_da_bpf_obj {
+	char state_names[state_max_da_bpf_obj][32];
+	char event_names[event_max_da_bpf_obj][32];
+	unsigned char function[state_max_da_bpf_obj][event_max_da_bpf_obj];
+	unsigned char initial_state;
+	bool final_states[state_max_da_bpf_obj];
+};
+
+static const struct automaton_da_bpf_obj automaton_da_bpf_obj = {
+	.state_names = {
+		"state_a",
+		"state_b",
+	},
+	.event_names = {
+		"event_1",
+		"event_2",
+	},
+	.function = {
+		{       state_b_da_bpf_obj,       state_a_da_bpf_obj },
+		{            INVALID_STATE,       state_a_da_bpf_obj },
+	},
+	.initial_state = state_a_da_bpf_obj,
+	.final_states = { 1, 0 },
+};
diff --git a/tools/verification/rvgen/tests/rvgen_monitor.t b/tools/verification/rvgen/tests/rvgen_monitor.t
index 5f2562600bad..3d71685a7ad5 100644
--- a/tools/verification/rvgen/tests/rvgen_monitor.t
+++ b/tools/verification/rvgen/tests/rvgen_monitor.t
@@ -47,6 +47,17 @@ check_and_compare_folder "LTL per_task with parent and description (default name
 	"$RVGEN monitor -c ltl -s tests/specs/test_ltl.ltl -t per_task -p ltl_parent -D 'Simple description'" \
 	"test_ltl" "LTL_MON_EVENTS_ID"
 
+# BPF monitor test
+check_and_compare_folder "DA BPF per_cpu" \
+	"$RVGEN monitor -b -c da -s tests/specs/test_da.dot -t per_cpu -n da_bpf_cpu" \
+	"da_bpf_cpu" "Edit the da_bpf_cpu/da_bpf_cpu.c to add the instrumentation" \
+	"Edit kernel/trace/rv/Makefile"
+
+check_and_compare_folder "DA BPF per_obj" \
+	"$RVGEN monitor -b -c da -s tests/specs/test_da.dot -t per_obj -n da_bpf_obj" \
+	"da_bpf_obj" "Edit the da_bpf_obj/da_bpf_obj.c to add the instrumentation" \
+	"Edit kernel/trace/rv/Kconfig"
+
 # Error handling tests
 check "missing required spec argument" \
 	"$RVGEN monitor -c da -t per_cpu" 2 \
-- 
2.55.0

