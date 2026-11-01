Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502355;
	b=Q4RN8ZnT4ZBB3r+G+/kqxwpi9nnhH0vtlC+E1RMAqRkzkxCFaqC9LdrVs7+xGf9nLu32
	 gzhCsRu8TwcHj35V5B7G4ukSIBQ5nVvkckwQYLkWXmJvFAx1PirZJfGzi9bLwOyi5fW/Z
	 c3f4KH5YW/EsNwhMI7jGyluJCU2Dl7rMzEaNgzVYh3fNRsIqIcGSKnYYjlf8TyiPfaP0q
	 /or4YAbb6XbPPkWP+9N4eTaExJCHP88rrvaxioaFrUXvc+/te5n235ppmf8qVvsbjCc9R
	 scAWvyvfB5bE63qMXx5OYepGUUdbNt9jySZJogwGXwAFLLhhPOvzm9DQiHZBTItnMWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yS47cYMGxHUT4HugbU9YNQZ4btzuRGBRfWoE4TfcrPw=;
	b=dZTaWC3BHo5874tYoQ6W9k93rsvHWowVv6aIlmCM33xFjJnfbXExN0/1X6SkWomdSQVW
	 3h86D7FtmVdWHsiCYAybp7BaUEELN92HhMb/TktYZh1RQVrQtS6yw1xgJ8FufgUJ5ESPM
	 eI0d0KBFsoVJPcjEz9l2DuQ2TTthld+XxCZNJxrevdbS/+29isRKxkDhK+HFFUi/biAIO
	 kyS1zOIe1by8OfW9dATvodmd5rLXv12pGe2y3fPG2UkVcYjsSQAYg9mvGp0Pb1YOUExHO
	 UqKvC56bc73DHjxOQnxqL+tIFX5fo2Xfr2OVdSa3biQjJ6P2v+BD7I5Dk4JSIQSqMkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="n0/CBdVl";
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D6606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E3D6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n0/CBdVl
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1564375a91.3
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502354; x=1794107154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yS47cYMGxHUT4HugbU9YNQZ4btzuRGBRfWoE4TfcrPw=;
        b=n0/CBdVlWeEnJSesXUIkGgwnnSAOIP7Vxb0YATpzDbk8n1vxnYnsZnPjqQ9J8W116I
         Gqiwwb+0ugyDHZAUEoCbBZB4D+yE08z9Ws8CqcXkLkJes3OJSPST5lxJKMH6D/YvDTJV
         kSw4SU0iOx/BGDzfSJWHkBIlQMOlIDFhmJb+wbWKPunnHEH5ASXVkv+E6tOBX2QsUhWu
         OryWKkv8+iPDDznuo+2wwsbNFHe3hRC985fUdis0MV6oTu29cE3QFFOPhE2PZJE5pGh0
         qEHaT2ew+FNK5sY3YARlJE9brkyStS7t/tsskWBHXW2QHi9E3JpXBDZTyqkkl/Wd3Yxm
         lATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502354; x=1794107154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yS47cYMGxHUT4HugbU9YNQZ4btzuRGBRfWoE4TfcrPw=;
        b=HqYblgIQ7JSCk9jZ/pVDJ8RGc010ZLKQBIDXERZt124wAeGGWdp+Har+VQ5FjOgBw3
         yJdgtqoEr+TfvbgpeiqWUpg7QWjKLsDqN4txeGrPkL8a61CrIKr1JcsWtyGC/azSAfnK
         YMEutORd2JMlXb3rdEr09NUM4l6aEd3DQXi/SOmiLX47aGEiL+sKTez6t74AUwVsWS5K
         KTaayVEG8rhymY7s4agHmsScUsiEEFqhVC+FQGNaXvgeDILLtHglfreXdioUdp78IKht
         F9CcZ1KbfFSUjMDjb+5zhj/fTctIGS2yA1C3n4UIbq2YeAkXq1H3PuiCcpK91OR4H1Xm
         gMfQ==
X-Gm-Message-State: APuU4Z9mNggwTLePS+0EiqzV+gzu8qfptKG20hkb7b27xuVzh55lCMvb
	9NCp7nnt7ckYviCA4kHUudQrSP3vk+cbxGVHvkL7/XAU70s7TOjMV2Ke2O2vng==
X-Gm-Gg: AYBFou085rpdhoQluHo+I2Flq0ne6qV1ty9lyrEHto//I75Mwvzl2djzds5J2dpKFD1
	5oXzQRWwjiWU0F+MktQ+ENVWFzhtpQ15+6Wbc+qGPd0YcOdRlHrm6bI+oUc4r99FCpctZ/w3uUL
	LyCzmcWEHh7v8CKfHQJsNZhgipM2x2LEwd4P8U2bbHIWEJWDgV3xJ7G9dKQ282e3PlySSpKS7JO
	l3K8ZE6bDwMh/KUlhxiN2kNJYaTuO7xDtLEvt5eOnM5sMGfq0mwaq6cSkJUQneVJFkbDP3Edn8e
	XztdGayHdqpD6aGt6J/I6xRKiP8NkBvHrAw4Edu9iqDRK7XAi6ZDIaS9auIFuDqN/FJnCqAVjpR
	2mvRAkiDCOkSusUWy8OD8lu+VfO3TfoDBIpiuCb54100lulj3bQLWBnUI8l6TcJbBcB759QOYj/
	KV05VIJ41ooTHl1R2ana/NVmqy91D6nP2h6Jpr5vSAuHbeXoylbVELD7d23Peda1GLkuSlmGyF4
	/aWJk0hOL/jqRt9z+H8KbJDDpXv6dHuXYRwtM9AtEH9ZG8WB4qYpjz1LXM2lTfqIMNhKHn5uwyE
	K1ZG0VpTuOZsMPcUvju6+mB5nG30N0tgqIYpdsIyDJ84Vz2GSGA/v8QRRUu0kUmfvDvMfKeERA/
	2C+1N10Fp5btEnsAhFnqNqCtE8wkrK2obKJ8QX5wmbzTDqVSXikjSD5uZdQTppFGqiIdBbEwbjQ
	==
X-Received: by 2002:a17:90b:2f8f:b0:3ab:b39f:41b9 with SMTP id 98e67ed59e1d1-3ae897f8c61mr5289433a91.61.1793502354239;
        Sat, 31 Oct 2026 20:05:54 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85f662basm4263066a91.1.2026.10.31.20.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:05:53 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 07/14] selftests/bpf: Test pointers in arena and .bss.addr_space.1
Date: Sun,  1 Nov 2026 03:05:03 +0000
Message-ID: <20261101030511.1578690-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
References: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
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

The initial values of variables in arena point to other variables in arena:

  pointer       points to
  ------------  -------------------------------------------
  px            an int
  parr          the third element of an array
  head, next    the elements of a list
  pbig          an element of an array in .bss.addr_space.1
  psx           a static int
  psbig         an element of a static array in .bss.addr_space.1

The prog and user space must see the same pointers:
 - The prog follows each pointer and examines the value that it finds.
 - User space compares px, parr, head and next with the addresses in the
   skeleton.
 - User space reads through pbig, psx and psbig the values that the prog
   stored there. Static variables are not in the skeleton.

The selftests link each object with the static linker. Thus the object with
psx and psbig does not build without the change in linker.c.

The variables in .bss.addr_space.1 must be zero and aligned, and the object
file must be smaller than these variables.

A second object has a pointer in arena to a variable that is not in arena.
The open of this object must fail.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile.skel     |   3 +-
 .../bpf/prog_tests/arena_data_ptrs.c          |  70 +++++++++
 .../selftests/bpf/progs/arena_data_ptrs.c     | 135 ++++++++++++++++++
 .../bpf/progs/arena_data_ptrs_fail.c          |  25 ++++
 4 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_data_ptrs.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_data_ptrs.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_data_ptrs_fail.c

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
index e8699903feef..b8eaecc7f429 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -20,7 +20,8 @@ ifneq ($(BPF_CC),)
 BPF_SRCS := $(notdir $(wildcard progs/*.c))
 BPF_OBJS := $(patsubst %.c,$(RDIR)/%.bpf.o,$(BPF_SRCS))
 
-SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
+SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c	\
+		  arena_data_ptrs_fail.c
 
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h linked_arena.skel.h \
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_data_ptrs.c b/tools/testing/selftests/bpf/prog_tests/arena_data_ptrs.c
new file mode 100644
index 000000000000..aeeb6c0cd102
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_data_ptrs.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+struct elem {
+	struct elem *next;
+	int val;
+};
+
+#include "arena_data_ptrs.skel.h"
+
+static int run_prog(struct bpf_program *prog)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(prog), &opts), "run"))
+		return -1;
+	return opts.retval;
+}
+
+static void test_ptrs_and_bss(void)
+{
+	struct arena_data_ptrs *skel;
+	size_t elf_sz;
+
+	skel = arena_data_ptrs__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	ASSERT_OK(run_prog(skel->progs.use_ptrs), "use_ptrs");
+	if (skel->bss->skip) {
+		printf("%s:SKIP:compiler doesn't support arena_cast\n", __func__);
+		test__skip();
+		goto out;
+	}
+	ASSERT_OK(run_prog(skel->progs.use_bss), "use_bss");
+
+	/* addresses are the same in user space */
+	ASSERT_EQ((void *)skel->arena->px, (void *)&skel->arena->x, "px");
+	ASSERT_EQ((void *)skel->arena->parr, (void *)&skel->arena->arr[2], "parr");
+	ASSERT_EQ((void *)skel->arena->head, (void *)&skel->arena->n1, "head");
+	ASSERT_EQ((void *)skel->arena->n1.next, (void *)&skel->arena->n2, "n1.next");
+	ASSERT_EQ(*(long *)skel->arena->pbig, 7, "*pbig");
+	/* static variables are not in the skeleton */
+	ASSERT_EQ(*(int *)skel->arena->psx, 45, "*psx");
+	ASSERT_EQ(*(long *)skel->arena->psbig, 9, "*psbig");
+
+	/* 'big' is not in the file */
+	arena_data_ptrs__elf_bytes(&elf_sz);
+	ASSERT_LT(elf_sz, 8192 * sizeof(long), "elf_sz");
+out:
+	arena_data_ptrs__destroy(skel);
+}
+
+static void test_ptr_to_not_arena(void)
+{
+	struct bpf_object *obj;
+
+	obj = bpf_object__open_file("./arena_data_ptrs_fail.bpf.o", NULL);
+	if (!ASSERT_ERR_PTR(obj, "open"))
+		bpf_object__close(obj);
+}
+
+void test_arena_data_ptrs(void)
+{
+	if (test__start_subtest("ptrs_and_bss"))
+		test_ptrs_and_bss();
+	if (test__start_subtest("ptr_to_not_arena"))
+		test_ptr_to_not_arena();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_data_ptrs.c b/tools/testing/selftests/bpf/progs/arena_data_ptrs.c
new file mode 100644
index 000000000000..4af059a98236
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_data_ptrs.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 64);
+} arena SEC(".maps");
+
+bool skip;
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+
+struct elem {
+	struct elem __arena *next;
+	int val;
+};
+
+int __arena x = 42;
+int __arena arr[4] = { 1, 2, 3, 4 };
+struct elem __arena n3 = { NULL, 3 };
+struct elem __arena n2 = { &n3, 20 };
+struct elem __arena n1 = { &n2, 100 };
+
+/* variables that are zero and take no space in the file */
+#define __arena_bss __arena SEC(".bss.addr_space.1")
+char __arena_bss one;
+long __arena_bss big[8192];
+char __arena_bss aligned64[64] __attribute__((aligned(64)));
+
+/* a pointer to a static variable is relocated against the section, not against a symbol */
+static int __arena sx = 44;
+static long __arena_bss sbig[16];
+
+/* pointers to variables in arena that are stored in variables in arena */
+int __arena * __arena px = &x;
+int __arena * __arena parr = &arr[2];
+struct elem __arena * __arena head = &n1;
+long __arena * __arena pbig = &big[8000];
+int __arena * __arena psx = &sx;
+long __arena * __arena psbig = &sbig[3];
+
+SEC("syscall")
+int use_ptrs(void *ctx)
+{
+	struct elem __arena *n;
+	int i, sum = 0;
+
+	if (*px != 42)
+		return 1;
+	*px = 43;
+	if (x != 43)
+		return 2;
+	if (parr[0] != 3 || parr[1] != 4)
+		return 3;
+	for (n = head, i = 0; n && i < 10; n = n->next, i++)
+		sum += n->val;
+	if (sum != 123)
+		return 4;
+	if (*psx != 44)
+		return 5;
+	*psx = 45;
+	if (sx != 45)
+		return 6;
+	return 0;
+}
+
+SEC("syscall")
+int use_bss(void *ctx)
+{
+	unsigned long addr = (unsigned long)&aligned64;
+
+	if (one || big[0] || big[8000] || big[8191] || aligned64[63])
+		return 1;
+	*pbig = 7;
+	if (big[8000] != 7 || big[7999] || big[8001])
+		return 2;
+	big[8191] = 8;
+	one = 1;
+	/* variables that are not zero are where they were */
+	if (arr[3] != 4)
+		return 3;
+	/* hide the address from the compiler, it knows that '& 63' is 0 */
+	asm volatile ("" : "+r"(addr));
+	if (addr & 63)
+		return 4;
+	if (sbig[2] || sbig[3] || sbig[4])
+		return 5;
+	*psbig = 9;
+	if (sbig[3] != 9 || sbig[2] || sbig[4])
+		return 6;
+	return 0;
+}
+
+#else
+
+/* The skeleton has to have what user space looks at */
+struct elem {
+	struct elem *next;
+	int val;
+};
+
+int __arena_global x;
+int __arena_global arr[4];
+struct elem __arena_global n2;
+struct elem __arena_global n1;
+int * __arena_global px;
+int * __arena_global parr;
+struct elem * __arena_global head;
+long * __arena_global pbig;
+int * __arena_global psx;
+long * __arena_global psbig;
+
+SEC("syscall")
+int use_ptrs(void *ctx)
+{
+	skip = true;
+	return 0;
+}
+
+SEC("syscall")
+int use_bss(void *ctx)
+{
+	skip = true;
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/arena_data_ptrs_fail.c b/tools/testing/selftests/bpf/progs/arena_data_ptrs_fail.c
new file mode 100644
index 000000000000..93533dea5f71
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_data_ptrs_fail.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+/* the pointer is in arena, what it points to is not */
+int y = 1;
+int *py SEC(".addr_space.1") = &y;
+
+SEC("syscall")
+int prog(void *ctx)
+{
+	return y;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

