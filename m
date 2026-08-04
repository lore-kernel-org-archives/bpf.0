Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169733FE33
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874771; cv=none; b=qCpJ5WSpvFaacSjf93dej1CwLqnEeLCH7fFiAfThCimRGPpxaZxqSLbTatco6/AmZ/kmC/s/T0wxR5Y21J3IDV+9q657Bwty4ee+340Ai5kV7/eBNP1uVok27MLvHPt8Ckw1xwskQKtPIOJQ0SeemrczJK7G/6dQyV2Ia+zprj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874771; c=relaxed/simple;
	bh=1f17HifVvRKbg7a6rQ1wyQCdh1lDbQjXevSFQsblSn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNKayqvV16wCUYTW1yxVj4ooLR5/qMJ2uOS3qhc50QyHVbQ5n9lzriKLjQyJKU7RLHvh3vOYhrMDXMI2K6ciN/0wsiOrtCi/wm4Mk7bHkMP+9BxWBjQK/wu26jRakm5LwHkV5e9Pcnxul2Hfnvy40z5xO2z+SDnLIp76V0Qm/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HnC9I+Ni; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HnC9I+Ni"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dUifq/xAX1PbtMUCNwU73TB32OohdZB5cc+ZjQqVzAM=; b=HnC9I+NikQRAnKnIonU+NvOR91
	x5nlNHKam65r4qYeCS95pg40fQ12vcZm3kif6ErzZFRIOL7jOaUzf+zlZkScJ1fFek1oIUt93dXO5
	WJVDywyUKHhdaU40MuCV06lfW5fEFkkRcbZ62vn+cWy7VXidR0cHaMpnU7+Mmh6eooDKc8NPK/Dpj
	wXDZGihklyq0PJZRmTgcCjhS00Q1Qxl0LKQlAo7rDswrFWID4O5sWn7QRlF7HHqIiDyEkXchzI7Zu
	WLYuR29h3MNJvHIKMw3NqOEOtRMJy36PsrP6H88HcJhakod9CLRxYLuwnkuFewbSlvY6OdE904i5D
	uk93Gz3w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wrLbb-000NbC-0h;
	Tue, 04 Aug 2026 22:19:19 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add load-acquire test for dst_reg == src_reg from ctx
Date: Tue,  4 Aug 2026 22:19:17 +0200
Message-ID: <20260804201917.253491-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804201917.253491-1-daniel@iogearbox.net>
References: <20260804201917.253491-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28082/Tue Aug  4 08:24:26 2026)

Add a verifier test that a load-acquire fetching into its own source
register (dst_reg == src_reg) from a ctx pointer is rejected.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_load_acquire
  [...]
  #614/1   verifier_load_acquire/load-acquire, 8-bit:OK
  #614/2   verifier_load_acquire/load-acquire, 8-bit @unpriv:OK
  #614/3   verifier_load_acquire/load-acquire, 16-bit:OK
  #614/4   verifier_load_acquire/load-acquire, 16-bit @unpriv:OK
  #614/5   verifier_load_acquire/load-acquire, 32-bit:OK
  #614/6   verifier_load_acquire/load-acquire, 32-bit @unpriv:OK
  #614/7   verifier_load_acquire/load-acquire, 64-bit:OK
  #614/8   verifier_load_acquire/load-acquire, 64-bit @unpriv:OK
  #614/9   verifier_load_acquire/load-acquire with uninitialized src_reg:OK
  #614/10  verifier_load_acquire/load-acquire with uninitialized src_reg @unpriv:OK
  #614/11  verifier_load_acquire/load-acquire with non-pointer src_reg:OK
  #614/12  verifier_load_acquire/load-acquire with non-pointer src_reg @unpriv:OK
  #614/13  verifier_load_acquire/misaligned load-acquire:OK
  #614/14  verifier_load_acquire/misaligned load-acquire @unpriv:OK
  #614/15  verifier_load_acquire/load-acquire from ctx pointer:OK
  #614/16  verifier_load_acquire/load-acquire from ctx pointer @unpriv:OK
  #614/17  verifier_load_acquire/load-acquire from ctx pointer, same dst and src register:OK
  #614/18  verifier_load_acquire/load-acquire from ctx pointer, same dst and src register @unpriv:OK
  #614/19  verifier_load_acquire/load-acquire with invalid register R15:OK
  #614/20  verifier_load_acquire/load-acquire with invalid register R15 @unpriv:OK
  #614/21  verifier_load_acquire/load-acquire from pkt pointer:OK
  #614/22  verifier_load_acquire/load-acquire from flow_keys pointer:OK
  #614/23  verifier_load_acquire/load-acquire from sock pointer:OK
  #614     verifier_load_acquire:OK
  Summary: 1/23 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_load_acquire.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
index 74f4f19c10b8..ae1dab1b0cbb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
+++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
@@ -148,6 +148,22 @@ __naked void load_acquire_from_ctx_pointer(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("load-acquire from ctx pointer, same dst and src register")
+__failure __failure_unpriv __msg("BPF_ATOMIC loads from R6 ctx is not allowed")
+__naked void load_acquire_ctx_same_dst_src(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	".8byte %[load_acquire_insn];"	// w6 = load_acquire((u32 *)(r6 + 0));
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(load_acquire_insn,
+		     BPF_ATOMIC_OP(BPF_W, BPF_LOAD_ACQ, BPF_REG_6, BPF_REG_6, 0))
+	: __clobber_all);
+}
+
 SEC("xdp")
 __description("load-acquire from pkt pointer")
 __failure __msg("BPF_ATOMIC loads from R2 pkt is not allowed")
-- 
2.43.0

