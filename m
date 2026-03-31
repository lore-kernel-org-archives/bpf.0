Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E230CDAB
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774924268; cv=none; b=Lwd8rfYjjZfE6jgQGu2+Kv5tBU6R11IQrnSiHhPpRZyDPGZ7fIvkbW2fKEBJqsMlDtAsDeRtO4XQYlG8dl9ZfbwL2ZrETJCHrJQJRv4X/aq4pPw8dGNhdlH39+DP/OCGRk75TyqSFn4+PPbYaUI81QyWn2D/7RBvKhf/QAOJ8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774924268; c=relaxed/simple;
	bh=9vgFi29Uwt4Hy0DWSECpUMOCEYUvXdZzyKcBaRSSQ/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+jff5SQNOxPWDLiOhc7ni47vA6Xe44NBJaTIhk+S2gNAOzFJJACynmu3R5YJ9ZKfqykMurVXHdvqAL20B3bpdi8VkM2SGzlSzmoo+CkHvY9werV3ze1XzP4MTaT/7DcwXz2go3D6nsdlS7/bCS12wxmedr5r5VnBP86tRZvoKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy0rAMmj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy0rAMmj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so39541995ad.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 19:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774924267; x=1775529067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KBNqkyAejqe++2mYyBULeebF1rQKQ6X3ZEEpltMbIqk=;
        b=dy0rAMmjiZ8GEY38GeXWKrkxQU1Az+4bUymoVXdhHk6qWRQPLfHcJoz1v7+ubqK/E6
         zX6P4+R9+ena/ObxKPKZ7etnHBQsrKjiquaVj5SxlhNJXq1r+pKUpiq+RKIxfp+9OXVK
         jwD7NzlhcpD7CrvJpgSW9YfgQTtPNXUezDXkeMM9ox8foX4Whmw2zCcR+RaSRL6uPdRW
         DNIulMv8VOJ1wSbIxEatphDjnYf7Ap7FiV6Px5yjFOqjaYbBXGj6LwqI6xkBskjolswf
         w8BonsUP/yRoGzKQ7n3Jz6+YG+HO2zN8YuVJQNYMYicNrN36HcyVGkpVai3ND8uET7H4
         ipTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774924267; x=1775529067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBNqkyAejqe++2mYyBULeebF1rQKQ6X3ZEEpltMbIqk=;
        b=Vmc5/7U51r5FeZMX1Czhb7SuGkSwpFuHUB/sP7yKaOVbT0aZtU7PmAjeVTjKoYoEDU
         vf1rpMQUdr8iYkJUjhlSzf843YTPgmYAoQTFlaGejS/J1R6aT4gUttBM7ql05kFtiieH
         eXt7tXNhbeql/Q9t9kNey4b8aKalabtl7lyPjDZsXNWA/cGQLdPjt5YQUa8BXglK/tOk
         FpRgjpezzFSPaoTtxSZkj7eCpWJDuB23u3+anM0rNpm2nJadetXS00c0XWevYxM7vuUH
         of+G0cmMNSCLUkUpwLvy5mO2QzyDOttogeAtJSQKk09pyIux2UEwpnmHTIsvjwxRqVen
         Wcgw==
X-Gm-Message-State: AOJu0YzPhcnYYOPR8VtuOAK1oGf3YO55iS7Y1rjHyFz3GthSq2r4ISpT
	QjYpvEKaqMlakMgH13xyVnkYAfq60v8YysEYh9iqHb//mh6qFr9DcLWQgRafKSka
X-Gm-Gg: ATEYQzxLObYlvkz28LZDYOInrLOIOjZm1jhLk49lUwTOz0nzL3mVjjJGIClIM8TUu7v
	tGs8PqXrAMOcrdEQIgLQJKKubm1is25ZwyPc7CDgZjfqLBCqAWP+f84PezM375BtkpmWBOLdNqM
	1qiKAXu8H1G7QoxShAnfI8MqWhrteXeVYMBXO0hFm9iUpD3RR7TwPoMG9JKhtKbKqkIrV7Qu0iH
	HB+KGCL0DGGm37z5y+KznFa414zide/0jf6MGYbfx1TLG+kjoS2tuPe5Gn3ndPV9S0YXJTUIr72
	/j6+6y/A5Quwwi3YNEaOtqipc0/MLrb1wLQvir+dxSnndaLJdZy77fb29w/HTvhGJEdxoQqPnn5
	l9DBjoxTrbdNC1yZXtDsT0SYiCO94PTsynCFO8fwMjqlFN4uM4J2HE1/3U7s0UE7ftYmH5wOSBS
	I4YyofLX+A43o4Mn0EG1JAHwye5bCQA7FgKeAk5QYhTM1wrfwpaswDBUOgG3UxZg==
X-Received: by 2002:a17:902:d512:b0:2b2:4a25:5308 with SMTP id d9443c01a7336-2b25eeaf1dfmr15497155ad.6.1774924266800;
        Mon, 30 Mar 2026 19:31:06 -0700 (PDT)
Received: from cps-manycore-1.. ([143.248.136.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242683064sm94714165ad.33.2026.03.30.19.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 19:31:06 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>
Subject: [PATCH bpf v3] bpf: Fix RCU stall in bpf_fd_array_map_clear()
Date: Tue, 31 Mar 2026 02:30:56 +0000
Message-ID: <20260331023056.484354-1-rhkrqnwk98@gmail.com>
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
 kernel/bpf/arraymap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 33de68c95..5e25e0353 100644
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

