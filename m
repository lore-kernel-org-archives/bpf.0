Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560011;
	b=eHNAE1neDOjxvoxABrWLjoBBA+6NinTAR6PaQchH/2UcB85Zpxat4fRPiypyOlhH3pbX
	 tvQP4E97UX1+OkJS/JNXsJNS/lnXD/b0ThTdvEg0zul9esiRES0E+eGiOotsFv1Fw6eg1
	 vNG3Gqp1CSESrzbjMNjDj5xoqhhHIqbj0KhNIvgr0YqBy5DE7HlcO0HONVWj/z78kEW8B
	 44qXb+ijuSa4/UvmlsrpkMsSyjHkJTABLwjGNhQRO4weqFvv8e+JvXDSMd076pkxZu/nT
	 9eDPZp2+zGPq8eOeZs7PxNalH41ok97U/11Rz+oz7WPhuRrAthmGR/FeAUnkbDZUW1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TGjs5rzvGQiTsQRwE47K693DPakZ/Tmr+xfd0UMO86A=;
	b=rvMgoMAeTd638OxIMehhSj1G8/VFal87VtHSSYR9uWk1fXvyYVgaAUdD6hB+QT1tpz0B
	 3Lt9u5O/Nef9UDlphKiZEuRpLk7QIQFxd8EkWRRhPd+C41eFl9uI1w29YinUUpQjQJi8U
	 9CtMd0NiDesAuJEwxZ6EWsMz+/bN9FTgnkONyyXVJfkYBKcOMRJRZqmK3L823hSVJNX0m
	 ya4JWxAvFGYaNd7J6O0W49WPW1MKDC+Vh8GaOopAccCG5uvpJt9ksY+Vlpwvx03judxb4
	 DrBGq3PLiUdbZCTaQETgZjFR24WdNlRb/TBDAQW234Vw1U9i51JO6l4zTWchroTnEpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mH/TKZbD";
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B001606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B001606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mH/TKZbD
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso2004148a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560010; x=1794164810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TGjs5rzvGQiTsQRwE47K693DPakZ/Tmr+xfd0UMO86A=;
        b=mH/TKZbDLL+jDcBBkK+++azHifMzDu9thaDvNdcI1tjTJZtK8tascllMR+phOodlO1
         8vq7qdvcDwvT2/rQxFgOcaAq+8f9ZmJLhaDheKvr75OgSiLXmuT7O68xVHY4EIvOvX8B
         HYiVnnirEyu304CBhUkCzvk5aFbBbnSdEmLMBIS9gBENc6Qd1gcgLFCfbsj8OwiG8rM3
         +FuQaxQu7YZENBHWxMQw/MksnM3jldO2epr98gxG5aoT1WkJaFAQgDhi0CUNfOQ7TPG6
         RuLd/BqB1E/6A7lov4K8kxlejsvwqwjKBS9I7qNphfdknfvDvky2O0ekgYMTFZysxLt/
         SMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560010; x=1794164810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TGjs5rzvGQiTsQRwE47K693DPakZ/Tmr+xfd0UMO86A=;
        b=BevcX7N7mKIvQ+ZXzZX6k88euzqSz60D3bTB6X2wIZJmsMlnn+sDc4XenKZkTaNKuL
         J0FGgkDaYeC8SpJsSLRoPbQeOb1LPcv49W0p1dfGofuml7vCuW+2iybe1ZG5R1wfoiq/
         70e3E8v8Tjjj4FbqDXDm4lcsUEWaqdT0cjYLNMEWhdeh6URB/TpkqD3/ZADZzSV9cIbl
         UfwsgHKiUDtx0vDmYsU0WguwCDBIvYyaLnK1rk97C2PKWoQuLkdhVZkFViwAF/NUb4ca
         /em1tbp0+pENMkeIo17vZ9MnbKw95GExN1wixO3mb14HX/U0KQObsB2bjAO+R4jdKdVq
         ojFg==
X-Gm-Message-State: APuU4Z/UlWgLGtYzOPedpDnuiUQoWoANDsStHbX1IwGzPhIV24Mm3IyP
	hecFOwf7nCswX6hlUiNTO9hpzLsFCwBGHhPLVqGZOAinBvdCAhCPgnhlJKHznQ==
X-Gm-Gg: AYBFou0J8LN4d4IkyleSSHDbGThjRz0Pwd/gNytZv+C7MxCFJ05qk6USvczSlSryTAu
	xisvfeo5b8LbrCs9NriQonJD0L1SSbCDyeGBq6rwE8nDiWIUEggiPt4lr0YhEsSl8R3ZzlR9yRy
	ibRB0Gad6O3bKESocdSnn8708kiArgztDNU3uXgcalylC90fMPVsx9BqitEBDHaDqbLdH0olp3W
	1gDtqf9/d8HyFCWRNxlK69FWGjvSUVXSGpqLR1HXdCcSvy93s8LStApm0S8G+0AuFy1FVxUKB96
	z7PKmk39QZJ7RZXU8O/NYLaFeOvdyI0jFt7XZPej9ceBVnD3o2UoocX2jgizBRhuEjR5CB4hKJg
	o2WJFG3p+3xt9iNQztVFj35CNPt91+JzqwvSn0LLE9Q/aAjErxjGvwtq/iZVqQMGFQAnNVWJBAk
	bQDZqRvyiBU8SIJFw/4PJC45ofg7Ze+U+B4fdpZ/jTfgHl6I/M4X3Oqu6tsmDwq52oCXqqps/L6
	lDFTQQIH5sw2ewiWTre9HEXgNR84at6gesdjGljn6FjdXYSQTPfAtVP1aPccCafN2rh906gSt27
	ZkionHOI8oNmHkW6TDa1b9UNjnvz4O3nsymwgw3zLV2g8vF3RAEzqefWSGyQgKK257y6bn8rF9w
	j8WurXgJ65Kg+1AcV+0cJhdh4P4BcMxb/debDmFoXmxS1rSccU0Su+x7sWlh6fPYQdjNRF7UoQH
	wwpMYGNHUhbd3/Ja7j7Lc=
X-Received: by 2002:a17:90b:184c:b0:3ae:3b3d:c617 with SMTP id 98e67ed59e1d1-3ae89778667mr4226537a91.29.1793560009896;
        Sun, 01 Nov 2026 11:06:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98afe3sm15105019a91.12.2026.11.01.11.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:06:49 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 12/27] selftests/bpf: Test the arguments of an extension prog
Date: Sun,  1 Nov 2026 19:05:20 +0000
Message-ID: <20261101190535.1454146-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
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

An extension must not expect more of its arguments than the callers of the
replaced function provide. It must fail if it expects more memory, a
non-NULL pointer or another kind of argument. The same argument, less
memory or a pointer that can be NULL must pass. Test check_ext_args() at
load and at attach to another function of the same target prog. The load
must fail with the message of the check, and the attach with -EINVAL.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/freplace_args.c  | 92 +++++++++++++++++++
 .../selftests/bpf/progs/freplace_args.c       | 53 +++++++++++
 .../selftests/bpf/progs/freplace_args_tgt.c   | 70 ++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/freplace_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_args_tgt.c

diff --git a/tools/testing/selftests/bpf/prog_tests/freplace_args.c b/tools/testing/selftests/bpf/prog_tests/freplace_args.c
new file mode 100644
index 000000000000..d1930af23fa0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/freplace_args.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "freplace_args.skel.h"
+#include "freplace_args_tgt.skel.h"
+
+/*
+ * An extension must not expect more of its arguments than the callers of the
+ * function that it replaces provide. The progs are loaded and attached to each
+ * other. None of them runs.
+ */
+static const struct test {
+	const char *name;
+	const char *ext;	/* prog of freplace_args.c */
+	const char *tgt;	/* prog of freplace_args_tgt.c */
+	const char *func;	/* function of tgt that ext is loaded for */
+	const char *func2;	/* function of tgt that ext is attached to */
+	int bad_reg;		/* argument that is refused, 0: none */
+} tests[] = {
+	{ "same_nonnull",		"ext_mem_nonnull",  "tc_prog", "mem_nonnull" },
+	{ "same_trusted",		"ext_task_trusted", "tc_prog", "task_trusted" },
+	{ "smaller_struct",		"ext_mem_smaller",  "tc_prog", "mem_smaller" },
+	{ "larger_struct",		"ext_mem_larger",   "tc_prog", "mem_larger", NULL, 1 },
+	{ "nullable_for_nonnull",	"ext_mem",	    "tc_prog", "mem_nonnull" },
+	{ "nonnull_for_nullable",	"ext_mem_nonnull",  "tc_prog", "mem", NULL, 2 },
+	{ "trusted_for_mem",		"ext_task_trusted", "tc_prog", "task_mem", NULL, 1 },
+	{ "arg_ctx_for_ctx_type",	"ext_skb_ctx",	    "tc_prog", "skb_ctx" },
+	{ "mem_for_arg_ctx",		"ext_tp_mem",	    "tp_prog", "tagged_ctx", NULL, 1 },
+	{ "attach_nullable_to_nonnull",	"ext_mem",	    "tc_prog", "mem", "mem_nonnull" },
+	{ "attach_nonnull_to_nullable",	"ext_mem_nonnull",  "tc_prog", "mem_nonnull", "mem", 2 },
+};
+
+static void run_test(struct freplace_args_tgt *tgt_skel, const struct test *t)
+{
+	struct bpf_program *ext, *tgt;
+	struct freplace_args *skel;
+	char log[4096], msg[128];
+	struct bpf_link *link;
+	int err;
+
+	skel = freplace_args__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+
+	ext = bpf_object__find_program_by_name(skel->obj, t->ext);
+	tgt = bpf_object__find_program_by_name(tgt_skel->obj, t->tgt);
+	if (!ASSERT_OK_PTR(ext, "ext") || !ASSERT_OK_PTR(tgt, "tgt"))
+		goto out;
+
+	log[0] = '\0';
+	bpf_program__set_autoload(ext, true);
+	/* libbpf prints the log of a load that fails and must not */
+	if (t->bad_reg && !t->func2)
+		bpf_program__set_log_buf(ext, log, sizeof(log));
+	err = bpf_program__set_attach_target(ext, bpf_program__fd(tgt), t->func);
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	err = freplace_args__load(skel);
+	if (t->bad_reg && !t->func2) {
+		snprintf(msg, sizeof(msg),
+			 "Extension program's argument in R%d is incompatible with original",
+			 t->bad_reg);
+		if (ASSERT_ERR(err, "load"))
+			ASSERT_HAS_SUBSTR(log, msg, "log");
+		goto out;
+	}
+	if (!ASSERT_OK(err, "load") || !t->func2)
+		goto out;
+
+	link = bpf_program__attach_freplace(ext, bpf_program__fd(tgt), t->func2);
+	ASSERT_EQ(libbpf_get_error(link), t->bad_reg ? -EINVAL : 0, "attach");
+	bpf_link__destroy(link);
+out:
+	freplace_args__destroy(skel);
+}
+
+void test_freplace_args(void)
+{
+	struct freplace_args_tgt *tgt_skel;
+	int i;
+
+	tgt_skel = freplace_args_tgt__open_and_load();
+	if (!ASSERT_OK_PTR(tgt_skel, "tgt_open_and_load"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (test__start_subtest(tests[i].name))
+			run_test(tgt_skel, &tests[i]);
+	}
+
+	freplace_args_tgt__destroy(tgt_skel);
+}
\ No newline at end of file
diff --git a/tools/testing/selftests/bpf/progs/freplace_args.c b/tools/testing/selftests/bpf/progs/freplace_args.c
new file mode 100644
index 000000000000..6e8f16bd5d8e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_args.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+/* In freplace_args_tgt.c each of them has 16 bytes. */
+struct buf { __u64 v[2]; };
+struct larger { __u64 v[4]; };
+struct smaller { __u64 v[1]; };
+struct tp_ctx { __u64 v[2]; };
+
+SEC("?freplace")
+int ext_mem(int a, struct buf *p)
+{
+	return 0;
+}
+
+SEC("?freplace")
+int ext_mem_nonnull(int a, struct buf *p __arg_nonnull)
+{
+	return 0;
+}
+
+SEC("?freplace")
+int ext_mem_larger(struct larger *p)
+{
+	return 0;
+}
+
+SEC("?freplace")
+int ext_mem_smaller(struct smaller *p)
+{
+	return 0;
+}
+
+SEC("?freplace")
+int ext_task_trusted(struct task_struct *t __arg_trusted)
+{
+	return 0;
+}
+
+SEC("?freplace")
+int ext_skb_ctx(struct __sk_buff *skb __arg_ctx)
+{
+	return 0;
+}
+
+SEC("?freplace")
+int ext_tp_mem(struct tp_ctx *p)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/freplace_args_tgt.c b/tools/testing/selftests/bpf/progs/freplace_args_tgt.c
new file mode 100644
index 000000000000..4f1d1d3d2891
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/freplace_args_tgt.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+/* In freplace_args.c 'larger' has 32 bytes and 'smaller' has 8 bytes. */
+struct buf { __u64 v[2]; };
+struct larger { __u64 v[2]; };
+struct smaller { __u64 v[2]; };
+struct tp_ctx { __u64 v[2]; };
+
+__weak int mem(int a, struct buf *p)
+{
+	return 0;
+}
+
+__weak int mem_nonnull(int a, struct buf *p __arg_nonnull)
+{
+	return 0;
+}
+
+__weak int mem_larger(struct larger *p)
+{
+	return 0;
+}
+
+__weak int mem_smaller(struct smaller *p)
+{
+	return 0;
+}
+
+/* No tag: memory of the size of the struct. */
+__weak int task_mem(struct task_struct *t)
+{
+	return 0;
+}
+
+__weak int task_trusted(struct task_struct *t __arg_trusted)
+{
+	return 0;
+}
+
+__weak int skb_ctx(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+SEC("tc")
+int tc_prog(struct __sk_buff *skb)
+{
+	struct smaller smaller = {};
+	struct larger larger = {};
+	struct buf buf = {};
+
+	return mem(0, &buf) + mem_nonnull(0, &buf) + mem_larger(&larger) + mem_smaller(&smaller) +
+	       task_mem(NULL) + task_trusted(bpf_get_current_task_btf()) + skb_ctx(skb);
+}
+
+/* In a tracepoint prog the tag makes a context of any struct. */
+__weak int tagged_ctx(struct tp_ctx *ctx __arg_ctx)
+{
+	return 0;
+}
+
+SEC("tracepoint")
+int tp_prog(void *ctx)
+{
+	return tagged_ctx(ctx);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

