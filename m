Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ABD3BB687
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975822; cv=none; b=bzx5v50gbnJEyv+m1QHaZmeGEby0s23Au9p2hHt83PRaMYuOSBhOHgApf6EeErjyrLbEA/i+wYD4KIUs7mPtbRmQbZhRHkCTBixTu0CTqcCl831ovyl0w9urMExtsF427rhbIJ7kWMY1bJhsp0CVisRUFwJhK1MthXG7NV4ITNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975822; c=relaxed/simple;
	bh=5uyLa660w3eK4bUuPO/IZhBgZzj3gD7hwRS3C57zNe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAEtb6UoFtZzWuC6RiKsERxL/rUpaef7Y1ROVrLWRnZi3XteetrN69Q3NoGBFb1FFWrilePDILLPcylkqENqqpWQFhRyJah4EBr7WUObeLXt6ZGbSH9S3cT1yCmIZspUiQWiGGnaO2b69tDNWBOxJURQoIn4UeHWbF/Wn8hCnms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=JtBZpExF; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JtBZpExF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=g3gRBLJcb20Hy97KfJuY2Kp6tqAZXQ8Ys4Zo0TasuyU=; b=JtBZpExFToCdKCpJGXNqa8uTg7
	oBZK/Lx6KtPGEhJzpQPyqq6NbI4kwJCGWxvTt+TzK8xF98mZnuhvey9GpC0xrBfULoxUBPmimMnOG
	1ijh3LwvhRhWiGdWlHbnSrTeF4YRD752A0GGxmgVoEQ0YaZeq6yKKPRMlB7taIRf62QqwqZRzv2gD
	onlWgzCY51caWN5lWUb0ea98DdKKaxK+6F/R9lxvVhlZNJKGLKbgrBmOMHPdZmWPqSz9N4QjyO5IM
	CD/GcxVqsfcVQ7nMywOh1riiF+f9VeQgBcfLTdOQNLv8nDcrPjtZLlDlvPAbVSKl09vkkF59e8MjA
	ccKlzUgQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wvy2a-000ML4-0q;
	Mon, 17 Aug 2026 16:10:16 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 1/3] selftests/bpf: Add tests for pointer type merge at a shared load
Date: Mon, 17 Aug 2026 16:10:13 +0200
Message-ID: <20260817141015.878071-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28095/Mon Aug 17 08:23:59 2026)

Cover the ways in which the type recorded for a shared load used to lose
the BPF_PROBE_MEM rewrite which would then trigger a NULL deref if not
handled properly.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t mem_rdonly_untrusted
  [...]
  #242/1   mem_rdonly_untrusted/btf_id_to_ptr_mem:OK
  #242/2   mem_rdonly_untrusted/ldx_is_ok_bad_addr:OK
  #242/3   mem_rdonly_untrusted/ldx_is_ok_good_addr:OK
  #242/4   mem_rdonly_untrusted/offset_not_tracked:OK
  #242/5   mem_rdonly_untrusted/stx_not_ok:OK
  #242/6   mem_rdonly_untrusted/atomic_not_ok:OK
  #242/7   mem_rdonly_untrusted/atomic_rmw_not_ok:OK
  #242/8   mem_rdonly_untrusted/kfunc_param_not_ok:OK
  #242/9   mem_rdonly_untrusted/mixed_mem_type:OK
  #242/10  mem_rdonly_untrusted/mixed_mem_untrusted_btf_id_type:OK
  #242/11  mem_rdonly_untrusted/mixed_mem_btf_id_type:OK
  #242/12  mem_rdonly_untrusted/mixed_rdonly_mem_btf_id_type:OK
  #242/13  mem_rdonly_untrusted/mixed_mem_mem_type:OK
  #242/14  mem_rdonly_untrusted/mixed_map_value_mem_type:OK
  #242/15  mem_rdonly_untrusted/mixed_stack_mem_type:OK
  #242/16  mem_rdonly_untrusted/diff_size_access:OK
  #242/17  mem_rdonly_untrusted/misaligned_access:OK
  #242/18  mem_rdonly_untrusted/null_check:OK
  #242/19  mem_rdonly_untrusted/ldx_is_ok_commuted_addr:OK
  #242/20  mem_rdonly_untrusted/helper_param_not_ok:OK
  #242     mem_rdonly_untrusted:OK
  Summary: 1/20 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 v2->v3:
  - address GCC-BPF failure (Eduard, CI)

 .../bpf/progs/mem_rdonly_untrusted.c          | 234 ++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index b91271d4caa4..3e0d4f687aaa 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -3,6 +3,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
+#include "bpf_kfuncs.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
 SEC("tp_btf/sys_enter")
@@ -164,6 +165,239 @@ int mixed_mem_type(void *ctx)
 	return *p;
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, u64);
+} array SEC(".maps");
+
+char dynptr_data[8];
+
+int zero;
+
+SEC("socket")
+__success
+__log_level(2)
+__msg("r8 = *(u64 *)(r7 +0){{.*}}R7=untrusted_ptr_sock")
+__msg("r8 = *(u64 *)(r7 +0){{.*}}R7=ringbuf_mem")
+__retval(0)
+int mixed_mem_untrusted_btf_id_type(void *ctx)
+{
+	u64 *p, *q, v;
+
+	p = bpf_ringbuf_reserve(&ringbuf, sizeof(*p), 0);
+	if (!p)
+		return 1;
+	*p = 42;
+	q = bpf_rdonly_cast(0, bpf_core_type_id_kernel(struct sock));
+	/*
+	 * The load below is reached with PTR_TO_MEM | MEM_RINGBUF on one
+	 * path and with PTR_TO_BTF_ID | PTR_UNTRUSTED on the other. The
+	 * merged type has to keep the BPF_PROBE_MEM rewrite, otherwise
+	 * the NULL deref taken at runtime panics the kernel instead of
+	 * returning 0.
+	 */
+	asm volatile (
+	"r7 = %[p];"
+	"if %[zero] != 0 goto +1;"
+	"r7 = %[q];"
+	"r8 = *(u64 *)(r7 + 0);"
+	"%[v] = r8;"
+	: [v]"=r"(v)
+	: [p]"r"(p),
+	  [q]"r"(q),
+	  [zero]"r"(zero)
+	: "r7", "r8");
+	bpf_ringbuf_discard(p, 0);
+	return v;
+}
+
+SEC("socket")
+__success
+__log_level(2)
+__msg("r8 = *(u32 *)(r7 +0){{.*}}R7=ptr_nameidata")
+__msg("r8 = *(u32 *)(r7 +0){{.*}}R7=ringbuf_mem")
+__retval(0)
+int mixed_mem_btf_id_type(void *ctx)
+{
+	struct task_struct *task;
+	u32 *p, *q;
+	u64 v;
+
+	p = bpf_ringbuf_reserve(&ringbuf, sizeof(*p), 0);
+	if (!p)
+		return 1;
+	*p = 42;
+	task = bpf_get_current_task_btf();
+	/*
+	 * A plain BTF pointer walk yields a bare PTR_TO_BTF_ID, and
+	 * task->nameidata is NULL unless the task currently is in the
+	 * middle of a path lookup.
+	 */
+	q = (u32 *)&task->nameidata->flags;
+	/*
+	 * Same as above, except that the other path yields a bare
+	 * PTR_TO_BTF_ID. Merging it with PTR_TO_MEM used to drop the
+	 * BPF_PROBE_MEM rewrite the bare PTR_TO_BTF_ID would have
+	 * gotten on its own.
+	 */
+	asm volatile (
+	"r7 = %[p];"
+	"if %[zero] != 0 goto +1;"
+	"r7 = %[q];"
+	"r8 = *(u32 *)(r7 + 0);"
+	"%[v] = r8;"
+	: [v]"=r"(v)
+	: [p]"r"(p),
+	  [q]"r"(q),
+	  [zero]"r"(zero)
+	: "r7", "r8");
+	bpf_ringbuf_discard(p, 0);
+	return v;
+}
+
+SEC("socket")
+__success
+__log_level(2)
+__msg("r8 = *(u32 *)(r7 +0){{.*}}R7=ptr_nameidata")
+__msg("r8 = *(u32 *)(r7 +0){{.*}}R7=rdonly_mem")
+__retval(0)
+int mixed_rdonly_mem_btf_id_type(void *ctx)
+{
+	struct task_struct *task;
+	struct bpf_dynptr dptr;
+	char buf[sizeof(u32)];
+	u32 *p, *q;
+	u64 v;
+
+	if (bpf_dynptr_from_mem(dynptr_data, sizeof(dynptr_data), 0, &dptr))
+		return 1;
+	p = bpf_dynptr_slice(&dptr, 0, buf, sizeof(buf));
+	if (!p)
+		return 1;
+	task = bpf_get_current_task_btf();
+	q = (u32 *)&task->nameidata->flags;
+	/*
+	 * Same as above, except that the PTR_TO_MEM side already carries
+	 * MEM_RDONLY. Merging it with a bare PTR_TO_BTF_ID used to yield
+	 * PTR_TO_MEM | MEM_RDONLY, which is not rewritten either since
+	 * only its PTR_UNTRUSTED variant is.
+	 */
+	asm volatile (
+	"r7 = %[p];"
+	"if %[zero] != 0 goto +1;"
+	"r7 = %[q];"
+	"r8 = *(u32 *)(r7 + 0);"
+	"%[v] = r8;"
+	: [v]"=r"(v)
+	: [p]"r"(p),
+	  [q]"r"(q),
+	  [zero]"r"(zero)
+	: "r7", "r8");
+	return v;
+}
+
+SEC("socket")
+__success
+__log_level(2)
+__msg("r8 = *(u64 *)(r7 +0){{.*}}R7=ringbuf_mem")
+__msg("r8 = *(u64 *)(r7 +0){{.*}}R7=rdonly_untrusted_mem")
+__retval(0)
+int mixed_mem_mem_type(void *ctx)
+{
+	u64 *p, *q, v;
+
+	p = bpf_ringbuf_reserve(&ringbuf, sizeof(*p), 0);
+	if (!p)
+		return 1;
+	*p = 42;
+	q = bpf_rdonly_cast(0, 0);
+	/*
+	 * Both paths are PTR_TO_MEM based, so they used to not trip the
+	 * type mismatch check and skipped the merge altogether, leaving
+	 * the insn with the PTR_TO_MEM | MEM_RINGBUF recorded first and
+	 * hence without the BPF_PROBE_MEM rewrite the other path needs.
+	 */
+	asm volatile (
+	"r7 = %[q];"
+	"if %[zero] == 0 goto +1;"
+	"r7 = %[p];"
+	"r8 = *(u64 *)(r7 + 0);"
+	"%[v] = r8;"
+	: [v]"=r"(v)
+	: [p]"r"(p),
+	  [q]"r"(q),
+	  [zero]"r"(zero)
+	: "r7", "r8");
+	bpf_ringbuf_discard(p, 0);
+	return v;
+}
+
+SEC("socket")
+__failure
+__msg("same insn cannot be used with different pointers")
+int mixed_map_value_mem_type(void *ctx)
+{
+	u64 *p, *q, v;
+	u32 key = 0;
+
+	p = bpf_map_lookup_elem(&array, &key);
+	if (!p)
+		return 1;
+	q = bpf_rdonly_cast(0, 0);
+	/*
+	 * PTR_TO_MAP_VALUE is neither PTR_TO_MEM nor PTR_TO_BTF_ID based,
+	 * so it cannot be merged into a type which keeps the BPF_PROBE_MEM
+	 * rewrite the PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED of the other
+	 * path needs. Both bases were mismatch ok, hence the load used to be
+	 * accepted with the PTR_TO_MAP_VALUE recorded and the NULL deref on
+	 * the second path panicked the kernel.
+	 */
+	asm volatile (
+	"r7 = %[q];"
+	"if %[zero] == 0 goto +1;"
+	"r7 = %[p];"
+	"r8 = *(u64 *)(r7 + 0);"
+	"%[v] = r8;"
+	: [v]"=r"(v)
+	: [p]"r"(p),
+	  [q]"r"(q),
+	  [zero]"r"(zero)
+	: "r7", "r8");
+	return v;
+}
+
+SEC("socket")
+__failure
+__msg("same insn cannot be used with different pointers")
+int mixed_stack_mem_type(void *ctx)
+{
+	u64 *p = bpf_rdonly_cast(0, 0);
+	u64 s = 42, v;
+
+	/*
+	 * Same as above, but for a PTR_TO_STACK on the other path.
+	 */
+	asm volatile (
+	"r7 = %[p];"
+	"if %[zero] == 0 goto +1;"
+	"r7 = %[s];"
+	"r8 = *(u64 *)(r7 + 0);"
+	"%[v] = r8;"
+	: [v]"=r"(v)
+	: [p]"r"(p),
+	  [s]"r"(&s),
+	  [zero]"r"(zero)
+	: "r7", "r8");
+	return v;
+}
+
 __attribute__((__aligned__(8)))
 u8 global[] = {
 	0x11, 0x22, 0x33, 0x44,
-- 
2.43.0

