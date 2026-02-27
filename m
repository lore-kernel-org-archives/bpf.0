Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B96E377562
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232497; cv=none; b=biCbGz8wKMKP9JOr5BTGugF7CpMyKbUZkZ0XbS5m81wzkgbUgpH0vX2wfN73Jtw+6lZfEQ72fVmtzAruyvJQGPlPNkPqN7HQ8cUl4M7Dp9bG6Mgg/btHcfdMVt1LjTwThL7aoBB5mprD3niA0a/Skr6Sq5CY9XC6QEdMz5HBpOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232497; c=relaxed/simple;
	bh=CBlsFejr5KPYr+BAHmJ0ePkKlKhEBqb4H9DfPXqlMwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZARfV4MQtthO+AWibG3mE8RW0RSXDf11ACIgSbtrrD403DnMiiCDu8XcMkNccIu14cIKfIdcd7zk3sXlABhG2qRHGkr/f4L/EYOyoE54/YzD/Wh78C7msGd7vEfXS9g2k2P9cfscs0aoyOwXcJn5BS+tkyqH20TOojtSWX2yBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyq1lkcK; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyq1lkcK"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7d4c7d04890so2026550a34.3
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 14:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772232494; x=1772837294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRCYfY9Z+ibsEk5m7GpDDN/83vtX1YMv69df7cbKT4k=;
        b=jyq1lkcK4CzhPDKfBRaPSCoUlHAiILXYrl40KiZ99kbgEw2G17DKkcHHEid59SlSwZ
         PSSSci7tRi9d9ivyNioNqOv7VA8oatDOvjcaboaow3+wpq4FtABXibProvmUP3fkW+AU
         9S5Nl1cn081Ea1mR1AX2hhbNzU0uytETuDEmf7dRLijjufP5XfxzQ1EU8FHm488tsryT
         BwKx1YCGHauOKLiVvxiSwmmfgYJPj4CgDZIQQqM2ZMXT495er/U6otsMiBOkbdJAhO0y
         VT8Hw3h0uFF9QtEMctxHUEhXQImLh9QBMeIYnCJ5gzW7E/kz7ABZAXkt3TGJXUULAS4t
         gvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772232494; x=1772837294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RRCYfY9Z+ibsEk5m7GpDDN/83vtX1YMv69df7cbKT4k=;
        b=S67M5A80Y3NSVwo5CPgMveJcLQwAbdMuVTizFEphjG/KVs6TKUI8XVW/1ngZOPuQLu
         4Lk9wEg/lW5oiiweTtvsh+FransjntqUgcKIHdWHdAjlECp4JINA/J+j5ECdpIPxWoVz
         a0+BS5+rE7BgsEFI2Sl3iWQMPNHZRb1txfAnvKUKI7MgEJOhFEI9Qj2792uWSA+8/uwt
         /ZsyEbUXtA9jgKyUZkptHljvgkYdeAdGH+NkPf0HTOnma3iO98O20xyjp0k2aM7T/hkm
         VThqBdC+6RzHgasvl8hfPDChyCDr/txQ4m3eKjoumeokmmm6N9eo4Tjzr2XX6+oUMxty
         TRow==
X-Gm-Message-State: AOJu0YwByQfQ8cUa5bWcA05FTjBpwGg5N9sfo3uKPx0hYk5PUzSDDCCs
	IFOJRTRfaLtqEXnGYis/z/3DUwmOgGvdLK+06Fg+VYVQceaWo2tiARt2MXG6bkVMH2M=
X-Gm-Gg: ATEYQzwrwpLL9cvTMM+TYP/vieLQBbM8THrWb85YqVCsqyC/53qPepJXbeja6PRqgj9
	Iwqcqmn4ViFFr4rmVqIApkbgyU7/pBpvnF6QO1Otns6Dv0GVgodFp90Dt8g1BdmjsagguJMqp8w
	X3uUxfMpfYEM016FIPD5+/Q3DVGnW3L0pVn6EniaNfEPyc/+1i0sHmimxoR5eoWWTkoqugtzotf
	6SVTsUtyNCzmeVSTilVeU8O3cO4xSAp/pH28tRJtDbsSMmY/rUrsg96lM5l/qLaW6RGOAwQXt3q
	EY3z8BBDIp40WZJFL9n3v2oYuDWenu0OEcNMX2nv13XE9CFZS98EF1a+EyKgUaQ+tRcxpAxSxoj
	8ETYkRHdwEz5oDkBocVuyCHGQIrKdRDCI0LxkFDsgsNyJmg/sae8syPL4ic6iRmOWALLom5a+II
	BsgLVos39wIZrdAwHRkYEZkAzUPmAeqAEt9HxkdQ/qgZ4=
X-Received: by 2002:a05:6830:3708:b0:7cf:d9bb:63a1 with SMTP id 46e09a7af769-7d591b6e9demr3321027a34.16.1772232494293;
        Fri, 27 Feb 2026 14:48:14 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586626869sm5202732a34.16.2026.02.27.14.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 14:48:13 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 3/5] bpf: Delay freeing fields in local storage
Date: Fri, 27 Feb 2026 14:48:03 -0800
Message-ID: <20260227224806.646888-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227224806.646888-1-memxor@gmail.com>
References: <20260227224806.646888-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4533; h=from:subject; bh=CBlsFejr5KPYr+BAHmJ0ePkKlKhEBqb4H9DfPXqlMwI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoh0r+XvFjvUJnj1s7DspkAlyNCsGbt6Vbsh3h3xS NtD5yyuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaIdKwAKCRBM4MiGSL8RyjPCEA CpQrXcyddnkB/gyKouu7VzCedlzVezcPmrro1P/L9QeKqQYS3bj5gGR62vOYDG22BX1vvA2aVZvBa0 j+SKRDYwO9upoRdE+NdPqkw46nEDpLDM6M5DpUTW0o9nzxRIpVbf76ly5cxv6rkCrPDiilGEB3JW6Y gzDM9IDatAEbFXxS16jwyBfMjoVxN3rPcK8r/bibHvtNQwNkxIS8vxWr4j6GBj3N4IrpPZxUwr/RUi +v8+/qJDM8UB54q30kBqapCa/DFYZat1xQ20dHLXNBoTLpfXrgVyo0IyV+lbE1BhA4v/AO987q8ZVB Y990v4zZ3Tvtz0WSfAk5RHWt9iS/EmYk2JmsAiy0Y7mVyrajGZnNQQ0OwCS0uXs42MSh5j7twnQ1kv 9XpuOz50TobT4vOjxK5TvARewgbCvfrkN9NzmLubb4aH1AtVqturxv7TSrkdy7Tf4/Tq/s12JZi8NR gegfxusGH0PLn1qZTFe5rZP9l+gjmVhiulOLGPREPKgMtvtLxEigMUcgDY3hobWW1qbvy5eTmUcPu4 14VuN27QxK27IhGh2GmXHC4lkouMYsBzFL5ZeFhc6DDIEmkKaQh57xC+AQMwXtJiDQ5SYKYl27ezBn miJ8cZRcLbsv/HfGeB+761TmEIsK6taNV/53kQ2g9ivCx45cPgpLTvADywRQ==
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

While we're at it, drop migrate_disable() from bpf_selem_free_rcu, since
migration should be disabled for RCU callbacks already.

Fixes: 9bac675e6368 ("bpf: Postpone bpf_obj_free_fields to the rcu callback")
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 40 ++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 2bf5ca5ae0df..d7db1ada2dad 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -164,16 +164,28 @@ static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
 			     bpf_local_storage_free_trace_rcu);
 }
 
-/* rcu tasks trace callback for use_kmalloc_nolock == false */
-static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
+/* rcu callback for use_kmalloc_nolock == false */
+static void __bpf_selem_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *smap;
 
 	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
+	/* bpf_selem_unlink_nofail may have already cleared smap and freed fields. */
+	smap = rcu_dereference_check(SDATA(selem)->smap, 1);
+
+	if (smap)
+		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
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
@@ -181,7 +193,7 @@ static void __bpf_selem_free(struct bpf_local_storage_elem *selem,
 			     bool vanilla_rcu)
 {
 	if (vanilla_rcu)
-		kfree_rcu(selem, rcu);
+		call_rcu(&selem->rcu, __bpf_selem_free_rcu);
 	else
 		call_rcu_tasks_trace(&selem->rcu, __bpf_selem_free_trace_rcu);
 }
@@ -195,11 +207,8 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 	/* The bpf_local_storage_map_free will wait for rcu_barrier */
 	smap = rcu_dereference_check(SDATA(selem)->smap, 1);
 
-	if (smap) {
-		migrate_disable();
+	if (smap)
 		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-		migrate_enable();
-	}
 	kfree_nolock(selem);
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

