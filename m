Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4DD468C14
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 05:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792387168; cv=none; b=RbUoX+CWC2OkdmrC8UfP9IEf1XSJW47w7M3B+yFi5HKtPp1lNqLx6CNqUhuY8AO2UAkgwQWnodkRcD6GAeSzYFJ7onw2z8CDCLFHrycSVRUeEuEwpTOx9oHQloxr4VjHs8peGT3D5UnLMMMYiFq8elF+feALO+WL5B3NMqwhbZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792387168; c=relaxed/simple;
	bh=6p4pzWvSf+SsQ5TQqNTsxOKIzCgiI14EeqbIl+63LWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYBdS9UUl3dAnVJQxFe8bHKHyh8IkaR7OqYDe9ix4D3EBYOgJqTB13N/jGy4YNQOPcmuIQr0mzYEefS49Rr5ZZ55OvRO6l4vtVgM2JDhcAiX+nPEOqziMhKe1CUl+WZ/fxjUQcw1z9tkik6MPKZ6rlT+mtfb6zQjZmioXRq0olY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8EzaevU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8EzaevU"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a06c60065fso270701b3a.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 22:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792387163; x=1792991963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7qX4pgxubI0rDBtjdRYL82LGy1lRScFIhITM4KIv1oE=;
        b=Y8EzaevU+0WLmaHzpEQz8sX7RGGylkgcfmUDXrY7dbsMzD7qjZJCjsgeZaFxO6OTMj
         dG0tclEQQpCjwWDgAV+uTz9mUKN5FQuzamoljxNgKAnzLbJgku2BarBSZSS9szbF0vvu
         XQKWM2AE5f0QIXkne1Uf+yf+cUTUToes3entnhMRLiLn6pQYsHcgxADS9imB4ibnPVXI
         3VTv+gPH1j/AHZIRj5YeqG4hblH+RIPf/0GK/ZySRLkQro3FAVG6h7TAldumCwCsvlBa
         PWm9UBPAyF/Gq9ZE5ke/9M9vnTakV99t41y5s0+QEXu+gvznxzsK8gDBuB8O5ai2Mcer
         hoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792387163; x=1792991963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7qX4pgxubI0rDBtjdRYL82LGy1lRScFIhITM4KIv1oE=;
        b=c+s/T79e3eLym2sTSndpVweHRVrSUVdK9Yz6q57drqTvnbDA1w35oncv3m13yykd1T
         xgb9sSJqzYQp8mVnCeC4XbzVLGuJdA7+FM+bDfV8CNAS13EwPgjtkpCvKYEMhWRGde05
         VYxqJa0AAD7XgmLenAJYw9gpkr97uUPkqpUo4gOzTdAMzUA+R2qUOfnDYuXgNls3Hurh
         YgmbcVjNRI9YhjNeuLCsXYCU72i6IlHKzf6zQpya8INNXCcKzsYt51lDvQKkxKAIORaw
         WH5AA8/IAm6YC8T4fpakcExxblAGnWWiu7HWab+IW66jB+59q3UJK59D+5uGoa8oPfRm
         chXg==
X-Gm-Message-State: AFq9FYIqa37IYqiZzVAMSE57N51z+4zwu7jIChKtExC/1RqoADpZeWkI
	mHelzJBWvx9ZGFVnXxMweFqBKX1hfi2+zpz84QVNhK2OMcxWGZv7SdGKxzWfnQ==
X-Gm-Gg: AYBFou2pgG1KKuIY/p1pXJfM5trzHvhKz2YXwQGzKDPAKaphYFYP1ZRN5UAtXRmmgo+
	oV5VH81r+BVo1CLJeFkVzailuIZmueN6j3InqMa7RPF2QYymG/yi89mv7E0A0JRB4QJ/zC5Brfu
	BqO+9br8etKAeYbiZore2YM39TjLWrYrPtx8x5NiflVxsTb6JqyuniFqBAH0eAHQvyj1oo64y+z
	TpNmJUpKJwdLTi1trpTc+KLKys49y3deaxdkSOrczwWPdklNt/KuPPOOyX5bLpsjkWLIuqZnrDn
	iqCrrIE7EOt3cGfzxLBptD6KiL4YDAP4SXXU8yIkPyga+gz4LV3cDK1hEJDsHm9CiIa4rhhiFX7
	xUGtQmKJ0Znz0Yk6lBRWXe7JKlOawOxVGeSEd4UM5sO7z0Di81AXXFAgvVPNBtT0Jk+q5eSxZqG
	7FBsEFFB2pqxkrXDs5hEBfNLFuqIc+nvPYCT7gpezquQdtUaJ5fbLazk1jDp4ZtwEtdaTO0fNv3
	z1t+L9L2LERg6UZL7bmaquPFwL3zlHC1e1yFoitZGhJAOukXCgAJheAFmZh6RCpn8azyfZ/KoPc
	RjwAgA5D/iBlNh3GLb6XTDkF4qUpCxRG8wos5t1u1EPWX6e5OFQ0/w==
X-Received: by 2002:a05:6a00:2355:b0:89e:71df:d6d5 with SMTP id d2e1a72fcca58-8a04b713029mr4374179b3a.10.1792387163375;
        Sun, 18 Oct 2026 22:19:23 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f56c8b931sm3407917b3a.9.2026.10.18.22.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 22:19:22 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf-next 5/5] selftests/bpf: Add a C++ prog with exceptions
Date: Mon, 19 Oct 2026 05:18:46 +0000
Message-ID: <20261019051846.3012089-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019051846.3012089-1-alexei.starovoitov@gmail.com>
References: <20261019051846.3012089-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
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

[1] https://github.com/llvm/llvm-project/pull/233140

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

