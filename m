Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB2470453
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792323243; cv=none; b=tlkThJ7BOqpKeos0jFa2VpYUa9Zejz0E6R12fLolYV5nUY28UhXYO48t2wbBecs9wRAZ7YwBWKy64Gh5ExEM6ALLWdOz9mMzL/J3l8yMCWttyf4kOnylBvgCnICk6nifgJ+/wK+LvrvTsCwYa8Ehe8f//RpIq4tVXNKdQggOGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792323243; c=relaxed/simple;
	bh=FPUZweFaCwCZI0ktH+NvHl4VHzKKZ9VrVwy8cZMs4HY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mF7QmX8rIz+sDdhnWjHZC3sJ/1KXvOMyrh5eZoG3F28byzUdcEIVLg8MAZJaAMi0oT86YRckCT+NPs/Mo8l6GUakJRQipccofz/7fl+FmH7Rova/XEvrdsdqR2RvyiaOM9ssTjuN7oR2JfVV0dziqbpP+Ma2qULT1dNGwYAsR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=i929Jpq2; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="i929Jpq2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=TqviCiafJZiNnsUbwgfGpG4LajsdJ6dW33LgWfMaAj0=; b=i929Jpq2pBtska2EsCltHNt7eC
	YYiyT5FiNnzgWRj0hBbpscv9AmyvdBRRYh5tUOBnhhGv4jDtrDz7SV5MlFm07M/9XmdtYKR27dHGt
	QvyGUYncAuk8m5AUwKfDVHahR85bYYKXYgYrv+bl2J6SUULTsszosxs+kv9Lj9iZvku18pgh1KgO3
	2G4RfPu+iy9sBTGzWe8CAkvPIlg7Wkhef+qhcNPSB3L/vUa2UT4rl3+GcfbXojBBdAs1d3SxaMlQq
	PvPixn0igHmhI94Xzyh9ghzk5DStJm3Dhxo7+46wIPyp8IHwB7uUoHpTPlknOc/Hz5As7pNZQ/F7n
	awjaz0kQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xIP9E-000GM9-2Y;
	Sun, 18 Oct 2026 13:33:52 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] bpf, x86: Mask the shift counts of the magic number division
Date: Sun, 18 Oct 2026 13:33:52 +0200
Message-ID: <20261018113352.730799-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28157/Sun Oct 18 08:24:14 2026)

The kernel test robot reports for a clang 22 randconfig with UBSAN
and ThinLTO:

  vmlinux.o: error: objtool: do_jit(): unexpected end of section .text.do_jit

Fix by masking the counts to their range like rol64() does, which keeps the
shifts defined for the sanitizer and removes the __ubsan_handle_shift_out_of_bounds()
checks. The counts are below 32 and 64 anyway, so the emitted code does not
change. Reproduced with clang 20 and the robot's config without LTO.

Fixes: 02cfd66f3d9a ("bpf, x86: Divide by constants via multiplication with a magic number")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610171029.DfoBvNXv-lkp@intel.com/
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 11a4e4f87aac..d3843045dc71 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2080,7 +2080,7 @@ struct bpf_div_magic {
  */
 static void bpf_magic_udiv(u64 d, int lz, struct bpf_div_magic *mag)
 {
-	u64 mask = ~0ULL >> lz;
+	u64 mask = ~0ULL >> (lz & 63);
 	u64 nc, delta, q1, r1, q2, r2;
 	int p;
 
@@ -2200,7 +2200,7 @@ static bool emit_div_const(u8 **pprog, const struct bpf_insn *insn, u32 dst_reg)
 		 * the add sequence.
 		 */
 		if (mag.add && !(imm32 & 1)) {
-			pre = __ffs(imm32);
+			pre = __ffs(imm32) & 31;
 			bpf_magic_udiv(imm32 >> pre, pre, &mag);
 			if (mag.add)
 				return false;
-- 
2.43.0

