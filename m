Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0923C1998
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772228196; cv=none; b=sXRFBfCLWPmkTUDy5/kLqvRtzjES+NaH+UP92uKuD2q33VFEz5q4tkDAp7FbeP83vfpM/hf10ezr47F71LuTvaswkJOhSP7klt1wWThbM9J2gQ7AznlrNaJ47DrzqjSIP7yiP0V1OELQYSmPu6IrQ0EK6fwAk/DvvTVdaSe+IuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772228196; c=relaxed/simple;
	bh=yDV1DpCBndSZJdu5OMOfGqeAiYVwT78by5xvlBmfZI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZImOYOR0hSt7RwV8SKJSfY9AReYsKm59/BInoVZ/EgPdD6md65DTR3fgELqjNOzM0ICMTFfAzdYLjJSFlFwLdz/nYS8PcXgKD0FZ/eotcfKIoYd0HYVe3CgACfhwUFjCu5pFoYtQcTrbhaUa9kPevhkgav4DrYQSs0ekzEtPo1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/hb98dm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/hb98dm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-436e8758b91so1643941f8f.0
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 13:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772228193; x=1772832993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JGpgl0DTfXyMLx0hKTF5yverrETlR8kzkIoCwidlaEc=;
        b=R/hb98dmUImar0aKxy+0v9AuFod9QpmjCmqdWiYe60xVydr/Mx1fKJTzlQiOaOvQG4
         bUnJnLKb/Vc4uIZnLuqeH5dgpiPP5hdN9SH8lOOngN/CHdL1W5XZWGx0U5N3gN+vg749
         mTe1iPcW6jQt2nSZkSCei+z8U7gO3okI1gkMwmoNrK5W7gx8pNoKfMX4/1PMDGLLhSrh
         IQVp75MyjI4yi9okjlkyxpmDGzKpI4APAIa2A6frIV3GzNakmID8y3EemMdtbx4Tk0wE
         kmyau4epGIV20ndEHi3Z0dBfoZ0lLQOjjkkZ9fhjVK6I01+5xDrB0ha5RUU/Ni8pD2TB
         7HtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772228193; x=1772832993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGpgl0DTfXyMLx0hKTF5yverrETlR8kzkIoCwidlaEc=;
        b=P4pDQZ8egy9qQCyXZKVN9BSTRBpmbwTezNzUP557pX6AGWbAF2c8zl1n3zjIuNbJLJ
         4V2VE9GC1B/jyH3cNKZ+kDVE8E6xaex5oN6loyCHovcOKctDZxcBeL7j4IzxqVw+itZE
         B57Xks81TzR54ch+1laX9ajWgJ0H2I+Mz+uzgTrJ3dCwB9E3H1q2K+T269Qre7u8CePT
         kqqRROdU/x+lxpAyvKPvoyyJN0GQWqd2Cm7wdPnPqelKrKjK4o77Ex2IfMs3NnvUhbZF
         spCPeZ3K5w08vE/nvWL2FYjb04OS1S32eYfVeXKcS+L0VwZ3XmP9/HIQ7PGOw8hy2XoT
         YppA==
X-Gm-Message-State: AOJu0Yy1b+y3ye6FHaSyRJNCMA9Kg9k6TD7HVQnOfQTWXGCmuteUyhnI
	yB8qXVTeYtadAVNZZwrHxBg4WXg6s4GyGoOpSzhbQqIYNCwkTuqIqvvDQcqy9zaSvW8=
X-Gm-Gg: ATEYQzzgSLH1vk+G45OFTNpZFTVcaoS9MQNeKSUWrDPgGubd+lAE3eXYg4boF8MeUO+
	ZwdM5AynRKjRwoinQ/LQaEHXa34W0Uip6efQnSyTnQgnzlFaGbyWr11VSUKFHSwc+uJ1FB8I9Zk
	MjaTLI06VzNqtAHOU3DRoLIqUamwcm9p32HkCBVFGJlB35nQhuCDJvQOr6NLTRfmEJ9MoXtshyW
	FOcxdHoZks3rtIDhbyim8hhCxN0sm086ObSOFU0R1rUTMFbHzeQxBfSi5sCBPmaeXkgn30giWW3
	cSfw1BgFLzwK0NndjugMQ2UG5dZXZB/nFYF+ziRgI1oJUEshXnJUPmgC9oO0pZj2GEqAXXjHOQ4
	IZoYaoTtXqYdoR9zQhjrEMXd0fGwr6ac3kxKBa/XRQA/xSWLbgjnOEEgdRXcdYsA6tONlpzHcCt
	Ke6aEj9uu0FfGdWonb00ei1TksGQ7KLgYu4xEl7pR8TPLUaDvtCUbFLFBSZgeVQnQr6+/aye0uc
	WV1LR+sF38kajZpJl1YnAn0pOdGgksDLcAZcEWOYctvDcdJPZgPFxEws7osFSxWIlWfoixuWqo2
	Z3ZXMM+kP70=
X-Received: by 2002:a05:6000:609:b0:439:8e84:883e with SMTP id ffacd0b85a97d-4399de31afbmr6902552f8f.46.1772228193260;
        Fri, 27 Feb 2026 13:36:33 -0800 (PST)
Received: from Tunnel (2a01cb06901b353b20ebf6654db8a566.ipv6.abo.wanadoo.fr. [2a01:cb06:901b:353b:20eb:f665:4db8:a566])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c70f50esm8992924f8f.13.2026.02.27.13.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 13:36:32 -0800 (PST)
Date: Fri, 27 Feb 2026 22:36:30 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v3 bpf 3/4] selftests/bpf: Test refinement of single-value
 tnum
Message-ID: <90d880c8cf587b9f7dc715d8961cd1b8111d01a8.1772225741.git.paul.chaignon@gmail.com>
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

This patch introduces selftests to cover the new bounds refinement
logic introduced in the previous patch. Without the previous patch,
the first two tests fail because of the invariant violation they
trigger. The last test fails because the R10 access is not detected as
dead code. In addition, all three tests fail because of R0 having a
non-constant value in the verifier logs.

In addition, the last two cases are covering the negative cases: when we
shouldn't refine the bounds because the u64 and tnum overlap in at least
two values.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 560531404bce..97065a26cf70 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1863,4 +1863,141 @@ l1_%=:	r0 = 1;				\
 	: __clobber_all);
 }
 
+/* This test covers the bounds deduction when the u64 range and the tnum
+ * overlap only at umax. After instruction 3, the ranges look as follows:
+ *
+ * 0    umin=0xe01     umax=0xf00                              U64_MAX
+ * |    [xxxxxxxxxxxxxx]                                       |
+ * |----------------------------|------------------------------|
+ * |   x               x                                       | tnum values
+ *
+ * The verifier can therefore deduce that the R0=0xf0=240.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum on umax")
+__msg("3: (15) if r0 == 0xe0 {{.*}} R0=240")
+__success __log_level(2)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void bounds_refinement_tnum_umax(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 |= 0xe0;			\
+	r0 &= 0xf0;			\
+	if r0 == 0xe0 goto +2;		\
+	if r0 == 0xf0 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test covers the bounds deduction when the u64 range and the tnum
+ * overlap only at umin. After instruction 3, the ranges look as follows:
+ *
+ * 0    umin=0xe00     umax=0xeff                              U64_MAX
+ * |    [xxxxxxxxxxxxxx]                                       |
+ * |----------------------------|------------------------------|
+ * |    x               x                                      | tnum values
+ *
+ * The verifier can therefore deduce that the R0=0xe0=224.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum on umin")
+__msg("3: (15) if r0 == 0xf0 {{.*}} R0=224")
+__success __log_level(2)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void bounds_refinement_tnum_umin(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 |= 0xe0;			\
+	r0 &= 0xf0;			\
+	if r0 == 0xf0 goto +2;		\
+	if r0 == 0xe0 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test covers the bounds deduction when the only possible tnum value is
+ * in the middle of the u64 range. After instruction 3, the ranges look as
+ * follows:
+ *
+ * 0    umin=0x7cf   umax=0x7df                                U64_MAX
+ * |    [xxxxxxxxxxxx]                                         |
+ * |----------------------------|------------------------------|
+ * |     x            x            x            x            x | tnum values
+ *       |            +--- 0x7e0
+ *       +--- 0x7d0
+ *
+ * Since the lower four bits are zero, the tnum and the u64 range only overlap
+ * in R0=0x7d0=2000. Instruction 5 is therefore dead code.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum in middle of range")
+__msg("3: (a5) if r0 < 0x7cf {{.*}} R0=2000")
+__success __log_level(2)
+__naked void bounds_refinement_tnum_middle(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	if r0 & 0x0f goto +4;		\
+	if r0 > 0x7df goto +3;		\
+	if r0 < 0x7cf goto +2;		\
+	if r0 == 0x7d0 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test cover the negative case for the tnum/u64 overlap. Since
+ * they contain the same two values (i.e., {0, 1}), we can't deduce
+ * anything more.
+ */
+SEC("socket")
+__description("bounds refinement: several overlaps between tnum and u64")
+__msg("2: (25) if r0 > 0x1 {{.*}} R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))")
+__failure __log_level(2)
+__naked void bounds_refinement_several_overlaps(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	if r0 < 0 goto +3;		\
+	if r0 > 1 goto +2;		\
+	if r0 == 1 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test cover the negative case for the tnum/u64 overlap. Since
+ * they overlap in the two values contained by the u64 range (i.e.,
+ * {0xf, 0x10}), we can't deduce anything more.
+ */
+SEC("socket")
+__description("bounds refinement: multiple overlaps between tnum and u64")
+__msg("2: (25) if r0 > 0x10 {{.*}} R0=scalar(smin=umin=smin32=umin32=15,smax=umax=smax32=umax32=16,var_off=(0x0; 0x1f))")
+__failure __log_level(2)
+__naked void bounds_refinement_multiple_overlaps(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	if r0 < 0xf goto +3;		\
+	if r0 > 0x10 goto +2;		\
+	if r0 == 0x10 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

