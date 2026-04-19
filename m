Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F061A9F9B
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776623320; cv=none; b=qDE/2jTIPjWNlV9lYAb7KKmsbEZ92hgrk7h4D2DvDyMP9JsZfsY+BND5Y0ROFMKD8Hp1j7SQ6QNPizAfEAkRt7XD4fevjdb1iR9oaeFiQGXm+sWxGuAAn8K7HJtvoVA09F8DPN8Zl6krq/d0/Umzboh/xEzpWbxZTHZrtX/8THs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776623320; c=relaxed/simple;
	bh=JPaLF9KQAO0I7OzRvnXnLa+c4fsShMzQE8hERbaVjME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGp3dh2QoWNIE2WSzPWlgcL0pIdB0BrWbNub7/9gqCkrQ3XzR5L1fTDanNEU4D7NcdXgZ4bJBYhpA9t5wX2oUfAAIfvDfz9/MivJaxVgQJNWOdrgDGnOiBbnm77v2N9X1QV+oLM2c8IrMb13omyi0+hdnD89qgigz/1qh5duu9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdeYfsuT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdeYfsuT"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so1867768a91.0
        for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776623318; x=1777228118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6k8p2Fo/UmqGALv94kPvEJFTlYIOKqHlXqqU4ID0kYo=;
        b=kdeYfsuTpsBWIj2Nek5VxGikTLSEmJKuDUVpK/vPe9XbKFuQ0Q1qXeHkGy8E8rsnxJ
         4sz9lN9n8nlJp5bs3jyn8Um1IRbhN2WC9dSRhxuAD9WUr/S6ZkF2ZwEGScGUYDc9NvS2
         13deuamvN2zVGB0pdZICPlCxfjulUWvoKbDa9IA5yF+M2vTadiIO/F3bFl8oZHnkV5uu
         JodV9Nh87Lpic5sz8QGrzfoh+IQL+JCbErl7Y2hgAdVLUp8tEnCQwmVnrpBP4wvn5Q6U
         L3SfqF++C47v2k2XqQUq6eU2hfWGuvjBnsQ1c2uyBCYz1Cpx0N57dK8oTuHkjWucdOaz
         K7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776623318; x=1777228118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k8p2Fo/UmqGALv94kPvEJFTlYIOKqHlXqqU4ID0kYo=;
        b=LmE7tdfSoUuHKaP34Gj48d+7fvmu/kfWice97V/iFYp7BN11aOQafwAjTbu87iJG2D
         l0S79kB5V9kd3/cqiRmn3wFOMlJm6BhEXeLtWkLAgN4LBB3AgdbsIOTvSDqdRWS+rck1
         PuYbuUQj75FHKMaHSC+vwqiqGIZVl8wc/EkJWBWM5cYMUSvaOloL6d6LDJGOwvjARvbF
         a/nR/N9Ucffc0SyxxXYZd82umj2o+vYeJ4j+IC4I7kRkB3Zw+7mfrlS2sLd8RMpUZbzO
         c02zpWPD6qIX6EclRjIVweRw67NepYaEEVCfDbCySBSfbpxDBhISCYGMxd0Rj4TN7a9H
         cdvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8nKJE9VGQ49aLjHPPKpQnSbHILR+OcMVOSpy732vTX0QPthsrbuasMB02lrOeBxOv52qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBrcMF662I9E0IdVAqhiQnATJg6qTT1diiU5KT4HBZJ+Ujh4N6
	N5KSM7vyx+gZyHJLyO/s2T2jvjQIZpwWKixZ1ru+WrOXaeaXZQF/FxV3
X-Gm-Gg: AeBDietcI06hpPVLirzkIgXhjyuM0oq0fvgAIqVpvzjfsuYzcJp9c/xz+2MueYj2Sub
	ZHZRr7303OzmkG6ICUxouRJS1V3ei/dPOO9IfeJlIV/wVp3jz9GiwlMMYJ8RJ159q6a6Yf2W2Ki
	Zsh1AeAW1fk+uc9WZSf9wHFJc1H56MqeChhm1mEWMUGLkkKR4liWF6bAOZdTpW6JASszaRA4SXn
	uxMLSWdPIZJtt4Jm4LBlcExtjFGqSYEaycFeJCJAjDfAKYwKKrSyEzkG6cdb67i1XaEmy2vTAUC
	+7ROhQBGWcyXYrt8kPByl5J43ogVVVktx7hsWpuASQ8sOcm56gZpy11gts5IG7yc1JFBFjS9Gzz
	EP/j5Jn1EB9xm0QdW4GdR4pXrpf3Y/71UWoQPkBG8TTDU7vq60OOXBSIrqlw+DKzExGuzWDm/Zc
	RJlt5io+dkBUy+CF4la/zMVFonXszomr3zcJ2XqSjNBg==
X-Received: by 2002:a17:90b:1a8d:b0:35f:b987:4dac with SMTP id 98e67ed59e1d1-361403fa894mr10901791a91.12.1776623317580;
        Sun, 19 Apr 2026 11:28:37 -0700 (PDT)
Received: from archlinux ([205.254.163.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613faf1103sm3103452a91.8.2026.04.19.11.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:28:37 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] perf/lock: Fix non-atomic max/time and min_time updates in contention_data
Date: Sun, 19 Apr 2026 23:57:54 +0530
Message-ID: <20260419182754.143225-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The update_contention_data() had a FIXME noting that max_time and
min_time updates lacked atomicity. Two CPUs could simultaneously
read a stale value, pass the comparison check and race on the
write-back, with the smaller value potentially overwriting the
larger one and silently corrupting the statistics.

Fix this by replacing the bare conditional assignments with a
bpf_loop()-based CAS retry loop. Each field tracks its own
convergence independently via max_done/min_done flags in cas_ctx,
so a successful CAS on one field is never retried even if the
other field needs more attempts.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 50 +++++++++++++++++--
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 96e7d853b9ed..5c8431be674a 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -175,6 +175,13 @@ struct mm_struct___new {
 	struct rw_semaphore mmap_lock;
 } __attribute__((preserve_access_index));
 
+struct cas_ctx {
+	struct contention_data *data;
+	u64 duration;
+	int max_done;
+	int min_done;
+};
+
 extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym __weak;
 
 /* control flags */
@@ -486,16 +493,49 @@ static inline s32 get_owner_stack_id(u64 *stacktrace)
 	return -1;
 }
 
+static long cas_min_max_cb(u64 idx, void *arg)
+{
+	struct cas_ctx *ctx = arg;
+
+	if (!ctx->max_done) {
+		u64 old_max = ctx->data->max_time;
+
+		if (old_max >= ctx->duration) {
+			ctx->max_done = 1;
+		} else {
+			u64 r = __sync_val_compare_and_swap(
+				&ctx->data->max_time, old_max, ctx->duration);
+			if (r == old_max)
+				ctx->max_done = 1;
+		}
+	}
+
+	if (!ctx->min_done) {
+		u64 old_min = ctx->data->min_time;
+
+		if (old_min <= ctx->duration) {
+			ctx->min_done = 1;
+		} else {
+			u64 r = __sync_val_compare_and_swap(
+				&ctx->data->min_time, old_min, ctx->duration);
+			if (r == old_min)
+				ctx->min_done = 1;
+		}
+	}
+
+	return (ctx->max_done && ctx->min_done) ? 1 : 0;
+}
+
 static inline void update_contention_data(struct contention_data *data, u64 duration, u32 count)
 {
 	__sync_fetch_and_add(&data->total_time, duration);
 	__sync_fetch_and_add(&data->count, count);
 
-	/* FIXME: need atomic operations */
-	if (data->max_time < duration)
-		data->max_time = duration;
-	if (data->min_time > duration)
-		data->min_time = duration;
+	struct cas_ctx ctx = {
+		.data     = data,
+		.duration = duration,
+		.max_done = 0,
+		.min_done = 0,
+	};
+	bpf_loop(64, cas_min_max_cb, &ctx, 0);
 }
 
 static inline void update_owner_stat(u32 id, u64 duration, u32 flags)
-- 
2.53.0

