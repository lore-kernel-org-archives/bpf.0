Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FDD374E6D;
	Fri,  6 Mar 2026 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782351; cv=none; b=MhTK7cIJ379/YyawU6CSpscSzI7uVgmO35Aqc+J1AKoOWe0HvthiwOHMnhAncwpfWngBIQY7HWwtTWqCjQ3bp2201dia7VGypN6kys/36maQBZV9FkrzYFnlZXkRhAGdjnZOOGXpeOM/JKwCZxXh4DmN2boshKvkePTucUp7Ncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782351; c=relaxed/simple;
	bh=nq+gKYvBVh8CCQrMZgS/17fJgAVyRB5bfKBSmYEnThg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChPbjhFEXthz6aYYk2kwWlDlghFPijZpJYkVU8uLliZusqQRpahL2mQAu5FR7RmnY66eGvuEgkhtSQBva7PtjiSNdiHTw6uBzpIxa8IxFnBroqX/Ukrb9BoQvNXtw6pF0t7ePY/92L5JYbYChd2KiIm0G7gxnvVz2F3VAe/HerQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=F9sriAIO; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="F9sriAIO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=kL
	9pzxcbWCJ7nrsEz3VRw6n72+rSbWAhFJ7F+/FBEcM=; b=F9sriAIO8bZ9Yz1d/7
	yl2lVfR0kHbceIx3yf8ObTuMQgdJPWHD7wSUUdUEQaMqZZTjc6F9AuCX9bzf7UzW
	BCqoClCBj8Rsb12Pqf7IwNt5OkSyTeHfuShIxZe/iLzum3m/01I9eDNzumVjB7Jv
	Qg/l56K8csOJnR5mprOA8rrns=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgCHt9PNgqppuc55BQ--.55212S3;
	Fri, 06 Mar 2026 15:31:26 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	emil@etsalapatis.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	zhaomengmeng@kylinos.cn
Subject: [PATCH 1/3] sched_ext: remove SCX_OPS_HAS_CGROUP_WEIGHT
Date: Fri,  6 Mar 2026 15:31:08 +0800
Message-ID: <20260306073110.229595-2-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306073110.229595-1-zhaomzhao@126.com>
References: <20260306073110.229595-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgCHt9PNgqppuc55BQ--.55212S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary3ZF1rCry8Aw43Cw1rZwb_yoW8KFW7pF
	4DuF48tr17try7Ga18ua1vgFyUW3y3Gw42gFWDXr4S9r4kKr1aqwn8tr43ZryYgayrZF4f
	GF4qka47Gw1UWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3ManUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlw7YUGmqgs4FlwAA3M

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

While running scx_flatcg, dmesg prints "SCX_OPS_HAS_CGROUP_WEIGHT is
deprecated and a noop", in code, SCX_OPS_HAS_CGROUP_WEIGHT has been
marked as DEPRECATED, and will be removed on 6.18. Now it's time to do it.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 kernel/sched/ext.c               | 3 ---
 kernel/sched/ext_internal.h      | 8 +-------
 tools/sched_ext/scx_flatcg.bpf.c | 2 +-
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b9247c9f0430..fd83af17d46d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5062,9 +5062,6 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
-	if (ops->flags & SCX_OPS_HAS_CGROUP_WEIGHT)
-		pr_warn("SCX_OPS_HAS_CGROUP_WEIGHT is deprecated and a noop\n");
-
 	if (ops->cpu_acquire || ops->cpu_release)
 		pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index bd26811fea99..3c86c53e1975 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -174,19 +174,13 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
 
-	/*
-	 * CPU cgroup support flags
-	 */
-	SCX_OPS_HAS_CGROUP_WEIGHT	= 1LLU << 16,	/* DEPRECATED, will be removed on 6.18 */
-
 	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
 					  SCX_OPS_ENQ_LAST |
 					  SCX_OPS_ENQ_EXITING |
 					  SCX_OPS_ENQ_MIGRATION_DISABLED |
 					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
 					  SCX_OPS_SWITCH_PARTIAL |
-					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
-					  SCX_OPS_HAS_CGROUP_WEIGHT,
+					  SCX_OPS_BUILTIN_IDLE_PER_NODE,
 
 	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
 	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 0e785cff0f24..a8a9234bb41e 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -960,5 +960,5 @@ SCX_OPS_DEFINE(flatcg_ops,
 	       .cgroup_move		= (void *)fcg_cgroup_move,
 	       .init			= (void *)fcg_init,
 	       .exit			= (void *)fcg_exit,
-	       .flags			= SCX_OPS_HAS_CGROUP_WEIGHT | SCX_OPS_ENQ_EXITING,
+	       .flags			= SCX_OPS_ENQ_EXITING,
 	       .name			= "flatcg");
-- 
2.43.0

