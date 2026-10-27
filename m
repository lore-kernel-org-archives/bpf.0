Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132085;
	b=lyjzbZa+ZRq5rozReNPmPxGZk1Up6srdWCGgFHNGJr3RlJ+mgqzorvXj/+/wjO6pTWsB
	 TVI/Tlob0xUCEG+t/UpJLWZ1ujieZUNTnUBL3hLTeCmrb4e7yt2mX84FoF7Cfda7+SKVw
	 v1QpE6PX3F/c86MeQPNylEgDN66GAIFFxtHWX96do/YW+inlBfOpB0/AJUz/7qFqAqKeL
	 bQcC/7mIsflcV1nW0RaMQmFwgjq5ol417a7uGOF1owTfnhlAkov38mH5SQvmPLf0Lc5BE
	 ZulVtfyF+RRgEaDv/+U7IahHF/QVRpumnAHy7G6wWB36Agru3YY5eIsbmMw/p6YhI7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ESqjTCEySHqE+ygnAQybXyvYJ0e5BRCSG4DiJOenODM=;
	b=rXziLbFg8yNRsjto3wPBIjsnzvX2pGGANeC9E9EdxNHoP/VPrxX5OxQ7njUoqmZEQDFa
	 lolrKzwMfQnwPrpfpPMNQPOk3e3Lt8mbQyrbdSSlI79uOcECj2cEmIy1h98L6EFGZJqB0
	 CLqIjX4emtznj5FqrUbDd9Mqb6xD+mmrz1dAzbk6M+RLVVvfWO0bs8RhPf3IbvDapX6J6
	 S/7+mUEAY7zcQf38i0fGZNxHqrBiM5Q4OIIVBZfunp4Wwjlwoqjv1TOopeHzOo3p0e8vF
	 +7/0FOV5Aq16I+8kbX1Rl7IumRVmb6qJ5cNsQTwnlVfJqFPEpjsLaArJ/XSc4qQDWGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QO3F1Ydb;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55C7606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 20:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D55C7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QO3F1Ydb
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so173718a91.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793132084; x=1793736884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ESqjTCEySHqE+ygnAQybXyvYJ0e5BRCSG4DiJOenODM=;
        b=QO3F1YdbcQQBDx2JbTL3HB+EHiBvQcrU1J4qBXgtD/srL2Vmr5qpSNug/Gbzem+Dwd
         CooVgN2/fRW8+cuWUCNuTl7sTyawtQ0BwqIVq3vbDNOU3bOUYmRKtQFdABDyOk0j56ZS
         jllrgCBN7OSd5o/3EBmICXNnVtf1R7+qQ2ni5L3DiBdYByt4wPqqa6Zb5HBliEgVz1eK
         BsrgZlyxn25Az25kC1ejE2wCt3plVTIFonmT9cQ74uazGNyxTFDhmn+8/kJ+5z1Q47yo
         sq5U+RNI6PzZ3ulQDG6awCNJ2xjeLZ2B3dYGciuJrKwbv3EO8DcZeaWk8i0IeuWZRa65
         x0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793132084; x=1793736884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ESqjTCEySHqE+ygnAQybXyvYJ0e5BRCSG4DiJOenODM=;
        b=DnRHyWrXlmAQiNrjOD88VrZTj8c0mOGGRGCzWiwyXTOYveDG2jNti6Bi6eZggz+rjN
         Dl1y/d0dKJEpDfMgkDQF45dy5oWAu8uiRASUm8iaSv4vz9JfkAi2YFRf1RQwmAUwiqrT
         EPAvnadXxV68UfCVcPsi+irYFqA7JevOv0Gm9wN8LQGyZzv6NLwJAwiz+goS42bkNTA6
         ihK4vyRpZvAIAp7gXxLti2TDhEOMh4dxOSRem3pWrXjI4T58BHyYa2LRw/8WDhibw3gr
         eJ+Y+BBfnPlD02jk20cCBa3GYdR/CRveheTnyXEzkP6TGdcDh3g6keCL3VjA6J7kT+5G
         r+CQ==
X-Gm-Message-State: AFq9FYLN6CDrvHeGC31pHPg2NGVo21X/qzz1QvXjOKQvk9nUbSMj/t58
	18PPg4P2GvoVZZHSyBaKRsIAyScu75iLNhTvXlKSnJOwEzIxk9ZegFZQHm9qyg==
X-Gm-Gg: AYBFou2bode4gIRaV5iq5SpBAmHvY/Kgfza2bSyg6kOqU0bvspsOg8NMKl0pHPrrnmS
	2E8u9fMZxW2WrkOvxmna2aFZe/jK11qqtvKYyE6AbZz9Kspr4m7jva9c1EXhz/7JybNRW7mjT3I
	oSsKvTXTKafvlb/ZZZ9moVZfTVGlm5ZO7ny/YSOHOrBZBIaXAx9OqvMbBO0jduZGqNWvUpqMBVx
	Taa8+0nXWqwDaiZGs05uJ5nTkyat9HcpyPBS9meAdIstbAcnOW19yRjoOe0cnUMeMZsVzaUfDtQ
	HYpSji4AvvHDNtTmQzs4DhMy2l10I1OPI0+CjY8hjpLDrbiIwY2Cj+BmQuCiFI+Vtx2iRfI6AXU
	j9UqWEtPkoFUlk3JqKmwnTyogGFdOT44c7OQRs5UyUytyx+VrMpwBVdR3hOVeINaNGXTtDZBl0B
	dIx7EBcVTPFvRqYlRm4g8TJy6cf9j+VMS7P2I8Ho0xCP3j7OH1meRAWKkGsT6cxpRNZtCE45u4E
	IGIEaamUvR+AtmrvpYoPu5lrQQaL5U/JJIHXcR7Qew8DWVPVsmzm2YgRYZHa1VaL1EsT8lNQdLH
	WnzeYbeaMpD2mmxuB4aT53HIo9bRUz+5caMmSwa+08O3KFc30it/qmKx7/Ni9jDh60x+P+xRpzu
	+YVK8hnNtn6Bu6GtxviQ2ESHii9oXiwA8Xgg+sC/NhOoXCmpjtwXYCZukucJDPPMT33i3caNNXQ
	==
X-Received: by 2002:a17:90b:5286:b0:3aa:6b5d:a00a with SMTP id 98e67ed59e1d1-3ae58318a03mr102721a91.53.1793132083948;
        Tue, 27 Oct 2026 13:14:43 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae57cb2be4sm241723a91.15.2026.10.27.13.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 13:14:43 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 1/2] bpf: Keep the valid bytes of a packet pointer in scalar evolution
Date: Tue, 27 Oct 2026 20:14:35 +0000
Message-ID: <20261027201436.3192716-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027201436.3192716-1-alexei.starovoitov@gmail.com>
References: <20261027201436.3192716-1-alexei.starovoitov@gmail.com>
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

check_packet_access() accepts an access when umax + off + size <= range.
Thus 'range - umax' bytes from a packet pointer are in the packet, and
nothing can make umax smaller without a change of the range. For this
reason commit b88822d2584f ("bpf: Fix packet range of pointers sharing an
id") removed reg_bounds_sync() from the arithmetic on packet pointers.

At the head of a counted loop scalar evolution gives new bounds to a packet
pointer, in bpf_set_reg_range() and in bpf_reg_union(). The two functions
call reg_bounds_sync(). Then the step or var_off makes umax smaller.

     r4 &= 0x38
     if r4 > 50 goto 2f         ; r4 is 0, 8 .. 48, but umax is 50
     r6 = pkt
     r6 += r4
     r5 = r6
     r5 += 8
     if r5 > pkt_end goto 2f    ; 8 bytes from r6 are in the packet
  1: r0 = *(u16 *)(r6 + 0)
     r6 += 8
     r9 += 1
     if r9 < 2 goto 1b

  r6                       umax  range  valid bytes
  -----------------------  ----  -----  ------------
  in front of the loop       50     58  8
  in all iterations          58     58  0
  after the step of 8        56     58  2, incorrect

In the second iteration r6 can be pkt_end. The verifier accepts the prog,
and the prog reads 2 bytes after the packet. A kernel without scalar
evolution rejects it.

Make the range smaller by the same number as umax.

The range can also be a mark: the pointer is at pkt_end or beyond pkt_end.
The mark is valid in the first iteration only. Remove it when the pointer
is widened. This does not change a verdict. The arithmetic in the loop
removes the mark too, so the state that returns to the head was not pruned,
and the verifier made one more pass with the two branches of each compare.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Closes: https://lore.kernel.org/bpf/sashiko-outbox-187068@kernel.org/
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c     |  3 +++
 kernel/bpf/verifier.c | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 7b82fd79f9cc..abc4ba5ec1a9 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2837,6 +2837,9 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 				bpf_log(log, "\n");
 			}
 			scratch_widened_reg_id(env, reg);
+			/* "at pkt_end" and "beyond pkt_end" are not valid in all iterations */
+			if (type_is_pkt_pointer(reg->type))
+				reg->range = max(reg->range, 0);
 			err = bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
 						bounds.base, bounds.step);
 			if (err)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 02b2915f0014..cf7b64de1a4d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17739,6 +17739,20 @@ bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
 	}
 }
 
+/*
+ * 'range - umax' bytes from a packet pointer are in the packet. reg_bounds_sync() can make umax
+ * smaller: with a step of 8, or with 3 zero bits in var_off, 58 becomes 56. Make the range
+ * smaller by the same number, so that the number of bytes does not grow.
+ */
+static void sync_widened_reg(struct bpf_reg_state *reg)
+{
+	u64 umax = reg_umax(reg);
+
+	reg_bounds_sync(reg);
+	if (type_is_pkt_pointer(reg->type) && reg->range > 0)
+		reg->range = max_t(s64, reg->range - (s64)(umax - reg_umax(reg)), 0);
+}
+
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step)
 {
@@ -17747,7 +17761,7 @@ int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 	reg->step = step;
 	reg->base = base;
 	reg->var_off = tnum_unknown;
-	reg_bounds_sync(reg); /* this should infer the tnum alignment */
+	sync_widened_reg(reg); /* this should infer the tnum alignment */
 	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
 }
 
@@ -17792,7 +17806,7 @@ int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
 		acc->base = base;
 		acc->step = step;
 	}
-	reg_bounds_sync(acc);
+	sync_widened_reg(acc);
 	return reg_bounds_sanity_check(env, acc, "bpf_reg_union");
 }
 
-- 
2.55.0

