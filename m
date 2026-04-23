Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB73A9D8A
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965760; cv=none; b=BtfyXTdHd/RdlM6C7uNAfydLhyeL4UaUgxKmDvLxglAhoz1VkpSoBxyzg/KKL5uOHrLxSt3M3CINsVN9iq2sPCItbQSxCgwyQoxS8aHU10HtYPH94ArMLGFUw0FagjoQkB/meRETP/DZ7KibP7R87j5D4wKZqJiqMV+KeABm3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965760; c=relaxed/simple;
	bh=kbu91miAhJ/uxreLuzFTT8fU/t806GJZgTxiktjnF+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tA54SWrFfsI1sYzYxdOhMXLwxZ+mvR8AybVy0p9kxSPuaZnSpjkBoUKrBbhTin4dv+Ib2rllYbeFn691CAyAeYFHrJSLDdzuIvkH3Kjt7vcUHNlJ44ld5WrmLy+oUsEQ/DyUqN4E/uY/SlxjBfM/rOJgtKcYkKLRBZ/d6Bsvhgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2jOcB3m; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2jOcB3m"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f69a286dbso5334820b3a.2
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776965758; x=1777570558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1+m8M29eqk9de6dbvvJWlkqdX1t+b6gyj+kzk8w80DI=;
        b=j2jOcB3mqGeo/+M4JjcbG1CpQsQ/qwgytYMOS/RAZjOkwt9GB9GVF/dCLPc4wNY3ap
         xNnfloRPANLerIZ5OLMxXpSxMWf3ntywkWfb8BA2IrUdrnR8fkaExtXiHjlfgBT07Uie
         30j3G/zCqD7s21tRgfLJVyTyP90dU0oGbRCbZx7HAuWUMGL0i22nitRCSAzw+ktyZUiI
         C3xNIvHEsX2r8W/ODIQcjiJFRlMlyLAWgBqKam5gMTG8byqhByHJ52CMMndNbNk2k2v/
         8WmcuYPz72hvOf2KsILgyigayCgtiv9tEXVp1r/xrn5KqkFkX2cOLeedf4ZUrwG8u7/I
         ZCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776965758; x=1777570558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+m8M29eqk9de6dbvvJWlkqdX1t+b6gyj+kzk8w80DI=;
        b=nbGz9rxZFgQ4lgAxbqR4a3TBbpqTK3fFkXrYTLDcrh5kG5PHrGcTLmo4dT6/xGIen2
         iMdzczOl/Mgrq8BvIcIYb6eDYyHLyWAf4n18+XuQpJ742l31je9Weu/p7BGt0djIJwzn
         vWXdW1ZxL8opLlOjj5vVFF4vs8+DsLRp9X8J84b5ewvklTUGkqCSjEoUA0tHTUOBk13V
         FC44zH41xbY7f3yqaHRLJ/fT5HhEkjCpAN6Gq9Cl9ncg0fjH9Z2PV6Tnq76ODx3/wj2u
         ZaqyKQsiMOefWoFSfWY3J7GI6dhdXju6z230j2rs9dB2kSIXI8IQil0K1FM5EyxJos9I
         snyg==
X-Forwarded-Encrypted: i=1; AFNElJ/L1qrFhdts644LCIihyw9k5/cEb2dl5cpirtXsCoOwwJESeiJpfSR8hbDf0xUqIuQRdMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjjboSmZ+L4Z+w6EDgdBO59+0eTykrEzW41PF0imbXVYLpKvgU
	25iBuPpc+uxeWHq7yhOf0RrzA9E1RLTDuHyPNI2byIE4HmHkKDVwmVdN
X-Gm-Gg: AeBDieuHtSNKGT/cqkdtQ+ltluJW8m4x8W3QdDbpcQ5+2q9ArwnNplaKcUL9HvpmUcp
	2J/UAX8zPXPwW/COrFtrnfBsH7lPsQju6O0F7aBOlyYKHsmnM+cOD5rphXx9d4H0naeNiWwevmM
	ZXT/V5rPczXJDJX8nN/nNQrXh+25ZzbDMfRGCYZSZaT8QZ0t6Rng9TpXDOw2Z/B5NpfXoMCiBmN
	Ob9BTibwbHD+sTmZBd6TuFxv9bW0yETDpVK7b29EaUbM/Pb7kxfCmQ1ILc6MrUfFII/Qf/vBwsM
	PIYNacYw45FihDdB8N6m5Wum6j26kmj7kMbfh2dBLmREQ4k6CCg+tTIpkjlSZXeetVy//b+8TbS
	ZX8GK7+KD1cfmL5zWotPFlD2+9YhWwItDmDzRr51qqq3nJ+4G8MgCo1NnoF7Fh+nSSbCOApgohw
	6uaoWkUnQkx7IBApgdwHko/ZQrSwVdLS4St9Hs+J+b9obeJlyppebn
X-Received: by 2002:a05:6a00:e1a:b0:82f:7bec:2050 with SMTP id d2e1a72fcca58-82f8c90d174mr30725301b3a.39.1776965758167;
        Thu, 23 Apr 2026 10:35:58 -0700 (PDT)
Received: from archlinux ([205.254.163.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe901csm26171363b3a.48.2026.04.23.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:35:57 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tycho@kernel.org,
	suchitkarunakaran@gmail.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2] perf/lock: enable end-timestamp accounting for cgroup aggregation
Date: Thu, 23 Apr 2026 23:05:05 +0530
Message-ID: <20260423173505.73223-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_lock_stat() handles lock contentions that start but never reach a
contention_end event (e.g., locks still held when profiling stops), but
previously treated LOCK_AGGR_CGROUP as a no-op due to missing cgroup
context in userspace.

Fix this by adding a cgroup_id field to struct tstamp_data, recording it
at contention_begin using get_current_cgroup_id() when aggr_mode is
LOCK_AGGR_CGROUP. Capturing it at contention_begin is semantically
correct, the contention cost is incurred by the task that had to wait,
not by whatever task happens to be running at contention_end. It is also
preferable from a performance standpoint, as contention_end runs just
before the task enters the critical section.

Update contention_end to use pelem->cgroup_id instead of calling
get_current_cgroup_id() dynamically, ensuring both complete and
incomplete contention events attribute the wait time to the cgroup at
wait-start time consistently.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/util/bpf_lock_contention.c          | 4 ++--
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 4 +++-
 tools/perf/util/bpf_skel/lock_data.h           | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index cbd7435579fe..1a5bd2ff8ee4 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -463,8 +463,8 @@ static void update_lock_stat(int map_fd, int pid, u64 end_ts,
 		stat_key.lock_addr_or_cgroup = ts_data->lock;
 		break;
 	case LOCK_AGGR_CGROUP:
-		/* TODO */
-		return;
+		stat_key.lock_addr_or_cgroup = ts_data->cgroup_id;
+		break;
 	default:
 		return;
 	}
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 96e7d853b9ed..139199811020 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -536,6 +536,8 @@ int contention_begin(u64 *ctx)
 	pelem->timestamp = bpf_ktime_get_ns();
 	pelem->lock = (__u64)ctx[0];
 	pelem->flags = (__u32)ctx[1];
+	if (aggr_mode == LOCK_AGGR_CGROUP)
+		pelem->cgroup_id = get_current_cgroup_id();
 
 	if (needs_callstack) {
 		u32 i = 0;
@@ -771,7 +773,7 @@ int contention_end(u64 *ctx)
 			key.stack_id = pelem->stack_id;
 		break;
 	case LOCK_AGGR_CGROUP:
-		key.lock_addr_or_cgroup = get_current_cgroup_id();
+		key.lock_addr_or_cgroup = pelem->cgroup_id;
 		break;
 	default:
 		/* should not happen */
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 28c5e5aced7f..652e114e6b87 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -13,6 +13,7 @@ struct owner_tracing_data {
 struct tstamp_data {
 	u64 timestamp;
 	u64 lock;
+	u64 cgroup_id;
 	u32 flags;
 	s32 stack_id;
 };
-- 
2.53.0

