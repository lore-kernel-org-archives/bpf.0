Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B30370D63;
	Mon, 22 Jun 2026 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119060; cv=none; b=I6950VoZ5sRwe0lZIUee2Tcyo/P++2CV/DTqng7zdFwhkdhycROzlCF/iHzpy8MLShTGy/nweV2ZloNAebgHtencgq7QbIvwmpOMKJ8EhcRfuFu/HKkmiQocbcPOXHKIVLchF6NJo44HHxJJe+xr5OOXS3v/CuL4iQOMWsc9P6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119060; c=relaxed/simple;
	bh=WC825aoE/QYs39iGJwGJPVkqGPyeyDgnTB/voJks2k0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rq0UESIHhGl4ICgxb/Uf/Rvnqsn5jPALDkULhU3EwhhZM9MpNNz6TY55hOczGEYDnoaDUPGOw5c66TEYcOiN9jYFxLQH2pC4Paz9pONgpdUyJ2jgJml5064riL3LiDVpx/2XGxLnWfiGAMsma/RBgILqv9nZUwszLk1ma3Drlvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=none smtp.helo=mailgw.kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mailgw.kylinos.cn
X-UUID: cb8ad3a26e0911f1aa26b74ffac11d73-20260622
Message-ID:<1782119051681935.15048.seg@mailgw.kylinos.cn>
X-Spam-Fingerprint: 0
X-GW-Reason: 11109
X-Content-Feature:
	ica/max.line-size 120
	audit/email.address 1
	dict/adv 1
	dict/drug 1
	dict/game 2
	meta/cnt.alert 1
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9180a7df-694e-48d5-bef4-91724c8e2c55,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:9180a7df-694e-48d5-bef4-91724c8e2c55,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:9197166142425cdb517d5290b4e29a6c,BulkI
	D:260622151259ZE4WMJFI,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cb8ad3a26e0911f1aa26b74ffac11d73-20260622
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 37353235; Mon, 22 Jun 2026 15:12:57 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH v3 4/4] selftests/bpf: Add kptr-xchg benchmark
Date: Mon, 22 Jun 2026 15:12:34 +0800
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260622071234.1410830-1-zhaochenguang@kylinos.cn>
References: <20260622071234.1410830-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a bpf selftest benchmark that exercises bpf_kptr_xchg() in a tight loop
so helper vs inlined JIT paths can be compared on supported architectures.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 tools/testing/selftests/bpf/Makefile          |  2 +
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../selftests/bpf/benchs/bench_kptr_xchg.c    | 96 +++++++++++++++++++
 .../selftests/bpf/progs/kptr_xchg_bench.c     | 49 ++++++++++
 4 files changed, 149 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_xchg_bench.c

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
diff --git a/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c b/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c
new file mode 100644
index 000000000000..363883073e2c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c
@@ -0,0 +1,49 @@
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
+/*
+ * BTF FUNC records are not generated for kfuncs referenced only through
+ * optimized paths. Keep bpf_obj_drop() visible to libbpf's kfunc linker.
+ */
+void __btf_root(void)
+{
+	bpf_obj_drop(NULL);
+}
-- 
2.25.1

