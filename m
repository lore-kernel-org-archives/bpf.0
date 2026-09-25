Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDC94BFE81
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358783; cv=none; b=Bm+b3ips9ajyktiLiwf5sKfJ7JMcCRdWK+P4llvSJLmWKybOoAZhHAA86nF5Kv0OE2CWHQLIoAMyL86nTbJyvGOccM0MgKXEit0lZDjL3qMEgpT183KwJAVlYVTYsiLQ+wGgc9HseUchmAJ8Xjowd8sh2Ych4rJgKZbZSNcNk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358783; c=relaxed/simple;
	bh=TDRDCmcSa3ET7qdiVCBTAkLxF7Of8CT7QDonUt+JoYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pim3B0okq/98USw08vz+V7aRS4X+whQZ+jXCsgr/Xp16aNmX95aNnIdFX0kwxpCfGX8AsjyYmjPi+eKfIAD2nr4OJSpuKdMpUqqCBgLIT2y1zy9KPMorRwwRhT0/HRZR2QePqXEzpLppeXFXWd/HcCt4MfilU/1f3vGn9SU6+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=bR5ikARo; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="bR5ikARo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=g85cuKoq6gHsvmABQsOawZT2FohsBQGdAvSEUYIPLnk=; b=bR5ikARouH49d/ARRAlZv6m1Gj
	xtv+CRXOk+AeFKCNzfNkdJEQkIXlX7vd+T+dqWm8qvOYa2Ymi7AurqZyrTwuSO+hmvJtusDpUEsYo
	ngbix8rCR2rtmSIkPDrGuoRjwCQuXo57S729VSRRfniLQBMvMdgunhWnW/S1Hqt2Aw07JxpXedmNE
	0n3h468uIMcErY/ztt8JEozw/MahzPzhM30sX74i2Mq1xyexbTHXs4wbiQA3S2wnNWihy9Bz3PUST
	32KJgXJltgamb1IfezpoHUwDHxF2GvAG4nP/yU1GHWk+3k7gHGbTgf4SBWaBnW9+C+jRqQ0yc60IO
	qDiXsVxw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6Q-000JlL-0K;
	Fri, 25 Sep 2026 19:52:54 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 14/16] selftests/bpf: Add a test for gotox nop targets
Date: Fri, 25 Sep 2026 19:52:41 +0200
Message-ID: <20260925175244.1136329-15-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925175244.1136329-1-daniel@iogearbox.net>
References: <20260925175244.1136329-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28134/Fri Sep 25 08:25:58 2026)

Add a test to the verifier_gotox suite which exercises a gotox target which
is a ja +0, and checks that the nop removal pass keeps it.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_gotox
  [...]
  #644/33  verifier_gotox/jump_table_target_nop:OK
  #644     verifier_gotox:OK
  Summary: 1/33 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_gotox.c      | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index b917c2e14283..f5a9878c7b8d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -551,6 +551,35 @@ __naked void gotox_edges_across_subprogs(void)
 		: : GOTOX_OPERAND : __clobber_all);
 }
 
+/*
+ * The gotox target is a ja +0, which the nop removal pass must keep as the
+ * jump table still names it.
+ */
+SEC("socket")
+__success __retval(0)
+__xlated("goto pc+0")
+__naked void jump_table_target_nop(void)
+{
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:								\
+	.quad nop_%= - socket;					\
+	.size jt0_%=, 8;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 = *(u64 *)(r0 + 0);					\
+	.8byte %[gotox_r0];					\
+nop_%=:								\
+	goto +0;						\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0, 0))
+	: __clobber_all);
+}
+
 #endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 || __TARGET_ARCH_powerpc*/
 
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

