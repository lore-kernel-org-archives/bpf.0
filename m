Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1DD4A1DE1;
	Thu, 24 Sep 2026 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265779; cv=none; b=SrHn7giullG5L2dL49pT6stgcpwOUZfGwT/lvhBJyespMr/x3BZ3Q6oXkdM7aGSqhdA2oRX0aUJGF2oiSNYcrywaCHTXza1IT25TuEtHVjvbYevv/tcfJxVZkO3vgJbnOYyhRdDY5D7iTpFL0RsR01o5TUDovKmRZSR5Avs37zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265779; c=relaxed/simple;
	bh=ypkc0FuzcUHPgfC58MWa/fnycMenJ6PB86mv3ZMQuOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXlTg6U4yr5b9ot3ubl4IXzCS5IguF9uVexPNtF+MGWhts/EeEb7wXYPYHXegD9RKRMGQFBsKhkViXAwfYkMYYYMX3uNwOjwiXIvfZwR8Xfn7xlL1KatjVMlgx8QA5EKyhUepq3F+DdldSF4v8gX/lrb/hAdf46xSfcd+TS1mTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=HQwqIo2g; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=5wwhhOvH; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="HQwqIo2g";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="5wwhhOvH"
From: George Hu <integral@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1790265774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=weJSPBdbOEXZMKYu3fBfRIOkPkIIHuxhlXQ0OoqPoA0=;
	b=HQwqIo2gtfzzAoDly6x0Za7c8cnyRnvSvZ+Y7J0oZsLG13qyhrHd0GkqpT2d5Uhex+8TH4
	5r7dK0uM83flxzDbrjRuQiZuvMyyYT+eLDcZ/Qfo3Ciu9rzGKeaPB0R1Gz/77wAjfoNmay
	Cuky+8Qe/XLtCg/nM5G7oLwkyxZpjVK+izzpr9J91afuZzaqt7CzrVKx229djxAAj/HL+V
	hv2mMvDkD739rAMe7Ndia1dKQhyXuDpKaZiKzrrHfORQgcnv7CLK+cDziil6o92xYqbXLT
	DHGM8uuh9ltABlTTMMyLtSrToo58Q+NTv6VdVHfe9lvo+iPVeoVr40FHBedEYdtnPh9JHM
	Hic13d2MiC5Sq3Vu+Pji7lWi4bV6xFEeF9K+k27Ske2KVS5V2yUqI8yUOjo1dAxVVo3C/J
	uharwnL4xcjhX1IoMgeItEUevoXBbHSP8mAfR/UFjEdGXtoo114XC5NsKlKfncDh5OC8DR
	4In82m9OG2pPx8TU2cvwxbQPisgOKgzXSLZQVdvOtsxM6mvFpDIq8nI//VTWRRpKWnLVh4
	Beq19MnaDZwfuzpd3wK+cUB4w9GrQ+3DWetBHEBGYcaLt5Hfwy6inxlDMezmsbD0q2+rhA
	uFbH+bInRndghPv/IV8YMiJKiieG5q3S3DMs2idb5bmVtqD56RbsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1790265774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=weJSPBdbOEXZMKYu3fBfRIOkPkIIHuxhlXQ0OoqPoA0=;
	b=5wwhhOvHzFbA+30LNMWc/fXP8hRQ/U6ejll0pFYGJLVMCn+Z9yDehZ7K0l0h38r2a58mQf
	+b+9696mYVToHuAw==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=integral smtp.mailfrom=integral@archlinux.org
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Hu <integral@archlinux.org>
Subject: [PATCH] bpf, x86: use 32-bit zero idiom for shorter encoding
Date: Fri, 25 Sep 2026 00:01:54 +0800
Message-ID: <20260924160154.12807-1-integral@archlinux.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emit "xor eax, eax" instead of "xor rax, rax".
In 64-bit mode, zeroing EAX implicitly clears RAX, and the 32-bit
form encodes one byte smaller while keeping identical semantics.

Signed-off-by: George Hu <integral@archlinux.org>
---
 arch/x86/net/bpf_jit_comp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9fbef7504e51..2e3c8e9861a4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -579,8 +579,11 @@ static void emit_prologue(u8 **pprog, u8 *ip, u32 stack_depth, bool ebpf_from_cb
 		if (tail_call_reachable && !is_subprog)
 			/* When it's the entry of the whole tailcall context,
 			 * zeroing rax means initialising tail_call_cnt.
+			 *
+			 * xor eax, eax
+			 * equivalent to 'xor rax, rax', but one byte less
 			 */
-			EMIT3(0x48, 0x31, 0xC0); /* xor rax, rax */
+			EMIT2(0x31, 0xC0);
 		else
 			/* Keep the same instruction layout. */
 			emit_nops(&prog, 3);     /* nop3 */
-- 
2.55.0

