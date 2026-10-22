Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692995;
	b=17L/3FwNQz7Sx9YjYxtDw1ZpYInRyqi7gTdBWlm2c7O735ukVhxJRvmlUv2gOsxsQVws
	 A55c3BnkA6w7fEkFhr4G3Dwe//cwNhX4wXBHOaoDJM/ote4ITvLAq6oANzkM3WoGU1uPk
	 O1Ln3pOqxnsnrkKqSF9ulB8hPvhMqrNkVapM/dQuydW2c6j/ooDtGr42dvikkpxBz4FCe
	 bnjcQs9WHbbda0kMY8kmG+FAOacR4OYhDIHCz06RUnUzBjOicyyPMb/z2v2x72NCgx96S
	 YI7r7VRW0YBTl44wH0ZwsNPSFEbh07+OnO9wFWdEkWxPPpm+FseUxwxMna+qcszMx4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=525OXRTkCGukB1Pg+MVGVcjD+Y2Gy39duVYWV6D2upE=;
	b=klO48GArdeYSxyWR+4srEhbt0ycs62gDPTlSyR7gv3utqHWaXAI4Ogt5m5zSOVFKrGKr
	 ocxUrw6kEz1+iwyEOWs4m9FNRafR/iLXg+WPJBvAntzTJ2jwVG1Xxy2RUShfrPMddLEqe
	 ZQRKAjjzzq7SdkLm/XIMS40VGDETIOR5LBHfTgVBiTXV9f5J7cdh8lwtewoXoU/WWxmuw
	 IC6lCXo9vYVHa08f5LJVNq8HlZULCTDdQlqf6elCKdlmhb+8XmbPxrY6eZXgp03UVrIHA
	 ngfh6K8ei5bd9SncjbdiWN/RAth9ab+cOPQyA+FqoU1mzUdncIb8HEnSitu4FnGLgeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hcffg22g;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908BA606A322
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 18:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 908BA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hcffg22g
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b060ec084so76764f8f.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792692994; x=1793297794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=525OXRTkCGukB1Pg+MVGVcjD+Y2Gy39duVYWV6D2upE=;
        b=Hcffg22glfuo9j+UoU7FtA9i9R7VpB3T/VL3uZbDnH5e68P/XJk13CMFRtIOp623fs
         66i6bEo2d4xxGRnFRhDb1bvug5cLCrbP8TbA7RWV1L8nzdMTzPVrGwLDh4o3c2YRLaUq
         WZ/0y/nLop5sYGu2lhtx1L8tx+Sw0OIsRZwD/em1IwQSrVEndp0uRItr7BSoHo7JIU3c
         naeEpHBuWgUZsjYS7S5oAPZLrs+LSq132BFLwfwNCH3UEGBMCzeK5VfH0croHRZhrL9U
         EtuPBhxbs1y2NcJxMSPBe34WYH0p/Y7Gjfe7DbxMKa1TZAOWpDuTlwuueScCPmF+L+zK
         GKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792692994; x=1793297794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=525OXRTkCGukB1Pg+MVGVcjD+Y2Gy39duVYWV6D2upE=;
        b=KeQuDDPPyBYxBNKX+l4xKZ4p4Nvac/aWdfdv0zNH/8AN3NcoHdGs1+BAAXbeWzDNNV
         TGNZHmMtKnUYudapxzVRHiaOgMfD/CtSR2CJxMbObTRkig80SWxPG03yIamUbdaheChR
         KVEeNI619fwGcbatsSmpiycS4nEtmuNTji8a+HryJoTOT5cQnl7rJo9+0f1mqSvRdhvF
         xoiqunl51iUwXhZJ5oc7khuoekTpkKhuBueki3EsoHn9aipsC0BKrl1Y4ol4Qp1kseHG
         yYx9mw8rnqmJbTGw6AbRvU6yNlSRS1vXJTZ0rlDQdXH44Dl3DBzn2aDPDdAxqHmErDAP
         lITA==
X-Gm-Message-State: AFq9FYLmMFgc7S1vTyrX61b2dh7h4w+JjUKc1Zwk5P9lgJ3I7Xh0TZm4
	6OlO1D/eSafUNtbtEiVJYkyf3fLi1PYbIjmLm370tVpyhoPr/JNAfUfN4x4hzFypW2nE5A==
X-Gm-Gg: AYBFou0CT8FYPKYC0MCmq+IT/xadplGtMLzqG/sO/JmPhZwhkXiB60//igh5rvn4Fij
	ZhT0c8OklENwZmfC2mwPs7Q6f4tcgvkHdDUQ7Jar1RqCLMhFY/657ZjD8h2iRVX8d0sCVcST6aa
	fmiqVqW72OBBiU9JBV1grDmnPDFvLg6Ujifxt/XFqrwmyDp5Hspn7pC2ppl3NS0mX/1/l+DL9ma
	qDVjap9y7Xl/cIFYNnKvaNNr3o0fzJ0pnDmJ4h0VVOsLeij9IavzS4O42CG39ARIze2w2xERaf3
	qV5z/vpLonbbj4PaMtsr7Dr2GfHm/EY/rXHghQlwq5ToDNaTXWftEebRbA3Xlr4rqLIR+bHfut+
	gB4Xnya2uipK1nJR7VM3lkYIWkw4itnp9JOmOCH923R8dzzW/oroKHXTIdqFOZwig8micnE8lji
	Jb4+bd6fQGPQS1JXUBaysxihKLkOUbwLkA2K0uQhznnjDc+GQLdAx+TUeZWNgyb8Y1jmDOKML+l
	9X6F51RHcjK46qQxRhQn3oykoiOHrtMvZk4yyHc2bmpgoK614Ef1aiyhKjSj7loq0vUcMMiIbVE
	yX9e2RSTOLRgQjQ0FN8A7DbaslY=
X-Received: by 2002:a5d:5d09:0:b0:487:342:d141 with SMTP id ffacd0b85a97d-48e2649da0dmr13328204f8f.23.1792692993734;
        Thu, 22 Oct 2026 11:16:33 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3796b2b4sm18451f8f.7.2026.10.22.11.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:16:33 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_ksock_bind() kfunc
Date: Thu, 22 Oct 2026 18:16:20 +0000
Message-ID: <20261022181620.247201-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022181620.247201-1-mahe.tardy@gmail.com>
References: <20261022181620.247201-1-mahe.tardy@gmail.com>
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
index dd6b167623d9..9827aeccf3f5 100644
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
+	struct sockaddr_in src_addr = {};
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

