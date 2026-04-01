Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D03793DD
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059625; cv=none; b=kkaBynzZKR3xlYjVKetZ2KgoYIv154ptvHgmz86mM+jqC36+5R8YB6FmN6JFCBfVzcJRqslRLw4QZP6+T/1hbMUAUS3njxS59qbu2klZ2HNzctwLvvApjJgXZqBcm5OBPSsWBaCfoK78TxgEdEap+qFXLcYCiFAb2PMLqkYzvhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059625; c=relaxed/simple;
	bh=ZZq3yee9BkOoR2qTfhgOXylM02ozOASsJhzRJAg3pAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lFZ26GKwAfXJpKXR9r99qpMfTuHO1fcbOPrmDioB/xcl7v7UK02wU88dgK8cNP0Zaz04MqALhg6YeJJHAJF2RIM+G0LUQOKevkx5l3IPisiG3+9yZQGnV+Luy7y+XAsqRCmAoLIisuW2ArRbErU5EuzF3OkDhhp13AjyadAhUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+9rNG0U; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+9rNG0U"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so14567965e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775059618; x=1775664418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BqqBbsbDP6OW8x0qSXfxaZ2DrJX6+6e31rWGaUAEIg=;
        b=s+9rNG0U5mJEOPO8lrLQiX5sAR0Py2SBxjTEXN9yii3Pp4etmSoTNaxaD6Xi1Zxk0F
         ZOzWGisafResgJWVbMQd+ZYubgkIoPDTw0+znygyhLVA/lBl63dRqBRiKF9OyzSzlA8O
         hyHGG0pOLjR7Hjjta/a7CsSnooi+7wCnQV8sIL3XNG+Tiyrfir3i0pDvolMle7iwAnzO
         4XyUXLRQXw8X33+8ZLE9vlgMuSlEz0ycNSlVJe1dOQPHdwrtKnyP5PxmDEMKqe3luCgj
         8m8KSBgO3u2yplS6FCw7wOvOG5RtlZOkEZe60y71omuRZBg1LP1KnjbCvnAWcDHkSo9Q
         lWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059618; x=1775664418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8BqqBbsbDP6OW8x0qSXfxaZ2DrJX6+6e31rWGaUAEIg=;
        b=MFAPipWcggPGhRbDzUCh01kuekNoP8yLfZmNKG85GTQEmRUOQUN5MQFLyDOzzdHkP4
         EnyWg0IVVSNYJtpBHPZDGB8BeMPJIDHdiE/Og+YPajpKhsxJoLcC8yIscTZBtNJ5V+nV
         iMFlhI/Miik53C23S9aT113vUEUDUqXFn3nhVGQYxyhzQBL+Owat0eiCByCFYtylM0wY
         uPQavPU3M4Su+t5FxKX33FkjBn0N/tja6IArpvFC+GF9Or0aPP5Z9zw7Mn1e6sVSAZak
         yLhByFgMRqHaT1W5EWFx0x+DEVbL0VwaMC1S/p5rlc46PjC0FMQ7VhOEd+5at3ZS7eFS
         PuVQ==
X-Gm-Message-State: AOJu0Yxx6XIqfsY/R810KLnh7laEai4qnl99FnCA/p7DgEDUgeFqZx3E
	JvNB6eq3gE2wGhKEsoPoIRKb1UgQAE1As4h2k3irBRfpJK30qnYQJ4IWqrkXuQ==
X-Gm-Gg: ATEYQzwtpez2qz/d5IaulL8HSBN5kVGcuuCh/gsBrgKJZTz5LnRQw401TdmwQ6oXdu4
	Jg2brU9wB0POuCiwVNtT5k1zObVIKpcZ2Sl0hkzDOf+fR3jYaJTiz3gKHabigrmSxKc7I0YQLd1
	r/d3LdZtedNaRqHOXtOKG/0uvGp0XfwT8CdrYnG3fUMV/rd9L11gBSSg/I6LEbTV484iZU20urz
	vpofC2Y63mhsqQBDWX2xnnaIMWf+SBpWd7BImv0jkaaa3pxAUBQYVxktpgK0cxuS+pe7lJXYLYr
	sU12ipregQ6uN9yh7q85dyE1T8GUE4CfdwWm3QR5GTL0Osgd/pwAknqmcJdrlSyIjBfsmbMZ2nS
	UAGx4noOi1g+4I2S71R3p6eedYiXcVlhkcwQfnjBNQa9qtq2CRoSyAo5lzekTdkANwXEpuJTOqF
	GBzuiadO9phUkkfz+UsOVUNOrLT9/7gPRJVSOaDpKwJg==
X-Received: by 2002:a05:600c:450e:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-488835d17edmr70043185e9.14.1775059617787;
        Wed, 01 Apr 2026 09:06:57 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e829c43sm116893495e9.5.2026.04.01.09.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:06:57 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiyong Yang <ksur673@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add more tests for loading insn arrays with offsets
Date: Wed,  1 Apr 2026 16:15:29 +0000
Message-Id: <20260401161529.681755-3-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401161529.681755-1-a.s.protopopov@gmail.com>
References: <20260401161529.681755-1-a.s.protopopov@gmail.com>
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
index 75b0cf2467ab..594adf698fdb 100644
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
+	snprintf(s, sizeof(s), "__check_ldimm64_gotox_prog_load(%u,%u,%u)", off1, off2, off3);
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
+reject_offsets(struct bpf_insn *insns, __u32 insn_cnt, __u32 off1, __u32 off2, __u32 off3)
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

