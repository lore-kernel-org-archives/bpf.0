Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C476366DAD
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771616418; cv=none; b=Gb97sTKI10JjPgLwt/dC1g7KRVIFcuJYT0fLUlBS8J3rE4Lp7gFE7YR4enzjkcCbH+56nSA3KLhoSfZGbaUOnuLNE1IcKJOlYt8okOCzvfv3nV3tiGFpvOaVgyVjGXmxLwwRAIQ9aT0n3IzKMNPJ97yroo6nwPHO7kQD0Dsq6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771616418; c=relaxed/simple;
	bh=COcMQYnWEJRPhOFNkMrgGoiFrAEoZ+lJpA3deTPp6Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSCuxHquIOdP/4rPBGzc8Z1alwegE7oxWbA5g46pt8WEPzx5RFExwF4CvyrvdzH3RVb1UiBJZZRFuoHPYRM7Wvpx0ulcdQgojNiUMLm52laJY+Z5+O9xz5MgNlSwHeUnCE1sMwOUp92rVyzwsNiMoEbo2fGsio1pzwbCKZFw4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ZQIJrgqV; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ZQIJrgqV"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ca01dc7d40so233097385a.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 11:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771616416; x=1772221216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vO48Vp1qmu9W9gedi8k4I6iGoYK/r+wqKE7+DgaeNM=;
        b=ZQIJrgqVo2LA9jbueUBekAxInitZAK73RiBh1SzP0AHhwtUoUnneuWNbdNuZofTC2U
         lKgsENODmtW2sd3UBny4CmV/stgLjTzuTeP2H0WRmDAhZaHExRSboHoPZBhyOgozCHsx
         GPirTmLwZIgA58juzMPqlj5amxXv0Y+9wx6FdRMO4DO/zu5V+pmHG+oVMEoKl01o0cGY
         1VGuihVhI+Z88fH7e2UZaFTMJi0UNZEMr1552DjwpUaqgtNLUVYVOBbOJp27hydjqBuA
         7XjqvfVPDXYJ47XeQl+/PtEFbNvofUq9erKBF5pzDsmI7Di4c+PAfgzp4pGyeCfzpNyq
         x+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771616416; x=1772221216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vO48Vp1qmu9W9gedi8k4I6iGoYK/r+wqKE7+DgaeNM=;
        b=hqs1vFox09nCL0XFN3FRlUfCQ/syx94SBm4gb/3UYd/zx0J2kTc3JXVFprR6FRVory
         Ej964/t03s63550LpxF+wNmNUCvmEos9zT6edEjx3vHc+ONj9mqvIUJCUlqABloFZv3M
         HP0qGb0/etEaiUoAqJULMUj0xAWAoyqEWRHRqNCoygJvU2aqFgVHIJmCZqkGPpzOkwzx
         gQirNZ1AApok4xiekknPvg2+hDLmwKqFaVaMGGMvftMR4mOUpGPDDzQNQett9JWq505T
         O/1Qzcoo2A0gc//H6XDzy5V+XkmhPB9Q2pWeUxxRq1UIxMmv8D/chQSxpLyx4ELgR9x2
         rr/w==
X-Gm-Message-State: AOJu0YyBBcubYvrgyWUhXAoRPq59jDQ1v5yOICLmIAjMawTkIQ96trGo
	AZyMFk34trXdBzKJneHD0H9uvpLx+hdLWxAX5Ms50I1pL7RqfxXL7N9ydzk7F4wySwds2d311oP
	pQYelkj9oIRZD
X-Gm-Gg: AZuq6aLuJ0KP/IfU5vbCXwcx4rnohNm9P96TiHEO54g9gtDrcVQ2PK1QqmpzDN38bgF
	nnrsaBvfZcNZyiIBhoVYjvMYH+zf2unzIHPS0Ap7annwTBt9EOglK75YvBmQIkaTx/FJxazOj0s
	GXBoDiBvIrePv/X1/VqM7ZdGjMrkmNMX6PsCZsDnU87DOsGn+Q0l+Mt8ZGekRN2Ker11SsoYR59
	5K2yPE7/ho4YM39fBsTPrPR/fmR0duAaGG5j/TYXeH0DArB3KBsJ+yYNDBH99lNCvqop2oyUcVD
	3dKhssr6F6gVPbjkhustz7gHJmoJwLdC1oF1zyaZ+ReuP/yJSU4e/ISAxlCYGEA7Ro4s+hG7ysq
	Nq37ilfPvC1jk82g1nwE1T6Gkm2mosgP3yHqTwkvvNMY/46Yz++V6moG3muPufa5LIBUJdWfEv9
	s8SeLBl5FwJAATiBG9WUP2SBtSJottrHGYf4nQ
X-Received: by 2002:a05:620a:294f:b0:8c6:acca:4a29 with SMTP id af79cd13be357-8cb8c9d295cmr109104085a.13.1771616415764;
        Fri, 20 Feb 2026 11:40:15 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d046055sm28155485a.8.2026.02.20.11.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:40:15 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Cc: "Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v2 3/3] selftests/bpf: add test for btf__add_btf() with split BTF sources
Date: Fri, 20 Feb 2026 14:40:03 -0500
Message-ID: <a34ae259317345f01ccf87d06ceed2507be36038.1771616227.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771616227.git.josef@toxicpanda.com>
References: <cover.1771616227.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that verifies btf__add_btf() correctly handles merging
multiple split BTF objects that share the same base BTF. The test
creates two sibling split BTFs on a common base, merges them into
a combined split BTF, and validates that base type references are
preserved while split type references are properly remapped.

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 .../selftests/bpf/prog_tests/btf_write.c      | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/testing/selftests/bpf/prog_tests/btf_write.c
index 6e36de1302fc..80353a545cdd 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -497,10 +497,99 @@ static void test_btf_add_btf()
 	btf__free(btf2);
 }
 
+static void test_btf_add_btf_split()
+{
+	struct btf *base = NULL, *split1 = NULL, *split2 = NULL;
+	struct btf *combined = NULL;
+	int id;
+
+	/* Create a base BTF with an INT and a PTR to it */
+	base = btf__new_empty();
+	if (!ASSERT_OK_PTR(base, "base"))
+		return;
+
+	id = btf__add_int(base, "int", 4, BTF_INT_SIGNED);
+	ASSERT_EQ(id, 1, "base_int_id");
+	id = btf__add_ptr(base, 1);
+	ASSERT_EQ(id, 2, "base_ptr_id");
+
+	/* base has 2 types, type IDs 1..2 */
+	ASSERT_EQ(btf__type_cnt(base), 3, "base_type_cnt");
+
+	/* Create split1 on base: a STRUCT referencing base's int (ID 1) */
+	split1 = btf__new_empty_split(base);
+	if (!ASSERT_OK_PTR(split1, "split1"))
+		goto cleanup;
+
+	id = btf__add_struct(split1, "s1", 4);
+	/* split types start at base_type_cnt = 3 */
+	ASSERT_EQ(id, 3, "split1_struct_id");
+	btf__add_field(split1, "x", 1, 0, 0); /* refers to base int */
+
+	id = btf__add_ptr(split1, 3);
+	ASSERT_EQ(id, 4, "split1_ptr_id"); /* ptr to the struct (split self-ref) */
+
+	/* Create split2 on base: a TYPEDEF referencing base's ptr (ID 2) */
+	split2 = btf__new_empty_split(base);
+	if (!ASSERT_OK_PTR(split2, "split2"))
+		goto cleanup;
+
+	id = btf__add_typedef(split2, "int_ptr", 2); /* refers to base ptr */
+	ASSERT_EQ(id, 3, "split2_typedef_id");
+
+	id = btf__add_struct(split2, "s2", 8);
+	ASSERT_EQ(id, 4, "split2_struct_id");
+	btf__add_field(split2, "p", 3, 0, 0); /* refers to split2's own typedef */
+
+	/* Create combined split BTF on same base and merge both */
+	combined = btf__new_empty_split(base);
+	if (!ASSERT_OK_PTR(combined, "combined"))
+		goto cleanup;
+
+	/* Merge split1: its types (3,4) should land at IDs 3,4 in combined */
+	id = btf__add_btf(combined, split1);
+	if (!ASSERT_GE(id, 0, "add_split1"))
+		goto cleanup;
+	ASSERT_EQ(id, 3, "split1_first_id");
+
+	/* Merge split2: its types (3,4) should be remapped to IDs 5,6 */
+	id = btf__add_btf(combined, split2);
+	if (!ASSERT_GE(id, 0, "add_split2"))
+		goto cleanup;
+	ASSERT_EQ(id, 5, "split2_first_id");
+
+	/* combined should have: base (2 types) + split1 (2) + split2 (2) = 6 types + void */
+	ASSERT_EQ(btf__type_cnt(combined), 7, "combined_type_cnt");
+
+	VALIDATE_RAW_BTF(
+		combined,
+		/* base types (IDs 1-2) */
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+
+		/* split1 types (IDs 3-4): base refs unchanged */
+		"[3] STRUCT 's1' size=4 vlen=1\n"
+		"\t'x' type_id=1 bits_offset=0",      /* refers to base int=1 */
+		"[4] PTR '(anon)' type_id=3",          /* refers to split1's struct=3 */
+
+		/* split2 types (IDs 5-6): remapped from 3,4 to 5,6 */
+		"[5] TYPEDEF 'int_ptr' type_id=2",     /* base ptr=2, unchanged */
+		"[6] STRUCT 's2' size=8 vlen=1\n"
+		"\t'p' type_id=5 bits_offset=0");      /* split2 typedef: 3->5 */
+
+cleanup:
+	btf__free(combined);
+	btf__free(split2);
+	btf__free(split1);
+	btf__free(base);
+}
+
 void test_btf_write()
 {
 	if (test__start_subtest("btf_add"))
 		test_btf_add();
 	if (test__start_subtest("btf_add_btf"))
 		test_btf_add_btf();
+	if (test__start_subtest("btf_add_btf_split"))
+		test_btf_add_btf_split();
 }
-- 
2.53.0

