Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB74F55CC
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370786; cv=none; b=Cw9KP6TLkYTsnciMTE2l7BtrbAT3kL61Zi4gYzwJj8aHUI448c+A350zdMOgt4cJEtCqGFTavqeaBqMt/bLvdmMvcYkKRNhC9aZKdxB9o5UrgV+TCvwSabdmVdiP+L4Z0EZfT1FGVOyi0uSfyR6KUdtkDE1MeUjnawTGdX+URKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370786; c=relaxed/simple;
	bh=ijm5lHQWQ9SSokx2rkHGGQZO+6/C/fF2/f2jdr/P/x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPq8puv7qJdJB6u7kiiRH/ZWr+svoiyLtcW/9D+k03QK9/LOCd2vkLIBfRk0Rs0+S4sVvQS0OO4x856M/0ym7ILlBGeFomDzVxAhFo0PFLkfgoQtkMjE6Zl3KjWhgnLgRgSu3uP/IFKCdT9UdFoxE7FY6YTpM6oE57sQgLuLe5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpVjo0tm; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpVjo0tm"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae6f5fc7so941757eaf.3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370784; x=1790975584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uH5QuHAWHRs2PdTMSNLPSw5mEP8ea21+KvBhW/MXRfE=;
        b=hpVjo0tmmzBCgSMJhJNuafqxUujNd03Z8oM14tIxfYoEy29+sEvJTFveQeHTKB9vwc
         9YmcM4ZL5cTqp5vSezPYYfU2pHSQtmepezs0dYaSH46qgtnKKAxtQyOrdegUtX9sOFJS
         T+MuKyA/zwsr8LvIu0+XQc9+8rFx8lWeapw3/ks8GTmDGnD7gnYwELW6fsccLoubKg1H
         9wpHI2ufpfbEByYv4NB8K66XG9vVmWtuTcx6GfmVwic4kPnqxyECu1Hf182r71T4l1is
         RbftOxzZZvhRRkmBB4lMZrUSD7XKIvlxV9BVJeeHgZP0N2sd/+a5r9n6aKjqWZDcoScW
         M4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370784; x=1790975584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uH5QuHAWHRs2PdTMSNLPSw5mEP8ea21+KvBhW/MXRfE=;
        b=f9thvpw1c7MkT/5CeED84fACZ+vkOZqBDYo574JTtKIsIrEcFQGsDbqqIi3h7i3tNV
         KVpIUDaLiR8NhbdZf6869Q9kyoMitWY5krLupOel8XFWWtLECtT7MQYO7mXsExwLTOyJ
         QMtZDcOcMXR+g6SuvShnQ3tgvP3M9nbSuph3y5tSTJmGXp7y9hi5q0cuffHa75Rp/Mle
         hSAhNLvVvihtYvD4BCqcL2vJrwimJSkp7KxUcz82mF0H6SR5T9BeFH1Bj5InNhwson7P
         iCSA2zUJh+qJusY6bYVtBjRftZTNWWH9be4b+1j1N9clFnMmikGwjKYatNAWSCUwRX45
         5wZw==
X-Gm-Message-State: AFuF++keWsEdN7IV4ztVcyt8Er4P9EgYCAaOlqDVs7ngIo94XYqwAtXY
	9HsI7JJATgt03Bce2si/IzZgm/ZgsFhdJBsBEeK8a341J3wRceP6xGf1mHskeg==
X-Gm-Gg: AYBFou1nRt+1VmvtLeQQAKdv5XeLO+eMx2yZuWXv515Fq3TgEB0MTqlgmzRQtPsCh6t
	vqOvBF6QWcHb9RItFOZAtUdicKPzStNG5kzkTWR3Ec37OQt1teI6DUKElDi9bkpB9/URaIqvnma
	ZCaoF0Jw0c6Fd8Psw0D8K34HB5nowUqKfhq12mUjZo6lze1pzGLC4wKh6SBywXphztGoGvGZC70
	U2ef/0O/gIm6hr18hgk55dd0ejBdZm7+sZ4SqdPhVAU2vLHfaQbYm8SV+sG+SI9hh+eVOra/zHq
	snIVaq7X/kYPdUfne8cLesMfEe1Rl7kuP93OoNffJ4ef8gYmnEA7rFg+MjlE2JRLOyp/H9y1AEe
	ESR198IMJklQ7j9+fbe27atKSEWY/4SpzYXqw5jhjQYTuwtXt/uzBjxXj7jBNefRdUUvMLxevU0
	YHYZ7Lk4LmkUvXvLWfeHtUFCLs/lFgqEwjNP62cMCM5YWpEJSsp0tv4O6fn6dSZk0=
X-Received: by 2002:a05:6820:190d:b0:6b1:2f12:6c0c with SMTP id 006d021491bc7-6d43f7a70f0mr6523926eaf.34.1790370784032;
        Fri, 25 Sep 2026 14:13:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e6211cedsm3262618a34.3.2026.09.25.14.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:13:03 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 04/12] bpf: Check subprog scalar arguments in the common path
Date: Fri, 25 Sep 2026 14:12:48 -0700
Message-ID: <20260925211256.1834061-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260925211256.1834061-1-ameryhung@gmail.com>
References: <20260925211256.1834061-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF subprogram scalar arguments are checked separately even though the
common argument checker enforces the same SCALAR_VALUE requirement.
Start the migration by routing the scalar branch through check_func_arg()
and update the verifier-log expectation.

Use the BTF parameter index for metadata and the ABI slot index for
register lookup. Route extra slots of by-value aggregates through
check_arg_extra_slot() so every occupied slot follows the common path.

Following patches can extend this guarded common-check branch as each
remaining BPF-subprogram-specific implementation is removed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 19 ++++++-------------
 .../selftests/bpf/progs/aggregate_arg_func.c  |  2 +-
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 65a1245e4edb..a84143285b3f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10871,10 +10871,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		nslots = btf_arg_slots(t);
 
 		if (arg_type == ARG_SCALAR) {
-			if (reg->type != SCALAR_VALUE) {
-				bpf_log(log, "%s is not a scalar\n", reg_arg_name(env, argno));
-				return -EINVAL;
-			}
+			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
+			if (ret)
+				return ret;
 		} else if (arg_type & PTR_UNTRUSTED) {
 			/*
 			 * Anything is allowed for untrusted arguments, as these are
@@ -10964,15 +10963,9 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		}
 
 		for (k = 1; k < nslots; k++) {
-			argno_t extra_argno = argno_from_arg(slot + k + 1);
-			struct bpf_reg_state *extra_reg;
-
-			extra_reg = get_func_arg_reg(caller, regs, slot + k);
-			if (extra_reg->type != SCALAR_VALUE) {
-				bpf_log(log, "%s is not a scalar\n",
-					reg_arg_name(env, extra_argno));
-				return -EINVAL;
-			}
+			ret = check_arg_extra_slot(env, caller, slot + k, &meta);
+			if (ret)
+				return ret;
 		}
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_func.c b/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
index d0a4f84a6fbf..2132b926a8f0 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_arg_func.c
@@ -43,7 +43,7 @@ __naked int aggregate_arg_pair_asm(void)
 }
 
 SEC("tc")
-__failure __msg("R2 is not a scalar")
+__failure __msg("R2 type=fp expected=scalar")
 __naked int aggregate_arg_pair_ptr_fail(void)
 {
 	asm volatile (
-- 
2.52.0

