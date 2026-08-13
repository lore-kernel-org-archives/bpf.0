Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238FC42BC57
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653639; cv=none; b=A8wPmYILHPMU+fiq+uH/TK+AlJe1MqfJZFGLHFtDesSl8RxMKLwUaMZWltWCfUItDakejkihpvNgRQa1V7sNOMKNA4sbq512PkpFU///KZZquSrM9wwXjFnHRsBfEItEPhAesya4mElV4nBDv2VPor69VxSict8/XFxLtUCyy+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653639; c=relaxed/simple;
	bh=TgvsOtlxHMVUQw82JTEqrhHgAfMvxqn1/UvDyH1r7Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdC6Krr6ZhTnmU80ca8lqmafXkpQobXniO+sv0Nk5Slw1U/6oS+HSbMNF3gDJNr2pt+yHFlm04Hor34KijvwnCE+ezuSxie1qyfVXtBbShNvDzm3HSEPk/nPzlqqvDmfrkOKFtqwbFh9bExcuZJidsGv0vWPxSUWUPYc2c4qCIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=GJvyWBF3; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="GJvyWBF3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=InRsPhzvmrSO1WdOh5sokr4hMDBny7ZlgQkNACRbBAc=; b=GJvyWBF3AkqH/P07Iy4HBO5CxH
	1L1G5ZRipNtk864zP8d3EmZI4gW59ibgl/gTnkdRux9pQePbZ23Lkmc+Li19Nvq2bdnMbPU7sHl9Y
	+fWqZV6/ksIk/qnSpLA1Q7SnDkfWyaFJ1RIrKZl6P63SPOSGPbR3YortgJ/rxOSYnkRUxs3IVmEDB
	RhUG3dUqASA1k/4zNPTyf/MiVrMB/D9GnisZCxHuodAdWhbLTlwmaw9kOXOsOZnn6hCI7jYAgWe1C
	yWO1krMycEWhnqyDpOCICWVwlV34yyEY0Hjzv5dqnWzryYANRKKReiPrGmxSIRhOfZwJPeP6UI0C9
	eNGRPgwg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wucE7-0009ur-1F;
	Thu, 13 Aug 2026 22:40:35 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add tests for pointer type merge at a shared load
Date: Thu, 13 Aug 2026 22:40:32 +0200
Message-ID: <20260813204032.644949-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813204032.644949-1-daniel@iogearbox.net>
References: <20260813204032.644949-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28091/Thu Aug 13 08:25:54 2026)

Cover the ways in which the type recorded for a shared load used to lose
the BPF_PROBE_MEM rewrite. All four reach the same load with a PTR_TO_MEM
on one verification path and take a NULL deref on the other:

  - mixed_mem_untrusted_btf_id_type: pairs with PTR_TO_BTF_ID |
    PTR_UNTRUSTED from bpf_rdonly_cast() which is merged into
    PTR_TO_MEM | PTR_UNTRUSTED
  - mixed_mem_btf_id_type: pairs with bare PTR_TO_BTF_ID from
    a pointer walk which gets merged into a bare PTR_TO_MEM
  - mixed_rdonly_mem_btf_id_type: same, but with a PTR_TO_MEM |
    MEM_RDONLY from bpf_dynptr_slice() which is merged into
    PTR_TO_MEM | MEM_RDONLY
  - mixed_mem_mem_type: pairs PTR_TO_MEM | MEM_RINGBUF with the
    PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED of bpf_rdonly_cast()
    which was not merged at all

bpf_convert_ctx_accesses() rewrites none of these, so the NULL deref
on the second path panicked rather than returning 0. Assert that this
is not the case with the fix anymore.

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
  #238/14  mem_rdonly_untrusted/diff_size_access:OK
  #238/15  mem_rdonly_untrusted/misaligned_access:OK
  #238/16  mem_rdonly_untrusted/null_check:OK
  #238/17  mem_rdonly_untrusted/ldx_is_ok_commuted_addr:OK
  #238/18  mem_rdonly_untrusted/helper_param_not_ok:OK
  #238     mem_rdonly_untrusted:OK
  Summary: 1/18 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../bpf/progs/mem_rdonly_untrusted.c          | 183 ++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index b91271d4caa4..127b745bb0b7 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -3,6 +3,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
+#include "bpf_kfuncs.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
 SEC("tp_btf/sys_enter")
@@ -164,6 +165,188 @@ int mixed_mem_type(void *ctx)
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
+	 * Both paths are PTR_TO_MEM based, so they do not trip the type
+	 * mismatch check and used to skip the merge altogether, leaving
+	 * the insn with the PTR_TO_MEM | MEM_RINGBUF recorded first and
+	 * hence without the BPF_PROBE_MEM rewrite the other path needs.
+	 */
+	v = *get_mem_or_rdonly_untrusted_mem_addr(p);
+	bpf_ringbuf_discard(p, 0);
+	return v;
+}
+
 __attribute__((__aligned__(8)))
 u8 global[] = {
 	0x11, 0x22, 0x33, 0x44,
-- 
2.43.0

