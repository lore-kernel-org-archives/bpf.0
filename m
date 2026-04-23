Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D0363C72;
	Thu, 23 Apr 2026 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941019; cv=none; b=CoCClDxolnyzqW4dAaTZ1Ps0FR7N10UyOAMEdoGVoN2WOR/iNt4U8ItPHTI06hvst6x5gy5/nJzw5WnuyKRPKt2f35z1lEtFe4ERRYMwHoNI8lzqxftBnEz1xTYGhHhsWzh3P0VuoHHti0LYx7+3Nn6MGVG/0M9OQ5z8NdXgBqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941019; c=relaxed/simple;
	bh=jzVUNqteRf9qf1dW5be0tnfzsaUw53zh2mT3/paRV44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sUbeHdLRYqFKD1r8KD1tL+xzJtCrWdnK5Am5qqZD+ZNkKzMUg6d/Fisb0Y5ml7gn4Li3dxv2WQlzQ2BS2ulJSwvMgo4yUsL6BR6xqF3Z156TYq1tlKwbBeWx0WK1cZTx8xSMQZpbiXws3XCXkM25bh5nyaoIHdZyDghpirDeGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=dttp9ri2; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="dttp9ri2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=slO8TiWz2gHyNVQLPFdBYdiZuRPXdoAhGpTI9Ybjgow=;
	b=dttp9ri2vFR0Yfw1sJdPBciqP/EyUnV7iklVMznFH6jwqfrrYmHUr5123ofOck
	iZsFRjbb4VB14PePXvo6gJJnXuTMuaMyKtmQXXrVk2ZVXkx/H8VQqZ7hwblDW0sn
	GtMYfykpMIAWkDedceC2qFT0+k1D363asEU6sj2gvKTTw=
Received: from [127.0.1.1] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3P9Oj9+lp5NpsDw--.53840S2;
	Thu, 23 Apr 2026 18:42:44 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
Date: Thu, 23 Apr 2026 18:42:35 +0800
Subject: [PATCH] selftests/sched_ext: Include common.bpf.h to avoid build
 failure
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-b4-selftest-fix-v1-1-8c72287bde3d@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAJr36WkC/yXMUQqDMBCE4avIPrug0ap4FfFBk7FdKVayUQTx7
 qbt4zcw/0kKL1Bqk5M8dlH5LBF5mpB9DcsTLC6aTGaqrDQFjyUr3lOABp7kYNfU1rmhypsHKL5
 Wjzj/il3/t27jDBu+GbquGyZPMchzAAAA
X-Change-ID: 20260423-b4-selftest-fix-d87cdda6185e
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Zhao Mengmeng <zhaomengmeng@kylinos.cn>, 
 Cheng-Yang Chou <yphbchou0911@gmail.com>
X-Mailer: b4 0.15.2
X-CM-TRANSID:PykvCgD3P9Oj9+lp5NpsDw--.53840S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1UXFyfJr4fAr4kKw48JFb_yoW8KF13pa
	4kZr4vkr1IgryUJw18AF40q3ySqws3Jw409w4UGwnxAFn2qFWxXr42vF4fWwnIk39Y9r4a
	y34IgayxWr10v3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULVysUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlwT7c2np96RdHQAA3I

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

In scx-cid patchsets, sched_ext selftest failed to build with following
error:

non_scx_kfunc_deny.bpf.c:17:6: error: conflicting types for 'scx_bpf_kick_cpu'
17 | void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
|      ^
tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: previous declaration is here
136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;
|             ^
non_scx_kfunc_deny.bpf.c:26:23: error: too few arguments to function call, expected 3, have 2
26 |         scx_bpf_kick_cpu(0, 0);
|         ~~~~~~~~~~~~~~~~     ^
tools/testing/selftests/sched_ext/build/include/vmlinux.h:136300:13: note: 'scx_bpf_kick_cpu' declared here
136300 | extern void scx_bpf_kick_cpu(s32 cpu, u64 flags, const struct bpf_prog_aux *aux) __weak __ksym;

The root cause is on scx core part, but we can avoid this by including
common.bpf.h and remove scx_bpf_kick_cpu() to make it more robust, just
like the usage in other xx.bpf.c.

Link: https://lore.kernel.org/sched-ext/20260421071945.3110084-1-tj@kernel.org/
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Tested-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
index 9f16d39255e7..0d6fcc8e5eb6 100644
--- a/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
+++ b/tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
@@ -9,12 +9,7 @@
  * Copyright (C) 2026 Cheng-Yang Chou <yphbchou0911@gmail.com>
  */
 
-#include <vmlinux.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-/* SCX kfunc from scx_kfunc_ids_any set */
-void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
+#include <scx/common.bpf.h>
 
 SEC("struct_ops/ssthresh")
 __u32 BPF_PROG(tcp_ca_ssthresh, struct sock *sk)

---
base-commit: eff158514a85c1b81966667a880dd8bcd29bbbd1
change-id: 20260423-b4-selftest-fix-d87cdda6185e

Best regards,
--  
Zhao Mengmeng <zhaomengmeng@kylinos.cn>

