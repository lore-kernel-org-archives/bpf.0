Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393E3562617
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061057; cv=none; b=cLHfTdauMkRjLHbZOy1ffQGoKzABy4TgXPB/yylvv2CLjRZW1myjZAqrkXI1Y/L+xOBbTyN6NFkh68mpwmncUhvScWSO+vBUjOTbz1wxDrYdbc1wVIjRfzcz2hEtYYEl/JfjOqproQMGljYtranYw0QfmalJHPHq7/ilcExa99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061057; c=relaxed/simple;
	bh=zO/SPNdon2pdqyZUxl36yf0nSMTSVAwzDRVEhNiLIDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpjU87dh4NldZWPPQwevxIiXRVh3yNVhwtCH+a/VkaJspxKXBWl1gdq9diZq77IniAqgthxV61kd8g1GUuxH9mYQiX5nY8fuNiTNJKCD5gI+/lt95I00yDf/RXAvfLjgdgfMDIqm0HlRGBX8z+44BXothjAzHchiDZ4BjNljLrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPkTKwJ1; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPkTKwJ1"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so2644363a91.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789061039; x=1789665839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hxmfltWUCBswI++r7Px5zoeRZX2z1LT+ChZwk/CFaaA=;
        b=jPkTKwJ1qSLVYSTlLUX7FeYgSxc1igQEAohraR+h4cIiuMHhpobfYHx5CnG6IGqRks
         YEBiFeONJ8MpK6OGw2G0IuRqf+ubMgi8oaEPLgXw2Ikbeixrda/2754DrQBMyA/E11NF
         BefgvrwTBzkjA+eAY5wIITnmEykyy8M8McM+BSXqURoGJ+ZruZdxFKO8v7mT49HLIZoh
         rP/plFogkZfEUmABsbAyE7J49bbFGt6lDoznpvYWAWB4GL/EMp5xU4ZGVgZcGpxEwmsL
         oKAiR3hz512/P/hRrbRTSQrHuRo4GV5z/+J0m3ebxRs9xpdrC01GQ5eZKLKTZrkOB1QM
         BeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789061039; x=1789665839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hxmfltWUCBswI++r7Px5zoeRZX2z1LT+ChZwk/CFaaA=;
        b=eI/sjuA//kUgKpAwktzXkk731oE6TwdrYikOpb9vo+bCaFJHWMCFySKmWOP7/mQQ0X
         B2mCjOihBX8l68up3lpDADOV5ebZJTvNwVKl/8NcIdM5pWxn5ie1iHnqPVu+BKI3aVux
         1kgZC30U83LiW23RSqQqCSvgopZjn81CmQ7wAA5J6OpSYBMdw/kvN6YEMFf9LUONuUSr
         I2KoROZ8M30g+D5q9bNStPUJkPK684tFAm3IniglYpXbqBNooWTFLLvhi/jhlD2NSinZ
         +dW2hgeEBk6lgKy4n+51fSS36L8kgPxHy0jTghj2RTP4vZnUVvFTW6RHJUM9sVT0iMD/
         NAzg==
X-Gm-Message-State: AFuF++nIPETdN+J+agB9BtL5O2RxVeCNP8RXanK/EIG0umcN2JcwWp/8
	7cwU+wuqzGvk6LV6FCUM3pDYHm5fdq4mcr4cAcwNMvxY8cS5xcDk0nVj3gNi7JjC1iQ=
X-Gm-Gg: AYBFou3szbITl75emDv3FKAxAAdtFpKXv+G0nAiVMXy45S60VKmJxpRJg/ExVzYnStU
	/Pf0THPT9Qp7FeLQ3xThefuopwhzU6W6bE2iP1z66bhk4HOYcN6NCrjRxJseNH2e00c4k0xxYBE
	+CdG5EpOy/eUpSWaCRpw9YRzuVIyI57MCQabwtJuBUqpD8cTYNu6bUVeFXwu4+f2viGr6xDjsXC
	PYWAQvuBfhpvoed07iK3elmO/30Knbjt3l4cn7nqowmFwiCaTFVgujxJiASGqL5BE0Bu6+ICX+z
	qxW72sRf5zpyZmS8cK3BVXE3veDNNKNRGTBdYIiSNxUj5kALiPv1F+WV83kQMxk8sUNbRrZYYU6
	Nf5yGY+NB3OVqu1dKwH7T20necUrXlB2OZdC0dTxX8tysPzBnYnn7FuTIxAKJIa/eH18rtU+r0V
	YRJQps6wXilkxTuUP7yy1wo/sc6TfD4+YofSI9gmKUWY+ZshbBAaR908AIVo7zCrUe3dDEYPbU2
	fdLloi+/2pxoinjGKeetByFNrBNrPr0Pd+ziKPBkJKF1LwW/WKxlI4H
X-Received: by 2002:a17:90b:3d89:b0:398:dcfe:968e with SMTP id 98e67ed59e1d1-39bac3f9063mr22147992a91.20.1789061038350;
        Thu, 10 Sep 2026 10:23:58 -0700 (PDT)
Received: from ubuntu2204.comp.polyu.edu.hk ([158.132.255.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d995a42a5sm164304a91.17.2026.09.10.10.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:23:58 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	Mingpei CAO <caomingpei@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Test private struct_ops bitfield rejection
Date: Thu, 10 Sep 2026 17:23:40 +0000
Message-ID: <20260910172340.1467764-3-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910172340.1467764-1-caomingpei@gmail.com>
References: <20260910172340.1467764-1-caomingpei@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an optional all-zero private bitfield to the struct_ops test. Verify
that libbpf returns -ENOTSUP and emits the bitfield diagnostic.

Keep the existing all-zero scalar test as the compatibility control.

Assisted-by: LLM
Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 31 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   |  7 +++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 75a0dea511b3f..517e5abe67c0c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -150,6 +150,35 @@ static void test_struct_ops_not_zeroed(void)
 	struct_ops_module__destroy(skel);
 }
 
+static void test_struct_ops_private_bitfield(void)
+{
+	struct struct_ops_module *skel;
+	char *log = NULL;
+	int err;
+
+	skel = struct_ops_module__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_private_bitfield"))
+		return;
+
+	bpf_map__set_autocreate(skel->maps.testmod_zeroed, false);
+	err = bpf_map__set_autocreate(skel->maps.testmod_private_bitfield, true);
+	if (!ASSERT_OK(err, "enable_private_bitfield_map"))
+		goto cleanup;
+
+	if (start_libbpf_log_capture())
+		goto cleanup;
+	err = struct_ops_module__load(skel);
+	log = stop_libbpf_log_capture();
+	ASSERT_EQ(err, -ENOTSUP, "struct_ops_module_load_private_bitfield");
+	ASSERT_HAS_SUBSTR(log,
+			  "bitfield private_bitfield is not supported",
+			  "private_bitfield_rejection_log");
+
+cleanup:
+	free(log);
+	struct_ops_module__destroy(skel);
+}
+
 /* The signature of an implementation might not match the signature of the
  * function pointer prototype defined in the BPF program. This mismatch
  * should be allowed as long as the behavior of the operator program
@@ -304,6 +333,8 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_load();
 	if (test__start_subtest("struct_ops_not_zeroed"))
 		test_struct_ops_not_zeroed();
+	if (test__start_subtest("struct_ops_private_bitfield"))
+		test_struct_ops_private_bitfield();
 	if (test__start_subtest("struct_ops_incompatible"))
 		test_struct_ops_incompatible();
 	if (test__start_subtest("struct_ops_null_out_cb"))
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 71c420c3a5a6c..423caf78f4207 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -76,6 +76,13 @@ struct bpf_testmod_ops___zeroed testmod_zeroed = {
 	.zeroed_op = (void *)zeroed_op,
 };
 
+struct bpf_testmod_ops___private_bitfield {
+	unsigned int private_bitfield:31;
+};
+
+SEC("?.struct_ops.link")
+struct bpf_testmod_ops___private_bitfield testmod_private_bitfield;
+
 struct bpf_testmod_ops___incompatible {
 	int (*test_1)(void);
 	void (*test_2)(int *a);
-- 
2.43.0

