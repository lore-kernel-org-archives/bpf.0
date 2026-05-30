Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB32DE70D
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780171195; cv=none; b=DY0V+FBhOdDChctZr1duU5knfyqeU6IJvlNQYmD4gWF/w3EbjDGhYVtxdCJJ7Q4Ok84fakepDpKaVqaN5gE72Vchdty6IxyUTtdZCP+M558DmJLkcNriah0dp+bTY51EhmSvvycA8BKsn7RSzTYpUAGWQ/owlF7tR51OyjKCsA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780171195; c=relaxed/simple;
	bh=5zJusSnBR/65awI1IGCM4CuwRdjvqqq0/RBbB7KSKUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVcQ9EfPQwTKDAKB5G8+k12ntVUq/xgMWGzU0eKhGYwBW5DGtSYbQTPW6ik8gCY6vtpctoPy1q0YlkxXTBuwDdkpoA4N0oudcSJpea8Hs4bIhprz8p2R3wku5tcAxP5c4KbQ18vftSjYxoTnAKOdygqgDinFpW+O7XEkiBHlDPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxpdGeV7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxpdGeV7"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2be1dd4af34so135763285ad.1
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 12:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780171194; x=1780775994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xWnFYquKZAEN4o53+EwT2fq4AtPddIjzLexfT3gRqtQ=;
        b=fxpdGeV7xyVY2GVfX3qaXI24cZw9tAyW7N5xOUnaQ58P50u4ld6Oleu3wJ5ADswD3A
         2BeWG1M9jUgDF3tr7rPkoNWrc5Rt82zry7aNCrYMD3+xNgMMUuEU+QZ/19zOhI6s0p3/
         qWROyCq6XJI3SY6HMWRrAiumJipmhv9chqPxGiuaexNFYyOvil0E+Q65b+09VrJtJEiF
         oYsHo3a5vugBVbNjoQzd/6kM+/hfN2uqjfigYChkIJl9inFpbMKzzjnuCj164tJS1TB5
         ZVkiWyvd7/4xbckY5hzHZPcjYHiSPlLZOieRReuv9WtiFbVPP2QLIDwD5jVTtdMOPxCp
         IHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780171194; x=1780775994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWnFYquKZAEN4o53+EwT2fq4AtPddIjzLexfT3gRqtQ=;
        b=N9kacO5Jd8mNOLkjPLAb5UTGWXovYoSOlKEreF+7NTvi0DbhIia9IbIGW4R3Oh2vBV
         0HtKuhLMwdfKYoL49qk/O/YL91z9BpqVFzasklc32QTArw0j7CsTFv8M3eGKO26rWPjh
         3Murz+nBtoxuyNgvQYwfcLcMNOgGZ5XmeZ78RF0BmyW5rg72eO4esQMzmcReAlKkqtpD
         DBArDRcBmAckNXfVStyX1XVXfrQdXWzchLp7xGJNPN0eiOofuq/+G6JtDO8ygh0rUD2W
         HnUQ9a8/WBplTMYLVxL6uazhZPtYP4mkOgMaYrT6j1Iyat5EL0WrgVLTLWfg7rNNYK02
         cKfg==
X-Forwarded-Encrypted: i=1; AFNElJ/sk9Rcnqb76qZluoP139SUp+RtGNYAx6Vle6DfEZrhUl8p4VEMszefkELB39OTOGmeOUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTfRlDNfR516lrjBqnGtGHIyHqvMMT+Lgi2cA532na7xcThoMo
	6rZt9MaVETU/VVzfROY9q2XX0R97V/WxNBJSbhfCsijNxposB8YEdfMU
X-Gm-Gg: Acq92OFgWxge9w6qylz1ybHMNCxkCBLl+C4FYoGf/WAib4u11QTKPc/RdnQrk8hOqU7
	Nv/wuTPjzW+AI3QVn5yoYvMUMIRJeQiI1xFQvye1YXzQkmF6op8G7XeLcApKT+bWn4hVJncEY9S
	/3mznzdxfrFt+9wGSbQEH+WBF7lQvm5VSd6eQoktC+rP1nYrA82bz9rd6aNjZAvzpZnkjt0nHfr
	e+mR7tisgN0iPin+3npxdsoV2eqaqch+2QF7lurh3PGZaZD7pFrT9/dy+bt783Y6vTrPHBRi2bL
	BC7fhhSjSNjbaqDqU1A0CmolFOcMZ0v/sGmCLibDuSffmrvpwK2c+sXvZyWIqnfij5Tgb7v8yL6
	5Rw6ItSs0gdrPlBWs+KDK2MicBUQNTkfGMYAIHxYuxWG2mbdgBoXahy1zBA9mPivGx4dYm8dD+I
	eV2txPaGagIl81kr+S1U509tPoHVXMpXJPwWut9cpiUl8=
X-Received: by 2002:a17:902:ea11:b0:2b7:abc0:3bd7 with SMTP id d9443c01a7336-2bf36793349mr58275845ad.9.1780171193523;
        Sat, 30 May 2026 12:59:53 -0700 (PDT)
Received: from archlinux ([205.254.163.119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772df0fasm5178148a12.30.2026.05.30.12.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 12:59:53 -0700 (PDT)
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
Subject: [PATCH v2 RESEND] perf/lock: enable end-timestamp accounting for cgroup aggregation
Date: Sun, 31 May 2026 01:29:40 +0530
Message-ID: <20260530195940.78700-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.54.0
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
2.54.0

