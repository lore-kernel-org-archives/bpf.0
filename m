Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0DF3B0AC8
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015239; cv=none; b=OGWeJD42reYytUBTyYkTK8dVs9nkJKqZL7x4PnEIrJ51ZtHLMMSDFY4Jh+795M5g9iA1TQof2bCf8/DK81qyd2WOyqYBlGQgjxVEC+pDmtLvBAlqmi1QAhf+TvQHV4+Pvb90dTKhNNoWx5xD3KJvzclKHHaHfZ6IFNzYnyfnGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015239; c=relaxed/simple;
	bh=FNvjnL1YHoAyA3oRFNjm7qQgITzFUYmVe8ZiqdfFbUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYL7SOd7HfurdW90Pcc2uGq1WlwPcYxF9SRk7pin++I6nhbExgGzXr5MEwghYBMki2omA5RFYozw/Qtc5nOPRGxiX9ygLyKatHwYOPqBQNqHZBXI/9hnXZev3iDnZbJo0RagGFOiXtItj++FbABCqMJGH2LkTeFRSyebqreiKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=RM51A+Vd; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="RM51A+Vd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=MApRlrECnnvl1vmWxiJCU+sUmwd59kbMkc
	lYytk8eJY=; b=RM51A+Vd9Sbr9OK6LWdqI+ZwDxyVANLE4E87OYh1zYOBnJjF46
	UzAktZwskF2O6rgza/kV1pJe5cO6eu3ULxyNiuq2f8wQgajYQKYR5pMYryUM2OUp
	ekCekTH3Cu3Om5MGh4i2fkbAJVFeBX3z713NH/WH3jsxkYFbHxgxTiCxI=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDXxRy2NKJquTL_AA--.5850S2;
	Thu, 10 Sep 2026 12:40:22 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf v2 1/2] bpf: Invalidate iterator-owned BTF pointers on destroy
Date: Thu, 10 Sep 2026 12:40:20 +0800
Message-ID: <20260910044021.2279628-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910044021.2279628-1-xyx2021@mail.ustc.edu.cn>
References: <20260910044021.2279628-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgDXxRy2NKJquTL_AA--.5850S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1xuw1xAw4DCry7tFW7XFb_yoW5GF1Upr
	4rWr90yr4kZrW7ZFnrtan8uFyrZry5Xay3CrykWa4SyFnxur12kFy0gr1Yvr9akFW8C340
	vrW0v3s09a1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMc
	Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU0I385UUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Open-coded iterator next kfuncs that return non-struct pointers associate
the returned PTR_TO_MEM with the iterator's reference ID.  Struct pointer
returns take a separate PTR_TO_BTF_ID path which omits this relationship.

This leaves the pointer returned by bpf_iter_task_vma_next() valid in the
verifier after bpf_iter_task_vma_destroy() frees the iterator's backing
allocation, including the VMA snapshot.  A BPF program can therefore read
the released snapshot through the stale pointer.

Set the iterator reference ID as the parent of non-RCU PTR_TO_BTF_ID
results from iterator next kfuncs. Preserve the parent across BTF field
loads when the result remains fully trusted and its lifetime is tied to the
parent. This invalidates trusted vm_file and vm_mm pointers derived from
the snapshot.

Do not propagate the parent to MEM_RCU, MEM_PERCPU, or MEM_USER field
results. Those result types obtain their usable lifetime or access domain
independently from the owning pointer. Untrusted results continue to follow
their existing fault-tolerant access rules.

This issue was found during BPF verifier testing with an in-house
runtime semantic checker.

Fixes: 4cbee026db54 ("bpf: return VMA snapshot from task_vma iterator")
Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd27..55ba1be0b6a8a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6140,9 +6140,16 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	}
 
 	if (atype == BPF_READ && value_regno >= 0) {
-		ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
+		enum bpf_reg_type reg_type = ret;
+		u32 parent_id = reg->parent_id;
+
+		ret = mark_btf_ld_reg(env, regs, value_regno, reg_type,
+				      reg->btf, btf_id, flag);
 		if (ret < 0)
 			return ret;
+		if ((regs[value_regno].type & PTR_TRUSTED) &&
+		    !(regs[value_regno].type & (MEM_RCU | MEM_PERCPU | MEM_USER)))
+			regs[value_regno].parent_id = parent_id;
 	}
 
 	return 0;
@@ -14105,6 +14112,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].btf = desc_btf;
 			regs[BPF_REG_0].type = type;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
+
+			if (bpf_is_iter_next_kfunc(&meta) && !(type & MEM_RCU))
+				regs[BPF_REG_0].parent_id = meta.ref_obj.id;
 		}
 
 		if (is_kfunc_ret_null(&meta)) {
-- 
2.43.0

