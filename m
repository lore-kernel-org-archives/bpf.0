Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275FC36167E
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772169646; cv=none; b=b1E6Zlzx71bqm5BanAQNhXC+klRyfA3woHzsXt6VAaL7NS5GKQErT/5H8xH9M5e+T29awrKrRmH1+cHNYgYkvGC20eOLsM9risg/dLvK1t8aRRSAgvlTYM+EzJAIhgogMEZTgveJV3WrQ+zkkvS2LlQhHwHJpn1vQIdVWiiwK+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772169646; c=relaxed/simple;
	bh=gRuPixCzlWiMbQbNhtJnU+tN7ZFVNdTYq+4STtCLQqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHEUOn1ul8jW3cZSep7FgW3y7ZhWEinRhovVage2R2wcO71orXyBU6juuxVfoMjuBwx+Qpqaqd5lXrHGWnbl94Rg6mv9YQfEprDiBY7EZfVoeeuQXEpoaR1AzKkKObw/1RwS6HdwDqhzkXt7sKHpB0XvLhc9kn88MeBeOpTb0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4xqVaw8; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4xqVaw8"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-4638e238094so1009725b6e.3
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 21:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772169644; x=1772774444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as8na4AiuU2zxY12oDZEXWlGbYmW+pg18antAASwqLk=;
        b=R4xqVaw8k6efsN0vB13xLMivzGgpg/066xwl7STYj631FIgiGfl7tJxbNZCTSSZbMP
         plvWwUKvU3XiJzrb3tcSs4elfgLeold49nsqO6FczZWB45HAktvASL69y4YjVCqsRZnh
         gG3tfF+lLobeosjfR9Rl3ziUAUWSKhQ4DqVuKqw9fjtkuR7stByvZX6l4M6wjT0GVMyt
         KPwdx/PTwR/MGelv4tH22YpapUSH3GwhiP3WQMweec8jbCdArzKuh3b3Srb3Cy7EsNfg
         zT1BGVyQ9U4+5RLVLiqDtjSZWl2zFMcmi4x8xjMlCwd0ZPgfDO2bOu0jEYzl0dkE6yF9
         agTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772169644; x=1772774444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=as8na4AiuU2zxY12oDZEXWlGbYmW+pg18antAASwqLk=;
        b=kup7piI18B9MGXeQrvTGwdhhAqy+oj3f4WLJAPjzHdz3WNhVlmqQ27YsILqQAn5QeW
         LA/u8bMYzxDSD3n7aLNuUiqQhl/vjQTLAjBKDJRVsxUxYpUojcrn2xf4qQ3sAWAmHATg
         42BD4Io6FPz3A0pjBDXS8J0H6956nGpP2u2IwOKu8afyDKNfEiQXVksueiPWm3X8r31u
         Wybb7YwDhvGArl6k6ACgY86Xa5cp6y81n7ZJBHcSJEVNQKr8W/l56nKIuSMDeODql4xk
         D3oS5jrWRLW3/cuaF+sIMFjLB/2tVdtU/+qVFyYMCT2AEpk3887cSqwIvRLg+P/Hu81T
         Hepw==
X-Gm-Message-State: AOJu0Yx7apy0XX8JkXssL+Pk4VdEjF52xo8Vom7so20eNNmxAsPY1CTU
	RJhlKA+4eneE0Kf6aMuG0XFPmIrXa5cx/cvKxm9ewCUgFaTQUTdZcfLbACwgqi1t5n0=
X-Gm-Gg: ATEYQzywZqwy7D/vrRQ2ti9FPUm0FG4ww9yDIzmCMyZ3V25FdXKAIOHSqi+zu7l7MFx
	F3nkuTSTJOY/NVAFxpIz6jKcGm1oDROHqY5R+T7/CE0dCM8+iYKwYDjeUd/0q8kApMLrNpDNCis
	u1b95bKFssASIrfhq/B0jsEFtA46AVGA76SucxVFWXSEPMfXvNxFtTSzOdPbo6Vt5Qgd3yPp9SV
	wSCyZdIWrz78WP/a+POudWRAVf6nXf4dRlQz+ky48gDQdXlOEl/3GnEouEkk07EVpj1RV3Q3IwK
	VKtSrU1eypujPRARdazvS3wihKrsZmL+MGlux3Mm+zjw/kMIzy95tmHkEOag5UvtbkcpX3V+GmZ
	t4ctcSExVFyIpGPCRwavI/JjocQW/ZSrwUO7tg6aSzlu97xm8VFFOo7W7ir7FMiRWCmLgGoN+TV
	WiK3VUeCS+3ihYa1ZWSRkvoHjaH/XD54w9M94kNXc+JJE=
X-Received: by 2002:a05:6808:518e:b0:45f:66f:a2be with SMTP id 5614622812f47-464bebedc9fmr976306b6e.47.1772169643576;
        Thu, 26 Feb 2026 21:20:43 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb0991f5sm1419227b6e.0.2026.02.26.21.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 21:20:42 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 3/5] bpf: Delay freeing fields in local storage
Date: Thu, 26 Feb 2026 21:20:29 -0800
Message-ID: <20260227052031.3988575-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227052031.3988575-1-memxor@gmail.com>
References: <20260227052031.3988575-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3909; h=from:subject; bh=gRuPixCzlWiMbQbNhtJnU+tN7ZFVNdTYq+4STtCLQqk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoSmOkAvOLZTcQEWP/xha+rKWe29MwGUWD0Me75Tv GdeunoKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaEpjgAKCRBM4MiGSL8RygpdEA CRhsq2UlgJ8af1q4U3CJLDUogFj8kk+FVhT9Slarg0BqKeLm+jeKtUxAO/Pn3RCGvDv09oMoSajVA1 NnW1kM3w1fuFWfVR28ZFZlxy1cMFNk/LxCs+wPgNEPkxbD0KPDSwQn2PKyP94iJP2qMCmPDuI/wthn o0vNdcPUy5hmbSkV5Zk3sWsshuY8i6F5F2/SrVyssU6+wsHrgP1U0j8i8CVEYCyivmK0TfTbnnYZ4I HrtJp1ISeAE0SVrFX1M7CUt8S/nEpuPzMpkJB6qdVq1n0NFxxu/zheo4GPecY3NDFHd9EhQHkyl/F5 XsRofVz2cGU3J43nfvEoIZRArbPoxIz75obInwGFEtPZEFstZDp9Gqxj+ooMtnNKefMmHKJLMhNLCb UQCGXZCzHxqPFc8uyrYbjkhcKqBGPm49pYE4ek5IZSlFv034OOcfx+mgpNCbXA9lZzjYCHUkqwxPtZ W7HMugsw/B9MjpKMb3d/bumAypxpQ78kOzJFj3ELNg65e0OS/Zdc1/IJOyDjuMrRVXJRrA0G+ipveG JBUx2GT6LXro9SlkhHU4V0KnLl9cUQn6zO5N09c8qFtL0IcwrF+c/I6blfFJVSGI6mxSvuspVWoq6a l2MJfRcBxnPDhSqzsyQ3VRTjJlyr2YMwMAXAv2v9XE6cWq2Q3zi5351NZLpA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, when use_kmalloc_nolock is false, the freeing of fields for a
local storage selem is done eagerly before waiting for the RCU or RCU
tasks trace grace period to elapse. This opens up a window where the
program which has access to the selem can recreate the fields after the
freeing of fields is done eagerly, causing memory leaks when the element
is finally freed and returned to the kernel.

Make a few changes to address this. First, delay the freeing of fields
until after the grace periods have expired using a __bpf_selem_free_rcu
wrapper which is eventually invoked after transitioning through the
necessary number of grace period waits. Replace usage of the kfree_rcu
with call_rcu to be able to take a custom callback. Finally, care needs
to be taken to extend the rcu barriers for all cases, and not just when
use_kmalloc_nolock is true, as RCU and RCU tasks trace callbacks can be
in flight for either case and access the smap field, which is used to
obtain the BTF record to walk over special fields in the map value.

Fixes: 9bac675e6368 ("bpf: Postpone bpf_obj_free_fields to the rcu callback")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 2bf5ca5ae0df..5cd874f911da 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -164,16 +164,25 @@ static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
 			     bpf_local_storage_free_trace_rcu);
 }
 
-/* rcu tasks trace callback for use_kmalloc_nolock == false */
-static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
+/* rcu callback for use_kmalloc_nolock == false */
+static void __bpf_selem_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
 
 	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
+	/* bpf_selem_unlink_nofail may have already cleared smap and freed fields. */
+	if (SDATA(selem)->smap)
+		bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA(selem)->data);
+	kfree(selem);
+}
+
+/* rcu tasks trace callback for use_kmalloc_nolock == false */
+static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
+{
 	if (rcu_trace_implies_rcu_gp())
-		kfree(selem);
+		__bpf_selem_free_rcu(rcu);
 	else
-		kfree_rcu(selem, rcu);
+		call_rcu(rcu, __bpf_selem_free_rcu);
 }
 
 /* Handle use_kmalloc_nolock == false */
@@ -181,7 +190,7 @@ static void __bpf_selem_free(struct bpf_local_storage_elem *selem,
 			     bool vanilla_rcu)
 {
 	if (vanilla_rcu)
-		kfree_rcu(selem, rcu);
+		call_rcu(&selem->rcu, __bpf_selem_free_rcu);
 	else
 		call_rcu_tasks_trace(&selem->rcu, __bpf_selem_free_trace_rcu);
 }
@@ -214,18 +223,12 @@ static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		    bool reuse_now)
 {
-	struct bpf_local_storage_map *smap;
-
-	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
-
 	if (!selem->use_kmalloc_nolock) {
 		/*
 		 * No uptr will be unpin even when reuse_now == false since uptr
 		 * is only supported in task local storage, where
 		 * smap->use_kmalloc_nolock == true.
 		 */
-		if (smap)
-			bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
 		__bpf_selem_free(selem, reuse_now);
 		return;
 	}
@@ -958,10 +961,9 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	 */
 	synchronize_rcu();
 
-	if (smap->use_kmalloc_nolock) {
-		rcu_barrier_tasks_trace();
-		rcu_barrier();
-	}
+	/* smap remains in use regardless of kmalloc_nolock, so wait unconditionally. */
+	rcu_barrier_tasks_trace();
+	rcu_barrier();
 	kvfree(smap->buckets);
 	bpf_map_area_free(smap);
 }
-- 
2.47.3

