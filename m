Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C076025
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774750078; cv=none; b=X6AzunhOyxFIjlFF/zlWtgn3+R5ValK971WH3BOJKVmer4v7+U2bpYFmwxbETbsnJrfiUGVAcDR4yBR/Zoood7671jkaFRUFgeb1mN/Q4hyKlu/UwjN/0YIplc8BrxVSavX3GGU3mtadKCA9rJmaFIrxBBfpXaqP2urawT23ujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774750078; c=relaxed/simple;
	bh=UrBw3OrCyzbCVVqeLEDrPOWj9cp3c+L/4qLj7+RldV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X96tgLOBqXvIIC5nOwhiIzXYwER7aeE7eL9iqjBqRTgvVLH5E+0kbKPRDfnBZCPI7OAxtSvpZDY6Rjme3QUCG5tnEcE7xVSviO/TygTZIPf0BPHUsxpqL3C9QyyYjAa/+zkl3SVjlvttjdx0f2xCjoB3oA8vrykPf/euq63xhjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+tF8Jmj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+tF8Jmj"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aaf43014d0so22701655ad.2
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 19:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774750076; x=1775354876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hiv8UpfCn7kyMWwzp6anyXzVhdhv6oz+YwTKUvhT6CM=;
        b=n+tF8JmjKE/eTuBSly29kZkSv+QW459OwRwjoufKJMewAgJTdpAGhGTI9LNqTL6Lfb
         wwGSIS72ilNuhStyv5qMIrdJXsZRC3eMzPHK9FMgJK8QqxKYYLqjMLRSaFaJyD2PfOxR
         Kag7zAy1EgR++aVRZqvJw8UBOXvi5MLqnvySwGtpivTAbDKAtlFi+T6BA/FNY4ddMePN
         PxrOkEgw0UrovvggHDgHswKoaKhKLEM37wpexzcXFkDqKmCGeU/NtY6pEcUlfQX8/Jhd
         QrbAFNKd7RsD+7z7bC/6w2uDeMb+k2P19R2tS3/yeKskOO9qeKJwqCLbzuNFVrhAFe/M
         O+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774750076; x=1775354876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiv8UpfCn7kyMWwzp6anyXzVhdhv6oz+YwTKUvhT6CM=;
        b=jTOpX47MnAA9y5lMde9N2BYJZU9Ta3q4fbPQR++9OmhWLACcUc8c1dQZ62YifIRQjP
         1Fc6WlI1yS6YzU7VcnL+Nggn/9jqNmfH+GdJcN3v4N2di/3u4kYPB/KSphgE0aHxwOnu
         T4GRU4EsHZYwyT/F4/uc3TezQjkjTQ5mc1Y1xC1PF/Sc7l4mn7QjBDBGFlBuLui86QhG
         D7t/xmi3PF+ejmX0cngwun3tU44ooPmrYxwjciPIk1wlsafBfTpECbjRrvNp50mzNnmm
         QVJvXBEaWR93sw/LjW5+JZiNqbP807FHLZa57E3zEUbcTJK5x+NxEhPwiSIr3Puku9Xn
         Yd6w==
X-Gm-Message-State: AOJu0Yz2dkrC1b/DYShXiYGPl/NCJuwyjO1CDgsXIoMM7zmtVSFmWsht
	q6DtJ9/EV8E1Vorn7cvPVdiR7H7j/H57lZ2UxvFsk726Wqr22JRzGgFtQJ89Lj7r
X-Gm-Gg: ATEYQzxP+yffXs2iVeE0P+k2cjQNlhWr4nbHTejFBnE970tQnjOLRaGTgwYzUzIH6L4
	WntBXW/eG700xJtaGgMStCGGoKlEDfQnVzq4tmM9ciDzlCMz0OI72OS93IKE0uRQoX5cpnHSVK4
	JXazNVbfyxEsDtIZ50twBEn3rHFPfS9209Ib/UBQuvNcSId7d/O8+sUeiRvf6Ss2PaDFCl7WlNn
	nJCtBlUt2txbaDh167meqNmJtQqDkL/3pps1bvYd87S9xUJAuQ3BirP2foGe27FyI+298A4jo8w
	3sGhvH8o5tgHUApZ41m9eFB0GOH+AWyu+h8jYAIb8veunGbNnFwzNbjYv4mkBxNvZaJK1GPGuNx
	9HRFXK/U/uIb4xyRVcB4K9O2TTuU2qa4QsvtF2BQiwKA5tRDz3cA7mglXoswEbYtqMpqhHGOStW
	fTD8NprmD84cO0hiSiaZU4SIBrB/Von+ee5/F0ehIxZO8S2/9Yk1DsS9yRGR9W7g==
X-Received: by 2002:a17:902:e883:b0:2b0:6323:1758 with SMTP id d9443c01a7336-2b0cdd1ad56mr86655935ad.48.1774750075873;
        Sat, 28 Mar 2026 19:07:55 -0700 (PDT)
Received: from cps-manycore-1.. ([143.248.136.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427afa57sm43482695ad.71.2026.03.28.19.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 19:07:55 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz78@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>
Subject: [PATCH bpf v2] bpf: Fix RCU stall in bpf_fd_array_map_clear()
Date: Sun, 29 Mar 2026 02:07:48 +0000
Message-ID: <20260329020748.3649741-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a missing cond_resched() in bpf_fd_array_map_clear() loop.
Other similar loops in the same file already have one.

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

