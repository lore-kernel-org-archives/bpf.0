Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF40237E5DC
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619263; cv=none; b=dWKL8DTVJg4e2TJIm2rWdkwZijD78RhSJGqqjX+NpcELs9jw97NC0qLxLRfaL+6GGeqSwJN5Oh+swemhvidNUtLrgdEd5ZNzMscPjmE5Ue0CPNRhkJTO5de8taIKD0qFg0vk1y0Y0lenRVbkE+nNnIoKmlXQ+5wnNbK/iwT9bz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619263; c=relaxed/simple;
	bh=3gVR2k4Vd9YjqVgVe1YI+B7hQjtZQZXuxdk14k9/UIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGwWsLPBvh0LnAEUvFzSBi9u0t7FeL9hlhvNERpq0DWQxszzrK/eRou0AYADdddXSwK8WLfqBZKJpSLoiLuzp2vWPh8Q1UvMra3xKGsxeMDR24Yrqy87eytL/dSphlUXhJqBOSUCXJRjL7RXyWPsprH5U9FZb6z8hO5e771Tiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE/HeTcn; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE/HeTcn"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6d797cfdd5fso1210615eaf.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619261; x=1791224061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UrVHuX1mKCuybU80qqz2uMNAkaAKfMcq7l1BoOa6mqY=;
        b=JE/HeTcnU2PkJL+xhQuTHjIgWXmAfQCcWyUwAQ2NhTqOE9Emp1FvoV4KkpLMLSeMJ1
         Y2XgXtxbN5kx5JTpTy1egaqVyjg81CZOmFAu/9auYae4YXnYeftywhlQ9zuDF08WObi4
         qP/pJFbE7/6OMwpYqCAO5aa7i3CPEmojAeXJ574JtGvRuG3bcpnkvoP9684pTWSTE44G
         EMfS+VdYXN9fTQ7vkvIjw6WBOm1KtQDjBlxaYLHM4TmhXwKq1OOw5u2b5Ku13IdHtw7W
         TYQlox6GU84pEQjR1b90uEeaVLym3mjF8ogh4Inqilv2ypje5d83W/6FQEQVTpFX2JKo
         wH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619261; x=1791224061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UrVHuX1mKCuybU80qqz2uMNAkaAKfMcq7l1BoOa6mqY=;
        b=siv5ID5oDgyN83pg4+NWgp31zCzsa19xh18wXTojERdEnVZB8rE1VVTZOHvg3kYY47
         5+10NR/5SpE+8aGDJhKhJ0GdkOszYrv+TyPC+GMw0wP/mSlBvlZUS8c678eM7bLAkHuh
         6Pfpm2aDJxUiwJ5CKuKwrw6K84+Lsh5VaDkY/LJCtgEdXCMQFUYjkDKFsl9UZncBi8bu
         ng4NSDY40WfTjhgYjJInTrSVaPW3Y4EI5QSAqpLNKZvG/XbBUkEaM7KasVZYtPb7wrCO
         KoO1xRxQolHA1naeaX/htXH4uqW8SIWRGFQmeu7Qz+qhf4VWjL4ouKdSXWkvwM5sc6dJ
         3RGg==
X-Gm-Message-State: AFuF++n7ajQ6sOe1Ee2rQcOD3NtKn+aoc1gGONBTHcxe83ku1uouWupV
	zVWjdqRDcCseDd7gwCjeq0AIT5jHO7XmlGD5p+eZQkjWj+u+414n0Bj7m7rmtg==
X-Gm-Gg: AYBFou1OSYgQVeRWLQyc3LiNcyCkInR44+Yu7VtDXeFUdQNgZPiGmN0SfR4Ki3CzOaA
	5HJBKxkkdXpodqpo5P1Oham3sJlRfhoprh3KZ4k5EkrnCrBQSUgJTjje/IHiU85Hr6vJJqNqc6o
	HoAYJqbuJT7Tw7xpWrLXdUGebbdHiLCaK3gBlgcpNkCh3EJVZwEJdjZ7oKV1eXLPk57P9yAJ4kH
	2LYbW7/mogg3Ax9hVaSiJG4PHghVX6jTpudTPU6k6JDXrDJxtW5exZqZreiSQq3pTMcaDOImhkL
	I4Exp9AShDjDF3WPu5LVGsI2nt/cbQVo0BswLBUr7v7rAbACuSBeXyABliZBBOTyGJ5lU9RrwOj
	k9tiUjXjzTaX+M3+k2VDSMHHVFWR76+LKRhzx9hmJ3zqdQSjoHVibhe/SuQKSIGafBe/a8ZUQH3
	Sx/2bfPqCfILT+OHanu3PoBitvAMde3+Owv4ONTQlRvSbmc8Wn3eMjKV4mtrsqc2rpUE+8Ejho
X-Received: by 2002:a05:6820:618:b0:6d8:92b9:4399 with SMTP id 006d021491bc7-6d892b945fdmr4420951eaf.27.1790619260569;
        Mon, 28 Sep 2026 11:14:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d57ef2c07sm2084551a34.4.2026.09.28.11.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:14:20 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 04/11] bpf: Check subprog scalar arguments in the common path
Date: Mon, 28 Sep 2026 11:14:06 -0700
Message-ID: <20260928181414.644158-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928181414.644158-1-ameryhung@gmail.com>
References: <20260928181414.644158-1-ameryhung@gmail.com>
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
index d2281b27f17b..147473cf14f1 100644
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

