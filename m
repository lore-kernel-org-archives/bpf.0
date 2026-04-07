Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3357133688E
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589868; cv=none; b=AGUJlt2vmEs4J3PsWBSYj7cuAe6UFfVHeAPh013pT/r9SXLxx3tY6SfdEjjMUiU6PnQvo1DLVHBWsqFPf5lvbO9k/Ml/SBzJD/gs1Pk913tqtdMUBgQRL1bERMWx45tnGdp8K2xLOU/1xNwYssYcLJA+9LT023ARnULUj5lro+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589868; c=relaxed/simple;
	bh=krbNSSxcg4rQk++Ms+POBN5LnflmbU0eVumM90ugInU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UMnVanUQEoGvVmjQaD/3MGq2nW259Kw8L82PU1I85wsoiTKxRyxQJrm9Auc+C5+Xf7zkRlFV/vs4mOQVP+TVF3r339ztVX8Kstla2FfRtFMqntiw/GgxhR3UckYuMAEwdLFWQdb1j2HxaazDa35+TOMFEO+Nytea1/dqi0MRpAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=g/vESDxO; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="g/vESDxO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=U/cb30S0DTqZpgFVRFPmfV9pjSgyhmzq0ra67W+2+k0=; b=g/vESDxOIS1OmChD8BZxCYthcx
	Af/35D53M133vLnBRIj7ByYeuS6tpFuQutImZYpekSsu6ZoHM4b/VdbYpyTzDc0ldpK9cyxNuA2xx
	clt5/YScNel7B7wHnHqGZUXwVEMAKXWUAeoi1lcomXiYaA7wZ66ntdBKhhhRlqiGHHkD7nkdgFZyb
	56TrmnW2vRlbeDvS767ge8R8mlRQGvhnc77yiby3xLVb1rRnzGwLtsve7tR1QvXVOtof2CoJugftO
	cLnj2dngvLusQHHWEjGKmg1kZFL2jiaBIvGfvCQ8NWadVIMS1+lz8aWnCspqdjjVPEHIrUsVAVH5q
	bapPWrZA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wAC2A-0001v2-27;
	Tue, 07 Apr 2026 21:24:22 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	puranjay@kernel.org,
	info@starlabs.sg
Subject: [PATCH bpf-next 1/4] bpf: Fix linked reg delta tracking when src_reg == dst_reg
Date: Tue,  7 Apr 2026 21:24:18 +0200
Message-ID: <20260407192421.508817-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27964/Tue Apr  7 08:24:40 2026)

Consider the case of rX += rX where src_reg and dst_reg are pointers to
the same bpf_reg_state in adjust_reg_min_max_vals(). The latter first
modifies the dst_reg in-place, and later in the delta tracking, the
subsequent is_reg_const(src_reg)/reg_const_value(src_reg) reads the
post-{add,sub} value instead of the original source.

This is problematic since it sets an incorrect delta, which sync_linked_regs()
then propagates to linked registers, thus creating a verifier-vs-runtime
mismatch. Fix it by just skipping this corner case.

Fixes: 98d7ca374ba4 ("bpf: Track delta between "linked" registers.")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1bebbdb3b693..d83e17cccd38 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16722,7 +16722,8 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	 */
 	if (env->bpf_capable &&
 	    (BPF_OP(insn->code) == BPF_ADD || BPF_OP(insn->code) == BPF_SUB) &&
-	    dst_reg->id && is_reg_const(src_reg, alu32)) {
+	    dst_reg->id && is_reg_const(src_reg, alu32) &&
+	    !(BPF_SRC(insn->code) == BPF_X && insn->src_reg == insn->dst_reg)) {
 		u64 val = reg_const_value(src_reg, alu32);
 		s32 off;
 
-- 
2.43.0

