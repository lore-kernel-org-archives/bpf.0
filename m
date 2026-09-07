Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B43E472547
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786660; cv=none; b=KLsUR6fav++0SmHGIFnEYPl6RI8ByTVTHyU5bSwqiOAI2zLTr76KgbeTkFnjSz0cmRDhztexk8rrLoREDLCLD38s5zNiIozZ4o2W/rR6GPx66hjbcC9xi2Zz9END41rPyXFof35fTMCW8+NodqNtaS1gquHG2zcIMNj3yy1vz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786660; c=relaxed/simple;
	bh=HfLRJsTY0hfI4t2MNcYBg28vs+uH+tNMC9Ta+dENfAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ma0bVTjVEtGrWJut/E7MvXPNX0M6WKw9NjMoO+Fq8ApUcHJ0ECwZd1vy8PmGgLkpk/KA8V1OHojlXCBaeCWtwDhV325hJ4Jlc3N3/lvchMvohFK6hBAfFCHp+DMYRrOnZU2rnFazXWX1X+rFrAclPTfhtP2C8sMZWnawHybfMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJGEr79g; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJGEr79g"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6b0496f4bbcso2148588eaf.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788786655; x=1789391455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ewh5vXF9yUEB2JD8VUcw2G4Vqq+1fiqwcZLuV8UwlJU=;
        b=ZJGEr79gCW4admRzOUa+hhuflBfGmOsL6qgeBI6Qty1YtRCJE1RJ6jbN+EMDdn3jzi
         JBFsjpV3crazx1Gdsol2J+1uTFZVWsGa8OyDZBTUFnZtI04+3xV1CuVaisKAd2FaKxnr
         1jHghpbL4VF0o8ysKBC6vTGEzHLUJSkTjOvOG4SdtsVxC+Ub/+YYyXPQ7DUgVjR1Vv7a
         /9TVub3YJ5hlHci2fesx5KB4G375VaYqLheH6kI37CADgjH45cBRi1NJTR454JrBgMfF
         7muAa3HHIBYOF9FeZYHa17ELpdTIkn1vB8r2At/eg4eX9Jloj7x9MJ22d/xf1uUdE1Ft
         Rb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786655; x=1789391455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ewh5vXF9yUEB2JD8VUcw2G4Vqq+1fiqwcZLuV8UwlJU=;
        b=Ic8fssYgORO0WUO90XweNUCXa9bfg6m70uySDR2Ew+VDNjkasZb6Va8XpvjH5a0X5T
         kQ2Zvse5W8V/qIyE9PSsWTvTDC3ZeNskdmTyHE+lWsg2Y+3uFrGDu+aAEYhTsykCZqmC
         d4+nbHSL7mgdyCYhT2bSb97i9pCfVRtSVJV1kY5eizWgpkqpfb7g8g4H4T6tQ5SQx031
         4FJWCKSgVj23rr1WgYq9T9XXe5PRU71JQjuxJCGh+qUnZQoIZbzsHrodJ2bX14anLqBy
         ly+wrEy/Y+R1CcGXzqaSPMhDcTM0WoxENIzNvFVnwt0MBupPkECTSWibe60Q2ec5m78F
         smRA==
X-Gm-Message-State: AFuF++mvLBzoyH9JstjZUAgXQQCnvzUs4HLZGZP0MQ68hzWzNeJhZr58
	Di8vz5gkp33DL0I6lOQaNHbQCa1mTl4f73GYtt3jhT4fmBweWld9bFwcjmxuJpCltE192A==
X-Gm-Gg: AYBFou175+70m0Vb/zxMGiGwJlwfAMXXpXQkS7Gt0xvXgta85c38Qv/nTySjNgDVHap
	j5Uz59C+RCdbGylXB43XBqDMqSfOABuNUIiF6UWmg5onS+BCkMeGfVvOul0rI0Kz3heTlybQQY4
	opvkLgZ7pgq4OeIVWlecalqA+ekCkHtY3ROxqFk+51gRBnbtdbTNeTWLmibtOBDrjJ9JGK9/gvE
	SkhPqV/3hj8bTFUNeJz9V8M/40SgKb5rrF3cHDTNc0nYGsOkm0V9TPrtoqZ1Nop5EGfT4vu4u7F
	BXbDs9xnZQV0+DPhzF19rB9G7jnfWQ/EKG/COr/GRAD7Xx7yJ5qoIZoKklwM2EiUTq1mJH2xnax
	CGsfOnWQrijUeb3iWHNvdq6EbEqYmGk3dhx6SNOEpGL/AyDO18B0isLHERd+jiQWmxNJLaiMjiR
	TJvIKB+9gEs7tbfwJvLRKoD8HrmrgUb91JraFI6zQnJTX+MtAd9ib1c2J+rfkbZxUDqOIFAcr7u
	6FTEBbabREiCb+7GTUxreLISJyIBk+7d3/e6w==
X-Received: by 2002:a05:6820:4b8b:b0:6b7:83d6:293b with SMTP id 006d021491bc7-6b783d62fa9mr10596211eaf.62.1788786654451;
        Mon, 07 Sep 2026 06:10:54 -0700 (PDT)
Received: from HKG-A3-RJYWAR2VC4M5B7A1.. ([140.245.43.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa33e96sm27853445eec.12.2026.09.07.06.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:10:54 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	Mingpei CAO <caomingpei@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Test array element comparison in BTF dedup
Date: Mon,  7 Sep 2026 13:10:21 +0000
Message-ID: <20260907131021.34343-3-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907131021.34343-1-caomingpei@gmail.com>
References: <CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyWD4xmz3PuBycw@mail.gmail.com>
 <20260907131021.34343-1-caomingpei@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise recursive array comparison with different and identical
element definitions. Check that distinct containers remain separate
and identical types are deduplicated, including their references.

The negative case fails before the fix and passes afterwards.
The positive case passes both before and after the fix.

Assisted-by: LLM
Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_dedup.c      | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_dedup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup.c
new file mode 100644
index 000000000000..3e889c0bed53
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "btf_helpers.h"
+
+static void test_array_element_types(bool identical)
+{
+	struct btf *btf;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf_new"))
+		return;
+
+	/*
+	 * Comparing the first fields maps array [3] to [6]. The second
+	 * fields reuse [3], requiring an identical-type check of [6]/[7].
+	 * Place container [5] before its elements [8]/[9] so they still
+	 * have distinct IDs when their definitions are compared.
+	 */
+	if (!ASSERT_EQ(btf__add_int(btf, "int", 4, BTF_INT_SIGNED), 1, "int") ||
+	    !ASSERT_EQ(btf__add_struct(btf, "container", 8), 2, "container1") ||
+	    !ASSERT_OK(btf__add_field(btf, "first", 3, 0, 0), "first1") ||
+	    !ASSERT_OK(btf__add_field(btf, "second", 3, 32, 0), "second1") ||
+	    !ASSERT_EQ(btf__add_array(btf, 1, 4, 1), 3, "array1") ||
+	    !ASSERT_EQ(btf__add_struct(btf, "elem", 4), 4, "elem1") ||
+	    !ASSERT_OK(btf__add_field(btf, "x", 1, 0, 0), "elem1_field") ||
+	    !ASSERT_EQ(btf__add_struct(btf, "container", 8), 5, "container2") ||
+	    !ASSERT_OK(btf__add_field(btf, "first", 6, 0, 0), "first2") ||
+	    !ASSERT_OK(btf__add_field(btf, "second", 7, 32, 0), "second2") ||
+	    !ASSERT_EQ(btf__add_array(btf, 1, 8, 1), 6, "array2") ||
+	    !ASSERT_EQ(btf__add_array(btf, 1, 9, 1), 7, "array3") ||
+	    !ASSERT_EQ(btf__add_struct(btf, "elem", 4), 8, "elem2") ||
+	    !ASSERT_OK(btf__add_field(btf, "x", 1, 0, 0), "elem2_field") ||
+	    !ASSERT_EQ(btf__add_struct(btf, "elem", 4), 9, "elem3") ||
+	    !ASSERT_OK(btf__add_field(btf, identical ? "x" : "y", 1, 0, 0), "elem3_field"))
+		goto out;
+
+	if (!ASSERT_OK(btf__dedup(btf, NULL), "dedup"))
+		goto out;
+
+	/* Identical elements leave only the first four expected types. */
+	btf_validate_raw(btf, identical ? 4 : 7, (const char *[]) {
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] STRUCT 'container' size=8 vlen=2\n"
+		"\t'first' type_id=3 bits_offset=0\n"
+		"\t'second' type_id=3 bits_offset=32",
+		"[3] ARRAY '(anon)' type_id=4 index_type_id=1 nr_elems=1",
+		"[4] STRUCT 'elem' size=4 vlen=1\n"
+		"\t'x' type_id=1 bits_offset=0",
+		"[5] STRUCT 'container' size=8 vlen=2\n"
+		"\t'first' type_id=3 bits_offset=0\n"
+		"\t'second' type_id=6 bits_offset=32",
+		"[6] ARRAY '(anon)' type_id=7 index_type_id=1 nr_elems=1",
+		"[7] STRUCT 'elem' size=4 vlen=1\n"
+		"\t'y' type_id=1 bits_offset=0",
+	});
+
+out:
+	btf__free(btf);
+}
+
+void test_btf_dedup(void)
+{
+	if (test__start_subtest("array_different_element_types"))
+		test_array_element_types(false);
+	if (test__start_subtest("array_identical_element_types"))
+		test_array_element_types(true);
+}
-- 
2.43.0

