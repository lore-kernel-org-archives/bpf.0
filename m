Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793555054;
	b=l4KD5y1IFxT+VrUxOl2IE9GhtB/JUNockwbnmX/eBdps8CvCbjF/6rbY2aidRh896hRY
	 IPLJIPJ6TZaF7+rBJEWBpmESScf4qlnbKI6ebuYViRgmpwQua9HAmh0UmyewNNW9F+92E
	 39Y4aD4gVOTMLyw3tveUBdMEmts2aHyb1q29YcD7epM9UeH1Uxm4o10FJgp7t46OANaGP
	 V8Gk5vr3FsSYQrkXNsnIl0v92LN7qIsbtaF/rrCtCzgTGRJNSLuXF5U7sNQnjSV7bQwZh
	 XkZuXzwlDDgdy+v6cnu/okloV/ZVE14u2BBvT2ci9vLIdEs/D8lnfNqqdk8o4tlLisQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fuzX9I+IjCZo8iGf/tRRs3qiWSHTYVsbPr2QsG7o6pQ=;
	b=xJVzQ0r7uFZWZhE6hhl3v4I+nVaWx4vs/qZwq3pX2nrzHD3fQRL8rkqHlMqElT6fxCOk
	 U/D8LeNvckj7V0lRUd3U4FfOeK+Gw9d5sgNKnRlVXzy1mIATBgsUMtM1knfEAxeWM1Wel
	 USUn7WVLvHyeT4xb3NUETeG88Xg3brY1T4CNB1n8iAnoJGDsqNDP3Kz3EnSP44IM1ccTw
	 RKl6bpLBHMPYnxIptTfWZWULajWbdB8yvWhg5B0V/+8enSKYfXrPFaqLmJVWQEX7CHJYI
	 nElaua+KChR1R63HbBcdamo/YwJBRLbVIvWieHSOEDU+kb52n/8bD80yass4t5d1DGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N1rLXfJm;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C119606A32E
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 17:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C119606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N1rLXfJm
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso755589a12.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 09:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793555053; x=1794159853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fuzX9I+IjCZo8iGf/tRRs3qiWSHTYVsbPr2QsG7o6pQ=;
        b=N1rLXfJmCZn1mwUmiPrU10q/bDb1JHcnnsPzVaAGzskKwphuoWGoFM2rJ/GdbjEs4A
         7BG8RdYmQcqNbIMMII/qT/nxYIKfnhfMSO2WcPt24zQ1dugTY8zIkH17b2UMB0CJZR01
         j4cmJ8UfaXMKyM9/kItHkxcYvokcJm0r8IBoVJtX08gB9B3CElXu8JokM5R7pj1YI0H4
         iPxIAHImBHgebL0MnibCVsIdKHeezTpMho4DhOgODiSw79qN781Uwyl0SkeIkplD8dUm
         Q6AlihRH3tTcGXlwgVWE/Jd48SSw+eYqxJ54QNqN9SyCx9qg4+rgo5/lIgQRjIBHiYaf
         Wcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793555053; x=1794159853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fuzX9I+IjCZo8iGf/tRRs3qiWSHTYVsbPr2QsG7o6pQ=;
        b=FhQKg0Iz36wiFDutBCERK7YcWqWD6uyXTKCz2hiUo0Bxt69OCZq/qN/I9G16BplqLT
         Fr2FeJwQu4n0VG0HSO9aBgRLcaxZiJgMQT4MeWU+TE+gowd6yFLqOkl+h46Zd7O6KaL9
         wYVhuznhIVE86eA4ATx6s4FFl42yf90Z/3VbRr2PmV7uekPaDP8SSG1j5ajJR6ilpijP
         71ogLr9oTp3KJehTThaxtXlmut5SZBJQHUvmkYJD55qp1CJMiMhffQW77B/ygXvaCtbr
         89CO0Wa0li56D1qP2p2StJHYDBDlGyD40cBYjv7nNxNW+BWvLdIZFlzDK5Lcsma+I40x
         nlMw==
X-Gm-Message-State: APuU4Z93se8DWFpvxJ02pFZCRbFfAjPIZS/OV7O2MXlMlHbVPlU/fnGS
	DQlVCD99SYCi7OgpnwusTlwj88HqibpEs+8sv8U3gyY5epYyq1jYCU0rbuOtfA==
X-Gm-Gg: AYBFou2rzMYsJQ6ZqVZdg44NOnnyaYpzr+GAAh0nOahK9D41E3DjoKeR5paUCqllnLH
	CzaOHzSb1jDtd2XTldqT7fELyktEkrePqtK3sk2PPlzR2r0Pk3SO1cT/Xw8i9jouNCew74R7OTW
	uDMp5La6jBkFmYKe1m4pC2xVHQfBrlHvPoeLHg3NxbGTbDgH5+0AY6C8xuqfB5q5FV0eq5jNOS7
	pjQAtW2luHoMO+a1B9pW1cADSAf1kflaAq6JQ4u4uR/mrUs4EJII+HBP5i+01TwXtR/1beHVtLc
	m2FrKWiS+8xHx80cARMUVjkv+DOawSpf7RODAlGogsUSg7EH2fzXLPSWezC6FTfgH+OUTyrxfiy
	vStrevQ5nvToJBw8E0M+TpTN0CQ5QG9mbFHk6t6ydjDbE26LT39i1w6tJ/8dmA0hL9efSyMjYDI
	YgojxY2aIAZzEYvqflqhibUQkPBvBmTDYf/6til98VNZ+q/FAem1z1WmtT9tSd5MqhZDs2YF3Tu
	O2FNYjyggc4fKsOXrP29FKqymWa5x91XgxZ2kuNUi4XKrZ0ALJ1V/6NTdFNHOokLso6SvozrFJl
	VS8c7RjBVJV1UVkythTxZKkRbo8GPOXAMHC1GFySoDEAkD8q+TUsTwYfKs+PEw0fhwn0TAs91X0
	KIP9aVmGl0CglyhuFWUPGhBmU6vwM8av58ku+YADPXw21cnhSETqrgtPLMVU3XXQFxBC7f/Cdcn
	M=
X-Received: by 2002:a17:90b:4f42:b0:3ac:a521:953 with SMTP id 98e67ed59e1d1-3ae897c777fmr6100962a91.46.1793555053360;
        Sun, 01 Nov 2026 09:44:13 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e98f888sm15096560a91.13.2026.11.01.09.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 09:44:13 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: The register of an implicit kfunc argument is not live
Date: Sun,  1 Nov 2026 17:44:04 +0000
Message-ID: <20261101174405.4055052-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101174405.4055052-1-alexei.starovoitov@gmail.com>
References: <20261101174405.4055052-1-alexei.starovoitov@gmail.com>
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

The verifier fills in the last arguments of a kfunc that has
KF_IMPLICIT_ARGS. The prog does not pass them:

  bpf_stream_vprintk(stream_id, fmt, args, len)         the prog calls
  bpf_stream_vprintk(stream_id, fmt, args, len, aux)    the kernel has

The prog sets r1-r4. The verifier adds 'r5 = aux' in front of the call.

bpf_compute_live_registers() counts the arguments of the second prototype.
Thus r5 is live before the call, and up to the previous insn that writes to
r5. In a loop that is the same call in the previous iteration: r5 is live
at the loop head, its value is what the call left in it, and it has no
formula. Scalar evolution gives up on a loop that has such a register. The
verifier also compares r5 when it looks for an equal state.

Let bpf_get_call_summary() tell how many of the last argument slots are
implicit, and do not count them as used.

Nothing reads r5 between the last write of the prog and 'r5 = aux':
check_func_arg() does not look at the register of such an argument, and a
jump to the call goes to the added insn. The call clobbers r5 as before.

Almost all scx_bpf_*() kfuncs have an implicit argument. So have
bpf_obj_new(), bpf_obj_drop(), bpf_list_push_*(), bpf_rbtree_add() and
bpf_stream_*().

Insns that the verifier processes:

  progs                    progs that change    insns
  -----------------------  -----------------  -------
  scx, as BPF CI has it    26 of 466          -18.9 %
  scx, master              26 of 563          -10.5 %
  selftests                52 of 6329          -0.3 %

lavd_dispatch of scx_lavd goes from 281049 to 5589. No prog of Cilium
changes, no verdict changes. In each set of scx 3 progs get more insns, at
most 1.2 %: a path ends earlier, and that moves where later paths end.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 2 ++
 kernel/bpf/liveness.c        | 3 ++-
 kernel/bpf/verifier.c        | 9 +++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7baeb831281f..c28f43d60900 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1235,6 +1235,8 @@ static inline bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
 
 struct bpf_call_summary {
 	u8 arg_slot_cnt;
+	/* the last of them are filled in by the verifier, the prog doesn't pass them */
+	u8 implicit_slot_cnt;
 	bool is_void;
 	bool fastcall;
 };
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e657e6d95408..215f839bd2fb 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2621,7 +2621,8 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			def = ALL_CALLER_SAVED_REGS;
 			use = def & ~BIT(BPF_REG_0);
 			if (bpf_get_call_summary(env, insn, &cs)) {
-				use = GENMASK(min_t(u8, cs.arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS), 1);
+				use = GENMASK(min_t(u8, cs.arg_slot_cnt - cs.implicit_slot_cnt,
+						    MAX_BPF_FUNC_REG_ARGS), 1);
 			} else if (bpf_pseudo_call(insn)) {
 				/* a static callee's reads are added in bpf_compute_live_registers() */
 				subprog = callee_subprog(env, insn);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1b6c0674ff6a..8509e65889bd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19687,6 +19687,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 				bpf_jit_inlines_helper_call(call->imm));
 		cs->is_void = fn->ret_type == RET_VOID;
 		cs->arg_slot_cnt = 0;
+		cs->implicit_slot_cnt = 0;
 		for (i = 0; i < ARRAY_SIZE(fn->arg_type); ++i) {
 			if (fn->arg_type[i] == ARG_UNUSED)
 				break;
@@ -19703,6 +19704,14 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			/* error would be reported later */
 			return false;
 		cs->arg_slot_cnt = btf_proto_slots(meta.btf, meta.func_proto);
+		cs->implicit_slot_cnt = 0;
+		if (meta.kfunc_flags & KF_IMPLICIT_ARGS) {
+			const struct btf_type *func = btf_type_by_id(meta.btf, meta.func_id);
+
+			/* the prototype without implicit args, see is_kfunc_arg_implicit() */
+			cs->implicit_slot_cnt = cs->arg_slot_cnt -
+				btf_proto_slots(meta.btf, btf_type_by_id(meta.btf, func->type));
+		}
 		cs->fastcall = meta.kfunc_flags & KF_FASTCALL;
 		cs->is_void = btf_type_is_void(btf_type_by_id(meta.btf, meta.func_proto->type));
 		return true;
-- 
2.55.0

