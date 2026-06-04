Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AC0477E24;
	Thu,  4 Jun 2026 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579690; cv=none; b=Rp03f54tGbQiYeqNL5SwO/czOk5eOFkr6AN2LTR5Pibyrs9mIVvJb1/OLk1GLr8LEaZ9GRz0TQ+TrRyf2sTwlgVorhueaVj7hUitNmiAwA8Y5pJ9NGAuHGSnz6DKrxRjIP18fmzQpQN+LV0GvzuvlnbvANJCUHZsOr9AN5vVtNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579690; c=relaxed/simple;
	bh=7ouYXT25vyVFspS+GXIj7bf/qIbvG+Mpt6N6ur7w1K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8lEMHrFL2nbpA4HhOEC1Eg3UvbGD8mvEUoBGGTJXytSbSQA9/YOLu9FDnzNbbOZ6V6E4sZ9gtIJQoTpE2QEEQQzWJe3/VcuyrGaS/0mDFXh5/Yxx92tgU+rjavspfZ/cnYkf5gV07U9/cnBnb9fu2SQVgP6hyb4Gdd3BIpbaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gWQNK16HDzKHMWZ;
	Thu,  4 Jun 2026 21:27:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A9CE140573;
	Thu,  4 Jun 2026 21:27:56 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP2 (Coremail) with SMTP id Syh0CgCH_oNZfSFqyEtmAg--.28555S3;
	Thu, 04 Jun 2026 21:27:56 +0800 (CST)
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
Subject: [PATCH bpf v4 1/3] selftests/bpf: Restrict bpf_set_retval argument in sk_bypass_prot_mem
Date: Thu,  4 Jun 2026 13:04:56 +0000
Message-ID: <20260604130458.617765-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604130458.617765-1-xukuohai@huaweicloud.com>
References: <20260604130458.617765-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCH_oNZfSFqyEtmAg--.28555S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3KF4kAw1rZrWUCF4Durg_yoW8JF4kp3
	Z7Aas09rZ5Cr17Ja1Sgr47t3WSgw4vvrWFkr1Fq3WUZ3W5K3s7Xr4xKF47Kw1YyrZIqw43
	ua4Sgas3Zr48A3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Test sk_bypass_prot_mem passes an unchecked value as argument to helper
bpf_set_retval(). The argument can be outside the valid range enforced
by the strict retval validation added in the next patch.

Restrict the argument to -EFAULT when it is outside the valid range, so
the test will not be rejected by the verifier when retval validation
is enforced.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c | 2 ++
 1 file changed, 2 insertions(+)

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
2.47.3

