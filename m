Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E376836195B;
	Mon, 28 Sep 2026 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790562098; cv=none; b=b8ND6qEwxtuogdKJXpmlBMx5NYtTWFSjSbUCuP5pgB0NlWK2xWth3XSScpHQrrWq8X9NZzIJEGP6FhBuYMDropYdGJVhfIR+Ni2rbzjvXPX2hdWRXRcij+Np4oyRY5YK4Ji2sb7PE5gbGLHEgfQ7LktFMmt7EVo/ppy5YQBiv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790562098; c=relaxed/simple;
	bh=Rs2FBqQifyANYmW9JggxqukmdYoNPAHP6hClmxD3OOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnM4l6Sr1Q+8FAWPTeAsioNXdhumxvT6taKBr3A8Bknf8SzUFSqvLGMpFjaH4M9imMgEXC4lr6yTV0gu5G1sP0IkyHxIdbbneLu3BgpSNi0K9Jq55SqS9PJ4vsne5a+9Vum+cLK0Nfn7/QcI6Dc+FqAk14T7a/ih7Pq0SfqkavA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dl0ARl3R; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dl0ARl3R"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790562093; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=X3FxpV9hdjJFYmi4djMcIYOFyHUGcAiMBxxXsjrwS8c=;
	b=dl0ARl3RPhRMDbyH/NenK/5HNhGhdz526IY+7ki8cXt8gGaCgyA3FcolOoeXNu++DXMu54JVncptSIj6bus6rfswLWzJY8JTTJI1d95NCi7jA5afj1JL86yXWZrkSXJbDDB9AGtHLFgXMnuNoWgXqwR+lF4we2Pp15/7vsmxKqY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBgzgOz_1790562092;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBgzgOz_1790562092 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 10:21:32 +0800
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Enable gotox tests for riscv64
Date: Mon, 28 Sep 2026 10:21:09 +0800
Message-ID: <20260928022109.1093-3-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928022109.1093-1-cp0613@linux.alibaba.com>
References: <20260928022109.1093-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The riscv64 JIT now supports the gotox instruction and jump tables, so
run the tests in verifier_gotox.c on riscv64 too, mirroring what was done
for arm64 and powerpc.

The guard is 64-bit only because the RV32 JIT does not implement gotox.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Björn Töpel <bjorn@kernel.org>
---

Changes since v1:
- Collapse the multi-line #endif marker to a single line.

 tools/testing/selftests/bpf/progs/verifier_gotox.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index f5a9878c7b8d..96a9d914930e 100644
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
@@ -580,6 +582,6 @@ nop_%=:								\
 	: __clobber_all);
 }
 
-#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 || __TARGET_ARCH_powerpc*/
+#endif /* gotox: x86, arm64, powerpc, riscv64 */
 
 char _license[] SEC("license") = "GPL";
-- 
2.50.1

