Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278F93A960F
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951270; cv=none; b=jdUJ0YziN0DS57wS2yHN626kZ/bp1rtykPKPc/Cb2z0RPSQngDULra1q4yDgjBvmhVW0grSjCzDeB/3AfK1cDOpDplTddFJN1hEBXkEUugR/1wDm97XklnrIICsA81RYo5TQmVIj7vbKN+OwNTLG7YIiqV5/UiEId9fGRy4GMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951270; c=relaxed/simple;
	bh=14BgWXGYvMxKrH+bLcevmpvB/nZXPn1iqzfyZesTd1Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESWlONi9GjO/QqtFVeu/AjnnOs8kCTNKDxP4JjdBNvMfSmQ28FHhQG1duNo5/WAFoIeUEf6m924OSFr3vfzOjWGXYrZiwUEIWPSeN3bz4PPx/Waf7QLr9op69oKeK+FLTIHsQDp9PKSwpafj2Sya2JomR/FRtHgRRfw0wtlXF70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=QiGpKV10; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="QiGpKV10"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899aede64e8so5167646d6.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 08:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771951268; x=1772556068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6glUrQNLLHKDhoE0AfhFKk2w7A6Gpwspl9jBx15p8WY=;
        b=QiGpKV101yJKGwBn9DksdyQKI5dlL+zzzuriof4Rj5Cop083HZjevfiIUCKBmuhWP5
         hdEvTstI9QbrMuL8Xt1TCjPmREOuD6VhlK1W8tKeHWnPNkm+zCuljl4jYUEiy37hUYXL
         CwZjmeTscaUD9ik8hqozTSJl1Ka1IE/aNsdt0Y0ifLpfMLsuQeS6nIy8olE1aoElGrZN
         iOugR8jdlRmzhU4W1tF4BGq5v9AOrUvlf61rxpfgawmbSM9SRR2X7KcY0O0G66klPGp0
         L5NA2iDRISTDdEUz/HN3eTqWYiUagGtbbsKARUjI1T5KHrGqYuHCKIsQLDeYNY/11gU1
         44bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771951268; x=1772556068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6glUrQNLLHKDhoE0AfhFKk2w7A6Gpwspl9jBx15p8WY=;
        b=wU8ms4IBYUhjj5frtGJADfGkbbXMkkBS726qp7v45ZCBJcyoTBC1tTSuthL9mqDFJ5
         9fcHGuhWAXBej8UZWhB2VO6ePdmfFsAKGsZWyxk3Djbymwacl1cmZioCL3cdY1DXC2Hw
         0h8JFKxhq/e12RFyFcRkdjs+NWxn44HfpY6r3XvTOz4WZAtOv4EAv3LauNfKsWQ6FLoG
         kD4vqJjnftNxhFYqsNU3H+AOnnJ0xTza0wamKKSmUGe1cAWFiU54NFcz4yn/AbMQGG5j
         w7dj/TaRAuQrASyqBcpCdnSLivRkS5EKU8M6CiB7B2FrqboTspvwKjFUMkc6450bT//H
         QxWQ==
X-Gm-Message-State: AOJu0YxBrZ47/8DOl35Nc1+12lIzBRq+SU4eXXh3LTDSsoLlHvQmGnQn
	Hhwajag4R79T0WK31xy4oCtpfDdIc/Kp3YgoLxY3/rugyjF4yf3ABN3Y5lbgojPEdkMjnYwqHhE
	YKusCt2NUsNxE
X-Gm-Gg: ATEYQzwVWgAcDRofNEuXIJl/VET3KG5OjmKv+L9qdowfZFEO0g5TXQdF4pr1CnFZCaI
	dLaMl+MNegyB/mcpfN8qNmJo5V06ZjltBMjZY93RD9TdJuE0zWXEYVZa9VUVgcMmeSx3jFYLfzo
	JBvEAte5W1jbcX6WmirNIav7a1wSdLOo6V/Tlo6kRhAtBDoHg+GtYeNW6i4/Xu1l0MnyEGXLHKf
	oEYLUWPWdRyxJy1dU9zJ5O8Cb4JGWDCemG+pfAGVtvvLUE7sV7BykNFkBLQDuL4u1E/q9N3tliK
	VBuPo7ICJ+BgCyrEVdHmTwB8vURlMMo6o7vKUSdXmTOPignzwDkZ9puh2+8ykenaP6Zrr2sq4le
	72e3GsvY3tSyr4754wNrk+5XxF4NbOjYNUY7Vknr110xUmeckIydYu8z4gpt9FGYj4vl+UvUE7M
	oKT8XbHY0/xSC1Hz+5bQ3AufejYg==
X-Received: by 2002:a05:6214:407:b0:892:66bb:fdbb with SMTP id 6a1803df08f44-899b35003bemr9091586d6.23.1771951267243;
        Tue, 24 Feb 2026 08:41:07 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997cba2437sm113275156d6.23.2026.02.24.08.41.06
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:41:06 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Subject: [PATCH v5 3/3] selftests/bpf: add test for btf__add_btf() with split BTF sources
Date: Tue, 24 Feb 2026 11:40:54 -0500
Message-ID: <dbaf8e09041984d90e0e3acb4aa86a3700728b00.1771950922.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771950922.git.josef@toxicpanda.com>
References: <cover.1771950922.git.josef@toxicpanda.com>
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

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 .../selftests/bpf/prog_tests/btf_write.c      | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/testing/selftests/bpf/prog_tests/btf_write.c
index 6e36de1302fc..5c84723cf254 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -497,10 +497,121 @@ static void test_btf_add_btf()
 	btf__free(btf2);
 }
 
+static void test_btf_add_btf_split()
+{
+	struct btf *base = NULL, *split1 = NULL, *split2 = NULL;
+	struct btf *combined = NULL;
+	int id, err;
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
+	/* Add a typedef "int_alias" -> base int in split1, which will be
+	 * duplicated in split2 to test that btf__dedup() merges them.
+	 */
+	id = btf__add_typedef(split1, "int_alias", 1);
+	ASSERT_EQ(id, 5, "split1_typedef_id");
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
+	/* Same "int_alias" typedef as split1 - should be deduped away */
+	id = btf__add_typedef(split2, "int_alias", 1);
+	ASSERT_EQ(id, 5, "split2_dup_typedef_id");
+
+	/* Create combined split BTF on same base and merge both */
+	combined = btf__new_empty_split(base);
+	if (!ASSERT_OK_PTR(combined, "combined"))
+		goto cleanup;
+
+	/* Merge split1: its types (3,4,5) should land at IDs 3,4,5 */
+	id = btf__add_btf(combined, split1);
+	if (!ASSERT_GE(id, 0, "add_split1"))
+		goto cleanup;
+	ASSERT_EQ(id, 3, "split1_first_id");
+
+	/* Merge split2: its types (3,4,5) should be remapped to 6,7,8 */
+	id = btf__add_btf(combined, split2);
+	if (!ASSERT_GE(id, 0, "add_split2"))
+		goto cleanup;
+	ASSERT_EQ(id, 6, "split2_first_id");
+
+	/* Before dedup: base (2) + split1 (3) + split2 (3) = 8 types + void */
+	ASSERT_EQ(btf__type_cnt(combined), 9, "pre_dedup_type_cnt");
+
+	VALIDATE_RAW_BTF(
+		combined,
+		/* base types (IDs 1-2) */
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+
+		/* split1 types (IDs 3-5): base refs unchanged */
+		"[3] STRUCT 's1' size=4 vlen=1\n"
+		"\t'x' type_id=1 bits_offset=0",      /* refers to base int=1 */
+		"[4] PTR '(anon)' type_id=3",          /* refers to split1's struct=3 */
+		"[5] TYPEDEF 'int_alias' type_id=1",   /* refers to base int=1 */
+
+		/* split2 types (IDs 6-8): remapped from 3,4,5 to 6,7,8 */
+		"[6] TYPEDEF 'int_ptr' type_id=2",     /* base ptr=2, unchanged */
+		"[7] STRUCT 's2' size=8 vlen=1\n"
+		"\t'p' type_id=6 bits_offset=0",       /* split2 typedef: 3->6 */
+		"[8] TYPEDEF 'int_alias' type_id=1");   /* dup of [5] */
+
+	/* Dedup to mirror the bpftool merge flow; should remove the
+	 * duplicate "int_alias" typedef.
+	 */
+	err = btf__dedup(combined, NULL);
+	if (!ASSERT_OK(err, "dedup"))
+		goto cleanup;
+
+	/* After dedup: one int_alias removed, so 7 types + void */
+	ASSERT_EQ(btf__type_cnt(combined), 8, "dedup_type_cnt");
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

