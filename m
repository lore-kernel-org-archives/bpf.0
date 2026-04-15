Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5403DBD70
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776269263; cv=none; b=G6WaU9bxXZhvdHUtBw9ldkYI1CtvJEtRkwD2f4LbUBOY83X0fECDUXdXFgWkj68zL8R9w15UYn2rxgb/yLCZNgsHO1oumn41QsUxIJbEn3n7HPJ7mKAHjbPlV7/cZUCjOqRd5PFrCjU5IOhsbRFsLf1HT0Cz28CxgquoZCDxn5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776269263; c=relaxed/simple;
	bh=n1d2SeMZM2zZwkQkPQHoIT8LP6c//bTSAEtt+6JKy+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jj8oUFN+c2w0abteO4hvz/bb0/K01cTk9NeUqFffZ6BCMAUvgfw2m5CRK8nvwaLXLokLiYTUjj/4b095P0VNq/2ww/YC+rIVuc6N5JV6qF/n+VAxXThjPrW8KZvDTdvaCmCzSEbO7whiurMxGNVI1TzazFcjtZepglsVBz83b+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCB2uUV+; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCB2uUV+"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56a857578a8so2740849e0c.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776269261; x=1776874061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sRf1ZhfESR0g5qmvARKnHi37WjtyuE7WI4Kzrl3FU4=;
        b=rCB2uUV+de1CTj55C5i8eF9VjW6ebIA1/4OepZbYHWOfu0dCI8Z6GxAQN79BZNUzJF
         51TxDUQuod2c10vhr2i4U7LR/AlJaj5XZ9QGpVYQebZW357GGBB31f9SmMgjntfj2004
         jVbWLU9veCGRKzpylHKp+4CuEusITcscbS4lLp9aTLCkyV1d2pdb62OwQcjHg6I7L/CL
         2uaHOy1het/41ja1p8/WFXVDRAJD4O+hco7tlPuFProhv7WAtviFwV4fKGCxrEr4HBqa
         E+BOv157lZXXGZ3tFl5dXAvta+g/6f8BXDfSANU+4sUHD2OsyhAUma/sA7RVWCQWQj92
         r8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776269261; x=1776874061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9sRf1ZhfESR0g5qmvARKnHi37WjtyuE7WI4Kzrl3FU4=;
        b=ZR6nuqfO8PGm/01+6eP0CxzLwF0eYM/xuC8pvGp8yapMlC6KPeL84mecqWx3RePL7c
         eaYDthAdcUJDqtEBlVFylIvaVxXl6KW/EWAZMRysM/s2xvWYND92DXd2ifRFFulBmntc
         Jim3wAdjBJTUBzcKSbjd8T4y7int1w1XlXaxCsQ6PLMjNfZJc/HgmQ9wL9EaGFWJzaWP
         revlcvxRUMNbVEQMfEuep7m+f4Hw2ORG3MB0WKDhtmFwappD2GET25Wmkil8KiUiTKIJ
         X2jT9ScbdOdaJ+YdYcxxPg21SUdzskvYG+AtH/Hhpur6KbDYT9xQHdu3C4cSbEOKi/wT
         d20A==
X-Gm-Message-State: AOJu0Yz232dS8OmoRWfNRPeIzAvQ8tHOxVkPmHDiFoDL0RT5nQ5h1QGb
	SfeP2aKQbP6pU9G1uNEErCNNrieVtoLbsvioGqwgZnUi2L4Ht4PMQ6FJzJbxGotV
X-Gm-Gg: AeBDievcbXihM9R0Uxfj5y0omN4YWlGkwgyoFrvtIzzpbX6/UWGB1eXhAHReOnru8l+
	3gAn8RihkDcS7aqkgu3pO3OHWHddmRgeP6Q7eTqBr8lrQqpDHAi+ZPtGsIBN+k411mVkXrKvwI4
	yC7VwCJwOPoYrHvSfcbGyuM52f5AUJlGOg3El+K3DexZr3CliKss+d8NmyGDo/Jx9Kar1fYaCjP
	SpmDQhJU57lyYJlYQ0IDSzaYNrbCHAKggD8sUBy22SB7cSnAxNDAivKtucfFwbizq+0HNWp7xnW
	4lTuAN7DSokCWRKvR9Wf/v3falefAP7Ly1mau8tj+GnrvBQzNnxqmHfLw7BfHnxMdZAuSsmyEfV
	NvwPGpHeEnp7OcEa0D02u0XekMUxBNHUbOpNtiJXeIYKy4zSWjHOodsV2RcSIwsSOXKt5ZQjn0o
	2kXOZuyfJ7gQVzBHleKw+0b0KlmF+yDZQu4JRmna2Xzlrl1yPsl0amcMyGK44OFng4TvGdePvvA
	2Kr+HWPl/Qs5he7sOUlhCHu9JmVZ4GXVDB2EfL7BA==
X-Received: by 2002:a05:6122:65a1:b0:56c:d1b0:3626 with SMTP id 71dfb90a1353d-56f3bd1af66mr11489933e0c.15.1776269261148;
        Wed, 15 Apr 2026 09:07:41 -0700 (PDT)
Received: from lima-default (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c959839sm14883736d6.14.2026.04.15.09.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:07:40 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test for empty intersection of tnum and u64
Date: Wed, 15 Apr 2026 12:07:28 -0400
Message-ID: <20260415160728.657270-3-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Chaignon <paul.chaignon@gmail.com>

Thanks to the previous patch, if the tnum and u64 don't intersect on a
branch, we can deduce the branch is dead code. This patch adds a
verifier selftest for that case, with an invalid r10 write on the dead
branch.

Without the previous patch, this selftest fails as follows:

  0: call bpf_get_prandom_u32#7  ; R0=scalar()
  1: r6 = r0                     ; R0=scalar(id=1) R6=scalar(id=1)
  2: r1 = 0xe00000002            ; R1=0xe00000002
  4: r2 = 0xf00000000            ; R2=0xf00000000
  6: if r6 s< r1 goto pc+2       ; R1=0xe00000002 R6=scalar(id=1,smin=umin=0xe00000002,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))
  7: if r6 s> r2 goto pc+1       ; R2=0xf00000000 R6=scalar(id=1,smin=umin=0xe00000002,smax=umax=0xf00000000,var_off=(0xe00000000; 0x1ffffffff))
  8: if w6 == 0x1 goto pc+1      ; R6=scalar(id=1,smin=umin=0xe00000002,smax=umax=0xf00000000,var_off=(0xe00000000; 0x1ffffffff))
  9: exit

  from 8 to 10: R0=scalar(id=1,smin=umin=0xe00000002,smax=umax=0xf00000000,smin32=umin32=1,smax32=umax32=1,var_off=(0xe00000001; 0x100000000)) R1=0xe00000002 R2=0xf00000000 R6=scalar(id=1,smin=umin=0xe00000002,smax=umax=0xf00000000,smin32=umin32=1,smax32=umax32=1,var_off=(0xe00000001; 0x100000000)) R10=fp0
  10: R0=scalar(id=1,smin=umin=0xe00000002,smax=umax=0xf00000000,smin32=umin32=1,smax32=umax32=1,var_off=(0xe00000001; 0x100000000)) R1=0xe00000002 R2=0xf00000000 R6=scalar(id=1,smin=umin=0xe00000002,smax=umax=0xf00000000,smin32=umin32=1,smax32=umax32=1,var_off=(0xe00000001; 0x100000000)) R10=fp0
  10: (b7) r10 = 0
  frame pointer is read only

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index c1ae013dee29..151c7a479a6b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2184,4 +2184,29 @@ __naked void tnums_equal_impossible_constant(void *ctx)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("dead branch: tnum and u64 don't intersect on true branch")
+__success
+__naked void empty_tnum_u64_intersection(void *ctx)
+{
+	asm volatile("									\
+	call %[bpf_get_prandom_u32];							\
+	r6 = r0;									\
+	r1 = 0xe00000002 ll;								\
+	r2 = 0xf00000000 ll;								\
+	if r6 s< r1 goto +2;								\
+	/* On fallthrough, r6's u64=[0xe00000002;0xf00000000] */			\
+	/*                      tnum=(0xe00000000; 0x1ffffffff) */			\
+	if r6 s> r2 goto +1;								\
+	/* On fallthrough, r6's tnum=(0xe00000001; 0x100000000) */			\
+	/* It doesn't intersect with the u64 so the condition is always false */	\
+	if w6 == 1 goto +1;								\
+	exit;										\
+	r10 = 0;									\
+	exit;										\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.51.0

