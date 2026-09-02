Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E8A445AFC
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788392233; cv=none; b=QtYbQtKjRus9+xIeu8R1upk7g1Iepyqq/DYdT86egB0eKYpXpgNBeMiv58Xg27el5McEPHgAT/mdIAdWlKacTAJEqfXAyRtvmQKUvmcbISrAORpmKLWdUBfJP3WUc0278HD0NUTNRTdeEaUzokFQDsPTCKaRH+k24cldfpO17/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788392233; c=relaxed/simple;
	bh=LjwptsOM3x5ip8XRCpLt5Z7RMbuZGVBIinYvrV0Sj9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JEx706/BfJEjjgIrZUAk4/zOFE8E3BvSageZf5VaG8wiXuOcHXISCrBAq3w17yAwxHi5lpBmKojTLbfAlz2L2nr01kE+U+5GRM/vFOl4fm7lcoJey/kSUOMvcd56G5S02ecHqepE6s/fu4V5Pma3axhGShO2LvilDZptX02l398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koiekotc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koiekotc"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d5335cf904so16690615ad.2
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788392228; x=1788997028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4l9WFdqM7tecR6VguX8j3ZK3vUuSqoqKxiim35gCM9E=;
        b=koiekotcbo+8eunKkEq3RDcaV6dkc3Uq+KuiUR7EsFG9zmaPRw+dqGNYOdiWz1gCCA
         l3nTun3wn24u2Ks9wmp4Ho4Hhe61Dc1G0FtfOj9v/QgIgt1CCEwsgAajI19d+/BQiUdu
         G8sFUcaL4LAMCIvZPFm5XtwT+mv4v0vY78sCjkIB1HDoSlBKIHC0Y+3d0p3VFMqKU40s
         PuABiooGs11RV/xH7SKGZDYTUNrYXDx5tqIzK9R/3Kj9IFVQQTrne2kvD07Eb0rc0PAl
         G7SwisVOBRfQPAFA+GEJxyE4UtWFv4rND+QWHthn3RFusWdL9HLMCLsWNbpmfT80me/D
         JOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788392228; x=1788997028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4l9WFdqM7tecR6VguX8j3ZK3vUuSqoqKxiim35gCM9E=;
        b=PdgYIhO3ZG1dmhCvz4vZiLqMzBqZb5tM1hSwQkrlByxjgZSzhVoeSNAjqVA6ay3EMi
         LObcRpGkLdiWX0rcfM9B8nXibrFGK23T8mdKyJanU/Ck+YZzOam9wJ7ysmoYCxfb7IXz
         90PG1/kzb1mfHberB1YDzdnY0D/v5PdLrHIN+dY9vG59E1K0z8up+Wq/jw8Lj4EaYFX+
         /vTtnLsLBMOk8l02OObj2DzYeqGB7hJ1xCB8iwCTmSzUtmIeaYqmSyiioIbUUf9NIvcb
         AsM4MlWprWCBa9qyDIgepNVg05FmSLgsLk9/1sAa/jGVulqgFtu05Vyxm7JXb7A1RQiQ
         dDfw==
X-Gm-Message-State: AFuF++mVyX+jmYzVvAIGQJoBuQqLcQyBIEKGkb69Fb5T8tTQIMy35uPQ
	umh4T6PnOcG4nsj2Am8O/FJF//heKHWmkG+Da41Nj/ohADx3ac/HbNcL758yze9ITCw=
X-Gm-Gg: AYBFou2Av0EDK1KDe90Y8IQyqaw7x64iKSL/mPR2oPgbxXaD8m77KJMB0LRl8zSAIWI
	GOl5DhdUhHnrQmylKIZ/nUt/YsEr8irH66PY+jdZ8idWEHC080W3GmjjdpXnV9KAO8KtF+eCOC8
	HPAx0nzK79eoxjaeN7ALcBBp+pZreA55+5Kam4Eh/Eexf6vU3z79CZVAYT/zaLKcpzFDTCw5Y69
	VSXJlnShqKBBpYjMJo9pmcWOBJQ9VfbcuY9URs/3TJReCn/G9P21pra1H2EaZX6dfmX9/G/vNdh
	G4Qs2YRPpOL/sdvZyqk6wM+wPicTjhLq7sCWcsWHD1fEO+OIZFdFFGkHt6Iyzq22RxSCzzYjarI
	2NWivLgDbxMUcltfrGuTAVGN2ZGz7X/CHQBckvx1ZknUnywWxTmkh0dHH1/gGKszqghedBA3CBu
	ilRjdruOMPIN5XWF74Xs1UJsE4eXACIHIaiIYRFiTe66N+C7OTIE9mWxG2hrWElwuNcmTFpF2yy
	rIRR4Uqpo15B+A/UWVK6C3FYLXTbfu1Wlz8NoJWr6kPWw==
X-Received: by 2002:a17:90b:3d81:b0:398:c150:e7b3 with SMTP id 98e67ed59e1d1-39aedf5d923mr12738426a91.4.1788392228057;
        Wed, 02 Sep 2026 16:37:08 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1238])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33253672933sm2583725eec.4.2026.09.02.16.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:37:07 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 1/2] bpf: reject BPF_PSEUDO_FUNC reference to the main program
Date: Wed,  2 Sep 2026 16:36:57 -0700
Message-ID: <20260902233658.1186477-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fixups.c:jit_subprogs() rewrites BPF_PSEUDO_FUNC loads to contain real
function addresses. This function is invoked from bpf_jit_subprogs()
only when env->subprog_cnt > 1. Meaning that for any program like
below:

  int main(void *ctx) {
    void *ptr = main;
    ...
    bpf_timer_set_callback(..., ptr);
    ...
  }

The 'ptr' won't be ever converted to contain an address.
In combination with e.g. bpf_timer_set_callback() this would lead to a
function call at a bogus address.

Instead of complicating the implementation, just assume that no useful
program needs main to be a sync or async callback and reject
BPF_PSEUDO_FUNC loads for the main subprogram.

Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e64035683795..7d8ddb1bee00 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17089,6 +17089,15 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			verbose(env, "callback function not static\n");
 			return -EINVAL;
 		}
+		/*
+		 * When env->subprog_cnt == 1 this instruction won't be rewritten
+		 * to hold a real function address. Assume that no usable program
+		 * combines e.g. main and timer callback and just reject here.
+		 */
+		if (subprogno == 0) {
+			verbose(env, "callback function cannot be the main program\n");
+			return -EINVAL;
+		}
 
 		dst_reg->type = PTR_TO_FUNC;
 		dst_reg->subprogno = subprogno;
-- 
2.55.0

