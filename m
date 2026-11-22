Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376611;
	b=B2VE8sqaAbIhgFpJIEG9kyJjV1wobc+Qv42dACccvuxlHb4vP9LvTEEhp9YF7Z0kUiel
	 pdOXklCWiBB7KObo53wVXL+4WISPx67m7gD1q90DFgGo9kud+bc5VkiwVtZGVxj4esGK7
	 1tdh7TD5UBUsx+mCP35bJz7RWjXFr+ikoyq7tw3GJvYQKiwkwRSTTBOrEL6Z7AUWlN1Io
	 VimYB3gHUx0qYA0bFELUSSkJAZmnsa5HC77mBikQWmlz0VipoD6LnGWDpCxTsjVN6N0x2
	 9pWW3pKPrSpwKc3fZEU26hw7W8ac+rY7421EtKZpXb2bzBdcUExvdcvr7e80vLJHlPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Kymp+J2o3UsNdNweR6Jcb6B6Bh4mLi4upsmCFa3PCvE=;
	b=hTeDXTi0BbYDsUVHk5Jsnfr/DGZNhvYIBLwsy7DGka/audMQpuY1ebAYbhKA4z0OPVHx
	 BzVHk/MLOXXHit46rTt0/OkjilhSBn0KClvvULFSnsJfq1cnbPmgQRpPGvXyyTFYcuMG+
	 0VRt8sRPxo6i760bwNAUcPB5a3YHUltGlyTcUJWt0axryv1KZFJJiDYEWNV4lZ3XmOELR
	 XvARgkqYSnKPXY4HZuHyqUwSWHGll7pX+JQd8IAZ3BvHjMl+n8e64VXkSZwXG9jEJiaQ2
	 d8p2Y8ZQifGb5GxzAPZi5bmT1MQWfo3RdSADRn9NULq9MUTsQwHfZ1bsr5ALwE+5Wtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lukasstockner.de;
	spf=pass smtp.mailfrom=lukasstockner.de;
	dkim=pass header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VKnLIlqh;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17B9606A31A
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 19:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D17B9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukasstockner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukasstockner.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukasstockner-de.20260707.gappssmtp.com header.i=@lukasstockner-de.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VKnLIlqh
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b467581b98so23569015e9.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 11:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lukasstockner-de.20260707.gappssmtp.com; s=20260707; t=1795376609; x=1795981409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kymp+J2o3UsNdNweR6Jcb6B6Bh4mLi4upsmCFa3PCvE=;
        b=VKnLIlqhRlYX5lXFJpZsvXei+/LaIsGcsL+oBuaCGsebodV6KLhcT6YMWd1BWBhZmk
         lcN49Ah6qzNMHWV/rrIBDbteEeRoNssPiJlXG/udKLlxgFe7Y1sVfrq9q/M6XCFOciHO
         7wm2rMI7i+6b8aZw0eWax67CRdl9y+6YuXQAKvfMddnMy8M6mSgvitrPWi0/VMonv5uH
         aRtibrnYdbY70/DlFE0EI76V1M21InjIYhZYsQM4NZg1bgzF6GBwgQQJEPZA9/A6rZfB
         2xb6+82BmXL8nJMmcPQm9n1g2wy48/98m1BpXiv58Bg50rqzl/8MPhUQzlIiz7ltrGky
         Caig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376609; x=1795981409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kymp+J2o3UsNdNweR6Jcb6B6Bh4mLi4upsmCFa3PCvE=;
        b=t1t00qfQLIarXzD3UF2aChaUWDMUeTbXAUjtZleEnmtxxtnTUf6rrkvwYBg/xJj6fj
         A7wxv1lG0J/BcqCRvWh87ejGuIm+HO6Mc6KWUErIpeigCZHXM3cGY+TPMIsEGutQ0Vy0
         IWqjRSiyAs76XAaBcbW7D8NvqdwSseSo4nxloATZHNrZsKHWw89ciS9UvwvvDZOxRv+x
         5PBAbO/BBYfhaF/XOI2bQraXsmJxcGnLO+oU1/pyZa9t36snySSia8cVBzjYJ/B1YFoY
         TdfHiJnNrIGK8KWClNz5owNQnAB5EwAtBBlUU0SLCsLyn/TQRSdNQL2SpaPJ+pDQFLGM
         NJMg==
X-Forwarded-Encrypted: i=1; AL+hErHvj1oyM2xmvkU6LB4VVlNxXeCcfpaCTdlFNc66fi9ZwT+xTmZHqKpJqb9CT8b2b41kmyg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0g/vpBzs7gAepmCizE/1Nlo+q5WwCx+7vbFZxGsPEjUKyfBn9
	kp823T94DJYCTRcCTYus9shWQzA0eacfpdFlxt4jf8tuWwo/hXh7vT2YA2ctvNpbGZM=
X-Gm-Gg: AZFdTZeDUHt7y1VHPIg0q/35Ma4qEipmTnd2SUV/bJJ4ampqkhPg/OmBAOlvZXmOMck
	UdEk5vJ+eaPCo139Ws30s/hKHO7yUuyGXOHyTT5QUNTTrWDQGjK8wZUoU3zfd1jHWIYs+GFNHka
	0b6QvBTvttQ+q3GizxYLB0E07x+zk/WU0TfCdJwBk2IGUnQcqB4/8aZnVg5gvVNvo80kGVc9Y1a
	7lUqN6q6UoxW4FDA2g3A+/BB/gN1jkWsgwKQghvGF7rNSu4w8q5OmalcIuzZ3+q44/GaGDHKeZS
	YWUGKhuUkDhYYQbqZfsCjqK7b6MdVH9dooefxwKYrY+1VnMBzmLM8CVlue8t4zXkn7pVyrbfhPX
	Up3pA5vvKUV4uXidjVfK1GfXfU+Zfpjcpe90KaPBADGWJysG+79iolnVAe4Zzbbxyh1yQgzYojO
	ykPPHn+B0jyhEKcfZ/wf044xBFUhsyM+2uJVMY01PGfSfHA2lwuDvaqhZ6rav2MEIWgGdAtBaV2
	yy9NXw6YPfdvNErbxltHsWXd+ty5DTLhR4J5mdLJxQIFLuBNvc6xlfWXb5Z2lPJGZ7KWkQEoulC
	uPI6/VySML5RnN7gMLb6yf/DI9ri+pQSCCvkD/wleBkHyFvwBzsTGUIb8inUsGDcAegr5Y6tHQJ
	sng==
X-Received: by 2002:a05:600c:a08b:b0:4bb:6651:9eda with SMTP id 5b1f17b1804b1-4bb88922ca4mr188621625e9.14.1795376609171;
        Sun, 22 Nov 2026 11:43:29 -0800 (PST)
Received: from lukas-laptop (195-200-20-154.mclarenap.oninferno.net. [195.200.20.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442995sm293917125e9.2.2026.11.22.11.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:43:28 -0800 (PST)
From: Lukas Stockner <lukas@lukasstockner.de>
To: Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Lukas Stockner <lukas@lukasstockner.de>
Subject: [PATCH 4/4] powerpc32/bpf: don't fold MOV into instructions that use dst_reg
Date: Sun, 22 Nov 2026 20:42:05 +0100
Message-ID: <20261122194205.218543-5-lukas@lukasstockner.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122194205.218543-1-lukas@lukasstockner.de>
References: <20261122194205.218543-1-lukas@lukasstockner.de>
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

The PPC32 eBPF JIT folds MOVs followed by an ALU operation to the same
destination into 3-operand PPC instructions by dropping the MOV and
reusing its source as the second operand for the second instruction.

That is wrong when the second instruction also uses the destination
register as its source, since the MOV that would have assigned it
is dropped, so the folded instruction will end up using the previous
content of the register.

For example, "r2 = r1; r2 += r2" gets folded to "r2 = r1 + r2", while
the correct result would be 2 * r1.

In particular, this also happens for zero-extension MOVs inserted by the
verifier, where "r2 = r1; w2 = w2" becomes just "w2 = w2", so the actual
assignment is skipped.

Fixes: 19daf0aef84f ("powerpc/bpf/32: perform three operands ALU operations")
Signed-off-by: Lukas Stockner <lukas@lukasstockner.de>
---
 arch/powerpc/net/bpf_jit_comp32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 7414e350d2d4..3ba50d6696a2 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -367,7 +367,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		if (i && (BPF_CLASS(code) == BPF_ALU64 || BPF_CLASS(code) == BPF_ALU) &&
 		    (BPF_CLASS(prevcode) == BPF_ALU64 || BPF_CLASS(prevcode) == BPF_ALU) &&
 		    BPF_OP(prevcode) == BPF_MOV && BPF_SRC(prevcode) == BPF_X &&
-		    insn[i - 1].dst_reg == insn[i].dst_reg && insn[i - 1].imm != 1) {
+		    insn[i - 1].dst_reg == insn[i].dst_reg && insn[i - 1].imm != 1 &&
+		    !(BPF_SRC(code) == BPF_X && insn[i].src_reg == insn[i].dst_reg)) {
 			src2_reg = bpf_to_ppc(insn[i - 1].src_reg);
 			src2_reg_h = src2_reg - 1;
 			ctx->idx = addrs[i - 1] / 4;
-- 
2.56.0

