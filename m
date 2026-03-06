Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B536F430
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826860; cv=none; b=CXE+nz4iqAIs8IfCm7wNtZZzobygWvBjudSk3+OtmsWUrwsERXSt1GV4GcoIMscGM56CtBW3T7cyFiGmIbzd/udTm0JQRxsWpI+BfQlPof3Q180bc32+1Zi5DLclSBM0yPN11ou1xm8tWALfTJdOUe/Z+eCvFU4cx9m1L9BdXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826860; c=relaxed/simple;
	bh=S/SKHxHdcMr1QfdvIXxApGtmWBodmKNCEKaTN0iTkn4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAA6w9wlRm7HKqnIhS6MyJc5jSHHHb2/p+5YJrOygbcZTP27q9BJuGMqjespAXrSPKmM/qP4bHNQbYl1vOG4LuosEkr7841vRVSRkMAzqE4H7W2xwcC3+y9Hi9s8UXT2jG6rPH4lqCfjcXpvXU0Ee7KeZlDUJTaxyRo8Ua1Sfho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2/S4FSj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNhZ5+KL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2/S4FSj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNhZ5+KL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772826857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UCk5SXr8JRhBJjx3kalF2SaqtbteDwoDGZPqMuj8Nbw=;
	b=J2/S4FSjas95SyW2OxxxmyILUMNKrQxuHd+kbY1sMDQ7/NZZENyeFpAY/A3ox968Lq824E
	lTYHwH3YTdWpkvE98iSqau54OqL6kvpukT3AgVd8U08v9QyQX4odcw/koXUBfHySLYuvcV
	HQIzSs8883gbPx/5B0+gEE6TQ40Y/YE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-xzyeJKLJPxqxqL02aSASRA-1; Fri, 06 Mar 2026 14:54:15 -0500
X-MC-Unique: xzyeJKLJPxqxqL02aSASRA-1
X-Mimecast-MFC-AGG-ID: xzyeJKLJPxqxqL02aSASRA_1772826855
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48372facfedso85556445e9.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 11:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772826854; x=1773431654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCk5SXr8JRhBJjx3kalF2SaqtbteDwoDGZPqMuj8Nbw=;
        b=eNhZ5+KLtqks2XpJGAn/ukj09Jjr/H91HMpQ9QwJ5QL7Kf58TYzSTwnxhJfLcAefNf
         XuESED7B+yPr5UOlfqJ3MW+M2I4/Eabjt2cE38nuJQWW5pcGZQ8O5ESHfWE07L+WMPkv
         6oIrT2M4OvWhdpcSSYjB2S/rwRSMwU3Spi02tQQ8t6EaEJszvaYLvg4Qn3vDKY8sREyN
         9kzJcLtCAvrWDSguRQ//oUbrtcuEPHTfSE7EhqDKM5Nm/VLuaVERqOTdQFem/UXO3L7b
         BxzZGxnVEvfvcgs8bJa+5TEllCynxLBMKXTkvz/i3I93wjT1SDQbTXIoDXErmvAY23UT
         rwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772826854; x=1773431654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UCk5SXr8JRhBJjx3kalF2SaqtbteDwoDGZPqMuj8Nbw=;
        b=GpVdYFBeDCQiGAB18n7rjBglTiprXAQHn/41RNpXysJUTrphP9IV2i/RWFu8M1sQ+z
         RV/tjYJpNb7BFQzx8s7vVMLIPdpkqf69RWP+xpGPls52h1rFhl+6NoSdE5rFEb6w0SjI
         o2Q0biaRhNH25YzcSIO7OLPN3iNAeYvDejWf/+jqMa6r8VLJgQLAIn++IDdvYva4dldU
         dQqmoZUgLv0I6JmH7Ki0eX6FyUTH6D7eRkSH5eI1TQHam87yI1WyClr6ER/Sw1jkAFUk
         XAOGqTVxWRXX43FsYdb7J8UaNovWV5hMFjrRYTM0eMsWDOpQ1pz0tgMgJ0VlBvRN0dLE
         uZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaIMGL4Aq0wvWt0fmGwE+48mwdyH3YRC5R9nHSVFmeP6B8h7O0phil+7NScbvSF4hmqDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUQUTFspNINE7bz4u97t8p03N1sAkuO4I3M5SCpm0vGP0ovgg
	hodTrN9BH4JaElpV7HpX/YAo2I3XN3Q+4fgMo69agT8IP7gpHcmLKagRlkBVdjMbIqCm5mkNOAV
	WFfdhk4R43LtnAT743Bg5kDDhUILYrGIPa6g9diE0f6gBIxbcHxNiag==
X-Gm-Gg: ATEYQzzUGUMHOHZoXqlFYG8K17lQ2i1IfsbmHF84JIJGjO+DOKxeRq4Qtb00WBtJw8V
	GV+phAGJ1jyylWHup2xHN5Z5NRKoUD2KTlbLLq4F6+Am6ypbofXc3sGo1LG0a1hlqNoPF1U570Z
	DNy3R8BlwPfiRypfsY20Yftmw7bCHsQmBYkXfG9ngOm/H4Wv5ZSMrzjyAT7ZDJ+qjL2nUn9a/m0
	fpUNyG38ocvUpdkM9VnhMUDNQFxZEs80FcLCBtgiA7bavVreIx6Mr6h2CS8s1B05ogxGJr7CCSP
	/znoGY2sonqjVPan/sfK8yRXmruVx5qLhy974NYCgFG4etEul4pGffFyJfg4cN3UYJxTozq4iKu
	Pcp0NPOwjVn5POa5LJTwlcZCLuCOuSO1wxcRLvg==
X-Received: by 2002:a05:600c:3147:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-4852671cbebmr51861275e9.7.1772826854486;
        Fri, 06 Mar 2026 11:54:14 -0800 (PST)
X-Received: by 2002:a05:600c:3147:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-4852671cbebmr51860805e9.7.1772826853882;
        Fri, 06 Mar 2026 11:54:13 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b75eesm48596485e9.14.2026.03.06.11.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:54:13 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 1/4] tools/rtla: Consolidate nr_cpus usage across all tools
Date: Fri,  6 Mar 2026 21:49:49 +0200
Message-ID: <20260306194953.2511960-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306194953.2511960-1-costa.shul@redhat.com>
References: <20260306194953.2511960-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysconf(_SC_NPROCESSORS_CONF) (via get_nprocs_conf) reflects
cpu_possible_mask, which is fixed at boot time, so querying it
repeatedly is unnecessary.

Replace multiple calls to sysconf(_SC_NPROCESSORS_CONF) with a single
global nr_cpus variable initialized once at startup.

`#pragma once` in timerlat_u.h is needed for pre-C23 compilers to avoid
redefinition errors.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.c            |  7 +++-
 tools/tracing/rtla/src/common.h            |  2 +
 tools/tracing/rtla/src/osnoise_hist.c      |  3 --
 tools/tracing/rtla/src/osnoise_top.c       |  7 ----
 tools/tracing/rtla/src/timerlat.c          |  5 +--
 tools/tracing/rtla/src/timerlat_aa.c       |  1 -
 tools/tracing/rtla/src/timerlat_hist.c     |  3 --
 tools/tracing/rtla/src/timerlat_top.c      |  7 ----
 tools/tracing/rtla/src/timerlat_u.c        |  3 +-
 tools/tracing/rtla/src/timerlat_u.h        |  1 +
 tools/tracing/rtla/src/utils.c             | 10 +----
 tools/tracing/rtla/tests/unit/unit_tests.c | 44 ++++++++++------------
 12 files changed, 31 insertions(+), 62 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index f310b0d59ad3..a31fbaea5da6 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -5,12 +5,14 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
 #include <getopt.h>
+#include <sys/sysinfo.h>
+
 #include "common.h"
 
 struct trace_instance *trace_inst;
 volatile int stop_tracing;
+int nr_cpus;
 
 static void stop_trace(int sig)
 {
@@ -165,7 +167,7 @@ common_apply_config(struct osnoise_tool *tool, struct common_params *params)
 	}
 
 	if (!params->cpus) {
-		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
+		for (i = 0; i < nr_cpus; i++)
 			CPU_SET(i, &params->monitored_cpus);
 	}
 
@@ -213,6 +215,7 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 	bool stopped;
 	int retval;
 
+	nr_cpus = get_nprocs_conf();
 	params = ops->parse_args(argc, argv);
 	if (!params)
 		exit(1);
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index d4b3715700be..90a3c0d1dbf3 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -108,6 +108,8 @@ struct common_params {
 	struct timerlat_u_params user;
 };
 
+extern int nr_cpus;
+
 #define for_each_monitored_cpu(cpu, nr_cpus, common) \
 	for (cpu = 0; cpu < nr_cpus; cpu++) \
 		if (!(common)->cpus || CPU_ISSET(cpu, &(common)->monitored_cpus))
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 5c863e7aad28..00b8c95cbf85 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -646,9 +646,6 @@ static struct osnoise_tool
 *osnoise_init_hist(struct common_params *params)
 {
 	struct osnoise_tool *tool;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	tool = osnoise_init_tool("osnoise_hist");
 	if (!tool)
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index b7aed40fd216..9a6cd9a2470a 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -232,12 +232,8 @@ osnoise_print_stats(struct osnoise_tool *top)
 {
 	struct osnoise_params *params = to_osnoise_params(top->params);
 	struct trace_instance *trace = &top->trace;
-	static int nr_cpus = -1;
 	int i;
 
-	if (nr_cpus == -1)
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 	if (!params->common.quiet)
 		clear_terminal(trace->seq);
 
@@ -494,9 +490,6 @@ osnoise_top_apply_config(struct osnoise_tool *tool)
 struct osnoise_tool *osnoise_init_top(struct common_params *params)
 {
 	struct osnoise_tool *tool;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	tool = osnoise_init_tool("osnoise_top");
 	if (!tool)
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 9e4daed0aafc..31c921efa7c1 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -99,7 +99,7 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 int timerlat_enable(struct osnoise_tool *tool)
 {
 	struct timerlat_params *params = to_timerlat_params(tool->params);
-	int retval, nr_cpus, i;
+	int retval, i;
 
 	if (params->dma_latency >= 0) {
 		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
@@ -115,8 +115,6 @@ int timerlat_enable(struct osnoise_tool *tool)
 			return -1;
 		}
 
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 		for_each_monitored_cpu(i, nr_cpus, &params->common) {
 			if (save_cpu_idle_disable_state(i) < 0) {
 				err_msg("Could not save cpu idle state.\n");
@@ -214,7 +212,6 @@ void timerlat_analyze(struct osnoise_tool *tool, bool stopped)
 void timerlat_free(struct osnoise_tool *tool)
 {
 	struct timerlat_params *params = to_timerlat_params(tool->params);
-	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	int i;
 
 	timerlat_aa_destroy();
diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 178de60dcef9..095483375823 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -1043,7 +1043,6 @@ void timerlat_aa_destroy(void)
  */
 int timerlat_aa_init(struct osnoise_tool *tool, int dump_tasks, enum stack_format stack_format)
 {
-	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	struct timerlat_aa_context *taa_ctx;
 	int retval;
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 88211e54bc9d..3ebe41eed9f6 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1040,9 +1040,6 @@ static struct osnoise_tool
 *timerlat_init_hist(struct common_params *params)
 {
 	struct osnoise_tool *tool;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	tool = osnoise_init_tool("timerlat_hist");
 	if (!tool)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 7a00f3844f56..4105638f45c4 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -442,15 +442,11 @@ timerlat_print_stats(struct osnoise_tool *top)
 	struct timerlat_params *params = to_timerlat_params(top->params);
 	struct trace_instance *trace = &top->trace;
 	struct timerlat_top_cpu summary;
-	static int nr_cpus = -1;
 	int i;
 
 	if (params->common.aa_only)
 		return;
 
-	if (nr_cpus == -1)
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 	if (!params->common.quiet)
 		clear_terminal(trace->seq);
 
@@ -790,9 +786,6 @@ static struct osnoise_tool
 *timerlat_init_top(struct common_params *params)
 {
 	struct osnoise_tool *top;
-	int nr_cpus;
-
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	top = osnoise_init_tool("timerlat_top");
 	if (!top)
diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index ce68e39d25fd..a569fe7f93aa 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -16,7 +16,7 @@
 #include <sys/wait.h>
 #include <sys/prctl.h>
 
-#include "utils.h"
+#include "common.h"
 #include "timerlat_u.h"
 
 /*
@@ -131,7 +131,6 @@ static int timerlat_u_send_kill(pid_t *procs, int nr_cpus)
  */
 void *timerlat_u_dispatcher(void *data)
 {
-	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 	struct timerlat_u_params *params = data;
 	char proc_name[128];
 	int procs_count = 0;
diff --git a/tools/tracing/rtla/src/timerlat_u.h b/tools/tracing/rtla/src/timerlat_u.h
index 661511908957..a692331bd1c7 100644
--- a/tools/tracing/rtla/src/timerlat_u.h
+++ b/tools/tracing/rtla/src/timerlat_u.h
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#pragma once
 /*
  * Copyright (C) 2023 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
  */
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index d979159f6b70..77593718766a 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -19,7 +19,7 @@
 #include <stdio.h>
 #include <limits.h>
 
-#include "utils.h"
+#include "common.h"
 
 #define MAX_MSG_LENGTH	1024
 int config_debug;
@@ -119,14 +119,11 @@ int parse_cpu_set(char *cpu_list, cpu_set_t *set)
 {
 	const char *p;
 	int end_cpu;
-	int nr_cpus;
 	int cpu;
 	int i;
 
 	CPU_ZERO(set);
 
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 	for (p = cpu_list; *p; ) {
 		cpu = atoi(p);
 		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
@@ -577,7 +574,6 @@ int save_cpu_idle_disable_state(unsigned int cpu)
 	unsigned int nr_states;
 	unsigned int state;
 	int disabled;
-	int nr_cpus;
 
 	nr_states = cpuidle_state_count(cpu);
 
@@ -585,7 +581,6 @@ int save_cpu_idle_disable_state(unsigned int cpu)
 		return 0;
 
 	if (saved_cpu_idle_disable_state == NULL) {
-		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 		saved_cpu_idle_disable_state = calloc(nr_cpus, sizeof(unsigned int *));
 		if (!saved_cpu_idle_disable_state)
 			return -1;
@@ -662,13 +657,10 @@ int restore_cpu_idle_disable_state(unsigned int cpu)
 void free_cpu_idle_disable_states(void)
 {
 	int cpu;
-	int nr_cpus;
 
 	if (!saved_cpu_idle_disable_state)
 		return;
 
-	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
-
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		free(saved_cpu_idle_disable_state[cpu]);
 		saved_cpu_idle_disable_state[cpu] = NULL;
diff --git a/tools/tracing/rtla/tests/unit/unit_tests.c b/tools/tracing/rtla/tests/unit/unit_tests.c
index aa53f8605e36..f3c6d89e3300 100644
--- a/tools/tracing/rtla/tests/unit/unit_tests.c
+++ b/tools/tracing/rtla/tests/unit/unit_tests.c
@@ -7,8 +7,10 @@
 #include <sched.h>
 #include <limits.h>
 #include <unistd.h>
+#include <sys/sysinfo.h>
 
 #include "../../src/utils.h"
+int nr_cpus;
 
 START_TEST(test_strtoi)
 {
@@ -34,35 +36,29 @@ END_TEST
 START_TEST(test_parse_cpu_set)
 {
 	cpu_set_t set;
-	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
+	nr_cpus = 8;
 	ck_assert_int_eq(parse_cpu_set("0", &set), 0);
 	ck_assert(CPU_ISSET(0, &set));
 	ck_assert(!CPU_ISSET(1, &set));
 
-	if (nr_cpus > 2) {
-		ck_assert_int_eq(parse_cpu_set("0,2", &set), 0);
-		ck_assert(CPU_ISSET(0, &set));
-		ck_assert(CPU_ISSET(2, &set));
-	}
-
-	if (nr_cpus > 3) {
-		ck_assert_int_eq(parse_cpu_set("0-3", &set), 0);
-		ck_assert(CPU_ISSET(0, &set));
-		ck_assert(CPU_ISSET(1, &set));
-		ck_assert(CPU_ISSET(2, &set));
-		ck_assert(CPU_ISSET(3, &set));
-	}
-
-	if (nr_cpus > 5) {
-		ck_assert_int_eq(parse_cpu_set("1-3,5", &set), 0);
-		ck_assert(!CPU_ISSET(0, &set));
-		ck_assert(CPU_ISSET(1, &set));
-		ck_assert(CPU_ISSET(2, &set));
-		ck_assert(CPU_ISSET(3, &set));
-		ck_assert(!CPU_ISSET(4, &set));
-		ck_assert(CPU_ISSET(5, &set));
-	}
+	ck_assert_int_eq(parse_cpu_set("0,2", &set), 0);
+	ck_assert(CPU_ISSET(0, &set));
+	ck_assert(CPU_ISSET(2, &set));
+
+	ck_assert_int_eq(parse_cpu_set("0-3", &set), 0);
+	ck_assert(CPU_ISSET(0, &set));
+	ck_assert(CPU_ISSET(1, &set));
+	ck_assert(CPU_ISSET(2, &set));
+	ck_assert(CPU_ISSET(3, &set));
+
+	ck_assert_int_eq(parse_cpu_set("1-3,5", &set), 0);
+	ck_assert(!CPU_ISSET(0, &set));
+	ck_assert(CPU_ISSET(1, &set));
+	ck_assert(CPU_ISSET(2, &set));
+	ck_assert(CPU_ISSET(3, &set));
+	ck_assert(!CPU_ISSET(4, &set));
+	ck_assert(CPU_ISSET(5, &set));
 
 	ck_assert_int_eq(parse_cpu_set("-1", &set), 1);
 	ck_assert_int_eq(parse_cpu_set("abc", &set), 1);
-- 
2.53.0

