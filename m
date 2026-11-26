Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698121;
	b=5jcuAOp0ZDa99OlahEEFLCA7jW+qyxJ17hBWfCbgnXmsClZS82X5FZ1GffCh/SKsYZ0z
	 GmuksM1W3zgLWfn6Cb9/tGURilqYbxB1WH3Qn42j4NUmpwU7rC/yrSHcp5EmhiRFat6qh
	 59RIvz7H44Nci9iWaCnft2JYeduUJ1aZV68rcuQl7Qwi9o8hJv+vYDz9HS1Bc1njUV6Xe
	 gugW96RJe7H+b78FE6HlUQgvD4WbDyn2orMHlM5H9xsT8v/Dn6iYTlyehKYDefUp0dzO3
	 dWRN1g6vlTsG8QjMk3APGHB4iYKHAXfVLhPEb3HaLPwyvSud60vQKr3yYIpZqFvjjiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698121;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=wq8zFgSAzHIJhaAsqFgvjlNg2khdNMSb+6FPwTy01kM=;
	b=hYIIB16S2PM5Q0cH/+626OL54jb4Jh9jzdU2yYsPH8ueGQuv7ITbXD6AhF6MGK2hP6OB
	 nQO1Qknnp9Cwki6wZgmsHCbTc0Zi7pWM3k06o6AV2Bnr1krnhfULxyKg08N//aWC/x95Q
	 oiOpBMOOgkVF5fHjSj3uD9OurnoDhcNh4oiZZ/tDvBETZqtGnBm3b1qTfUa7N4p7fc6VR
	 6FyHlwxcZM7lmDLhBE5FJNkIYdJ56cSnh/O1GuiGcme4cW1ZrvXNk8Rv+Lxw9wHAePHds
	 Nf2Z8h6eEvkHd99lRVouzpcIj9BNT+Owg+00k0m88KjgPqyiLfsK21Fnnaz0GSjMycA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HxpBE6O7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC5606A334
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DFC5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HxpBE6O7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wq8zFgSAzHIJhaAsqFgvjlNg2khdNMSb+6FPwTy01kM=;
	b=HxpBE6O7Ur2bHrm4rN9GMh0uN/AeUd9n6RgtOC8uRE+5YqqpsP/SOgXdxUzL7Af72RYEcq
	H/S2bRUv0jMSRjyEjNOWe5++cw3wUcZoxdZKABBcxQqh2OCzGfZNn5QX9vECbakvwvdvEq
	xBS6EVBZdvIZtQaxcMMijDPnE+zKXA0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-YeXDpCPpPBG42x1AXuX8aw-1; Thu,
 26 Nov 2026 13:01:55 +0000
X-MC-Unique: YeXDpCPpPBG42x1AXuX8aw-1
X-Mimecast-MFC-AGG-ID: YeXDpCPpPBG42x1AXuX8aw_1795698113
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CAA6180059B;
	Thu, 26 Nov 2026 13:01:53 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1412E1800543;
	Thu, 26 Nov 2026 13:01:49 +0000 (UTC)
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
Subject: [PATCH v3 18/18] verification/rvgen: Add selftest for rvgen -b
Date: Thu, 26 Nov 2026 14:00:04 +0100
Message-ID: <20261126130004.127155-19-gmonaco@redhat.com>
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

Add selftest cases for BPF monitors generation.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 .../tests/golden/da_bpf_cpu/da_bpf_cpu.c      | 35 +++++++++++++
 .../tests/golden/da_bpf_cpu/da_bpf_cpu.h      | 47 ++++++++++++++++++
 .../tests/golden/da_bpf_obj/da_bpf_obj.c      | 49 +++++++++++++++++++
 .../tests/golden/da_bpf_obj/da_bpf_obj.h      | 47 ++++++++++++++++++
 .../verification/rvgen/tests/rvgen_monitor.t  | 11 +++++
 5 files changed, 189 insertions(+)
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.c
 create mode 100644 tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h

diff --git a/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c b/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c
new file mode 100644
index 000000000000..5a652ce9b461
--- /dev/null
+++ b/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.c
@@ -0,0 +1,35 @@
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
+static struct rv_monitor rv_this = {
+	.enabled = 0,
+};
+
+char LICENSE[] SEC("license") = "GPL";
+char DESCRIPTION[] SEC(".rodata.description") = "auto-generated";
diff --git a/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h b/tools/verification/rvgen/tests/golden/da_bpf_cpu/da_bpf_cpu.h
new file mode 100644
index 000000000000..715b34a099f6
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
+	const char state_names[state_max_da_bpf_cpu][32];
+	const char event_names[event_max_da_bpf_cpu][32];
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
index 000000000000..a7d465f84f05
--- /dev/null
+++ b/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.c
@@ -0,0 +1,49 @@
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
+static struct rv_monitor rv_this = {
+	.enabled = 0,
+};
+
+char LICENSE[] SEC("license") = "GPL";
+char DESCRIPTION[] SEC(".rodata.description") = "auto-generated";
diff --git a/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h b/tools/verification/rvgen/tests/golden/da_bpf_obj/da_bpf_obj.h
new file mode 100644
index 000000000000..f42fa733abee
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
+	const char state_names[state_max_da_bpf_obj][32];
+	const char event_names[event_max_da_bpf_obj][32];
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
2.56.1

