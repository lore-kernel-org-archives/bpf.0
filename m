Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C32D781B
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149619; cv=none; b=ruHnQS0u4TxXOmvpysOTlO1O0jQ7WxUA+pusiTkT59TTKPX+osoKEndasuxVcgFIkDc217nlBlmhz6iDOlcePGyny5XmB3u18uRhTn1gxoORjpg7yofSnKDrbbFv1ZBrRcLRsMpcfdhvgvr1YHwq+9IFEE+u1VcLQn/ea4yG22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149619; c=relaxed/simple;
	bh=5bTBKNf3IPeW3myyGQNQiNrcZXPHCg4BTyptbKTLOGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXwNsKryQbyqlvGmJfIIN+NxyAAiy5e9ioib5BIUtsV+3Q7deaCpH432JiKLa7OUbyi8RJl1A6ejGZo1KzErGg8cobTt7c7PTaz6Rsc8h3Os40wBVd7DMCKS//6tNDXuSTS33hWHO+ESIdknvtxefYRoYGksUK7NWOJWpW9hMsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYPbZ10Q; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYPbZ10Q"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-456b64704b4so31840fac.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149617; x=1786754417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yoi694xuwMzrhceQZpa9JbKjIsDQtibbCuzD2TzXXis=;
        b=rYPbZ10QGSNyM4BR3e4lmS11/1obTuU3eqLtBgTy3AOdVYcPzYvUQeDDvR84pKsbu8
         7mv1QtSmgdrsPsWz/hDJZu3uplFnPim65H+HLxlqzgxrFr+MMdqTbTAqXxvpp87GFDKu
         XB/IhjYpMCuarRQIijtE8qa/RBMZVKmlHh/ev3IWMo5zmvNoFx4oS/NLAf/646BKzm2d
         QwbN3NlSflUc/pxpcWB1nT15ZlmGNnrqA2CqiIoYayoE61SFOewf81N0BxpEcocKP0Yz
         iFVj3HFcd1r31+m5fNUlFr3b3TVHff0575Itj1/LY91om/3bl5X1K9lSoiSMZ21cVqiC
         S70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149617; x=1786754417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yoi694xuwMzrhceQZpa9JbKjIsDQtibbCuzD2TzXXis=;
        b=MglM9JJ8k/ySHcxDdo0QMN6lt0d6RcyyEblVBXfFl8IX5wtjalsQbCk2b+Om9BnDTM
         jDq5aVkHoIuhe60z5Dq1Y2VQriWwlRj4uRIHtCJ3OZXnaEEiTeR2C0GmQi4XTGaBMvec
         oQpi/ra9NJ48iwOE6z+2gWeeyeIIKL+rRfv962Os+ul6ikENNu8wolkbTDKKmJOBgVa1
         4/ghP6rxwUG5DFbAeTSYp2xlMjujIDKpRebnpG1kYbk5K+wqCxP58RIQpAp4CUuDQTrY
         4JmdF2wMWd2aUv3w7GZ4Wj/NlSJ6t2RgOEF3S1megPPyxtgJZMZIOYMlYcqMwrjK35xh
         RKig==
X-Gm-Message-State: AOJu0YyH1eR1jWTNngpB0RZrB/8XEy5W+Q4e+A0HCaTp7f9QoguKx/c0
	Qva0S2FN+cQd+UVNh5bCKzHqAbQmrOfIYFLCJPII1R6KOe8K8tKFBcGt6yDYxRilLBY=
X-Gm-Gg: AR+sD12hvx0V7eWNAru+VuHzGDpJabpjhAqqPGPRQj7mb0bgeIOmFOnYsBCgi+Rqi73
	rDKAmmedZVSaSVkFGZlQNR1DF9phiObB3AEpayzSCLCWufwn/GTEFq4X24YCWGRcNRDk2QaPrwp
	tiMbZxXnqCr5aVqpQiou+IglDXOQdtwe5fn+lli9FGTTR2/q0/0QxfqhDa7v7aQni3Od0dX7tLb
	ulFreWQiBCsyVlejvqtrUBK7jpiXOyaO2MWnMvaz2CyyLUT+h4ZblccKqpcQsd4I//YN9/wMo5+
	GQTi0SP8MLemr/LWyVC1rTp4hHQAUw2ITh3W6+d+9IhzIg3qcag1gMJ7kfyyJDts48n4ly6du2u
	BAZb08bTvzoYI9I1b0oYqoxFK6wQyzrOaBVNLKUYT2Iu6I8hlLicO8RTTgSmtlbPLQ58ep5Ha4C
	OIeyMKrKyLnDIyZjMBDOkUayRXaQAEGSIH54OjY1VNk+dSAAwOGlPq5oLpFnHiX4vR3qFDC90CX
	+SXONB2Q0ljcWChLZhB2KpVwzpdJH0nlart2rSv+jawfmQc+auA3jLyWViqFJ+aY/wdOjA=
X-Received: by 2002:a05:6870:1401:b0:447:559a:29a0 with SMTP id 586e51a60fabf-459ff0d7418mr3762046fac.0.1786149617175;
        Fri, 07 Aug 2026 17:40:17 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1a88ef6sm3036897fac.8.2026.08.07.17.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:40:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 14/14] selftests/bpf: Test attach rejection for struct_ops arena programs
Date: Sat,  8 Aug 2026 02:39:34 +0200
Message-ID: <20260808003938.3486067-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3799; h=from:subject; bh=5bTBKNf3IPeW3myyGQNQiNrcZXPHCg4BTyptbKTLOGk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqsqm83vyk/dXGBT8iiZzXX2RsTSt8dneiOz02Wr2Wp/u MCt3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCKS7xkZPvmvjnsXwMV/3vvFl9bYVw svH5qfPDF0jrFCi4noKpYyN4Z/KtzCKhF7vTmPvtLK3yueonS0MMpbvuTq/QvHZrMI/nzMDQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise fentry, fexit, and freplace programs that target a struct_ops
callback with an arena context argument. Verify each load is rejected with
-EOPNOTSUPP and the arena-specific verifier diagnostic.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_arena.c    | 54 +++++++++++++++++++
 .../bpf/progs/struct_ops_arena_attach.c       | 25 +++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_attach.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
index 323d707c543f..940ec2cda0d5 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 
 #include "struct_ops_arena.skel.h"
+#include "struct_ops_arena_attach.skel.h"
 #include "struct_ops_arena_fail.skel.h"
 
 #if defined(__x86_64__)
@@ -49,6 +50,57 @@ static void arena_arg_fail(void)
 
 	struct_ops_arena_fail__destroy(skel);
 }
+
+static void arena_arg_attach_one(int target_fd, const char *prog_name)
+{
+	struct struct_ops_arena_attach *skel;
+	struct bpf_program *prog, *pos;
+	char log_buf[64 * 1024];
+	int err;
+
+	skel = struct_ops_arena_attach__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_arena_attach__open"))
+		return;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, prog_name))
+		goto out;
+
+	bpf_object__for_each_program(pos, skel->obj)
+		bpf_program__set_autoload(pos, pos == prog);
+
+	err = bpf_program__set_attach_target(prog, target_fd, "test_arena_cb");
+	if (!ASSERT_OK(err, "set_attach_target"))
+		goto out;
+
+	log_buf[0] = '\0';
+	bpf_program__set_log_buf(prog, log_buf, sizeof(log_buf));
+	err = struct_ops_arena_attach__load(skel);
+
+	ASSERT_EQ(err, -EOPNOTSUPP, prog_name);
+	ASSERT_HAS_SUBSTR(log_buf, "Cannot attach to a target with arena context arguments",
+			  "verifier_log");
+
+out:
+	struct_ops_arena_attach__destroy(skel);
+}
+
+static void arena_arg_attach(void)
+{
+	struct struct_ops_arena *skel;
+	int target_fd;
+
+	skel = struct_ops_arena__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_arena__open_and_load"))
+		return;
+
+	target_fd = bpf_program__fd(skel->progs.test_arena_cb);
+	arena_arg_attach_one(target_fd, "fentry_test_arena");
+	arena_arg_attach_one(target_fd, "fexit_test_arena");
+	arena_arg_attach_one(target_fd, "freplace_test_arena");
+
+	struct_ops_arena__destroy(skel);
+}
 #endif
 
 /*
@@ -68,6 +120,8 @@ void serial_test_struct_ops_arena(void)
 		arena_arg();
 	if (test__start_subtest("arena_arg_fail"))
 		arena_arg_fail();
+	if (test__start_subtest("arena_arg_attach"))
+		arena_arg_attach();
 #else
 	test__skip();
 #endif
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_attach.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_attach.c
new file mode 100644
index 000000000000..081a770307e5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_attach.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("fentry")
+int BPF_PROG(fentry_test_arena, unsigned long long *st_ops_ctx)
+{
+	return 0;
+}
+
+SEC("fexit")
+int BPF_PROG(fexit_test_arena, unsigned long long *st_ops_ctx, int ret)
+{
+	return 0;
+}
+
+SEC("freplace")
+int freplace_test_arena(unsigned long long *st_ops_ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0-Meta

