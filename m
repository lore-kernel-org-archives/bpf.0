Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A84301B3
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826871; cv=none; b=AyWxVkqtr02GCJF/3VvFPBvVrqHgH0mh4Hmh7VopCDDEAJeLJAH8gs5/F/d6Ij+d8qt6dOcVXct9y5Wexc+UhjTGGbTBNWGVQjPTvMrjDT0jIsAI89ufi5poygZTaFzrEfqfp6P+IJROwr1Ahm8pE6x74+segy5i7xctMRymWS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826871; c=relaxed/simple;
	bh=OWC7q8wLb6/3FihOEavLfTvY2AxxNgMODatMWWOuplM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bE/IgDTFgCMW9VYTB7OcLgLi0jTe+ZDKbA78isOwfxh65GsgoVNKKAihmoV5VF8a0Vq9jKTq1JsrjvgR9H/xSBKw04mkIDSLvuobnG4j8i351hobqlvjpc33FlY1+GTsv5jgSQdSm4o6EaZRjwYOK4cKIjs+feQfq/0x1NHZnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjtDvUx1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSnV/CPK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjtDvUx1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSnV/CPK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772826868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+QhEt5URy2DIR8oMNtQgq3o4v4oSagpPMGAskLs6Ck=;
	b=OjtDvUx1tLNGRAR6D6/YV7VYv0GJt/Ta8PvCzMlLp+ntvUhNwtKwRluoVdRLCQfy9hFbDg
	n18xQbPR2H9mcV7F28e1Yu/X4HsscA/pZVsheCmTUVjo6KWweWIFe0R07lHsfamp3jTGri
	5GoEW9SteXIqEmhAfmjwUeKySUgw38Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-9hgji418PNuOIkPDirdcRg-1; Fri, 06 Mar 2026 14:54:27 -0500
X-MC-Unique: 9hgji418PNuOIkPDirdcRg-1
X-Mimecast-MFC-AGG-ID: 9hgji418PNuOIkPDirdcRg_1772826866
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836cd6dfe6so83060535e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 11:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772826866; x=1773431666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+QhEt5URy2DIR8oMNtQgq3o4v4oSagpPMGAskLs6Ck=;
        b=DSnV/CPKZ6Uyvc7laeuY1Fx1IOW8PoGAauPjGY7saOkdXowYxww0GWgXndVnJASX+A
         6lo90ShnDyA620Lnc2azffH/a+cpP/4O5ylP7J71igfDAVX2QekduWrZg0zU9qgiBJJ5
         zXP9xN/8XXrIBHE7eqKpUYSx0jFh/BHH5HOB6XskB8yzOf2eQkxNGNzUSQQ9ePH4AqHW
         mYbcQbnZBmuaV7+l0J3cvaZgYaTdKlddmlM4MQyV/IxaHM8OBkAxZPGlK2BlvJ1wOLXi
         Le3yeQHq16a4ZZ/vCwLeKY3mL9XqkK8erCVStiEaSH6DPuJlRGgYsdkS1DVCnXpVtG93
         FTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772826866; x=1773431666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+QhEt5URy2DIR8oMNtQgq3o4v4oSagpPMGAskLs6Ck=;
        b=C+drp84vDeMpbUzoShehHvRpMYiCTobIh0TNwB/8IstV68g6OQiENAVNAB5VkS+U3w
         61gzqkDYnbqxoyQhD7zK+3ZuqH/c0DBdww2Ye3VaLEXh7gvJICDx89n9m4LBRfXSCl70
         q2LechqPOf+Ld4CvqCeNCXVqP1FRzYuLVGFsi/uSHXetBaM/cx8nG/Q4/E1sHEHL+7gt
         dp8Pk1OGrpoDLCdExFTC/PU5vpx7jf196YWKp1mNGAsB9+YjKp8Vmg1YIOO3DAeq+MjF
         Ogj+vcTP/ZurB5HcN2sJDFw5YzukNe+JLCjJ3zl/p1jCjRoDwfhD/VLhI2uTyEbn0i1g
         KQxA==
X-Forwarded-Encrypted: i=1; AJvYcCX46p+i6cE96X2Wt5yrFwLOoja7GwFE8yjKWzACnuu38UHOFkPk/WT8sjvW9+/c4VDmask=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmuNXxjK3fly8MkZeK+WuCO9TYox4YA/s/lNLMy/BiEnggO7kj
	4+uE7OArjGUtpAbG17igfUzIZYePzFO/d7kSEJn8/Y+smgeq3E4zWCdaG0MRqilqkQMqF5p4nLW
	jj9ZCX5LW+Lpp6LXHyAUlGvrEVyIbYwCwj/BtCecvLWKHgAzOlw80Og==
X-Gm-Gg: ATEYQzyuXXgzqpCy6/FOfSCABf/vHR+pf0IVgq51qrDEn1fp7bXnB481e4eo8Um8S8B
	thWACKdcPNbmqXOio1bDpmmhV6i4RtF8GM2Rz3AMQ5rhie/SuydJKUY8+kscmI76krhDnbCFrLS
	4E+kPgLLonbN6eZCebucShHvyD1eFOgtw+pDomtWri4PYGoccFLm4xZ0OspC7GHLWIoWqxMWbNo
	KFISe7f5M6MnZMTDsX4HO9n0WT2qNvGN5fmpgJk2jWdYaDjlb8mCuElufUbD4GwfRyBLBOmJ786
	JTRg38ypq/CpkYn1S4pgbKibWwdWwAFSnx1TcCqh+BHhlZw/x6EU/7/E8hPqCml0IDNIDCWcpyH
	dui/WH+HGjiUIOF3w1Jg8XeiUI1AC5/POJj0w8g==
X-Received: by 2002:a05:600c:4752:b0:483:7783:537b with SMTP id 5b1f17b1804b1-4852697a593mr55972985e9.24.1772826866115;
        Fri, 06 Mar 2026 11:54:26 -0800 (PST)
X-Received: by 2002:a05:600c:4752:b0:483:7783:537b with SMTP id 5b1f17b1804b1-4852697a593mr55972745e9.24.1772826865698;
        Fri, 06 Mar 2026 11:54:25 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b75eesm48596485e9.14.2026.03.06.11.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:54:25 -0800 (PST)
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
Subject: [PATCH v4 4/4] tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu
Date: Fri,  6 Mar 2026 21:49:52 +0200
Message-ID: <20260306194953.2511960-5-costa.shul@redhat.com>
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

nr_cpus does not change at runtime, so passing it through the macro
argument is unnecessary.

Remove the argument and use the global nr_cpus instead.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/common.h        |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c  | 15 +++++++--------
 tools/tracing/rtla/src/osnoise_top.c   |  2 +-
 tools/tracing/rtla/src/timerlat.c      |  4 ++--
 tools/tracing/rtla/src/timerlat_hist.c | 16 ++++++++--------
 tools/tracing/rtla/src/timerlat_top.c  |  2 +-
 6 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 90a3c0d1dbf3..22ec436a93cc 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -110,7 +110,7 @@ struct common_params {
 
 extern int nr_cpus;
 
-#define for_each_monitored_cpu(cpu, nr_cpus, common) \
+#define for_each_monitored_cpu(cpu, common) \
 	for (cpu = 0; cpu < nr_cpus; cpu++) \
 		if (!(common)->cpus || CPU_ISSET(cpu, &(common)->monitored_cpus))
 
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 5bbec27b46a7..4181e025511a 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -244,7 +244,7 @@ static void osnoise_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -273,8 +273,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
-
+	for_each_monitored_cpu(cpu, &params->common) {
 		if (!data->hist[cpu].count)
 			continue;
 
@@ -285,7 +284,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -298,7 +297,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -314,7 +313,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -349,7 +348,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+		for_each_monitored_cpu(cpu, &params->common) {
 
 			if (!data->hist[cpu].count)
 				continue;
@@ -385,7 +384,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 672cdb254f4c..f92caea9f2e9 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -236,7 +236,7 @@ osnoise_print_stats(struct osnoise_tool *top)
 
 	osnoise_top_header(top);
 
-	for_each_monitored_cpu(i, nr_cpus, &params->common) {
+	for_each_monitored_cpu(i, &params->common) {
 		osnoise_top_print(top, i);
 	}
 
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 31c921efa7c1..8a44537e25cb 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -115,7 +115,7 @@ int timerlat_enable(struct osnoise_tool *tool)
 			return -1;
 		}
 
-		for_each_monitored_cpu(i, nr_cpus, &params->common) {
+		for_each_monitored_cpu(i, &params->common) {
 			if (save_cpu_idle_disable_state(i) < 0) {
 				err_msg("Could not save cpu idle state.\n");
 				return -1;
@@ -218,7 +218,7 @@ void timerlat_free(struct osnoise_tool *tool)
 	if (dma_latency_fd >= 0)
 		close(dma_latency_fd);
 	if (params->deepest_idle_state >= -1) {
-		for_each_monitored_cpu(i, nr_cpus, &params->common) {
+		for_each_monitored_cpu(i, &params->common) {
 			restore_cpu_idle_disable_state(i);
 		}
 	}
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index cfb745b75b8a..ee1af251c94d 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -298,7 +298,7 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -350,7 +350,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -372,7 +372,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -400,7 +400,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -428,7 +428,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -473,7 +473,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 	sum.min_thread = ~0;
 	sum.min_user = ~0;
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -620,7 +620,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+		for_each_monitored_cpu(cpu, &params->common) {
 
 			if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 				continue;
@@ -658,7 +658,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 8fad4edb0d72..cc296c9d7fe7 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -446,7 +446,7 @@ timerlat_print_stats(struct osnoise_tool *top)
 
 	timerlat_top_header(params, top);
 
-	for_each_monitored_cpu(i, nr_cpus, &params->common) {
+	for_each_monitored_cpu(i, &params->common) {
 		timerlat_top_print(top, i);
 		timerlat_top_update_sum(top, i, &summary);
 	}
-- 
2.53.0

