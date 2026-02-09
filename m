Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42AF363C7D
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629111; cv=none; b=tzMWigosXkSLKgO1OsS13mm7M1QNvUt1LOu5Cb2p+Yo+uv5PLPsAHMzf6+xYBFVJ+oW860s90yoUSwtSrtvc/OXABdBGqIh+v9M7HTwg/max7ub9xb0RdcL4OwtMvEQDyIipKBcxGQWBlwyOJg86dBC5PPGH8I2eo4LolRoMWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629111; c=relaxed/simple;
	bh=jXM6h73fi/T1NI6sc5NlsOcr2JeACiIlmwKPddXhEyc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaryT5olBvaZSvA3xNAJQymRCo24gwqbnFV9KaFfpufw1YcrMykLcm+NuzPfCvDqB202/t8qZVi0pKaFGR/ZfpqSVd1ay+5w8iygt31h9L8aMQ81BZdF33qonR3Fkmbr9ETG26+GcwePn9gO7sFJm8nMX8m07lkmtQgpFsy5+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3/Zzoaj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPHBb2wl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3/Zzoaj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPHBb2wl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770629110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrzntSVggQfVgXA1EfIrnMrsyGocXfN5hLyeRmwcLd0=;
	b=T3/ZzoajpQqp5M/+ui8wdZ1QUx8L1UbO4vFlxydB5qKd2mbp2vQzSTaEydpIMBcKC6vKNx
	vLJQj4dS2qCe0MqxaKeO/O2vIQ7idPDVHCOmnPAPtQyCTFnAX1HWVMBw0NaHw+i3jkPusw
	b+k/Ux6jkQONHc7hMldzVgLAkDTcvWY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-cjpUDyFFP2mQ1NJFQMKzmg-1; Mon, 09 Feb 2026 04:25:08 -0500
X-MC-Unique: cjpUDyFFP2mQ1NJFQMKzmg-1
X-Mimecast-MFC-AGG-ID: cjpUDyFFP2mQ1NJFQMKzmg_1770629107
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4806865a01bso41925605e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 01:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770629107; x=1771233907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrzntSVggQfVgXA1EfIrnMrsyGocXfN5hLyeRmwcLd0=;
        b=LPHBb2wlvzHU2pUC8e1YUSCfikI3hstMcfZt6H946JzTHCxq8Dekf6czPHbl+Hc119
         E16+eo741ivzeGFOcHC7D7sBYuWos1lECSj09hNum9HG3BmJTLwJUrZLYUNIA5qOMmNT
         NskLh01RN9j635jOdTlNaA6R85AzyDnxr3yjgA/kT6GTA8HQ/Y65hYPq1uV7lyKP3j2u
         0CcyoeGetKPN5lX46GYa4ZjU84K/agg5sDs9mdS/ZoUMdAbNFl2BL2U9r7C8ZaQMF7Ki
         VHm0TFGjzL3FhEjxD1VasFejZ4sLMYnrIST7D/G/WCS24sdcokfMOdkjKEGSXdu4CWX5
         c4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770629107; x=1771233907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vrzntSVggQfVgXA1EfIrnMrsyGocXfN5hLyeRmwcLd0=;
        b=l8YRNCcWxC55BVHQ0iFQUyiTb8Vnsd++glyY5KpTsk1o8UJUeM4Cr9s7IyZr6KzFU8
         lZ99Y6Cab+EQnwSuwEiNXZdgY4XUcpOKOgAipL/6x8vbu1DAccVtfK2HKuqQS95qVsuh
         gK0qDiCGwvyCpOaXqx3u6hY6eJMXHQxd1b5lgtAClI7XxECmqrI6PVDz2SEtckWHL5oi
         g7UpdgUjhVNKf2QBOVbefmE7Pl2Q/MArIXvOMAPuEPNnuYvhcvlqt7ZwwV56n7GIyutj
         Qch4K7wWgkp7cJKGlBvbAF+8ySiDBlLbFCPbZDj9L3zDUQs+zhuCoywmWnpKLV8yAybi
         Hsjw==
X-Forwarded-Encrypted: i=1; AJvYcCXq5DkyVvtZPl53w/GN9IMd00XzzG390qe6Y65giVtm5uzuXUfYbz3/dCY662GYj6+Stl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYs1pU0xH7uOELAhKG6RRltXdw6g8mi7GFDxiOZGv3pSaVJWw
	EtmH0Xj6/ZkT3QKnKdnaVvDxIZam+ahJE1sgNQEvZNa8nwqLTJoUyAM9CcGDJCEISsCfTjGbXNm
	bqaWXNO8bSKZgbQnDQSDncISE+4Nr+4yGsnQuZiAdtr+FlzLDVaB1rQ==
X-Gm-Gg: AZuq6aKhcne6S0rZb7itdV/o4CmQsD5mryljT/PB5w3spdafJwewcJ+K+69QTovYtjq
	3pkObCTE29amU52J7Uk/wQTgtoEtPjr8RwAglmGzbwciKp5Nm9ovbQrF9NuxfiTRhvnfYiYMWpb
	vRcyLV6jEmU/2KbFVZNzfCu1/0j+Gj5RB0UzumOfmlTuFB/cZ3RdgLKaarVkghvFoQ/yMxWGW+7
	nSfLE37P/jzdGrWnGWrV4tF26CBwXkVCJiZCNW3LW6pyxBu3BMPrlsRBEwFS/qva6z7Z9qOV3xL
	kzVWlBm2dHk2st3STZ+smlowijVDpPPpa4D7xs8XkA/4+T9KjG75A0Bba08ycPOlVnBLZ+RbdLu
	Wk73MvXzwuVP3uDdXlTwpq3I9Bg==
X-Received: by 2002:a05:600c:5307:b0:480:4a4f:c36f with SMTP id 5b1f17b1804b1-4832096671dmr160891275e9.21.1770629107337;
        Mon, 09 Feb 2026 01:25:07 -0800 (PST)
X-Received: by 2002:a05:600c:5307:b0:480:4a4f:c36f with SMTP id 5b1f17b1804b1-4832096671dmr160890915e9.21.1770629106883;
        Mon, 09 Feb 2026 01:25:06 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d33f5fsm316310295e9.5.2026.02.09.01.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:25:06 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 4/4] tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu
Date: Mon,  9 Feb 2026 11:24:36 +0200
Message-ID: <20260209092436.2899888-5-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209092436.2899888-1-costa.shul@redhat.com>
References: <20260209092436.2899888-1-costa.shul@redhat.com>
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
index 32f9c1351209..28d258d6d178 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -109,7 +109,7 @@ struct common_params {
 
 extern int nr_cpus;
 
-#define for_each_monitored_cpu(cpu, nr_cpus, common) \
+#define for_each_monitored_cpu(cpu, common) \
 	for (cpu = 0; cpu < nr_cpus; cpu++) \
 		if (!(common)->cpus || CPU_ISSET(cpu, &(common)->monitored_cpus))
 
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 90291504a1aa..e8f07108d39a 100644
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
index 6fb3e72d74f2..ab5db35f21ae 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -236,7 +236,7 @@ osnoise_print_stats(struct osnoise_tool *top)
 
 	osnoise_top_header(top);
 
-	for_each_monitored_cpu(i, nr_cpus, &params->common) {
+	for_each_monitored_cpu(i, &params->common) {
 		osnoise_top_print(top, i);
 	}
 
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 69856f677fce..ec14abd45fff 100644
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
index 4bf1489cad23..db66312ec966 100644
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
index 4eb820fe1f21..ed3d3d1c8956 100644
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
2.52.0

