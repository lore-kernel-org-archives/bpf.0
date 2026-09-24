Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BCA3DA7CC
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219458; cv=none; b=c08pnogCU19hT/0ktfeyARvgkgZOi9uMa2hlQCMjQJoF0++DqA9AxgNQ/kiG37C48CF4CFXKD5Akq+bn58vOI2I6jVXDvN8S/1ceWJKkwBFbgE0PEl3n+j8Gkr1+/Ig+LG/9OU3mAkfelA0FM9LyJKgTuywQmSckltfqHPmG8Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219458; c=relaxed/simple;
	bh=1mDxKB+rqoNBK03GNLu+Wg9Xogvu2BiL2reBy0UDNYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJeO6PYviAMEVG+M1VBh9CGwU9+e0X2xRkYZSAwI7K+zpVoFwN+8EVGFNz0cNES7EC2zosqvTr6EMi39arhbUtioTVO6Uzavu4LaCIEXzIoTa0ywqnHWIbe2ZaoI/x2i+0/bw0qlcde7MP9jNrJ6OTSf7ba3AcwwUosZIvpeG2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPw9GdtT; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPw9GdtT"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c3304833so745287a12.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219457; x=1790824257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/nN4Yn6oA7a1x94vAsNmOo9xURw7VO7RdS5v3ioLOGE=;
        b=UPw9GdtT4vwPGThOTU4zapA4niz815h5wnI+tWKtI6+Jy2zEwejpkl8sGImsyHPdUR
         NAKylwwYvwMI+/Zyk/e0DItDryc+SroHW33qbBmg3LksLwXktWgKPBemiGbsmtdJ6WOr
         6qnUDBgeS7pt2n0DpOliQVaRVxS8yCzjlnDR3oUW9VE7ymgdAufrUtimaiblVamldKOj
         VNbjjNqaB9oN6z4lrAF1emmMCyc7elotQkDkdw2ybToPiCMZK7DK5EI3OAgdP7mL8m6a
         Om/+E6K+/I50zQHpV72UXFRJwqPI2mpjHQx0+XeG/NJm9azfPrrbNC/ee/y1z1l2F5QJ
         Cd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219457; x=1790824257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/nN4Yn6oA7a1x94vAsNmOo9xURw7VO7RdS5v3ioLOGE=;
        b=n0Ol9UQhCJ+l3RzPgEKULw1KhZlFsr/zwOo7mgFD/sbc8r0YlvQnVeKC2Em54wG9Li
         6DEBYkt15+VXYoImoPWcJBI554agOSZG74NzRqpshNe5FNX6uYvNmBViIHFoT+22sVS0
         awQCN7bAlBi65pwOe1nj/I5FB9B29z1KQIxHM5bmgSGaDnSwsKEkGrTjz1CphcIZHl5P
         UTY4NFDw9Ue/y9OZwhE3P04d9n5iymANHl85tMRQKqcMprGf6/NYiOR1EXNg7V8AIcJx
         4XnYPLw8W5Zl8PM5aopXxYpIs983wKXX8m1ig+OilJX9bC0DDoj71ZsLn2n1ackIhlBy
         sMHA==
X-Gm-Message-State: AFuF++mUyf1eLu+b+6aq/MqGT+VnckZf5+XsARNYgeR2Yut2rHFkNWL1
	pA9IdRyu4HOOz5IHpx7m+NHAV7MeiohEZTErcLjGvbPliCFskYzEivGEEryX8g==
X-Gm-Gg: AYBFou2Q/R0rdCf8aYOHDRmcDFZNH2B2eToZNlNfqivfMA9rKCmV+QFWcMiIHF0mmjk
	bFNuz1N6NhzDX9m2F3ynNsx0llWvDSbhnR0F4Lf8yDxlAgbRgEKmmVTV1jvalUU7rZ1aHZTb8WC
	T0wedKPpAF2BQnFf0ncs0bZc2wjlVTQzTHgUM6TTATsGfr3uDGQWkEIcW0WAFtPdAy8vQ+YYB0K
	2pHeh4ZzhmPxFNKowuqkPJLtpt23KjM4fZY5UAH7GncgA6ILnfBGgCpEJ2UnBbwcvYb08QE7YG2
	I2DRsrTevBFHs8vwnrLJ1skCjEhWgZ6gljOoCy320zhMeBybq+UK4TlUIG7ORKbZwrFrmSUUNWq
	JPU7h0M9wQThpfE78NcKrtF8x9YpGRNRsjw6x06vNxn2+ZUL1l41IjdlFpVH/D47iSKOGhJMaAU
	ngUK4Iid2MUHJJ3HshyCgGguZkoPfILF+tuwJkK1jIlJrlkSo8zQv1LJWG0KvZOqI8I3vjnKwue
	uh7jwFtOOJEMyKqwMGQwj7MxZ6Cv07/A1Sr394UU5dPAx1cdjKxAfv6UwUpk8ssjiNNwwtzhqDP
	HKUInsqiwwULHtrsAaO7N6fJOj1lsEeFG4Gbzrk458TxTMzD4AEmpw==
X-Received: by 2002:a17:90b:55c3:b0:39e:3559:12df with SMTP id 98e67ed59e1d1-3a098b98d43mr931117a91.1.1790219456453;
        Wed, 23 Sep 2026 20:10:56 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972eec92sm2025033a91.7.2026.09.23.20.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:10:55 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 03/17] bpf: Keep functions with address taken when removing dead code
Date: Thu, 24 Sep 2026 03:10:28 +0000
Message-ID: <20260924031042.1690890-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

ld_imm64 BPF_PSEUDO_FUNC may take the address of a function that
nothing calls: the helper call that takes it as a callback is dead
code, or the prog only stores or compares the pointer. The function is
not seen by the main pass and bpf_opt_remove_dead_code() removes it,
while ld_imm64 stays and points to whatever follows. If the function
was the last one jit_subprogs() hits:

  verifier bug: No program to jit at insn 8 (subprog < 0)

Otherwise the register gets the address of the next function.

Keep the first insn of such function and make it a trap like
sanitize_dead_code() does, so the address stays valid and unique.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 2add8001c3ec..75936842d177 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -619,12 +619,41 @@ void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env)
 	}
 }
 
+/*
+ * The address of a function might be taken by the code that is not dead,
+ * while the function itself is dead code, since nothing calls it. Keep the first
+ * instruction of such function, so that the address remains valid and differs
+ * from the addresses of other functions. Make it a trap like
+ * sanitize_dead_code() does.
+ */
+static void keep_funcs_with_addr_taken(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
+	struct bpf_insn trap = BPF_JMP_IMM(BPF_JA, 0, 0, -1);
+	struct bpf_insn *insn = env->prog->insnsi;
+	int insn_cnt = env->prog->len;
+	int i, t;
+
+	for (i = 0; i < insn_cnt; i++) {
+		if (!aux_data[i].seen || !bpf_pseudo_func(insn + i))
+			continue;
+		t = i + insn[i].imm + 1;
+		if (aux_data[t].seen)
+			continue;
+		memcpy(insn + t, &trap, sizeof(trap));
+		aux_data[t].zext_dst = false;
+		aux_data[t].seen = env->pass_cnt;
+	}
+}
+
 int bpf_opt_remove_dead_code(struct bpf_verifier_env *env)
 {
 	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
 	int insn_cnt = env->prog->len;
 	int i, err;
 
+	keep_funcs_with_addr_taken(env);
+
 	for (i = 0; i < insn_cnt; i++) {
 		int j;
 
-- 
2.55.0

