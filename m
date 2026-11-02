Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793623454;
	b=BIzwqckhPfJI2k7PbS2VyUP//4l3UiHc8obetgGilQbh6YgoeAzIV1D0QBDQWlicDthH
	 ADdFx22o79VM4Q/yntpwChcJduFE9gUplOYwb8cGBa96iX57k5CpkI44CuG22b7gVBOK5
	 I4yc12MWHFg4AuQW0ApdctXarrkq7aZwUoQ/cjZxX2B4uZU5PD6fC8oqdAFLj9HCYsGgm
	 faPDYOngaPKldEki4kPnNG/e8Arrz7ekvgiT3h1/QNTCh2P5g4E1Ec4cY1FHytqrSyH7q
	 0+WqKjOvRSX0NtseUFICDuwgeeHzUKEnei+8m7Vczwb6HlPjW0XDyq3jQHEWeMBi80Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623454;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wQJ0T9iVe1s2es6a+GeIR8KtHKblqFsrngbXVEJ2S4E=;
	b=Paawp5ShtXn0Wjr1EllFYpRqTuXIv4CJnkZFcsW6Vhj88y5Rw6TR9ZJ8NGoxavdiZJQq
	 N0mC4o5qT1+lQ39eCTf6PuU514o2VbB+HYkOu5MT6kDyWncg3Y2SSoggcRoG9yzU/usjY
	 FBN2nRP+bqViqDU61MN3mT5R14i354VaucnWBC7CKYZR/ZSj4gYuk5KFcRXkdwnlG/3Zn
	 rwYlDtxEnBKKi7pPUZQo6NBE1ac5M+vqiHBdccC92sX0g5IkBJGbjGuyod3Ll4SYp7wCR
	 R11wpFZd/U11MHvrbVoAuvfU4iKhDVcuZgB234BaL5umzzTqYlC127xzfGa+eBrL9PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCyK7M3p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05384606A335;
	Mon,  2 Nov 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCyK7M3p
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793623453;
	b=h7iRuLB8fVZml3jcC6xD4lxHWrT7a3shlRkEwTtLBrvEkjTiRNMiTf/JGMVbJsMXXs4B
	 2LTwto0CNce2OxKk+XcEe+P3XMWW/3nu1GFe2CiOX6O5Zptmoe2lBpHrQHlv73TKGXs5G
	 II6H24hlLk7l5qeiqfcKn2OM9XGT9aLLRfPwnEKL3Lr5rilXLee3I+zh2of72LNIm4zbV
	 tRaw97ZzYIxOSRdpYgr3La6GD1QhXQ+UxpZsGTrFVuswp0MuZPi9+5MTtX8B99DCS/wfE
	 kCo9nM+Cm+cvoE0U6LyXn2iSQLRdZQ1gCgVIbQO71GNHSjFJfxI2F+tmM79icGoDyog==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793623453;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wQJ0T9iVe1s2es6a+GeIR8KtHKblqFsrngbXVEJ2S4E=;
	b=BRedWLBOG6TZTKHepY6xyzgqUQEXP1giyofZQi5RMqbqXhNUs+k+RG6Iz+hjktyQihQj
	 2BWhkUvwo4WD9hvVjnk2TBHIXFk7VeAhsoYKcfE1WpJA2gTn2s1Fczbs4e68Dm3vkLyEb
	 sQVxmVcI6S7WHLQ7kq66IDWiHUbfL+IVPtknFQNKP6F0/e/5I+ACX2aUIALF2CNRK8/wO
	 ZEC0h+ueZpclgJiYl3qqYp1e4sbd8gv+U/a6XmJ7kdtnSozIft01LQ9N7sAZTszSXqS3e
	 E14QlvBii+sIykgY5HXw+Ip61xc6fYDhYgwO1kgnV0+DhQUMgGjaKN3m/eXLOCyDkyg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 37FC91F00A17;
	Mon,  2 Nov 2026 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623453;
	bh=wQJ0T9iVe1s2es6a+GeIR8KtHKblqFsrngbXVEJ2S4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bCyK7M3pWm8vLh24YgQJ3anULOMmcAqsM2JTp9FgX+1Tp1Qx8PpnMiIsRcBcPaD6Z
	 B2kPaepxc6ROH395rAIl3rXOho4iZjAKsvgRshI62K5LsbVgdv1tUEOr0MSDEIhHZ8
	 RYVHlPXaL2bPIfqu3+AVdkq//0hJaANbNB9BbF9PY4xzkp0I7qQp1iORiIodhXZZqB
	 YHBHxv7JkUhFLhKlrL41zS8CIxrBxSlBO63rRbguwtmTXzfND9z7EfktPhf5U2wJSk
	 YifTtHMwUQfPvWWgPF8nykSZMq1+k5GNWlq9Gbt1UkTpURV7r7PF+r18jDMHZQxgI/
	 2jaBK2iVZlEvg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A66DF464B9;
	Mon,  2 Nov 2026 12:44:12 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Date: Mon, 02 Nov 2026 17:44:11 +0500
Subject: [PATCH bpf-next v4 1/2] bpftool: Fix disposal of the LLVM
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
Message-Id: <20261102-bpftool-plugin-v4-1-5a853e973db9@gmail.com>
References: <20261102-bpftool-plugin-v4-0-5a853e973db9@gmail.com>
In-Reply-To: <20261102-bpftool-plugin-v4-0-5a853e973db9@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793623450; l=924;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=X2MjSY5tQq8kOSRYHXZwlXNvTlqDdyCp9JF2r6O/Qbg=;
 b=ydyt5APEFRbljm2ndZMLRfGzQajym1e6BujlIbS+hiDo9vLXHVVIy6qHRJH4aM++mXM83Kjf7
 rzjAFVocEstDaBPUITR5x6uQMwRNQiJHniQ8PcC9PXXemmsyB3Rawfo
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


