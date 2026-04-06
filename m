Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC822F12A5
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490773; cv=none; b=oMV0GpNbXbjPHmuNCdQo9A0FeZ8Ylmw+r0ni5Ck6yPV3Ak/a2i2vv4FJaMjR9QhoYtp+idT+dbcaGSLCqSfiUmUzjpRN+WSrCQISAdBNZyc5hCTZ7xL+ADsWxO0MuSzE27SjEcDkGyHvBqZU6/HB4u2KaUoieXrrAHQ0vnpSch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490773; c=relaxed/simple;
	bh=/gSGrY55gnVyWxSaAF3sGOkAA8TYsz1sM0KyKFwMHz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i0VfR5aGdqp8UqzcXGTC94Fa5UUxAaRT/DQH5pZis6sYuoNuzKHmFnhaJZhE2ofqfPBOlNlNm8Qo/b20RLaFM3BQTs0kBgLR6hXwPzQiTp3E/1eUivhaMeTj5ch/9QM0S4QZuYmynLiNWkADO07q4+DvvXnltPAqZXkuEieLGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JP5jtpel; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP5jtpel"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d23305225so3258342f8f.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775490770; x=1776095570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmGPaumtNSg1VKbbvXzlFoaQU8nrMYj+VPeqTl5z2KY=;
        b=JP5jtpelj87+boUkKwAcoGvxebWrDOjylO4pTzs4/20Ymgl96V3JZm1/h8MTFFnIUT
         3EkFANgDj0d55LFNenmvXsMmu1/q5OzM9HbMi8NhzMlcojJFwvTKh/gKCgdyNTdmx9hq
         MKRAB/ERT+NfHkKQmsqGgEF2WR7CRnPWGjJbesFlqKI7LFt16jEoCOBXwE2rGmJ7ukJm
         qj2xwVlPt8E+IzIxZzHQv2OOYtJa1mJo025c8ukmXpwwxvPpNIZ1JPrnfmN2eVFNrj7M
         lPVabqY38kS2rbWpgOPv8ndrKp62K2VOec52td/rAgnAz61ynIUmienVZdAk2lSzCI6t
         0yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775490770; x=1776095570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bmGPaumtNSg1VKbbvXzlFoaQU8nrMYj+VPeqTl5z2KY=;
        b=ppGWezp7rMBrTGkX0VGNZ1qkj1VdNq+lwRnRmQUSCc+4CvwaKDhMtW0GRu2QoXC8WX
         +kwB+Ykl2wKKMxR+ZdqrYfg8zHluga6f6dND+S2bALR+rT+FxxoOy0xR5ISk4eUwAUp+
         9L1VKHVYBu78jHFSPjjOP0pDnEAJ/pUl+bVao7ew6ZflxKpjtg4ZUrRVryh+yVIujvZf
         L4te+KUCrhF4MFLFCTFRUceZ2YL7Zi1tAyaFgSXjM+9LoqNr/1vhkb3idpWMZQm0pPkA
         /GdQPjCw7iptiMbhdhNSygiqnGM2eF33c1xRlHeW2/YAiPf7jVYh+X16F0a+qasWByFF
         gtCw==
X-Gm-Message-State: AOJu0YwcyWzWJUnQUUkK33Lcn23y3RDxMW44ZDzl/ZNUSic5TGeotXGe
	IMc8en7IRMijK44vgYPFaviwKImz9NPxHvMJB/GujE/bURYgszCNvTrC2J8cAw==
X-Gm-Gg: AeBDiet4gk6ZoNN/XluQKOsxU6C6MwCH5GTSw/xy6ecApV6KLcigLP5vC3cXzRqKpPh
	4Z5Y7UY/tYo1TA0PWZyWk/o0U/wJGV/mAvPiyjX0bFp+6oZIdLlvyHgetMzC75y8eb79tFbWNcA
	4nsEfBCzeviChx34TRCi2/hAr2FOOktWExOQZ04t9khIejsz3vO5VYEParEy7nZgWL/rtXJbnP/
	7KRKEM9R7hcjKPOmO3R/D5h0lCKql4/0Zl1c4Oo9pPqFuXbc42a8lz1U5JOFyleAQas3bs0NUEs
	8AjkL1uwqNvFgukyik9TcyI1vnn3eu0jX3nrixvtOtbaR5W7gqdL1tfIso0kdUSdaf15GET360n
	QYT4Fycn5ISBrExupNr7LXEqfOFaZfOfTBPQ7uowdDhR7Cq1VhJFW1gP17awy/89xiAMnKcg4WN
	XJ5hYzkkoSvqBXU1UitmmsKjQtYlkuDC9VBhwjNEQNeA==
X-Received: by 2002:a5d:5f42:0:b0:43d:1dfe:45b7 with SMTP id ffacd0b85a97d-43d292e2b48mr18851243f8f.46.1775490770184;
        Mon, 06 Apr 2026 08:52:50 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm42114802f8f.4.2026.04.06.08.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 08:52:49 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiyong Yang <ksur673@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v3 bpf-next 2/2] selftests/bpf: Add more tests for loading insn arrays with offsets
Date: Mon,  6 Apr 2026 16:01:41 +0000
Message-Id: <20260406160141.36943-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406160141.36943-1-a.s.protopopov@gmail.com>
References: <20260406160141.36943-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A `gotox rX` instruction accepts only values of type PTR_TO_INSN.
The only way to create such a value is to load it from a map of
type insn_array:

   rX = *(rY + offset) # rY was read from an insn_array
   ...
   gotox rX

Add instruction-level and C-level selftests to validate loads
with nonzero offsets.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 123 ++++++++++++------
 tools/testing/selftests/bpf/progs/bpf_gotox.c |  31 +++++
 2 files changed, 115 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
index 75b0cf2467ab..73dc63882b7d 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
@@ -317,7 +317,7 @@ static void check_ldimm64_off_load(struct bpf_gotox *skel __always_unused)
 
 static int __check_ldimm64_gotox_prog_load(struct bpf_insn *insns,
 					   __u32 insn_cnt,
-					   __u32 off1, __u32 off2)
+					   int off1, int off2, int off3)
 {
 	const __u32 values[] = {5, 7, 9, 11, 13, 15};
 	const __u32 max_entries = ARRAY_SIZE(values);
@@ -349,16 +349,46 @@ static int __check_ldimm64_gotox_prog_load(struct bpf_insn *insns,
 	/* r1 += off2 */
 	insns[2].imm = off2;
 
+	/* r1 = *(r1 + off3) */
+	insns[3].off = off3;
+
 	ret = prog_load(insns, insn_cnt);
 	close(map_fd);
 	return ret;
 }
 
-static void reject_offsets(struct bpf_insn *insns, __u32 insn_cnt, __u32 off1, __u32 off2)
+static void
+allow_offsets(struct bpf_insn *insns, __u32 insn_cnt, int off1, int off2, int off3)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int prog_fd, err;
+	char s[128] = "";
+
+	prog_fd = __check_ldimm64_gotox_prog_load(insns, insn_cnt, off1, off2, off3);
+	snprintf(s, sizeof(s), "__check_ldimm64_gotox_prog_load(%d,%d,%d)", off1, off2, off3);
+	if (!ASSERT_GE(prog_fd, 0, s))
+		return;
+
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err")) {
+		close(prog_fd);
+		return;
+	}
+
+	if (!ASSERT_EQ(topts.retval, (off1 + off2 + off3) / 8, "test_run_opts retval")) {
+		close(prog_fd);
+		return;
+	}
+
+	close(prog_fd);
+}
+
+static void
+reject_offsets(struct bpf_insn *insns, __u32 insn_cnt, int off1, int off2, int off3)
 {
 	int prog_fd;
 
-	prog_fd = __check_ldimm64_gotox_prog_load(insns, insn_cnt, off1, off2);
+	prog_fd = __check_ldimm64_gotox_prog_load(insns, insn_cnt, off1, off2, off3);
 	if (!ASSERT_EQ(prog_fd, -EACCES, "__check_ldimm64_gotox_prog_load"))
 		close(prog_fd);
 }
@@ -376,7 +406,7 @@ static void check_ldimm64_off_gotox(struct bpf_gotox *skel __always_unused)
 		 * The program rewrites the offsets in the instructions below:
 		 *     r1 = &map + offset1
 		 *     r1 += offset2
-		 *     r1 = *r1
+		 *     r1 = *(r1 + offset3)
 		 *     gotox r1
 		 */
 		BPF_LD_IMM64_RAW(BPF_REG_1, BPF_PSEUDO_MAP_VALUE, 0),
@@ -403,43 +433,55 @@ static void check_ldimm64_off_gotox(struct bpf_gotox *skel __always_unused)
 		BPF_MOV64_IMM(BPF_REG_0, 5),
 		BPF_EXIT_INSN(),
 	};
-	int prog_fd, err;
-	__u32 off1, off2;
-
-	/* allow all combinations off1 + off2 < 6 */
-	for (off1 = 0; off1 < 6; off1++) {
-		for (off2 = 0; off1 + off2 < 6; off2++) {
-			LIBBPF_OPTS(bpf_test_run_opts, topts);
-
-			prog_fd = __check_ldimm64_gotox_prog_load(insns, ARRAY_SIZE(insns),
-								  off1 * 8, off2 * 8);
-			if (!ASSERT_GE(prog_fd, 0, "__check_ldimm64_gotox_prog_load"))
-				return;
-
-			err = bpf_prog_test_run_opts(prog_fd, &topts);
-			if (!ASSERT_OK(err, "test_run_opts err")) {
-				close(prog_fd);
-				return;
-			}
-
-			if (!ASSERT_EQ(topts.retval, off1 + off2, "test_run_opts retval")) {
-				close(prog_fd);
-				return;
-			}
-
-			close(prog_fd);
-		}
-	}
+	int off1, off2, off3;
+
+	/* allow all combinations off1 + off2 + off3 < 6 */
+	for (off1 = 0; off1 < 6; off1++)
+		for (off2 = 0; off1 + off2 < 6; off2++)
+			for (off3 = 0; off1 + off2 + off3 < 6; off3++)
+				allow_offsets(insns, ARRAY_SIZE(insns),
+					      off1 * 8, off2 * 8, off3 * 8);
+
+	/* allow for some offsets to be negative */
+	allow_offsets(insns, ARRAY_SIZE(insns), 8 * 3, 0, -(8 * 3));
+	allow_offsets(insns, ARRAY_SIZE(insns), 8 * 3, -(8 * 3), 0);
+	allow_offsets(insns, ARRAY_SIZE(insns), 0, 8 * 3, -(8 * 3));
+	allow_offsets(insns, ARRAY_SIZE(insns), 8 * 4, 0, -(8 * 2));
+	allow_offsets(insns, ARRAY_SIZE(insns), 8 * 4, -(8 * 2), 0);
+	allow_offsets(insns, ARRAY_SIZE(insns), 0, 8 * 4, -(8 * 2));
+
+	/* disallow negative sums of offsets */
+	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 3, 0, -(8 * 4));
+	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 3, -(8 * 4), 0);
+	reject_offsets(insns, ARRAY_SIZE(insns), 0, 8 * 3, -(8 * 4));
+
+	/* disallow the off1 to be negative in any case */
+	reject_offsets(insns, ARRAY_SIZE(insns), -8 * 1, 0, 0);
+	reject_offsets(insns, ARRAY_SIZE(insns), -8 * 1, 8 * 1, 0);
+	reject_offsets(insns, ARRAY_SIZE(insns), -8 * 1, 8 * 1, 8 * 1);
+
+	/* reject off1 + off2 + off3 >= 6 */
+	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 3, 8 * 3, 8 * 0);
+	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 7, 8 * 0, 8 * 0);
+	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 0, 8 * 7, 8 * 0);
+	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 3, 8 * 0, 8 * 3);
+	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 0, 8 * 3, 8 * 3);
+
+	/* reject (off1 + off2) % 8 != 0, off3 % 8 != 0 */
+	reject_offsets(insns, ARRAY_SIZE(insns), 3, 3, 0);
+	reject_offsets(insns, ARRAY_SIZE(insns), 7, 0, 0);
+	reject_offsets(insns, ARRAY_SIZE(insns), 0, 7, 0);
+	reject_offsets(insns, ARRAY_SIZE(insns), 0, 0, 7);
+}
 
-	/* reject off1 + off2 >= 6 */
-	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 3, 8 * 3);
-	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 7, 8 * 0);
-	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 0, 8 * 7);
+static void check_ldimm64_off_gotox_llvm(struct bpf_gotox *skel)
+{
+	__u64 in[]  = {0, 1, 2, 3, 4};
+	__u64 out[] = {1, 1, 5, 1, 1};
+	int i;
 
-	/* reject (off1 + off2) % 8 != 0 */
-	reject_offsets(insns, ARRAY_SIZE(insns), 3, 3);
-	reject_offsets(insns, ARRAY_SIZE(insns), 7, 0);
-	reject_offsets(insns, ARRAY_SIZE(insns), 0, 7);
+	for (i = 0; i < ARRAY_SIZE(in); i++)
+		check_simple(skel, skel->progs.load_with_nonzero_offset, in[i], out[i]);
 }
 
 void test_bpf_gotox(void)
@@ -496,5 +538,8 @@ void test_bpf_gotox(void)
 	if (test__start_subtest("check-ldimm64-off-gotox"))
 		__subtest(skel, check_ldimm64_off_gotox);
 
+	if (test__start_subtest("check-ldimm64-off-gotox-llvm"))
+		__subtest(skel, check_ldimm64_off_gotox_llvm);
+
 	bpf_gotox__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_gotox.c b/tools/testing/selftests/bpf/progs/bpf_gotox.c
index 216c71b94c64..99b3c9c9a01c 100644
--- a/tools/testing/selftests/bpf/progs/bpf_gotox.c
+++ b/tools/testing/selftests/bpf/progs/bpf_gotox.c
@@ -421,6 +421,36 @@ int use_nonstatic_global_other_sec(void *ctx)
 	return __nonstatic_global(in_user);
 }
 
+SEC("syscall")
+int load_with_nonzero_offset(struct simple_ctx *ctx)
+{
+	void *jj[] = { &&l1, &&l2, &&l3 };
+
+	/*
+	 * This makes LLVM to generate a load from the jj map with an offset:
+	 *      r1 = 0x0 ll
+	 *      r1 = *(u64 *)(r1 + 0x10)
+	 *      gotox r1
+	 */
+	if (ctx->x == 2)
+		goto *jj[ctx->x];
+
+	ret_user = 1;
+	return 1;
+
+l1:
+	/* never reached, but leave it here to outsmart LLVM */
+	ret_user = 0;
+	return 0;
+l2:
+	/* never reached, but leave it here to outsmart LLVM */
+	ret_user = 3;
+	return 3;
+l3:
+	ret_user = 5;
+	return 5;
+}
+
 #else /* __BPF_FEATURE_GOTOX */
 
 #define SKIP_TEST(TEST_NAME)				\
@@ -442,6 +472,7 @@ SKIP_TEST(use_static_global_other_sec);
 SKIP_TEST(use_nonstatic_global1);
 SKIP_TEST(use_nonstatic_global2);
 SKIP_TEST(use_nonstatic_global_other_sec);
+SKIP_TEST(load_with_nonzero_offset);
 
 #endif /* __BPF_FEATURE_GOTOX */
 
-- 
2.34.1

