Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C7350D48
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983597; cv=none; b=XtOugnAGap5LIkPZ6N2T9HZHu6mdmpoJY0mTFS0dG5Y8Qm88jDSfQH54ZIi0DHEh2s9menjiaDvEmyy09oAj22HqbYdc+LWHkOwYUxjwRuwvvXiOnKmqBvSo4NepDzIxBWRpEAwSMvO8CYi2XYAdVVYMjyQH83SOIRdoohoZv5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983597; c=relaxed/simple;
	bh=2ZVTZcJEQvp9j4d2P5a9LlD36iiY34YfpFu/m0+lLq4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScI71bY/tZ5DLZxXf/uaTPozie3mtRVUs5a3yc6T1d3gb2+nKcD9I1vKTes68vorVq5XAvU0Gc1Fr/AbFXSBwVv1JIDtcY+bcxKNflgqkdVE1ME/J8M5QN8MIsIRiwk9AmFUneNsrEObEnShxKTeNG+2WkNF0KR+deSR4ykmdJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcMgR2p6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oxCjBsb+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcMgR2p6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oxCjBsb+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770983594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBIaDmc/b8KhOmbhsBz+ARqnHRu5Sb2xsdw5j1dfy9I=;
	b=dcMgR2p6aS2K0MqwFFz+/gaXzlWLXQRnqFev4urOuAvIdLndRjsGjCAVjVGGsxqWRy6FOs
	mo5Kr39yRVT0M0onUbcNydNCFV2o00XNbIx1AapBFgqHDytu4bQDEH6vyb7jXtD1X/oGrz
	cqk5jQtNC36q6v+tTfa2BEoxd9hLTsc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-7i3KD_oqPbabLHTKBbK_2g-1; Fri, 13 Feb 2026 06:53:13 -0500
X-MC-Unique: 7i3KD_oqPbabLHTKBbK_2g-1
X-Mimecast-MFC-AGG-ID: 7i3KD_oqPbabLHTKBbK_2g_1770983592
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837246211bso8883515e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 03:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770983592; x=1771588392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBIaDmc/b8KhOmbhsBz+ARqnHRu5Sb2xsdw5j1dfy9I=;
        b=oxCjBsb+OtyvINW/HQaSx7kxMNeCW6P7OF20/KoSpRiqIrXBQaOl/vBSmSDpv7/321
         UJSlgrrpUymLiqTEGIxBYYnAGuzYulM3ogkeB26Vpz8pS5NuETeXxA56Wo6JLH/OlQ7f
         1PP24yMU9hoEI5QPQ+aWxw1aZeFzLbG+CH0hHjdZxIY2hggXeFl4ZY6pkPiTY/fgmVqM
         HTXYi804hdbktzwQE0RdqgfStV7EolMJRNrZ9E7An+M1y6d8WA/97/MyEvSkPgRnoLgF
         YCK8HHTDC5cKdyuVxCBvMUqKZKi3Q6XBdWf0th3Ojgihr7RKzotFouo+xpRdGpGgdUoY
         TVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770983592; x=1771588392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WBIaDmc/b8KhOmbhsBz+ARqnHRu5Sb2xsdw5j1dfy9I=;
        b=MdRMswRH6rM4xjF2SWNfW41Og+s7wj6rnasYQ3jngHnJ6dy7PdMNlbJlcwo7yfwKNo
         sZBUWfEHKKeH8+VWgOEnxHvW8eL9Ni5CM6rOpTy10PVhmSLmDZlmgYVBue5ME3COYvg+
         RzOlsHDUEAJY+kxiNMtJpIBVwbtMCxr/xHAjvBM9HE83YezgSqQp1X2WrcoYEYq80Vvv
         Q0OhEyZTSRv5rMxLZ6ZqTxepwlC2OxFP77XimfHDzl1jr5506rVWsi2E19cAQTdyQj5v
         HIp9B++kGm6vsNc5AesajJ725rUuYC/og8v2xmnDtR5UZOFUSLtVzj4FN2mQmrUUuJwm
         kv7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUk6kMHYTFMhKgV4vcXkHbQm36PAbSdY7uGj8/nhQ2nvm6ePI7KGCIoP/aFMsfkWXbVgBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOO1PluDiSmglgsKgkP7t2f7qEqsAcV3x82CCQoNoyq9EKAVl
	x/tRgxStdN5BnGZcbVuM0qzesaF5ZfUXWhh+ul5KEE+KMNdYvz7CyWVue5gWzrB1GWY6s4Ha+mz
	VjOOiKya8kFinRm5B4VnGwp0+c82iQMT5J2Va8UtEC3gjqy2Z9hDjZw==
X-Gm-Gg: AZuq6aLY3Q4x6DHYAt/yL/YyzrUnbI+5F9UB6eAEfeaDsYZ/WAO4EUjP6y8/RbLrwK1
	V1fWxhGtGEztHgs+6D2vGc20D/Q62UYh6adPzzTYHLR2b26ntpInB6OQ2vZU5X8iSbluBjb/yZY
	e/HSI6p/75xKcpVSRgHVDKuWvNkfJShNURDHzibJomaPZ9FnfXuSpUvjZkFkwgm0esIkg5tDtJJ
	3xPJKJtDvLP5BnokJbpuYvNkXJMUr+Uv60zRnQhs4lSZJmWiIUJmCCleuioT2NsdXM7eJkXkYm8
	JagnsbupFYs9/w9Y+6gIW1s9RTm7jJcBVTj3nzg/VeG6ry1Bs9mlm2UPpAnkjNYtj/5yEh8qnHI
	13UrgUl6YiKyTpC9aY+jRjR4WX5LylQes1hI=
X-Received: by 2002:a05:600c:1d89:b0:480:3bba:1ca9 with SMTP id 5b1f17b1804b1-48373a083c8mr27812975e9.4.1770983591681;
        Fri, 13 Feb 2026 03:53:11 -0800 (PST)
X-Received: by 2002:a05:600c:1d89:b0:480:3bba:1ca9 with SMTP id 5b1f17b1804b1-48373a083c8mr27812615e9.4.1770983591263;
        Fri, 13 Feb 2026 03:53:11 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm234671275e9.14.2026.02.13.03.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:53:10 -0800 (PST)
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
Subject: [PATCH v3 5/5] tools/rtla: Remove unneeded cpus parameter from timerlat BPF functions
Date: Fri, 13 Feb 2026 13:52:34 +0200
Message-ID: <20260213115234.430232-6-costa.shul@redhat.com>
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

nr_cpus is a global variable available throughout the codebase, so
passing it as a function parameter is unnecessary.

Remove the cpus parameter from timerlat_bpf_get_hist_value() and
get_value(), using the global nr_cpus directly.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/timerlat_bpf.c  | 16 +++++++---------
 tools/tracing/rtla/src/timerlat_bpf.h  |  6 ++----
 tools/tracing/rtla/src/timerlat_hist.c |  2 +-
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 8d5c3a095e41..dd3cf71d74e5 100644
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
@@ -196,7 +194,7 @@ int timerlat_bpf_get_summary_value(enum summary_field key,
 	return get_value(bpf->maps.summary_irq,
 			 bpf->maps.summary_thread,
 			 bpf->maps.summary_user,
-			 key, value_irq, value_thread, value_user, nr_cpus);
+			 key, value_irq, value_thread, value_user);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
index f4a5476f2abb..531c9ef16f51 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.h
+++ b/tools/tracing/rtla/src/timerlat_bpf.h
@@ -23,8 +23,7 @@ int timerlat_bpf_restart_tracing(void);
 int timerlat_bpf_get_hist_value(int key,
 				long long *value_irq,
 				long long *value_thread,
-				long long *value_user,
-				int cpus);
+				long long *value_user);
 int timerlat_bpf_get_summary_value(enum summary_field key,
 				   long long *value_irq,
 				   long long *value_thread,
@@ -44,8 +43,7 @@ static inline int timerlat_bpf_restart_tracing(void) { return -1; };
 static inline int timerlat_bpf_get_hist_value(int key,
 					      long long *value_irq,
 					      long long *value_thread,
-					      long long *value_user,
-					      int cpus)
+					      long long *value_user)
 {
 	return -1;
 }
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index db66312ec966..1c4702948532 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -209,7 +209,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 	/* Pull histogram */
 	for (i = 0; i < data->entries; i++) {
 		err = timerlat_bpf_get_hist_value(i, value_irq, value_thread,
-						  value_user, nr_cpus);
+						  value_user);
 		if (err)
 			return err;
 		for (j = 0; j < nr_cpus; j++) {
-- 
2.52.0

