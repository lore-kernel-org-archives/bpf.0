Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBDD33D6F7
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015234; cv=none; b=jyHQ10k7gQoqMC8RlRl5FCZ460FkzVVX3vefsc9oOur70f5IM4Du9iqFiLuYrjNeWBvxc6CwJLG+vQX0C2fWfihWtSWkaQK9J01t8CClyn+vDcR7Y8GJhfDGlXyNacLUGoiNIGddpVtWUogBrUMlxbmGQXIQOefWtz97IHvMn14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015234; c=relaxed/simple;
	bh=0xo1DdZ8C9LOnLvbRfN3R8SF1PKYl7SXUD2NemNw3Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reves1y7/cHldSNAHMd0/PTuNsOWMiwv6nclGSsob7aXYs9Adeo3e0LBaCpWd8xexduLSww9LITmnRWLpyOf2xW825DdQqUq9xZs290PvzfZqqDOpAVhwb6z1ezk0UhnqA/GMAH8YxRdsn+//XDWMHI3ot5U5Jp/sgJ5LvIeETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=hkOoO6JL; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="hkOoO6JL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=FhCAigX7fpfJGmNR9OItJHsfEe+FLtOw7S
	ucQ0b/8S0=; b=hkOoO6JLFQpFiQzcrpH9uTnpirwzWU7cZtjTQUkxQwRYy/tUGb
	jlv6iRyr/REmILtUoa/GbdKE+vcvbLSMQdGm5epOTtngzH55cnVgAQvmfbDE6RYV
	6ujTUjN5z8qnSVzbcX0c7MkhN85FgzhgRcFKPmJo6Byj9rsIZGpvaT0+o=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCXkyq3NKJqvjL_AA--.318S2;
	Thu, 10 Sep 2026 12:40:23 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Reject task VMA snapshot use after destroy
Date: Thu, 10 Sep 2026 12:40:21 +0800
Message-ID: <20260910044021.2279628-3-xyx2021@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgCXkyq3NKJqvjL_AA--.318S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1DuFy8KF4xCrW5Cry3Jwb_yoWrJFWrpa
	n3A3sFkr4fXw47KF1kCF4ku3Wakwn5Za4jg34093WYkr48tr48WFyrJr1YvF1rAryvgF1S
	qrW0ka9xGr4UJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMc
	Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU0wvttUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Add verifier tests that obtain a task VMA snapshot, destroy its iterator,
and then access the snapshot directly or through its trusted vm_file field.
The verifier must reject both stale accesses.

Also verify that pointers whose lifetime does not depend on the iterator
remain usable after iterator destruction. Cover an RCU-protected task
iterator result and an exe_file pointer reached through the task VMA
snapshot's vm_mm field.

Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 .../selftests/bpf/progs/iters_testmod.c       | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
index 76012dbbdb413..7fc23f0c4444e 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -28,6 +28,78 @@ int iter_next_trusted(const void *ctx)
 	return 0;
 }
 
+SEC("raw_tp/sys_enter")
+__failure __msg("invalid mem access 'scalar'")
+int iter_next_trusted_after_destroy(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma_ptr;
+
+	bpf_iter_task_vma_new(&vma_it, cur_task, 0);
+
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (!vma_ptr)
+		goto out;
+
+	bpf_iter_task_vma_destroy(&vma_it);
+	return vma_ptr->vm_start;
+out:
+	bpf_iter_task_vma_destroy(&vma_it);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("invalid mem access 'scalar'")
+int iter_next_trusted_field_after_destroy(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma_ptr;
+	struct file *file_ptr;
+
+	bpf_iter_task_vma_new(&vma_it, cur_task, 0);
+
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (!vma_ptr)
+		goto out;
+
+	file_ptr = vma_ptr->vm_file;
+	bpf_iter_task_vma_destroy(&vma_it);
+	if (file_ptr)
+		return file_ptr->f_mode;
+	return 0;
+out:
+	bpf_iter_task_vma_destroy(&vma_it);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__success
+int iter_next_trusted_rcu_field_after_destroy(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma_ptr;
+	struct mm_struct *mm_ptr;
+	struct file *file_ptr = NULL;
+
+	bpf_iter_task_vma_new(&vma_it, cur_task, 0);
+
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (vma_ptr) {
+		mm_ptr = vma_ptr->vm_mm;
+		/* exe_file has RCU protection independent of the iterator. */
+		if (mm_ptr)
+			file_ptr = mm_ptr->exe_file;
+	}
+
+	bpf_iter_task_vma_destroy(&vma_it);
+	if (file_ptr)
+		return file_ptr->f_mode;
+	return 0;
+}
+
 SEC("raw_tp/sys_enter")
 __failure __msg("Possibly NULL pointer passed to trusted R1")
 int iter_next_trusted_or_null(const void *ctx)
@@ -66,6 +138,25 @@ int iter_next_rcu(const void *ctx)
 	return 0;
 }
 
+SEC("raw_tp/sys_enter")
+__success
+int iter_next_rcu_after_destroy(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task task_it;
+	struct task_struct *task_ptr;
+
+	bpf_iter_task_new(&task_it, cur_task, 0);
+
+	task_ptr = bpf_iter_task_next(&task_it);
+	bpf_iter_task_destroy(&task_it);
+	if (!task_ptr)
+		return 0;
+
+	bpf_kfunc_rcu_task_test(task_ptr);
+	return 0;
+}
+
 SEC("raw_tp/sys_enter")
 __failure __msg("Possibly NULL pointer passed to trusted R1")
 int iter_next_rcu_or_null(const void *ctx)
-- 
2.43.0

