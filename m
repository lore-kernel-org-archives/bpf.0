Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797703A1684
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591414; cv=none; b=N1EaRhNR9QS3J9xiHm9j2+JTmgfbU2+q4o8g5hs1TCW59OIxHJRennxekfiUI0BInuW65aN5L7U0Ne0dyZYXVulDryVkIxf7LdP52F1nwKrsctxuSc8Ub7YBPoLrdfsuV3kJArmw9bXzXp1y5O9VJmp8hjua1344qCQ+/rls8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591414; c=relaxed/simple;
	bh=VtD4IAUkF8c8JKC4eB0uYR5C7tyifNbCmVEjM2Z3dlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhcdPdtNrSRexo5VHnJyLpjjixfoP1iXq6/lhRtyYgn5y4pYUuLgtBnkVROdVkuzD0iju7Ozh9sVQfxjFFVuQNKhC6+BfPl4avw/1+Pa6b0HZTliemreRdollGpSqq8RwCrXhpWwm0/iycr1r5SHOz3EPPuJOFiIFySDv+AYfW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OwipMGBy; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OwipMGBy"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1D4A3807BE;
	Mon, 28 Sep 2026 12:30:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t4vCYtH7Sacg; Mon, 28 Sep 2026 12:30:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1790591407; bh=VtD4IAUkF8c8JKC4eB0uYR5C7tyifNbCmVEjM2Z3dlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OwipMGByLd8h0wVnVB3bPgppmT8RvSYJ7idRe9dIzuN9o1E1K1Lnkeox3ZXo2JIc8
	 M4haZ54ehz/0D3jyp6Fa8qeKSiGF2dneWfVp87TDigYSbKdinkcnqC1zGMjoE2LpWE
	 hMN0eLmaPLOYZpkRifOhp35mMWP4xv56YHcwIRG7VpDO3CmlRSe75jhL2lbarvjHD8
	 iSKdO/RFMEH7UKrj5aCscnL4E6xcREoEVZxUpUMgD0ct8lQXUovC4AFU7h65lLt87K
	 5slZU7eMc9D+WZtSkpo0GEBTy5CRITwT6DgkDz5uktur0vtm1SjNdBlmeiCk8XocXn
	 u0ujzdxTUmm4g==
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
Subject: [PATCH 2/2] selftests/bpf: add test for percpu map flags combination
Date: Mon, 28 Sep 2026 11:28:21 +0100
Message-ID: <20260928102821.995214-3-maghasi@disroot.org>
In-Reply-To: <20260928102821.995214-1-maghasi@disroot.org>
References: <20260928102821.995214-1-maghasi@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that exercises using a combination of flags for
percpu map update.

Before the fix, this test fails to respect user flags combination of
(BPF_F_CPU | BPF_EXIST). With the fix applied the test passes.

Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
---
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
index 7b4a1e24363b..a0a1fa0e11c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
@@ -537,6 +537,24 @@ static void test_hash_cpu_flag(void)
 	test_map_op_cpu_flag(BPF_MAP_TYPE_HASH);
 }
 
+static void test_percpu_hash_flags_combination(void)
+{
+	u32 max_entries = 1;
+	u64 flags, val = 0;
+	int err, map_fd, key = 0;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_HASH, "test_flags_combo",
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
 void test_percpu_alloc(void)
 {
 	if (test__start_subtest("array"))
@@ -565,4 +583,6 @@ void test_percpu_alloc(void)
 		test_array_cpu_flag();
 	if (test__start_subtest("cpu_flag_hash"))
 		test_hash_cpu_flag();
+	if (test__start_subtest("percpu_hash_flags_combination"))
+		test_percpu_hash_flags_combination();
 }
-- 
2.47.3

