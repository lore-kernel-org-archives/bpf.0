Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C326350D48
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983591; cv=none; b=QwzOcL/RhDD0wH8+hYbOSKJv0RkkPtr9VQBnRCQQ71/ciZh1/1I+xdR/rLY1/CN6xoLsiY7abKuBSbeoY6ud3VQwJKVAhlPNwtKQOgGNhjXnumVg+b593lviemTGKaz4KjEuhjFJ5l2Vio3+5UViC1OL9gqY1Dlp8zu62P+dK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983591; c=relaxed/simple;
	bh=w5dKFS5R1t7rYrQ20YIX0+7bdom2BHUqpe/9dlSUrLY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLloppAvhzOU3H3zZn6NF3zaHRb/smcsq5XXzx8ozEESYJI1wD6mW4tUpfpkkIn7QnGjllHeTQ+Z2BRRKjXrZ/rXZdxRZDvQHyBrmm5Zu/3bELQm/e6xxLk+VWuIqXfQipvZIrC1BIBkx1vtteRUvikLCNPhbnvRqPtXExlempE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTk8Lbbs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rx0vyNPK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTk8Lbbs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rx0vyNPK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770983588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kx32wyrFkPDhCGYWgA3ZxyjG0SxAKZ8Fjt/kqUocyos=;
	b=NTk8LbbsxXGstVHd8vV6uPJXG34n0TNXAQktextox91AY3WRMjCg+xrNn2X0blcrr/2EcN
	ZGixtI1ojLbCx+/MZrUtt2+hoa57F3NkA7uwKrVVk8jd3ZTRjd5Qdw7G7V/LYzaI58dqQB
	qk7EIJ5WYJRGDUfVJ47C9UpHvscIv4k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-Y81d-WkZMnGRpC7KMEBEHw-1; Fri, 13 Feb 2026 06:53:07 -0500
X-MC-Unique: Y81d-WkZMnGRpC7KMEBEHw-1
X-Mimecast-MFC-AGG-ID: Y81d-WkZMnGRpC7KMEBEHw_1770983586
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836fbfa35cso5077015e9.1
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 03:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770983586; x=1771588386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kx32wyrFkPDhCGYWgA3ZxyjG0SxAKZ8Fjt/kqUocyos=;
        b=rx0vyNPKiTJZSgvwL8LNCF4TNzLgereHFpho/tKLu8DD44JHIvdMCuYFRHF6jr+xHh
         wJT/UUbgcMWhSR+9nIQL9v7GOC2dzn2nmO0VlYrjhNSynoIqviJyPgv86q/iJvmTIQPO
         9TEm1NbXXLNUFltdnnr42Ym9Vja4bXkb8bSKbojHAHR+pEHU9oo/jx72LOdRL6mikkJg
         ngC5jBv+skb8XJnPpsf+xR8UJQ9m58ia3nD1oOtp53ehWlPcyYwTht0I+HqA3Zyc8nrF
         YLCZMWNTyT5xE3WWOs5d9t4CGlWFdd68tyj9bj+S5DqO5nZ0vlPvmKVyn5PbCU7r0qF9
         yM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770983586; x=1771588386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kx32wyrFkPDhCGYWgA3ZxyjG0SxAKZ8Fjt/kqUocyos=;
        b=vexfNIOgxVGFBoYYtjtSu3Ne5PhI/kD0t4twG9j041ONc7hpEIGF1szB2xtqhmJYyR
         1AAxGlAnsNAesLpp8qGcxnZnf5ujcetv6M+BtHkZDUPFs6bVeoEjtu9Vp/w8+6JulCTi
         IHu9hOJEoEwAc+S8+/S39HKXwzQc2+fLvDmEcw+HXcV4s27F8co4TqmtvGc4ym25izbG
         Uowd1j+iiGCyVpnQIzhcUoSWm1DcMqlGlXsKe893+9fxwSLQSJ6+ZVk5Fr+HEeuJhA+E
         D3p1TjnuFCfn/A5m2QxUz8G4m/0ozK+UgL4kscMpfEq9P6jOyqOBJHzFLcVdtegI31hg
         WEFA==
X-Forwarded-Encrypted: i=1; AJvYcCXdOfhpSJcG8Htak6ZOz8szHSV9/rljpSNfT/30SuJf3MW8zggnNNRSbsnd3JYm2MD2qRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmeys2bBIbThRCKcLZ9U5+uwgk0rfiWef8WJHpX4OY4sGwn9dn
	GKMXTgHcKEYY0NTxdS26ui5j7jP6hrEEcwQ93d9llg40c9qXk8kVjfto92eiCRhj5Eu+Kp6S+cb
	tO1RRrirAIzUhyz/IdRNc3+nf7tlB6HyQQaqzhXNr06BErtNOjqByjw==
X-Gm-Gg: AZuq6aIpjd8+MntKgU1hqUF0ct7OXfGsrBEIpwVwYVatz7o7IG752uCvxAkHAJ35ixv
	Yi3AjT2pz8w72VNXZXQc/f6avzG9DPFKCinKS+OMH4ILul3fYdgOZWueog5JMkuLuLf6XIrfmpJ
	c3tm9Py+tsWklndbr4qYtTqnL8KO4u9UWVH9tj6DyhYwKr0D2jBJERg8vHXZMBLq6wen01FLtMC
	nLC9S5HKghG3gaIp1UclDiP9YSqmtA5D6ZsLn93lGLe3lZWyhfwnJ2rIu/QpWZsrn1ty0E1MpBE
	UACERmSDY8WZOaJVuq4kOpbbLCcedHtFGJLQwgMbpo97FrFV5v1zpJA9ii9w3OawF7TJF8qlKJO
	YeJdMXVnDvqs2ngs488wbLHHxwwaFHkYeKNY=
X-Received: by 2002:a05:600c:8706:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-48373a58a97mr22578605e9.35.1770983585893;
        Fri, 13 Feb 2026 03:53:05 -0800 (PST)
X-Received: by 2002:a05:600c:8706:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-48373a58a97mr22578295e9.35.1770983585422;
        Fri, 13 Feb 2026 03:53:05 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm234671275e9.14.2026.02.13.03.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:53:05 -0800 (PST)
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
Subject: [PATCH v3 3/5] tools/rtla: Remove unneeded nr_cpus members
Date: Fri, 13 Feb 2026 13:52:32 +0200
Message-ID: <20260213115234.430232-4-costa.shul@redhat.com>
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

nr_cpus does not change at runtime, so keeping it in struct members is
unnecessary.

Use the global nr_cpus instead of struct members.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 18 ++++++------
 tools/tracing/rtla/src/osnoise_top.c   |  3 --
 tools/tracing/rtla/src/timerlat_aa.c   | 10 +++----
 tools/tracing/rtla/src/timerlat_hist.c | 40 ++++++++++++--------------
 tools/tracing/rtla/src/timerlat_top.c  | 19 ++++++------
 5 files changed, 39 insertions(+), 51 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index d83ee047a5f5..90291504a1aa 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -29,7 +29,6 @@ struct osnoise_hist_data {
 	struct osnoise_hist_cpu	*hist;
 	int			entries;
 	int			bucket_size;
-	int			nr_cpus;
 };
 
 /*
@@ -41,7 +40,7 @@ osnoise_free_histogram(struct osnoise_hist_data *data)
 	int cpu;
 
 	/* one histogram for IRQ and one for thread, per CPU */
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		if (data->hist[cpu].samples)
 			free(data->hist[cpu].samples);
 	}
@@ -73,7 +72,6 @@ static struct osnoise_hist_data
 
 	data->entries = entries;
 	data->bucket_size = bucket_size;
-	data->nr_cpus = nr_cpus;
 
 	data->hist = calloc(1, sizeof(*data->hist) * nr_cpus);
 	if (!data->hist)
@@ -246,7 +244,7 @@ static void osnoise_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -275,7 +273,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -287,7 +285,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -300,7 +298,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -316,7 +314,7 @@ osnoise_print_summary(struct osnoise_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
@@ -351,7 +349,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+		for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 			if (!data->hist[cpu].count)
 				continue;
@@ -387,7 +385,7 @@ osnoise_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].count)
 			continue;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 73b3ac0dd43b..6fb3e72d74f2 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -31,7 +31,6 @@ struct osnoise_top_cpu {
 
 struct osnoise_top_data {
 	struct osnoise_top_cpu	*cpu_data;
-	int			nr_cpus;
 };
 
 /*
@@ -59,8 +58,6 @@ static struct osnoise_top_data *osnoise_alloc_top(void)
 	if (!data)
 		return NULL;
 
-	data->nr_cpus = nr_cpus;
-
 	/* one set of histograms per CPU */
 	data->cpu_data = calloc(1, sizeof(*data->cpu_data) * nr_cpus);
 	if (!data->cpu_data)
diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 5766d58709eb..59b219a1503e 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -102,7 +102,6 @@ struct timerlat_aa_data {
  * The analysis context and system wide view
  */
 struct timerlat_aa_context {
-	int nr_cpus;
 	int dump_tasks;
 
 	/* per CPU data */
@@ -738,7 +737,7 @@ void timerlat_auto_analysis(int irq_thresh, int thread_thresh)
 	irq_thresh = irq_thresh * 1000;
 	thread_thresh = thread_thresh * 1000;
 
-	for (cpu = 0; cpu < taa_ctx->nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		taa_data = timerlat_aa_get_data(taa_ctx, cpu);
 
 		if (irq_thresh && taa_data->tlat_irq_latency >= irq_thresh) {
@@ -766,7 +765,7 @@ void timerlat_auto_analysis(int irq_thresh, int thread_thresh)
 
 	printf("\n");
 	printf("Printing CPU tasks:\n");
-	for (cpu = 0; cpu < taa_ctx->nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		taa_data = timerlat_aa_get_data(taa_ctx, cpu);
 		tep = taa_ctx->tool->trace.tep;
 
@@ -792,7 +791,7 @@ static void timerlat_aa_destroy_seqs(struct timerlat_aa_context *taa_ctx)
 	if (!taa_ctx->taa_data)
 		return;
 
-	for (i = 0; i < taa_ctx->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		taa_data = timerlat_aa_get_data(taa_ctx, i);
 
 		if (taa_data->prev_irqs_seq) {
@@ -842,7 +841,7 @@ static int timerlat_aa_init_seqs(struct timerlat_aa_context *taa_ctx)
 	struct timerlat_aa_data *taa_data;
 	int i;
 
-	for (i = 0; i < taa_ctx->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 
 		taa_data = timerlat_aa_get_data(taa_ctx, i);
 
@@ -1031,7 +1030,6 @@ int timerlat_aa_init(struct osnoise_tool *tool, int dump_tasks)
 
 	__timerlat_aa_ctx = taa_ctx;
 
-	taa_ctx->nr_cpus = nr_cpus;
 	taa_ctx->tool = tool;
 	taa_ctx->dump_tasks = dump_tasks;
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index dee5fbf622c3..4bf1489cad23 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -44,7 +44,6 @@ struct timerlat_hist_data {
 	struct timerlat_hist_cpu	*hist;
 	int				entries;
 	int				bucket_size;
-	int				nr_cpus;
 };
 
 /*
@@ -56,7 +55,7 @@ timerlat_free_histogram(struct timerlat_hist_data *data)
 	int cpu;
 
 	/* one histogram for IRQ and one for thread, per CPU */
-	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		if (data->hist[cpu].irq)
 			free(data->hist[cpu].irq);
 
@@ -94,7 +93,6 @@ static struct timerlat_hist_data
 
 	data->entries = entries;
 	data->bucket_size = bucket_size;
-	data->nr_cpus = nr_cpus;
 
 	/* one set of histograms per CPU */
 	data->hist = calloc(1, sizeof(*data->hist) * nr_cpus);
@@ -204,17 +202,17 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 {
 	struct timerlat_hist_data *data = tool->data;
 	int i, j, err;
-	long long value_irq[data->nr_cpus],
-		  value_thread[data->nr_cpus],
-		  value_user[data->nr_cpus];
+	long long value_irq[nr_cpus],
+		  value_thread[nr_cpus],
+		  value_user[nr_cpus];
 
 	/* Pull histogram */
 	for (i = 0; i < data->entries; i++) {
 		err = timerlat_bpf_get_hist_value(i, value_irq, value_thread,
-						  value_user, data->nr_cpus);
+						  value_user, nr_cpus);
 		if (err)
 			return err;
-		for (j = 0; j < data->nr_cpus; j++) {
+		for (j = 0; j < nr_cpus; j++) {
 			data->hist[j].irq[i] = value_irq[j];
 			data->hist[j].thread[i] = value_thread[j];
 			data->hist[j].user[i] = value_user[j];
@@ -226,7 +224,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].irq_count = value_irq[i];
 		data->hist[i].thread_count = value_thread[i];
 		data->hist[i].user_count = value_user[i];
@@ -236,7 +234,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].min_irq = value_irq[i];
 		data->hist[i].min_thread = value_thread[i];
 		data->hist[i].min_user = value_user[i];
@@ -246,7 +244,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].max_irq = value_irq[i];
 		data->hist[i].max_thread = value_thread[i];
 		data->hist[i].max_user = value_user[i];
@@ -256,7 +254,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].sum_irq = value_irq[i];
 		data->hist[i].sum_thread = value_thread[i];
 		data->hist[i].sum_user = value_user[i];
@@ -266,7 +264,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->hist[i].irq[data->entries] = value_irq[i];
 		data->hist[i].thread[data->entries] = value_thread[i];
 		data->hist[i].user[data->entries] = value_user[i];
@@ -300,7 +298,7 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(s, "Index");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -352,7 +350,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "count:");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -374,7 +372,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "min:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -402,7 +400,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "avg:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -430,7 +428,7 @@ timerlat_print_summary(struct timerlat_params *params,
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "max:  ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -475,7 +473,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 	sum.min_thread = ~0;
 	sum.min_user = ~0;
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
@@ -622,7 +620,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 			trace_seq_printf(trace->seq, "%-6d",
 					 bucket * data->bucket_size);
 
-		for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+		for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 			if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 				continue;
@@ -660,7 +658,7 @@ timerlat_print_stats(struct osnoise_tool *tool)
 	if (!params->common.hist.no_index)
 		trace_seq_printf(trace->seq, "over: ");
 
-	for_each_monitored_cpu(cpu, data->nr_cpus, &params->common) {
+	for_each_monitored_cpu(cpu, nr_cpus, &params->common) {
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 25b4d81b4fe0..4eb820fe1f21 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -41,7 +41,6 @@ struct timerlat_top_cpu {
 
 struct timerlat_top_data {
 	struct timerlat_top_cpu	*cpu_data;
-	int			nr_cpus;
 };
 
 /*
@@ -71,8 +70,6 @@ static struct timerlat_top_data *timerlat_alloc_top(void)
 	if (!data)
 		return NULL;
 
-	data->nr_cpus = nr_cpus;
-
 	/* one set of histograms per CPU */
 	data->cpu_data = calloc(1, sizeof(*data->cpu_data) * nr_cpus);
 	if (!data->cpu_data)
@@ -190,16 +187,16 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 {
 	struct timerlat_top_data *data = tool->data;
 	int i, err;
-	long long value_irq[data->nr_cpus],
-		  value_thread[data->nr_cpus],
-		  value_user[data->nr_cpus];
+	long long value_irq[nr_cpus],
+		  value_thread[nr_cpus],
+		  value_user[nr_cpus];
 
 	/* Pull summary */
 	err = timerlat_bpf_get_summary_value(SUMMARY_CURRENT,
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].cur_irq = value_irq[i];
 		data->cpu_data[i].cur_thread = value_thread[i];
 		data->cpu_data[i].cur_user = value_user[i];
@@ -209,7 +206,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].irq_count = value_irq[i];
 		data->cpu_data[i].thread_count = value_thread[i];
 		data->cpu_data[i].user_count = value_user[i];
@@ -219,7 +216,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].min_irq = value_irq[i];
 		data->cpu_data[i].min_thread = value_thread[i];
 		data->cpu_data[i].min_user = value_user[i];
@@ -229,7 +226,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].max_irq = value_irq[i];
 		data->cpu_data[i].max_thread = value_thread[i];
 		data->cpu_data[i].max_user = value_user[i];
@@ -239,7 +236,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
-	for (i = 0; i < data->nr_cpus; i++) {
+	for (i = 0; i < nr_cpus; i++) {
 		data->cpu_data[i].sum_irq = value_irq[i];
 		data->cpu_data[i].sum_thread = value_thread[i];
 		data->cpu_data[i].sum_user = value_user[i];
-- 
2.52.0

