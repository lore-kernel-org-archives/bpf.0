Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D53537DE
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781850663; cv=none; b=ri3nowpYmoP8OrtW+1RYkcjjX/vTmlxgJggtx2kMB0OePcAyc0jpDrQAtWP0frxCb3agd7+Tp4R8pbFvgE5+HAis3uf2ofwgEY+6EQs0l8X6MRwQDlzIqNXPxupniaOgQ/MYIG3y/roPjiTeE20P2uPQ8w04sxKbN+Vzi5AXsvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781850663; c=relaxed/simple;
	bh=YS0u1EKD53vo2t6W+IEib8k/HgYIgbkb0atxBhbXQmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvzSusI7o8A5nv7WhErpnP4ZH2UDUKucyZ/hdQ5Ni68YGFFYhBKH+JhVraGU5TeTDSRccK4GdkNA91WHwT7SxvVIKG+eELHv7+8OaLNrOYpyzlamvrWa75W/e25EVOWx1J+5ZPKraQEnzf5dTgwKJmGhpABe3qCs4ncg6lNLXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F01I2N3G; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F01I2N3G"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8422871b42dso1243070b3a.3
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 23:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781850662; x=1782455462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cYyaGPf1aE+4RqqUs8yjO/wC6Ni+rND+DrZOmahUAI=;
        b=F01I2N3Gsz2fPxhJFaz/zd7SIEU2U28sa00lnrMprURx3igiDP9Hl0nXV9WmO/nOEl
         +E8qZhbJHd/jjTlSIJ1VDZe/6I2zbdoaBLuvRAUTWNfY0iQnm4cFF0meFPrzBm1UgKw6
         rlY+0zzgQFP661GZoH0+ZNvW/2bT8yPRnV7lx8+8T0Og0OFC3ZbMC2E09rtM+8+kdsU/
         I4Jjpg2viX7o9Fw5DpdVznDUFvWhjzL7sEuTWX5YLuixJa2FFu0h4dNn0p7f1nxBzCRd
         VLFFR6MEjjOYUXrXU3kmV+4O6KWVm1H7s+JkH8geuNNA9snZMu/cev4PD9sjfI9FrEXd
         Sg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781850662; x=1782455462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2cYyaGPf1aE+4RqqUs8yjO/wC6Ni+rND+DrZOmahUAI=;
        b=pDl/uzL1BaZmwCT2xwSxdGohbuvG30YC0TP4oZq6IkXBgbahiqPmdZQPI8tZM6NLGv
         wBqV8hZq1RbsHvAfBIUvg0YQnKAJVdj/nuHJDkAKuIWd5Q4BuMdxrmiqwo4ZOAPDnxW0
         Ciy85wtmvX5gH9MQkQkV6YEV39p8tnL7XwOxXiBSqmNCX3y3cuHBo4RDR+YWgQi0QSeX
         onaFfNWJhpBHhLmUTZIWNsIvFZ4XkbZZ3a2nljWkYHa8yINX6hz+G+fkDlZ85Y7jOgET
         oEsmpC3HrEB6aujxYHWlq6p28moAcY3Gmi9B19W55lUfI5YvePFg2qbYF2vys3+B5gRm
         sVDA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZpzZklMrk1W4Hz5FlVuYsMrgwDKNDEW02daM3ChxSxd1oiRdJiytWWqklO9Pm9QeB8a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykACwvvMWIYK+pd/uxvgACLQPPavO0zAJPVZByMfiIliWAhWv8
	iH/85BWyu+Hj1uWvt9grWjoIlH421tGZnbO4gNAqGMDlSTNWIaz/D65t
X-Gm-Gg: AfdE7cny3UuU24ObpRP7u4VgkgCKc1bgSstlc+0Ua2bFZZ+6hA/2M7KZdmi+NcbxEqp
	6CbEPTnLLmBynxrlxQcpoQ3rycMUTQ92eeivXo0e2ICBSUyMRE1uXtbkfGm8HmCXSHb8kNKLA1r
	wpFJfSO2T5Lc0F65ybw+maEOqMXmWj3VAFERhNCGSmAQzXi6g9jli7QHZftawup1Kxy8O8BeR1l
	kKn6ZBBVyrIFnXiUvriz1TEniBQl/r2OyEOHnMZfCttGjFNiq5A+56lfh/RAnQ7iglbe2GvOjnf
	9LjneAD0uK+Z9BFpIGApB5/G++JabAwevebl092ex1+tlWK8KmOPMUC9eeHY94JJ9hhdYC5j9k2
	wCqaTjud5rK84y48L/f/cMZnB7t8UrbgTP6LzreQGcJIoucE8CfFG3orDX6dVK80yfS3npgdryy
	w3rRtfUOmwv2jxr3TMz8CqmvsUlWwFOrnk27ryemr6ptg/rSCUtV+Kaq8qKk0HhQ==
X-Received: by 2002:a05:6a00:3916:b0:841:58b0:82bb with SMTP id d2e1a72fcca58-8455604dfa2mr1641891b3a.9.1781850661847;
        Thu, 18 Jun 2026 23:31:01 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455382b886sm1380096b3a.51.2026.06.18.23.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 23:31:01 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v4 3/3] selftests/bpf: test rejection of a packet-modifying SK_SKB stream parser
Date: Fri, 19 Jun 2026 06:29:52 +0000
Message-ID: <20260619062959.3277612-4-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
References: <20260619062959.3277612-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that attaching an SK_SKB stream parser that can modify the packet
is rejected, while a read-only parser still attaches.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 31 +++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  7 +++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
index 621b3b71888e..1d7231728eaf 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
@@ -431,6 +431,35 @@ static void test_sockmap_strp_verdict(int family, int sotype)
 	test_sockmap_strp__destroy(strp);
 }
 
+static void test_sockmap_strp_parser_reject(void)
+{
+	struct test_sockmap_strp *strp = NULL;
+	int parser_mod, parser_ro, link;
+	int err, map;
+
+	strp = test_sockmap_strp__open_and_load();
+	if (!ASSERT_OK_PTR(strp, "test_sockmap_strp__open_and_load"))
+		return;
+
+	map = bpf_map__fd(strp->maps.sock_map);
+	parser_mod = bpf_program__fd(strp->progs.prog_skb_parser_resize);
+	parser_ro = bpf_program__fd(strp->progs.prog_skb_parser);
+
+	err = bpf_prog_attach(parser_mod, map, BPF_SK_SKB_STREAM_PARSER, 0);
+	ASSERT_ERR(err, "bpf_prog_attach parser_mod");
+
+	link = bpf_link_create(parser_ro, map, BPF_SK_SKB_STREAM_PARSER, NULL);
+	if (!ASSERT_GE(link, 0, "bpf_link_create parser_ro"))
+		goto out;
+
+	err = bpf_link_update(link, parser_mod, NULL);
+	ASSERT_ERR(err, "bpf_link_update parser_mod");
+out:
+	if (link >= 0)
+		close(link);
+	test_sockmap_strp__destroy(strp);
+}
+
 void test_sockmap_strp(void)
 {
 	if (test__start_subtest("sockmap strp tcp pass"))
@@ -451,4 +480,6 @@ void test_sockmap_strp(void)
 		test_sockmap_strp_multiple_pkt(AF_INET, SOCK_STREAM);
 	if (test__start_subtest("sockmap strp tcp dispatch"))
 		test_sockmap_strp_dispatch_pkt(AF_INET, SOCK_STREAM);
+	if (test__start_subtest("sockmap strp parser reject pkt mod"))
+		test_sockmap_strp_parser_reject();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
index dde3d5bec515..fe88fa6d40bc 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
@@ -50,4 +50,11 @@ int prog_skb_parser_partial(struct __sk_buff *skb)
 	return 10;
 }
 
+SEC("sk_skb/stream_parser")
+int prog_skb_parser_resize(struct __sk_buff *skb)
+{
+	bpf_skb_change_tail(skb, skb->len, 0);
+	return skb->len;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

