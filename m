Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793279145;
	b=jgr1SnD+iSwpuvaRHqWwbrBAOzpR/pR0uRKv1SNtr0VeyJO/vNdsICjRvLKHJMMa9xZ6
	 1hs2AYiiErINzYYXfzWQA6RmYrPpPDhIstLzuwVyUz8U6reQMbLY0mjG0ZOQUowEj6+Z2
	 7b2PjYMaQ0/hJEZwV1eqabkumH757TreQdZe50OYjzmU86dTZK6ZPVNFRpwBKq42ukkSl
	 Wr1ca4TZoQNdEgH1sg2YL/pt427GpgOAhLOw+m1SsWBIB9Cmta6I12l6ou3roABc79sJd
	 o/y5R5zXe2kjVGSBwzS6MRBLuA+CEN9Kc1Er2MnPtmJmxGzf3uCjU4euB2vUyl0EoaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279145;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wQJ0T9iVe1s2es6a+GeIR8KtHKblqFsrngbXVEJ2S4E=;
	b=FsVGUnKETHTl4FokK/M2apJPeUWemSehwZkeUJS2o7gSKFP8AI/oz8x0RP/ks0IfKXkn
	 iuYITg3NJstnPzqVe8stLg74bnXmcG/GsQDZm2J51UEenetU4Vha9AtQoZW6EXu0s9lUx
	 TwEBvN68SpPSzoTZuWtmpJegXGaVG4QuOJ585CjjYV1aBL0tk1rSIAAj6GJsB2upIbqYM
	 xdnEqzDWxgePpEzVtX6MGJ4MgfRAgL10f0s7N9oG4l3FC66Kj0giPdxj6wT18javx/rh5
	 2pIWqoqxuNaoM5LVs/zzgz1MQ0nl7/f78mJfVaGGYmO1Qlt8jd9J3YVdQspMNqtIbCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yaj4ivoZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B853B606A31C;
	Thu, 29 Oct 2026 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yaj4ivoZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793279144;
	b=MzSdAchpe5jjf+d7+Sph2NF8Xc/xi97SfGXD8rxO7tC9B0641GeD7aQBo+4ck2yLQxU1
	 jR1nIpCt9rr+rVwNxjCzZjXRSaJ5gAZW4WrfUd02kRwAPCB1LAxN2+Rpc16rJc/4UFLAS
	 1zOsfFr2+fsoCMZ87SshKZS0IoYVAh3AVry+GZ5CFIxkHAygrzEOCABw0IlwqugKYCvAT
	 bsd8vcXXkvmo74zEyTZTWNdD0/DGTnn5CFPTMDSntNaCxTsx2VCOf2K75l4WydKqs8K5l
	 ncJTLkvt+e3XNAIzy9v1iGSy2y06wUHPADItkKmF7mVk/hQWpfYofEPK0ddwU2NQ13g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793279144;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wQJ0T9iVe1s2es6a+GeIR8KtHKblqFsrngbXVEJ2S4E=;
	b=nfgjLUTX1vZdE0/egNj3nveqe/ivoF0tPdCjX/ezuUx1+6AAh8IBx7MaQYqJvCl41tNl
	 X1+kS69QHu6xh8VeB5PEaYpad6kQM0YG4/gGpiblT2KqZkU5/gUe06PHggAVBP567+ja3
	 UDVZyl1JUiu8quCgaEuAQu4/T4+Op8Q6Vdlb7MaO8B61J8XemZSFMSpr03xP7yd+ukpYx
	 jVFXz+1M8aCr4KlIjv5+zfyhwj2lU52znEuUKypxPPZKHa44Md7eruKGxtX3JBm8bX6Pu
	 RhQsv7PRWMAq934MjK3wokF+oJ6uuSBW62CdSjnssPoM6L7tPbt41DE+nYF3MElWW8Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AFD311F01828;
	Thu, 29 Oct 2026 13:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793279144;
	bh=wQJ0T9iVe1s2es6a+GeIR8KtHKblqFsrngbXVEJ2S4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Yaj4ivoZuRfLZ4MwqWd+3c39NmYGT/7AlEHUEF9Cr39uWtdaha9uYO8SIxXlfRILu
	 AfmAGuIjRt/VQN94vrjUyB8gfE4zphMUzHfyIVB2VW6Zjs7myDTpM1TQ9gEfrBb4Sd
	 UwfUMdByJiYU0vzSm9youfVxlt7gMb2vUD+M/8AaStAN5mIe89meYGVUb6F2sA0rm1
	 u+o2CUBB98FrTuINbIoYuHRhP7W1aHXA/KYfYuLh9iTYRqH6Y5+7DcATRs5aGPHhUM
	 bF+h1kekWoYAAYsP/FYM95D0xIzKMAx+hLICooGcvgQd57d9tQ4sHe7g8p7bjASrbd
	 J/jEOjiKBl/dw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3197F45867;
	Thu, 29 Oct 2026 13:05:43 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Date: Thu, 29 Oct 2026 18:05:37 +0500
Subject: [PATCH bpf-next v3 1/2] bpftool: Fix disposal of the LLVM
 disassembler context
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261029-bpftool-plugin-v3-1-87af799da40a@gmail.com>
References: <20261029-bpftool-plugin-v3-0-87af799da40a@gmail.com>
In-Reply-To: <20261029-bpftool-plugin-v3-0-87af799da40a@gmail.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 Mark Korenberg <socketpair@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793279142; l=924;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=X2MjSY5tQq8kOSRYHXZwlXNvTlqDdyCp9JF2r6O/Qbg=;
 b=b08DZ0iD48pu8tDg4b+c6d82tiJC/kqTT2OO8dtPG/mSwLjURVatlZlKpkT4w3M1j4orzPv6z
 9sm2ygCDdjuDXJ3NhYxWEV8an/3Wvaif8bfhU6zwFmlhTAzDBIm8P/j
X-Developer-Key: i=socketpair@gmail.com; a=ed25519;
 pk=2iAMjWhs7kA9X8ccetT2YVX8dvniXua2okQogw3Don8=
X-Endpoint-Received: by B4 Relay for socketpair@gmail.com/20260603 with
 auth_id=806
X-Original-From: Mark Korenberg <socketpair@gmail.com>
Reply-To: socketpair@gmail.com
Content-Transfer-Encoding: 7bit

From: Mark Korenberg <socketpair@gmail.com>

destroy_context() frees the disassembler context with LLVMDisposeMessage(),
which is a plain free() meant for strings returned by LLVM. The context is
therefore never destroyed, leaking about 28 KiB per disassembled function.
Use LLVMDisasmDispose() instead.

Fixes: eb9d1acf634b ("bpftool: Add LLVM as default library for disassembling JIT-ed programs")
Signed-off-by: Mark Korenberg <socketpair@gmail.com>
---
 tools/bpf/bpftool/jit_disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 04541155e9cc..5ff144ce84a1 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -115,7 +115,7 @@ init_context(disasm_ctx_t *ctx, const char *arch,
 
 static void destroy_context(disasm_ctx_t *ctx)
 {
-	LLVMDisposeMessage(*ctx);
+	LLVMDisasmDispose(*ctx);
 }
 
 static int

-- 
2.56.0


