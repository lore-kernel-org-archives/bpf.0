Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034346C4AA
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391833; cv=none; b=LE1ePsUV1yhihJu02c8aZ6OASI8nDzhJx/bC61hB/ZwSpKSdQQYEE6ZA//BHp7MwvpOS5WjtNlNJdOT8VPkHZ5Xtm8Y9CqyZ0FJK+T751/ovbqlUTj/tw3um8Hr3lLG+4PfvQpKvTJsfFOBX/+nKkXYplRVH9dUT8O6mNDTpDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391833; c=relaxed/simple;
	bh=Sxvzgo6sImEpFzwDHMSULgUff3qg8ybtr8tsYtYfBWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvetB1ow8tcDdjIkpdY4Ecm73sYy2D5yj2Bu71jeF1hgx7MIHeF6FyYu8VV1rnSyFZsSzamk5jK8VOVy1FsS/+vtJLzNQvXAn33Ot/KSCW376cDQRVknMl9kGebKSd/1Z0QnUVGFORDyKKptCxZMt1QhHmCLRftFnMHbfsbNxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iobOcXbV; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iobOcXbV"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e66652cc3so14313655e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391830; x=1789996630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nU/QxVgRQIkw4+EUnSt8Xo9sORfgu+Znf8+M+k+CDdU=;
        b=iobOcXbVH7baJ6fKWvnVqgVa2DdvFoQWUN+LscqTHUFtXb/rzGlBtfH9I6FnpBiF9j
         MCd9HYZrx06f6nuhU/Z8zbN5rusB1wbpOpxHeM63pCC72BeRsRU6fM+C0nJFu6KgoSk6
         0dFgAI0TVKTb4f0470Xzh6OiVHZX6IUiXZq+mu0mjIGRk4XMQm4buw6KxLV2xi7Pp8oW
         YHgZqUNOeRx5e4TlbmGurf/+oSVuIxoJoE3x4X3us7fLMURNuGVeSKNu8sDY1IsVzON3
         tLa6y9ditYS0q9TWtQor7wphTYeZ1FVlhpitrozEpveQMAMyZckP4Ph2RYIbRWMiVZbo
         nwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391830; x=1789996630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nU/QxVgRQIkw4+EUnSt8Xo9sORfgu+Znf8+M+k+CDdU=;
        b=DCU768JOivoh62tsEg2s/vjC3lV9jEo6FIntc+bWVsiuoZVFhdoQ3ZyF1kz+09UNfJ
         1dO4HnD2QT/i0c8kLTiWlFhbshCsrgBIQngjNwsDLMSF51yPaH8QBuugUJb6Bkj4MAx3
         nm81p5/f9LYDD94za64l4dxjVSwBbUWKhBQEoQZrtob0oLrsOEDhNqi+ttDSQhWjfYgT
         ZFs3wNaHXb+q/JbGXB0oVFnb8tYVr7J2JK+BOAjU8Nr3uZ1L3vUcT/90kp3sKOlFgd8R
         7oWov8XwB8nx09ipJ1SDPnCBde5j4iG771/Mb0NVHzA2N/6qHqxOfnJXdL76M6ZS6Vwc
         4Lug==
X-Gm-Message-State: AFuF++nm1wYVYwImebSPZ+6pUGS5fFk0ar8VfdUMzkvjxotGWWE1LwuG
	ANt38DZwnk+INKChllC7lG6lxlJy2WqFdVB25dymg0fizuQ44FM+dXjXFHTR1CXh
X-Gm-Gg: AYBFou0LFjTBdpMfYM7KcbWWKihyN3i3QqQyPpX7SqSWkOOwMvgUeFPii9tBjtxMOh2
	NjSwfJk/GmBMGcsR+iUqZpw4dUf8oj8TmBwhyc6lvaviwsAz2dH3bW0NeOUzzCUcr7VT+mwXmk0
	8yze4BwSlz1jk2Ksj7Qg5HVLvookIJ5TE67JyAejty8iTE+p2b+EB/7vBYwqq4XeF2JUjCZkLIP
	PJhwfb9l02J9Q/mMe34OMBIEMAirYcg8LMCg95cOJwy8BwudcAglPD2++mFBEaQ347hB93a59G6
	+lXk2rWwjBWHkNc1NxYNgDBtQH/wE8rbjHqn9biChWHo5bate+MqloM/wSLz+QJ5RZunfUr+PnT
	Tld1kEC4tcgdXeir0ywaBYqAN3AT3nNOe3YT3R0DV73kHf6753eVYryD9kl5hBqxMrqB/BN0gEP
	GztVVkCHBC0E8cF/x98ac4nNkuElw+1Xy8EbsL7VAQgeH7mx/BMoYWe8uJlrr5QGGNp4RQChdgT
	lDBoZGfANyQo+Aoy95f6eHgTSgkOFcZ2qpQmuSsxtg/dLj5AhxR+YO0UkFqYn311AVqr3v7CaWi
	2Sm2khT5ED2BGpa1frtsIUktmqJEU+v/lDJ6eU1JR2vRAMfgbA==
X-Received: by 2002:a05:600c:a47:b0:49c:fc6e:8cb4 with SMTP id 5b1f17b1804b1-49e7a67741cmr30998485e9.24.1789391829892;
        Mon, 14 Sep 2026 06:17:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e6f1sm26240961f8f.6.2026.09.14.06.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:17:09 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 4/7] bpf: Restrict CO-RE poisoning to relocatable instructions
Date: Mon, 14 Sep 2026 15:16:54 +0200
Message-ID: <20260914131701.2529725-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914131701.2529725-1-memxor@gmail.com>
References: <20260914131701.2529725-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3693; i=memxor@gmail.com; h=from:subject; bh=Sxvzgo6sImEpFzwDHMSULgUff3qg8ybtr8tsYtYfBWs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv555lWq+rup2/e/MKy85hLmaxgYcfWjM2pM9cUFT3+f H2FW0JVRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACayKIDhf6zl70MZqdGTGPYt uR7Ea/fFw1eiuEQx8kNT952qWDO2CkaG77L9TXGWUZyXyxbGzSgT/3Jco4r/yEtTp0+avJLW1XG 8AA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

check_subprogs() verifies that each subprogram ends in an exit or an
unconditional jump before in-kernel CO-RE relocations are applied.
An unresolved relocation can then replace that terminal instruction with
an invalid helper call. The resulting fall-through into another subprogram
breaks the CFG invariant used by postorder and stack liveness analysis,
which can write past their per-subprogram arrays.

Handle instruction poisoning after the instruction has passed the same
class and operand-form checks used for a resolved relocation. This rejects
relocations targeting jumps, calls, exits, register-source arithmetic, or
non-immediate loads before they can alter the control flow. Keep poisoning
supported instructions, including both halves of a plain ldimm64, so an
unresolved relocation in dead code remains valid.

The shared relocation code applies this restriction to both libbpf and
in-kernel CO-RE.

Fixes: efcda22aa541 ("bpf: compute instructions postorder per subprogram")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/relo_core.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 8ad2715721cf..a884bc2bff19 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1047,17 +1047,6 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 
 	class = BPF_CLASS(insn->code);
 
-	if (res->poison) {
-poison:
-		/* poison second part of ldimm64 to avoid confusing error from
-		 * verifier about "unknown opcode 00"
-		 */
-		if (is_ldimm64_insn(insn))
-			bpf_core_poison_insn(prog_name, relo_idx, insn_idx + 1, insn + 1);
-		bpf_core_poison_insn(prog_name, relo_idx, insn_idx, insn);
-		return 0;
-	}
-
 	orig_val = res->orig_val;
 	new_val = res->new_val;
 
@@ -1066,6 +1055,8 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 	case BPF_ALU64:
 		if (BPF_SRC(insn->code) != BPF_K)
 			return -EINVAL;
+		if (res->poison)
+			goto poison;
 		if (res->validate && insn->imm != orig_val) {
 			pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: got %d, exp %llu -> %llu\n",
 				prog_name, relo_idx,
@@ -1082,6 +1073,8 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 	case BPF_LDX:
 	case BPF_ST:
 	case BPF_STX:
+		if (res->poison)
+			goto poison;
 		if (res->validate && insn->off != orig_val) {
 			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDX/ST/STX) value: got %d, exp %llu -> %llu\n",
 				prog_name, relo_idx, insn_idx, insn->off, (unsigned long long)orig_val,
@@ -1140,6 +1133,9 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 
+		if (res->poison)
+			goto poison;
+
 		imm = (__u32)insn[0].imm | ((__u64)insn[1].imm << 32);
 		if (res->validate && imm != orig_val) {
 			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: got %llu, exp %llu -> %llu\n",
@@ -1164,6 +1160,16 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
 	}
 
 	return 0;
+
+poison:
+	/*
+	 * Only relocatable instructions reach here. Poison both halves of
+	 * ldimm64 so the verifier reports the bad relocation, not opcode 00.
+	 */
+	if (is_ldimm64_insn(insn))
+		bpf_core_poison_insn(prog_name, relo_idx, insn_idx + 1, insn + 1);
+	bpf_core_poison_insn(prog_name, relo_idx, insn_idx, insn);
+	return 0;
 }
 
 /* Output spec definition in the format:
-- 
2.53.0

