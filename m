Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207888;
	b=JNoWfrzFOEfGJYJXY6lUEYmthnYy06e+KUUueR6RDPDDWhG7WNtS4XcaU/cw9/DCR6MY
	 xp7jhVH/QlTae2fgxfjRpDfG09Io8/KOMfn9skzwzwJh05SgY5rU1dnU2zklDvRck3rox
	 zsmrIcm0+eUgrh1eWPK+kmvnUC3v6QyyOzxpukgl5Y0PzhYHcfA6aBBjQ3evwvAkR3Y3h
	 GkjpzTxoFyWJzzz2f+xsVrT32NTzvNTP/+TRfyFvzVvZwsOHAC7HEAmY7TEyGZRpSw+dX
	 g9Hjy8Ix2iJ2ZtyvgJOcRmrv0b3pkjKni5sG3A1iNcARjd+YVjmatNCbhcZ4yjRZ2mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H0OYe2ytx0LbcrePQnMcsy2iDxO+1omtDmVYu3cugf4=;
	b=bADauztx0P6NkOj9PX7aHUrMIendx1SoKc9mRODOD2hizUM2ln3XCGcbfZsRl7mTvJM4
	 S+9uxxxriNhB5se7vEWEX4T2vafTulRPz2wC3Mlq3QPoYgvzu8d+MFnFRFrMpgUB36x6A
	 8ZdsthebWJ76oWwohaxyGq2O4XyZwulN7drqimeIeV02nHd6BNt3GHBg6cCPHHf3SCEvm
	 F8pMjYDOgTEJK9w9Z7RBKEvmg2VdzzCGd5bG7xEcdn3b9AycLw0bJYbqBilbB8zj2YTA7
	 M55lhmwmvYCPTtKlCqFuIvahK8bwu1L15T8MWyyRdQ2ln1uY/ar13af51E/LqANJh7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sJe91V0e;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0B60A2607
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10F0B60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sJe91V0e
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f041f88577so8102745ad.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207886; x=1795812686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H0OYe2ytx0LbcrePQnMcsy2iDxO+1omtDmVYu3cugf4=;
        b=sJe91V0e5TTPyGb9hlsZs+QYhDjsGtJm7nZzKhx7V/ltAHrzJSqtlNhQK+GbanifNv
         yvwrKsWNVTUFv+JXWMUzEjkNqjoV7kImFANL+K3nDU0JU3PvE3yqeJ8xRb4uzh4eDB/G
         TH2F0wifo7OEL17S4LiRPqwb8+bbhm6bDm4/yGUqEPuuW55IUIgmXXVpA7sD3asRHNkn
         tDnHub1nm6gfHH6hqpO+ips+j3UDWlTBm94IG1x5odzSuF8N+clagx2etPGRMJmoZxPC
         BwnT8QDG6HR7Bi4PrRmrU75baZhH8VvKttY9sb0xCUDkOeOY2DhbmJXq6m/Y1Wv3hWlE
         Gb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207886; x=1795812686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H0OYe2ytx0LbcrePQnMcsy2iDxO+1omtDmVYu3cugf4=;
        b=vrTJhAdmReTAy1Km6khEc7B6hpokkpVkZsr701gLbRQ10YY7/1Qho2WSKUH1iCP0gG
         Mc3zdaEMb/Y502td1Sl64db+T5FQKVXS4T/Oj91h7mK1Rk/xsEw0yuti4SHLk+vjU26t
         3DaLlKW9Ii7viBipaLsSGN39AhCSsrJchfY4xNekzBXYrHC392td0m8/4LmsrH78ETbO
         Mm3tNzQ0Oy6AVIHVIxqmkR+1VYGp5HOZRJA6/IbDm6sWE93cieX9NtIDGb2rRwl2GSCj
         YBLyhUc6ij6wFbx5dAmcckQPRWaIiSYVtcYuFWhgFSnxuSTX3Hpl5Uu0uM5hPUxm9MBb
         /D7w==
X-Gm-Message-State: APuU4Z/3aZE+r5uSa2nxJ87PeESdVsoqU13dGemX2CntkJydTDmpR4TD
	eA0Vw9EYl2F9S/kQl8O2RuXYFz92rYEQzkIlqgVcd6nfyMbO4n/OxfSlMgjsYg==
X-Gm-Gg: AZFdTZfQcNbDTfb3B4anLfn/FfzZ1qryPoNX3Amf+m49EgWA/7zb0eJCb4QNG2cVqZp
	PB3lmAcmTdeLcibWVjG9nm5ur88MJC2zjEjs0QBj/TWnYt4t33757YjhYlu06n1ZYHTxedEmNhI
	Qke6ND9ec743PzMeSEG0uKV8NM8rGUOm0s3WnqkkU2lKHhLEiDxImBrOVdvii2ACsGt/SgTSBzS
	Fpdrft9lIvbGvKx96/QZoYM2ID5Hgd1vcyu/73SNX4RN0u6GIZH701BbE2+IR/LP6JPAul4rxsV
	1oLXFlW32hj1xK78l8RT3xGdJ0wZDGq6qA2p/ksGfarcIbi0J0R5AHFzxXykv0oxqkBieShUlcn
	G8AOQGKjO2bJ245GWgNWpzHrlmAnx48QetEwzSvXHck61uvfEDtfNyABZ5Zo4JnF7cAbIWk5+LL
	BOxaExsHN6o83LVTZWvvSIxD4vW08cF9pkOJ86gJ017k/c1VUgXuC3HT0lX2kbZm0hb+Nqj2Ucr
	L2JklePyi4DtM5yM9+/g8zZNRdfN06gXHP8CZ3joSJVSFYt8rEeS5TGHyAly1BZL5fOBF7klDSo
	r3+9k1xFB1gWD3ZWCvr99iLgkqlzkNyv4pc+a+IZjB1NFemMYwfLIv7VyjJmlFR93u12bcH/n/i
	4qa3IwoHQf+f5y/0SDYLUa3yDr3g21+5LSbrD8MRpIxXKXPTZR6BNTtayVuyRU8DrC1Np7BJTIA
	==
X-Received: by 2002:a17:902:dacc:b0:2f0:25ea:8fc6 with SMTP id d9443c01a7336-2f03f1a47dbmr41706895ad.28.1795207886270;
        Fri, 20 Nov 2026 12:51:26 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1aa3sm18639505ad.21.2026.11.20.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:51:25 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 14/49] bpf: Mark a state that no run of the program has
Date: Fri, 20 Nov 2026 20:49:22 +0000
Message-ID: <20261120204959.614908-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

A jump can leave an xreg without a value: the ranges and the known bits
have no number in common. No run of the program has such a state.

  jump -> range is empty -> infeasible -> a pass:              continues
                                          a run without joins: drops it

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 2 ++
 kernel/bpf/verifier.c        | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f110909413b..8b8f999de26 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -560,6 +560,8 @@ struct bpf_verifier_state {
 	struct bpf_reference_state *refs;
 	u32 insn_idx;
 	u32 curframe;
+	/* an xreg has no value: unreachable. Only a path-sensitive run drops such a state. */
+	bool infeasible;
 
 	struct_group(held,
 	void *active_lock_ptr;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8d90ed783d0..3c027b19551 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1808,6 +1808,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_env *env, struct bpf_verifier_st
 	dst_state->unwound = src->unwound;
 	dst_state->changed_pkt_data = src->changed_pkt_data;
 	dst_state->flow_entry = src->flow_entry;
+	dst_state->infeasible = src->infeasible;
 	dst_state->insn_idx = src->insn_idx;
 	dst_state->curframe = src->curframe;
 	dst_state->last_insn_idx = src->last_insn_idx;
@@ -2437,6 +2438,7 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 		reg->base, reg->step);
 	if (env->test_reg_invariants)
 		return -EFAULT;
+	env->cur_state->infeasible = true;
 	__mark_scalar_unbounded(s);
 	scalar_step_reset(s);
 	return 0;
@@ -19013,6 +19015,7 @@ static int refine_live_branch(struct bpf_verifier_env *env, struct bpf_insn *ins
 			      struct bpf_reg_state *reg1, struct bpf_reg_state *reg2)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
+	bool empty;
 	int err;
 
 	/* is_branch_taken() knew the branch before it refined anything */
@@ -19023,7 +19026,9 @@ static int refine_live_branch(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 * The fall-through branch of JSET forgets the ranges. Or this branch is dead too: the path
 	 * is infeasible. The registers are left as they are.
 	 */
-	if (BPF_OP(insn->code) == BPF_JSET || reg_is_empty(reg1) || reg_is_empty(reg2))
+	empty = reg_is_empty(reg1) || reg_is_empty(reg2);
+	env->cur_state->infeasible |= empty;
+	if (BPF_OP(insn->code) == BPF_JSET || empty)
 		return 0;
 	err = reg_bounds_sanity_check(env, reg1, "live_reg1");
 	err = err ?: reg_bounds_sanity_check(env, reg2, "live_reg2");
-- 
2.55.0

