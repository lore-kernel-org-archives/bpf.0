Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F9E3A4513;
	Sat, 30 May 2026 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780137335; cv=none; b=mUGrb7lO51l8enHj1/cfFAvjGNbkAJh2XtjN0yZTBkt7zUAwfdGXVjVUog9vqzSKO7Urz1ne4vb4B3PeewPAoRJKg48U0paLm6hE+vCNhYyQ7yp+Z0gMlEX1rWm0OgmRoQqcHv7ihHQK0mjRPrPE82ZesIN+RdoaJIVTADQmxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780137335; c=relaxed/simple;
	bh=/Vk4rr1Vwwr9RA0LvbkzxGntrQW9C8p9yq6BjrGt89c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8Yad4fIWmQ+FIlQiBMrmzoz7o9jKpNEJmPIsCJHprEvr5emgnJl7SSVUQ5trRHS0Xq46qtEOHb5t6y2uOBpzgkFr3wbk2PrHSnUiEfnTlt/pmBx9aAd9Yn4vHh85zsksLY5661PDK9jNPfM2xYY37C8751M9aU852H41glp7wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gSGmw0T6ZzYQtvg;
	Sat, 30 May 2026 18:34:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5CF794058D;
	Sat, 30 May 2026 18:35:25 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with SMTP id gCh0CgCXrFhpvRpqo6izEA--.19629S4;
	Sat, 30 May 2026 18:35:25 +0800 (CST)
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
Subject: [PATCH bpf v3 2/3] selftests/bpf: Fix cgroup bpf tests broken by bpf_set_retval validation
Date: Sat, 30 May 2026 10:12:38 +0000
Message-ID: <20260530101239.590395-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530101239.590395-1-xukuohai@huaweicloud.com>
References: <20260530101239.590395-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXrFhpvRpqo6izEA--.19629S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyxKFWDuF1DZry5uFWruFg_yoW8CFWfp3
	Z7AFyqy3s3CF17Ja18GrsF9a1fKwsYqryYyw18XF1UZ3W3J3srXr4xKF45try3trZ3Zwsx
	uayag3s3ZF48Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1VT
	5JUUUUU==
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

