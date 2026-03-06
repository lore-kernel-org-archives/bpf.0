Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF3F7081E
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826864; cv=none; b=GRalKlr7AFSd3fjiBP82EZBL0YOP4QkOl8E47swTGZz7rB0UAYj8Y5mHjRz9yJip6agFlwk09TwvmKTBuBxDrJITY7pnb4vvFzcZhg1kjoAvRU3wCB95QhUzjLyuGbm85xmIxzY3tPPZOToqnLFQZso5G5MGRlgKELLLpSKVtIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826864; c=relaxed/simple;
	bh=eIx0WUCThzc1Mhd7tZA/tvw0jMl5/Z7DBQ1leSDTcY8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJfzpd4MiyWET0OHGcWU1Crq/vRXUk3uXg8jdhbgsUG9jQajIZ3x9znfT/dn7ve36SQf4Gcoaq6G5Or2XGEoNoJBbWcVLkpA03wC/k9OShc/vT6tHAIjw+0VrInc1arii6plb+nxrlnny7/3rScY5IB4tZ4VP0xU4mk+WXodU/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEzZ6xPc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbtelPOX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEzZ6xPc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbtelPOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772826861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DvYpwDJsCCEBALyiCy6MGzM+CIB2BT5my2pAupEVpA=;
	b=UEzZ6xPcAZ4ua97YTf7x5bIzFhB3DkXNiGVH3qv94Z9ZUqreVpYIJaitafFH9Q0sKpZ9iH
	xxc6pEj+TcdFnfmi9HmC6OnlbXXDUMKlUxGSnJlEM3kmKw2ose+igkgrmmZCn3iE27ZsMS
	eWjXpODXQ3HnusY0SRc7I5aVpFBkU80=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-khrKicU3MBib-KH5h-UOxw-1; Fri, 06 Mar 2026 14:54:20 -0500
X-MC-Unique: khrKicU3MBib-KH5h-UOxw-1
X-Mimecast-MFC-AGG-ID: khrKicU3MBib-KH5h-UOxw_1772826859
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836ff58111so101578725e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 11:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772826859; x=1773431659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DvYpwDJsCCEBALyiCy6MGzM+CIB2BT5my2pAupEVpA=;
        b=RbtelPOXNaIl5isfcx0WE/oYJUNLEyT4IwOwsnUf3lTsWMpmrv9rPZG7LAxw6GhiHy
         3AT3GUM8rv58LP6xmx5tqj52uCrBs0z4WXGN4T4ter5OzA+LKenB4CzvjX1qZf0/dOtk
         JNxTUsMOGTxUcF/UP1sccdMQcZI+glsYZe5GFp6grQNapT3U8tKVg2G3RYejPxNS6k1u
         LtLt1j5FNDVK/ySXYKjPzIXZOhdkp81NIvCux52TMqv110xYK0Sod5hcRJHPnNHTEQUA
         Xq6x2IoY8c+tZK7x2iaBDXjTdL2FyKcDNL7bwcrBMjWdzR9l+rnSZ40tyTIqR10Zzy4U
         hXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772826859; x=1773431659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4DvYpwDJsCCEBALyiCy6MGzM+CIB2BT5my2pAupEVpA=;
        b=tYrMGdq+c2y5UJEFiXJAKeHO1M3giPnz5sHssJvlPGoqgwKlJW8Ul52gXb1t7QfXh3
         4Ceswj+oEC12dkTr5294Kbpi5UFMiNGjvhAHSFAjUO3yIXGVxxYC+0Sz75UGcsx5COd6
         MrrFS0HmcXSbeeoXJg3qXv0H39vLV6GJc+VirfafB1cEDWDYhG5nw4nG3NpvLGPLRDls
         rKVsyLJPmFVRCFbEXjuPpr5TKRiFsjrOCUzTD4vUMxe9LzzSAgTn8CK/oSzeAtb9ufnk
         en69IwDkb8oFy2uEv5jfkTRHfvtjdcxyES4XeJxMSelNE9ciB/JQvnvLDfNRLHOWjqOV
         CsRg==
X-Forwarded-Encrypted: i=1; AJvYcCUwfp8mxKWLZWpVIr0C4kHG36WmBGyXTz2KFKhF8FE0RXe9t7UVt2ZgcEEYcNmfQCLrVwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeyKEH0T5snC8MdZHCxGIP6kmgxm3Yo04zZSZZmwWXTmpM08e+
	GgX4EOqTQxDHWBCe3swIYjob/hoU/N4Xvumh0W6vFUGvxi4mp+XTbPbInmJAoMdCDCLU5UKpif2
	K6A9ryGrkkxaFzPB/GET48F0+KRkCh5Iq/wrD4AegehRZkyzf97rwVA==
X-Gm-Gg: ATEYQzzTpaQDmDQA9bXTcHKrVXFxNVjieA8FOvCzhL2sASvPRIhe8bYfSntXC6Uy/C4
	YxxWOEJlY8vKzG/6QckoaglS5ViyDZcruH53T70VmPlesI7RoDX30Jg/BqmZc93zsXgw1t1cnIq
	ofTDlCvZmCZSGq2Gmhxvf5bUSSjiKVJ+6TaYF4Bv0IkZ3qOOv9BtCNCrQv1zQ9Sx8YBffM3EuCO
	bJP9OVQ9O7sldeYVGI8wiUXuS1RfboaQlUMMasW+UDPWNqyzJm09pUxcy9Sp9zkxpjMa8UV37Nw
	KsWOY6qxZLHJFB7/ZEIz9DKg6YWumERJ4xBmz5gEBNrpgtU0HEfavKyp6NdP3bnIwj+zEsVZVTM
	v9t2mDMmxPTm7bwWaaKykJCBnZ3rTJsawyw780A==
X-Received: by 2002:a05:600c:c088:b0:483:79a6:e7e1 with SMTP id 5b1f17b1804b1-48526919935mr51129825e9.7.1772826858733;
        Fri, 06 Mar 2026 11:54:18 -0800 (PST)
X-Received: by 2002:a05:600c:c088:b0:483:79a6:e7e1 with SMTP id 5b1f17b1804b1-48526919935mr51129545e9.7.1772826858229;
        Fri, 06 Mar 2026 11:54:18 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b75eesm48596485e9.14.2026.03.06.11.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:54:17 -0800 (PST)
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
Subject: [PATCH v4 2/4] tools/rtla: Remove unneeded nr_cpus arguments
Date: Fri,  6 Mar 2026 21:49:50 +0200
Message-ID: <20260306194953.2511960-3-costa.shul@redhat.com>
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

nr_cpus does not change at runtime, so passing it through function
arguments is unnecessary.

Use the global nr_cpus instead of propagating it via parameters.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  |  4 ++--
 tools/tracing/rtla/src/osnoise_top.c   |  4 ++--
 tools/tracing/rtla/src/timerlat_bpf.c  | 19 ++++++++-----------
 tools/tracing/rtla/src/timerlat_bpf.h  | 12 ++++--------
 tools/tracing/rtla/src/timerlat_hist.c | 21 ++++++++-------------
 tools/tracing/rtla/src/timerlat_top.c  | 19 +++++++------------
 tools/tracing/rtla/src/timerlat_u.c    |  6 +++---
 7 files changed, 34 insertions(+), 51 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 00b8c95cbf85..f39f60d3b00e 100644
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
@@ -651,7 +651,7 @@ static struct osnoise_tool
 	if (!tool)
 		return NULL;
 
-	tool->data = osnoise_alloc_histogram(nr_cpus, params->hist.entries,
+	tool->data = osnoise_alloc_histogram(params->hist.entries,
 					     params->hist.bucket_size);
 	if (!tool->data)
 		goto out_err;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 9a6cd9a2470a..3a241b69f622 100644
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
 
@@ -495,7 +495,7 @@ struct osnoise_tool *osnoise_init_top(struct common_params *params)
 	if (!tool)
 		return NULL;
 
-	tool->data = osnoise_alloc_top(nr_cpus);
+	tool->data = osnoise_alloc_top();
 	if (!tool->data) {
 		osnoise_destroy_tool(tool);
 		return NULL;
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 05adf18303df..dd3cf71d74e5 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -147,24 +147,23 @@ static int get_value(struct bpf_map *map_irq,
 		     int key,
 		     long long *value_irq,
 		     long long *value_thread,
-		     long long *value_user,
-		     int cpus)
+		     long long *value_user)
 {
 	int err;
 
 	err = bpf_map__lookup_elem(map_irq, &key,
 				   sizeof(unsigned int), value_irq,
-				   sizeof(long long) * cpus, 0);
+				   sizeof(long long) * nr_cpus, 0);
 	if (err)
 		return err;
 	err = bpf_map__lookup_elem(map_thread, &key,
 				   sizeof(unsigned int), value_thread,
-				   sizeof(long long) * cpus, 0);
+				   sizeof(long long) * nr_cpus, 0);
 	if (err)
 		return err;
 	err = bpf_map__lookup_elem(map_user, &key,
 				   sizeof(unsigned int), value_user,
-				   sizeof(long long) * cpus, 0);
+				   sizeof(long long) * nr_cpus, 0);
 	if (err)
 		return err;
 	return 0;
@@ -176,13 +175,12 @@ static int get_value(struct bpf_map *map_irq,
 int timerlat_bpf_get_hist_value(int key,
 				long long *value_irq,
 				long long *value_thread,
-				long long *value_user,
-				int cpus)
+				long long *value_user)
 {
 	return get_value(bpf->maps.hist_irq,
 			 bpf->maps.hist_thread,
 			 bpf->maps.hist_user,
-			 key, value_irq, value_thread, value_user, cpus);
+			 key, value_irq, value_thread, value_user);
 }
 
 /*
@@ -191,13 +189,12 @@ int timerlat_bpf_get_hist_value(int key,
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
+			 key, value_irq, value_thread, value_user);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
index 169abeaf4363..531c9ef16f51 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.h
+++ b/tools/tracing/rtla/src/timerlat_bpf.h
@@ -23,13 +23,11 @@ int timerlat_bpf_restart_tracing(void);
 int timerlat_bpf_get_hist_value(int key,
 				long long *value_irq,
 				long long *value_thread,
-				long long *value_user,
-				int cpus);
+				long long *value_user);
 int timerlat_bpf_get_summary_value(enum summary_field key,
 				   long long *value_irq,
 				   long long *value_thread,
-				   long long *value_user,
-				   int cpus);
+				   long long *value_user);
 int timerlat_load_bpf_action_program(const char *program_path);
 static inline int have_libbpf_support(void) { return 1; }
 #else
@@ -45,16 +43,14 @@ static inline int timerlat_bpf_restart_tracing(void) { return -1; };
 static inline int timerlat_bpf_get_hist_value(int key,
 					      long long *value_irq,
 					      long long *value_thread,
-					      long long *value_user,
-					      int cpus)
+					      long long *value_user)
 {
 	return -1;
 }
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
index 3ebe41eed9f6..7e735b62488c 100644
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
@@ -211,7 +211,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 	/* Pull histogram */
 	for (i = 0; i < data->entries; i++) {
 		err = timerlat_bpf_get_hist_value(i, value_irq, value_thread,
-						  value_user, data->nr_cpus);
+						  value_user);
 		if (err)
 			return err;
 		for (j = 0; j < data->nr_cpus; j++) {
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
@@ -1045,7 +1040,7 @@ static struct osnoise_tool
 	if (!tool)
 		return NULL;
 
-	tool->data = timerlat_alloc_histogram(nr_cpus, params->hist.entries,
+	tool->data = timerlat_alloc_histogram(params->hist.entries,
 					      params->hist.bucket_size);
 	if (!tool->data)
 		goto out_err;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 4105638f45c4..994e89a57cd3 100644
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
@@ -791,7 +786,7 @@ static struct osnoise_tool
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
2.53.0

