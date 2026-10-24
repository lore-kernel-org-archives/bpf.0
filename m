Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792836428;
	b=Hpl5ldRjahW2LO0+kOfaPRzO6uAqEkPSja5AjaxUJQ6OfNZF7EUqhkFbd+LHi2nMvmlb
	 ROhHGOLVuHZa/FBQFounOhc9AYRelJTcuDqpFy9L/bS2bvFEm4NJX41CPTakkMqmMkI/g
	 QSjCKDfTCwjETMSRp4NTyP8zJjEle6J06lKR9CeWR8PU+Tge50CDJNsxAkzZVNuFZtxcs
	 dHEuq/87AeX8NUaxecjrl2y65fsykL2451CIIG0wQVDWVFwe0SG15sewKo8YUHPVohEQE
	 3barw9Uxfil/rPT8zEKy5ZhN4j/qYwaN2UrXYPfFUULqcGmbIW2X+p/tcbi0dXiGVHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792836428;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Gdn8jSFPTcxDS97JhC3dj0QYbbpQPyEoTetWOwON/6M=;
	b=dd05LeV1QuY82ChnZJEifbHs+gugQvbLNpy3uK6AMitTLsIXYCJRL6TRs3dWEMm43BoX
	 v79+4/QzA1fp8bXSsUWNi0+sd8nUi8SKCAw0Y2ByK/yrILjGTlQehI6thIKB8bw0xpz/W
	 D79Fi+CJCl3sDWp4AV0GDc8T/c16MDEPstqEtGEQyBMepUW6tQk6ZbD8XJWF5mAOkM9F5
	 7E9wIqy/omrTPo1IwAbE9jh//R9jxunp503ilfRn6z5ZHJqKYQzrjuuW6oqFNdOtmcpM+
	 sPoxXccSLU03r9HCQAWhZsxsPMapzbjAjbZjbu+UieMQdpuQgOsaeKhbAHNroTOSY6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=en9ZtyVx;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4DD606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 10:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B4DD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=en9ZtyVx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Gdn8jSFPTcxDS97JhC3dj0QYbbpQPyEoTe
	tWOwON/6M=; b=en9ZtyVxzV6JJ2icBqUFnpCdLh/sAJV/KjUV8EUiioGdqMh4aF
	okc+aeDHjeVBlP3rPf4qXB/c8XutijNhBbPveDgVKf5GhtwNwBYmRM6UL+BqialD
	iZmxQ1x54zaqCbmRI1I01NyUQaOIao2m/QHAHHqOe00GTpMzXqhcC+R1I=
Received: from localhost (unknown [222.195.81.103])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgD3gkdBg9xqDzY7AA--.3503S2;
	Sat, 24 Oct 2026 18:06:57 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	utilityemal77@gmail.com
Subject: [PATCH bpf-next v8 2/2] selftests/bpf: Test borrowed iterator result lifetimes
Date: Sat, 24 Oct 2026 18:06:47 +0800
Message-ID: <20261024100647.2579244-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024100647.2579244-1-xyx2021@mail.ustc.edu.cn>
References: <20261024100647.2579244-1-xyx2021@mail.ustc.edu.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgD3gkdBg9xqDzY7AA--.3503S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Kr18Ar4fXFWUGFyDAFyUtrb_yoW8WF17uo
	Z7CFn0ya1UurykAw47Kr4xKrW7Zan09F9xJrW5G39aga18Gwn5KrW7Ww4UX3WjgF15Kry7
	ua4rGanavr4kGr1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYM7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
	x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
	1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0
	I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8tw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bel1PUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Exercise borrowed VMA results before and after iterator advancement
and destruction, including NULL next, trusted fields, and a FILE
dynptr that must be discarded before advancing. Keep positive controls
for using the current element and discarding the dynptr first.

Use a test-module iterator returning current to verify the explicit
independent-lifetime exception. Retain controls for RCU-protected
results. Also check the generic trusted-field rule outside iterators:
reading file->f_inode while holding an acquired file reference succeeds,
but using the saved inode pointer after bpf_put_file() is rejected.

The annotated programs check verifier loading and diagnostics; they do
not request runtime execution of the added programs.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 .../selftests/bpf/progs/iters_testmod.c       | 370 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_vfs_accept.c |  17 +
 .../selftests/bpf/progs/verifier_vfs_reject.c |  19 +
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  25 ++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   4 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   5 +
 6 files changed, 440 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
index 145750bb64ef8..8896335668b47 100644
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
@@ -77,6 +407,46 @@ int iter_next_rcu(const void *ctx)
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
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
index 55398c04290a8..25f37a3dd7cfb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
@@ -11,6 +11,23 @@
 
 static char buf[64];
 
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(inode_field_before_file_put)
+{
+	struct file *file;
+	ino_t ino;
+
+	file = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!file)
+		return 0;
+
+	ino = file->f_inode->i_ino;
+	bpf_put_file(file);
+	__sink(ino);
+	return 0;
+}
+
 SEC("lsm.s/file_open")
 __success
 int BPF_PROG(get_task_exe_file_and_put_kfunc_from_current_sleepable)
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index b5f456d57669e..ed2bd2faebf36 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -12,6 +12,25 @@
 
 static char buf[PATH_MAX];
 
+SEC("lsm.s/file_open")
+__failure __msg("invalid mem access 'scalar'")
+int BPF_PROG(inode_field_after_file_put)
+{
+	struct inode *inode;
+	struct file *file;
+	ino_t ino;
+
+	file = bpf_get_task_exe_file(bpf_get_current_task_btf());
+	if (!file)
+		return 0;
+
+	inode = file->f_inode;
+	bpf_put_file(file);
+	ino = inode->i_ino;
+	__sink(ino);
+	return 0;
+}
+
 SEC("lsm.s/file_open")
 __failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(get_task_exe_file_kfunc_null)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 6380f52f4dd2c..76fbe64755ef9 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -281,6 +281,27 @@ __bpf_kfunc void bpf_iter_testmod_seq_destroy(struct bpf_iter_testmod_seq *it)
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
@@ -1016,6 +1037,10 @@ BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
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
index 4ba9def74404b..aef780261ef4f 100644
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
index 3b810f1e438f7..e9902e651d72b 100644
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

