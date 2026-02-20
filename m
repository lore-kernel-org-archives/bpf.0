Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B622E6CC2
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606159; cv=none; b=HZiHxeBwm5ZR9NWVj4DYzAbEm61moYMQifzKc0HlLDjMaOfz78Gg1dJLD7qQGLKcSRK+OfioVDvxm6zNxL0e/HHTxNN4bmnUli8KNwP+iEkN04knauTrkh9HABiF2jkVIJDO5JSNjm1+2KcYGzN0hSuCzWXl8SfHre58VtLl/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606159; c=relaxed/simple;
	bh=COcMQYnWEJRPhOFNkMrgGoiFrAEoZ+lJpA3deTPp6Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ecuc18eGUF2EnunMIozl01g/g5X+Se2wZo99cvPUlWK2xh5Onxq3YBGXC+gHoVyOZMQd7tSmDo+3O/qSZuPBmsvASEUGCwGUo1gy1jiWJInbqytMjZ+k/xc0V86Wvku/skQ7w0lW92orl6b0B9X4I/Fs0eXBgwN0aFLIUWHVJ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=HxDsn2kq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="HxDsn2kq"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-797d36fdb96so42102967b3.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 08:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771606157; x=1772210957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vO48Vp1qmu9W9gedi8k4I6iGoYK/r+wqKE7+DgaeNM=;
        b=HxDsn2kqoHD/WQnD8d2EZLpo7seG1/t0DjmNQhpGrGDo/tyxIkU5LUh1lnYMePoUm+
         pgRcCn79TghJUwXgkmSCfWR/FjF2oxHlF8kEuVKMYzijS4P5uwGMjCTlV/oeyyzxz2qn
         86OCVqQBXmocSiQu6GkNR7a1DVXQkedo1e7+f/xFroEZ0YD0R3FWIFpelhC9sxK4I4OC
         kx9aYJUdDxmXm0QYcfreR/WJKO4r3g2SuH0xjwljKorswAYfROpe9khcIe33Bzl4YyVG
         zjEGlNtHhiWvyaCE5YJ55+4jlMuYbqtCtdhRxcoZaHPCQ77ElJNSgg23/SM0aScT23mi
         rKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771606157; x=1772210957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vO48Vp1qmu9W9gedi8k4I6iGoYK/r+wqKE7+DgaeNM=;
        b=BUqXOEzia7PhoFtRLtkOb/B/DhkPvDu/huXlMqceptR12ACReMatNGvBnC//ooGvTT
         G6FzajbarZMd8YWjUmS5FgoZreywjgp3HxXtMEG5qvPqiQ0+H0SWd9YHEpXeuIWP9jaK
         uqG53Qu6A/g9fzuTVAFRCL2oEzIaSvbe7ZKqEjKtaxFZmtU0S+601GxFf5e5fLH0FNSV
         wzsubtVKdkZT1kTeVh+XOLY+3QVvUa5Jq6uEE7J73K2Ud2T+F7+dFCAQnvKxAPfjoWJx
         id5BAGVH1ai46El87iEWPmi34r2+yIBED66LvtbLqxSLRPBfu7xVdFTVo1fxciLbN/4f
         jvkQ==
X-Gm-Message-State: AOJu0YxzVb3Y2H7u30QlRPcw46sfL50SWDucYz9d6w2lJkjQ/DNL8ffe
	qpHtPioYCqBhJj1iN/xnJplRryAggevByd9p47aoT9uRU/eDjozY3lrGmojPdCPxCltfK9ph041
	ekKaHy/JQrbAw
X-Gm-Gg: AZuq6aIWzSyuorWkRg2Bk9hpic2hqTtEx8pDsaEGfF2MXlRBMtjBXYq5txHMa4rQcrM
	7/6OeCllEF3sIKf2xcolLXxc8cS3cIavlTRFd4Q5DYSXlto477i0o4/P2OAamX8AKLFaZqbniXW
	sw+6kr2hseQRQPobWci2tOFloL4jO2s01uII5rMm1jRruIwqk0SG3qpvElBKHZCdFZ70d4QkRFy
	S/S7iWZQqEXLm7Is0O7XvRQZWmZvcs+TNrYaAwIvyFxVpmvbvXM7guy8U+JezCUgwOXKuSLMVvU
	3mlK8bLAvZLtCzrS614SMMYr6GgSJ3pWF4qrDyHdmrF1UZepodvokzwpejbSvbKy8k7Fqa0edpb
	a6KiDXZfSfSUrHpyTJgYsDmE3lhpWbMCoh7LSwtfP4NpEdUUrTfeOnVFxxAYiHtHrTy5DadV1F1
	Tdzi6wCY5ECnEWIIUwpPloN+Jojg==
X-Received: by 2002:a05:690e:140a:b0:649:d084:9ee7 with SMTP id 956f58d0204a3-64c63fe6960mr4449049d50.7.1771606156770;
        Fri, 20 Feb 2026 08:49:16 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e6f7e1sm8586925d50.2.2026.02.20.08.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 08:49:16 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Cc: "Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 3/3] selftests/bpf: add test for btf__add_btf() with split BTF sources
Date: Fri, 20 Feb 2026 11:48:47 -0500
Message-ID: <fecf02afeababcb6e7253465c3033e0b57224cda.1771605821.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771605821.git.josef@toxicpanda.com>
References: <cover.1771605821.git.josef@toxicpanda.com>
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

