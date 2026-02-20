Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51008349B0A
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771595882; cv=none; b=lTOq6B2KRyEyxT02b4hMvdP6ROnO4DrXGCs3dOM0KfSyZYTsfPGLIUXRLFbuZo5FYTkjIhWZJY+Tb+dOreaSdRg3WtV45nx3uD6/r1Z/JaeluAK3w0BeWO28Bv3VTXzKzB6tWrxrWbzNlWR2dBr/7dIcAboYgiGkrPMN9UWmWvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771595882; c=relaxed/simple;
	bh=yNUCXZxrqmvRqfHc8zHB5J/ar78BnBHpKtDhvgPNuMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5Dyuj5S7xGHGUd0ozIDU7wp0WO8Mqlcb+lURyKpEOwudUPKU8DjyYAG1rIz77UFKO9iPeCaWAp78LUxgZ52NSjLFtES1iB12QrfgmyWgc4ukgbuUUgl6XkWB8QCYSTmmuN2Gok4P+JLzDnlKTQdB1wXCCv/OBJ+9IoyQgFnbF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D95IVPlc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D95IVPlc"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4362d4050c1so2067035f8f.2
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 05:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771595879; x=1772200679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7QUlYTW0zbqfDHbbMICRhjgVwChXwtfr/18sCwTvFI=;
        b=D95IVPlckp8obdWl4xrAwXSG6eYvKYXR9CmkttMSx1lrvdFl96yQYpAQqeER/nPqBk
         C9rpDvUQl7wnx1VanPVKeDkNJZhFM8IV5so6PP5gXsMDxwohhWniAGCLBwC4L1W06h8x
         PktlcI+2IQTadx/Tm/MCv8UsvAac5Yw2i4mij32lv82h72oHumHZOD1rXGPEz1llPLEW
         XuZ+jmX0GfaVfeS+PV553ZbpxxmqGhW+FdG6X5TkUSjFLGrhfEGooKDeihNaGOQZ/8g+
         2cMq6CuJdKIrEFh1bjqiIlBJ+o0yUe1nyaZnfzFOLjP/SmPm89dU904UxA8wyCFu4ull
         oGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771595879; x=1772200679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7QUlYTW0zbqfDHbbMICRhjgVwChXwtfr/18sCwTvFI=;
        b=ACsn8NchY0x85Bar7X2fMgSULxFoBau4zu1zZ/aGYAz09D10JlfIMIsJi4N5z69JqI
         52Icm51aGYgZPIcC5mufdw21WVEB/deCFxBne8+syocTqixMnWnCYVqyTqqq3RWHcIS+
         FQmbefTq22+LDH/e6tifes6+9i9KDqpMLhwihqlvmeO2LUe//+0QJiMn8ZAEx144blFA
         eG+FnuLeOiWhx/4OMg9y1N9zmuaRN0peIH78sUu25v3mdf5GZsRgqvucROQikLREjPr1
         cNHS2jxtUffazlTIkaclQhQSteP0xbTNSFwMs0465fxD6rhfA+M5KsuKZ4ZmJNQmejqW
         2iNQ==
X-Gm-Message-State: AOJu0YxaDH3YO9PfDyc/D33aZ6ol7Pq9jXqrayVQZdad82yCaoxfdliA
	YxP0g+KbUbF6bp8dzRkYLExkpwGhxMz/1sH1EQyAKYBePIvn+cMNF+JdiuB/VA==
X-Gm-Gg: AZuq6aJ8KgF0A8e/+qJEVi/jL3HfvjntUlnNzU+pvNDoAYU0nDgZiK6YyiNQGQn9S8a
	9kpgKPPBjq92H4J6ytPzewvXxDQVsMU58Trzob9lX7DwT6OrERpAsbwCPfOU2PsV9/2fk36tYpf
	QGZqpGLE/vQZjRhp7/ko5CaSBsW6s1THWMQ7OaX2oZEBb6WQ9eat4uvUWNv97ursn65hG2lV4VG
	dila/J02g990uKjmQrwntzDkTlMmh1JOSSMbWSbhI8Xb0DuzcluB6S+pH64nb6XGU/kJQpJXvP6
	yuZf6cglMG8GtQXHIiUE1kwrFEAFBSUfw/uvhyBC/ZzIkQPbSP2rZIcQlDKAmqxGypeEIci5e3s
	TYK177D8pmU+8Dox8zlIm/89lbKzqmwU9OTxggAjAfA9bahTnJgjMTw0xRzX08JB4n3rS1kkrs7
	zn9tq4PTZnKvz+RHA2bv5EKSNYlFFrPDAVbFx+FpO/kFzUAGzeoiBHu8luMcm0e4TTDHz+1ndzW
	jefYNoCtM4db5blfuAL6mcmLILjEvmBFN/7d852ByCYWU4ro4+xY5LtjpJsEFlrjZoo2KkTvKE=
X-Received: by 2002:a05:6000:22c3:b0:437:75c1:5793 with SMTP id ffacd0b85a97d-4396b02f160mr3639998f8f.3.1771595879170;
        Fri, 20 Feb 2026 05:57:59 -0800 (PST)
Received: from Tunnel (2a01cb09b01c9b546fd5ffb86f392ee0.ipv6.abo.wanadoo.fr. [2a01:cb09:b01c:9b54:6fd5:ffb8:6f39:2ee0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad0166sm56807092f8f.35.2026.02.20.05.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 05:57:57 -0800 (PST)
Date: Fri, 20 Feb 2026 14:57:54 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v2 bpf 3/4] selftests/bpf: Test refinement of single-value
 tnum
Message-ID: <1bd78db44bef27d9d7fb549ed3eb8811ee2a5e5e.1771594636.git.paul.chaignon@gmail.com>
References: <cover.1771594636.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771594636.git.paul.chaignon@gmail.com>

This patch introduces selftests to cover the new bounds refinement
logic introduced in the previous patch. Without the previous patch,
the first two tests fail because of the invariant violation they
trigger. The last test fails because the R10 access is not detected as
dead code. In addition, all tests fail because of R0 having a
non-constant value in the verifier logs.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 560531404bce..41dd249faadd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1863,4 +1863,95 @@ l1_%=:	r0 = 1;				\
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
+ * The verifier can therefore deduce that the R0=0xf00=3840.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum on umax")
+__msg("3: (15) if r0 == 0xe00 {{.*}} R0=3840")
+__success __log_level(2)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void bounds_refinement_tnum_umax(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 |= 0xe00;			\
+	r0 &= 0xf00;			\
+	if r0 == 0xe00 goto +2;		\
+	if r0 == 0xf00 goto +1;		\
+	r0 = 0;				\
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
+ * The verifier can therefore deduce that the R0=0xe00=3584.
+ */
+SEC("socket")
+__description("bounds refinement with single-value tnum on umin")
+__msg("3: (15) if r0 == 0xf00 {{.*}} R0=3584")
+__success __log_level(2)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void bounds_refinement_tnum_umin(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 |= 0xe00;			\
+	r0 &= 0xf00;			\
+	if r0 == 0xf00 goto +2;		\
+	if r0 == 0xe00 goto +1;		\
+	r0 = 0;				\
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
+ * 0    umin=0x7cf     umax=0x7df                              U64_MAX
+ * |    [xxxxxxxxxxxxxx]                                       |
+ * |----------------------------|------------------------------|
+ * |      x            x            x            x            x| tnum values
+ *
+ * The verifier can therefore deduce that the R0=0x7d0=2000. Instruction 5 is
+ * therefore dead code.
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
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

