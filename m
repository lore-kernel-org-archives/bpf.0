Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35CB363C5F
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629109; cv=none; b=ZkpOXF1XpojtfZGymN5EcZpsIr7qPqdz1rcDx3px31VuJd50VJZbUsxkJkPX+klnM7BaqwkABNX2gTH5VzJ/wvhWgyt2fTXhwtx0Y+DFlFncvnpCwAWs9WCUrBy01dzSHeawKIEgYdfZhJaMF+kQLs9EFeWFTm/psjpl1MElbww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629109; c=relaxed/simple;
	bh=w5dKFS5R1t7rYrQ20YIX0+7bdom2BHUqpe/9dlSUrLY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIU2aLSRIfDc8bzbi5YxI8h6v4GxOC22J49eu/RmizQAkvZjprP5167/eKNMiuFqtQfmLGCU3uqCxkNp8VRMa9tlhGA0F/6S2CMd0IpzFkx9sAB1dF2WvCnWOy85AItKjn+62qU8aadBKiwuJW8p/EBrifMXtgR3Tz63v5fxZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGDN69Vi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yy7hqXDZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGDN69Vi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yy7hqXDZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770629107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kx32wyrFkPDhCGYWgA3ZxyjG0SxAKZ8Fjt/kqUocyos=;
	b=YGDN69ViyF3UN1BggnKGjeNtAqym0L6LfjHZ4K2932VsZP/C2ltuBYwdQEm1OB+lVximzG
	MgpqINF+Hp7btW/0SFvemwZmxnJAIKa/D9cizJH88zzwnuL96Molz14iBi5MUe+ljyZ+rP
	jRwNgPAL4D3uzfqT8iJNORjTny13ons=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-tDGiHNpCPrOq99azoBMktg-1; Mon, 09 Feb 2026 04:25:06 -0500
X-MC-Unique: tDGiHNpCPrOq99azoBMktg-1
X-Mimecast-MFC-AGG-ID: tDGiHNpCPrOq99azoBMktg_1770629105
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso44459295e9.2
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 01:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770629105; x=1771233905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kx32wyrFkPDhCGYWgA3ZxyjG0SxAKZ8Fjt/kqUocyos=;
        b=Yy7hqXDZ38BLWSUtUiKabOyBtoKoUhaCEefEp6eXCfLN32nysyuJq2wVCpqTaB/8t7
         /4yJlD14trnZfjkHOdn7wtWbgAmUeZS4Fr7j8WWJaoX5YHmbGgvYeG9sxmTF1y6t88Sz
         uaBhN9EyFg7gumpbIKJQmEJpIsZQxmMyOauzulbxo8PwrZVamcnYp91VZz8bNwMbk/vm
         eZRLeEr3m7NIX/6Rs0qJI+QUot0sxKt5qGE+AeJp9ZJgUwWpg/emCsYUIzNWu03OsmNW
         PU4MeQG/NrsyOxBf8cewZp9Vls0cd8qY/S5Ef9aZjBzlHId1XFyshXACMVTxDNU+1NIF
         uIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770629105; x=1771233905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kx32wyrFkPDhCGYWgA3ZxyjG0SxAKZ8Fjt/kqUocyos=;
        b=dshMwhpJg41ECNoloT+cQVyHjOt0VRdzky+J9k+iKJX56v+unCdaS1G4AEJkQAsjhT
         EWwnide49Qyq8DeZJ5ptJ9MOBKYB3iABCJhXQeg8LowvIFH7CY9O5AVUchq5UqWf4D9G
         UlxBtifZNksTrkjYyI0q7bigxpy77jxlMH7hhh0Q91FTxOR6nV1XqisgPtY+VD06fIlm
         H4J5YcU7a9w7NTxMoXV7amVQaDvYvbW8JkqVngmmb38NFMKgdVDzY6qTG/U2zbpuBlfi
         N0s0T0sMNlvEAB7lD0X5n9Pyf0zz3aN9Tr7TJlbwMhxeO/DTC3p+/7ZbFsBIXTRCy/l9
         n9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9PNCb+Vv98F9txbtFI0otYrLPbBUJN/XIbFZJNwPKpWboGFsqTI+r13B8Mw4UzHQDKvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJjWpOgPjp+s70teEe1uFr0ri6dnQ7n2k6k3C7jCRu+DlGgV72
	fFA9Mk+k5cNxrFfHwPYpfrRTTcKTsIzeqHW0l9noFWCEJE6fSngWmk9o/SLqcpCyOfW9WhZWPgC
	ywE5eOvx4UZFIj7s1S+b1QuPuiTmpewNwgbZrlv/Ho47LxtMJQpIXRQ==
X-Gm-Gg: AZuq6aJKtGRdSrH4zZe+5wUQ1eiQbZH8JVLWo+1nZs0RiAAjmVeGdSHI7lkdzPkvcsj
	Orq354cIfCmvS3gWJjbHScewYVGErq6VtctXH1VOh0Yj1Q3Cr4m8jHpFyNrgq/z9N7sWDgRFZ8W
	NAY1waWYzOvTGbMdfe0jcOU28wgqPqKHGjJQjBTReJNArhPmMB3OwUUOjwoxoWk9wGUJPFsPtT4
	hBLcT5UkabqGUIDcYpunBdorURtQs2dczP/e/XW3SXykIprXjhQwLFpuUysu+/hWtYGB7H7gQmu
	zQHMglv6SPNSWoM7bpjo9QWePmHUfMSp24dW+gTwYvWCrJ2QTuOA2D1dbsS1aeOA00SBbkMB2Mn
	baI/mplcTq4LLHvdceuy10b6zvg==
X-Received: by 2002:a05:600c:1d16:b0:483:1ed8:75d4 with SMTP id 5b1f17b1804b1-483201effc4mr139203075e9.15.1770629104738;
        Mon, 09 Feb 2026 01:25:04 -0800 (PST)
X-Received: by 2002:a05:600c:1d16:b0:483:1ed8:75d4 with SMTP id 5b1f17b1804b1-483201effc4mr139202545e9.15.1770629104111;
        Mon, 09 Feb 2026 01:25:04 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d33f5fsm316310295e9.5.2026.02.09.01.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:25:03 -0800 (PST)
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
Subject: [PATCH v2 3/4] tools/rtla: Remove unneeded nr_cpus members
Date: Mon,  9 Feb 2026 11:24:35 +0200
Message-ID: <20260209092436.2899888-4-costa.shul@redhat.com>
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

