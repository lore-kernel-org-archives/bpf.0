Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520038;
	b=QnJOdY9nvqe4/LapfEVx/JcDC5KPqehEi2PzXoffDmxX2wmLDpiMiWjMg7fw4OnquFOL
	 LgdzrvBiUKOBy/ZafNg1PAsaWhw21q0lewO1vWJonM50o10lSHepxZ3IyLX5G4PrdqkQ9
	 iKMKO8eGKrtAD1Rh7qQ5M2vVCyWcjd1ujDTkehUGiTRCF4w3jwzq2/vzrCIFiSPy6fFZK
	 tHptbUR3sV4yjJPbMq0D0Og/rR/LjR4hITtqoww9o/W0gFInYPmbAwOAOgBZTWJDJC7JJ
	 WqubfuXSbW2j5qEgfjgvN3XI23nMh3ahBqpubwGdOp2hOHGfVqwhgLrreEXwSh/9lBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=56wKz7OSyUcVXJ0GobzBIz+9MKjmFME/XIz4Sm3ma50=;
	b=ZZSlj7REkoH/51oPosRbFVP6BJsBpMe7olLfXE7YiEMiAdH+tKW9IUse5g+uRsF26ylo
	 /ZkIdYYGuUFJ+YQEt4a0mnCXpPHMEY5/Oza/VU88jXjlZSM1pF31bawp6/TVU1fVMl8oE
	 M/t20YM0XCdMrXZdUBTpMl3US5oApzmWCUAuW566AlUxh2cYfAljwLHGlvZfDe6gzer//
	 TRM8mPT4wZ1rLxXHx4mZVymLo3eEDVxDMq/HqO4HODKGENHvkuifTf+8TQPdc4HKsihUg
	 BhXk7kBgpjxdeYNhr4UHefT78Hpdta4bjSaujjjY0j4REoMMlTC1DkLHIngUohabDEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Y/vVijx3";
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E44606A31F
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35E44606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y/vVijx3
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a070755c8cso1061259b3a.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520037; x=1793124837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56wKz7OSyUcVXJ0GobzBIz+9MKjmFME/XIz4Sm3ma50=;
        b=Y/vVijx3RIggBS5sTK64dTrPshEkKWptM9PeABPBMNYs0ANXbUCfKaXdaH1avQyAgO
         gU+uYSDPA78+3/i1aYfm7ZORCqyk7Q/QljwIe19yR7EIDnQI8lL3tDVvFty+s2m4Ds2V
         8+1N9zpf2bpxSQEYb5gL0LDH5vxFGOjljx/ClVFdKtqPePxm35mE+xfnyeqfZKZd7aie
         MhnAykW70WF9BaBDLcvq4mk/bbsikjFXE90FNVVYy+FckzOQuaPxO+BPLbmF7rYkqMOj
         eZDhn9Lo3n6e4osLuz29wvb9D168c8ZSrCuugeqJqzr3o5SoxeJ6xjp/xmKEM5bsbg1K
         fdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520037; x=1793124837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=56wKz7OSyUcVXJ0GobzBIz+9MKjmFME/XIz4Sm3ma50=;
        b=rlOm3n5BHVfYWWhXBjPqLWrFf8EdhhsmuSKgvLa8WS7NkD83zUwFBt5HJ32QbZBM5W
         aBpsjMV2RWk5qxQbARjdaBepC88VDfIZTyDJIKI9P3zmRI2UEKSGDPYUViSKsa1NF0R/
         BcDMZnM/ci0152td4YjIiyYq6DsynPoiaqrlJY/xUJOrim4vh+XMj/q8ipaE/rKWpVB9
         IbuGrzeuEioVrZGHoWcBnC93uqyQdCb4h2eRV8RJrrCVtywWhz7Ga2JLLSCQ1MMGC3rB
         LR6/qCTCO7pHQzdV8GnO25S2vNL5W1jP3t6gtYTzjaxdp8RLrMjijx62G9Z74DqB3Ty/
         mzjg==
X-Gm-Message-State: AFq9FYL+0MpCOgkRwmlj4kweMhRKL7S8pL9sjRRwW4PJPFBgAUIG4fra
	+NrgRGQ1XEPfx/abGokMKoiXl4CKJRLr1uQcz9bTdpn8xUJgb+eApP+EBKLcrQ==
X-Gm-Gg: AYBFou1LZtins9cFcC7oNdzPiNloi9Yr3mNOl/KqG/KAkxWHH+Z4mGlQ6B/lRJB+Ph2
	vWbgxXwAi5YiCQawVbPCs/rjEFvI9QC6Iac636YYDf3tXfWAbLDAv+xpobi4AZppFaQLlIRUzoN
	OkmjsPuPB9TXlyY6AzXqg40SeCiBtQqXQPEIjj23dEfq5rDF1R3+Re6RVSrvJzlgRX7udSAoCtc
	t38RploP+lF8aKOcUcNXS6G5BSL3VmNrDrV/36yS9OWEwTJwqY+zBk0DlDFBju8NBrgtW8fzRcm
	AdU1VShNAfGPiVmdFhBRISUB6ADBNeUGpFFA911M93aID68BvXdmsiqDahnnGeahciStBZrTzCd
	PVecxwf9O7f8hnHa/bpi1lW9/vgSyG7C6t386OK5aty4+8DaJb09/h6PHlRNv8TKUKhyKGIqI9Y
	8PClaIn6EDx35KTF8RlD2uq0bQd4WPfrcK6nGTpil7KQ5KPOC+G5RoN0vTQOGgXL6tleH72L38h
	4Fnrx07TGC/nPiuXU+uPdpt2Sg8pEVaQb+vBVufpkQ+I8KlveOy9/8Hr4Hx51PwhGrEXZa/MpkO
	g9zZVc28vQNU6x1rEY6UoghCW/sv0nydBEd6C44kU3lqrQvH4itD9hc=
X-Received: by 2002:a05:6a00:180f:b0:8a0:8848:8c28 with SMTP id d2e1a72fcca58-8a0884898d5mr336977b3a.2.1792520037419;
        Tue, 20 Oct 2026 11:13:57 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a088b89ae9sm51474b3a.11.2026.10.20.11.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:13:56 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v4 bpf-next 5/6] selftests/bpf: Add a C++ prog with exceptions
Date: Tue, 20 Oct 2026 18:13:19 +0000
Message-ID: <20261020181320.1284798-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
References: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
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
 .../selftests/bpf/prog_tests/unwind_cxx.c     |  77 ++++++++++++
 .../selftests/bpf/progs/unwind_cxx.cpp        | 115 ++++++++++++++++++
 3 files changed, 203 insertions(+)
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
index 000000000000..a049a807cd04
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
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
+	if (!is_jit_enabled()) {
+		printf("%s:SKIP:JIT is disabled\n", __func__);
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

