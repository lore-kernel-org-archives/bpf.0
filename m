Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB2E3A75B9
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830065; cv=none; b=LCrMKCTbph7Eu54opvOG4x390YqxIbD0MQa0Q1E+bOoI4D+ALGRTNmr6MR/bRqAwivdHg4byKTn3pzWZEz6rudTXUGgik9CBCHqXJZzJaRfJweYCf7ExUKCPhmJmZPCyrCgsHH4Lbks0foAP2KwV951+cgBIXWGCj3+sce6bbms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830065; c=relaxed/simple;
	bh=hOxm7SjlpbqBrEEDguYsG+OkjxtRvM2/8AInbZBt79Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBApC3NxxPYYyO/qO6mCHASjA0aVCN727D2g/2ABfYOs1TbQCxbZUMQ0ojsAi6i0E+QDXIc+l/riiCzM8zvS/48y0F1R1IB9ls3LrvmMYu5IfIIlwzMsZ8HMC4iQdDMHe5317O2mwWOncW345ju8RLWrJgOjEnIfrXG5y40cXpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov0qzb/o; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov0qzb/o"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b8ebe6bd1so112978f8f.2
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775830062; x=1776434862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qyzPpXAXSz138DHYR7mZI4kKk1VA1xvVpWE+tBCFF8M=;
        b=Ov0qzb/oKp48mDdjoRGkZv6L+RMdac2BAjVx/5FngAJcY0/R22AbqTL/HywJc0i0BN
         HYSNJXPVxbgPrvBldNh/aZARN7dUHdxpqpt1WFXJjAgTSdivgSnkcIDRceAY385kyUjj
         kDn9tYRllsvZTkyFwvSuBqYcDYuLXHswCLPsjvw/OAs3XH/aVzPpgChVl/WipGn62WcL
         xJIIFgbZlgFY50cXn/D9jYcuaZqwaGvIOjW8hhtxZYt7LiB+iEqjeXmcnm8hMxgYyXLG
         3iN7PaV5H9RiknGe8ENW3U7VRBZYWCiDeX7MbWbss7VlA+LkVripRCuSqcamGaRU7BBw
         EpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830062; x=1776434862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyzPpXAXSz138DHYR7mZI4kKk1VA1xvVpWE+tBCFF8M=;
        b=XwsqPD1DNV2IXHBwGAuqbV2CvUjMqXbFdhic4mcN1vSJrpECS1hbaxVheehqvZsKT6
         S9mZNRmH67W6/2TX6+ABW81mHw2QfBJ59yC8Cs24ggRpMo/LT4Bq7iqv7MVEuZm9Fh0b
         94QQvk5lFen4enleUxGM+6NYZfdK5Ot7G8IMh+7GexNlL5gfgDy7yof0LRjsNKPszYP5
         sBgL3+yOpdmLuQP/THMwOb/20Usb8osDcGq6uCrxJNDyKrL7mD3onbAYCLxwOeBqJxz2
         R1EN/J9hwX9JNHJIe35IfIVbw4SVNjNS7CWsf2x/VEbFYLJmb4CWRza75DaFHQeKiHrA
         Cw4A==
X-Gm-Message-State: AOJu0YzYOJgtEnsdY1MHqjbNHtWQkJXJpYy7FTRThqELZXoyZFXNuFtl
	zgaow5Y/wLH2Hf2uY7AzauiFIX3gSG+i7YdNCThNOrrk6fhhQgrgPerBpEXGdHN4
X-Gm-Gg: AeBDiesRFZsTSR5VZHVFqZDVbqfIeQvRq8dY/xz6oGLxIcbQjuWqRBltlnJTruW8TqW
	H8hCM54YDBTkKQoHK/9ZCDTjwbp+5fsSmf3rXmVFy47HewxPWbJlbY7+ST75bTK0+/vGaLvEtxO
	8SdEzNQAu7ad9ClkszoxzU63+4ss4gPRoIZvFKnRyLnTVqLvJRQDJ7c0/sBOVSDoTSKKVWFdXtX
	omWEgtlT/vD3bhfYCq58yCYZtLPkNe+nLMQro0v3KYUjr1uaU1fJapokQTaazgZhbsqb73JFOcc
	/R0g5iNgbZLFvO90r6Z75NAvnlWUDDEqKu5KH2DOwbk2b+XJYh0hfFkjFmy/wcj2cAcEMkVo1LJ
	sAhp+LiHN6g6UiPSBopmTB3f7UR9/pB4njb9gK8Jr6N+7B35wSc7Uci8ZvKIF4xc+bEi14wLamA
	91vWutZru4qUOum82Ij2K+80V1vH57evqze2bvl8RV+S1hQ8LWzr/N/s5XHvSQpWDFaEi01pDEW
	c7KIn4=
X-Received: by 2002:a05:600c:1f83:b0:488:a9e4:35be with SMTP id 5b1f17b1804b1-488d687c0f9mr24225825e9.5.1775830062231;
        Fri, 10 Apr 2026 07:07:42 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4a46sm47409655e9.4.2026.04.10.07.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:07:41 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
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
	Zijing Yin <yzjaurora@gmail.com>
Subject: [PATCH bpf-next] bpf: reuseport: add cond_resched_rcu() in reuseport_array_free()
Date: Fri, 10 Apr 2026 07:07:25 -0700
Message-ID: <20260410140725.961623-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reuseport_array_free() iterates over all map entries inside
rcu_read_lock() to detach sockets from the array. When max_entries is
very large (e.g., hundreds of millions), this loop runs for an extended
period without yielding the CPU, triggering RCU stall warnings in the
kworker thread that executes bpf_map_free_deferred().

The observed stall occurs because the loop has no scheduling point:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  Workqueue: events_unbound bpf_map_free_deferred
  Call Trace:
   reuseport_array_free+0x1ec/0x470 kernel/bpf/reuseport_array.c:127
   bpf_map_free_deferred+0x34a/0x7e0 kernel/bpf/syscall.c:893
   process_one_work+0x952/0x1a80
   worker_thread+0x87b/0x11f0

Add cond_resched_rcu() in the loop body to allow the scheduler to run
and RCU grace periods to complete. This is safe because each iteration
processes a single entry independently, sk->sk_callback_lock is not held
across the yield point, and the map is fully detached from userspace so
no concurrent insertions can occur.

This follows an established pattern for long-running kernel loops that
must run under rcu_read_lock().  The closest precedent is in another BPF
map free function:

  kernel/bpf/hashtab.c:1600
    htab_free_malloced_internal_structs()
      rcu_read_lock();
      for (i = 0; i < htab->n_buckets; i++) {
          ... walk bucket ...
          cond_resched_rcu();
      }
      rcu_read_unlock();

Fixes: 5dc4c4b7d4e8 ("bpf: Introduce BPF_MAP_TYPE_REUSEPORT_SOCKARRAY")
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
Base: bpf-next.git master branch
      (tip a0c584fc18056709c8e047a82a6045d6c209f4ce
       "bpf: Fix use-after-free in offloaded map/prog info fill"
       as of 2026-04-09).

Tested with CONFIG_PREEMPT_RCU=y, CONFIG_KASAN=y (inline),
CONFIG_SMP=n (single vCPU QEMU VM), gcc 13.3.0.

To reproduce: create a BPF_MAP_TYPE_REUSEPORT_SOCKARRAY with
max_entries >= 100M, set rcu_cpu_stall_timeout low, pin the CPU with a
SCHED_FIFO thread so the kworker stays in rcu_read_lock() long enough
to trip the stall timeout, then close the fd. Without the fix the
reuseport_array_free() kworker stalls RCU reliably; with the fix,
cond_resched_rcu() yields periodically and no stall is observed.
Reproducer (C source): repro_reuseport.c (https://pastebin.com/YjdwqdX1)

 kernel/bpf/reuseport_array.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 49b8e5a0c6b4f..e3c789b80e2b8 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -5,6 +5,7 @@
 #include <linux/bpf.h>
 #include <linux/err.h>
 #include <linux/sock_diag.h>
+#include <linux/rcupdate_wait.h>
 #include <net/sock_reuseport.h>
 #include <linux/btf_ids.h>

@@ -136,6 +137,7 @@ static void reuseport_array_free(struct bpf_map *map)
 			write_unlock_bh(&sk->sk_callback_lock);
 			RCU_INIT_POINTER(array->ptrs[i], NULL);
 		}
+		cond_resched_rcu();
 	}
 	rcu_read_unlock();

-- 
2.43.0
