Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491928;
	b=CJDFzbAQRyNm1wevvXCN9TyfzQTWuX19S4QueutdpAFfWywD78XPTYATJG6U3bCRu3Xa
	 gvIWJorvSIVz2gBrMC8IBwhD+zQisf+m5m4i4t9JZydsbI6ldsrnHnwXI5/ttUr1PhUZr
	 H2UKG7uPdrFcMbX26X93OhLEi7wOJ1zhenWZ0nN06uw5YGjGtdtsoufnTAEuB9W6GyAE1
	 wW3fWIx4uoB26Ku77BVfimrYBE51zJNSgt3G1KStYh+t2C2tkFyscGnNmDzvIXVA+32Ro
	 RjckIWrwfBJ19VHr+tZaHDBXlGzuRBxUBAS0DAnnvQvn07GLVIyeS4X6NHoyl/vNMcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GH4/sMbIVb/PRKafLnvsKSsgd0EUcesJyPmYbXgeZ0w=;
	b=ESN7Cm8eaQzhoB/4ukLyvhszXGysLFPxA+syfThUZzzHSdfJeTprUGwSjQ/wP4Dg7zYP
	 wl9gEIZnNbst4gHvoYG+cdfAtM+zPviR1WCB32dcbCGoCrAcK4VO6D78asNuEzMYm6hYn
	 leJwGxbDAS3HvI78kGVOKNNIRX2yDKSHczGHFWokV/TUa/e8tO6BoAs1c7+oRzgPpnS85
	 h+ahoPpqghHt29cVCDNYpGYwPZw3njgwpyU3StMbIw/u3KWlsH9xzOVTi/0gRwZ0L2Hsd
	 pqRPZc9f6CUWLzETjUIebSTmyhsfWE8MXMmDChCosPr/FS6BOQFX15B2yMrBI03FN2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RUTiVOaT;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FE60A2622
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 978FE60A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RUTiVOaT
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1e266fca2so15818785e9.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491926; x=1793096726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GH4/sMbIVb/PRKafLnvsKSsgd0EUcesJyPmYbXgeZ0w=;
        b=RUTiVOaTa0qH1gt7f0s6XkSF1KLaWGEkwnlsTqojm+9HIK+WCSDU5Fzo7yzfc6/W5M
         L3rvFfMlzWZueI80lHlnEZ0vuIsxBPlBcCUh1gg2Uk14X3GQKx5Au+MCUeecL4V90KqN
         zG5uQNtYvmllOVErd8yNMJ5nPdmsnjEVioGa3wQLGhDEmnlbFA6xedXY2dQixr7gFt/i
         h4aKjMm8ryHDNRJaanBMxSQ85i68rQ5xzz92kDnRnTJXYRk/WnUbOmQcFIGszRorzkwc
         /CibxoZMDW2nq4uN0LEGFCNzXuSeOopRYHKbyHMNlC3dJqQUW/HnNlEfdImf8YbgCqtC
         6wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491926; x=1793096726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GH4/sMbIVb/PRKafLnvsKSsgd0EUcesJyPmYbXgeZ0w=;
        b=h6g6XWyQj+9UeSfB5S5jh306JFu79dHyrkbBQYJL9jd27gmGdXZ7pLB2ig6qEN9U1J
         gM0ldSub0pLxDDibpKOOrQMSMPjZcoKf5T0zpL4DjCNx8Dg78JD282OdKWM7T/T5u12f
         qyaIQho49JT3WKzOr6xrWFbXkRIJuwuZK9fFlLjBC4EWpd8Y/nldTFPkBAVyIUxZ5XHF
         3yxv/EyCcu5prf+pD6BIVR7Ln3qsSspiPiCWNp987eegBthuYDtcWus9DRLq4q7WfaEM
         HfA+kVQyI1/5bwHkp198xogTkm5gtfL/ujCPF4KAu0qaPnhaGx7ua2nvZ5xm1+KEpuME
         3eIw==
X-Gm-Message-State: AFq9FYK31+VYmfxcPfi4pt7CRxtoOItMXdvBtJOFBEfGEkXPTJ1WIKKV
	pd0RujOnARlDuNpR2aFZu9NvS8ujsKCAFFFQheXIiFbvkLVpJaCFCUhGiasV0Ab/TJ1nrQ==
X-Gm-Gg: AYBFou3To4+hEhmLz2kMQZLXMfmo+Vr5/WBfweWzTKCx2Q4zlunZJ6f9dDWkkjI2xgw
	wpdvF1wusmmNDQprt/W0nMjELFVkcUT2U5SEjm5/WUe6R787Ry3fl9Vw3ewKoWcrzVymwrHe/lf
	vFJsuMEqcdmh0TImUFkF4MHP5c75l+Vbp3q8WayDv0hxvlsnPfrpTpNrXUvb2yjiSH2065QR5VQ
	+CUM1XW6t9NoYqKXENBGA/a9gPDd1InFKguNtmXX4Fs0kQXNblFlLiVuIEKOM1ATpLP5EawFIpq
	YXFqhaMTNWPO8hH36ps0hjc/rA1r+fsr/mghocUnm6UFzgUM7//jyaF52OXG+Fnh+8HoAB6QcXC
	h4qS9CSHflXfQ+nr2V9011F5oXC6YBLxJsAqDuF4TO/ybyycWv+Z2YW1N6Cv3WTgr8hL+RajSKy
	VKLsoHtImnYIsA7CFQ3B7EzJ4KrZjK1xoEI/eBAzL1xBIOiQ7h1aD8LW7N3k6pgf2keCjnsMXMr
	x2Ub85AjM/PNHgmylT62exyAKkRNcQU9uBwshivRPQRcw==
X-Received: by 2002:a05:600c:3513:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a1d760e58fmr220948485e9.27.1792491925762;
        Tue, 20 Oct 2026 03:25:25 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:25 -0700 (PDT)
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
Subject: [PATCH bpf-next 5/8] selftests/bpf: Test ksock connect/send combinations
Date: Tue, 20 Oct 2026 10:25:09 +0000
Message-ID: <20261020102512.518479-6-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020102512.518479-1-mahe.tardy@gmail.com>
References: <20261020102512.518479-1-mahe.tardy@gmail.com>
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

Tests more consistently that calling bpf_ksock_send() from unconnected
ksock socket fails and that bpf_ksock_connect() can be called from the
SYSCALL program creating the socket or from the LSM program also calling
bpf_ksock_send().

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  | 53 +++++++++++++++----
 tools/testing/selftests/bpf/progs/ksock_lsm.c | 32 ++++++++---
 2 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
index dd6b167623d9..78677bfffdf3 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksock.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -17,6 +17,12 @@ struct ksock_test_env {
 	int rfd;
 };

+struct ksock_test_case {
+	const char *name;
+	bool connect_in_syscall;
+	bool connect_in_lsm;
+};
+
 static bool ksock_test_env_setup(struct ksock_test_env *env)
 {
 	struct sockaddr_in addr = {
@@ -55,16 +61,18 @@ static bool ksock_test_env_setup(struct ksock_test_env *env)
 	return false;
 }

-void test_ksock_lsm(void)
+static void test_ksock_lsm_case(const struct ksock_test_case *test)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
-	struct ksock_test_env env;
 	struct sockaddr_in trigger_addr = {
 		.sin_family = AF_INET,
 		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
 	};
+	struct ksock_test_env env;
 	struct ksock_lsm *skel;
 	char recv_data[sizeof(skel->data->send_data)] = {};
+	bool connected = test->connect_in_syscall || test->connect_in_lsm;
+	int expected_send_ret = connected ? (int)sizeof(skel->data->send_data) : -EDESTADDRREQ;
 	ssize_t n;
 	int tfd = -1;
 	int err;
@@ -79,6 +87,8 @@ void test_ksock_lsm(void)
 	/* Step 1: Run the setup SYSCALL prog to create the ksock */
 	skel->bss->ipv4_remote = htonl(INADDR_LOOPBACK);
 	skel->bss->remote_port = RECV_PORT;
+	skel->bss->connect_in_syscall = test->connect_in_syscall;
+	skel->bss->connect_in_lsm = test->connect_in_lsm;
 	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_setup),
 				     &opts);
 	if (!ASSERT_OK(err, "ksock_setup run"))
@@ -103,15 +113,25 @@ void test_ksock_lsm(void)
 	if (!ASSERT_OK(err, "trigger bind"))
 		goto fail;

-	/* Step 3: Verify the LSM hook sent the notification */
-	if (!ASSERT_EQ(skel->data->send_ret, sizeof(skel->data->send_data),
-		       "LSM send bytes"))
+	/* Step 3: Verify the operations and received notification, if any. */
+	if (!ASSERT_EQ(skel->data->connect_ret, connected ? 0 : -1, "connect retval"))
+		goto fail;
+
+	if (!ASSERT_EQ(skel->data->send_ret, expected_send_ret, "LSM send retval"))
+		goto fail;
+
+	n = recvfrom(env.rfd, recv_data, sizeof(recv_data),
+		     connected ? 0 : MSG_DONTWAIT, NULL, NULL);
+	if (!connected) {
+		if (ASSERT_EQ(n, -1, "no datagram"))
+			ASSERT_EQ(errno, EAGAIN, "recvfrom errno");
 		goto fail;
+	}

-	n = recvfrom(env.rfd, recv_data, sizeof(recv_data), 0, NULL, NULL);
-	if (ASSERT_EQ(n, sizeof(recv_data), "recvfrom len"))
-		ASSERT_MEMEQ(recv_data, skel->data->send_data, sizeof(recv_data),
-			     "payload match");
+	if (!ASSERT_EQ(n, sizeof(recv_data), "recvfrom len") ||
+	    !ASSERT_MEMEQ(recv_data, skel->data->send_data, sizeof(recv_data),
+			  "payload match"))
+		goto fail;

 fail:
 	if (tfd >= 0)
@@ -124,6 +144,21 @@ void test_ksock_lsm(void)
 	ksock_lsm__destroy(skel);
 }

+void test_ksock_lsm(void)
+{
+	static const struct ksock_test_case tests[] = {
+		{ .name = "unconnected_send" },
+		{ .name = "syscall_connect_send", .connect_in_syscall = true },
+		{ .name = "lsm_connect_send", .connect_in_lsm = true },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (test__start_subtest(tests[i].name))
+			test_ksock_lsm_case(&tests[i]);
+	}
+}
+
 void test_ksock_lsm_verifier(void)
 {
 	RUN_TESTS(ksock_lsm_verifier);
diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm.c b/tools/testing/selftests/bpf/progs/ksock_lsm.c
index 9808451098ef..944398ce2852 100644
--- a/tools/testing/selftests/bpf/progs/ksock_lsm.c
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm.c
@@ -13,6 +13,9 @@ char send_data[32] = "hello from bpf ksock";
 __be32 ipv4_remote;
 __u16 remote_port;
 int target_pid;
+bool connect_in_syscall;
+bool connect_in_lsm;
+int connect_ret = -1;
 int send_ret = -1;

 SEC("syscall")
@@ -31,14 +34,15 @@ int ksock_setup(void *ctx)
 	if (!ks)
 		return err;

-	addr.sin.sin_family = AF_INET;
-	addr.sin.sin_port = bpf_htons(remote_port);
-	addr.sin.sin_addr.s_addr = ipv4_remote;
-
-	err = bpf_ksock_connect(ks, &addr, sizeof(addr));
-	if (err) {
-		bpf_ksock_release(ks);
-		return err;
+	if (connect_in_syscall) {
+		addr.sin.sin_family = AF_INET;
+		addr.sin.sin_port = bpf_htons(remote_port);
+		addr.sin.sin_addr.s_addr = ipv4_remote;
+		connect_ret = bpf_ksock_connect(ks, &addr, sizeof(addr));
+		if (connect_ret) {
+			bpf_ksock_release(ks);
+			return connect_ret;
+		}
 	}

 	err = ksock_ctx_insert(ks);
@@ -51,6 +55,7 @@ SEC("lsm.s/socket_bind")
 int BPF_PROG(ksock_socket_bind, struct socket *sock, struct sockaddr *address,
 	     int addrlen, int ret)
 {
+	union bpf_ksock_addr addr = {};
 	struct bpf_ksock *ks;
 	u32 pid = bpf_get_current_pid_tgid() >> 32;

@@ -63,7 +68,18 @@ int BPF_PROG(ksock_socket_bind, struct socket *sock, struct sockaddr *address,
 		return ret;
 	}

+	addr.sin.sin_family = AF_INET;
+	addr.sin.sin_port = bpf_htons(remote_port);
+	addr.sin.sin_addr.s_addr = ipv4_remote;
+
+	if (connect_in_lsm) {
+		connect_ret = bpf_ksock_connect(ks, &addr, sizeof(addr));
+		if (connect_ret)
+			goto out;
+	}
+
 	send_ret = bpf_ksock_send(ks, send_data, sizeof(send_data));
+out:
 	bpf_ksock_release(ks);

 	return ret;
--
2.43.0

