Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793041433;
	b=5fj2K4sgipabzwfx1QIiNBxKrlN7+CotCKFpoUKL+z1uNsFDC5ZhYyw2Whe9LsBdREz0
	 Nm6eDvkziO6+cqAjDpD401RZx+hkMwjKRXi5Qf7CKU9vIKUugEBkCk6b6gGlCtLlS02gM
	 BP1ONy3L/auOvaPdIOSf4Vhwcn91CkXo/jimvUQayeN9o2hqLQ3s/+UDpp+WwlUrRLye0
	 NNzHbaERD7xjwTsoFz9Iuo017BPprQtJQchXln0RAfZMccu/ZyEg1f3HjWB5Qq7XTr4Ys
	 NuDQ3r1bN8PUduSJGDOfjoV+TNp/GDInqe5v4ZfVGjejI8qtuopzoRBRq1HD5/qjGng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yCT26Kmbeags0MRsZ4Kpw9oJUlQ0yW2hs9dWp1Ih4k4=;
	b=x8xoZQFJj+FCTe1dMtiIPjACEXnNNwJJgNT8ZRLlTpBZM/3JnLnYu4OhqGxgYRAPvXH8
	 KG5fHKBcBwHQOkDRlpr66L6Q358g6JopGmjSrUKahTTY7NzqI8WoQdDEHI+Q9GburbcmT
	 LJqIrCZoLzV/V8HxQKEdiQn4MMYT7obiVY89I+ozD2T4u/ymOzSWsmGdYhkcrCjvJ3DQj
	 468M/M03OhikGomGqmO11MwMgb5/IAJT9Q2ChBGYM9ySM1IZN7rUE2sDuAhvPopMfbnPY
	 YWNOEaPHMmSnTOtivbf7nDhXZbhqL26hCysTMPMTRDbYjcUStSOQPFPbKsJIYTeSMiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e+zUs2PH;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D893606A324
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 19:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D893606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e+zUs2PH
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dee593f18so2532772f8f.3
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793041432; x=1793646232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yCT26Kmbeags0MRsZ4Kpw9oJUlQ0yW2hs9dWp1Ih4k4=;
        b=e+zUs2PHF0Ma2PXz31OAQA/8UkojYWGTXJclYDH0IacEkBLKBqQweYtiS5DFW3YrRe
         1c2y+aXSxHtZNR2sTm195cIxF5/4tDB1WL8JvnqMubUG4pYQZmOstbQNGpyFZ/MCqNiW
         fC8cqQG0yuN5pkrf6GKXDQ6pbiC7n/0BmYxDbU9/sLfdA9FJ9mZ68TEzPcWza0dG/azk
         hqkX15AEgyp/swTsm3Zp3Gom+aqqfg5F/H94RIkTarVy24PUyvbpLQ8wabmThIq/9DBY
         /SXe+FOKDPZ9Pm2hySeG6TonOUeEh/T90ZSj5a9cI938UVObdewYBKYrlt4nxP2gaflI
         7i5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793041432; x=1793646232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yCT26Kmbeags0MRsZ4Kpw9oJUlQ0yW2hs9dWp1Ih4k4=;
        b=wMJ8TaqkoCHdqPQ7rPuqMfh6N6T8ofUVr7JCStHqyNuqGgu2aUsQ/4Z9avcB0Xx/RK
         Expfo9G4KyTWq2AI9IPN6xfpMadJgqwqI+cnCiDKU6BeXgoDvRsebvi95fDfBLPZTQ4A
         BvaqnVApBsJUjO1QCOyhdoSRfDsfE2TICYXrsNqBNqXP9rlHOSgV/wI+OCEfibACefi8
         pZkKcTsVoRm6OICS+qvHhA4ScJq2rrPj4PV3o7mdsm/VRDOS/vBV10cdOmvbBkPL67o7
         1F5fRDv81NIP+L4P3CAW1a9zRSGwwMiOZ3T7U887Fg3ecubteswtV/xZNzz5oZj8oSe5
         iRKg==
X-Gm-Message-State: AFq9FYKKPoE9qCVTwkCGMVhQ1YK3bf81GwZhXuOwRFT6/XQjdjm/3wDf
	yMFfZF8ik6aAXGW7zZ7FNadoGe38c9Uvf5Upc6Ypgk3OhCqzMPNz4B4OeuLMWghSy8k=
X-Gm-Gg: AYBFou0Rukmv3xdevbUOTHEohrpL0U9bvmvnsZfynB1Jbe+uzuT80NF5QtAtuOd2jxv
	JJEUulZQGZuEHS072u+ybiEL3T+VfKYxLSXeBgiih4aTWwaeCuX7PHLvseKOpeWjCzax5aJj4GH
	jViy3E+ilk/BHzFn6JNgZVT8Cf07V9qy67Z++vGH1Ysnj9072gRkmzNNl2SDm3alMFR7OaJQFFP
	bRkqKA+DK6uijxj+dgaJBY2lWYH4zRAHg0geogp/LcWwZIcehvOF/nHCPOnEY1YblgDe59MVb3J
	8OQpp3yWiDrMNItbYrPiDg1hpBLUj4Rm07snQHWF5JBZ3qny7ePUVg775XaMcPZBFYnc2/zSFDk
	XcdNVdvzWleP5nZVL1d+RftA2RNn2aKuep9vwJCpJ/2C5w1u98B4s0M1tOBGJ3SYdjVWcI86J7q
	rPMACrbylGPMGKTq5lHgP7fJFrUSbpTdDFmNd4vCQeAGTLpwJbLkwIY7giDsaCB4aBFd68MOktI
	SkQ6eslhIiAYFRMQnGmBUwYHrQU4/SdhjbUMW5R3pjT5Hk4ob6zCqLO07771OW+i4/rgMBAEXtt
	Pdb36bYcIlInWq9WcRDW1aVPxBA=
X-Received: by 2002:a5d:6704:0:b0:48b:118e:7454 with SMTP id ffacd0b85a97d-48e3eb8bdc6mr11129837f8f.31.1793041431604;
        Mon, 26 Oct 2026 12:03:51 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3ecd37f4sm21145713f8f.44.2026.10.26.12.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:03:51 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	willemb@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	horms@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuniyu@google.com,
	memxor@gmail.com,
	emil@etsalapatis.com,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test bpf_ksock_bind() kfunc
Date: Mon, 26 Oct 2026 19:03:42 +0000
Message-ID: <20261026190342.137069-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026190342.137069-1-mahe.tardy@gmail.com>
References: <20261026190342.137069-1-mahe.tardy@gmail.com>
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

Reuse the existing basic ksock test to also bind to a specific source
and verify that the source address was respected when receiving.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  | 22 ++++++++++++++-----
 .../selftests/bpf/progs/ksock_common.h        |  2 ++
 tools/testing/selftests/bpf/progs/ksock_lsm.c | 18 +++++++++++----
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
index dd6b167623d9..b319f74bcf3d 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksock.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -10,6 +10,7 @@

 #define NS_TEST "ksock_lsm_ns"
 #define RECV_PORT 7777
+#define LOCAL_KSOCK_PORT 6666
 #define RECV_TIMEOUT_SEC 5

 struct ksock_test_env {
@@ -63,6 +64,8 @@ void test_ksock_lsm(void)
 		.sin_family = AF_INET,
 		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
 	};
+	struct sockaddr_in src_addr;
+	socklen_t src_addrlen = sizeof(src_addr);
 	struct ksock_lsm *skel;
 	char recv_data[sizeof(skel->data->send_data)] = {};
 	ssize_t n;
@@ -76,9 +79,10 @@ void test_ksock_lsm(void)
 	if (!ksock_test_env_setup(&env))
 		goto fail;

-	/* Step 1: Run the setup SYSCALL prog to create the ksock */
+	/* Step 1: Create, bind, and connect the ksock from the SYSCALL prog. */
 	skel->bss->ipv4_remote = htonl(INADDR_LOOPBACK);
 	skel->bss->remote_port = RECV_PORT;
+	skel->bss->local_port = LOCAL_KSOCK_PORT;
 	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_setup),
 				     &opts);
 	if (!ASSERT_OK(err, "ksock_setup run"))
@@ -108,10 +112,18 @@ void test_ksock_lsm(void)
 		       "LSM send bytes"))
 		goto fail;

-	n = recvfrom(env.rfd, recv_data, sizeof(recv_data), 0, NULL, NULL);
-	if (ASSERT_EQ(n, sizeof(recv_data), "recvfrom len"))
-		ASSERT_MEMEQ(recv_data, skel->data->send_data, sizeof(recv_data),
-			     "payload match");
+	n = recvfrom(env.rfd, recv_data, sizeof(recv_data), MSG_TRUNC,
+		     (struct sockaddr *)&src_addr, &src_addrlen);
+	if (!ASSERT_EQ(n, sizeof(recv_data), "recvfrom len"))
+		goto fail;
+	if (!ASSERT_EQ(ntohs(src_addr.sin_port), LOCAL_KSOCK_PORT,
+		       "source address port"))
+		goto fail;
+	if (!ASSERT_EQ(ntohl(src_addr.sin_addr.s_addr), INADDR_LOOPBACK + 1,
+		       "source address ip"))
+		goto fail;
+	ASSERT_MEMEQ(recv_data, skel->data->send_data, sizeof(recv_data),
+		     "payload match");

 fail:
 	if (tfd >= 0)
diff --git a/tools/testing/selftests/bpf/progs/ksock_common.h b/tools/testing/selftests/bpf/progs/ksock_common.h
index 2a32cff2fbe9..87321f4ba4f5 100644
--- a/tools/testing/selftests/bpf/progs/ksock_common.h
+++ b/tools/testing/selftests/bpf/progs/ksock_common.h
@@ -11,6 +11,8 @@

 struct bpf_ksock *bpf_ksock_create(const struct bpf_ksock_create_opts *opts,
 				   u32 opts__sz, int *err__uninit) __ksym;
+int bpf_ksock_bind(struct bpf_ksock *ks, const union bpf_ksock_addr *addr,
+		   u32 addr__sz) __ksym;
 int bpf_ksock_connect(struct bpf_ksock *ks, const union bpf_ksock_addr *addr,
 		      u32 addr__sz) __ksym;
 struct bpf_ksock *bpf_ksock_acquire(struct bpf_ksock *ks) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm.c b/tools/testing/selftests/bpf/progs/ksock_lsm.c
index 9808451098ef..28da777eea6c 100644
--- a/tools/testing/selftests/bpf/progs/ksock_lsm.c
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm.c
@@ -10,6 +10,7 @@

 char send_data[32] = "hello from bpf ksock";

+__u16 local_port;
 __be32 ipv4_remote;
 __u16 remote_port;
 int target_pid;
@@ -32,19 +33,28 @@ int ksock_setup(void *ctx)
 		return err;

 	addr.sin.sin_family = AF_INET;
+	addr.sin.sin_port = bpf_htons(local_port);
+	addr.sin.sin_addr.s_addr = bpf_htonl(0x7f000002); /* 127.0.0.2 */
+
+	err = bpf_ksock_bind(ks, &addr, sizeof(addr));
+	if (err)
+		goto err_release;
+
 	addr.sin.sin_port = bpf_htons(remote_port);
 	addr.sin.sin_addr.s_addr = ipv4_remote;

 	err = bpf_ksock_connect(ks, &addr, sizeof(addr));
-	if (err) {
-		bpf_ksock_release(ks);
-		return err;
-	}
+	if (err)
+		goto err_release;

 	err = ksock_ctx_insert(ks);
 	if (err && err != -EEXIST)
 		return err;
 	return 0;
+
+err_release:
+	bpf_ksock_release(ks);
+	return err;
 }

 SEC("lsm.s/socket_bind")
--
2.43.0

