Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612712;
	b=BBx6DeHGN8lU+swyfKe6WbL0ufusfGqQZX2ssTTxmBB6krXIZ1Tq5IuFDhHeSdBTziOy
	 R3gzWZyyyZdVjXKSUWw0Wy31MU2zMF7XTPFVUpdtvV8NbKaF+Gi7lM4sn+JegKBqmq2DD
	 ePg8EuN8FMJLXLxKAdnloVnwpX2cOdcx6L/d3EQ7ykPAeq1haJO4zAMdHUd4dZu9kvhsN
	 qyveOV0ugzBeq37BNhurfeIk0MQ+i/slsGpQ+7s6RCwiQooKy5Z6DeliBs3tNDJPXQbWp
	 hfVJ2/2x4Db/+h6ISnEP2uqvw8lfE7MFtwacPL8vTKi7oWiA7KmaU77Vnt2MInwN5pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612712;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=u+4xmbdLU1mrrwnt1X/d3bWQL9p1KJ5CSL5nr0RSS6A=;
	b=tO9SXQHVvW6yYEK0+dNDZ9839SNvhK7W5JCzwfOgkzln+EE/gKP/FqcpwE71h/O6jg+U
	 zz+x4aVCFwoJgSEwyn3GtHXrR9OeQF8D7S9uJtfYHs1VIAoCivHzII3qDwXTkDn2+HToM
	 raXnGcS8d4Mvam6K/TKgvyKT0AtIr9ZJ/NbAfFHEB6bdGhMuiM9bdRRm181CV8qHsSmj1
	 /BD6eczQiwk+QaFuOlvefP4og6EjEjnbXu3jS011tLzysPDVQihY3bYVUBYnUtdJPCknt
	 TvDysMUJ1YnJQIhMsJnbfmOhDFyz2iB1mTl8xxSALXolMrlkPOLNC/lu0fDvKodYU5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzxUeoNA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666A3606A319;
	Wed, 21 Oct 2026 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzxUeoNA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59201F000C1;
	Wed, 21 Oct 2026 19:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792612711;
	bh=u+4xmbdLU1mrrwnt1X/d3bWQL9p1KJ5CSL5nr0RSS6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dzxUeoNAVzeREkTXx4wpn4Qz9g7BTqmPmF8DOIwyFvv1g+LB0blfX5Y57KNABZV3A
	 g/2/BZq5FB2fi4SqTH8eeQH3T1SB7A0SrDT7nGObuHcG62icIencAySky6nGXKpq/2
	 R+9IzIjT8qrlXaXGzWWeehkxVZQZon14itVD+u1iAvpxC7Z+BTCz81RFliiVDfL3DB
	 YX9QlkVG+ZNID3JwLLjIAmAQ3YKlf+dptoW308wFGqrtufjlooN5qUCIOv0wYOIXas
	 0wJPDbnWuSP0Sjzf1rici8Dpu956XQPnaMdKE8UIKBEDwtyNWDATkLxKhjR8rmygEf
	 a/U1O3MJ9GYMA==
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
Subject: [RFC bpf-next 2/9] bpf: Add uprobe faultable user copy kfunc
Date: Wed, 21 Oct 2026 21:57:51 +0200
Message-ID: <20261021195759.119421-3-jolsa@kernel.org>
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

The bpf_probe_write_user() helper uses a no-fault copy. Adding kfunc
that can fault in the destination pages while copying to user memory.

Restricting it to sleepable uprobes and to LOCKDOWN_BPF_WRITE_USER.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/helpers.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1ba63a..4d9e9423826a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -29,6 +29,7 @@
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
 #include <linux/buildid.h>
+#include <asm/tlb.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3738,6 +3739,36 @@ __bpf_kfunc int bpf_copy_from_user_mm(void *dst, u32 dst__sz,
 	return ret;
 }
 
+/**
+ * bpf_probe_write_user_faultable() - Copy data to userspace with page faults
+ * enabled
+ * @unsafe_dst__ign: Destination address in the current task's address space.
+ * @src__srcptr:     Source buffer in BPF-accessible memory.
+ * @src__sz:         Number of bytes to copy.
+ *
+ * Copies data to userspace, allowing page faults to resolve the destination
+ * mapping. A failed copy may have written a prefix of the source buffer.
+ *
+ * Return: 0 on success, -EFAULT if the copy is incomplete, or -EPERM if the
+ * current task cannot safely access userspace.
+ */
+__bpf_kfunc int bpf_probe_write_user_faultable(void __user *unsafe_dst__ign,
+					      const void *src__srcptr,
+					      u32 src__sz)
+{
+	if (unlikely(in_interrupt() ||
+		     current->flags & (PF_KTHREAD | PF_EXITING)))
+		return -EPERM;
+	if (unlikely(!nmi_uaccess_okay()))
+		return -EPERM;
+	if (unlikely(!current->mm))
+		return -EFAULT;
+	if (copy_to_user(unsafe_dst__ign, src__srcptr, src__sz))
+		return -EFAULT;
+
+	return 0;
+}
+
 /**
  * bpf_copy_from_user_mm_str() - Copy a string from an address space
  * @dst:             Destination address, in kernel space. This buffer must be
@@ -5139,6 +5170,31 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 	.set   = &generic_btf_ids,
 };
 
+BTF_KFUNCS_START(user_mem_btf_ids)
+BTF_ID_FLAGS(func, bpf_probe_write_user_faultable, KF_SLEEPABLE | KF_PERFMON)
+BTF_KFUNCS_END(user_mem_btf_ids)
+
+enum user_mem_kfunc_id {
+	KF_bpf_probe_write_user_faultable,
+};
+
+BTF_ID_LIST_SINGLE(bpf_probe_write_user_faultable_btf_id, func,
+		   bpf_probe_write_user_faultable)
+
+static int user_mem_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (kfunc_id == bpf_probe_write_user_faultable_btf_id[0])
+		return security_locked_down(LOCKDOWN_BPF_WRITE_USER);
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set user_mem_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &user_mem_btf_ids,
+	.filter = user_mem_kfunc_filter,
+};
+
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
 BTF_ID(func, bpf_task_release_dtor)
@@ -5266,6 +5322,7 @@ static int __init kfunc_init(void)
 	};
 
 	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &user_mem_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
-- 
2.54.0

