Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33148393DD9
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774649196; cv=none; b=XqVgXV4pTIPdJ4CuB3bO42eE6QrM6SxulDLeubzXWrxO8dYTu4cROzdf7eRTVmE03NKXix7sP5nIl1VVvTcI8Z0RCB9CKdNfxNYWPvML4dnXigZAyZ7p9aOgC6XQ7ZSxo+NqbFRAw/Zq4a+AM3lY1yYdoeDkumU+56miqguTcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774649196; c=relaxed/simple;
	bh=gEE1CjXR0TRZRdMZf+XjGUzs0f9SWb16JmhkPLTkD7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QPePNDGmGQeIjGcDP4bFRd9UnrLh09AWRWNf3xeuBbd56d8PSiZ/b8UO1wwH2pm5Gitqw3Fwxiwnx3bR2/Bkf4eKgmmzCbBszcBA5/iNP9IZb0vOAYeuBKo98+wPqAp5NlL4Xo0arh4+x8R4KER3d21xQ0tCWskQgn9U7Tju/kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=e7/WMkr8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="e7/WMkr8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=5vmzevZHkuRrjnC2YXofisHUWyZMpn1++JJi5mgur+M=; b=e7/WMkr8lt+ckxEMzPGOY6b5LA
	Qm8e9sCd5pk1qqwXfUIXO/sQYu2N/FbVD84zq1TkfZOHoDC2/tUMeihZ1F7AuQMpZJYm+zDSK5JUB
	hleHuFs++87VZmc9popk2UVEq731f15jYv0S/DaLNoBKgNsGoTNPbWafJDXAwifq4ctL/V3u+kmZ5
	hirh2ReYNEZmlAZZ2Ej28Vp1rWZ5o9RCNtf3u/PzMIsCWX7FMAkVAVLO0mvoSAcdTqA36xiNEExU4
	WcoO/ZBKfYDJmDgJaycxMp2W849Kafydq2L9qRbu839X9No/L4kVMFk+HjdPEgpWycE98oEb9QeCh
	Zf4m8jHQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w6FK2-000GsK-0S;
	Fri, 27 Mar 2026 23:06:30 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	rivastava0@gmail.com
Subject: [PATH bpf-next] selftests/bpf: Add few tests for alu32 shift value tracking and zext
Date: Fri, 27 Mar 2026 23:06:29 +0100
Message-ID: <20260327220629.343327-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27953/Fri Mar 27 07:24:46 2026)

Add few more alu32 shift tests using div-by-zero on provably dead paths
to check both verifier and JIT xlation resp. runtime correctness.

If the verifier mistracks the result, it rejects due to the div by 0;
if the JIT computes a wrong value, then runtime hits the dead path and
retval changes.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_subreg
  [...]
  #644/76  verifier_subreg/arsh32_imm1_value:OK
  #644/77  verifier_subreg/lsh32_reg0_zero_extend_check:OK
  #644/78  verifier_subreg/rsh32_reg0_zero_extend_check:OK
  #644/79  verifier_subreg/arsh32_reg0_zero_extend_check:OK
  #644/80  verifier_subreg/lsh32_imm31_value:OK
  #644/81  verifier_subreg/rsh32_imm31_value:OK
  #644/82  verifier_subreg/arsh32_imm31_value:OK
  #644/83  verifier_subreg/lsh32_unknown_precise_bounds:OK
  #644/84  verifier_subreg/rsh32_unknown_bounds:OK
  #644     verifier_subreg:OK
  Summary: 1/84 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_subreg.c     | 165 ++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/testing/selftests/bpf/progs/verifier_subreg.c
index be328100ba53..31832a306f91 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
@@ -823,4 +823,169 @@ __naked void arsh_63_or(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__success __retval(42)
+__naked void arsh32_imm1_value(void)
+{
+	asm volatile ("					\
+	r0 = 42;					\
+	r1 = -2147483648;				\
+	w1 s>>= 1;		/* r1 = 0xC0000000 */	\
+	r2 = 0xC0000000 ll;				\
+	if r1 == r2 goto l0_%=;			\
+	r0 /= 0;		/* unreachable */	\
+l0_%=:	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(1)
+__naked void lsh32_reg0_zero_extend_check(void)
+{
+	asm volatile ("					\
+	r6 = 1;						\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w1 = 0;						\
+	w0 <<= w1;		/* reg shift by 0 */	\
+	r0 >>= 32;		/* must be 0 */		\
+	if r0 == 0 goto l0_%=;				\
+	r6 /= 0;		/* unreachable */	\
+l0_%=:	r0 = r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(1)
+__naked void rsh32_reg0_zero_extend_check(void)
+{
+	asm volatile ("					\
+	r6 = 1;						\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w1 = 0;						\
+	w0 >>= w1;		/* reg rsh by 0 */	\
+	r0 >>= 32;		/* must be 0 */		\
+	if r0 == 0 goto l0_%=;				\
+	r6 /= 0;		/* unreachable */	\
+l0_%=:	r0 = r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(1)
+__naked void arsh32_reg0_zero_extend_check(void)
+{
+	asm volatile ("					\
+	r6 = 1;						\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0x1000000000 ll;				\
+	r0 |= r1;					\
+	w1 = 0;						\
+	w0 s>>= w1;		/* reg arsh by 0 */	\
+	r0 >>= 32;		/* must be 0 */		\
+	if r0 == 0 goto l0_%=;				\
+	r6 /= 0;		/* unreachable */	\
+l0_%=:	r0 = r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(42)
+__naked void lsh32_imm31_value(void)
+{
+	asm volatile ("					\
+	r0 = 42;					\
+	r1 = 1;						\
+	w1 <<= 31;		/* r1 = 0x80000000 */	\
+	r2 = 0x80000000 ll;				\
+	if r1 == r2 goto l0_%=;			\
+	r0 /= 0;		/* unreachable */	\
+l0_%=:	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(42)
+__naked void rsh32_imm31_value(void)
+{
+	asm volatile ("					\
+	r0 = 42;					\
+	r1 = -2147483648;	/* 0x80000000 */	\
+	w1 >>= 31;		/* r1 = 1 */		\
+	if r1 == 1 goto l0_%=;				\
+	r0 /= 0;		/* unreachable */	\
+l0_%=:	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(42)
+__naked void arsh32_imm31_value(void)
+{
+	asm volatile ("					\
+	r0 = 42;					\
+	r1 = -2147483648;	/* 0x80000000 */	\
+	w1 s>>= 31;		/* r1 = 0xFFFFFFFF */	\
+	r2 = 0xFFFFFFFF ll;				\
+	if r1 == r2 goto l0_%=;			\
+	r0 /= 0;		/* unreachable */	\
+l0_%=:	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(1)
+__naked void lsh32_unknown_precise_bounds(void)
+{
+	asm volatile ("					\
+	r6 = 1;						\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 3;		/* u32: [0, 3] */	\
+	w0 <<= 1;		/* u32: [0, 6] */	\
+	if w0 < 7 goto l0_%=;				\
+	r6 /= 0;		/* unreachable */	\
+l0_%=:	r0 = r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(1)
+__naked void rsh32_unknown_bounds(void)
+{
+	asm volatile ("					\
+	r6 = 1;						\
+	call %[bpf_get_prandom_u32];			\
+	w0 >>= 28;		/* u32: [0, 15] */	\
+	if w0 < 16 goto l0_%=;				\
+	r6 /= 0;		/* unreachable */	\
+l0_%=:	r0 = r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

