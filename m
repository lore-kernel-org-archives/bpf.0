Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577586;
	b=yYyXQ1OSQxtVHc2RIubGTZkj65Op2AhQqAk3C7LlCprwybewH1YUygLNKp/ROP3B+VAq
	 Bdj5o8J0kozjMILWfkShx6xvG8Fl6bDJmxJiQMX2/qGvFMM8os4qWIF0farfvsF+X0qdB
	 jIZz5HF2SmWEB4fkNMIetgn/ls4AyjoTLLXgc/s8BLlFg6WMP6RD97iIBb8U02t1rLexF
	 EfD3UtYm2TPbpqp9q2BWV/k3bOL4eAK/4i50Y1723mWzs0I+EMMPBMmTXzncNC5qTj9/a
	 g73XilXrv07DDsQdCZkgIUbqT50t/t1ECuusAAkjVCR0h3D3O32Rleev4SSlDLPebvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3atTFqNicxw9/2abno5bwtyXJnSjkg6iBLecR9045e8=;
	b=etsBlmOfectvQJMAivsp1huLcKpZkd4s8B5UsPs0I2XV5PAg9xkxiHBJtKForN/Z+0C7
	 52X9o651LmU4gebm+xQgMvZ2XziDOz3zy7v6vo2gE9cB/RXMydqi1CPZUiVD8l++0eWZ8
	 E0w7Ro0p1rt2D6ZmbklYyoknWY//lypKATBGvBwdtyUuL7AVoxzs1zxlRHxVKweopWUQ+
	 AQdUyBOqk2UAfFAGg+pRqcDDmWOUTJ8Qsy6UBzXQHT8vAQCSWvgnc6v451+Uu0/zK8+yC
	 lAQRpB9q0QIaroRmfiHx0WrKCP+S+WXB9FJLujmsdyrtNYkc9+u3aXaat3KTaWnNwiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oXj1gvu6;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6849606A335
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6849606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oXj1gvu6
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f0458cc9easo41424275ad.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577582; x=1796182382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3atTFqNicxw9/2abno5bwtyXJnSjkg6iBLecR9045e8=;
        b=oXj1gvu6iAoTPk2PDFl81HWIlHab4rWD45CHTwQpdQhk66dxozilJzK2m/fCPr5omT
         lc/3EggTeCVKbpVGfj0XtAyoB649OPSCiwDhAxU1MwF+risq8KDEXFeNywmihpjvge+3
         52g8JFemjI0gy+OEcs1M5VndnJ/HcnxYIbsS2ULkaBHDUwJiJxE0d89z/N9tSzt5sBqq
         +J2Fkqu7wVxm5eyrGSzBqs+V2jsSacLYHPzNfEl/F8ZxyXnKTmKrtnzxyM6Rj53nEfqg
         lzjAmwthVlF1sm8osf7Y/dNg20CIJUNVFJ1FXSfILMr4fJR2B6iXQy5u2K7Yb0Zan6co
         Kh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577582; x=1796182382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3atTFqNicxw9/2abno5bwtyXJnSjkg6iBLecR9045e8=;
        b=eNNyjTpcm6LjO63de1pExqNWw6M2iCETgI0xla/9Ghxf48K0ovBAlDoDDtyWM1P5r2
         UqCHuKN4XU9+IgomgihYSDHs/Jl4/TrsgtXu56KxUh6yRKRyZoXGbBjLNbXwYqcjQSSC
         bHxCHcasTWXNqNDn79iOyH9bQ6vjB1qfYpTpa8XAqkebDPm7EZGv3VOi+lh8bqKzSc0g
         U3xEfbMxZN3Rsm9bJUWIULy/BUv3g6Y//vKEUr6+0TCHVp9yeVjp7uW9SN+TyDGdSsgX
         m01ui9NNR/dMLTDSAAzx5esiKjf+UsCOe/AB1oZ57OzqH1Rvw2Jqpk+uKgtFNSFXYWQq
         jstw==
X-Gm-Message-State: APuU4Z/QZm7VWcOhIJ79a52zP2P1kncmPHoS4nLb6bp+chW8ppSCv08y
	2p8nkES5UszQSpcRtlzN3E6KAuEvcqJafIOiJHeNvV9HidgQhlyKKrbS9WP2RLrC
X-Gm-Gg: AZFdTZdvuEZeo9XfVRaBJ6lbgqx7jDaTjV37w5g6NUvHxbF1yNG5KZjVZUPhG5PwL1N
	UA7aHSzu/w4CsE5IB78ckMXI4zHJzwzo6ZKg+oeu2aEkx1+97BJL+Kg115St6B4Q9FXzeY2Y5Pl
	OnvtOLLRHe/glEaiDYKwasps3rGuUC0PBB6lSaKEUiALa4ufxVKDgefaIdbvKJOf7jvE5wdcoP2
	8kSsxAe6PLsNA+RPf1CkWGBKnjHWxc2DJUx2+otsSiNhBCVVzuOxNb9e5vWZXyqRXNpPhF4ceOL
	KYQt3H1poF4YNhw3zNVgQMXN+VTuyw/rAdBun8HUlayvPlrkHkRnRICJApqvjbAwyNM4HmkToXu
	/BVeXkpLpyT3UvmKxSO4bI8ADt2gGeTFzZZpgfdsUmrt9ixS8CEBb2u0KDeCcJg5/+FLC0DSXIA
	10K+8w1yFwqbQNXsep31K+Tm7CmmEFzETcdb4CKTV0jwBR4WXsj0ryvHPaa/YHujwIc6AiUzK1G
	WlEL5YdGonwOIMyv3/7YxOuFet297ax1baOeN6qdqaS4PGNA6lFTIw+QWZg4F/OLr0hin9YRDby
	87MMS8ENzRahRNel7c0Dzrs+2Amr20Fm8Nb6l8Xqk702kCw3bYY10/ZHw1ToZoPgn/k6jMm+3gr
	u2lGAZ0o8Qs2jfuFsyztO/Bin/iKiIueSSgOJQFKHZUdyFTkAeUw7cUYhxXEKtHebSViogurwSg
	==
X-Received: by 2002:a17:903:198e:b0:2f0:3b8b:9160 with SMTP id d9443c01a7336-2f03f1d3714mr162515925ad.44.1795577581725;
        Tue, 24 Nov 2026 19:33:01 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c88sm77688285ad.56.2026.11.24.19.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:33:01 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 34/47] bpf, x86: Do not use the paranoid ITS thunk
Date: Wed, 25 Nov 2026 03:29:25 +0000
Message-ID: <20261125032938.670542-35-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The paranoid thunk completes the check of a hash, it traps when ZF is
clear. The JIT emits no such check. With paranoid FineIBT, the default
with IBT and no FRED, on a cpu that has ITS the kernel oopses at an
indirect tail call, at gotox, and when an XDP program is not in the
dispatcher:

  CFI failure at __x86_indirect_its_thunk_array+0x3d/0x3e

Take the plain thunk. its_static_thunk() has no user after this.

The miss of the dispatcher is an indirect jump to bpf_func. FineIBT has
no ENDBR there, with or without ITS. Jump to bpf_dispatcher_nop_func(),
it goes through the preamble.

Fixes: 4f9087f16651 ("x86/cfi,bpf: Fix BPF JIT call")
Fixes: e52c1dc7455d ("x86/its: FineIBT-paranoid vs ITS")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 4c3e09d98131..4411fa667027 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -683,6 +683,12 @@ static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
 	*pprog = prog;
 }
 
+/* its_static_thunk() can give the one that completes the check of a hash */
+static u8 *its_thunk(int reg)
+{
+	return IS_ENABLED(CONFIG_MITIGATION_ITS) ? __x86_indirect_its_thunk_array[reg] : NULL;
+}
+
 static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
 {
 	u8 *prog = *pprog;
@@ -691,7 +697,7 @@ static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
 
 	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
 		OPTIMIZER_HIDE_VAR(reg);
-		emit_jump(&prog, its_static_thunk(reg + 8*ereg), ip);
+		emit_jump(&prog, its_thunk(reg + 8*ereg), ip);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
 		EMIT_LFENCE();
 		__emit_indirect_jump(&prog, reg, ereg);
@@ -732,7 +738,7 @@ static int emit_indirect_call(u8 **pprog, int bpf_reg, u8 *ip)
 
 	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
 		OPTIMIZER_HIDE_VAR(reg);
-		err = emit_call(&prog, its_static_thunk(reg + 8*ereg), ip);
+		err = emit_call(&prog, its_thunk(reg + 8*ereg), ip);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
 		EMIT_LFENCE();
 		__emit_indirect_call(&prog, reg, ereg);
@@ -4675,6 +4681,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 
 static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image, u8 *buf)
 {
+	void *nop_func = bpf_dispatcher_nop_func;
 	u8 *jg_reloc, *prog = *pprog;
 	int pivot, err, jg_bytes = 1;
 	s64 jg_offset;
@@ -4694,7 +4701,11 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
 		if (err)
 			return err;
 
-		emit_indirect_jump(&prog, BPF_REG_3 /* R3 -> rdx */, image + (prog - buf));
+		/* With FineIBT there is no ENDBR at bpf_func, go through the preamble */
+		OPTIMIZER_HIDE_VAR(nop_func);
+		err = emit_jump(&prog, nop_func, image + (prog - buf));
+		if (err)
+			return err;
 
 		*pprog = prog;
 		return 0;
-- 
2.55.0

