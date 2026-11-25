Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577590;
	b=ckK6vqxJWZ4f69AJbB+jvV/UF/MmV15+ima0PDsTBaPAJU8GurApS1dZJ8TKDRbYhqTt
	 hBNBmAt1J8wnZSun//Xz/uMZ5R0xM86qbq/x0++j+6QHQDx7HwiFxogNo9hsRBb7D9mtf
	 KWmFKdX/GrhK6vgZT6bGX84DskNjkHZlDw6gAp+xEpF6g201uzaFO5UdU71ju+O1i8Hs/
	 bDuN1vBs7skmKKJfPHT7JxSYzQPuP4kPDLvf7vjrDI5XTvVLMyiQ7H52Tq3V5S70eJpVx
	 ru7iZNkd7q0KpdtiQ/gZwR/opxPBlb7IqCZAXeWEC10dwyRZeqlgpT7R0rjxsbhKbBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CSFMHs9pcj+ktTE8CVd+5r7XQ8bR2tav7NY3KGsTLAg=;
	b=Fxf+l3vSwF6J7PHhv8ELqD/SVeo4nSIDqu7lQQzMh57+qVd71EfLR3FKJIxO6GqXyopc
	 j0G8ZaanTAQOzZEmcF9Rp2CPuy39m/c4p3/HnIPDAtHR6LrqZqXdlk1UripiBh5kCSrhY
	 ncoAX+U7Sv4Erlp2an+5hq3EBZr+jP37hP4c9JMHhvXEq9RJyJ3t36Xe9liucGBJtair7
	 x97dZEWlmQesABPmb9Wg//TRm1WI3+AtD4PfyRqtjDW+rkR2SpZAOt+hoNw/XWhjBjBtv
	 tQK8fhYQtkHbK+8QPfYoVbSrdtfTbrjngd8CJVr6OeF/Na6aPO2Twaio4BVbF/5nOwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LP8LYrMC;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A3606A33C
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 486A3606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LP8LYrMC
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f02f04a426so42658495ad.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577587; x=1796182387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CSFMHs9pcj+ktTE8CVd+5r7XQ8bR2tav7NY3KGsTLAg=;
        b=LP8LYrMC2654lWE6GcdxIopy1XDt1FuR6yIVZXBqZjkqJOCtc5edPAoplQRQW6u1eB
         NFzMfjYNHLKDbownUceORV6qtPjhRB09ESvr4fGAx52+dW1czlBZ+yFozobjyrSdnqaW
         1DJVZ3ovwy+Z1BSd/8O+GxtuwUcS1m1hU7DDsF7avpYMF9YFZH3PPx3WrpUbc35kBuRI
         Pkgqr9fIGka5KZROfIS+aELi7g3ScwbxylmESlDl5SWIWNcYFLlxsYOOquVziA2/8l1q
         v+wW2dkRpH2oW4LmdC6h3yqtuf+uBoJBMxs2GiBm98v82rKsjv/Um0LcrGVIgkTXWWfX
         IlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577587; x=1796182387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CSFMHs9pcj+ktTE8CVd+5r7XQ8bR2tav7NY3KGsTLAg=;
        b=PJsVH25+I97qQmkmwM84tat9RoqYSkW85qFBKTKZrmih0R2mdBiJPk3l5prF3+jPZI
         x0JloNoFuX/yuhBRu16EAZKO1PkYyuUd7GVTqhFQbUEEWI9FRVKwoKoGZICvRG0zwO/3
         whmcXh99DpCCj3AniKXl0zj3ul8ndVAAAuGcCI4+Wyg2Mebbmw66ABl1Iyxta7xfN+bz
         EtQUxfc8jvrpviMxxvBvDefzDn6fQCqnATQ3LSJR6GtcknIs0V4oWkWyquOrDejN1NwP
         2gDR0W2WWDfWD1hJy8/1EPpUAKkzpHGlp2p7dGFMLtU+brGldLcqGFHirBudxtwNVjPj
         g6+A==
X-Gm-Message-State: APuU4Z9+ylOlTJuDNINkUPmkGquKxzr+fZ4iCEy8oKbzO1gw1BNs50mR
	CaZR2mr+FaQB5UiPx+ksP60hMNv9SIphKbzzMpBTbMvF2RnJEToETebka9lGxoUH
X-Gm-Gg: AZFdTZflxm/B74qZ4ChoFFR2LwdyAosdRbmQq17JOy7kXCWW/PesXmO1du2LqL8XeR3
	oW0BA3fD4xTqcdKVl6VdgSMAbM3o1tSF7Wtt1cajW9aX8eOsMls4bhopuB3DvEwLx55K3tYaia6
	N6cRSBK1IvFr3lNE4kbDd/Ppi2F9zZtCpzHdNMl0L9i8cYaVJkAP6yt8n9jgvcWSP5aN/t9h48E
	OO3J1ogDIH/YcDLhQD0j8c37x33GnAByqvWPQ2/cSolbvZTE3cxJipnvuSQW/M5BuKYTFZ1NtSQ
	yE3nrSLi6QGNZol+/pQ+WoIO09bvdDg69cSDJn/QdLiktSwtgDFvVmjGB0ydj4L0ctWC40012y8
	NPrZC6RLe1Jsz+O5/mbmjVe80IQ1jLIqF1Og6quwpI1mKTcUHPn+RAXMwtmN6bB+BaCdfux9G7n
	GBx1TCVjmgwC3lIbLppd7GnKtrWWrM5xPykPA3nONEegpGokWReL65LuKKa7JBkKhZQ58vviezZ
	dli7nBGX0sydWEe/nkpF6NbqWccBP0tw2CdFCTlqIUMzeQCWtSKtGS2QLv5T7b7mQrwXQLktATr
	wIgx33Lu242bbBOoVm9iL+fk4DkaKoz8mcfHFsuiZJMWyHlLDbcZhoAgLcVxfftKhX9bPXs5LnC
	0QxBZ5QI/0+Iy9Y2LT61XMA0I8kpHJwfwTX3b925tDexYIKAy+86eOrbvXq5wvjMZxCq6gNPhRK
	Y=
X-Received: by 2002:a17:902:f684:b0:2f0:56b8:e75f with SMTP id d9443c01a7336-2f056b8ea97mr138080745ad.29.1795577587550;
        Tue, 24 Nov 2026 19:33:07 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c2ad2sm77508765ad.16.2026.11.24.19.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:33:07 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 35/47] bpf, x86: Enforce alignment of atomics in arenas
Date: Wed, 25 Nov 2026 03:29:26 +0000
Message-ID: <20261125032938.670542-36-alexei.starovoitov@gmail.com>
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

A program chooses the address of an atomic insn in an arena at run time,
the verifier does not check it. A locked insn that crosses a cache line
locks the bus, and with split_lock_detect it is fatal in the kernel.

Copy the low bits of the address to its top bits. A misaligned address
is not canonical then, and the access goes the way of a fault in the
arena: the insn is skipped, a fetch gives 0, the report is in the stream
of the program. That is what arm64 does after an alignment fault.

Fixes: d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena to x86 JIT")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 4411fa667027..0624290633cc 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1687,6 +1687,23 @@ static int emit_atomic_rmw_index(u8 **pprog, u32 atomic_op, u32 size,
 	return 0;
 }
 
+/*
+ * AUX_REG = dst_reg, with the low bits of dst_reg + off in the top bits. r12 + AUX_REG + off
+ * is not canonical when it's not aligned: the access faults, no split lock is taken.
+ */
+static void emit_arena_align_check(u8 **pprog, const struct bpf_insn *insn, u32 dst_reg)
+{
+	int size = BPF_LDST_BYTES(insn);
+	u8 *prog = *pprog;
+
+	/* lea r11, [dst_reg + off % size] */
+	EMIT2(add_2mod(0x48, dst_reg, AUX_REG), 0x8D);
+	emit_insn_suffix(&prog, dst_reg, AUX_REG, insn->off & (size - 1));
+	emit_shift_imm(&prog, BPF_LSH, AUX_REG, 64 - ilog2(size), true);
+	emit_alu_reg(&prog, BPF_OR, AUX_REG, dst_reg, true);
+	*pprog = prog;
+}
+
 static int emit_atomic_ld_st(struct bpf_verifier_env *env, u8 **pprog,
 			     struct bpf_insn *insn, u8 *ip, u32 dst_reg,
 			     u32 src_reg, bool accesses_stack_only)
@@ -1771,12 +1788,14 @@ static int emit_atomic_fetch_rmw(u8 **pprog, struct bpf_insn *insn, u32 dst_reg,
 	branch_target = prog;
 
 	/* Load old value */
+	if (index_reg >= 0)
+		emit_arena_align_check(&prog, insn, dst_reg);
 	if (fault)
 		fault[0] = prog;
 	if (index_reg < 0)
 		emit_ldx(&prog, BPF_SIZE(insn->code), BPF_REG_0, dst_reg, insn->off);
 	else
-		emit_ldx_index(&prog, BPF_SIZE(insn->code), BPF_REG_0, dst_reg,
+		emit_ldx_index(&prog, BPF_SIZE(insn->code), BPF_REG_0, AUX_REG,
 			       index_reg, insn->off);
 
 	/*
@@ -3409,6 +3428,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				}
 				break;
 			}
+			if (!bpf_atomic_is_load_store(insn))
+				emit_arena_align_check(&prog, insn, dst_reg);
 			start_of_ldx = prog;
 
 			if (bpf_atomic_is_load_store(insn))
@@ -3417,7 +3438,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 							      src_reg, X86_REG_R12, insn->off);
 			else
 				err = emit_atomic_rmw_index(&prog, insn->imm, BPF_SIZE(insn->code),
-							    dst_reg, src_reg, X86_REG_R12,
+							    AUX_REG, src_reg, X86_REG_R12,
 							    insn->off);
 			if (err)
 				return err;
-- 
2.55.0

