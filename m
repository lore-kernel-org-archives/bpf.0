Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA12F83B7
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481899; cv=none; b=pjV+DoihWR6+HUqqOhL6JzRQJxGWolVNx0HkMmnzcejyJLkFNcC1RT1L+KiNI21frWktYm6CzGE7ANTvxuVjS0u9okxp6l/Ua3XtBKXY8vUUm83YSi/Bbq/hXsAuIIDZXm2OqKiuSix4LkLAZmWlUUYYnSKNXD81r0qJk36zX2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481899; c=relaxed/simple;
	bh=3N97yFRJXvKb6b7YL/mFRwcaLHNXAj/gBI2abLc2SGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qufaS4EESHZhK6nd1RKncQbOp5398zEGtTI7PsmhSICO2HeMk1cDZNFwCYjD17rTsxN139f6wRstwU/wb1a2u0d5QUcUHJUhNA8VWWi0MkY4rm3wyMIFwtRNiFqzcHN05le+j71oMS67QZZGnvSj+dJKw+JETyEaaWeU6QdbqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XpnXCFjc; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XpnXCFjc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769481896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1h1q5g16E2+HxxmA8AEi7c9OVDnvBp79Z3yJmFR5fgE=;
	b=XpnXCFjcm8y7faBJpFYJww+jR+yGYIHG+kqWgVobyvG10nkq2uyy+a9X01QSIZXtEpruj6
	+K6dysT8+y97FCtJ8wJabeeZaRN0OhmcoXRPIezWmweIuRstHhMBlx8CDBy5DAzYxm9xII
	Oml/IlbtnEFladSFRfFwvh59cNyoa9Y=
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
Subject: [PATCH bpf-next v3 08/17] mm: introduce bpf_oom_kill_process() bpf kfunc
Date: Mon, 26 Jan 2026 18:44:11 -0800
Message-ID: <20260127024421.494929-9-roman.gushchin@linux.dev>
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

Introduce bpf_oom_kill_process() bpf kfunc, which is supposed
to be used by BPF OOM programs. It allows to kill a process
in exactly the same way the OOM killer does: using the OOM reaper,
bumping corresponding memcg and global statistics, respecting
memory.oom.group etc.

On success, it sets the oom_control's bpf_memory_freed field to true,
enabling the bpf program to bypass the kernel OOM killer.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/oom_kill.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 44bbcf033804..09897597907f 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -46,6 +46,7 @@
 #include <linux/cred.h>
 #include <linux/nmi.h>
 #include <linux/bpf_oom.h>
+#include <linux/btf.h>
 
 #include <asm/tlb.h>
 #include "internal.h"
@@ -1290,3 +1291,82 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 	return -ENOSYS;
 #endif /* CONFIG_MMU */
 }
+
+#ifdef CONFIG_BPF_SYSCALL
+
+__bpf_kfunc_start_defs();
+/**
+ * bpf_oom_kill_process - Kill a process as OOM killer
+ * @oc: pointer to oom_control structure, describes OOM context
+ * @task: task to be killed
+ * @message__str: message to print in dmesg
+ *
+ * Kill a process in a way similar to the kernel OOM killer.
+ * This means dump the necessary information to dmesg, adjust memcg
+ * statistics, leverage the oom reaper, respect memory.oom.group etc.
+ *
+ * bpf_oom_kill_process() marks the forward progress by setting
+ * oc->bpf_memory_freed. If the progress was made, the bpf program
+ * is free to decide if the kernel oom killer should be invoked.
+ * Otherwise it's enforced, so that a bad bpf program can't
+ * deadlock the machine on memory.
+ */
+__bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
+				     struct task_struct *task,
+				     const char *message__str)
+{
+	if (oom_unkillable_task(task))
+		return -EPERM;
+
+	if (task->signal->oom_score_adj == OOM_SCORE_ADJ_MIN)
+		return -EINVAL;
+
+	/* paired with put_task_struct() in oom_kill_process() */
+	get_task_struct(task);
+
+	oc->chosen = task;
+
+	oom_kill_process(oc, message__str);
+
+	oc->chosen = NULL;
+	oc->bpf_memory_freed = true;
+
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_oom_kfuncs)
+BTF_ID_FLAGS(func, bpf_oom_kill_process, KF_SLEEPABLE)
+BTF_KFUNCS_END(bpf_oom_kfuncs)
+
+BTF_ID_LIST_SINGLE(bpf_oom_ops_ids, struct, bpf_oom_ops)
+
+static int bpf_oom_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS ||
+	    prog->aux->attach_btf_id != bpf_oom_ops_ids[0])
+		return -EACCES;
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_oom_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_oom_kfuncs,
+	.filter         = bpf_oom_kfunc_filter,
+};
+
+static int __init bpf_oom_init(void)
+{
+	int err;
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&bpf_oom_kfunc_set);
+	if (err)
+		pr_warn("error while registering bpf oom kfuncs: %d", err);
+
+	return err;
+}
+late_initcall(bpf_oom_init);
+
+#endif
-- 
2.52.0

