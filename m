Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B842314A
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602308; cv=none; b=MEPa/t40pisyhk9/IMnrDS1Ul8DgFEJ/BC9APieXTfAL9rFiDzsaJm1ywqUwvGrIl7wenL52PAKpgYN2sGEkh0gL7Lf/xIBeg5gIGrwxMcHYemYpw47d0XWl2kVn47cRd7tKBzoRUazOc2qWBSuTTH0fTnc/4I4DvchUKqGa6vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602308; c=relaxed/simple;
	bh=masccS+7veDUie+oWDi6NRulf6w+dIgm7hvvOnWqGTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPFCyNQgbMioiSufvk0m1FKbAQxcaqdbvcXqBpdHXW9PfM3iz9eKgxQToBxBrYq6kkEDqgOVCd/AS0Z3pxD+nLR+1BCoteR3VOgTXw0OeSpe1XPqSoT375prypvEdCX6S9LZIJvrqprCURrTwCxD7BZ+HtZ7vkNCzAh2rYFgBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf/DI4db; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf/DI4db"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0b944f6edso44208905ad.2
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 02:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781602307; x=1782207107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpDob04Du+/4G79ElledxXfX7TMGsPEaydT5UDTPkDw=;
        b=Lf/DI4dbpon05Oqg6jCyTzWBgLpS34NQWCYnl5E6urkLgu1uhu5DJTxEfI8kc2wPz9
         raBvXD+SlUygQza4wcfkVN8Va6TXk4XZ8+w4BeVJYfQY+C3ZjhSYuV8NP92aF+XyY2MK
         4YBKi/eeyMHvN5z54iKcg5kEL3iJLfRXeReLIgvx0GOTYtW54Slm2C4Q8/hoDH5IN3QR
         EQTK2ck4vRX/UK8dOLLJnthJYAzk5mML3aehjvdSnMVxQMnTuucGX+lQSgBI/NEzi+uk
         lew+F1tW60CS3OjeMdRD+zDRgCNBNLWz3WvFLTfxYixoewTv797QVGAFuBe8Coa1bWn0
         z2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781602307; x=1782207107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpDob04Du+/4G79ElledxXfX7TMGsPEaydT5UDTPkDw=;
        b=poF9lUiX17pozBdupT6j3/gUif0NHWmAZjWAdvPaVQA3cU43CmPA9iJxJZ/H33rB+d
         5CTYvqGReced6QlA9St/oHZS0bDMnesRITi8asO7PfE9AgcabQNLj/xWtGfGTimnRJDi
         YZLoOijecLzbYbacQ0s8m+KnwWd8sSKwKduSyb4Mr/EQzFAF/X591jqGn9rMhgMgCBm1
         4fK8hJmEhYLBqgSwfEbGCsvFuxdxLjTPf8FhlezHttQ6XpJ+JpzgqVpub5q+UkhP1nU9
         tfJD7i0l14avURqV1LEmRX1i1IlgsyIbpw9QpJdo6lWexnE5YVWjVTHjc86lmpkIbQFS
         4I7g==
X-Gm-Message-State: AOJu0YxhnQFEOiGUJ6Zh0d6DTHmVhtboLOo4k9twnoyJdN89gQEAlRjB
	73RZgKvb0GyZfF72ZYPPPTDEbQhD91DE2PYHfPkK4jvBQceRfb7tng5lTT/zY17uXac=
X-Gm-Gg: Acq92OHguj/XWCP0h1gPNrgx6qgNq+lJE9jeyfoZ61A3n+mjanW6jEzpyP+95q1D6Bc
	g/lH0D+CZt5f1Y1pbGjQLtZtYj3w5myAtFwjZjYwQyC4EYMqqctBE1aFYdztDPWjJASndlts1jX
	kREOnNXAdh1XGr63N2b+PrTmj1O0jkc54TLx59VmNBNcBAmBvDjw5Ep5iNMGeS/qbRNOc19WkiA
	6b5TgjkxW4VWs5Vrds98PNesOVzhM6Hs6KwegqzcDgYWBc/KV3TZyLBF2qZ0Vw7ajip7hla24iA
	ByD9pONVFWlEHhx26DHK4bxwKfJxLAN7vQxvctCj2DOCt8MKLDSYZNMYJg9LedgvPJDvRpgCOrx
	7enN7pyBnQeVhOgSlTUxe3xqtOp2vUnDb882q0MLQGUYTdk2LMFejP26FFbxjaL8zA0AF2gIc32
	6Od8wzMZjQW+fSyJ7L7KZROlrrMeDFdkUyqoxw2ElGqGaJmoV1ZAQhlS+Jn53LDMQ=
X-Received: by 2002:a17:903:37c5:b0:2bf:2114:ecbe with SMTP id d9443c01a7336-2c664243261mr168196865ad.23.1781602306778;
        Tue, 16 Jun 2026 02:31:46 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::209f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c6c52sm127329545ad.22.2026.06.16.02.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:31:46 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	toke@redhat.com,
	lorenzo@kernel.org,
	paul.chaignon@gmail.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Cover partial copy of non-linear test_run output
Date: Tue, 16 Jun 2026 17:31:03 +0800
Message-ID: <20260616093103.471444-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
References: <20260616093103.471444-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prog_run_opts already verifies that BPF_PROG_TEST_RUN returns -ENOSPC
for a short data_out buffer while still reporting the full output size
through data_size_out.

Add the same coverage for non-linear test_run output. Use pass-through
TC and XDP programs with a 9000-byte packet, a 64-byte linear data area,
and a 100-byte data_out buffer. The expected output spans both the linear
data and the first fragment.

Verify that test_run returns -ENOSPC, reports the full packet length
through data_size_out, and copies the packet prefix into data_out for
both non-linear skb and XDP frags paths.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/prog_run_opts.c  | 72 +++++++++++++++++++
 .../selftests/bpf/progs/test_pkt_access.c     | 12 ++++
 2 files changed, 84 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
index 01f1d1b6715a..71af1ff02023 100644
--- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
@@ -4,6 +4,10 @@
 
 #include "test_pkt_access.skel.h"
 
+#define NONLINEAR_PKT_LEN 9000
+#define NONLINEAR_LINEAR_DATA_LEN 64
+#define SHORT_OUT_LEN 100
+
 static const __u32 duration;
 
 static void check_run_cnt(int prog_fd, __u64 run_cnt)
@@ -20,6 +24,71 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
 	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt, info.run_cnt);
 }
 
+static void init_pkt(__u8 *pkt, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		pkt[i] = i & 0xff;
+}
+
+static void test_skb_nonlinear_data_out_partial(struct test_pkt_access *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	__u8 pkt[NONLINEAR_PKT_LEN];
+	__u8 out[SHORT_OUT_LEN];
+	struct __sk_buff skb = {};
+	int prog_fd, err;
+
+	init_pkt(pkt, sizeof(pkt));
+	memset(out, 0xa5, sizeof(out));
+
+	skb.data_end = NONLINEAR_LINEAR_DATA_LEN;
+
+	topts.data_in = pkt;
+	topts.data_size_in = sizeof(pkt);
+	topts.data_out = out;
+	topts.data_size_out = sizeof(out);
+	topts.ctx_in = &skb;
+	topts.ctx_size_in = sizeof(skb);
+
+	prog_fd = bpf_program__fd(skel->progs.tc_pass_prog);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+
+	ASSERT_EQ(err, -ENOSPC, "skb_nonlinear_partial_err");
+	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "skb_nonlinear_partial_data_size_out");
+	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "skb_nonlinear_partial_data_out");
+}
+
+static void test_xdp_nonlinear_data_out_partial(struct test_pkt_access *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	__u8 pkt[NONLINEAR_PKT_LEN];
+	__u8 out[SHORT_OUT_LEN];
+	struct xdp_md ctx = {};
+	int prog_fd, err;
+
+	init_pkt(pkt, sizeof(pkt));
+	memset(out, 0xa5, sizeof(out));
+
+	ctx.data = 0;
+	ctx.data_end = NONLINEAR_LINEAR_DATA_LEN;
+
+	topts.data_in = pkt;
+	topts.data_size_in = sizeof(pkt);
+	topts.data_out = out;
+	topts.data_size_out = sizeof(out);
+	topts.ctx_in = &ctx;
+	topts.ctx_size_in = sizeof(ctx);
+
+	prog_fd = bpf_program__fd(skel->progs.xdp_frags_pass_prog);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+
+	ASSERT_EQ(err, -ENOSPC, "xdp_nonlinear_partial_err");
+	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "xdp_nonlinear_partial_data_size_out");
+	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "xdp_nonlinear_partial_data_out");
+}
+
 void test_prog_run_opts(void)
 {
 	struct test_pkt_access *skel;
@@ -69,6 +138,9 @@ void test_prog_run_opts(void)
 	run_cnt += topts.repeat;
 	check_run_cnt(prog_fd, run_cnt);
 
+	test_skb_nonlinear_data_out_partial(skel);
+	test_xdp_nonlinear_data_out_partial(skel);
+
 cleanup:
 	if (skel)
 		test_pkt_access__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
index bce7173152c6..cd284401eebd 100644
--- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
+++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
@@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
 
 	return TC_ACT_UNSPEC;
 }
+
+SEC("tc")
+int tc_pass_prog(struct __sk_buff *skb)
+{
+	return TC_ACT_OK;
+}
+
+SEC("xdp.frags")
+int xdp_frags_pass_prog(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
-- 
2.43.0

