Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489062;
	b=10W8zw6Ce6y0U8VBuAG+KskWfs/jz5UvnsScvXMSP2CeROXpa4Y3VZowwq1o2xNo7UXr
	 t5K6VDRul/ujtpzswlV/ZMyMZ4QN0oHZWvZYVgdRM6Mem3c/uXwJeyUPVRuGw13Ai64f2
	 gA1DYTA4NIaTJSPN5kHVcfmKRBz7OtJ2rL2dNkv9caKRo8CV8vIzgZJ9ByQswRZ/LEP37
	 yULHDrWadOpR0plgz0+issE2t33usoXqUyujOBbItAAQgM847j3V8CHYMClyznCd3tIbr
	 WNfYASu8ggN+cYJoBaD/yz7Abbfr2H/XWI0mVT+kCjihH73HdqHsPS1XRZARXsiBmmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489062;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BW+evLCwYzgT0GOJ7iXT+1380LgSCWUXaHPzAnO9hFo=;
	b=2kHcVQjpDVpydWbXfpeKl/ZkdgHwFTNVoFafiKaI4/9b/rJZvgQM7+Ugsz2bKJSkVb1B
	 KjKuqxM4TjCItfU+lU6+P0Ud7xjCSOpGBiLZp0+E1tCgGjgSh0sO68dELNT0B6FS7LcB9
	 TGyaVHoDWmN4JIvUZmSEAoH8A8HW8fPfAAprLqm/L6dwJUJi2A8sZF/3OuvM3o6Gq2yzp
	 E2BogkVEYWJ1xDdkzRubhDIN0Vl4SPHWCZ8bg7zTJoAL5WwYFrptQ1zo8/F/XCeyXEDUq
	 nH0PJjrXW53RC9774gSB/U0Dms5rh1TBOkeSk9I+vXHiJvj8ugEiqk/wSN5WfvCFM7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qBQLcaX+;
	arc=none smtp.remote-ip=95.215.58.36
Received: from mta1.migadu.com (out-36.mta1.migadu.com [95.215.58.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE8606A884
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 13:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65CE8606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qBQLcaX+
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=W34IEyxXNHmafjPVCQKPdoBcem/laKBLdON5EZxe8XQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794489059; v=1; x=1795093859;
 b=qBQLcaX+Me9W57ltaRTAIhnjpIRKP+PymHektNYZ4RwLctL4Q2fAArBiRRHG3fZVjj1KXlbU
 kfVL4iOWVueCM0CJ161yJrLgKWMwQLLmXGymHBgkHkmETGRyHW1lMNJdF6NplUYjDUfxAKVbb7C
 msg8OQMVcRDPbRISi1LDi7kg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a55b6c2c48a7caae;
	Thu, 12 Nov 2026 13:10:59 +0000
X-Mizu-Trace-ID: a55b6c2c48a7caae
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	liwanwu@kylinos.cn,
	usama.arif@linux.dev,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 6/6] sched_ext: Clear the built-in idle masks on CPU hotplug transitions
Date: Thu, 12 Nov 2026 21:09:34 +0800
Message-ID: <20261112130934.563321-7-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112130934.563321-1-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The built-in idle masks are only maintained by __scx_update_idle()
(task driven idle transitions) and reset_idle_masks() (ops load);
nothing clears them when a CPU is hotplugged. If a CPU goes offline
while idle, its bit stays set for the whole offline window:
scx_bpf_pick_idle_cpu() and the other idle kfuncs keep reporting the
offline CPU as an idle candidate, and the built-in select_cpu path may
claim it once before the guard layers bounce the wakeup, costing a
failed pick and a bumped SCX_EV_SELECT_CPU_FALLBACK each time. This is
not the documented racy and self-correcting regime of the idle SMT
handling: the stale bit is a deterministic leftover, and read-only
kfunc consumers never trigger the claim-time self-correction.

handle_hotplug() now drops the CPU from the built-in idle masks on
both transitions like it already does for the cid-form online_cmask.
scx_idle_test_and_clear_cpu() is also gated on cpu_online(): the clear
alone is not sufficient, because a dying CPU keeps re-picking its idle
task until it halts and each re-pick re-sets its bit, which can happen
after the hotplug paths have already run. The claim path is the one
choke point every idle consumer goes through, so an offline CPU is
never handed out as an idle candidate regardless of any stale bits.

Verified in qemu (4 cpus) with an idle-probe scheduler probing
scx_bpf_pick_idle_cpu() every dispatch: 15/15 offline/online cycles
probe zero stale entries with the change. Stock is not A/B-comparable,
as every hotplug transition restarts the scheduler and reinitializes
the masks; the fix rests on the path above.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/ext.c  |  7 +++++++
 kernel/sched/ext/idle.c | 21 +++++++++++++++++++++
 kernel/sched/ext/idle.h |  1 +
 3 files changed, 29 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 792cf0c1d582..a9612d768986 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4356,6 +4356,13 @@ static void handle_hotplug(struct rq *rq, bool online)
 	if (scx_enabled())
 		scx_idle_update_selcpu_topology(&sch->ops);
 
+	/*
+	 * Keep the built-in idle masks in sync with the hotplug state: an
+	 * offline CPU must stop being advertised as idle and a CPU coming
+	 * back must not inherit a stale idle bit.
+	 */
+	scx_idle_clear_cpu(cpu);
+
 	/*
 	 * The tables can't be retired while this function is running as the
 	 * retirement is inside cpus_read_lock. However, scx_cpu_arg() is
diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index 922fbc3065cc..ff0c5402886e 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -107,6 +107,18 @@ static bool scx_idle_test_and_clear_cpu(int cpu)
 			__cpumask_clear_cpu(cpu, idle_smts);
 	}
 
+	/*
+	 * An offline CPU is never an idle candidate, but its bit can
+	 * linger past @cpu going offline: the dying CPU keeps re-picking
+	 * its idle task until it halts, which can happen after the
+	 * hotplug paths have already run. Drop the stale bit and refuse
+	 * the claim.
+	 */
+	if (unlikely(!cpu_online(cpu))) {
+		cpumask_clear_cpu(cpu, idle_cpus);
+		return false;
+	}
+
 	return cpumask_test_and_clear_cpu(cpu, idle_cpus);
 }
 
@@ -743,6 +755,15 @@ static void update_builtin_idle(int cpu, bool idle)
 	}
 }
 
+/*
+ * Drop @cpu from the built-in idle masks; used on hotplug transitions
+ * so an offline CPU stops being advertised as idle.
+ */
+void scx_idle_clear_cpu(s32 cpu)
+{
+	update_builtin_idle(cpu, false);
+}
+
 /*
  * Notify schedulers of an idle transition on @cpu's cid, delivering to every
  * sched that holds %SCX_CAP_BASE on the cid (the root holds every cap). A real
diff --git a/kernel/sched/ext/idle.h b/kernel/sched/ext/idle.h
index 87a0e58f1eb7..89180abbfd21 100644
--- a/kernel/sched/ext/idle.h
+++ b/kernel/sched/ext/idle.h
@@ -21,6 +21,7 @@ extern struct btf_id_set8 scx_kfunc_ids_select_cpu;
 
 void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
 void scx_idle_init_masks(void);
+void scx_idle_clear_cpu(s32 cpu);
 
 s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		       const struct cpumask *cpus_allowed, u64 flags);
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
