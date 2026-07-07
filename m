Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BB6360ED0
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450941; cv=none; b=gyWzNuzJctBuimDHCIXFSGmJsnyVUJ/v/gXNRFkN+QLH+slfS/ZfUZB374Jd9hdZBB2piyQXhq5/fizA1jDUR3VnXh9p8+BrxWbYZF41IMkSUyowyCm9OZv+MY3knJwtHFFQVwHRjY4X2F9lIHVKeMVaexMCqkENesb10hgTEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450941; c=relaxed/simple;
	bh=qVYd8W/V96ViW8gWnUTEZ1mcDFE55CY8/nfB0eBUtkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oN0PUUiw1NzOXDcpTTId8RJaU4b2BuAhNIIh2sWMKFGp69aF++LT9PxvRyj11wkuTAnWZH82ngydVZbSCg8pM18djzLDLfsNA4sgHKMhEBCkJNCN8n0SmayDd+WAsmTxLu0nui+36esrVMdeaZ6jArI2eLjNhPXeFLJdZvjcnZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+1faKeT; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+1faKeT"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so6996965e9.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783450939; x=1784055739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGkI3pKZiTR9zzvyF3/uhJjXj1WLqR3GLkFD+J7ID/8=;
        b=B+1faKeTtEml3WG7M3vnHbhOfGmJ6JaqRjX+dhmFibmatetkSP6jePek+Rlcgoe+Gy
         ef32JmDHSihmVZYY83q7IeWjjQ3lNVpGKhDO/rzlpQjvfAWrA6etw7+2DBtXgIWtcUbH
         hsS1B8XtIKH53MYDF0Y8qdQj1dc6Zv1EIyEtPm3xwVdCqstW/i1no1FpwHnAYvu2+dG3
         4fwy/SE9JggzdaluK7Lvu0xfp5U/Hv2dRq7RSfkfCgp3iT50lFiwleTCn2wiU78pyiz1
         sKUNBkGfpyWLXi3LUdfRkKGSb23ADFj2LUSVLBxwt22PutSrYNjBOjTj/GBqWKY8+ZUz
         Kw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783450939; x=1784055739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZGkI3pKZiTR9zzvyF3/uhJjXj1WLqR3GLkFD+J7ID/8=;
        b=FdcrPZ45lX1v9I36bWj9NKdAeJm+/F4CMR1kgslgzeX6HHFLLClX6uuSUMWrEDQixx
         qT30MXh73zXnJGMDU6Il6haE5dwnJIDbJnS8LSWBURmT6Z8TJqJvha0hkFHHSt2BnwEV
         1DWjaVMowhMkEUB74GgadkTmWdqsvJAXR/igTt6ZJLucC7DUQmbkMRTt1who/7Zyf5+X
         LJ7daB1zUEAU3Lk+HxYrBdcA05sbdi4UnXDN+oKt3av4LOCpgaJNJnCikCFQhEl+iZ5r
         RiCP/ccNEewAGapjUVaYQHefOeUngj5sIQFcGh/hHu5gblNye2w2UdjMo/ikIP5lBzMW
         WTOw==
X-Gm-Message-State: AOJu0Yyuw7/WPsQ+1s3oPMPsaLJvJeFys3uRBIu9bPtEOgokgdQm6daD
	tvgIxRWpwr3Af4HKyD1m5BtAZSKHxmRUs+SO6Ieqb94ZjoPRv6eTEF6JGxaLvcmH
X-Gm-Gg: AfdE7cmCaX1YM/yg8NgeBhI7ktfAg6rLwtinKBNaZyA+bTD3caEMfSe9yv1ikoLDWBl
	Pu75KSS/nRr+Oibesc28G15tXHZMEdM1wchj8HoElOICr6P4fUj1FLSJU6Rg6vNPwXhnmKZpEvh
	u94nSUS1xTvEoFshHKPl04BVxTd1jwDwplO/jNaEJl30qrE6og3k3+QxMb2R9KhvSZxFF4UrK2M
	bxCoXlFCSYil4f4mhyHYcs3yJNKyzAi4sUlI+uglNFLZEuB1fiHGmrR0eY540b5xyTscFIHhT5m
	PerKUwpvA/tdady7cg43mH1ufn/3asHO/hNM85cDagCdAIuY92e1wPq5mxxh6OFVMUatXtCMy3s
	mNX77FJ4oU96e8Cv9DIc1uFyXcRg0J4bHJ6fe2Q19CoUojM0L+mtSArcqHE+gKsqBFxTQlFvW/X
	yiuem9WasfYcKcQGJQWF+p6UYXhbBoffY3dK7YqGDz7LxUPGfNoHtbj7P7UNzW6hAJiGmDRiWnA
	N6knhqx5G2XlpwB14XIXvBhgyfJuIrC65f7DsLYQSx4aZq3GTuJgDM=
X-Received: by 2002:a05:600c:1d1a:b0:493:d078:796 with SMTP id 5b1f17b1804b1-493df092921mr81945795e9.17.1783450938476;
        Tue, 07 Jul 2026 12:02:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0ebf593sm80166525e9.0.2026.07.07.12.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:02:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add untrusted BTF write regression
Date: Tue,  7 Jul 2026 21:02:13 +0200
Message-ID: <20260707190214.1997705-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707190214.1997705-1-memxor@gmail.com>
References: <20260707190214.1997705-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2861; i=memxor@gmail.com; h=from:subject; bh=qVYd8W/V96ViW8gWnUTEZ1mcDFE55CY8/nfB0eBUtkM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIcvXp+DTrrtGqldc7qZ1T9P/wx+bUXBK/KyyYNZBfS3xk BbVKawdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMjpX4wM8/eHu9kyW5257v19 a+HclVf2/RHnjf/NKs/Y02x1aV69PiPDrpnNX+ceE/7RFVPVcqtqs53E6ZCuLXU5czfNfNQu5Wb JCQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a TCP congestion-control struct_ops load test for a write through a
BTF pointer produced by bpf_rdonly_cast().

The test expects the verifier to reject the program before the TCP CA
btf_struct_access callback can whitelist the tcp_sock field write.

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

