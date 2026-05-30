Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2DA303A07;
	Sat, 30 May 2026 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780121931; cv=none; b=Ym/6xMvhPCqiSOpsKRnsnaIcszytZcYKWvObdi0mOltbSdxE33PIoTmOw1pQ0X5wxMaYpRUXzjjC/Y7tIawIrQlHo9+PwBF2bB5toOztFxf2Drx/mTL5CZbgodJmwxKpTe9Z9lvlXDCPNj8WN0lm/+sexbDSJyClGGSySgcR7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780121931; c=relaxed/simple;
	bh=/Vk4rr1Vwwr9RA0LvbkzxGntrQW9C8p9yq6BjrGt89c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJhc77y//aTvxAWgy3koht2ZUG+H/T8v+g1jaFKkk99+pfDyeIQCSsnv8z9JYDrclvTfxfP8l9nPbliVG2TZS5Vc+2pOEw+9vOXTO5MupFvgMM34skgkaS4FOe3atAqsvUHlikusDXWEXlnhyYa+fQXWsZC8p3ks8ea2nPe2XQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gS94h00mHzYQtrj;
	Sat, 30 May 2026 14:17:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 03C7A4058F;
	Sat, 30 May 2026 14:18:41 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with SMTP id gCh0CgDnr1s8gRpqNcqdEA--.3341S4;
	Sat, 30 May 2026 14:18:40 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	YiFei Zhu <zhuyifei@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH bpf v2 2/3] selftests/bpf: Fix cgroup bpf tests broken by bpf_set_retval validation
Date: Sat, 30 May 2026 05:55:56 +0000
Message-ID: <20260530055557.549474-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530055557.549474-1-xukuohai@huaweicloud.com>
References: <20260530055557.549474-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnr1s8gRpqNcqdEA--.3341S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxKFWDuF1DZry5uFWruFg_yoW8CFWfp3
	Z7AFyqy3s3CF17Ja18GrsF9a1fKwsYqryYyw18XF1UZ3W3J3srXr4xKF45try3trZ3Zwsx
	uayag3s3ZF48Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UCZXrU
	UUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add explicit return value checks for cgroup bpf progs rejected by the
bpf_set_retval validation.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/progs/cgroup_getset_retval_hooks.c        | 6 +++++-
 tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c      | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c
index 13dfb4bbfd28..c0bfa2d12dc7 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c
@@ -2,12 +2,16 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <errno.h>
+#include "err.h"
 
 #define BPF_RETVAL_HOOK(name, section, ctx, expected_err) \
 	__attribute__((__section__("?" section))) \
 	int name(struct ctx *_ctx) \
 	{ \
-		bpf_set_retval(bpf_get_retval()); \
+		int val = bpf_get_retval(); \
+		set_if_not_errno_or_zero(val, -EFAULT); \
+		bpf_set_retval(val); \
 		return 1; \
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c b/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
index 09a00d11ffcc..bae5283fca6b 100644
--- a/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
+++ b/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <errno.h>
+#include "err.h"
 
 extern int tcp_memory_per_cpu_fw_alloc __ksym;
 extern int udp_memory_per_cpu_fw_alloc __ksym;
@@ -97,6 +98,7 @@ int sock_create(struct bpf_sock *ctx)
 	return 1;
 
 err:
+	set_if_not_errno_or_zero(err, -EFAULT);
 	bpf_set_retval(err);
 	return 0;
 }
-- 
2.43.0

