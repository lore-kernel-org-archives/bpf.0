Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55DC3A3E73
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775558347; cv=none; b=nl3OcoWwP12UsGg12FVTQVJ/imjC7IJ/cPyimX/C29cIX57uM/VoVr19KTG1yJq59KGq0DIpyQqcXW/lIdvshqmMc2Kv8ZQi78A9YP0XpJzXZe1V5BrB16DK0kW/A4XeLNW0Oa7EggDjYajRwZDMdBOjRRvjA7e7WnW+PYwXL1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775558347; c=relaxed/simple;
	bh=V1hP5sQhNxvVYVxPSbTWY5q1NHHszPeMCmdBeBTAWIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hWIaWvrU6kDc9R0I6r54dZ482zE7pZIZEWBlcqYI20+uBodryuF+jaMHASWn/KdlV7UzCT5lwtDc+k6DUtD3jgsXUgx1ATOMkv5MSjA3GuXm5PIAvT00XUpeMuOcKK6VCVn8V/aKd73jHPSjA+87dnPKWWqjqbEpnn9do6EhAZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRt/ta0J; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRt/ta0J"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso1975117a12.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 03:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775558346; x=1776163146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2YGU/Qu7KSxje0XXhCuAHmY0WW9UbPdGFgaWpsgE88=;
        b=qRt/ta0JX7QcV08H6oPCu970uRcej9B+zIIjCx+xTzNdIT5gqAu3uNqYn5i22mgueK
         XmKCbXo2Rlufj3O4qSfEGtZ/MD55BEY0WYGDjaayDf7S+WGlOfcc2hVCrJJdrE/KEX02
         VyIKWhD30Vyf8U/0/TN67tcy+DiPpgctkrfR4ztim/c+RO2nXcPjUBRXCU1djwqL64QU
         K/m3AsStQJV9SdumTNHx+6o0HBInDD65G/z0Iieg5Ui4Q20HC+RH+8xsZObHpqWpTsrs
         wrp2PL9Gm6fdtqghlviBW55S6mRIy3wNde3rXVefRO1cHys7KWhy2q7RtJYzJs/s3HbX
         8G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775558346; x=1776163146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2YGU/Qu7KSxje0XXhCuAHmY0WW9UbPdGFgaWpsgE88=;
        b=QQPMAKmS1qKO79iORV9izdETF+gK/O1UrT55WeOC1fb106tbg08KyL/FjiWB7f3TWo
         a/HUSvZnMa5lAJRXOYVpyKk0C2wGhnFKo5VT7bFRdE2SaMJF5Si2P5ARYoEBHlDxKh0L
         T57DgpLX/JvDqdy9EWNQJCRjULQldL9zXQ3rYNtmpFTWqaa0wZ+GNgcoFBiWlRGU/pUA
         akYGqC+pBX7gQYaEQnTIRQEw87EcKY2fdDZ3dzgYBEQ60ghxMBKkGrr2xIDU0hVOP7mv
         +Vd9jG8rCySK/o05TzT0uAlrzH1POvY2nEd1zzosp/BpTm5MgXesxRY4cJjaDH14Fqvd
         dtJw==
X-Gm-Message-State: AOJu0YxwBnEEvjPTt+AMuNFhI+xc+K9c5fsaUOzqN7AFVg8CbKT3LGxj
	Lq/46BTO1OsIFjwq/Wya9HWOJWreu3GyizjI51MEM/IXLtIN6V26+Utg0iT/BIId
X-Gm-Gg: AeBDiev0zOMgYC/F9ejQurQ1AhNlfZi6EV0XvSc0ycwIkb3F7k0jM2iLHwHkPdJvJaw
	xQ1q+k/yAOtrYSkNHU4AqT8Vl87KpYBLKCeWrW/Fbtxj+L/4nnv0gdLe+J2qLKrGOCKaHlGgwkz
	2PVG1mYEk25MhVU42S34JvEIPhHpo+1FDcHzdDHDZAgW5HmdDwi8RQzaEi69yr85j1newA/za25
	DFqV/jLnvH/W1cLgIQxgguuToFSh3e5yiDhswpiGB8BdjFsvNUNjD1nlIMtclRHN/FfGydfCCjY
	dI5umJ8GlB00tk5mv5ojMQOO9L2FhNYaM+jPJC9MYBfxtRYVYqYD09s5m5q1rMcLTNIMjuBYJAN
	/yxIZIT72T4ifnA7+K1xOxWwDozqX7D0C/xqO4XfKi+lQgrelpNFK+z2gKX+NgjiLVdMZsmCubI
	eL6FiWx3ROOFENTDXMnKwW52HK555Et0aBeDaM9rPJq4aYSm98mPox2Ua5o1UTJQ==
X-Received: by 2002:a05:6a00:3902:b0:82c:7876:a027 with SMTP id d2e1a72fcca58-82d0da8edd7mr14975927b3a.18.1775558345640;
        Tue, 07 Apr 2026 03:39:05 -0700 (PDT)
Received: from cps-manycore-1.. ([143.248.136.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca75dfsm16966468b3a.60.2026.04.07.03.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 03:39:05 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	sun.jian.kdev@gmail.com,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>
Subject: [PATCH bpf v4] bpf: Fix RCU stall in bpf_fd_array_map_clear()
Date: Tue,  7 Apr 2026 10:38:23 +0000
Message-ID: <20260407103823.3942156-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a missing cond_resched() in bpf_fd_array_map_clear() loop.

For PROG_ARRAY maps with many entries this loop calls
prog_array_map_poke_run() per entry which can be expensive, and
without yielding this can cause RCU stalls under load:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  rcu: 	(detected by 0, t=6502 jiffies, g=729293, q=305 ncpus=1)
  rcu: All QSes seen, last rcu_preempt kthread activity 6502 (4295096514-4295090012), jiffies_till_next_fqs=1, root ->qsmask 0x0
  rcu: rcu_preempt kthread starved for 6502 jiffies! g729293 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
  rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
  rcu: RCU grace-period kthread stack dump:
  task:rcu_preempt     state:R  running task     stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00004000
  Call Trace:
   <TASK>
   context_switch kernel/sched/core.c:5382 [inline]
   __schedule+0x697/0x1430 kernel/sched/core.c:6767
   __schedule_loop kernel/sched/core.c:6845 [inline]
   schedule+0x10a/0x3e0 kernel/sched/core.c:6860
   schedule_timeout+0x145/0x2c0 kernel/time/sleep_timeout.c:99
   rcu_gp_fqs_loop+0x255/0x1350 kernel/rcu/tree.c:2046
   rcu_gp_kthread+0x347/0x680 kernel/rcu/tree.c:2248
   kthread+0x465/0x880 kernel/kthread.c:464
   ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:153
   ret_from_fork_asm+0x19/0x30 arch/x86/entry/entry_64.S:245
   </TASK>
  rcu: Stack dump where RCU GP kthread last ran:
  CPU: 0 UID: 0 PID: 30932 Comm: kworker/0:2 Not tainted 6.14.0-13195-g967e8def1100 #2 PREEMPT(undef)
  Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  Workqueue: events prog_array_map_clear_deferred
  RIP: 0010:write_comp_data+0x38/0x90 kernel/kcov.c:246
  Call Trace:
   <TASK>
   prog_array_map_poke_run+0x77/0x380 kernel/bpf/arraymap.c:1096
   __fd_array_map_delete_elem+0x197/0x310 kernel/bpf/arraymap.c:925
   bpf_fd_array_map_clear kernel/bpf/arraymap.c:1000 [inline]
   prog_array_map_clear_deferred+0x119/0x1b0 kernel/bpf/arraymap.c:1141
   process_one_work+0x898/0x19d0 kernel/workqueue.c:3238
   process_scheduled_works kernel/workqueue.c:3319 [inline]
   worker_thread+0x770/0x10b0 kernel/workqueue.c:3400
   kthread+0x465/0x880 kernel/kthread.c:464
   ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:153
   ret_from_fork_asm+0x19/0x30 arch/x86/entry/entry_64.S:245
   </TASK>

Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
Fixes: da765a2f5993 ("bpf: Add poke dependency tracking for prog array maps")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v3 -> v4: Add changelog, no functional change
v3: https://lore.kernel.org/bpf/20260331023056.484354-1-rhkrqnwk98@gmail.com

v2 -> v3: Add Reviewed-by tag, fix CC typo
v2: https://lore.kernel.org/bpf/20260329020748.3649741-1-rhkrqnwk98@gmail.com

v1 -> v2: Add Fixes tag
v1: https://lore.kernel.org/bpf/20260328174428.3554328-1-rhkrqnwk98@gmail.com

 kernel/bpf/arraymap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 33de68c95ad8..5e25e0353509 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1015,8 +1015,10 @@ static void bpf_fd_array_map_clear(struct bpf_map *map, bool need_defer)
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
-	for (i = 0; i < array->map.max_entries; i++)
+	for (i = 0; i < array->map.max_entries; i++) {
 		__fd_array_map_delete_elem(map, &i, need_defer);
+		cond_resched();
+	}
 }
 
 static void prog_array_map_seq_show_elem(struct bpf_map *map, void *key,
-- 
2.43.0

