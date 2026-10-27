Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127891;
	b=hfgL6dQaw3sg9V30nxAOB0pb/mvo3/Fm4BRBlvih6khxGuUwmpLcAx3QMDHAMShSSuPj
	 F3AqVQ57lGedplHalbhdtC7KcBJBo299F9E5xDkymsZ6TpisA6rMmgjWTHJxvSL/wTWCz
	 qkEqumEOV4hxgyc9pVHPfK1tvHzEyXGe2U0g0IoZGtZH3eQiZZHu4LkHP0QatCVScM6dV
	 JUizRR4GBvQnxUEoaWBONfDL6A3nzul9R1l1s8hduO+o+os4vVYL9QEwsNs1iJKNb+3lY
	 wCjdfJSYJZ3DHuoZk+Rhk54osY/AhxvhU2Zfc6dne1frFW4KAEAhLZlNER2plx7N2vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QbC3yxGsU6LrOgeTDKKb/rdDquNwT4LOk3vjESTLIoo=;
	b=KTBbce73Zl88l27FB+5cX8Bm27OTAkLj04Wz17rmfRb5Erpt77Gn1AahSQ61rpm3lQCl
	 KRqI0H7l7IvsC/AM78xXmpxyXRKLC9edvfWFd8ygoFwE3QL2dNVTt8WpjGaJPK2dNYMp7
	 BEDkjjR4TuTO+Jmm68i9HikaH31PgfQYZRf1xgBfuEEzudCbAB/s3DywoJpoFWDTDIjUz
	 ZGJ37p46YYh0V+1PgyTjIFNAmKanVKhIDiVu3rBHv4M1wZhS57ESTCeCuILHCMr6HjiZf
	 osWyEGQLde1+YUp/BsF1X9GruWoqQ4wPEDLkNqOyhtnRwt1n9/w4EgKwARPZ1VaRe+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m6iGcGze;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B7E606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0B7E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m6iGcGze
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd8ca57ef64so611413a12.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127890; x=1793732690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QbC3yxGsU6LrOgeTDKKb/rdDquNwT4LOk3vjESTLIoo=;
        b=m6iGcGzevoq/sC+Es9xB0j0jOYdBKBLKiQii9U4qf54oTilO7iFaCwEmDAnjD72QDJ
         mmMDeCgRiJyqNBVlV+vkz1KlDUvKIskE2LjaTkjzmbCEIiZJKRSeuh+vRi02dnkEV81W
         8V6hMoko4mrgdLslYpfhBbDXge5+xf7Euw65L0hlJgERF1IfappSxymbzIOhNbEm2cTr
         HQTAbLCAOvESGIS4bQMjW8g9I+wEtKWpYo4yHUy2XVC8+x8iQEVDDTYqZiMdGt80O3lC
         AQKKwi0GdE1t7kV5pH/z3/7is4IwmOvnlk0FNKlTo4nXOD9dmS+ZAErYMsUbaNph9QuZ
         rTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127890; x=1793732690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QbC3yxGsU6LrOgeTDKKb/rdDquNwT4LOk3vjESTLIoo=;
        b=aV7ssUA+Xw6yWIQTPwrbPQDehj7sWEvwIENn9fqjSJp6r02zikbhCQELASopbdgtn1
         HQpvLTjm/iosU47LeQhJA7zI7oeNfAgxFosotXTEO1V/eGlqA3nFRu9JNgiK5mfppRyG
         0VucB257zklA508KMoO+QC7io4Iunu0wxjgUSgAeYvRk3G2irkCk7VRkIGgPoU/4Pf9e
         uEnY7Z0AXk1ERc97+4hnatmWEull5S91NZ+kyK9Pobc/cZYeak06wU4PnXX6IYNZkljV
         7RNvwNv789UbddU5m4YLAwQES7dsIHpYpftddMjDGpNQmYR3G1rBYnUHNxxsTOAms+LU
         k6+A==
X-Gm-Message-State: AFq9FYJqqDNaVXR8iOjlmDFpBzISrC2woZL8b2kVXDoyDDR/K6cNQq88
	IH4Lnmb3fpzDgffVAHQ0X6gT6DyYPowCW2zptw5yM4qdkh9eFZIpJgEg+oUCxw==
X-Gm-Gg: AYBFou1uZRffeNaYaR070fK/wVnynFo+OWFqxEbE+w4UuU7mihFLhjl12Nz1bL02UXJ
	5ktH1VMuRSQq0vF9lXu2GGUzhizeteBCGz+cDAc1vnmDQ0BNs70ggDMIYv6s1QqznUpVFidVU0f
	G3aGx0qQhLcvxIMc0O8aJ7brgANiqIkacd4CMcH/3GxGHl7jsCfWdUNvVnBG27N0GGuVUDiX0wG
	WwSbk0Xnh9iAxLhhPpbxM46PsTr/aZSF11Xwi/1+FYThAR9wRhJnvGeWqGwcAC8+sUFMZCzP540
	+PmWPvlQUto1sG2ClsZG8KUPPGW6SGGr+VOSeRkvHlCzAG+H5waQhYPnZE8+ZjP27io8DeBZ8sB
	kI3sJfYO/WcXaKGHM6CXiRdJWcZhLnw8M4kWswM6Pg8jrz0JfNGp97qtElaHG8T1g9QOuAqKx7M
	NInXp/GBaRb+9Exy4/ww2Ym/t6+Ao+seApWovosIaTI5KtvXOUEBfSS3SNPNraJdn1apTmGNY3A
	PsyW9PhktEhRnaJZtSKkbNG88QCyIikBoNir4aQkO2aQDDd7sXAN5k7H3mRU+g3WU4+ADxw3xgb
	eD19aIGeu1Yi1/Z85Ls1n4pQzLFS7FPCBcNvxPJGgtGJF2gWIPjdXy1jmHCNLvC0BvBQxJq28jI
	3yXfdVAnSGCaWinqXHDAm9GSsm/NJgVYQqj2Pr4bT1Cctnw==
X-Received: by 2002:a17:90b:564d:b0:3ab:8288:b8ce with SMTP id 98e67ed59e1d1-3ae580d2596mr6280a91.24.1793127889980;
        Tue, 27 Oct 2026 12:04:49 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae57c62111sm63249a91.13.2026.10.27.12.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:04:49 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 16/19] bpf: Finish the insn in the state that maybe_fork_scalars() splits off
Date: Tue, 27 Oct 2026 19:03:11 +0000
Message-ID: <20261027190314.1440199-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When a register is -1 or 0, maybe_fork_scalars() splits the state in two
before an 'and' or an 'or' with a constant. The result is more accurate for
each value alone. The verifier continues with -1. It pushes a copy of the
state with 0 and verifies the copy later, from the same insn.

           today                              this patch

  N:   r1 &= 8    r1 is -1 or 0      N:   r1 &= 8    r1 is -1 or 0
        /     \                            /     \
    r1 = -1   r1 = 0                   r1 = -1   r1 = 0
    r1 &= 8   push to N                r1 &= 8   r1 &= 8
       |                                  |      push to N+1
  N+1: ...                           N+1: ...

At insn N the copy is a part of the state that it came from: 0 is in
[-1, 0]. If pruning compares the two states, it drops the copy, and no one
verifies the case r1 = 0.

The first state has branches that are not explored. Usually pruning does
not use such states. In a loop that scalar evolution counted it does, and
the head of such a loop always keeps its state. Thus a fork at the head of
a counted loop loses the case r1 = 0:

     r9 = a map value of 8 bytes
     r6 = -1
  1: r6 &= 8                  r6 is -1 or 0, only -1 is verified: 8
     r6 ^= 8                  0. It is 8 when r6 was 0.
     r1 = r9
     r1 += r6
     r0 = *(u8 *)(r1 + 0)
     r6 = -1 or 0
     r7 += 1
     if r7 < 100 goto 1b

  from 11 to 11: safe

The verifier accepts this prog. The prog reads the byte that follows the
map value. With a constant of 64 Tbyte in a register it reads an address
that is not mapped, and the kernel crashes.

Do the insn in the copy too, and push the copy to the next insn. All other
code that pushes a state does the same.

No verdict changes in selftests, Cilium and scx. Each fork processes one
insn less, and the sequence in which the verifier explores states changes
slightly. 62 of 161 progs of Cilium process a different number of insns,
from -0.7% to +3.3%. The total is 986970 -> 987013. 2 of 563 progs of scx
process one insn less.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8139e41ace00..02b2915f0014 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17289,11 +17289,14 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	}
 }
 
+static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn *insn,
+				      struct bpf_reg_state *dst_reg, struct bpf_reg_state src_reg);
+
 static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			      struct bpf_reg_state *dst_reg)
+			      struct bpf_reg_state *dst_reg, const struct bpf_reg_state *src_reg)
 {
 	struct bpf_verifier_state *branch;
-	struct bpf_reg_state *regs;
+	struct bpf_reg_state *reg;
 	bool alu32;
 
 	if (reg_smin(dst_reg) == -1 && reg_smax(dst_reg) == 0)
@@ -17303,19 +17306,25 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 	else
 		return 0;
 
-	branch = push_stack(env, env->insn_idx, env->insn_idx, false);
+	branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
 	if (IS_ERR(branch))
 		return PTR_ERR(branch);
 
-	regs = branch->frame[branch->curframe]->regs;
+	reg = &branch->frame[branch->curframe]->regs[insn->dst_reg];
 	if (alu32) {
-		__mark_reg32_known(&regs[insn->dst_reg], 0);
+		__mark_reg32_known(reg, 0);
 		__mark_reg32_known(dst_reg, -1ull);
 	} else {
-		__mark_reg_known(&regs[insn->dst_reg], 0);
+		__mark_reg_known(reg, 0);
 		__mark_reg_known(dst_reg, -1ull);
 	}
-	return 0;
+	/*
+	 * The insn is done with in the branch too, and what gets to the next insn is a state
+	 * like any other. At this insn the branch is a part of the state that is looked at:
+	 * it must not be compared with it.
+	 */
+	clear_scalar_id(reg);
+	return adjust_scalar_min_max_vals(env, insn, reg, *src_reg);
 }
 
 /* WARNING: This function does calculations on 64-bit values, but the actual
@@ -17420,7 +17429,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		break;
 	case BPF_AND:
 		if (tnum_is_const(src_reg.var_off)) {
-			ret = maybe_fork_scalars(env, insn, dst_reg);
+			ret = maybe_fork_scalars(env, insn, dst_reg, &src_reg);
 			if (ret)
 				return ret;
 		}
@@ -17431,7 +17440,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		break;
 	case BPF_OR:
 		if (tnum_is_const(src_reg.var_off)) {
-			ret = maybe_fork_scalars(env, insn, dst_reg);
+			ret = maybe_fork_scalars(env, insn, dst_reg, &src_reg);
 			if (ret)
 				return ret;
 		}
-- 
2.55.0

