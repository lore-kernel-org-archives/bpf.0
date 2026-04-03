Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E662D94BA;
	Fri,  3 Apr 2026 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775202739; cv=none; b=pXc8Y7RI26h4kJrsvJ4idYEU/NSrJXDOyxCrDr6bpALvNns4DB50QHJ75hE0Zct0Urd3LY2iWjQNiHUnT9ssjCb9m9FRGfHFXlgUqOsayIFTM9gwkznvUDRKOQcLizD9sj3/riy5WVFsQkJrx0PhtsBi7urdqHv5ZDe2b5AWLoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775202739; c=relaxed/simple;
	bh=OBpaZEE22lcXZcmCVd7Uv4GpMiXDbuH6DCx2uQqXPSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OL/Cdj0De7mKkPPP8GLowxAz6z9Yx/97s2X7gW/6+toh1S9ldW35rH+aEQhxHgjzgOP6d2N0aVof41UpJ5oDNowHvsLM7ydrPsOuPfaL7RzXnWXpHhmq+Q+Idjqd1AcP46snBrFWNw7hQXbMQnmJRhcmk2DRt6CTvrlBl8cKZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Hfw/T8mk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Hfw/T8mk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B03331A311C;
	Fri,  3 Apr 2026 07:52:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7CCD7603C1;
	Fri,  3 Apr 2026 07:52:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF802104502AB;
	Fri,  3 Apr 2026 09:52:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775202734; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=l2tKqb2cP8dgE3Jxvi84X6u600OhvCUQw7yoh5rEaXU=;
	b=Hfw/T8mk+G1OivmviRmK2FPteJEYnDzfJ0ERP907qXaTRLR5fkj3iAWWTToGv9+qaV7biN
	cWD3Cg1V4XZ9riLZFSK+jPYyZXB4y9K9oExToeVTjGo0vhkuJ43rAN0mYsvvhDVElbdhps
	LKn+lpA+4FLzLcPQnMCYKCmgqndEuw2dbBW2vKLlmfMGarb4fJzSqCZ9AsqIvRTK19dBzi
	w/ymb2fZV7Pro0u3Hnc1DQpF2ZzA7gHi9xsBrH1rrV9dnvzcs9xO+AX92F/QnOf1oEdnCM
	Z8FxbA+/dB3M4YBosn3dUvXbjoabHa2guMx5dapakJrMQwDQbQkXOhsL3JecbA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 03 Apr 2026 09:52:06 +0200
Subject: [PATCH bpf-next] selftests/bpf: remove unused toggle in tc_tunnel
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-tc_tunnel_cleanup-v1-1-4f1bb113d3ab@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMWwrCMBAAr1L220D6oEqvIlKSdbeulDXkIYXSu
 xv1cxhmdkgUhRJMzQ6R3pLkpRXaUwP4cLqQkXtl6Gw32sH2JuOciyqtM67ktATj2faOB77gGaF
 2IRLL9ntewQc2SluG29+k4p+E+buE4/gAd2mYTH8AAAA=
X-Change-ID: 20260403-tc_tunnel_cleanup-bf03af4f8c7c
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.0
X-Last-TLS-Session-Version: TLSv1.3

tc_tunnel test is based on a send_and_test_data function which takes a
subtest configuration, and a boolean indicating whether the connection
is supposed to fail or not. This boolean is systematically passed to
true, and is a remnant from the first (not integrated) attempts to
convert tc_tunnel to test_progs: those versions validated for
example that a connection properly fails when only one side of the
connection has tunneling enabled. This specific testing has not been
integrated because it involved large timeouts which increased quite a
lot the test duration, for little added value.

Remove the unused boolean from send_and_test_data to simplify the
generic part of subtests.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
index 23b5c522ea9f..1aa7c9463980 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
@@ -206,18 +206,13 @@ static void disconnect_client_from_server(struct subtest_cfg *cfg,
 	free(conn);
 }
 
-static int send_and_test_data(struct subtest_cfg *cfg, bool must_succeed)
+static int send_and_test_data(struct subtest_cfg *cfg)
 {
 	struct connection *conn;
 	int err, res = -1;
 
 	conn = connect_client_to_server(cfg);
-	if (!must_succeed && !ASSERT_ERR_PTR(conn, "connection that must fail"))
-		goto end;
-	else if (!must_succeed)
-		return 0;
-
-	if (!ASSERT_OK_PTR(conn, "connection that must succeed"))
+	if (!ASSERT_OK_PTR(conn, "connect to server"))
 		return -1;
 
 	err = send(conn->client_fd, tx_buffer, DEFAULT_TEST_DATA_SIZE, 0);
@@ -391,7 +386,7 @@ static void run_test(struct subtest_cfg *cfg)
 		goto fail;
 
 	/* Basic communication must work */
-	if (!ASSERT_OK(send_and_test_data(cfg, true), "connect without any encap"))
+	if (!ASSERT_OK(send_and_test_data(cfg), "connect without any encap"))
 		goto fail;
 
 	/* Attach encapsulation program to client */
@@ -403,7 +398,7 @@ static void run_test(struct subtest_cfg *cfg)
 		if (!ASSERT_OK(configure_kernel_decapsulation(cfg),
 					"configure kernel decapsulation"))
 			goto fail;
-		if (!ASSERT_OK(send_and_test_data(cfg, true),
+		if (!ASSERT_OK(send_and_test_data(cfg),
 			       "connect with encap prog and kern decap"))
 			goto fail;
 	}
@@ -411,7 +406,7 @@ static void run_test(struct subtest_cfg *cfg)
 	/* Replace kernel decapsulation with BPF decapsulation, test must pass */
 	if (!ASSERT_OK(configure_ebpf_decapsulation(cfg), "configure ebpf decapsulation"))
 		goto fail;
-	ASSERT_OK(send_and_test_data(cfg, true), "connect with encap and decap progs");
+	ASSERT_OK(send_and_test_data(cfg), "connect with encap and decap progs");
 
 fail:
 	close_netns(nstoken);

---
base-commit: 9ebb4fa90266705741534924eac62d6f03895fea
change-id: 20260403-tc_tunnel_cleanup-bf03af4f8c7c

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

