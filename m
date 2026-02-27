Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4937BE9B
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772228571; cv=none; b=PhmISC+elnuy00de8+z2YWaYc3B6dG9At5WK4jCRaxUos8pYIeDHPkULie47xf56VB9k/hIdoU4x7ZivEymDR2RHrpWpETk7IQLERQfB1rjwsg5Ohp2KQQxIMDvOs16a2/xMEJEbJ6zboLCPlVprYuDq/sKtTuZYPpCdfhJD2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772228571; c=relaxed/simple;
	bh=EXebDxV6DbidSI7ZH33Ni62tmJVNdYiwnv26iV97MkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk19EM2TAZeV3Ydso++liEbKb8wj8M5UcHcTrazMzWV3unB9Diau+lto51I0TX4SBOkFSn/45TAowd+TQ5mxx5oS10KWrDkNVWbnUNsnHR2yBeIRcRmnsN6paSx6kyTNJAwCl4nvFNd3ilrNx2W9HRTJBgdiE+gXSEAE2HLlr7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGLS/GNM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGLS/GNM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso19959715e9.3
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 13:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772228568; x=1772833368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIwOA310k/uKWFCuynAytdPrqPN15Xibbm8zSDFj/3A=;
        b=UGLS/GNMSHMXRH3K2GWeYfOHwGWPlvTTWtI3qM2aRk6nJG4eA4ji/wQ8VPCwugPcfP
         jUiIJsbWML9rdoc1SOsVslW9PIaq2lBw/Ipn5D+00mSmDXYN4OIRIgJyQH5Uhh6rcxft
         rLXEsGtOCYwJPEmnRVQjRiFMKTKnVpnYImFLWUonkJulkRx1vviCeXyhwqEQjje2VV9B
         a/xtEE5Mz0FRLXPNhHCy7y7QoEVEdxqDtkC9Sc05x0LxWQM3ADumiA7RcGAZLvgcFLY/
         AwM3vH/e963Cch9Uw0qZ9UnJ+B0F9Xh0j3nS14bgIkDiBfxen9PWabB73MyM+IfddMdY
         N6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772228568; x=1772833368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIwOA310k/uKWFCuynAytdPrqPN15Xibbm8zSDFj/3A=;
        b=nvwrHhYiMGwy/ezjvs1RFZLIsOoRT7cXjACnpGXzilnBZoAXvFvgruFhQl5o+3jdUs
         3npelihFey/0qZBxnvKcOw2433IGJmmriarT90pIV6dJNxreEk1u3NlHGtRvKheymX6r
         qTjuH7npxueBLM5YJxucSdwhAcoooUHMkNaja4uODA6svT744kYvDLF5/KJQr1sMb2ZV
         RC0ujTrXI9tvPTg6GXGT1Ma0/zr9tVWkPIyuL+k1foJOAH9K8wpIThH8EhvZATQ0sC2k
         HuY1NDpXopwfDpo1TU8xdKILXQ1fcCvRwIezEjGpqfCsoObYyVrfAzvA4YN1fZzjCrIh
         5zLw==
X-Gm-Message-State: AOJu0YzHWhyZ6MrvxNnnQA7jSnuD/7AH+wYihmqEPgAGcUy6M0zFPeno
	A5QnBORod6dtDTZMb4CleciTNusU0+Zn+ymyIjMqUF4qW9sI579EXxyM/qh0mvJAItA=
X-Gm-Gg: ATEYQzz56pn1ITr24kn7peo3z6Py5dolRQ3giH+SJaX77G93K+WsydgAJI1FDpDf7vw
	lHV3OwM85t+BQDSiVJiUIFvN8fMWFYNoSG6MpQsbWdoUO8yv/8VzU8riK7uZUd6VVlynbvcfTc6
	9/osaRlAgP090yUHVs0jCZF4B+ZQbTnCKnfs43rJrYKZNFfH5OPnZM4ZVpAqIOlEuWLJrk2M7Kv
	FycMI/ck3QuBdtxfKIn8sb+HKGu2aw4dLxvXxbGkPxWt0XZqgTEkRGDWNwT3CGP4jb8t6JWj9Ba
	q5oxxbR+jDGsj1YDcs7WjOkvdMZsRN6xSTYC2IAAWBUwP4M+p3b2xClVZ94HfhtjcoTyMN8Xyro
	hpnZgI2/Fa3+FwT1qty3ink+CUlFyLVE+kodCBxq/wYPcV0I5m4P9zo3O9FK9tOVCYjIJz3Z3DM
	KqHFSuOl5qMT9x2kzx35/I4nRMPq8HARoyrbefGBlJ+VqkylKXJIzeOPEgCXOyk7qXUGtA0KWd7
	MyYPCnvo44/vrgWAtJhnAjKNw6g87EVn/OXZPKDcX0bTM14leITbGIHDt6Oa5IAsSb4BfNyO3Cy
X-Received: by 2002:a05:600c:c16e:b0:482:e5d4:b7ca with SMTP id 5b1f17b1804b1-483c9bbb8d3mr67920425e9.8.1772228568159;
        Fri, 27 Feb 2026 13:42:48 -0800 (PST)
Received: from Tunnel (2a01cb06901b353b20ebf6654db8a566.ipv6.abo.wanadoo.fr. [2a01:cb06:901b:353b:20eb:f665:4db8:a566])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b84023sm132429705e9.12.2026.02.27.13.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 13:42:47 -0800 (PST)
Date: Fri, 27 Feb 2026 22:42:45 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v3 bpf 4/4] selftests/bpf: Avoid simplification of crafted
 bounds test
Message-ID: <50641c6a7ef39520595dcafa605692427c1006ec.1772225741.git.paul.chaignon@gmail.com>
References: <cover.1772225741.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772225741.git.paul.chaignon@gmail.com>

The reg_bounds_crafted tests validate the verifier's range analysis
logic. They focus on the actual ranges and thus ignore the tnum. As a
consequence, they carry the assumption that the tested cases can be
reproduced in userspace without using the tnum information.

Unfortunately, the previous change the refinement logic breaks that
assumption for one test case:

  (u64)2147483648 (u32)<op> [4294967294; 0x100000000]

The tested bytecode is shown below. Without our previous improvement, on
the false branch of the condition, R7 is only known to have u64 range
[0xfffffffe; 0x100000000]. With our improvement, and using the tnum
information, we can deduce that R7 equals 0x100000000.

  19: (bc) w0 = w6                ; R6=0x80000000
  20: (bc) w0 = w7                ; R7=scalar(smin=umin=0xfffffffe,smax=umax=0x100000000,smin32=-2,smax32=0,var_off=(0x0; 0x1ffffffff))
  21: (be) if w6 <= w7 goto pc+3  ; R6=0x80000000 R7=0x100000000

R7's tnum is (0; 0x1ffffffff). On the false branch, regs_refine_cond_op
refines R7's u32 range to [0; 0x7fffffff]. Then, __reg32_deduce_bounds
refines the s32 range to 0 using u32 and finally also sets u32=0.
From this, __reg_bound_offset improves the tnum to (0; 0x100000000).
Finally, our previous patch uses this new tnum to deduce that it only
intersect with u64=[0xfffffffe; 0x100000000] in a single value:
0x100000000.

Because the verifier uses the tnum to reach this constant value, the
selftest is unable to reproduce it by only simulating ranges. The
solution implemented in this patch is to change the test case such that
there is more than one overlap value between u64 and the tnum. The max.
u64 value is thus changed from 0x100000000 to 0x300000000.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index d93a0c7b1786..0322f817d07b 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -2091,7 +2091,7 @@ static struct subtest_case crafted_cases[] = {
 	{U64, S64, {0, 0xffffffffULL}, {0x7fffffff, 0x7fffffff}},
 
 	{U64, U32, {0, 0x100000000}, {0, 0}},
-	{U64, U32, {0xfffffffe, 0x100000000}, {0x80000000, 0x80000000}},
+	{U64, U32, {0xfffffffe, 0x300000000}, {0x80000000, 0x80000000}},
 
 	{U64, S32, {0, 0xffffffff00000000ULL}, {0, 0}},
 	/* these are tricky cases where lower 32 bits allow to tighten 64
-- 
2.43.0

