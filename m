Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C53F3CFF63
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025413; cv=none; b=rMwgYIkBDsSyIVa68zCafaJLvP3T9pHq+TTfa92QfQ11M4fn+s0NaMergFP8g4sSKp7qAiByoQOkJNC3D9rGL8tcb3xG5QCl/7DNPdoqjYlBZHVn65EYc+H8VxS5sOvnSoT6OTotkaRXIuRTCK8PDwy5zSpor97AVMNqHq0hLF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025413; c=relaxed/simple;
	bh=abJYq2eJorQws8Yu4IK3w0jeIpj/pb713uR926g6M/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ir5C1Sag971pCfb0bX7fzJkgK2cuB1iJoKjF2wKTI5AOh2f8IJR5vFoEf1r69MmPuKawZlqku7apOKF9lBdafFgwRJWkTjRjQ5xRdGkh7iLnKkyqSobzhr1kQkvykZtsTpx+cyRwLpnXWF78Gq3c8Yx156FnSdkC9D2gZEP+O68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY1zFeOX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY1zFeOX"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fe36cfabso6374165e9.1
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025409; x=1774630209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+SF8BVlk2iUF0JPrfWr+V6kH6sZDdrOPuvOEvG+IdA4=;
        b=KY1zFeOX83yhNDKFzglsxxqx2Ywx7psI1PFBxAX6KCcMRaa2sQue1jWNXCkSXvUv1n
         U5sYYJs5qAx9BW6HU0Fg2FROlMEGPENhOOyIGewWeSQ+Esn2mGljEJMk3SSro+ZSe5CJ
         rqDyUk56PKA/WS46Z7VxqxkMWqhexbpN5+4MNgG1HBsG4ISeEMfz9zHNY2dDYZKlltyL
         oA00mcp2WcxWQKzlFAC626C7Wk1+12IfSYlB+tDx50y7CFo/pE0mVK7XkFBwo0Z5CCW4
         kg4RviOPSZkJ8M9WxwkgsguSRnyfqPFqx48vwepeNoOoghb8ARW07dn6VWdZtkhvztRk
         Amag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025409; x=1774630209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SF8BVlk2iUF0JPrfWr+V6kH6sZDdrOPuvOEvG+IdA4=;
        b=a+q2aDQFamhHj6iR7fPb+of6bwuLNxLMLHE71dwOudAHpCy41edLWScIuVzXlU4T38
         3PVAcBquZPJJpgvCvFLTJdu5GTWnmtdHXfAz54J5we0JCYWK363M8/G//hY/2riqjBD5
         fgUMz7Dw5xJ1BjeCTIXRpL9u//t3eo9ajtLpQc4JtmgVneBwV7jcukO9/dQmQX6nW71d
         38/NHw7AvjqGyqIpRCwwwZ4h/xgpgzb/JFs03c2510LVTvjJZvO7vSpRz2wjZt9zw3OD
         lk7ifuKRcJ6rmyPB/5J8AwhWPVYwChgimL1DeLUW3prYhPF94jf7q/ZTKWx8bTDWkENK
         udpg==
X-Gm-Message-State: AOJu0YwaGrb0kmIkycZpM6gSNgGqi89Y3LXh9yr2SLXzzY6CnqD35VEf
	g5YKBw+tjyqLDB3mRwGKLzMirqOp6GPff51Wr5p15P8aSs16pP1BqPNPpYEok4tn
X-Gm-Gg: ATEYQzza73+UJ95vzgzZe+oa+sp6Ye5wOG3yXY19JtqrHeb9ROqwXsWTesVQu8jepUR
	8xREnPhsZA8p9Fkss50a8oq9HUs6RY5XbJjYdM2tMlJxNFrLNxVDeorKK7qPhUOIQ93leedQP8m
	Lj0bzBuYJAii9wBakQD59Ra2SJRK3ZpGQoab9MIRZA8tff6nDfpHWeGMhAh2Y1cFVjJDwYyCo7M
	uVN49yA8HoY9CTwUgmnTE2muAnctTvKbDSdtuNkuSNbGSqBthLeiw0qlgP13O7XNSPsK1mg/Uww
	3W/3Ddb4Y2RABSUIfZOTC36u6UdOzv9+IUhElmAE+iH/FMR81SjDdBuMZef4uAB7YzCogBD+Iu/
	yvdW92bfU2nvbzoWfYUUB/hBKzdwmmUdEjx5HDMu8y7XPjB0UtTi6IezfByS5oxKRcT9FYIsaTt
	IIz6bR2MG+buEkAltHDq4Q2Em3P7ZRV66Syie/ZgaOH4/HxfXA3JVxM2WFuHAmC03cNMsmg4lQS
	DFbiVSLXP263JMAtM/xrpIQqqQUXJHnZ/DDp23rPBzL4Nzoh2lcettXoKh4pWDSEggL61AfC7xY
X-Received: by 2002:a05:600c:8215:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-486fe8e4038mr59965135e9.11.1774025409171;
        Fri, 20 Mar 2026 09:50:09 -0700 (PDT)
Received: from Tunnel (2a01cb09b013a2c6b23e8799d065d8e3.ipv6.abo.wanadoo.fr. [2a01:cb09:b013:a2c6:b23e:8799:d065:d8e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe8359acsm72718915e9.12.2026.03.20.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:50:08 -0700 (PDT)
Date: Fri, 20 Mar 2026 17:50:05 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v2 bpf-next 5/6] selftests/bpf: Cover invariant violation
 cases from syzbot
Message-ID: <b82e9240f62200aae173a1c69c782f56ed7f8f21.1774025082.git.paul.chaignon@gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774025082.git.paul.chaignon@gmail.com>

This patch adds a selftest for the change in the previous patch. The
selftest is derived from a syzbot reproducer from [1] (among the 22
reproducers on that page, only 4 still reproduced on latest bpf tree,
all being small variants of the same invariant violation).

The test case failure without the previous patch is shown below.

  0: R1=ctx() R10=fp0
  0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
  1: (bf) r5 = r0                       ; R0=scalar(id=1) R5=scalar(id=1)
  2: (57) r5 &= -4                      ; R5=scalar(smax=0x7ffffffffffffffc,umax=0xfffffffffffffffc,smax32=0x7ffffffc,umax32=0xfffffffc,var_off=(0x0; 0xfffffffffffffffc))
  3: (bf) r7 = r0                       ; R0=scalar(id=1) R7=scalar(id=1)
  4: (57) r7 &= 1                       ; R7=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
  5: (07) r7 += -43                     ; R7=scalar(smin=smin32=-43,smax=smax32=-42,umin=0xffffffffffffffd5,umax=0xffffffffffffffd6,umin32=0xffffffd5,umax32=0xffffffd6,var_off=(0xffffffffffffffd4; 0x3))
  6: (5e) if w5 != w7 goto pc+1
  verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0xffffffd5, 0xffffffffffffffd4] s64=[0x80000000ffffffd5, 0x7fffffffffffffd4] u32=[0xffffffd5, 0xffffffd4] s32=[0xffffffd5, 0xffffffd4] var_off=(0xffffffd4, 0xffffffff00000000)

R5 and R7 are prepared such that their tnums intersection results in a
known constant but that constant isn't within R7's u32 bounds.
is_branch_taken isn't able to detect this case today, so the verifier
walks the impossible fallthrough branch. After regs_refine_cond_op and
reg_bounds_sync refine R5 on the assumption that the branch is taken,
the impossibility becomes apparent and results in an invariant violation
for R5: umin32 is greater than umax32.

The previous patch fixes this by using regs_refine_cond_op and
reg_bounds_sync in is_branch_taken to detect the impossible branch. The
fallthrough branch is therefore correctly detected as dead code.

Link: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5 [1]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 3724d5e5bcb3..818efa08404d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2070,4 +2070,28 @@ __naked void refinement_32bounds_not_overwriting_64bounds(void *ctx)
 	: __clobber_all);
 }
 
+/* Last jump can be detected as always taken because the intersection of R5 and
+ * R7 32bit tnums produces a constant that isn't within R7's s32 bounds.
+ */
+SEC("socket")
+__description("dead branch: tnums give impossible constant if equal")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void tnums_equal_impossible_constant(void *ctx)
+{
+	asm volatile("										\
+	call %[bpf_get_prandom_u32];								\
+	r5 = r0;										\
+	r5 &= 0xfffffffffffffffc;	/* var_off32=(0; 0xfffffffc) */				\
+	r7 = r0;										\
+	r7 &= 0x1;			/* var_off32=(0x0; 0x1) */				\
+	r7 += -43;			/* s32=[-43; -42] & var_off32=(0xffffffd4; 0x3) */	\
+	if w5 != w7 goto +1;		/* on fallthrough var_off32=-44, not in s32 */		\
+	r10 = 0;										\
+	exit;											\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

