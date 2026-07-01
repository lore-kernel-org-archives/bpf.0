Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB8D282F31;
	Wed,  1 Jul 2026 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877883; cv=none; b=dlZtlagQlefawtr7VZWp90Oj0KgwfiCsDv4uOlPjvL/MsVdwVIYHpTCy97AM3Xj7P2fDPjSzziCyev9vd7UZCEkQP+NOokNviqyEjICXAYdetpJiJzZIXzaxt0vTlc3yN9tHz9sVg6qhtEd2lSLdNPfL5WWuFFD048gY7wHZaeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877883; c=relaxed/simple;
	bh=YK5Ct9E5Fow4eBaP+aFSGb3Asb/U7m6K8tvGkvEmNws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V19FZ3ZuqTAFhz/qBlwYPoQoevedBGT7SrzcQOd5eldtE27ZepbkcE5fP0G1FCRgxcQ43dYi1fgkdylHjXpJrbcu0d/MT9jS2JIqoObiIavaKt1/r8rig+yb45V+Qf8fYoyZIChtxegtsPvr1CecEEK/zBAd6ayH9+ggFPDloh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxFfCujkRqmFUAAA--.1476S3;
	Wed, 01 Jul 2026 11:51:10 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxD8OsjkRq4e+5AA--.24861S2;
	Wed, 01 Jul 2026 11:51:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	KaFai Wan <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1] bpf: Use BPF_CALL_IMM macro consistently in bpf_do_misc_fixups
Date: Wed,  1 Jul 2026 11:51:07 +0800
Message-ID: <20260701035107.8069-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxD8OsjkRq4e+5AA--.24861S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrW7WF1rXr4UGFy8ZFWxXwc_yoW8Gr1UpF
	ZYkF1xGr4qqF1IvF47JFs7Gay3J3yrZrsxCFZFqry2ya13tr1kGF95K3WrXFyayr1IkFn0
	kF1IyrWYvw18WwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxUGYDUUUU

In bpf_do_misc_fixups(), the conversion from a function address to a
BPF immediate value is handled using the BPF_CALL_IMM macro inside the
'patch_map_ops_generic' label block. However, immediately following it
in the 'patch_call_imm' label block, the immediate value is calculated
manually by subtracting __bpf_call_base from fn->func.

Inspired by KaFai Wan's review comments on fixing helper call offsets,
use the BPF_CALL_IMM macro in 'patch_call_imm' as well to clean this up.
This removes the redundant manual pointer arithmetic and ensures coding
style consistency across adjacent label blocks within the same function.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 kernel/bpf/fixups.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 3cf2cc6e3ab6..12a8a4eb757f 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2338,7 +2338,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				     func_id_name(insn->imm), insn->imm);
 			return -EFAULT;
 		}
-		insn->imm = fn->func - __bpf_call_base;
+		insn->imm = BPF_CALL_IMM(fn->func);
 next_insn:
 		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
 			subprogs[cur_subprog].stack_depth += stack_depth_extra;
-- 
2.42.0

