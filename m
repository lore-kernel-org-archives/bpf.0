Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EC84F475E
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776751; cv=none; b=StGvSzsch4nJcFMJhLrxGKZGqpTM2f9xZTZZqzYw/Gm7KfVtOcmyKbtk20oMvza73AF+eT8KENfvthzG04gLK5LmCS8SB9rfmjbFRKUbkP6j867uz3dbrPoLlCkpySj6YMz1kOkT1bue/pqnGQV14GXsmdZy7lF1+TLU4BbxDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776751; c=relaxed/simple;
	bh=JxTWYR96h03bsKZA1zdkdXQWgiv9P/sXx3vqgnWSqxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8aOTY9hM5Xp9ZRSl0hZwzvxjiBSfn/+cP8vF/w8ctixVruCaY9f0WIo/hQr7gGbK9ldaSjZo8ZamcBbxNl7fcWRn3Pw4pU8JE79eIPCYLTAJTPy8llkij4jcrFXkZppQWb+f901yoExILolGI8G8vmXEcj+mHzYi5/KdVNqIAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=RRL3cfYs; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="RRL3cfYs"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E83FD82B93;
	Wed, 30 Sep 2026 15:59:00 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M51s_TbVaY5E; Wed, 30 Sep 2026 15:59:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790776740; bh=JxTWYR96h03bsKZA1zdkdXQWgiv9P/sXx3vqgnWSqxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RRL3cfYsOibr30hQmnyafPeTj+4hz8V1/ca02zBDuWDwY+/O/nDw7yCm8CDbi/iHe
	 2cBVoJwKaNaAkNCwamEks/xB4YyWbApWcD+n4brVVE8Bpt7WQKdS9j0xF/QL7Asdfd
	 P3FC5r9N6vTbmqV2KpvSS5DvA2m5LxKOl9N7HIwi4TsUTaQ1LntSWixPE32KCqXvJk
	 ulRshpbTwGEd4zRRrH1Tjhr6gNLi1kLzCzFpGNL5bwLaVvkPLp6l2Bkg8sxaRR2yb5
	 DwJADYsupIEbEZHZzMKiM6RwKTLyoGjn4vjmKobTsAOaL/nCrTpUR3cNtAeNTDEnaN
	 TnIVDZvbYDdkA==
From: Masoud Aghasi <maghasi@disroot.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	leon.hwang@linux.dev,
	Masoud Aghasi <maghasi@disroot.org>
Subject: [PATCH v2 2/2] selftests/bpf: add test for percpu map flags combination
Date: Wed, 30 Sep 2026 14:57:53 +0100
Message-ID: <20260930135753.1063495-3-maghasi@disroot.org>
In-Reply-To: <20260930135753.1063495-1-maghasi@disroot.org>
References: <20260930135753.1063495-1-maghasi@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to exercise usage of a combination of flags for
percpu hash map updates.

Before the fix, these tests fail to respect user flags combination of
(BPF_F_CPU | BPF_EXIST). With the fix applied these tests pass.

Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
---
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 7b4a1e24363b..e14a476da5c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -537,6 +537,34 @@ static void test_hash_cpu_flag(void)
 	test_map_op_cpu_flag(BPF_MAP_TYPE_HASH);
 }
 
+static void test_percpu_map_flags_combination(enum bpf_map_type map_type)
+{
+	u32 max_entries = 1;
+	u64 flags, val = 0;
+	int err, map_fd, key = 0;
+
+	map_fd = bpf_map_create(map_type, "test_flags_combo",
+				sizeof(int), sizeof(u64), max_entries, NULL);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
+		return;
+
+	flags = BPF_F_CPU | BPF_EXIST;
+	err = bpf_map_update_elem(map_fd, &key, &val, flags);
+	ASSERT_EQ(err, -ENOENT, "bpf_map_update_elem flags_combo");
+
+	close(map_fd);
+}
+
+static void test_percpu_hash_flags_combination(void)
+{
+	test_percpu_map_flags_combination(BPF_MAP_TYPE_PERCPU_HASH);
+}
+
+static void test_percpu_lru_hash_flags_combination(void)
+{
+	test_percpu_map_flags_combination(BPF_MAP_TYPE_LRU_PERCPU_HASH);
+}
+
 void test_percpu_alloc(void)
 {
 	if (test__start_subtest("array"))
@@ -565,4 +593,8 @@ void test_percpu_alloc(void)
 		test_array_cpu_flag();
 	if (test__start_subtest("cpu_flag_hash"))
 		test_hash_cpu_flag();
+	if (test__start_subtest("percpu_hash_flags_combination"))
+		test_percpu_hash_flags_combination();
+	if (test__start_subtest("percpu_lru_hash_flags_combination"))
+		test_percpu_lru_hash_flags_combination();
 }
-- 
2.47.3

