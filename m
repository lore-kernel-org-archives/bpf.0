Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131722F77B
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749829; cv=none; b=sqesLd9Pmy0HmlJBPk8nhvC/Tevv3O7U8ei8REVMs0CKxH6BiGqB+wsk+U8Kk0PdhvdqKLAqMddJv3gtdfYAOVRWFZYNMVAUFDQxuYzg1I3Y4hOIp9hM1dzrPTtYCxgajPuOvxJJnNsnGX99WEGhvNFICdTVICR/r8Yxo619W2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749829; c=relaxed/simple;
	bh=dVpzTE2olahybK/q/R89EYqbNkpBcd3LEXGXNfkRh94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBN6eI64FAjzgsc8x0ag2f8AWCBix6TgRLA+khfpybtTjLum/PFmW4V8egBTOa9kzmDPWUeCQjY5mD9ZSS5WXejSCxPAzASyHbP7QE5tIBNGNnDD/DBa5PwxSaOQ0khiPrhWC03bfut6nKkfWA7Ux/bmqaENxKTbVY8hOph6ls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NjhbqAMl; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NjhbqAMl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=N7goyYAtkb25GuEm/3ofKFVkxUC/fu4aF5BO8IpRLgQ=; b=NjhbqAMl41Q0IeBRqPeD/4l2JQ
	aL8lCgik+Q6K4s1FuoBnp0hLAXxBzF+K1iQqRfVTEhY0VvyfZxndYBemgoIbQ5iKcNQcSa82kjArv
	C++3XcFxR8R2lCyeS/zoHs4ZZ30DvBF1c5Sqi6pySWqs7LfzHWTrE3U+YHCI2O5E2Ou50j7vz1ogZ
	639xRv+TalTKWG/FhAQA16fC3T7ULeq/5xqrpOYOZfT73NKJeYdksDgoictySJgXzPpHF4vHWUOcz
	Jw1sGyDJLgOULgRklhdyIqxt5LkrF1R9INLkzYCntILYTwToDdlB25LcM9Z22KFHrZYlTetHLHXpf
	QM6q9X/Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAre6-000ESO-0c;
	Thu, 09 Apr 2026 17:50:18 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	eddyz87@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for stale pkt range after scalar arithmetic
Date: Thu,  9 Apr 2026 17:50:16 +0200
Message-ID: <20260409155016.536608-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409155016.536608-1-daniel@iogearbox.net>
References: <20260409155016.536608-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27966/Thu Apr  9 08:24:43 2026)

Extend the verifier_direct_packet_access BPF selftests to exercise the
verifier code paths which ensure that the pkt range is cleared after
add/sub alu with a known scalar. The tests reject the invalid access.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_direct
  [...]
  #592/35  verifier_direct_packet_access/direct packet access: pkt_range cleared after sub with known scalar:OK
  #592/36  verifier_direct_packet_access/direct packet access: pkt_range cleared after add with known scalar:OK
  #592/37  verifier_direct_packet_access/direct packet access: test3:OK
  #592/38  verifier_direct_packet_access/direct packet access: test3 @unpriv:OK
  #592/39  verifier_direct_packet_access/direct packet access: test34 (non-linear, cgroup_skb/ingress, too short eth):OK
  #592/40  verifier_direct_packet_access/direct packet access: test35 (non-linear, cgroup_skb/ingress, too short 1):OK
  #592/41  verifier_direct_packet_access/direct packet access: test36 (non-linear, cgroup_skb/ingress, long enough):OK
  #592     verifier_direct_packet_access:OK
  [...]
  Summary: 2/47 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../bpf/progs/verifier_direct_packet_access.c | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index 4ee3b7a708f7..915a9707298b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -859,4 +859,65 @@ l0_%=:	r0 = 1;					\
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("direct packet access: pkt_range cleared after sub with known scalar")
+__failure __msg("invalid access to packet")
+__naked void pkt_range_clear_after_sub(void)
+{
+	asm volatile ("					\
+	r9 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r8 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r9 += 256;					\
+	if r9 >= r8 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	/* r9 has AT_PKT_END (pkt + 256 >= pkt_end) */	\
+	r9 -= 256;					\
+	/*						\
+	 * AT_PKT_END must not survive the arithmetic.	\
+	 * is_pkt_ptr_branch_taken must validate both	\
+	 * branches when visiting the next condition.	\
+	 */						\
+	if r9 < r8 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u8*)(r9 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("direct packet access: pkt_range cleared after add with known scalar")
+__failure __msg("invalid access to packet")
+__naked void pkt_range_clear_after_add(void)
+{
+	asm volatile ("					\
+	r9 = *(u32*)(r1 + %[__sk_buff_data]);		\
+	r8 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
+	r9 += 256;					\
+	if r9 >= r8 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+l0_%=:	/* r9 has AT_PKT_END (pkt + 256 >= pkt_end) */	\
+	r9 += -256;					\
+	/*						\
+	 * Same as sub, but goes through BPF_ADD path.	\
+	 * AT_PKT_END must not survive the arithmetic.	\
+	 */						\
+	if r9 < r8 goto l1_%=;				\
+	r0 = 0;						\
+	exit;						\
+l1_%=:	r0 = *(u8*)(r9 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

