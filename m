Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E782F5495
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792285400; cv=none; b=sO4seoUCDunbMdLx7GPqv8vdZ/4M6fHGg36mjmJ7kCgxo3uvZspNQIQ5PNH1wEbvvovpVdvBRg+erAc64yZEfuvKjCwKD4D3oN9Spooi+gZQ7EFRNVWj1fPInuQlcaBJXCLq3jz23mRIy69nH/ZGW+o42F+UH3q7v2EozJIWWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792285400; c=relaxed/simple;
	bh=dNuFCvtL4pyBK4I8tXVFMFSIIXJVP5YdZ6djiH0YFq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIajQmrEcXoXGBvK8nE4dp8Mp0SYhrrg6jF+2Nt/Bac4AjMkVfOPa2lCHNGOe5S4jGyhQp54iaioWkdDU5x02dxOSYyrQPoAr4bgJMY+uGh6T1IYuwNmmzWaWrgwesEoNB4ADwF2KEoLrOMvL12/kZ40+hA1eag2nqmAsrGN2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEkVhkdw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEkVhkdw"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so117636b3a.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 18:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792285398; x=1792890198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WD3g722/9K6HoLlGq+HAL5yG10ySSL0HZEPgl3K0gr4=;
        b=pEkVhkdweyRKo1xkeK7eKive8YvtvCFH5RndsPW1uDTbqKhpSv6zMh5jdQDu92GDWD
         1dVFaEvMw7qq/Hau9jsMYYoTXGvrqYbNOYcMVeP/a+ooWloUITQBiogm++n889JpL/ib
         riB6VVeEzjCv7CMwDdjBsmKWDNJZR1hB4JAZQLsX1PJ1hn3JfueGvXPwaF4Se122FrQh
         jy+htJHODMvOrApUpF79CGBu4oNC43wATJ1KzA8tJFEGs6on/XQ1r/9ENiy3e1aVXgDS
         E3XQokp2+oe1Ov5nqwF0RN5GWaUjoRj2vNjfGvUreUSHMk/TxYOFDDdJqrfanieXIPXv
         Z5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792285398; x=1792890198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WD3g722/9K6HoLlGq+HAL5yG10ySSL0HZEPgl3K0gr4=;
        b=vmLdsJ5yTL7VN8Gjj1p8IgtqgaF1Zu9BzIcrtI272puc/gjuk6QX8RsvIyn6IXAq+x
         H5ttL0kcC+alR1OpbsaCnQ4N/YgSPNAUD5p13koxQSEWuXVBvTWGirISTef70XYNzpTD
         EO7dsfNlfntzXiDeEXkWh6JXaCLD1TJANQblQnluKitwOBSSvv8RGg/ah7/ehUe05Tr9
         3y01icDdM+lhELMcRjCd8vvqiG9CUMp5uzyen17utS0p2iQeltru2RX4pWj+ycGAxas4
         j4egVEDKaeP8rn2EVh2VMaQpxNIGj3ee37m0B/mbAj1rCLleWwI57TWWABJZ5PAkGRy1
         AYGA==
X-Gm-Message-State: AFq9FYLT/XDjS7sAO2Gi9EGCS4RFIPu5Vb+HWYDXeDSaHkkPNDmjDTQG
	PX2Z/jBL6uM5APnxcIxUw5N1gLsDd5STOES7LysI6GfOWq17otkYn9w3NJ5NLw==
X-Gm-Gg: AYBFou3RFbWoOgdWNel24B/mEm03Ly0PoHq2hx8iOzW7x2u7HxaMsegCsN1z+y3aDCY
	EBoWU0vlqoBGMjNGNH75Rl99Qk0/rEUyMLcHgMXLivOwTvXJnp4JD0ygh6tt+OgYRUGFNyFXg8O
	JUsFWHSb/0LaxGly+vq1qxkdZay/WX/DMhmOhAaUQaP3cJpUbQkS3kL6w6lW5UamlZGhGi97OkI
	eq6KY2JwRuNxdj+tlNvSEz6w7XdhDqljA6zhG2QVpSrWYTiO9ZhGj8MvAp5UsNdMrTPnmBcQa6p
	CoP/MHxng7gn0/YPlD/Ivr+U5mJVI8genkdMXscwe2yuJj8rnwA1yEmyiNagKdol6BIRgU4gEc6
	40tsvpTr5dmXKTKMsWqRUJKvuNPC4ippD9rlDTbyjW7jfoTnnFK3aSnG6AlrIEQw6wWUlZ7Z73k
	evEAw/ywsfuy1rLtz0aAdpnxNtPYPIy6cPSC0hKGz0934fRgCaj9MAr5LHzR/5P6emYOkAl86I/
	dc49SHqERbd1KIqWz/S2lHJMJwpeBuHgYxE9YQZGBDIbtXQi7fVzz/QxekwHJBAi2Nkmihh3Sax
	d5aVlVc13H2q9tLV8XsUOFFwui63O9DFdBnMmk1J1Eg=
X-Received: by 2002:a05:6a00:3e24:b0:893:12e5:c07c with SMTP id d2e1a72fcca58-8a04be4225cmr2890891b3a.27.1792285398243;
        Sat, 17 Oct 2026 18:03:18 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f579464besm2653047b3a.34.2026.10.17.18.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 18:03:17 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 5/5] selftests/bpf: Add a C++ prog with exceptions
Date: Sun, 18 Oct 2026 01:02:45 +0000
Message-ID: <20261018010246.1643877-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>
References: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>
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

The test is skipped when llvm doesn't lower unwinding [1]. It looks for BTF
decl_tag "unwind" in the object, since the version of llvm doesn't tell.

[1] https://github.com/llvm/llvm-project/pull/233140

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile.skel     |  11 ++
 .../selftests/bpf/prog_tests/unwind_cxx.c     |  76 ++++++++++++
 .../selftests/bpf/progs/unwind_cxx.cpp        | 117 ++++++++++++++++++
 3 files changed, 204 insertions(+)
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
index 000000000000..6a189045851f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+/*
+ * llvm tags the functions that say in r3 whether they return or unwind.
+ * Without that _Unwind_RaiseException() is an unknown extern and libbpf doesn't
+ * open the object, so look before that.
+ */
+static bool llvm_lowers_unwinding(const char *file)
+{
+	struct btf *btf = btf__parse(file, NULL);
+	int i, n = btf ? btf__type_cnt(btf) : 0;
+	bool ret = false;
+
+	for (i = 1; i < n && !ret; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+
+		ret = btf_is_decl_tag(t) &&
+		      !strcmp(btf__name_by_offset(btf, t->name_off), "unwind");
+	}
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
+#if defined(__x86_64__) || defined(__aarch64__)
+	const char *file = "./unwind_cxx.bpf.o";
+	struct bpf_object *obj;
+
+	/* gcc flavor doesn't build it */
+	if (access(file, R_OK) || !llvm_lowers_unwinding(file) || !is_jit_enabled()) {
+		test__skip();
+		return;
+	}
+	obj = bpf_object__open_file(file, NULL);
+	if (!ASSERT_OK_PTR(obj, "open"))
+		return;
+	if (!ASSERT_OK(bpf_object__load(obj), "load"))
+		goto out;
+	/* libbpf goes on without BTF when the kernel doesn't take it */
+	ASSERT_GE(bpf_object__btf_fd(obj), 0, "btf_fd");
+
+	/* inner's destructor, then middle's */
+	run(obj, "catches", 64, 65, 12);
+	run(obj, "catches", 200, 42, 12);
+	run(obj, "does_not_catch", 64, 65, 12);
+	run(obj, "does_not_catch", 200, 0, 12);
+out:
+	bpf_object__close(obj);
+#else
+	test__skip();
+#endif
+}
diff --git a/tools/testing/selftests/bpf/progs/unwind_cxx.cpp b/tools/testing/selftests/bpf/progs/unwind_cxx.cpp
new file mode 100644
index 000000000000..fa9ddd87319d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/unwind_cxx.cpp
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * C++ exceptions. llvm lowers unwinding to plain insns:
+ *   ret                      r3 = 0; exit
+ *   invoke foo unwind pad    call foo; if r3 != 0 goto pad
+ *   resume                   r0 = 0; r3 = 1; exit
+ * so 'throw' is a jump or an exit, 'catch (...)' and the destructors that run on
+ * the way are ordinary blocks reached by ordinary branches.
+ *
+ * vmlinux.h and bpf_helpers.h are not C++.
+ */
+#define SEC(name) __attribute__((section(name), used))
+#define __ksym __attribute__((section(".ksyms")))
+#define __noinline __attribute__((noinline))
+#define __always_inline inline __attribute__((always_inline))
+
+#if __clang_major__ >= 24
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
+	__builtin_trap();
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

