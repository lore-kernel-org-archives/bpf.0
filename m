Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749274;
	b=nV0wKBWTfGfGhPbzhcJbHc4AV7plheqfxodACaPJXx2kQ0/CWak+vaPd0o6ao4l+oUPt
	 KBVwp4VX1xdM8IR9CW5BTUid6cPlumajDNH5WxO6APrZKhwOeCyC4xET3cJ2jJy2SGGHR
	 i9xfxSl1GnBC+7WZlqOGXq2Sq2f/F6SnYT6+ueC7cHtIhatcvMe4SC37gbdDa9BmBIDlN
	 ZhJM/a6WABm48rvLdbpqPW938L9TVnEZ1LY3P87wwBxsfnzF4zkMhZoz6nnpaSRHBAnl9
	 GCNx1txI9CUG2k1P2Kzj1PgziOxVASFy1/DMlm7gGgH9Pvu2lu+wRgtN18788Elphew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GxDTa6SI1HdscuSDw4K4E8IXSIC9q4IT/ZKi1JT1DXg=;
	b=u7JvsKjpY3dAkjfkqOjDzqnCm5Hp9f/pULlBD0pGUlhva+Smfnymsb+ha9C5nAtCZm6x
	 31R0ylEX42zihqXO5DIVe3NQcRpjiefDaDVR2ZFq357xbBlkubdj9OgZWdGoZswXiWzhd
	 1dNCPJipzmzHWF5dX0iKNlODrQsg1YgODGc8UNoWi6grpRxKw14+uKAKdeyWIQFSdDXja
	 1J7g/ZDghkO2pkS6AhqlV7PJ1XD6z9jWshqqAZSWFLGum0jHcarKNW1zBjEO3FRhvrz8y
	 iym57k3w+dyMOCSsp02uoh3+ldFWJDLaWp+8a6+DCS8h3Gs5yGtoPQBEVwTXahaiVFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQrBH9ZG;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E6606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B04E6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQrBH9ZG
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-89ff475a152so68939b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749273; x=1794354073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GxDTa6SI1HdscuSDw4K4E8IXSIC9q4IT/ZKi1JT1DXg=;
        b=pQrBH9ZGcR9ENEVAiJjrALbRNg3rV6DL3evfFNfByyHVGYMoCRT0m4D4X6A8rNM53u
         iQqgCZvYEH8VcIMshMEMGSeVgF3MRD3e5b+qjmQBbsIyzkEwlt2kmvYXAzv8M7HCS+E5
         ROD6xqINNN56MyN+y7JdCadLDkkZCYFoILyLYOGPHyo+xFJIaO6l5dBuiAu8IZobgTsc
         iq6FPk80s5fYQXl6u73StKz9D1uuoH8axzTbLC8woHjbvHOEKKPlpQkTaegZdSmceXzo
         zH6TZZFb7jiYkgl94PYy6mAddam6EW3h1bDgKr0B6//Gj1cRImDFCeK+VnZ55IK6wnDL
         zxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749273; x=1794354073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GxDTa6SI1HdscuSDw4K4E8IXSIC9q4IT/ZKi1JT1DXg=;
        b=g4N3Kj7qHWtJ/wPziLrxOkOepJdm8es+pl/DWH1jnsaOzzPluXbVMITvaTzSvtX1YU
         Wg+DHuWG0m2Q5q0cnWFN9KfMAbtPVAPm8i1ndXCgQVWLGoNyeVZw19AfgxGR6FTKn+N8
         gDr2fkjeYF8iNaGPX3lsIpkU+8Lv1z6nlcPq5wPMAoZdanFzg0a9BHLUuug+vR8R7AMJ
         gKHRBWHdClSv9m0smr0N1LDpYDuku/GiNvkzZbp1/XpA56jUxxQ5YXHX24goI1QkeXEi
         Uy+K8w8cgK05W8rMdNcmgN/T+nOAJ0XAPcegeC2TI2FMNrc6d9STXW2h0IJCFbgl8CgP
         0Jmw==
X-Gm-Message-State: APuU4Z/2Gy0BVvcvlhxH5ZybvWXpFFjK1zUHfF8WdG4EP6vPFr/U0b6Y
	pKrS038eZ9Ol/y0+i2pKUaEUmsYiaq+Yp/acGOoNr29oXmC8Rct9wsUBZceF+g==
X-Gm-Gg: AYBFou2pkwxxX3q3xyTRIrQJ9QrxtDVqzN8XIoHipKEd19kK7ogohCucnSoyXjXjBdR
	915/yKslPzHMJcVAH7XPEufJC1l9BfOJJBK0bicxqHYfgWDINwZ9PauK/cgIC+KMrWQpH6zhlTN
	3e8VJkAB5fgThAw2YueD9acJb6ST1FLgC8TzcLwmW/nXpdZZQeS3UGePrkiSU7CM0lgOH3XlrdI
	ijiStyH97AKryxdpli0SX3AUuQcpagyi/8fWhjkeGEJCgdP7Zfki1BeOkSPCZ72aw0QiqFBDxxZ
	jrlF65Sm2sxgGvcEh08TRD6l57S6R/tkIOERYguz7THOTRjiRvCtU49t5IKnvR8RsNk6mEUfs+a
	Wyvb0O6oz/c49Cbd+R5ZTEcgYjMCs5SR163xfIZz1FiLl6wcisYqL+bGqpVw3Kpe/7S1aWan1YW
	6uUyTnht5B7gNlmo789L15zy5kI6a8l8LbxTXNfRNUgAthPf9s+eDTsFjSFpcoNc06Zs71fBCLw
	KWanopcKxahqKaw3MZmGDgEEFz54jkg9fnJNMU/ncdvSDqLxp72Br8Rskqt6opckGHckncFsy8b
	J1xPAzypw1bYGLoNZYOKNhklQ+VPQh5zlgmADMnp/W8aJfnVMmJzVvFCxthfj3rQ+s4WzvXuXz9
	v5ef6QSXol2sjw6O0JIVic7vBP46YnWgGRWa1Cqu6r0U6IWpMqIAa8f67F/2qdcLMohZAr186nA
	==
X-Received: by 2002:a05:6a00:3a1c:b0:878:34d7:69b2 with SMTP id d2e1a72fcca58-8a9bffd63e3mr10705309b3a.57.1793749272685;
        Tue, 03 Nov 2026 15:41:12 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09af91d24sm151264b3a.29.2026.11.03.15.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:41:12 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 01/37] bpf: Keep the range of a packet pointer when a number >= 0 is added
Date: Tue,  3 Nov 2026 23:40:26 +0000
Message-ID: <20261103234104.208239-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

After a prog compares 'pkt + 54' with pkt_end, the verifier knows that
54 bytes are in the packet: the range of pkt (r=54 in the log). The range
stays when the prog adds a constant. But the verifier clears it when the
prog adds a scalar that is not a constant, although it has an upper bound:

  if (pkt + 54 > pkt_end || off > 38)
          return 0;
  *(u64 *)(pkt + off)     rejected: pkt has r=54, the sum has r=0

Keep the range when the scalar cannot be negative. The verifier accepts a
load if umax + insn->off + size <= range, where umax is the largest offset
of the pointer. Thus it accepts range - umax bytes after the pointer. A
scalar in [0, N] adds N to umax, and it moves the pointer by N at most:

  pkt                 pkt + off         pkt + 38        pkt + 54
  |                   |                 |               |
                      the sum           its umax        its range
                      |<-- 16 bytes ->|                     accepted
                      |<------- 54 - off bytes -------->|   in the packet

Clear the range, as before, when umax of the sum is not below it. Such a
range permits only a load with a negative insn->off, which stays rejected.
It would make states different that regsafe() can prune today.

reg_bounds_sync() of the sum stays: the alignment check and the check of
the smallest offset use what var_off and the step tell about the sum. But
it can make umax smaller. Then make the range smaller by the same number,
with bpf_trim_pkt_range() of commit 88e2c896d859 ("bpf: Keep the valid
bytes of a packet pointer in scalar evolution"). This is sufficient because
the sum gets a new id, as before: no other pointer shares its range.

'(pkt + x) - y' can keep a range now, and BPF_SUB does not sync a result
that keeps a range. A prog that needs what the sync learns from var_off
about this difference (smallest offset, alignment) is rejected now. To sync
and trim the results of BPF_SUB like a sum would also change 'pkt - y',
which is not synced today: valid progs that load today are rejected then.

Sums of paths that checked different lengths now differ in the range, and
regsafe() prunes fewer of them. veristat shows the same verdicts and insns
for Cilium, Katran, sched-ext/scx and the selftests. These progs check only
the bytes in front of a variable offset: no sum keeps a range.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 62f26149c3ae..fa53ee735762 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16358,6 +16358,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	const char *reason;
 	int ret, bounds_ret;
 	bool to_scalar;
+	s64 smax;
 
 	dst_reg = &regs[dst];
 	/*
@@ -16513,12 +16514,18 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 			if (!known)
 				dst_reg->id = ++env->id_gen;
 			/*
-			 * Clear range for unknown addends since we can't know
-			 * where the pkt pointer ended up. Also clear AT_PKT_END /
+			 * The range is what umax of the pointer may get to, see
+			 * check_packet_access(). umax of the addend was added to it
+			 * and the pointer moved by that much at most, so the range
+			 * holds. Clear it if the addend may be negative: umax says
+			 * nothing then. Clear it if umax got to it: it permits no
+			 * byte at or after the pointer, and it would only keep equal
+			 * states apart in regsafe(). Also clear AT_PKT_END /
 			 * BEYOND_PKT_END from prior comparison as any pointer
 			 * arithmetic invalidates them.
 			 */
-			if (!known || dst_reg->range < 0)
+			if (dst_reg->range < 0 ||
+			    (!known && (smin_val < 0 || reg_umax(dst_reg) >= dst_reg->range)))
 				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
 		break;
@@ -16611,11 +16618,18 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	 * A packet pointer that keeps its id or range is checked against a
 	 * range set from the checked pointer's umax, so var_off must not tighten
 	 * its umax. r32 must still match var_off for reg_bounds_sanity_check().
+	 * A sum with a new id is different: progs rely on what var_off and the
+	 * step tell about it (alignment, umin). No other pointer has its id, so
+	 * it is enough that its range loses what its umax loses.
 	 */
-	if (reg_is_pkt_pointer(dst_reg) && (known || dst_reg->range > 0))
+	if (reg_is_pkt_pointer(dst_reg) &&
+	    (known || (opcode == BPF_SUB && dst_reg->range > 0))) {
 		__update_reg32_bounds(dst_reg);
-	else
+	} else {
+		smax = reg_smax(dst_reg);
 		reg_bounds_sync(dst_reg);
+		bpf_trim_pkt_range(dst_reg, smax);
+	}
 	bounds_ret = sanitize_check_bounds(env, insn, dst_reg);
 	if (bounds_ret == -EACCES)
 		return bounds_ret;
-- 
2.55.0

