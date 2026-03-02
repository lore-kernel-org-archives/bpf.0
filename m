Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EEC319871
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772435696; cv=none; b=PLmB08Fnsd4hvhtwiObEOaepwiPjrV64LfYQZZ4Mte+3Fn+IqsL2b96rgL8EOVZ9lgGSrx/QTnWUVtaq70CXOVT0CM9H1v0Wz1C3kq2JIB7Rnxh8aGk5YV7G6tWNT4SvMhcFm78vr8MCadyWaj4xE6shm9x8kLK5GYQqsmV0hGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772435696; c=relaxed/simple;
	bh=IqIHegnKM2HEYo0MpRxqsAMyp5aspxcpxaEEy/gmTyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUQgKE2czzECkLOnvBpkF/vxkbNG6Bb9n9SwM8qQaPmQ0JZgf6rtBgXPJSzuB2q3s4gvU+IfPCoEmbP8He9vnLExqvvMr5ScSgobuVYN0mpm7bGCUNV7y430dMrBZxLz7Gn+DAx55aC/HuVgquVM09o9AIXiSI7Rf4WnF7NkrcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcNGxVgd; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcNGxVgd"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4638a18efc2so3131441b6e.3
        for <bpf@vger.kernel.org>; Sun, 01 Mar 2026 23:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772435694; x=1773040494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qx9IFITrMKLlkT1svVa6s0PRctPgUnyk1fnGEcICs8I=;
        b=VcNGxVgdjWhfMnCnYrF+n2JyqEAbhhLuu39zn+/iCshka7PuUK1jegg9Yd7ituNwUU
         zXCxulUA6TLaz31OlVAAd+ev42Ok3PVa+ZePEA6u+VSX1OzkTVUu4XKxnHO7w1VSP31R
         KSFHRwAlHMnjlcCUiRZ5rSr9PVzbrn2A7eSSyjdq7srWTEiXHKNRoaI+i/b+Yl9HUfSN
         AQzfx8aDnATnMaUFlCAHNFwjF+UnzS1aBiOlTSa64rPGv1E5Hqe68JiTYVq5ntbNRuWE
         SbfPdrqp2bqpvz1YKwZNc5p5n73mCnd0a+ifbljEPcLoc6XeBMXSFvRSDLYVTFdRgXTi
         Zohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772435694; x=1773040494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qx9IFITrMKLlkT1svVa6s0PRctPgUnyk1fnGEcICs8I=;
        b=ffsMjqclf/rYeLPgzOaRYph4LwHZrmiz/cAlwnppZ0oW1NeTdWN4YensXNULAP10u3
         g+CPXjuN1PzfF2aOZfZJWctYpcfg8mdkYIsINiroGd3Epu38+Rif8oIBqSjblskCgO0J
         iMd4h4GsKyVxgw5HqIITx+V9fkJIj8yJJqlf7o0fdtToeq539NvIZ32AO6MBgfdx0D2V
         KMoQTOwK+OcNH03CeUVDTjkTeJNv3caGfvSXy8oDVk/pwJqG6wUOro0vCsMU/ogp1bKg
         K4ayI96orDvjxdzmWdTGHj/D9UroELKtuvEeBTuUWX9jJ83b47yeKolN7TEZceQ00W5n
         lwEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfzxyxb5aeylN06IUS0pn9IoWDhts7poQx8WkVvwTvGtZRg2J3sedz+CpFegWFREQzTWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90sOg2RWbb6lFGpqy6CF37jx22+PRy7f6pLT+DYJcPIWvVPl4
	w/XgLYlm4fLqbLm/Ay2iph3UH94v8MuxoKpgrRvjUNN7p3fuF0x7nGYS
X-Gm-Gg: ATEYQzzbQ7nGHfyMh0NsfGSRV3n8fn2NIyztDnMakG4BWiqFZ74U1tV1t3YTjxwf3bl
	N068DrNPUqnXJzMbPTraTCK36wCSkhQQXUW9dNgK/PtgfmrPBo63hkPuk3/yMlI8+bRyBMruvTD
	ykfRZ9ivxNpwmUWlAZ8xc64cGG7t5Usq+S8MBCOVvnuUhRaYstcZ6HSsniDuqJA6iesmM8k/QXu
	c4sqmKM7SAeE6s7X9Oi/SBvFQ/PldiQ/2W/tUp7JEwV8eETOp53sDD5bUnw8e5WJIv+7tZvIhYt
	qWJPI9XVYGSpcB9NDVRDPzxwhxqEa7sfAUCwGEXBJ2Z0YC8uf955KouE1xjm7IdIrvVIDGKuTQK
	X6blanxTngKqXIeP4tJK/FHHWB+1jdyRbcmteOHhISm9dmhPod/0GgSLVjqErEKAGbUUSjmcYiP
	7hwOp9SbfWRB9RUX5Goq1nl6iWZiu4y8liO7Q3Y0kRsXrGW5245d30NEC3Pm1dvyZRsJwZrmAmw
	4LjFJfcqS7sAUiilmd6ivaXBs+GjIH1PCUaTL59LAjHA9LU46s=
X-Received: by 2002:a05:6808:1391:b0:45e:6cac:92c9 with SMTP id 5614622812f47-464be9fb4c3mr7130460b6e.27.1772435694139;
        Sun, 01 Mar 2026 23:14:54 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb3ab494sm6867919b6e.8.2026.03.01.23.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 23:14:53 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] selftests/bpf: skip verif_scale_pyperf600 on -E2BIG jump complexity limit
Date: Mon,  2 Mar 2026 15:14:34 +0800
Message-ID: <20260302071434.311395-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

verif_scale_pyperf600 loads pyperf600.bpf.o, a large scale case produced
by partial LLVM unrolling.

On some kernel/toolchain combinations, the verifier rejects it with -E2BIG:

  The sequence of 8193 jumps is too complex.

This hits the verifier jump sequence complexity limit (8192).

Treat -E2BIG for this test as SKIP rather than FAIL. Other pyperf600
variants are unaffected.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../bpf/prog_tests/bpf_verif_scale.c          | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 73f669014b69..181acdddea1c 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -112,13 +112,33 @@ void test_verif_scale_pyperf180()
 
 void test_verif_scale_pyperf600()
 {
+	libbpf_print_fn_t old_print_fn = NULL;
+	int err;
+
 	/* partial unroll. llvm will unroll loop ~150 times.
 	 * C loop count -> 600.
 	 * Asm loop count -> 4.
 	 * 16k insns in loop body.
 	 * Total of 5 such loops. Total program size ~82k insns.
 	 */
-	scale_test("pyperf600.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+
+	if (env.verifier_stats) {
+		test__force_log();
+		old_print_fn = libbpf_set_print(libbpf_debug_print);
+	}
+
+	err = check_load("pyperf600.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT);
+
+	if (env.verifier_stats)
+		libbpf_set_print(old_print_fn);
+
+	if (err == -E2BIG) {
+		test__skip();
+		return;
+	}
+
+	ASSERT_OK(err, "expect_success");
+
 }
 
 void test_verif_scale_pyperf600_bpf_loop(void)

base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
-- 
2.43.0

