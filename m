Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9E478865
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027176; cv=none; b=FnMGA+kHjHbrLtbMHfIoHHFs4wS7PuMiJKeREkYEx2qCnFER4ES0ievtG78UtL4AFMFgiJvRj3UcPVgHN/zB15ZxHaIXBKDHdZklfo3lXGv+oqYIll7UZj+r0wL82FYozf5DQqFPu4J5YGAsC795orr0fkHQxFK/iQ4S65ginnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027176; c=relaxed/simple;
	bh=Z0W2fduMZ7LhPVFauFPX5Q5psOdHMsLzNE/ts6W/Emw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfGj3jiaJWItHkM/OycGhhGZ+K/48lW2RxyNcQE2Ps0F+WC5tcZES9c24XXvq+Zk3uJ/Wtxs/T3xYvkDVTGUQAbgCuH7tEYBTgtqY7i2vNzznNOcEnHevwrUS1JDGjqajc9en9ufYoWn0NLyONHkjyNLM2uPSEuEpwuXtJM3n/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=f2KBGYiG; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="f2KBGYiG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rYC7bjqvh78aySxybagFJurKEHT0Bk4cjpcp2n2LcxE=; b=f2KBGYiG60Qss+YcShjlVTYO5f
	lCyTZwMZTSX8jTNmSi7xQ7hZ3R1xUT4weyIFUdGmV3RgegLdwuQhzcbX+uUR5mNMTXa1cs3WE3VDH
	RIJdFAMkPi1ozUZqGhBGlia3Zwv4vtnFMpo/vjP+Pv3CBiU30Xz/jOuMAK4FUGOBzLKNiwdzxx04Q
	U0r/tkjZ+OWQg8c7IJiTV0nKpnmEE1yxBXqQkLuQHF7WvFEUP6JFZ7fHNNUBlvGUkeCb4WT0mKgz2
	bbtRgkpjMKikXMIIY1mzAjoLF5yA0865YcZ/C9VTqBJTEQZ+oqeJFaJPZxCwcm02GsC/7RHKM7+yL
	v81bNjCg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wrzFm-0004sg-2R;
	Thu, 06 Aug 2026 16:39:26 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org,
	Peilin Ye <yepeilin@google.com>
Subject: [PATCH bpf-next 4/6] bpf, arm64: Fix exception table metadata for arena load-acquire
Date: Thu,  6 Aug 2026 16:39:22 +0200
Message-ID: <20260806143924.319238-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806143924.319238-1-daniel@iogearbox.net>
References: <20260806143924.319238-1-daniel@iogearbox.net>
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

