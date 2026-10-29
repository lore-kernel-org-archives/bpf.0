Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793277820;
	b=mITHNMGIqnul2SDew12Wliaqjp9mem/RiFHQ35+7yfdcwzYtvgdUSGejhB0lJmpclG7v
	 wbswqx/NG/tFwPNvLL+N3LM9uq5pQ5xhlm8ub9zzMgJkySrpgayxQXh7I2yqGMhJ9ZLD0
	 4IwLkqe6GbO4j1y6myDvRX5L6K1CJjRxr2oFM4LeXyQjTG91Wgfd0jnhSDavKDEoEQYMG
	 zrfy7Zw6n+26TGMlrHt/6x5rXbOBgiD5xrgxz4M+vSNZruTIeTZFlLgm8EmWFb55aXfZt
	 3US1I9ouLgIU7nRn+32tR1xrTe3d/aW3CoZucgqWL4HK74EGdo1RybKkL5D1dG8/1Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277820;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wQJ0T9iVe1s2es6a+GeIR8KtHKblqFsrngbXVEJ2S4E=;
	b=r+muiPsBJvwywTzKHpcyLgbFgpFpJ32wfvpfoffl5YGb1g18d54KrZ5NQkz6pekWjjHp
	 SvljQJCO3ddrBSX12XNwbyz27Sk9NTB1K9uoRWGvLkBNsKagqz7DEACik+XKXWY9Qw3Y6
	 EuEwpD4NGXq59/FidrAPueaeqhiQZSnfrDd8HoNYR2MwX4YgUNgcts/MUMzE9tH2Upc0v
	 +iOGHesgFSVRt5EfKieRWaRuE5/Etbh0AY5eUZb1yI5/PxW29vUcvjugPwHhNRoo8yn44
	 Vs8wfSu2eya4lteCz2Fm2oE8cPSOErTl6r2L3O30UZrBEsLOs6CYQYV7AXrKw7nL2Eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9iAHg2L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3221606A31C;
	Thu, 29 Oct 2026 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9iAHg2L
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793277819;
	b=W4tYeMVMY/kQuD7GUPHFJefsaiIc0/gEMpMKcDT7id1X1ceZq89a+xxjYO5nt8kWnber
	 iVqm7JaKiCc+wtcQ0YQRiD2kzAj8sX1VJslYOyoviCMQ+8hgIGxspdM1tGGMOXBkPaN3A
	 qbA9vgS3SLFcOJMSmYxpsDhUW+bACdPO0uTeeWQNQWD1VupRxjTKxDu1dPr0/F3xIIHq1
	 FAWMAypjlJxT1OnsbooABdXhQdZJFdyFLaP++gTPYybjxXxl5V9xphznslZDHEwu+3+dP
	 FmzSYiEiHiYjvfviQgA1jhyeN/lT7MPdV4Gwr0iaKHqke3wyAoJU/1ie04UsgtnQ1bA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793277819;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wQJ0T9iVe1s2es6a+GeIR8KtHKblqFsrngbXVEJ2S4E=;
	b=QoJpaxLaND/pcYN3S94SqemtFSpMUKHXuq57oDNRK1/KgL2qpvh3rIGCBv2F4ISOYJ9s
	 NDymAl8FJ5DbzXCb3SuPE3TfDafKqi4QP1uGilS1JiJsJz0blBTP6RsD2B2NiZrHD18u3
	 dT25bP+DeW3mr7TsHRKCk54+2EJmcQhrPjscFKHOqF2qBmZBvZnESGjffoRV4Kr4Wsgxy
	 O3EjSdDHhxOnxu/cM6/Jw/LCUOEL3GNN8dy2cQrXUP3m3a6KMgoumB65eS/W27st1sFuD
	 4eLV67/AJYY3htsZ54/PFEpfaCBL3YIYtNwr/pem8lTvxjKE486gvI6p1XFxL+I7lVQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DBAB61F01825;
	Thu, 29 Oct 2026 12:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793277819;
	bh=wQJ0T9iVe1s2es6a+GeIR8KtHKblqFsrngbXVEJ2S4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=H9iAHg2LidJdERooqQd15jldIuPAenlE7FlmK/d5M+QCpGI9CwWhb87pyASL2maJV
	 zAOQdexJXQ7/9wse5lFA+++OqEJ0HN+szKz+F+PY/wy65AItGm6T/9jLt5zjs/oDWV
	 Orv76h6N3dSFfkWw6PuQXbwvPlc9+2Yds06fJHNsvrI+0M2O2xPTd3PIs40VKQjsy4
	 2yFOxS+Ze0HGj+/hKmwt125w4RcPbeulNCn8NkfZj9mdZge3FoWEaZoROru7H7CrIS
	 0g7fmlzNHRg1fvr+xYPdpLQM31em5Zf1jqyYMO1bmyh/64Zk+cEyh/F//g8YjWx6bH
	 h0XxEDNBK2T1A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4DC8E45846;
	Thu, 29 Oct 2026 12:43:38 +0000 (UTC)
From: Mark Korenberg via B4 Relay <devnull+socketpair.gmail.com@kernel.org>
Date: Thu, 29 Oct 2026 17:43:18 +0500
Subject: [PATCH bpf-next v2 1/2] bpftool: Fix disposal of the LLVM
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
Message-Id: <20261029-bpftool-plugin-v2-1-1a47b2391b0b@gmail.com>
References: <20261029-bpftool-plugin-v2-0-1a47b2391b0b@gmail.com>
In-Reply-To: <20261029-bpftool-plugin-v2-0-1a47b2391b0b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793277817; l=924;
 i=socketpair@gmail.com; s=20260603; h=from:subject:message-id;
 bh=X2MjSY5tQq8kOSRYHXZwlXNvTlqDdyCp9JF2r6O/Qbg=;
 b=XSUs+HmZc7S3AnWxy6PF2YQn5Gmv8CW+4abMPsLsQaliMnixfJmpBuszp+CAc5xHnLaVZY2UH
 DTPbFI/uuWxBp1q2gvXJZXFDMqLAMFjgjyo+3NOr3oYZVQ09S2cXPvf
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


