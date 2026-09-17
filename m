Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9E3F3275
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789622415; cv=none; b=mWYMUq/upTIwBq9XYpmIO2odO48GC0TrOYQ+yaY2ZOKjKgtoeCE+Pr8tYfzDN4NlPbzFekEpfX3clyaTdbnCXrnu9033feL73YkGWtOtz5ZxAOYgR86lB0NNhbU8YzyVchVGkHvNTN3QA2gqXjk8+pxr0HrwSsYXOvC5wqv8ahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789622415; c=relaxed/simple;
	bh=aQJLvMH0OtzmVX7jH6Fb/4N++dyyAN6GEeaxF22FLpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF6FAcVg5hqCdKf54Bx0G6/IJ/yyb7MIfxXe8ASjT3+lNd9B+lZOIBZCqgknZiIq1+dH7lB0uiahJWAJCsNNudrWF4SRU6T9TCC7fM8GBFZ3EpPV+J+uZf73MExYgCjjNw8HrTqC6Q1WfmYD5RlXNwJHBAoTcuB7wSGhxHoRMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=WHZf05g9; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="WHZf05g9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=SYUKXtNZjevnU2LA1msT3/4PzK6lUkOrqV
	YuvxgnS7U=; b=WHZf05g9WUid362GQ0z9oOaWlc47yYcsfZ+i928wBP07a9bs7A
	NPXTueJya6R3E2L1QBr765qGMrd55ffqQ6dwfLUCShCo1KdH9UaIPe+e/sSMD96k
	DcIjAZJDXc116ZnvmWoClnxw0/M0UflA4Bg4Ap31YYVjRzUl2j4j6PHB0=
Received: from localhost (unknown [222.195.81.43])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHOiF7eKtq6aYqAQ--.2817S2;
	Thu, 17 Sep 2026 13:19:55 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Test iterator BTF pointer lifetimes
Date: Thu, 17 Sep 2026 13:19:48 +0800
Message-ID: <20260917051948.1588826-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917051948.1588826-1-xyx2021@mail.ustc.edu.cn>
References: <20260917051948.1588826-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBHOiF7eKtq6aYqAQ--.2817S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr18urWDtFW8KF4kJFWxtFb_yoWDJryfpa
	1xA3srCw4fX3y3Kr1kCanruFy3Kw1kZa4UW34vva1Fkr48tr4kWFyrtr1Yy3WrArykGFyS
	qrW0ka9xGrW8JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU84KZJUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Add verifier coverage for iterator-owned BTF pointer lifetimes.
Cover current struct results, iterator transitions,
trusted fields and FILE dynptr cleanup obligations. Keep current-result,
explicit-discard and independent RCU lifetime controls.

These annotations check verifier outcomes; they do not assert runtime
execution of the newly added programs.

Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 .../selftests/bpf/progs/iters_testmod.c       | 332 ++++++++++++++++++
 1 file changed, 332 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
index f65cc9766633e..81581459f11e3 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -28,6 +28,298 @@ int iter_next_trusted(const void *ctx)
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
+int iter_next_trusted_after_next(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma_ptr, *next_vma_ptr;
+	u64 vm_start;
+
+	bpf_iter_task_vma_new(&vma_it, cur_task, 0);
+
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (!vma_ptr)
+		goto out;
+
+	next_vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (!next_vma_ptr)
+		goto out;
+
+	vm_start = vma_ptr->vm_start;
+	bpf_iter_task_vma_destroy(&vma_it);
+	return vm_start;
+out:
+	bpf_iter_task_vma_destroy(&vma_it);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("invalid mem access 'scalar'")
+int iter_next_trusted_after_next_null(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma_ptr, *next_vma_ptr;
+	u64 vm_start;
+
+	bpf_iter_task_vma_new(&vma_it, cur_task, 0);
+
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (!vma_ptr)
+		goto out;
+
+	next_vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (next_vma_ptr)
+		goto out;
+
+	vm_start = vma_ptr->vm_start;
+	bpf_iter_task_vma_destroy(&vma_it);
+	return vm_start;
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
+__failure __msg("invalid mem access 'scalar'")
+int iter_next_trusted_field_after_next(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma_ptr, *next_vma_ptr;
+	struct file *file_ptr;
+	u32 mode;
+
+	bpf_iter_task_vma_new(&vma_it, cur_task, 0);
+
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (!vma_ptr)
+		goto out;
+
+	file_ptr = vma_ptr->vm_file;
+	if (!file_ptr)
+		goto out;
+
+	next_vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (!next_vma_ptr)
+		goto out;
+
+	mode = file_ptr->f_mode;
+	bpf_iter_task_vma_destroy(&vma_it);
+	return mode;
+out:
+	bpf_iter_task_vma_destroy(&vma_it);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("Leaking reference id=")
+int iter_next_file_dynptr_after_next(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma_ptr;
+	struct bpf_dynptr dynptr;
+	struct file *file_ptr;
+
+	bpf_iter_task_vma_new(&vma_it, cur_task, 0);
+
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (!vma_ptr)
+		goto out;
+
+	file_ptr = vma_ptr->vm_file;
+	if (!file_ptr)
+		goto out;
+
+	bpf_dynptr_from_file(file_ptr, 0, &dynptr);
+	bpf_iter_task_vma_next(&vma_it);
+	bpf_dynptr_file_discard(&dynptr);
+out:
+	bpf_iter_task_vma_destroy(&vma_it);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__failure __msg("Leaking reference id=")
+int iter_next_file_dynptr_after_destroy(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma_ptr;
+	struct bpf_dynptr dynptr;
+	struct file *file_ptr;
+
+	bpf_iter_task_vma_new(&vma_it, cur_task, 0);
+
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (!vma_ptr)
+		goto out;
+
+	file_ptr = vma_ptr->vm_file;
+	if (!file_ptr)
+		goto out;
+
+	bpf_dynptr_from_file(file_ptr, 0, &dynptr);
+	bpf_iter_task_vma_destroy(&vma_it);
+	bpf_dynptr_file_discard(&dynptr);
+	return 0;
+out:
+	bpf_iter_task_vma_destroy(&vma_it);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__success
+int iter_next_file_dynptr_discard_before_advance(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma_ptr;
+	struct bpf_dynptr dynptr;
+	struct file *file_ptr;
+
+	bpf_iter_task_vma_new(&vma_it, cur_task, 0);
+
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (!vma_ptr)
+		goto out;
+
+	file_ptr = vma_ptr->vm_file;
+	if (!file_ptr)
+		goto out;
+
+	bpf_dynptr_from_file(file_ptr, 0, &dynptr);
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_iter_task_vma_next(&vma_it);
+out:
+	bpf_iter_task_vma_destroy(&vma_it);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__success
+int iter_next_trusted_current_after_next(const void *ctx)
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
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (vma_ptr)
+		bpf_kfunc_trusted_vma_test(vma_ptr);
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
+SEC("raw_tp/sys_enter")
+__success
+int iter_next_trusted_rcu_field_after_next(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma_ptr;
+	struct mm_struct *mm_ptr;
+	struct file *file_ptr = NULL;
+	u32 mode = 0;
+
+	bpf_iter_task_vma_new(&vma_it, cur_task, 0);
+
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (vma_ptr) {
+		mm_ptr = vma_ptr->vm_mm;
+		if (mm_ptr)
+			file_ptr = mm_ptr->exe_file;
+	}
+
+	bpf_iter_task_vma_next(&vma_it);
+	if (file_ptr)
+		mode = file_ptr->f_mode;
+	bpf_iter_task_vma_destroy(&vma_it);
+	return mode;
+}
+
 SEC("raw_tp/sys_enter")
 __failure __msg("Possibly NULL pointer passed to trusted R1")
 int iter_next_trusted_or_null(const void *ctx)
@@ -66,6 +358,46 @@ int iter_next_rcu(const void *ctx)
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
+SEC("raw_tp/sys_enter")
+__success
+int iter_next_rcu_after_next(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task task_it;
+	struct task_struct *task_ptr;
+
+	bpf_iter_task_new(&task_it, cur_task, 0);
+
+	task_ptr = bpf_iter_task_next(&task_it);
+	if (!task_ptr)
+		goto out;
+
+	bpf_iter_task_next(&task_it);
+	bpf_kfunc_rcu_task_test(task_ptr);
+out:
+	bpf_iter_task_destroy(&task_it);
+	return 0;
+}
+
 SEC("raw_tp/sys_enter")
 __failure __msg("Possibly NULL pointer passed to trusted R1")
 int iter_next_rcu_or_null(const void *ctx)
-- 
2.43.0

