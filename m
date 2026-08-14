Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3CB3769E0;
	Fri, 14 Aug 2026 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689766; cv=none; b=sazbWemsjbmz98iFsl7a6/S7vrV1PHthwErnHKy4lG+Pu0YzOYxn6+HufcbgMJlgbSqJegyQaZ8oTmubalDZ4Gf8BnEND9pak0vZE+6AHqvIE+kM1u7jiu9074Nt9M5BYULr/VukUpoJOBGNtmmsuK1NXQuSIF1MMQcncJVMEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689766; c=relaxed/simple;
	bh=OaEJKFqGikVM89zewHcJ8VzvCRGKmVPi7EEfIKContI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HKahJ97VKCyy202GSOrMBvR+60DR+EAK3wERrGulaLi2zT3ZpU2Zza3krQH8TeCg9oYZHZHYUgfGzX7Jmg20CIXpHBgw0vA3RiO9zseugMOooIWsDquS/wToRYllkYjcwb9e1D8WzCqWCOSx8pkG+2yChZCYkANda9GOPOQ9Hq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hLt203v6MzKHMtn;
	Fri, 14 Aug 2026 14:42:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 16B1540BA7;
	Fri, 14 Aug 2026 14:42:37 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgCH8YjbuH5qmzgVCQ--.6441S2;
	Fri, 14 Aug 2026 14:42:36 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next] riscv, bpf: Fix missing sign-ext for signed 1-byte and 2-byte kfunc args
Date: Fri, 14 Aug 2026 06:47:26 +0000
Message-Id: <20260814064726.3607615-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCH8YjbuH5qmzgVCQ--.6441S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF48Wry5ury3JFWUXFWfGrg_yoW8WF15pF
	15C34akF9Yqw1IvFy8AF48Wr15Gr4vva17uFWj9a45JFW2qFWrWr4rKw4Yvay5urZ5u3WF
	kryqgwn7u3yku3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

On RV64, the ABI requires sign-extension for signed 1-byte and 2-byte
kfunc args. However, the RV64 JIT currently does not perform
sign-extension for such kfunc args.

Before commit 7ce090afbf72 ("bpf: Infer zext_dst based on static
register liveness analysis"), state pruning could potentially omit
zero-extension of 32-bit subregisters, which inadvertently masked the
above issue by making the args appear as if they had been properly
sign-extended. After that commit, the problem is exposed, causing the
kfunc_call/kfunc_call_test4 selftest to fail.

Fix this by extending the existing sign-extension logic to handle signed
1-byte and 2-byte kfunc args as well.

Fixes: 443574b03387 ("riscv, bpf: Fix kfunc parameters incompatibility between bpf and riscv abi")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 2504df1fa111..74efe4b138d2 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1823,9 +1823,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 			for (idx = 0; idx < fm->nr_args; idx++) {
 				u8 reg = bpf_to_rv_reg(BPF_REG_1 + idx, ctx);
+				bool sign = fm->arg_flags[idx] & BTF_FMODEL_SIGNED_ARG;
 
-				if (fm->arg_size[idx] == sizeof(int))
-					emit_sextw(reg, reg, ctx);
+				if (sign_extend(reg, reg, fm->arg_size[idx], sign, ctx))
+					return -EINVAL;
 			}
 		}
 
-- 
2.34.1

