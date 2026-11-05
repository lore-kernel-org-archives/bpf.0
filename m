Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874248;
	b=w58bGe0UZa778xZ2vNhIs4g+TH/B5FfLZisv3R4s/ExsK/CSn6SEO0o/6WItTTDlf1In
	 TSDRlRoxgufO3szKj5LPXsyjkCpnWRUAoqqF9JVJNuiSoDINUnoyMPG6afWVGonDmEZWT
	 vJRp9M07l0fD1tBEvPJLUOz0ZqJtUPeM4uhC3LNaQU694g3sfY1R9fFSTj1L65icUf6zu
	 Rz0LVnsW+Btof7vMGcvzl48worhf8GbvmbwZ5CDMUPdOmGPtHWsSNdR/koNOPCMacMW1x
	 JqoStUa7Sua78NwglV/InFDVSZvjOCXIvVuBtCWJlF3F0SaJNe9yyaWo1PWFWUDG/1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874248;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ukfAuOjvggf2x46fnM5SSPXxPa35OmUkK54EQRFxays=;
	b=Z/Xis4qQx8wrlFnxivQkWkQ9Ch2ylW6v03gyIugTn7CLiowoS3lipRDVpQV4cAbJTkZy
	 0qebuNADjqYSFl2yrOYDG1WIOHxWIZV469QrnOc7rwWnPNLCkOStCx9yidIbbPCY/DBV0
	 vuc4BdH19Yti1lDbVDyBucwDbshQucdgDkAvun4AQ7P3qDofinW+W70hOnlfg5W/6ysER
	 v4E9rSS/qmr9yZUtxjmKrBPt+aI3JLgEZWSiarNmHWhekdgWBhLl7Xj3QFTzrZrf4C4Ws
	 XixvlzgJGWiy2VgG7+Y/6+3F+1HhNuj1su9PF4lz/PAUT6MvMScql0idLn0L6AvsqXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TD3Ho5vA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E00D606A332
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TD3Ho5vA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A861F0093A;
	Thu,  5 Nov 2026 10:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874248;
	bh=ukfAuOjvggf2x46fnM5SSPXxPa35OmUkK54EQRFxays=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TD3Ho5vAdZTm3OwPTMs1WIGa51yfZn6wuA6V6bsU2pwqHAeHaUyjDN1jVGPsza/bx
	 80YBY+97YdHXEHEi5971iUANIyN50uFTbzU2w/+3O5wiu8QGbU6qhE+pR0/QwMt1oM
	 aa3FBoHYg0NcTfevLUUwAb6z6cetaDtoNQJGfb6ueY3fG31rAr4KlfIhce4aVFrVLX
	 15h65pNOjLLf91XlJ+8pgEbGAVaZBZr1Fwc3vk0ILMmoCSVLqO+AeuHnwgoPMtFJ6P
	 l2H+QlUL5f72t21yqXBM1t0phfanNVajy8ENBtb/E1Wr7296HjFpGA0+hsZUo+d+JO
	 eJnwtsjhv8uGQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: [PATCHv3 bpf-next 2/8] bpf: Add user memory kfuncs
Date: Thu,  5 Nov 2026 11:23:36 +0100
Message-ID: <20261105102343.311331-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105102343.311331-1-jolsa@kernel.org>
References: <20261105102343.311331-1-jolsa@kernel.org>
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

Add sleepable kfuncs to copy data into a task's address space and to map
or unmap private anonymous memory in the current process.

Require a usable user mm for mmap and munmap. Register the kfuncs for
KPROBE programs and gate them on CAP_SYS_ADMIN BPF token capability and
the BPF_WRITE_USER lockdown check.

Use FOLL_FORCE | FOLL_WRITE for task memory copies and return -EFAULT
when a copy is incomplete.

Rename the syscall info-copy helper to bpf_copy_to_user_buf to avoid
the name collision.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Documentation/bpf/kfuncs.rst |  17 ++++++
 kernel/bpf/helpers.c         | 107 +++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c         |  10 ++--
 3 files changed, 129 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 4f8dd7c1d785..81686d556f58 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -976,3 +976,20 @@ the verifier. bpf_cgroup_ancestor() can be used as follows:
 BPF provides a set of kfuncs that can be used to query, allocate, mutate, and
 destroy struct cpumask * objects. Please refer to :ref:`cpumasks-header-label`
 for more details.
+
+4.4 User memory kfuncs
+----------------------
+
+The user memory kfuncs operate on the current process's address space.
+``bpf_copy_to_user()`` writes to this address space, including private mappings
+that are not writable. A partial copy is not rolled back if it faults.
+
+``bpf_user_anon_mmap()`` and ``bpf_user_munmap()`` create and remove mappings
+by calling the kernel's mapping functions directly rather than issuing
+``mmap(2)`` or ``munmap(2)`` syscalls. As a result, seccomp filters do not
+mediate these mapping operations. A seccomp filter can still allow or deny the
+syscall that triggers a BPF program, but it cannot separately filter the
+mapping performed by these kfuncs.
+
+.. kernel-doc:: kernel/bpf/helpers.c
+   :identifiers: bpf_copy_to_user bpf_user_anon_mmap bpf_user_munmap
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6788489a2608..937a0d7d6839 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -29,6 +29,9 @@
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
 #include <linux/buildid.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/limits.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3768,6 +3771,88 @@ __bpf_kfunc int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
 	return ret;
 }
 
+/**
+ * bpf_copy_to_user() - Copy data to the current task's address space
+ * @unsafe_ptr__ign: Destination address in the current task's address space
+ * @src:     Source address, in kernel space
+ * @src__sz: Number of bytes to copy
+ * @flags:   Reserved for future use; must be zero
+ *
+ * Faults in the destination and writes the way ptrace(PTRACE_POKETEXT) does:
+ * a private mapping doesn't have to be writable. A partial copy is not undone,
+ * the bytes before the fault stay written.
+ *
+ * The caller must coordinate with other threads so they do not execute the
+ * destination range while it is being modified, and ensure execution begins
+ * only after the copy completes.
+ *
+ * Return: 0 on success, -EINVAL if @flags is non-zero, or -EFAULT if the copy
+ * fails or is partial.
+ */
+__bpf_kfunc int bpf_copy_to_user(void __user *unsafe_ptr__ign, const void *src,
+				 u32 src__sz, u64 flags)
+{
+	int ret;
+
+	if (unlikely(flags))
+		return -EINVAL;
+	if (unlikely(src__sz > S32_MAX))
+		return -EINVAL;
+	if (unlikely(!src__sz))
+		return 0;
+	ret = access_process_vm(current, (unsigned long)unsafe_ptr__ign, (void *)src,
+				src__sz, FOLL_FORCE | FOLL_WRITE);
+	return ret == src__sz ? 0 : -EFAULT;
+}
+
+/* bpf_wq and bpf_task_work callbacks can run without a usable mm. */
+static bool bpf_user_mm_ok(void)
+{
+	return current->mm && !(current->flags & (PF_KTHREAD | PF_EXITING));
+}
+
+/**
+ * bpf_user_anon_mmap() - Map private anonymous memory into the current process
+ * @len:  Length of the mapping
+ * @prot: PROT_* flags of mmap(2), including PROT_EXEC
+ *
+ * This maps memory by calling vm_mmap() directly. It does not invoke the
+ * mmap(2) syscall, so seccomp filters do not mediate this mapping.
+ *
+ * Note that ia32 tasks are unsupported. This calls vm_mmap() directly and
+ * bypasses the compat mmap syscall wrapper.
+ *
+ * Return: The address of the mapping on success, -EPERM if the caller has no
+ * user mm, or an unsigned-long encoded negative error code, as returned by
+ * vm_mmap().
+ */
+__bpf_kfunc unsigned long bpf_user_anon_mmap(unsigned long len, unsigned long prot)
+{
+	if (!bpf_user_mm_ok())
+		return -EPERM;
+	if (!arch_validate_prot(prot, 0))
+		return -EINVAL;
+	return vm_mmap(NULL, 0, len, prot, MAP_PRIVATE | MAP_ANONYMOUS, 0);
+}
+
+/**
+ * bpf_user_munmap() - Unmap a range of addresses of the current process
+ * @addr: Start of the range
+ * @len:  Length of the range
+ *
+ * This unmaps memory by calling vm_munmap() directly. It does not invoke the
+ * munmap(2) syscall, so seccomp filters do not mediate this unmapping.
+ *
+ * Return: 0 on success, -EPERM if the caller has no user mm, or a negative
+ * error code.
+ */
+__bpf_kfunc int bpf_user_munmap(unsigned long addr, unsigned long len)
+{
+	if (!bpf_user_mm_ok())
+		return -EPERM;
+	return vm_munmap(addr, len);
+}
+
 /**
  * bpf_copy_from_user_mm_str() - Copy a string from an address space
  * @dst:             Destination address, in kernel space. This buffer must be
@@ -5175,6 +5260,27 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 	.set   = &generic_btf_ids,
 };
 
+BTF_KFUNCS_START(user_mem_btf_ids)
+BTF_ID_FLAGS(func, bpf_copy_to_user, KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_user_anon_mmap, KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_user_munmap, KF_SLEEPABLE | KF_PERFMON)
+BTF_KFUNCS_END(user_mem_btf_ids)
+
+static int user_mem_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&user_mem_btf_ids, kfunc_id))
+		return 0;
+	if (!bpf_token_capable(prog->aux->token, CAP_SYS_ADMIN))
+		return -EPERM;
+	return security_locked_down(LOCKDOWN_BPF_WRITE_USER);
+}
+
+static const struct btf_kfunc_id_set user_mem_kfunc_set = {
+	.owner  = THIS_MODULE,
+	.set    = &user_mem_btf_ids,
+	.filter = user_mem_kfunc_filter,
+};
+
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
 BTF_ID(func, bpf_task_release_dtor)
@@ -5302,6 +5408,7 @@ static int __init kfunc_init(void)
 	};
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &user_mem_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 02ed5368f056..9004f2673ccf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3932,8 +3932,8 @@ static void bpf_raw_tp_link_show_fdinfo(const struct bpf_link *link,
 		   raw_tp_link->cookie);
 }
 
-static int bpf_copy_to_user(char __user *ubuf, const char *buf, u32 ulen,
-			    u32 len)
+static int bpf_copy_to_user_buf(char __user *ubuf, const char *buf, u32 ulen,
+			       u32 len)
 {
 	if (ulen >= len + 1) {
 		if (copy_to_user(ubuf, buf, len + 1))
@@ -3970,7 +3970,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
 	if (!ubuf)
 		return 0;
 
-	return bpf_copy_to_user(ubuf, tp_name, ulen, tp_len);
+	return bpf_copy_to_user_buf(ubuf, tp_name, ulen, tp_len);
 }
 
 static const struct bpf_link_ops bpf_raw_tp_link_lops = {
@@ -4031,7 +4031,7 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 		goto out;
 
 	if (buf) {
-		err = bpf_copy_to_user(uname, buf, ulen, len);
+		err = bpf_copy_to_user_buf(uname, buf, ulen, len);
 	} else {
 		char zero = '\0';
 
@@ -5710,7 +5710,7 @@ static int bpf_task_fd_query_copy(const union bpf_attr *attr,
 			if (put_user(zero, ubuf))
 				return -EFAULT;
 		} else {
-			err = bpf_copy_to_user(ubuf, buf, input_len, len);
+			err = bpf_copy_to_user_buf(ubuf, buf, input_len, len);
 			if (err == -EFAULT)
 				return err;
 		}
-- 
2.43.0

