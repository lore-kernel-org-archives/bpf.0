Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF0A4C9DEB;
	Tue, 29 Sep 2026 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671857; cv=none; b=miXOnojqCb0vFuvS3XcUBe748BPUYyT+UkPS7n/nXm/s3+98kak9OabTgjkhImXsEoJ9uRyAPFKx+sMILMZKABr8BMYh0IBvYnzpDwyroqqkEMOGI+SXfH9z2ohMcuxXwaG4GrHF0qx6Fwr+vf/sddruZGlECbEuD2wUwF1hDHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671857; c=relaxed/simple;
	bh=x/2Yufj7BDckVgHIunGwns+v+3M+0W/YGsrpR6O36Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eX3QfnemCfhpBu5YHUjEBTIw6Aws5cn3gZsYq7qYj/kkI8peSxP9/uSvBgo9higFKB1sbseyzB2OtfihRStYrVlfAKdXOV/s9XAJdWysu2hd27DzAGeGB+qQfYgeAWmz0Sr/xnV+VwdTu/a7eVsVpqNA7DA4QAY4gIt5ihiuMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hvBhS0YmvzYQv2B;
	Tue, 29 Sep 2026 16:50:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0437B40974;
	Tue, 29 Sep 2026 16:50:43 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDn_iHie7tqgXJpCA--.48809S3;
	Tue, 29 Sep 2026 16:50:42 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 1/2] riscv, bpf: Support indirect calls to bpf subprogs (callx)
Date: Tue, 29 Sep 2026 08:54:49 +0000
Message-Id: <20260929085450.1852617-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929085450.1852617-1-pulehui@huaweicloud.com>
References: <20260929085450.1852617-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDn_iHie7tqgXJpCA--.48809S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZrW7KrW5urWDWr4kury3Jwb_yoWkCFc_uw
	1xtayxX398JFsrXa1jyF45KFykCw4rKF1DZFnYgry2k3Z5Xa1xArWkKryDZry7XryrKF45
	u3s3AaySyw42yjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
	ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUU9N3UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Implement callx by emitting a jalr instruction to jump to the target
subprog address held in rd, and marking the call as it clobbers
RV_REG_RA.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 7ce9f8460c59..88430825f4f5 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -2071,6 +2071,13 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
 		break;
 	}
+
+	/* indirect call to a bpf subprog via the address in rd */
+	case BPF_JMP | BPF_CALL | BPF_X:
+		mark_call(ctx);
+		emit_jalr(RV_REG_RA, rd, 0, ctx);
+		break;
+
 	/* tail call */
 	case BPF_JMP | BPF_TAIL_CALL:
 		if (emit_bpf_tail_call(i, ctx))
@@ -2397,3 +2404,8 @@ bool bpf_jit_supports_exceptions(void)
 	 */
 	return IS_ENABLED(CONFIG_FRAME_POINTER);
 }
+
+bool bpf_jit_supports_callx(void)
+{
+	return true;
+}
-- 
2.34.1

