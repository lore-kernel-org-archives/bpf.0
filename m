Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7558B6BD
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886187; cv=none; b=UtGUtQQgBKUPBbhqC4sPV6rlc4VYs2BrrgamM9ENAb7JeSegzfcAcPOEqqVVcwII3NfxryvoRy4PYAfzGXUZHI1Fs6JDDUHtrO/RN0GRJ01628KzSEiFKfAxDss3dZYbx5gXQMdeBAdwWlodrsFKp36xf5qQYUV3yTmmCaBBNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886187; c=relaxed/simple;
	bh=XxyMRF7fIGTbzRWsCbIPEAOZABbUq1jiCt4sxrunbeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hp91k6e7kOm82Y5iWB1qMK6DzLIH8Z1HEsxV1cEQI7ib0Aa6UTnXzii7TWZlFnay25SgXZkK5yTkrdk4Gs+GRJhheIYW4/9XRbvranPcotMwmLr0cybw4dbTfCdXjI8gZb+WEd2c8tglYp3/1XSmUm49pM1bRN3HHUidunNLWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En4N1VLI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En4N1VLI"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d9004f39d3so58483395ad.2
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886185; x=1789490985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o22DZiWDDwlAzhaD2Y2B352oTp6NegGs0qXVvBJMW04=;
        b=En4N1VLIN21Ys5ZvxycefGOJeV6JiRA3xhJ6p4btDRh2YU3c/7tSbeI62VIqPPZt++
         6Ko/mEyzmdnRhWxT4z5xx0zFsKbpMpd9m2TjposH+H40jO0eE5JBG94w7NxVpV2LqF+6
         BuUXQ1YIsDrpw8qDqTRVzMkG3zVGqYHuZC09YQ9biGrLRGIMmOxVxrb73/IpW7LJePIl
         S9EVWHkwnisl5d8nZiTrwGhUdCIqi5kLPd2xe21hieCkr2NHwawavlGHzB5GH7CI2Bvy
         YJskMkeVrgTrDmxhsQeFG/NKl8TA8gMXKu4FMYpJi4rf0k2ykMDPbn9wty+09WEibY9b
         qlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886185; x=1789490985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o22DZiWDDwlAzhaD2Y2B352oTp6NegGs0qXVvBJMW04=;
        b=qbec7oDe+siT4A5J/Zsfs9d5Db2TMznny9NXgh2w4IQUBSh6zy2bkc7HschMdch0k6
         4h0RWVlfKBUkwNHGzKAa1rcBPHUGcbeMP+X1g3oWq027nuEJ+mhs1bEZdxl/4kJOUOwb
         lGEuEEKFry9ZtG/HlxzUrqAotanozizvcy6T9dofcJRbV9ECX9OjHo2Ef+ZDWETQr+54
         4KnXBBw2nm/ymTjZW4lpAUQYCJiNgMPDrwAVqkIpm3Gb+h8eYNUddelniWhIacEmo5lg
         jUZnp/XuRghDYfBArKDdUQnpirOsKPHV+Ozqm2lhVNU55+5n0rPMGaqLfeYH44FOOuCs
         UbFg==
X-Gm-Message-State: AFuF++ngY5PPagKHobw3iTxCtrZPZEhx1f39ap00c37G9Q1Zx4hxYr1n
	Gxfdli4Xm24OBGK2wVx4If8Q0CS+7rqFs8PVHshT/wPgNln3+GK9VMLvk7pyORhOu49p2g==
X-Gm-Gg: AYBFou1GEOy1pfo2dniICc+HY3BJQQks2jbhdpbdcfso3qiqDClIyijacqlaleEnpJW
	c+xSvsaRCUCEMPUj6Iih8bCC3h+FQbF0Sn20c5hn6hhBs9eV3OELNR034cGWjZiqm31m0gT/bTf
	Knlfz9aHKR8Sutx5FnTggfWxFIt00W8RKYNms1KBX/cOLqWGWEnuH4fB8UPeLpAuy3PfdWwf/6G
	bP+U0sGN6nN5Ai3AMScTSMvwDNuKGZT8qx+mu1736HRamxB0HZhWAWA38lhnqBEF1MparbHIGWw
	nF53yesk9QZj4tbSMNsJ+MJ9Rq44oZOIQk4zDZoY5AZsT5Eqo4tUvpTq+DRbo4KsLmEP9JZFRef
	O1BWt9fv4WJAtVTyeeYhWq9zcFdKC3H4S17kZoKL+V86MQVMaJHlhuc6gujGzYjOLWZmjvYRL9c
	P62/hGqhCYdcRLSqjB/DbYKK6r7bTI0VqX70V5tO631L9eTigEdB3qO7n8RI0u80Rf4iR81nD28
	GBsLXJQ0cEJolxwA7K6SIjY8GU=
X-Received: by 2002:a17:902:e948:b0:2d9:51b7:c0bc with SMTP id d9443c01a7336-2db125a3452mr498904515ad.12.1788886184549;
        Tue, 08 Sep 2026 09:49:44 -0700 (PDT)
Received: from HKG-A3-RJYWAR2VC4M5B7A1.. ([140.245.43.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db146b9691sm61354295ad.0.2026.09.08.09.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:49:44 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: Mingpei CAO <caomingpei@gmail.com>,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	alan.maguire@oracle.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test array element comparison in BTF dedup
Date: Tue,  8 Sep 2026 16:49:20 +0000
Message-ID: <20260908164920.108074-3-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908164920.108074-1-caomingpei@gmail.com>
References: <20260908164920.108074-1-caomingpei@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise recursive array comparison with different and identical
element definitions using the existing BTF dedup tests. Add a separate
case with the same index type to isolate the element-type comparison.

Check that distinct containers remain separate and identical types
are deduplicated. Both negative cases fail before the fix and pass
afterwards; the positive case passes both before and after the fix.

Suggested-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: LLM
Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 126 +++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 67b9015cbd98..df6ad38d287d 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7062,6 +7062,132 @@ static struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0int\0long int"),
 	},
 },
+{
+	.descr = "dedup: array element comparison",
+	.input = {
+		.raw_types = {
+			/* signed int */
+			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4), /* [1] */
+			/* unsigned int */
+			BTF_TYPE_INT_ENC(NAME_NTH(2), 0, 0, 32, 4),		/* [2] */
+			/* signed int[1] */
+			BTF_TYPE_ARRAY_ENC(1, 1, 1),				/* [3] */
+			/* duplicate signed int[1] */
+			BTF_TYPE_ARRAY_ENC(1, 1, 1),				/* [4] */
+			/* unsigned int[1] */
+			BTF_TYPE_ARRAY_ENC(2, 2, 1),				/* [5] */
+			/* struct s { signed int a[1]; signed int b[1]; } */
+			BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),			/* [6] */
+			BTF_MEMBER_ENC(NAME_NTH(4), 3, 0),
+			BTF_MEMBER_ENC(NAME_NTH(5), 3, 32),
+			/* struct s { signed int a[1]; unsigned int b[1]; } */
+			BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),			/* [7] */
+			BTF_MEMBER_ENC(NAME_NTH(4), 4, 0),
+			BTF_MEMBER_ENC(NAME_NTH(5), 5, 32),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0int\0unsigned int\0s\0a\0b"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4), /* [1] */
+			BTF_TYPE_INT_ENC(NAME_NTH(2), 0, 0, 32, 4),		/* [2] */
+			BTF_TYPE_ARRAY_ENC(1, 1, 1),				/* [3] */
+			BTF_TYPE_ARRAY_ENC(2, 2, 1),				/* [4] */
+			BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),			/* [5] */
+			BTF_MEMBER_ENC(NAME_NTH(4), 3, 0),
+			BTF_MEMBER_ENC(NAME_NTH(5), 3, 32),
+			BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),			/* [6] */
+			BTF_MEMBER_ENC(NAME_NTH(4), 3, 0),
+			BTF_MEMBER_ENC(NAME_NTH(5), 4, 32),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0int\0unsigned int\0s\0a\0b"),
+	},
+},
+{
+	.descr = "dedup: array element comparison with same index type",
+	.input = {
+		.raw_types = {
+			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4), /* [1] */
+			BTF_TYPE_INT_ENC(NAME_NTH(2), 0, 0, 32, 4),		/* [2] */
+			BTF_TYPE_ARRAY_ENC(1, 1, 1),				/* [3] */
+			BTF_TYPE_ARRAY_ENC(1, 1, 1),				/* [4] */
+			BTF_TYPE_ARRAY_ENC(2, 1, 1),				/* [5] */
+			/* struct s { int a[1]; int b[1]; } */
+			BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),			/* [6] */
+			BTF_MEMBER_ENC(NAME_NTH(4), 3, 0),
+			BTF_MEMBER_ENC(NAME_NTH(5), 3, 32),
+			/* struct s { int a[1]; unsigned int b[1]; } */
+			BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),			/* [7] */
+			BTF_MEMBER_ENC(NAME_NTH(4), 4, 0),
+			BTF_MEMBER_ENC(NAME_NTH(5), 5, 32),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0int\0unsigned int\0s\0a\0b"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4), /* [1] */
+			BTF_TYPE_INT_ENC(NAME_NTH(2), 0, 0, 32, 4),		/* [2] */
+			BTF_TYPE_ARRAY_ENC(1, 1, 1),				/* [3] */
+			BTF_TYPE_ARRAY_ENC(2, 1, 1),				/* [4] */
+			BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),			/* [5] */
+			BTF_MEMBER_ENC(NAME_NTH(4), 3, 0),
+			BTF_MEMBER_ENC(NAME_NTH(5), 3, 32),
+			BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),			/* [6] */
+			BTF_MEMBER_ENC(NAME_NTH(4), 3, 0),
+			BTF_MEMBER_ENC(NAME_NTH(5), 4, 32),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0int\0unsigned int\0s\0a\0b"),
+	},
+},
+{
+	.descr = "dedup: identical array element comparison",
+	.input = {
+		.raw_types = {
+			/* int */
+			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4), /* [1] */
+			/* struct container { struct elem first[1]; struct elem second[1]; } */
+			BTF_STRUCT_ENC(NAME_NTH(2), 2, 8),			/* [2] */
+			BTF_MEMBER_ENC(NAME_NTH(3), 3, 0),
+			BTF_MEMBER_ENC(NAME_NTH(4), 3, 32),
+			/* struct elem[1] */
+			BTF_TYPE_ARRAY_ENC(4, 1, 1),				/* [3] */
+			/* struct elem { int x; } */
+			BTF_STRUCT_ENC(NAME_NTH(5), 1, 4),			/* [4] */
+			BTF_MEMBER_ENC(NAME_NTH(6), 1, 0),
+			/* duplicate struct container */
+			BTF_STRUCT_ENC(NAME_NTH(2), 2, 8),			/* [5] */
+			BTF_MEMBER_ENC(NAME_NTH(3), 6, 0),
+			BTF_MEMBER_ENC(NAME_NTH(4), 7, 32),
+			/* duplicate struct elem[1] */
+			BTF_TYPE_ARRAY_ENC(8, 1, 1),				/* [6] */
+			BTF_TYPE_ARRAY_ENC(9, 1, 1),				/* [7] */
+			/* duplicate struct elem */
+			BTF_STRUCT_ENC(NAME_NTH(5), 1, 4),			/* [8] */
+			BTF_MEMBER_ENC(NAME_NTH(6), 1, 0),
+			BTF_STRUCT_ENC(NAME_NTH(5), 1, 4),			/* [9] */
+			BTF_MEMBER_ENC(NAME_NTH(6), 1, 0),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0int\0container\0first\0second\0elem\0x"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4), /* [1] */
+			BTF_STRUCT_ENC(NAME_NTH(2), 2, 8),			/* [2] */
+			BTF_MEMBER_ENC(NAME_NTH(3), 3, 0),
+			BTF_MEMBER_ENC(NAME_NTH(4), 3, 32),
+			BTF_TYPE_ARRAY_ENC(4, 1, 1),				/* [3] */
+			BTF_STRUCT_ENC(NAME_NTH(5), 1, 4),			/* [4] */
+			BTF_MEMBER_ENC(NAME_NTH(6), 1, 0),
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0int\0container\0first\0second\0elem\0x"),
+	},
+},
 {
 	.descr = "dedup: struct example #1",
 	/*
-- 
2.43.0

