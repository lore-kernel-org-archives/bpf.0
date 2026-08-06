Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3061C862D
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047054; cv=none; b=h5KZZRv/wN42UF1z0PT1WfBFae6dKOK8pvssu0VVx2wtyEI68z0DxJJ8sGyi6QR4+4GUTjzayRAU39KS1HjcPIZwPpJVoWiXnR33UTnj/w9713c6La+JsMubRA1KZwrs+egXK6/QtYyrCNSwXIcOMNsp8zY74ojkbqI2qwDdj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047054; c=relaxed/simple;
	bh=vu4nKZTxqRgvcccORZv8G430F+s8WXtEZAxMmNHDYEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGeo/aq4LoS+AKiN3nLYV7rAxfoMvxag3enj7W1tAMWRlzFinK3AE+zjFkrM7dnr4pk/h6mqsyRI8dBa7iZa8z1FBMEFcUKH2Iuc/MsCrqufTl43X20xYd6PwzY92waaai2WkRGt9q7UCHtKHlsQ6H9gLnTTHvWMxDFGt8XlntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=nTqHrNcT; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nTqHrNcT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=KEfQER8IH1AQjVupzORUCkNAj+DBqKfTgAMGIb2dmT4=; b=nTqHrNcTD8N3xb2jaO+KOkpowX
	fTVvsJpQv1Tt9XB91ukI34XcIeqo9a6r5Y4bJxGbdPr5TEUUvBT+DhcXL5IGxgC/DHVAGmDfIMXz1
	+GwguvzOwWivEXL3kzE5TypiCkcb5eI4lbtX4sqJBHwInYgO+ssFf45fPbQUfi5/nGK2nnqe1bv3Z
	z4nd4Js8H7Dffwrvye3cS4281M7wqBOQAR4Vbxg6p/LFVelGhbT+pNh1na4oBkZvVSBuxli0xDtj0
	l+Jiv9N1sP2BV6nz8Q3o5bsqas1BwNLGTKj5YjsAyy3DNq1j46getoXX5Ozj6nI+u+PIwRnb52BBx
	h6bxyvPA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ws4QU-000DHK-0r;
	Thu, 06 Aug 2026 22:10:50 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org,
	Peilin Ye <yepeilin@google.com>
Subject: [PATCH bpf-next v2 4/6] bpf, arm64: Fix exception table metadata for arena load-acquire
Date: Thu,  6 Aug 2026 22:10:45 +0200
Message-ID: <20260806201047.333389-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806201047.333389-1-daniel@iogearbox.net>
References: <20260806201047.333389-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28084/Thu Aug  6 08:24:46 2026)

Same problem as on x86-64: add_exception_handler() decides whether an
instruction is a load by its class, and a load-acquire is of BPF_STX
class even though it reads from src_reg into dst_reg. As a result ...

  if (BPF_CLASS(insn->code) != BPF_LDX)
          dst_reg = DONT_CLEAR;

... drops the register to clear, and ...

  if (BPF_CLASS(insn->code) == BPF_LDX)
          arena_reg = bpf2a64[insn->src_reg];
  else
          arena_reg = bpf2a64[insn->dst_reg];

... hands ex_handler_bpf() the value register instead of the address
register. A load-acquire from an arena pointer that faults on an
unmapped page is therefore reported as a WRITE at a bogus address,
and dst_reg keeps its previous value instead of being cleared to 0.

Note that emit_atomic_ld_st() already picks src_reg as the address
for BPF_LOAD_ACQ, so only the exception table metadata was out of sync
with the emitted access.

Same as on x86-64, use bpf_atomic_is_load_acq() so a load-acquire takes
the load path.

Fixes: 9bb12368d539 ("bpf, arm64: Support load-acquire and store-release instructions")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Cc: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/net/bpf_jit_comp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 4cdc7dfb05ba..d14d297ebb96 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1178,7 +1178,12 @@ static int add_exception_handler(const struct bpf_insn *insn,
 
 	ex->insn = ins_offset;
 
-	if (BPF_CLASS(insn->code) != BPF_LDX)
+	/*
+	 * A load-acquire is of BPF_STX class, but reads from src_reg into
+	 * dst_reg like a BPF_LDX does, hence it must not be treated as a store
+	 * here.
+	 */
+	if (BPF_CLASS(insn->code) != BPF_LDX && !bpf_atomic_is_load_acq(insn))
 		dst_reg = DONT_CLEAR;
 
 	ex->fixup = FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
@@ -1193,7 +1198,7 @@ static int add_exception_handler(const struct bpf_insn *insn,
 		 * memory access. Pass the reg holding the unmodified 32-bit address to
 		 * ex_handler_bpf.
 		 */
-		if (BPF_CLASS(insn->code) == BPF_LDX)
+		if (BPF_CLASS(insn->code) == BPF_LDX || bpf_atomic_is_load_acq(insn))
 			arena_reg = bpf2a64[insn->src_reg];
 		else
 			arena_reg = bpf2a64[insn->dst_reg];
-- 
2.43.0

