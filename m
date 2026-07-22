Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDE231715D;
	Wed, 22 Jul 2026 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784698099; cv=none; b=tnJl1cUPto5EaqPxH0h1kCXxuVh4lTNDBvPa7Cp5ibCcr2Bd17G+8RSR8ZdvWSACDr1sNhdH8ol8LHWG6wEORwXL5SU19jU/EB+lPDRvJUMeTjXernIkRPixGormQRPVajDCg5pVNrI3qLwo1MUiy9qiesIODBez4fK9ia+vMWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784698099; c=relaxed/simple;
	bh=xGhxK7DdoYgEgPczWOg20FJ0P83ccyHQFsCVYJuxmgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hiW4YD14KOft0RW41K9SfZgfNoqu5q4S/gMO4NSn46rXS7wTwpufo1qs1OAXwlYB/kUxLklrGW5EbK3vu29uaGY3QJxihbZpXsktB6blF2fCPG4v+9/a6hbnQIl/oHH3ZBtEMbH6deObyuLSPTYVc+CY+qc/8Nplk40oYy8+G5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=WZgPddpX; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="WZgPddpX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=QSpZaUMg805BhWsPOR9AdS3pqyeG1IUi6N
	G3nKZSDO0=; b=WZgPddpXHgCYp9d6yTQTSO3PTHsKL52ioL12udwzeSmgd5byjp
	+YiVhxpNsiGwuVrtrKIj6wzwMJpTsRn/0tPN8SWcof7wiOwrgt9i58F6nBhgCBdd
	8S0IiccGxs8wBOzVFP0U99F0cXkUv8GHpfpeDM7j+VeqFaUg1nZ1DwRHU=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQCHWRjYVGBqhCwkAA--.51860S3;
	Wed, 22 Jul 2026 13:27:58 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/3] bpf: Preserve pointer state for commuted arithmetic
Date: Wed, 22 Jul 2026 05:27:31 +0000
Message-Id: <004a83de52a36e9f3acd6c3fa2d0dfd0a013460d.1784696372.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQCHWRjYVGBqhCwkAA--.51860S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw43Zw4rKw4rJFyfWF1DAwb_yoW5Zry8pw
	s7W3s3tr4kG3y7uw17ZF4qyr90kw4vqw1xCrykA34xCFW7JFyYqFWxKFyay3ySkrWvk34I
	kw4j9343ua4xXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUd0b7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEnc
	xIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E
	87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c
	0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a
	6rW5MxkIecxEwVAFwVW8WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0p_fHUOUUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

When scalar += pointer is handled in adjust_ptr_min_max_vals(), the
destination register inherits the pointer state from the source pointer.
Copying only selected fields is fragile because pointer provenance is
tracked by several bpf_reg_state fields.

Use verifier-env scratch storage to preserve the scalar operand while
replacing the destination with the full pointer state. This preserves the
frame number for PTR_TO_STACK registers and keeps parent identity fields
consistent.

Fixes: f1174f77b50c ("bpf/verifier: rework value tracking")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52be0a118cce0..085cbd5222737 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13726,11 +13726,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	s64 smin_val = reg_smin(off_reg), smax_val = reg_smax(off_reg);
 	u64 umin_val = reg_umin(off_reg), umax_val = reg_umax(off_reg);
 	struct bpf_sanitize_info info = {};
+	const struct bpf_reg_state *orig_off_reg = off_reg;
+	bool ptr_is_dst_reg;
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
 	int ret, bounds_ret;
 
 	dst_reg = &regs[dst];
+	ptr_is_dst_reg = ptr_reg == dst_reg;
 
 	if ((known && (smin_val != smax_val || umin_val != umax_val)) ||
 	    smin_val > smax_val || umin_val > umax_val) {
@@ -13796,11 +13799,15 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	/* In case of 'scalar += pointer', dst_reg inherits pointer type and id.
-	 * The id may be overwritten later if we create a new variable offset.
+	/* For 'scalar += pointer', dst_reg inherits the complete pointer
+	 * register state. Individual fields may be adjusted later by pointer
+	 * arithmetic.
 	 */
-	dst_reg->type = ptr_reg->type;
-	dst_reg->id = ptr_reg->id;
+	if (!ptr_is_dst_reg) {
+		env->fake_reg[0] = *off_reg;
+		off_reg = &env->fake_reg[0];
+		*dst_reg = *ptr_reg;
+	}
 
 	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
 	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))
@@ -13813,7 +13820,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		ret = sanitize_ptr_alu(env, insn, ptr_reg, off_reg, dst_reg,
 				       &info, false);
 		if (ret < 0)
-			return sanitize_err(env, insn, ret, off_reg, dst_reg);
+			return sanitize_err(env, insn, ret, orig_off_reg, dst_reg);
 	}
 
 	switch (opcode) {
@@ -13843,7 +13850,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		}
 		break;
 	case BPF_SUB:
-		if (dst_reg == off_reg) {
+		if (!ptr_is_dst_reg) {
 			/* scalar -= pointer.  Creates an unknown scalar */
 			verbose(env, "R%d tried to subtract pointer from scalar\n",
 				dst);
@@ -13906,7 +13913,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			return -EFAULT;
 		}
 		if (ret < 0)
-			return sanitize_err(env, insn, ret, off_reg, dst_reg);
+			return sanitize_err(env, insn, ret, orig_off_reg, dst_reg);
 	}
 
 	return 0;
-- 
2.34.1

