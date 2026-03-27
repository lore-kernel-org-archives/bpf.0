Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BBA3F87E1
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620989; cv=none; b=h9JQcw9l7O/dGgvJu/aGjFl5NLvUAjPXm6OKu2X+6fIoOBGm8bdmSuphtkwyaF0G3e6Iqf8quqf8RpVsK3JuchfgRX+r27lLhmPPydf03o29X0mm+3DdDzzgEiASv8sljALrtvSIisJRp+LK3uWW0RLeqLwdUVPs8zmT96gxUIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620989; c=relaxed/simple;
	bh=nk/5ZakMJ+t2bnACkG2W+99kDbR1MO4cQq0DjDs269o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+m0Sue45GweJnJ7ACmPgPo5V+788TSDW0INe5ejTKn2rw+XIztNofe45IO87LsCdKUSidItnSSQrTn38n/ZKNsDuc20l0xdVwKNSEhJF0bAKGaCnG2yBK43Pv21/dHUC/cjY2axHiTW+pi8mPYU22xjrpCwyqBtCVz61dobOoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBVk2nHT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBVk2nHT"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ab39b111b9so9918445ad.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774620985; x=1775225785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aupF+DuW1/DcLr6AsgbIe6z0Vi4ttYW8cK5LaEjq3w=;
        b=bBVk2nHTC40dS0AyeaC0MCoeEtN5Bf+tnn3sfNcMhXGXO+XfJqN4Fn6KVL8sdrWkwC
         gnnaYgu8oQomOxYvq4SaUXaCF81lut0Z3ewvBFNCR9QOEsoWc4bFbcZkc6AXV4GCeM7L
         9HCOrLEk1gQOimME7WZbhZjWU7PbOkCTXwp5iqfK7P62rs+yFbeHHpNTC/d4/ZpYfrhq
         OdnzUPmTOh+opu9hcBmCR+6NnMySZv4SwX77hB2xtwQAmeIjjUMmZd81DuhtZlYEzjhM
         e2iwu0Ow3v53ROZbJ7vafnm89nTFBOspkLGHzHw+4kRXsOHanJqSPox+GqsJLqTtgr/C
         0NIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620985; x=1775225785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6aupF+DuW1/DcLr6AsgbIe6z0Vi4ttYW8cK5LaEjq3w=;
        b=XrbyMCQtWjPLrqoADI8A2di6YKRxD/Py4RN409voLuuOt+W2wA+S0ktiNbJiy35EZH
         5LSWPcZJta0SJDKSpenTKq/gdPz9n2VelRBqL4T6pOwTqhZjNIsWYBEJ0KjnnvnRQfRm
         1nsSrdPnQkL61gB9C+XilYynlMjqxuF8Ygw8+5Qd8/jWRuBoZCCaG+QIf0j4yo5V+gth
         nry8TEsXO9HfZdA8itN28DPfKHcd26V6GhGlZAAJ4SVPQERwqIK04OXo7litxyCc9g0Y
         1yd1GG0+BfTkQJf0p/0xwPbM8oQNng5qb1awXos+UJ/gGRrT72csRD8psDdf6rU/PVmc
         YLJg==
X-Gm-Message-State: AOJu0YxEOGJOZKdqfWMRYMfsOi52/vXBC9JmC8i9rOnH9a8TPJF25OD0
	Kd/4BWKdmVKO0k34YklnABacmz8UFH+RkvCqEw60VIVptIz7I+CR0K7P
X-Gm-Gg: ATEYQzzqqhEWZT72oqB+rH1L2WaQDWPqMUCjj3VGKJfL3C9zncAzwFPN9OkdoosZgym
	w+rbOnbIcnv9VESOylTZh6ul7TAMCRUMoCdc/tXSZh/UQCR/7zEGc1QnbTlixw7bKXmCEpZ7wpi
	hr/kYvWVAP4ejIfzgAYyBj5De+8tqnNdcarsTgmRltKr+Ekk70LScqXCAJmnXN/o4juIrCqQvsK
	bwU1AoQP3NHJ4ofqrLQ76iFlRB4ghhMK45UoD9WA4/RZy5WKJDhhRs1MQ6fsuUHSJ+Jh/23mvCW
	JVJ8zXKFLQPbCgcDGqD7tm3WFwqXvU13UgGWwQlw0rjGRzzGP7JY5WaoX5wGh385gqVt4w5sv+K
	vWnPAqkbKUn+srDl4DKzQP0BkTn1EmbKd9MZUFEBpdqbMDTk5yNSI8/BgLnlVD39uXSWZNYERFu
	2BfWkFmRK9iH+70wWVBclaiXI+/hG/kVidHSIN2dz61+j8d0oWRPCmX+fEuMSQEuRnAxeXAUNu6
	PbIiCl+x2A/ZTsY5C4unxsnwjp48WwSIvvwt25eEKjd
X-Received: by 2002:a17:902:ce06:b0:2b0:5a4c:7266 with SMTP id d9443c01a7336-2b0cdc29022mr30209125ad.16.1774620984287;
        Fri, 27 Mar 2026 07:16:24 -0700 (PDT)
Received: from lab-kiba-ocxma-dut-01.. (191.68.231.218.rev.ocx2915.net. [218.231.68.191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8e958csm61371365ad.66.2026.03.27.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:16:23 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	x86@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: cover fentry on tailcalled programs
Date: Fri, 27 Mar 2026 14:16:02 +0000
Message-ID: <20260327141616.1961457-3-hayatake396@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327141616.1961457-1-hayatake396@gmail.com>
References: <20260327141616.1961457-1-hayatake396@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a small tailcall target/probe pair and a tailcalls subtest that
attaches fentry to the callee program.

The test first runs the callee directly and checks that fentry fires
exactly once, then runs the entry program, tail-calls into the callee
and checks that the same fentry also fires exactly once on the tail-call
path.

This covers both sides of the x86 change: direct entry must not
double-fire, while tail-called entry must now be observable.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 110 ++++++++++++++++++
 .../bpf/progs/tailcall_fentry_probe.c         |  16 +++
 .../bpf/progs/tailcall_fentry_target.c        |  27 +++++
 3 files changed, 153 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_fentry_probe.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_fentry_target.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 7d534fde0af9..ac05df65b666 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -1113,6 +1113,114 @@ static void test_tailcall_bpf2bpf_fentry_entry(void)
 	bpf_object__close(tgt_obj);
 }
 
+static void test_tailcall_fentry_tailcallee(void)
+{
+	struct bpf_object *tgt_obj = NULL, *fentry_obj = NULL;
+	struct bpf_map *prog_array, *data_map;
+	struct bpf_link *fentry_link = NULL;
+	struct bpf_program *prog;
+	int err, map_fd, callee_fd, main_fd, data_fd, i, val;
+	char buff[128] = {};
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		    .data_in = buff,
+		    .data_size_in = sizeof(buff),
+		    .repeat = 1,
+	);
+
+	err = bpf_prog_test_load("tailcall_fentry_target.bpf.o",
+				 BPF_PROG_TYPE_SCHED_CLS,
+				 &tgt_obj, &main_fd);
+	if (!ASSERT_OK(err, "load tgt_obj"))
+		return;
+
+	prog_array = bpf_object__find_map_by_name(tgt_obj, "jmp_table");
+	if (!ASSERT_OK_PTR(prog_array, "find jmp_table map"))
+		goto out;
+
+	map_fd = bpf_map__fd(prog_array);
+	if (!ASSERT_FALSE(map_fd < 0, "find jmp_table map fd"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(tgt_obj, "entry");
+	if (!ASSERT_OK_PTR(prog, "find entry prog"))
+		goto out;
+
+	main_fd = bpf_program__fd(prog);
+	if (!ASSERT_FALSE(main_fd < 0, "find entry prog fd"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(tgt_obj, "callee");
+	if (!ASSERT_OK_PTR(prog, "find callee prog"))
+		goto out;
+
+	callee_fd = bpf_program__fd(prog);
+	if (!ASSERT_FALSE(callee_fd < 0, "find callee prog fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_update_elem(map_fd, &i, &callee_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	fentry_obj = bpf_object__open_file("tailcall_fentry_probe.bpf.o", NULL);
+	if (!ASSERT_OK_PTR(fentry_obj, "open fentry_obj file"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(fentry_obj, "fentry_callee");
+	if (!ASSERT_OK_PTR(prog, "find fentry prog"))
+		goto out;
+
+	err = bpf_program__set_attach_target(prog, callee_fd, "callee");
+	if (!ASSERT_OK(err, "set_attach_target callee"))
+		goto out;
+
+	err = bpf_object__load(fentry_obj);
+	if (!ASSERT_OK(err, "load fentry_obj"))
+		goto out;
+
+	fentry_link = bpf_program__attach_trace(prog);
+	if (!ASSERT_OK_PTR(fentry_link, "attach_trace"))
+		goto out;
+
+	data_map = bpf_object__find_map_by_name(fentry_obj, ".bss");
+	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+			  "find tailcall_fentry_probe.bss map"))
+		goto out;
+
+	data_fd = bpf_map__fd(data_map);
+	if (!ASSERT_FALSE(data_fd < 0,
+			  "find tailcall_fentry_probe.bss map fd"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(callee_fd, &topts);
+	ASSERT_OK(err, "direct callee");
+	ASSERT_EQ(topts.retval, 7, "direct callee retval");
+
+	i = 0;
+	err = bpf_map_lookup_elem(data_fd, &i, &val);
+	ASSERT_OK(err, "direct fentry count");
+	ASSERT_EQ(val, 1, "direct fentry count");
+
+	val = 0;
+	err = bpf_map_update_elem(data_fd, &i, &val, BPF_ANY);
+	ASSERT_OK(err, "reset fentry count");
+
+	err = bpf_prog_test_run_opts(main_fd, &topts);
+	ASSERT_OK(err, "tailcall");
+	ASSERT_EQ(topts.retval, 7, "tailcall retval");
+
+	i = 0;
+	err = bpf_map_lookup_elem(data_fd, &i, &val);
+	ASSERT_OK(err, "fentry count");
+	ASSERT_EQ(val, 1, "fentry count");
+
+out:
+	bpf_link__destroy(fentry_link);
+	bpf_object__close(fentry_obj);
+	bpf_object__close(tgt_obj);
+}
+
 #define JMP_TABLE "/sys/fs/bpf/jmp_table"
 
 static int poke_thread_exit;
@@ -1759,6 +1867,8 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_fentry_fexit();
 	if (test__start_subtest("tailcall_bpf2bpf_fentry_entry"))
 		test_tailcall_bpf2bpf_fentry_entry();
+	if (test__start_subtest("tailcall_fentry_tailcallee"))
+		test_tailcall_fentry_tailcallee();
 	if (test__start_subtest("tailcall_poke"))
 		test_tailcall_poke();
 	if (test__start_subtest("tailcall_bpf2bpf_hierarchy_1"))
diff --git a/tools/testing/selftests/bpf/progs/tailcall_fentry_probe.c b/tools/testing/selftests/bpf/progs/tailcall_fentry_probe.c
new file mode 100644
index 000000000000..b784aeffb316
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_fentry_probe.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+int count = 0;
+
+SEC("fentry/callee")
+int BPF_PROG(fentry_callee, struct sk_buff *skb)
+{
+	count++;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tailcall_fentry_target.c b/tools/testing/selftests/bpf/progs/tailcall_fentry_target.c
new file mode 100644
index 000000000000..46da06ce323c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_fentry_target.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+
+#include <bpf/bpf_helpers.h>
+#include "bpf_legacy.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+SEC("tc")
+int callee(struct __sk_buff *skb)
+{
+	return 7;
+}
+
+SEC("tc")
+int entry(struct __sk_buff *skb)
+{
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.43.0

