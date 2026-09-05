Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C743F0B7
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788597267; cv=none; b=t/ewwwna/fZzvivYqx9eiu0lE4YMN9GsmM1U/lcAPFfYAiqsrTwG+/fRLeBgxepItTNTV6XZFu2EbiWPY2p3iG3svrGapQFaAnqcumLe9y23/ZaebNfV+CWfKrC2wgUS51yLVI344PIfAdV+LxwOhMsV0Di23XEjyvi9NrkMtkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788597267; c=relaxed/simple;
	bh=s4Y0JiT4xAIDUadPi1is7tuuN5Ng/5Xc8W5oRApGOv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miTlxLDMbae6yl+62qvQVFzFmfadOANtFnrUuJ0Hw4ubLYLS3kGTOprk7aiILfNa0KDj2mRAQ07M5g/GhcKXUAw7TScODKoIq+1pbH8tVUY4/Dwc4J7Auk83FDcrwHqCIeG8gT1Om4lEDmsTEONym/TM7O/HmGWN9Hni+yKzBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bx5Va2IT; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx5Va2IT"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484372811e5so538472f8f.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788597263; x=1789202063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BgkcIgRjcx8CzsIkhrtznq+t9jdmXNqsjQeLbjfh6oU=;
        b=Bx5Va2ITzCSDUoxpyG7glKZdGao0zIREAtqTOtfRNd02tOPoHDKp18YFZ7soNN+x5N
         WFgXLcIcQapYskyg3IFtRVEi8qLVrnn5TuDe2nZIfOK9NQpqLTY1Fpa1hFGj9x2joeBv
         0TzscKTgdS3xq9kastP5z++mfNAZeVN+PBn4C8YzXUzH+AyoiZKx3QEmbLH+XI9R+WPy
         O6GiGyrOz7NkF+Q8FYOhXchC8zdW7gemaDyLFP7n+YPIGfctwyEbPAssFvHqeyE2agW7
         y5oafOR0Or1c2uZmZv2vknvYx1uMYS3eeCcLZzRhzSN0OPCWBpf7uqYf0L05JDxbsAlt
         1YxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788597263; x=1789202063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BgkcIgRjcx8CzsIkhrtznq+t9jdmXNqsjQeLbjfh6oU=;
        b=MvPHTGoD3Oi8POAcEFHIZ07xIdgqe7Lyo/70WzV/5kHv1x3dUC6x8HaPTOdB6yPCop
         rIspPh047zDUgJyCRs+HdwWgYyHUqAgW0rKp1kbI4hipzy4h1fww6BsiHsBfZnsYlsln
         1FVxVLMMKU/opNwgeIlNvOWnW8v74EVKihtavBLwR8+arC4m4R+pkU1ik5cGGCLT2RxO
         eLBIcoqDa26Dg9hQYtFErIWB1Qrv/2VPMOUK4BmEd6Cda7nXF4Cd+t5i14lY4zayU3yD
         BihiqbvbCqjjtujBsJGe1iEulRk9WcIXJ10BRHbDI886sJtDdl7tBKMg+Rw8tfSa2HkR
         j3Dg==
X-Gm-Message-State: AFuF++kbHl+8wPLbwpGbnWSY/KyfQ4ZQX6l97yOIMlOoqiw3IjVJdryT
	lzSGtqxhWsuM5V0V5qaAOndu9pSBCJ4bNLv9Oms7+o6PQ1pGZRm1keg9Dso2ZZFA
X-Gm-Gg: AYBFou1oR4xinBNPl2fmve1Zq1q0gP0ByUE6d38OWVg7kpNGi/4K31lvZsOhZeoD0R9
	4aGzvfsZIw6PjA5MmseGmAcjF6h1SNhNopxGC6OvHKsKcvBBLAsCSAvxcZnB1KIKGLMoAu9qPDh
	4BCpTOQRdzHv/0EcWFWQHYRgKhCou6+x+ghiXe9rYWOBacV5hGjylT1ZMQ0zmgKsFE9IG2oXn5H
	dQb0k7u4GwL24UVR8QacQHbyu+XiZCXIUse/848wu8G6c8WzHJAs9o0rscOnKHUJBF1of5KQMMm
	1Ka3MXhmohPcap05LySV9/cxZv7JObLODK1naA2bf2IUC5ZMly7nCwWoAdWTqft6FYUGb0jhL0c
	s/a6HYwuEbj+HTLpMQHK0kUEheeuGfTzbNCJACuH4S08+Yvr0joW5XZ3mcNMNSpvcM8y2F9SjW+
	vAToQfxuExSFJPJw5db48HsrxdRVM8N7WNRGvp6a8Rn3Ij/BsM2TGU/UWHcl+5rimvWaWJJevEm
	tG+G9roGwMxydkuiqA6dmDrCzB/I2zmBlSGGVU4Fjufd0VQCzye68SExfcWNEpBtfOzxA7vvKZj
	apGCu2ok9JzAlz++cK3QRgmyqtk=
X-Received: by 2002:a5d:64eb:0:b0:482:e4bc:51a8 with SMTP id ffacd0b85a97d-485870899cfmr13967010f8f.7.1788597263317;
        Sat, 05 Sep 2026 01:34:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885be1c1sm11682289f8f.32.2026.09.05.01.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 01:34:22 -0700 (PDT)
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
Subject: [PATCH bpf v2 2/7] bpf: Preserve packet pointer class displacement in regsafe()
Date: Sat,  5 Sep 2026 10:34:10 +0200
Message-ID: <20260905083418.3723623-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905083418.3723623-1-memxor@gmail.com>
References: <20260905083418.3723623-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4107; i=memxor@gmail.com; h=from:subject; bh=s4Y0JiT4xAIDUadPi1is7tuuN5Ng/5Xc8W5oRApGOv0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2pfxHF9r9a+13qzjIZy2/I/I/TVj+hoezrp9S8qqWl 47BqrYdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMif9wz/o6R5Nh5YH7ddyGaf /Zvl+/rX3Rdoj7525Na2IOZY3Ql/pBl+sz360FHo8uFI2465ftUZv2yalXpdrGY6rcsXd5uWeU+ DBQA=
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

