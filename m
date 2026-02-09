Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59743115B0
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629105; cv=none; b=KVlpXkqrTj4fOCfExxbbMggbeKh9CZHPcxXhSPYrZeqMUeurBpOAodih22vuHxjMM+OSBastonTHG+5/oRzXC5Y+RYwEfP5PvQhj8cmtSWGi4fcy60oexGgY/VLMAk/ZSdNRp5q3nnO7y3PqAuumgvEpgmDG0qr7AmBUXMga2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629105; c=relaxed/simple;
	bh=0GS+sGsKXEzx+jNnjrXhGcR2pmtCanW/2A8zyqvNC+o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmMiiZL3NwxRctlDcCPLsfCMwuTSGTJ++rH+Yq2ybicoo7eEBmTIFbXWW31nB1OIjFoCURifWj5rtKimzjr2G4PRBP1GzYmrdnsg1P1w3ZRxDiXvP0yR5wgRhWroY5qNdyDjqfcK8X/QOFSwboW1s52kCBGiBVwRkxCe7Kqqw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePc2rX1f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtgZcJtO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePc2rX1f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtgZcJtO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770629103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brymhXOpcI8ZGOoB0rH9K+9PTJHbZxRRnQAyHzspC9M=;
	b=ePc2rX1fkFmluZSCr4JFuRK3PHEQZsF+rbzknVNvz7pRwVh5kL77Ng4SJiC7TiJ2Ka0TL9
	1yT428UWfQ4IRAAjnjGpoj13a2MlpAJZrDtQhLSVpZkwSpd11KHEqYMSVE10uoya81CrZA
	U4aYoEMp80rNJiOe3HiDkULKF9AtTWU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-x18UxpwFM5CmsdhBV7FoDA-1; Mon, 09 Feb 2026 04:25:02 -0500
X-MC-Unique: x18UxpwFM5CmsdhBV7FoDA-1
X-Mimecast-MFC-AGG-ID: x18UxpwFM5CmsdhBV7FoDA_1770629101
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4831192e66aso38100505e9.2
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 01:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770629101; x=1771233901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brymhXOpcI8ZGOoB0rH9K+9PTJHbZxRRnQAyHzspC9M=;
        b=QtgZcJtOZxMRAJKkzenNud1JcUhiKJJSTVH4+UHtIfi4Cvv2vEjOwPiJSbGDhEDud0
         xvWarobtsz1dmKFtqIHQTkIAmYZa97+0nCo8bNerCC3fOCJzT7odtxGQfsvH7TCv1MJI
         eAM15DHwECd3cr3G++v97vfsBnZOvzTccIeoAt9w9lJOGxGLcUyMhVWXTNeCYkod0atz
         qXksHDFrXVdbCpf0Zn65H0QvcRDaXtOVsCCxLX0U+KAT/kpDwqxLscdcDOq47rvAEizh
         lcU6GYpcmgygq+LawfSxJdi+Txn7hLCCw6T5iWs/G5nhozzUye2ipDJTDQhxdZz1NI39
         /neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770629101; x=1771233901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=brymhXOpcI8ZGOoB0rH9K+9PTJHbZxRRnQAyHzspC9M=;
        b=B0k3r4Q0pI4SEu5HQ6R/w4DiKwSnJO4q41yzuWoSz3aULDkelQv1s/HMgUbo6M1R/i
         aMbImHkyYAqJxPYLhjufoCKkt0S51lZjPzCkFELWWFZoc8Mb81/QxC4ukI/5RP1oUo83
         2M5nx1VQQVhoIhIKEgl5Lhi3n3DVz+0uHDGTCK2rL1Y5GBbmXKz3mxFZPxzN/uzt4rsA
         qFfWRFRJGBFyQCC+au6BiR8qLgTFBDJIgp7px0+7lPFiaIfnvyJuvc1MEQzBCME9FweD
         Gv8K+KVkNkZwI5DO9xMwiXniWXF/aouHupqF3ta17FjDIh8F/Jm+F5OpCosLO4l0dpjm
         WHkg==
X-Forwarded-Encrypted: i=1; AJvYcCWIahLwxXUNpD9eSu5zUe2WKHj0DWizBwX3K13fA+bVekdI20RU+Hdf/fdMAN5t3c8imJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSzmK0IUR6badeYRfWPha5TY4FUKKusyna16by3l/snG2bCa2d
	NBrK8v4UpiNrvg8gW1UDfqdJaWetbSTUla4Bgo2OB4ZhPQM+1Nm1NVzCpzm+IOXVpGcrK7oS3sG
	GpiqeabprhdEAX3pjxuP3+t2Ptygi5qWUuC8v3o39o72+6g/DmYkzuw==
X-Gm-Gg: AZuq6aL+jQkMGXJIsai1djCXoZFmSvZL5a2UsA+d7yrZtmfK1mPLRTC/YU3Hg9+8dwH
	HGpvNzpXaISPXz8iRLzRzIZaO4Jkbla+wDOIfBvKKZzQ+znQ/CZWTWrTqEWaNWGDoFS9ClMmLJX
	NWW0IM+X/msarNYHX94GF/U2kzIVwkFyW8+aXrvvWjHaH+CuJCCoDr1Zzserw1/Xhs7algd8QOk
	Mu8NK9ElnAlUPzgymh8cyWVD3QgfBrzbSuDVJwEVCQvVljjw3QJfjOehNpwRiyC7tSZy/kdGrYy
	qbqwIxhqbgOswLCLIxmif0m6XD/tUHS3UfNCIVOOd+6yN3+C2/ibwUGFISKC4FzM2Px9aWpaiTl
	z4BDydHsvYHHz/wVmgIZd+nOsLw==
X-Received: by 2002:a05:600c:5488:b0:480:1e8f:d15f with SMTP id 5b1f17b1804b1-483201d5fa2mr138959935e9.2.1770629100993;
        Mon, 09 Feb 2026 01:25:00 -0800 (PST)
X-Received: by 2002:a05:600c:5488:b0:480:1e8f:d15f with SMTP id 5b1f17b1804b1-483201d5fa2mr138959655e9.2.1770629100577;
        Mon, 09 Feb 2026 01:25:00 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d33f5fsm316310295e9.5.2026.02.09.01.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:25:00 -0800 (PST)
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
Subject: [PATCH v2 2/4] tools/rtla: Remove unneeded nr_cpus arguments
Date: Mon,  9 Feb 2026 11:24:34 +0200
Message-ID: <20260209092436.2899888-3-costa.shul@redhat.com>
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

nr_cpus does not change at runtime, so passing it through function
arguments is unnecessary.

Use the global nr_cpus instead of propagating it via parameters.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  |  4 ++--
 tools/tracing/rtla/src/osnoise_top.c   |  4 ++--
 tools/tracing/rtla/src/timerlat_bpf.c  |  5 ++---
 tools/tracing/rtla/src/timerlat_bpf.h  |  6 ++----
 tools/tracing/rtla/src/timerlat_hist.c | 19 +++++++------------
 tools/tracing/rtla/src/timerlat_top.c  | 19 +++++++------------
 tools/tracing/rtla/src/timerlat_u.c    |  6 +++---
 7 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 03ebff34fff4..d83ee047a5f5 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -62,7 +62,7 @@ static void osnoise_free_hist_tool(struct osnoise_tool *tool)
  * osnoise_alloc_histogram - alloc runtime data
  */
 static struct osnoise_hist_data
-*osnoise_alloc_histogram(int nr_cpus, int entries, int bucket_size)
+*osnoise_alloc_histogram(int entries, int bucket_size)
 {
 	struct osnoise_hist_data *data;
 	int cpu;
@@ -652,7 +652,7 @@ static struct osnoise_tool
 	if (!tool)
 		return NULL;
 
-	tool->data = osnoise_alloc_histogram(nr_cpus, params->hist.entries,
+	tool->data = osnoise_alloc_histogram(params->hist.entries,
 					     params->hist.bucket_size);
 	if (!tool->data)
 		goto out_err;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 7dcd2e318205..73b3ac0dd43b 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -51,7 +51,7 @@ static void osnoise_free_top_tool(struct osnoise_tool *tool)
 /*
  * osnoise_alloc_histogram - alloc runtime data
  */
-static struct osnoise_top_data *osnoise_alloc_top(int nr_cpus)
+static struct osnoise_top_data *osnoise_alloc_top(void)
 {
 	struct osnoise_top_data *data;
 
@@ -496,7 +496,7 @@ struct osnoise_tool *osnoise_init_top(struct common_params *params)
 	if (!tool)
 		return NULL;
 
-	tool->data = osnoise_alloc_top(nr_cpus);
+	tool->data = osnoise_alloc_top();
 	if (!tool->data) {
 		osnoise_destroy_tool(tool);
 		return NULL;
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 05adf18303df..8d5c3a095e41 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -191,13 +191,12 @@ int timerlat_bpf_get_hist_value(int key,
 int timerlat_bpf_get_summary_value(enum summary_field key,
 				   long long *value_irq,
 				   long long *value_thread,
-				   long long *value_user,
-				   int cpus)
+				   long long *value_user)
 {
 	return get_value(bpf->maps.summary_irq,
 			 bpf->maps.summary_thread,
 			 bpf->maps.summary_user,
-			 key, value_irq, value_thread, value_user, cpus);
+			 key, value_irq, value_thread, value_user, nr_cpus);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
index 169abeaf4363..f4a5476f2abb 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.h
+++ b/tools/tracing/rtla/src/timerlat_bpf.h
@@ -28,8 +28,7 @@ int timerlat_bpf_get_hist_value(int key,
 int timerlat_bpf_get_summary_value(enum summary_field key,
 				   long long *value_irq,
 				   long long *value_thread,
-				   long long *value_user,
-				   int cpus);
+				   long long *value_user);
 int timerlat_load_bpf_action_program(const char *program_path);
 static inline int have_libbpf_support(void) { return 1; }
 #else
@@ -53,8 +52,7 @@ static inline int timerlat_bpf_get_hist_value(int key,
 static inline int timerlat_bpf_get_summary_value(enum summary_field key,
 						 long long *value_irq,
 						 long long *value_thread,
-						 long long *value_user,
-						 int cpus)
+						 long long *value_user)
 {
 	return -1;
 }
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 841118ed84f2..dee5fbf622c3 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -83,7 +83,7 @@ static void timerlat_free_histogram_tool(struct osnoise_tool *tool)
  * timerlat_alloc_histogram - alloc runtime data
  */
 static struct timerlat_hist_data
-*timerlat_alloc_histogram(int nr_cpus, int entries, int bucket_size)
+*timerlat_alloc_histogram(int entries, int bucket_size)
 {
 	struct timerlat_hist_data *data;
 	int cpu;
@@ -223,8 +223,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 
 	/* Pull summary */
 	err = timerlat_bpf_get_summary_value(SUMMARY_COUNT,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -234,8 +233,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_MIN,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -245,8 +243,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_MAX,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -256,8 +253,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_SUM,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -267,8 +263,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_OVERFLOW,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -1036,7 +1031,7 @@ static struct osnoise_tool
 	if (!tool)
 		return NULL;
 
-	tool->data = timerlat_alloc_histogram(nr_cpus, params->hist.entries,
+	tool->data = timerlat_alloc_histogram(params->hist.entries,
 					      params->hist.bucket_size);
 	if (!tool->data)
 		goto out_err;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 3e395ce4fa9f..25b4d81b4fe0 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -62,7 +62,7 @@ static void timerlat_free_top_tool(struct osnoise_tool *tool)
 /*
  * timerlat_alloc_histogram - alloc runtime data
  */
-static struct timerlat_top_data *timerlat_alloc_top(int nr_cpus)
+static struct timerlat_top_data *timerlat_alloc_top(void)
 {
 	struct timerlat_top_data *data;
 	int cpu;
@@ -196,8 +196,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 
 	/* Pull summary */
 	err = timerlat_bpf_get_summary_value(SUMMARY_CURRENT,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -207,8 +206,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_COUNT,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -218,8 +216,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_MIN,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -229,8 +226,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_MAX,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -240,8 +236,7 @@ static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
 	}
 
 	err = timerlat_bpf_get_summary_value(SUMMARY_SUM,
-					     value_irq, value_thread, value_user,
-					     data->nr_cpus);
+					     value_irq, value_thread, value_user);
 	if (err)
 		return err;
 	for (i = 0; i < data->nr_cpus; i++) {
@@ -782,7 +777,7 @@ static struct osnoise_tool
 	if (!top)
 		return NULL;
 
-	top->data = timerlat_alloc_top(nr_cpus);
+	top->data = timerlat_alloc_top();
 	if (!top->data)
 		goto out_err;
 
diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index a569fe7f93aa..03b4e68e8b1e 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -99,7 +99,7 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
  *
  * Return the number of processes that received the kill.
  */
-static int timerlat_u_send_kill(pid_t *procs, int nr_cpus)
+static int timerlat_u_send_kill(pid_t *procs)
 {
 	int killed = 0;
 	int i, retval;
@@ -169,7 +169,7 @@ void *timerlat_u_dispatcher(void *data)
 
 		/* parent */
 		if (pid == -1) {
-			timerlat_u_send_kill(procs, nr_cpus);
+			timerlat_u_send_kill(procs);
 			debug_msg("Failed to create child processes");
 			pthread_exit(&retval);
 		}
@@ -196,7 +196,7 @@ void *timerlat_u_dispatcher(void *data)
 		sleep(1);
 	}
 
-	timerlat_u_send_kill(procs, nr_cpus);
+	timerlat_u_send_kill(procs);
 
 	while (procs_count) {
 		pid = waitpid(-1, &wstatus, 0);
-- 
2.52.0

