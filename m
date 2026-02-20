Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E9B2FF158
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771622457; cv=none; b=i09hawgaMDAdbQZc/qFCFUUcsEfDrDSdvXFotbZHd9bsPA7xyQmzFFEmXY85IqCH3kiD4GeU9iL2JwZ3PGExcVUocbGcWx+YpTjnsTr+UhHX3fm1ofTsewCsPLlEDo4bIf6pJp8JC2u7iDEucRT3dWoxjp1MRwMxicQkXWzQsBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771622457; c=relaxed/simple;
	bh=COcMQYnWEJRPhOFNkMrgGoiFrAEoZ+lJpA3deTPp6Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrXkwqAXfFmFLCGn+Hd7aSERHR76KVkLci3IZxKj5+rMom3RBoZklPuHV9SzIkhZJNcOzGdVpbIdbcHlcOIxySufdXONygIa2tD7gAa58qZlOVMThVKXkxfUyvlmYIc1hmm5DR0RXJMQLzCOTM3JveWLNA4j6w+rnkrIKMLA3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Vdc7lj76; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Vdc7lj76"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79800183233so32775127b3.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 13:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1771622455; x=1772227255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vO48Vp1qmu9W9gedi8k4I6iGoYK/r+wqKE7+DgaeNM=;
        b=Vdc7lj76PN88XJAmX41GQDvBW4OWyHOrr8pt23tlOWmvnPXi49pymFc0IKNq9QXcSI
         pXPzL33HlcJyl+EEPZYvTChtq9XucN3ICrslMziViJ9nmmHKMtE4UEhv8FDIUKkyo6xc
         MsI1Wrs5Yux0KMhIQA9K3GMJWZmmbgEeuADmajFyV/7Moarr+IIBRyoajcqUDbUAHpSo
         qYvs8uxOrxjV7d0oopYCmFTMyVfk9oD5IM/GHEvOkaNYQjMrUe+9VSVSGKMIEAFAIX85
         0jImCISxWUlj2r01BNfU5+9Joy75R4SQ4H/3jrrtoLj0dA6E+ePC8IbDepTJei6cP4wB
         x4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771622455; x=1772227255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vO48Vp1qmu9W9gedi8k4I6iGoYK/r+wqKE7+DgaeNM=;
        b=P+miDrD4f3TgzUDdsy/fotr1DLzLDX9OzGsnDcyDyq+yab0kUmEyTye9XQxhg8Aiij
         mu64ZNaoljfwAmMLF4jpKEkm8qpbl8jGXiLM7khGl/dGJ6H8fK3HkbfO0pgd21AGq7j4
         OAha1OQmUTmFJmd7HygIODb7jVj0zAnxnwH4yGo3irVeYy8heoLN9DWN4eu4C3z9Qdgw
         1bL2HcnsYBJycUCy1DlEzsLqpfcZaCWVSp4NRR+MdxqIfYT8tdzS2g/Ysn3YrgMbBHBD
         2i8wiEcs8165fUm5Wx5vriiDna9LiLfm1lpbG+MqYG2q06+e0j5YhHyeaLNCZqjWLrw9
         1zxg==
X-Gm-Message-State: AOJu0Yy9cj/hukihbAgsK3lKrAN2kcSvQmcoYTr1uLN6eVvyrFyexIjg
	BPbSxwlcBB/7Z/qHxTjgwDRsgvrblzMltK7UyG9FDDD8lyyRBSOJGeBsCRvyf+l/Fj/NDdprHBN
	VmjleDGkrENNh
X-Gm-Gg: AZuq6aLSBpoU6OSOyCbP1DdIROMm5yBTdKhfA21nwR+/KhMevcgQEyqjQUtcOBAjRLV
	/d+MKpVt+pX0pho5BQYML2eSLk4IiiqhoKOueZd4W/86MY0I/22OIvCJ0wGHCPDd5Pd0Nn4siVw
	UTxgdDKSc9/VDLddJMWVaY+65DlFuxzpP8x4YeP+WSWZt+mj8HDmLwK5O8oBM/fjTdf/+xat2eL
	NBaRZ4GRFFc53kKkcvaoaDwNqJ3MAaIIHQ5tu1QpPJYYRVxM07zEpqfhxiba2Th1LqI6hKmbLWj
	zN37HpMnnNYBewXNceW1C7Ih2YChdr/ntM65PfC9SeItJZTO+pGtugmJS3oOJvJx+2QPnxATq3M
	zGwfTXMVBkfheYOkvAeDboqjHedjHOz3+S3Wyl3Eq0F0QwHU/Fj1WxYXMZnWqOFv4hVipxY871C
	6Qil8KaD02azhDLZwOHouTFLPHFg==
X-Received: by 2002:a05:690c:6c85:b0:796:2aaf:e0a2 with SMTP id 00721157ae682-79807d52feemr56820517b3.33.1771622455487;
        Fri, 20 Feb 2026 13:20:55 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd87fa2sm1549527b3.28.2026.02.20.13.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 13:20:54 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Cc: "Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH v3 3/3] selftests/bpf: add test for btf__add_btf() with split BTF sources
Date: Fri, 20 Feb 2026 16:20:44 -0500
Message-ID: <72a997c5dfe24fcd74551a1135318f2cf13f23d4.1771622266.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771622266.git.josef@toxicpanda.com>
References: <cover.1771622266.git.josef@toxicpanda.com>
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

