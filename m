Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698487;
	b=gGqeAa9F5YPD1elqbAqfG598hefqtXfhujAhvmpfNkaVvr0c32f8PamPiT8Hlp9QCLMr
	 hrr/C9qf5TRUsgh3VghrhHPH6S6uapK/oJv2X5T9UAa24MGvcQvaYQ+ITkAiAvpdOav4O
	 u5jFbw4KoCnxsoYcIwUnehRCVPPkih/MS9aPD81qYKKnpTP7aX138WoKj16RGBb5DQ4Ku
	 X5rGHyJvaXBuz52bZP3bVdG/AFd1DajHkVwDdd7eJ4vUGqsdpbYcWsjBqukXYBypmr5Od
	 LtZbC7tO8s4mXFsW4fVqx39kM8YxFbVqdXDjhSYYTOvxeyAVHzwAuDQUT0qlgeWb+OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698487;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nEqMgqyd/762KLfRuk3SpbGEirCMEdUQqsbedRol0yE=;
	b=KATKv71uQrS9wuiusnPZGvaZRQ0YjojfR6qQXrM09HusG5BEB3Dw+uZk2LWLGKxbjFmq
	 1PLcyH4NBvU7Tr/ueiAhcr5TH3mZBy46ShsYvB3VyeR5GjBJqd+atDgy6vp5lr5RvOajA
	 W1aejfGH27WjmV3N1zTUoWnlHcDpmSLBZLmrF3kBzqsE41yWET05/9Ig2AeyyXhbavkB/
	 cll4u8tB0v3bEf0Duuj4ETA6m5wDw6Rrz0wcPnY5n6JHug9AO0RnjL0A3QNaAltfBXm1W
	 XkXwEc4fCSaKZoQ2mki3L3G38qvLmHluRMSlCtZAMWBcs3nyGKnAKOpdeNchGV6A/nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdI4SjA0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF265606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdI4SjA0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14061F000C1;
	Tue,  3 Nov 2026 09:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698486;
	bh=nEqMgqyd/762KLfRuk3SpbGEirCMEdUQqsbedRol0yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fdI4SjA0lHJciGnHDno1xeSGphHtiyyMkRp/eADiuetnME44g0gH9TcX76yI/KLok
	 UGYcSMMq/GHgUtH92R+7vulmM1WucYKnyeb0Zi5HKH5oXq2CIHKJ9LOcehAr/VNWCd
	 kjJQBRkB45IJxKKUKY8jYshJvXM+omhS94UJnclZDzkQnt8YyLbQLI0ke/l7vnbosJ
	 2k4QxA9yfdmqJCc03NttJZLum0yeGJmB7lEDmwwZCKlYscrosqaS0sX/lKXv9LaXVr
	 LvGGH2mq06UZvflVEd9U8vl1qBT2oN8Cv8mbSkDAyOSG4n1ydM7NpBji1QFEynphJN
	 EAiQscsJ99AWw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	HyeongJun An <sammiee5311@gmail.com>,
	Christian Simon <simon@swine.de>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Verify classic uprobe attach types
Date: Tue,  3 Nov 2026 10:34:00 +0100
Message-ID: <20261103093400.112178-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103093400.112178-1-jolsa@kernel.org>
References: <20261103093400.112178-1-jolsa@kernel.org>
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

Check that loaded uprobe and uretprobe programs retain
BPF_TRACE_UPROBE as their expected attach type.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/uprobe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe.c b/tools/testing/selftests/bpf/prog_tests/uprobe.c
index 86404476c1da..7d372552f5ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe.c
@@ -44,6 +44,10 @@ static void test_uprobe_attach(void)
 	skel = test_uprobe__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
+	ASSERT_EQ(bpf_program__expected_attach_type(skel->progs.test1),
+		  BPF_TRACE_UPROBE, "uprobe_attach_type");
+	ASSERT_EQ(bpf_program__expected_attach_type(skel->progs.test3),
+		  BPF_TRACE_UPROBE, "uretprobe_attach_type");
 
 	urand_pipe = urand_spawn(&urand_pid);
 	if (!ASSERT_OK_PTR(urand_pipe, "urand_spawn"))
-- 
2.43.0

