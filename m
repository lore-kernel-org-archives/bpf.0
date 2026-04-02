Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AB207DF7
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142706; cv=none; b=O+Tl9UJ/wDV24FCJCeKuyguBFPoOxsxSml49wDzJMvdbVjXKyOB1hdVNUIDpe3idKrZ6GWcZtbjeZ3sPqv8jYtfGk+LBzvpe87dshzBlySrGQv5haIbNXPJbEifj4OuRANRmY6OkV/nHwYDn3X5XvAPY0MnLwci/0iOkbY3gjwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142706; c=relaxed/simple;
	bh=eQ527pa5Gf6xhWT00243J8aBXfQnKua5lRHRhxlTSZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVJcE3KtBI7uV0WwpG71Jx3HMu91tALF4HH2Y/1EzFWt//3Il7difgTFHo6uqxVF7IMPNKAOU/Vh95i4EPIfQjsRaIBDJ0NVGphDkFjdptnFoyThbbccbwRY+45SHUNWPBVA+R6pxjnxc6QpI0w2VzKBKcL7iVjz6HVanjhlIiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdAPM+uf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdAPM+uf"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so926544f8f.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775142703; x=1775747503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHRdOI3jqi5EojZ9y4ApTX6mB08PIavvNU0QiW2mfMg=;
        b=AdAPM+ufLB1xEXoainS2B1ERkvaAEJ6BzZT+WY4AjbTgWcCvumWVmGELRnn6MwBg/c
         xdzvsgxAyXF+3bSqA45ECVRXNlYC/qxEOQOudxhT1DTD06kIqx7Hd3wJP0r2OUyNsi5I
         Dyx7QNsBc7VNsxeydf5rZYVIGiJimbLxAAGn14jwbyrorGEiVoiFwWIbUYwDC1BfFsrJ
         cDagVExI49Xb9+H3616hOF+3hRzxPwaW8rA3iyhOFuu7n4tJ75/SSmVvMf6jvCFBqbXB
         fwSYnt+Nzvj5U1GYJ2zNiGv8T3SjmjKvy9Vplryu1ssMGUeiZDrZgtJ8yMwUjJUtAaww
         cKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142703; x=1775747503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHRdOI3jqi5EojZ9y4ApTX6mB08PIavvNU0QiW2mfMg=;
        b=KvJXooXIZ2isAJ9XvibgI+LZqhboev+nN/bN5wt8zAp+saPwfq/dj+y8btoDK8N4pZ
         wSrad/e2C/0j4/5zQe52Qy+FLIgRqhYuzX/x2K3fjGiIh4oGmveccfGdWakfVVrzkWwM
         Rw/3+fQYRzofpUIstQgvfhfR5ywlQgd7hl91MgmYUernZjGWH9EVTLPLtEMsmiAFGjJS
         4UdzT2AESjgpNl4IaJwt6q1c/Zxe/d3iULaUw47QkP8ywD6XezodLy09fga6mKfb435f
         w44kdqQzRe4SRCKVmwDaFAU6jKt1JaLNKr3aeh/VwRbopt6TO+LN9C7Y6eEf67wcWbxD
         c0ig==
X-Gm-Message-State: AOJu0YyZ0WO/HPOsOiXPdLbelwBSRd6/TwdxUPaRCFBiJjD793WbOt0p
	km8ng83tqrbHJ0y9azqTtYP+BwUKtdvNRvf19sQx2Gne8fqY+zLcvQNlwLUB71yt
X-Gm-Gg: AeBDieuYMIu5Hrm7HGBKr5F/jJ8pzqgtWxYjBqRlYP6DECCssbuNY5Sq3PFSQIPKMZV
	eRgV4YaEb30SOIsHA0E7fDdJr3EEcy0Kv7yFOG/0l7AJ6Ojgvl0zTPf+NgPP83bwScn5Elqoc03
	sMaAtIjAS7UNLGuDR6RTqpEdMMg97UCrORehbDOUHtUCTdg2zOJsvXt8LVYekeqM1xwWxJPY/qe
	ZILVPRmN4xqvpaBrm727Hb1ASo/Om6pPgKMmFTQ3MQsOaDi4Jmn6NmwzGbL8hTpFZYaSKL1fteV
	2wUrgOgbGss8WI2A8GP3s25FtO/ZtYzJ3oyR+r7W6rIPanWf7ZkYCSDkAoQJju8ysg/dU71gP+y
	tqEC93N2q1n7V+cKAg8W4z7rOuQ+JAk47lzvRuM6JPg/nUL8CNHalT7vcjtGQ1jkzyjQmSU7lco
	27DYvWZ7s1R4vhElHFdW+cTZX7xppTSMmavDljOq9eiIKfpI7zgm0ikLAbDg5ZchL0g9YSkw+oP
	8pxKhY/71T7NVJjpejTN9TxrOuQFAQ6B2qkX8J5wNn9WxXZmlCe8B1u5TCLvj530Af1F0Lilhl0
	Ml/Nol/x8VaqM7Je3wp0QsVx5fgHPEkksEAr36KNNXM=
X-Received: by 2002:a05:6000:178d:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-43d15055ec5mr14251138f8f.14.1775142703336;
        Thu, 02 Apr 2026 08:11:43 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00981c6411e4c4d8e7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:981c:6411:e4c4:d8e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm7740686f8f.9.2026.04.02.08.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:11:42 -0700 (PDT)
Date: Thu, 2 Apr 2026 17:11:41 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf-next v3 5/6] selftests/bpf: Cover invariant violation
 case from syzbot
Message-ID: <b1e22233a3206ead522f02eda27b9c5c991a0de9.1775142354.git.paul.chaignon@gmail.com>
References: <cover.1775142354.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775142354.git.paul.chaignon@gmail.com>

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
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index bb20f0f06f05..df7c62a12318 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2165,4 +2165,33 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+/*
+ * Last jump can be detected as always taken because the intersection of R5 and
+ * R7 32bit tnums produces a constant that isn't within R7's s32 bounds.
+ */
+SEC("socket")
+__description("dead branch: tnums give impossible constant if equal")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void tnums_equal_impossible_constant(void *ctx)
+{
+	asm volatile("						\
+	call %[bpf_get_prandom_u32];				\
+	r5 = r0;						\
+	/* Set r5's var_off32 to (0; 0xfffffffc) */		\
+	r5 &= 0xfffffffffffffffc;				\
+	r7 = r0;						\
+	/* Set r7's var_off32 to (0x0; 0x1) */			\
+	r7 &= 0x1;						\
+	/* Now, s32=[-43; -42], var_off32=(0xffffffd4; 0x3) */	\
+	r7 += -43;						\
+	/* On fallthrough, var_off32=-44, not in s32 */		\
+	if w5 != w7 goto +1;					\
+	r10 = 0;						\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

