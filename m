Received: from mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF62B4CA77D
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358861; cv=none; b=EoNE4jBbz+eCpegRPNTAf9iR3OMs4ob7ib2rmPWEUB16Yf2FHhWJuhGPQubZmDIA0G69VQtj/BRQ4bg07v0CsnoYzk7VA9BIfvVIR5luLcEKoDBhy4ad/bs+JgsqaYqUAiyDB2AuZX1kxjos9YbxLfFon4o/nBULj3v2KqwENgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358861; c=relaxed/simple;
	bh=p67gamRmEwkUu95LFXAoYMitz/njw63lJRtWJbeZLy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j8mPkeiLBcqAR7kWng8IlHawBeyP6oSFIlV5ujoNvjS/mGVVWeweeru/VFbOkQ/tizUIzH2mpOuvd+bAghUrqI45X5ZH2D2yATufTOJIpbAlk+F6F+mdqzIPLHJwbE7rTjam6iPHpCFWgDjvCLe02VIW0ohCHsH04WdfWrcGtzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QRcboaoz; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QRcboaoz"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=p67gamRmEwkUu95LFXAoYMitz/njw63lJRtWJbeZLy4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790358846; v=1; x=1790963646;
 b=QRcboaozLKaoxFUSBaCGy4b55IgVhMVaDeRoLzRLhmMlTQCQug7GTvIT4+z9mSLEqs8OWMG0
 b7UxkZBt47DeevV1W8PhHXtOJjSnJ7ZzdxmxC6RaoVn531n9GqYHqKTGUcGNWDcXcfB89QTaqt3
 pN9c9bPZ0ArbNzZxeTkxoG8U=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c0aea6dd7cc8ad8e;
	Fri, 25 Sep 2026 17:54:06 +0000
X-Mizu-Trace-ID: c0aea6dd7cc8ad8e
X-Migadu-Flow: FLOW_OUT
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Date: Fri, 25 Sep 2026 17:53:21 +0000
Subject: [PATCH bpf] bpf, arm64: Fix jited line info off by kCFI hash
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-b4-arm64-bpf-linfo-cfi-v1-1-e930ab335170@linux.dev>
X-B4-Tracking: v=1; b=H4sIABC1tmoC/22NzQ6CMBCEX4Xs2Q2IgOCrGA/tupVVbMnWv4Tw7
 ha8epyZb2YmiKzCEQ7ZBMoviRJ8EttNBtQbf2GUc9JQFmVTdGWNtkKj96ZCOzocxLuA5ARdTbu
 223NVtASpPCo7+azDR0gonH5mfNor02OZXDBrIqNV46lfrGHMKbyD3ljzNfpzBfP8BektMb+2A
 AAA
X-Change-ID: 20260925-b4-arm64-bpf-linfo-cfi-f5c3897e408c
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Maxwell Bland <mbland@motorola.com>, 
 Sami Tolvanen <samitolvanen@google.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
X-Mailer: b4 0.15.2

With CONFIG_CFI=y, the jited line info of every arm64 BPF program is
off by one instruction, so tools that use it show the wrong source line.

The JIT counts ctx.offset[] from ctx.ro_image. Since commit
710618c760c0 ("arm64/cfi,bpf: Support kCFI + BPF on arm64"),
prog->bpf_func starts past the 4-byte kCFI hash, and
bpf_prog_fill_jited_linfo() adds the offsets to prog->bpf_func.

Subtract cfi_get_offset() from the offsets before the fill, and move
the fill after bpf_prog_update_insn_ptrs(), which needs the offsets
relative to ctx.ro_image.

Fixes: 710618c760c0 ("arm64/cfi,bpf: Support kCFI + BPF on arm64")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260904014748.C04AA1F000E9@smtp.kernel.org/
Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/all/DLNXZ2WK7TPD.2RZBUNRS4FA4L@gmail.com/
Assisted-by: LLM
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
Tested in an arm64 KVM guest with CONFIG_CFI=y. Without this patch
every line info entry after a function's first was off by one
instruction, and with it every entry was correct.
---
 arch/arm64/net/bpf_jit_comp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c5f55d6161fee..cdc98efc1acf0 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2345,14 +2345,21 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		/* offset[prog->len] is the size of program */
 		for (i = 0; i <= prog->len; i++)
 			ctx.offset[i] *= AARCH64_INSN_SIZE;
-		bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
 		/*
 		 * The bpf_prog_update_insn_ptrs function expects offsets to
 		 * point to the first byte of the jitted instruction (unlike
-		 * the bpf_prog_fill_jited_linfo above, which, for historical
+		 * the bpf_prog_fill_jited_linfo below, which, for historical
 		 * reasons, expects to point to the next instruction)
 		 */
 		bpf_prog_update_insn_ptrs(prog, ctx.offset, ctx.ro_image);
+		/*
+		 * Line info is relative to prog->bpf_func, which starts
+		 * cfi_get_offset() bytes into ro_image. Shift the offsets here,
+		 * after bpf_prog_update_insn_ptrs(), which needs them unshifted.
+		 */
+		for (i = 0; i <= prog->len; i++)
+			ctx.offset[i] -= cfi_get_offset();
+		bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
 out_off:
 		if (!ro_header && priv_stack_ptr) {
 			free_percpu(priv_stack_ptr);

---
base-commit: ad139384ecddb6f3e7e3c3c12765aafae0e39670
change-id: 20260925-b4-arm64-bpf-linfo-cfi-f5c3897e408c

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

