Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B053B8D4A
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591628; cv=none; b=IT10Fj1JyLnHwa3b0atUzzXFxTAhTbfKPepmHqs/jDgpgQj3JMoXrMv2iviJMaAgkTVlVRrQZcRY04y7AzMW1HbopeFDCbhUe+1K9Td8Cjbd23KmrRhC0zGOHG5rvy4qaAg7BMKHuTOrWYSLcx/5fAu4DEiVLO31gNa0mHYG9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591628; c=relaxed/simple;
	bh=s4Y0JiT4xAIDUadPi1is7tuuN5Ng/5Xc8W5oRApGOv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbP825bWocA/IkgT7c7xw5Du/vTOWNIPJkcFN2Xn8YtkSJYba0hSNW8vn/+YjieLQuxDulGqyWkwudqlViDZTpLRLib/Q7YeHLrEn7XGz+SERkncB+owBEkEVe6Ch5PbN83HmyyloJoPGRTLhp3tKXscAvGpOhZX+9sUFVOthwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmS68Au2; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmS68Au2"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-49cd3d0f150so7754075e9.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 00:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591609; x=1789196409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BgkcIgRjcx8CzsIkhrtznq+t9jdmXNqsjQeLbjfh6oU=;
        b=lmS68Au2uEyevQpafL76e3zjfsBXVRZVeJTBJ9rMU19QJ2eNx7JZKBR5G7aNYdO11t
         tVzW483EQCeas9GmSOh/4/CkDD7/JgDPr+XaK0vnhYQRmykwY+LO2QEIF6JPjqdHFvu1
         J1Gz+lG30W3lTz2cQJ8CRwDM8m/smXq9Nmz65Ei+7gd45RKntTV+Mxd0foPxDDgQk5pF
         01mmVlppOAVrdN1Dljf1iDfigbRNLpw1J8RPT/p2PqR3W9hs4BVyRd8mPpVzezPpRDnS
         HmAP2GF6qVanYNebe3Cwpaf7H63Oc9fSqMNn0+3JgDONSdImW39jiWOcC+l9GCh2mKE6
         GoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591609; x=1789196409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BgkcIgRjcx8CzsIkhrtznq+t9jdmXNqsjQeLbjfh6oU=;
        b=JZrRyx4+qwGPbQa/zaA1fRedeJPUwXIHZbawnoCSLrGSQ73RMQxH2QcnKo6Mv9atjQ
         enXFGRz1G3Le+rMhC7Xhr1Zz3fwJ6o7AerjyL2mxXfYi/lMe+YXFEjRDBv4UoeHPIWDn
         f4eaekn3Yts9NVsnd15d32a9tK6Xk0//7IpUtCxh+gTr1egOVaNXGsJE8Au/2O0t5u2K
         dFT93MYz9DbHHcOB0QZVdeXJtswZdKuT4QGpItPvS+A45FV2/LLuExFuY0Mg4U9GsmfQ
         96XSUD34I+rJ7BAVZfVxqzf22oyL1o+cjeLpSrhqiTb9/stZ4XIUeZL155AP4nHRQle3
         fEtg==
X-Gm-Message-State: AFuF++m3SF8jbyJy+aqvaTvuoLQbYmE2eIEcPQWOnbTtv9zB5tDv4soY
	bcGohscmb4peTOhuI8hQFESDK66pJU/6byOdQFTRxAFCf2auWgRlog6E9zau+mqi
X-Gm-Gg: AYBFou2jSLjfy3432YOcXpPm9vH1FRa56KarSQ8rZYukOyJELh07k/9xlx7suovUVeW
	xuXYiG/tb/AFPxF/sziaTFPZP5wwdTpFEfz32vtn5EpA6I0WAQRrcsFjskMDkvEghgZWjhjz1Zq
	JZh2KNOfBzJa7mrkEg2/vyfOp+caimnSeGAHx0NnS/wD2k2uxcckEBgxnvPWSSTUopx6+W11hbf
	B4bDSqsh1LaSl6y8hoqbX0gkwTvujqolsH7vqrSIzrv728jj+1Ib/Vxg57rZwZNa147bMYkYiB7
	WFsdkl3PRwxUad3FXZCVIhE9L24Z9pMwvao2vWAUQvKBeb+t98HkJ3Cld+siyT8ULQxN1IAP7L7
	9ByLpQXkHrnkscY3WnyOrEWdFzAaAfkEdxAop6V7hX5ttEaopb1ALAYnZkOAOITkeddFYQH7Xn/
	jfmF70jhLWJJDnbNuaRBIVEJ54D0pmf1Datd3eUefsbHdtDXd9eHPPsMIIqRW5L5/RIZTX8WgZc
	jW/p4WtCBPsJoub2YaylN90nhQCvLEiYGucoRZQihz8RjOgceW01/rk3nFh6I18YadGfmOCUI07
	ko01HTqyEEON6B1p1jxIWxz+70E=
X-Received: by 2002:a05:600d:8490:10b0:499:93b3:91ea with SMTP id 5b1f17b1804b1-49cf825e25dmr78021745e9.15.1788591609003;
        Sat, 05 Sep 2026 00:00:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf770fcf5sm123552355e9.6.2026.09.05.00.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 00:00:08 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 3/8] bpf: Preserve packet pointer class displacement in regsafe()
Date: Sat,  5 Sep 2026 08:59:54 +0200
Message-ID: <20260905070003.3193366-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905070003.3193366-1-memxor@gmail.com>
References: <20260905070003.3193366-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4107; i=memxor@gmail.com; h=from:subject; bh=s4Y0JiT4xAIDUadPi1is7tuuN5Ng/5Xc8W5oRApGOv0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv23mWPLrT719rvVnGQz1p+R+R/mrD8DQ9nXT+l5FUtL x2DVW07SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJFbTYwM2xjm+txp/TZR4tnd QyetHgioxhpEyC3+/iP95XYh/eSaowz/ixJ1vQ6//picOX85U9i96RIL796edu/r+hmXE1+ucLm cwgsA
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

Requiring equal r64 bases would prevent the bug, but would also reject a
safe uniform translation of the whole class. Instead, record the base
translation seen for the first packet pointer in each ID mapping and
require every subsequent member to have the same translation. This keeps
the relative displacement invariant while retaining pruning for uniformly
translated classes. Packet pointers without an ID remain unaffected.

Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/states.c          | 42 ++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 36b65797877d..5cf92ce18520 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -854,6 +854,8 @@ struct backtrack_state {
 struct bpf_id_pair {
 	u32 old;
 	u32 cur;
+	s32 pkt_ptr_delta;
+	bool pkt_ptr_delta_set;
 };
 
 struct bpf_idmap {
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c6a7..2f8f3fe164b0 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -339,6 +339,7 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 	if (idmap->cnt < BPF_ID_MAP_SIZE) {
 		map[idmap->cnt].old = old_id;
 		map[idmap->cnt].cur = cur_id;
+		map[idmap->cnt].pkt_ptr_delta_set = false;
 		idmap->cnt++;
 		return true;
 	}
@@ -352,6 +353,43 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 	return false;
 }
 
+static bool check_pkt_ptr_ids(const struct bpf_reg_state *old,
+			      const struct bpf_reg_state *cur,
+			      struct bpf_idmap *idmap)
+{
+	struct bpf_id_pair *map = idmap->map;
+	s64 delta;
+	unsigned int i;
+
+	if (!check_ids(old->id, cur->id, idmap))
+		return false;
+	if (!old->id)
+		return true;
+
+	/*
+	 * Packet range is shared by all pointers with the same ID. Preserve
+	 * their relative displacement, while allowing the whole class to move.
+	 * Packet pointer offsets are bounded by BPF_MAX_VAR_OFF, so the delta
+	 * between two valid offsets fits in s32.
+	 */
+	delta = (s64)(cur->r64.base - old->r64.base);
+	if (delta < S32_MIN || delta > S32_MAX)
+		return false;
+
+	for (i = 0; i < idmap->cnt; i++) {
+		if (map[i].old != old->id)
+			continue;
+		if (!map[i].pkt_ptr_delta_set) {
+			map[i].pkt_ptr_delta = delta;
+			map[i].pkt_ptr_delta_set = true;
+			return true;
+		}
+		return map[i].pkt_ptr_delta == delta;
+	}
+
+	return false;
+}
+
 /*
  * Compare scalar register IDs for state equivalence.
  *
@@ -632,8 +670,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		} else if (rold->range > rcur->range) {
 			return false;
 		}
-		/* id relations must be preserved */
-		if (!check_ids(rold->id, rcur->id, idmap))
+		/* id relations and intra-class displacement must be preserved */
+		if (!check_pkt_ptr_ids(rold, rcur, idmap))
 			return false;
 		/* new val must satisfy old val knowledge */
 		return range_within(rold, rcur) &&
-- 
2.53.0

