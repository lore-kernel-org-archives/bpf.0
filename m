Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755486;
	b=Fz0t2lx/rLxxXycDSoNfdN7lqFhszzuKtQxwLawphG6lB88PP/OWwaCuFb+bXtoLOfOv
	 ncMl5xFa6mN2ypl9z1/XIJhzb1kEpf5W+EOsCnCDMdUcXBvKYqMdRqmrKRzdA/u7Nc7sg
	 kNjoLoY9vXZ05EiyIV6NH7s0vtrISiD1F8INN7Apu7QJfLoSGVy8mNj6x5bHE7m++ZdoO
	 /d7qyq18L1UXwf69ZiQnAoiBL903cJmORCSRcMKoM8Wy6dZwQtawXujALsxpv9UMAz8CF
	 5158rhseNnSu6g09DXyOmTglavv9AEcuC3B2GYXPbXQAtpZeGf8LHJk0GEXBuw6puYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t68Aog5ohonTlOBSW18O5/IXMuuB6DC8HahbyJ8qbEc=;
	b=cacERr03OmA+URCRJ/8lnSrPep7CP8EDAMQHICujfhdQxqaWlUxBTN/pshopcpB+xdKW
	 lT+OwSSuR1q/zCMSV/huk0w/NN+QlL9K8hC2Tbm2PWOB8O15GeLpqs8O6NgziytsDLv9E
	 7Rsl4K/Yw8CE426cyY+1jQEggQgeK/TjaCmPMdCxo1TT+Rir7AUIujFq2gQAUHZ1L7ZlP
	 N0df+2t8abYvq+Zv/bMfvOX7IQ8JpOolK1wJ9xv0UWURPdqIomubdhorJ6hENymp5hAKg
	 mdAmuyjWNsviqhmTHCcCWLxZguOaaPArGt0hHn7UnKPc0djMTJpveS1y0liFhoA5+iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MCIWLhLf;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA40606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDA40606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MCIWLhLf
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso125582a12.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755485; x=1794360285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t68Aog5ohonTlOBSW18O5/IXMuuB6DC8HahbyJ8qbEc=;
        b=MCIWLhLf/Ylw/d7+PRJHu2M9wV6+SoTuRz99kxrl9BYMwWnU9e2pZimz/6kSaJe7gL
         BZ5VCJtRHztRyTVDVHgIkV+Ka9OsT5jSK/+l0TtrQosPLeXs52FlsfNBFLiFCjJ9uOkL
         wq6VjfE1B8ULsNsw/Ytz4YUVyhgp+HM0Uyfl4tS6E5Jnn9ePSmwB3Crum9wa/joYKKSk
         PVkdxssKNMVlL4C78SFWUW3BGz8uTot7VkqwqCPpsPMF8B0xzZu+0wS3upIBmQCs2UHY
         5oLlT8UIJ0M1ksQjqwnE8uMife/XC4DiTjKfAaGekutb7CJzCK3IiiznNekC0CRTJI1p
         aJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755485; x=1794360285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t68Aog5ohonTlOBSW18O5/IXMuuB6DC8HahbyJ8qbEc=;
        b=DWoGHlVpDR08hdtxESMbMZi2WVZLDojB1eUG/pRU+4+p0Eeu3q7g8gpvc9maBnYtWR
         1rX8Yjm9/r/WJhadaLIvSbpBWFb2jNgb0E96ircVFcjo7NyNq2RaALSSlX8RAvnTwxz1
         x9u+5hTVI5g5pALXaUTN9LiNpkf94Ws4CCXvMGX1dkPbFRLcnySH/PKDwf12SyMZaEot
         pbF1TLCXTloi97a5+Q39rreJq+1wJqS/gPDWHh/SJjSTLch/b2TOgFI931qurMZ1u78F
         1Km+1AX2r5iUU4tTx9C2snAVgD9m1hVKbcDojSLAztd83TduqiQGMvFOZgHoDUwYki39
         ex9w==
X-Gm-Message-State: APuU4Z/UMgnnjJmsg1JEqNulF8OKr2ZFIyALEZU3WUY4BJIVfMq0Kgv2
	ltdL6nQxcRK4/O96tBkv7uzi3XWw8bLcP5NbNUhyDyzwWlGH4JRk3hnElAmN/w==
X-Gm-Gg: AYBFou15+ai/CKVl7iRLIZt1aD0BTyS9UZVYw13memeKN/pTZaqkCCtibR4/9o34KrA
	V0lsKiH3jXfBDXB8mlw12oOc8oQfGtBKRy5tfs716Zk4HWrUAcN+Wzu1Vv6a99qSUX2ZvKuO50/
	JYJeJT/I4C2568KhC+mLX+DyzCeK8hXRWNyFmy88w0OZSmmMGVsPIXJzgvSkrtijW/f0KQuo/7d
	gEVDDwhgosJQMAFWXL4AM96onhhCQ+rBabg7HR7eFp2ABkjU+D+EVNAEaqywcaHANWjyjNXKzJr
	qJ1fVTA8wY2r3FEyox5hqCyts3DYyxTZDQ6+7o9Q0z94CR58iTN5fnUvVxIy/sMlw2nmFTLDaHG
	Ziva2EZ5ZJgef15zztfqvQP9ZoTSBs5xEi3I74UTCarvGaiH3qAASU0Vz6pMqeXJsxvOErHu0zr
	8rQ7TZpM5K0bQPxdtH5503oX851l5OjEtc4hql+tKUItCRzYPoNy79yp3qJieib3vFBghbCyGyw
	U3O/ALnIgEZBfm04wyZ+kPwdlKi/ukW7NtOtGTu0AF4cjSrOgKaxIwin987K0HWNXqVfD6v4T9I
	cY+dhvnbf6hzFWaidtZe5Nj+jQtEgFQaEz7edrq67OSaPgDjbo70G8f3rRaSD4VXd3OfuCGe1/D
	XIVM/N2JurTzLFgSW7D3DO3vo5S2hNatp3yriCMdJlvEM0TL1Ks+CglXbPykLBhCrBFadiTZaef
	xPTDXQfCyQTcDj8ixPKFE=
X-Received: by 2002:a17:90b:2252:b0:3a7:8c68:6446 with SMTP id 98e67ed59e1d1-3ae8987d10amr12605381a91.63.1793755485002;
        Tue, 03 Nov 2026 17:24:45 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09311866fsm1455755a91.17.2026.11.03.17.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:24:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 07/14] selftests/bpf: Test pointers in arena and .bss.addr_space.1
Date: Wed,  4 Nov 2026 01:23:53 +0000
Message-ID: <20261104012401.1354861-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
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
file must be smaller than these variables. The size of .addr_space.1 is not
a multiple of the alignment, thus libbpf must align the second section.

A second object has a pointer in arena to a variable that is not in arena.
The open of this object must fail.

The test is serial, as the other tests in prog_tests/arena_*.c. See commit
a14f9ba080c1 ("selftests/bpf: Run arena tests serially").

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/Makefile.skel     |   3 +-
 .../bpf/prog_tests/arena_data_ptrs.c          |  70 +++++++++
 .../selftests/bpf/progs/arena_data_ptrs.c     | 138 ++++++++++++++++++
 .../bpf/progs/arena_data_ptrs_fail.c          |  25 ++++
 4 files changed, 235 insertions(+), 1 deletion(-)
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
index 000000000000..a01c712ff3d0
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
+void serial_test_arena_data_ptrs(void)
+{
+	if (test__start_subtest("ptrs_and_bss"))
+		test_ptrs_and_bss();
+	if (test__start_subtest("ptr_to_not_arena"))
+		test_ptr_to_not_arena();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_data_ptrs.c b/tools/testing/selftests/bpf/progs/arena_data_ptrs.c
new file mode 100644
index 000000000000..bf3048ab2d7a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_data_ptrs.c
@@ -0,0 +1,138 @@
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
+/* the size of .addr_space.1 is not a multiple of the alignment of .bss.addr_space.1 */
+char __arena odd = 1;
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

