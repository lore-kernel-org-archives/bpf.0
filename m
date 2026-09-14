Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834F2FE057
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424721; cv=none; b=azQoy4am0IlRKGkP+WkVrk/uHWohHimBBM+B6GrUggsFzTtsqfdGmOXB0ijDdqw9Ocv+DdWE+Jvt+/eCOSofsJy400FhLktxcl8bufTxd6MAnI4xaRXoctCt26KSAVODIfDB28TQIM+WOCUKkifogh4UX0ya9h15hfxYFra8T2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424721; c=relaxed/simple;
	bh=u6A1booZqff9HZn1c6UG3ORSmFh2XZq7GxUxYIULqw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVJS/FQPPYqzSMLlJvjd66WE612/mGY1WiPyGgagMuyQCdg/5JnNgjegxp+IpsPv2trCewyK6UbkLwT4H1WOhCoynZBiGAOp3KA2Iqe9RxfBBeO0iFxjtkDAeEQS6iZ2eKKbR5U51SCz7ZzhFuzf6LxSzxvFatDYwHVx7jgmvxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeevhlTv; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeevhlTv"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-484392e3450so343829f8f.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424718; x=1790029518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HC2tCCvpccn+pRkVO68CBG2Pf/51+9f68zCb1h69W6w=;
        b=UeevhlTv3KbC3Sax+3IhrttQXRwmJsP623lqf4rIeM2NHg6MdiXurAhanS5AK8OBgu
         Jvu+JozV9hpKYFodtaN8t50Yz/DB/Bgvi0eR/vPthh5iHZEqSOOU0Kuyb6gExOWf/1Q2
         52RgVwYldRcRSctJaByLkW61Q8Jyfp6OmFwJzoO2Av6zyMjJ74FGZLw05mvY/rWyTamx
         EpP/pXZnUk2rjhhGlj3J3nkDZ4asiCBXyxe+Y7ZcWqysD5PMGpiurNu0U7/M5TvDI+Yx
         piMxQ1Dq5YXLhcBwb036cR5luaPyRULVfdVsYGgvDzzFlwSwT+r861rJWZJKjPRVMZHk
         RfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424718; x=1790029518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HC2tCCvpccn+pRkVO68CBG2Pf/51+9f68zCb1h69W6w=;
        b=fSb6WVLXRK4c8SiI91HliBpel/IXT5q0ezC+qeFvQe2aqAurDxM7dG2eqollp5DEYv
         6OjHh2nDeO9zh3PzWcwAYSH2sLHHKTSWdz3Aka+G72CnozK2KKxGzmsgmnyfUADGyZoz
         MHaRe0viisLJQ1I+aucnMBsQ9Y5jzGOlRxs1w7UVM3fVLg8b9z8cl2HiwFoKCNIMJtSm
         Umx0Yl83Z/magC3IUKULG4eIJdluxbh0l/fhR5FM3oh9CRxotnaLL1PrDipMigB67vbJ
         u4fwCcxEjYlgSZH7aITXs4xnHd8hX+nP4DBZ1iJfaGoVCRfshXynUMMT1P1sBYhP1NgV
         UMew==
X-Gm-Message-State: AFuF++mtX5ZRz/JElVTOfJ3nLbxTCj1q5nEvnZkrVtCdvt8CvI7OjEqc
	HhxGAaiDUWGRehBghNylRExguJp5t5Vr1HM6Fiq+ekipytPTvo9zmHjWzYA+LY0Fh3o=
X-Gm-Gg: AYBFou378/WAOPVSQ+hESezBQ/bjhTYrrADN3AjWs2aQS+j+jBF/GLYV+1QZoYPtGrG
	ysvBswJ+jTIkEUDOkd9HMH03AxRDb0LiU9pQLCi0dfxRHkk61h1Js3TBpWq9cKKFQM1+9+GQQ2j
	QLzfu9rXzv0YuQfCJ3Gpf+sBMfq3X89AT/kvaTzVQPX4gka4UsJXej3+GwCU051Xc4EtMpQSnCM
	bT5vcDBUAph4EITilxyX4T1xCSuoyaKZDZWQE5CB3cxq41ctscSjmaCeFXFMUxrM7bocKv433zq
	xIgr8AODbA4850MyR6Lt1a1d0jzb2lUbSWcEgQXXiLJoDzz/dl7DEt3wHgXJsW/nxiTQGHu6ay5
	C/sklHFJVlhPoXM5GZeL4RIaLaxeRAEOFKkZvgrk8crkehrMeuesLjH6l7tzEl94HLTdzMtLvJU
	EipPyMeshY8cmXQl0B6+W0/eTB+AmNVQEvY02oJ0uTzlquN6SovzAmC98SmCIEhVZQ86XoIqiY+
	MAQIy97uaQ5s2FqdfDIsx7libE+Uko5vycKdgQkk+IFhCgqiTVEPxPw4xMuDEbRWLAhsMTMuMg6
	l1VTzOjIc29fe/jT/BXTpD+a/NBP6kU8MDVIjH3y6cIxF0cA
X-Received: by 2002:a05:6000:4718:b0:486:e4e1:79f with SMTP id ffacd0b85a97d-48705b620e8mr1950780f8f.23.1789424718414;
        Mon, 14 Sep 2026 15:25:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32d5f1sm31910875f8f.12.2026.09.14.15.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:25:18 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v4 02/11] bpf: Preserve packet pointer class displacement in regsafe()
Date: Tue, 15 Sep 2026 00:24:59 +0200
Message-ID: <20260914222514.1635018-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914222514.1635018-1-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=memxor@gmail.com; h=from:subject; bh=u6A1booZqff9HZn1c6UG3ORSmFh2XZq7GxUxYIULqw8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtFia67jvzk+ref+/s9z7rt+7fQsulVdckV08WKEonXl M1nfw/qKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQ4xBgZelcnTZFoa/CLcln4 NfKp/kFW7dzloR2RNzd5xl42l3BmYmQ4rCdRyJF2xKwx6O+cssUaQWVHGFJdz8gKHi461bDv7At eAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

regsafe() maps packet pointer IDs between states and checks that each
current register range is a subset of the corresponding explored
register range. It does not, however, preserve the displacement between
registers that share a packet pointer ID.

This is unsound because packet range is shared by ID. A bounds check on
one class member updates every member, and a later access can consume the
range through another member. Commit 022ac0750883 ("bpf: use reg->var_off
instead of reg->off for pointers") folded the fixed pointer offset into
r64 and removed the old off equality check, so two individually narrower
registers can prune even when their displacement has changed. The
explored path can then license an out-of-bounds packet access on the
pruned path.

Require matching range bases for packet pointers with an ID. Together
with the existing ID mapping, this preserves the displacement between
members of each packet-pointer class without adding per-ID state.
Packet pointers without an ID remain unaffected.

Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/states.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c6a7..6c88ad95b63b 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -635,6 +635,9 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		/* id relations must be preserved */
 		if (!check_ids(rold->id, rcur->id, idmap))
 			return false;
+		/* Preserve displacements between pointers sharing an ID. */
+		if (rold->id && rold->r64.base != rcur->r64.base)
+			return false;
 		/* new val must satisfy old val knowledge */
 		return range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off);
-- 
2.53.0

