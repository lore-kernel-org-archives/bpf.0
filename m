Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A13D6CA7
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510823; cv=none; b=qdEDrRCsmkE2+5+TJCve1jEHxV/i9LVFO1Rk8DGCRLP5T8RSGMREJWM+F9sNvY0KfqEqisJ7hRd77TWUQhqJm7eXFkyaTblaeRjKrHYSfHYS7RYT1TXvzZDDb0BPKo9aALV5aG/wupRcNrP4Pd+e9FdDWtFZ2VvtPYRvpHYn8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510823; c=relaxed/simple;
	bh=AWSd9MfwrBSqMvA+bM4QZlyQCDq1FXY8XbTRWNJJOhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbAtsKGqPrWnoWFxINwQ0m93bqUpjgvXZ4zyP7HyWeKiuwCKTHl6BFKKsLnIUTvU3DxFgvXS//bXbppukL2opKYBs5L5RFx4xK7+OIM7Ss8Tl0VcL9zRfmDYfX96OzfMOrbZyVuhS4laiRaBaHEQw7+mBa8SDoL0IvmNbwZvBP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gzfpd4L9; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gzfpd4L9"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso723205a91.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788510821; x=1789115621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkEvV2A5e8YuhFKlaWDxO3OETdMpII+zkuLu0SBnhgQ=;
        b=Gzfpd4L9gdA8WnTy7Eo+k4Ehj+skyk5khvVES5Nk6lWnLSPmGaizBE2TdcXWGvLXQ+
         vi+Z+LZi9zjlTX8WTIdMOeC6tQHpkBgJpQnI4RbRSBBB++sJAxtfSLewulYCaUucSrPk
         N1Yb+D1+5b491cOyxAlpT4zuk3bmARCgZHe/HEQZrOItsAGmOr2XyQubhkxE3/cvjGAp
         op1nJc6/EW9OzJ6vK3fUSHjIiAlUXgVUN+Ku/Eqb+sqgwHp8UXMtvZ/w7lWcUo8nc8E6
         u43kVh7JV0Zv4TCemchRrbL4m2xIEYUt+1VepztRLk083eHgMpTKFQuJLasUvt2CmNJR
         FqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510821; x=1789115621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QkEvV2A5e8YuhFKlaWDxO3OETdMpII+zkuLu0SBnhgQ=;
        b=DPv/+5kQMuhWWmSwoJrkQXfG3c+gdXrIynhr5rwpTGB/MJJhHBPwH96Ipmw40bwa2R
         rI+wmpLTJNA4d9plbKnsXZN4PobQ1BsgG4HrPXaU2mPnQt4eVVqi213xmDYB6U3Rh/Jv
         Kxt35T5moKDRoq8p+zu3QU7+lrQ51wE8lhhv0ANbAmXIbLt7pSVn0yHcW90HEyofeuwd
         sR/nYPVI5KwOgjf4rd/z400eyUFnOl3Jj9GJtorQKGFYHvPxCyTtqnG67sUXLLHhto0I
         9p2fcqCDF4Ke1kfrFibQd/EsVTllrtNvBs6IbkVjVxj/EIXy+P0zuj+ESSGzYb5NC50L
         eiMQ==
X-Gm-Message-State: AFuF++lW4uCgTL/C1JP/qdDcSAYycRPekeMb3TRUBlUpBkrBd590ApGg
	Wwg7YW7m+2t8pS7q9JsUOjogCpnkvb5RTLctzVUaBErJ6ZSdT1JdH4JlCSKOzyKCiBU=
X-Gm-Gg: AYBFou3TI6+iIbFFfYsDod0Z6qmbIRhmzyvDmgfOGJqvZZyMzSfKGz1A8+aLtZh479v
	OwuHiW7oLXRAS/MaEdAijNUyRLQaxBzLewXml+aqigrPggf88uU7OF9luYmYOXnPAbbq8Mj29Ba
	HbjwRlKwzxpZTQPt1R2eQS0ig/6gNrVaDtJNBGpYBNkxm48C9HP7YCKaX6wewjsThyJC4VmfS1S
	Ufu4uBeeONZr5/sVo8PKKnvJqJXa/9FriG89cGD8VP/g0yZXB6HawhiPdNa8iAJs8i42KkxwGEX
	gDePQT8ES4TZaMXZABNuwPgJ/XD+E4TMQ92GZzIfbzCbvM7cJEMFncR8qvOnXbSAnuB5+/obFHn
	qYz7t6MNyOB3n16LM8uL13CC/AbCt1Po3dMy+1qHGQ5zF8ZTXbzveDfyS8oArYVO+tJIsSsu4mp
	jM0GUwm8Foo6zprW/aEJwOnwVd4QoA6O0y74OcFKY5fFf1TMCjFJo3kTbdfKvoa1DXwj9s7HA+u
	o1YehuGWF4vV2vVYyYae1TDz+3KdpNJxQUgdSziPx0=
X-Received: by 2002:a17:90b:3b52:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-39b26101d25mr6519163a91.8.1788510821118;
        Fri, 04 Sep 2026 01:33:41 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm9628057a91.1.2026.09.04.01.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:33:40 -0700 (PDT)
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
Subject: [PATCH bpf 3/8] bpf: don't resurrect a scalar id dropped by collect_linked_regs()
Date: Fri,  4 Sep 2026 01:33:20 -0700
Message-ID: <20260904083325.2083493-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904083325.2083493-1-eddyz87@gmail.com>
References: <20260904083325.2083493-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_cond_jmp_op() copies the compared registers into
env->{false,true}_reg{1,2} before collect_linked_regs() runs and copies
those snapshots back into both branch states afterwards.

collect_linked_regs() records at most LINKED_REGS_MAX members of a
linked registers group in the jump history and calls clear_scalar_id()
for every member that does not fit. The compared register is not exempt
from that.

As a consequence, sync_linked_regs() might adjust ranges for more
registers than bpf_bt_sync_linked_regs() can propagate precision to.

Collect the linked registers before the snapshots are taken instead.
This might lead to some unnecessary clear_scalar_id's, but from
previous testing situations with many linked registers are
extremely rare.

Fixes: ec1d77cb0ee9 ("bpf: Use bpf_verifier_env buffers for reg_set_min_max")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e53619e2210e..d16dd1fb08b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16870,6 +16870,16 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			return err;
 	}
 
+	/*
+	 * Collect the linked registers before env->{true,false}_reg{1,2} setup,
+	 * otherwise ids dropped by collect_linked_regs() would be resurrected
+	 * when env->{true,false}_reg{1,2} are copied back.
+	 */
+	if (BPF_SRC(insn->code) == BPF_X && src_reg->type == SCALAR_VALUE && src_reg->id)
+		collect_linked_regs(env, this_branch, src_reg->id, &linked_regs);
+	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
+		collect_linked_regs(env, this_branch, dst_reg->id, &linked_regs);
+
 	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 	env->false_reg1 = *dst_reg;
 	env->false_reg2 = *src_reg;
@@ -16924,10 +16934,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	 * 'this_branch' and 'other_branch' share this history
 	 * if parent state is created.
 	 */
-	if (BPF_SRC(insn->code) == BPF_X && src_reg->type == SCALAR_VALUE && src_reg->id)
-		collect_linked_regs(env, this_branch, src_reg->id, &linked_regs);
-	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
-		collect_linked_regs(env, this_branch, dst_reg->id, &linked_regs);
 	if (linked_regs.cnt > 1) {
 		err = bpf_push_jmp_history(env, this_branch, 0, 0, 0, linked_regs_pack(&linked_regs));
 		if (err)
-- 
2.55.0

