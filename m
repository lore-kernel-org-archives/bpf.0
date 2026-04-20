Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979773BADAE
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710835; cv=none; b=jNGwmTAQfpr+yRxi9xhX9UfCbbwSuVUoLbm/9Vt1caHE2Kkat+96ePLTa2M6oBx9cn/krhiq2BvUhL+14f1nK6fZ3aYur4FJq875i/M8Qhd2ubQBKqdK3ze1r1FAGEF7RqXmOVEaATIQRwz5KuIFJQG1UeaJIKY3REb0XAfRf70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710835; c=relaxed/simple;
	bh=vW02KOU5qndWFI5Kbr8zih/4D7EhB9UqxDCMlU5uBtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dp+wq4um+3bgiA+iv7hrwvdpFzIVH7ejKqbjd4cARbFFspXP75NxovLjvuTbqqEkUGO9LmRDPbGnlEIYj2XVeCgreFOoGv3gu/EH2rMHnj2knWfiJ0m7LiHlJ1v2TpXkUMQAIDLOxKVejnkqUU2eweOR/apH6UBbBQYfSAr6YUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7VfrFoP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7VfrFoP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2d3a9e149so20525225ad.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776710829; x=1777315629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9zb1CzXElV/JafdZJDqAqdzrpLqJEbxaPbWiaVDaWpI=;
        b=c7VfrFoPzfksxrVeKnfwPUcPAmNou4e30BlJP8q8rgwgTE7Km/f0qOvDPrg48NUD4A
         Ym4ST+iPmDXhx106c+h9+yOATQxcAHbhkmYv5COGGsPnydF6P8KkVWWRFv09tU8cwOOQ
         AH/nGvpXtlicD6RD60yjSU1dqv2/JefDTop/WAOv2DNGXuohlY50pYL65EMQobiPWn+A
         smwJzNdlldSs0S2yxZLynHC1hElB0aOanRjrzhTdPVzcF1oFhG7M51QJm8Q2975g49Bx
         Gx6ULK+NYFsQFd2uFvcTPGaiWntWRGabg3kYai0q4yz1sSkKGUoc4V/QoqVJvIOJHwJB
         PQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776710829; x=1777315629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zb1CzXElV/JafdZJDqAqdzrpLqJEbxaPbWiaVDaWpI=;
        b=ROLCYxGSiRg3BzRa1Caf0zpNQpCdqV0xgAbhS+EUm1xkfGInaW857gFXaLeGqefG6p
         eh1uxMcKzayNdyfJrCLtFxvqFug49NnW2HImumwfq/glTCaQR+fUeqATaZgWvKbLxABV
         HC4yjXI6EWtF0oGokaZ+0BsOSfLOIYt6rN8vtuBIe1oyX4XTl1IGh7ZS2gWLyIWNH6Q+
         +hsvc8UsZiK/wpNqyk3ANOYxqB3m0EP6bIgA0QsRPocV8rbPqHYkaOua72XXecu1XBpz
         oglTjLXurV4txOsDbBXPbJTnbgxVKeuaG+bZrU3SALtz6aj7aEGXeqH2p+3nYNdw7e7b
         mGjw==
X-Forwarded-Encrypted: i=1; AFNElJ/aVg4k1VGhtTToYVt3Wp6O2m8Jm3rjzhgrTUA2DLU7E0/Horu+LfJIgM+WWoRnjYaaFuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD9HoovDqUT4KJpbKcmZS2V7mwKCc6JAHcaSyotryJiMpLQNn+
	nQ581VpPh412SpGoHF1P5yNLenPxYppxjf0CUkF8MTelhHiedAo1bCKs
X-Gm-Gg: AeBDieuB2iNI9WwCV2ZtSyX/lW26QiTBJjLgYumPQkMWeAYwNV6JS9VQrbobX0ooTmq
	Au5lZk2liYqhrg/bnT4SOJlMPMDamNXVYo1q2nNwGdzXOMvrFhtTPjsxvA3rswMl11mJB0F73mv
	iUk9ez/VbPr48xhiHS+EsyuD5t7yW2e259L8u8DYrdyco7pMCcdyiq3zFlTDVa5kNiReuo6CcwT
	YUrlc0szAMF0sJy33aah1Uo33aFgc5DxKBzNCg/YqvwpN+zfRAgt5cgPPkVaxDbshINdxYjb7wg
	L5dtt1lqI6VZ33Zvy5NJrKEjar4Ps05R/28o/TRzPiVzK5tKtr/M0B3Ldk3QLmQsQhk8jYSo0E1
	MvrkKnEfs3iYnWzwFmZwAttXZxgOVUP69S7OszoZQ4tzCD7gnPgefFKom82TKBrQ0/ut5sHeY71
	nR2GRCkK/Rl6Lz5ka/+WVYTspCnXub3pMtjn2glTVkfQ==
X-Received: by 2002:a17:903:11c3:b0:2ae:5346:d4e6 with SMTP id d9443c01a7336-2b5f9ef78e0mr130724395ad.28.1776710828613;
        Mon, 20 Apr 2026 11:47:08 -0700 (PDT)
Received: from archlinux ([205.254.163.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0d0f8sm103913295ad.47.2026.04.20.11.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 11:47:08 -0700 (PDT)
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
Subject: [PATCH] perf/lock: enable end-timestamp accounting for cgroup aggregation
Date: Tue, 21 Apr 2026 00:16:56 +0530
Message-ID: <20260420184656.331306-1-suchitkarunakaran@gmail.com>
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
context in userspace; fix this by adding a cgroup_id field to
struct tstamp_data, recording it at contention_begin using
get_current_cgroup_id() when aggr_mode == LOCK_AGGR_CGROUP, and using
ts_data->cgroup_id to build the aggregation key in update_lock_stat(),
matching the contention_end behavior in BPF and ensuring correct
attribution of incomplete events.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/perf/util/bpf_lock_contention.c          | 4 ++--
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 2 ++
 tools/perf/util/bpf_skel/lock_data.h           | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

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
index 96e7d853b9ed..d0e2cad02fa3 100644
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

