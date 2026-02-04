Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67362BE630
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770184318; cv=none; b=fNrI5oC0J3PhGJaCH+t3sF82AbAmKMqag/w9B77om2cYEeJeFfn531ZvAIpFBfdtJZG0OrtRVPODJbnNSchc5IlJXqKlWeclytuBisvilJ4kBNrj+bM1n+sWqvVrGHCsILokPscSx1gOI04riNACUycA5BEUp9C9HxcuCyFHxCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770184318; c=relaxed/simple;
	bh=S4JwWp/YdwIcbYXyYDnZ999W2somid7Mc0cjTjAqLiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1IcLwSw1hMJtP7tIl0w/+NYlJzl/lmOVdEh07R7VkgxqjT69Jsalmyf9/Spe3pGLyrW7pqKHoMOE0zUm8JyOxJ34U9Xu7IX3NQeCvrYGvAbrB8nlBRWchnsppMwKWXOgPnBLCqjeuTRtM90rBsiZfWGUtbTJIXD4fOqUrcotBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6+BFIHU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6+BFIHU"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-352c5bd2769so3822190a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 21:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770184318; x=1770789118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJasTIQHUab64Vuev0hrkGm0JtkbwTTb5I6K1gN00+4=;
        b=I6+BFIHUyEaGofSQ+5hddvr6I3DIfUFj8MHlEZiXYcCgKSxRYcMFOIAGgzxJ2M1a7f
         40gPcCXLfUOz1P5BRPs4MtSdhZBZpm6F5WqRjuhiD4w2WiWO7evPcqr7qfAhB/Kol2z7
         7Xo7F1G2g1q9EAxPdXTOHKeQwBTGTCfG5/LgTMQhSS3hD+Og3yXaqZT3nA3LtNnJ75NE
         GX3ycIl5rtQS4M+KUk8foWg2b0kSyRD0OridUWQMIRuPH07y9WiIrCa77OA9jIzE3eTD
         esrA4FiXOnHmbF3emLHAiXJKqwsYkBT20eDUuAlqTM+OK+IWmGI2/x5Q8vtJLcqntliA
         H2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770184318; x=1770789118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gJasTIQHUab64Vuev0hrkGm0JtkbwTTb5I6K1gN00+4=;
        b=jeT3ThtC90xW3gaH713N/HPiIcaMB07s69cKQvJG+kzFUA9o43KAZtSNlmFm/9XBkd
         DQizc3qqAacwMg9Y1PTE2Uxtg/pmRsuK0ZRxPtecCodTk0XNVmEACzS4UIWmnNPEJDl1
         WgyQnByj0iLN+ogYFj14mT1mZARkO7fBxvBDxeqhV/dLA+cv58L3VEag6f5XaRslSgDi
         qTUcgGz1Chad41MdCyt/KeN39mXD7WulA7/x8Ijr8AamqNg3g2wmJdwIt1Fc3C5Vr937
         suDmTJEoj5zXeN0v6F79VpgbiSWU2V6BlmtMVcpPokttxZ662EVbicF8NBHGqV12kRQi
         p34w==
X-Gm-Message-State: AOJu0Yx9gmuJpxd6cXQIsRf+InHZdYZvjDZ0fpqM7rUVT7jJGcFbHr9d
	qF5lY+Zha6a3tw2qJkzm2vJfywNYJa2P0gK6kAabb3TS4KSXHnnOYaH22Lxsuw==
X-Gm-Gg: AZuq6aKUOk7LW+KohspiQvUQQUhnxchlCTfk8qvyt91X/vbZQKdV/94cqBQikyLCuVN
	xIwy+nVhyp5uc+JHSqpG6wxz3irhnGowMbtaCeJ40EDonXq5lFcZqtHUqRHCTRB8XF1VfZ1/25Z
	XyvtgaLX51d78GWYRIOY13PE9tWQt37/yAhKu1PwPK7hKy2JgretxcQ3MTSDhRoXRMsZcNMZ/65
	QqJoE0TE80P0ZW60bwS30F0kc7XEShvQxZkgiolAy3Exokt7KaiVhESyWWnqfs/Jp9cerjLu271
	DjM96ZntBiXttFnf26X7UO8bY7wGHiW5K4CmDYfWgLk22BIFzXOZHfYO9SWUO5mF5p9ycDsHovJ
	FHbU1FydmLDeYS5TbGqMfPFxKysxPDOUyuWQ8uYLdEmFFLrz5bAwe9PUUMw5hN5Puydeez4CFO7
	4etMGjyin/T62upmhswHNc0VzvdAccGRTFL/tctTKtnWWsf1GNsJlU7YJ0hbhUKOewb078WIb8O
	G3ojhvcAgmq7ceUM7cs8VjjEgq5ANByjrNM1Nb4/XB+xJJOYw==
X-Received: by 2002:a05:6a21:3a85:b0:38d:eeb9:8f6f with SMTP id adf61e73a8af0-393724d7d7fmr2071712637.72.1770184317666;
        Tue, 03 Feb 2026 21:51:57 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c8360c2e6sm973318a12.16.2026.02.03.21.51.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 21:51:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH v3 bpf-next 3/4] bpf: Add a recursion check to prevent loops in bpf_timer
Date: Tue,  3 Feb 2026 21:51:46 -0800
Message-ID: <20260204055147.54960-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204055147.54960-1-alexei.starovoitov@gmail.com>
References: <20260204055147.54960-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Do not schedule timer/wq operation on a cpu that is in irq_work
callback that is processing async_cmds queue.
Otherwise the following loop is possible:
bpf_timer_start() -> bpf_async_schedule_op() -> irq_work_queue().
irqrestore -> bpf_async_irq_worker() -> tracepoint -> bpf_timer_start().

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/helpers.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0517e9a8fc7c..01052f8664eb 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1427,9 +1427,23 @@ static int bpf_async_update_prog_callback(struct bpf_async_cb *cb,
 	return 0;
 }
 
+static DEFINE_PER_CPU(struct bpf_async_cb *, async_cb_running);
+
 static int bpf_async_schedule_op(struct bpf_async_cb *cb, enum bpf_async_op op,
 				 u64 nsec, u32 timer_mode)
 {
+	/*
+	 * Do not schedule another operation on this cpu if it's in irq_work
+	 * callback that is processing async_cmds queue. Otherwise the following
+	 * loop is possible:
+	 * bpf_timer_start() -> bpf_async_schedule_op() -> irq_work_queue().
+	 * irqrestore -> bpf_async_irq_worker() -> tracepoint -> bpf_timer_start().
+	 */
+	if (this_cpu_read(async_cb_running) == cb) {
+		bpf_async_refcount_put(cb);
+		return -EDEADLK;
+	}
+
 	struct bpf_async_cmd *cmd = kmalloc_nolock(sizeof(*cmd), 0, NUMA_NO_NODE);
 
 	if (!cmd) {
@@ -1628,6 +1642,7 @@ static void bpf_async_irq_worker(struct irq_work *work)
 		return;
 
 	list = llist_reverse_order(list);
+	this_cpu_write(async_cb_running, cb);
 	llist_for_each_safe(pos, n, list) {
 		struct bpf_async_cmd *cmd;
 
@@ -1635,6 +1650,7 @@ static void bpf_async_irq_worker(struct irq_work *work)
 		bpf_async_process_op(cb, cmd->op, cmd->nsec, cmd->mode);
 		kfree_nolock(cmd);
 	}
+	this_cpu_write(async_cb_running, NULL);
 }
 
 static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
-- 
2.47.3

