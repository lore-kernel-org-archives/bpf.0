Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698113;
	b=d6Xznx2OSWGgRQwhtrPS474Jo9CSn8H3B9jQKqqACtBsaxPeoZsC6+ZYIXCgy5hxInhM
	 x86k8UnVE7598Sau4xJT0QbLEkbiy8t3e3Cl0YjYlL+4w1aFLOK/HVldCNyZ+7rThDzvJ
	 mmL2cJCZonOgV1qjiTV3q0a1PDNjBf1ijRYnD5KK4eZqfKeJ51GEN2iVHo50sjGqFcuew
	 fBZYNiAoTonbQ6EdqWKHwrLt5sO+yExmMrRSprPjHQXL6JxUJC3MaDxCQtcnZRVHjQlLN
	 0F26T1GPwslNdPKApVxfK+WeW+rOVHhZ35vbIEb7LU0UNqgM8a50cPjDZSNkDkepB3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698113;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=NxLzF4JKc9tPGD4BS9NAAHb0LfBF2IW1VGK/GWO1iTc=;
	b=AZomIIt/k8HxVC3by5J0iLJH4/QNcZG1Yj+FFXLRQvMZErmdRq5VvrXvvoTk1Syq5P4Q
	 Xj8FtKn2WHUwszTGHojrkUx3+gZUUrS2ab55byBKsNKE6ok9jNuzsH5KElJkpJM9B9iU8
	 arVcMeHMnM37KBGBeU/xRIukaS3HmRvvItZrMdCJ4jKNAxRRPrYULzMPDZOUP1PN6Yydp
	 g9OldqK3xD4iJCVaZvR7K59KRh6Vy5W2N1l6G17TnWjtaEnsj1yihLc3Wq4zZF6nwi0Mh
	 8Q0aXyMwKZSpjQWnQUM2lF7zxVHgC6B/veuZnbGom06s8Zy85HvW/JV9lI8ZBur3Xcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gE2SoQy3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6458606A331
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6458606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gE2SoQy3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxLzF4JKc9tPGD4BS9NAAHb0LfBF2IW1VGK/GWO1iTc=;
	b=gE2SoQy3k31dc/oSiPLbKya4bFwOgIbFpZtl2Mvt23+OtMWNC0RIsIpUbxuiOpOHKYepc8
	Wf9LMok5GC/P5XvaI9ifazaXRLVb0MVmkvmoavv+vGxzbHysZgHKFG9f5cJUPrdBZYlZa8
	Daf+cuPYqEE61HsptB3XUBhjvUwoBDs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-XcadsHHMO2GHUNSHKyX5Rg-1; Thu,
 26 Nov 2026 13:01:45 +0000
X-MC-Unique: XcadsHHMO2GHUNSHKyX5Rg-1
X-Mimecast-MFC-AGG-ID: XcadsHHMO2GHUNSHKyX5Rg_1795698104
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0D3C1944A8C;
	Thu, 26 Nov 2026 13:01:43 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE4DB1800543;
	Thu, 26 Nov 2026 13:01:40 +0000 (UTC)
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
Subject: [PATCH v3 16/18] verification/rvgen: Add support for BPF monitors
Date: Thu, 26 Nov 2026 14:00:02 +0100
Message-ID: <20261126130004.127155-17-gmonaco@redhat.com>
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

Add the -b flag to rvgen monitor to generate a bpf monitor.
By default the code is generated in a folder with the same name as the
model just like in-kernel monitors, although only the source and header
are meaningful here. Passing -a moves the sources to
tools/verification/rv/bpf_monitors/ where they can be built directly.

Currently BPF monitors are only supported for DA.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/__main__.py          | 15 ++++++++---
 tools/verification/rvgen/rvgen/dot2c.py       | 15 ++++++++---
 tools/verification/rvgen/rvgen/dot2k.py       | 22 +++++++++++++---
 tools/verification/rvgen/rvgen/generator.py   | 26 ++++++++++++++-----
 .../rvgen/rvgen/templates/dot2k/main_bpf.c    | 21 +++++++++++++++
 5 files changed, 80 insertions(+), 19 deletions(-)
 create mode 100644 tools/verification/rvgen/rvgen/templates/dot2k/main_bpf.c

diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index 246b43fa29f1..16ce9b512fbb 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -39,6 +39,8 @@ if __name__ == '__main__':
                                 help="Monitor specification file")
     monitor_parser.add_argument('-t', "--monitor_type", dest="monitor_type", required=True,
                                 help=f"Available options: {', '.join(Monitor.monitor_types.keys())}")
+    monitor_parser.add_argument('-b', "--bpf", dest="bpf", action="store_true",
+                                required=False, help="Generate a BPF monitor")
 
     container_parser = subparsers.add_parser("container", parents=[parent_parser])
     container_parser.add_argument('-n', "--model_name", dest="model_name", required=True)
@@ -50,6 +52,9 @@ if __name__ == '__main__':
 
     params = parser.parse_args()
 
+    if params.subcmd == "monitor" and params.bpf and params.monitor_class != "da":
+        parser.error("BPF monitors (-b/--bpf) are only supported for deterministic automaton (-c da)")
+
     try:
         if params.subcmd == "monitor":
             print(f"Opening and parsing the specification file {params.spec}")
@@ -80,7 +85,9 @@ if __name__ == '__main__':
     print("Almost done, checklist")
     if params.subcmd == "monitor":
         print(f"  - Edit the {monitor.name}/{monitor.name}.c to add the instrumentation")
-        print(monitor.fill_tracepoint_tooltip())
-    print(monitor.fill_makefile_tooltip())
-    print(monitor.fill_kconfig_tooltip())
-    print(monitor.fill_monitor_tooltip())
+        if not params.bpf:
+            print(monitor.fill_tracepoint_tooltip())
+    if not params.subcmd == "monitor" or not params.bpf:
+        print(monitor.fill_makefile_tooltip())
+        print(monitor.fill_kconfig_tooltip())
+        print(monitor.fill_monitor_tooltip())
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index c6bd4d00d92e..246b76931660 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -111,10 +111,17 @@ class Dot2c(Automata):
         min_type = self.get_minimun_type()
         buff = []
         buff.append(f"struct {self.struct_automaton_def} {{")
-        buff.append(f"\tconst char *state_names[state_max{self.enum_suffix}];")
-        buff.append(f"\tconst char *event_names[event_max{self.enum_suffix}];")
-        if self.is_hybrid_automata():
-            buff.append(f"\tconst char *env_names[env_max{self.enum_suffix}];")
+        if self.bpf:
+            # BPF struggles with non-fixed string pointers
+            buff.append(f"\tconst char state_names[state_max{self.enum_suffix}][32];")
+            buff.append(f"\tconst char event_names[event_max{self.enum_suffix}][32];")
+            if self.is_hybrid_automata():
+                buff.append(f"\tconst char env_names[env_max{self.enum_suffix}][32];")
+        else:
+            buff.append(f"\tconst char *state_names[state_max{self.enum_suffix}];")
+            buff.append(f"\tconst char *event_names[event_max{self.enum_suffix}];")
+            if self.is_hybrid_automata():
+                buff.append(f"\tconst char *env_names[env_max{self.enum_suffix}];")
         buff.append(f"\t{min_type} function[state_max{self.enum_suffix}][event_max{self.enum_suffix}];")
         buff.append(f"\t{min_type} initial_state;")
         buff.append(f"\tbool final_states[state_max{self.enum_suffix}];")
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index b48895b93c8a..d0677da59172 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -30,14 +30,19 @@ class dot2k(Monitor, Dot2c):
         buff = [ self.monitor_type.upper() ]
         buff += self._fill_timer_type()
         if self.monitor_type == "per_obj":
-            buff.append("typedef /* XXX: define the target type */ *monitor_target;")
+            pad = "_bpf" if self.bpf else ""
+            buff.append(f"typedef /* XXX: define the target type */ *monitor_target{pad};")
         return "\n".join(buff)
 
     def fill_tracepoint_handlers_skel(self) -> str:
         buff = []
         buff += self._fill_hybrid_definitions()
         for event in self.events:
-            buff.append(f"static void handle_{event}(void *data, /* XXX: fill header */)")
+            if self.bpf:
+                buff.append("SEC(/* XXX: tracepoint or other probe */)")
+                buff.append(f"int BPF_PROG(handle_{event}, /* XXX: fill header */)")
+            else:
+                buff.append(f"static void handle_{event}(void *data, /* XXX: fill header */)")
             buff.append("{")
             handle = "handle_event"
             if self.is_start_event(event):
@@ -50,19 +55,28 @@ class dot2k(Monitor, Dot2c):
                 buff.append("\tstruct task_struct *p = /* XXX: how do I get p? */;")
                 buff.append(f"\tda_{handle}(p, {event}{self.enum_suffix});")
             elif self.monitor_type == "per_obj":
+                pad = "_bpf" if self.bpf else ""
                 buff.append("\tint id = /* XXX: how do I get the id? */;")
-                buff.append("\tmonitor_target t = /* XXX: how do I get t? */;")
+                buff.append(f"\tmonitor_target{pad} t = /* XXX: how do I get t? */;")
                 buff.append(f"\tda_{handle}(id, t, {event}{self.enum_suffix});")
             else:
                 buff.append(f"\tda_{handle}({event}{self.enum_suffix});")
+            if self.bpf:
+                buff.append("\treturn 0;")
             buff.append("}")
             buff.append("")
         if self.monitor_type == "per_obj":
             buff.append("/* XXX: obj is being destroyed, remove if not required (e.g. obj is static) */")
-            buff.append(f"static void handle_{self.cleanup_marker}(void *data, /* XXX: fill header */)")
+            if self.bpf:
+                buff.append("SEC(/* XXX: tracepoint or other probe */)")
+                buff.append(f"int BPF_PROG(handle_{self.cleanup_marker}, /* XXX: fill header */)")
+            else:
+                buff.append(f"static void handle_{self.cleanup_marker}(void *data, /* XXX: fill header */)")
             buff.append("{")
             buff.append("\tint id = /* XXX: how do I get the id? */;")
             buff.append("\tda_destroy_storage(id);")
+            if self.bpf:
+                buff.append("\treturn 0;")
             buff.append("}")
             buff.append("")
         return '\n'.join(buff)
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 626bb7ce90ee..8895a264cf0c 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -11,18 +11,22 @@ from pathlib import Path
 
 class RVGenerator:
     rv_dir = "kernel/trace/rv"
+    rv_tool_dir = "../../../tools/verification/rv/bpf_monitors/"
 
     def __init__(self, extra_params={}):
         self.name = extra_params.get("model_name")
         self.parent = extra_params.get("parent")
+        self.bpf = extra_params.get("bpf")
         self.abs_template_dir = \
             Path(__file__).resolve().parent / "templates" / self.template_dir
-        self.main_c = self._read_template_file("main.c")
+        self.main_c = self._read_template_file("main.c" if not self.bpf
+                                               else "main_bpf.c")
         self.kconfig = self._read_template_file("Kconfig")
         self.description = extra_params.get("description", self.name) or "auto-generated"
         self.auto_patch = extra_params.get("auto_patch")
         if self.auto_patch:
             self._fill_rv_kernel_dir()
+            self.rv_tool_dir = (Path(self.rv_dir) / self.rv_tool_dir).resolve()
 
     def _fill_rv_kernel_dir(self):
         # find the kernel tree root relative to this file's location
@@ -188,6 +192,9 @@ obj-$(CONFIG_RV_MON_{name_up}) += monitors/{name}/{name}.o
     def __create_directory(self):
         path = Path(self.name)
         if self.auto_patch:
+            if self.bpf:
+                # no directory for BPF monitors
+                return
             path = Path(self.rv_dir) / "monitors" / path
         path.mkdir(exist_ok=True)
 
@@ -199,6 +206,8 @@ obj-$(CONFIG_RV_MON_{name_up}) += monitors/{name}/{name}.o
         path = Path(self.name) / file_name
         if self.auto_patch:
             path = Path(self.rv_dir) / "monitors" / self.name / file_name
+            if self.bpf:
+                path = Path(self.rv_tool_dir) / file_name
         self.__write_file(path, content)
 
     def print_files(self):
@@ -213,8 +222,9 @@ obj-$(CONFIG_RV_MON_{name_up}) += monitors/{name}/{name}.o
         path = f"{self.name}.h"
         self._create_file(path, model_h)
 
-        kconfig = self.fill_kconfig()
-        self._create_file("Kconfig", kconfig)
+        if not self.bpf:
+            kconfig = self.fill_kconfig()
+            self._create_file("Kconfig", kconfig)
 
 
 class Monitor(RVGenerator):
@@ -222,7 +232,8 @@ class Monitor(RVGenerator):
 
     def __init__(self, extra_params={}):
         super().__init__(extra_params)
-        self.trace_h = self._read_template_file("trace.h")
+        if not self.bpf:
+            self.trace_h = self._read_template_file("trace.h")
 
     def _is_id_monitor(self):
         return False
@@ -241,6 +252,7 @@ class Monitor(RVGenerator):
 
     def print_files(self):
         super().print_files()
-        trace_h = self.fill_trace_h()
-        path = f"{self.name}_trace.h"
-        self._create_file(path, trace_h)
+        if not self.bpf:
+            trace_h = self.fill_trace_h()
+            path = f"{self.name}_trace.h"
+            self._create_file(path, trace_h)
diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/main_bpf.c b/tools/verification/rvgen/rvgen/templates/dot2k/main_bpf.c
new file mode 100644
index 000000000000..1a83f3a2159a
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/templates/dot2k/main_bpf.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#define RV_MON_TYPE RV_MON_%%MONITOR_TYPE%%
+#include "%%MODEL_NAME%%.h"
+#include <rv/da_monitor.h>
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ */
+%%TRACEPOINT_HANDLERS_SKEL%%
+static struct rv_monitor rv_this = {
+	.enabled = 0,
+};
+
+char LICENSE[] SEC("license") = "GPL";
+char DESCRIPTION[] SEC(".rodata.description") = "%%DESCRIPTION%%";
-- 
2.56.1

