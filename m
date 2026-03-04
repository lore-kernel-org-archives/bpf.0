Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBFD3845C3
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657829; cv=none; b=ackC6Qx225PHOsz55JXOvtie/MozJPn2LqEKolq10b8sKSwD04DShU0I2lP9fKFc09npJwSUUHb1Iw+5QaYNn2mWsNCrL5g8pboiJ1xkpVBtGFTn1Mpro45HLujU2Gt5HVfZFebvHHYOcV/XZ7x26Ow31cCYwQCQVMOUcpYMxe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657829; c=relaxed/simple;
	bh=WyeYQb3YQCz+f5H/eR5ZDASafjif2FCnbOm6FuWiFnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRVSBMH3vbyvvGCXMMxYAwNfUBdfF8BmGPoHMV3WQ0vHOqTnVlwsuT+tJbDRIrC2FBtNrm60HzSkWwS4YGjS5IEuOZXfTtpJjpU/+H6EBQXM7fSnp7fpfnMvR8NEb7CIY484rou2Tcme4kfU8Twe85zq2nP+iNCbtloOovwH9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=qB3k6+zR; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="qB3k6+zR"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899eabc5292so42896226d6.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1772657823; x=1773262623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncCoeXyjR9RDKeVTND0rxI6Rhxaft+8azHfZqWQiIOU=;
        b=qB3k6+zRux6W1rAP1Jbw3Iy143vQIU4j2jHgMZEzdLZTJLTnuYNONfTMMyuZ3tCtET
         ESAvnY6gVR8Lpgr452lUD+kTJ7GLI4AZXwF0E+cu29vy04DFUb2YG3NqrT1HmrI4M1E7
         WvH5XMo6VK9lgGYy/GS6tZPxpmFYe/cOYKeVl8WnT6b8gjaYeJQ7gbjKxbDl5grJduw8
         SBF8xHSsVtod2ppmpkA/+c4zYfRFN0eFARDZ9bKwzD9WGxk+pyusTTVQWB9BT46jPRWM
         +aakF1WDRMaDwmwr1c/ziH/3bHKZShmIsD+2ZXH6eGKpdIszxEYhVeMPui/1ssG0OICy
         lsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772657823; x=1773262623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ncCoeXyjR9RDKeVTND0rxI6Rhxaft+8azHfZqWQiIOU=;
        b=vwW4irMrXcifsBTY6PK7IZdm/qZk3LF1TbtBeDl5v/l9nSjM/wPeQrLi/BBfx3y3jZ
         /Jy+iWfl5v7UhLZdE4yOs8QUdtuq2NmZmCGf2ppcHH4LIZgSzdVt61K/NbzDO/pcXGyd
         Rvl4D/ftweliIdpoxbCxd90WbPvL9K98X0HlujKvgnnfXrOeCNi3xlGgC18wbC1eOsaw
         Rs98dwCDQJp+4PiM0NU0gamYUAR32BQLghgdEZlGXJe/nMMid01TrbfBLlXz2MSpwF01
         61WrDqP3AQdezOklBXPUfYwVt8e8Zbf+2IwsLTJlnGXK6Ed6VMvdgE1Lgk+ibs7BlQWk
         ptjw==
X-Gm-Message-State: AOJu0YwrFtg5gQ2lR+8ND2DzhIeDQYeAVWoC/13CaLgvSne+0OGR+CU/
	wF9aI37lQW47OIBAYKV0TDPHLj8xMndOo8kFrxZJYegbdnj5C+jV5JOLvbrLxeDB1NmQH4uyUN1
	hjG9yPfbC0g==
X-Gm-Gg: ATEYQzwttFEcqSE+02shFZ8K/2a/TgcrkMzrDrQrRkzf/YCPsxxp5pb2osx/4TLV9Fv
	Vl35gmIvdE+pjNQ1llXND6DpjrlPtu9qnTb4+ylCCtP2H4Uo1lApUS3c6UYauZlB4hc7tTyMku9
	mSf9GS2kF1Oiv0y9SYBszKQ66dGucVkxLEQRNDDLduyiDrrSDAzOAMnjma/JBQezfiTgXk6IXYh
	NwqYvlOfh1pSjZCvnZZ/C6qrxGS8B30iIeTG7qT9qurOC6XJaLuo9q25S11OaCjqySwWkqEf8e2
	I2vE9jaWw1bJaL817wHJzYOKQ7lOd0kvHT8xuNmu1cGje67mkaY/CcULU6nbQ+eHsQrlc8W+bR9
	pEgdi6ZpPuMo1GFBb4eBmY4CdKxN4KrLBdnGl7eGk+pnfFsN7+V39qh1Fv137ItpUK6J24H9oS/
	FccSRCfI+qflSm9yOHnZBs4cXpWA==
X-Received: by 2002:ad4:5ba8:0:b0:899:f78e:d72a with SMTP id 6a1803df08f44-89a19d392c4mr47279256d6.64.1772657822984;
        Wed, 04 Mar 2026 12:57:02 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899ee519773sm97849416d6.47.2026.03.04.12.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 12:57:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: bpf@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v6 3/3] selftests/bpf: add test for btf__add_btf() with split BTF sources
Date: Wed,  4 Mar 2026 15:56:52 -0500
Message-ID: <64a8c947bff1ae89efa9ba8c099466477762490f.1772657690.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772657690.git.josef@toxicpanda.com>
References: <cover.1772657690.git.josef@toxicpanda.com>
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
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
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

