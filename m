Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1892E8B82
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179373; cv=none; b=Qdwg5XyU1LzEppUavt3jqAgIAz5CXJKV9DExK2CFldsp0Bs1x7ka8XUWCqmpYHsbERhg2EnXH5Qy1CXPUiA5l/v3UeDC6QU0HD/ZPaV120kNTr3wlgRr5kJDPHeCRvai9RlL5BRQwwaC76e9xz/6donNGOINfw/GkSBAhKLqinc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179373; c=relaxed/simple;
	bh=c+3opmxIH4DLfjXxSKulQKhrGuenddLurBJ2Uoc+vXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e010QE+wmuWpbpXBljhakZ2C2WDDir38oaFxLk+mn7PAU3W9ZFTA3SOQTcnFQRMx35AtG2miC9ptQu5ATAoZzyh2MLUoZCz/FAr+iHCHcpjivKs2ht/P/Lr5a0xexaROvSf9v8xAaFEIHwxDEkLHGWMWW7DkxmgR1urlDaHyuUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lct7fJjZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lct7fJjZ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-366087480d8so970044a91.3
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778179371; x=1778784171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLbDA5dUP8vgYaSGZyctZknfu5NA4leOLY3uMdguNYA=;
        b=lct7fJjZBYJ31+qe5c//W+fNO8/RNynrYkgh9XV8MOOb9F54zfr9GR+wHs3T6iJDry
         zS6GAApXBtsc92f3lnCfH8MtVUbx0WDoyZ0fimFeCO2AYUepGHmk0ifXJc7pJCXSlytD
         C2fvCRgC2XP43NtBz/3q5Z4JON7PaxNzb+3eTdZtuac3Z3W/ammTveJ6AC3HBhte/fkq
         5vwY4YvRVwAx9GwsTZ0ODDqBqa8o5h5Xsgvw96gpUsyi+1IuVHFwe3EQkksByq2r9vsN
         VdF7B7+BApQHqk4R/a3IveJi4fxUpAskbx+sWxL5JNbSSW69UgR2m6DrazG5cQDMUcxz
         Dltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179371; x=1778784171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLbDA5dUP8vgYaSGZyctZknfu5NA4leOLY3uMdguNYA=;
        b=c0X9gXwBXeoNpnaJi+YdisfNIdKZvJ+ENH8D2AmgDQ13F9S03zbvbVPubwJ3o0CD79
         A6fWnXeeGsc1LYC85fVaCUdkwEbZXYqaNImHdC+xF9Y7IFdJC+hIKBr3DjW+4E0GIytI
         3oxbFGPaa791r0X90cud/c6wBzZ9RyhUBDM3ZQa4SO61aVVr+hEzI9HXmqnV9V+4tw/A
         77klmxYgBfPW5GsqqhAUHkb4/Zl3Q6pHj/8tsziQGiKyujs95SLnnn70SqQOly6RshBf
         XzQFGbBEChx9FDf5rYvLz2h6ulC1XGR1Jx2ZyArETRjf+F671UjYxxhBlx14qnFqmJ1j
         vwLg==
X-Forwarded-Encrypted: i=1; AFNElJ/Munp7lhv9Ttihz9C4ZR9pfPOqZz6pinU7AzrA1ND9VPqRIiWBoATR2eG5I6AToIHSBO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIAIzYiiF1JtxgaFzLp2jl9XiCQUsmYE0+z5CmznGfMUx85sv
	mb0xXHT71eNm4673ieC9uSRqfaHM0Pt31T6vfGMxFzg/ggrW9QbtsR6N
X-Gm-Gg: Acq92OF7zkqITvKj/cLSXGYMBxgd0GoAePbsEmUSbrt4+8mHr8dIkvpMkg2SfKl6BsK
	Uq74zictoUKsgU1DCQKWhHopC33cXdB7OqX60V2tQURuSo7IvRpZBKqa2HTS1XRaJ1Frx+Ml3bW
	hge3caln+fW2vIGwKUOswMolyiweWCmykw7KDZ2KC5fG7ZFL4/dmaB1hGzATPXAMyj4SPi16B8v
	jkJ2Gz4ogna0E6rIIjZJkrKwxQuNtrU8XwMNPvFJUNUMEoUAxoE+Xreu02xbuntr9B+KThc9o7B
	+NBsWS1j7wtwWc8ERhvRm4zDt+w9v8aDt0se3WosJ9gYqzjrtonTfLbA0PD8AxEpqwcd85yzkIx
	fm8riTL1l/KSKwbUhEjBxlkNxKClfm5BWj0hpjweZRQN3t+i/yyCF/MFDdZSBRsaG9aN4SNHEF1
	Rlm+vNAoHtTEKZgEbDgrG0l+7JWYeeLGAur1qCtWbfiA==
X-Received: by 2002:a17:90b:3846:b0:366:33a6:9926 with SMTP id 98e67ed59e1d1-36633a69cfamr1834848a91.18.1778179371533;
        Thu, 07 May 2026 11:42:51 -0700 (PDT)
Received: from archlinux ([205.254.163.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-366478fb189sm118708a91.16.2026.05.07.11.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:42:51 -0700 (PDT)
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
Subject: [PATCH 1/2] perf/lock: Fix non-atomic max/time and min_time updates in contention_data
Date: Fri,  8 May 2026 00:12:37 +0530
Message-ID: <20260507184238.65280-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.54.0
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
2.54.0

