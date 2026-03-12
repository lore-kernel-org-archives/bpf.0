Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74C03C062B
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314818; cv=none; b=HIL9javLeQMNkWDVh/Rk+n764fws6gienrs0caLURASjhS7o6Rbbo2bOuiwutdydKhACaqR/1CCiG+uCLKy3DmA71KbI+q0ZWWDSoh4XbGjEJYGguh110698OIWSnxZHgEZQ9FrG+c1iWh/rzCXdEB9cjGktg3r4hHcj+BU6AGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314818; c=relaxed/simple;
	bh=eEGCNciotS7iEBBHufK4139f3quoGr+WQxIYOQa1CdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b947W/yZ0VO1n88kDm5Xgrywu6kH6vS2IZMAIBftppR//evvvwaNi4/Zog+IP9h3/ITjNBB1S8QMfgIMV/RgO9Ein5NvAOB213WkusQqKfWJQjjQ/19LEWvYgxqu+iUqNard1KP2LxgQnaa/InetDBeIqL5qdwLQztXfSc5Zu3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loeYGvCH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loeYGvCH"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a17791284so379223a91.2
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773314817; x=1773919617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEM/LvSnA1bThQs7eRFG3MhoNO4xKYnG7/K9LoZwNsc=;
        b=loeYGvCHNc+pfj4lSQWvI/DCH4saaT8O+M8XHGi0MnevImun5R1KU1ub/qSRDFQhqV
         9SEEZJcPx8aAjCll1TfB+nQvbSwXggbUYwv6tM9ziZWTILEUOQQr0o6laaTWprrMNg13
         hcZ+cw1KdWB3wxxQv2yDQR5j89dUmch9ijg1jx9Hh290O4egN8SlGokP2u7JznvfGkE9
         qP+5wQoZcj6CPxhb98t6dUwixVEjgD5onWL2pVRCLn/hNWYNsqz4W8aK9u5P+fp9jIqs
         qDmq+/L3Ch/PnjBG2he9xbHkgpB904sM9VvPxxzlaO7pq8zInrOdAUS5gGamParOceLP
         rELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773314817; x=1773919617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xEM/LvSnA1bThQs7eRFG3MhoNO4xKYnG7/K9LoZwNsc=;
        b=W+6CYjFf7AE+TW8ublbJ7Jq+QPn+T0wNlR6U4sEJBhbPQerxNHOpMJIZdhwwccVAMB
         LEY2oBW2ol8c40HPAoNeBsUsOF3yEL1lwojJBvrj9l/8YfcGmRP+hMM/8M+5NhIOLg7I
         FXVMWscsk6mO/uSyQUV68eDBlqtXOe8CeDCa8DgJ8/b/bBxjwiu09LaoA6MuqueIdo7Y
         6qBPZA03iwv0FjwX8oh9YsMlw+Q/v9nxz/IqKQcAv16HrfdWLYR5ViT/vlfojrwcvDDX
         4kagQ9VlCnowixlc8weqEUoEwR1mKShxFrPCzUWqdaZsuzm0LZ0ngA+hvI7xbKqVi8bz
         hvvQ==
X-Gm-Message-State: AOJu0Yxmq7O+ekGbaOFWPDJq55VIENdmBZtkR2l+7+LYoGQQ7QXcAZi3
	yh9hm+St/JECTbccj6niiV8sCljbuKzeQ3UhIy92k8RMFmFsmLuMyIxDwubWwfiojt0=
X-Gm-Gg: ATEYQzzj8JPIkozv1apBU2+CLBrO/2zrpAnkDuHWfkWkjEQ3FIxczYnpBI9UYjZ1Jdf
	DpExkWOeDosMWnuIvA/7AHk3Lr5wrw1RpGATHg3V/Ey66SKUZdDHX6Nmx8+GyRZdsA3sv0QSHum
	QFKgSoRK6qlJ5HR81p3wqFTYP/B7QQeoJVxTgDnBVlBGrR2r7mCxh2xoV3b98OqtuA80wYavdlr
	pJGu8NXx0NFOqlYOTBKS50LvjzomqXPJ5v5odPm8sdiw7Y7Jh6eQJcm0IY+9EQNivsxMUosqSFR
	pf1bfgx5nuOwhwaH8ZqtZCsE+N/ndxY7VlkRcZzgqJw1QMaDMlK8qRLX7W3bvNLblvrAvsUzg0b
	2SpB14Ox0/IyjoEi/ieLifNJCkact7vmq1XPGmPMHck4hfLkLYaBjgxoSgGmtw44IVMNAC+fKos
	67GLqgfgb38uwsltoXB/f/W4sNwjxuANNvGCzFSevAjOMvgbDBYChHvPq+57/nN41PbB++iy3CL
	W3Tg9NXeg==
X-Received: by 2002:a17:90b:3d0f:b0:359:b7a5:21a8 with SMTP id 98e67ed59e1d1-35a011d3905mr5393630a91.5.1773314816780;
        Thu, 12 Mar 2026 04:26:56 -0700 (PDT)
Received: from kali-VMware-Virtual-Platform.. ([185.218.127.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a03005f7fsm5220579a91.15.2026.03.12.04.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 04:26:56 -0700 (PDT)
From: Daniel Wade <danjwade95@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	Daniel Wade <danjwade95@gmail.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add tests for maybe_fork_scalars() OR vs AND handling
Date: Thu, 12 Mar 2026 22:26:43 +1100
Message-ID: <20260312112643.22659-3-danjwade95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312112643.22659-1-danjwade95@gmail.com>
References: <20260312112643.22659-1-danjwade95@gmail.com>
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

These tests exercise the fix in the previous patch, which makes the
pushed path re-execute the ALU instruction so it computes the correct
result for BPF_OR.

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

