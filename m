Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088EB3C3F67
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845489; cv=none; b=KvXdJt3LnE43ZHafYXSBn7qde7vh0O3eNX41ndnHkRYEdc5dSnVTnfh3SYb5cYl6A6YLPgBr4SRjNDQpcXidgsLHl7QNHLdDvwizp4CgbV3eCnMy1/Iel88tziGaOiMpb9UZ8v5KPqN/8xClQHHrZenLQDk+329X/VwMYGNQfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845489; c=relaxed/simple;
	bh=NIPG0q64bfQvcd2+PimroMsQ37BPfbkdJShZGCOV4kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToqPR3xx1+CN6VlPzjpBLc8wKCnpPBBuiLzlYcLZxDc4mKREqoCiPfIoG+b27wT9MDW4klBkLVOfmHhr6YDTCFj42Taft4plh3yTymLcfPL9ZCi0vaQOACMWu77YQgbzQzGXiMOuRUEfaD0310TXb4FBwjRtl2S+YtbII1Suafs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4K2hyYQ; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4K2hyYQ"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fad256d40so881045f8f.0
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845484; x=1787450284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nyv2eEgZcgnnTjfVn1LG6DEqnbOLUhLoF4zxBmTnbcs=;
        b=B4K2hyYQAmY/JH/XNKJ6+CTtDv2HHr+VA0rg3zeDJwM9C++3zvYYydX8zWwKPgbumj
         h8j+dyMJu+6SHdlvupL2E1HlSpTuaLPFeuGAFMI2YI3UCHfr0aaeDmvTIqrtq+sE/ZIz
         IWLoQsj8UcoFsVFOWbCPqUBEPVmyaomNaECUj14GdUpbDGtH7F+zAfMMZ+XhD8GUfIMl
         41nr6eVDlP9DADKc16weVpRd3D6wbK8Qn2OF5lcTIs6fIg8joxiEiX5HWpEMZe/HrbDN
         mL2DA88JqAoADkW1Lhj5S6fM2rtCXbGAptsmHtUOTNTaYJ0+1NA5V7Ym82owTtpDy8E3
         olzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845484; x=1787450284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nyv2eEgZcgnnTjfVn1LG6DEqnbOLUhLoF4zxBmTnbcs=;
        b=cbhXataGyECR5RgIz4RE4bTyQOhdQTPg8LLHppLXY9N73mN0wmxQ2Nrh413A6m1Zrz
         NEVJ6uV7AfuujrLj016mSEe+qdrUXoOOmLR2LZbPA4RqzVxWFtDuzpggh7JgR77vsYzM
         ujYyJknFj0GlceCp09Jgc0kOsmi7uwTuKrh7mXL7+ufDcrHXqRgt1GLAgFKkK1XVBcvl
         8UStfDK+oNqs8uQElotNs/dX1xMeOcur5d4SPLbapDXy6JlKUwxr49VosI0zS1nnmz0H
         NHGeijemcOnYsV8DdRjryYU7JgRsPPNaBLJZg0+3Sqid1c0S1yvbdSsumf3j7hj+aIUH
         OvNw==
X-Gm-Message-State: AOJu0YwjgJajy453GyEvEgMK+H/0RMC1nvlDSSphJVokV2TSh894e2Tw
	LU1TT2PmqzMnoFFHvy+GE+MAPxGCaY11JZmuTDkMH9MdtdiJK3jcKyAuson8BaCL
X-Gm-Gg: AR+sD116esTKToIzNL3XSNnqo1eVsLsCIgDj2KDbCrndzOv44NxeO5QmN4uqRDVwV2V
	aOTqpWAxkHM+cHX0FsSqPuJQOUh6+b6qApkrhaRu55XEuLxjDn8SuvxEeEKZXb/4HgHskRNr50X
	33EfnJ4IAg8jv3yuUhSThuB9qvtVkKYGyTMG3/mUHVvD+CkLAAOuri3bm4cyj+JOyRekkFpsrFV
	gKtzPtuiPE/x7WqlsNLpwHbXhjs4JMLhnqhj4xbLB/Z2nIKeNxkRxfHMxabu66q8UlIpKZgnZTp
	Zj2Cstu0Q2fE7q0gih6gkqIz7Z4xk6lOfYo2HMQ9EjBk8CxvMOfmpdmNJp2mDAhdXaAriB5BMVU
	FmU2+DbidGTRLUqsRbQG9j8Wb21KGYpwYMPukstmNN68iPEQxKpGouVFkj5k7HVwdCibUhuYXTV
	uZCvdwTd43NCDE6vZi2oSXAzNgrsKvjDQj+/DLlVjXjfrJnLzMdnZIpXlZUuvPHBwB4Gva8WN+F
	gwgqr1ctRMFvjfamycB62kU8oK1/52aHF1NfUs3YkTS98R3GXZxDjMn7hplpXJ454zEqyNddt3A
	9dqsghH5fnSftaYvNBlfkRomOLQ=
X-Received: by 2002:a5d:5e85:0:b0:47f:91eb:342 with SMTP id ffacd0b85a97d-4816071addfmr23528576f8f.13.1786845484297;
        Sat, 15 Aug 2026 18:58:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2cdc9fsm21062360f8f.37.2026.08.15.18.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:58:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 12/14] selftests/bpf: Test Program Structure diagnostic context
Date: Sun, 16 Aug 2026 03:57:40 +0200
Message-ID: <20260816015746.2632990-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3527; i=memxor@gmail.com; h=from:subject; bh=NIPG0q64bfQvcd2+PimroMsQ37BPfbkdJShZGCOV4kg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQuLQVdlNqer/RISbzqrVc7wLr6jnXfy06oyNWFjgy poUR+2OUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATEQpnOGfjmP7Ih+Xh/EVW2e9 eP9eJnh/kc0J/gf13xcs699+2+HpSYZ/Cr9Za5a/X7oo/Pwz5cBK7vma9/8HMke+ZG7ZzxDH9MW PBwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise each corrected Program Structure report. Place a missing-table gotox
after another instruction so its attribution differs from the subprogram
start, and assert that the recursive-call reason names both ends of the edge.

Add malformed subprogram layouts for a branch crossing a subprogram boundary
and a subprogram that falls through its end. Both cases carry BTF line records
and assert that their structured reports include the corresponding source
function and file.

Link: https://lore.kernel.org/bpf/cf2f420c2b21de440a7dc51b1565c0f06d4b539640ee5c03384e5d77bcfb5686@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_cfg.c        | 40 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_gotox.c      |  2 +
 .../selftests/bpf/progs/verifier_loops1.c     |  1 +
 3 files changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/testing/selftests/bpf/progs/verifier_cfg.c
index c1f55e1d80a4..4416d915cdf3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -55,6 +55,46 @@ __naked void out_of_range_jump2(void)
 "	::: __clobber_all);
 }
 
+static __naked __noinline __used int cross_subprog_target(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("jump across subprogram boundary")
+__failure __msg("jump out of range from insn 1")
+__msg("jump_across_subprog_boundary @ verifier_cfg.c")
+__naked void jump_across_subprog_boundary(void)
+{
+	asm volatile ("					\
+	call cross_subprog_target;			\
+	goto +1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+static __naked __noinline __used int fallthrough_subprog(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("subprogram fallthrough")
+__failure __msg("last insn is not an exit or jmp")
+__msg("fallthrough_subprog @ verifier_cfg.c")
+__naked void subprog_fallthrough(void)
+{
+	asm volatile ("					\
+	call fallthrough_subprog;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
 SEC("socket")
 __description("loop (back-edge)")
 __failure __msg("unreachable insn 1")
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 5b18c9a27717..a835a4871021 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -53,9 +53,11 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __fa
  */
 SEC("socket")
 __failure __msg("no jump tables found for subprog starting at 0")
+__msg(">>> 1 | (0d) gotox r0")
 __naked void jump_table_no_jump_table(void)
 {
 	asm volatile ("						\
+	r0 = 0;							\
 	.8byte %[gotox_r0];					\
 	r0 = 1;							\
 	exit;							\
diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
index d248ce877f14..d1ec19b7f66b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -139,6 +139,7 @@ SEC("tracepoint")
 __description("bounded recursion")
 __failure
 __msg("recursive call from")
+__msg("The call from bounded_recursion__1() to bounded_recursion__1() would make")
 __naked void bounded_recursion(void)
 {
 	asm volatile ("					\
-- 
2.53.0

