Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15AB221540;
	Fri,  6 Mar 2026 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782483; cv=none; b=SMkg7h0LjGSr2L8CaASF9gjfya374U8m+3cIoNuBMAU3KNAxxb32pXdHp1L8+7s1CjY+vzhtBHQEXcqAfIsbVjxlsA58LvRjKqBrGv4pF/NhAjpLZAJ2++fcPxzTkdXUgDgH6hVEdFd+eM4wwmi0RL5fL1sZ18mP9QFpDeMVLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782483; c=relaxed/simple;
	bh=2Rua+1dgKXiTu3vehu5xaStccMHEcC/UZL92wp5GaKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGue+PE7/c1pOblen6j6G1LaEVRL+AoR67Fr9hXMZZCryUfRdDJiAzvnMxHxYknUYGMjit1n9xabLswcHU6yOvb9ATQ0PNsjrh1riEfDHvoRFiMlRyW5vfbaxduAWNz2XquLQaSU8O2wB1ayHfHhRFUK2PrtDiHE1AP3QeSLu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=VWnTBq/k; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="VWnTBq/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/O
	aapI72pB5b3e/Gh8u+WItdoHV7XziQ1xQMIx/96oM=; b=VWnTBq/kja8GU2yfpo
	gcIVtSnOVeWCa/ksvItcvb0x8sKhlfygSGo7eS33/OVnkMnHx7Nx0+7JKlvaKGgy
	YXSFwUDWgdmW+J8dNr4XeufvSWNmk3EHZMC2lLwYdY2zgkigRF9lsbQqFBhY7qbX
	89DyBsxo593V3f8UFc3ErHECU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgCHt9PNgqppuc55BQ--.55212S4;
	Fri, 06 Mar 2026 15:31:27 +0800 (CST)
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
Subject: [PATCH 2/3] tools/sched_ext: Update scx enum autogens
Date: Fri,  6 Mar 2026 15:31:09 +0800
Message-ID: <20260306073110.229595-3-zhaomzhao@126.com>
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
X-CM-TRANSID:PykvCgCHt9PNgqppuc55BQ--.55212S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF1rKw1fWr45Jw4xKFykXwb_yoWxJw45pF
	srCFWUtF4UXFW7C3y8tF4rCw12kr1UJry8XryrXw40yFykAanaqry2qF4rGFyrXrWrWFyk
	XFWkG34S9r9Fqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0MKZUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlg-YUGmqgs-ohAAA3z

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Use scripts in scx repo to update these autogen files:

1. enum_defs.autogen.h: Remove SCX_OPS_HAS_CGROUP_WEIGHT, add other new
enums
2. enums.autogen.bpf.h and enums.autogen.h: Remove SCX_RQ_BAL_PENDING and
Use python scripts generation instead of manual edit style.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 .../sched_ext/include/scx/enum_defs.autogen.h | 26 ++++++++++++++-----
 .../sched_ext/include/scx/enums.autogen.bpf.h |  4 +--
 tools/sched_ext/include/scx/enums.autogen.h   |  3 +--
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/tools/sched_ext/include/scx/enum_defs.autogen.h b/tools/sched_ext/include/scx/enum_defs.autogen.h
index dcc945304760..0f4ee052c0ef 100644
--- a/tools/sched_ext/include/scx/enum_defs.autogen.h
+++ b/tools/sched_ext/include/scx/enum_defs.autogen.h
@@ -14,7 +14,11 @@
 #define HAVE_SCX_EXIT_MSG_LEN
 #define HAVE_SCX_EXIT_DUMP_DFL_LEN
 #define HAVE_SCX_CPUPERF_ONE
-#define HAVE_SCX_OPS_TASK_ITER_BATCH
+#define HAVE_SCX_TASK_ITER_BATCH
+#define HAVE_SCX_BYPASS_LB_DFL_INTV_US
+#define HAVE_SCX_BYPASS_LB_DONOR_PCT
+#define HAVE_SCX_BYPASS_LB_MIN_DELTA_DIV
+#define HAVE_SCX_BYPASS_LB_BATCH
 #define HAVE_SCX_CPU_PREEMPT_RT
 #define HAVE_SCX_CPU_PREEMPT_DL
 #define HAVE_SCX_CPU_PREEMPT_STOP
@@ -27,6 +31,7 @@
 #define HAVE_SCX_DSQ_INVALID
 #define HAVE_SCX_DSQ_GLOBAL
 #define HAVE_SCX_DSQ_LOCAL
+#define HAVE_SCX_DSQ_BYPASS
 #define HAVE_SCX_DSQ_LOCAL_ON
 #define HAVE_SCX_DSQ_LOCAL_CPU_MASK
 #define HAVE_SCX_DSQ_ITER_REV
@@ -36,6 +41,10 @@
 #define HAVE___SCX_DSQ_ITER_ALL_FLAGS
 #define HAVE_SCX_DSQ_LNODE_ITER_CURSOR
 #define HAVE___SCX_DSQ_LNODE_PRIV_SHIFT
+#define HAVE_SCX_ENABLING
+#define HAVE_SCX_ENABLED
+#define HAVE_SCX_DISABLING
+#define HAVE_SCX_DISABLED
 #define HAVE_SCX_ENQ_WAKEUP
 #define HAVE_SCX_ENQ_HEAD
 #define HAVE_SCX_ENQ_CPU_SELECTED
@@ -45,8 +54,10 @@
 #define HAVE___SCX_ENQ_INTERNAL_MASK
 #define HAVE_SCX_ENQ_CLEAR_OPSS
 #define HAVE_SCX_ENQ_DSQ_PRIQ
+#define HAVE_SCX_ENQ_NESTED
 #define HAVE_SCX_TASK_DSQ_ON_PRIQ
 #define HAVE_SCX_TASK_QUEUED
+#define HAVE_SCX_TASK_IN_CUSTODY
 #define HAVE_SCX_TASK_RESET_RUNNABLE_AT
 #define HAVE_SCX_TASK_DEQD_FOR_SLEEP
 #define HAVE_SCX_TASK_STATE_SHIFT
@@ -55,6 +66,7 @@
 #define HAVE_SCX_TASK_CURSOR
 #define HAVE_SCX_ECODE_RSN_HOTPLUG
 #define HAVE_SCX_ECODE_ACT_RESTART
+#define HAVE_SCX_EFLAG_INITIALIZED
 #define HAVE_SCX_EXIT_NONE
 #define HAVE_SCX_EXIT_DONE
 #define HAVE_SCX_EXIT_UNREG
@@ -81,33 +93,33 @@
 #define HAVE_SCX_OPI_CPU_HOTPLUG_BEGIN
 #define HAVE_SCX_OPI_CPU_HOTPLUG_END
 #define HAVE_SCX_OPI_END
-#define HAVE_SCX_OPS_ENABLING
-#define HAVE_SCX_OPS_ENABLED
-#define HAVE_SCX_OPS_DISABLING
-#define HAVE_SCX_OPS_DISABLED
 #define HAVE_SCX_OPS_KEEP_BUILTIN_IDLE
 #define HAVE_SCX_OPS_ENQ_LAST
 #define HAVE_SCX_OPS_ENQ_EXITING
 #define HAVE_SCX_OPS_SWITCH_PARTIAL
 #define HAVE_SCX_OPS_ENQ_MIGRATION_DISABLED
 #define HAVE_SCX_OPS_ALLOW_QUEUED_WAKEUP
-#define HAVE_SCX_OPS_HAS_CGROUP_WEIGHT
+#define HAVE_SCX_OPS_BUILTIN_IDLE_PER_NODE
 #define HAVE_SCX_OPS_ALL_FLAGS
+#define HAVE___SCX_OPS_INTERNAL_MASK
+#define HAVE_SCX_OPS_HAS_CPU_PREEMPT
 #define HAVE_SCX_OPSS_NONE
 #define HAVE_SCX_OPSS_QUEUEING
 #define HAVE_SCX_OPSS_QUEUED
 #define HAVE_SCX_OPSS_DISPATCHING
 #define HAVE_SCX_OPSS_QSEQ_SHIFT
 #define HAVE_SCX_PICK_IDLE_CORE
+#define HAVE_SCX_PICK_IDLE_IN_NODE
 #define HAVE_SCX_OPS_NAME_LEN
 #define HAVE_SCX_SLICE_DFL
+#define HAVE_SCX_SLICE_BYPASS
 #define HAVE_SCX_SLICE_INF
 #define HAVE_SCX_RQ_ONLINE
 #define HAVE_SCX_RQ_CAN_STOP_TICK
-#define HAVE_SCX_RQ_BAL_PENDING
 #define HAVE_SCX_RQ_BAL_KEEP
 #define HAVE_SCX_RQ_BYPASSING
 #define HAVE_SCX_RQ_CLK_VALID
+#define HAVE_SCX_RQ_BAL_CB_PENDING
 #define HAVE_SCX_RQ_IN_WAKEUP
 #define HAVE_SCX_RQ_IN_BALANCE
 #define HAVE_SCX_TASK_NONE
diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index 5da50f937684..2b9540f0b3d5 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -19,9 +19,6 @@ const volatile u64 __SCX_RQ_ONLINE __weak;
 const volatile u64 __SCX_RQ_CAN_STOP_TICK __weak;
 #define SCX_RQ_CAN_STOP_TICK __SCX_RQ_CAN_STOP_TICK
 
-const volatile u64 __SCX_RQ_BAL_PENDING __weak;
-#define SCX_RQ_BAL_PENDING __SCX_RQ_BAL_PENDING
-
 const volatile u64 __SCX_RQ_BAL_KEEP __weak;
 #define SCX_RQ_BAL_KEEP __SCX_RQ_BAL_KEEP
 
@@ -129,3 +126,4 @@ const volatile u64 __SCX_ENQ_DSQ_PRIQ __weak;
 
 const volatile u64 __SCX_DEQ_SCHED_CHANGE __weak;
 #define SCX_DEQ_SCHED_CHANGE __SCX_DEQ_SCHED_CHANGE
+
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index fc9a7a4d9dea..c615cb323f8b 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -10,7 +10,6 @@
 	SCX_ENUM_SET(skel, scx_public_consts, SCX_SLICE_INF); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_ONLINE); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_CAN_STOP_TICK); \
-	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_BAL_PENDING); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_BAL_KEEP); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_BYPASSING); \
 	SCX_ENUM_SET(skel, scx_rq_flags, SCX_RQ_CLK_VALID); \
@@ -46,5 +45,5 @@
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_LAST); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CLEAR_OPSS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_DSQ_PRIQ); \
-	SCX_ENUM_SET(skel, scx_deq_flags, SCX_DEQ_SCHED_CHANGE); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_DEQ_SCHED_CHANGE); \
 } while (0)
-- 
2.43.0

