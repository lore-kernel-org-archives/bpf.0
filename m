Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E993368B2
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 04:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928159; cv=none; b=NiAm90xFEd8rQAieUpGSoELvLQaFOiIEmXfcwoSL74mGOd1fjWcJ51adobaQtNhA9LmdOBgAIGaC8UcvvQDy2DQ9VnNvDuPMZYIDh1oveVtEnnM44VEvBHTQUcan+sNS/sspEzXE3iwmI1FZ4xuKBeKRGCB/DQujlUQdWjxxYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928159; c=relaxed/simple;
	bh=1IxJRjDw8wd8LI1GMz+f+WZIfJzoIv0MFIeXXBfN2mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UknKFG1SiansKLR74RWB9gyGavUWBHrtEXkW03UlSLHLTkJH9JSxTNIGORs/oT1b2MXPAp5Pi42lUzYodyHoVF85vApvsrt4jxJG7vFyBY4HTMOsAmP938d6nhMU1uzYxF9zSwHC1FJi9OsAFXNq8fQSDzOpDALiBmDUUBOBB44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=p15LgXQd; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="p15LgXQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=s1Z4jTLf/LFc+EE1oWECLQdvsNueShOK/l
	z+5lR2f24=; b=p15LgXQd9Srkfp2WGGxYoZF8nlNVFyX2rD8vBXtp+GjYyq5lnp
	aTAZG2+hoGa8U2VFlf5dKq8HCVI9YhKr4axg71UrNm4VdGiw8ofhpyTLzsHgZvtg
	e/M3JDXIehZyX0b+8r3ktWYkIgz3Zb7vjtlZfqLI11Eifl7KuOdnBe9eQ=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDHuSCX4KBqLj_5AA--.5784S2;
	Wed, 09 Sep 2026 12:29:11 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf 1/2] bpf: Invalidate iterator-owned BTF pointers on destroy
Date: Wed,  9 Sep 2026 12:29:06 +0800
Message-ID: <20260909042907.1734153-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909042907.1734153-1-xyx2021@mail.ustc.edu.cn>
References: <20260909042907.1734153-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgDHuSCX4KBqLj_5AA--.5784S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CryDGr1kWrW7uw17Zr17GFg_yoW8Cr18pr
	WruFyqkr4kA3yjkFy7Aa18uFyavFy3Xay3Gr1vk3yrCFn8Ww13KrWUKryYvws0yFn5GFn2
	vrW09wn0qw1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU0eMKJUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Open-coded iterator next kfuncs that return non-struct pointers associate
the returned PTR_TO_MEM with the iterator's reference ID.  Struct pointer
returns take a separate PTR_TO_BTF_ID path which omits this relationship.

This leaves the pointer returned by bpf_iter_task_vma_next() valid in the
verifier after bpf_iter_task_vma_destroy() frees the iterator's backing
allocation, including the VMA snapshot.  A BPF program can therefore read
the released snapshot through the stale pointer.

Set the iterator reference ID as the parent of non-RCU PTR_TO_BTF_ID
results from iterator next kfuncs.  Releasing the iterator reference in
the destructor then invalidates those results as it already does for
PTR_TO_MEM results.

Leave MEM_RCU results unchanged.  Their lifetime is independently
protected by the surrounding RCU read-side critical section, which can
remain active after an iterator is destroyed.

This issue was found during BPF verifier testing with an in-house
runtime semantic checker.

Fixes: 4cbee026db54 ("bpf: return VMA snapshot from task_vma iterator")
Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd27..be4978629ae59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14105,6 +14105,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

