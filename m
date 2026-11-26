Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698042;
	b=29w0JLFIajTVJ9Z0OERFH9FfG5f8OgEVgTyQWh1Shv4Q1l055xrZNB8KT1cd5iCs1mvN
	 Wnb9qFBx8u09/5XS8D5CU96o+1i8Vu3sBJL+n84Dd2Y2Jw5v0hvnlsu4BGeWPJkcsPSOD
	 LXhwNYQwHffAsLwWwRjfDfouKc6nMYekhah5XLy0xzDsrlwfWey/xxwL0quyqrTrBww+9
	 E+GEaqt2l6fHi/nucKOglLWo0Ta/BEFV+vtpDEEZ+SnKjXjnDiJynyA8L2Am4aYXKSDoJ
	 hyXMNSnO59DOyhDVEqajPxITDI7GjE5Ob71uPCl9dyDF5Ku29R4UU8TZjFn/L+UmuEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698042;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=86yKQJUR7h0azgWV1Z7d9FfwaGTKd9Idl12qAP/cPPA=;
	b=4wZ4n9uzXWR2OUaHlwOqVOL+Fv0q7gKerYASOOoCGYcSzgkwWuQvNbuKzVTUzv4jCweR
	 dGmuEf9pV5zDYgAFqDjbaNr2Nr9AOF1E8Xvsrk2Vp7BWxMbvejX6yM/4f2vnHMKezkHmP
	 CzTB2hKehDGrboUMbquw5+zijRgrDVT0PF2fcyv2Bft97+soapCoxStPnIP+Y46ZB34Ny
	 WlFYVIjQXsKUcjjfg2jLVrd5skPXdF1eYUSbOrmMvSLv6vqeaLTERJ3VPMB8X2LocYGe+
	 KwQCZoQcpdt/3Df8B6FCdytL1ZYWMDd5p9AKDMUbo6kx/gfCkAdwqO+S9YcH2ux9hIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Uk/ydSn6";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F7606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E12F7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uk/ydSn6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795698041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86yKQJUR7h0azgWV1Z7d9FfwaGTKd9Idl12qAP/cPPA=;
	b=Uk/ydSn6hxb/Jv+zyNNaVjEUo5SP59mEJAFFeQwathjt97A4ZF6P9opaqtoy/SpSErAl4C
	ZIv9SkCVjE6NqxqwpViTSGkRBdZfN34p2sPWcB+TtKNbEqYZxbiKdR1ucrrW8ehw1r4OTf
	T+7AUO4/9R4F9NGbwjRxiXJlcHugPfg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-x3f7WlVnNKmXzxQgHHqzQg-1; Thu,
 26 Nov 2026 13:00:38 +0000
X-MC-Unique: x3f7WlVnNKmXzxQgHHqzQg-1
X-Mimecast-MFC-AGG-ID: x3f7WlVnNKmXzxQgHHqzQg_1795698035
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B669180057B;
	Thu, 26 Nov 2026 13:00:35 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60B92180054C;
	Thu, 26 Nov 2026 13:00:31 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3 03/18] rv: Add wrapper macros for monitor tracepoint definitions
Date: Thu, 26 Nov 2026 13:59:49 +0100
Message-ID: <20261126130004.127155-4-gmonaco@redhat.com>
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

Currently, each monitor trace header repeats DEFINE_EVENT with explicit
TP_PROTO and TP_ARGS matching the respective event class. This
introduces boilerplate across monitors and makes changing the underlying
prototype cumbersome as every monitor's trace header must be updated
individually.

Add wrapper macros in rv_trace.h that wrap DEFINE_EVENT with the shared
prototypes and argument lists.
Update all monitor trace headers, the rvgen code generation templates,
and the test golden files to use these helper macros.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 .../trace/rv/monitors/nomiss/nomiss_trace.h   | 14 ++----
 kernel/trace/rv/monitors/nrp/nrp_trace.h      |  9 +---
 kernel/trace/rv/monitors/opid/opid_trace.h    | 14 ++----
 .../rv/monitors/pagefault/pagefault_trace.h   |  8 +---
 kernel/trace/rv/monitors/sco/sco_trace.h      |  9 +---
 kernel/trace/rv/monitors/scpd/scpd_trace.h    |  9 +---
 kernel/trace/rv/monitors/sleep/sleep_trace.h  |  8 +---
 kernel/trace/rv/monitors/snep/snep_trace.h    |  9 +---
 kernel/trace/rv/monitors/snroc/snroc_trace.h  |  9 +---
 kernel/trace/rv/monitors/sssw/sssw_trace.h    |  9 +---
 kernel/trace/rv/monitors/stall/stall_trace.h  | 14 ++----
 kernel/trace/rv/monitors/sts/sts_trace.h      |  9 +---
 .../trace/rv/monitors/wakeup/wakeup_trace.h   |  8 +---
 kernel/trace/rv/monitors/wip/wip_trace.h      |  9 +---
 kernel/trace/rv/monitors/wwnr/wwnr_trace.h    |  9 +---
 kernel/trace/rv/rv_trace.h                    | 44 +++++++++++++++++++
 tools/verification/rvgen/rvgen/dot2k.py       | 28 ------------
 tools/verification/rvgen/rvgen/generator.py   | 14 +++---
 .../rvgen/rvgen/templates/dot2k/trace.h       |  7 +--
 .../rvgen/templates/dot2k/trace_hybrid.h      | 11 ++---
 .../rvgen/rvgen/templates/ltl2k/trace.h       |  8 +---
 .../tests/golden/da_global/da_global_trace.h  |  9 +---
 .../da_perobj_parent/da_perobj_parent_trace.h |  9 +---
 .../da_pertask_desc/da_pertask_desc_trace.h   |  9 +---
 .../tests/golden/ha_percpu/ha_percpu_trace.h  | 14 ++----
 .../golden/ltl_pertask/ltl_pertask_trace.h    |  8 +---
 .../test_bak_kunit/test_bak_kunit_trace.h     |  8 +---
 .../tests/golden/test_da/test_da_trace.h      |  9 +---
 .../test_da_kunit/test_da_kunit_trace.h       |  9 +---
 .../tests/golden/test_ha/test_ha_trace.h      | 14 ++----
 .../test_ha_kunit/test_ha_kunit_trace.h       | 14 ++----
 .../tests/golden/test_ltl/test_ltl_trace.h    |  8 +---
 .../test_ltl_kunit/test_ltl_kunit_trace.h     |  8 +---
 33 files changed, 116 insertions(+), 262 deletions(-)

diff --git a/kernel/trace/rv/monitors/nomiss/nomiss_trace.h b/kernel/trace/rv/monitors/nomiss/nomiss_trace.h
index 42e7efaca4e7..2863b905e0db 100644
--- a/kernel/trace/rv/monitors/nomiss/nomiss_trace.h
+++ b/kernel/trace/rv/monitors/nomiss/nomiss_trace.h
@@ -5,15 +5,7 @@
  */
 
 #ifdef CONFIG_RV_MON_NOMISS
-DEFINE_EVENT(event_da_monitor_id, event_nomiss,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(id, state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor_id, error_nomiss,
-	     TP_PROTO(int id, char *state, char *event),
-	     TP_ARGS(id, state, event));
-
-DEFINE_EVENT(error_env_da_monitor_id, error_env_nomiss,
-	     TP_PROTO(int id, char *state, char *event, char *env),
-	     TP_ARGS(id, state, event, env));
+DEFINE_DA_EVENT_ID(event_nomiss);
+DEFINE_DA_ERROR_ID(error_nomiss);
+DEFINE_HA_ERROR_ENV_ID(error_env_nomiss);
 #endif /* CONFIG_RV_MON_NOMISS */
diff --git a/kernel/trace/rv/monitors/nrp/nrp_trace.h b/kernel/trace/rv/monitors/nrp/nrp_trace.h
index 2e13497de3b6..3d85bdcbcd90 100644
--- a/kernel/trace/rv/monitors/nrp/nrp_trace.h
+++ b/kernel/trace/rv/monitors/nrp/nrp_trace.h
@@ -5,11 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_NRP
-DEFINE_EVENT(event_da_monitor_id, event_nrp,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(id, state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor_id, error_nrp,
-	     TP_PROTO(int id, char *state, char *event),
-	     TP_ARGS(id, state, event));
+DEFINE_DA_EVENT_ID(event_nrp);
+DEFINE_DA_ERROR_ID(error_nrp);
 #endif /* CONFIG_RV_MON_NRP */
diff --git a/kernel/trace/rv/monitors/opid/opid_trace.h b/kernel/trace/rv/monitors/opid/opid_trace.h
index b04005b64208..914763d5dbf4 100644
--- a/kernel/trace/rv/monitors/opid/opid_trace.h
+++ b/kernel/trace/rv/monitors/opid/opid_trace.h
@@ -5,15 +5,7 @@
  */
 
 #ifdef CONFIG_RV_MON_OPID
-DEFINE_EVENT(event_da_monitor, event_opid,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor, error_opid,
-	     TP_PROTO(char *state, char *event),
-	     TP_ARGS(state, event));
-
-DEFINE_EVENT(error_env_da_monitor, error_env_opid,
-	     TP_PROTO(char *state, char *event, char *env),
-	     TP_ARGS(state, event, env));
+DEFINE_DA_EVENT(event_opid);
+DEFINE_DA_ERROR(error_opid);
+DEFINE_HA_ERROR_ENV(error_env_opid);
 #endif /* CONFIG_RV_MON_OPID */
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault_trace.h b/kernel/trace/rv/monitors/pagefault/pagefault_trace.h
index fe1f82597b1a..4b49ddbbb244 100644
--- a/kernel/trace/rv/monitors/pagefault/pagefault_trace.h
+++ b/kernel/trace/rv/monitors/pagefault/pagefault_trace.h
@@ -5,10 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_PAGEFAULT
-DEFINE_EVENT(event_ltl_monitor_id, event_pagefault,
-	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
-	     TP_ARGS(task, states, atoms, next));
-DEFINE_EVENT(error_ltl_monitor_id, error_pagefault,
-	     TP_PROTO(struct task_struct *task),
-	     TP_ARGS(task));
+DEFINE_LTL_EVENT_ID(event_pagefault);
+DEFINE_LTL_ERROR_ID(error_pagefault);
 #endif /* CONFIG_RV_MON_PAGEFAULT */
diff --git a/kernel/trace/rv/monitors/sco/sco_trace.h b/kernel/trace/rv/monitors/sco/sco_trace.h
index b711cd9024ec..36ec9b876df5 100644
--- a/kernel/trace/rv/monitors/sco/sco_trace.h
+++ b/kernel/trace/rv/monitors/sco/sco_trace.h
@@ -5,11 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_SCO
-DEFINE_EVENT(event_da_monitor, event_sco,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor, error_sco,
-	     TP_PROTO(char *state, char *event),
-	     TP_ARGS(state, event));
+DEFINE_DA_EVENT(event_sco);
+DEFINE_DA_ERROR(error_sco);
 #endif /* CONFIG_RV_MON_SCO */
diff --git a/kernel/trace/rv/monitors/scpd/scpd_trace.h b/kernel/trace/rv/monitors/scpd/scpd_trace.h
index 6b0f4aa4732e..ad330701eb2d 100644
--- a/kernel/trace/rv/monitors/scpd/scpd_trace.h
+++ b/kernel/trace/rv/monitors/scpd/scpd_trace.h
@@ -5,11 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_SCPD
-DEFINE_EVENT(event_da_monitor, event_scpd,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor, error_scpd,
-	     TP_PROTO(char *state, char *event),
-	     TP_ARGS(state, event));
+DEFINE_DA_EVENT(event_scpd);
+DEFINE_DA_ERROR(error_scpd);
 #endif /* CONFIG_RV_MON_SCPD */
diff --git a/kernel/trace/rv/monitors/sleep/sleep_trace.h b/kernel/trace/rv/monitors/sleep/sleep_trace.h
index 22eaf31da987..44a22828a810 100644
--- a/kernel/trace/rv/monitors/sleep/sleep_trace.h
+++ b/kernel/trace/rv/monitors/sleep/sleep_trace.h
@@ -5,10 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_SLEEP
-DEFINE_EVENT(event_ltl_monitor_id, event_sleep,
-	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
-	     TP_ARGS(task, states, atoms, next));
-DEFINE_EVENT(error_ltl_monitor_id, error_sleep,
-	     TP_PROTO(struct task_struct *task),
-	     TP_ARGS(task));
+DEFINE_LTL_EVENT_ID(event_sleep);
+DEFINE_LTL_ERROR_ID(error_sleep);
 #endif /* CONFIG_RV_MON_SLEEP */
diff --git a/kernel/trace/rv/monitors/snep/snep_trace.h b/kernel/trace/rv/monitors/snep/snep_trace.h
index 01aad49a949a..94edc47b30b9 100644
--- a/kernel/trace/rv/monitors/snep/snep_trace.h
+++ b/kernel/trace/rv/monitors/snep/snep_trace.h
@@ -5,11 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_SNEP
-DEFINE_EVENT(event_da_monitor, event_snep,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor, error_snep,
-	     TP_PROTO(char *state, char *event),
-	     TP_ARGS(state, event));
+DEFINE_DA_EVENT(event_snep);
+DEFINE_DA_ERROR(error_snep);
 #endif /* CONFIG_RV_MON_SNEP */
diff --git a/kernel/trace/rv/monitors/snroc/snroc_trace.h b/kernel/trace/rv/monitors/snroc/snroc_trace.h
index 50114cef5122..20462159988a 100644
--- a/kernel/trace/rv/monitors/snroc/snroc_trace.h
+++ b/kernel/trace/rv/monitors/snroc/snroc_trace.h
@@ -5,11 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_SNROC
-DEFINE_EVENT(event_da_monitor_id, event_snroc,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(id, state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor_id, error_snroc,
-	     TP_PROTO(int id, char *state, char *event),
-	     TP_ARGS(id, state, event));
+DEFINE_DA_EVENT_ID(event_snroc);
+DEFINE_DA_ERROR_ID(error_snroc);
 #endif /* CONFIG_RV_MON_SNROC */
diff --git a/kernel/trace/rv/monitors/sssw/sssw_trace.h b/kernel/trace/rv/monitors/sssw/sssw_trace.h
index 6c03cfc6960b..26cffbf9ed62 100644
--- a/kernel/trace/rv/monitors/sssw/sssw_trace.h
+++ b/kernel/trace/rv/monitors/sssw/sssw_trace.h
@@ -5,11 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_SSSW
-DEFINE_EVENT(event_da_monitor_id, event_sssw,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(id, state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor_id, error_sssw,
-	     TP_PROTO(int id, char *state, char *event),
-	     TP_ARGS(id, state, event));
+DEFINE_DA_EVENT_ID(event_sssw);
+DEFINE_DA_ERROR_ID(error_sssw);
 #endif /* CONFIG_RV_MON_SSSW */
diff --git a/kernel/trace/rv/monitors/stall/stall_trace.h b/kernel/trace/rv/monitors/stall/stall_trace.h
index 6a7cc1b1d040..9da0aedf01c1 100644
--- a/kernel/trace/rv/monitors/stall/stall_trace.h
+++ b/kernel/trace/rv/monitors/stall/stall_trace.h
@@ -5,15 +5,7 @@
  */
 
 #ifdef CONFIG_RV_MON_STALL
-DEFINE_EVENT(event_da_monitor_id, event_stall,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(id, state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor_id, error_stall,
-	     TP_PROTO(int id, char *state, char *event),
-	     TP_ARGS(id, state, event));
-
-DEFINE_EVENT(error_env_da_monitor_id, error_env_stall,
-	     TP_PROTO(int id, char *state, char *event, char *env),
-	     TP_ARGS(id, state, event, env));
+DEFINE_DA_EVENT_ID(event_stall);
+DEFINE_DA_ERROR_ID(error_stall);
+DEFINE_HA_ERROR_ENV_ID(error_env_stall);
 #endif /* CONFIG_RV_MON_STALL */
diff --git a/kernel/trace/rv/monitors/sts/sts_trace.h b/kernel/trace/rv/monitors/sts/sts_trace.h
index d78beb58d5b3..5b7d5e359290 100644
--- a/kernel/trace/rv/monitors/sts/sts_trace.h
+++ b/kernel/trace/rv/monitors/sts/sts_trace.h
@@ -5,11 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_STS
-DEFINE_EVENT(event_da_monitor, event_sts,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor, error_sts,
-	     TP_PROTO(char *state, char *event),
-	     TP_ARGS(state, event));
+DEFINE_DA_EVENT(event_sts);
+DEFINE_DA_ERROR(error_sts);
 #endif /* CONFIG_RV_MON_STS */
diff --git a/kernel/trace/rv/monitors/wakeup/wakeup_trace.h b/kernel/trace/rv/monitors/wakeup/wakeup_trace.h
index 7e056183f920..817826d77341 100644
--- a/kernel/trace/rv/monitors/wakeup/wakeup_trace.h
+++ b/kernel/trace/rv/monitors/wakeup/wakeup_trace.h
@@ -5,10 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_WAKEUP
-DEFINE_EVENT(event_ltl_monitor_id, event_wakeup,
-	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
-	     TP_ARGS(task, states, atoms, next));
-DEFINE_EVENT(error_ltl_monitor_id, error_wakeup,
-	     TP_PROTO(struct task_struct *task),
-	     TP_ARGS(task));
+DEFINE_LTL_EVENT_ID(event_wakeup);
+DEFINE_LTL_ERROR_ID(error_wakeup);
 #endif /* CONFIG_RV_MON_WAKEUP */
diff --git a/kernel/trace/rv/monitors/wip/wip_trace.h b/kernel/trace/rv/monitors/wip/wip_trace.h
index aa2162f47a4c..454333ea51e3 100644
--- a/kernel/trace/rv/monitors/wip/wip_trace.h
+++ b/kernel/trace/rv/monitors/wip/wip_trace.h
@@ -5,11 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_WIP
-DEFINE_EVENT(event_da_monitor, event_wip,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor, error_wip,
-	     TP_PROTO(char *state, char *event),
-	     TP_ARGS(state, event));
+DEFINE_DA_EVENT(event_wip);
+DEFINE_DA_ERROR(error_wip);
 #endif /* CONFIG_RV_MON_WIP */
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr_trace.h b/kernel/trace/rv/monitors/wwnr/wwnr_trace.h
index fc97ec7476ad..c395bb01542b 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr_trace.h
+++ b/kernel/trace/rv/monitors/wwnr/wwnr_trace.h
@@ -6,11 +6,6 @@
 
 #ifdef CONFIG_RV_MON_WWNR
 /* id is the pid of the task */
-DEFINE_EVENT(event_da_monitor_id, event_wwnr,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(id, state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor_id, error_wwnr,
-	     TP_PROTO(int id, char *state, char *event),
-	     TP_ARGS(id, state, event));
+DEFINE_DA_EVENT_ID(event_wwnr);
+DEFINE_DA_ERROR_ID(error_wwnr);
 #endif /* CONFIG_RV_MON_WWNR */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 2f8a932432c9..36e7c78c046e 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -57,6 +57,17 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 		__get_str(state))
 );
 
+#define DEFINE_DA_EVENT(name)						\
+	DEFINE_EVENT(event_da_monitor, name,				\
+		TP_PROTO(char *state, char *event,			\
+			 char *next_state, bool final_state),		\
+		TP_ARGS(state, event, next_state, final_state))
+
+#define DEFINE_DA_ERROR(name)						\
+	DEFINE_EVENT(error_da_monitor, name,				\
+		TP_PROTO(char *state, char *event),			\
+		TP_ARGS(state, event))
+
 #include <monitors/wip/wip_trace.h>
 #include <monitors/sco/sco_trace.h>
 #include <monitors/scpd/scpd_trace.h>
@@ -90,6 +101,11 @@ DECLARE_EVENT_CLASS(error_env_da_monitor,
 		__get_str(env))
 );
 
+#define DEFINE_HA_ERROR_ENV(name)					\
+	DEFINE_EVENT(error_env_da_monitor, name,			\
+		TP_PROTO(char *state, char *event, char *env),		\
+		TP_ARGS(state, event, env))
+
 #include <monitors/opid/opid_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_IMPLICIT here
 
@@ -152,6 +168,17 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 		__get_str(state))
 );
 
+#define DEFINE_DA_EVENT_ID(name)					\
+	DEFINE_EVENT(event_da_monitor_id, name,				\
+		TP_PROTO(int id, char *state, char *event,		\
+			 char *next_state, bool final_state),		\
+		TP_ARGS(id, state, event, next_state, final_state))
+
+#define DEFINE_DA_ERROR_ID(name)					\
+	DEFINE_EVENT(error_da_monitor_id, name,				\
+		TP_PROTO(int id, char *state, char *event),		\
+		TP_ARGS(id, state, event))
+
 #include <monitors/wwnr/wwnr_trace.h>
 #include <monitors/snroc/snroc_trace.h>
 #include <monitors/nrp/nrp_trace.h>
@@ -187,6 +214,11 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 		__get_str(env))
 );
 
+#define DEFINE_HA_ERROR_ENV_ID(name)					\
+	DEFINE_EVENT(error_env_da_monitor_id, name,			\
+		TP_PROTO(int id, char *state, char *event, char *env),	\
+		TP_ARGS(id, state, event, env))
+
 #include <monitors/stall/stall_trace.h>
 #include <monitors/nomiss/nomiss_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_ID here
@@ -239,6 +271,18 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
 
 	TP_printk("%s[%d]: violation detected", __get_str(comm), __entry->pid)
 );
+
+#define DEFINE_LTL_EVENT_ID(name)					\
+	DEFINE_EVENT(event_ltl_monitor_id, name,			\
+		TP_PROTO(struct task_struct *task, char *states,	\
+			 char *atoms, char *next),			\
+		TP_ARGS(task, states, atoms, next))
+
+#define DEFINE_LTL_ERROR_ID(name)					\
+	DEFINE_EVENT(error_ltl_monitor_id, name,			\
+		TP_PROTO(struct task_struct *task),			\
+		TP_ARGS(task))
+
 #include <monitors/pagefault/pagefault_trace.h>
 #include <monitors/sleep/sleep_trace.h>
 #include <monitors/wakeup/wakeup_trace.h>
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index fd3254ea5b4d..b48895b93c8a 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -125,34 +125,6 @@ class dot2k(Monitor, Dot2c):
             return "da_monitor_id"
         return "da_monitor"
 
-    def fill_tracepoint_args_skel(self, tp_type: str) -> str:
-        buff = []
-        tp_args_event = [
-                ("char *", "state"),
-                ("char *", "event"),
-                ("char *", "next_state"),
-                ("bool ",  "final_state"),
-                ]
-        tp_args_error = [
-                ("char *", "state"),
-                ("char *", "event"),
-                ]
-        tp_args_error_env = tp_args_error + [("char *", "env")]
-        tp_args_dict = {
-                "event": tp_args_event,
-                "error": tp_args_error,
-                "error_env": tp_args_error_env
-                }
-        tp_args_id = ("int ", "id")
-        tp_args = tp_args_dict[tp_type]
-        if self._is_id_monitor():
-            tp_args.insert(0, tp_args_id)
-        tp_proto_c = ", ".join([a + b for a, b in tp_args])
-        tp_args_c = ", ".join([b for a, b in tp_args])
-        buff.append(f"	     TP_PROTO({tp_proto_c}),")
-        buff.append(f"	     TP_ARGS({tp_args_c})")
-        return '\n'.join(buff)
-
     def _fill_hybrid_definitions(self) -> list:
         """Stub, not valid for deterministic automata"""
         return []
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 45e2bab26cb5..626bb7ce90ee 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -111,9 +111,6 @@ class RVGenerator:
     def fill_monitor_class(self):
         return "NotImplemented"
 
-    def fill_tracepoint_args_skel(self, tp_type):
-        return "NotImplemented"
-
     def fill_monitor_deps(self):
         buff = []
         buff.append("	# XXX: add dependencies if there")
@@ -227,20 +224,19 @@ class Monitor(RVGenerator):
         super().__init__(extra_params)
         self.trace_h = self._read_template_file("trace.h")
 
+    def _is_id_monitor(self):
+        return False
+
     def fill_trace_h(self):
         trace_h = self.trace_h
         monitor_class = self.fill_monitor_class()
+        macro_suffix = "_ID" if self._is_id_monitor() else ""
         monitor_class_type = self.fill_monitor_class_type()
-        tracepoint_args_skel_event = self.fill_tracepoint_args_skel("event")
-        tracepoint_args_skel_error = self.fill_tracepoint_args_skel("error")
-        tracepoint_args_skel_error_env = self.fill_tracepoint_args_skel("error_env")
         trace_h = trace_h.replace("%%MODEL_NAME%%", self.name)
         trace_h = trace_h.replace("%%MODEL_NAME_UP%%", self.name.upper())
         trace_h = trace_h.replace("%%MONITOR_CLASS%%", monitor_class)
         trace_h = trace_h.replace("%%MONITOR_CLASS_TYPE%%", monitor_class_type)
-        trace_h = trace_h.replace("%%TRACEPOINT_ARGS_SKEL_EVENT%%", tracepoint_args_skel_event)
-        trace_h = trace_h.replace("%%TRACEPOINT_ARGS_SKEL_ERROR%%", tracepoint_args_skel_error)
-        trace_h = trace_h.replace("%%TRACEPOINT_ARGS_SKEL_ERROR_ENV%%", tracepoint_args_skel_error_env)
+        trace_h = trace_h.replace("%%MACRO_SUFFIX%%", macro_suffix)
         return trace_h
 
     def print_files(self):
diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/trace.h b/tools/verification/rvgen/rvgen/templates/dot2k/trace.h
index 87d3a1308926..44ef49457bbe 100644
--- a/tools/verification/rvgen/rvgen/templates/dot2k/trace.h
+++ b/tools/verification/rvgen/rvgen/templates/dot2k/trace.h
@@ -5,9 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_%%MODEL_NAME_UP%%
-DEFINE_EVENT(event_%%MONITOR_CLASS%%, event_%%MODEL_NAME%%,
-%%TRACEPOINT_ARGS_SKEL_EVENT%%);
-
-DEFINE_EVENT(error_%%MONITOR_CLASS%%, error_%%MODEL_NAME%%,
-%%TRACEPOINT_ARGS_SKEL_ERROR%%);
+DEFINE_DA_EVENT%%MACRO_SUFFIX%%(event_%%MODEL_NAME%%);
+DEFINE_DA_ERROR%%MACRO_SUFFIX%%(error_%%MODEL_NAME%%);
 #endif /* CONFIG_RV_MON_%%MODEL_NAME_UP%% */
diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/trace_hybrid.h b/tools/verification/rvgen/rvgen/templates/dot2k/trace_hybrid.h
index c8290e9ba2f4..6b49529bc0e5 100644
--- a/tools/verification/rvgen/rvgen/templates/dot2k/trace_hybrid.h
+++ b/tools/verification/rvgen/rvgen/templates/dot2k/trace_hybrid.h
@@ -5,12 +5,7 @@
  */
 
 #ifdef CONFIG_RV_MON_%%MODEL_NAME_UP%%
-DEFINE_EVENT(event_%%MONITOR_CLASS%%, event_%%MODEL_NAME%%,
-%%TRACEPOINT_ARGS_SKEL_EVENT%%);
-
-DEFINE_EVENT(error_%%MONITOR_CLASS%%, error_%%MODEL_NAME%%,
-%%TRACEPOINT_ARGS_SKEL_ERROR%%);
-
-DEFINE_EVENT(error_env_%%MONITOR_CLASS%%, error_env_%%MODEL_NAME%%,
-%%TRACEPOINT_ARGS_SKEL_ERROR_ENV%%);
+DEFINE_DA_EVENT%%MACRO_SUFFIX%%(event_%%MODEL_NAME%%);
+DEFINE_DA_ERROR%%MACRO_SUFFIX%%(error_%%MODEL_NAME%%);
+DEFINE_HA_ERROR_ENV%%MACRO_SUFFIX%%(error_env_%%MODEL_NAME%%);
 #endif /* CONFIG_RV_MON_%%MODEL_NAME_UP%% */
diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h b/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
index 49394c4b0f1c..47266a383ac9 100644
--- a/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
+++ b/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
@@ -5,10 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_%%MODEL_NAME_UP%%
-DEFINE_EVENT(event_%%MONITOR_CLASS%%, event_%%MODEL_NAME%%,
-	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
-	     TP_ARGS(task, states, atoms, next));
-DEFINE_EVENT(error_%%MONITOR_CLASS%%, error_%%MODEL_NAME%%,
-	     TP_PROTO(struct task_struct *task),
-	     TP_ARGS(task));
+DEFINE_LTL_EVENT_ID(event_%%MODEL_NAME%%);
+DEFINE_LTL_ERROR_ID(error_%%MODEL_NAME%%);
 #endif /* CONFIG_RV_MON_%%MODEL_NAME_UP%% */
diff --git a/tools/verification/rvgen/tests/golden/da_global/da_global_trace.h b/tools/verification/rvgen/tests/golden/da_global/da_global_trace.h
index 4d2730b71dd0..4be02dfaed97 100644
--- a/tools/verification/rvgen/tests/golden/da_global/da_global_trace.h
+++ b/tools/verification/rvgen/tests/golden/da_global/da_global_trace.h
@@ -5,11 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_DA_GLOBAL
-DEFINE_EVENT(event_da_monitor, event_da_global,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor, error_da_global,
-	     TP_PROTO(char *state, char *event),
-	     TP_ARGS(state, event));
+DEFINE_DA_EVENT(event_da_global);
+DEFINE_DA_ERROR(error_da_global);
 #endif /* CONFIG_RV_MON_DA_GLOBAL */
diff --git a/tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent_trace.h b/tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent_trace.h
index 59bfca8f73d2..6e99897f51d1 100644
--- a/tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent_trace.h
+++ b/tools/verification/rvgen/tests/golden/da_perobj_parent/da_perobj_parent_trace.h
@@ -5,11 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_DA_PEROBJ_PARENT
-DEFINE_EVENT(event_da_monitor_id, event_da_perobj_parent,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(id, state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor_id, error_da_perobj_parent,
-	     TP_PROTO(int id, char *state, char *event),
-	     TP_ARGS(id, state, event));
+DEFINE_DA_EVENT_ID(event_da_perobj_parent);
+DEFINE_DA_ERROR_ID(error_da_perobj_parent);
 #endif /* CONFIG_RV_MON_DA_PEROBJ_PARENT */
diff --git a/tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc_trace.h b/tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc_trace.h
index 4e6086c4d86e..2198f0626fb5 100644
--- a/tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc_trace.h
+++ b/tools/verification/rvgen/tests/golden/da_pertask_desc/da_pertask_desc_trace.h
@@ -5,11 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_DA_PERTASK_DESC
-DEFINE_EVENT(event_da_monitor_id, event_da_pertask_desc,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(id, state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor_id, error_da_pertask_desc,
-	     TP_PROTO(int id, char *state, char *event),
-	     TP_ARGS(id, state, event));
+DEFINE_DA_EVENT_ID(event_da_pertask_desc);
+DEFINE_DA_ERROR_ID(error_da_pertask_desc);
 #endif /* CONFIG_RV_MON_DA_PERTASK_DESC */
diff --git a/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu_trace.h b/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu_trace.h
index 074ddff6a60d..374c5daa9c30 100644
--- a/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu_trace.h
+++ b/tools/verification/rvgen/tests/golden/ha_percpu/ha_percpu_trace.h
@@ -5,15 +5,7 @@
  */
 
 #ifdef CONFIG_RV_MON_HA_PERCPU
-DEFINE_EVENT(event_da_monitor, event_ha_percpu,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor, error_ha_percpu,
-	     TP_PROTO(char *state, char *event),
-	     TP_ARGS(state, event));
-
-DEFINE_EVENT(error_env_da_monitor, error_env_ha_percpu,
-	     TP_PROTO(char *state, char *event, char *env),
-	     TP_ARGS(state, event, env));
+DEFINE_DA_EVENT(event_ha_percpu);
+DEFINE_DA_ERROR(error_ha_percpu);
+DEFINE_HA_ERROR_ENV(error_env_ha_percpu);
 #endif /* CONFIG_RV_MON_HA_PERCPU */
diff --git a/tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask_trace.h b/tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask_trace.h
index ebd53621a5b1..34eb6cda2026 100644
--- a/tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask_trace.h
+++ b/tools/verification/rvgen/tests/golden/ltl_pertask/ltl_pertask_trace.h
@@ -5,10 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_LTL_PERTASK
-DEFINE_EVENT(event_ltl_monitor_id, event_ltl_pertask,
-	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
-	     TP_ARGS(task, states, atoms, next));
-DEFINE_EVENT(error_ltl_monitor_id, error_ltl_pertask,
-	     TP_PROTO(struct task_struct *task),
-	     TP_ARGS(task));
+DEFINE_LTL_EVENT_ID(event_ltl_pertask);
+DEFINE_LTL_ERROR_ID(error_ltl_pertask);
 #endif /* CONFIG_RV_MON_LTL_PERTASK */
diff --git a/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_trace.h b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_trace.h
index b984208838c4..580de388f415 100644
--- a/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_trace.h
+++ b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_trace.h
@@ -5,10 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_TEST_BAK_KUNIT
-DEFINE_EVENT(event_ltl_monitor_id, event_test_bak_kunit,
-	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
-	     TP_ARGS(task, states, atoms, next));
-DEFINE_EVENT(error_ltl_monitor_id, error_test_bak_kunit,
-	     TP_PROTO(struct task_struct *task),
-	     TP_ARGS(task));
+DEFINE_LTL_EVENT_ID(event_test_bak_kunit);
+DEFINE_LTL_ERROR_ID(error_test_bak_kunit);
 #endif /* CONFIG_RV_MON_TEST_BAK_KUNIT */
diff --git a/tools/verification/rvgen/tests/golden/test_da/test_da_trace.h b/tools/verification/rvgen/tests/golden/test_da/test_da_trace.h
index 8bd67115d244..77107e1033ac 100644
--- a/tools/verification/rvgen/tests/golden/test_da/test_da_trace.h
+++ b/tools/verification/rvgen/tests/golden/test_da/test_da_trace.h
@@ -5,11 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_TEST_DA
-DEFINE_EVENT(event_da_monitor, event_test_da,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor, error_test_da,
-	     TP_PROTO(char *state, char *event),
-	     TP_ARGS(state, event));
+DEFINE_DA_EVENT(event_test_da);
+DEFINE_DA_ERROR(error_test_da);
 #endif /* CONFIG_RV_MON_TEST_DA */
diff --git a/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_trace.h b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_trace.h
index 16804a79e834..8ef5c32e9224 100644
--- a/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_trace.h
+++ b/tools/verification/rvgen/tests/golden/test_da_kunit/test_da_kunit_trace.h
@@ -5,11 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_TEST_DA_KUNIT
-DEFINE_EVENT(event_da_monitor, event_test_da_kunit,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor, error_test_da_kunit,
-	     TP_PROTO(char *state, char *event),
-	     TP_ARGS(state, event));
+DEFINE_DA_EVENT(event_test_da_kunit);
+DEFINE_DA_ERROR(error_test_da_kunit);
 #endif /* CONFIG_RV_MON_TEST_DA_KUNIT */
diff --git a/tools/verification/rvgen/tests/golden/test_ha/test_ha_trace.h b/tools/verification/rvgen/tests/golden/test_ha/test_ha_trace.h
index 381bafcb3322..77623246b4b6 100644
--- a/tools/verification/rvgen/tests/golden/test_ha/test_ha_trace.h
+++ b/tools/verification/rvgen/tests/golden/test_ha/test_ha_trace.h
@@ -5,15 +5,7 @@
  */
 
 #ifdef CONFIG_RV_MON_TEST_HA
-DEFINE_EVENT(event_da_monitor_id, event_test_ha,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(id, state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor_id, error_test_ha,
-	     TP_PROTO(int id, char *state, char *event),
-	     TP_ARGS(id, state, event));
-
-DEFINE_EVENT(error_env_da_monitor_id, error_env_test_ha,
-	     TP_PROTO(int id, char *state, char *event, char *env),
-	     TP_ARGS(id, state, event, env));
+DEFINE_DA_EVENT_ID(event_test_ha);
+DEFINE_DA_ERROR_ID(error_test_ha);
+DEFINE_HA_ERROR_ENV_ID(error_env_test_ha);
 #endif /* CONFIG_RV_MON_TEST_HA */
diff --git a/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_trace.h b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_trace.h
index 6c13ee0068d3..9de08745e46e 100644
--- a/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_trace.h
+++ b/tools/verification/rvgen/tests/golden/test_ha_kunit/test_ha_kunit_trace.h
@@ -5,15 +5,7 @@
  */
 
 #ifdef CONFIG_RV_MON_TEST_HA_KUNIT
-DEFINE_EVENT(event_da_monitor_id, event_test_ha_kunit,
-	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(id, state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor_id, error_test_ha_kunit,
-	     TP_PROTO(int id, char *state, char *event),
-	     TP_ARGS(id, state, event));
-
-DEFINE_EVENT(error_env_da_monitor_id, error_env_test_ha_kunit,
-	     TP_PROTO(int id, char *state, char *event, char *env),
-	     TP_ARGS(id, state, event, env));
+DEFINE_DA_EVENT_ID(event_test_ha_kunit);
+DEFINE_DA_ERROR_ID(error_test_ha_kunit);
+DEFINE_HA_ERROR_ENV_ID(error_env_test_ha_kunit);
 #endif /* CONFIG_RV_MON_TEST_HA_KUNIT */
diff --git a/tools/verification/rvgen/tests/golden/test_ltl/test_ltl_trace.h b/tools/verification/rvgen/tests/golden/test_ltl/test_ltl_trace.h
index 3571b004c114..72609d3d5570 100644
--- a/tools/verification/rvgen/tests/golden/test_ltl/test_ltl_trace.h
+++ b/tools/verification/rvgen/tests/golden/test_ltl/test_ltl_trace.h
@@ -5,10 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_TEST_LTL
-DEFINE_EVENT(event_ltl_monitor_id, event_test_ltl,
-	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
-	     TP_ARGS(task, states, atoms, next));
-DEFINE_EVENT(error_ltl_monitor_id, error_test_ltl,
-	     TP_PROTO(struct task_struct *task),
-	     TP_ARGS(task));
+DEFINE_LTL_EVENT_ID(event_test_ltl);
+DEFINE_LTL_ERROR_ID(error_test_ltl);
 #endif /* CONFIG_RV_MON_TEST_LTL */
diff --git a/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_trace.h b/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_trace.h
index a054d5b2c0ea..039fd38dde9f 100644
--- a/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_trace.h
+++ b/tools/verification/rvgen/tests/golden/test_ltl_kunit/test_ltl_kunit_trace.h
@@ -5,10 +5,6 @@
  */
 
 #ifdef CONFIG_RV_MON_TEST_LTL_KUNIT
-DEFINE_EVENT(event_ltl_monitor_id, event_test_ltl_kunit,
-	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
-	     TP_ARGS(task, states, atoms, next));
-DEFINE_EVENT(error_ltl_monitor_id, error_test_ltl_kunit,
-	     TP_PROTO(struct task_struct *task),
-	     TP_ARGS(task));
+DEFINE_LTL_EVENT_ID(event_test_ltl_kunit);
+DEFINE_LTL_ERROR_ID(error_test_ltl_kunit);
 #endif /* CONFIG_RV_MON_TEST_LTL_KUNIT */
-- 
2.56.1

