Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15221A6830;
	Tue,  2 Jun 2026 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366541; cv=none; b=GTNCuiyJ3PInj3rJiXjRr7cyzMAVEwLaRtSWHXZ5h3xrwmKht6unB0GN4EbN1rY1DkkB6FIvrrmys28kLx0F8lRk3cR0M6dMb11LIc6QH/E9pLVxd9BXdR8RWkvaFy+/w4lRH7TpmqQzvu77vKV3YYweV6g213RtThUp0v4v1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366541; c=relaxed/simple;
	bh=NBWptHo+Hzm3bev1l+Fo4YZzvE0YvimRgtFKI10yh8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SF/hhtYXZlxzsrRSjuVr4l5oJxpXNLhOr4c9vUItqCNo0k8mVJOWGG8EuhsIUBVUl9TSl2hZ0rXCUEsHD732dmLZRnysR7HKA3x6OZasfio3+g5g1aYRtb2ePHliPaIURjImHGyY/Hp63v66dRWQNHlsoRe//ElaF7Bu733wnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ef814d905e2811f1aa26b74ffac11d73-20260602
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f6a32988-e2cc-4cfa-a2de-962875ae84d2,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:f6a32988-e2cc-4cfa-a2de-962875ae84d2,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:c95bfc276c48dd31b85d258e133a9ac0,BulkI
	D:26060210153497GLZCF1,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|136
	|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bul
	k:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ef814d905e2811f1aa26b74ffac11d73-20260602
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 735991183; Tue, 02 Jun 2026 10:15:33 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] LoongArch: bpf: Support kptr xchg inline
Date: Tue,  2 Jun 2026 10:15:15 +0800
Message-Id: <20260602021515.214560-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The BPF verifier can lower a bpf_kptr_xchg() call into a single BPF_XCHG
atomic instruction when the JIT advertises support through
bpf_jit_supports_ptr_xchg(). This drops the helper call overhead from the
kptr exchange fast path.

Such inlining is only safe when the JITed atomic exchange provides the
same full memory ordering as the bpf_kptr_xchg() helper. On LoongArch the
plain amswap.d instruction carries no barrier semantics, so emit the
ordered amswap_db.d variant for 64-bit BPF_XCHG instead. Add the
amswapdbw/amswapdbd instruction emit helpers it relies on, and implement
bpf_jit_supports_ptr_xchg() to turn the inlining on.

Extend the kptr_xchg_inline selftest to cover LoongArch64, and add a
kptr-xchg benchmark to compare the helper and inline paths.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
1.
 test steps are as follows:
 cd /root/zcg/linux/tools/testing/selftests/bpf
 make bench VMLINUX_BTF=/root/zcg/linux/vmlinux -j4
 ./bench -d 30 -w 5 -p 1 kptr-xchg --nr_loops 256
 
 test results before applying the patch:
    ./bench -d 30 -w 5 -p 1 kptr-xchg --nr_loops 256
    Summary: throughput   68.612 ± 0.249 M ops/s ( 68.612M ops/prod), latency   14.575 ns/op
 
 test results after applying the patch:
    ./bench -d 30 -w 5 -p 1 kptr-xchg --nr_loops 256
    Summary: throughput   82.983 ± 0.268 M ops/s ( 82.983M ops/prod), latency   12.051 ns/op
 
 Throughput increased by 21%

2.
 When running the test, the following command can verify that
 bpf_kptr_xchg gets inlined after applying the patch, eliminating
 the overhead of invoking the helper function on every execution.
 
 bpftool prog show | grep -A4 -B1 'name benchmark'
 	xlated 64B  jited 196B  memlock 16384B
    46: tracing  name benchmark  tag a9c8498a6197e8db  gpl
 	loaded_at 2026-05-29T16:29:47+0800  uid 0
 	xlated 232B  jited 380B  memlock 16384B  map_ids 8,10,9

 bpftool prog dump xlated id 46 | grep -A6 -B6 -E 'xchg|atomic|call'
 
 Before patch:
  ; __sync_add_and_fetch(&hits, i);
    13: (18) r2 = map[id:10][0]+0
    15: (db) lock *(u64 *)(r2 +0) += r1
  ; return 0;
    16: (b4) w0 = 0
    17: (95) exit
  ; old = bpf_kptr_xchg(&ptr, NULL);
    18: (18) r1 = map[id:9][0]+0
    20: (b7) r2 = 0
    21: (85) call bpf_kptr_xchg#244684 ------ there call helper function
  ; if (old)
    22: (15) if r0 == 0x0 goto pc-16
  ; bpf_obj_drop(old);
    23: (bf) r1 = r0
    24: (18) r2 = 0x0
    26: (85) call 0x900000000046760c#92204
    27: (05) goto pc-21
 
 After patch:
  ; __sync_add_and_fetch(&hits, i);
   13: (18) r2 = map[id:10][0]+0
   15: (db) lock *(u64 *)(r2 +0) += r1
 ; return 0;
   16: (b4) w0 = 0
   17: (95) exit
 ; old = bpf_kptr_xchg(&ptr, NULL);
   18: (18) r1 = map[id:9][0]+0
   20: (b7) r2 = 0
   21: (bf) r0 = r2
   22: (db) r0 = atomic64_xchg((u64 *)(r1 +0), r0) ---- there inlining 'kptr xchg'
 ; if (old)
   23: (15) if r0 == 0x0 goto pc-17
 ; bpf_obj_drop(old);
   24: (bf) r1 = r0
   25: (18) r2 = 0x0
   27: (85) call 0x900000000046760e#92206
   28: (05) goto pc-22
---
 arch/loongarch/include/asm/inst.h             |  2 +
 arch/loongarch/net/bpf_jit.c                  |  7 +-
 tools/testing/selftests/bpf/Makefile          |  2 +
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../selftests/bpf/benchs/bench_kptr_xchg.c    | 96 +++++++++++++++++++
 .../bpf/prog_tests/kptr_xchg_inline.c         |  3 +-
 .../selftests/bpf/progs/kptr_xchg_bench.c     | 48 ++++++++++
 7 files changed, 158 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_xchg_bench.c

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 76b723590023..636cfc524b02 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -783,6 +783,8 @@ DEF_EMIT_REG3_FORMAT(amswapb, amswapb_op)
 DEF_EMIT_REG3_FORMAT(amswaph, amswaph_op)
 DEF_EMIT_REG3_FORMAT(amswapw, amswapw_op)
 DEF_EMIT_REG3_FORMAT(amswapd, amswapd_op)
+DEF_EMIT_REG3_FORMAT(amswapdbw, amswapdbw_op)
+DEF_EMIT_REG3_FORMAT(amswapdbd, amswapdbd_op)
 
 #define DEF_EMIT_REG3SA2_FORMAT(NAME, OP)				\
 static inline void emit_##NAME(union loongarch_instruction *insn,	\
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 24913dc7f4e8..b2bc54b4ca87 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -486,7 +486,7 @@ static int emit_atomic_rmw(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			emit_zext_32(ctx, src, true);
 			break;
 		case BPF_DW:
-			emit_insn(ctx, amswapd, src, t1, t3);
+			emit_insn(ctx, amswapdbd, src, t1, t3);
 			break;
 		}
 		break;
@@ -2362,6 +2362,11 @@ bool bpf_jit_supports_fsession(void)
 	return true;
 }
 
+bool bpf_jit_supports_ptr_xchg(void)
+{
+	return true;
+}
+
 /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool bpf_jit_supports_subprog_tailcalls(void)
 {
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6ef6872adbc3..ea4c22e20f3c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -866,6 +866,7 @@ $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
 $(OUTPUT)/bench_bpf_crypto.o: $(OUTPUT)/crypto_bench.skel.h
 $(OUTPUT)/bench_sockmap.o: $(OUTPUT)/bench_sockmap_prog.skel.h
 $(OUTPUT)/bench_lpm_trie_map.o: $(OUTPUT)/lpm_trie_bench.skel.h $(OUTPUT)/lpm_trie_map.skel.h
+$(OUTPUT)/bench_kptr_xchg.o: $(OUTPUT)/kptr_xchg_bench.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -888,6 +889,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_bpf_crypto.o \
 		 $(OUTPUT)/bench_sockmap.o \
 		 $(OUTPUT)/bench_lpm_trie_map.o \
+		 $(OUTPUT)/bench_kptr_xchg.o \
 		 $(OUTPUT)/usdt_1.o \
 		 $(OUTPUT)/usdt_2.o \
 		 #
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 029b3e21f438..2b6dd8aec282 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -575,6 +575,7 @@ extern const struct bench bench_lpm_trie_insert;
 extern const struct bench bench_lpm_trie_update;
 extern const struct bench bench_lpm_trie_delete;
 extern const struct bench bench_lpm_trie_free;
+extern const struct bench bench_kptr_xchg;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -653,6 +654,7 @@ static const struct bench *benchs[] = {
 	&bench_lpm_trie_update,
 	&bench_lpm_trie_delete,
 	&bench_lpm_trie_free,
+	&bench_kptr_xchg,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c b/tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c
new file mode 100644
index 000000000000..b8a0d346fda6
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026. Loongson Technology Corporation Limited */
+#include <argp.h>
+#include "bench.h"
+#include "kptr_xchg_bench.skel.h"
+
+static struct ctx {
+	struct kptr_xchg_bench *skel;
+} ctx;
+
+static struct {
+	__u32 nr_loops;
+} args = {
+	.nr_loops = 256,
+};
+
+enum {
+	ARG_NR_LOOPS = 7000,
+};
+
+static const struct argp_option opts[] = {
+	{ "nr_loops", ARG_NR_LOOPS, "nr_loops", 0,
+	  "Set number of bpf_kptr_xchg() calls per trigger"},
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case ARG_NR_LOOPS:
+		args.nr_loops = strtol(arg, NULL, 10);
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static const struct argp bench_kptr_xchg_argp = {
+	.options = opts,
+	.parser = parse_arg,
+};
+
+static void validate(void)
+{
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "benchmark doesn't support consumer!\n");
+		exit(1);
+	}
+}
+
+static void *producer(void *input)
+{
+	while (true)
+		syscall(__NR_getpgid);
+
+	return NULL;
+}
+
+static void measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&ctx.skel->bss->hits, 0);
+}
+
+static void setup(void)
+{
+	struct bpf_link *link;
+
+	setup_libbpf();
+
+	ctx.skel = kptr_xchg_bench__open_and_load();
+	if (!ctx.skel) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	ctx.skel->data->nr_loops = args.nr_loops;
+
+	link = bpf_program__attach(ctx.skel->progs.benchmark);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
+const struct bench bench_kptr_xchg = {
+	.name = "kptr-xchg",
+	.argp = &bench_kptr_xchg_argp,
+	.validate = validate,
+	.setup = setup,
+	.producer_thread = producer,
+	.measure = measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c b/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
index 7def158da9eb..8f7b58727416 100644
--- a/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
+++ b/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
@@ -14,7 +14,8 @@ void test_kptr_xchg_inline(void)
 	int err;
 
 #if !(defined(__x86_64__) || defined(__aarch64__) || \
-      (defined(__riscv) && __riscv_xlen == 64))
+      (defined(__riscv) && __riscv_xlen == 64) || \
+      (defined(__loongarch__) && __loongarch_grlen == 64))
 	test__skip();
 	return;
 #endif
diff --git a/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c b/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c
new file mode 100644
index 000000000000..ff146e4dcde7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2026. Loongson Technology Corporation Limited */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define MAX_XCHG_LOOPS 4096
+
+struct bin_data {
+	char blob[32];
+};
+
+#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
+
+private(kptr) struct bin_data __kptr *ptr;
+u32 nr_loops = 256;
+long hits;
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int benchmark(void *ctx)
+{
+	struct bin_data *old;
+	u32 i;
+
+	for (i = 0; i < MAX_XCHG_LOOPS; i++) {
+		if (i >= nr_loops)
+			break;
+
+		old = bpf_kptr_xchg(&ptr, NULL);
+		if (old)
+			bpf_obj_drop(old);
+	}
+
+	__sync_add_and_fetch(&hits, i);
+	return 0;
+}
+
+/* BTF FUNC records are not generated for kfuncs referenced only through
+ * optimized paths. Keep bpf_obj_drop() visible to libbpf's kfunc linker.
+ */
+void __btf_root(void)
+{
+	bpf_obj_drop(NULL);
+}
-- 
2.25.1

