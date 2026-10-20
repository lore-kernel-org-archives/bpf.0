Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792470834;
	b=lFWiw4aZAUBqh9RR99V7JbGfya9ZKDWgCnupmOZ2LnpvMJ82pDCvG7Hxr6HBojIoqyFf
	 h4k7EKbBG9FDqpuEHazQmymkjlWm4vwsfim5QYcxy31RJQFYjnvI0kIUFbTgwTUD5/bX3
	 DzXzyDl+tR8UMn7yk7K5tuGB12cPT7xIUBPqoqdb3R4NDz1e6nozBJMOWC79b8H1IhN6q
	 ICaKHUs2wEFRsM570ED6aCAXMpZbM13GYJnRSB5f4ALA053FbYts6ny/dN2IeiwRNt4ey
	 IIv4ghy++bR4md923i3U9xzQTMRvT0EpQltI9yWdznfcDFwG68xPyPqUvWIFl92nuiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792470834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=akMrtCCQtTfDXEem+wSAT/aZf54g3PRrML7AidafIto=;
	b=X+xPLR5MOu6aokPGZPTM8+PxUh8FrEX0qs3JKt39quDW41bxsNZ2sIMVAHWWbHUjJ4tu
	 p0n/57Sikdohp6R7oEMpJBtH4KhkFyFx46YVBcAAgL3yLqomml8RsSzUIAogwYlDikqM/
	 yjkHf6rEgC/cVnoC07w1Y4+1OuC7/WqvP8JW+qtEfMZX51m26j0ntMPwds6INwOXnjrGp
	 BnXWsWO1LJ9nZxSdJOrSneSBkEw6GhbQ/qOiW4tTpajr5WHxgoXpx1ntTserKfs5Mrnqe
	 /8AYieA/JdZ+Qc3oJADYlTuV0V5AfJCuzZxhNOsmXyonFm9yQtjBzWtxrRVT8gkHqqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TUiFIDel;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC32606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 04:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBC32606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TUiFIDel
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd5e6f0a22bso1026938a12.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 21:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792470833; x=1793075633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=akMrtCCQtTfDXEem+wSAT/aZf54g3PRrML7AidafIto=;
        b=TUiFIDel3w15wDue7IKWQrQ1pr19ZgPCv8sQSLOweT941GrP/lG1PjQ6UPJWWoxyb5
         wzaNhxi7hw9vaEKnsMkr2fbHA3joADRP0OVmwdAIwUuDVnkfJpZr28Z7o/PC9g73HNX0
         YfEum8upE2Bj5cZ+5JjCKbBcjfGofRk0FSiZaZo/F3Pmb0AUAxPTg2tfpxRaeTlsebNL
         +1Uf6pqkQTNzQfXLr0xBn9iv8ZetKx+KWbP9bDNUH2v0oTz6GjOrueZa2J7u9fwGzXbF
         hyEmLBDfLnSYsgi2BGJD1WegmcGL20QWqle1RFyl0BFMA5bLK92gBgvDW2cZ34poQMwz
         EJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792470833; x=1793075633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=akMrtCCQtTfDXEem+wSAT/aZf54g3PRrML7AidafIto=;
        b=K7vxO0pyYRe8arXB9C4FodX7pA+yBq+r6EspoY0Pze2mTUkEVSfo4jCId0mrtNTapG
         JXhfuMmct4Y95EOyJQWCN70UTY5ZuBG5M7GC5pr1rIhkjxABtPUe3enlAtDXXNufJj22
         vVaJ/xpSBrAIvRrjKrlTahgV2axYgQbcipRlcAoA+h11sOt9zdv0TE+M9lrCkPfVcj2H
         rWAYJtR3FhUU3/rJeRhRRjU8tMrMfHctHiFfaw5Ln1j4sg8fNrmIF/xh1Zk4cOGVTl8b
         ZKAG/w2O1A5aofuP2nnzpiS+VLuhvl8P18eH+d6ZIbOBL4kHg2BUqiMfnUfuOCHQmBG9
         l5LQ==
X-Gm-Message-State: AFq9FYJ3NneYj2K3kZlmbo5NjK1KrZ4f45lhLI0rZ/yZua13iRFc5Qh0
	50DhVbp3vXTm/Zqff83Dmo8zCqNrr6iyatdf5c+UaVq62BMH5Af7yKTcZEOl9g==
X-Gm-Gg: AYBFou2TxShv2MzsKz28Ksy5fQMQpyFNsmUZv0Erg0UtvRv4v0mMHBF+tKh1CEZu9x3
	D+0j0EXMMY6bSHH7dBInjFFcKfLAufGsMOKdz9zDOD3276P/pMfSDyQxgPuMSwsmxoK1FwbSoI0
	fseWZCYO1LG8t0qgDleCSdBJ4lS54WJuT5IdkyTzLMMQl+pyEdb7tviZvIUMqzEDuhcowjZlTBn
	1dw6vVUtZBTmROIZI0mQrHuzub8xeJxZ/sZnZMtbGEDIM2UshUXr5E1WhjJ1nb/4PkqDdk85oBV
	0N6wsHfLQu9onWVDkILvm/PwlOS8lprR0YCepy+KM09kuXH1DbPidkO9HvO13E/2BDAuadR1Jl0
	X+bZJBcpN/U3CxATz1S60baX/2tfgE6VSpfbCMGzHIosWpb+iSz3sWbBPPt4KkxcspbPW93oQkt
	K0t/YqUpqEJFCzDebb61MBxwXwp4zuUjDTGK6PjV+ltkoN5vdBS8UlbNZ24rgH7lCT5aYcHomS6
	EPhM4wr3b+2SjJn1D5WMWuEAk4wNPeKCIsUHNPucBfpiX+yYw9zxesWbwDGADUtawzTFhA+eykq
	Rg2pho0A9aH5OB7IiH+gEbhRs9vcCxID3LmM1BUFQARdU9pUWJdIYsDk9tZbkP25bHBm4kdRi6E
	Yp/1m+pj7LoyxTuBsPIEmyWP1Lw==
X-Received: by 2002:a17:90b:5146:b0:3ac:adce:60b2 with SMTP id 98e67ed59e1d1-3acee293865mr7727847a91.2.1792470833011;
        Mon, 19 Oct 2026 21:33:53 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d400505sm2251046a91.4.2026.10.19.21.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 21:33:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v3 bpf-next 5/6] selftests/bpf: Add a C++ prog with exceptions
Date: Tue, 20 Oct 2026 04:33:18 +0000
Message-ID: <20261020043319.3031996-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
References: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

  static __noinline int inner(int len)
  {
          rcu_guard guard;

          if (len > 100)
                  throw 1;
          return len;
  }

  static __noinline int middle(int len)
  {
          preempt_guard guard;

          return inner(len) + 1;
  }

  SEC("tc") int catches(struct __sk_buff *skb)
  {
          try {
                  return middle(skb->len);
          } catch (...) {
                  return 42;
          }
  }

The exception passes through two frames. The destructors call
bpf_rcu_read_unlock() and bpf_preempt_enable(). The verifier insists on
both, and the test checks that they ran in that order.
In the second prog nobody catches. The destructors run and the prog
returns 0.

All that is left of the C++ runtime is four one line functions.
__cxa_throw() calls _Unwind_RaiseException(), which llvm lowers.

progs/*.cpp are built like progs/*.rs: by clang only and without skeletons.
vmlinux.h and bpf_helpers.h are not C++, so the prog declares what it
needs.

clang that lowers unwinding [1] defines __BPF_FEATURE_UNWIND. Without it
the object has no progs and the test is skipped.

[1] https://github.com/llvm/llvm-project/pull/233649

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile.skel     |  11 ++
 .../selftests/bpf/prog_tests/unwind_cxx.c     |  76 ++++++++++++
 .../selftests/bpf/progs/unwind_cxx.cpp        | 115 ++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_cxx.cpp

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
index 06e297a17156..6570c48f92b0 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -153,4 +153,15 @@ $(RUST_OBJS): $(RDIR)/%.bpf.o: progs/%.rs $(RUST_CORE) | $(RDIR)
 endif
 endif
 
+# Programs in C++. No skeletons: gcc doesn't build them.
+ifeq ($(BPF_CC),$(CLANG))
+CXX_OBJS := $(patsubst progs/%.cpp,$(RDIR)/%.bpf.o,$(wildcard progs/*.cpp))
+BPF_OBJS += $(CXX_OBJS)
+
+$(CXX_OBJS): $(RDIR)/%.bpf.o: progs/%.cpp | $(RDIR)
+	$(call msg,$(BPF_CC_MSG),$(BINARY),$@)
+	$(Q)$(BPF_CC) -x c++ -g -Wall -Werror -fexceptions -funwind-tables -fno-rtti	\
+		$(BPF_CC_FLAGS) -c $< -o $@ $(call skip_on_fail,BPF)
+endif
+
 endif # BPF_CC
diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c b/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
new file mode 100644
index 000000000000..36e52766022c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#ifndef ENOTSUPP
+#define ENOTSUPP 524
+#endif
+
+/* The progs are under #ifdef __BPF_FEATURE_UNWIND */
+static bool llvm_lowers_unwinding(const char *file)
+{
+	struct btf *btf = btf__parse(file, NULL);
+	bool ret;
+
+	ret = btf && btf__find_by_name_kind(btf, "catches", BTF_KIND_FUNC) > 0;
+	btf__free(btf);
+	return ret;
+}
+
+static void run(struct bpf_object *obj, const char *name, int len, int retval, int dtors)
+{
+	struct bpf_program *prog = bpf_object__find_program_by_name(obj, name);
+	struct bpf_map *map = bpf_object__find_map_by_name(obj, ".data.dtors");
+	char data[256] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = data,
+		.data_size_in = len,
+		.repeat = 1,
+	);
+	int key = 0, val = 0;
+
+	if (!ASSERT_OK_PTR(prog, name) || !ASSERT_OK_PTR(map, "dtors"))
+		return;
+	ASSERT_OK(bpf_map__update_elem(map, &key, sizeof(key), &val, sizeof(val), 0), "clear");
+	ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(prog), &opts), "test_run");
+	ASSERT_EQ(opts.retval, retval, "retval");
+	ASSERT_OK(bpf_map__lookup_elem(map, &key, sizeof(key), &val, sizeof(val), 0), "lookup");
+	ASSERT_EQ(val, dtors, "dtors");
+}
+
+void test_unwind_cxx(void)
+{
+	const char *file = "./unwind_cxx.bpf.o";
+	struct bpf_object *obj;
+	int err;
+
+	if (access(file, R_OK)) {
+		printf("%s:SKIP:gcc doesn't build %s\n", __func__, file);
+		test__skip();
+		return;
+	}
+	if (!llvm_lowers_unwinding(file)) {
+		printf("%s:SKIP:llvm doesn't lower unwinding\n", __func__);
+		test__skip();
+		return;
+	}
+	obj = bpf_object__open_file(file, NULL);
+	if (!ASSERT_OK_PTR(obj, "open"))
+		return;
+	err = bpf_object__load(obj);
+	if (err == -ENOTSUPP) {
+		printf("%s:SKIP:JIT does not support unwinding\n", __func__);
+		test__skip();
+		goto out;
+	}
+	if (!ASSERT_OK(err, "load"))
+		goto out;
+
+	/* inner's destructor, then middle's */
+	run(obj, "catches", 64, 65, 12);
+	run(obj, "catches", 200, 42, 12);
+	run(obj, "does_not_catch", 64, 65, 12);
+	run(obj, "does_not_catch", 200, 0, 12);
+out:
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/progs/unwind_cxx.cpp b/tools/testing/selftests/bpf/progs/unwind_cxx.cpp
new file mode 100644
index 000000000000..d46ee41fef85
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/unwind_cxx.cpp
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C++ exceptions. llvm lowers unwinding to two insns:
+ *   invoke foo unwind pad    call foo; unwind_goto pad
+ *   resume                   r0 = 0; unwind_exit
+ * so 'throw' is a jump or an exit, 'catch (...)' and the destructors that run on
+ * the way are ordinary blocks.
+ *
+ * vmlinux.h and bpf_helpers.h are not C++.
+ */
+#define SEC(name) __attribute__((section(name), used))
+#define __ksym __attribute__((section(".ksyms")))
+#define __noinline __attribute__((noinline))
+#define __always_inline inline __attribute__((always_inline))
+
+#ifdef __BPF_FEATURE_UNWIND
+
+struct __sk_buff {
+	unsigned int len;
+};
+
+extern "C" {
+void bpf_rcu_read_lock(void) noexcept __ksym;
+void bpf_rcu_read_unlock(void) noexcept __ksym;
+void bpf_preempt_disable(void) noexcept __ksym;
+void bpf_preempt_enable(void) noexcept __ksym;
+
+/* Starts an unwind. Not a kfunc: llvm lowers the call and it doesn't come back. */
+int _Unwind_RaiseException(void *exc);
+
+/* All that is left of the C++ runtime. Nobody looks at the exception object. */
+static char exc_obj[16];
+
+__always_inline void *__cxa_allocate_exception(unsigned long size) noexcept
+{
+	return exc_obj;
+}
+
+__always_inline void __cxa_throw(void *exc, void *tinfo, void (*dtor)(void *))
+{
+	_Unwind_RaiseException(exc);
+}
+
+__always_inline void *__cxa_begin_catch(void *exc) noexcept
+{
+	return exc;
+}
+
+__always_inline void __cxa_end_catch(void) noexcept
+{
+}
+}
+
+/* One decimal digit per destructor, in the order they ran */
+volatile int dtors SEC(".data.dtors");
+
+/* The verifier insists that both are undone on every path out of the prog */
+struct rcu_guard {
+	__always_inline rcu_guard()
+	{
+		bpf_rcu_read_lock();
+	}
+	__always_inline ~rcu_guard()
+	{
+		bpf_rcu_read_unlock();
+		dtors = dtors * 10 + 1;
+	}
+};
+
+struct preempt_guard {
+	__always_inline preempt_guard()
+	{
+		bpf_preempt_disable();
+	}
+	__always_inline ~preempt_guard()
+	{
+		bpf_preempt_enable();
+		dtors = dtors * 10 + 2;
+	}
+};
+
+static __noinline int inner(int len)
+{
+	rcu_guard guard;
+
+	if (len > 100)
+		throw 1;
+	return len;
+}
+
+static __noinline int middle(int len)
+{
+	preempt_guard guard;
+
+	return inner(len) + 1;
+}
+
+extern "C" SEC("tc") int catches(struct __sk_buff *skb)
+{
+	try {
+		return middle(skb->len);
+	} catch (...) {
+		return 42;
+	}
+}
+
+/* The exception leaves the prog: it returns 0 */
+extern "C" SEC("tc") int does_not_catch(struct __sk_buff *skb)
+{
+	return middle(skb->len);
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

