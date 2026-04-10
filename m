Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1038B3876D5
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863618; cv=none; b=LDv0mF42IJ22iCBXRXOrHZTS3KjSWIk1fmnZ2aOBwy0DOACoF8aIsDoKDM4HuSYnfEcNAEDvacufGKneIiYFQfzeYKm4Lggyd8FqTMCPCMRd6DvN8vl9m5L/szu2RL88NucLvFXk7FnLzem0I6/Z+LSUJDeCVeHlvaL4vwfjcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863618; c=relaxed/simple;
	bh=ztNbTjXl2ZFs8z6/Y1mo4ioZP2ZlAjhDurknWSv65dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=da0dSucfjR2atYOiQMc+OAx2SRNEF/Wn/Jk2ixf1enPnvAAbKigp8Rh7zbR/NVpYnfC9zh38DrOYPmsaOSpCxE8XSntEV4aOaFsVQT4tckX2PKS5Gl8cQkkodz18Fk+H8zaXfoWEgfBOGulIXdPSHLbKtX4TqY7m7dNPI3YG85Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lGkyCIwZ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lGkyCIwZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zls1FGvYtFKjXdb5pZVEPiHZPGLFGuDA+n7hg1l5a/o=; b=lGkyCIwZx9Y84GiSWUWytcostk
	Zuj2CVCrR0cSR1sX1BorqB/flKcr8Xwg/PXImy7n8Vh3hFT/tXfLYQIay30e4P6pPAkFPdYJZaTAY
	4953BTZAHi/dfJcW9L2/M4nqjPHg264kX4yl8JmlG2BRnOIpNiN16yVNS70E49GEk4m/IN3IylbG8
	YYlLuD704sjs8tU5cwA70QAx+jIK7KWp9672v+eSfVKIQg8rAnvaeyYyFR34EZvSODtZMfgpKzVMH
	UMYdSJyxVbCYGeo3VAren3IqzhH+z/fbYpRvngpOob6U9/j2vqEcZUlnziYoNWQLA/k8qtVYeob6s
	iadLD4dQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wBLFU-0002cp-32;
	Sat, 11 Apr 2026 01:26:53 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	eddyz87@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for add_const base_id consistency
Date: Sat, 11 Apr 2026 01:26:51 +0200
Message-ID: <20260410232651.559778-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410232651.559778-1-daniel@iogearbox.net>
References: <20260410232651.559778-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27967/Fri Apr 10 08:24:45 2026)

Add a test to verifier_linked_scalars that exercises the base_id
consistency check for BPF_ADD_CONST linked scalars during state
pruning.

With the fix, pruning fails and the verifier discovers the true
branch's R3 is too wide for the stack access.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_linked_scalars
  [...]
  #613/22  verifier_linked_scalars/scalars_stale_delta_from_cleared_id:OK
  #613/23  verifier_linked_scalars/scalars_stale_delta_from_cleared_id_alu32:OK
  #613/24  verifier_linked_scalars/linked scalars: add_const base_id must be consistent for pruning:OK
  #613     verifier_linked_scalars:OK
  Summary: 1/24 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../bpf/progs/verifier_linked_scalars.c       | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 60a6f246e2d1..d571fbfc86a3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -647,4 +647,67 @@ l_exit_%=:							\
 	: __clobber_all);
 }
 
+/*
+ * Test that regsafe() verifies base_id consistency for BPF_ADD_CONST
+ * linked scalars during state pruning.
+ *
+ * The false branch (explored first) links R3 to R2 via ADD_CONST.
+ * The true branch (runtime path) links R3 to R4 (unrelated base_id).
+ * At the merge point, pruning must fail because the linkage topology
+ * differs.
+ */
+SEC("socket")
+__description("linked scalars: add_const base_id must be consistent for pruning")
+__failure __msg("invalid variable-offset")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void add_const_base_id_pruning(void)
+{
+	asm volatile ("						\
+	r1 = 0;							\
+	*(u64*)(r10 - 16) = r1;					\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r6 &= 1;						\
+	if r6 >= 1 goto l_true_%=;				\
+								\
+	/* False branch (explored first, old state) */		\
+	call %[bpf_get_prandom_u32];				\
+	r2 = r0;						\
+	r2 &= 0xff;		/* R2 = scalar(id=A) [0,255] */	\
+	r3 = r2;		/* R3 linked to R2 (id=A) */	\
+	r3 += 10;		/* R3 id=A|ADD_CONST, delta=10 */\
+	r6 = 0;							\
+	goto l_merge_%=;					\
+								\
+l_true_%=:							\
+	/* True branch (runtime path, cur state) */		\
+	call %[bpf_get_prandom_u32];				\
+	r2 = r0;						\
+	r2 &= 0xff;		/* R2 = scalar [0,255], id=0 */	\
+	r4 = r0;						\
+	r4 &= 0xff;		/* R4 = scalar [0,255], id=0 */	\
+	r3 = r4;		/* R3 linked to R4 (new id=C) */\
+	r3 += 10;		/* R3 id=C|ADD_CONST, delta=10 */\
+	r6 = 0;							\
+								\
+l_merge_%=:							\
+	/* At merge, old R3 linked to R2, cur R3 linked to R4. */\
+	/* Pruning must fail: base_ids A vs C inconsistent. */	\
+	if r2 >= 6 goto l_exit_%=;				\
+	/* sync_linked_regs: R2<6 => R3<16 in old state. */	\
+	/* Without fix: R3 in [10,15] from incorrect pruning. */\
+	/* With fix: R3 in [10,265], not synced from R2. */	\
+	r3 -= 10;		/* [0,5] vs [0,255] */		\
+	r9 = r10;						\
+	r9 += -16;						\
+	r9 += r3;		/* fp-16+[0,5] vs fp-16+[0,255] */\
+	*(u8*)(r9 + 0) = r6;	/* within 16B vs past fp */	\
+l_exit_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

