Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B938384CE4;
	Sat, 23 May 2026 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779528059; cv=none; b=B30sSRMpIv4EbKVcOu21gROkC/rI/iYWbp3EJrNGG+y9A9u8+jIKNDjCWkjRZtPSBccDBEg7sWzoKo/4+zkuJdZ/UxaCSxkhc3fxfLQlDmDioxQ3UofWRNNJOdM4RpUhdr43sd4qNCDKo3M7CCuX4HPmZgji6S33BM0jjYo5JBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779528059; c=relaxed/simple;
	bh=Yyt4sH6PyC6Du1Lmag8gwIkJlBKpPqXpSSef/YEltoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOE+1BPHZ2oRsmRmQuXXwAMeBN+9Nfxf+J4xfbAJrtgZ7dBPrYKBOZHHf4pphg18IKt++yb5wl74vNYcraSa0cZQT3I470a7RdWOjT4seCx0oCtKoPH/+WB7DlArxj1kx2K4FRh9d+FTePjmZ24H1aEWl8Ni7kcg0G+ODQPAeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gMxSG28TJzYQtrJ;
	Sat, 23 May 2026 17:19:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8DACE4056D;
	Sat, 23 May 2026 17:20:47 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with SMTP id gCh0CgC3flpscRFqWE9VDQ--.41561S3;
	Sat, 23 May 2026 17:20:47 +0800 (CST)
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
	Matt Bobrowski <mattbobrowski@google.com>,
	Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH bpf 1/2] bpf: Add return value check for BPF_LSM_CGROUP
Date: Sat, 23 May 2026 08:58:05 +0000
Message-ID: <20260523085806.417723-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523085806.417723-1-xukuohai@huaweicloud.com>
References: <20260523085806.417723-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3flpscRFqWE9VDQ--.41561S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3Wr17Jw1fGr1DCr4Uurg_yoW8CFyrpF
	n7Gryqyr4qyFZrWa1xtan3AFyYyF4jg3y3GF97J34Yva1fXrs8Xa4jgr4akr9IyFy8Jw1I
	yr1jvFZI9ayUZa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jehFxU
	UUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

BPF_LSM_CGROUP programs use bpf_set_retval() helper to set the return
value, but the value is not validated. This could cause kernel panic
similar to the bug fixed by commit 5d99e198be27 ("bpf, lsm: Add check
for BPF LSM return value").

Fix it by verifying the argument for bpf_set_retval() falls within the
valid return value range for the target hook.

Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Closes: https://lore.kernel.org/all/567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..fe60a695de55 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10462,6 +10462,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	case BPF_FUNC_set_retval:
 		if (prog_type == BPF_PROG_TYPE_LSM &&
 		    env->prog->expected_attach_type == BPF_LSM_CGROUP) {
+			struct bpf_retval_range range;
+			struct bpf_reg_state *r1 = &regs[BPF_REG_1];
+
 			if (!env->prog->aux->attach_func_proto->type) {
 				/* Make sure programs that attach to void
 				 * hooks don't try to modify return value.
@@ -10469,6 +10472,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
 				return -EINVAL;
 			}
+
+			bpf_lsm_get_retval_range(env->prog, &range);
+			range.return_32bit = true;
+			if (!retval_range_within(range, r1)) {
+				verbose_invalid_scalar(env, r1, range, "At bpf_set_retval", "R1");
+				return -EINVAL;
+			}
 		}
 		break;
 	case BPF_FUNC_dynptr_data:
-- 
2.43.0

