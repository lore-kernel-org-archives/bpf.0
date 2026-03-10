Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D0340DFB1
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149920; cv=none; b=WLTUuThhtwOkJ2KLgcQzSOqAae/piQgrJ23LlfSbvZxlbSG5iwkoR4BJfYlTo8I6L+5YcPLeSHRPv9WzXTIpTJDO+FHtL3fSLBePJYDJ/WKDbZTb4MchTLA1tPqbBR1MxOquLgg0ByZZqZ4bKKG3sjz38gHeW4PauiSoEVUHfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149920; c=relaxed/simple;
	bh=M3Lc8CrWNaMojtrHO4gw5bdP11pPrygd6bjnFklUemI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnvCqpoRKin1i/ihm2IedX4RpA/2T/5MSQxyOnNXjEr578X78412XCL2lolMtBrpwKWnCCzzMd/lbBKB97fTU/gbzB0kgF9wAu13bz2lKtencPNHqlLaeKtyk87Gibg3XFulBxXKxnzEtYrhV2/GtlP4LaFyPQqirVk2K7WhSQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3xk3hnK; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3xk3hnK"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6e2355739dso5243981a12.2
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773149918; x=1773754718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLBuQxLI3rlskofeVZWajhDyFNDuGNSsgZJnCF7UBJY=;
        b=g3xk3hnKeCReuTkb7LbbaiQvbrhG9OzSSHAAPeI19dqEjj76xwzfwySzbyrIPtRsj5
         z2wHnkrGmZX0ifYKsbUZ/ZhbNVTBuauRPShEk9Y2owNVkAXMwclWfj6eZeom/q+jPHrU
         in6hWVEwVouTTo3u13Z5S+4SzRjzcpEwz3n0ImAg/6jxAGZEoxc1bKSxO3K/idsONoyY
         cxT2dM4Ao1LaOB1txFCQedizUg3AWvnRJ5DC5o9oHIBCQfgiap4AlyJAJAl0dBtFIt+R
         DiL7X7+I6U2OBOVqnGGjdSKVy4AYqWCr0UgmCduEiIqOudiACMIt15/81bdLXABf+C6y
         42Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149918; x=1773754718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLBuQxLI3rlskofeVZWajhDyFNDuGNSsgZJnCF7UBJY=;
        b=puc75UThwUo68De2+9jYHWd9VJ11Qz2rTO4+gSgRrGoOCYV/vvqtI08pIf/cumWS+A
         Xs5eNVTl69/LPIAw62wG/ykkLGy14bq+fMrc1lHVrJQLlkxMOGekMrTUL+yGBt3o22Ms
         09TVgzFskyiXBlGfyY9j666yA0+JqGkOwPg1/LRQFEBoEINV8eoPkY24RES0blZqBu2C
         HOokgSM1wPvoTab1T23WevWmojjIpLheQ6C5t3EA1vqYbhAt+U8rjZXCqzz3oKwcvuJ9
         lKrW/0/rieD/WdXceq0UHYHDRVpsOF/JNktT82cfgbcw/9tlDn0sZiqarYEJ6MYMHptK
         DfmA==
X-Gm-Message-State: AOJu0YwX+Rgrgi7NXEMuFHAAT2iJx/wwtAgNOlDpz54x85VTtlbl0326
	SqhOuoKX+rY5zCjr0G+134Wtny/TscHjYZLlqM+bd87suOvSyHDDbaVP9jTRHZ6zPgY=
X-Gm-Gg: ATEYQzzCSiE5gpkRKVP+ZrwY+1DzmRt8dfpErOA4FSdlJe0B8YARhDo06d2l8M7tJZ+
	c0kMT04Wzviy524xS7RNZ9EFjUGn9gl1caf88vkVwLL6TOGOUqlVPUDCqiB9LKlmGgmpH7eBs8m
	GfGalquZz3uCeQRyW/P/Vkdnmgtj20rOC93vlkkdeI3yA0REI/e6eUgkmHIRzCP3nJm6UadhWOs
	n+Zt79F708cL3srGXkiEjq8CiheStY7Vf2gZTbeKDL5Uaxd+z65JxVAF1ezSGC+HUkFGRE+IcWv
	5i8N9IgbZPbtWLlntXvVIy+AGyGnQYWrPkVZYrn0YfAce7Cw19u7lTpSvxymSbT7JKgPhM+JyHX
	x+R/YJbJ8PmLOLsOTn5Tkm7kwDz5xxbksIx9TBB7+C8f7o8c9esdAmlaiaCF3tM2Cl9XlZdpXPS
	RGEEqzg3kisiuXcvvR5eS1xofmlXSd6u0yU6h7nZCY1J3qcBeuXYTz0mgfq5Z1+vNb/c9mdNN4v
	z/GPCQ7b2Ot14LeJQaC
X-Received: by 2002:a17:902:e790:b0:2ae:5aed:1f4d with SMTP id d9443c01a7336-2ae8245cd73mr141664525ad.42.1773149918070;
        Tue, 10 Mar 2026 06:38:38 -0700 (PDT)
Received: from kali-VMware-Virtual-Platform.. ([185.218.127.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78f6csm203111285ad.23.2026.03.10.06.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:38:37 -0700 (PDT)
From: Daniel Wade <danjwade95@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	Daniel Wade <danjwade95@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Add tests for maybe_fork_scalars() OR vs AND handling
Date: Wed, 11 Mar 2026 00:35:04 +1100
Message-ID: <20260310133504.94871-3-danjwade95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310133504.94871-1-danjwade95@gmail.com>
References: <20260310133504.94871-1-danjwade95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three test cases to verifier_bounds.c to verify that
maybe_fork_scalars() correctly tracks register values for BPF_OR
operations with constant source operands:

1. or_scalar_fork_rejects_oob: After ARSH 63 + OR 8, the pushed
   path should have dst = 8. With value_size = 8, accessing
   map_value + 8 is out of bounds and must be rejected.

2. and_scalar_fork_still_works: Regression test ensuring AND
   forking continues to work. ARSH 63 + AND 4 produces pushed
   dst = 0 and current dst = 4, both within value_size = 8.

3. or_scalar_fork_allows_inbounds: After ARSH 63 + OR 4, the
   pushed path has dst = 4, which is within value_size = 8
   and should be accepted.

These tests exercise the fix in the previous patch, which passes the
opcode into maybe_fork_scalars() so it sets the pushed path value to
K (not 0) for BPF_OR.

Signed-off-by: Daniel Wade <danjwade95@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index a0bb7fb40e..541d70fa46 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1200,4 +1200,106 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("maybe_fork_scalars: OR with constant rejects OOB")
+__failure __msg("invalid access to map value")
+__naked void or_scalar_fork_rejects_oob(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r6 = *(u64*)(r9 + 0);				\
+	r6 s>>= 63;					\
+	r6 |= 8;					\
+	/* r6 is now either -1 (current) or 8 (pushed).	\
+	 * Current path: r6 < 0, branch taken, exits.		\
+	 * Pushed path:  r6 = 8, branch not taken.		\
+	 */						\
+	if r6 s< 0 goto l0_%=;				\
+	/* Pushed path: verifier must know r6 = 8.		\
+	 * map_hash_8b has value_size=8, so r9 + 8		\
+	 * is one byte past the end -- must be rejected.	\
+	 */						\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: AND with constant still works")
+__success __retval(0)
+__naked void and_scalar_fork_still_works(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r6 = *(u64*)(r9 + 0);				\
+	r6 s>>= 63;					\
+	r6 &= 4;					\
+	/* r6 is now either 0 (pushed, 0&4==0) or		\
+	 * 4 (current, -1&4==4 in AND path).			\
+	 * Both paths: r6 >= 0, falls through.			\
+	 * Both offsets within bounds of value_size=8.		\
+	 */						\
+	if r6 s< 0 goto l0_%=;				\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("maybe_fork_scalars: OR with constant allows in-bounds")
+__success __retval(0)
+__naked void or_scalar_fork_allows_inbounds(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_hash_8b] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r9 = r0;					\
+	r6 = *(u64*)(r9 + 0);				\
+	r6 s>>= 63;					\
+	r6 |= 4;					\
+	/* r6 is now either -1 (current) or 4 (pushed).	\
+	 * Current path: r6 < 0, branch taken, exits.		\
+	 * Pushed path:  r6 = 4, offset 4 within		\
+	 * value_size=8, so byte access at r9+4 is valid.	\
+	 */						\
+	if r6 s< 0 goto l0_%=;				\
+	r9 += r6;					\
+	r0 = *(u8*)(r9 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

