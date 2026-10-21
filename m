Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612733;
	b=cszs3Jwm0tYSMhly9F0vWopE9qlwTgI5Zd+FKYs6xvJ2BSWb37dGzl0IdLNZ2bQH3t+q
	 fzQS+gK0/BnXcvToTP68gE7pfsPlWPBjJD4W8xiwPmp+NocfAXT2u0JSTyC247EbTAEHz
	 eaenXTS9J119c6cW6FXzPQpSG0e4fOBjcMoEB8t091X5VxXu5rmKjgusJfUrvd8ZHArsh
	 LdyiPYEHhDdRW3EXyd0sXGs81ktOvs43L/IE2lzH+lnbWqXcx4OLHA061q1oyRXV/zshk
	 a5ilbsoSRvk1VXOuI0hup4f0/DFaHu9h3iVNHGren0/9a/ngKE6xKGZ4qW+H13vMHPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612733;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Jn7cYNwO2EebwQTtuyF9ZBF5UX2UIlTQdb3hKPwxsNE=;
	b=nk9Fg92EPb8dkxflWriCZrE2yjMaq+fLH5Qe7BTzNfF5pyytcQOIQxcP6NS1sFxfYjqQ
	 W23Fp80oCI0VUq2GqtBJ8CxvE6A/FMLaHfbyhKLj+wqEIDzsOJYCQ5IiM7+WjyG4iJ2S5
	 YXm6mdkCM8Or1ommV/8aOQCjC1Al8Q+8kEY1egGV7YAIevwCy5ueAiM1IH5sCpOF+Kt7U
	 erB4qEg/cuRlvEp5Oqjzn7lghg0B0zR2InXZMHnluWiNruWlYeSdDj38Mmx88eX6ikQHH
	 JWkfEQvq4T2WZdhDfy5zNkb3jzj4EEmtt7DNlaTbeG2oMMMPrdxavVll+sZ3gV6lgqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaHL1atm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF99606A31A;
	Wed, 21 Oct 2026 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaHL1atm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F92E1F000C1;
	Wed, 21 Oct 2026 19:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792612732;
	bh=Jn7cYNwO2EebwQTtuyF9ZBF5UX2UIlTQdb3hKPwxsNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aaHL1atmE35nyOxsUVNKx824WP2YE1bRZTN24CLskPsbTsMWv0Rz9Py4LeD8cjWqo
	 66nb6382hQ/iBEApI8d2qsL8uF29CgIVtpX0xaOtMR7TXdGzKLpPMJ+jX87imjE19m
	 J/Z+W87/yHp3kROLG6lX2G/JwT0CD7qukSJX0OVlcdVYGnnVIn+2+20drOKW1AsT9W
	 Q3x8NdIOw3DULa1TNc2wXHxMlFMDtA/xjO3vXoEZxRzr0rDf6aIL8Mc6DX6RMuCEUX
	 v/tqtQJNknxoXBjfuENl5NL7QiuXMUcgXGQQsZYQjXIPNnTtVoA8EzTIpR1AtSDLN5
	 D27bG18iA+sIA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [RFC bpf-next 4/9] bpf: Add kfuncs to allocate and seal user pages
Date: Wed, 21 Oct 2026 21:57:53 +0200
Message-ID: <20261021195759.119421-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021195759.119421-1-jolsa@kernel.org>
References: <20261021195759.119421-1-jolsa@kernel.org>
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

Adding sleepable BPF kfuncs for allocating anonymous pages
in the current process and changing an allocated page to
read/execute permissions. The mapping remains in userspace
until it is unmapped or the process exits.

It's allowed only for sleepable kprobe type, which technicaly
means only sleepable uprobe.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/helpers.c | 127 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4d9e9423826a..246f4969a144 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -29,6 +29,10 @@
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
 #include <linux/buildid.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/personality.h>
+#include <asm/cacheflush.h>
 #include <asm/tlb.h>
 
 #include "../../lib/kstrtox.h"
@@ -3739,6 +3743,127 @@ __bpf_kfunc int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
 	return ret;
 }
 
+/* vm_private_data token for the unmergeable anonymous mapping below. */
+static char bpf_user_page_marker;
+
+/**
+ * bpf_user_page_alloc() - Allocate lazy anonymous pages in the current mm
+ * @nr_pages: Number of pages to allocate
+ *
+ * Creates a read/write anonymous mapping in the current task's address space.
+ * The mapping is kept non-executable even for tasks with READ_IMPLIES_EXEC,
+ * to avoid creating a writable executable mapping. The physical page is
+ * allocated on its first access. The mapping remains until userspace unmaps
+ * it or the process exits.
+ *
+ * Return: The userspace address on success, or a negative error code.
+ */
+__bpf_kfunc long bpf_user_page_alloc(unsigned long nr_pages)
+{
+	const unsigned long prot = PROT_READ | PROT_WRITE;
+	const unsigned long flags = MAP_PRIVATE | MAP_ANONYMOUS;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr, populate, len;
+	struct vm_area_struct *vma;
+	int err;
+
+	if (unlikely(in_interrupt() || current->flags & (PF_KTHREAD | PF_EXITING)))
+		return -EPERM;
+	if (unlikely(!nmi_uaccess_okay()))
+		return -EPERM;
+	if (unlikely(!mm))
+		return -EFAULT;
+	if (unlikely(!nr_pages || nr_pages > (ULONG_MAX >> PAGE_SHIFT)))
+		return -EINVAL;
+
+	len = nr_pages << PAGE_SHIFT;
+	err = security_mmap_file(NULL, prot, flags);
+	if (err)
+		return err;
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	addr = do_mmap(NULL, 0, len, prot, flags,
+		       mk_vma_flags(VMA_DONTEXPAND_BIT, VMA_DONTCOPY_BIT, VMA_DONTDUMP_BIT),
+		       0, &populate, NULL);
+	if (!IS_ERR_VALUE(addr)) {
+		/* VM_DONTEXPAND prevents merging this mapping into another VMA. */
+		vma = find_vma(mm, addr);
+		vma_start_write(vma);
+		if (current->personality & READ_IMPLIES_EXEC) {
+			vm_flags_clear(vma, VM_EXEC);
+			vma_set_page_prot(vma);
+		}
+		vma->vm_private_data = &bpf_user_page_marker;
+	}
+
+	mmap_write_unlock(mm);
+
+	if (!IS_ERR_VALUE(addr) && populate)
+		mm_populate(addr, populate);
+	return addr;
+}
+
+/**
+ * bpf_user_page_exec() - Make a BPF-allocated user page read/execute
+ * @addr: Address of the page to change
+ *
+ * Changes a writable page created by bpf_user_page_alloc() to read/execute.
+ * The page cannot be made writable again after this call.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+__bpf_kfunc int bpf_user_page_exec(unsigned long addr)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct page *page;
+	int err = -EINVAL;
+
+	if (unlikely(in_interrupt() ||
+		     current->flags & (PF_KTHREAD | PF_EXITING)))
+		return -EPERM;
+	if (unlikely(!nmi_uaccess_okay()))
+		return -EPERM;
+	if (unlikely(!mm))
+		return -EFAULT;
+	if ((addr & ~PAGE_MASK) || addr > ULONG_MAX - PAGE_SIZE)
+		return -EINVAL;
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	vma = find_vma(mm, addr);
+	if (!vma || vma->vm_start > addr)
+		goto out;
+	/* Allow to change only vma allocated by bpf_user_page_alloc. */
+	if (vma->vm_private_data != &bpf_user_page_marker)
+		goto out;
+	if (!(vma->vm_flags & VM_WRITE) || !(vma->vm_flags & VM_MAYEXEC))
+		goto out;
+
+	vma_start_write(vma);
+
+	err = get_user_pages(addr, 1, FOLL_WRITE, &page);
+	if (err != 1) {
+		if (!err)
+			err = -EFAULT;
+		goto out;
+	}
+
+	flush_icache_user_page(vma, page, addr, PAGE_SIZE);
+	err = do_mprotect_pkey_locked(addr, PAGE_SIZE, PROT_READ | PROT_EXEC, -1);
+	if (!err) {
+		vma = find_vma(mm, addr);
+		vm_flags_clear(vma, VM_MAYWRITE);
+	}
+	put_page(page);
+out:
+	mmap_write_unlock(mm);
+	return err;
+}
+
 /**
  * bpf_probe_write_user_faultable() - Copy data to userspace with page faults
  * enabled
@@ -5171,6 +5296,8 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 };
 
 BTF_KFUNCS_START(user_mem_btf_ids)
+BTF_ID_FLAGS(func, bpf_user_page_alloc, KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_user_page_exec, KF_SLEEPABLE | KF_PERFMON)
 BTF_ID_FLAGS(func, bpf_probe_write_user_faultable, KF_SLEEPABLE | KF_PERFMON)
 BTF_KFUNCS_END(user_mem_btf_ids)
 
-- 
2.54.0

