Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983716;
	b=UKB+1xdZK3YLQ3vzRlWkRd2zxrqDHxXzc3huY39dT+VVc+cxptwYhXNJGQ2YuVk2IgSX
	 4U/VsPQYzgoj/o9GkFqx/zx12iYeK8MfGCEg6p0m1WrarYXy3De4d9YFjA+e2gEDutzoh
	 TBt8Mft9R90GdPleulJ0jOFQ7AhA3a/y39oQsbs02tZ4veapNN989ao0+BmROVBlsEo8F
	 BsBAzcYYWMHvPfVXhakZYIhj2CzDdQq/oDLqCSmXHrtxKDatKbErHJKUqbeBRZ71Lt8ov
	 RHDgTfQvRe+mYPH8gZGlryR/13KA6Vp426tM9dT3GbScZba4ihFrTDWGAsxT4BeRUvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dnwii9WzAXrDcSgdH/GO7Z2bM6gPURS19zxRp8tZa3k=;
	b=illc7nJZ3B0TROxXMd2YxtHy7gbN1KpVlYKFIHryFU3Knltfyd88zKR0KCTOdt0Qcfq5
	 G5jdYvsWFC/6piVLFgGxHPGKcq7ykdAhay31UqdnkB/a/vMAHhXesSAApmUCvRoG/pJmO
	 yt6JS3Z+AV/9IA3PR3oybfeDjcMCe4SLvuBQAS7ADUAVxf2+RFdobU/QLW4R14pts9EFw
	 hbky9fqci5aAuJI9GA5zjr6NsrTL1rtA95T6RGOQXOslus3TvnVW9ItxKjHySc3Jhf3ch
	 WytGAkZ8WlFPE1cTiflbO9DWJQ1xDmPEp9re66N8r9t21y4XPWD22298j2zdgTnQISA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EpD+wfTo;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE3606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FFE3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EpD+wfTo
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so2326180a91.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983716; x=1793588516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dnwii9WzAXrDcSgdH/GO7Z2bM6gPURS19zxRp8tZa3k=;
        b=EpD+wfTo2nFvVb/eipscjnf323JM0lzGo+bQq2ViUqWaxK6x7wSV4wZYFNMzBWHnzL
         MB093vGMFJv6Ph76lrEtioa/t09bofjznIrfOg6AO15CN8vrCcmIePA6HLM30DPIna2D
         nwVfYn94LHGYMPhX5vcgf+M62nTt6t6gOeeD+prg7dMPCQ2wGKY/U6QO7kQaErXzUjCG
         6JxnJ5aqD85AkBXZVpp4gxJZTFpY7+d8M+CzYVC80rUAza+to7eS252Vlx3Lku5QkzvE
         8w0hYgkkeubFrmkRDeN4GaKC6RT0neKLAA0XNxqeemtLeYYevGO8VEzESnSQF+xbZEhl
         O69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983716; x=1793588516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dnwii9WzAXrDcSgdH/GO7Z2bM6gPURS19zxRp8tZa3k=;
        b=P2fInqrU28Vps6hgbx3pr3oTdSszfSiwoHI6cSQ3P2O6dsr28udRTLohquef3543xJ
         UQV5+ONoJ8LyWWQV85KqIGNK1idLho2pmDCYz0ZC2/Oq05LqRG9IKCBvAlG5Wpqbd8sH
         HdBgddXtiWUvIPgXu6zLAMot4w/djR4JeA1pCz/D/XPsQJY3HU6AnASKxNCJtTJwFpN1
         Rl6+llpp6xt+eCONa6mH/g+E+1Mw/p30XfHtsmhVCUuYsq9aBX/DKwxY05BBzv1I2ZDT
         DUjYbhuN1JnmUG/IcuZ6a1sHe5cQeaxZM8UL+UThI1VnfCbZH8Fl+5+wapYIwP8MdPZY
         fTmQ==
X-Gm-Message-State: AFq9FYKsyan9iQFmCOWXT9QA3lg0f57AEg/IlK5lNX/djofysdQN1Z4i
	FAKWPThxMcpvct2PMQCIcReeC0DMd81Wlzvu1U8qIlFKhZtflovVLKZrTmpbLg==
X-Gm-Gg: AYBFou3L2Ba6mFNH0+X3mBIQYvELMVVxwajP0YreP+hBIYh99YKSB4fx7WFp+JN2pxL
	yFoHdwN5lyn3KBbgxHrtb0+t4PtNokBsCLRuzeeEkOjGSGTyPG1ExKuE/Ylj74+pUsqJJR4YhH6
	T0uA2oduifnNa38YnL3qfetd6NSU60dQHy39IY2UZZILWftAu0ci4qd+B+gkhEgOBPKUkgOLT9R
	M+BADzOAxHKitqia4r0eDFyiCvTq7SvTxBzcX7JahAJ0qctD9WmT4mpk8dkWR9e4c34D6NzuAnD
	3y7269NVN9mgpuQ281LQ086YcC/6OIVIJLH9QLRi1GZJg859v85qnV74pyFBbbzdrjPIEV9Aq1C
	TEzQIPn2rbcWoZf7ZXP5iD77Azdw+ZLKRZFXHEXhQHWP9Q2+aLuokQhMpnIBNFm9WPBSX7ADE0W
	Je5XcB/zYdAUZT1kPtDP9xLMuaKp4AhuUL/ZzIkPm+5qFm+ZkR84m9jo/Z1W5at2Tata3D8hggh
	NswsijFYIEDy6g4HCAUTEWi08aq8q7NJ0fdr+m7YStzvsMNT5lTro/6FfsJUhL21Sj2yXrTNK1s
	HHWUidnUSYqRnAAMHWPsgswrOIYAgOc/GfF5Aa9jJxDxTTLWTjaFl5ZJKecdZdrUEDgGUbuBCFa
	BBmB/zttQelUAa0yyfPisrU9x
X-Received: by 2002:a17:90a:d603:b0:3ad:adfe:5854 with SMTP id 98e67ed59e1d1-3adeae76ff5mr4939030a91.40.1792983715781;
        Sun, 25 Oct 2026 20:01:55 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb82761esm4753769a91.0.2026.10.25.20.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:01:55 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 22/81] selftests/bpf: Test pointers in arena and .bss.addr_space.1
Date: Mon, 26 Oct 2026 02:58:43 +0000
Message-ID: <20261026025943.404450-23-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The prog and user space must see the same pointers:
 - The prog follows each pointer and examines the value that it finds.
 - User space compares px, parr, head and next with the addresses in the
   skeleton.
 - User space reads through pbig the value that the prog stored there.

The variables in .bss.addr_space.1 must be zero and aligned, and the object
file must be smaller than these variables.

A second object has a pointer in arena to a variable that is not in arena.
The open of this object must fail.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile.skel     |   3 +-
 .../bpf/prog_tests/arena_data_ptrs.c          |  67 ++++++++++
 .../selftests/bpf/progs/arena_data_ptrs.c     | 117 ++++++++++++++++++
 .../bpf/progs/arena_data_ptrs_fail.c          |  25 ++++
 4 files changed, 211 insertions(+), 1 deletion(-)
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
index 000000000000..79bc324f0909
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_data_ptrs.c
@@ -0,0 +1,67 @@
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
index 000000000000..76e564b54e49
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_data_ptrs.c
@@ -0,0 +1,117 @@
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
+/* pointers to variables in arena that are stored in variables in arena */
+int __arena * __arena px = &x;
+int __arena * __arena parr = &arr[2];
+struct elem __arena * __arena head = &n1;
+long __arena * __arena pbig = &big[8000];
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

