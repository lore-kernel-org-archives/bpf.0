Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6C2FD7A7
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481903; cv=none; b=J5LQds9odBgAv3mcVkvpVIAd6eUZ+hhmjbpRFnbSFtcdHTVgJW8XpyquiflCGJimQSm15xtR5xV2tWqRypoQ5lkoI3UILo+pz7EKnnRU4l+HyNPrSLB9hitwb1Dekd0903OPoHbmaXktA7h3OZMEf9OsNzpmFawBIp5oByjaPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481903; c=relaxed/simple;
	bh=MgWs5lP6r3Qfa3ZTdKxYXq1lDV/7HubPkzoqUi5YZuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwZ8Zo4c2EFfSWA7fuLUu7xVBH+IGPWHHFzs74y0/K1xMd4sPuXmpJRIVACj/iY2R0Vir2Qu+xjMHo6DqI1s4XsZH345Tjk5S6LEaDHnYVPdvnJV9mkLh0Cm4teQQouYVKPYQz22Bv3NrGuHlk6wgKVmKB2XUyhd98zcOjxMPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xo4Wlf2s; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xo4Wlf2s"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769481899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jnmuzCSLEAcMoftcKzgrUEP3R0cGte9hNLunPOvNN4=;
	b=xo4Wlf2st4h78zZyRTjozjqSvP2G67otMcHptD9RUQEBUHCt5kCMtTK6HiJeG9/APRhhgu
	Jf4VG+YWbC7GLvrQ10Z7/7EK5//vc9rT7vUWhMqlw+GDtG3197LpdOSk57CeIdhQ8SSUkD
	HFIMJaueXEy4M09lIcO8ICQm1zO0ICE=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next v3 09/17] mm: introduce bpf_out_of_memory() BPF kfunc
Date: Mon, 26 Jan 2026 18:44:12 -0800
Message-ID: <20260127024421.494929-10-roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-1-roman.gushchin@linux.dev>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
an out of memory events and trigger the corresponding kernel OOM
handling mechanism.

It takes a trusted memcg pointer (or NULL for system-wide OOMs)
as an argument, as well as the page order.

If the BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK flag is not set, only one OOM
can be declared and handled in the system at once, so if the function
is called in parallel to another OOM handling, it bails out with -EBUSY.
This mode is suited for global OOM's: any concurrent OOMs will likely
do the job and release some memory. In a blocking mode (which is
suited for memcg OOMs) the execution will wait on the oom_lock mutex.

The function is declared as sleepable. It guarantees that it won't
be called from an atomic context. It's required by the OOM handling
code, which shouldn't be called from a non-blocking context.

Handling of a memcg OOM almost always requires taking of the
css_set_lock spinlock. The fact that bpf_out_of_memory() is sleepable
also guarantees that it can't be called with acquired css_set_lock,
so the kernel can't deadlock on it.

To avoid deadlocks on the oom lock, the function is filtered out for
bpf oom struct ops programs and all tracing programs.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/oom.h |  5 +++
 mm/oom_kill.c       | 85 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index c2dce336bcb4..851dba9287b5 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -21,6 +21,11 @@ enum oom_constraint {
 	CONSTRAINT_MEMCG,
 };
 
+enum bpf_oom_flags {
+	BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK = 1 << 0,
+	BPF_OOM_FLAGS_LAST = 1 << 1,
+};
+
 /*
  * Details of the page allocation that triggered the oom killer that are used to
  * determine what should be killed.
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 09897597907f..8f63a370b8f5 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1334,6 +1334,53 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
 	return 0;
 }
 
+/**
+ * bpf_out_of_memory - declare Out Of Memory state and invoke OOM killer
+ * @memcg__nullable: memcg or NULL for system-wide OOMs
+ * @order: order of page which wasn't allocated
+ * @flags: flags
+ *
+ * Declares the Out Of Memory state and invokes the OOM killer.
+ *
+ * OOM handlers are synchronized using the oom_lock mutex. If wait_on_oom_lock
+ * is true, the function will wait on it. Otherwise it bails out with -EBUSY
+ * if oom_lock is contended.
+ *
+ * Generally it's advised to pass wait_on_oom_lock=false for global OOMs
+ * and wait_on_oom_lock=true for memcg-scoped OOMs.
+ *
+ * Returns 1 if the forward progress was achieved and some memory was freed.
+ * Returns a negative value if an error occurred.
+ */
+__bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
+				  int order, u64 flags)
+{
+	struct oom_control oc = {
+		.memcg = memcg__nullable,
+		.gfp_mask = GFP_KERNEL,
+		.order = order,
+	};
+	int ret;
+
+	if (flags & ~(BPF_OOM_FLAGS_LAST - 1))
+		return -EINVAL;
+
+	if (oc.order < 0 || oc.order > MAX_PAGE_ORDER)
+		return -EINVAL;
+
+	if (flags & BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK) {
+		ret = mutex_lock_killable(&oom_lock);
+		if (ret)
+			return ret;
+	} else if (!mutex_trylock(&oom_lock))
+		return -EBUSY;
+
+	ret = out_of_memory(&oc);
+
+	mutex_unlock(&oom_lock);
+	return ret;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_oom_kfuncs)
@@ -1356,14 +1403,48 @@ static const struct btf_kfunc_id_set bpf_oom_kfunc_set = {
 	.filter         = bpf_oom_kfunc_filter,
 };
 
+BTF_KFUNCS_START(bpf_declare_oom_kfuncs)
+BTF_ID_FLAGS(func, bpf_out_of_memory, KF_SLEEPABLE)
+BTF_KFUNCS_END(bpf_declare_oom_kfuncs)
+
+static int bpf_declare_oom_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_declare_oom_kfuncs, kfunc_id))
+		return 0;
+
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+	    prog->aux->attach_btf_id == bpf_oom_ops_ids[0])
+		return -EACCES;
+
+	if (prog->type == BPF_PROG_TYPE_TRACING)
+		return -EACCES;
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_declare_oom_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_declare_oom_kfuncs,
+	.filter         = bpf_declare_oom_kfunc_filter,
+};
+
 static int __init bpf_oom_init(void)
 {
 	int err;
 
 	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					&bpf_oom_kfunc_set);
-	if (err)
-		pr_warn("error while registering bpf oom kfuncs: %d", err);
+	if (err) {
+		pr_warn("error while registering struct_ops bpf oom kfuncs: %d", err);
+		return err;
+	}
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					&bpf_declare_oom_kfunc_set);
+	if (err) {
+		pr_warn("error while registering unspec bpf oom kfuncs: %d", err);
+		return err;
+	}
 
 	return err;
 }
-- 
2.52.0

