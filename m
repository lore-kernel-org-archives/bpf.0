Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E74AA598
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269625; cv=none; b=EgV1IwipaoDwudQ0osNdpDSaarNZf66floyj/F+w2O/9pA6JQsIx3GhfjKsR8VExNe7c7TdKgs8WERHeYymf8wtcpuf3ge69tjKyqDYw1W7TAfXQMvwZ7Thx1uPh8AuvhhXREcAb1lcDTJxCOfFEclK9r3O4ugYED+VHBSKyA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269625; c=relaxed/simple;
	bh=Rp1zIEKY15NhAB21KokUfykU/0SbuH/XJNjwAx2TvFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCZiI/xhp6xfYWrwU+/CAv+yJTYQLmJDThkKyDeWHaUhhsyC5Hi8c+Sup8zxfTqR/H1/eWYX0lN8TsreRzv8bAzIp/1NwI7AezU5EIW3gIvlB8V5dMmDU182A35UnV5+AZ712q2TVRMieplaRxqwGHPb5U5MrLaansGjjM1ig9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5nXyRQp; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5nXyRQp"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so136525e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269621; x=1790874421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=In3iLsNezSimcVM3glIR2ujd/ZgqiV3goBGVv+fKqkY=;
        b=n5nXyRQp5PCSf+Pvy3XCRhHEzvspbGbwsgTA/qzDdO+cXFwjj+ws+AjE3ldk4b3pnD
         065KotUwaF+IC1aBupB8zs4lJhvplDNmJ+vzMXC6b/JeJV/8uFuOvuETcUNdfSyu3Ucb
         hWnJIrubgdyxrHghoLAupcaTSsp4IZa5XiikVecwKhmKU+clkiWJ0/ECK24AsJlpoGbl
         QtKPo8wYdnU0r+Vx3ze4mTOzT9nVGn1yllpM+GLCOgNb0eqO8ISMbgHbqmo5ZFvmhsFV
         qc/3EcZgFF+Owg3qOF7LDtyZygbyjNmp9Ri2AdDzWXGij3ePjy4wpJEvF+pjjJUGG4Yg
         4YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269621; x=1790874421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=In3iLsNezSimcVM3glIR2ujd/ZgqiV3goBGVv+fKqkY=;
        b=IBrChH8LT60DTvNtQTgPJt31XRG5+b35CJ24mmnesTFg8lb1TbLBguK3PCY2wrrM1Q
         B1mbzpOeaLBZFfwV8bkXOp2COCs3tE5EvNcJcb4ej1S933l7br3WP1PXBgujO/ZbJHII
         Usr7KZVRHmbK+4MIETYKSyRDZy1ZnlzHta5PEuGAxLOhb/mdudxA/MhF7GqQ2qUmTHaJ
         c3hTlINy6+W+FWThAlMpe0xC1lZNm6Aea/sPO6GenjNOkL9xla1p2x583yfF/zNXrBnt
         AFzsQluIdLASaGD+IynxzG9tFFnSASJb23W4RQOTwKaVK2Z6ilt6jwyAiVntFRXcS2zE
         anxA==
X-Gm-Message-State: AFuF++nQTib80zAxS4r/lcbj6sXQX1A76053rI+JuvTFy/IYKRiyV9+d
	U1frya0XGVgQdBuknaaAF19jTjJFU3T/J5k3unIujQk5pWmJvb5wte1rU2NUQZpY
X-Gm-Gg: AYBFou0XLVsw0+hkWijtcY6eY/E35dz6etvyWgo/HFaBV3Y5fFHnkR44HhdBRm9BTpE
	DX4d6OhVAyMhL8fXm75hxVFyuOrc8z0q1SelR1NiPBcIwayf1vAxVIh9R1h2Es8N6MNL0RBjemF
	vTp91utTnCKWI8I7Ce8oXbv1wIo2uInppxzn+rQm2BlKp9dadmjenylUIWP1sJC6hxjgVS5g7eS
	oRIoDIklrTKecnMZ2XydvIqno0zCJstxmuYl2Ld8ZosLKGogDn38gyoJnW45N4TrLCBbhZSGfvQ
	iXLWaXjygbwThqhnpLZiKOJDGipTsr+PSu1+QjV/43VFdLxaga3tB/zfCBdQsnWhuWFp/f5QcNa
	3z68GQczwfPli6RC6pMqw/EvFhvA11+YEiky3KYVj1htuI4EDml8ex0Ij2OZFz9OECLzQ/79G0W
	uSSnzvBDGcKmU3eV14fHIvy/Qv1zYxDsFfS2PjoTsszLFllI18d7Vkuvh79+Cqgc9m19mXdL7qV
	Tgi1HzZDEkIOEfpfo2CcwTKCTx3M+blj+WSi82GAMRxTxWoQPIFzgNSwgU5zyAN4V4RjwJdYk3w
	HDEDtgZpciQcSqcKj9F6fLxu5k95P5hBaPCHaw==
X-Received: by 2002:a05:600c:3b98:b0:49f:ce78:3564 with SMTP id 5b1f17b1804b1-49fe66f187cmr56885795e9.21.1790269621238;
        Thu, 24 Sep 2026 10:07:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee6ca26fsm3954675e9.0.2026.09.24.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:07:00 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: Test Program Structure diagnostic context
Date: Thu, 24 Sep 2026 19:06:41 +0200
Message-ID: <20260924170646.2366016-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924170646.2366016-1-memxor@gmail.com>
References: <20260924170646.2366016-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2842; i=memxor@gmail.com; h=from:subject; bh=Rp1zIEKY15NhAB21KokUfykU/0SbuH/XJNjwAx2TvFg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtrRGl+S6CYkEf25ajPEj4ifjnLdy597LW8lmXvmwCPF 4qbRHQ7SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJEJkxgZbsoHuy347L14xaf1 c/app9V49Wpsk1TPnpC8pXzKxJmKrIwMfZmJRbqV8y/WX/m8qibcT7j52BH5FXtWVITwqz/h38X PBgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise each corrected Program Structure report. Place a
missing-table gotox after another instruction so its attribution
differs from the subprogram start.

Add malformed subprogram layouts for a branch crossing a subprogram
boundary and a subprogram that falls through its end. Both cases carry
BTF line records and assert that their structured reports include the
corresponding source function and file.

Link: https://lore.kernel.org/bpf/cf2f420c2b21de440a7dc51b1565c0f06d4b539640ee5c03384e5d77bcfb5686@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_cfg.c        | 40 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_gotox.c      |  2 +
 2 files changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/testing/selftests/bpf/progs/verifier_cfg.c
index 3c3bb03e8217..a8396d4fd5f3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -56,6 +56,46 @@ __naked void out_of_range_jump2(void)
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
 __description("invalid DW LDSX instruction in diagnostics")
 __failure __msg("BUG_ldx_99")
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 0e27c2c79c57..e3d3e45b6c31 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -101,9 +101,11 @@ __naked void jump_table_terminal_gotox_subprog(void)
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
-- 
2.53.0

