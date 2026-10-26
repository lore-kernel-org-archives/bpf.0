Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983752;
	b=ZpNxpCA3titkR+dTV83Ga4snnxgGHC8is+pIsiNKZFYiorjTTMJbEeumj2Tl+CD+ZDoU
	 I9HwkqS9sASSGKKgfMjGVxNKDDZrAg1tHWcSc4XQnmRPyghrbfhfOXjVKbbrXgcvQ5yW2
	 wGtCaM2VJG80polyZlNLfSXyHEKkSvX00qOgelDMwqHyPpRCB+tcOjvkcKJjejPxkbwJ0
	 +dbLN9REfN8hXR6uF7T8iaPQzD9N/p0csuWvk1NPSK50RK/5SMq6iNJ5ud7J6PePx9Fil
	 ohRuiHf6krsFbgSqmbWcAooHs65O7q1pnyC5vlI9k3clSLoNo3ZlxqFB7PavlKnK1/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TNEku9C+2uj/n6KoVKdNT5htdceroGaZHj5BTlKJDeg=;
	b=LFd+Fg40ddmP1XxWwD7ucZYpi3MJaGIgJPRfP6gby1OnVqajNMk7mNIXr00jVz8Kaubh
	 83Y6Jh7i7yeH8GczjxEcaIbXdXeqW8/0MN10zEwiZyRUwl/FooLzWzJ+Lv20Nu7SbolMX
	 jVQ1jpRpqd8IK7/gx8xZF1EdLvCohUpxPuBclcJslGmRr0fd8oGztdeWZHsJxASoyx6Gc
	 abjbblJy52j1Pd5qPfYf9jbjJnC+6ZZ/gapLfj0aCSN1cbYkcV7nSQfwN6FV0albwGb2p
	 qtPmn3RCYOaGMrB7wWQLLbaHOjKTvDgcUBRA9AlRDJ7oUUvV5gGgzSiGzi1fBOTui4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TLIkNAE9;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1645606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1645606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TLIkNAE9
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3aded3c6103so580121a91.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983751; x=1793588551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TNEku9C+2uj/n6KoVKdNT5htdceroGaZHj5BTlKJDeg=;
        b=TLIkNAE92I9rUBWKjVLpxqouxGfsy3mjhR3fQ+mv7fHnkg4MjSkN21GDPN6JZ/82GV
         b4bDFAhcnv5A9rBkgghZADeFUnEEVmTbINpl3jbp9K0JuCb1XKDYLWXm1F0tfnun5YXU
         kj75+m4954c0pEQgfhcEFkBWHbhF5U+ENGKUOQpn+8t3+Zl4okTd8lcYXF9kzEAKFree
         ZWtI0s6ggEHgHziLUQGRdX6vJa8Rx85wmNZimKaKQHNlXUAqzcqUJpj82GdhWi0Tgo71
         wm0zp3BxoMqfl2UoFSyVQicmLYK3IvGVmxwG2/xMdU1xmZxwXp8FInLKr+4Zp1y/9g9e
         NRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983751; x=1793588551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TNEku9C+2uj/n6KoVKdNT5htdceroGaZHj5BTlKJDeg=;
        b=e2wOrEepLEEKUDAJSTe+bHDR1egKExe8sRkTPMEjSDXilrWzP9MWyfy+k2ez9Zf68y
         PSJGfs5/SkO/dU2RaIao5UZpqn9Q4hqqnMS5/yu4Bd6ZFbFZ+6C+J1j7WjHPLWRbDgQM
         BiPOCUq9B7fKZP+o3MsAk6zliJe4VxJY9rt7NfflD9/zAWCLg0y4tlL77aHF2VSc/DlG
         /ICfPSXcgnVH8LpFT5Ob3d/GUJfpzQClq2ft+anEhJc+UGlbyu0N7RfXqxufuIX47H9S
         M4l99yuluZBdwCQbebHaTfy37XISdvRFRtJVhcIJBuHVzYjWll6M/TrvnrGf1zMVrMLY
         e7XQ==
X-Gm-Message-State: AFq9FYIVjc7/rsZRnDhncHQj/w55Bih5gqd9FUNAZPm9nfAfX151fDK1
	cnfzE6VsdqFQqI/lFxfp/rIAtpxnC5RhW2H+uAbjbIt/jV4EsAAp9N1ZeCWXhA==
X-Gm-Gg: AYBFou2C/j1AGBb1bAQwXXiHBklQqpedkCjSsiCbnQmllI7dLIIXmq9zy0RV94rGtA/
	f6NJK8GgjKkgGRnZUkS13SH5KoiTWwzZlRBTDdp4oAk0IiWBHZ2EXj0G4nC6qqQQ20f3F3b6StF
	GabIvp6KnYMEA2z3rXeqzAC0SneUyDNh4wXz6VNzSyN0Ed7tN1nluIBBhv9ZT146EQKhyreCJC9
	tVRBeCxLEpk5Ks4zDHqELFwJ32viM+o+fKy1dPhb8frWiLAmz1hUTXDfClZXREdbfvQuFX+dtqV
	tx1sDCOxc2tYv7WxXvmi5ReZXfjf2czKpPp58VLr4JFHaozWkQrmEwU7sS6tLHuSolHQHFZ7jAx
	BKRhjWI6QS8gPc9TihNsZAjqk181TF2R9z7Mme3DfYXpMykoT14chlcl46CGkdD8rwjFNPESzhf
	7mYb7JX3DF1ad+F0OhNz9/DZRJtRiZ/2y+Byoql8//rUCqMxIZQIjgw5EDSAu9JYB20tnybobao
	tcjB0KJ4aFRws3af3IBLRfKI56jMRnH3UtuFxTQ57ZME2BM65vWpap/3jAU87wqNxHP2DM4ka6C
	kDoY+57p7BAYk7AHqWACLaBmAKwF820eelSIXQh5XVKy6cOm1c1uJiRrVVlid5FNYFpwf99gPEg
	ze/RgkVehFsWoHInu0jv+Kcby
X-Received: by 2002:a17:90b:1a86:b0:3ac:adce:60ad with SMTP id 98e67ed59e1d1-3adeae6d70amr4397038a91.22.1792983751105;
        Sun, 25 Oct 2026 20:02:31 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6af24sm6228696a91.6.2026.10.25.20.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:02:30 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 28/81] bpf, arm64: Support BPF_REG_ARENA_SP
Date: Mon, 26 Oct 2026 02:58:49 +0000
Message-ID: <20261026025943.404450-29-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

r12 (BPF_REG_ARENA_SP) is the stack pointer of the second stack of a prog.
This stack is in arena. The verifier replaces the insns that use r12 with
insns that the JIT already knows: a 32-bit add, addr_space_cast, and loads
and stores in arena. Thus the JIT only has to supply a register.

Map r12 to x23. The JIT does not use x23 for other data. x23 is callee
saved, thus helpers and kfuncs keep its value. It is not an argument
register, thus calls do not change.

The kernel calls the main prog and callbacks, and it does not know about
r12. The main prog, and a callback that uses r12, take a stack at entry and
set r12. Thus they save x23 at entry and restore it at exit. Other subprogs
get x23 from the caller.

Progs without r12 get the same code. The cost in progs with r12:

  save and restore of x23      0 or 2 insns (stp, ldp). The JIT saves
                               registers in pairs.
  load or store through r12    3 insns: add of the base of arena, mov of
                               the negative offset, ldr or str.
  load or store through r10    1 insn, for reference.

Compile tested only.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 33632fb20997..58f30911bdab 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -61,6 +61,8 @@ static const int bpf2a64[] = {
 	[BPF_REG_9] = A64_R(22),
 	/* read-only frame pointer to access stack */
 	[BPF_REG_FP] = A64_R(25),
+	/* callee saved register for the pointer to the stack in arena */
+	[BPF_REG_ARENA_SP] = A64_R(23),
 	/* temporary registers for BPF JIT */
 	[TMP_REG_1] = A64_R(10),
 	[TMP_REG_2] = A64_R(11),
@@ -419,6 +421,11 @@ static void find_used_callee_regs(struct jit_ctx *ctx)
 	if (ctx->arena_vm_start)
 		ctx->used_callee_reg[i++] = bpf2a64[ARENA_VM_START];
 
+	/* subprogs get it from the caller and leave it as it was, unless the kernel calls them */
+	if (prog->aux->arena_stack_size &&
+	    (!bpf_is_subprog(prog) || prog->aux->arena_stack_entry))
+		ctx->used_callee_reg[i++] = bpf2a64[BPF_REG_ARENA_SP];
+
 	ctx->nr_used_callee_reg = i;
 }
 
@@ -2537,6 +2544,11 @@ bool bpf_jit_supports_private_stack(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_stack(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_kfunc_call(void)
 {
 	return true;
-- 
2.55.0

