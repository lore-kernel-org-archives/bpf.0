Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D03403E9
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 03:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480078; cv=none; b=rF3jkWJIXWXQGT6vZliLKsoYSwkxJo8z9oAyr42Mq9XoKlu8Y9CvLQ+oCPYyhR5oGFaATkVd865UwFa7fErQmkyotwEMXJYdKld43AWLidf/zCMuH9cj9/kKMJCSI0sgKRhPEQLHbpGqhDg1YmA/bwSViA8TsPQWUvuzRS3qu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480078; c=relaxed/simple;
	bh=Gr1lgFO5IfJAmkYWIQNfxnFrJ7a9YsX3y0Aqb9YB9mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEHCFYIDhnd08FcdMzVpdbZSFlao61d28h+M8cvazXUvHTH8m7WNArX63CAg4nAsLO4Y1f/dwq1fgps63mjLjiXY5SjlRznqTcXejPbrUcLFz9R/gKFr9IM+nMQHezznsifJ4vmZhP2WtrbCfFdgmNcvU8uce4bw+4ccpHH1BsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dmhih6pV; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmhih6pV"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-493b4af7976so1032305e9.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 20:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783480075; x=1784084875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGmcA1aLFJN6GA64jJGITryMibNBJ8p/f1Uy7aaDWj4=;
        b=Dmhih6pVO5IN+hEqoeHk4QGfp5tKIk7HSZ+dehyd5wFTks8/lIuUGvOIbt/05szyea
         UJhvgUto2z1bVVXTE4Cw4m4fLBZnPY29EKYzMNNg0q37lrtpJ/At4P4KBOSIRs3S+07u
         qvym01fn6vVrGWjMIKdnSHVI+lVwe0H9iVggOWCxmZ9B75YVT12Qpm6XZ3tNuiFmi6NL
         a4dyTg6sXh5/vr9c4J0sxuxcloWKPS7XTH/xTnvQdpJNoYzjL3ex9JwU9ZjO818PY9D2
         Jc8WfulKpVKP8+0l8Ak2mQwq/LbsrZaA445buFuIJzB7f/7XND4WtI8oQr7ljzGYSu8A
         k44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783480075; x=1784084875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eGmcA1aLFJN6GA64jJGITryMibNBJ8p/f1Uy7aaDWj4=;
        b=j8xgb9k8taK3LnMqtSx70EhzAfE1yDh4v7vHmK6i2gnV0QA8l5YGrJHv6fle5B0qsZ
         CZAVO9+dfx+e+wBcy51hCJLBlHymAPate9GQuq+mU+GKt3iRimGzGnyMDi7QXdtFlrsT
         /rDCPq1u4YqmPAKK/badMuholOWLW5mJcKLigNlwTwnZ4Q7WqAEy2geYxbUck4DzZ8Mb
         ru9fOy75ND3AbIsSAI3ke51hpAqCwbBDE5j0NsEuZDkL+5QaIyIpeP8HwZ+9kNotb/3e
         J+wVGPUVEYe8/Kl7kRyBAar7VBt5f1pvB/DBYh90Ce79bZ8aXrvwOWfNZMLr9yFyb5YC
         FN6w==
X-Gm-Message-State: AOJu0YyEYFDO74Yj6MyLMssAECuV8RIli5VTSRR+hUEnQFoddxl0RrGx
	1fKbmnbF3e5aWTB1nxizcDmnfOGyKC3J93Tua/T/nXL3djKr6uvb1JYK4u875h8k
X-Gm-Gg: AfdE7cmRMCzTZ2K+zQZ2ys2a6IMSLleiHMQqoKEGPs1gkBLhKG2ix8JsjOd9NtIE2u8
	lOukp6Qhi8SC3TdSpq9Zucr5/GF3V9ni5tRia3GPEMv7elsH4WywmQNHxa6rqKvGuXVZmldI86D
	B+xPwXvgMZNktYqeC6FsOzG1ROs+uiYaoPUNm8jUl0ThEhUBfAXARf/FIiKRyTX0Z6DxfkvnXc4
	BQwFB+kai5WAyNSj2QMoF8x221MoCLB0MpQBOUDs3nNO1P++rnj+ZrXEG11YnDR5PHkV/ac23Pg
	x+hCExjCrtvAK7JOe+UGaZ1N4LGTab/1VyfZXWy7esiV63f/70y5dEGaiNSKxKh39LxcVCaMCVK
	CNxVsJgKbtLAGgc5GpTiB/qrytx9mwEfC8AupD3fuv5mr+e9R76ms9ywztc4gw31D+V0hnKmtRw
	NYq8W8De/2Bn2uF64q9qsTMEPuu5zPcw0Y47BiJAbzrDcyUtO8grEBxOtvshjBolA3dxqQck52B
	dAoP0hfx0U6UA+Qwjl5wlg0mueLjgDoqA0JfWqOaLmpV0g9RF9KVK4=
X-Received: by 2002:a05:600c:4fc6:b0:492:43d2:9e6e with SMTP id 5b1f17b1804b1-493e68391c1mr4871715e9.9.1783480075474;
        Tue, 07 Jul 2026 20:07:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm37652068f8f.33.2026.07.07.20.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:07:55 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Amery Hung <ameryhung@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add untrusted BTF write regression
Date: Wed,  8 Jul 2026 05:07:51 +0200
Message-ID: <20260708030752.2503467-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708030752.2503467-1-memxor@gmail.com>
References: <20260708030752.2503467-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2908; i=memxor@gmail.com; h=from:subject; bh=Gr1lgFO5IfJAmkYWIQNfxnFrJ7a9YsX3y0Aqb9YB9mE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct3370nC+/bec91VbyVyfNuQ/6+fv4bXfaFU4/035I7Y Gu9rbSvo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOZsZbhf9bCRYtafX7Hf+yO d9n7au9WtZmrVgqI+kd/neCcmXyWfQ/DH86Pkb7sRRdOMgslP2uMe3yl7HXmpVm108Qndp9ZOp+ vhA8A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a TCP congestion-control struct_ops load test for a write through a
BTF pointer produced by bpf_rdonly_cast().

The test expects the verifier to reject the program before the TCP CA
btf_struct_access callback can whitelist the tcp_sock field write.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 12 +++++++++
 .../bpf/progs/tcp_ca_untrusted_btf_write.c    | 26 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
index fe30181e6336..eb05fc82f81b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -14,6 +14,7 @@
 #include "tcp_ca_incompl_cong_ops.skel.h"
 #include "tcp_ca_unsupp_cong_op.skel.h"
 #include "tcp_ca_kfunc.skel.h"
+#include "tcp_ca_untrusted_btf_write.skel.h"
 #include "bpf_cc_cubic.skel.h"
 
 static const unsigned int total_bytes = 10 * 1024 * 1024;
@@ -579,6 +580,15 @@ static void test_tcp_ca_kfunc(void)
 	tcp_ca_kfunc__destroy(skel);
 }
 
+static void test_untrusted_btf_write(void)
+{
+	struct tcp_ca_untrusted_btf_write *skel;
+
+	skel = tcp_ca_untrusted_btf_write__open_and_load();
+	ASSERT_ERR_PTR(skel, "tcp_ca_untrusted_btf_write__open_and_load");
+	tcp_ca_untrusted_btf_write__destroy(skel);
+}
+
 static void test_cc_cubic(void)
 {
 	struct cb_opts cb_opts = {
@@ -637,6 +647,8 @@ void test_bpf_tcp_ca(void)
 		test_link_replace();
 	if (test__start_subtest("tcp_ca_kfunc"))
 		test_tcp_ca_kfunc();
+	if (test__start_subtest("untrusted_btf_write"))
+		test_untrusted_btf_write();
 	if (test__start_subtest("cc_cubic"))
 		test_cc_cubic();
 	if (test__start_subtest("dctcp_autoattach_map"))
diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write.c b/tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write.c
new file mode 100644
index 000000000000..eda4697aac80
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "bpf_tracing_net.h"
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops")
+void BPF_PROG(untrusted_btf_write_init, struct sock *sk)
+{
+	struct tcp_sock *tp;
+	int v = 1;
+	void *p;
+
+	p = bpf_rdonly_cast(&v, 0);
+	tp = bpf_rdonly_cast(p, bpf_core_type_id_kernel(struct tcp_sock));
+	tp->snd_cwnd = 1;
+}
+
+SEC(".struct_ops")
+struct tcp_congestion_ops untrusted_btf_write = {
+	.init = (void *)untrusted_btf_write_init,
+	.name = "bpf_ro_btf",
+};
-- 
2.53.0

