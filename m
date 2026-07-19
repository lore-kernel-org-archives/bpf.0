Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4E3A1681
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475402; cv=none; b=kTeNFHnNgaNZGdw+omDRXPJmCFEZJuHDbHl3rxIVE3m+WpISVI11Qv43euH2sSASzpe3MZmgZ4cZ3Ja7E7itHGvBJViZvc5xBMOC7+zIyC6S1x7sPEswnS93G2bc4qWGziurM3rwrcd2Vm/5CZcrPY6xT8accVBf90NkAkPku/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475402; c=relaxed/simple;
	bh=10Ho7dr5l4fuAhOOthXSibAznFNAgGdRFTc8FN9HcCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcTxxbM7IGE8DDzxOm6kt4MYN2D3RXNhzrzlqGa4uWWER4N+VA1nDYRKGSQJ93nxV3ZNENXCcWoO5S+ROD6kXiMGv8841eHzztbQovUHOmMtGkoTmuxK9tI4m6sgQ8uRiyzDMYMkpxvnJq5/RC4CtnoAkA0biEmStqQbEl2ur9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APem2PZB; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APem2PZB"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4744516a312so1276327f8f.1
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784475399; x=1785080199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vmi9hbcO0tiSDtwGKEKzAl+A2ux3D+9Qg88NOjva8w0=;
        b=APem2PZBu6b28bEEkQvkhNabsveLcNgTSEsfj2ag4Nibye4oqywFuS8RU+HlheTmc6
         URcVNKjj+czzx5lleOPstpATePlxXfGn/y4bUn6qcj/ia5h82l+WFQAWu6NnyjzXFNC/
         tLzUwZ9NsxBjI3ql42IzfWKmcEo6iYy8I4d+t8eZLT4Sb2DF8XvGHIMgT2Qw0vRVH/PY
         Gb+vAQ0H4aFhtk5EybU4prnBVfU6k5s6FuW5x8mVyS+NzBBzgEg8RdPOlJKIakf6wMC9
         mPGOTNjZB5bGggLwZDrIbAd32Q/nyYYr83Tru5+h9jELIBAVtsGo/vQbjNFJXgeUBJFT
         BnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784475399; x=1785080199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vmi9hbcO0tiSDtwGKEKzAl+A2ux3D+9Qg88NOjva8w0=;
        b=Y3PTUEEkI3tfJvY0KqokiQmRc5JvWsy+A9BQyJfZc4WE3mPLCdRk0auf4mM/Ux+xpe
         Ea041+0QyimNrDgI2XOz+mojQJ5TF6CKZbu4nJNA6nGPe+FdxEK0uEAT43nCUahG2vTO
         RAXcyEjOAVY7Rnlz2BFY7RU86BFjk9F9xIt8zaKw9V5qHcjtTEDtFLDOgKeGLQJAyUpL
         ub0/bmtR/cXVn/14fMADNC0EZNhiy+Kz307Z48kdFWADRn7wr4h5tSJKh0K6RH7HxJ01
         GAmVlR9UL68MjAZNN//J4Wt3nCoMZYwF5tz9j5O7iKjrbcQ8CuJ62FTRYHHmRVMiOQf+
         gq4w==
X-Gm-Message-State: AOJu0Yx+vGC8m9wvpnOwN0iVtCOpMLBj8OQl4M63uhGNWPjfsH6LWZdc
	vArng3VVb8W6exL0Da5sf/aRUXm+NE3s8QsjdDtom7kttLVVihyBfZYggcJ+rLdT
X-Gm-Gg: AfdE7ckmJETRlDM0aqsGljrWX1oEw6Pnv5uraneoJFySVWpvCkhnAem5t+lRUKCIMHO
	uECcC6luaHfypCXE/Bl7CSTdzSuoKuWZzsD3ZsTJyIz+lTh8oPL01yCsLU4bR8ZHoBskMq2W+bK
	wx3V03JZcQ5qd83Kn7h16RxZYSEkLyleFdvtgKfs3Y3d+BJRWbAj/ReaX+4zPx8nCZCL/MtECEO
	w0Jopzj8labRIl6K296xDjH/YGQ8ux+5j4ra86DkkwVX3eMdsnjvikV8GlfScaBEayMpzRDigyV
	gE9ZY6Jg2KvBYzS/cPf7m3SHW7r8ArWQBXA+xwvPq8ZT36bJ/nDANpab620DQ196dY3LpHoq9mz
	qPlWfY/Em3dg1AWyZHh/x+ob8xNIo5G+T1kDaXXVuO4XStRDIiGTufQS6xjnYd7Wy5hUAs7u4Q6
	4UCPR+QAA0aSa1xWETH2B/twxth+GGR0mVeV3vwUM7meLnvPbQ5+lmwtX73NzxICNGKsS2BVYYL
	Q+RJuwWHUxUVrpgHTzYEIg51cnth5f24/HUaUlzOn0A4e1xkVTCq8M=
X-Received: by 2002:a05:600c:3113:b0:493:f478:4c71 with SMTP id 5b1f17b1804b1-4954a323b14mr107429325e9.7.1784475399059;
        Sun, 19 Jul 2026 08:36:39 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm221929135e9.12.2026.07.19.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:36:38 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: Test duplicate unique fields in nested structs
Date: Sun, 19 Jul 2026 17:36:31 +0200
Message-ID: <20260719153634.2908692-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719153634.2908692-1-memxor@gmail.com>
References: <20260719153634.2908692-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=memxor@gmail.com; h=from:subject; bh=10Ho7dr5l4fuAhOOthXSibAznFNAgGdRFTc8FN9HcCk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISvmlcSU1R9Mrh9YOCF35iKZi58XyUd5lPRfMH39XfLuE i+135WvO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRl/4M//23PVi8vVPSTOXv 9dvHeLY/4Z3UtMV4ZeG5BLUnBQofMgoY/mn9MrlTe4X9W5XLq1adS+XysrIarpvqQ7Y+u/db46/ 5Wg4A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a raw BTF test with a spin lock directly in a struct and another in a
nested struct. The duplicate must now be rejected during BTF loading.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 66855cbd6b73..2100400d896b 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4250,6 +4250,33 @@ static struct btf_raw_test raw_tests[] = {
 	.max_entries = 1,
 },
 
+/*
+ * struct inner {
+ *     struct bpf_spin_lock lock;
+ * };
+ *
+ * struct value {
+ *     struct bpf_spin_lock lock;
+ *     struct inner nested;
+ * };
+ */
+{
+	.descr = "struct test duplicate nested unique fields",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_STRUCT_ENC(NAME_TBD, 1, 4),				/* [2] */
+		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
+		BTF_STRUCT_ENC(NAME_TBD, 1, 4),				/* [3] */
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),
+		BTF_STRUCT_ENC(NAME_TBD, 2, 8),				/* [4] */
+		BTF_MEMBER_ENC(NAME_TBD, 2, 0),
+		BTF_MEMBER_ENC(NAME_TBD, 3, 32),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0int\0bpf_spin_lock\0val\0inner\0lock\0value\0lock\0nested"),
+	.btf_load_err = true,
+},
+
 {
 	.descr = "struct test repeated fields count overflow",
 	.raw_types = {
-- 
2.53.0

