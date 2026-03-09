Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92E258EFF;
	Mon,  9 Mar 2026 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023409; cv=none; b=IvBCjZVEFU1MiV3W6DIXhRY6U6T1+0Tz43nvBMMRF8da+GMVz5ow5oCdFi7LksL61iPsw7UdKd5wqOPJQ4QScZ4oWMsE7j9mHftBud6gzp6hYFpoSWB+0XS+cVQK0xeQJblKL8+X/D63Jps8B0+MdgmRX1M6X+fHvduj5yY4cTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023409; c=relaxed/simple;
	bh=PytrpEKu4z4cSniLZJgATP9QtiYJe2vxD7ljF7M4rvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nr5arGbN9/By6Bw16fbIoNTnhKtwPY+UsgyCnoWtpBa+80cssjbEKbO5siEFN4nQKmVoRsugSRlW8ey8G/YS75w1DnrvupYKrup9i2Pz66ztQJlNsiM9oOQS9K5yNOaSM6NM7CLrQ8gCFVJKpCc9xPJECdrH5Mwx73vChPE9TOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Udj3BQVI; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Udj3BQVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=XB
	EAi+d0EcrM28oc+704+b++RsibF9o45FVGfBaavnk=; b=Udj3BQVIRFTcv4ceir
	AEAtx+1hMGiwSFy1hQeZH2ytKuw7gAghKSYpvPVz6+6UTbPw2+1mUOFMikmz/rC4
	CrM/4U1Lpcb4jNtCaKi/BR2NHHGAGuLpj189PbFZZOw1ifcwTIWANcCznshByprq
	/lDZG8LaSBh87tipEpZSj4SP0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCkvCgDHb_5qMK5pKd7+BA--.65315S3;
	Mon, 09 Mar 2026 10:28:59 +0800 (CST)
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
Subject: [PATCH v2 1/2] sched_ext: remove SCX_OPS_HAS_CGROUP_WEIGHT
Date: Mon,  9 Mar 2026 10:28:46 +0800
Message-ID: <20260309022847.106150-2-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309022847.106150-1-zhaomzhao@126.com>
References: <20260309022847.106150-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCkvCgDHb_5qMK5pKd7+BA--.65315S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4xZryxCF4rJr4kGF43Awb_yoW5CF1fpa
	1DZr48tr12qry7Ga18Ca1kury7Ww43Gw12gr98Xw4S9r4kGw4aqw1Yqr43ArWYqFWrZFZ3
	GFWq9a47Kw1jgF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UDrcfUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqwwtpGmuMGw5owAA3v

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

While running scx_flatcg, dmesg prints "SCX_OPS_HAS_CGROUP_WEIGHT is
deprecated and a noop", in code, SCX_OPS_HAS_CGROUP_WEIGHT has been
marked as DEPRECATED, and will be removed on 6.18. Now it's time to do it.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 kernel/sched/ext.c                              | 3 ---
 kernel/sched/ext_internal.h                     | 8 +-------
 tools/sched_ext/include/scx/enum_defs.autogen.h | 1 -
 tools/sched_ext/scx_flatcg.bpf.c                | 2 +-
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d6d807337013..69bb2e5b1adb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6282,9 +6282,6 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 		return -EINVAL;
 	}
 
-	if (ops->flags & SCX_OPS_HAS_CGROUP_WEIGHT)
-		pr_warn("SCX_OPS_HAS_CGROUP_WEIGHT is deprecated and a noop\n");
-
 	if (ops->cpu_acquire || ops->cpu_release)
 		pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index f8df73044515..bec4d22890b0 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -180,19 +180,13 @@ enum scx_ops_flags {
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
diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index 78d34f0c29f0..40b30dad8ede 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -114,7 +114,6 @@
 #define HAVE_SCX_OPS_ENQ_MIGRATION_DISABLED
 #define HAVE_SCX_OPS_ALLOW_QUEUED_WAKEUP
 #define HAVE_SCX_OPS_BUILTIN_IDLE_PER_NODE
-#define HAVE_SCX_OPS_HAS_CGROUP_WEIGHT
 #define HAVE_SCX_OPS_ALL_FLAGS
 #define HAVE___SCX_OPS_INTERNAL_MASK
 #define HAVE_SCX_OPS_HAS_CPU_PREEMPT
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

