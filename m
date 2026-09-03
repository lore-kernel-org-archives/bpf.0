Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC16332EDE
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472094; cv=none; b=haP01x6J70iTCRlLRJdHMs33oTjdnL1HiNDk99crjgbdvgMPNp4PDUpAb22V/0wOHnPHRDjqpTBnJlYERVarjpYZBZkGNTDTVIJqP1ViUxy4U4G3lybxnR0Yx2efaHPrshbA0JXyked/YVzp8Da05WssM9fD97Qea8pVe7ImV+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472094; c=relaxed/simple;
	bh=rMgKSLZ84QHes467dovB5LbAcvtpLwO5e4G7tjmrizA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJwMvASFcgzJDybhz5INRaHeORL8krBi2JG4F2zKK2pyCAvTnySb7nW0oUiqcCOPNsC89LPDG7fjUo4kXtSLWttm6ODlcriLOXxQHitltWKYTq7cVwAteMPkAvja/96tEJtCN42j9UV8xUkcDt1UOnJIijVFEslCdPpbPJU5iRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovq90DVD; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovq90DVD"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-482e1e7a4f6so153023f8f.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788472091; x=1789076891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GjuWXEv9UNcmb/bnkXmfu4HeHdh/bIJwH3R0fhIIPS4=;
        b=ovq90DVDhtFQPRvLmFNjTcnjgujXlJ3oZ6qxbZ1tXLjofMt2qf+3/xdigRaafrjQpX
         mvy7MwLq90elJ9Xe+EOB2DaKyDeA0IsMALzDNrTzkJaxEJ0PXvj/tRbwnaeLxrjpxdy2
         hG1lZWA9wYtzxPULT1T9jAvFKa6ml4aNiu/hePGiNILQFWtCYWmHE4ZN26v2TpmE8DFf
         16eN0vOJigwRSXbBIQt0PjA22NALrwq+Zg904Ta5B/zWSpdJpnH0eHVTFrzp++ZgegcI
         1oaKkpbOsMFvsaAXitlfnfXzFoaYB3xXnXoZi5KTKasmPA0n9Hm8I2YBX9QwWRqaFcrk
         tzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472091; x=1789076891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GjuWXEv9UNcmb/bnkXmfu4HeHdh/bIJwH3R0fhIIPS4=;
        b=Y2hzh81O3mEA0wrawjprupMxL3oU4fgMwdg9LdRT9mSW1EtVMwE4GVzXFXlg+qI7fc
         qC3fDJzEEEgze3ceIngVvXo/gz64ayqxd4HecIHP1RBKRmKw5ZOSgUwRHxKz/MJ5KAx7
         ofottcseqdoenjWqnnuihTVu5/SMAbjKrz8Qy+aRg8ISUJJedo1jfrgl6FxDwd6T/TY/
         ftcylybRSPaEBp51O9tF8KA5xqUwobf1N0aZQ/2AZxmXO7rVXk6UX48fDNBaTUCUhF86
         FuKjev7IjNjZsanaZVhR2Gm/qTX1YprwBe29gHAsGhugC+TLsbrcPo3ERv4ql//ub4oQ
         G/Qw==
X-Gm-Message-State: AFuF++liZV1S9hdeiBKMlxuN75obCk60D8QXpJGpnvzzwspzt6nfDghR
	PmAwlDpMTlAQoVSi0BuaUrjmR+D7wjCf1D4LbcE3mI5sPFxoBos0VO4oOeSQayPj
X-Gm-Gg: AYBFou3szL1MBtNCT+DOysqLzAllZvUCNHAsw/eZ4tchVxXrdeWJYJqxB3+IGuZdR2n
	htU2b6WymEG5Yw39a3ho5DXOZLXwoaSgrpsq7r5RhOSVLhLs6POPQ1s1CDiFQh569qqG1JLtjpW
	Hgx7OfK9msxWtImWkZO4x7tW3c675anjvducMCrDljieeVM1yj57dNe8Pb1cJGCJ7xNN3/8Mwc8
	sljlmPsMKYcjL7/Lby6+eRRquz3kOCyRFuh1Nj3mYeHz2aL2OboazjUnxDsOqfrrr60aokCXBPj
	r/fRzY7RSTL2ugF/hpUESUAMN0fl3daglMBB2p5qWGmz4QD6OKzo52cCODfwwtruV9hqlq4ZW8Z
	bxld0KWMM1jwTzN2GOnuRl95bsoc2syNWTqSd8bHwwTKCAUBiEmywWId7PHAgn4DJUWvC4Q38Ah
	0AnR92CnSPQ+J3D+IUe062VqkQQHYB3uIe6YEM/E+qpG/Uw2kCn+btDWyfYV3q9LyQTOeeJ5YWm
	tEHpOQWlG7hGsRMwOYHNZ1JeTgxdpdmIa+R2uet24Af5u2zgLdWa6/kcF/WUFLbvRBlc22ILCj1
	RXixpM0Nl1Nwz/8MJOa8pLM+6uA=
X-Received: by 2002:a5d:64e8:0:b0:47f:762f:32a9 with SMTP id ffacd0b85a97d-4858705ed81mr3566657f8f.12.1788472090598;
        Thu, 03 Sep 2026 14:48:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9a67sm1331239f8f.16.2026.09.03.14.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:48:10 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 7/8] bpf: Reject legacy packet loads from callbacks
Date: Thu,  3 Sep 2026 23:47:53 +0200
Message-ID: <20260903214758.2727663-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903214758.2727663-1-memxor@gmail.com>
References: <20260903214758.2727663-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3317; i=memxor@gmail.com; h=from:subject; bh=rMgKSLZ84QHes467dovB5LbAcvtpLwO5e4G7tjmrizA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvma9YLTaJh0ZuM1GVS5Oavzy94brWrsEBn46QrIjq+z QvDe2d2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCI3jzEyvP317Gx2zHmxhZwa jI+VFVeuvGidZHhMxHmXYe/Tt2ckdzIytKVs/e92WVDxkZmIR8vpv+ELNK5PTZl4/iCLSHXgPsF DrAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

check_ld_abs() models a failed BPF_LD_ABS or BPF_LD_IND in a
subprogram as an implicit return with R0 set to zero. It calls
prepare_func_exit() to explore this synthesized path.

When the load is reached directly from a synchronous callback,
prepare_func_exit() enforces the callback return contract and marks R0
precise. R0 is not derived from a real instruction on this path, so
precision backtracking reaches the callback call with R0 still requested
and triggers the "callback unexpected regs" verifier bug. A privileged
program loader can therefore cause a verifier warning and an -EFAULT
BPF_PROG_LOAD.

These legacy packet-load instructions are deprecated. Reject them from
callbacks rather than complicating their implicit-return model. Check all
active frames before constructing the implicit return so nested static
subprograms cannot hide the callback context.

Global functions are verified independently with a fresh frame zero, so
an active-frame check cannot identify a global function called from a
callback. Also check the complete subprogram call graph during stack-depth
validation and reject a function containing a legacy load when any caller
is a callback. This covers global and static descendants without making
has_ld_abs transitive, preserving its per-function BTF return-type check.
Ordinary uses outside callbacks remain supported.

Fixes: ee861486e377 ("bpf: Fix ld_{abs,ind} failure path analysis in subprogs")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/bpf/20260903152147.C0E241F00A3A@smtp.kernel.org
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 26139fa09f12..2cb8fba68cd1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5302,6 +5302,15 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 	if (!priv_stack_supported)
 		subprog[idx].priv_stack_mode = NO_PRIV_STACK;
 process_func:
+	if (subprog[idx].has_ld_abs) {
+		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
+			if (subprog[tmp].is_cb) {
+				verbose(env, "cannot use BPF_LD_[ABS|IND] within callback\n");
+				return -EINVAL;
+			}
+		}
+	}
+
 	/* protect against potential stack overflow that might happen when
 	 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
 	 * depth for such case down to 256 so that the worst case scenario
@@ -17182,6 +17191,7 @@ static bool may_access_skb(enum bpf_prog_type type)
  */
 static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
+	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_reg_state *regs = cur_regs(env);
 	static const int ctx_reg = BPF_REG_6;
 	u8 mode = BPF_MODE(insn->code);
@@ -17192,6 +17202,13 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		return -EINVAL;
 	}
 
+	for (i = state->curframe; i; i--) {
+		if (state->frame[i]->in_callback_fn) {
+			verbose(env, "cannot use BPF_LD_[ABS|IND] within callback\n");
+			return -EINVAL;
+		}
+	}
+
 	if (!env->ops->gen_ld_abs) {
 		verifier_bug(env, "gen_ld_abs is null");
 		return -EFAULT;
-- 
2.53.0

