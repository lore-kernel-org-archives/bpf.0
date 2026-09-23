Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7F52CCDF;
	Wed, 23 Sep 2026 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168979; cv=none; b=jHvrZ6Vg2NsmEAcv8OM2FC/U4RKe5PEu9AjrgIfmkxrl9AKsCsFZZII/crboM1afNVRYQWJV5smGAPYvTh5BrEi0DGyIGYhy23/Q3gFif95zzuPP+ypj+4Soz0U1QaBWRDxqUL0N8TotROtov4/+nXHWaHqYgHeQgOoblH/rNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168979; c=relaxed/simple;
	bh=57PuwQ6vh0dHqm64Qch1yvln/aQ34OaRWLzMWMvIp78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFmGErRxC3ZjIMPtXK10d1h/cZ5r8XyZvCTSYkuS7MxgNoLXvvGQoXUqwzJKnAOvlukk8VldGLcc7GBzUZVLEGdN8uifkBICjgntklKFOts8avNQIl2boErkaqE9V4iRyFrn1l/cP6vmfhzMubVrjsNzo+3Ydb2zKONgSLc93ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iuOYGxb0; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iuOYGxb0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790168969; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qDsY6laUwuanA+jJYyeUYogdaMe7dOVPNrzeOBRqPVI=;
	b=iuOYGxb0N9BlMMbWwRyqJlw+hbDw+czUPZk2A3P9GkLAjDQSo5lWOwrS76gEEZCA3XOpXzGwRVwi54b9WZpMvN6vlfYp5FS5qqwC/AX4Tfv3vXHqpmxRSgUNzKsIZBfHDxcB2wV2cxNEYnKcuPhFqk1si+WE5ByBIf/LnnOxGRU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBX4ZPj_1790168968;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBX4ZPj_1790168968 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 21:09:28 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	shuah@kernel.org,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Enable gotox tests for riscv64
Date: Wed, 23 Sep 2026 21:08:56 +0800
Message-ID: <20260923130856.1157-3-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923130856.1157-1-cp0613@linux.alibaba.com>
References: <20260923130856.1157-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The riscv64 JIT now supports the gotox instruction and jump tables, so
run the tests in verifier_gotox.c on riscv64 too, mirroring what was done
for arm64 and powerpc.

The guard is 64-bit only because the RV32 JIT does not implement gotox.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tools/testing/selftests/bpf/progs/verifier_gotox.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 5b18c9a27717..4a38f7da720a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -6,7 +6,9 @@
 #include "bpf_misc.h"
 #include "../../../include/linux/filter.h"
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_powerpc)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
+	defined(__TARGET_ARCH_powerpc) || \
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)
 
 #define DEFINE_SIMPLE_JUMP_TABLE_PROG(NAME, SRC_REG, OFF, IMM, OUTCOME)	\
 									\
@@ -409,6 +411,8 @@ __naked void spill_fill_ptr_to_insn(void)
 	: __clobber_all);
 }
 
-#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 || __TARGET_ARCH_powerpc*/
+#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 ||
+	* __TARGET_ARCH_powerpc || __TARGET_ARCH_riscv
+	*/
 
 char _license[] SEC("license") = "GPL";
-- 
2.50.1

