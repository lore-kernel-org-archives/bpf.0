Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B856F440630
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790292702; cv=none; b=AEmmDqzdOwxIEeXsxAKT/zTcAkO+beVW3chzH7PX3Qp0ZjeaTKPFMBa6ie6KvTYvgusAg8MkqSKxoyhZBeO4eewm9fs3eofZt2KSLPJRmb3Bp57qOBcjIAdAhza8it6y8L/ThhoWRwho/NTRgbqrM8bij0v89QV7S+FYYUNslbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790292702; c=relaxed/simple;
	bh=ot5f6o9eBqT06pIeeBauRQm2TfSZGSLTs39Oq32sRBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGqcOIZqXxowJCTE4R0c6MLv9rpnSX1zXQLs2urnMRz2LaJT127x+goOpA9YH5OTItODlFTqVGndzVA2gcslzXn0Wmjv6SReaE4DFA02v2THIg3yUpf6OZbAgVrZPR7TMGJB6lZcKSR13+bjEaIqETuWeJpLCvEyhyPnDCM23WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx355qjd; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx355qjd"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f7so1185435ad.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790292700; x=1790897500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lLrTGLs6hSgHWXCAg2c6arWE9tEPLvC72NTieQoy3hE=;
        b=fx355qjd2BFGECcPhfDEj6eZhW3+tPI0V/AxhH3FhthDTXv8CENdW1XdNVPHzrllYk
         TYyAttzDptomkLETupW5Yq2O07HIMGmQbJsX8XuFBAAYF8ktsbWKq8yHudmMQCxdCu09
         XtaXDfnqhLMyhTMrYuwB/ewPcTwdjDcu2a8dm0B+ts33r/qcBdT8yjdS9xcn0sOXAFAD
         iTiQwOk0yzdDRe308W5adaO3UQTgaHACRIg5F9+Yaqu2Ob3QFicbx54yyt2wLAz0W/O+
         oeuCAFE9cnSIg2WMZ5r8x6ExCNiPggp681d9uzds96FSiyV3EU/MO/6rZu/IWWwS2/XQ
         dRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790292700; x=1790897500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lLrTGLs6hSgHWXCAg2c6arWE9tEPLvC72NTieQoy3hE=;
        b=VmorkOyNFhIbK4hHS1RUM91OJy6b3921jkB5HhsI4wnbHUsBURWOppA5hwqc6NeHze
         JMER3dJq73xyIYDJKIw21IMv84OnNY3y5tPaZaL0esR30wRphnWX8k2eaeEje/BoHOPT
         b3NV4XmAa+UQ/SWpHKaDeTNBcFGZI17amkF7h5ktNzInJqwUT408qyqv4aayglT5H6M9
         7sfRO+LrvOHkmj/9cAgnd7UrZSy/y/1g7Gbzw2urPAZmZ1BYc7RuB2ry/fsTSQUOvRZa
         TM80syo3YzcNOOv1gMHJA0djjyCDATinXyfes66J1Kc3363lFS7phQYvqdFMBs4s6TcA
         3lGg==
X-Gm-Message-State: AFuF++mcgLBFnRs4HUE632Cb2a9EO3CWvNSZAssX3rXdiAaW9T1b9tfP
	fpE49B1WsVee5KFrEO72e7BCEUrZa7GUO8zumKxMpl7xYq4cy920l11cOj/iZA==
X-Gm-Gg: AYBFou0yZXttA4cQtCD15wdXuE1C0EfQN9Khq7cvDw2ALq/D194dHbuP29ZUczDV9MA
	wHSiZVmgDzc6H9n1iglAwqZyt6LD1uHrPSDy/BfbzsKvnNIcO4DaD7Mdj/IEMa6267gOhF8iLcG
	EA3FKYMdL/OKkVNLl2dKzaFQGTeCjBMEjp4anIP1kZM17KyXZ4pChVhPibxHyLoSiVb0P52TE7V
	u65bbk10W+7ilZJqjXGUHylr+PyGsWYD5pD9WAXxDBYKxbBIOea5ERU1TLdrGMIAoQGAC5yVGIR
	ea8q/BhLAu79DWB4paKq1Ir08+UiFKWV+giq8jfz2PPFaYtjHpFhX8ztFlDEEBSW+xFRGCQ+tD1
	BXsiabCvliabzrKFBXnkjiRDazm+VW9+6RVhuqcbpi2i8q6CTJbRmJD+rVNUTVB2tvCBixUlQjn
	B6PEcCycIPuSJWI01dTs+iLuc7HPm9YKvpNmbUDs+gFnIJ+bb7a6Pv3Jw7VL8MbYbuGhpRSC9s/
	jKxSmMbS724mJJ9RvXQpQxG4GSj64U0O+pKaLwbDrF3WpyffioCX5+dqlKv5bSEiUPgemTr6mkG
	x0KnFM3rwITtrevwgVm9ZTFXbaMlQrMZ3mZeuoddJnY=
X-Received: by 2002:a17:903:19cb:b0:2dd:c0ff:e724 with SMTP id d9443c01a7336-2df7dfd60fcmr33860045ad.54.1790292699772;
        Thu, 24 Sep 2026 16:31:39 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91464979sm1980755ad.77.2026.09.24.16.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:31:39 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/8] selftests/bpf: Add test for timed may_goto with private stack
Date: Thu, 24 Sep 2026 23:31:24 +0000
Message-ID: <20260924233130.1213812-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
References: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Run fentry progs with 64 and 128 bytes of stack that loop until
may_goto expires. Check that r0-r5 are intact after the loop and that
it made more than 65535 iterations.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/may_goto_priv_stack.c      | 41 +++++++++++++++
 .../selftests/bpf/progs/may_goto_priv_stack.c | 52 +++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/may_goto_priv_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/may_goto_priv_stack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/may_goto_priv_stack.c b/tools/testing/selftests/bpf/prog_tests/may_goto_priv_stack.c
new file mode 100644
index 000000000000..4f8476d36250
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/may_goto_priv_stack.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "may_goto_priv_stack.skel.h"
+
+static void check_regs(__u64 *regs)
+{
+	int i;
+
+	for (i = 0; i < 6; i++)
+		ASSERT_EQ(regs[i], 0, "reg");
+	/* count is refreshed at least once when may_goto is timed */
+	ASSERT_GT(regs[6], 0xffff, "iterations");
+}
+
+void test_may_goto_priv_stack(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct may_goto_priv_stack *skel;
+	int err;
+
+	skel = may_goto_priv_stack__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	err = may_goto_priv_stack__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto out;
+
+	memset(skel->bss->regs_64, 0xff, sizeof(skel->bss->regs_64));
+	memset(skel->bss->regs_128, 0xff, sizeof(skel->bss->regs_128));
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.priv_stack_64), &topts);
+	if (!ASSERT_OK(err, "test_run"))
+		goto out;
+
+	check_regs(skel->bss->regs_64);
+	check_regs(skel->bss->regs_128);
+out:
+	may_goto_priv_stack__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/may_goto_priv_stack.c b/tools/testing/selftests/bpf/progs/may_goto_priv_stack.c
new file mode 100644
index 000000000000..5c2aa0aa5055
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/may_goto_priv_stack.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+/* r0-r5 after the loop and the number of iterations */
+__u64 regs_64[7];
+__u64 regs_128[7];
+
+/*
+ * fentry prog with 64 or more bytes of stack uses private stack.
+ * Loop until may_goto expires. r0-r5 should stay zero.
+ */
+#define TIMED_MAY_GOTO_PRIV_STACK(size, func)				\
+SEC("fentry/" #func)							\
+__naked void priv_stack_##size(void)					\
+{									\
+	asm volatile (							\
+	"r6 = 0;"							\
+	"*(u64 *)(r10 - " #size ") = r6;"				\
+	"r7 = %[regs] ll;"						\
+	"r0 = 0;"							\
+	"r1 = 0;"							\
+	"r2 = 0;"							\
+	"r3 = 0;"							\
+	"r4 = 0;"							\
+	"r5 = 0;"							\
+"1:"									\
+	".8byte %[may_goto];"						\
+	"r6 += 1;"							\
+	"goto 1b;"							\
+	"*(u64 *)(r7 + 0) = r0;"					\
+	"*(u64 *)(r7 + 8) = r1;"					\
+	"*(u64 *)(r7 + 16) = r2;"					\
+	"*(u64 *)(r7 + 24) = r3;"					\
+	"*(u64 *)(r7 + 32) = r4;"					\
+	"*(u64 *)(r7 + 40) = r5;"					\
+	"*(u64 *)(r7 + 48) = r6;"					\
+	"r0 = 0;"							\
+	"exit;"								\
+	:								\
+	: [regs]"i"(&regs_##size),					\
+	  __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 2, 0)) \
+	: __clobber_all);						\
+}
+
+TIMED_MAY_GOTO_PRIV_STACK(64, bpf_fentry_test1)
+TIMED_MAY_GOTO_PRIV_STACK(128, bpf_fentry_test2)
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

