Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF2494A18
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576511; cv=none; b=N4hb6yJoZ4AGoP160GkLhBOnYqkstWb/dV+yGFmL26ZHAwvBUmd9CF3/p1Aw05JRudc83gH1fOTgBiyXDhyUs/goJbAdPOyigOwF9NfDZ5rOgZl5z7O/oa3YKzwqnugGiBWibA1Z/OGsLME7/BOVqoq8vRe4eh0PVZ/K5FVM+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576511; c=relaxed/simple;
	bh=hq+l3Wi6nBu66fux9G2Qmg0ztbqBkzpKo8+DAjG2j9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fa65gTQ8nRiqZTtUEvo1ORCIKiz5pFeMLJ6jT5rnXJa2pkyUUytsRarIb2Nw4exVaBYbPgpGwsK2kGoPIu2JPIc6esSdZj4fHAW25wfgcKJWGrQL4slvXWoX4g5S5676ehLdDKhBPgxIJOW8CTZ1IOUmqdhTcw493za7yvN7DL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ0v3NGw; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ0v3NGw"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-4955674321eso2512975e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786576508; x=1787181308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GzwLFUZ6n9eF7AgZHBGlUmg004VwQL/U1OuHwZiXoSE=;
        b=NQ0v3NGwy7XYyhGU3nF5Zgpn6peNGCvZB7Gn29Wt1ZUlwN7akaoXj0q0k5RtIA9puM
         3OqShgHrqdPbmZkHplt1n1sqzg+b6H0GEeGEvsyBPU4+ZUa0sm0xrOjidY+96pnzSlLx
         ufc+HrFL9LVCwE1vvjfvooWWakjDQkoa/LhbWeUAC7nWech7Sw3JrhJmchZ7VR8SkFV5
         JQwfMAt4LQ+Vj5NGhspSw28vpkO7dgFT2SVLZSQ4WU62kr6LFJqnQ3pkTwj5radCPRlP
         +RwFqrdRcwFWOFwCQO8wCZo3S60kDUH59egyGQXhOI3x2+XDAwsRbwNqrnDAb6iXzC9k
         z74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786576508; x=1787181308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GzwLFUZ6n9eF7AgZHBGlUmg004VwQL/U1OuHwZiXoSE=;
        b=X1hUNbuj5tZXlweUuYSBkvf8xGbov9bWuat1HP6PEl/2/7ye75epJEOViJet51y42S
         /+8qfaMdqLR0KSPfjVgPsTDCqSCJVl4AhI4v+71bwJeoJdBTVJWrQI/oocClLnVXayGX
         nzs5AmdO4hc8uGs17E/6H4vlInb2QwlVYaDxAFcYicg5o5SwZ9sN/AnBTkEqnLiB6iov
         ZFmADtPW6fNXItRjz8FctMKyvtOJLrnnzMTEOE+IRuMnU+r9ofHlydW99OxTDz9fl0Al
         xNByHNwoXFjMwt9rj/KFJMEo8lHduz+SGgF8ugutXAV0BEDUS7rtF1/bmUQGUS0q7XoI
         XvlQ==
X-Gm-Message-State: AOJu0YxkzMLyUirRXDXWwvoTX2JHmmcjeyTRVSI8nKz1380rGBNq6rcG
	d0IzhhgOrjHhtb5277Iem1sF2KCHDYWyW16LoBCZrJy6Le1Cdl3pfMH6kYwqPQf/
X-Gm-Gg: AR+sD10x/+mWhfgLvWtr/1pbTwgeA10oEvBhsGesYeayWh0K5NQ1vivoxeZ6zWoqAwB
	3R2ldhII0g0s+G4WjkU5n00/eXslvAD7nbOKYiHePBdV7dcq4+kVZhr/rFA4/aYru7R8MjUndCi
	8mgIEJkyn+XNu70ex1zWQuIFYuiWXvV/wQTB02DTWtQwxd/SONsZjvcxZeSOE82hIgDvXX/jhcv
	INhlvGNQzvSDzfNUJwMrQ/OA7NKIrCGQcWe1zzBs0akp29yhv5eXqO+395BGrBtxEMWsJCYIGaC
	qcyfZv+i+btF04zlyopNGMhijXHFFNTFm69buS4KWsj2PwtU+bo33NOjG9hIO2LoL/McMXB25q6
	Klfboem5diLpBdrn0Fz8eHznhZtenvK/ZG+Tt0o0wSQAnRwnxdZrim5cKbSBBgOTR+bIrRfVuuL
	waq0kav+t1ndjAMvhzW2nhPirq2nOss0+KeDKmaVNAPqUz5jcTdOAV/ipsyQcf8Ti7W4tB7p1WB
	FXkxoBMmXA1jlH0jPerQDrG29rw0FLTymVsuhAbpX+zXeAH6JdeQpx5/DRpphMJk/LKVRVFoSwn
	kfp9/qbTtCxeinlRgLcGFNenIaM=
X-Received: by 2002:a05:600c:3b05:b0:498:519:e660 with SMTP id 5b1f17b1804b1-4998217bbe9mr12940465e9.4.1786576507884;
        Wed, 12 Aug 2026 16:15:07 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499820c2897sm26637265e9.0.2026.08.12.16.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:15:07 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] bpf: Fix func_info_aux desync after dead code elimination
Date: Thu, 13 Aug 2026 01:15:05 +0200
Message-ID: <20260812231506.3558128-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=memxor@gmail.com; h=from:subject; bh=8drCH+ILjhzZC3RjcY2l5ZIGJSzth4UYGqBU0Bz+A2c=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavm+9Y0roefr/lf3l15+sjvn3bnY21aRb7M3t+1InVZ1 UbFBZ7zOkpZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRo10M/z0MQmuWWZ3lY7h3 yEdsQe5qvWa3IvGeFQ8i0u4ulPVWr2FkOL3QTO+MO8PW2990V9cy19TP5jmlLX9Tj1WuOFjy1qL /jAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier keeps per-subprogram metadata in three parallel arrays:
subprog_info, func_info, and func_info_aux. Dead code elimination can
remove whole subprograms, and adjust_subprog_starts_after_remove()
shifts subprog_info and func_info to close the gap, but leaves
func_info_aux in place. From that point on, func_info_aux[i] no longer
describes subprogram i.

Shift func_info_aux together with func_info so the three arrays stay
aligned after subprogram removal.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/bpf/20260808064523.DE3E71F000E9@smtp.kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/fixups.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index c4bd70befbb5..37ea85e974f1 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -401,13 +401,17 @@ static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
 			sizeof(*env->subprog_info) * move);
 		env->subprog_cnt -= j - i;

-		/* remove func_info */
+		/* remove func_info and its aux */
 		if (aux->func_info) {
 			move = aux->func_info_cnt - j;

 			memmove(aux->func_info + i,
 				aux->func_info + j,
 				sizeof(*aux->func_info) * move);
+			if (aux->func_info_aux)
+				memmove(aux->func_info_aux + i,
+					aux->func_info_aux + j,
+					sizeof(*aux->func_info_aux) * move);
 			aux->func_info_cnt -= j - i;
 			/* func_info->insn_off is set after all code rewrites,
 			 * in adjust_btf_func() - no need to adjust
--
2.53.0

