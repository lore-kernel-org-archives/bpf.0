Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173562D0C82
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780170763; cv=none; b=RX/Q68OTMzzK7cVEElkHr1VKXaC3frH2TIzYY3OVhFCTPFHPkkO6vR0auQhka9fNpFzgQhU+OQLXscSxiCMVY6k8v9LmZRtPBS9U61BXAEWic5iKuASIY72RIrDmrbx3MM8QIerm2N0XAFYwskJuxf4Ahz2FjEP2dDICEanQbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780170763; c=relaxed/simple;
	bh=rvq5LDbnJDIRErmZhFttXSQwgqS/gTbMhyWFrdYdZx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMUOLwGx3PqnsKV37+k7kLQUiUe65T0+1W1mYcmwRI2K1Ng2LxRpr0Z/UM9wd1iSRaZVmGyMnaTEmbrpcggXswZUbbbmXl9TmfRn/vFqPevjUela9D/r6tNn9j/7Ze9tru/foU3ktD6TYCcBAfuoN8Jefuqct2J1prvASb/awXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyTyOKOQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyTyOKOQ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c379e8ffso627475ad.3
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780170761; x=1780775561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yRI8S7rO7BEyLKlLy7cyQrxqSvUTXdcDj9hT1MZ8+U=;
        b=OyTyOKOQ9kJooeKDowc/luTNWBvqmSKqZ19rd7U1NoUPrCUGysGcKnRbsPCnpSGELa
         ihnNw385ztwyMlEyeDAV9We3lkqsVMRPkMqJDAStjhPb32yrRnOITKgh8mvVwY3JBLaB
         DnZoyPfGQxJ9RqtDwXp+I5yqe6kynYp4ITOQWGZ1wVrqL7x8TFlZigFatDqlVWae46FG
         MS9wSKGURjZd8WZIxn6cFUTBSnSYouo5Oi9iJCJzeoWFya2wBy92eDWhA8qQVsgHfhLe
         7bfX3kIYHXWl6MwRoa7luByv1Q23sc1dcxL7DsQp4mv8TRuR6Ll0lf20qAheEV77IAA3
         4CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780170761; x=1780775561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yRI8S7rO7BEyLKlLy7cyQrxqSvUTXdcDj9hT1MZ8+U=;
        b=gFqUQUkWPasBh6R1TClrw+VftcoQBOiUymmJAJcGX80b/S5gwNrThoq8oHE6sUPUBS
         1RlQhST6POxvsFLmxnYCz2Vb6diWslQb7+vowXmV6mnPztKweR0ohx03ym5bsp/gswlT
         YQ5rYGZLKZKPRwc/MT0/v/LdzHoa/bIfxhOqBfc1EpiCIstCPJLY7TLcGmqsQxYZjPKw
         HiT3okp9R1BvFOk8PcShhIHPjRhnid1GHn77BqaF1DcuMh4tBh5dZTVMHLFYPODqQUDE
         w1bhgVC0ik+uD2j7Av5pUn0JcZQMl+VmNpEgJ4IS6aGH8elwRLKpEmW5RELoi+lX/Tt/
         QJkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Y0TfOQLUFWhGSwEgPgl0cVxoP6D7HSgl5aFejX4HU6b/XbbTEmpbxrSBy+rtDu1f29mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOV/VEfbQ3XJrCpG07fCpJM795ixK/KUPQG1PhxJ25LKCXbtdX
	eNiqptFKHXRNnL5xn0dZoLSMVnOR3X+7jDPF/eencMqWq9RtiUyk/BTu
X-Gm-Gg: Acq92OG8xajHu3GbcTJo8gcOIOW8G4gyldZ+JsoBEypMSShuix96dsAB0++Q5pzOguA
	zycokjOMwEidhWH1qDy4xqN4e25aNLpJZwgoeyjUQOZ+St8A5Bd8dsfpbzCjjJaXiivv0Cuqe/e
	w6AeFa655kfLjpvH+cTrpS80hKPD+RDhq3ZJtr2HV5PlzFy0a8IS5K73Os+X8ZeQiQkY6JYmo1L
	pHXV+Re5ODrWBaZ1qOVvwtvUuI5FyeAhDOICeTjDTjL8fG1t8jd1MqPGbY+hXWjYYWjTr4QaISf
	JNVkn6wM+aRxnt0yRJWyjO1fbCx3o7ySXupYaCTNYIoq8uasNF0up7ii+SJqv8iRc+iREBZ9RWY
	JXLFqNAg+CGTOQk+gRhBNnyKfDsU8G/R9BJzgsrsezDKxPsV468x+p0pXHQXBazM5P2c3Dcxlvx
	jBaVeCh6C5iBloBf54F7L/JVKn0yDZ645kslltaEzH7Jg=
X-Received: by 2002:a17:903:2409:b0:2bc:a52c:c8fa with SMTP id d9443c01a7336-2bf3685a533mr64533095ad.26.1780170761238;
        Sat, 30 May 2026 12:52:41 -0700 (PDT)
Received: from archlinux ([205.254.163.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c4dd4csm58343345ad.78.2026.05.30.12.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 12:52:40 -0700 (PDT)
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
Date: Sun, 31 May 2026 01:22:30 +0530
Message-ID: <20260530195230.69382-1-suchitkarunakaran@gmail.com>
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

Acked-by: Namhyung Kim <namhyung@kernel.org>
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

