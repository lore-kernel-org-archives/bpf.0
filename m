Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A766C46E019
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116188; cv=none; b=VQrLCJnvjT0X+BkrXcg4N6ocpfnaVaUX8+MQeAHvGJ5825WHN3Pl9gX4I19QvwNl84oD4vzyCtsP4nlxiblm/aRtoZkGm7C1yPRGygjcWmdFcsAmV7dUvv9fvQHKbKDtkT0zgyx+PU6bgP0SURUp+ghggZDbhshYqSaDQdd1Ehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116188; c=relaxed/simple;
	bh=0sE7aaIqPzn3JxTaI6eG9R0eumVe7BHcHL/QQeDjb3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyzzU3Ap5VvVQ+DF6V4wyXQyQq2vOkZg4Q4wjuEKRjVUHGqFw3O3qg3Lrki6S99aoWtXTSczP8kpKGCI89VQzNqcpejm1se3kd6UrWbuKQnFBUXBFBspVgM9W7wcKU4uDBo6838WKBspsukH1erZ/qehIbp3jbDEvh1rvVf/A9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=HUByhvfX; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="HUByhvfX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=3tRxNyHji++ZugnpZBG/TtYztoo3/+TGL5
	Bb5N2XaLY=; b=HUByhvfX21wNRINk741UYyY2e6MFSZQe/zbKcCcH8hzx+/Cbjd
	AswZeTx4b6iPGIq8sowcZC9codBKVGM8nDXt2E+oTH3W83sY0y+lQnfEW8j4utTg
	gGuNW6i1i/98/Ee3MK+z+tDjmhg+7OranMHRi5ovNjqaMal4sXLdjp/bs=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgA3LyYTv6NqzO8GAQ--.484S2;
	Fri, 11 Sep 2026 16:42:59 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Test iterator BTF pointer lifetimes
Date: Fri, 11 Sep 2026 16:42:54 +0800
Message-ID: <20260911084254.3481508-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911084254.3481508-1-xyx2021@mail.ustc.edu.cn>
References: <20260911084254.3481508-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgA3LyYTv6NqzO8GAQ--.484S2
X-Coremail-Antispam: 1UD129KBjvJXoW3CF4ruF47ZF43Kw4rGryrtFb_yoWDWFy5pa
	1xA3srCw4fX3y3KF1kCanruFy3Kw1kZa4UW340va1Fkw48tr4kWFyrJr1Yy3W5AFykGFyS
	qrW0ka9xGrW8JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
	Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxU4iL0UUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Add verifier coverage for struct pointers returned by open-coded iterator
next kfuncs. Verify that the pointer is trusted for kfunc arguments while
the iterator element is current, then rejected after either next or
destroy. Cover both non-NULL and NULL next results.

Exercise a trusted vm_file field as well as the direct VMA pointer. Verify
that a FILE dynptr derived from vm_file must be discarded before iterator
next or destroy, and that advancing after an explicit discard remains
accepted. Keep a MEM_RCU field reachable through the snapshot's vm_mm field
valid across iterator transitions because its lifetime is independent of
the iterator.

Also cover the existing RCU iterator behavior to make sure it retains its
current lifetime and trust semantics.

Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 .../selftests/bpf/progs/iters_testmod.c       | 332 ++++++++++++++++++
 1 file changed, 332 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
index 76012dbbdb413..a55e5cf29474a 100644
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

