Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E130835CBAA
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983593; cv=none; b=M63yDtXz/uI1kD2sn5LWhW7SFRU+ddvO8Vc9u82+u1Z6OLe2MFNLQbHqvaYR8CkGjqdb+E5YffNO0cVI1/pPbFt1LlrLa/DWgBF1kb4d79XrSnxaFFuEkJjWDcXsqyi0AAYJqe4TpeAawnCHe14VVD/pxMeowktu+UcriZ95+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983593; c=relaxed/simple;
	bh=jXM6h73fi/T1NI6sc5NlsOcr2JeACiIlmwKPddXhEyc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRGU9IPnhHuYIS2eqBvFKTxKDJr1Mkl/zkwky6foAaFBUrbTgG+bUXS4vHsZ05vWiAQGsxJ4+U2s+VVvCCMImAsvtZKks3qvdwKcse5ily6Kt8i4aPN2kdj8qxEZTcD7c7lIEXdugN/VfKeo9x9E2VMnBwP/TsGdOG4bcZPSULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHQ4yFmf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScC7mzel; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHQ4yFmf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScC7mzel"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770983591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrzntSVggQfVgXA1EfIrnMrsyGocXfN5hLyeRmwcLd0=;
	b=fHQ4yFmfP9+oeRicat5VTr7LiQOH8g3shd6jSAz14YcMolzfJ80aZ93PFpMR/Dj4tiM5lO
	cMrzDMFdHsc0jfy/jGPktNEMBfJo/5lo2jevAVCNCZ+gEbQZWtL9ZtGku5vVWcE+ePYUJ1
	6cECKNf6BayJBJPP4CyKe9ak7b5X7UY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-9oWoEp69N76WU4JzuaXblw-1; Fri, 13 Feb 2026 06:53:09 -0500
X-MC-Unique: 9oWoEp69N76WU4JzuaXblw-1
X-Mimecast-MFC-AGG-ID: 9oWoEp69N76WU4JzuaXblw_1770983589
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836abfc742so5731025e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 03:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770983588; x=1771588388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrzntSVggQfVgXA1EfIrnMrsyGocXfN5hLyeRmwcLd0=;
        b=ScC7mzelmlRr3wEhPuMFwWGjk5SAnRtA1D/PllFmLp5JgZr0s/jUYOYLpZu8xdjXJc
         II7pPWno/t+7Nf9yJTv/4dQJiK7b6S3xe/pish/VId4PRuG4mwQl43WsKBfBHigySShl
         FR9DeA25Kmwfu4ufOhmXs4qGYVDRvlG02lu9k50TZg0o99hyrZiVUPkpIeX557IqHbi5
         1o/x5rkEMlldQnBIkxFlQ60pp/O9i5EixpjvhpB71uB7RFUXyBas/svjAUMsrGldrBjE
         FNIp6NedJHLKiUiVTHtsknfngX9boOUGO+ylSGWOgp3cGN/ak89z7wbVk51IDdRtJKGP
         SNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770983588; x=1771588388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vrzntSVggQfVgXA1EfIrnMrsyGocXfN5hLyeRmwcLd0=;
        b=reWlk/QRGnM54iZY3TTZUwEbQRCGksg51K9XeRN2k5VMy4Qk2eKokpwaTkopacq4uE
         JrlaVCj6M/nGCsHSHyemeqeXC84/CrDp76rNyK0lLHi5PQ/IMnHvUy0ze5nl5WCTgcBE
         4ubbLqmh6m1AhIBaGz6oQc8F/2OIBrnyx1JyzqGT+mQHhbDuHnoz1Vsug5zh91VVEV4l
         hkOECtEMox+WxKdOIRzTXYlv+8M2HM79mA5PKZzyrULEu3TZem3tfEQbzbQDhlvSovA7
         fWJIasNMcZkW4gTKMWbEJotWUd6TJ6T2PG2UDI4zl4zIlWVCbXdcJW82ncjy5INe3Ff4
         2BaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTGS4IaBGlyWRauiXYQ80M3tQyJfzyPUtJ2yp68njukyUnm49R7LFDm3F2Gnznvpqv3T0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcaZNrHY5hCjQhDBGZXIDo2XgWIk8Z8LQp52f9eaYf0BWa5cdr
	esMhXUFrZ/LgP/Uu62M4VKCgKg9GnsK5a0a5R0sMkVXbNnfOg+ve9C/S3ykUP2X3m1riMSzVm2D
	9Na/bf/wmHR8MA+gIzbAvBCRDSDkzKU+VXvWKx99W9dsv2yLBVFxxng==
X-Gm-Gg: AZuq6aJxOeqiMUNX1VLFGSp1E3zxPpyRkpOb5lSqwuZzjZ0Sw5N99ZG0vhLKyVFdOtq
	6QcV32gFZ6+HVyMaJjBQ7UaH4zw6mqu5vqpkIxhsXkI9PDILRN5pyxYKLlNBtzgmRYQpQ1nQ19m
	mIOZoRuCjObDyZSkWijK1LHEzaJtbQB92FDGOg/7QAZqPnCkjfqO6zQtJEAgW/QFJllb+iDhA2/
	1FeC1hzhUFZNCQj0vi6CQkwMAtK1WxMcr5UUbSpvOcFfGD7ySaCBjuI9f4yhzViaRH8DxZG8aaU
	iybeaWwNo03eFfiuIbP6DcEUIkEwYMr7Wmvq6prSTo5b4zEzNkvSJyEOn0ldJQc2uqOZi8xjYwa
	ysUNZGCXVTGCIyqwX+Rs8ozx5KrZ+OM0woaU=
X-Received: by 2002:a05:600c:45cc:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-48373a6c1f8mr21763865e9.35.1770983588496;
        Fri, 13 Feb 2026 03:53:08 -0800 (PST)
X-Received: by 2002:a05:600c:45cc:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-48373a6c1f8mr21763435e9.35.1770983588037;
        Fri, 13 Feb 2026 03:53:08 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm234671275e9.14.2026.02.13.03.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:53:07 -0800 (PST)
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
Subject: [PATCH v3 4/5] tools/rtla: Remove unneeded nr_cpus from for_each_monitored_cpu
Date: Fri, 13 Feb 2026 13:52:33 +0200
Message-ID: <20260213115234.430232-5-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213115234.430232-1-costa.shul@redhat.com>
References: <20260213115234.430232-1-costa.shul@redhat.com>
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

