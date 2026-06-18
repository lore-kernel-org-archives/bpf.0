Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94833B71D4
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778467; cv=none; b=cpu+GnjUQAVxNnw+JpyeS1O1D9g2mAJHfr0eKBMMvkSww8ynwYbL0JZxs8tIU5Ldfx59Zt2J57OyxsVmjA6pUUaLv7oP1kJUWfHYLuf4rEPKDekbpEfTLGvWWqdVLNvPMd1k26qd2Q3GYv5vQaf4OIrlI58OFCaYGFz6JnsIxPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778467; c=relaxed/simple;
	bh=YS0u1EKD53vo2t6W+IEib8k/HgYIgbkb0atxBhbXQmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9zYSrQSyV9DEbpWTWHzYNQFk/NY22RBZD3QyRXBHUv5IjJYrlb6YoiijOb0RZVhXAR7o2bWniqJ4MRbPVP3f1hiVXC4HN3vheco5wxpRJNNTDYFT63cOx3hwLw/vkKYF+R2AfeCcN1tWci9UWonkxEfJIILQk9X8UtywJWxT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/Q4TwDN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/Q4TwDN"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so689783a91.1
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781778462; x=1782383262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cYyaGPf1aE+4RqqUs8yjO/wC6Ni+rND+DrZOmahUAI=;
        b=o/Q4TwDNzBAyOzFLdHlPb8t22uBR3VwUUVlYXuy8AlrbPDTQzE9C85/G1SiJI2yyMF
         jJ3+8DBCftw0sORjKGEhNb1UePubiR2JaZsw0zaDd8oxekANElUzcb9ZSpCF+zMiIBQP
         40i0A0BQO1dlaFP2K2W7jBYrUq24DWIq8MusFeMycy4L5m2vCgz/SY/aBsZZS0vz9QYR
         no2FGFjbXxGJwEZVC4att8N6pzUcnkL7v53fD6zYZ6NhTMHdAme2LYsdbVd3WHKVHaPs
         NT71/aKIxQB+7mvqB9KeLCRZxFuXlok7xxRtFUFxnbc/Mm7PGbDsGN9ofi8ucFhDY8jY
         Kwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778462; x=1782383262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2cYyaGPf1aE+4RqqUs8yjO/wC6Ni+rND+DrZOmahUAI=;
        b=AvQZ8bB+UC8We6fAOUSPPd+i1HSVSa3bvt3EC8KgmF9TonA5LhfqjDxUb3tdkXhVsA
         VJo8WZUPDkWZKJ8qdPHoRQCvAtetgE2x2xb/tOe6lT4N1oxp6TWeiqYZYoNK7YyaBh8n
         EwBm9uEoYV5BQLmzAALtzLmrdb4PGtw+JKnkC4nuow35azRsDfkBi0KqV2amMH1DoLJh
         Zax9QBWPyAxFnpofIuaybIXGBImrijNnr/Eya+IO2UoYoIIMBbxioiuwF1MVz6JHfh/p
         RFbn1eEE/i7tJ8sS1hfinxrNXxfew6g9MdGxHZT69c6sOPSROr+U/C+y1DHA3eZL2tnZ
         glwA==
X-Forwarded-Encrypted: i=1; AFNElJ9j/r6YD+8BlQmLo+1r0sIa1pOpqUPbvQYuvy4KJ0zBACpCkL5vhqtbR67R5o+A/dPW6js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3RduweOLNzJHwneDB504a3fUho1R6vQQAkZnEVKmPZshgA4S5
	W0XqpTy0Q8ANh/9DKb7NehrqATj6IqdwIZYAablLhfJ2XUPVxv2kBFKq
X-Gm-Gg: AfdE7ckUYrfLAu7HOa08Y8vcnR4e4b0q7syBEOoVkfvuZ+st1Epb8Wlp+5bcst44Q6t
	4cHWSVjN/XUBjEr8fIDmYB6GMnA2d/ge0MEM6mFzpTnBkmSBtENfb+Xwbt2hNhPwUxrytE2Pr0K
	oe0p7UZpgrld9vmzMKunBep+e5UmnvpC2ofR9mnv+Q2vloqXjOEi4lI6DsDtylHGtM7S2mNNzOs
	+o2oCF4mQyinV0IFSqGsEkT8CULd4Bvh4ttYOzxJpQYhvrBCsiOLHlmhgskDFKgmKaWpxv42W6Z
	YjtvD5O3Qd76enA1j00VHGaE8NBlx5tnX5GBfFyYttj72YJZHYzh1UWS/LaebIyhKW8iBvNiRGU
	fguOhJlsBFHdJ0MjxYlNJU4XFUpcdPL7Y67BtY2IDqTh5bEWWSrW43hgKtQoOlVI28r8vw5y2ll
	hVjqqGSSKtf4PV2I+uTfy8MTVF9Hq07Tygt4/w2pyiSdhKQ3WzU8s=
X-Received: by 2002:a17:90b:2812:b0:368:341a:a925 with SMTP id 98e67ed59e1d1-37ce46d8c8bmr3179447a91.23.1781778461702;
        Thu, 18 Jun 2026 03:27:41 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521cac5bsm8997512a91.5.2026.06.18.03.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:27:41 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 2/2] selftests/bpf: test rejection of a packet-modifying SK_SKB stream parser
Date: Thu, 18 Jun 2026 10:27:08 +0000
Message-ID: <20260618102718.2331468-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
References: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
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

