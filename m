Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499A449999
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458407; cv=none; b=gH0y3mNbbIwgcGOnbJENbSXpe1zPfGSdXdd4H+pwv8SzetphvB1F6jfK71IPMBCU2ME7HpUOhPqQqL8aWBGao/+ESSgJq2oIwDAiEOmmWcA/7mG5aC5bT/mdCSviyiQn62xOsBVR9DIIBv+IadlP3KwsLsjisSkJ/M93rS/qtmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458407; c=relaxed/simple;
	bh=jPQWMRzJN8KkiKEp2dEV0cXDOfHSJHi18+FwEMSjxs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T9OL5v0xzDsU3R7xBv1X91DjWav2qhZS1GHDd0EtrU9AgEujvcUnbG5Q0Vnj7L4PfgLSJheUcUQxkLl2G5VlvFtRlmsigeSA77VM3phoOIFukyUawz67WSOY7a9QDXFRt007ISv8G/LMfxrep4yY8t0nx8Z0OqAtf9oULGoUqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QS+pk5J1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QS+pk5J1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4EBEC1A1570;
	Tue, 11 Aug 2026 14:26:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1ABDD6033C;
	Tue, 11 Aug 2026 14:26:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E56311C48D19;
	Tue, 11 Aug 2026 16:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786458398; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Agq3sfKBD0YIl3ZEZMoJ6k37uVUxPAwcPH2YFUuq8mY=;
	b=QS+pk5J1lRswgAiZEWWUP0YOezG7FUmxaYn0Jr6KWQhys/dv4Xs7H4ChCbLVt/zRMoQh0R
	LGXDZjoXYOIC7DQFeatCLS8zLSy9BS0D0N01Q0zDQ5xEdrp/2YvU6gHiS3d4GcTlZLi02m
	bsT0D/EQxp3/sQ0IycdeIqK7Rp09Yrdhp2CUaO1lPQ0bMSkR7m5qXC/Y+vWjEe4jqiFHld
	jP4jajIhQypeQWM2WNDVntlt0OUtm88FnQD8TpBqrObeAQ2TESQNHcqP/iFgLqIkfPoy7I
	8xyFkozQ7/r+SHahlpXy2GqSghJowDbNmYf/W0ljkgiJxS2108IU7IW6KwvPMw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 11 Aug 2026 16:26:13 +0200
Subject: [PATCH bpf v3 2/2] selftests/bpf: add connect timeout to
 test_tc_edt
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-tc_tunnel_flaky-v3-2-876f4e0bc603@bootlin.com>
References: <20260811-tc_tunnel_flaky-v3-0-876f4e0bc603@bootlin.com>
In-Reply-To: <20260811-tc_tunnel_flaky-v3-0-876f4e0bc603@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Now that the connect helpers from network_helpers.c poll the connect
status when connect() returns EINPROGRESS, make sure that test_tc_edt
benefits from this polling by setting a timeout value for connection.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/prog_tests/test_tc_edt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c b/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
index 462512fb191f..8ac3caa3d091 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_edt.c
@@ -109,7 +109,7 @@ static void run_test(void)
 	nstoken = open_netns(CLIENT_NS);
 	if (!ASSERT_OK_PTR(nstoken, "open client ns"))
 		return;
-	client_fd = connect_to_fd(server_fd, 0);
+	client_fd = connect_to_fd(server_fd, TIMEOUT_MS);
 	if (!ASSERT_OK_FD(client_fd, "connect client"))
 		return;
 

-- 
2.55.0

