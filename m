Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592747;
	b=KEjUq5jZnZ9zGHVjYAiepk5ugOwakdWtvIwfJ4WuHW/vWV2S+ProtjigVQVQA891lL9L
	 NHwltsYcYD6A/VrzYLMBHNitzngVc/CrLu16MAgt41TubLwNyS9Q0hSHC2bJG6h5402Gi
	 ePlVaflnG//Bt6eEyDw4CFbFZZl6xaSuLx+gzKGswZJXPHL7sgN2Yj0/9mboYZoWynHLg
	 jZiFrR4yaxX0OEciYw5Stvn/JzmaZKvAd3/79nD2vkxHZNI5wtBEsthU3PEX1doJGsYAr
	 gYickiHzpZFFknUNjC/o0g/cIi2wsiuZDU7pQ3zUnG1XaXUVmZxaZcjHWASqZU+NGmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=IbtetBGyMqW5A3czeRcso0j1DlFdB0qPnYKKYAmHO90=;
	b=qwEAtm9MmRwXuo/SdSpi0lFbg/ruZq3QujNz028pdh0mwDIdcVgdFFKJkUFz9FzQ+uIN
	 YTcXZPrpfJsgMH1/FX5HCEHjMIEQVsiSHNvugnMFuxQTABJlGBy3lUMHF9UzdggAEy5a0
	 qajzMFB8C9/qtXBwLq6MmwJDM8ytaPCzEqECVeW6H6x46HLaI9cjBIl30gNbFveX3LSr7
	 tsC1JV13boCIHscvOvtiFQ+jY1l8Q2dmOVDKuuNLNzuNPP6ZXuLr0blu5kKzEj1WF3qfa
	 4xoE3wlyv3gQY2r86B1Gzr+7TG/YEEVTOa2pEMPeo44K2pERivuaXL9MyP7Fc02Xniw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kNhKwmYj;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F647606A323
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 14:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F647606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kNhKwmYj
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f30660e69so49748985a.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 07:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592745; x=1793197545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IbtetBGyMqW5A3czeRcso0j1DlFdB0qPnYKKYAmHO90=;
        b=kNhKwmYjUU5prWZe34EcLasG4mmTDiVoMpOqk8MBCLiHZhjxTVhrnW714Dn06a6AmC
         izJdA5C/B02oE85MNOd5iCRaZiFZLxtsQ7w4pe72oIygmM8FUQoZ6YrnDp01mdysn7f8
         ITPwB4S5g76bIMAXxBOQ5M19MyAv5G9vMJK3+BqvKH6teukqdf6VSZF4v3BgsKqzTDTP
         caIde6HS90dp6VuEIxAx29yKWnO4BA9vAXSJaa3ayfxRKpn2VE9pj11eHIaSsRnXu2mv
         yAqgEQgGKge4j943tq7dmRR1E9EHKx1eW6Y3/enHlRFF8eO/RodNOf8pSeNL8v7Vv6CX
         Zt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592745; x=1793197545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IbtetBGyMqW5A3czeRcso0j1DlFdB0qPnYKKYAmHO90=;
        b=2FySt7zvuj+WLMJ8vNpGSHPfLz4kFl3mDGqQzjgVJty29QeE2KQt1vNg8cXey1Heij
         /S7X/it5n21k42bsOSnZy6XS7BO39VlYNSJEN9JeSC2f67sMjDkcySs3wImSlP40xRtx
         NPDe66nmZZZbWAKlCENxWI4/s5Qs0NmAY2e+ADSzSQKcdPuSm18ob7FDMxn5yncvoFCT
         IvKir6P9s2WOGDHMllW8HqNpXYT60kC+Dn+vYQdXXyZ1F2zDpBx5ddn0A/OYpH4MfLx5
         s87jEvIrRzXc7tYGnMGwR/0kmFSS0/SQEmDqPNpDLQeXNVzeGupawo+s9m7wsSP8fK+i
         PLPg==
X-Gm-Message-State: AFq9FYIcAN1rpvtZcnnMHOAfJuTOBT3aN2u4XOGRtv6cickHRwkxFF+3
	ZKLcAvQhsVIqE9aEuyttCNujlVqrFZzgzYV4bIB0c3pg8EUdIZdnXJTC
X-Gm-Gg: AYBFou3TjLFgV6hgiUlhbmNatM7QL+R9XSKXQn9FcnILxTeZKOqhbmXrZIHPIDZHFun
	SV9Wu2XPokce2LYCc7muGUjqFqbWXsS9W+t8pECvxICpAIeS/u8+LZPU9vzAy9tk7vntsjDZHgg
	scpXH5ffKsmSH1hmGcq/bvMV+NK6D5bTAMz1AKMtY/VXpAEsGb1xlEDFFEFeDrrWesp3WyRJTjC
	v+AdtpCdPOihNV7U2+0WUVlRReUej4szaINr9epmYndFFv3FXuET+rDpadHVonIZmJUwoXFNkIM
	Df/1WHfzk1dvi/C+/Hg9GY/9FIU2JE9DASOjcnlaKfVz+wACftE43aJ2UhJgi8uBYL9iOWIRn1s
	AqRD1jmPRw9DBUor2+oGm2zcAqT52bCfxbVLoXNEOX5v2oZ1CWTAL3OMhHyZndBfuc0IER95ZWB
	yEZXeyxe6G99JklYCxvmbdtpEr1VJMLVWbEMbN7px1cbChSEOHNKt01d48oKuAcHJqMJZnvwMLe
	fKtMof5z1Cos+SAWUmCg2bwRDBJ8Ttxo2fju9cJbWtJ3A==
X-Received: by 2002:a05:620a:439c:b0:93f:1936:b206 with SMTP id af79cd13be357-93f57f81856mr411059085a.83.1792592745359;
        Wed, 21 Oct 2026 07:25:45 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2bee2sm261474585a.42.2026.10.21.07.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:25:45 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 21 Oct 2026 07:21:32 -0700
Subject: [PATCH bpf-next 1/2] bpf: Stop JIT passes only when no insn moves
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-jit_size_fix-v1-1-b89fd32cafd6@meta.com>
References: <20261021-jit_size_fix-v1-0-b89fd32cafd6@meta.com>
In-Reply-To: <20261021-jit_size_fix-v1-0-b89fd32cafd6@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792592741; l=3015;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=6KmNud59wub05Eq8z3Fs8QCfOhenV5BlJMY16U+Kmns=;
 b=2FWtec/0Gxze7O379lLLTYomwH3fOFkeKeXDyC/OTlya09TCO9KcO+y3oL1tN5vV+T/uOl5r+
 MhM7yTOfepJD7QcNR9x3SZVAa32PPtaLAnCkTlmgmZESHNwBlD7jXsk
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

A backward jump is sized from its target's current-pass address and its
own previous-pass address, so it can grow while other jumps shrink. Two
passes may then give the same image length with jumps still changing,
and the image pass fails with "bpf_jit: fatal error".

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 arch/x86/net/bpf_jit_comp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 6a2fe3d0039d..b483cde866d9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -355,6 +355,9 @@ struct jit_context {
 	 */
 	int tail_call_direct_label;
 	int tail_call_indirect_label;
+
+	/* Set when a pass moves the end of any insn */
+	bool addrs_changed;
 };
 
 /* Maximum number of bytes emitted while JITing one eBPF insn */
@@ -2574,6 +2577,13 @@ static int emit_unwind_ret_addr(u8 **pprog, u8 *ip)
 	return 0;
 }
 
+static void set_insn_end(struct jit_context *ctx, int *insn_end, int end)
+{
+	if (*insn_end != end)
+		ctx->addrs_changed = true;
+	*insn_end = end;
+}
+
 static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -2702,7 +2712,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	if (rw_image)
 		memcpy(rw_image + proglen, temp, ilen);
 	proglen += ilen;
-	addrs[0] = proglen;
+	ctx->addrs_changed = false;
+	set_insn_end(ctx, addrs, proglen);
 	prog = temp;
 
 	for (i = 1; i <= insn_cnt; i++, insn++) {
@@ -3930,7 +3941,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			memcpy(rw_image + proglen, temp, ilen);
 		}
 		proglen += ilen;
-		addrs[i] = proglen;
+		set_insn_end(ctx, addrs + i, proglen);
 		prog = temp;
 	}
 
@@ -4977,10 +4988,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 skip_init_addrs:
 
 	/*
-	 * JITed image shrinks with every pass and the loop iterates
-	 * until the image stops shrinking. Very large BPF programs
-	 * may converge on the last pass. In such case do one more
-	 * pass to emit the final image.
+	 * JITed image usually shrinks with every pass, but individual
+	 * jumps can grow, so the loop iterates until no insn moves.
+	 * Very large BPF programs may converge on the last pass. In
+	 * such case do one more pass to emit the final image.
 	 */
 	for (pass = 0; pass < MAX_PASSES || image; pass++) {
 		if (!padding && pass >= PADDING_PASSES)
@@ -5010,7 +5021,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			}
 			break;
 		}
-		if (proglen == oldproglen) {
+		if (!ctx.addrs_changed) {
 			/*
 			 * The number of entries in extable is the number of BPF_LDX
 			 * insns that access kernel memory via "pointer to BTF type".

-- 
2.53.0-Meta

