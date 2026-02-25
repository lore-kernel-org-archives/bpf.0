Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B152E7635
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045493; cv=none; b=liZYRzc9FVc0FXHPRgSXRfYyhYOEPQ0NtNV0HgeB3x+fHdEWEprzURO4nQwaezOXsHdilcbkpTWLpczAALxIC3UtVJcxGk/2mEzbgIjuzX+H2P6oJV6l7BuuT35ed3uxX6n0+uQ5lwoZdocR7HlfEvDUcq1bDZ50Q/f0iQ32zsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045493; c=relaxed/simple;
	bh=l+y7TJkQlsNUHl/BJnCUzora7rfvP3e4VVlr/Bipn4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMrbu2ATPhNMHR7XwIkb2PBZm6zwRN9TzLEIWKMDGZwI3ub79Vj4sHOd2s2jp93dOf3lLw2weKBxhRfBM2OVSDMs04DnDWtI47OnxO1+/1FCL6jVT447LsiBLievcdcIjN+R/CZlCePdM0QTmNaoiS88XPeGH1HYPGX0Akv2BVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMBJfK9R; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMBJfK9R"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7d4c4b494fcso4235732a34.3
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 10:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772045486; x=1772650286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoRES8KgT0yGUaLtVT+mhbrKEj4D1gFAGg3+9h1SX7w=;
        b=QMBJfK9R2fb2AZORT/aqTD8NSWyN23X9I21GFqeiMr6/kZcxO5YTAPvG7f+4C7RzSt
         LMp0eit3cBnHtKJ4rsadqMlq79E7A7p946ryz1bCYjGQRzaYipf3FpN2hSeFYYy2KJ+P
         3LSFpYH+4a5taU4pnW5s0GxKKm5BOMHumraJSiXufxB79NL1yDT83+Z7kgHM89dF+wR2
         eaOYpNbUkpZ6P6+hO8m6KREqC0TOQ9rD1UotYrGQT2AwQ+8VlJhpO3kBXwg1ISFOfF29
         9MZwatLVUoE5jbPBBz2jQqcLl8cozPgq9te6IhhZ73jY70W4f52RYTf6FKIiV/txpAx8
         7DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772045486; x=1772650286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoRES8KgT0yGUaLtVT+mhbrKEj4D1gFAGg3+9h1SX7w=;
        b=Ok5nmVgNnv6VLtkihaq/aamSri8B4qaG975eS2K24EDCNegkHRloUawpbrfxhJNXZf
         rEPfblr/GLvJfFKkUob5gIyk8faseEL3/Yo9ZgaUd0MTsc4fEn+Vo2x6micN+hH4SUuL
         idzq7cYhV64JaT55Za/cXIceSX1N0g65EJA5VQ+M+WQCz1Uazi20UF+vDRvuCMS/v5zk
         nH/rUmdUsC/evTv6xhHDAB/2qZrqN6LpV1ayrtNTmuVh8RZVv2GgPQEOzJ12hExOyzn3
         SJMZh2kIcskDXcxx2tTM3WnFLkDmasRSAUggyYUZznaO7ic6pxfb1lIc0P5rnc8x5+hc
         +egQ==
X-Gm-Message-State: AOJu0Yy35ybDmipZ2NK4SkG63KMqa6EEN2aaN8EFbQiPOaHRxJGil01C
	p9gRxAgjg5iArFNZsUSrnJLuvdgDQE/bIGhggEmRYS6uA2BLtsrfmNzr4w01/TAyT/8=
X-Gm-Gg: ATEYQzyon/9oh6UluDAZwKT8NwIHCMl6CUKxGXxGNhs6hpaS86a3NPW34vVI6hy2XTs
	mJYEnAUaS8kntWY/Fhpua1uq01LWhIkmFDv5uJBvNXfVBgab4XTItleJPgcsxXAMQLPVl2itFnS
	IvXtjrDD8J1UtvjmSRr4aTz65MXj9QjH+efx0wjeaa1xmnKqbXA5F50SvIUtunlZyGoY40y5e17
	XduqJQEGpa931egXVekhN6v3URdHOGGhix9JYtx32OZ6wEzCCZpqTF+vNAZekw2FrWmM06WVoXo
	Yie5YsLJMBrVw48d7jcdBELW4hXZiwmf64aLefDiIqrCcasVeoTQJjpvvfgO6jgchtlU5K74il2
	HohfjCKx3x9Z/BQSbkatHl26XMiMkfVqLB72/8fqPtYPkUP9nfpKT/4DnYhAUXQUADS2Ks9V5pe
	yOY8PAAbRpviS8SpCO4gKFGFuhQzge3iUp8AvSojgb
X-Received: by 2002:a05:6830:3887:b0:7d1:9da9:c6e with SMTP id 46e09a7af769-7d582a67643mr681176a34.25.1772045486311;
        Wed, 25 Feb 2026 10:51:26 -0800 (PST)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d04e0bbsm13006179a34.24.2026.02.25.10.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 10:51:25 -0800 (PST)
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
Subject: [PATCH bpf-next v1 2/4] bpf: Delay freeing fields in local storage
Date: Wed, 25 Feb 2026 10:51:19 -0800
Message-ID: <20260225185121.2057388-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225185121.2057388-1-memxor@gmail.com>
References: <20260225185121.2057388-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3909; h=from:subject; bh=l+y7TJkQlsNUHl/BJnCUzora7rfvP3e4VVlr/Bipn4s=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpn0QMzGSvcnJUBGQ0HRiHbIVyP8e3ZSRzz7budsYl SBVnkQqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaZ9EDAAKCRBM4MiGSL8RygqFD/ wPnokXAec+9fy/M0vZYjwzZ76h5OArqg0WHSK8ek2IcROPK0VL1nlUEAjkMSDBkmt6n1pPpCiTmkQv nMSmtL6/LbB+RCPq5txuBEtQuJHIYblXYm4HHRLJM0TjF8PlCG+naEl7dn4+PlkDx65qQED+VR93Lc 32iz4yQdQ96Tdlv5PUQqNHvttPXeIa9gUdPgnZPC8Xh+wf+v87/VknV4I7Yl0jubBw8xJ0FWRrUgv1 3ViPZmcivkvISWVhtLXkrBHQbPlANN603nN1q1nt5GBVxKUzmuJ0xTpl+572TMdjFeOFTxooOd+gFG 1xNA+2M3DHDw1s8NgP86+5uBUJXCT9AmnU8IywUpCwVDHIUsCuVLSvGQjiL8Bd5qmR2eUOjDWO3hTt DTpDTu01yF2PJ+wFwV2WlIWLNMCMfRW30vWtI1REJz1BdLQ+T1b+jCKm9i4Z4Gz3KsMeZyrBoaGyDA NYuMnnYGinOPbdAMj6k0riYN5txhjsRE8eZmFtDIDt0fxvP11jSku9H3tJghIGBXw6oQ9w26hHja1z zPxLULTAkvA+o2xJ6lF+aBJzrMe9/rJYYT7RZMoosxJ9ipxCA5IQAFK42qoIdpPNEV8JlKZJiyd7oD 7YvCb1MhuzodsJvf3xS3fqHu2j3HSd54hRhh8c5idqOsG0FhyIILs5B6i3Ng==
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
index b28f07d3a0db..0825a92dcd6d 100644
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

