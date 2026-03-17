Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81D35949
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773790405; cv=none; b=qSEW5tf1iCzjJ/eBIM8+50ai3DDHOs2cOwnaEayVMCq3p+U458OlhGaga+uhIzqWHKhaGb+rrjURAOLPMFPQLBxfgoCiso8rwQ4A2ho4cQD5/3Bdtn/zy//dTlMUMpNkiwTD1dUbBlJBGr20r+niJ7E61pW3L6zUVHWgysyhUWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773790405; c=relaxed/simple;
	bh=M2oILnMFRnCTXhv2of1N86xCWOBlK3ZFjdGz940AjQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+LK2URigrpTiVyr1uQmfjBP5OBu+NDREY6qIwZsLTFhU1JGZkGQISijKwzifSt2sNy7kxZ9gklvBZoJ5xZjsIdtgGqT2s+t0rcnT7LPlBH22g9paQ5M5RFlFVik6jmmtJfzZuCLJ/1x2p7/DWALsYolNmNQ//OPle0n/MeMJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1bzf7Rq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1bzf7Rq"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-485445e80bdso54513935e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 16:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773790402; x=1774395202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jq7vMllbLituEwsxAiSeLrzSpUIncWET2crS5mchow=;
        b=M1bzf7RqBnSxfZ/7sWIpP1ZvQGkq6k7/82LXnElKwdAHDa1OPiI7MeZaIIu+bmtRCv
         jIASMSIK2k0x8XZFSXDtauDxnQPDWLx/ZS53wBbH2BBaPMqWW+PyzGiiDtP8CstYunR2
         N+xuZvikypnSLzPFojx1L9ttGyIKeVSfXgTPzppx47g1dUOKlq7wwHPNexb4Gai1NAUJ
         FiGHDVKXs02q1yZyWZQp6ir3ThM7AbssSKvM8Qj7pEnF2I/xAkicnLUkMhbS5fV0lsoB
         ak1h56mmMDKZCjC0kUHz/9B+w8tzOIFPx+Kb2r0hiLYTSTwT5h0+8EaORDG3VyH/+0ZE
         I3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773790402; x=1774395202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jq7vMllbLituEwsxAiSeLrzSpUIncWET2crS5mchow=;
        b=VjuJtiRsRFKwX41rtF2cuIC0RQ0aJbCy7q6afOmLmzJj+cRCxgdZ2adlB9Vps5IQDP
         pf80xepqub4OKA6TmYbUetKzS/1pBsBldo0qhYJiEboYHoHq6xs2Kw2QmcL5vfZ/HcH6
         E18MKcttwfRP9PHDEg20YYSs0JyDLGP6vc6es1oEshSjDxakRqQXY67Mb1p7kQulBo3X
         MNFcjowP28JK727a8SG8ac0KY6G4cwf098G7Myy8qOipI82ArShT85j4D0xyLjCwwG72
         LXIgM+Gr6R4FdhEtg/tXb8WnhRRH2RzZCVx5Zkio77PmUYYNLOaZPJs2YXiE10AJCT/Z
         H0pg==
X-Gm-Message-State: AOJu0YzPtIfayeh+J5vo/hRUaHx61yB16r/vSuKMGbWi/mFXbXcwUqgS
	OiFykPe4IH+Wu59ImGYubHTUE5/VegIHN0tjwCVIZbqudSdiZYh204VwVS4+9ww=
X-Gm-Gg: ATEYQzx+GapRjR1BI7dpvE8wdgUIgIoGA6c2f6OeFnTSRHYR3CJmhUUwStORoKcIa58
	yYvvi0odlTzmTQHuKG4Nr+wsdqAXlYKpccQxjMOjUsumXubMuGF0F/KFwZY0MKRSvGtFvT1cjOy
	/UXxRzKFGHz2Tb89axxWkxsseiPT1Bccz2FYY94KpwZwlh2/3wo5pVDnoIVMm2GmTAWWyzC1HHC
	zKbjcd6fp8VagQVFShotfq0VLkG51WlLZ78Xzdhyi+AhQw254gxlCLgUqmjItqPPe/BZkb8wcXt
	cgQz0q/wMheU+K+fJtQHM7/kkvYfpFpTeuxtP6TX/+MF1PDgi/lCkw1P0TbsM7cc6SvE9q+/pYy
	Vrfflrq8UCjHvlMk0iQ44pZ8u4r6QJJv4BTcA3sS5/uBEt2q7nAtibrO8ErMN42EJ6qiu9OhYtu
	vvOtzlEeh9+Y2PRQ==
X-Received: by 2002:a7b:cb8a:0:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-486f4451174mr14845805e9.10.1773790401272;
        Tue, 17 Mar 2026 16:33:21 -0700 (PDT)
Received: from jacks ([197.38.212.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518986fcsm2581770f8f.26.2026.03.17.16.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:33:20 -0700 (PDT)
From: Ibrahim Zein <zeroxjacks@gmail.com>
X-Google-Original-From: Ibrahim Zein <ZeroXJacks@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	gregkh@linuxfoundation.org,
	Ibrahim Zein <ZeroXJacks@gmail.com>
Subject: [PATCH bpf-next v3] bpf: verifier: fix integer wrap in regs_refine_cond_op() BPF_JNE case
Date: Tue, 17 Mar 2026 19:33:14 -0400
Message-ID: <20260317233314.1748174-1-ZeroXJacks@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In regs_refine_cond_op(), the BPF_JNE case narrows register bounds
without guarding against wrap-around at type boundaries. When
umin_value equals U64_MAX, incrementing it wraps to 0, producing
an inconsistent bounds state (umin=0, umax=U64_MAX-1).

This can be triggered by constructing a register state where:
  r1 = unknown_byte | 0xFFFFFFFFFFFFFFFE
  -> var_off = (value=U64_MAX-1, mask=1)
  -> constrain with JGE U64_MAX -> umin=umax=U64_MAX, tnum non-const
  -> compare with BPF_JNE const=U64_MAX -> wrap occurs

The comment above these checks incorrectly claims this boundary
condition is impossible. However, is_reg_const() uses tnum_is_const()
which requires mask == 0, so a register can have umin == umax while
tnum is non-const (mask != 0). Remove the misleading comment and add
explicit boundary guards to prevent wrap-around in all
{u,s}{min,max}{32,64} variants.

Fixes: d028f87517d6 ("bpf: make the verifier tracks the "not equal" for regs")
Reported-by: Ibrahim Zein <ZeroXJacks@gmail.com>
Signed-off-by: Ibrahim Zein <ZeroXJacks@gmail.com>
---
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17046,31 +17046,30 @@
 		 */
 		val = reg_const_value(reg2, is_jmp32);
 		if (is_jmp32) {
-			/* u32_min_value is not equal to 0xffffffff at this point,
-			 * because otherwise u32_max_value is 0xffffffff as well,
-			 * in such a case both reg1 and reg2 would be constants,
-			 * jump would be predicted and reg_set_min_max() won't
-			 * be called.
-			 *
-			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
-			 * below.
-			 */
-			if (reg1->u32_min_value == (u32)val)
+			if (reg1->u32_min_value == (u32)val &&
+			    reg1->u32_min_value != U32_MAX)
 				reg1->u32_min_value++;
-			if (reg1->u32_max_value == (u32)val)
+			if (reg1->u32_max_value == (u32)val &&
+			    reg1->u32_max_value != 0)
 				reg1->u32_max_value--;
-			if (reg1->s32_min_value == (s32)val)
+			if (reg1->s32_min_value == (s32)val &&
+			    reg1->s32_min_value != S32_MAX)
 				reg1->s32_min_value++;
-			if (reg1->s32_max_value == (s32)val)
+			if (reg1->s32_max_value == (s32)val &&
+			    reg1->s32_max_value != S32_MIN)
 				reg1->s32_max_value--;
 		} else {
-			if (reg1->umin_value == (u64)val)
+			if (reg1->umin_value == (u64)val &&
+			    reg1->umin_value != U64_MAX)
 				reg1->umin_value++;
-			if (reg1->umax_value == (u64)val)
+			if (reg1->umax_value == (u64)val &&
+			    reg1->umax_value != 0)
 				reg1->umax_value--;
-			if (reg1->smin_value == (s64)val)
+			if (reg1->smin_value == (s64)val &&
+			    reg1->smin_value != S64_MAX)
 				reg1->smin_value++;
-			if (reg1->smax_value == (s64)val)
+			if (reg1->smax_value == (s64)val &&
+			    reg1->smax_value != S64_MIN)
 				reg1->smax_value--;
 		}
 		break;
