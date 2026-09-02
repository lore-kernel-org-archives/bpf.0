Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05C3AEF37
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334127; cv=none; b=GxouBV+oRCszPBhB10tmS57wUiweRuBu9z9ebvs+EfLso7cwEuI8NEzMogSjPK86cebSc1rSZsrcYfS1VnNFKF7infNDrEp7UlLhINvb5ZSPWETAW4GOYKManZ+Rl8Xt6z6nzdeL/R5yB4tjDG49hReyWUQUbXrv6QGWOzyolJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334127; c=relaxed/simple;
	bh=O7eOc+GrfsoI38rGGASdlzKnFAd9Ksg3oIO1dODrbwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sfi27gkFsrwmcO/4rKGMMMNwabs0DtGJs6ij+lzHNqOtAo8QYyvIgvATsyY67M3HTEoIVlJvNoitdTzZS8uTbPi921+aS7b4D7q8RMQgtajuKiOGgQAStEUPV3cSmpmKEu35UETaUm2LV+z3CsX7sH48aVOY/TTBBmqi/E28vLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POpp0iFs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POpp0iFs"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d9201076b3so8558145ad.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 00:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334125; x=1788938925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ObuaZv4RYffY/ex7R/c+VIJJtJGx+BGQSafYgMfG8PE=;
        b=POpp0iFsPjoV9As3FS59qOeUWyVeEXupGm0FdMvXfI/KJrrBmKLdFaTFyunKKwnJdb
         5j9/CFryi3cOjbAteFzAqBEjqS2aURXwnn1fRpVPlEuKdY/CeAxh3yk+GZ7lrn0zAtiR
         h2wgsfX4TbAzFpB10HJww0olT+ojXPMorXW5Kmaqso8gYwFdNgaT8G3ngisZZc/VLaqR
         MYQZZ5M3PYx4ShsdyUpv7XrrJu6dlMgofuG5QxEbg4eSwQi3kJ7k9A3Dwdzvy6bKd9FR
         hQqSwxuDQ+bhmWHfu5g9ol5Dihqobty+ITay02+v0Bwe52oBc9WHUOHA3GK8c/WBg8rU
         g62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334125; x=1788938925;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ObuaZv4RYffY/ex7R/c+VIJJtJGx+BGQSafYgMfG8PE=;
        b=PnLHzRFGrorjjTjo/isWmvdUCfGrChFEtmoYfYoDOeohqoeBYEibJA3m/gF9cwhaHt
         afHQtIrBZZRrdybnbr38HvZd75FVP0OhfAwT2n7R/DQqMi4XhcNswenBCJtrclBJ5z+A
         jc+NUjGEdi9xlWxBPwYlYu0otVf59SgysW61rZ7xES8h5BXZaE93W4+6Ms+2x3qNptvq
         eX8xSAeEh1CCeql7KhQX94m721X+WGI1t/d+PGML3C22/ldu8YKuBwhkGYyNnHjRP38X
         zWrStZLHve7PtS/+9cUUvNOw+nNG6y9pbFYA+OKfv9vFOUNbKWCfLrZcQkmk+Em4wPd9
         OAyw==
X-Gm-Message-State: AFuF++k8nS+EQoNml+9jYwLi7ZnH39hcMsp7n1y3lnbGH9cfCajZ5A2P
	RRG/ZgaJUi8EZ+w9JkN9OHwWff9fh7KwlRk/AINVJa5u2FbD0t4ukvn7nMHK3+o2
X-Gm-Gg: AYBFou01RiX0GpHkaT4P0f+heYD/0RoB92VxvlcJ/ClQW3Fd33QUmEJ5Ece4yRYhiF6
	1RdzaXKiRG5UXz9eZSDjXS2obNECGRRk3kUxc2UVnI28LlJstaEdxtQQZWELXif0dAjVkSxY+rP
	JcSBxGT3cpC8S4+nACK59zv4gkjj/lFsxhV3zggPhi+onZn4CnmIp4jP60m29wvC/QcJQdbx1ZQ
	0bNLogbs/gp7bc8XEEg9QwvnbTpReQuMup14v2KA+l5hF/4z9U+ws8M8dxcnf0tLN7kEm98Bmbg
	b+EoYAPD/qjBuYDEU6kUzZQxP+b5ZXYxaDzeaUTS/ZkNwVePCgbnHD/aM0Y0+93Fnz6Fcq2ER1O
	+dG8dYwdsHKzNS9XlLrf0+zM7o2ACtoO+UJYhF9QujZjnXUcAkuih9PoBlvybaV3+IyMxefik+u
	W+8X80Czfo72tuLPhL8mQkB9V/Frv/97jshWzpwRW+v0bAriyP34o+Gp/kyYla3VTzevzD+o5wX
	VPZfCNHfdy4HnKO
X-Received: by 2002:a17:903:1aab:b0:2da:f1b1:56c4 with SMTP id d9443c01a7336-2daf1b16445mr13603885ad.3.1788334125085;
        Wed, 02 Sep 2026 00:28:45 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2daefcbc86fsm3978355ad.62.2026.09.02.00.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:28:44 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	npc@anthropic.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 1/2] bpf: backtrack_insn(): handle ld_{abs,ind} subprog exit edge
Date: Wed,  2 Sep 2026 00:28:34 -0700
Message-ID: <20260901-bug-016-backtrack-ld-abs-v1-1-59368f1be435@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Nicholas Carlini reported a bug in precision backtracking mechanism
for BPF_LD | BPF_{IND,ABS} instructions. These instructions are
modelled as two branches:
- fallthrough;
- implicit exit from current subprogram.

The implicit exit case was not handled by the backtrack_insn()
function. When backtracking such a path backtrack_insn() did not call
bt_subprog_enter(), which meant that backtracking continued
manipulating precision marks in a caller frame, while looking at
instructions in a callee frame.

This lead to segmentation faults during verification
(see the selftest), or unsound state pruning.

Fixes: ee861486e377 ("bpf: Fix ld_{abs,ind} failure path analysis in subprogs")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/backtrack.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index a2b18a9f1694..eaf7438b9ebf 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -582,16 +582,29 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			  */
 		}
 	} else if (class == BPF_LD) {
-		if (!bt_is_reg_set(bt, dreg))
-			return 0;
-		bt_clear_reg(bt, dreg);
 		/* It's ld_imm64 or ld_abs or ld_ind.
 		 * For ld_imm64 no further tracking of precision
 		 * into parent is necessary
 		 */
-		if (mode == BPF_IND || mode == BPF_ABS)
-			/* to be analyzed */
-			return -ENOTSUPP;
+		if (mode == BPF_IMM) {
+			bt_clear_reg(bt, dreg);
+			return 0;
+		}
+		/*
+		 * BPF_{IND,ABS} are modelled as two branches:
+		 * - fallthrough;
+		 * - implicit subprogram exit.
+		 * It is necessary to switch current frame if
+		 * implicit subprogram exit branch is backtracked.
+		 */
+		if (mode == BPF_IND || mode == BPF_ABS) {
+			if (bt_is_reg_set(bt, dreg))
+				return -ENOTSUPP;
+			if (subseq_idx != idx + 1)
+				if (bt_subprog_enter(bt))
+					return -EFAULT;
+			return 0;
+		}
 	}
 	/* Propagate precision marks to linked registers, to account for
 	 * registers marked as precise in this function.

-- 
2.53.0
