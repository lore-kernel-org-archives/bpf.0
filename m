Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54295489FDD
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913045; cv=none; b=Td0e+iS3sqivlkmGl3wgCIcsTMIcK4pFM6VtxxcuCIUs+oUZNEoJGZ0OaRKie6DkeywO9yVtkMS38Y5eEeZV3SE5qVk2lsYNAI8QgMRkEq/BgQeLgfbqAX2Du0DYAenlcji6Hy8jgPVJ7rrUOT3tCiGEI8a1DI040fIPzIlELx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913045; c=relaxed/simple;
	bh=craGQw/gkyetVOPP0GCZji5pj5+6BO9lvwrE8TSuopo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzI6W0XR/59eX183ssMcEdBZTVeeVPv9pa62j+O3+NAAL2LUiH9oD16rWd+FMp0IUDmhLpee5stPBoiSGvQkzbOfKmQkkscBaHycNhlZkMYuAqY5DhxiNWNgXs7DSB4oBzQMyC2Y5qb0DTNY0/qUOyOIHdW05h95ut1z/eBtodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=h2p9z3B0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="h2p9z3B0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hm/le/4gMBQ1ju84mS5rJv1XDNOx5MV4pG+rqeYmkPg=; b=h2p9z3B0gOcczMtVHt3vIhd/5V
	nhanvAI4sR46wT6ZEZ/D15kq9iNIKWrEsSKAwWPisXn4Tbc9V3uVTLzfiKargiWWJK6uGm4r3quZc
	652v7kjg2l8lCHY0G/154lRia+F3gT0v5Om3hdJC+WH2IwJtlkTMqgtbFZPQYlsf7Bk9ntC5EU8g5
	BqnCafN1cZHJUfWYBpxjjUkCfZbIARFB8eTTPumxeiJoVXr/+14LQaZLW+cdqHpXQDi5+fTR5nMiv
	9iwm+Y2xfwjqfJe3LgctQP65xNoeiHPrs5BQgIYzDv9+9IYSQS3keBGQmNNNTnsccfrJJmzzi87Y6
	IyKQzBCw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3D-000PPu-2P;
	Tue, 13 Oct 2026 19:12:31 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 01/18] bpf, x86: Drop redundant REX prefixes from zero and sign extensions
Date: Tue, 13 Oct 2026 19:12:13 +0200
Message-ID: <20261013171230.523677-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013171230.523677-1-daniel@iogearbox.net>
References: <20261013171230.523677-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28152/Tue Oct 13 08:26:14 2026)

movzx into a 32-bit register already clears the upper 32 bits, so the
REX.W prefix on the 8 and 16-bit BPF_LDX loads only costs a byte. This
also matches what the arena variants of these loads emit. Likewise,
the 32-bit movsx from an 8-bit register only needs a REX prefix when
the destination is an extended register or the source is sil, dil, bpl
or an extended register. LLVM emits these loads for u8 and u16 fields
and, with cpu v4, the movsx for a cast to s8 or s16.

Before/after for r0 = *(u8 *)(r1 + 0):

  48 0f b6 47 00  movzbq 0x0(%rdi),%rax
  0f b6 47 00     movzbl 0x0(%rdi),%eax

Before/after for w1 = (s8)w0:

  40 0f be f8     movsbl %al,%edi
  0f be f8        movsbl %al,%edi

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 083fcd6cf15b..adec4f8e422e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1106,8 +1106,9 @@ static void emit_movsx_reg(u8 **pprog, int num_bits, bool is64, u32 dst_reg,
 	} else {
 		/* movs[b,w]l dst, src */
 		if (num_bits == 8) {
-			EMIT4(add_2mod(0x40, src_reg, dst_reg), 0x0f, 0xbe,
-			      add_2reg(0xC0, src_reg, dst_reg));
+			if (is_ereg(dst_reg) || is_ereg_8l(src_reg))
+				EMIT1(add_2mod(0x40, src_reg, dst_reg));
+			EMIT3(0x0f, 0xbe, add_2reg(0xC0, src_reg, dst_reg));
 		} else if (num_bits == 16) {
 			if (is_ereg(dst_reg) || is_ereg(src_reg))
 				EMIT1(add_2mod(0x40, src_reg, dst_reg));
@@ -1273,12 +1274,16 @@ static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 
 	switch (size) {
 	case BPF_B:
-		/* Emit 'movzx rax, byte ptr [rax + off]' */
-		EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x0F, 0xB6);
+		/* Emit 'movzx eax, byte ptr [rax + off]' */
+		if (is_ereg(dst_reg) || is_ereg(src_reg))
+			EMIT1(add_2mod(0x40, src_reg, dst_reg));
+		EMIT2(0x0F, 0xB6);
 		break;
 	case BPF_H:
-		/* Emit 'movzx rax, word ptr [rax + off]' */
-		EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x0F, 0xB7);
+		/* Emit 'movzx eax, word ptr [rax + off]' */
+		if (is_ereg(dst_reg) || is_ereg(src_reg))
+			EMIT1(add_2mod(0x40, src_reg, dst_reg));
+		EMIT2(0x0F, 0xB7);
 		break;
 	case BPF_W:
 		/* Emit 'mov eax, dword ptr [rax+0x14]' */
-- 
2.43.0

