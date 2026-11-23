Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423393;
	b=mLz5CFUp09QRbxKND3Jou/R7HTGHvLhjwuzE3SvoTTBr3YSM/qC/KxutB7ZhXqAlsLLg
	 TnYG/jqoPUBLS3nCqJkMJNz/L1LlJ6YzsS4NWno4WOsT3lOlVYJS9gjXUG6CcPaP7Qxh7
	 +7jXx7AsfNV76sHG68Om5M7UE4CcMHSGmnmGoOsZjNR7b18fFdoG1QWU5Y3AyUUbPzH/Z
	 WtZNHG/CZIg982mSVHtSWlRzu2JIK4JaKXAhV0K/mDxCTYzWjLjQzcdJi1Lk7A90+0q14
	 FzjvD8mLvsBFEVIO7fR23FTpztxH/VwBW2VigHoApY7a6Kt0I0qgIS1CT0HZSj2pcoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WsMDVDRcPOdr0yU45+bId8Zq42zni9YwKMp1FwF5jDA=;
	b=xQXWqJslrCiIgptDwjwB8we0+ChzQOhmrI1C8fDuTmlprOF5zB6bb8sqmg3czuFvfESq
	 R7XilL+W3VIu1H2Hs2GfT1BMqXCVKYT8VfkGGmtwTatIJ5wB4wrh1pdfqRpTYuClQVxFT
	 7SfdfiGCUD+Lr4qmPCJcjvUdGkOWJJj+X/0Fo5QlBi4UQnba8WHfXtFXjXeNrUUPUxWLV
	 MXnG3G2g/KvPhZWVoA7gaVhImpRGG8uhH8GvDWU/glgMliB2CNP/b42foT5rf7x3C/sVt
	 aCfG5UadvB7QO9ukaABnKBeCdGdHJ0lEeqy6HF+egdbPxTdpMe6UjyN8DGAs6rf81qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=jvjl7UuD;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A314606A339
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 08:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A314606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=jvjl7UuD
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so2490072f8f.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 00:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795423392; x=1796028192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WsMDVDRcPOdr0yU45+bId8Zq42zni9YwKMp1FwF5jDA=;
        b=jvjl7UuDeylAi/aqGSsDGsKLMOdDb2OhE6HDHqm47lRoNW0rpGHBwOMnOc+b+ed2Np
         nyFIEIHasMr990mID+IBBY5NUr8cOfYQ8gRICFo8rsjeBoFC88qh1er7rwltZO9KkHr1
         BO4POBGI0x9etEmADs8E64wav/Wa7gK406jOeKYnuUvwjAf6eHbYNoIQR6utFHe1793+
         vrs2U7IvO7NpuC/AtJc6Cr0RLxARXHP1ROjbGtDFsl3PKWL8In7oSoyqbirPchpm0BYC
         ILA6tvDEfKt8kvUMay5hJBy6p8la4632ctx/XhdjGbXquRZKPbKeWgFS2eRzlKfjVcZ7
         oXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795423392; x=1796028192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WsMDVDRcPOdr0yU45+bId8Zq42zni9YwKMp1FwF5jDA=;
        b=vUcsL2RIswu8iraX1IsJ8mXCenKCDJbW3rfjQ4IDYlD7FCpSOWXajff8eJm2VJ3MU8
         cpbRloEqpcdpD0la4INopwSLSZKk+hYavjw3rh7LrvZzuMZ0iqoPbyoOUQWHgCxDrr1r
         4DEl7RwnVp3ILzvnfoZ0pexBL7KO3cnTiaYsLFL+7DnHewhsq3Q1bFQI/0pTBPT2mcT9
         VV1xG+/3QbdW5np3kCMvQextCe+21zugOU72qofMsNzZ5WFPyx3e8e4HCGSC6WKHA2Ov
         nD2LVVMR7HHmRigHQAgU5GSjXekyMueXAgBJ3runpk6UFr9LIUvqkMgK870hPoOR5W5X
         Hxhw==
X-Gm-Message-State: APuU4Z9Cf4WNBCNnYgQ+ioItWTalaU8KUu4QPNgpVzI3DVjvqVgWrXzR
	vd4LlHvrAGIRPOznkfJRJfbnIP2D1biJD3VhcH8sbo1cXHFiuZXT7fzitGPMmiJ01DihYEw/xKF
	lcnnlaoi8gg==
X-Gm-Gg: AZFdTZdmBCAappBHpLOZIxDSGDpdkmmFk9v5NvT7fEXquBeI4QktbtC2X7OMnmRv8B2
	7JPut2DyHInye8XJWnXk9B6GLqGvH2EY8a36EF7qbJ9CgmX90sl+5fkurteloXTvZAvh8qSCCY9
	bCYEvu0UQQg5churizeCScLNUrE6726gDe0BaQcpT3T3gz5l3C35LOLLgi+2mMSdIgGwFF3ts6S
	O6jXRMHP88OaCGIlV+KX5/c2IxDFA5K5oIpKLqzWZLdD/jkzjxscbv98eEcLmJunN/Io3p7FqRy
	gCLtjFs3xmN46+x/oAIUDXpHR6zcuVDbe9WCcYcZe3E3pFalwaEFYW0s5cBSUwkMtEsvF2Jf+7q
	62uh0lV5k5MrC5IqM0BJ252FJC+VY+y3L1wsDYtVO6D090qSiuut44C/Lruelsq2VdKAcVugPOK
	L6uKvthAH68Z9mqERy8i4aXYWg26j7CD0A0alUhixkSwZ2MrB/rDdHJkUO1a+c4GMOziORYWkUC
	ybdaLLfeN8Sz2XoV3xXHeukZlVY5GbaHqQyopH5FLwjgXVjJmqwD0C5V7jpKOhpcWuxcN/Mv2Ht
	r3qkaRStnzOVYKYMrg7z41nvCkh2F3OJw4PXyW3BlTSVwmcHPJCj7cMUDRchrdXbovhTCNWJ
X-Received: by 2002:a05:600c:848d:b0:4bb:6687:5386 with SMTP id 5b1f17b1804b1-4bb8880c7f1mr236936835e9.19.1795423391490;
        Mon, 23 Nov 2026 00:43:11 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb88442693sm286713925e9.1.2026.11.23.00.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:43:11 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: test assigning a TCP listener to a UDP datagram
Date: Mon, 23 Nov 2026 10:41:38 +0200
Message-ID: <20261123084138.723275-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123084138.723275-1-razor@blackwall.org>
References: <20261123084138.723275-1-razor@blackwall.org>
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

Assign the TCP listener from server_map to a UDP datagram for an unbound
port. Without "bpf, net: validate assigned socket on receive" UDP receive
uses the TCP socket and the kernel crashes. With it the datagram gets the
normal lookup and the client sees ECONNREFUSED. Let packets the program
does not parse pass, so the ICMP error reaches the client.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
CC: Martin KaFai Lau <kafai@fb.com>
CC: Alexei Starovoitov <ast@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: John Fastabend <john.fastabend@gmail.com>
CC: netdev@vger.kernel.org

 .../selftests/bpf/prog_tests/sk_assign.c      | 36 +++++++++++++++++++
 .../selftests/bpf/progs/test_sk_assign.c      |  2 +-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
index 10a0ab954b8a..804087a19aa9 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
@@ -199,6 +199,37 @@ prepare_addr(struct sockaddr *addr, int family, __u16 port, bool rewrite_addr)
 	}
 }
 
+static void
+run_udp_to_tcp_listener(int server_map, int family)
+{
+	struct sockaddr_storage addr;
+	char buf[] = "testing";
+	const int zero = 0;
+	int client = -1;
+	socklen_t len;
+	__s64 server;
+
+	len = family == AF_INET ? sizeof(struct sockaddr_in) :
+				  sizeof(struct sockaddr_in6);
+	prepare_addr((struct sockaddr *)&addr, family, BIND_PORT, false);
+	server = start_server_addr(SOCK_STREAM, &addr, len, NULL);
+	if (!ASSERT_GE(server, 0, "start_server_addr"))
+		return;
+	if (!ASSERT_OK(bpf_map_update_elem(server_map, &zero, &server, BPF_ANY),
+		       "update_server_map"))
+		goto out;
+
+	prepare_addr((struct sockaddr *)&addr, family, CONNECT_PORT, false);
+	client = connect_to_addr(SOCK_DGRAM, &addr, len, NULL);
+	if (ASSERT_GE(client, 0, "connect_to_addr") &&
+	    ASSERT_EQ(write(client, buf, sizeof(buf)), sizeof(buf), "write") &&
+	    ASSERT_LT(recv(client, buf, sizeof(buf), 0), 0, "recv"))
+		ASSERT_EQ(errno, ECONNREFUSED, "recv_errno");
+	close(client);
+out:
+	close(server);
+}
+
 struct test_sk_cfg {
 	const char *name;
 	int family;
@@ -255,6 +286,11 @@ void test_sk_assign(void)
 		goto cleanup;
 	}
 
+	if (test__start_subtest("ipv4 udp to tcp listener"))
+		run_udp_to_tcp_listener(server_map, AF_INET);
+	if (test__start_subtest("ipv6 udp to tcp listener"))
+		run_udp_to_tcp_listener(server_map, AF_INET6);
+
 	for (i = 0; i < ARRAY_SIZE(tests) && !READ_ONCE(stop); i++) {
 		struct test_sk_cfg *test = &tests[i];
 		const struct sockaddr *addr;
diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
index 3079244c7f96..4e8ae7b7d297 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_assign.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
@@ -178,7 +178,7 @@ int bpf_sk_assign_test(struct __sk_buff *skb)
 
 	tuple = get_tuple(skb, &ipv4, &tcp);
 	if (!tuple)
-		return TC_ACT_SHOT;
+		return TC_ACT_OK;
 
 	/* Note that the verifier socket return type for bpf_skc_lookup_tcp()
 	 * differs from bpf_sk_lookup_udp(), so even though the C-level type is
-- 
2.47.3

