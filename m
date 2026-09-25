Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7E4F55CC
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370789; cv=none; b=o8cFXhbNeAmVuQAr+5Fb5WA+QC4g7uz2Bcqm7xgtmAMci8YSiliukLIlNIKKGmjLkGZkr14ilJ1dBWqmVS2MFaa1vY0qWMvVFjLEdmCw5doLirDuF6Tt/lm7zH8tDYxTkH9thJ99aUujTgyzP4jac6EAQ6eJxEFcSXyBxMmWvuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370789; c=relaxed/simple;
	bh=mI3k9jVwzBacxDfMSaLENwwLQgPwCF/GqbX+LebN7jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHJewKEti/1YZSU2oXpMaapy5j8NgbXC6aDL2xIWdwn4MwUSWiSHNalOzfyJgw52azbItCCJ7M7DYJm2ie+KgqF58IYsWxkfdsuvt297OowegkV1BQdglUJ/ix9oJrh/cAv5HMuL+YPGG4QfvzypEdknOdqY21UlnCkdGBSE4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byBp99UE; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byBp99UE"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6c24d19ebcfso781063eaf.3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370787; x=1790975587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0c0XIcKAlgb6Cn/vjjxW93mjka8mCqlV+QfNgILJ4bs=;
        b=byBp99UErjjFcAfipXeLC7i6vt4vCmnTZmPYS/U0KaG+VQpbWBXe1n092m+axT2nuX
         qpubllixbt/ePsB0ipaLT2BdaGj2s+LCFXT1YvYiczYUm01hH5iWAeTnzIuWHySP5f2m
         688cRBmUlGC9x2Xgl7b3YG7IzIGzJObqp7VneOfGzwl7bxNL1/a9n1VupgSqbVfBmfjT
         LQLEFqmflO400aqLnWL0r1vaNEtUC/P7WIhjsq9pVRikqXLintt03BnMm8ZVtZ4DadS1
         JEO9moUm6vqGJiiW3vbw++AEjguDdEIl2rFnKgBsrV3X/9Xh/dc8+cr0lZIAmy+zGNWn
         m8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370787; x=1790975587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0c0XIcKAlgb6Cn/vjjxW93mjka8mCqlV+QfNgILJ4bs=;
        b=JFDHzyP73iQxLxS7WMTcmyGvsNNhRzfCpfmUBQ8Aqm9x/mQCHTt3fn95QrCEjUp5ST
         n+63/WslA5D9SygWhSo696C0ZwbX2OZEz8UjSNDAbiLrDOcBxEGkslYXflWo+CDUZoUv
         oJK5tIdFpSzPC6ZTguGyy+O//PnlM4+CbA/B/uBjksVAMxTcJ1fB1/rm+BA5c7WgtAz5
         hKU6/FE4DcVEoJZjChHnX+7FZd7ZZ9XwImuNw2cyGpPT9au+pvgB7MYZThaSDUDtBn6G
         oS45q+M5nKiz7zUu9xMGc/Szymwy0Rbc2Fh+g22EvL4tD6slr/nPEGIdOCNzS3eRT8dw
         klGQ==
X-Gm-Message-State: AFuF++lXdpON0zFV9zfCBirbsASb5TSmolK+LUmVs9a4IDZYJO0FyTBn
	fyRU8RMD2Ebd1eIXJ/h1q841vlnKSaLjnQPE79JyK9+FzyN8U1SiDUP8/FZd5Q==
X-Gm-Gg: AYBFou1Vwt8ezaRR05Gbyyor/TBzkFZl7zJVaFl77hN5mNm7fkCVITtRgxn97t4ssIP
	MBh/fvMhPe5k8G0d8V8wIe+CDqHeG1D1HYD5SllHgHUwBGHGyj9Osfd/0kSI/bM0AaVv7OpcGXV
	zo9ZTXLUT46LwvoMtrNXMS16Ia4Go5OVPmhC29I1qpH+UR86q4KG1Eexhmiyggx5CKxccg0hhb0
	RN1fz2JL7ikf+wWyNhuUXoOJvuOReMKorD/SolFKiPz6ph5bP5fW57TWhtEljGj+wQMeNaITCrJ
	TZG456ZYhRfzwjrfrj1ZmsNMzEiCVTQ2lQ8GRaHJuMM/oVQnBZ1cvaqDB8QIwACRb/6M4X5zI1u
	HI2KnVKHzotL9FgVAMN+c5gcDmqLo7ESvQCLUs60U/e2Pa4GF5NsU4nSZKkgWeU1Qouptoudl+z
	HTalVyjyMv5dH4UaQUPUudaEdBeimKjv1gMaXxVE0a/MXdGK6QebARqyl76ntEG8tGNyFeZEkr
X-Received: by 2002:a05:6820:2083:b0:6ca:3ce1:ed18 with SMTP id 006d021491bc7-6d43f1cd7e7mr6294449eaf.9.1790370786475;
        Fri, 25 Sep 2026 14:13:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:11::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d583542ffcsm3580512eaf.14.2026.09.25.14.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:13:06 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 06/12] bpf: Check subprog context arguments in the common path
Date: Fri, 25 Sep 2026 14:12:50 -0700
Message-ID: <20260925211256.1834061-7-ameryhung@gmail.com>
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

Subprog and helper/kfunc context arguments require PTR_TO_CTX with an
acceptable offset. Route subprog context arguments through
check_func_arg() and update the verifier-log expectation.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                             | 15 ++-------------
 .../selftests/bpf/progs/test_global_func5.c       |  2 +-
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7932d81a5aa9..a7b245e90f33 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10879,22 +10879,11 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
 		nslots = btf_arg_slots(t);
 
-		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE) {
+		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
+		    arg_type == ARG_PTR_TO_CTX) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
 				return ret;
-		} else if (arg_type == ARG_PTR_TO_CTX) {
-			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_CTX);
-			if (ret < 0)
-				return ret;
-			/* If function expects ctx type in BTF check that caller
-			 * is passing PTR_TO_CTX.
-			 */
-			if (reg->type != PTR_TO_CTX) {
-				bpf_log(log, "%s expects pointer to ctx\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 		} else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_MEM);
 			if (ret < 0)
diff --git a/tools/testing/selftests/bpf/progs/test_global_func5.c b/tools/testing/selftests/bpf/progs/test_global_func5.c
index 257c0569ff98..4573ecd96aa0 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func5.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func5.c
@@ -26,7 +26,7 @@ int f3(int val, struct __sk_buff *skb)
 }
 
 SEC("tc")
-__failure __msg("expects pointer to ctx")
+__failure __msg("R2 type=fp expected=ctx")
 int global_func5(struct __sk_buff *skb)
 {
 	return f1(skb) + f2(2, skb) + f3(3, skb);
-- 
2.52.0

