Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5F521207
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913055; cv=none; b=fmWnuX2mtvviIng1kLYG455oplv7+RW/oQWh0QjG9QQKgCpH6kZnmiAx+U1uzfdl2oTwqVvboV42FY7hCFYCOQLVxDvh7Hjm/sdbeuP9BqoUGPmTHq9f11LhCrp+HpjYOQDxcMa/Wp0eURg2niB9N8TaOnSwlSCAg8K4rkdsneM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913055; c=relaxed/simple;
	bh=ykhfEod99WJQrIO44l27aOApcieua4/mpHFIRC3ujwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQIZsTQubuJGOe5qv3GdVdNPuADnVKcxL/i8aS5v1XdVUp/17MkoLeQisv320sgv3LREo6U5mN4Ks+iilvYrfrfiOJwF2vfVWyLdlysPKQtuIbi2jnDJRhwLV4LUjp/DsjG6tex2pStvliZnI99wwlE8J+BoFtQqB9S/ID4LWqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=I39lsvoV; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="I39lsvoV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+rH1tTffSJjwLooRuw3sQxAjVha4Xcuh0goRNuh611M=; b=I39lsvoVo4ljk7oZGk/TpmzIes
	n3nGo5zc43dqZi7MXXLP7ReIvFiGQQmVAMym4077HvXftlgegDMcKg39XMlF827aeriPOQjP7pVs3
	BVnzhXYeCd2ZOGXL2M82YJ72QwuKY6/F+Dipsr1Ilm/HtDfALp4sPxtfijPiCvc50OnFSUkUTRe+8
	VM2VHYczgUexFfCpBWGFerxwo/tIZ6ZORrEYFqgRh/Lj03jlLgo53fHjUqUvRlONu978rdUeZKdeO
	tzqv4BxsAHDfkHOx1qdwJGywk6UjAUChCvdheHI6dBRPhRagc9tIAFF0JrUrsNOLFxGWBNkvsikfD
	sbGB6kTQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3I-000PR8-1p;
	Tue, 13 Oct 2026 19:12:36 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 09/18] bpf, x86: Swap 16-bit values with bswap and shr, not ror and movzx
Date: Tue, 13 Oct 2026 19:12:21 +0200
Message-ID: <20261013171230.523677-10-daniel@iogearbox.net>
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

The 16-bit byte swap was emitted as a 16-bit rotate followed by a zero
extending move. bswap of the 32-bit register followed by a right shift
by 16 has the same result, is two bytes shorter, and avoids the operand
size prefix and the 16-bit partial register write. Both sequences are
two single cycle uops on Intel and AMD. LLVM emits be16 for bpf_htons()
and bpf_ntohs() with cpu v3 and bswap16 with cpu v4, both of which
take this path.

Before, for r1 = be16 r1:

  66 c1 cf 08  rorw $0x8,%di
  0f b7 ff     movzwl %di,%edi

After:

  0f cf        bswap %edi
  c1 ef 10     shrl $0x10,%edi

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1c84d2a02aba..50158d4b85b2 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2596,18 +2596,16 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_ALU64 | BPF_END | BPF_FROM_LE:
 			switch (imm32) {
 			case 16:
-				/* Emit 'ror %ax, 8' to swap lower 2 bytes */
-				EMIT1(0x66);
+				/* Emit 'bswap eax' to swap lower 4 bytes */
 				if (is_ereg(dst_reg))
 					EMIT1(0x41);
-				EMIT3(0xC1, add_1reg(0xC8, dst_reg), 8);
+				EMIT2(0x0F, add_1reg(0xC8, dst_reg));
 
-				/* Emit 'movzwl eax, ax' */
-				if (is_ereg(dst_reg))
-					EMIT3(0x45, 0x0F, 0xB7);
-				else
-					EMIT2(0x0F, 0xB7);
-				EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
+				/*
+				 * Emit 'shr eax, 16' to move the swapped lower
+				 * 2 bytes back down and zero extend
+				 */
+				emit_shift_imm(&prog, BPF_RSH, dst_reg, 16, false);
 				break;
 			case 32:
 				/* Emit 'bswap eax' to swap lower 4 bytes */
-- 
2.43.0

