Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562094;
	b=YQ80Lop/TddqhPYNYqINNYtPpbrXDgqQ8eSwPio6A4QE0MrKcUpwZomMp/wi8810XkLJ
	 u4O3Ic7wsXsKj+2p3ap2VkzB9uwsQaSdruPiYr2d9/h3RussJzIKAou2nBlbyloI46i8H
	 fTMsqxzkZdwqN76lLGwGlg5PUPV8JYriBH4EDJtiBqb/G3cKLglmWuP01y5RngYQ9ZKRk
	 77Zq+mdULA7kpZ7oBy7RiLETtTIPE6B4LOZ9d44h3SOaY84A6j3UR+F6NdcufjrEdgZRX
	 hTMKvNMhDyu8D3BJdsT+oKPBV376zdU1TtR6s9Khw5pJ5rG9XorDySeWraPWTAly86w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562094;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=AvNmMdEephyWyhftchuhmgTXlDYgN+4TeMGy6jDOe1Q=;
	b=LknOFG8CoeB2lMmI0bgBu+G17leapCYojzhOOyKK7QHwne9NznhfXP7RMhWpFHoW+AVE
	 Vt6IJbvo5MZjbPfqYd1r7wG3Ty1dQo6CwPHJ3KLYAUotMNgFtsf3szfni7i8Nlfhqwocv
	 577zwCa2ZjM0qI1c6KcehgPew4C4zCN0XOLOQvi9iB4LNfuzNxgeCFGjvOp+uhsvqAS7K
	 vsVi++a48YwSG6r/OAsxLq/2V/IA3OPymmbNAhC/EqtEvyo3FcOZpXb1r1nA7HGjkc3ET
	 tIeXdD53WZJ7Lm1N+QlJfuM+62P4u46MaTm+rDDteNIxihEFvLKRgQCrnPORBewnZzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=RD74u1Z4;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF6606A33A
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64BF6606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=RD74u1Z4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=AvNmMdEephyWyhftchuhmgTXlDYgN+4TeMGy6jDOe1Q=; b=RD74u1Z46Z9q5qEJErELqq9CuA
	B2dgmBxLjPMpkBzWPVMoC1EROroeQVJWY3/ZiHM4PbMhyiRA0SIWrRkO7tIa8iKGqZjS9YeUG2xBY
	+w+q94gufy04kdr/VL7S9dt8K1D6xT0SQbaX3oRhYtBvUSrrfY9cYPvJG71tnCN3FK4PBcqqsIAd9
	rtTA36pbiIIFtDpQsHzUE/SDDh8boJqPh/8U4jUffAl7OuIp0BdCu10VLMwlLQWv6/ubuWU/ZhfzN
	+yJ5h1wytyHy74sdw4n/SO0kFurFY0YNKLmIOGhm2KCONSjsdy/0F3MEdk6MkuXHCDULKixF/P2iH
	OG72wTaw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xVzio-000Pye-2d;
	Wed, 25 Nov 2026 00:14:46 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	will@kernel.org,
	memxor@gmail.com
Subject: [PATCH bpf-next 4/5] arm64, insn: Widen the ADRP offset helpers to the reach of ADRP
Date: Wed, 25 Nov 2026 00:14:42 +0100
Message-ID: <20261124231443.3424414-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124231443.3424414-1-daniel@iogearbox.net>
References: <20261124231443.3424414-1-daniel@iogearbox.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28193/Tue Nov 24 07:27:44 2026)

aarch64_insn_adrp_get_offset() and aarch64_insn_adrp_set_offset() pass
the offset as an s32, while the imm21 of ADRP reaches +/-4GB. The
getter shifts the immediate into 32 bits, so a page 2GB or more away
loses its sign: page -524289 comes back as +2147479552 and page 524288
as -2147483648. The setter has no range check, so an offset beyond the
reach wraps into the immediate.

Pass the offset as an s64, sign extend the immediate, and reject an
offset that is not page aligned or out of reach with
AARCH64_BREAK_FAULT, like the encoders do. The alternatives keep their
offsets in s64 as well. An alternative whose ADRP would be out of reach
then gets a BRK patched in instead of an ADRP to the wrong page.

The BPF JIT does not use the two helpers. Their users are the
alternatives, the module PLT comparison and the static call
trampolines, whose ADRPs stay within 2GB, so no kernel code is
affected.

Found by checking the encoders against Arm's A64 ISA XML (2026-09).

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/include/asm/insn.h   |  4 ++--
 arch/arm64/kernel/alternative.c |  2 +-
 arch/arm64/lib/insn.c           | 16 ++++++++++++----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index b25dfd958f94..302ee42d2b3c 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -733,8 +733,8 @@ u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
 s32 aarch64_get_branch_offset(u32 insn);
 u32 aarch64_set_branch_offset(u32 insn, s32 offset);
 
-s32 aarch64_insn_adrp_get_offset(u32 insn);
-u32 aarch64_insn_adrp_set_offset(u32 insn, s32 offset);
+s64 aarch64_insn_adrp_get_offset(u32 insn);
+u32 aarch64_insn_adrp_set_offset(u32 insn, s64 offset);
 
 bool aarch32_insn_is_wide(u32 insn);
 
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index f5ec7e7c1d3f..2a1be7010e03 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -78,7 +78,7 @@ static __always_inline u32 get_alt_insn(struct alt_instr *alt, __le32 *insnptr,
 			insn = aarch64_set_branch_offset(insn, offset);
 		}
 	} else if (aarch64_insn_is_adrp(insn)) {
-		s32 orig_offset, new_offset;
+		s64 orig_offset, new_offset;
 		unsigned long target;
 
 		/*
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 1b4525c50504..57a5c662411e 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -1529,17 +1529,25 @@ u32 aarch64_set_branch_offset(u32 insn, s32 offset)
 	BUG();
 }
 
-s32 aarch64_insn_adrp_get_offset(u32 insn)
+s64 aarch64_insn_adrp_get_offset(u32 insn)
 {
 	BUG_ON(!aarch64_insn_is_adrp(insn));
-	return aarch64_insn_decode_immediate(AARCH64_INSN_IMM_ADR, insn) << 12;
+	return sign_extend64(aarch64_insn_decode_immediate(AARCH64_INSN_IMM_ADR,
+							  insn), 20) << 12;
 }
 
-u32 aarch64_insn_adrp_set_offset(u32 insn, s32 offset)
+u32 aarch64_insn_adrp_set_offset(u32 insn, s64 offset)
 {
 	BUG_ON(!aarch64_insn_is_adrp(insn));
+
+	if ((offset & (SZ_4K - 1)) || offset < -(s64)SZ_4G ||
+	    offset >= (s64)SZ_4G) {
+		pr_err("%s: invalid offset %lld\n", __func__, offset);
+		return AARCH64_BREAK_FAULT;
+	}
+
 	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_ADR, insn,
-						offset >> 12);
+					     offset >> 12);
 }
 
 /*
-- 
2.43.0

