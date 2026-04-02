Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E64345CAE
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155092; cv=none; b=N0gWhDTdQfsxa15JddeNIe+GjptPBkImZna7RCY9adjIsn0Xax+tlGf2EP9a8dYs3CieTzOkCfBgI3uPuFL2F/5xyUtiXZIWuiFMvQpuYLgvv055cqZW4L7VYN0uC15Sq+I/4puhK0H5RTkExFOfFywsLv72sGnXRdlPWqQrxZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155092; c=relaxed/simple;
	bh=vUGi0rFl2wm76CFt0LCMDH9R9Wmw7Xo+DQRpqBcXRgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VNjCSSSrOdi80WPEmgsUNDhPupEUGGBW1tDvv15Ea3adEMIqagBTKYFfbdapiOmiQvMlGNkq1ZID3FkTsphXewkYS2RGKHpM5HeI1exZwozDS1rzCDxwixNOPy2P73Eop3wIVgSpFfoVb3Tr5/5FuUTjTlN0EJ3nJsqPgKugpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuBhvic/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuBhvic/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so11465355e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775155089; x=1775759889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2UMUOiDu4xP/nxZcd/E7/5AqSDmily+3OuYgbnrBRM=;
        b=KuBhvic/fkwDb648u5eqBvrOiVvdAhvduVnZ80dfM+ujGGRYqvKk28O2qYqi6SVfdc
         ZZVj8iDfFanb8c21sGCsi5WtwIQcHUF5O1WiCM1/+RNgN3ty6SrygykUEjI1KD8+E1Um
         jNlyx7lnnOvDFE5xUilzrq3nQ4A0HlviJiOxTk1lViPutXm7vRIa+Ln268ehHAiDpkoV
         K/3lA6LJQ1pPvtyDOJ/iA6bCfH6m57UKBKv0dry7exdtGccG59Sr85r4J/el3TtYBtYL
         r5wzQ9tvUWwbxiCegi4WMR3IvKpjsRiYQMb/5fe1KYk40kqLrRtkw/k+g3sEwl9j2ae/
         4AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775155089; x=1775759889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h2UMUOiDu4xP/nxZcd/E7/5AqSDmily+3OuYgbnrBRM=;
        b=EIDl2RfALXaJuCencOBsBN69ZvvSmal3L/VQSYmxEscgBKaIQoggUqT/12NGHZSy7V
         tDCDPVXAVr6hiC2CCUVEEUojX/xDSard7b/1Hl9kT3XCJXW1xgMYql3dv964YYmMzuLy
         uLr6uJxBSUPNnHSzHgHFQ2Z5foAYbjizpZaDFP/KDXcLmzgF8lrve2qulFnVmIaxBTwd
         HB1QLnQ9vjBBNrKKTt8bkf5DwwRgZqB0sIfxi7HvQKX/Vo4w4cnRvu2KLhlErSp/YZO0
         BtNDlFnTdrmijSwJV2d9/riZRCdNSo6g2XWZeCBVceqaIPs5GqzyQyl+CXlJ7mfwJhUK
         iW2A==
X-Gm-Message-State: AOJu0YzTW/ZCvrHlzNqz2AFToUZOE1WwGYe5FK2Lz0H0Y+BsLl9a61BW
	2wYEYMSh1I+PJ/BmNNucGFbTlg0Cm2HexqWpooyGMnaBr5I/4Ib7lElHfu7PLw==
X-Gm-Gg: ATEYQzxDdiRirP6gqWyFYA5oyxQoJoOaPavAwv9DC2gNHBJtSQHC96Vzi075k764An1
	dWXz9f7PMPXqW5BEHC0SN2d/uy5Cqsj3Vi4YrIvQ0404CkOBcu9EQOelFrBYGt+c4maUPt0bW8B
	cZ3GDSY0IGwqKYcvDBgC55gJKiO6kmJueb10zPXwNFlEbg5xrYepcWh2zGTBE0qkEW9ykQDqHrq
	RYl0kW9qTKiuf8Ent6Edpqg8bbdwlM7GlWRdRSyq4JRGFQUuRuDNijqX1f2xwqmLL6G0IVAutpP
	pGAhhdJPeLCpY8gKNBHEqEXoB7B+iu37HhbsPeDNmevahpfEo7+yX1ojPhOckEtuL/SVOT4IhiT
	XSjnwWPa//ebITo66czHsQ1RF/8VGuYkNv9elb+/BL98trPaZWnnSgP7+3hYUxFiSrc2pLYRXoC
	68KlVPT54XwqGgBi89LO5K4O/0MoiS342/iSmBurztAg==
X-Received: by 2002:a05:600c:310f:b0:487:467:42a2 with SMTP id 5b1f17b1804b1-488997b6f09mr1236475e9.18.1775155088719;
        Thu, 02 Apr 2026 11:38:08 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fd5594sm2215815e9.3.2026.04.02.11.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 11:38:08 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Add more tests for loading insn arrays with offsets
Date: Thu,  2 Apr 2026 18:46:47 +0000
Message-Id: <20260402184647.988132-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402184647.988132-1-a.s.protopopov@gmail.com>
References: <20260402184647.988132-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A typical series of load instructions for a gotox looks like

   r1 = &map + offset1
   r1 += offset2
   r1 = *(r1 + offset3)
   gotox r1

Here offset3 is, normally, equal to zero; but this is not guaranteed.
Extend selftests with tests for non-zero offset3 and, while here, also
add tests for negative offsets (the offset1 and the sum of three offsets
still have to be non-negative).

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 114 +++++++++++-------
 1 file changed, 73 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
index 75b0cf2467ab..f4f14b6f0d24 100644
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
@@ -403,43 +433,45 @@ static void check_ldimm64_off_gotox(struct bpf_gotox *skel __always_unused)
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
-
-	/* reject off1 + off2 >= 6 */
-	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 3, 8 * 3);
-	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 7, 8 * 0);
-	reject_offsets(insns, ARRAY_SIZE(insns), 8 * 0, 8 * 7);
-
-	/* reject (off1 + off2) % 8 != 0 */
-	reject_offsets(insns, ARRAY_SIZE(insns), 3, 3);
-	reject_offsets(insns, ARRAY_SIZE(insns), 7, 0);
-	reject_offsets(insns, ARRAY_SIZE(insns), 0, 7);
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
 }
 
 void test_bpf_gotox(void)
-- 
2.34.1

