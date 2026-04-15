Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BCC34D3B5
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776255262; cv=none; b=ljO5cXhfAhsT5x2CmE6RMValfMcceoMutHDwy//d7cdbT0hDzSqp2/iBmrikBFvaN2UWarkZ/3V7HFq64820wPR40LiNfjSHZv83xmmJcpwMX4nEIYJax3NSzwRkvjVi1XW1pzanfuDmeGFlMCxwVwPDq+c2IqYAqgTkfXoSiv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776255262; c=relaxed/simple;
	bh=tvx3EwdQKn32rL47uctv5zJriKhK6Az0ph7ay/L0FBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BEmdoVot6S9sSfRMLXfdqx/rYvr8jOtoK+4Ph9JYCrStYEtatO9brpaK6u0DpnyadL0+TEP++ypOhXx0xnQdsTIXdVu9S1A8tmpdlf7GyhuagBMjvsB6OPiAaYmP6riam3qdLg3KV7sogMHv/thXwcQwuGgNNPEmgLGQ99SGsY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=SW4GsgoF; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="SW4GsgoF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=CZIMPaKWVsIl8Yv5++m+1N7i7BgjFkeCRIdk77MXJmQ=; b=SW4GsgoFIoS8ovi3AGbvCUUdRz
	qAfkSey0PmoHnWmfTEnj5eUATmoVQst2w4lRoG//Ac8MJXTeIQP7yCb77CNKkXGDaMVYamiSYDpfN
	nuPTU45/BwwoMQ0ElkPaUUvlm+K5r5kYaMB6FltRo+3+TRR8FP+ji1XXw7BoUg7nkAcvUwnadC+zH
	Bqr19r2fh9TKDRcRVpLJZeYX2s/O7NpMXO1Q/mBrHRbwR9Ue8jKos+sbGiy6iwyoqDv1axCiQ07ac
	976kje+sxgEOirEUJXDHk6ZS9lbVm+iD+0c+hKOYZoY/5CkXxUAAZfbPi7O+IAZD/w0qtAuRomfCS
	hcI0aTGg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wCz88-000Os0-13;
	Wed, 15 Apr 2026 14:14:04 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com
Subject: [PATCH bpf 1/2] bpf, arm64, insn: Reject out-of-range B.cond targets
Date: Wed, 15 Apr 2026 14:14:02 +0200
Message-ID: <20260415121403.639619-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27972/Wed Apr 15 08:24:27 2026)

aarch64_insn_gen_cond_branch_imm() calls label_imm_common() to
compute a 19-bit signed byte offset for a conditional branch,
but unlike its siblings aarch64_insn_gen_branch_imm() and
aarch64_insn_gen_comp_branch_imm(), it does not check whether
label_imm_common() returned its out-of-range sentinel (range)
before feeding the value to aarch64_insn_encode_immediate().

aarch64_insn_encode_immediate() unconditionally masks the value
with the 19-bit field mask, so an offset that was rejected by
label_imm_common() gets silently truncated. With the sentinel
value SZ_1M, the resulting field ends up with bit 18 (the sign
bit of the 19-bit signed displacement) set, and the CPU decodes
it as a ~1 MiB *backward* branch, producing an incorrectly
targeted B.cond instruction. For code-gen locations like the
emit_bpf_tail_call() this function is the only barrier between
an overflowing displacement and a silently miscompiled branch.

Fix it by returning AARCH64_BREAK_FAULT when the offset is out
of range, so callers see a loud failure instead of a silently
misencoded branch. validate_code() scans the generated image
for any AARCH64_BREAK_FAULT and then lets the JIT fail.

Fixes: 345e0d35ecdd ("arm64: introduce aarch64_insn_gen_cond_branch_imm()")
Fixes: c94ae4f7c5ec ("arm64: insn: remove BUG_ON from codegen")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/lib/insn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index cc5b40917d0d..37ce75f7f1f0 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -338,6 +338,8 @@ u32 aarch64_insn_gen_cond_branch_imm(unsigned long pc, unsigned long addr,
 	long offset;
 
 	offset = label_imm_common(pc, addr, SZ_1M);
+	if (offset >= SZ_1M)
+		return AARCH64_BREAK_FAULT;
 
 	insn = aarch64_insn_get_bcond_value();
 
-- 
2.43.0

