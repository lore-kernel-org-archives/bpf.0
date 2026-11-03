Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793714396;
	b=NnJ6fI+7td1CHFZPF/tyB0zczAk9yyY4AEctEbv/UIcYwY+KkMzSyhRa7Ouvhzycu2TC
	 sDcMDsI6wLBm7lVRU0sb8fuAkC1r2Ls+Nk/Lsmc0MIssM7wN8DSjuDMO3q2S0Du+yEI7K
	 MHsOAKdT1qDYDqzLCONfjWDJHQyrOg3/LyBH7Ov9nXIgfbganB4B1UveHe1qJDTXycMNx
	 brW/8ORkP2RKC6AQ7YD7UKq+Nj5yeP+5XdCRPXZJuc6InJz3FlclKv/aEeDaTmNWjwWso
	 o/Rf9TOjYH8eZYm7A4/dQcwktUmPg8KYLVXwLCtsKcAuViBbWLpVTcr9aw9zf7dt2Ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714396;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fdwV+XH9NvK1Im6ennF2xULO8qxPmM8IB/d5hh95yUY=;
	b=pKxRTm4Njg7semn7huEsAS4//tuw5QsSJ7RQshlIokHwcOTm7tvEVMzE2LEJ18+8U11q
	 6IbAauj0FqsSSkk3QaNiZgbKqR2gemvUvVWzK5ZdR4xRy6Rpeknk4k3MKeOGJzYLorUNB
	 rTLhHGLkm7d1S0dYViUZgwtGeR0SXvPlT7/rEU72spQrSOd3NftzZ/xM9tNqTdE6XEerm
	 z0FxkNtm/ql+pU8ekZNX3eROTVTC9PRH5cf/VYgGyxOex9rZRpszb2niQMS9i7MJ97uiX
	 0Qr1WzdAcxiIxog4QiAAiKrmzKgVwZmd3X7k6wheCe6K/vkJGXQYXOWkH0HQP29kwRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8SFfs3m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C239608361F;
	Tue,  3 Nov 2026 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8SFfs3m
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793714396;
	b=TEr25OPPKq2iDUeb4SuglmShiP5kGqE/lbiqVTQM2yF5QSDqUIKRiPbRfxUJG18yYtPG
	 MKL4K7mGXs/fhItK9fVwPbyyVQL7EI1dDngx7Cl+Gdnj0qcb4pTqoZI0SCLn+69UFWkNc
	 h4ZdPbq7TAN7dsz3mopgfO5kMCnmybqJXtatNKTB/TWed8EofAwfaNSs9QXWXP6Vt4r9k
	 KG73iPhaxmmQYLv6voqmrRyx8REY7cvgP+smEBDBrPIcTUr+duHv74Ni7rZgvSLFMXzcB
	 bGdO+vEvSnP6oNgao6KGn13hLfYxLevuu0fklym8nad/kjgKSDFVqQd+xWBa8a6ohyg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793714396;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fdwV+XH9NvK1Im6ennF2xULO8qxPmM8IB/d5hh95yUY=;
	b=XlcBEAmKRNB00eumKbY/WGzWXaOt2qj9VxCJKFBvrMiEE0zoAqthu36HFDaFdhSPQUL8
	 YY4vwagqYkb3Bv8rFns0hnW3P3XTRnDrYE0oG1JfHC7dlJlI/uIzU8A/KozdVUvrw6E7Z
	 v8va4ybDpaNhFeW+gETPmcnt1RFO2VYv/xTGyMROOb1y05HHmTs+TGeKY1Rb4PIKzPUXY
	 2VhHf7TMEXmsnG+QxuCZ3r07NDbVODh3A8NAlD14mgCEKj3ETiHdOjrNxjl3Eae77JYFB
	 W/4W+SeqY0Ybk9qsJUV1ma6pAH/2H7WYy7g6l/+cNXDqyLvTIM9e3ArAvo0EGpxcR0g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BB2C51F00A15;
	Tue,  3 Nov 2026 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714396;
	bh=fdwV+XH9NvK1Im6ennF2xULO8qxPmM8IB/d5hh95yUY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=B8SFfs3mXyzGQYuIw8pJl698NuP1cvwqVxbhzbVpyOQvl1lgaSZ8S2Dxd6Lf7GdGw
	 VDW1raWBoN3rJIjKzSR9WCEBCs3KMm+UwyQAv3gl0PLkSprjG6CwqwYMyTFhoTb2k0
	 CTF38Krq3dYx9s0knfksITj7nVYVazLWcnngkA/VgjcdWzZFWtAXfY05i00wE7l87K
	 Rt/tjdPtMaDvuCtehRkZKLz0RuAKq1Re0hv4aH4lgxOkTR/vYN/Nz3P2vLP2tXRXXJ
	 hqQm6XRmpDKwXUOsDrYqh05HZbfLL7qIqSBQqXdZef+06rVM5WuPgzEE818ZDzapeP
	 CVYOtpPWiHq+A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2CE6A46966;
	Tue,  3 Nov 2026 13:59:54 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 18:59:53 +0500
Subject: [PATCH bpf-next v5 1/3] bpftool: Fix disposal of the LLVM
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
Message-Id: <20261103-bpftool-plugin-v5-1-683e08a25df0@gmail.com>
References: <20261103-bpftool-plugin-v5-0-683e08a25df0@gmail.com>
In-Reply-To: <20261103-bpftool-plugin-v5-0-683e08a25df0@gmail.com>
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
 Nick Desaulniers <ndesaulniers@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 Mark Korenberg <socketpair@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793714393; l=926;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=WFtOq3wdcmZOoH/EhJgh2UIYAu0AaQ6cH9OmA9+kaSo=;
 b=hTCTXZ6eoCML/m1GjNTUVVsHdppz6wlw86fD8uroJrgV44vs3OkUJ9FzaEK2Wmxgp0gqzW6wt
 QJ2H5pwW5ohAsMV1chrBl2iL2VDJeATAWWtAV4uNP1rJgS0JHr911Ng
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
index 04541155e9ccc..5ff144ce84a1c 100644
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


