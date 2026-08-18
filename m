Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027FB2116F4
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787012698; cv=none; b=hBsSZzJj29I9G/+j6lhGcmmZL13z+3o7KKnXWuvjM9rbMHujRndwffjv1UEW19GnSbeoZYrJYTQL/nR07SEgWnaDcWylcxKNLj8skS9CYJTVQmWQhKQ35PHYrGMOZOpuRsylWLQx7NGGsp64SUHPp0yS7bvFGxaXUOeDUwhORpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787012698; c=relaxed/simple;
	bh=U0cdwRkNU8DDkTZBzpmBkqOIyFGgDUIy3LahHB12YmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+znWEroGOOYHnLo/yBvVjo2/dfGrKleFHczWX6/UJ/Soemvuch9RV75mZ4dP2S+B9bHyjNzNbt1byiIaXi9eDgG6g32dSoiyUc0QfEjDrn9CXcdKh+jZwCsrlgm7yTr8SM0zgCQX9KFv3d4pSnH46cYeO378jwFbCx+jgAfucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvZ8/ci7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvZ8/ci7"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so340509a12.0
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 17:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787012695; x=1787617495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dqe2p//IXwPRRWOgvWYahO9x2ZMS0WvCKoSIYY1NM34=;
        b=NvZ8/ci77f42Sts/5nli7p1aZJwGPjbZgu2OsgTl6nNAuL6Pyw2e4AgWk4NjM/1yXL
         GqPR5cLT9qzjK26zo5txgSE5KUyK8E0266a6J0CVQYKEzn/r+hGVqBNHJ05erf6Z9J0R
         nMaXROf83vhBLsykD+jkwIqWy1193VriXXQVkWgreSbLEFMXb+CmX9mvZPB9WQUNZF1j
         Z2zPLC0JVxD4UITe3hhiZk9UnbgTQaRtPO82ZLZ0E9HhAWlbHrrGs4VhF25fcDidCbhp
         UUlT1LgnZEYl0R0W1NlxhsKNx+A014xZ3n1ysQz2l1xYAOTrZUQPWpVS49CwIWCEfgTc
         LqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787012695; x=1787617495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dqe2p//IXwPRRWOgvWYahO9x2ZMS0WvCKoSIYY1NM34=;
        b=OTO5ETk46gJmsdVLzFKApGwVJemLuMet/VkDR2fTDOz4wcCuKaPg2SX0WABEKN5Ftk
         qsP8KERmaZdCbIhhP7TO/GZk69jphvQDFSgiIGmfTDHp2hlfbsGyaYAZ5NBPRtrubBXd
         JuidkzbMJQhGG92CaTdJnct9H55gdYWbpCL7QKTMYRk9+nFEt+yx1heHEiD4zl+5x2xX
         zjg5QP5EzONhMhcfvWXuwDvdc88LQKPrbjD0nHwJucCE0ggBTmVp7lZcO20pFMJJs7je
         RpEEyzts2TJaIsQqhUdlmgCWeaYDXjJadGZXLJ2MzSI6oE0zbnPSsPQcvp4Dbcx5A7KW
         NYNA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1SMb8zWRYgghhRLDb69bX/KDp6e0T1M6IKcXsBKg/tGYQTgOdD3OFIKwPiriAAVHBHeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+FxHZIrOjtoKTh0GUHN8VxlOz4Pp1ZIEDhw/lhBh/wQYWLHmm
	R6sxBKxWwEyZxh3cVGP7lrHBvbbKQy+W7IwxTw16Mw2vlN6kHLAgvzuj
X-Gm-Gg: AR+sD13G/qMbN82JlwomOT7EaUrwuLGZQE/ejKWldPXRNf2sYbbhbeqTPdyWuRnOYD0
	evVPjSfEYBVcr3v6Ta5+aqGTBJE4chxllDSz2VdJXjz0I/t0Xdd6E1NysMzgZzf2ffekxACpUQq
	cJyZt/yM4DV4nsRlfKpu7LRhaA9r0tVJg4obwryN7CShzN95+lLvhOjXUKzyPmbwb9g8QWTVv+n
	L29/M8fRN/OZtfl3XCl0PJvYv/mEjjaKjFqNf3c2Am9JQQ8P6T/QLm13fiisWgvqPCWdJXm+KYs
	vv/Cb65Q4NYjsnPJs6ktEZEbNcE5oOkU+8zAmEmTk49UsB0oLYIhJF2QzkjRHS7WroX+8daFWdY
	GBScZ+hvVrN6CFVuLS5f0L29HWkMmiRi397nYVKTHE1xJzwv+8GrBO5yuKJcVhDPo1gV9cuGXZD
	lu1lkRyyh/TiN0rZDGKGcXe5i71bv4Pj+1LOLjjeRCnfDudfcblB+SpXk=
X-Received: by 2002:a17:90b:17ce:b0:38e:7e9b:5fbc with SMTP id 98e67ed59e1d1-3955f0e4554mr2145187a91.7.1787012695192;
        Mon, 17 Aug 2026 17:24:55 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:6b::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32678dcedf4sm10262056eec.5.2026.08.17.17.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 17:24:54 -0700 (PDT)
From: Ziyang Men <ziyang.meme@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	kernel-team@meta.com
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Ziyang Men <ziyang.meme@gmail.com>,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] cgroup: add BPF kfuncs to read a cpu cgroup's stats
Date: Mon, 17 Aug 2026 17:24:49 -0700
Message-ID: <20260818002450.3071325-2-ziyang.meme@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818002450.3071325-1-ziyang.meme@gmail.com>
References: <20260818002450.3071325-1-ziyang.meme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Collecting cgroup statistics is expensive: the existing
method is to open and parse a cgroup file. memcg already has an
efficient alternative through BPF; this series extends that idea to cpu.

Expose the CPU controller's per-cgroup statistics to BPF, following
the memory controller kfuncs in mm/bpf_memcontrol.c.

Design:
- Add bpf_css_flush_rstat() and bpf_cgroup_base_stat() to cgroup rstat.
  The second kfunc returns the raw cgroup_base_stat after the
  same cputime adjustment used by cpu.stat.
- Leave reading the CFS bandwidth counters to the BPF program. They are
  plain fields of tg->cfs_bandwidth, so they need no kernel code.
- Add bpf_css_to_task_group(), which returns a checked RCU pointer of
  the task_group*. This is usefule to compute the throttled time in bpf
  side since the bpf_per_cpu_ptr() requires a verifier-known struct
  task_group * and a pointer carrying the MEM_PERCPU property. 
  This use the convention that task_group embeds its css at offset zero,
  so no scheduler helper or scheduler source change is needed.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Suggested-by: Tejun Heo <tj@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Ziyang Men <ziyang.meme@gmail.com>
---
 kernel/cgroup/Makefile  |  2 ++
 kernel/cgroup/bpf_cpu.c | 61 +++++++++++++++++++++++++++++++++++++++++
 kernel/cgroup/rstat.c   | 59 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 120 insertions(+), 2 deletions(-)
 create mode 100644 kernel/cgroup/bpf_cpu.c

diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index ede31601a363..0ba59b7eef48 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o freezer.o
 
+obj-$(CONFIG_BPF_SYSCALL) += bpf_cpu.o
+
 obj-$(CONFIG_CGROUP_FREEZER) += legacy_freezer.o
 obj-$(CONFIG_CGROUP_PIDS) += pids.o
 obj-$(CONFIG_CGROUP_RDMA) += rdma.o
diff --git a/kernel/cgroup/bpf_cpu.c b/kernel/cgroup/bpf_cpu.c
new file mode 100644
index 000000000000..ac165d0b79ef
--- /dev/null
+++ b/kernel/cgroup/bpf_cpu.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CPU controller BPF kfuncs
+ *
+ * Author: Ziyang Men <ziyang.meme@gmail.com>
+ */
+
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/cgroup.h>
+
+#ifdef CONFIG_CGROUP_SCHED
+struct task_group;
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_css_to_task_group - Cast a CPU controller css to its task group
+ * @css: CPU controller css
+ *
+ * Must be called under RCU.
+ * A C cast does not give the verifier a task_group pointer. This kfunc
+ * preserves the task_group and per-CPU types needed to read cfs_rq.
+ *
+ * Return: The task group, or NULL if @css belongs to another controller.
+ */
+__bpf_kfunc struct task_group *
+bpf_css_to_task_group(struct cgroup_subsys_state *css)
+{
+	if (css->ss != &cpu_cgrp_subsys)
+		return NULL;
+
+	/* task_group embeds css at offset zero. */
+	return (struct task_group *)css;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_cpu_cgroup_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_css_to_task_group,
+	     KF_RCU | KF_RCU_PROTECTED | KF_RET_NULL)
+BTF_KFUNCS_END(bpf_cpu_cgroup_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_cpu_cgroup_kfunc_set = {
+	.owner		= THIS_MODULE,
+	.set		= &bpf_cpu_cgroup_kfunc_ids,
+};
+
+static int __init bpf_cpu_cgroup_kfunc_init(void)
+{
+	int err;
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					&bpf_cpu_cgroup_kfunc_set);
+	if (err)
+		pr_warn("error while registering cpu cgroup kfuncs: %d\n", err);
+
+	return err;
+}
+late_initcall(bpf_cpu_cgroup_kfunc_init);
+#endif /* CONFIG_CGROUP_SCHED */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index de816a43db9f..46c322c4858b 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -752,6 +752,54 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	cgroup_force_idle_show(seq, &bstat);
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_css_flush_rstat - Flush a cgroup subsystem's rstat data
+ * @css: cgroup subsystem state to flush
+ */
+__bpf_kfunc void bpf_css_flush_rstat(struct cgroup_subsys_state *css)
+{
+	css_rstat_flush(css);
+}
+
+/**
+ * bpf_cgroup_base_stat - Read a cgroup's base statistics
+ * @cgrp: cgroup to read from
+ * @out: zero-initialized output in nanoseconds
+ *
+ * CPU time is adjusted as for cpu.stat.
+ */
+__bpf_kfunc void bpf_cgroup_base_stat(struct cgroup *cgrp,
+				      struct cgroup_base_stat *out)
+{
+	if (cgroup_parent(cgrp)) {
+		__css_rstat_lock(&cgrp->self, -1);
+		*out = cgrp->bstat;
+		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
+			       &out->cputime.utime, &out->cputime.stime);
+		__css_rstat_unlock(&cgrp->self, -1);
+	} else {
+		root_cgroup_cputime(out);
+	}
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_rstat_common_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_css_flush_rstat, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_cgroup_base_stat, KF_SLEEPABLE)
+BTF_KFUNCS_END(bpf_rstat_common_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_rstat_common_kfunc_set = {
+	.owner		= THIS_MODULE,
+	.set		= &bpf_rstat_common_kfunc_ids,
+};
+
+#endif /* CONFIG_BPF_SYSCALL */
+
 /* Add bpf kfuncs for css_rstat_updated() and css_rstat_flush() */
 BTF_KFUNCS_START(bpf_rstat_kfunc_ids)
 BTF_ID_FLAGS(func, css_rstat_updated)
@@ -765,7 +813,14 @@ static const struct btf_kfunc_id_set bpf_rstat_kfunc_set = {
 
 static int __init bpf_rstat_kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
-					 &bpf_rstat_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					&bpf_rstat_kfunc_set);
+#ifdef CONFIG_BPF_SYSCALL
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					       &bpf_rstat_common_kfunc_set);
+#endif
+	return ret;
 }
 late_initcall(bpf_rstat_kfunc_init);
-- 
2.53.0-Meta

