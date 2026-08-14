Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25323AEF2D
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744394; cv=none; b=NOixyyB3/6j1okXUBODdejT8aDK4CofBlRZk/NTE+MXWDs7Wqu4+1HzZvBHqWaeWPJ3l+hBPkDfTTJHwXm0H3GOms9+GgNO2+Kt0fLWasI/PAPp/l/ZFIIi3dEMP79igTQJKC8moelyUlVWbYQ1Xa8L2wMTzu+pCSN7bB34tnsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744394; c=relaxed/simple;
	bh=xzBcG8zrdVWHTTOLp4tCPPc1QDjgP31zJnQLNFvRAYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zna6aCeUuWk3K5vRYYkVQ0LJ6Z5TcV0HVzzuSQVcEvKdTjBqeEo6zKPaZmQdu8NZzpwXugTqbIrLzYmzIy0p3uNJTsxtv46BpbiKpWeeiCsgdIo35TZzOsUJdUFbPL3EV29TAEeOgAfawp/9omcXqz13qSflG3GOyB11eLI94B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=q0ZgUyrb; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="q0ZgUyrb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xhPF1QvyalZ00mgXhx6DBM5gr5TxltP/vhsS+yaORGM=; b=q0ZgUyrbV0G7CbCtvRg0zbLjoH
	Grc+TvW0reFvTkxoBCtTS1Vu1GGSxVKe8MxkTLYtB/iQHachq/xkNkOlYAKANqiBksw6R1/J60DnI
	DBGfaqD+yVCjKVnVHOW3Ph4zy3KTq1q4LvCYzgMAhOU2VyK9YNH30GSxoB9DH8NNd9wwNjlV6go1E
	A0IsezELkXgc/lwCkm550X4v9OVVm5sXICT2ZHJNiaYD6xGDNPfCnMEVoHTEGDZ64hXZaRBTh+eMg
	9aJHRc0Zrhy2lx5MRd1JfCVP0IAKl7i63/+HXlxW2IkDHAgOkGiAWEFRapVckwhCyqmyk7rAg5BRD
	iIjPwM9w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wuzpo-000F9R-0P;
	Fri, 14 Aug 2026 23:53:04 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 5/6] selftests/bpf: Add tests for pointer type merge at a shared load
Date: Fri, 14 Aug 2026 23:52:59 +0200
Message-ID: <20260814215301.709827-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814215301.709827-1-daniel@iogearbox.net>
References: <20260814215301.709827-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28092/Fri Aug 14 08:27:02 2026)

Cover the ways in which the type recorded for a shared load used to lose
the BPF_PROBE_MEM rewrite which would then trigger a NULL deref if not
handled properly.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t mem_rdonly_untrusted
  [...]
  #238/1   mem_rdonly_untrusted/btf_id_to_ptr_mem:OK
  #238/2   mem_rdonly_untrusted/ldx_is_ok_bad_addr:OK
  #238/3   mem_rdonly_untrusted/ldx_is_ok_good_addr:OK
  #238/4   mem_rdonly_untrusted/offset_not_tracked:OK
  #238/5   mem_rdonly_untrusted/stx_not_ok:OK
  #238/6   mem_rdonly_untrusted/atomic_not_ok:OK
  #238/7   mem_rdonly_untrusted/atomic_rmw_not_ok:OK
  #238/8   mem_rdonly_untrusted/kfunc_param_not_ok:OK
  #238/9   mem_rdonly_untrusted/mixed_mem_type:OK
  #238/10  mem_rdonly_untrusted/mixed_mem_untrusted_btf_id_type:OK
  #238/11  mem_rdonly_untrusted/mixed_mem_btf_id_type:OK
  #238/12  mem_rdonly_untrusted/mixed_rdonly_mem_btf_id_type:OK
  #238/13  mem_rdonly_untrusted/mixed_mem_mem_type:OK
  #238/14  mem_rdonly_untrusted/mixed_map_value_mem_type:OK
  #238/15  mem_rdonly_untrusted/mixed_stack_mem_type:OK
  #238/16  mem_rdonly_untrusted/diff_size_access:OK
  #238/17  mem_rdonly_untrusted/misaligned_access:OK
  #238/18  mem_rdonly_untrusted/null_check:OK
  #238/19  mem_rdonly_untrusted/ldx_is_ok_commuted_addr:OK
  #238/20  mem_rdonly_untrusted/helper_param_not_ok:OK
  #238     mem_rdonly_untrusted:OK
  Summary: 1/20 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../bpf/progs/mem_rdonly_untrusted.c          | 254 ++++++++++++++++++
 1 file changed, 254 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index b91271d4caa4..ac8bba3e7d02 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -3,6 +3,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
+#include "bpf_kfuncs.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
 SEC("tp_btf/sys_enter")
@@ -164,6 +165,259 @@ int mixed_mem_type(void *ctx)
 	return *p;
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ringbuf SEC(".maps");
+
+int zero;
+
+static __noinline u64 *get_mem_or_untrusted_addr(u64 *mem)
+{
+	/*
+	 * Try to avoid compiler hoisting load to if branches by using
+	 * __noinline func.
+	 */
+	if (zero)
+		return mem;
+	else
+		return bpf_rdonly_cast(0, bpf_core_type_id_kernel(struct sock));
+}
+
+SEC("socket")
+__success
+__log_level(2)
+__msg("= *(u64 *)(r{{[0-9]}} +0){{.*}}=untrusted_ptr_sock")
+__msg("= *(u64 *)(r{{[0-9]}} +0){{.*}}=ringbuf_mem")
+__retval(0)
+int mixed_mem_untrusted_btf_id_type(void *ctx)
+{
+	u64 *p, v;
+
+	p = bpf_ringbuf_reserve(&ringbuf, sizeof(*p), 0);
+	if (!p)
+		return 1;
+	*p = 42;
+	/*
+	 * The load below is reached with PTR_TO_MEM | MEM_RINGBUF on one
+	 * path and with PTR_TO_BTF_ID | PTR_UNTRUSTED on the other. The
+	 * merged type has to keep the BPF_PROBE_MEM rewrite, otherwise
+	 * the NULL deref taken at runtime panics the kernel instead of
+	 * returning 0.
+	 */
+	v = *get_mem_or_untrusted_addr(p);
+	bpf_ringbuf_discard(p, 0);
+	return v;
+}
+
+static __noinline u32 *get_mem_or_btf_id_addr(u32 *mem)
+{
+	struct task_struct *task;
+
+	/*
+	 * Try to avoid compiler hoisting load to if branches by using
+	 * __noinline func.
+	 */
+	if (zero)
+		return mem;
+
+	task = bpf_get_current_task_btf();
+	/*
+	 * A plain BTF pointer walk yields a bare PTR_TO_BTF_ID, and
+	 * task->nameidata is NULL unless the task currently is in the
+	 * middle of a path lookup.
+	 */
+	return (u32 *)&task->nameidata->flags;
+}
+
+SEC("socket")
+__success
+__log_level(2)
+__msg("= *(u32 *)(r{{[0-9]}} +0){{.*}}=ptr_nameidata")
+__msg("= *(u32 *)(r{{[0-9]}} +0){{.*}}=ringbuf_mem")
+__retval(0)
+int mixed_mem_btf_id_type(void *ctx)
+{
+	u32 *p, v;
+
+	p = bpf_ringbuf_reserve(&ringbuf, sizeof(*p), 0);
+	if (!p)
+		return 1;
+	*p = 42;
+	/*
+	 * Same as above, except that the other path yields a bare
+	 * PTR_TO_BTF_ID. Merging it with PTR_TO_MEM used to drop the
+	 * BPF_PROBE_MEM rewrite the bare PTR_TO_BTF_ID would have
+	 * gotten on its own.
+	 */
+	v = *get_mem_or_btf_id_addr(p);
+	bpf_ringbuf_discard(p, 0);
+	return v;
+}
+
+char dynptr_data[8];
+
+static __noinline u32 *get_rdonly_mem_or_btf_id_addr(u32 *mem)
+{
+	struct task_struct *task;
+
+	/*
+	 * Try to avoid compiler hoisting load to if branches by using
+	 * __noinline func.
+	 */
+	if (zero)
+		return mem;
+
+	task = bpf_get_current_task_btf();
+	return (u32 *)&task->nameidata->flags;
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
+	struct bpf_dynptr dptr;
+	char buf[sizeof(u32)];
+	u32 *p;
+	u64 v;
+
+	if (bpf_dynptr_from_mem(dynptr_data, sizeof(dynptr_data), 0, &dptr))
+		return 1;
+	p = bpf_dynptr_slice(&dptr, 0, buf, sizeof(buf));
+	if (!p)
+		return 1;
+	/*
+	 * Same as above, except that the PTR_TO_MEM side already carries
+	 * MEM_RDONLY. Merging it with a bare PTR_TO_BTF_ID used to yield
+	 * PTR_TO_MEM | MEM_RDONLY, which is not rewritten either since
+	 * only its PTR_UNTRUSTED variant is.
+	 */
+	p = get_rdonly_mem_or_btf_id_addr(p);
+	/* asm block to have reliable match target for __msg. */
+	asm volatile (
+	"r7 = %[p];"
+	"r8 = *(u32 *)(r7 + 0);"
+	"%[v] = r8;"
+	: [v]"=r"(v)
+	: [p]"r"(p)
+	: "r7", "r8");
+	return v;
+}
+
+static __noinline u64 *get_mem_or_rdonly_untrusted_mem_addr(u64 *mem)
+{
+	u64 *p = bpf_rdonly_cast(0, 0);
+
+	/*
+	 * Hoist the cast above the branch so that the PTR_TO_MEM |
+	 * MEM_RINGBUF path is verified first and thus gets its type
+	 * recorded first.
+	 */
+	if (zero == 0)
+		return p;
+	return mem;
+}
+
+SEC("socket")
+__success
+__log_level(2)
+__msg("= *(u64 *)(r{{[0-9]}} +0){{.*}}=ringbuf_mem")
+__msg("= *(u64 *)(r{{[0-9]}} +0){{.*}}=rdonly_untrusted_mem")
+__retval(0)
+int mixed_mem_mem_type(void *ctx)
+{
+	u64 *p, v;
+
+	p = bpf_ringbuf_reserve(&ringbuf, sizeof(*p), 0);
+	if (!p)
+		return 1;
+	*p = 42;
+	/*
+	 * Both paths are PTR_TO_MEM based, so they used to not trip the
+	 * type mismatch check and skipped the merge altogether, leaving
+	 * the insn with the PTR_TO_MEM | MEM_RINGBUF recorded first and
+	 * hence without the BPF_PROBE_MEM rewrite the other path needs.
+	 */
+	v = *get_mem_or_rdonly_untrusted_mem_addr(p);
+	bpf_ringbuf_discard(p, 0);
+	return v;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, u64);
+} array SEC(".maps");
+
+static __noinline u64 *get_map_value_or_rdonly_untrusted_mem_addr(u64 *mem)
+{
+	u64 *p = bpf_rdonly_cast(0, 0);
+
+	/*
+	 * Hoist the cast above the branch so that the PTR_TO_MAP_VALUE
+	 * path is verified first and thus gets its type recorded first.
+	 */
+	if (zero == 0)
+		return p;
+	return mem;
+}
+
+SEC("socket")
+__failure
+__msg("same insn cannot be used with different pointers")
+int mixed_map_value_mem_type(void *ctx)
+{
+	u64 *p, v;
+	u32 key = 0;
+
+	p = bpf_map_lookup_elem(&array, &key);
+	if (!p)
+		return 1;
+	/*
+	 * PTR_TO_MAP_VALUE is neither PTR_TO_MEM nor PTR_TO_BTF_ID based,
+	 * so it cannot be merged into a type which keeps the BPF_PROBE_MEM
+	 * rewrite the PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED of the other
+	 * path needs. Both bases were mismatch ok, hence the load used to be
+	 * accepted with the PTR_TO_MAP_VALUE recorded and the NULL deref on
+	 * the second path panicked the kernel.
+	 */
+	v = *get_map_value_or_rdonly_untrusted_mem_addr(p);
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
+	 * Same as above, but for a PTR_TO_STACK on the other path. A
+	 * subprog cannot return one, so the branch and the load have to
+	 * be kept in the same frame, and the asm block is there to have
+	 * the compiler not duplicate the latter.
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

