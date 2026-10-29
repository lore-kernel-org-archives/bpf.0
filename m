Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309177;
	b=K3MnLmCZxMELHcfox9V+wvuSapHavSMECYKYJZ5xvuFGnyiiFAGkgVQ6vNKxXJ7DtAQY
	 1ZrzGndw/1+CI8i0gh7H5SV8h3PbGHl0hwdHSxLf+DwR6/J15ZSGC8i4yamOD+Z/2JI53
	 bVrlA7/8+kXKmO7NPsZDgCCoVzOuePY/EI5XpOQhz3BV3eLnNgfQX4jq73bSjqfxS1vEc
	 RnLLSJRRf7RhZ30/y4OXY1wjZPrfvIzd6XDpMqmfT8WvHjpIgQhUQJJBwwEj3CfKn2Tia
	 4k0K8zNN+xr+rsE6RuQv1CwsCKtjIuprjTUTI+mj6W3atoelEsQ0abVarhRgYUTc72w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309177;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7hpAZFKXcGCDxLX+70ahCIeH027GncS4YaaaIyP5lP8=;
	b=xUB4nYe90QehOduTlKs9G7up84GCTV53ZHJvPzgNM9YjqOLdO5Qry15cuL31sX6vS4XQ
	 nLXCdKuoPSDPd7hrDwa5AJXwjXeV19KxfUrG9IYFZkrBnphensFSK1adkE6Iv9R6zoWLR
	 z1bXHYdrtdOYdGmjSYz0X2hEsiGya5dUS31L71lJYm13ZzY+veC65z50OMUwTCNK/9RN5
	 cziXGWfNDEnwhabHWvqkZ3v7ro99Irn3sIdo/IiC2A/cSgGobxX5CEjihDECBtUG+yhWb
	 fTHzOwVcysw33BtAQSHy4YBfcj5dH3MKk2cfmMzIwQTfl1ucVVoDi4ZCsW6+SkqS3CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKMbSOH3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C40606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKMbSOH3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696D11F01816;
	Thu, 29 Oct 2026 21:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309177;
	bh=7hpAZFKXcGCDxLX+70ahCIeH027GncS4YaaaIyP5lP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NKMbSOH3RpSORuB1bQu/P3iXd0ghTjzlmcy0yI7CNt9RDYNRYsCWm+xkqvM6KNkOC
	 iLB/NQcSGRHJeEw2+XOWAailuz32Ld2ZYuviSIiYEusvJHMkkhkd48m7E9prv918b+
	 KOhtK8ICzETUhlMg1H3Uj+GkPzYnW5g1nwavORdKLs9X2VlqkWfF22RumkLEoWpjKt
	 bDNJM4+jwJGmpwVOsTJGcR6MTBcjKggxhuTNFXrX2oMOO9wA/8CFhbkJWNJfXzFNsR
	 GeAV9qfjB6jpTuM8+A+CPIcyQszpg1Jyog5J2rHD2sUxINJLeNHt1cj8kaSBMJlAq+
	 9EmqMQo5jD3cw==
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
Subject: [PATCH bpf-next 2/8] bpf: Add user memory kfuncs
Date: Thu, 29 Oct 2026 22:25:45 +0100
Message-ID: <20261029212551.56964-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029212551.56964-1-jolsa@kernel.org>
References: <20261029212551.56964-1-jolsa@kernel.org>
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
 kernel/bpf/helpers.c | 102 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c |  10 ++---
 2 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1ba63a..0540e415c7dd 100644
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
 
@@ -3738,6 +3741,83 @@ __bpf_kfunc int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
 	return ret;
 }
 
+/**
+ * bpf_copy_to_user() - Copy data to the current task's address space
+ * @unsafe_ptr__ign: Destination address in the current task's address space
+ * @src__srcptr:     Source address, in kernel space
+ * @src__sz:         Number of bytes to copy
+ * @flags:           Reserved for future use; must be zero
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
+__bpf_kfunc int bpf_copy_to_user(void __user *unsafe_ptr__ign, const void *src__srcptr,
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
+	ret = access_process_vm(current, (unsigned long)unsafe_ptr__ign, (void *)src__srcptr,
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
+ * bpf_user_mmap() - Map private anonymous memory into the current process
+ * @len:  Length of the mapping
+ * @prot: PROT_* flags of mmap(2), including PROT_EXEC
+ *
+ * This maps memory by calling vm_mmap() directly. It does not invoke the
+ * mmap(2) syscall, so seccomp filters do not mediate this mapping.
+ *
+ * Return: The address of the mapping on success, -EPERM if the caller has no
+ * user mm, or an unsigned-long encoded negative error code, as returned by
+ * vm_mmap().
+ */
+__bpf_kfunc unsigned long bpf_user_mmap(unsigned long len, unsigned long prot)
+{
+	if (!bpf_user_mm_ok())
+		return -EPERM;
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
@@ -5139,6 +5219,27 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 	.set   = &generic_btf_ids,
 };
 
+BTF_KFUNCS_START(user_mem_btf_ids)
+BTF_ID_FLAGS(func, bpf_copy_to_user, KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_user_mmap, KF_SLEEPABLE | KF_PERFMON)
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
@@ -5266,6 +5367,7 @@ static int __init kfunc_init(void)
 	};
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &user_mem_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 90bc7230afa8..0da2a26bcb82 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3936,8 +3936,8 @@ static void bpf_raw_tp_link_show_fdinfo(const struct bpf_link *link,
 		   raw_tp_link->cookie);
 }
 
-static int bpf_copy_to_user(char __user *ubuf, const char *buf, u32 ulen,
-			    u32 len)
+static int bpf_copy_to_user_buf(char __user *ubuf, const char *buf, u32 ulen,
+			       u32 len)
 {
 	if (ulen >= len + 1) {
 		if (copy_to_user(ubuf, buf, len + 1))
@@ -3974,7 +3974,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
 	if (!ubuf)
 		return 0;
 
-	return bpf_copy_to_user(ubuf, tp_name, ulen, tp_len);
+	return bpf_copy_to_user_buf(ubuf, tp_name, ulen, tp_len);
 }
 
 static const struct bpf_link_ops bpf_raw_tp_link_lops = {
@@ -4035,7 +4035,7 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 		goto out;
 
 	if (buf) {
-		err = bpf_copy_to_user(uname, buf, ulen, len);
+		err = bpf_copy_to_user_buf(uname, buf, ulen, len);
 	} else {
 		char zero = '\0';
 
@@ -5714,7 +5714,7 @@ static int bpf_task_fd_query_copy(const union bpf_attr *attr,
 			if (put_user(zero, ubuf))
 				return -EFAULT;
 		} else {
-			err = bpf_copy_to_user(ubuf, buf, input_len, len);
+			err = bpf_copy_to_user_buf(ubuf, buf, input_len, len);
 			if (err == -EFAULT)
 				return err;
 		}
-- 
2.54.0

