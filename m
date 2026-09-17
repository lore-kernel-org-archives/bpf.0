Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C74AEBED
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687950; cv=none; b=by1iPo/4pri3NzLJTo7QAWPOfHon+DB96COY2788aiE62C5T7vVnTfWl3WKdSzkTusPAVRb62RCSB30f7lkgtSnAHBnsd4inNMgn3cmWHVcW35cLplOuAmDAOMaTPZuaBUjrD0ehMKsS89t53i0cyOx8PdgpuKapoPRoX8Cdw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687950; c=relaxed/simple;
	bh=u6A1booZqff9HZn1c6UG3ORSmFh2XZq7GxUxYIULqw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK6sauzbRuNN8++/S6RGSYB2HtgGXIjsUYCJxDRyhar9k/aLJwbAwoAZzU5I5C94Bt/pld2MIvHsdgH6nbbTCB7LgxFMocayRFYvXVwX0+/XW+ZJcpPqucegEGSb8/CqPEuc10VTT0BsQW0YFlnJ34dchb4untKjhfvGhY+3UGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcEw4sqM; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcEw4sqM"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e66652cc3so856175e9.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789687947; x=1790292747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HC2tCCvpccn+pRkVO68CBG2Pf/51+9f68zCb1h69W6w=;
        b=bcEw4sqM9kgYWe3WCqsmFkVRAD3skPBMLBw0M/s0JXN1YQFJFEK0hHDjHe0UHlYzcl
         Z5s9FHuYs4p3gN9EjqDjGv0UGGbfD5Tglnw3dW33VtzYIDAyVSqJzQXW9JYudPUK2r9K
         2iSOvS2SvfE0Vx0dhpuyWSbfEVo3+uJLfXI5Ravp/vjAc/ufU+RxcmgVXyxdQIKFw1nV
         TfBfGAAoCPeDSrDxsCL2woB1iHcxjGkMRErYN/L5FrdVXiOsMIZTauIEiL+2JVjnVwzA
         T4YqzEWxRAK+myP16Fr9sh1JPIH9sUoLmzxSSBquoXm0oWCYbYIxFdtDPuCP55vmGOpp
         CE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687947; x=1790292747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HC2tCCvpccn+pRkVO68CBG2Pf/51+9f68zCb1h69W6w=;
        b=rUhmr1RNnZPrfJzofacFozfEV7dArzznsf/jX6njjoizK8AZqibRJRqkJR7vctLZfZ
         jC4aQAbDJ4Ls4EwEamFqarcEH6jjG1ymNBF3oWSujLfSA10nBxlVhKGF696SNAuSDFir
         tkYEvqnfc3X0XIznYFS4qG7mqfMfGCwuZjEMfMQGxcw7vEd72pYcF+S//BSo4KqIdxwq
         t2yK89chbxNbqnZuhsaREdLLzSG9xz8vem1j9ArFovjToNEHm7T0bml6fG5OzNjzqW57
         oBxhgT/B9us/ii1k6CC7NX3g3yAyvfIO7/w9OEp9glDPQjD195rWwg9anTBjtn9Jdp08
         7KuQ==
X-Gm-Message-State: AFuF++mft3VKKGzB224cptoFq6Jod/0wfEKN/qtvyzmcwFE8ZhlWglaP
	NEPW0MBg82jJZ+St3iQJ5YpbtWTRY77B4k+T2ALkSkzh5f9PsufS5mnuIIK4mr9K
X-Gm-Gg: AYBFou10VuP13hfslHxVi2iM0GIAQSdS0Ag0VPXJFKjeNUl22ebS7CjQbq7IcGjCmZk
	5YKOocwFIkUhtKTuYuOuRqn4Vi0s7QaSq3eNxcLmTUHjnY+9PGYojjZR6jMyjpTL444n+f98eSV
	rQgjCfHlyI28gBePU5FhujxhSN/aYXyDRZZn3Zc5lsg9ue1KooU3zzRiV5IGnb43XhA/vz3BFh1
	Mrwac0YrHaOnf5geOVBPEPCwwTr5RRNij+Umadt6DDUz8Qpoz91R29TlmwYIU/cK/EkkG5Lx1oY
	nRhXr1HTBeqzw/JwmQwx08ej8ydDg746AQqXH+2IFfm8k9Aoco9RcDMMGwBxF1ZkGxQDTMrb6QM
	HmMwp/NcCTAAIkrUMOw84cGblVmqhBmo+clgfYmxO9KsUswvhOWjmZjG0bXuJhg4NiPiqs3Ye2x
	mkIta3QW06x0EeI3ZEXUdh4fblckiNPMZErvV3QTB+X5wGr1z7pWA2VHRfrJana/Gip8JxmEhZ3
	Uh69GtUk5qchJAOXymUIHVehIr2IkPtu9OF9n09wy3dlhdiy+Jv6bvKFbcKTgvs9nHxKdUtcnk1
	D0GJsQKeLRJnPKCVbO0xPX0sYjN0DiHeRBCA3w==
X-Received: by 2002:a05:600c:34c8:b0:49e:732e:6b79 with SMTP id 5b1f17b1804b1-49fc574eff6mr4990105e9.32.1789687947203;
        Thu, 17 Sep 2026 16:32:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7ce03dcsm1487105e9.5.2026.09.17.16.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:32:26 -0700 (PDT)
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
Subject: [PATCH bpf v7 02/10] bpf: Preserve packet pointer class displacement in regsafe()
Date: Fri, 18 Sep 2026 01:32:10 +0200
Message-ID: <20260917233222.2542500-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917233222.2542500-1-memxor@gmail.com>
References: <20260917233222.2542500-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=memxor@gmail.com; h=from:subject; bh=u6A1booZqff9HZn1c6UG3ORSmFh2XZq7GxUxYIULqw8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtNRYa7jvzk+ref+/s9z7rt+7fQsulVdckV08WKEonXl M1nfw/qKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwES6jzMy7LrS1yQRfzKTxVxh 4sG6dnWrZwnzPXydF7Pun3Bou355J8M/E7vn6Ry772Tzbpp/PfzF9n2nHMuOct9czTHJMvqUTOE 0RgA=
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

