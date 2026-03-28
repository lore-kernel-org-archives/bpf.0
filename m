Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851932ED29
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774719881; cv=none; b=XGy3j5R+E9LigUC/P4003Eh6ZAqLlcRbWFnDjIo4wIbhrKkY7n5d4ZW5FKbm49gYj15K++bWbpxBUEo2EPhwTSrheAc0Xkh0cQYtyPEzwXbkQWImtt/nEmA2hAD6p2Grfk6De/0Knr80iHXGqkh6cze9IVKPZUNPYGulAvCG5eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774719881; c=relaxed/simple;
	bh=WvILGTpjF/D4pi5kdNEKgty4Bl1aj/OQVB9dAAA4a3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZRNXK7sg5kZ0lA43hBIpD8pv3/CbNTxmFodyQPC0o7Y3mSNHd6hg75H9GJ/xOJvEW0XiX5mfTxxsiDRj2sShCm7bvi1eFVUZxKndUJ2EJ//wXJOgf+uK9HRTJQPkT7t91nyp0ytqMQCL+JXnw1VR3jOgES/xfQIOP917TXtqBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDzLWEaj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDzLWEaj"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b0afa0210bso16020355ad.2
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 10:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774719879; x=1775324679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvSfAaSNTnZS97xnXnYJY5nBSkWpcfr6mFAd698DlKg=;
        b=fDzLWEajWqOxQzYVVNbVMzDzCNxhj+uFbWcJ6E7T9ciXD3u04WA28xmKglCPcYrla5
         42K7jSpJL6RK5jmt6+ymW66tdL7kIYr0aYsSJuW0nh/y4SPRm2q9PfCMRiCgMDo8+Vq8
         itqa6evJ+/K7KWztpPjTnz/45sdZ5IXkhp532b1nUbAnFJewg0p1KbVreEWSXLUdmcCt
         VUOazwYt0ZHhtivDZONP2iwIR37OmnmyGRgU1R51OWMjxt/36zBMDF57lUAse9chRRa6
         08Rr1HJgcr7ct2EPgZr/xBpvlUcqRqOAfK0LnsGABE5z5LSiJYchezI6WO8WiHU8VhT1
         SBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774719879; x=1775324679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvSfAaSNTnZS97xnXnYJY5nBSkWpcfr6mFAd698DlKg=;
        b=T0wjaCbU2GalTSxbtHeX9VmmmPiv+gGwrwIXfztTxXyo59MTa8w6qQ52zYPDzXLch6
         V/stGqNbMN7Eg8eb3Er1Lld+zY3D5I33ekYzwT0AknD4Ew1NMlML+w3XJrT9JRkXquql
         vp+K9TB+zAsirj8NDh42Jav9jR0GQKUosk8zxSBZpHJ+ufqmd+iBMuEwnk7G+JHVd1rV
         ty+aF0zcU+/ZAjM52nhO07+u3LPlOc/K8hu483aVolOKGSiWAYqOrHMhiJl4Wv+A9cHL
         fDTmktRNxJvl+3VVW0WwW1kKo7qjk5+ric5MDEnhL73Ldxuheuz+25p4qFozFL+p6cV5
         I2og==
X-Gm-Message-State: AOJu0YwVYxaH/1fMOHxjhH7NoHZ58dSuWSHw8mdewiqqELggmIbA285x
	udJMFQwdajHSAC+6suW/Ip6DKmz1YdDOkMFtPjJonA3V18/PV317IycgspmvsthQ
X-Gm-Gg: ATEYQzxYQVpZ8mOqZ1gj1sDFpjvZRBOEiL8Pd/c98zDHPU3ZVhR1f2Bs1SlM64trnVl
	BaYDGra86hWkC3OJa60cYNTq5FpFougYcySH3dX0QnvYi/CduxDETQsZo8pkONstlLJaFZR/hC+
	K25Od8KQ4RLVR5uytdRZR7HViK5c6I0U/F9tWpBrBJnloTQraVYsqggUJNhgojPRLMBXRtsPqqt
	y0P0F9ATZ9YsR52IvzU1WdOjg8ckyJAqbJ0yn8lSDJqxnXKVyfbs2nmNkIgjt7eDgnMtkhA1Efq
	75eqnVI2Hc9P4CoHwo3dDvm0dahgNhyNOCk0Tr2LmTY1+z/E7RTWYLRXtSy/w9nCIhqkXd1NfTx
	HiKDwaKgnPo9nSqxQyI+T70YdzeZvJZFryBCC96YVOpgDvucQUfs9P9MvmHV7C7QlD6KeRqbZoY
	uiMJLFia1U1gaP2tmAIO7YuUK8zu0Ym+gz92t2Yhze3rHAuz6qsK8HEoyd1WvaHw==
X-Received: by 2002:a17:903:2f8d:b0:2b2:4b6a:f3b8 with SMTP id d9443c01a7336-2b24b6afb22mr1511365ad.29.1774719879041;
        Sat, 28 Mar 2026 10:44:39 -0700 (PDT)
Received: from cps-manycore-1.. ([143.248.136.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c5339sm29262105ad.79.2026.03.28.10.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 10:44:38 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.next,
	andrii@kernel.org,
	martin.lau@linux.dev,
	Sechang Lim <rhkrqnwk98@gmail.com>
Subject: [PATCH bpf] bpf: Fix RCU stall in bpf_fd_array_map_clear()
Date: Sat, 28 Mar 2026 17:44:28 +0000
Message-ID: <20260328174428.3554328-1-rhkrqnwk98@gmail.com>
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

