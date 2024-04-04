Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1018AF4
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 03:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712202453; cv=none; b=ukYr2d27hb2t98SXj/0Xs2RMyXGUz66QpsNi3ZfiA7gAQ8tWAFq3PSR01kUhTg0BwX+X07pnU6azXyWAJHgMwNOlCWZsEih7ENSYT13saGe68CSaCTSpdw22MXLl7z6/sYSkAWLW3jq005hd6j3MTUdYgwUAHQDQgM1v78YTxlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712202453; c=relaxed/simple;
	bh=2hk+tx0LrpMLvowCDf/kysbI9hOfTrDg5223tp3OWPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7fYzqYLuzsa+hzuddBAQauYckjVjV7A5ynOYxZRPmT+nN9hpBa0QfDE2pTjoNTkF4vdet/3SGf43uxPD5lHS0iYzn16+Eqh1kPthci9hVvm/ObGKbN7hL/DL9Fe9OFuGvaITz7QOYuLxbtpenxyV8/5DEXKXJ7+fUGc8ibJ8Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwECqRWv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwECqRWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AB7C433C7;
	Thu,  4 Apr 2024 03:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712202452;
	bh=2hk+tx0LrpMLvowCDf/kysbI9hOfTrDg5223tp3OWPo=;
	h=From:To:Cc:Subject:Date:From;
	b=MwECqRWvAiZHsZbC4Mo9OrSquyXn1rIIjVJPbwpxYQjpAJtdKOD5b6MzeQmzYxAPO
	 u+t+lNhJO9uC0XtLrX9YUjdrF9p0QAA59CNFageEhDH+N0xgafMjaU4yHV8SujBakC
	 b/1QikroSIOSPSw/JZ9ikjXv7YIy/DVI97cwSsp7EYPCh7rAwgLnA23QBrecmJex3i
	 VjpehlZIBvUT1I9TcQDVpeDibnptdL9YioFsFQF8sd4en5OvR+M6Kcqtmp5r2KAnpV
	 JmM7yDMe7V2ATlolhbeh7FjQf30FynwfO8qnAKtbGRVgCXdKtDhRxRZ9Nu87XOLL/h
	 epL8mPpjwY9mw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] bpf: handle CONFIG_SMP=n configuration in x86 BPF JIT
Date: Wed,  3 Apr 2024 20:47:26 -0700
Message-ID: <20240404034726.2766740-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On non-SMP systems, there is no "per-CPU" data, it's just global data.
So in such case just don't do this_cpu_off-based per-CPU address adjustment.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404040951.d4CUx5S6-lkp@intel.com/
Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index af89dd117dce..964e8154da66 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1383,15 +1383,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 				EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
 				break;
 			} else if (insn_is_mov_percpu_addr(insn)) {
-				u32 off = (u32)(unsigned long)&this_cpu_off;
-
 				/* mov <dst>, <src> (if necessary) */
 				EMIT_mov(dst_reg, src_reg);
-
+#ifdef CONFIG_SMP
 				/* add <dst>, gs:[<off>] */
 				EMIT2(0x65, add_1mod(0x48, dst_reg));
 				EMIT3(0x03, add_1reg(0x04, dst_reg), 0x25);
-				EMIT(off, 4);
+				EMIT((u32)(unsigned long)&this_cpu_off, 4);
+#endif
 				break;
 			}
 			fallthrough;
-- 
2.43.0

