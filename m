Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7378C2DE715
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085377; cv=none; b=IYEkZaVQsg9utr87qVlFjKKjjrIy/T4ADlwnvKVfHJttYNqV2t0xsQYaOPIMagbjRv/RKtd9iZn2YwcECb1jbsEVEHMjsIwzTW8PkLGOCDGmxw7DqSFPpx1u+dDladjWJo88x8MvMALVgehwxVpPueFomP6Zx7ZYDGmPNSbI9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085377; c=relaxed/simple;
	bh=yd9suuqaBTQJ0u+KqTX0eG3Ne9QEvqWkbV7usNzvFHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImxGeBJNoBf6/WMzdY/m7QSiy9S8hjEmr22SzsjxdMtQ4Kajysit51hKcge6y/4OzXtPMSVaE8HxxxTSI496BdVQTDO9p0wT2ajSKj8HrfgdaI2HTNrJMc8bcsiS4h4HvLmXgVm+d4TZadJfGzlibf8499yUaMU9OnDbuRm6/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvcAMzUF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvcAMzUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC809C116C6;
	Tue,  3 Feb 2026 02:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770085377;
	bh=yd9suuqaBTQJ0u+KqTX0eG3Ne9QEvqWkbV7usNzvFHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvcAMzUFDothlKBGH7gXQWQ93kKbQWOcV7NvB77lzAHj6kOPnRKnQ8Bf2SP32pC6g
	 ClvRcVzFd8tIj27gwwd2gBWlDTWTA/SndjnpiJ78UUUg9CHDmS+bY4rujEn8zTmjij
	 JqxsBqUiOUQnApsl2o8rJC6iPBlFeGdkQ8CtLtM76edHysa1/524dewVcskKpXZHz+
	 NDWaYTMxU8wrwjq71PsjjludZ6wW3r5Z016GUcjs4PhUjfuKd/uSPH3vz4A0iabSPK
	 i3YIhKJKa5oQEXb/IpRy8g2l/cBuPowD4rFSX663xmUAoWIBECszx0tSRFpMDHPDFT
	 SnqP/IixaI8Tg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v2 3/5] bpf: verifier: relax maybe_widen_reg() constraints
Date: Mon,  2 Feb 2026 18:22:26 -0800
Message-ID: <20260203022229.1630849-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203022229.1630849-1-puranjay@kernel.org>
References: <20260203022229.1630849-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The maybe_widen_reg() function widens imprecise scalar registers to
unknown when their values differ between the cached and current states.
Previously, it used regs_exact() which also compared register IDs via
check_ids(), requiring registers to have matching IDs (or mapped IDs) to
be considered exact.

For scalar widening purposes, what matters is whether the value tracking
(bounds, tnum, var_off) is the same, not whether the IDs match. Two
scalars with identical value constraints but different IDs represent the
same abstract value and don't need to be widened.

Introduce scalars_exact_for_widen() that only compares the
value-tracking portion of bpf_reg_state (fields before 'id'). This
allows the verifier to preserve more scalar value information during
state merging when IDs differ but actual tracked values are identical,
reducing unnecessary widening and potentially improving verification
precision.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d92e10d4c2cc..5da1c6036e44 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8995,15 +8995,23 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 		       const struct bpf_reg_state *rcur,
 		       struct bpf_idmap *idmap);
 
+/* Check if scalar registers are exact for the purpose of not widening.
+ * More lenient than regs_exact()
+ */
+static bool scalars_exact_for_widen(const struct bpf_reg_state *rold,
+				    const struct bpf_reg_state *rcur)
+{
+	return !memcmp(rold, rcur, offsetof(struct bpf_reg_state, id));
+}
+
 static void maybe_widen_reg(struct bpf_verifier_env *env,
-			    struct bpf_reg_state *rold, struct bpf_reg_state *rcur,
-			    struct bpf_idmap *idmap)
+			    struct bpf_reg_state *rold, struct bpf_reg_state *rcur)
 {
 	if (rold->type != SCALAR_VALUE)
 		return;
 	if (rold->type != rcur->type)
 		return;
-	if (rold->precise || rcur->precise || regs_exact(rold, rcur, idmap))
+	if (rold->precise || rcur->precise || scalars_exact_for_widen(rold, rcur))
 		return;
 	__mark_reg_unknown(env, rcur);
 }
@@ -9023,8 +9031,7 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 		for (i = 0; i < MAX_BPF_REG; i++)
 			maybe_widen_reg(env,
 					&fold->regs[i],
-					&fcur->regs[i],
-					&env->idmap_scratch);
+					&fcur->regs[i]);
 
 		num_slots = min(fold->allocated_stack / BPF_REG_SIZE,
 				fcur->allocated_stack / BPF_REG_SIZE);
@@ -9035,8 +9042,7 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 
 			maybe_widen_reg(env,
 					&fold->stack[i].spilled_ptr,
-					&fcur->stack[i].spilled_ptr,
-					&env->idmap_scratch);
+					&fcur->stack[i].spilled_ptr);
 		}
 	}
 	return 0;
-- 
2.47.3

