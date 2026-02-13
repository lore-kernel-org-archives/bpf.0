Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E2B352C39
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983587; cv=none; b=F8aNU4rW2K+swC3TNkEoijWZOjB/YAZ0fFjbgVOxnqfGDBgVvHzizTDPvQy7RzQVlYKmIY49Tw4PiVCESLq2AYsI2Q0z6VsGgOT2Jht4l9FJbvLr1+gnkS8IdYpaIvlQJk4zhtR2TiOEa187+ej/iwf9ogqqU/x4k4WRr6Y30vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983587; c=relaxed/simple;
	bh=0GS+sGsKXEzx+jNnjrXhGcR2pmtCanW/2A8zyqvNC+o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0PJmWNPpfseTjHUMSDMDgN9wL1Pb271mMg67ySkmblyf7yJzYpEwZyqzJJu+xb6CYmb/0SdUtzan1+3M9rIqzro2JHgx3wb+ooiDIeiJWqJEkm4goRVRQ/zg/dR/1SzvJnylXXEpxp3NcQlVuCZukX2zF9IuVDac8j80LKUf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDCqIWDj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tlYxrYjH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDCqIWDj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tlYxrYjH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770983584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brymhXOpcI8ZGOoB0rH9K+9PTJHbZxRRnQAyHzspC9M=;
	b=QDCqIWDj71v67h0ChLfkjzcaQxTvEyvFLI/StUXR6AqklaZQUkSdQ1HFKQCPXZ4UDe9PA9
	Fi5SXBH8jvykT6ocat/yY/tLbReYmkS4DwXuPXJHCLSht9yghE8Mue4deZp1OjYjUmMqKn
	KrR/B6PFn3VIy/i7ByZNGIO+RzNse5E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-okqUs4yLPeaRP9kQ9g6tfQ-1; Fri, 13 Feb 2026 06:53:03 -0500
X-MC-Unique: okqUs4yLPeaRP9kQ9g6tfQ-1
X-Mimecast-MFC-AGG-ID: okqUs4yLPeaRP9kQ9g6tfQ_1770983582
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso12293165e9.2
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 03:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770983582; x=1771588382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brymhXOpcI8ZGOoB0rH9K+9PTJHbZxRRnQAyHzspC9M=;
        b=tlYxrYjHr5q8A0AEDpEMux++HskmFsHbZp8o1FpsWpuzP+jKolM5Z0zrhd7/0GMcFI
         9u1ZSFjNuD1R2veLR2MfVFsivHc03nkLcE0RUBrRh7BPU3PN+AbxBKAPKnltOSVYHkB3
         hoNZWHydlVWFHnlZRB105xe1GA8KAQowXGHD2w4WpmCQRKd3fUYos2pR8Wt7U8Uxgitz
         4UEWPmnzxYC1/ikNjxwXoOX1WY7tffdczkr4hyD4PEwkyScMEd+vipXmlhoNdFy/Nax5
         tdOOhkEDXvMelQxjDTG7B7Q+NjgTXRl7+WILbVokI33bZdX07zagNzpWrDKd7DOxuDFo
         d3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770983582; x=1771588382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=brymhXOpcI8ZGOoB0rH9K+9PTJHbZxRRnQAyHzspC9M=;
        b=njFpTA/WkbsVFtkQ5U6CEVslNNBVZo+W/o0PQskyOFiIgiCsLer6MAgNmPhYcN+G6a
         KY+7qpxay3ENA9Wmbb0hc0gMqjrrDWpNq39zTVxNof746vIBb6Lm3Zg7Gfa9riYwx4KA
         zKF4Sqex5gZLMUC5v5bKwbVwSlJM12Wz7U0tfD6BiWKnq5c7OAWDRsO0t3AUpFvxB8Gx
         1fiYvw90lyaIp1UTbBB3a5wNwr0maIqj9/WnXyxc0j8YVNTFFO4x12aMCMiCYxJ366wT
         +bWB+B1XVkEYpvLbTkAPlSM/If2sMwkrXdNHINC30vBk8sONggUwor5bIMpNqtUe9MxM
         IN0g==
X-Forwarded-Encrypted: i=1; AJvYcCUkvvdYS44xB579IxK845t8EgL83XlOzv07ydEfTZeumAhcnZfz29fHs3LIjsLn65mF4uc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxwq+ikj51SXQ+2WUBfomhW5rvWfQgNYvqT6HvwjbVdxPv78gj
	tHR+DGHpseL5ol5P5nBEUcyT/CDFkSS4KcZ+3LQPWGIZwGyuPXR/Pd3ZQLS52WC3PD1QgP8gx+Y
	fgC3kqywraRgulZVnExKh88K6G8nrErRVniksBG+HdLMpt+LrjVbvgw==
X-Gm-Gg: AZuq6aLneUW7i/Jrev8eUYmEAgkq92xeDtn11oxsvW3KiRRaa6l9AKS1hhfPP0S/INS
	uHoBVm/34OrW2RQTkynYcY0SuMzLtyZ+FTBtGnKHrZnQO+aSxSMa78pSots1KWiP2n70qJhDwlv
	1lBvAnlHwu5OyZYC5ssYgX+0LNxZg2hLz6ifa0PiM6j4dwhOKNAgpg2RrMiuycumTp9Sz3xmv8D
	a1fvgBjn54mhgg2Ao3XsL3XFs/zKTNPVTWxwFcgKlKrCiJP+iqs6XcXwajGTTZgL41myftUsN+z
	z/diK2h5jkN7PQR4b2z2RKiwBYYzWfjzW68IyPcCw9Oysxsilw18dT5OQYvMXX4qfTgRmS3Y0dC
	pY6YQ2GXMI5PC9sq8d75QFBNDVzn684kxvVk=
X-Received: by 2002:a05:600c:5296:b0:482:eec4:74c with SMTP id 5b1f17b1804b1-48373a5d771mr22090195e9.22.1770983581811;
        Fri, 13 Feb 2026 03:53:01 -0800 (PST)
X-Received: by 2002:a05:600c:5296:b0:482:eec4:74c with SMTP id 5b1f17b1804b1-48373a5d771mr22089795e9.22.1770983581338;
        Fri, 13 Feb 2026 03:53:01 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm234671275e9.14.2026.02.13.03.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:53:00 -0800 (PST)
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
Subject: [PATCH v3 2/5] tools/rtla: Remove unneeded nr_cpus arguments
Date: Fri, 13 Feb 2026 13:52:31 +0200
Message-ID: <20260213115234.430232-3-costa.shul@redhat.com>
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

