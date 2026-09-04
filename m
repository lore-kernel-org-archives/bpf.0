Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7446D550
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518548; cv=none; b=bqqS0l2WsrzM2bedgel5lP403EF5gdotw6+/Vhy+dhFgYLkadrZTKKnuY1bDxt/svHlJk6iAeGJDsreYKPd+kZDr928BlRDHJMB5d0amhaL6raOnM8NKlNExaTkVIpY6ANwXvfoSBO25/qKHdZsS9J4Swe7cptmpmxYfinwvCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518548; c=relaxed/simple;
	bh=bMRurldRSRqtzCEv+ej85ViPmQWWCjjwTBlmVuevoaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+B7S+ONBqsryQ+OFJgb0XJstCCP/6cCP2SlBYjnz5Knc9ImWoWEUok1HFopTNXZUNypUFLzbvzJDS3xFQ8ibd5QHe774C07NHQsxEQNRjPIY27FyM7CoDKWQ7rSbJ8bBHlE3TU8Xjt13EcXl/uBR4L5a9mwivO2+14zzINEBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOL4arfS; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOL4arfS"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so2329055e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518543; x=1789123343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zujED7urXh/czNFTuUB1hA8dqVviRGAKiGqo9Q3fl1c=;
        b=MOL4arfSkJbxqcHaFGa1/iIJva5k9WNTzgig9f4N2WKfKlPRx5USJI3gB/ySxowfxv
         cP2ze8v6559ItY1Sw/XlCvIQ5pj5YgbWGmM5IBPDkikdu6gGdJG+UfLUchihEn3zPidl
         Yk4VF3BETNabR4R0i5NDGYrYpGa8kKWVm/VP41GZpC88iWHtu+xfpG0idiKwKruwUJTN
         rs6+WXfKPGjiZQu53c+5vwmfEWCFvCGAQVYnC7u0XNCRm2fvi2MqW/I4TbS9gu4dYtt2
         OFpHST+G+r894pBVFf1VV5E1reaQkaovKm6WEmlNDSkUzbwVDSZTZRlFBp2RWNAJFv1U
         bXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518543; x=1789123343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zujED7urXh/czNFTuUB1hA8dqVviRGAKiGqo9Q3fl1c=;
        b=RIyC0ncD8RhNrK7+bfsj04Pi2QcJlWkMj0bRaDI28I3ziDBHGoHORBTbrVlX2mT7aI
         Hr7UBKVn24g0cxPvdFqRlqpo+Fqf6BpIJbVLwFqGJ5KUskM9K9lDSTJYDHpjRV16h32O
         K/li+/RyzDK5op0aI4qAcxkY2gA2VWyb0MgjxRmI8nnTWtmzDgDrGRzF1MGDLYJgKt42
         zFAG1vyG/hBlVvRXCFG3Tsdz1eDbbovussSLM9KVE86xv9En019+dy4cznFOfctCkE+m
         JiFEOOzTvpWNkIFxC/pCgbvI9dk7SICJg9zR9+vTx3BpT/U6WU06yzanKgGO/gYciksk
         MEUQ==
X-Gm-Message-State: AFuF++mnJdjeWyDuirhq224XVw76d3R033Yy9qXeTf39RnPJIfe9kETV
	JSowKpTaZpKRuqh+uAVw4jAT6771JulfEuYqLtZrFtdRanxxHyNPN4F8rG0BGycg
X-Gm-Gg: AYBFou0doOaLqJyBLXngO4sFERH2tUvJs34MNu20AM6IyGNwZHdv1TfQVbMRbmr/3ru
	yVg+7enwXvEC5AIq8ueV8m6bCNeh2hQqO4wRSubRp4vaOZ9EyVAAH7j1z5OKYUO3Hy91pPcMyrR
	6J8zvBkC3SehnERxAsmT7soG+T3uY0IWk+3ppfmdhhEiVcLDVZf94rTRGftjxAOZGPlROyUv8qk
	XLHIPbSuK959vL574YV5tG1N3wNJ9m5elSi26NBlzKMPvz+zPRFAeP5RKxj+EOKr+u6RPpY/ifr
	2HsJtCCaWow/ovlBjvtwhI7FI0Y2haBCmYkle+QEGWoQVL31jwDurpxzZtPU+QtyAkRnoGMLxu7
	n/djbXG9k1jrDlzv+EUqCOhHQAJ3QBpj3OICgnXiN91SeuX4Rxz3I203CMwAX6oCS05yXo6n3ZZ
	cCL5GPR6kciljCPHZVFkazIFcPjnNP1Vs6KEnqO+QWcbvHTuSoDvmT6zlvyt1dzXiMZKjlH/BZR
	xJhrrKv0lR5VqY47RkBBq/UsMohwI09H2pDOXD2mnlpDnZZ7qFVu85ZuH0IUplU1dLWWB+2UA6i
	zA/OijshWsOr1dxjEl6j19TtOZU=
X-Received: by 2002:a05:600c:3ba5:b0:49c:dada:f581 with SMTP id 5b1f17b1804b1-49cf7f39c8bmr63201525e9.0.1788518542933;
        Fri, 04 Sep 2026 03:42:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm60771855e9.0.2026.09.04.03.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:42:22 -0700 (PDT)
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
Subject: [PATCH bpf v1 5/8] bpf: Mark NULL kptr stores precise
Date: Fri,  4 Sep 2026 12:41:56 +0200
Message-ID: <20260904104203.345917-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904104203.345917-1-memxor@gmail.com>
References: <20260904104203.345917-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1909; i=memxor@gmail.com; h=from:subject; bh=bMRurldRSRqtzCEv+ej85ViPmQWWCjjwTBlmVuevoaE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvW/HMPpzlaXTstUx0v3sJRvOrb0qR8wSN2O/4u85aP7 yz7HtvaUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlcMmVkuGv7Mik6XeLHyR2n aibNUYu2S753rby/x5K3PuO+WF7UGob/fpvS7t6d280TuP3mh/ufbm32Yb26Z+u2BIk33WHrznQ WswEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

check_map_kptr_access() permits a scalar store into an untrusted kptr
field only when the register is known to contain zero. Unlike other
verifier checks whose outcome depends on a scalar value, it does not mark
that register precise.

A state checkpoint reached with an imprecise zero can therefore prune a
second path that reaches the store with an arbitrary nonzero scalar. The
program can write attacker-controlled bits into the kptr field and load
them back as a PTR_TO_BTF_ID.

Call mark_chain_precision() before accepting a known-zero register. This
forces state equivalence to compare its scalar range and makes the verifier
visit and reject a path carrying a nonzero value.

Fixes: 61df10c7799e ("bpf: Allow storing unreferenced kptr in map")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d7dd0befbd10..ba9753bf529a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4694,8 +4694,15 @@ static int check_map_kptr_access(struct bpf_verifier_env *env,
 			return ret;
 	} else if (class == BPF_STX) {
 		val_reg = reg_state(env, value_regno);
-		if (!bpf_register_is_null(val_reg) &&
-		    map_kptr_match_type(env, kptr_field, val_reg, value_regno))
+		if (bpf_register_is_null(val_reg)) {
+			/*
+			 * This store is valid only because the scalar is known to be
+			 * zero. Mark it precise so another scalar cannot be pruned
+			 * against this state.
+			 */
+			return mark_chain_precision(env, value_regno);
+		}
+		if (map_kptr_match_type(env, kptr_field, val_reg, value_regno))
 			return -EACCES;
 	} else if (class == BPF_ST) {
 		if (insn->imm) {
-- 
2.53.0

