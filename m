Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD30D37472D;
	Fri,  5 Jun 2026 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669549; cv=none; b=T3fEyKwrgl/QCwlghX60qMNsOb7onbt1vbBxY/qqSi3g2KZu4e0xBg+jUp4ySWK1YZZRh6X/R9iSaH0ISOloff0IOwHxF/9nlg5xv/HfcclI9mUwoJefPw93ZGJwzafj9WHXSnnf8Obk7zH1gN0ZQVKnOehvr77NKCLddJwGEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669549; c=relaxed/simple;
	bh=7ouYXT25vyVFspS+GXIj7bf/qIbvG+Mpt6N6ur7w1K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPXPt+M+5k0Y8UBymRN1WY4ODZF+BjsSD569GqquRyZHd0UrN1G0QoMq4FL5D3HsY4gREvgytDS2CNsH8Cw8Od3kb4X3PtcOr8nJHDt0G+0af4fpeXyNj6AqERDel8zpmQSqjxicPb5oGuZV3PULLuafFiiZY48hn/RJ3njV2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gX3ck3GyRzYQtkl;
	Fri,  5 Jun 2026 22:25:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 97E714056E;
	Fri,  5 Jun 2026 22:25:36 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP1 (Coremail) with SMTP id cCh0CgBntjtd3CJqFYjiAg--.54292S3;
	Fri, 05 Jun 2026 22:25:36 +0800 (CST)
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
Subject: [PATCH bpf-next v5 1/3] selftests/bpf: Restrict bpf_set_retval argument in sk_bypass_prot_mem
Date: Fri,  5 Jun 2026 14:02:41 +0000
Message-ID: <20260605140243.664590-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605140243.664590-1-xukuohai@huaweicloud.com>
References: <20260605140243.664590-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBntjtd3CJqFYjiAg--.54292S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3KF4kAw1rZrWUCF4Durg_yoW8JF4kp3
	Z7Aas09rZ5Cr17Ja1Sgr47t3WSgw4vvrWFkr1Fq3WUZ3W5K3s7Xr4xKF47Kw1YyrZIqw43
	ua4Sgas3Zr48A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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

