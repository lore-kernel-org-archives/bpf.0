Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7F13D75C9
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790510730; cv=none; b=fv/0QsMXn+GUPaAayrBoAThmdjRMWssenJWQMytwznSIQjw/j/PYxaktXdq/w92n0nLQNPI0PA5j7R195D0nxBfmIkM77QFwNgHWjjHTkpqkdlJLy4H9rWACTAZDlvGt4OAixhF7s5SACy9iTlf6aYnU36rDnH5PHHsDN04jpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790510730; c=relaxed/simple;
	bh=dwzNwwdwdbnWYGx2F90owgwY9wPpmDei4SPTex6kSA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQmCihQ0ZWguyA+XMTQvPO2yJYvMJhCP4nEQQwcWC/gIh3tWzyk8N7RQyV/t8zS9Ye5hxEKT1jjdwpb1J6M9vKLDPbHVPwCmQhE1App5h1Up2GQDOoUgXK/DF91XZPmXZsSGWv1ev+iOWlHEI8C1uiuFRifwcw5Z4NtQCqs8Q8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=RF8CFfHt; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="RF8CFfHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=7Y4mU379tIDeIddjINCS5LtJp6H2GseXyq
	31Jt/+/GE=; b=RF8CFfHtROoY3ZVKM7BkJ6Q31v9foBSWEnfv5OkSabzy1OMQkq
	LhXMBUixV8GFrjNHUCkm7GwN9+p7N9lFKgamZR/e72fSjaEH7aq0N/Fv//vGu+rp
	EeyGPnHoUPHTZ/COFW3FrO+s5CLt7Z48gF3EQ9YfMKCwV49L139l60O0s=
Received: from localhost (unknown [222.195.81.76])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCHhCs_BrlqBYlqAQ--.1497S2;
	Sun, 27 Sep 2026 20:04:15 +0800 (CST)
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
Subject: [PATCH bpf-next v6 2/2] selftests/bpf: Test borrowed iterator result lifetimes
Date: Sun, 27 Sep 2026 20:04:06 +0800
Message-ID: <20260927120406.1041915-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927120406.1041915-1-xyx2021@mail.ustc.edu.cn>
References: <20260927120406.1041915-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgCHhCs_BrlqBYlqAQ--.1497S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Kr18Ar4fXFWUGFyDAFyUtrb_yoW8GFW5to
	Z7CFn0ya1Uur97Aw17Kr4xKrW7uanY9F9xJrZ8G39aga18Gw1kKrW7Ww4UX3W2gF15Jry3
	ua4rGanavrs5Gr1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY97k0a2IF6FyUM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
	x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
	1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0
	I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07jFrWOUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Exercise borrowed VMA results before and after iterator advancement
and destruction, including NULL next, trusted fields, and a FILE
dynptr that must be discarded before advancing. Keep positive controls
for using the current element and discarding the dynptr first.

Use a test-module iterator returning current to verify the explicit
independent-lifetime exception. Retain controls for RCU-protected
results. The annotated programs check verifier loading and diagnostics;
they do not request runtime execution of the added programs.

Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 .../selftests/bpf/progs/iters_testmod.c       | 370 ++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  25 ++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   4 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   5 +
 4 files changed, 404 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
index f65cc9766633e..18b99f1684dfa 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -8,6 +8,44 @@
 
 char _license[] SEC("license") = "GPL";
 
+struct bpf_iter_testmod_current {
+	u64 __opaque;
+};
+
+SEC("raw_tp/sys_enter")
+__success
+int iter_independent_lifetime_after_next(const void *ctx)
+{
+	struct bpf_iter_testmod_current it;
+	struct task_struct *task;
+
+	bpf_iter_testmod_current_new(&it);
+	task = bpf_iter_testmod_current_next(&it);
+	if (!task)
+		goto out;
+
+	bpf_iter_testmod_current_next(&it);
+	bpf_kfunc_trusted_task_test(task);
+out:
+	bpf_iter_testmod_current_destroy(&it);
+	return 0;
+}
+
+SEC("raw_tp/sys_enter")
+__success
+int iter_independent_lifetime_after_destroy(const void *ctx)
+{
+	struct bpf_iter_testmod_current it;
+	struct task_struct *task;
+
+	bpf_iter_testmod_current_new(&it);
+	task = bpf_iter_testmod_current_next(&it);
+	bpf_iter_testmod_current_destroy(&it);
+	if (task)
+		bpf_kfunc_trusted_task_test(task);
+	return 0;
+}
+
 SEC("raw_tp/sys_enter")
 __success
 int iter_next_trusted(const void *ctx)
@@ -28,6 +66,298 @@ int iter_next_trusted(const void *ctx)
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
@@ -66,6 +396,46 @@ int iter_next_rcu(const void *ctx)
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
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 93847ca6293b4..6e50c1f7f13aa 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -244,6 +244,27 @@ __bpf_kfunc void bpf_iter_testmod_seq_destroy(struct bpf_iter_testmod_seq *it)
 	it->cnt = 0;
 }
 
+__bpf_kfunc int bpf_iter_testmod_current_new(struct bpf_iter_testmod_current *it)
+{
+	it->remaining = 2;
+	return 0;
+}
+
+__bpf_kfunc struct task_struct *
+bpf_iter_testmod_current_next(struct bpf_iter_testmod_current *it)
+{
+	if (!it->remaining)
+		return NULL;
+	it->remaining--;
+	/* current remains alive independently of the iterator. */
+	return current;
+}
+
+__bpf_kfunc void bpf_iter_testmod_current_destroy(struct bpf_iter_testmod_current *it)
+{
+	it->remaining = 0;
+}
+
 __bpf_kfunc void bpf_kfunc_common_test(void)
 {
 }
@@ -893,6 +914,10 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_testmod_seq_value)
+BTF_ID_FLAGS(func, bpf_iter_testmod_current_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_testmod_current_next,
+	     KF_ITER_NEXT | KF_RET_NULL | KF_ITER_RET_INDEPENDENT)
+BTF_ID_FLAGS(func, bpf_iter_testmod_current_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_kfunc_common_test)
 BTF_ID_FLAGS(func, bpf_kfunc_arena_arg_test)
 BTF_ID_FLAGS(func, bpf_kfunc_arena_cap_test)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index 2b12f81bf7487..94a228e807582 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -31,6 +31,10 @@ struct bpf_iter_testmod_seq {
 	int cnt;
 };
 
+struct bpf_iter_testmod_current {
+	u64 remaining;
+};
+
 struct bpf_testmod_ops {
 	int (*test_1)(void);
 	void (*test_2)(int a, int b);
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 67c02a421d133..13be4b6012cb9 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -33,6 +33,11 @@ struct prog_test_ref_kfunc {
 #endif
 
 struct bpf_iter_testmod_seq;
+struct bpf_iter_testmod_current;
+
+int bpf_iter_testmod_current_new(struct bpf_iter_testmod_current *it) __ksym;
+struct task_struct *bpf_iter_testmod_current_next(struct bpf_iter_testmod_current *it) __ksym;
+void bpf_iter_testmod_current_destroy(struct bpf_iter_testmod_current *it) __ksym;
 
 struct prog_test_pass1 {
 	int x0;
-- 
2.43.0

