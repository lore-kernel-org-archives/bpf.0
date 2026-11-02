Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583062;
	b=d+ElJH8XBzBK5lqLe9lbhobH9QTbQPMwTkYpxvnDgwfdXFcRd2HJAjg2nH0UxA2KYKu8
	 skLVP+w+k4rI6RrjyhzdOORmrwjtLiy97AKmHD9YeNEYfqEz9v6T7bCG2me3LX2uSNLGv
	 OdZdL2HC4CbzIyM+Z1Ck3SLTIpCjte1LDjgKqqSL+mD3L+JRE+rCNuZNFSAlcT/DA7MLd
	 g3aAMfiSfedwMzNOkNcQ8HDdcroTRn0vzY4gDPXnE+2Ov4RypFiJ5UFit87zeEfcnJ/ch
	 Q6o5CrTQl3WecRqTYg9lIo2GGTrourc3E8SS/uFWQJYwh2yPpisMx24KqoFvinyAVDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U6Z9zm91ZRQlZVV7sohhB6eQzd3Yod0qjA3XbUsU0GY=;
	b=V1qyeCFcQH0H1lTdzkEjZpxROXkSo1Otsm7aSMgRnQMZ93lDF1HUY35eQ4avi6JJPFFv
	 IINsQts6ut82mf6MNIx7H90BOvNE4XhBlXfd4IWukD3WA5LTwwWr410mCuXfYmwZtA9Yq
	 8CAK1Qmto37U0UU0m0LIHshIK2zyanSq+lL0DQMxvRs7a1zY8yS9UhUhuu3wq8FIPR2cP
	 YDiF1A29xDmLmgpsbNOaOHCvraG065TIakuGEvgWQSUlXInIkxqanzjam/2fCCPFq+cRv
	 1veYk6tfT+2sI2QDG5NQrW7r6lbU166+mRjr9MkZyGsSn6BFuMNg8Tg4gpzFa7iDyXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CETpO6lD;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906E606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D906E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CETpO6lD
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so1309331a91.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793583061; x=1794187861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U6Z9zm91ZRQlZVV7sohhB6eQzd3Yod0qjA3XbUsU0GY=;
        b=CETpO6lDx4W9SeOf3lufyReVlDEqrGKQzmZ2fFVZht4DJYWhj7iBTHGZiR2wXbUqya
         Eg0aIkmrWf+U4YK9E4HzTxgckBrNCeHfNGzku+8arHGAWGvyk5cQ2qEQ/iVYcIRJlg+p
         xCdsOGsOaBrPxlCRVVlVr8rDQ7AzhW7InKGiSHo7CfjkDVHvu/ID59sWmHLqO+6ynYwU
         1kJUDntaJcFZR/18HaQtvWHyHE72CJ9DXPSwvgffaTrZQXH07iHsKHYTdI/94euLB3n+
         7e5UtGdR43evQRRpfOWswDBa4C9qMX1O0759Tmskcm6nxrDVdPKTr2euOkq66IAy1Se+
         oPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793583061; x=1794187861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U6Z9zm91ZRQlZVV7sohhB6eQzd3Yod0qjA3XbUsU0GY=;
        b=ZPqMa8+0TXZEkwERsgjoQB9H4RPkoTI3rjDEO3Uh+ENhY1kxK4YSZbSpVzhIeka6Dj
         OEqaGXIZfj+5mr8Nh4XrOzn3+nHRA5Y7kQjhqJ1iTUR/dsnKOVwKDekuLd5u0wIuBCi3
         UjtGHZeTat7J5A5sjYyudkIlCUhKB/HYjycCZjS1HiVHoCgerPO6jopOEJmkojTHKgQf
         kt51FtH8btHTENE8bHNtCL9sqv2inOP/o1DmVAHSoHxFY10HSPaZ+GmeOlyNcF7TWmQZ
         ITZJgu14BdRxEIJQqnQFYDzk7bja0B5haGq1jEcvJmIs9YVW8hGLm79BIeGfiSTrFYid
         //0w==
X-Gm-Message-State: APuU4Z90U4vxBfkjQXbxGKJuRA+rUTH1H8Ve8UqotWDniTTCy+8h9UpH
	vFyrS+L7oZoTJfd9+hF5uvoBx476OuQ0TLtM5Sr1KnWjva0gE0tTaVH2CoVppQ==
X-Gm-Gg: AYBFou2ltnPDn60RPXfIUNowSnkqxd3UsTNQmNBRH/wCgCQFkOXvfgeyWal/D3UjsK2
	azf6U3dby96g+g8Oc/OyhMu6LLIqVt1D2uch2qG0pcN+eOMpq/hEHpslhWvjeLtDlGAu505pR+A
	fMl0Z7gkwiZ8Y2LOIAuHJoualNX3/qHzLUhtW2eJdCsSRPXq0fUnYRkw6TcxmEnJvLPFIQZH9TD
	/2+UBHTjkNphuiTeaLwLbZ7Xu2oyzhlB+cYNa09YHCiq2WGs4BuCTToDIG8df912WYDA75dhnCd
	fxwCWrOHwZMj0Q1vKUcIMjOlN8jc5w818CEY29GuUZ2a6fQ0PfbQgI8KroyYh8PwEpx1lS7Dv/8
	+hl1cs/W2D3oXw+HnTfOc1eS6TevRQXgenVt1PDKt5t2N84AzWVbQIxCCDwLY6tg1PHXPm07Rsg
	huRBtIsBbR40EKLYeV+/R6piTkZ4gqCW05oGpnV2hbp8QIvl/eZyYqtRtGAZcydoKwmK8J7G0DZ
	Z7I2buJ/OBAqucncMRHfFTIsOf6bI0s6N998gDZrnpKeoNzVS/6zlTQ7kd06dZGd/QeqQ0QwzI8
	zQThuwl990z9tQ4pgluO1P/CpTrjyVPkQYBH5ZjRU3v6DtyUNOfsvaB+SiFj2FCm8qs6vfvAzfC
	HoCx/D2SrQkO442E4Iy84jAo2XaUnwKnE3i2acLFvCUccux1db//DrLl/MevFYeEXsHvtTGCbBg
	==
X-Received: by 2002:a17:90b:1845:b0:3ab:8288:b8ce with SMTP id 98e67ed59e1d1-3ae8974d028mr4274371a91.24.1793583060858;
        Sun, 01 Nov 2026 17:31:00 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aec233ba08sm1918831a91.0.2026.11.01.17.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:31:00 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 13/13] selftests/bpf: Test the tables that follow patched and removed instructions
Date: Mon,  2 Nov 2026 01:29:40 +0000
Message-ID: <20261102012940.1756142-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
References: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
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

bpf_patch_list_commit() builds the new image of a prog from queued patches,
removals and inserted insns. Then it moves each table that names insns, and
each table has its own rule. The tests of jumps do not show an error in
these rules. Add the tests that are missing.

  table                 test
  --------------------  --------------------------------------------------
  aux data              ctx access behind removed insns
  jumps, calls          call of and jump to an insn with insns inserted in
                        front
  subprogs              call over removed and patched insns
  exception callback    exceptions/exception_cb_behind_dead_subprog [*]
  func info, line info  patch_list/line_and_func_info
  insn arrays           bpf_insn_array/gotox-target-prologue-shift [*]
  poke descriptors      patch_list/poke_descriptor
  function pointers     callx_rodata_prog_shrinks_below_func
                        callx_rodata_table_of_ops
                        callx_rodata_func_with_may_goto
  [*] existing test

The prog for line info and func info has marks. A mark is a line of source
code with one insn, 'r0 = n'. Each record must name the insn with its mark.
Removed code must have no record: its marks are gone, and insn_off grows
from record to record.

A function pointer in .rodata names the first insn of a subprog. In the
first two tests the verifier removes more insns than the subprog has. Thus
the old index of the subprog is behind the end of the new image. The tests
fail when the commit uses an old index with the new prog->len. In the third
test the subprog has may_goto, and the pointer must name the setup of the
may_goto count.

Also test two things that are not tables:
 - bpf_opt_remove_nops() removes a 'goto' or a may_goto that jumps over
   nops only: "may_goto over a nop", "goto over a nop" and
   "goto over a nop and an insn". In the last test the 'goto' must stay.
 - bpf_patch_list_apply() is the commit without the verifier.
   patch_list/classic_filter attaches a classic BPF filter with
   bpf_jit_harden=2. Its jumps go over insns with constants, and the test
   compares what the filter returns.

patch_list/poke_descriptor runs on x86-64 only, because no other JIT uses
poke descriptors. patch_list is a serial test. With
net.core.bpf_jit_harden, which other tests set, a prog has other xlated
insns and no poke descriptors.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/patch_list.c     | 256 ++++++++++++++++++
 .../testing/selftests/bpf/progs/patch_list.c  | 136 ++++++++++
 .../bpf/progs/verifier_callx_rodata.c         | 100 +++++++
 .../selftests/bpf/progs/verifier_patch_list.c | 181 +++++++++++++
 4 files changed, 673 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/patch_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/patch_list.c

diff --git a/tools/testing/selftests/bpf/prog_tests/patch_list.c b/tools/testing/selftests/bpf/prog_tests/patch_list.c
new file mode 100644
index 000000000000..127ed58cfc39
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/patch_list.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+/* The tables that follow the insns which the verifier patches and removes */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "sysctl_helpers.h"
+#include "patch_list.skel.h"
+
+/* load one program of the object */
+static struct patch_list *open_and_load(const char *name, int jmp_table_fd)
+{
+	struct bpf_program *prog;
+	struct patch_list *skel;
+
+	skel = patch_list__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return NULL;
+
+	bpf_object__for_each_program(prog, skel->obj)
+		bpf_program__set_autoload(prog, !strcmp(bpf_program__name(prog), name));
+	if (jmp_table_fd >= 0 &&
+	    !ASSERT_OK(bpf_map__reuse_fd(skel->maps.jmp_table, jmp_table_fd), "reuse_fd"))
+		goto err;
+	if (!ASSERT_OK(patch_list__load(skel), "load"))
+		goto err;
+	return skel;
+err:
+	patch_list__destroy(skel);
+	return NULL;
+}
+
+#if defined(__x86_64__)
+static int run(struct bpf_program *prog)
+{
+	char data[64] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = data,
+		.data_size_in = sizeof(data),
+		.repeat = 1,
+	);
+
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(prog), &opts), "test_run"))
+		return -1;
+	return opts.retval;
+}
+#endif
+
+/* Whether 'r0 = mark' is at 'off', or behind the insns inserted in front of a function. */
+static bool mark_is_at(const struct bpf_insn *insns, __u32 cnt, __u32 off, bool func_start,
+		       int mark)
+{
+	while (func_start && off < cnt && insns[off].code == (BPF_ST | BPF_MEM | BPF_DW))
+		off++;
+	return off < cnt && insns[off].code == (BPF_ALU64 | BPF_MOV | BPF_K) &&
+	       insns[off].dst_reg == BPF_REG_0 && insns[off].imm == mark;
+}
+
+static void test_line_and_func_info(void)
+{
+	/* what is left of the marks and functions of fn_1001(), in the order of the insns */
+	static const int marks[] = { 1001, 1004, 1005, 1006, 1007, 1008, 3001, 3002,
+				     4001, 4002, 4003 };
+	static const int funcs[] = { 1001, 3001, 4001 };
+	__u64 jited_linfo[64] = {}, ksyms[8] = {};
+	struct bpf_line_info linfo[64] = {};
+	struct bpf_func_info finfo[8] = {};
+	struct bpf_insn insns[128] = {};
+	struct bpf_prog_info info = {};
+	__u32 i, j, k, cnt, starts = 0, len = sizeof(info);
+	struct patch_list *skel;
+	struct btf *btf = NULL;
+	const char *str;
+	int mark;
+
+	skel = open_and_load("fn_1001", -1);
+	if (!skel)
+		return;
+
+	info.xlated_prog_insns = ptr_to_u64(insns);
+	info.xlated_prog_len = sizeof(insns);
+	info.line_info = ptr_to_u64(linfo);
+	info.nr_line_info = ARRAY_SIZE(linfo);
+	info.line_info_rec_size = sizeof(*linfo);
+	info.jited_line_info = ptr_to_u64(jited_linfo);
+	info.nr_jited_line_info = ARRAY_SIZE(jited_linfo);
+	info.jited_line_info_rec_size = sizeof(*jited_linfo);
+	info.func_info = ptr_to_u64(finfo);
+	info.nr_func_info = ARRAY_SIZE(finfo);
+	info.func_info_rec_size = sizeof(*finfo);
+	info.jited_ksyms = ptr_to_u64(ksyms);
+	info.nr_jited_ksyms = ARRAY_SIZE(ksyms);
+	if (!ASSERT_OK(bpf_prog_get_info_by_fd(bpf_program__fd(skel->progs.fn_1001), &info, &len),
+		       "get_info"))
+		goto out;
+	cnt = info.xlated_prog_len / sizeof(*insns);
+	if (!ASSERT_LE(cnt, ARRAY_SIZE(insns), "xlated insns") ||
+	    !ASSERT_LE(info.nr_line_info, ARRAY_SIZE(linfo), "nr_line_info"))
+		goto out;
+
+	btf = btf__load_from_kernel_by_id(info.btf_id);
+	if (!ASSERT_OK_PTR(btf, "btf"))
+		goto out;
+
+	if (!ASSERT_EQ(info.nr_func_info, ARRAY_SIZE(funcs), "nr_func_info"))
+		goto out;
+	for (i = 0; i < info.nr_func_info; i++) {
+		str = btf__name_by_offset(btf, btf__type_by_id(btf, finfo[i].type_id)->name_off);
+		mark = 0;
+		sscanf(str, "fn_%d", &mark);
+		ASSERT_EQ(mark, funcs[i], "func");
+		ASSERT_TRUE(mark_is_at(insns, cnt, finfo[i].insn_off, true, mark), str);
+	}
+
+	for (i = 0, k = 0; i < info.nr_line_info; i++) {
+		for (j = 0; j < info.nr_func_info; j++)
+			if (finfo[j].insn_off == linfo[i].insn_off)
+				break;
+		/* a function begins with a line, also in the JITed code */
+		if (j < info.nr_func_info)
+			starts++;
+		if (j < info.nr_func_info && info.nr_jited_line_info && info.nr_jited_ksyms)
+			ASSERT_EQ(jited_linfo[i], ksyms[j], "jited_line_info");
+		/* the line of a removed insn doesn't stay beside the line of the next insn */
+		if (i)
+			ASSERT_GT(linfo[i].insn_off, linfo[i - 1].insn_off, "insn_off");
+
+		str = strstr(btf__name_by_offset(btf, linfo[i].line_off), "MARK(");
+		if (!str)
+			continue;
+		mark = atoi(str + strlen("MARK("));
+		if (k < ARRAY_SIZE(marks))
+			ASSERT_EQ(mark, marks[k], "mark");
+		k++;
+		ASSERT_TRUE(mark_is_at(insns, cnt, linfo[i].insn_off, j < info.nr_func_info, mark),
+			    str);
+	}
+	if (skel->rodata->has_line_text)
+		ASSERT_EQ(k, ARRAY_SIZE(marks), "marks");
+	ASSERT_EQ(starts, info.nr_func_info, "functions that begin with a line");
+out:
+	btf__free(btf);
+	patch_list__destroy(skel);
+}
+
+/*
+ * The x86-64 JIT finds the function of a tail call by the index in the poke
+ * descriptor, and connects it at once when the program array has the target.
+ * No other JIT uses the poke descriptors.
+ */
+static void test_poke_descriptor(void)
+{
+#if defined(__x86_64__)
+	struct patch_list *target, *entry = NULL;
+	int key = 0, fd;
+
+	if (!is_jit_enabled()) {
+		printf("%s:SKIP:JIT is disabled\n", __func__);
+		test__skip();
+		return;
+	}
+
+	target = open_and_load("poke_target", -1);
+	if (!target)
+		return;
+	fd = bpf_program__fd(target->progs.poke_target);
+	if (!ASSERT_OK(bpf_map__update_elem(target->maps.jmp_table, &key, sizeof(key),
+					    &fd, sizeof(fd), 0), "map_update"))
+		goto out;
+
+	entry = open_and_load("poke_entry", bpf_map__fd(target->maps.jmp_table));
+	if (!entry)
+		goto out;
+	ASSERT_EQ(run(entry->progs.poke_entry), 7, "retval");
+out:
+	patch_list__destroy(entry);
+	patch_list__destroy(target);
+#else
+	printf("%s:SKIP:the JIT does not use poke descriptors\n", __func__);
+	test__skip();
+#endif
+}
+
+/*
+ * A classic filter has no verifier env, so bpf_patch_list_apply() puts the
+ * blinded constants in. Each insn with a constant grows, and the jumps of the
+ * filter go over such insns. The filter returns how much of the packet stays.
+ */
+static void test_classic_filter(void)
+{
+	const char *harden = "/proc/sys/net/core/bpf_jit_harden";
+	struct sock_filter code[] = {
+		/* A = first byte of the packet */
+		BPF_STMT(BPF_LD | BPF_B | BPF_ABS, 0),
+		BPF_JUMP(BPF_JMP | BPF_JGT | BPF_K, 40, 4, 0),
+		BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 7, 2, 0),
+		BPF_STMT(BPF_ALU | BPF_ADD | BPF_K, 10),
+		BPF_STMT(BPF_RET | BPF_A, 0),
+		/* A == 7 */
+		BPF_STMT(BPF_RET | BPF_K, 0),
+		/* A > 40 */
+		BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 15),
+		BPF_JUMP(BPF_JMP | BPF_JSET | BPF_K, 1, 2, 0),
+		BPF_STMT(BPF_ALU | BPF_MUL | BPF_K, 3),
+		BPF_STMT(BPF_RET | BPF_A, 0),
+		/* A is odd */
+		BPF_STMT(BPF_RET | BPF_K, 33),
+	};
+	struct sock_fprog prog = { .len = ARRAY_SIZE(code), .filter = code };
+	static const struct {
+		char byte;
+		int len;
+	} tests[] = { { 1, 11 }, { 7, 0 }, { 40, 50 }, { 41, 33 }, { 44, 36 } };
+	char old[16] = {}, buf[64] = {};
+	int sv[2], i, err, len;
+
+	if (!is_jit_enabled()) {
+		printf("%s:SKIP:JIT is disabled\n", __func__);
+		test__skip();
+		return;
+	}
+
+	if (!ASSERT_OK(socketpair(AF_UNIX, SOCK_DGRAM, 0, sv), "socketpair"))
+		return;
+	if (sysctl_set_or_fail(harden, old, "2"))
+		goto out;
+	err = setsockopt(sv[1], SOL_SOCKET, SO_ATTACH_FILTER, &prog, sizeof(prog));
+	sysctl_set_or_fail(harden, NULL, old);
+	if (!ASSERT_OK(err, "SO_ATTACH_FILTER"))
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		buf[0] = tests[i].byte;
+		if (!ASSERT_EQ(send(sv[0], buf, sizeof(buf), 0), sizeof(buf), "send"))
+			break;
+		/* nothing arrives when the filter returns 0 */
+		len = recv(sv[1], buf, sizeof(buf), MSG_DONTWAIT);
+		ASSERT_EQ(len < 0 ? 0 : len, tests[i].len, "len");
+	}
+out:
+	close(sv[0]);
+	close(sv[1]);
+}
+
+/*
+ * Serial: the xlated code is another one and there are no poke descriptors
+ * while another test sets bpf_jit_harden, and classic_filter sets it.
+ */
+void serial_test_patch_list(void)
+{
+	if (test__start_subtest("line_and_func_info"))
+		test_line_and_func_info();
+	if (test__start_subtest("poke_descriptor"))
+		test_poke_descriptor();
+	if (test__start_subtest("classic_filter"))
+		test_classic_filter();
+}
diff --git a/tools/testing/selftests/bpf/progs/patch_list.c b/tools/testing/selftests/bpf/progs/patch_list.c
new file mode 100644
index 000000000000..0e8302098395
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/patch_list.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Programs for the tables that follow the insns which the verifier patches and removes */
+
+#include <linux/bpf.h>
+#include <stdbool.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+/*
+ * MARK(n) is a line of source code with one insn, 'r0 = n', and no other insn
+ * has n. The first mark of function fn_n is n. So user space can tell whether
+ * the line info and the func info of the loaded program name the right insns.
+ */
+#define MARK(n) asm volatile ("r0 = " #n ";")
+/* The line starts with a nop. When the nop goes away, 'r0 = n' gets the line. */
+#define NOP_MARK(n) asm volatile ("goto +0; r0 = " #n ";")
+
+/* gcc doesn't put the text of the lines into BTF */
+#ifdef __clang__
+const volatile bool has_line_text = true;
+#else
+const volatile bool has_line_text = false;
+#endif
+
+/* only dead code calls it */
+__naked __noinline __used
+static int fn_2001(void)
+{
+	MARK(2001);
+	asm volatile ("exit;");
+}
+
+__naked __noinline __used
+static int fn_3001(void)
+{
+	NOP_MARK(3001);
+	MARK(3002);
+	asm volatile ("exit;");
+}
+
+/* the setup of the may_goto count goes in front of it */
+__naked __noinline __used
+static int fn_4001(void)
+{
+	MARK(4001);
+	asm volatile (".8byte %[may_goto];"
+		      :: __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1, 0)));
+	MARK(4002);
+	MARK(4003);
+	asm volatile ("exit;");
+}
+
+SEC("socket")
+__naked int fn_1001(void)
+{
+	MARK(1001);
+	asm volatile ("if r0 != 0 goto +3;");
+	MARK(1002);
+	asm volatile ("call fn_2001;");
+	MARK(1003);
+	MARK(1004);
+	/* the division gets three insns in front */
+	asm volatile ("r1 = 1; r0 /= r1;");
+	NOP_MARK(1005);
+	/* the next insn has a line, so the line of the nop goes away */
+	asm volatile ("goto +0;");
+	MARK(1006);
+	asm volatile ("call fn_3001;");
+	MARK(1007);
+	asm volatile ("call fn_4001;");
+	MARK(1008);
+	asm volatile ("exit;");
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+SEC("tc")
+int poke_target(struct __sk_buff *skb)
+{
+	return 7;
+}
+
+__naked __noinline __used
+static int poke_pad(void)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	);
+}
+
+__naked __noinline __used
+static int poke_tail_call(void)
+{
+	asm volatile (
+	"r2 = %[jmp_table] ll;"
+	"r3 = 0;"
+	"call %[bpf_tail_call];"
+	"r0 = 1;"
+	"exit;"
+	:
+	: __imm_addr(jmp_table),
+	  __imm(bpf_tail_call)
+	: __clobber_all);
+}
+
+/*
+ * The divisions grow by more insns than there are between the tail call and
+ * the start of its function: the index that the tail call had is in this
+ * function afterwards.
+ */
+SEC("tc")
+__naked int poke_entry(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"r1 = 1;"
+	"r0 = 8;"
+	"r0 /= r1;"
+	"r0 /= r1;"
+	"r0 /= r1;"
+	"r0 /= r1;"
+	"call poke_pad;"
+	"r1 = r6;"
+	"call poke_tail_call;"
+	"exit;"
+	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
index 6cf58ca9ac5b..b2ee0c8e042b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -325,6 +325,106 @@ __naked void callx_rodata_func_starts_with_nop(void)
 		::: __clobber_all);
 }
 
+/*
+ * The program loses more instructions than the function has, so the offset
+ * that the function had is behind the end of the program that is left.
+ */
+SEC("socket")
+__success __retval(11)
+__naked void callx_rodata_prog_shrinks_below_func(void)
+{
+	asm volatile (
+		RODATA(tbl, ".quad nop_add1; .quad 0;")
+		"goto +0;"
+		"goto +0;"
+		"goto +0;"
+		"goto +0;"
+		"goto +0;"
+		"goto +0;"
+		"goto +0;"
+		"goto +0;"
+		"r2 = tbl_%= ll;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+int ops_arg = 10;
+
+/* the argument is never NULL, so the verifier removes the check and its branch */
+#define OP(name, n)						\
+static __noinline int name(int *arg)				\
+{								\
+	if (!arg)						\
+		return bpf_get_prandom_u32();			\
+	return *arg + n;					\
+}
+
+OP(op_a, 2) OP(op_b, 3) OP(op_c, 4) OP(op_d, 5) OP(op_e, 6) OP(op_f, 7) OP(op_g, 8) OP(op_h, 9)
+
+/* volatile, so that the compiler doesn't replace the table with direct calls */
+static int (* const volatile ops_table[])(int *) = {
+	op_a, op_b, op_c, op_d, op_e, op_f, op_g, op_h
+};
+
+/* the same in C: each function of the table loses its first instructions */
+SEC("socket")
+__success __retval(124)
+int callx_rodata_table_of_ops(void *ctx)
+{
+	int i, sum = 0;
+
+	for (i = 0; i < 8; i++)
+		sum += ops_table[i](&ops_arg);
+	return sum;
+}
+
+/* leave zeros where the function that is called next has its stack */
+__naked __noinline __used
+static unsigned long zero_stack(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 8) = r0;"
+		"*(u64 *)(r10 - 16) = r0;"
+		"exit;"
+	);
+}
+
+/* count to r1, or to 0 when nothing set the count of may_goto */
+__naked __noinline __used
+static unsigned long may_goto_count(void)
+{
+	asm volatile (
+		"r0 = 0;"
+	"l0_%=:"
+		".8byte %[may_goto];"
+		"r0 += 1;"
+		"if r0 < r1 goto l0_%=;"
+		"exit;"
+		:
+		: __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 2 /* offset */, 0))
+		: __clobber_all);
+}
+
+/* the pointer names the instructions that the verifier puts in front of the function */
+SEC("socket")
+__success __retval(5)
+__naked void callx_rodata_func_with_may_goto(void)
+{
+	asm volatile (
+		RODATA(tbl, ".quad may_goto_count; .quad 0;")
+		"call zero_stack;"
+		"r2 = tbl_%= ll;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 5;"
+		"callx r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
 /* can't be called with a scalar in r1 */
 __naked __noinline __used
 static unsigned long deref_r1(void)
diff --git a/tools/testing/selftests/bpf/progs/verifier_patch_list.c b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
index ffadd723f947..3ba99cf16e96 100644
--- a/tools/testing/selftests/bpf/progs/verifier_patch_list.c
+++ b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
@@ -242,4 +242,185 @@ __naked void patch_list_may_goto_gotol(void)
 	: __clobber_all);
 }
 
+/*
+ * The aux data follows its insn: the verifier still knows which insn loads
+ * from the ctx when the dead code and the nops in front of it are gone.
+ */
+SEC("socket")
+__description("patch list: ctx access behind removed insns")
+__success __retval(50) /* TEST_DATA_LEN without the Ethernet header */
+__naked void patch_list_ctx_behind_removed(void)
+{
+	asm volatile (
+	"r0 = 0;"
+	"if r0 == 0 goto l0_%=;"
+	"r0 = 1;"
+	"r0 = 2;"
+"l0_%=:"
+	"goto +0;"
+	"r0 = *(u32 *)(r1 + %[len]);"
+	"exit;"
+	:
+	: __imm_const(len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long patch_list_loop_at_start(void)
+{
+	asm volatile (
+"l0_%=:"
+	"r1 += -1;"
+	".8byte %[may_goto];"
+	"if r1 != 0 goto l0_%=;"
+	"r0 = r1;"
+	"exit;"
+	:
+	: __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1 /* offset */, 0))
+	: __clobber_all);
+}
+
+/*
+ * The setup of the may_goto count goes in front of the function. The call
+ * lands on the setup, the jump to the first insn of the function behind it.
+ * This is the code for the JITs that support the timed may_goto.
+ */
+SEC("raw_tp")
+__description("patch list: call of and jump to an insn with insns inserted in front")
+__arch_x86_64
+__arch_s390x
+__arch_arm64
+__arch_riscv64
+__arch_loongarch
+__success
+__xlated("0: r1 = 3")
+__xlated("1: call pc+1")
+__xlated("2: exit")
+__xlated("3: *(u64 *)(r10 -16) = 65535")
+__xlated("4: *(u64 *)(r10 -8) = 0")
+__xlated("5: r1 += -1")
+__xlated("...")
+__xlated("13: if r1 != 0x0 goto pc-9")
+__xlated("14: r0 = r1")
+__xlated("15: exit")
+__naked void patch_list_insert_in_front(void)
+{
+	asm volatile (
+	"r1 = 3;"
+	"call patch_list_loop_at_start;"
+	"exit;"
+	::: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long patch_list_never_called(void)
+{
+	asm volatile (
+	"r0 = 100;"
+	"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long patch_list_nop_add1(void)
+{
+	asm volatile (
+	"goto +0;"
+	"r0 = r1;"
+	"r0 += 1;"
+	"exit;"
+	);
+}
+
+/*
+ * A function goes away as dead code, the one behind it loses its first insn,
+ * and the caller both loses and gets insns in front of the call.
+ */
+SEC("socket")
+__description("patch list: call over removed and patched insns")
+__success __retval(11)
+__naked void patch_list_call_over_removed(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"if r1 == 1 goto l0_%=;"
+	"call patch_list_never_called;"
+"l0_%=:"
+	"goto +0;"
+	"r2 = 2;"
+	"r0 = 12;"
+	"r0 /= r2;"
+	"r6 = r0;"
+	"r1 = 4;"
+	"call patch_list_nop_add1;"
+	"r0 += r6;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * A goto or a may_goto that jumps over nops only is a nop. The nops are not
+ * dead code: may_goto falls through to its nop, 'if' jumps to the other one.
+ */
+SEC("raw_tp")
+__description("patch list: may_goto over a nop")
+__success
+__xlated("0: r0 = 1")
+__xlated("1: exit")
+__naked void patch_list_may_goto_over_nop(void)
+{
+	asm volatile (
+	".8byte %[may_goto];"
+	"goto +0;"
+	"r0 = 1;"
+	"exit;"
+	:
+	: __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1 /* offset */, 0))
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__description("patch list: goto over a nop")
+__success
+__xlated("0: r0 = *(u64 *)(r1 +0)")
+__xlated("1: if r0 == 0x0 goto pc+0")
+__xlated("2: r0 = 1")
+__xlated("3: exit")
+__naked void patch_list_goto_over_nop(void)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r1 + 0);"
+	"if r0 == 0 goto l0_%=;"
+	"goto l1_%=;"
+"l0_%=:"
+	"goto +0;"
+"l1_%=:"
+	"r0 = 1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* this goto also jumps over an insn that stays */
+SEC("raw_tp")
+__description("patch list: goto over a nop and an insn")
+__success
+__xlated("0: r0 = *(u64 *)(r1 +0)")
+__xlated("1: if r0 == 0x0 goto pc+1")
+__xlated("2: goto pc+1")
+__xlated("3: r0 = 1")
+__xlated("4: exit")
+__naked void patch_list_goto_over_nop_and_insn(void)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r1 + 0);"
+	"if r0 == 0 goto l0_%=;"
+	"goto l1_%=;"
+"l0_%=:"
+	"goto +0;"
+	"r0 = 1;"
+"l1_%=:"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

